/*------------- reflect.h
*
* Copyright (C): www.7cool.cn (2010)
* Author       : 
* Version      : V1.01
* Date         : 2010/11/26 9:18:52
*
*/ 
/*************************************************************
*
*************************************************************/

#ifdef USE_RTTI
#include <typeinfo>
#endif

#ifdef RTTI_DLL
#ifdef INSIDE_RTTI
#define RTTI_DLL_ENTRY __declspec(dllexport)
#else
#define RTTI_DLL_ENTRY __declspec(dllimport)
#endif
#else
#define RTTI_DLL_ENTRY
#endif

#pragma warning (disable:4100)

#include "rtti/type.h"
#include "rtti/class.h"
#include "rtti/field.h"
#include "rtti/method.h"
#include "rtti/typedecl.h"

const sint32 RTTI_CLASS_HASH_SIZE = 1013;

class RTTI_DLL_ENTRY RTTIRepository
{
public:
	RTTIRepository()
	{
		ZeroMemory(hashTable, sizeof(hashTable));
		ZeroMemory(hashAliasTable, sizeof(hashAliasTable));
		classes = NULL;
	}

public:
	RTTIClassDescriptor* getFirstClass()
	{
		return classes;
	}

	RTTIClassDescriptor*               findClass(char const* pclassname, bool bocasestr = false);
	RTTIClassDescriptor*               findClassByAliasName(char const* pAliasName, bool bocasestr = false);

#ifdef USE_RTTI
	RTTIClassDescriptor*               findClass(class type_info const& tinfo, bool bocasestr = false)
	{
		return findClass(tinfo.name(), bocasestr);
	}
#endif

	bool addClass(RTTIClassDescriptor* cls);
	virtual bool load(char const* filePath);

public:
	static RTTIRepository* getInstance()
	{
		if(theRepository == NULL)
		{
			theRepository = new RTTIRepository;
		}

		return theRepository;
	}

	static RTTIRepository* instance_readonly()
	{
		return theRepository;
	}

	static void delInstance()
	{
		if(theRepository)
		{
			delete theRepository;
			theRepository = NULL;
		}
	}

protected:
	static RTTIRepository* theRepository;

protected:
	RTTIClassDescriptor*  classes;
	RTTIClassDescriptor*  hashTable[RTTI_CLASS_HASH_SIZE];
	RTTIClassDescriptor*  hashAliasTable[RTTI_CLASS_HASH_SIZE];
};

typedef		RTTIRepository		RttiManage;
typedef		RTTIRepository		RttiM;

#define RTTI_FIELDNAME(pf,buf,objname)\
if (objname==NULL || objname[0]==0)\
	strcpy_s(buf,sizeof(buf)-1,pf->getAliasName());\
else\
	sprintf_s(buf,sizeof(buf)-1,"%s.%s",objname,pf->getAliasName());

/*
typedef bool (WINAPI* fnfieldfilter)(void* p, RTTIClassDescriptor* pclass, TiXmlElement* node, RTTIFieldDescriptor* pfield, const char* objname);
bool SaveClassToXml(void* p, RTTIClassDescriptor* pclass, TiXmlElement* node, fnfieldfilter filter = NULL, const char* objname = NULL);
bool InitClassFromXml(void* p, RTTIClassDescriptor* pclass, TiXmlElement* node, fnfieldfilter filter = NULL, const char* objname = NULL);
*/