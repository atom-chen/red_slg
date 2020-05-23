#ifndef _LOG_FORMAT_H_
#define _LOG_FORMAT_H_

#include <string>
#include <cassert>
#include <cstring>
#include <cstdlib>

#include "string_common.h"

namespace GXMISC
{
	// @TODO 重新设计(主线程解析日志格式字符串位置并存储起来, 多线程则采用安全版本)
	inline static void _LogFormat(std::string& out, const char* str, sint32 totalLen)
	{
		out.append(str, totalLen);
	}

	template< typename A0>
	inline const char* _LogFormatParam(sint32 curIndex, std::string& out, const char* str,  sint32 totalLen, sint32& lastTotalLen, A0 const & a0)
	{
		if(totalLen == 0)
		{
			assert(false);
			return NULL;
		}

		std::string findStr = "{";
		findStr.append(gxToString(curIndex));
		findStr.append("}");
		const char* cur = strstr(str, findStr.c_str());
		if (NULL == cur)
		{
			assert(false);
			out.append(str, totalLen);
			return NULL;
		}
		out.append(str, cur-str);
		out.append(gxToString(a0));
		lastTotalLen = (sint32)(totalLen-(cur-str+findStr.length()));
		return cur+findStr.length();
	}

	template< typename A0>
	inline void _LogFormat(sint32 curIndex, std::string& out, const char* str,  sint32 totalLen, A0 const & a0)
	{
		sint32 lastTotalLen = 0;
		const char* cur = _LogFormatParam(curIndex, out, str, totalLen, lastTotalLen, a0);
		curIndex++;
		_LogFormat(out, cur, lastTotalLen);
	}

	template< typename A0 , typename A1>
	inline void _LogFormat(sint32 curIndex, std::string& out, const char* str,  sint32 totalLen,  A0 const & a0 , A1 const & a1)
	{
		sint32 lastTotalLen = 0;
		const char* cur = _LogFormatParam(curIndex, out, str, totalLen, lastTotalLen, a0);
		curIndex++;
		_LogFormat(curIndex, out, cur, lastTotalLen, a1);
	}

	template< typename A0 , typename A1 , typename A2>
	inline void _LogFormat(sint32 curIndex, std::string& out, const char* str,  sint32 totalLen,  A0 const & a0 , A1 const & a1 , A2 const & a2)
	{
		sint32 lastTotalLen = 0;
		const char* cur = _LogFormatParam(curIndex, out, str, totalLen, lastTotalLen, a0);
		curIndex++;
		_LogFormat(curIndex, out, cur, lastTotalLen, a1, a2);
	}

	template< typename A0 , typename A1 , typename A2 , typename A3>
	inline void _LogFormat(sint32 curIndex, std::string& out, const char* str,  sint32 totalLen,  A0 const & a0 , A1 const & a1 , A2 const & a2 , A3 const & a3)
	{
		sint32 lastTotalLen = 0;
		const char* cur = _LogFormatParam(curIndex, out, str, totalLen, lastTotalLen, a0);
		curIndex++;
		_LogFormat(curIndex, out, cur, lastTotalLen, a1, a2, a3);
	}

	template< typename A0 , typename A1 , typename A2 , typename A3 , typename A4>
	inline void _LogFormat(sint32 curIndex, std::string& out, const char* str,  sint32 totalLen,  A0 const & a0 , A1 const & a1 , A2 const & a2 , A3 const & a3 , A4 const & a4)
	{
		sint32 lastTotalLen = 0;
		const char* cur = _LogFormatParam(curIndex, out, str, totalLen, lastTotalLen, a0);
		curIndex++;
		_LogFormat(curIndex, out, cur, lastTotalLen, a1, a2, a3, a4);
	}

	template< typename A0 , typename A1 , typename A2 , typename A3 , typename A4 , typename A5>
	inline void _LogFormat(sint32 curIndex, std::string& out, const char* str,  sint32 totalLen,  A0 const & a0 , A1 const & a1 , A2 const & a2 , A3 const & a3 , A4 const & a4 , A5 const & a5)
	{
		sint32 lastTotalLen = 0;
		const char* cur = _LogFormatParam(curIndex, out, str, totalLen, lastTotalLen, a0);
		curIndex++;
		_LogFormat(curIndex, out, cur, lastTotalLen, a1, a2, a3, a4, a5);
	}

	template< typename A0 , typename A1 , typename A2 , typename A3 , typename A4 , typename A5 , typename A6>
	inline void _LogFormat(sint32 curIndex, std::string& out, const char* str,  sint32 totalLen,  A0 const & a0 , A1 const & a1 , A2 const & a2 , A3 const & a3 , A4 const & a4 , A5 const & a5 , A6 const & a6)
	{
		sint32 lastTotalLen = 0;
		const char* cur = _LogFormatParam(curIndex, out, str, totalLen, lastTotalLen, a0);
		curIndex++;
		_LogFormat(curIndex, out, cur, lastTotalLen, a1, a2, a3, a4, a5, a6);
	}

	template< typename A0 , typename A1 , typename A2 , typename A3 , typename A4 , typename A5 , typename A6 , typename A7>
	inline void _LogFormat(sint32 curIndex, std::string& out, const char* str,  sint32 totalLen,  A0 const & a0 , A1 const & a1 , A2 const & a2 , A3 const & a3 , A4 const & a4 , A5 const & a5 , A6 const & a6 , A7 const & a7)
	{
		sint32 lastTotalLen = 0;
		const char* cur = _LogFormatParam(curIndex, out, str, totalLen, lastTotalLen, a0);
		curIndex++;
		_LogFormat(curIndex, out, cur, lastTotalLen, a1, a2, a3, a4, a5, a6, a7);
	}

	template< typename A0 , typename A1 , typename A2 , typename A3 , typename A4 , typename A5 , typename A6 , typename A7 , typename A8>
	inline void _LogFormat(sint32 curIndex, std::string& out, const char* str,  sint32 totalLen,  A0 const & a0 , A1 const & a1 , A2 const & a2 , A3 const & a3 , A4 const & a4 , A5 const & a5 , A6 const & a6 , A7 const & a7 , A8 const & a8)
	{
		sint32 lastTotalLen = 0;
		const char* cur = _LogFormatParam(curIndex, out, str, totalLen, lastTotalLen, a0);
		curIndex++;
		_LogFormat(curIndex, out, cur, lastTotalLen, a1, a2, a3, a4, a5, a6, a7, a8);
	}

	template< typename A0 , typename A1 , typename A2 , typename A3 , typename A4 , typename A5 , typename A6 , typename A7 , typename A8 , typename A9>
	inline void _LogFormat(sint32 curIndex, std::string& out, const char* str,  sint32 totalLen,  A0 const & a0 , A1 const & a1 , A2 const & a2 , A3 const & a3 , A4 const & a4 , A5 const & a5 , A6 const & a6 , A7 const & a7 , A8 const & a8 , A9 const & a9)
	{
		sint32 lastTotalLen = 0;
		const char* cur = _LogFormatParam(curIndex, out, str, totalLen, lastTotalLen, a0);
		curIndex++;
		_LogFormat(curIndex, out, cur, lastTotalLen, a1, a2, a3, a4, a5, a6, a7, a8, a9);
	}

	inline static void LogFormat(std::string& out, const char* str)
	{
		out.append(str);
	}

	template< typename A0>
	inline void LogFormat(std::string& out, const char* str, A0 const & a0)
	{
		sint32 curIndex = 0;
		sint32 totalLen = (sint32)strlen(str);
		_LogFormat(curIndex, out, str, totalLen, a0);
	}

	template< typename A0 , typename A1>
	inline void LogFormat(std::string& out, const char* str,  A0 const & a0 , A1 const & a1)
	{
		sint32 curIndex = 0;
		sint32 totalLen = (sint32)strlen(str);
		_LogFormat(curIndex, out, str, totalLen, a0, a1);
	}

	template< typename A0 , typename A1 , typename A2>
	inline void LogFormat(std::string& out, const char* str,  A0 const & a0 , A1 const & a1 , A2 const & a2)
	{
		sint32 curIndex = 0;
		sint32 totalLen = (sint32)strlen(str);
		_LogFormat(curIndex, out, str, totalLen, a0, a1, a2);
	}

	template< typename A0 , typename A1 , typename A2 , typename A3>
	inline void LogFormat(std::string& out, const char* str,  A0 const & a0 , A1 const & a1 , A2 const & a2 , A3 const & a3)
	{
		sint32 curIndex = 0;
		sint32 totalLen = (sint32)strlen(str);
		_LogFormat(curIndex, out, str, totalLen, a0, a1, a2, a3);
	}

	template< typename A0 , typename A1 , typename A2 , typename A3 , typename A4>
	inline void LogFormat(std::string& out, const char* str,  A0 const & a0 , A1 const & a1 , A2 const & a2 , A3 const & a3 , A4 const & a4)
	{
		sint32 curIndex = 0;
		sint32 totalLen = (sint32)strlen(str);
		_LogFormat(curIndex, out, str, totalLen, a0, a1, a2, a3, a4);
	}

	template< typename A0 , typename A1 , typename A2 , typename A3 , typename A4 , typename A5>
	inline void LogFormat(std::string& out, const char* str,  A0 const & a0 , A1 const & a1 , A2 const & a2 , A3 const & a3 , A4 const & a4 , A5 const & a5)
	{
		sint32 curIndex = 0;
		sint32 totalLen = (sint32)strlen(str);
		_LogFormat(curIndex, out, str, totalLen, a0, a1, a2, a3, a4, a5);
	}

	template< typename A0 , typename A1 , typename A2 , typename A3 , typename A4 , typename A5 , typename A6>
	inline void LogFormat(std::string& out, const char* str,  A0 const & a0 , A1 const & a1 , A2 const & a2 , A3 const & a3 , A4 const & a4 , A5 const & a5 , A6 const & a6)
	{
		sint32 curIndex = 0;
		sint32 totalLen = (sint32)strlen(str);
		_LogFormat(curIndex, out, str, totalLen, a0, a1, a2, a3, a4, a5, a6);
	}

	template< typename A0 , typename A1 , typename A2 , typename A3 , typename A4 , typename A5 , typename A6 , typename A7>
	inline void LogFormat(std::string& out, const char* str,  A0 const & a0 , A1 const & a1 , A2 const & a2 , A3 const & a3 , A4 const & a4 , A5 const & a5 , A6 const & a6 , A7 const & a7)
	{
		sint32 curIndex = 0;
		sint32 totalLen = (sint32)strlen(str);
		_LogFormat(curIndex, out, str, totalLen, a0, a1, a2, a3, a4, a5, a6, a7);
	}

	template< typename A0 , typename A1 , typename A2 , typename A3 , typename A4 , typename A5 , typename A6 , typename A7 , typename A8>
	inline void LogFormat(std::string& out, const char* str,  A0 const & a0 , A1 const & a1 , A2 const & a2 , A3 const & a3 , A4 const & a4 , A5 const & a5 , A6 const & a6 , A7 const & a7 , A8 const & a8)
	{
		sint32 curIndex = 0;
		sint32 totalLen = (sint32)strlen(str);
		_LogFormat(curIndex, out, str, totalLen, a0, a1, a2, a3, a4, a5, a6, a7, a8);
	}

	template< typename A0 , typename A1 , typename A2 , typename A3 , typename A4 , typename A5 , typename A6 , typename A7 , typename A8 , typename A9>
	inline void LogFormat(std::string& out, const char* str,  A0 const & a0 , A1 const & a1 , A2 const & a2 , A3 const & a3 , A4 const & a4 , A5 const & a5 , A6 const & a6 , A7 const & a7 , A8 const & a8 , A9 const & a9)
	{
		sint32 curIndex = 0;
		sint32 totalLen = (sint32)strlen(str);
		_LogFormat(curIndex, out, str, totalLen, a0, a1, a2, a3, a4, a5, a6, a7, a8, a9);
	}
}

#endif	// _LOG_FORMAT_H_