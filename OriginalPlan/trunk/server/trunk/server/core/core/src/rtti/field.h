#ifndef __FIELD_H__
#define __FIELD_H__

#include <string.h>
#include <math.h>

class RTTIClassDescriptor;

enum RTTIFieldFlags
{
	RTTI_FLD_INSTANCE  = 0x0001,
	RTTI_FLD_STATIC    = 0x0002,
	RTTI_FLD_CONST     = 0x0004,
	RTTI_FLD_PUBLIC    = 0x0010,
	RTTI_FLD_PROTECTED = 0x0020,
	RTTI_FLD_PRIVATE   = 0x0040,
	RTTI_FLD_VIRTUAL   = 0x0100,
	RTTI_FLD_VOLATILE  = 0x0200,
	RTTI_FLD_TRANSIENT = 0x0400
};

class RTTIFieldDescriptor
{
public:

	char const* getName()
	{
		return name;
	}
	char const* getAliasName()
	{
		return aliasname;
	}

	void fixPtrFieldName(char* fixname, int nBackLevel = 0x7fff);


	void setValue(void* obj, void* buf, int nmaxsize)
	{
		memcpy(getPtr(obj), buf, std::min(size, nmaxsize));
	}


	void getValue(void* obj, void* buf, int nmaxsize)
	{
		memcpy(buf, getPtr(obj),  std::min(size, nmaxsize));
	}

	RTTIClassDescriptor* getDeclaringClass()
	{
		return declaringClass;
	}

	int getOffset()
	{
		return offs;
	}
	void* getPtr(void* p)
	{
		if(!(flags & RTTI_FLD_STATIC))
		{
			return ((void*)(((unsigned char*)p) + offs));
		}
		else
		{
			return ((void*)(offs));
		}
	}

	int getSize()
	{
		return size;
	}


	RTTIType* getType()
	{
		return type;
	}

	int getFlags()
	{
		return flags;
	}

	RTTIFieldDescriptor(char const* name, int offs, int size, int flags, RTTIType* type, char const* aliasname = NULL)
	{
		this->name = name;
		this->aliasname = aliasname;

		if(!this->aliasname)
		{
			this->aliasname = name;
		}

		this->offs = offs;
		this->size = size;
		this->type = type;
		this->flags = flags;
		next = NULL;
		chain = &next;
	}


	RTTIFieldDescriptor& operator, (RTTIFieldDescriptor& field)
	{
		*chain = &field;
		chain = &field.next;
		return *this;
	}


	int getIndex()
	{
		return index;
	}

	virtual ~RTTIFieldDescriptor();

protected:
	friend class RTTIType;
	friend class RTTIClassDescriptor;
	friend class RTTIBfdRepository;

	int         flags;
	int         index;
	RTTIType*   type;
	int         offs;
	int         size;
	char const* name;
	char const* aliasname;

	RTTIClassDescriptor*  declaringClass;

	RTTIFieldDescriptor*  next;
	RTTIFieldDescriptor** chain;
};

#endif
