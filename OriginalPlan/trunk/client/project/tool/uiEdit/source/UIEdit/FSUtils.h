#ifndef __UE_FSUTILS_H__
#define __UE_FSUTILS_H__
#include <string>
#include <vector>
#include <cctype>
#include "windows.h"
using namespace std;
struct FSUtils
{
	template<typename T, int count>
	static inline int CountArray(T(&)[count]){ return count; };
	template<int count>
	static inline int CountStringLength(const char (&)[count]){ return count - 1; };
	template<int count>
	static inline int CountStringLength(const wchar_t(&)[count]){ return count - 1; };

	static bool ExtractExt(const string& path, string& ext)
	{
		string name;
		return ExtractPath(path, name, ext);
	}
	static bool ExtractName(const string& path, string& name)
	{
		string ext;
		return ExtractPath(path, name, ext);
	}
    static bool ExtractFilename(const string& path, string& filename)
    {
        string name, ext;
        if (!ExtractPath(path, name, ext))
        {
             return false;
        }
        filename = name + "." + ext;
        return true;
    }
	static bool ExtractPath(const string& path, string& name, string& ext)
	{
		string clearpath;
		if (!GetClearPath(path, clearpath))
			return false;

		if (!IsValidPath(clearpath))
			return false;
		
		string::size_type pos = clearpath.find_last_of("/\\");
		if (pos == string::npos)
		{
			pos = 0;
		}
		else
		{
			pos = pos + 1;
		}
		string exactname = clearpath.substr(pos);
		pos = exactname.rfind('.');
		if (pos == string::npos)
		{
			name = exactname;
			ext = "";
		}
		else
		{
			name = exactname.substr(0, pos);
			ext = exactname.substr(pos + 1);
		}
		return true;
	}

	static bool FileExists(const string& path)
	{
		DWORD attrs = GetFileAttributesA(path.c_str());
		return attrs != INVALID_FILE_ATTRIBUTES && (FILE_ATTRIBUTE_DIRECTORY != (FILE_ATTRIBUTE_DIRECTORY&attrs));
	}
	static bool DirectoryExists(const string& path)
	{
		DWORD attrs = GetFileAttributesA(path.c_str());
		return attrs != INVALID_FILE_ATTRIBUTES && (FILE_ATTRIBUTE_DIRECTORY == (FILE_ATTRIBUTE_DIRECTORY&attrs));
	}
	static bool FileExists(const wstring& path)
	{
		DWORD attrs = GetFileAttributesW(path.c_str());
		return attrs != INVALID_FILE_ATTRIBUTES && (FILE_ATTRIBUTE_DIRECTORY != (FILE_ATTRIBUTE_DIRECTORY&attrs));
	}
	static bool DirectoryExists(const wstring& path)
	{
		DWORD attrs = GetFileAttributesW(path.c_str());
		return attrs != INVALID_FILE_ATTRIBUTES && (FILE_ATTRIBUTE_DIRECTORY == (FILE_ATTRIBUTE_DIRECTORY&attrs));
	}

	static bool IsValidPath(const string& path)
	{
		// : * ? " <>|
		if (path.size() > 256)
			return false;

		string::size_type pos = 0;
		string::size_type pathSize = path.size();
		if (isalpha(path[0]) && pathSize >= 2 && path[1] == ':')
		{
			pos = 2;
		}
		for(; pos != pathSize; ++pos)
		{
			switch (path[pos])
			{
			case ':':	case '*':	case '?':	case '\"':
			case '<':	case '>':	case '|':
				return false;
			default:
				break;
			}
		}
		return true;
	}

	static bool IsValidPath(const wstring& path)
	{
		string::size_type pos = 0;
		string::size_type pathSize = path.size();

		if (pathSize > 4)
		{
			if (memcmp(&path[0], L"\\\\?\\", CountStringLength(L"\\\\?\\")) == 0)
			{
				pos += 4;
			}
			else
			{
				if (path.size() > 256)
					return false;
			}
		}

		if (isalpha(path[pos]) && pathSize - pos >= 2 && path[pos+1] == ':')
		{
			pos += 2;
		}
		for (; pos != pathSize; ++pos)
		{
			switch (path[pos])
			{
			case ':':	case '*':	case '?':	case '\"':
			case '<':	case '>':	case '|':
				return false;
			default:
				break;
			}
		}
		return true;
	}
	static bool IsValidFilename(const string& filename)
	{
		// : * ? " <>|
		if (filename.size() > 256)
			return false;

		for (string::size_type i = 0; i != filename.size(); ++i)
		{
			switch (filename[i])
			{
			case ':':	case '*':	case '?':	case '\"':
			case '<':	case '>':	case '|':	
			case '/':	case '\\':
				return false;
			default:
				break;
			}
		}
		return true;
	}
	static bool IsValidFilename(const wstring& filename)
	{
		if (filename.size() > 256)
			return false;

		for (string::size_type i = 0; i != filename.size(); ++i)
		{
			switch (filename[i])
			{
			case ':':	case '*':	case '?':	case '\"':
			case '<':	case '>':	case '|':
			case '/':	case '\\':
				return false;
			default:
				break;
			}
		}
		return true;
	}
	static bool GetClearPath(const string& path, string& clearPath)
	{
		vector<string::size_type> slashPoses;

		string::size_type pos = 0;
		string::size_type pathSize = path.size();
		bool hasRoot = false;
		if (isalpha(path[0]) && pathSize >= 2 && path[1] == ':')
		{			
			pos = 2;
			hasRoot = true;
			clearPath.push_back(path[0]);
			clearPath.push_back(':');
			if (path.size() > 2 && path[2] == '/' || path[2] == '\\')
			{
				pos = 3;
				clearPath.push_back('\\');
			}
			slashPoses.push_back(clearPath.size());
		}

		for (string::size_type oldpos = pos; pos != string::npos; pos = pos + 1, oldpos = pos)
		{
			pos = path.find_first_of("/\\", oldpos);
			if (pos == oldpos)
			{
				continue;	// ignore
			}
			else if (pos == oldpos + 1)
			{
				if (path[oldpos] == '.')
				{					
					continue;
				}
			}
			else if (pos == oldpos + 2)
			{
				if (path[oldpos] == '.' && path[oldpos + 1] == '.')
				{
					if (hasRoot && slashPoses.size() == 1)
					{
						return false;
					}
					if (slashPoses.size() > 1)
					{
						clearPath.resize(slashPoses[slashPoses.size() - 1]);
						slashPoses.pop_back();
						continue;
					}
					else
					{
						clearPath += "..\\";
						continue;
					}
				}				
			}
			
			clearPath += path.substr(oldpos, pos - oldpos);		
			if (pos != string::npos)
			{
				clearPath += '\\';
			}
			else
			{
				break;
			}
			slashPoses.push_back(clearPath.size());
		}
		if (*clearPath.rbegin() == '\\')
		{
			clearPath.erase(clearPath.size() - 1);
		}
		return true;
	}
	static bool GetFullPath(const string& path, string& fullPath)
	{
		fullPath.resize(256);
		DWORD ret = GetFullPathNameA(path.c_str(), fullPath.size(), &fullPath[0], 0);
		fullPath.resize(ret);
		return ret != 0 && ret != 256;
	}
	static bool GetFullPath(const wstring& path, wstring& fullPath)
	{
		fullPath.resize(256);
		DWORD ret = GetFullPathNameW(path.c_str(), fullPath.size(), &fullPath[0], 0);
		fullPath.resize(ret);
		return ret != 0 && ret != 256;
	}
    static inline std::string w2m(const std::wstring& wcs, DWORD codePage)
    {
        int len = WideCharToMultiByte(codePage, 0, wcs.c_str(), wcs.length(), 0, 0, 0, FALSE);
        std::string u(len, 0);
        len = WideCharToMultiByte(codePage, 0, wcs.c_str(), wcs.length(), &u[0], u.length(), 0, FALSE);
        return u;
    }
    static inline std::wstring m2w(const std::string& ansi, DWORD codePage)
    {
        int len = MultiByteToWideChar(codePage, 0, ansi.c_str(), ansi.length(), 0, 0);
        std::wstring u(len, 0);
        len = MultiByteToWideChar(codePage, 0, ansi.c_str(), ansi.length(), &u[0], u.length());
        return u;
    }

    static inline std::string ucstoutf8(const std::wstring& wcs)
    {
        return w2m(wcs, CP_UTF8);
    }

    static inline std::string ucstoansi(const std::wstring& wcs)
    {
        return w2m(wcs, CP_ACP);
    }

    static inline std::wstring ansitoucs(const std::string& ansi)
    {
        return m2w(ansi, CP_ACP);
    }
    static inline std::wstring utf8toucs(const std::string& ansi)
    {
        return m2w(ansi, CP_UTF8);
    }

    static inline std::string ansitoutf8(const std::string& ansi)
    {
        return ucstoutf8(ansitoucs(ansi));
    }

    static inline std::string utf8toansi(const std::string& ansi)
    {
        return ucstoansi(utf8toucs(ansi));
    }
};



#endif