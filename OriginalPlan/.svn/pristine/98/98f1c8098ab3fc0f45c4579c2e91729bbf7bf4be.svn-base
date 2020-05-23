#include "stdcore.h"
#include "string_common.h"

using namespace std;

namespace GXMISC
{
    const char* GXMISC::TFS<uint8>::FMT = "%hu";
    const char* GXMISC::TFS<sint8>::FMT = "%hd";
    const char* GXMISC::TFS<uint16>::FMT = "%hu";
    const char* GXMISC::TFS<sint16>::FMT = "%hd";
    const char* GXMISC::TFS<uint32>::FMT = "%u";
    const char* GXMISC::TFS<sint32>::FMT = "%d";
    const char* GXMISC::TFS<uint64>::FMT = "%"I64_FMT"u";
    const char* GXMISC::TFS<sint64>::FMT = "%"I64_FMT"d";
    const char* GXMISC::TFS<bool>::FMT = "%hu";
    const char* GXMISC::TFS<float>::FMT = "%f";
    const char* GXMISC::TFS<double>::FMT = "%lf";
    const char* GXMISC::TFS<const char*>::FMT = "%s";
    const char* GXMISC::TFS<char*>::FMT = "%s";
    const char* GXMISC::TFS<const char* const>::FMT = "%s";

	sint32 gxSprintf( char *buffer, sint32 count, const char *format, ... )
	{
		sint32 ret;

		va_list args;
		va_start( args, format );
		ret = vsnprintf( buffer, count, format, args );
		if ( ret == -1 )
		{
			buffer[count-1] = '\0';
		}
		va_end( args );

		return( ret );
	}

	string gxAddSlashR (string str)
	{
		string formatedStr;
		for (uint32 i = 0; i < str.size(); i++)
		{
			if (str[i] == '\n' && i > 0 && str[i-1] != '\r')
			{
				formatedStr += '\r';
			}
			formatedStr += str[i];
		}
		return formatedStr;
	}

	string gxRemoveSlashR (string str)
	{
		string formatedStr;
		for (uint32 i = 0; i < str.size(); i++)
		{
			if (str[i] != '\r')
				formatedStr += str[i];
		}
		return formatedStr;
	}

	const bool gxExplode(const char* src, const char* p1, const char* p2, std::string& outStr)
	{
		const char* strPos1 = strstr(src, p1); 
		if(strPos1 == NULL)
		{
			return false;
		}
		const char* strPos2 = strstr(strPos1+1, p2);
		if(strPos2 == NULL)
		{
			return false;
		}
		outStr.assign(strPos1+1,strPos2-strPos1);
		return true;
	}

	void gxTrimright(std::string &str,char c/*=' '*/)
	{
		//trim tail
		if(str.empty())
		{
			return;
		}
		sint32 i = 0;
		sint32 len = (int)str.length();

		for(i = len - 1; i >= 0; --i ){
			if(str[i] != c){
				break;
			}
		}

		str = string(str,0,i+1);
	}

	void gxTrimleft(std::string &str,char c/*=' '*/)
	{
		if(str.empty())
		{
			return;
		}

		//trim head
		sint32 len = (int)str.length();

		sint32 i = 0;
		while(str[i] == c && str[i] != '\0'){
			i++;
		}
		if(i != 0){
			str = string(str,i,len-i);
		}
	}

}
