#ifndef _MD5_EXT_H_
#define _MD5_EXT_H_

#include "md5.h"

static bool MD5Data(const void* pData,uint32 size,MD5_DIGEST *pMD5  )
{
	MD5_CTX context;
	MD5Init (&context, 0);
	MD5Update (&context, (unsigned char*)pData, size);
	MD5Final (&context,pMD5);
	return true;
}

// @todo
static bool MD5File(const char* pszFile, MD5_DIGEST *pMD5  )
{
	//     FILE* fp =0; 
	//     fopen(&fp,pszFile,"rb");
	//     if(!fp) return false;
	// 
	//     unsigned char buffer[8192];
	//     size_t len;
	//     fseek(fp,0,SEEK_END);
	//     len = ftell(fp);
	//     fseek(fp,0,SEEK_SET);
	// 
	//     MD5_CTX context;
	//     MD5Init (&context);
	//     while( len ){
	//         size_t readLen = (len < 8192 ? len : 8192);
	//         if(1 != fread(buffer,readLen,1,fp)){
	//             MD5Final (&context,pMD5);
	//             if (fp){fclose(fp);fp=NULL;}
	//             return false;
	//         }
	//         len -= readLen;
	//         MD5Update (&context, buffer, readLen);
	//     }
	// 
	//     MD5Final (&context,pMD5);
	//     if (fp){fclose(fp);fp=NULL;}
	return true;
}

static bool MD5String(const char* string, MD5_DIGEST* pMD5  )
{
	sint32 size = (sint32)strlen(string);
	return MD5Data(string,size,pMD5);
}

static std::string ToMD5String(std::string str)
{
	std::string md5Msg;
	MD5_DIGEST realMD5Str;
	if(MD5String(str.c_str(), &realMD5Str))
	{
		for(uint32 i = 0; i < sizeof(MD5_DIGEST); ++i)
		{
			md5Msg += GXMISC::gxToString("%.2x", realMD5Str[i]);
		}
	}

	return md5Msg;
}

#endif