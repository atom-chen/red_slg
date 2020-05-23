#include "curl_util.h"
#include "debug.h"

uint32 UrlWriteData( void *ptr, uint32 size, uint32 nmemb, void *stream )
{
	TUrlDownFile* downFile = (TUrlDownFile*)stream;
	if (downFile->curLen + size*nmemb >= (MAX_CURL_FILE_SIZE-1)) return 0;
	memcpy(downFile->buff+downFile->curLen, ptr, size*nmemb);
	downFile->curLen += size*nmemb;
	return size*nmemb;
}

bool GetUrlFile( TUrlDownFile& downFile, const char* url, const char* user, const char* pass, bool basicAuth /*= true*/ )
{
	CURL *curl;
	CURLcode res;

	memset(&downFile, 0, sizeof(downFile));
	curl = curl_easy_init();
	curl_easy_setopt(curl, CURLOPT_NOSIGNAL, 1L);						// 无信号处理
	curl_easy_setopt(curl, CURLOPT_URL, url);							// 设置下载地址
	curl_easy_setopt(curl, CURLOPT_TIMEOUT, 10000);						// 设置超时时间
	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, UrlWriteData);		// 设置写数据的函数
	curl_easy_setopt(curl, CURLOPT_WRITEDATA, &downFile);				// 设置写数据的变量
	curl_easy_setopt(curl, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);			// 设置验证方式
	if(basicAuth){
		std::string autlStr = GXMISC::gxToString("%s:%s", user, pass);
		curl_easy_setopt(curl, CURLOPT_USERPWD, autlStr.c_str());		// 设置登陆用户名和密码
	}
	res = curl_easy_perform(curl);										// 执行下载
	downFile.buff[downFile.curLen] = '\0';

	sint64 retCode = 0;
	if(CURLE_OK != curl_easy_getinfo(curl, CURLINFO_RESPONSE_CODE, &retCode))
	{
		curl_easy_cleanup(curl);
		return false;
	}

	curl_easy_cleanup(curl);

	if(retCode != 200)
	{
		return false;
	}

	if(CURLE_OK != res) return false;									// 判断是否下载成功

	return true;
}

bool GetUrlFileByPost(TUrlDownFile& downFile, const char* url, std::string posData)
{
	CURL *curl;
	curl = curl_easy_init();

	memset(&downFile, 0, sizeof(downFile));

	curl_easy_setopt(curl, CURLOPT_URL, url);
	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, UrlWriteData);
	curl_easy_setopt(curl, CURLOPT_WRITEDATA, &downFile);

	curl_slist* headerlist = NULL;
	headerlist = curl_slist_append(headerlist, "Content-Type: application/octet-stream");			
	curl_easy_setopt(curl, CURLOPT_HTTPHEADER, headerlist);
	curl_easy_setopt(curl, CURLOPT_POSTFIELDSIZE, posData.length());
	curl_easy_setopt(curl, CURLOPT_POSTFIELDS, posData.c_str());
	curl_easy_setopt(curl, CURLOPT_POST, 1);	

	CURLcode res = curl_easy_perform(curl);
	downFile.buff[downFile.curLen] = '\0';

	sint64 retCode = 0;
	if(CURLE_OK != curl_easy_getinfo(curl, CURLINFO_RESPONSE_CODE, &retCode))
	{
		curl_slist_free_all(headerlist);
		curl_easy_cleanup(curl);
		return false;
	}
	curl_slist_free_all(headerlist);
	curl_easy_cleanup(curl);
	if(retCode != 200)
	{
		return false;
	}

	if(CURLE_OK != res) return false;									// 判断是否下载成功

	return false;
}

/*
bool GetUrlResponse(TUrlDownFile& downFile, const char* url)
{
	ghttp_request *request = NULL;  
	ghttp_status status = ghttp_error;  
	char *buf = NULL;  
	int bytes_read = 0;  

	memset(&downFile, 0, sizeof(downFile));

	request = ghttp_request_new();
	if(ghttp_set_uri(request, (char*)url) == -1)
	{
		ghttp_clean(request);
		ghttp_request_destroy(request);
		gxError("Cant set url!url={0}", url);
		return false;
	}
	if(ghttp_set_type(request, ghttp_type_get) == -1)  
	{
		ghttp_clean(request);
		ghttp_request_destroy(request);
		gxError("Cant set get type!url={0}", url);
		return false;
	} 
	ghttp_prepare(request);  
	status = ghttp_process(request);  
	if(status == ghttp_error)  
	{
		ghttp_clean(request);
		ghttp_request_destroy(request);
		gxError("Process error!url={0}", url);
		return false;
	}

	buf = ghttp_get_body(request);  
	bytes_read = ghttp_get_body_len(request);  

	memcpy(downFile.buff, buf, bytes_read);
	downFile.curLen = bytes_read;
	downFile.buff[downFile.curLen] = '\0';

	ghttp_clean(request);
	ghttp_request_destroy(request);

	return true;
}
*/