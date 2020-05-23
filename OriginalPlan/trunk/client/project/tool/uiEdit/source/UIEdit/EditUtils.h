#ifndef __UTILS_H__UIEDIT__
#define __UTILS_H__UIEDIT__

#include <System.IOUtils.hpp>
#pragma hdrstop
//bool DirectoryExists(s)
#include <string>
#include <vector>
#include <algorithm>
#include <cstring>
#include <iostream>
#include <cwchar>

#include "FSUtils.h"

using namespace std;



inline bool IsInteger(const System::UnicodeString& str)
{
	AnsiString as = str;
	char numstr[256] = {0};
	int num = 0;
	if (1 != sscanf(as.c_str(), "%d%256s", &num, numstr))
		return false;
	return true;
}

System::UnicodeString DirClear(System::UnicodeString s)
{
    while (*s.LastChar() == L'/' || *s.LastChar() == L'\\')
    {
         s = s.SubString(1, s.Length() - 1);
    }
    return s + "\\";
}


// 匹配规则
// 1. 全词匹配最高。
// 2. 同样长度， 前缀匹配优先。 更小的单词优先。
// 3.

inline int wcompare(const wchar_t* a, int alen, const wchar_t* b, int blen, wchar_t* search_string, int len)
{
//	wchar_t search_string[] = L"1";
//	int len = wcslen(search_string);

	if (len == 0)
	{
		return wcscmp(a, b);
	}

	if (len > alen && len > blen)
	{
		return wcscmp(a, b);
	}

	if (alen > len && blen < len)
	{
		return -1;
	}

	if (blen > len && alen < len)
	{
		return 1;
	}

	const wchar_t* pa = wcsstr(a, search_string);
	const wchar_t* pb = wcsstr(b, search_string);

	if (!pa && !pb)
	{
		return wcscmp(a, b);
	}
	else if (pa && !pb)
	{
		return -1;
	}
	else if (!pa && pb)
	{
		return 1;
	}
	else //if (pa && pb)
	{
		if (alen == blen)
		{
            if (blen == len)
            {
                return 0;
            }
			return wcscmp(a, b);
		}

		if (alen == len)
		{
			return -1;
		}
		if(blen == len)
		{
			return 1;
		}
		int xa = pa - a;
		int xb = pb - b;
		if (xa != xb)
		{
			return xa < xb ? -1 : 1;
		}
		return alen > blen ? -1 : 1;
	}
}

inline int wcompare(const UnicodeString& a, const UnicodeString& b, const UnicodeString& c)
{
    return wcompare(a.c_str(), a.Length(), b.c_str(), b.Length(), c.c_str(), c.Length());
}

inline string tostring(const AnsiString& str)
{
    return FSUtils::ansitoutf8(str.c_str());
}
inline string tostring(const UnicodeString& str)
{
    AnsiString as = str;
    return tostring(as);
}

inline AnsiString toAnsiString(const string& str)
{
    AnsiString as = FSUtils::utf8toansi(str).c_str();
    return as;
}

inline UnicodeString toUnicodeString(const string& str)
{
    return toAnsiString(str);
}

inline string toansi(const AnsiString& str)
{
    return str.c_str();
}
inline string toansi(const UnicodeString& str)
{
    AnsiString as = str;
    return toansi(as);
}
#endif
