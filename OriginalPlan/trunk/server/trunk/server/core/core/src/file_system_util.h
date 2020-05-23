#ifndef _MY_FILE_SYSTEM_H_
#define _MY_FILE_SYSTEM_H_

#include "stdcore.h"

#include "base_util.h"

namespace GXMISC
{
	bool MyWriteStringFile(const std::string& fileName, const char* data, uint32 len);
	bool MyWriteStringFileAppend(const std::string& fileName, const char* data, uint32 len);
	bool MyReadStringFile(const std::string& fileName, std::string& data);
	bool MyReadStringFile(const std::string& fileName, char* data);
};

#endif