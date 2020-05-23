#include "debug.h"
#include "file_system_util.h"

namespace GXMISC
{
	bool MyWriteStringFile(const std::string& fileName, const char* data, uint32 len)
	{
		FILE* pf = NULL;

		pf = fopen(fileName.c_str(), "wb");
		if(NULL == pf)
		{
			gxError("Can't open file!FileName={0}", fileName.c_str());
			fclose(pf);
			return false;
		}

		if(fwrite(data, 1, len, pf) != len)
		{
			gxError("Can't write file!FileName={0}", fileName.c_str());
			fclose(pf);
			return false;
		}

		fclose(pf);
		return true;
	}

	bool MyWriteStringFileAppend(const std::string& fileName, const char* data, uint32 len)
	{
		FILE* pf = NULL;

		pf = fopen(fileName.c_str(), "ab+");
		if(NULL == pf)
		{
			gxError("Can't open file!FileName={0}", fileName.c_str());
			fclose(pf);
			return false;
		}

		if(fwrite(data, 1, len, pf) != len)
		{
			gxError("Can't write file!FileName={0}", fileName.c_str());
			fclose(pf);
			return false;
		}

		fclose(pf);
		return true;
	}

	bool MyReadStringFile(const std::string& fileName, std::string& data)
	{
		FILE* pf = NULL;

		pf = fopen(fileName.c_str(), "rb");
		if(NULL == pf)
		{
			gxError("Can't open file!FileName={0}", fileName.c_str());
			fclose(pf);
			return false;
		}

		fseek(pf, 0, SEEK_END);
		size_t len = ftell(pf);
		fseek(pf, 0, SEEK_SET);

		char* buff = new char[len];
		if(fread(buff, 1, len, pf) != len)
		{
			gxError("Can't read file!FileName={0}", fileName.c_str());
			fclose(pf);
			return false;
		}

		data.reserve(len);
		data.assign(buff, len);
		DSafeDeleteArray(buff);
		fclose(pf);

		return true;
	}

	bool MyReadStringFile(const std::string& fileName, char* data)
	{
		FILE* pf = NULL;

		pf = fopen(fileName.c_str(), "rb");
		if (NULL == pf)
		{
			gxError("Can't open file!FileName={0}", fileName.c_str());
			fclose(pf);
			return false;
		}

		fseek(pf, 0, SEEK_END);
		size_t len = ftell(pf);
		fseek(pf, 0, SEEK_SET);

		//char* buff = new char[len];
		if (fread(data, 1, len, pf) != len)
		{
			gxError("Can't read file!FileName={0}", fileName.c_str());
			fclose(pf);
			return false;
		}

		fclose(pf);

		return true;
	}

}