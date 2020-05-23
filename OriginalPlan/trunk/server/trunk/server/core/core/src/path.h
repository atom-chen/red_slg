#ifndef _PATH_H_
#define _PATH_H_

#include <string>

#include "time_gx.h"
#include "types_def.h"

namespace GXMISC
{
	// @ 测试所有接口是否可用
    class CPath
    {
	public:
		typedef std::vector<const std::string> TFileNameVec;
    public:
        /**	Take a path and put it in the portable format and add a terminated / if needed
        * ie: "C:\\Game/dir1" will become "C:/Game/dir1/" or "C:/Game/dir1" if addFinalSlash is false
        */
        static std::string	StandardizePath (const std::string &path, bool addFinalSlash = true);

        /**	Replace / with \ for dos process. Use only this function if can't do another way.
        * For example, if you do a system("copy data/toto data/tata"); it'll not work because dos doesn't
        * understand /.
        * But in the majority of case, / working (it works for fopen for example)
        */
        static std::string	StandardizeDosPath (const std::string &path);

		/**
		 * 遍历目录, 得到当前目录下所有指定类型的文件
		 */
		static void TraversePathGetFile(const std::string &path, TFileNameVec& files, const std::string ext = "*");
    };

    /**
    * Utility class for file manipulation
    */
    class CFile
    {
    public:
        /**
        * Retrieve the associated file name.
        * An empty string is returned if the path is invalid
        */
        static std::string GetFilename (const std::string &filename);

        /**
        * Retrieve the associated file path with the trailing slash.
        * Returns an empty string if the path is invalid
        */
        static std::string GetPath (const std::string &filename);

        /**
        * Just to know if it is a directory.
        * _FileName empty and path not !!!
        */
        static bool isDirectory (const std::string &filename);

        /**
        * Return true if the file exists.
        * Warning: this test will also tell that the file does not
        * exist if you don't have the rights to read it (Unix).
        */
        static bool FileExists (const std::string &filename);

        /**
        * Return true if the file OR directory exists.
        * Warning: this test will also tell that the file does not
        * exist if you don't have the rights to read it (Unix).
        */
        static bool IsExists (const std::string& filename);

        /**
        * Create an empty file.
        * Return true if the file has been correctly created.
        */
        static bool CreateEmptyFile (const std::string& filename);

        /**
        * Return a new filename that doesn't exists. It's used for screenshot filename for example.
        * example: findNewFile("foobar.tga");
        * will try foobar001.tga, if the file exists, try foobar002.tga and so on until it finds an unexistant file.
        */
        static std::string FindNewFile (const std::string &filename);

        /**
        * Return the position between [begin,end[ of the last separator between path and filename ('/' or '\').
        * If there's no separator, it returns string::npos.
        */
        static sint32 GetLastSeparator (const std::string &filename);

        static std::string GetFilenameWithoutExtension (const std::string &filename);
        static std::string GetExtension (const std::string &filename);

        /**
        * Return the size of the file (in bytes).
        *
        * You have to provide the full path of the file (the function doesn't lookup)
        */
        static uint32	GetFileSize (const std::string &filename);

        /**
        * Return the size of the file (in bytes).
        */
        static uint32	GetFileSize (FILE *f);

        /**
        * Return Time of last modification of file. 0 if not found.
        *
        * You have to provide the full path of the file (the function doesn't lookup)
        * The time is measured in second since 01-01-1970 0:0:0 UTC
        */
        static uint32	GetFileModificationDate(const std::string &filename);

        /**
        * Set the time of last modification of file.
        *
        * You have to provide the full path of the file (the function doesn't lookup)
        * The time is measured in second since 01-01-1970 0:0:0 UTC
        * Return 'true' if the file date has been changed or false in case of error.
        */
        static bool		SetFileModificationDate(const std::string &filename, uint32 modTime);

        /**
        * Return creation Time of the file. 0 if not found.
        *
        * You have to provide the full path of the file (the function doesn't lookup)
        */
        static uint32	GetFileCreationDate(const std::string &filename);

        /** Copy a file
        * NB this keeps file attributes
        * \param failIfExists If the destination file exists, nothing is done, and it returns false.
        * \return true if the copy succeeded
        */
        static bool Copyfile(const std::string &dest, const std::string &src, bool failIfExists = false);

        /** Compare 2 files
        * \return true if both files exist and the files have same timestamp and size
        */
        static bool QuickFileCompare(const std::string &fileName0, const std::string &fileName1);

        /** Move a file
        * NB this keeps file attributes
        */
        static bool Movefile(const char *dest, const char *src);

        /** Create a directory
        *	\return true if success
        */
        static bool	CreateDir(const std::string &dirname);

        /** Create a directory and any missing parent directories
        *	\return true if success
        */
        static bool	CreateDirectoryTree(const std::string &dirname);

        /** Try to set the file access to read/write if not already set.
        * return true if the file doesn't exists or if the file already have RW access.
        * Work actually only on Windows and returns always true on other platforms.
        * \return true if RW access is granted
        */
        static bool	SetRWAccess(const std::string &filename);

        /** Delete a file if possible (change the write access if possible)
        * \return true if the delete occurs.
        */
        static bool Deletefile(const std::string &filename);

        /** Delete a directory if possible (change the write access if possible)
        * \return true if the delete occurs.
        */
        static bool GeleteDirectory(const std::string &filename);

        /** Get temporary output filename.
        *	Call this method to get a temporary output filename. If you have successfully saved your data, delete the old filename and move the new one.
        */
        static void GetTemporaryOutputFilename (const std::string &originalFilename, std::string &tempFilename);

        /** Get application directory.
        * \return directory where applications should write files.
        */
        static std::string GetApplicationDirectory(const std::string &appName = "");
    };
}

#endif