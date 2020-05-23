#ifndef _CURL_UTIL_H_
#define _CURL_UTIL_H_

#include "core/types_def.h"
#include "core/string_common.h"

#include "curl/curl.h"

//#include <ghttp.h>

#define MAX_CURL_FILE_SIZE 1024*10
typedef struct UrlDownFile
{
	char buff[MAX_CURL_FILE_SIZE];
	sint32 curLen;

public:
	UrlDownFile(){
		memset(this, 0, sizeof(this));
	}
}TUrlDownFile;

bool GetUrlFile(TUrlDownFile& downFile, const char* url, const char* user, const char* pass, bool basicAuth = true);
bool GetUrlFileByPost(TUrlDownFile& downFile, const char* url, std::string posData);
//bool GetUrlResponse(TUrlDownFile& downFile, const char* url);

#endif // _CURL_UTIL_H_