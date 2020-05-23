#include "reflect.h"

void RTTIFieldDescriptor::fixPtrFieldName(char* fixname, int nBackLevel)
{
	if(getType()->isPointer() && nBackLevel >= 0)
	{
		nBackLevel = nBackLevel > getType()->getPtrLevel() ? getType()->getPtrLevel() : nBackLevel;
		memset(fixname, '*', nBackLevel);
	}

	sint32 nlen = (sint32)strlen(name);
	strncpy(&fixname[nBackLevel], name, nlen);
	fixname[nlen+nBackLevel] = 0;
}

RTTIFieldDescriptor::~RTTIFieldDescriptor()
{
	type->destroy();
}