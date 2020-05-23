#ifndef _INI_UTIL_H_
#define _INI_UTIL_H_

#define DReadIniStr(str, var) \
	if(!ini.readTextIfExist(_moduleName.c_str(), str, var)) \
{ \
	gxError("Can't read {0}! ModuleName = {1}", str, _moduleName.c_str()); \
	return false; \
}

#define DReadIniNum(str, var) \
	if(!ini.readTypeIfExist(_moduleName.c_str(), str, var)) \
{ \
	gxError("Can't read {0}! ModuleName = {1}", str, _moduleName.c_str()); \
	return false; \
}

#define DReadIniSockAttr(str, var)	\
	{	\
	std::string	tempStr;	\
	DReadIniStr(str, tempStr);	\
	if(!var.parse(tempStr.c_str()))	\
		{	\
		gxError("Can't read {0}! ModuleName = {1}", str, _moduleName.c_str()); \
		return false;	\
		}	\
	}


#endif	// _INI_UTIL_H_