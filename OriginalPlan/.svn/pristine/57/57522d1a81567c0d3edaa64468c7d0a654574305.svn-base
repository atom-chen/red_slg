#ifndef _SOCKET_ATTR_H_
#define _SOCKET_ATTR_H_

#include "core/base_util.h"
#include "core/string_parse.h"
#include "core/string_common.h"

typedef struct PackHandleAttr 
{
	PackHandleAttr(){
		compress = false;
		compressProtocol = true;
		encrypt = false;
		maxCompressNum = 10;
		compressLen = 1;
		compressMaxLen = 10000000;
		minCompressNum = 1;
	}
	bool	compress;			// 是否需要压缩
	bool	compressProtocol;	// 是否需要压缩协议
	sint32	maxCompressNum;		// 最大压缩个数
	sint32	compressLen;		// 超过多少长度需要压缩
	sint32  compressMaxLen;		// 一次压缩不能超过多长
	sint32  minCompressNum;		// 使用压缩协议的最小包个数
	bool	encrypt;			// 是否需要加密
}TPackHandleAttr;
typedef struct SockAttr
{
	GXMISC::TIPString_t ip;
	GXMISC::TPort_t port;
	TPackHandleAttr packAttr;

	SockAttr()
	{
		ip = "";
		port = 0;
		packAttr.compress = false;
		packAttr.compressProtocol = true;
		packAttr.encrypt = false;
		packAttr.maxCompressNum = 10;
		packAttr.compressLen = 1;
		packAttr.compressMaxLen = 10000000;
		packAttr.minCompressNum = 1;
	}

	bool needHandle()
	{
		return packAttr.encrypt || packAttr.compress;
	}

	bool parse(const char* str)
	{
		if(NULL == str)
		{
			return false;
		}

		GXMISC::CStringParse<std::string> parase;
		parase.setParseFlag("|");
		parase.parse(str);
		if(parase.size() < 2)
		{
			return false;
		}

		for(uint32 i = 0; i < parase.size(); ++i)
		{
			GXMISC::CStringParse<std::string> optParse;
			optParse.setParseFlag(":");
			optParse.parse(parase[i]);
			if(optParse.size() != 2)
			{
				return false;
			}

			if(optParse[0].compare("I") == 0)
			{
				// IP
				ip = optParse[1];
			}
			else if(optParse[0].compare("P") == 0)
			{
				// Port
				if(!GXMISC::gxFromString(optParse[1], port))
				{
					return false;
				}
			}
			else if(optParse[0].compare("C") == 0)
			{
				// Compress
				if(!GXMISC::gxFromString(optParse[1], packAttr.compress))
				{
					return false;
				}
			}
			else if(optParse[0].compare("CP") == 0)
			{
				// Compress Protocol
				if(!GXMISC::gxFromString(optParse[1], packAttr.compressProtocol))
				{
					return false;
				}
			}
			else if(optParse[0].compare("CN") == 0)
			{
				// Compress Num
				if(!GXMISC::gxFromString(optParse[1], packAttr.maxCompressNum))
				{
					return false;
				}
			}
			else if(optParse[0].compare("CL") == 0)
			{
				// Compress Len
				if(!GXMISC::gxFromString(optParse[1], packAttr.compressLen))
				{
					return false;
				}
			}
			else if(optParse[0].compare("CML") == 0)
			{
				// Compress Max Len
				if(!GXMISC::gxFromString(optParse[1], packAttr.compressMaxLen))
				{
					return false;
				}
			}
			else if(optParse[0].compare("CMIN") == 0)
			{
				// Compress Min Num
				if(!GXMISC::gxFromString(optParse[1], packAttr.minCompressNum))
				{
					return false;
				}
			}
			else if(optParse[0].compare("E") == 0)
			{
				// Encrypt
				if(!GXMISC::gxFromString(optParse[1], packAttr.encrypt))
				{
					return false;
				}
			}
			else
			{
				return false;
			}
		}

		return true;
	}
}TSockExtAttr;

#endif // _SOCKET_ATTR_H_