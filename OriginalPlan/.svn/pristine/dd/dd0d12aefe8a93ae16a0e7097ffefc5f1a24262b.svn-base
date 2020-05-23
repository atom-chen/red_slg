// #ifndef _ENUM_TO_STRING_H_
// #define _ENUM_TO_STRING_H_

#undef _E
#undef _BEGIN_ENUM
#undef _END_ENUM
#undef _EN

#include <map>
#include <string>

#include "core/types_def.h"

#ifndef GENERATE_ENUM_STRINGS
#define _E( element, str ) element
#define _EN( element, str, itemNum ) element = itemNum
#define _BEGIN_ENUM( ENUM_NAME ) typedef enum tag##ENUM_NAME
#define _END_ENUM( ENUM_NAME ) ENUM_NAME; const char* GetString##ENUM_NAME(sint32 index); \
	const char* GetString##ENUM_NAME(const std::string& index); const void RebuildString##ENUM_NAME(); 
#else
#define _E( element, str ) {	element, #element, str }
#define _EN( element, str, itemNum ) { element, #element, str }
#define _BEGIN_ENUM( ENUM_NAME )	\
	typedef std::map<int, const char*> TEnumMap##ENUM_NAME;\
	typedef std::map<std::string, const char*> TEnumStringMap##ENUM_NAME; \
	static TEnumMap##ENUM_NAME maps##ENUM_NAME;	\
	static TEnumStringMap##ENUM_NAME mapsString##ENUM_NAME; \
	typedef struct Element{	\
	enum tag##ENUM_NAME index;	\
	const char* indexString;	\
	const char* name;	\
	}TElement;	\
	TElement gs_##ENUM_NAME [] =
#define _END_ENUM( ENUM_NAME ) ; \
	const char* GetString##ENUM_NAME(sint32 index)	\
	{	\
	TEnumMap##ENUM_NAME::iterator iter = maps##ENUM_NAME.find(index);	\
	if(iter != maps##ENUM_NAME.end()){ return iter->second;}	\
	return ""; \
	}	\
	const char* GetString##ENUM_NAME(const std::string& index)	\
	{	\
	TEnumStringMap##ENUM_NAME::iterator iter = mapsString##ENUM_NAME.find(index);	\
	if(iter != mapsString##ENUM_NAME.end()){ return iter->second;}	\
	return ""; \
	}	\
	const void RebuildString##ENUM_NAME()	\
	{	\
	for(unsigned int i = 0; i < (sizeof(gs_##ENUM_NAME)/sizeof(gs_##ENUM_NAME[0])); ++i){	\
	maps##ENUM_NAME.insert(TEnumMap##ENUM_NAME::value_type(gs_##ENUM_NAME[i].index, gs_##ENUM_NAME[i].name));	\
	mapsString##ENUM_NAME.insert(TEnumStringMap##ENUM_NAME::value_type(gs_##ENUM_NAME[i].indexString, gs_##ENUM_NAME[i].name));	\
	}\
	}
#endif

//#endif	// _ENUM_TO_STRING_H_