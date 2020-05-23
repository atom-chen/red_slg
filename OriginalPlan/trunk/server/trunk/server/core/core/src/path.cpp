#include "stdcore.h"
#include "path.h"

#ifdef OS_WINDOWS
#	define NOMINMAX
#	include <sys/types.h>
#	include <sys/stat.h>
#	include <direct.h>
#	include <io.h>
#	include <fcntl.h>
#	include <sys/types.h>
#	include <sys/stat.h>
#	include <shlobj.h>
#else
#   include <sys/types.h>
#   include <sys/stat.h>
#	include <dirent.h>
#   include <unistd.h>
#	include <cstdio>
#   include <cerrno>
#   include <sys/types.h>
#   include <utime.h>
#endif // OS_WINDOWS

#include "string_common.h"
#include "debug.h"
#include "ucstring.h"
#include "types_def.h"
#include "base_util.h"

using namespace std;

namespace GXMISC
{
	sint32 CFile::GetLastSeparator (const string &filename)
	{
		string::size_type pos = filename.find_last_of ('/');
		if (pos == string::npos)
		{
			pos = filename.find_last_of ('\\');
			if (pos == string::npos)
			{
				pos = filename.find_last_of ('@');
			}
		}
		return (sint32)pos;
	}

	string CFile::GetFilename (const string &filename)
	{
		string::size_type pos = CFile::GetLastSeparator(filename);
		if (pos != string::npos)
			return filename.substr (pos + 1);
		else
			return filename;
	}

	string CFile::GetFilenameWithoutExtension (const string &filename)
	{
		string filename2 = GetFilename (filename);
		string::size_type pos = filename2.find_last_of ('.');
		if (pos == string::npos)
			return filename2;
		else
			return filename2.substr (0, pos);
	}

	string CFile::GetExtension (const string &filename)
	{
		string::size_type pos = filename.find_last_of ('.');
		if (pos == string::npos)
			return "";
		else
			return filename.substr (pos + 1);
	}

	string CFile::GetPath (const string &filename)
	{
		string::size_type pos = CFile::GetLastSeparator(filename);
		if (pos != string::npos)
			return filename.substr (0, pos + 1);
		else
			return "";
	}

	bool CFile::isDirectory (const string &filename)
	{
#ifdef OS_WINDOWS
		DWORD res = GetFileAttributesA(filename.c_str()); // @TODO UNICODE
		if (res == INVALID_FILE_ATTRIBUTES)
		{
			// gxwarning ("PATH: {0} is not a valid file or directory name", filename.c_str ());
			return false;
		}
		return (res & FILE_ATTRIBUTE_DIRECTORY) != 0;
#else // OS_WINDOWS
		struct stat buf;
		int res = stat (filename.c_str (), &buf);
		if (res == -1)
		{
			// There was previously a warning message here but that was incorrect as it is defined that isDirectory returns false if the directory doesn't exist
			// gxwarning ("PATH: can't stat {0} 0error {1} {2}", filename.c_str(), errno, strerror(errno));
			return false;
		}
		return (buf.st_mode & S_IFDIR) != 0;
#endif // OS_WINDOWS
	}

	bool CFile::IsExists (const string &filename)
	{
#ifdef OS_WINDOWS
		return (GetFileAttributesA(filename.c_str()) != INVALID_FILE_ATTRIBUTES); // @TODO UNICODE
#else // OS_WINDOWS
		struct stat buf;
		return stat (filename.c_str (), &buf) == 0;
#endif // OS_WINDOWS
	}

	bool CFile::CreateEmptyFile (const std::string& filename)
	{
		FILE *file = fopen (filename.c_str(), "wb");

		if (file)
		{
			fclose (file);
			return true;
		}

		return false;
	}

	bool CFile::FileExists (const string& filename)
	{
		return ! ! fstream( filename.c_str(), ios::in );
	}


	string CFile::FindNewFile (const string &filename)
	{
		string::size_type pos = filename.find_last_of ('.');
		if (pos == string::npos)
			return filename;

		string start = filename.substr (0, pos);
		string end = filename.substr (pos);

		uint32 num = 0;
		char numchar[4];
		string npath;
		do
		{
			npath = start;
			gxSprintf(numchar,4,"%03d",num++);
			npath += numchar;
			npath += end;
			if (!CFile::FileExists(npath)) break;
		}
		while (num<999);
		return npath;
	}

	// \warning doesn't work with big file
	uint32	CFile::GetFileSize (const std::string &filename)
	{
#if defined (OS_WINDOWS)
		struct _stat buf;
		int result = _stat (filename.c_str (), &buf);
#elif defined (OS_UNIX)
		struct stat buf;
		int result = stat (filename.c_str (), &buf);
#endif
		if (result != 0) return 0;
		else return buf.st_size;
	}

	uint32	CFile::GetFileSize (FILE *f)
	{
#if defined (OS_WINDOWS)
		struct _stat buf;
		int result = _fstat (fileno(f), &buf);
#elif defined (OS_UNIX)
		struct stat buf;
		int result = fstat (fileno(f), &buf);
#endif
		if (result != 0) return 0;
		else return buf.st_size;
	}

	uint32	CFile::GetFileModificationDate(const std::string &filename)
	{
		string fn = filename;

#if defined (OS_WINDOWS)
		//	struct _stat buf;
		//	int result = _stat (fn.c_str (), &buf);
		// Changed 06-06-2007 : boris : _stat have an incoherent and hard to reproduce
		// on windows : if the system clock is adjusted according to daylight saving
		// time, the file date reported by _stat may (not always!) be adjusted by 3600s
		// This is a bad behavior because file time should always be reported as UTC time value

		// Use the WIN32 API to read the file times in UTC

		// create a file handle (this does not open the file)
		HANDLE h = CreateFileA(fn.c_str(), 0, 0, NULL, OPEN_EXISTING, 0, 0); // @TODO UNICODE
		if (h == INVALID_HANDLE_VALUE)
		{
			gxWarning("Can't get modification date on file {0} : {1}", fn.c_str(), GXMISC::gxFormatErrorMessage(GXMISC::gxGetLastError()).c_str());
			return 0;
		}
		FILETIME creationTime;
		FILETIME accesstime;
		FILETIME modTime;

		// get the files times
		BOOL res = GetFileTime(h, &creationTime, &accesstime, &modTime);
		if (res == 0)
		{
			gxWarning("Can't get modification date on file {0} : {1}", fn.c_str(), GXMISC::gxFormatErrorMessage(GXMISC::gxGetLastError()).c_str());
			CloseHandle(h);
			return 0;
		}
		// close the handle
		CloseHandle(h);

		// win32 file times are in 10th of micro sec (100ns resolution), starting at jan 1, 1601
		// hey Mr Gates, why 1601 ?

		// first, convert it into second since jan1, 1601
		uint64 t = modTime.dwLowDateTime | (uint64(modTime.dwHighDateTime)<<32);

		// adjust time base to unix epoch base
		t -= CTime::GetWindowsToUnixBaseTimeOffset();

		// convert the resulting time into seconds
		t /= 10;	// microsec
		t /= 1000;	// millisec
		t /= 1000;	// sec

		// return the resulting time
		return uint32(t);

#elif defined (OS_UNIX)
		struct stat buf;
		int result = stat (fn.c_str (), &buf);
		if (result != 0)
		{
			gxWarning("Can't get modification date on file {0} : {1}", fn.c_str(), GXMISC::gxFormatErrorMessage(GXMISC::gxGetLastError()).c_str());
			return 0;
		}
		else
			return (uint32)buf.st_mtime;
#endif

	}

	bool	CFile::SetFileModificationDate(const std::string &filename, uint32 modTime)
	{
		string fn = filename;

#if defined (OS_WINDOWS)

		// Use the WIN32 API to set the file times in UTC

		// create a file handle (this does not open the file)
		HANDLE h = CreateFileA(fn.c_str(), GENERIC_WRITE|GENERIC_READ, FILE_SHARE_WRITE|FILE_SHARE_READ, NULL, OPEN_EXISTING, 0, 0); // @TODO UNICODE
		if (h == INVALID_HANDLE_VALUE)
		{
			gxWarning("Can't set modification date on file {0} (error accessing file) : {1}", fn.c_str(), GXMISC::gxFormatErrorMessage(GXMISC::gxGetLastError()).c_str());
			return false;
		}
		FILETIME creationFileTime;
		FILETIME accessFileTime;
		FILETIME modFileTime;

		// read the current the files times
		if (GetFileTime(h, &creationFileTime, &accessFileTime, &modFileTime) == 0)
		{
			gxWarning("Can't set modification date on file {0} : {1}", fn.c_str(), GXMISC::gxFormatErrorMessage(gxGetLastError()).c_str());
			CloseHandle(h);
			return false;
		}

		// win32 file times are in 10th of micro sec (100ns resolution), starting at jan 1, 1601
		// hey Mr Gates, why 1601 ?

		// convert the unix time into a windows file time
		uint64 t = modTime;
		// convert to 10th of microsec
		t *= 1000;	// millisec
		t *= 1000;	// microsec
		t *= 10;	// 10th of micro sec (rez of windows file time is 100ns <=> 1/10 us

		// apply the windows to unix base time offset
		t += CTime::GetWindowsToUnixBaseTimeOffset();

		// update the windows modTime structure
		modFileTime.dwLowDateTime = uint32(t & 0xffffffff);
		modFileTime.dwHighDateTime = uint32(t >> 32);

		// update the file time on disk
		BOOL rez = SetFileTime(h, &creationFileTime, &accessFileTime, &modFileTime);
		if (rez == 0)
		{
			gxWarning("Can't set modification date on file {0}: {1}", fn.c_str(), GXMISC::gxFormatErrorMessage(gxGetLastError()).c_str());

			CloseHandle(h);
			return false;
		}

		// close the handle
		CloseHandle(h);

		return true;

#elif defined (OS_UNIX)
		// first, read the current time of the file
		struct stat buf;
		int result = stat (fn.c_str (), &buf);
		if (result != 0)
			return false;

		// prepare the new time to apply
		utimbuf tb;
		tb.actime = buf.st_atime;
		tb.modtime = modTime;
		// set eh new time
		int res = utime(fn.c_str(), &tb);
		if (res == -1)
			gxWarning("Can't set modification date on file {0}: {1}", fn.c_str(), gxFormatErrorMessage(gxGetLastError()).c_str());
		return res != -1;
#endif

	}

	uint32	CFile::GetFileCreationDate(const std::string &filename)
	{
		string fn = filename;

#if defined (OS_WINDOWS)
		struct _stat buf;
		int result = _stat (fn.c_str (), &buf);
#elif defined (OS_UNIX)
		struct stat buf;
		int result = stat (fn.c_str (), &buf);
#endif

		if (result != 0) return 0;
		else return (uint32)buf.st_ctime;
	}

	static bool CopyMoveFile(const std::string &dest, const std::string &src, bool copyFile, bool failIfExists = false)
	{
		if (dest.empty() || src.empty()) return false;
		std::string sdest = CPath::StandardizePath(dest,false);
		std::string ssrc = CPath::StandardizePath(src,false);

		if(copyFile)
		{
			FILE *fp1 = fopen(ssrc.c_str(), "rb");
			if (fp1 == NULL)
			{
				gxWarning ("PATH: CopyMoveFile error: can't fopen in read mode {0}", ssrc);
				return false;
			}
			FILE *fp2 = fopen(sdest.c_str(), "wb");
			if (fp2 == NULL)
			{
				gxWarning ("PATH: CopyMoveFile error: can't fopen in read write mode {0}", sdest);
				return false;
			}
			static char buffer [1000];
			size_t s;

			s = fread(buffer, 1, sizeof(buffer), fp1);
			while (s != 0)
			{
				size_t ws = fwrite(buffer, s, 1, fp2);
				if (ws != 1)
				{
					gxWarning("Error copying {0} to {1}, trying to write {2} bytes failed.", ssrc, sdest, s);
					fclose(fp1);
					fclose(fp2);
					gxWarning("Errno = {0}", errno);
					return false;
				}
				s = fread(buffer, 1, sizeof(buffer), fp1);
			}

			fclose(fp1);
			fclose(fp2);
		}
		else
		{
#ifdef OS_WINDOWS
			if (MoveFileA(ssrc.c_str(), sdest.c_str()) == 0) // @TODO UNICODE
			{
				LPVOID lpMsgBuf;
				FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER |
					FORMAT_MESSAGE_FROM_SYSTEM |
					FORMAT_MESSAGE_IGNORE_INSERTS,
					NULL,
					GetLastError(),
					MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), // Default language
					(LPTSTR) &lpMsgBuf,
					0,
					NULL );
				uint32 errNum = GetLastError();
				gxWarning ("PATH: CopyMoveFile error: can't link/move {0} into {1}, error {2} {3}", ssrc.c_str(), sdest.c_str(), errNum, (int)(lpMsgBuf));

				LocalFree(lpMsgBuf);
				return false;
			}
#else
			if (rename (ssrc.c_str(), sdest.c_str()) == -1)
			{
				gxWarning ("PATH: CopyMoveFile error: can't rename {0} into {1}, error {2}", ssrc.c_str(), sdest.c_str(), errno);
				return false;
			}
#endif
		}
		return true;
	}

	bool CFile::Copyfile(const std::string &dest, const std::string &src, bool failIfExists /*=false*/)
	{
		return CopyMoveFile(dest, src, true, failIfExists);
	}

	bool CFile::QuickFileCompare(const std::string &fileName0, const std::string &fileName1)
	{
		// make sure the files both exist
		if (!FileExists(fileName0.c_str()) || !FileExists(fileName1.c_str()))
			return false;

		// compare time stamps
		if (GetFileModificationDate(fileName0.c_str()) != GetFileModificationDate(fileName1.c_str()))
			return false;

		// compare file sizes
		if (GetFileSize(fileName0.c_str()) != GetFileSize(fileName1.c_str()))
			return false;

		// everything matched so return true
		return true;
	}

	bool CFile::Movefile(const char *dest,const char *src)
	{
		return CopyMoveFile(dest, src, false);
	}

	bool CFile::CreateDir(const std::string &filename)
	{
#ifdef OS_WINDOWS
		return _mkdir(filename.c_str())==0;
#else
		// Set full permissions....
		return mkdir(filename.c_str(), 0xFFFF)==0;
#endif
	}

	bool CFile::CreateDirectoryTree(const std::string &filename)
	{
		bool lastResult=true;
		uint32 i=0;

		// skip dos drive name eg "a:"
		if (filename.size()>1 && filename[1]==':')
			i=2;

		// iterate over the set of directories in the routine's argument
		while (i<filename.size())
		{
			// skip passed leading slashes
			for (;i<filename.size();++i)
				if (filename[i]!='\\' && filename[i]!='/')
					break;

			// if the file name ended with a '/' then there's no extra directory to create
			if (i==filename.size())
				break;

			// skip forwards to next slash
			for (;i<filename.size();++i)
				if (filename[i]=='\\' || filename[i]=='/')
					break;

			// try to create directory
			std::string s= filename.substr(0,i);
			lastResult= CreateDir(s);
		}

		return lastResult;
	}

	bool CFile::SetRWAccess(const std::string &filename)
	{
#ifdef OS_WINDOWS
		// if the file exists and there's no write access
		if (_access (filename.c_str(), 00) == 0 && _access (filename.c_str(), 06) == -1)
		{
			// try to set the read/write access
			if (_chmod (filename.c_str(), _S_IREAD | _S_IWRITE) == -1)
			{
				return false;
			}
		}
#else
		// if the file exists and there's no write access
		if (access (filename.c_str(), F_OK) == 0)
		{
			// try to set the read/write access
			if (chmod (filename.c_str(), S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP|S_IWGRP|S_IXGRP|S_IROTH|S_IWOTH|S_IXOTH) == -1)
			{
				return false;
			}
		}
		else
		{
			return false;
		}
#endif
		return true;
	}


#ifdef OS_WINDOWS
#define unlink _unlink
#endif

	bool CFile::Deletefile(const std::string &filename)
	{
		SetRWAccess(filename);
		int res = unlink (filename.c_str());
		if (res == -1)
		{
			return false;
		}
		return true;
	}

#ifdef OS_WINDOWS
#define rmdir _rmdir
#endif

	bool CFile::GeleteDirectory(const std::string &filename)
	{
		SetRWAccess(filename);
		int res = rmdir (filename.c_str());
		if (res == -1)
		{
			gxWarning ("PATH: Can't delete directory {0}: (errno {1}) {2}", filename.c_str(), errno, strerror(errno));
			return false;
		}
		return true;
	}

	void CFile::GetTemporaryOutputFilename (const std::string &originalFilename, std::string &tempFilename)
	{
		uint32 i = 0;
		do
        {
		    tempFilename = originalFilename+".tmp"+gxToString (i++);
        }
		while (CFile::IsExists(tempFilename));
	}

	std::string CFile::GetApplicationDirectory(const std::string &appName)
	{
		static std::string appPath;
		if (appPath.empty())
		{
#ifdef OS_WINDOWS
			wchar_t buffer[MAX_PATH];
			SHGetSpecialFolderPathW(NULL, buffer, CSIDL_APPDATA, true);
			appPath = CPath::StandardizePath(CUString((ucchar*)buffer).toUtf8());
#else
			appPath = CPath::StandardizePath(getenv("HOME"));
#endif
		}

		std::string path = appPath;
#ifdef OS_WINDOWS
		if (!appName.empty())
			path = CPath::StandardizePath(path + appName);
#else
		if (!appName.empty())
			path = CPath::StandardizePath(path + "." + gxToLower(appName));
#endif

		return path;
	}

	std::string CPath::StandardizePath( const std::string &path, bool addFinalSlash /*= true*/ )
	{
		// check empty path
		if (path.empty())
			return "";

		string newPath(path);

		for (uint32 i = 0; i < path.size(); i++)
		{
			// don't transform the first \\ for windows network path
			if (path[i] == '\\')
				newPath[i] = '/';
		}

		// add terminal slash
		if (addFinalSlash && newPath[path.size()-1] != '/')
			newPath += '/';

		return newPath;
	}

	std::string CPath::StandardizeDosPath( const std::string &path )
	{
		string newPath;

		for (uint32 i = 0; i < path.size(); i++)
		{
			if (path[i] == '/')
				newPath += '\\';
			// Yoyo: supress toLower. Not useful!?!
			/*else if (isupper(path[i]))
			newPath += tolower(path[i]);*/
			else
				newPath += path[i];
		}

		if (CFile::IsExists(path) && CFile::isDirectory(path) && newPath[newPath.size()-1] != '\\')
			newPath += '\\';

		return newPath;
	}

#ifdef OS_WINDOWS
	void CPath::TraversePathGetFile(const std::string &path, TFileNameVec& files, const std::string ext)
	{
		char szFind[MAX_PATH];
		WIN32_FIND_DATAA FindFileData; // @TODO UNICODE
		strcpy(szFind, path.c_str());
		strcat(szFind, ext.c_str());
		HANDLE hFind=::FindFirstFileA(szFind, &FindFileData); // @TODO UNICODE
		if(INVALID_HANDLE_VALUE == hFind) return;
		while(true){
			if(FindFileData.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY){
				if(FindFileData.cFileName[0] != '.'){
					strcpy(szFind, path.c_str());
					strcat(szFind, "\\");
					strcat(szFind, FindFileData.cFileName);
					TraversePathGetFile(szFind, files);
				}
			}
			else{
				files.push_back( FindFileData.cFileName );
			}
			if(!FindNextFileA(hFind,&FindFileData)){ // @TODO UNICODE
				break;
			}
		}
		FindClose(hFind);
	}
#else
	void CPath::TraversePathGetFile(const std::string &path, TFileNameVec& files, const std::string ext)
	{
		gxAssert(false);
	}
#endif
}
