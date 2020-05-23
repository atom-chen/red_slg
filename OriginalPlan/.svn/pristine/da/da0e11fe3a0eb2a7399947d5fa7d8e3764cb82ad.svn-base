#ifndef _STREAMABLE_UTIL_H_
#define _STREAMABLE_UTIL_H_

#define DSerialBegStructLen(itemNum,mem)	\
	(sint32)(pMem##itemNum-pMyPack)	\
	+GXMISC::IStream::SerialLen(mem)
#define DSerialStructLen(itemNum,prenum,mem,premem)	\
	(sint32)(pMem##itemNum-pMem##prenum-sizeof(premem))	\
	+GXMISC::IStream::SerialLen(mem)
#define DSerialEndStructLen(itemNum,mem)	\
	(sint32)((sizeof(*this)+((char*)this))-pMem##itemNum-sizeof(mem))
#define DSerialBegFunc(itemNum,mem)	\
	char* pMyPack = ((char*)this);	\
	char* pMem##itemNum = (char*)(&(mem));	\
	gxAssert(pMem##itemNum-pMyPack >= 0);	\
	if(pMem##itemNum-pMyPack>0)	\
	{	\
	f.serialBuffer(pMyPack,(uint32)(pMem##itemNum-pMyPack));	\
}	\
	f.serial(mem);

#define DSerialFunc(itemNum,prenum,mem,premem)	\
	char* pMem##itemNum = (char*)(&(mem));	\
	gxAssert(pMem##itemNum-pMem##prenum-sizeof(premem) >= 0);	\
	if(pMem##itemNum-pMem##prenum-sizeof(premem) > 0)	\
	{	\
	f.serialBuffer(pMem##prenum+sizeof(premem),(uint32)(pMem##itemNum-pMem##prenum-sizeof(premem)));	\
}	\
	f.serial(mem);
#define DSerialEndFunc(itemNum,mem)	\
	sint32 selfPackLen = sizeof(*this);	\
	gxAssert(pMyPack+selfPackLen-pMem##itemNum-sizeof(mem) >= 0);	\
	if(pMyPack+selfPackLen-pMem##itemNum-sizeof(mem) > 0)	\
	{	\
	f.serialBuffer(pMem##itemNum+sizeof(mem), (uint32)(pMyPack+selfPackLen-pMem##itemNum-sizeof(mem)));	\
}
#define DSTREAMABLE_IMPL1(packVariedMem1)	\
	sint32 serial(GXMISC::IStream& f)	\
	{	\
	DSerialBegFunc(1,packVariedMem1);	\
	DSerialEndFunc(1,packVariedMem1);	\
	return 1;	\
}	\
	sint32 serialLen()	\
	{	\
	char* pMyPack = ((char*)this);	\
	char* pMem1 = (char*)(&(packVariedMem1));	\
	return DSerialBegStructLen(1,packVariedMem1)	\
	+DSerialEndStructLen(1,packVariedMem1);	\
}	\
	sint32 unSerial(GXMISC::IUnStream& f)	\
	{	\
	DSerialBegFunc(1,packVariedMem1);	\
	DSerialEndFunc(1,packVariedMem1);	\
	return 1;	\
}

#define DSTREAMABLE_IMPL2(packVariedMem1,packVariedMem2)	\
	sint32 serial(GXMISC::IStream& f)	\
	{	\
	DSerialBegFunc(1,packVariedMem1);	\
	DSerialFunc(2,1,packVariedMem2,packVariedMem1);	\
	DSerialEndFunc(2,packVariedMem2);	\
	return 1;	\
}	\
	sint32 serialLen()	\
	{	\
	char* pMyPack = ((char*)this);	\
	char* pMem1 = (char*)(&(packVariedMem1));	\
	char* pMem2 = (char*)(&(packVariedMem2));	\
	return DSerialBegStructLen(1,packVariedMem1)	\
	+DSerialStructLen(2,1,packVariedMem2,packVariedMem1)	\
	+DSerialEndStructLen(2,packVariedMem2);	\
}	\
	sint32 unSerial(GXMISC::IUnStream& f)	\
	{	\
	DSerialBegFunc(1,packVariedMem1);	\
	DSerialFunc(2,1,packVariedMem2,packVariedMem1);	\
	DSerialEndFunc(2,packVariedMem2);	\
	return 1;	\
}

#define DSTREAMABLE_IMPL3(packVariedMem1,packVariedMem2,packVariedMem3)	\
	sint32 serial(GXMISC::IStream& f)	\
	{	\
	DSerialBegFunc(1,packVariedMem1);	\
	DSerialFunc(2,1,packVariedMem2,packVariedMem1);	\
	DSerialFunc(3,2,packVariedMem3,packVariedMem2);	\
	DSerialEndFunc(3,packVariedMem3);	\
	return 1;	\
}	\
	sint32 serialLen()	\
	{	\
	char* pMyPack = ((char*)this);	\
	char* pMem1 = (char*)(&(packVariedMem1));	\
	char* pMem2 = (char*)(&(packVariedMem2));	\
	char* pMem3 = (char*)(&(packVariedMem3));	\
	return DSerialBegStructLen(1,packVariedMem1)	\
	+DSerialStructLen(2,1,packVariedMem2,packVariedMem1)	\
	+DSerialStructLen(3,2,packVariedMem3,packVariedMem2)	\
	+DSerialEndStructLen(3,packVariedMem3);	\
}	\
	sint32 unSerial(GXMISC::IUnStream& f)	\
	{	\
	DSerialBegFunc(1,packVariedMem1);	\
	DSerialFunc(2,1,packVariedMem2,packVariedMem1);	\
	DSerialFunc(3,2,packVariedMem3,packVariedMem2);	\
	DSerialEndFunc(3,packVariedMem3);	\
	return 1;	\
}

#define DSTREAMABLE_IMPL4(packVariedMem1,packVariedMem2,packVariedMem3,packVariedMem4)	\
	sint32 serial(GXMISC::IStream& f)	\
	{	\
	DSerialBegFunc(1,packVariedMem1);	\
	DSerialFunc(2,1,packVariedMem2,packVariedMem1);	\
	DSerialFunc(3,2,packVariedMem3,packVariedMem2);	\
	DSerialFunc(4,3,packVariedMem4,packVariedMem3);	\
	DSerialEndFunc(4,packVariedMem4);	\
	return 1;	\
}	\
	sint32 serialLen()	\
	{	\
	char* pMyPack = ((char*)this);	\
	char* pMem1 = (char*)(&(packVariedMem1));	\
	char* pMem2 = (char*)(&(packVariedMem2));	\
	char* pMem3 = (char*)(&(packVariedMem3));	\
	char* pMem4 = (char*)(&(packVariedMem4));	\
	return DSerialBegStructLen(1,packVariedMem1)	\
	+DSerialStructLen(2,1,packVariedMem2,packVariedMem1)	\
	+DSerialStructLen(3,2,packVariedMem3,packVariedMem2)	\
	+DSerialStructLen(4,3,packVariedMem4,packVariedMem3)	\
	+DSerialEndStructLen(4,packVariedMem4);	\
}	\
	sint32 unSerial(GXMISC::IUnStream& f)	\
	{	\
	DSerialBegFunc(1,packVariedMem1);	\
	DSerialFunc(2,1,packVariedMem2,packVariedMem1);	\
	DSerialFunc(3,2,packVariedMem3,packVariedMem2);	\
	DSerialFunc(4,3,packVariedMem4,packVariedMem3);	\
	DSerialEndFunc(4,packVariedMem4);	\
	return 1;	\
}

#define DSTREAMABLE_IMPL5(packVariedMem1,packVariedMem2,packVariedMem3,packVariedMem4,packVariedMem5)	\
	sint32 serial(GXMISC::IStream& f)	\
	{	\
	DSerialBegFunc(1,packVariedMem1);	\
	DSerialFunc(2,1,packVariedMem2,packVariedMem1);	\
	DSerialFunc(3,2,packVariedMem3,packVariedMem2);	\
	DSerialFunc(4,3,packVariedMem4,packVariedMem3);	\
	DSerialFunc(5,4,packVariedMem5,packVariedMem4);	\
	DSerialEndFunc(5,packVariedMem5);	\
	return 1;	\
}	\
	sint32 serialLen()	\
	{	\
	char* pMyPack = ((char*)this);	\
	char* pMem1 = (char*)(&(packVariedMem1));	\
	char* pMem2 = (char*)(&(packVariedMem2));	\
	char* pMem3 = (char*)(&(packVariedMem3));	\
	char* pMem4 = (char*)(&(packVariedMem4));	\
	char* pMem5 = (char*)(&(packVariedMem5));	\
	return DSerialBegStructLen(1,packVariedMem1)	\
	+DSerialStructLen(2,1,packVariedMem2,packVariedMem1)	\
	+DSerialStructLen(3,2,packVariedMem3,packVariedMem2)	\
	+DSerialStructLen(4,3,packVariedMem4,packVariedMem3)	\
	+DSerialStructLen(5,4,packVariedMem5,packVariedMem4)	\
	+DSerialEndStructLen(5,packVariedMem5);	\
}	\
	sint32 unSerial(GXMISC::IUnStream& f)	\
	{	\
	DSerialBegFunc(1,packVariedMem1);	\
	DSerialFunc(2,1,packVariedMem2,packVariedMem1);	\
	DSerialFunc(3,2,packVariedMem3,packVariedMem2);	\
	DSerialFunc(4,3,packVariedMem4,packVariedMem3);	\
	DSerialFunc(5,4,packVariedMem5,packVariedMem4);	\
	DSerialEndFunc(5,packVariedMem5);	\
	return 1;	\
}

#define DSTREAMABLE_IMPL6(packVariedMem1,packVariedMem2,packVariedMem3,packVariedMem4,packVariedMem5,packVariedMem6)	\
	sint32 serial(GXMISC::IStream& f)	\
	{	\
	DSerialBegFunc(1,packVariedMem1);	\
	DSerialFunc(2,1,packVariedMem2,packVariedMem1);	\
	DSerialFunc(3,2,packVariedMem3,packVariedMem2);	\
	DSerialFunc(4,3,packVariedMem4,packVariedMem3);	\
	DSerialFunc(5,4,packVariedMem5,packVariedMem4);	\
	DSerialFunc(6,5,packVariedMem6,packVariedMem5);	\
	DSerialEndFunc(6,packVariedMem6);	\
	return 1;	\
}	\
	sint32 serialLen()	\
	{	\
	char* pMyPack = ((char*)this);	\
	char* pMem1 = (char*)(&(packVariedMem1));	\
	char* pMem2 = (char*)(&(packVariedMem2));	\
	char* pMem3 = (char*)(&(packVariedMem3));	\
	char* pMem4 = (char*)(&(packVariedMem4));	\
	char* pMem5 = (char*)(&(packVariedMem5));	\
	char* pMem6 = (char*)(&(packVariedMem6));	\
	return DSerialBegStructLen(1,packVariedMem1)	\
	+DSerialStructLen(2,1,packVariedMem2,packVariedMem1)	\
	+DSerialStructLen(3,2,packVariedMem3,packVariedMem2)	\
	+DSerialStructLen(4,3,packVariedMem4,packVariedMem3)	\
	+DSerialStructLen(5,4,packVariedMem5,packVariedMem4)	\
	+DSerialStructLen(6,5,packVariedMem6,packVariedMem5)	\
	+DSerialEndStructLen(6,packVariedMem6);	\
}	\
	sint32 unSerial(GXMISC::IUnStream& f)	\
	{	\
	DSerialBegFunc(1,packVariedMem1);	\
	DSerialFunc(2,1,packVariedMem2,packVariedMem1);	\
	DSerialFunc(3,2,packVariedMem3,packVariedMem2);	\
	DSerialFunc(4,3,packVariedMem4,packVariedMem3);	\
	DSerialFunc(5,4,packVariedMem5,packVariedMem4);	\
	DSerialFunc(6,5,packVariedMem6,packVariedMem5);	\
	DSerialEndFunc(6,packVariedMem6);	\
	return 1;	\
}

#define DSTREAMABLE_IMPL7(packVariedMem1,packVariedMem2,packVariedMem3,packVariedMem4,packVariedMem5,packVariedMem6,packVariedMem7)	\
	sint32 serial(GXMISC::IStream& f)	\
	{	\
	DSerialBegFunc(1,packVariedMem1);	\
	DSerialFunc(2,1,packVariedMem2,packVariedMem1);	\
	DSerialFunc(3,2,packVariedMem3,packVariedMem2);	\
	DSerialFunc(4,3,packVariedMem4,packVariedMem3);	\
	DSerialFunc(5,4,packVariedMem5,packVariedMem4);	\
	DSerialFunc(6,5,packVariedMem6,packVariedMem5);	\
	DSerialFunc(7,6,packVariedMem7,packVariedMem6);	\
	DSerialEndFunc(7,packVariedMem7);	\
	return 1;	\
}	\
	sint32 serialLen()	\
	{	\
	char* pMyPack = ((char*)this);	\
	char* pMem1 = (char*)(&(packVariedMem1));	\
	char* pMem2 = (char*)(&(packVariedMem2));	\
	char* pMem3 = (char*)(&(packVariedMem3));	\
	char* pMem4 = (char*)(&(packVariedMem4));	\
	char* pMem5 = (char*)(&(packVariedMem5));	\
	char* pMem6 = (char*)(&(packVariedMem6));	\
	char* pMem7 = (char*)(&(packVariedMem7));	\
	return DSerialBegStructLen(1,packVariedMem1)	\
	+DSerialStructLen(2,1,packVariedMem2,packVariedMem1)	\
	+DSerialStructLen(3,2,packVariedMem3,packVariedMem2)	\
	+DSerialStructLen(4,3,packVariedMem4,packVariedMem3)	\
	+DSerialStructLen(5,4,packVariedMem5,packVariedMem4)	\
	+DSerialStructLen(6,5,packVariedMem6,packVariedMem5)	\
	+DSerialStructLen(7,6,packVariedMem7,packVariedMem6)	\
	+DSerialEndStructLen(7,packVariedMem7);	\
}	\
	sint32 unSerial(GXMISC::IUnStream& f)	\
	{	\
	DSerialBegFunc(1,packVariedMem1);	\
	DSerialFunc(2,1,packVariedMem2,packVariedMem1);	\
	DSerialFunc(3,2,packVariedMem3,packVariedMem2);	\
	DSerialFunc(4,3,packVariedMem4,packVariedMem3);	\
	DSerialFunc(5,4,packVariedMem5,packVariedMem4);	\
	DSerialFunc(6,5,packVariedMem6,packVariedMem5);	\
	DSerialFunc(7,6,packVariedMem7,packVariedMem6);	\
	DSerialEndFunc(7,packVariedMem7);	\
	return 1;	\
}

#define DSTREAMABLE_IMPL8(packVariedMem1,packVariedMem2,packVariedMem3,packVariedMem4,packVariedMem5,packVariedMem6,packVariedMem7,packVariedMem8)	\
	sint32 serial(GXMISC::IStream& f)	\
	{	\
	DSerialBegFunc(1,packVariedMem1);	\
	DSerialFunc(2,1,packVariedMem2,packVariedMem1);	\
	DSerialFunc(3,2,packVariedMem3,packVariedMem2);	\
	DSerialFunc(4,3,packVariedMem4,packVariedMem3);	\
	DSerialFunc(5,4,packVariedMem5,packVariedMem4);	\
	DSerialFunc(6,5,packVariedMem6,packVariedMem5);	\
	DSerialFunc(7,6,packVariedMem7,packVariedMem6);	\
	DSerialFunc(8,7,packVariedMem8,packVariedMem7);	\
	DSerialEndFunc(8,packVariedMem8);	\
	return 1;	\
}	\
	sint32 serialLen()	\
	{	\
	char* pMyPack = ((char*)this);	\
	char* pMem1 = (char*)(&(packVariedMem1));	\
	char* pMem2 = (char*)(&(packVariedMem2));	\
	char* pMem3 = (char*)(&(packVariedMem3));	\
	char* pMem4 = (char*)(&(packVariedMem4));	\
	char* pMem5 = (char*)(&(packVariedMem5));	\
	char* pMem6 = (char*)(&(packVariedMem6));	\
	char* pMem7 = (char*)(&(packVariedMem7));	\
	char* pMem8 = (char*)(&(packVariedMem8));	\
	return DSerialBegStructLen(1,packVariedMem1)	\
	+DSerialStructLen(2,1,packVariedMem2,packVariedMem1)	\
	+DSerialStructLen(3,2,packVariedMem3,packVariedMem2)	\
	+DSerialStructLen(4,3,packVariedMem4,packVariedMem3)	\
	+DSerialStructLen(5,4,packVariedMem5,packVariedMem4)	\
	+DSerialStructLen(6,5,packVariedMem6,packVariedMem5)	\
	+DSerialStructLen(7,6,packVariedMem7,packVariedMem6)	\
	+DSerialStructLen(8,7,packVariedMem8,packVariedMem7)	\
	+DSerialEndStructLen(8,packVariedMem8);	\
}	\
	sint32 unSerial(GXMISC::IUnStream& f)	\
	{	\
	DSerialBegFunc(1,packVariedMem1);	\
	DSerialFunc(2,1,packVariedMem2,packVariedMem1);	\
	DSerialFunc(3,2,packVariedMem3,packVariedMem2);	\
	DSerialFunc(4,3,packVariedMem4,packVariedMem3);	\
	DSerialFunc(5,4,packVariedMem5,packVariedMem4);	\
	DSerialFunc(6,5,packVariedMem6,packVariedMem5);	\
	DSerialFunc(7,6,packVariedMem7,packVariedMem6);	\
	DSerialFunc(8,7,packVariedMem8,packVariedMem7);	\
	DSerialEndFunc(8,packVariedMem8);	\
	return 1;	\
}

#define DSTREAMABLE_IMPL9(packVariedMem1,packVariedMem2,packVariedMem3,packVariedMem4,packVariedMem5,packVariedMem6,packVariedMem7,packVariedMem8,packVariedMem9)	\
	sint32 serial(GXMISC::IStream& f)	\
	{	\
	DSerialBegFunc(1,packVariedMem1);	\
	DSerialFunc(2,1,packVariedMem2,packVariedMem1);	\
	DSerialFunc(3,2,packVariedMem3,packVariedMem2);	\
	DSerialFunc(4,3,packVariedMem4,packVariedMem3);	\
	DSerialFunc(5,4,packVariedMem5,packVariedMem4);	\
	DSerialFunc(6,5,packVariedMem6,packVariedMem5);	\
	DSerialFunc(7,6,packVariedMem7,packVariedMem6);	\
	DSerialFunc(8,7,packVariedMem8,packVariedMem7);	\
	DSerialFunc(9,8,packVariedMem9,packVariedMem8);	\
	DSerialEndFunc(9,packVariedMem9);	\
	return 1;	\
}	\
	sint32 serialLen()	\
	{	\
	char* pMyPack = ((char*)this);	\
	char* pMem1 = (char*)(&(packVariedMem1));	\
	char* pMem2 = (char*)(&(packVariedMem2));	\
	char* pMem3 = (char*)(&(packVariedMem3));	\
	char* pMem4 = (char*)(&(packVariedMem4));	\
	char* pMem5 = (char*)(&(packVariedMem5));	\
	char* pMem6 = (char*)(&(packVariedMem6));	\
	char* pMem7 = (char*)(&(packVariedMem7));	\
	char* pMem8 = (char*)(&(packVariedMem8));	\
	char* pMem9 = (char*)(&(packVariedMem9));	\
	return DSerialBegStructLen(1,packVariedMem1)	\
	+DSerialStructLen(2,1,packVariedMem2,packVariedMem1)	\
	+DSerialStructLen(3,2,packVariedMem3,packVariedMem2)	\
	+DSerialStructLen(4,3,packVariedMem4,packVariedMem3)	\
	+DSerialStructLen(5,4,packVariedMem5,packVariedMem4)	\
	+DSerialStructLen(6,5,packVariedMem6,packVariedMem5)	\
	+DSerialStructLen(7,6,packVariedMem7,packVariedMem6)	\
	+DSerialStructLen(8,7,packVariedMem8,packVariedMem7)	\
	+DSerialStructLen(9,8,packVariedMem9,packVariedMem9)	\
	+DSerialEndStructLen(9,packVariedMem9);	\
}	\
	sint32 unSerial(GXMISC::IUnStream& f)	\
	{	\
	DSerialBegFunc(1,packVariedMem1);	\
	DSerialFunc(2,1,packVariedMem2,packVariedMem1);	\
	DSerialFunc(3,2,packVariedMem3,packVariedMem2);	\
	DSerialFunc(4,3,packVariedMem4,packVariedMem3);	\
	DSerialFunc(5,4,packVariedMem5,packVariedMem4);	\
	DSerialFunc(6,5,packVariedMem6,packVariedMem5);	\
	DSerialFunc(7,6,packVariedMem7,packVariedMem6);	\
	DSerialFunc(8,7,packVariedMem8,packVariedMem7);	\
	DSerialFunc(9,8,packVariedMem9,packVariedMem8);	\
	DSerialEndFunc(9,packVariedMem9);	\
	return 1;	\
}

#define DPACKET_IMPL()	\
public:	\
	TPackLen_t getPackLen()	\
{	\
	return sizeof(*this);	\
}

#define DPACKET_IMPL1(packVariedMem1)	\
public:	\
	TPackLen_t getPackLen()	\
	{	\
	return serialLen();	\
	}	\
	uint32 serialLen()	\
	{	\
	char* pMyPack = ((char*)this)+sizeof(TBaseType);	\
	char* pMem1 = (char*)(&(this->packVariedMem1));	\
	\
	totalLen = serialPackHeaderLen()	\
	+(sint32)(pMem1-pMyPack)	\
	+GXMISC::IStream::SerialLen(packVariedMem1)	\
	+(sint32)((sizeof(*this)+((char*)this))-pMem1-sizeof(packVariedMem1));	\
	flag = totalLen & 0xff;	\
	return totalLen;	\
	}	\
	sint32 serial(GXMISC::IStream& f)	\
{	\
	serialPackHeader(f);	\
	\
	char* pMyPack = ((char*)this)+sizeof(TBaseType);	\
	char* pMem1 = (char*)(&(this->packVariedMem1));	\
	gxAssert(pMem1-pMyPack >= 0);	\
	if(pMem1-pMyPack>0)	\
	{	\
	f.serialBuffer(pMyPack,(uint32)(pMem1-pMyPack));	\
	}	\
	f.serial(this->packVariedMem1);	\
	sint32 selfPackLen = sizeof(*this)-sizeof(TBaseType);	\
	gxAssert(pMyPack+selfPackLen-pMem1-sizeof(this->packVariedMem1) >= 0);	\
	if(pMyPack+selfPackLen-pMem1-sizeof(this->packVariedMem1) > 0)	\
{	\
	f.serialBuffer(pMem1+sizeof(this->packVariedMem1), (uint32)(pMyPack+selfPackLen-pMem1-sizeof(this->packVariedMem1)));	\
}	\
	\
	return 1;	\
}	\
	sint32 unSerial(GXMISC::IUnStream& f)	\
{	\
	char* pMyPack = ((char*)this)+sizeof(TBaseType);	\
	char* pMem1 = (char*)(&(this->packVariedMem1));	\
	gxAssert(pMem1-pMyPack >= 0);	\
	if(pMem1-pMyPack>0)	\
{	\
	f.serialBuffer(pMyPack,(uint32)(pMem1-pMyPack));	\
}	\
	f.serial(this->packVariedMem1);	\
	sint32 selfPackLen = sizeof(*this)-sizeof(TBaseType);	\
	gxAssert(pMyPack+selfPackLen-pMem1-sizeof(this->packVariedMem1) >= 0);	\
	if(pMyPack+selfPackLen-pMem1-sizeof(this->packVariedMem1) > 0)	\
{	\
	f.serialBuffer(pMem1+sizeof(this->packVariedMem1), (uint32)(pMyPack+selfPackLen-pMem1-sizeof(this->packVariedMem1)));	\
}	\
	\
	return 1;	\
}	\
	static void Setup()		\
{	\
	_Helper.doVoid();		\
	CGameSocketPacketHandler::RegisteUnpacketHandler(PACKET_ID, sizeof(TMyType), (TUnpacketHandler)Unpacket);	\
}	\
	static void Unsetup()	\
{	\
}	\
	static bool Unpacket(TMyType* pBase, const char * buff, sint32 len)		\
{		\
	GXMISC::CMemInputStream f;	\
	f.init(len, (char*)(buff));	\
	pBase->unserialPackHeader(f);	\
	f.serial(*pBase);	\
	return true;	\
}

#define DPACKET_IMPL2(packVariedMem1,packVariedMem2)	\
public:	\
	TPackLen_t getPackLen()	\
{	\
	return serialLen();	\
}	\
	uint32 serialLen()	\
{	\
	char* pMyPack = ((char*)this)+sizeof(TBaseType);	\
	char* pMem1 = (char*)(&(this->packVariedMem1));	\
	char* pMem2 = (char*)(&(this->packVariedMem2));	\
	\
	totalLen = serialPackHeaderLen()	\
	+(sint32)(pMem1-pMyPack)	\
	+GXMISC::IStream::SerialLen(packVariedMem1)	\
	+(sint32)(pMem2-pMem1-sizeof(packVariedMem1))	\
	+GXMISC::IStream::SerialLen(packVariedMem2)	\
	+(sint32)((sizeof(*this)+((char*)this))-pMem2-sizeof(packVariedMem2));	\
	flag = totalLen & 0xff;	\
	return totalLen;	\
}	\
	sint32 serial(GXMISC::IStream& f)	\
{	\
	serialPackHeader(f);	\
	\
	char* pMyPack = ((char*)this)+sizeof(TBaseType);	\
	char* pMem1 = (char*)(&(this->packVariedMem1));	\
	gxAssert(pMem1-pMyPack >= 0);	\
	if(pMem1-pMyPack>0)	\
{	\
	f.serialBuffer(pMyPack,(uint32)(pMem1-pMyPack));	\
}	\
	f.serial(this->packVariedMem1);	\
	char* pMem2 = (char*)(&(this->packVariedMem2));	\
	gxAssert(pMem2-pMem1-sizeof(this->packVariedMem1) >= 0);	\
	if(pMem2-pMem1-sizeof(this->packVariedMem1) > 0)	\
{	\
	f.serialBuffer(pMem1+sizeof(this->packVariedMem1),(uint32)(pMem2-pMem1-sizeof(this->packVariedMem1)));	\
}	\
	f.serial(this->packVariedMem2);	\
	sint32 selfPackLen = sizeof(*this)-sizeof(TBaseType);	\
	gxAssert(pMyPack+selfPackLen-pMem2-sizeof(this->packVariedMem2) >= 0);	\
	if(pMyPack+selfPackLen-pMem2-sizeof(this->packVariedMem2) > 0)	\
{	\
	f.serialBuffer(pMem2+sizeof(this->packVariedMem2), (uint32)(pMyPack+selfPackLen-pMem2-sizeof(this->packVariedMem2)));	\
}	\
	\
	return 1;	\
}	\
	sint32 unSerial(GXMISC::IUnStream& f)	\
{	\
	char* pMyPack = ((char*)this)+sizeof(TBaseType);	\
	char* pMem1 = (char*)(&(this->packVariedMem1));	\
	gxAssert(pMem1-pMyPack >= 0);	\
	if(pMem1-pMyPack>0)	\
{	\
	f.serialBuffer(pMyPack,(uint32)(pMem1-pMyPack));	\
}	\
	f.serial(this->packVariedMem1);	\
	char* pMem2 = (char*)(&(this->packVariedMem2));	\
	gxAssert(pMem2-pMem1-sizeof(this->packVariedMem1) >= 0);	\
	if(pMem2-pMem1-sizeof(this->packVariedMem1) > 0)	\
{	\
	f.serialBuffer(pMem1+sizeof(this->packVariedMem1),(uint32)(pMem2-pMem1-sizeof(this->packVariedMem1)));	\
}	\
	f.serial(this->packVariedMem2);	\
	sint32 selfPackLen = sizeof(*this)-sizeof(TBaseType);	\
	gxAssert(pMyPack+selfPackLen-pMem2-sizeof(this->packVariedMem2) >= 0);	\
	if(pMyPack+selfPackLen-pMem2-sizeof(this->packVariedMem2) > 0)	\
{	\
	f.serialBuffer(pMem2+sizeof(this->packVariedMem2), (uint32)(pMyPack+selfPackLen-pMem2-sizeof(this->packVariedMem2)));	\
}	\
	\
	return 1;	\
}	\
	static void Setup()		\
{	\
	_Helper.doVoid();		\
	CGameSocketPacketHandler::RegisteUnpacketHandler(PACKET_ID, sizeof(TMyType), (TUnpacketHandler)Unpacket);	\
}	\
	static void Unsetup()	\
{	\
}	\
	static bool Unpacket(TMyType* pBase, const char * buff, sint32 len)		\
{		\
	GXMISC::CMemInputStream f;	\
	f.init(len, (char*)(buff));	\
	pBase->unserialPackHeader(f);	\
	f.serial(*pBase);	\
	return true;	\
}

#define DPACKET_IMPL3(packVariedMem1,packVariedMem2,packVariedMem3)	\
public:	\
	TPackLen_t getPackLen()	\
{	\
	return serialLen();	\
}	\
	uint32 serialLen()	\
{	\
	char* pMyPack = ((char*)this)+sizeof(TBaseType);	\
	char* pMem1 = (char*)(&(this->packVariedMem1));	\
	char* pMem2 = (char*)(&(this->packVariedMem2));	\
	char* pMem3 = (char*)(&(this->packVariedMem3));	\
	\
	totalLen = serialPackHeaderLen()	\
	+(sint32)(pMem1-pMyPack)	\
	+GXMISC::IStream::SerialLen(packVariedMem1)	\
	+(sint32)(pMem2-pMem1-sizeof(packVariedMem1))	\
	+GXMISC::IStream::SerialLen(packVariedMem2)	\
	+(sint32)(pMem3-pMem2-sizeof(packVariedMem2))	\
	+GXMISC::IStream::SerialLen(packVariedMem3)	\
	+(sint32)((sizeof(*this)+((char*)this))-pMem3-sizeof(packVariedMem3));	\
	flag = totalLen & 0xff;	\
	return totalLen;	\
}	\
	sint32 serial(GXMISC::IStream& f)	\
{	\
	serialPackHeader(f);	\
	\
	char* pMyPack = ((char*)this)+sizeof(TBaseType);	\
	char* pMem1 = (char*)(&(this->packVariedMem1));	\
	gxAssert(pMem1-pMyPack >= 0);	\
	if(pMem1-pMyPack>0)	\
	{	\
	f.serialBuffer(pMyPack,(uint32)(pMem1-pMyPack));	\
	}	\
	f.serial(this->packVariedMem1);	\
	char* pMem2 = (char*)(&(this->packVariedMem2));	\
	gxAssert(pMem2-pMem1-sizeof(this->packVariedMem1) >= 0);	\
	if(pMem2-pMem1-sizeof(this->packVariedMem1) > 0)	\
	{	\
	f.serialBuffer(pMem1+sizeof(this->packVariedMem1),(uint32)(pMem2-pMem1-sizeof(this->packVariedMem1)));	\
	}	\
	f.serial(this->packVariedMem2);	\
	char* pMem3 = (char*)(&(this->packVariedMem3));	\
	gxAssert(pMem3-pMem2-sizeof(this->packVariedMem2) >= 0);	\
	if(pMem3-pMem2-sizeof(this->packVariedMem2) > 0)	\
	{	\
	f.serialBuffer(pMem2+sizeof(this->packVariedMem2),(uint32)(pMem3-pMem2-sizeof(this->packVariedMem2)));	\
	}	\
	f.serial(this->packVariedMem3);	\
	sint32 selfPackLen = sizeof(*this)-sizeof(TBaseType);	\
	gxAssert(pMyPack+selfPackLen-pMem3-sizeof(this->packVariedMem3) >= 0);	\
	if(pMyPack+selfPackLen-pMem3-sizeof(this->packVariedMem3) > 0)	\
	{	\
	f.serialBuffer(pMem3+sizeof(this->packVariedMem3), (uint32)(pMyPack+selfPackLen-pMem3-sizeof(this->packVariedMem3)));	\
	}	\
	\
	return 1;	\
}	\
	sint32 unSerial(GXMISC::IUnStream& f)	\
{	\
	char* pMyPack = ((char*)this)+sizeof(TBaseType);	\
	char* pMem1 = (char*)(&(this->packVariedMem1));	\
	gxAssert(pMem1-pMyPack >= 0);	\
	if(pMem1-pMyPack>0)	\
	{	\
	f.serialBuffer(pMyPack,(uint32)(pMem1-pMyPack));	\
	}	\
	f.serial(this->packVariedMem1);	\
	char* pMem2 = (char*)(&(this->packVariedMem2));	\
	gxAssert(pMem2-pMem1-sizeof(this->packVariedMem1) >= 0);	\
	if(pMem2-pMem1-sizeof(this->packVariedMem1) > 0)	\
	{	\
	f.serialBuffer(pMem1+sizeof(this->packVariedMem1),(uint32)(pMem2-pMem1-sizeof(this->packVariedMem1)));	\
	}	\
	f.serial(this->packVariedMem2);	\
	char* pMem3 = (char*)(&(this->packVariedMem3));	\
	gxAssert(pMem3-pMem2-sizeof(this->packVariedMem2) >= 0);	\
	if(pMem3-pMem2-sizeof(this->packVariedMem2) > 0)	\
	{	\
	f.serialBuffer(pMem2+sizeof(this->packVariedMem2),(uint32)(pMem3-pMem2-sizeof(this->packVariedMem2)));	\
	}	\
	f.serial(this->packVariedMem3);	\
	sint32 selfPackLen = sizeof(*this)-sizeof(TBaseType);	\
	gxAssert(pMyPack+selfPackLen-pMem3-sizeof(this->packVariedMem3) >= 0);	\
	if(pMyPack+selfPackLen-pMem3-sizeof(this->packVariedMem3) > 0)	\
	{	\
	f.serialBuffer(pMem3+sizeof(this->packVariedMem3), (uint32)(pMyPack+selfPackLen-pMem3-sizeof(this->packVariedMem3)));	\
	}	\
	\
	return 1;	\
}	\
	static void Setup()		\
{	\
	_Helper.doVoid();		\
	CGameSocketPacketHandler::RegisteUnpacketHandler(PACKET_ID, sizeof(TMyType), (TUnpacketHandler)Unpacket);	\
}	\
	static void Unsetup()	\
{	\
}	\
	static bool Unpacket(TMyType* pBase, const char * buff, sint32 len)		\
{		\
	GXMISC::CMemInputStream f;	\
	f.init(len, (char*)(buff));	\
	pBase->unserialPackHeader(f);	\
	f.serial(*pBase);	\
	return true;	\
}

#define DPACKET_IMPL4(packVariedMem1,packVariedMem2,packVariedMem3,packVariedMem4)		\
public:	\
	TPackLen_t getPackLen()	\
	{	\
	return serialLen();	\
	}	\
	uint32 serialLen()	\
	{	\
	char* pMyPack = ((char*)this)+sizeof(TBaseType);	\
	char* pMem1 = (char*)(&(this->packVariedMem1));	\
	char* pMem2 = (char*)(&(this->packVariedMem2));	\
	char* pMem3 = (char*)(&(this->packVariedMem3));	\
	char* pMem4 = (char*)(&(this->packVariedMem4));	\
	totalLen = serialPackHeaderLen()	\
	+(sint32)(pMem1-pMyPack)	\
	+GXMISC::IStream::SerialLen(packVariedMem1)	\
	+(sint32)(pMem2-pMem1-sizeof(packVariedMem1))	\
	+GXMISC::IStream::SerialLen(packVariedMem2)	\
	+(sint32)(pMem3-pMem2-sizeof(packVariedMem2))	\
	+GXMISC::IStream::SerialLen(packVariedMem3)	\
	+(sint32)(pMem4-pMem3-sizeof(packVariedMem3))	\
	+GXMISC::IStream::SerialLen(packVariedMem4)	\
	+(sint32)((sizeof(*this)+((char*)this))-pMem4-sizeof(packVariedMem4));	\
	flag = totalLen & 0xff;	\
	return totalLen;	\
	}	\
	sint32 serial(GXMISC::IStream& f)	\
	{	\
	serialPackHeader(f);	\
	\
	char* pMyPack = ((char*)this)+sizeof(TBaseType);	\
	char* pMem1 = (char*)(&(this->packVariedMem1));	\
	gxAssert(pMem1-pMyPack >= 0);	\
	if(pMem1-pMyPack>0)	\
	{	\
	f.serialBuffer(pMyPack,(uint32)(pMem1-pMyPack));	\
	}	\
	f.serial(this->packVariedMem1);	\
	char* pMem2 = (char*)(&(this->packVariedMem2));	\
	gxAssert(pMem2-pMem1-sizeof(this->packVariedMem1) >= 0);	\
	if(pMem2-pMem1-sizeof(this->packVariedMem1) > 0)	\
	{	\
	f.serialBuffer(pMem1+sizeof(this->packVariedMem1),(uint32)(pMem2-pMem1-sizeof(this->packVariedMem1)));	\
	}	\
	f.serial(this->packVariedMem2);	\
	char* pMem3 = (char*)(&(this->packVariedMem3));	\
	gxAssert(pMem3-pMem2-sizeof(this->packVariedMem2) >= 0);	\
	if(pMem3-pMem2-sizeof(this->packVariedMem2) > 0)	\
	{	\
	f.serialBuffer(pMem2+sizeof(this->packVariedMem2),(uint32)(pMem3-pMem2-sizeof(this->packVariedMem2)));	\
	}	\
	\
	f.serial(this->packVariedMem3);	\
	char* pMem4 = (char*)(&(this->packVariedMem4));	\
	gxAssert(pMem4-pMem3-sizeof(this->packVariedMem3) >= 0);	\
	if(pMem4-pMem3-sizeof(this->packVariedMem3) > 0)	\
	{	\
	f.serialBuffer(pMem3+sizeof(this->packVariedMem3),(uint32)(pMem4-pMem3-sizeof(this->packVariedMem3)));	\
	}	\
	f.serial(this->packVariedMem4);	\
	sint32 selfPackLen = sizeof(*this)-sizeof(TBaseType);	\
	gxAssert(pMyPack+selfPackLen-pMem4-sizeof(this->packVariedMem4) >= 0);	\
	if(pMyPack+selfPackLen-pMem4-sizeof(this->packVariedMem4) > 0)	\
	{	\
	f.serialBuffer(pMem4+sizeof(this->packVariedMem4), (uint32)(pMyPack+selfPackLen-pMem4-sizeof(this->packVariedMem4)));	\
	}	\
	\
	return 1;	\
	}	\
	sint32 unSerial(GXMISC::IUnStream& f)	\
	{	\
	char* pMyPack = ((char*)this)+sizeof(TBaseType);	\
	char* pMem1 = (char*)(&(this->packVariedMem1));	\
	gxAssert(pMem1-pMyPack >= 0);	\
	if(pMem1-pMyPack>0)	\
	{	\
	f.serialBuffer(pMyPack,(uint32)(pMem1-pMyPack));	\
	}	\
	f.serial(this->packVariedMem1);	\
	char* pMem2 = (char*)(&(this->packVariedMem2));	\
	gxAssert(pMem2-pMem1-sizeof(this->packVariedMem1) >= 0);	\
	if(pMem2-pMem1-sizeof(this->packVariedMem1) > 0)	\
	{	\
	f.serialBuffer(pMem1+sizeof(this->packVariedMem1),(uint32)(pMem2-pMem1-sizeof(this->packVariedMem1)));	\
	}	\
	f.serial(this->packVariedMem2);	\
	char* pMem3 = (char*)(&(this->packVariedMem3));	\
	gxAssert(pMem3-pMem2-sizeof(this->packVariedMem2) >= 0);	\
	if(pMem3-pMem2-sizeof(this->packVariedMem2) > 0)	\
	{	\
	f.serialBuffer(pMem2+sizeof(this->packVariedMem2),(uint32)(pMem3-pMem2-sizeof(this->packVariedMem2)));	\
	}	\
	f.serial(this->packVariedMem3);	\
	char* pMem4 = (char*)(&(this->packVariedMem4));	\
	gxAssert(pMem4-pMem3-sizeof(this->packVariedMem3) >= 0);	\
	if(pMem4-pMem3-sizeof(this->packVariedMem3) > 0)	\
	{	\
	f.serialBuffer(pMem3+sizeof(this->packVariedMem3),(uint32)(pMem4-pMem3-sizeof(this->packVariedMem3)));	\
	}	\
	f.serial(this->packVariedMem4);	\
	sint32 selfPackLen = sizeof(*this)-sizeof(TBaseType);	\
	gxAssert(pMyPack+selfPackLen-pMem4-sizeof(this->packVariedMem4) >= 0);	\
	if(pMyPack+selfPackLen-pMem4-sizeof(this->packVariedMem4) > 0)	\
	{	\
	f.serialBuffer(pMem4+sizeof(this->packVariedMem4), (uint32)(pMyPack+selfPackLen-pMem4-sizeof(this->packVariedMem4)));	\
	}	\
	\
	return 1;	\
	\
	}	\
	static void Setup()		\
	{	\
	_Helper.doVoid();		\
	CGameSocketPacketHandler::RegisteUnpacketHandler(PACKET_ID, sizeof(TMyType), (TUnpacketHandler)Unpacket);		\
	}		\
	static void Unsetup()		\
	{	\
	}	\
	static bool Unpacket(TMyType* pBase, const char * buff, sint32 len)		\
	{		\
	GXMISC::CMemInputStream f;	\
	f.init(len, (char*)(buff));	\
	pBase->unserialPackHeader(f);	\
	f.serial(*pBase);	\
	return true;	\
	}

#define DPACKET_IMPL5(packVariedMem1,packVariedMem2,packVariedMem3,packVariedMem4,packVariedMem5)	\
public:	\
	TPackLen_t getPackLen()	\
	{	\
	return serialLen();	\
	}	\
	uint32 serialLen()	\
	{	\
	char* pMyPack = ((char*)this)+sizeof(TBaseType);	\
	char* pMem1 = (char*)(&(this->packVariedMem1));	\
	char* pMem2 = (char*)(&(this->packVariedMem2));	\
	char* pMem3 = (char*)(&(this->packVariedMem3));	\
	char* pMem4 = (char*)(&(this->packVariedMem4));	\
	char* pMem5 = (char*)(&(this->packVariedMem5));	\
	totalLen = serialPackHeaderLen()	\
	+(sint32)(pMem1-pMyPack)	\
	+GXMISC::IStream::SerialLen(packVariedMem1)	\
	+(sint32)(pMem2-pMem1-sizeof(packVariedMem1))	\
	+GXMISC::IStream::SerialLen(packVariedMem2)	\
	+(sint32)(pMem3-pMem2-sizeof(packVariedMem2))	\
	+GXMISC::IStream::SerialLen(packVariedMem3)	\
	+(sint32)(pMem4-pMem3-sizeof(packVariedMem3))	\
	+GXMISC::IStream::SerialLen(packVariedMem4)	\
	+(sint32)(pMem5-pMem4-sizeof(packVariedMem4))	\
	+GXMISC::IStream::SerialLen(packVariedMem5)	\
	+(sint32)((sizeof(*this)+((char*)this))-pMem5-sizeof(packVariedMem5));	\
	flag = totalLen & 0xff;	\
	return totalLen;	\
	}	\
	sint32 serial(GXMISC::IStream& f)	\
	{	\
	serialPackHeader(f);	\
	\
	char* pMyPack = ((char*)this)+sizeof(TBaseType);	\
	char* pMem1 = (char*)(&(this->packVariedMem1));	\
	gxAssert(pMem1-pMyPack >= 0);	\
	if(pMem1-pMyPack>0)	\
		{	\
		f.serialBuffer(pMyPack,(uint32)(pMem1-pMyPack));	\
		}	\
		f.serial(this->packVariedMem1);	\
		char* pMem2 = (char*)(&(this->packVariedMem2));	\
		gxAssert(pMem2-pMem1-sizeof(this->packVariedMem1) >= 0);	\
		if(pMem2-pMem1-sizeof(this->packVariedMem1) > 0)	\
		{	\
		f.serialBuffer(pMem1+sizeof(this->packVariedMem1),(uint32)(pMem2-pMem1-sizeof(this->packVariedMem1)));	\
		}	\
		f.serial(this->packVariedMem2);	\
		char* pMem3 = (char*)(&(this->packVariedMem3));	\
		\
		gxAssert(pMem3-pMem2-sizeof(this->packVariedMem2) >= 0);	\
		if(pMem3-pMem2-sizeof(this->packVariedMem2) > 0)	\
		{	\
		f.serialBuffer(pMem2+sizeof(this->packVariedMem2),(uint32)(pMem3-pMem2-sizeof(this->packVariedMem2)));	\
		}	\
		f.serial(this->packVariedMem3);	\
		char* pMem4 = (char*)(&(this->packVariedMem4));	\
		gxAssert(pMem4-pMem3-sizeof(this->packVariedMem3) >= 0);	\
		if(pMem4-pMem3-sizeof(this->packVariedMem3) > 0)	\
		{	\
		f.serialBuffer(pMem3+sizeof(this->packVariedMem3),(uint32)(pMem4-pMem3-sizeof(this->packVariedMem3)));	\
		}	\
		f.serial(this->packVariedMem4);	\
		char* pMem5 = (char*)(&(this->packVariedMem5));	\
		gxAssert(pMem5-pMem4-sizeof(this->packVariedMem4) >= 0);	\
		if(pMem5-pMem4-sizeof(this->packVariedMem4) > 0)	\
		{	\
		f.serialBuffer(pMem4+sizeof(this->packVariedMem4),(uint32)(pMem5-pMem4-sizeof(this->packVariedMem4)));	\
		}	\
		f.serial(this->packVariedMem5);	\
		sint32 selfPackLen = sizeof(*this)-sizeof(TBaseType);	\
		gxAssert(pMyPack+selfPackLen-pMem5-sizeof(this->packVariedMem5) >= 0);	\
		if(pMyPack+selfPackLen-pMem5-sizeof(this->packVariedMem5) > 0)	\
		{	\
		f.serialBuffer(pMem5+sizeof(this->packVariedMem5), (uint32)(pMyPack+selfPackLen-pMem5-sizeof(this->packVariedMem5)));	\
		}	\
		\
		return 1;	\
	}	\
	sint32 unSerial(GXMISC::IUnStream& f)	\
	{	\
	char* pMyPack = ((char*)this)+sizeof(TBaseType);	\
	char* pMem1 = (char*)(&(this->packVariedMem1));	\
	gxAssert(pMem1-pMyPack >= 0);	\
	if(pMem1-pMyPack>0)	\
	{	\
	f.serialBuffer(pMyPack,(uint32)(pMem1-pMyPack));	\
	}	\
	f.serial(this->packVariedMem1);	\
	char* pMem2 = (char*)(&(this->packVariedMem2));	\
	gxAssert(pMem2-pMem1-sizeof(this->packVariedMem1) >= 0);	\
	if(pMem2-pMem1-sizeof(this->packVariedMem1) > 0)	\
		{	\
		f.serialBuffer(pMem1+sizeof(this->packVariedMem1),(uint32)(pMem2-pMem1-sizeof(this->packVariedMem1)));	\
		}	\
		f.serial(this->packVariedMem2);	\
		char* pMem3 = (char*)(&(this->packVariedMem3));	\
		gxAssert(pMem3-pMem2-sizeof(this->packVariedMem2) >= 0);	\
		if(pMem3-pMem2-sizeof(this->packVariedMem2) > 0)	\
		{	\
		f.serialBuffer(pMem2+sizeof(this->packVariedMem2),(uint32)(pMem3-pMem2-sizeof(this->packVariedMem2)));	\
		}	\
		f.serial(this->packVariedMem3);	\
		char* pMem4 = (char*)(&(this->packVariedMem4));	\
		gxAssert(pMem4-pMem3-sizeof(this->packVariedMem3) >= 0);	\
		if(pMem4-pMem3-sizeof(this->packVariedMem3) > 0)	\
		{	\
		f.serialBuffer(pMem3+sizeof(this->packVariedMem3),(uint32)(pMem4-pMem3-sizeof(this->packVariedMem3)));	\
		}	\
		f.serial(this->packVariedMem4);	\
		char* pMem5 = (char*)(&(this->packVariedMem5));	\
		\
		gxAssert(pMem5-pMem4-sizeof(this->packVariedMem4) >= 0);	\
		if(pMem5-pMem4-sizeof(this->packVariedMem4) > 0)	\
		{	\
		f.serialBuffer(pMem4+sizeof(this->packVariedMem4),(uint32)(pMem5-pMem4-sizeof(this->packVariedMem4)));	\
		}	\
		f.serial(this->packVariedMem5);	\
		sint32 selfPackLen = sizeof(*this)-sizeof(TBaseType);	\
		gxAssert(pMyPack+selfPackLen-pMem5-sizeof(this->packVariedMem5) >= 0);	\
		if(pMyPack+selfPackLen-pMem5-sizeof(this->packVariedMem5) > 0)	\
		{	\
		f.serialBuffer(pMem5+sizeof(this->packVariedMem5), (uint32)(pMyPack+selfPackLen-pMem5-sizeof(this->packVariedMem5)));	\
		}	\
		\
		return 1;	\
	}	\
	static void Setup()		\
	{	\
	_Helper.doVoid();		\
	CGameSocketPacketHandler::RegisteUnpacketHandler(PACKET_ID, sizeof(TMyType), (TUnpacketHandler)Unpacket);		\
	}		\
	static void Unsetup()		\
	{	\
	}	\
	static bool Unpacket(TMyType* pBase, const char * buff, sint32 len)		\
	{		\
	GXMISC::CMemInputStream f;	\
	f.init(len, (char*)(buff));	\
	pBase->unserialPackHeader(f);	\
	f.serial(*pBase);	\
	return true;	\
	}

#define DPACKET_IMPL6(packVariedMem1,packVariedMem2,packVariedMem3,packVariedMem4,packVariedMem5,packVariedMem6)		\
public:	\
	TPackLen_t getPackLen()	\
	{	\
	return serialLen();	\
	}	\
	uint32 serialLen()	\
	{	\
	char* pMyPack = ((char*)this)+sizeof(TBaseType);	\
	char* pMem1 = (char*)(&(this->packVariedMem1));	\
	char* pMem2 = (char*)(&(this->packVariedMem2));	\
	char* pMem3 = (char*)(&(this->packVariedMem3));	\
	char* pMem4 = (char*)(&(this->packVariedMem4));	\
	char* pMem5 = (char*)(&(this->packVariedMem5));	\
	char* pMem6 = (char*)(&(this->packVariedMem6));	\
	totalLen = serialPackHeaderLen()	\
	+(sint32)(pMem1-pMyPack)	\
	+GXMISC::IStream::SerialLen(packVariedMem1)	\
	+(sint32)(pMem2-pMem1-sizeof(packVariedMem1))	\
	+GXMISC::IStream::SerialLen(packVariedMem2)	\
	+(sint32)(pMem3-pMem2-sizeof(packVariedMem2))	\
	+GXMISC::IStream::SerialLen(packVariedMem3)	\
	+(sint32)(pMem4-pMem3-sizeof(packVariedMem3))	\
	+GXMISC::IStream::SerialLen(packVariedMem4)	\
	+(sint32)(pMem5-pMem4-sizeof(packVariedMem4))	\
	+GXMISC::IStream::SerialLen(packVariedMem5)	\
	+(sint32)(pMem6-pMem5-sizeof(packVariedMem5))	\
	+GXMISC::IStream::SerialLen(packVariedMem6)	\
	+(sint32)((sizeof(*this)+((char*)this))-pMem6-sizeof(packVariedMem6));	\
	flag = totalLen & 0xff;	\
	return totalLen;	\
	}	\
	sint32 serial(GXMISC::IStream& f)	\
	{	\
	serialPackHeader(f);	\
	\
	char* pMyPack = ((char*)this)+sizeof(TBaseType);	\
	char* pMem1 = (char*)(&(this->packVariedMem1));	\
	gxAssert(pMem1-pMyPack >= 0);	\
	if(pMem1-pMyPack>0)	\
		{	\
		f.serialBuffer(pMyPack,(uint32)(pMem1-pMyPack));	\
		}	\
		f.serial(this->packVariedMem1);	\
		char* pMem2 = (char*)(&(this->packVariedMem2));	\
		gxAssert(pMem2-pMem1-sizeof(this->packVariedMem1) >= 0);	\
		if(pMem2-pMem1-sizeof(this->packVariedMem1) > 0)	\
		{	\
		f.serialBuffer(pMem1+sizeof(this->packVariedMem1),(uint32)(pMem2-pMem1-sizeof(this->packVariedMem1)));	\
		}	\
		f.serial(this->packVariedMem2);	\
		char* pMem3 = (char*)(&(this->packVariedMem3));	\
		gxAssert(pMem3-pMem2-sizeof(this->packVariedMem2) >= 0);	\
		if(pMem3-pMem2-sizeof(this->packVariedMem2) > 0)	\
		{	\
		f.serialBuffer(pMem2+sizeof(this->packVariedMem2),(uint32)(pMem3-pMem2-sizeof(this->packVariedMem2)));	\
		}	\
		f.serial(this->packVariedMem3);	\
		char* pMem4 = (char*)(&(this->packVariedMem4));	\
		gxAssert(pMem4-pMem3-sizeof(this->packVariedMem3) >= 0);	\
		if(pMem4-pMem3-sizeof(this->packVariedMem3) > 0)	\
		{	\
		f.serialBuffer(pMem3+sizeof(this->packVariedMem3),(uint32)(pMem4-pMem3-sizeof(this->packVariedMem3)));	\
		}	\
		f.serial(this->packVariedMem4);	\
		char* pMem5 = (char*)(&(this->packVariedMem5));	\
		gxAssert(pMem5-pMem4-sizeof(this->packVariedMem4) >= 0);	\
		if(pMem5-pMem4-sizeof(this->packVariedMem4) > 0)	\
		{	\
		f.serialBuffer(pMem4+sizeof(this->packVariedMem4),(uint32)(pMem5-pMem4-sizeof(this->packVariedMem4)));	\
		}	\
		f.serial(this->packVariedMem5);	\
		char* pMem6 = (char*)(&(this->packVariedMem6));	\
		gxAssert(pMem6-pMem5-sizeof(this->packVariedMem5) >= 0);	\
		if(pMem6-pMem5-sizeof(this->packVariedMem5) > 0)	\
		{	\
		f.serialBuffer(pMem5+sizeof(this->packVariedMem5),(uint32)(pMem6-pMem5-sizeof(this->packVariedMem5)));	\
		}	\
		f.serial(this->packVariedMem6);	\
		sint32 selfPackLen = sizeof(*this)-sizeof(TBaseType);	\
		gxAssert(pMyPack+selfPackLen-pMem6-sizeof(this->packVariedMem6) >= 0);	\
		if(pMyPack+selfPackLen-pMem6-sizeof(this->packVariedMem6) > 0)	\
		{	\
		f.serialBuffer(pMem6+sizeof(this->packVariedMem6), (uint32)(pMyPack+selfPackLen-pMem6-sizeof(this->packVariedMem6)));	\
		}	\
		\
		return 1;	\
	}	\
	sint32 unSerial(GXMISC::IUnStream& f)	\
	{	\
	char* pMyPack = ((char*)this)+sizeof(TBaseType);	\
	char* pMem1 = (char*)(&(this->packVariedMem1));	\
	gxAssert(pMem1-pMyPack >= 0);	\
	if(pMem1-pMyPack>0)	\
		{	\
		f.serialBuffer(pMyPack,(uint32)(pMem1-pMyPack));	\
		}	\
		f.serial(this->packVariedMem1);	\
		char* pMem2 = (char*)(&(this->packVariedMem2));	\
		gxAssert(pMem2-pMem1-sizeof(this->packVariedMem1) >= 0);	\
		if(pMem2-pMem1-sizeof(this->packVariedMem1) > 0)	\
		{	\
		f.serialBuffer(pMem1+sizeof(this->packVariedMem1),(uint32)(pMem2-pMem1-sizeof(this->packVariedMem1)));	\
		}	\
		f.serial(this->packVariedMem2);	\
		char* pMem3 = (char*)(&(this->packVariedMem3));	\
		gxAssert(pMem3-pMem2-sizeof(this->packVariedMem2) >= 0);	\
		if(pMem3-pMem2-sizeof(this->packVariedMem2) > 0)	\
		{	\
		f.serialBuffer(pMem2+sizeof(this->packVariedMem2),(uint32)(pMem3-pMem2-sizeof(this->packVariedMem2)));	\
		}	\
		f.serial(this->packVariedMem3);	\
		char* pMem4 = (char*)(&(this->packVariedMem4));	\
		gxAssert(pMem4-pMem3-sizeof(this->packVariedMem3) >= 0);	\
		if(pMem4-pMem3-sizeof(this->packVariedMem3) > 0)	\
		{	\
		f.serialBuffer(pMem3+sizeof(this->packVariedMem3),(uint32)(pMem4-pMem3-sizeof(this->packVariedMem3)));	\
		}	\
		f.serial(this->packVariedMem4);	\
		char* pMem5 = (char*)(&(this->packVariedMem5));	\
		gxAssert(pMem5-pMem4-sizeof(this->packVariedMem4) >= 0);	\
		if(pMem5-pMem4-sizeof(this->packVariedMem4) > 0)	\
		{	\
		f.serialBuffer(pMem4+sizeof(this->packVariedMem4),(uint32)(pMem5-pMem4-sizeof(this->packVariedMem4)));	\
		}	\
		f.serial(this->packVariedMem5);	\
		char* pMem6 = (char*)(&(this->packVariedMem6));	\
		gxAssert(pMem6-pMem5-sizeof(this->packVariedMem5) >= 0);	\
		if(pMem6-pMem5-sizeof(this->packVariedMem5) > 0)	\
		{	\
		f.serialBuffer(pMem5+sizeof(this->packVariedMem5),(uint32)(pMem6-pMem5-sizeof(this->packVariedMem5)));	\
		}	\
		f.serial(this->packVariedMem6);	\
		sint32 selfPackLen = sizeof(*this)-sizeof(TBaseType);	\
		gxAssert(pMyPack+selfPackLen-pMem6-sizeof(this->packVariedMem6) >= 0);	\
		if(pMyPack+selfPackLen-pMem6-sizeof(this->packVariedMem6) > 0)	\
		{	\
		f.serialBuffer(pMem6+sizeof(this->packVariedMem6), (uint32)(pMyPack+selfPackLen-pMem6-sizeof(this->packVariedMem6)));	\
		}	\
		\
		return 1;	\
	}	\
	static void Setup()		\
	{	\
	_Helper.doVoid();		\
	CGameSocketPacketHandler::RegisteUnpacketHandler(PACKET_ID, sizeof(TMyType), (TUnpacketHandler)Unpacket);		\
	}		\
	static void Unsetup()		\
	{	\
	}	\
	static bool Unpacket(TMyType* pBase, const char * buff, sint32 len)		\
	{		\
	GXMISC::CMemInputStream f;	\
	f.init(len, (char*)(buff));	\
	pBase->unserialPackHeader(f);	\
	f.serial(*pBase);	\
	return true;	\
	}

#define DPACKET_IMPL7(packVariedMem1,packVariedMem2,packVariedMem3,packVariedMem4,packVariedMem5,packVariedMem6,packVariedMem7)	\
public:	\
	TPackLen_t getPackLen()	\
	{	\
	return serialLen();	\
	}	\
	uint32 serialLen()	\
	{	\
	char* pMyPack = ((char*)this)+sizeof(TBaseType);	\
	char* pMem1 = (char*)(&(this->packVariedMem1));	\
	char* pMem2 = (char*)(&(this->packVariedMem2));	\
	char* pMem3 = (char*)(&(this->packVariedMem3));	\
	char* pMem4 = (char*)(&(this->packVariedMem4));	\
	char* pMem5 = (char*)(&(this->packVariedMem5));	\
	char* pMem6 = (char*)(&(this->packVariedMem6));	\
	char* pMem7 = (char*)(&(this->packVariedMem7));	\
	totalLen = serialPackHeaderLen()	\
	+(sint32)(pMem1-pMyPack)	\
	+GXMISC::IStream::SerialLen(packVariedMem1)	\
	+(sint32)(pMem2-pMem1-sizeof(packVariedMem1))	\
	+GXMISC::IStream::SerialLen(packVariedMem2)	\
	+(sint32)(pMem3-pMem2-sizeof(packVariedMem2))	\
	+GXMISC::IStream::SerialLen(packVariedMem3)	\
	+(sint32)(pMem4-pMem3-sizeof(packVariedMem3))	\
	+GXMISC::IStream::SerialLen(packVariedMem4)	\
	+(sint32)(pMem5-pMem4-sizeof(packVariedMem4))	\
	+GXMISC::IStream::SerialLen(packVariedMem5)	\
	+(sint32)(pMem6-pMem5-sizeof(packVariedMem5))	\
	+GXMISC::IStream::SerialLen(packVariedMem6)	\
	+(sint32)(pMem7-pMem6-sizeof(packVariedMem6))	\
	+GXMISC::IStream::SerialLen(packVariedMem7)	\
	+(sint32)((sizeof(*this)+((char*)this))-pMem7-sizeof(packVariedMem7));	\
	flag = totalLen & 0xff;	\
	return totalLen;	\
	}	\
	sint32 serial(GXMISC::IStream& f)	\
	{	\
	serialPackHeader(f);	\
	char* pMyPack = ((char*)this)+sizeof(TBaseType);	\
	char* pMem1 = (char*)(&(this->packVariedMem1));	\
	gxAssert(pMem1-pMyPack >= 0);	\
	if(pMem1-pMyPack>0)	\
		{	\
		f.serialBuffer(pMyPack,(uint32)(pMem1-pMyPack));	\
		}	\
		f.serial(this->packVariedMem1);	\
		char* pMem2 = (char*)(&(this->packVariedMem2));	\
		gxAssert(pMem2-pMem1-sizeof(this->packVariedMem1) >= 0);	\
		if(pMem2-pMem1-sizeof(this->packVariedMem1) > 0)	\
		{	\
		f.serialBuffer(pMem1+sizeof(this->packVariedMem1),(uint32)(pMem2-pMem1-sizeof(this->packVariedMem1)));	\
		}	\
		f.serial(this->packVariedMem2);	\
		char* pMem3 = (char*)(&(this->packVariedMem3));	\
		gxAssert(pMem3-pMem2-sizeof(this->packVariedMem2) >= 0);	\
		if(pMem3-pMem2-sizeof(this->packVariedMem2) > 0)	\
		{	\
		f.serialBuffer(pMem2+sizeof(this->packVariedMem2),(uint32)(pMem3-pMem2-sizeof(this->packVariedMem2)));	\
		}	\
		f.serial(this->packVariedMem3);	\
		char* pMem4 = (char*)(&(this->packVariedMem4));	\
		gxAssert(pMem4-pMem3-sizeof(this->packVariedMem3) >= 0);	\
		if(pMem4-pMem3-sizeof(this->packVariedMem3) > 0)	\
		{	\
		f.serialBuffer(pMem3+sizeof(this->packVariedMem3),(uint32)(pMem4-pMem3-sizeof(this->packVariedMem3)));	\
		}	\
		f.serial(this->packVariedMem4);	\
		char* pMem5 = (char*)(&(this->packVariedMem5));	\
		gxAssert(pMem5-pMem4-sizeof(this->packVariedMem4) >= 0);	\
		if(pMem5-pMem4-sizeof(this->packVariedMem4) > 0)	\
		{	\
		f.serialBuffer(pMem4+sizeof(this->packVariedMem4),(uint32)(pMem5-pMem4-sizeof(this->packVariedMem4)));	\
		}	\
		f.serial(this->packVariedMem5);	\
		char* pMem6 = (char*)(&(this->packVariedMem6));	\
		gxAssert(pMem6-pMem5-sizeof(this->packVariedMem5) >= 0);	\
		if(pMem6-pMem5-sizeof(this->packVariedMem5) > 0)	\
		\
	{	\
	f.serialBuffer(pMem5+sizeof(this->packVariedMem5),(uint32)(pMem6-pMem5-sizeof(this->packVariedMem5)));	\
		}	\
		f.serial(this->packVariedMem6);	\
		char* pMem7 = (char*)(&(this->packVariedMem7));	\
		gxAssert(pMem7-pMem6-sizeof(this->packVariedMem6) >= 0);	\
		if(pMem7-pMem6-sizeof(this->packVariedMem6) > 0)	\
		{	\
		f.serialBuffer(pMem6+sizeof(this->packVariedMem6),(uint32)(pMem7-pMem6-sizeof(this->packVariedMem6)));	\
		}	\
		f.serial(this->packVariedMem7);	\
		sint32 selfPackLen = sizeof(*this)-sizeof(TBaseType);	\
		gxAssert(pMyPack+selfPackLen-pMem7-sizeof(this->packVariedMem7) >= 0);	\
		if(pMyPack+selfPackLen-pMem7-sizeof(this->packVariedMem7) > 0)	\
		{	\
		f.serialBuffer(pMem7+sizeof(this->packVariedMem7), (uint32)(pMyPack+selfPackLen-pMem7-sizeof(this->packVariedMem7)));	\
		}	\
		return 1;	\
	}	\
	sint32 unSerial(GXMISC::IUnStream& f)	\
	{	\
	char* pMyPack = ((char*)this)+sizeof(TBaseType);	\
	char* pMem1 = (char*)(&(this->packVariedMem1));	\
	gxAssert(pMem1-pMyPack >= 0);	\
	if(pMem1-pMyPack>0)	\
		{	\
		f.serialBuffer(pMyPack,(uint32)(pMem1-pMyPack));	\
		}	\
		f.serial(this->packVariedMem1);	\
		char* pMem2 = (char*)(&(this->packVariedMem2));	\
		gxAssert(pMem2-pMem1-sizeof(this->packVariedMem1) >= 0);	\
		if(pMem2-pMem1-sizeof(this->packVariedMem1) > 0)	\
		{	\
		f.serialBuffer(pMem1+sizeof(this->packVariedMem1),(uint32)(pMem2-pMem1-sizeof(this->packVariedMem1)));	\
		}	\
		f.serial(this->packVariedMem2);	\
		char* pMem3 = (char*)(&(this->packVariedMem3));	\
		gxAssert(pMem3-pMem2-sizeof(this->packVariedMem2) >= 0);	\
		if(pMem3-pMem2-sizeof(this->packVariedMem2) > 0)	\
		{	\
		f.serialBuffer(pMem2+sizeof(this->packVariedMem2),(uint32)(pMem3-pMem2-sizeof(this->packVariedMem2)));	\
		}	\
		f.serial(this->packVariedMem3);	\
		char* pMem4 = (char*)(&(this->packVariedMem4));	\
		gxAssert(pMem4-pMem3-sizeof(this->packVariedMem3) >= 0);	\
		if(pMem4-pMem3-sizeof(this->packVariedMem3) > 0)	\
		{	\
		f.serialBuffer(pMem3+sizeof(this->packVariedMem3),(uint32)(pMem4-pMem3-sizeof(this->packVariedMem3)));	\
		}	\
		f.serial(this->packVariedMem4);	\
		char* pMem5 = (char*)(&(this->packVariedMem5));	\
		gxAssert(pMem5-pMem4-sizeof(this->packVariedMem4) >= 0);	\
		if(pMem5-pMem4-sizeof(this->packVariedMem4) > 0)	\
		{	\
		f.serialBuffer(pMem4+sizeof(this->packVariedMem4),(uint32)(pMem5-pMem4-sizeof(this->packVariedMem4)));	\
		}	\
		f.serial(this->packVariedMem5);	\
		char* pMem6 = (char*)(&(this->packVariedMem6));	\
		gxAssert(pMem6-pMem5-sizeof(this->packVariedMem5) >= 0);	\
		if(pMem6-pMem5-sizeof(this->packVariedMem5) > 0)	\
		{	\
		f.serialBuffer(pMem5+sizeof(this->packVariedMem5),(uint32)(pMem6-pMem5-sizeof(this->packVariedMem5)));	\
		}	\
		f.serial(this->packVariedMem6);	\
		char* pMem7 = (char*)(&(this->packVariedMem7));	\
		gxAssert(pMem7-pMem6-sizeof(this->packVariedMem6) >= 0);	\
		if(pMem7-pMem6-sizeof(this->packVariedMem6) > 0)	\
		{	\
		f.serialBuffer(pMem6+sizeof(this->packVariedMem6),(uint32)(pMem7-pMem6-sizeof(this->packVariedMem6)));	\
		}	\
		f.serial(this->packVariedMem7);	\
		sint32 selfPackLen = sizeof(*this)-sizeof(TBaseType);	\
		gxAssert(pMyPack+selfPackLen-pMem7-sizeof(this->packVariedMem7) >= 0);	\
		if(pMyPack+selfPackLen-pMem7-sizeof(this->packVariedMem7) > 0)	\
		{	\
		f.serialBuffer(pMem7+sizeof(this->packVariedMem7), (uint32)(pMyPack+selfPackLen-pMem7-sizeof(this->packVariedMem7)));	\
		}	\
		return 1;	\
	}	\
	static void Setup()		\
	{	\
	_Helper.doVoid();		\
	CGameSocketPacketHandler::RegisteUnpacketHandler(PACKET_ID, sizeof(TMyType), (TUnpacketHandler)Unpacket);		\
	}		\
	static void Unsetup()		\
	{	\
	}	\
	static bool Unpacket(TMyType* pBase, const char * buff, sint32 len)		\
	{		\
	GXMISC::CMemInputStream f;	\
	f.init(len, (char*)(buff));	\
	pBase->unserialPackHeader(f);	\
	f.serial(*pBase);	\
	return true;	\
	}

#define DPACKET_IMPL8(packVariedMem1,packVariedMem2,packVariedMem3,packVariedMem4,packVariedMem5,packVariedMem6,packVariedMem7,packVariedMem8)	\
public:	\
	TPackLen_t getPackLen()	\
	{	\
	return serialLen();	\
	}	\
	uint32 serialLen()	\
	{	\
	char* pMyPack = ((char*)this)+sizeof(TBaseType);	\
	char* pMem1 = (char*)(&(this->packVariedMem1));	\
	char* pMem2 = (char*)(&(this->packVariedMem2));	\
	char* pMem3 = (char*)(&(this->packVariedMem3));	\
	char* pMem4 = (char*)(&(this->packVariedMem4));	\
	char* pMem5 = (char*)(&(this->packVariedMem5));	\
	char* pMem6 = (char*)(&(this->packVariedMem6));	\
	char* pMem7 = (char*)(&(this->packVariedMem7));	\
	char* pMem8 = (char*)(&(this->packVariedMem8));	\
	totalLen = serialPackHeaderLen()	\
	+(sint32)(pMem1-pMyPack)	\
	+GXMISC::IStream::SerialLen(packVariedMem1)	\
	+(sint32)(pMem2-pMem1-sizeof(packVariedMem1))	\
	+GXMISC::IStream::SerialLen(packVariedMem2)	\
	+(sint32)(pMem3-pMem2-sizeof(packVariedMem2))	\
	+GXMISC::IStream::SerialLen(packVariedMem3)	\
	+(sint32)(pMem4-pMem3-sizeof(packVariedMem3))	\
	+GXMISC::IStream::SerialLen(packVariedMem4)	\
	+(sint32)(pMem5-pMem4-sizeof(packVariedMem4))	\
	+GXMISC::IStream::SerialLen(packVariedMem5)	\
	+(sint32)(pMem6-pMem5-sizeof(packVariedMem5))	\
	+GXMISC::IStream::SerialLen(packVariedMem6)	\
	+(sint32)(pMem7-pMem6-sizeof(packVariedMem6))	\
	+GXMISC::IStream::SerialLen(packVariedMem7)	\
	+(sint32)(pMem8-pMem7-sizeof(packVariedMem7))	\
	+GXMISC::IStream::SerialLen(packVariedMem8)	\
	+(sint32)((sizeof(*this)+((char*)this))-pMem8-sizeof(packVariedMem8));	\
	flag = totalLen & 0xff;	\
	return totalLen;	\
	}	\
	sint32 serial(GXMISC::IStream& f)	\
	{	\
	serialPackHeader(f);	\
	char* pMyPack = ((char*)this)+sizeof(TBaseType);	\
	char* pMem1 = (char*)(&(this->packVariedMem1));	\
	gxAssert(pMem1-pMyPack >= 0);	\
	if(pMem1-pMyPack>0)	\
	{	\
	f.serialBuffer(pMyPack,(uint32)(pMem1-pMyPack));	\
}	\
	f.serial(this->packVariedMem1);	\
	char* pMem2 = (char*)(&(this->packVariedMem2));	\
	gxAssert(pMem2-pMem1-sizeof(this->packVariedMem1) >= 0);	\
	if(pMem2-pMem1-sizeof(this->packVariedMem1) > 0)	\
		{	\
		f.serialBuffer(pMem1+sizeof(this->packVariedMem1),(uint32)(pMem2-pMem1-sizeof(this->packVariedMem1)));	\
		}	\
		f.serial(this->packVariedMem2);	\
		char* pMem3 = (char*)(&(this->packVariedMem3));	\
		gxAssert(pMem3-pMem2-sizeof(this->packVariedMem2) >= 0);	\
		if(pMem3-pMem2-sizeof(this->packVariedMem2) > 0)	\
		{	\
		f.serialBuffer(pMem2+sizeof(this->packVariedMem2),(uint32)(pMem3-pMem2-sizeof(this->packVariedMem2)));	\
		}	\
		f.serial(this->packVariedMem3);	\
		char* pMem4 = (char*)(&(this->packVariedMem4));	\
		gxAssert(pMem4-pMem3-sizeof(this->packVariedMem3) >= 0);	\
		if(pMem4-pMem3-sizeof(this->packVariedMem3) > 0)	\
		{	\
		f.serialBuffer(pMem3+sizeof(this->packVariedMem3),(uint32)(pMem4-pMem3-sizeof(this->packVariedMem3)));	\
		}	\
		f.serial(this->packVariedMem4);	\
		char* pMem5 = (char*)(&(this->packVariedMem5));	\
		gxAssert(pMem5-pMem4-sizeof(this->packVariedMem4) >= 0);	\
		if(pMem5-pMem4-sizeof(this->packVariedMem4) > 0)	\
		{	\
		f.serialBuffer(pMem4+sizeof(this->packVariedMem4),(uint32)(pMem5-pMem4-sizeof(this->packVariedMem4)));	\
		}	\
		f.serial(this->packVariedMem5);	\
		char* pMem6 = (char*)(&(this->packVariedMem6));	\
		gxAssert(pMem6-pMem5-sizeof(this->packVariedMem5) >= 0);	\
		if(pMem6-pMem5-sizeof(this->packVariedMem5) > 0)	\
		{	\
		f.serialBuffer(pMem5+sizeof(this->packVariedMem5),(uint32)(pMem6-pMem5-sizeof(this->packVariedMem5)));	\
		}	\
		f.serial(this->packVariedMem6);	\
		char* pMem7 = (char*)(&(this->packVariedMem7));	\
		gxAssert(pMem7-pMem6-sizeof(this->packVariedMem6) >= 0);	\
		if(pMem7-pMem6-sizeof(this->packVariedMem6) > 0)	\
		{	\
		f.serialBuffer(pMem6+sizeof(this->packVariedMem6),(uint32)(pMem7-pMem6-sizeof(this->packVariedMem6)));	\
		}	\
		f.serial(this->packVariedMem7);	\
		char* pMem8 = (char*)(&(this->packVariedMem8));	\
		gxAssert(pMem8-pMem7-sizeof(this->packVariedMem7) >= 0);	\
		if(pMem8-pMem7-sizeof(this->packVariedMem7) > 0)	\
		{	\
		f.serialBuffer(pMem7+sizeof(this->packVariedMem7),(uint32)(pMem8-pMem7-sizeof(this->packVariedMem7)));	\
		\
}	\
	f.serial(this->packVariedMem8);	\
	sint32 selfPackLen = sizeof(*this)-sizeof(TBaseType);	\
	gxAssert(pMyPack+selfPackLen-pMem8-sizeof(this->packVariedMem8) >= 0);	\
	if(pMyPack+selfPackLen-pMem8-sizeof(this->packVariedMem8) > 0)	\
		{	\
		f.serialBuffer(pMem8+sizeof(this->packVariedMem8), (uint32)(pMyPack+selfPackLen-pMem8-sizeof(this->packVariedMem8)));	\
		}	\
		return 1;	\
	}	\
	sint32 unSerial(GXMISC::IUnStream& f)	\
	{	\
	char* pMyPack = ((char*)this)+sizeof(TBaseType);	\
	char* pMem1 = (char*)(&(this->packVariedMem1));	\
	gxAssert(pMem1-pMyPack >= 0);	\
	if(pMem1-pMyPack>0)	\
		{	\
		f.serialBuffer(pMyPack,(uint32)(pMem1-pMyPack));	\
		}	\
		f.serial(this->packVariedMem1);	\
		char* pMem2 = (char*)(&(this->packVariedMem2));	\
		gxAssert(pMem2-pMem1-sizeof(this->packVariedMem1) >= 0);	\
		if(pMem2-pMem1-sizeof(this->packVariedMem1) > 0)	\
		{	\
		f.serialBuffer(pMem1+sizeof(this->packVariedMem1),(uint32)(pMem2-pMem1-sizeof(this->packVariedMem1)));	\
		}	\
		f.serial(this->packVariedMem2);	\
		char* pMem3 = (char*)(&(this->packVariedMem3));	\
		\
		gxAssert(pMem3-pMem2-sizeof(this->packVariedMem2) >= 0);	\
		if(pMem3-pMem2-sizeof(this->packVariedMem2) > 0)	\
		{	\
		f.serialBuffer(pMem2+sizeof(this->packVariedMem2),(uint32)(pMem3-pMem2-sizeof(this->packVariedMem2)));	\
		}	\
		f.serial(this->packVariedMem3);	\
		char* pMem4 = (char*)(&(this->packVariedMem4));	\
		gxAssert(pMem4-pMem3-sizeof(this->packVariedMem3) >= 0);	\
		if(pMem4-pMem3-sizeof(this->packVariedMem3) > 0)	\
		{	\
		f.serialBuffer(pMem3+sizeof(this->packVariedMem3),(uint32)(pMem4-pMem3-sizeof(this->packVariedMem3)));	\
		}	\
		f.serial(this->packVariedMem4);	\
		char* pMem5 = (char*)(&(this->packVariedMem5));	\
		gxAssert(pMem5-pMem4-sizeof(this->packVariedMem4) >= 0);	\
		if(pMem5-pMem4-sizeof(this->packVariedMem4) > 0)	\
		{	\
		f.serialBuffer(pMem4+sizeof(this->packVariedMem4),(uint32)(pMem5-pMem4-sizeof(this->packVariedMem4)));	\
		}	\
		f.serial(this->packVariedMem5);	\
		char* pMem6 = (char*)(&(this->packVariedMem6));	\
		gxAssert(pMem6-pMem5-sizeof(this->packVariedMem5) >= 0);	\
		if(pMem6-pMem5-sizeof(this->packVariedMem5) > 0)	\
		{	\
		f.serialBuffer(pMem5+sizeof(this->packVariedMem5),(uint32)(pMem6-pMem5-sizeof(this->packVariedMem5)));	\
		}	\
		f.serial(this->packVariedMem6);	\
		char* pMem7 = (char*)(&(this->packVariedMem7));	\
		gxAssert(pMem7-pMem6-sizeof(this->packVariedMem6) >= 0);	\
		if(pMem7-pMem6-sizeof(this->packVariedMem6) > 0)	\
		{	\
		f.serialBuffer(pMem6+sizeof(this->packVariedMem6),(uint32)(pMem7-pMem6-sizeof(this->packVariedMem6)));	\
		}	\
		f.serial(this->packVariedMem7);	\
		char* pMem8 = (char*)(&(this->packVariedMem8));	\
		gxAssert(pMem8-pMem7-sizeof(this->packVariedMem7) >= 0);	\
		if(pMem8-pMem7-sizeof(this->packVariedMem7) > 0)	\
		{	\
		f.serialBuffer(pMem7+sizeof(this->packVariedMem7),(uint32)(pMem8-pMem7-sizeof(this->packVariedMem7)));	\
		}	\
		f.serial(this->packVariedMem8);	\
		sint32 selfPackLen = sizeof(*this)-sizeof(TBaseType);	\
		gxAssert(pMyPack+selfPackLen-pMem8-sizeof(this->packVariedMem8) >= 0);	\
		if(pMyPack+selfPackLen-pMem8-sizeof(this->packVariedMem8) > 0)	\
		{	\
		f.serialBuffer(pMem8+sizeof(this->packVariedMem8), (uint32)(pMyPack+selfPackLen-pMem8-sizeof(this->packVariedMem8)));	\
		}	\
		return 1;	\
	}	\
	static void Setup()		\
	{	\
	_Helper.doVoid();		\
	CGameSocketPacketHandler::RegisteUnpacketHandler(PACKET_ID, sizeof(TMyType), (TUnpacketHandler)Unpacket);		\
	}		\
	static void Unsetup()		\
	{	\
	}	\
	static bool Unpacket(TMyType* pBase, const char * buff, sint32 len)		\
	{		\
	GXMISC::CMemInputStream f;	\
	f.init(len, (char*)(buff));	\
	pBase->unserialPackHeader(f);	\
	f.serial(*pBase);	\
	return true;	\
	}

#define DPACKET_IMPL9(packVariedMem1,packVariedMem2,packVariedMem3,packVariedMem4,packVariedMem5,packVariedMem6,packVariedMem7,packVariedMem8,packVariedMem9)		\
public:	\
	TPackLen_t getPackLen()	\
	{	\
	return serialLen();	\
	}	\
	uint32 serialLen()	\
	{	\
	char* pMyPack = ((char*)this)+sizeof(TBaseType);	\
	char* pMem1 = (char*)(&(this->packVariedMem1));	\
	char* pMem2 = (char*)(&(this->packVariedMem2));	\
	char* pMem3 = (char*)(&(this->packVariedMem3));	\
	char* pMem4 = (char*)(&(this->packVariedMem4));	\
	char* pMem5 = (char*)(&(this->packVariedMem5));	\
	char* pMem6 = (char*)(&(this->packVariedMem6));	\
	char* pMem7 = (char*)(&(this->packVariedMem7));	\
	char* pMem8 = (char*)(&(this->packVariedMem8));	\
	char* pMem9 = (char*)(&(this->packVariedMem9));	\
	totalLen = serialPackHeaderLen()	\
	+(sint32)(pMem1-pMyPack)	\
	+GXMISC::IStream::SerialLen(packVariedMem1)	\
	+(sint32)(pMem2-pMem1-sizeof(packVariedMem1))	\
	+GXMISC::IStream::SerialLen(packVariedMem2)	\
	+(sint32)(pMem3-pMem2-sizeof(packVariedMem2))	\
	+GXMISC::IStream::SerialLen(packVariedMem3)	\
	+(sint32)(pMem4-pMem3-sizeof(packVariedMem3))	\
	+GXMISC::IStream::SerialLen(packVariedMem4)	\
	+(sint32)(pMem5-pMem4-sizeof(packVariedMem4))	\
	+GXMISC::IStream::SerialLen(packVariedMem5)	\
	+(sint32)(pMem6-pMem5-sizeof(packVariedMem5))	\
	+GXMISC::IStream::SerialLen(packVariedMem6)	\
	+(sint32)(pMem7-pMem6-sizeof(packVariedMem6))	\
	+GXMISC::IStream::SerialLen(packVariedMem7)	\
	+(sint32)(pMem8-pMem7-sizeof(packVariedMem7))	\
	+GXMISC::IStream::SerialLen(packVariedMem8)	\
	+(sint32)(pMem9-pMem8-sizeof(packVariedMem8))	\
	+GXMISC::IStream::SerialLen(packVariedMem9)	\
	+(sint32)((sizeof(*this)+((char*)this))-pMem9-sizeof(packVariedMem9));	\
	flag = totalLen & 0xff;	\
	return totalLen;	\
	}	\
	\
	sint32 serial(GXMISC::IStream& f)	\
	{	\
	serialPackHeader(f);	\
	char* pMyPack = ((char*)this)+sizeof(TBaseType);	\
	char* pMem1 = (char*)(&(this->packVariedMem1));	\
	gxAssert(pMem1-pMyPack >= 0);	\
	if(pMem1-pMyPack>0)	\
		{	\
		f.serialBuffer(pMyPack,(uint32)(pMem1-pMyPack));	\
		}	\
		f.serial(this->packVariedMem1);	\
		char* pMem2 = (char*)(&(this->packVariedMem2));	\
		gxAssert(pMem2-pMem1-sizeof(this->packVariedMem1) >= 0);	\
		if(pMem2-pMem1-sizeof(this->packVariedMem1) > 0)	\
		{	\
		f.serialBuffer(pMem1+sizeof(this->packVariedMem1),(uint32)(pMem2-pMem1-sizeof(this->packVariedMem1)));	\
		}	\
		f.serial(this->packVariedMem2);	\
		char* pMem3 = (char*)(&(this->packVariedMem3));	\
		gxAssert(pMem3-pMem2-sizeof(this->packVariedMem2) >= 0);	\
		if(pMem3-pMem2-sizeof(this->packVariedMem2) > 0)	\
		{	\
		f.serialBuffer(pMem2+sizeof(this->packVariedMem2),(uint32)(pMem3-pMem2-sizeof(this->packVariedMem2)));	\
		}	\
		f.serial(this->packVariedMem3);	\
		char* pMem4 = (char*)(&(this->packVariedMem4));	\
		gxAssert(pMem4-pMem3-sizeof(this->packVariedMem3) >= 0);	\
		if(pMem4-pMem3-sizeof(this->packVariedMem3) > 0)	\
		{	\
		f.serialBuffer(pMem3+sizeof(this->packVariedMem3),(uint32)(pMem4-pMem3-sizeof(this->packVariedMem3)));	\
		}	\
		f.serial(this->packVariedMem4);	\
		char* pMem5 = (char*)(&(this->packVariedMem5));	\
		gxAssert(pMem5-pMem4-sizeof(this->packVariedMem4) >= 0);	\
		if(pMem5-pMem4-sizeof(this->packVariedMem4) > 0)	\
		{	\
		f.serialBuffer(pMem4+sizeof(this->packVariedMem4),(uint32)(pMem5-pMem4-sizeof(this->packVariedMem4)));	\
		}	\
		f.serial(this->packVariedMem5);	\
		char* pMem6 = (char*)(&(this->packVariedMem6));	\
		gxAssert(pMem6-pMem5-sizeof(this->packVariedMem5) >= 0);	\
		if(pMem6-pMem5-sizeof(this->packVariedMem5) > 0)	\
		{	\
		f.serialBuffer(pMem5+sizeof(this->packVariedMem5),(uint32)(pMem6-pMem5-sizeof(this->packVariedMem5)));	\
		}	\
		f.serial(this->packVariedMem6);	\
		char* pMem7 = (char*)(&(this->packVariedMem7));	\
		gxAssert(pMem7-pMem6-sizeof(this->packVariedMem6) >= 0);	\
		if(pMem7-pMem6-sizeof(this->packVariedMem6) > 0)	\
		{	\
		f.serialBuffer(pMem6+sizeof(this->packVariedMem6),(uint32)(pMem7-pMem6-sizeof(this->packVariedMem6)));	\
		}	\
		f.serial(this->packVariedMem7);	\
		char* pMem8 = (char*)(&(this->packVariedMem8));	\
		gxAssert(pMem8-pMem7-sizeof(this->packVariedMem7) >= 0);	\
		if(pMem8-pMem7-sizeof(this->packVariedMem7) > 0)	\
		{	\
		f.serialBuffer(pMem7+sizeof(this->packVariedMem7),(uint32)(pMem8-pMem7-sizeof(this->packVariedMem7)));	\
		}	\
		f.serial(this->packVariedMem8);	\
		char* pMem9 = (char*)(&(this->packVariedMem9));	\
		gxAssert(pMem9-pMem8-sizeof(this->packVariedMem8) >= 0);	\
		if(pMem9-pMem8-sizeof(this->packVariedMem8) > 0)	\
		{	\
		f.serialBuffer(pMem8+sizeof(this->packVariedMem8),(uint32)(pMem9-pMem8-sizeof(this->packVariedMem8)));	\
		}	\
		f.serial(this->packVariedMem9);	\
		sint32 selfPackLen = sizeof(*this)-sizeof(TBaseType);	\
		gxAssert(pMyPack+selfPackLen-pMem9-sizeof(this->packVariedMem9) >= 0);	\
		if(pMyPack+selfPackLen-pMem9-sizeof(this->packVariedMem9) > 0)	\
		{	\
		f.serialBuffer(pMem9+sizeof(this->packVariedMem9), (uint32)(pMyPack+selfPackLen-pMem9-sizeof(this->packVariedMem9)));	\
		}	\
		return 1;	\
	}	\
	sint32 unSerial(GXMISC::IUnStream& f)	\
	{	\
	\
	char* pMyPack = ((char*)this)+sizeof(TBaseType);	\
	char* pMem1 = (char*)(&(this->packVariedMem1));	\
	gxAssert(pMem1-pMyPack >= 0);	\
	if(pMem1-pMyPack>0)	\
		{	\
		f.serialBuffer(pMyPack,(uint32)(pMem1-pMyPack));	\
		}	\
		f.serial(this->packVariedMem1);	\
		char* pMem2 = (char*)(&(this->packVariedMem2));	\
		gxAssert(pMem2-pMem1-sizeof(this->packVariedMem1) >= 0);	\
		if(pMem2-pMem1-sizeof(this->packVariedMem1) > 0)	\
		{	\
		f.serialBuffer(pMem1+sizeof(this->packVariedMem1),(uint32)(pMem2-pMem1-sizeof(this->packVariedMem1)));	\
		}	\
		f.serial(this->packVariedMem2);	\
		char* pMem3 = (char*)(&(this->packVariedMem3));	\
		gxAssert(pMem3-pMem2-sizeof(this->packVariedMem2) >= 0);	\
		if(pMem3-pMem2-sizeof(this->packVariedMem2) > 0)	\
		{	\
		f.serialBuffer(pMem2+sizeof(this->packVariedMem2),(uint32)(pMem3-pMem2-sizeof(this->packVariedMem2)));	\
		}	\
		f.serial(this->packVariedMem3);	\
		char* pMem4 = (char*)(&(this->packVariedMem4));	\
		gxAssert(pMem4-pMem3-sizeof(this->packVariedMem3) >= 0);	\
		if(pMem4-pMem3-sizeof(this->packVariedMem3) > 0)	\
		{	\
		f.serialBuffer(pMem3+sizeof(this->packVariedMem3),(uint32)(pMem4-pMem3-sizeof(this->packVariedMem3)));	\
		\
	}	\
	f.serial(this->packVariedMem4);	\
	char* pMem5 = (char*)(&(this->packVariedMem5));	\
	gxAssert(pMem5-pMem4-sizeof(this->packVariedMem4) >= 0);	\
	if(pMem5-pMem4-sizeof(this->packVariedMem4) > 0)	\
		{	\
		f.serialBuffer(pMem4+sizeof(this->packVariedMem4),(uint32)(pMem5-pMem4-sizeof(this->packVariedMem4)));	\
		}	\
		f.serial(this->packVariedMem5);	\
		char* pMem6 = (char*)(&(this->packVariedMem6));	\
		gxAssert(pMem6-pMem5-sizeof(this->packVariedMem5) >= 0);	\
		if(pMem6-pMem5-sizeof(this->packVariedMem5) > 0)	\
		{	\
		f.serialBuffer(pMem5+sizeof(this->packVariedMem5),(uint32)(pMem6-pMem5-sizeof(this->packVariedMem5)));	\
		}	\
		f.serial(this->packVariedMem6);	\
		char* pMem7 = (char*)(&(this->packVariedMem7));	\
		gxAssert(pMem7-pMem6-sizeof(this->packVariedMem6) >= 0);	\
		if(pMem7-pMem6-sizeof(this->packVariedMem6) > 0)	\
		{	\
		f.serialBuffer(pMem6+sizeof(this->packVariedMem6),(uint32)(pMem7-pMem6-sizeof(this->packVariedMem6)));	\
		}	\
		f.serial(this->packVariedMem7);	\
		char* pMem8 = (char*)(&(this->packVariedMem8));	\
		gxAssert(pMem8-pMem7-sizeof(this->packVariedMem7) >= 0);	\
		if(pMem8-pMem7-sizeof(this->packVariedMem7) > 0)	\
		{	\
		f.serialBuffer(pMem7+sizeof(this->packVariedMem7),(uint32)(pMem8-pMem7-sizeof(this->packVariedMem7)));	\
		}	\
		\
		f.serial(this->packVariedMem8);	\
		char* pMem9 = (char*)(&(this->packVariedMem9));	\
		gxAssert(pMem9-pMem8-sizeof(this->packVariedMem8) >= 0);	\
		if(pMem9-pMem8-sizeof(this->packVariedMem8) > 0)	\
		{	\
		f.serialBuffer(pMem8+sizeof(this->packVariedMem8),(uint32)(pMem9-pMem8-sizeof(this->packVariedMem8)));	\
		}	\
		f.serial(this->packVariedMem9);	\
		sint32 selfPackLen = sizeof(*this)-sizeof(TBaseType);	\
		gxAssert(pMyPack+selfPackLen-pMem9-sizeof(this->packVariedMem9) >= 0);	\
		if(pMyPack+selfPackLen-pMem9-sizeof(this->packVariedMem9) > 0)	\
		{	\
		f.serialBuffer(pMem9+sizeof(this->packVariedMem9), (uint32)(pMyPack+selfPackLen-pMem9-sizeof(this->packVariedMem9)));	\
		}	\
		return 1;	\
	}	\
	static void Setup()		\
	{	\
	_Helper.doVoid();		\
	CGameSocketPacketHandler::RegisteUnpacketHandler(PACKET_ID, sizeof(TMyType), (TUnpacketHandler)Unpacket);		\
	}		\
	static void Unsetup()		\
	{	\
	}	\
	static bool Unpacket(TMyType* pBase, const char * buff, sint32 len)		\
	{		\
	GXMISC::CMemInputStream f;	\
	f.init(len, (char*)(buff));	\
	pBase->unserialPackHeader(f);	\
	f.serial(*pBase);	\
	return true;	\
	}

#define DPACKET_IMPL10(packVariedMem1,packVariedMem2,packVariedMem3,packVariedMem4,packVariedMem5,packVariedMem6,packVariedMem7,packVariedMem8,packVariedMem9,packVariedMem10)		\
public:	\
	TPackLen_t getPackLen()	\
	{	\
	return serialLen();	\
	}	\
	uint32 serialLen()	\
	{	\
	char* pMyPack = ((char*)this)+sizeof(TBaseType);	\
	char* pMem1 = (char*)(&(this->packVariedMem1));	\
	char* pMem2 = (char*)(&(this->packVariedMem2));	\
	char* pMem3 = (char*)(&(this->packVariedMem3));	\
	char* pMem4 = (char*)(&(this->packVariedMem4));	\
	char* pMem5 = (char*)(&(this->packVariedMem5));	\
	char* pMem6 = (char*)(&(this->packVariedMem6));	\
	char* pMem7 = (char*)(&(this->packVariedMem7));	\
	char* pMem8 = (char*)(&(this->packVariedMem8));	\
	char* pMem9 = (char*)(&(this->packVariedMem9));	\
	char* pMem10 = (char*)(&(this->packVariedMem10));	\
	totalLen = serialPackHeaderLen()	\
	+(sint32)(pMem1-pMyPack)	\
	+GXMISC::IStream::SerialLen(packVariedMem1)	\
	+(sint32)(pMem2-pMem1-sizeof(packVariedMem1))	\
	+GXMISC::IStream::SerialLen(packVariedMem2)	\
	+(sint32)(pMem3-pMem2-sizeof(packVariedMem2))	\
	+GXMISC::IStream::SerialLen(packVariedMem3)	\
	+(sint32)(pMem4-pMem3-sizeof(packVariedMem3))	\
	+GXMISC::IStream::SerialLen(packVariedMem4)	\
	+(sint32)(pMem5-pMem4-sizeof(packVariedMem4))	\
	+GXMISC::IStream::SerialLen(packVariedMem5)	\
	+(sint32)(pMem6-pMem5-sizeof(packVariedMem5))	\
	+GXMISC::IStream::SerialLen(packVariedMem6)	\
	+(sint32)(pMem7-pMem6-sizeof(packVariedMem6))	\
	+GXMISC::IStream::SerialLen(packVariedMem7)	\
	+(sint32)(pMem8-pMem7-sizeof(packVariedMem7))	\
	+GXMISC::IStream::SerialLen(packVariedMem8)	\
	+(sint32)(pMem9-pMem8-sizeof(packVariedMem8))	\
	+GXMISC::IStream::SerialLen(packVariedMem9)	\
	+(sint32)(pMem10-pMem9-sizeof(packVariedMem9))	\
	+GXMISC::IStream::SerialLen(packVariedMem10)	\
	+(sint32)((sizeof(*this)+((char*)this))-pMem10-sizeof(packVariedMem10));	\
	flag = totalLen & 0xff;	\
	return totalLen;	\
	}	\
	\
	sint32 serial(GXMISC::IStream& f)	\
	{	\
	serialPackHeader(f);	\
	char* pMyPack = ((char*)this)+sizeof(TBaseType);	\
	char* pMem1 = (char*)(&(this->packVariedMem1));	\
	gxAssert(pMem1-pMyPack >= 0);	\
	if(pMem1-pMyPack>0)	\
		{	\
		f.serialBuffer(pMyPack,(uint32)(pMem1-pMyPack));	\
		}	\
		f.serial(this->packVariedMem1);	\
		char* pMem2 = (char*)(&(this->packVariedMem2));	\
		gxAssert(pMem2-pMem1-sizeof(this->packVariedMem1) >= 0);	\
		if(pMem2-pMem1-sizeof(this->packVariedMem1) > 0)	\
		{	\
		f.serialBuffer(pMem1+sizeof(this->packVariedMem1),(uint32)(pMem2-pMem1-sizeof(this->packVariedMem1)));	\
		}	\
		f.serial(this->packVariedMem2);	\
		char* pMem3 = (char*)(&(this->packVariedMem3));	\
		gxAssert(pMem3-pMem2-sizeof(this->packVariedMem2) >= 0);	\
		if(pMem3-pMem2-sizeof(this->packVariedMem2) > 0)	\
		{	\
		f.serialBuffer(pMem2+sizeof(this->packVariedMem2),(uint32)(pMem3-pMem2-sizeof(this->packVariedMem2)));	\
		}	\
		f.serial(this->packVariedMem3);	\
		char* pMem4 = (char*)(&(this->packVariedMem4));	\
		gxAssert(pMem4-pMem3-sizeof(this->packVariedMem3) >= 0);	\
		if(pMem4-pMem3-sizeof(this->packVariedMem3) > 0)	\
		{	\
		f.serialBuffer(pMem3+sizeof(this->packVariedMem3),(uint32)(pMem4-pMem3-sizeof(this->packVariedMem3)));	\
		}	\
		f.serial(this->packVariedMem4);	\
		char* pMem5 = (char*)(&(this->packVariedMem5));	\
		gxAssert(pMem5-pMem4-sizeof(this->packVariedMem4) >= 0);	\
		if(pMem5-pMem4-sizeof(this->packVariedMem4) > 0)	\
		{	\
		f.serialBuffer(pMem4+sizeof(this->packVariedMem4),(uint32)(pMem5-pMem4-sizeof(this->packVariedMem4)));	\
		}	\
		f.serial(this->packVariedMem5);	\
		char* pMem6 = (char*)(&(this->packVariedMem6));	\
		gxAssert(pMem6-pMem5-sizeof(this->packVariedMem5) >= 0);	\
		if(pMem6-pMem5-sizeof(this->packVariedMem5) > 0)	\
		{	\
		f.serialBuffer(pMem5+sizeof(this->packVariedMem5),(uint32)(pMem6-pMem5-sizeof(this->packVariedMem5)));	\
		}	\
		f.serial(this->packVariedMem6);	\
		char* pMem7 = (char*)(&(this->packVariedMem7));	\
		gxAssert(pMem7-pMem6-sizeof(this->packVariedMem6) >= 0);	\
		if(pMem7-pMem6-sizeof(this->packVariedMem6) > 0)	\
		{	\
		f.serialBuffer(pMem6+sizeof(this->packVariedMem6),(uint32)(pMem7-pMem6-sizeof(this->packVariedMem6)));	\
		}	\
		f.serial(this->packVariedMem7);	\
		char* pMem8 = (char*)(&(this->packVariedMem8));	\
		gxAssert(pMem8-pMem7-sizeof(this->packVariedMem7) >= 0);	\
		if(pMem8-pMem7-sizeof(this->packVariedMem7) > 0)	\
		{	\
		f.serialBuffer(pMem7+sizeof(this->packVariedMem7),(uint32)(pMem8-pMem7-sizeof(this->packVariedMem7)));	\
		}	\
		f.serial(this->packVariedMem8);	\
		char* pMem9 = (char*)(&(this->packVariedMem9));	\
		gxAssert(pMem9-pMem8-sizeof(this->packVariedMem8) >= 0);	\
		if(pMem9-pMem8-sizeof(this->packVariedMem8) > 0)	\
		{	\
		f.serialBuffer(pMem8+sizeof(this->packVariedMem8),(uint32)(pMem9-pMem8-sizeof(this->packVariedMem8)));	\
		}	\
		f.serial(this->packVariedMem9);	\
		char* pMem10 = (char*)(&(this->packVariedMem10));	\
		gxAssert(pMem10-pMem9-sizeof(this->packVariedMem9) >= 0);	\
		if(pMem10-pMem9-sizeof(this->packVariedMem9) > 0)	\
		{	\
		f.serialBuffer(pMem9+sizeof(this->packVariedMem9),(uint32)(pMem10-pMem9-sizeof(this->packVariedMem9)));	\
		}	\
		f.serial(this->packVariedMem10);	\
		sint32 selfPackLen = sizeof(*this)-sizeof(TBaseType);	\
		gxAssert(pMyPack+selfPackLen-pMem10-sizeof(this->packVariedMem10) >= 0);	\
		if(pMyPack+selfPackLen-pMem10-sizeof(this->packVariedMem10) > 0)	\
		{	\
		f.serialBuffer(pMem10+sizeof(this->packVariedMem10), (uint32)(pMyPack+selfPackLen-pMem10-sizeof(this->packVariedMem10)));	\
		}	\
		return 1;	\
	}	\
	sint32 unSerial(GXMISC::IUnStream& f)	\
	{	\
	\
	char* pMyPack = ((char*)this)+sizeof(TBaseType);	\
	char* pMem1 = (char*)(&(this->packVariedMem1));	\
	gxAssert(pMem1-pMyPack >= 0);	\
	if(pMem1-pMyPack>0)	\
		{	\
		f.serialBuffer(pMyPack,(uint32)(pMem1-pMyPack));	\
		}	\
		f.serial(this->packVariedMem1);	\
		char* pMem2 = (char*)(&(this->packVariedMem2));	\
		gxAssert(pMem2-pMem1-sizeof(this->packVariedMem1) >= 0);	\
		if(pMem2-pMem1-sizeof(this->packVariedMem1) > 0)	\
		{	\
		f.serialBuffer(pMem1+sizeof(this->packVariedMem1),(uint32)(pMem2-pMem1-sizeof(this->packVariedMem1)));	\
		}	\
		f.serial(this->packVariedMem2);	\
		char* pMem3 = (char*)(&(this->packVariedMem3));	\
		gxAssert(pMem3-pMem2-sizeof(this->packVariedMem2) >= 0);	\
		if(pMem3-pMem2-sizeof(this->packVariedMem2) > 0)	\
		{	\
		f.serialBuffer(pMem2+sizeof(this->packVariedMem2),(uint32)(pMem3-pMem2-sizeof(this->packVariedMem2)));	\
		}	\
		f.serial(this->packVariedMem3);	\
		char* pMem4 = (char*)(&(this->packVariedMem4));	\
		gxAssert(pMem4-pMem3-sizeof(this->packVariedMem3) >= 0);	\
		if(pMem4-pMem3-sizeof(this->packVariedMem3) > 0)	\
		{	\
		f.serialBuffer(pMem3+sizeof(this->packVariedMem3),(uint32)(pMem4-pMem3-sizeof(this->packVariedMem3)));	\
		\
	}	\
	f.serial(this->packVariedMem4);	\
	char* pMem5 = (char*)(&(this->packVariedMem5));	\
	gxAssert(pMem5-pMem4-sizeof(this->packVariedMem4) >= 0);	\
	if(pMem5-pMem4-sizeof(this->packVariedMem4) > 0)	\
		{	\
		f.serialBuffer(pMem4+sizeof(this->packVariedMem4),(uint32)(pMem5-pMem4-sizeof(this->packVariedMem4)));	\
		}	\
		f.serial(this->packVariedMem5);	\
		char* pMem6 = (char*)(&(this->packVariedMem6));	\
		gxAssert(pMem6-pMem5-sizeof(this->packVariedMem5) >= 0);	\
		if(pMem6-pMem5-sizeof(this->packVariedMem5) > 0)	\
		{	\
		f.serialBuffer(pMem5+sizeof(this->packVariedMem5),(uint32)(pMem6-pMem5-sizeof(this->packVariedMem5)));	\
		}	\
		f.serial(this->packVariedMem6);	\
		char* pMem7 = (char*)(&(this->packVariedMem7));	\
		gxAssert(pMem7-pMem6-sizeof(this->packVariedMem6) >= 0);	\
		if(pMem7-pMem6-sizeof(this->packVariedMem6) > 0)	\
		{	\
		f.serialBuffer(pMem6+sizeof(this->packVariedMem6),(uint32)(pMem7-pMem6-sizeof(this->packVariedMem6)));	\
		}	\
		f.serial(this->packVariedMem7);	\
		char* pMem8 = (char*)(&(this->packVariedMem8));	\
		gxAssert(pMem8-pMem7-sizeof(this->packVariedMem7) >= 0);	\
		if(pMem8-pMem7-sizeof(this->packVariedMem7) > 0)	\
		{	\
		f.serialBuffer(pMem7+sizeof(this->packVariedMem7),(uint32)(pMem8-pMem7-sizeof(this->packVariedMem7)));	\
		}	\
		\
		f.serial(this->packVariedMem8);	\
		char* pMem9 = (char*)(&(this->packVariedMem9));	\
		gxAssert(pMem9-pMem8-sizeof(this->packVariedMem8) >= 0);	\
		if(pMem9-pMem8-sizeof(this->packVariedMem8) > 0)	\
		{	\
		f.serialBuffer(pMem8+sizeof(this->packVariedMem8),(uint32)(pMem9-pMem8-sizeof(this->packVariedMem8)));	\
		}	\
		f.serial(this->packVariedMem9);	\
		char* pMem10 = (char*)(&(this->packVariedMem10));	\
		gxAssert(pMem10-pMem9-sizeof(this->packVariedMem9) >= 0);	\
		if(pMem10-pMem9-sizeof(this->packVariedMem9) > 0)	\
		{	\
		f.serialBuffer(pMem9+sizeof(this->packVariedMem9),(uint32)(pMem10-pMem9-sizeof(this->packVariedMem9)));	\
		}	\
		f.serial(this->packVariedMem10);	\
		sint32 selfPackLen = sizeof(*this)-sizeof(TBaseType);	\
		gxAssert(pMyPack+selfPackLen-pMem10-sizeof(this->packVariedMem10) >= 0);	\
		if(pMyPack+selfPackLen-pMem10-sizeof(this->packVariedMem10) > 0)	\
		{	\
		f.serialBuffer(pMem10+sizeof(this->packVariedMem10), (uint32)(pMyPack+selfPackLen-pMem10-sizeof(this->packVariedMem10)));	\
		}	\
		return 1;	\
	}	\
	static void Setup()		\
	{	\
	_Helper.doVoid();		\
	CGameSocketPacketHandler::RegisteUnpacketHandler(PACKET_ID, sizeof(TMyType), (TUnpacketHandler)Unpacket);		\
	}		\
	static void Unsetup()		\
	{	\
	}	\
	static bool Unpacket(TMyType* pBase, const char * buff, sint32 len)		\
	{		\
	GXMISC::CMemInputStream f;	\
	f.init(len, (char*)(buff));	\
	pBase->unserialPackHeader(f);	\
	f.serial(*pBase);	\
	return true;	\
	}

#define DPACKET_IMPL11(packVariedMem1,packVariedMem2,packVariedMem3,packVariedMem4,packVariedMem5,packVariedMem6,packVariedMem7,packVariedMem8,packVariedMem9,packVariedMem10,packVariedMem11)		\
public:	\
	TPackLen_t getPackLen()	\
	{	\
	return serialLen();	\
	}	\
	uint32 serialLen()	\
	{	\
	char* pMyPack = ((char*)this)+sizeof(TBaseType);	\
	char* pMem1 = (char*)(&(this->packVariedMem1));	\
	char* pMem2 = (char*)(&(this->packVariedMem2));	\
	char* pMem3 = (char*)(&(this->packVariedMem3));	\
	char* pMem4 = (char*)(&(this->packVariedMem4));	\
	char* pMem5 = (char*)(&(this->packVariedMem5));	\
	char* pMem6 = (char*)(&(this->packVariedMem6));	\
	char* pMem7 = (char*)(&(this->packVariedMem7));	\
	char* pMem8 = (char*)(&(this->packVariedMem8));	\
	char* pMem9 = (char*)(&(this->packVariedMem9));	\
	char* pMem10 = (char*)(&(this->packVariedMem10));	\
	char* pMem11 = (char*)(&(this->packVariedMem11));	\
	totalLen = serialPackHeaderLen()	\
	+(sint32)(pMem1-pMyPack)	\
	+GXMISC::IStream::SerialLen(packVariedMem1)	\
	+(sint32)(pMem2-pMem1-sizeof(packVariedMem1))	\
	+GXMISC::IStream::SerialLen(packVariedMem2)	\
	+(sint32)(pMem3-pMem2-sizeof(packVariedMem2))	\
	+GXMISC::IStream::SerialLen(packVariedMem3)	\
	+(sint32)(pMem4-pMem3-sizeof(packVariedMem3))	\
	+GXMISC::IStream::SerialLen(packVariedMem4)	\
	+(sint32)(pMem5-pMem4-sizeof(packVariedMem4))	\
	+GXMISC::IStream::SerialLen(packVariedMem5)	\
	+(sint32)(pMem6-pMem5-sizeof(packVariedMem5))	\
	+GXMISC::IStream::SerialLen(packVariedMem6)	\
	+(sint32)(pMem7-pMem6-sizeof(packVariedMem6))	\
	+GXMISC::IStream::SerialLen(packVariedMem7)	\
	+(sint32)(pMem8-pMem7-sizeof(packVariedMem7))	\
	+GXMISC::IStream::SerialLen(packVariedMem8)	\
	+(sint32)(pMem9-pMem8-sizeof(packVariedMem8))	\
	+GXMISC::IStream::SerialLen(packVariedMem9)	\
	+(sint32)(pMem10-pMem9-sizeof(packVariedMem9))	\
	+GXMISC::IStream::SerialLen(packVariedMem10)	\
	+(sint32)(pMem11-pMem10-sizeof(packVariedMem10))	\
	+GXMISC::IStream::SerialLen(packVariedMem11)	\
	+(sint32)((sizeof(*this)+((char*)this))-pMem11-sizeof(packVariedMem11));	\
	flag = totalLen & 0xff;	\
	return totalLen;	\
	}	\
	\
	sint32 serial(GXMISC::IStream& f)	\
	{	\
	serialPackHeader(f);	\
	char* pMyPack = ((char*)this)+sizeof(TBaseType);	\
	char* pMem1 = (char*)(&(this->packVariedMem1));	\
	gxAssert(pMem1-pMyPack >= 0);	\
	if(pMem1-pMyPack>0)	\
		{	\
		f.serialBuffer(pMyPack,(uint32)(pMem1-pMyPack));	\
		}	\
		f.serial(this->packVariedMem1);	\
		char* pMem2 = (char*)(&(this->packVariedMem2));	\
		gxAssert(pMem2-pMem1-sizeof(this->packVariedMem1) >= 0);	\
		if(pMem2-pMem1-sizeof(this->packVariedMem1) > 0)	\
		{	\
		f.serialBuffer(pMem1+sizeof(this->packVariedMem1),(uint32)(pMem2-pMem1-sizeof(this->packVariedMem1)));	\
		}	\
		f.serial(this->packVariedMem2);	\
		char* pMem3 = (char*)(&(this->packVariedMem3));	\
		gxAssert(pMem3-pMem2-sizeof(this->packVariedMem2) >= 0);	\
		if(pMem3-pMem2-sizeof(this->packVariedMem2) > 0)	\
		{	\
		f.serialBuffer(pMem2+sizeof(this->packVariedMem2),(uint32)(pMem3-pMem2-sizeof(this->packVariedMem2)));	\
		}	\
		f.serial(this->packVariedMem3);	\
		char* pMem4 = (char*)(&(this->packVariedMem4));	\
		gxAssert(pMem4-pMem3-sizeof(this->packVariedMem3) >= 0);	\
		if(pMem4-pMem3-sizeof(this->packVariedMem3) > 0)	\
		{	\
		f.serialBuffer(pMem3+sizeof(this->packVariedMem3),(uint32)(pMem4-pMem3-sizeof(this->packVariedMem3)));	\
		}	\
		f.serial(this->packVariedMem4);	\
		char* pMem5 = (char*)(&(this->packVariedMem5));	\
		gxAssert(pMem5-pMem4-sizeof(this->packVariedMem4) >= 0);	\
		if(pMem5-pMem4-sizeof(this->packVariedMem4) > 0)	\
		{	\
		f.serialBuffer(pMem4+sizeof(this->packVariedMem4),(uint32)(pMem5-pMem4-sizeof(this->packVariedMem4)));	\
		}	\
		f.serial(this->packVariedMem5);	\
		char* pMem6 = (char*)(&(this->packVariedMem6));	\
		gxAssert(pMem6-pMem5-sizeof(this->packVariedMem5) >= 0);	\
		if(pMem6-pMem5-sizeof(this->packVariedMem5) > 0)	\
		{	\
		f.serialBuffer(pMem5+sizeof(this->packVariedMem5),(uint32)(pMem6-pMem5-sizeof(this->packVariedMem5)));	\
		}	\
		f.serial(this->packVariedMem6);	\
		char* pMem7 = (char*)(&(this->packVariedMem7));	\
		gxAssert(pMem7-pMem6-sizeof(this->packVariedMem6) >= 0);	\
		if(pMem7-pMem6-sizeof(this->packVariedMem6) > 0)	\
		{	\
		f.serialBuffer(pMem6+sizeof(this->packVariedMem6),(uint32)(pMem7-pMem6-sizeof(this->packVariedMem6)));	\
		}	\
		f.serial(this->packVariedMem7);	\
		char* pMem8 = (char*)(&(this->packVariedMem8));	\
		gxAssert(pMem8-pMem7-sizeof(this->packVariedMem7) >= 0);	\
		if(pMem8-pMem7-sizeof(this->packVariedMem7) > 0)	\
		{	\
		f.serialBuffer(pMem7+sizeof(this->packVariedMem7),(uint32)(pMem8-pMem7-sizeof(this->packVariedMem7)));	\
		}	\
		f.serial(this->packVariedMem8);	\
		char* pMem9 = (char*)(&(this->packVariedMem9));	\
		gxAssert(pMem9-pMem8-sizeof(this->packVariedMem8) >= 0);	\
		if(pMem9-pMem8-sizeof(this->packVariedMem8) > 0)	\
		{	\
		f.serialBuffer(pMem8+sizeof(this->packVariedMem8),(uint32)(pMem9-pMem8-sizeof(this->packVariedMem8)));	\
		}	\
		f.serial(this->packVariedMem9);	\
		char* pMem10 = (char*)(&(this->packVariedMem10));	\
		gxAssert(pMem10-pMem9-sizeof(this->packVariedMem9) >= 0);	\
		if(pMem10-pMem9-sizeof(this->packVariedMem9) > 0)	\
		{	\
		f.serialBuffer(pMem9+sizeof(this->packVariedMem9),(uint32)(pMem10-pMem9-sizeof(this->packVariedMem9)));	\
		}	\
		f.serial(this->packVariedMem10);	\
		char* pMem11 = (char*)(&(this->packVariedMem11));	\
		gxAssert(pMem11-pMem10-sizeof(this->packVariedMem10) >= 0);	\
		if(pMem11-pMem10-sizeof(this->packVariedMem10) > 0)	\
		{	\
		f.serialBuffer(pMem10+sizeof(this->packVariedMem10),(uint32)(pMem11-pMem10-sizeof(this->packVariedMem10)));	\
		}	\
		f.serial(this->packVariedMem11);	\
		sint32 selfPackLen = sizeof(*this)-sizeof(TBaseType);	\
		gxAssert(pMyPack+selfPackLen-pMem11-sizeof(this->packVariedMem11) >= 0);	\
		if(pMyPack+selfPackLen-pMem11-sizeof(this->packVariedMem11) > 0)	\
		{	\
		f.serialBuffer(pMem11+sizeof(this->packVariedMem11), (uint32)(pMyPack+selfPackLen-pMem11-sizeof(this->packVariedMem11)));	\
		}	\
		return 1;	\
	}	\
	sint32 unSerial(GXMISC::IUnStream& f)	\
	{	\
	\
	char* pMyPack = ((char*)this)+sizeof(TBaseType);	\
	char* pMem1 = (char*)(&(this->packVariedMem1));	\
	gxAssert(pMem1-pMyPack >= 0);	\
	if(pMem1-pMyPack>0)	\
		{	\
		f.serialBuffer(pMyPack,(uint32)(pMem1-pMyPack));	\
		}	\
		f.serial(this->packVariedMem1);	\
		char* pMem2 = (char*)(&(this->packVariedMem2));	\
		gxAssert(pMem2-pMem1-sizeof(this->packVariedMem1) >= 0);	\
		if(pMem2-pMem1-sizeof(this->packVariedMem1) > 0)	\
		{	\
		f.serialBuffer(pMem1+sizeof(this->packVariedMem1),(uint32)(pMem2-pMem1-sizeof(this->packVariedMem1)));	\
		}	\
		f.serial(this->packVariedMem2);	\
		char* pMem3 = (char*)(&(this->packVariedMem3));	\
		gxAssert(pMem3-pMem2-sizeof(this->packVariedMem2) >= 0);	\
		if(pMem3-pMem2-sizeof(this->packVariedMem2) > 0)	\
		{	\
		f.serialBuffer(pMem2+sizeof(this->packVariedMem2),(uint32)(pMem3-pMem2-sizeof(this->packVariedMem2)));	\
		}	\
		f.serial(this->packVariedMem3);	\
		char* pMem4 = (char*)(&(this->packVariedMem4));	\
		gxAssert(pMem4-pMem3-sizeof(this->packVariedMem3) >= 0);	\
		if(pMem4-pMem3-sizeof(this->packVariedMem3) > 0)	\
		{	\
		f.serialBuffer(pMem3+sizeof(this->packVariedMem3),(uint32)(pMem4-pMem3-sizeof(this->packVariedMem3)));	\
		\
	}	\
	f.serial(this->packVariedMem4);	\
	char* pMem5 = (char*)(&(this->packVariedMem5));	\
	gxAssert(pMem5-pMem4-sizeof(this->packVariedMem4) >= 0);	\
	if(pMem5-pMem4-sizeof(this->packVariedMem4) > 0)	\
		{	\
		f.serialBuffer(pMem4+sizeof(this->packVariedMem4),(uint32)(pMem5-pMem4-sizeof(this->packVariedMem4)));	\
		}	\
		f.serial(this->packVariedMem5);	\
		char* pMem6 = (char*)(&(this->packVariedMem6));	\
		gxAssert(pMem6-pMem5-sizeof(this->packVariedMem5) >= 0);	\
		if(pMem6-pMem5-sizeof(this->packVariedMem5) > 0)	\
		{	\
		f.serialBuffer(pMem5+sizeof(this->packVariedMem5),(uint32)(pMem6-pMem5-sizeof(this->packVariedMem5)));	\
		}	\
		f.serial(this->packVariedMem6);	\
		char* pMem7 = (char*)(&(this->packVariedMem7));	\
		gxAssert(pMem7-pMem6-sizeof(this->packVariedMem6) >= 0);	\
		if(pMem7-pMem6-sizeof(this->packVariedMem6) > 0)	\
		{	\
		f.serialBuffer(pMem6+sizeof(this->packVariedMem6),(uint32)(pMem7-pMem6-sizeof(this->packVariedMem6)));	\
		}	\
		f.serial(this->packVariedMem7);	\
		char* pMem8 = (char*)(&(this->packVariedMem8));	\
		gxAssert(pMem8-pMem7-sizeof(this->packVariedMem7) >= 0);	\
		if(pMem8-pMem7-sizeof(this->packVariedMem7) > 0)	\
		{	\
		f.serialBuffer(pMem7+sizeof(this->packVariedMem7),(uint32)(pMem8-pMem7-sizeof(this->packVariedMem7)));	\
		}	\
		\
		f.serial(this->packVariedMem8);	\
		char* pMem9 = (char*)(&(this->packVariedMem9));	\
		gxAssert(pMem9-pMem8-sizeof(this->packVariedMem8) >= 0);	\
		if(pMem9-pMem8-sizeof(this->packVariedMem8) > 0)	\
		{	\
		f.serialBuffer(pMem8+sizeof(this->packVariedMem8),(uint32)(pMem9-pMem8-sizeof(this->packVariedMem8)));	\
		}	\
		f.serial(this->packVariedMem9);	\
		char* pMem10 = (char*)(&(this->packVariedMem10));	\
		gxAssert(pMem10-pMem9-sizeof(this->packVariedMem9) >= 0);	\
		if(pMem10-pMem9-sizeof(this->packVariedMem9) > 0)	\
		{	\
		f.serialBuffer(pMem9+sizeof(this->packVariedMem9),(uint32)(pMem10-pMem9-sizeof(this->packVariedMem9)));	\
		}	\
		f.serial(this->packVariedMem10);	\
		char* pMem11 = (char*)(&(this->packVariedMem11));	\
		gxAssert(pMem11-pMem10-sizeof(this->packVariedMem10) >= 0);	\
		if(pMem11-pMem10-sizeof(this->packVariedMem10) > 0)	\
		{	\
		f.serialBuffer(pMem10+sizeof(this->packVariedMem10),(uint32)(pMem11-pMem10-sizeof(this->packVariedMem10)));	\
		}	\
		f.serial(this->packVariedMem11);	\
		sint32 selfPackLen = sizeof(*this)-sizeof(TBaseType);	\
		gxAssert(pMyPack+selfPackLen-pMem11-sizeof(this->packVariedMem11) >= 0);	\
		if(pMyPack+selfPackLen-pMem11-sizeof(this->packVariedMem11) > 0)	\
		{	\
		f.serialBuffer(pMem11+sizeof(this->packVariedMem11), (uint32)(pMyPack+selfPackLen-pMem11-sizeof(this->packVariedMem11)));	\
		}	\
		return 1;	\
	}	\
	static void Setup()		\
	{	\
	_Helper.doVoid();		\
	CGameSocketPacketHandler::RegisteUnpacketHandler(PACKET_ID, sizeof(TMyType), (TUnpacketHandler)Unpacket);		\
	}		\
	static void Unsetup()		\
	{	\
	}	\
	static bool Unpacket(TMyType* pBase, const char * buff, sint32 len)		\
	{		\
	GXMISC::CMemInputStream f;	\
	f.init(len, (char*)(buff));	\
	pBase->unserialPackHeader(f);	\
	f.serial(*pBase);	\
	return true;	\
	}

#define DPACKET_IMPL12(packVariedMem1,packVariedMem2,packVariedMem3,packVariedMem4,packVariedMem5,packVariedMem6,packVariedMem7,packVariedMem8,packVariedMem9,packVariedMem10,packVariedMem11,packVariedMem12)		\
public:	\
	TPackLen_t getPackLen()	\
	{	\
	return serialLen();	\
	}	\
	uint32 serialLen()	\
	{	\
	char* pMyPack = ((char*)this)+sizeof(TBaseType);	\
	char* pMem1 = (char*)(&(this->packVariedMem1));	\
	char* pMem2 = (char*)(&(this->packVariedMem2));	\
	char* pMem3 = (char*)(&(this->packVariedMem3));	\
	char* pMem4 = (char*)(&(this->packVariedMem4));	\
	char* pMem5 = (char*)(&(this->packVariedMem5));	\
	char* pMem6 = (char*)(&(this->packVariedMem6));	\
	char* pMem7 = (char*)(&(this->packVariedMem7));	\
	char* pMem8 = (char*)(&(this->packVariedMem8));	\
	char* pMem9 = (char*)(&(this->packVariedMem9));	\
	char* pMem10 = (char*)(&(this->packVariedMem10));	\
	char* pMem11 = (char*)(&(this->packVariedMem11));	\
	char* pMem12 = (char*)(&(this->packVariedMem12));	\
	totalLen = serialPackHeaderLen()	\
	+(sint32)(pMem1-pMyPack)	\
	+GXMISC::IStream::SerialLen(packVariedMem1)	\
	+(sint32)(pMem2-pMem1-sizeof(packVariedMem1))	\
	+GXMISC::IStream::SerialLen(packVariedMem2)	\
	+(sint32)(pMem3-pMem2-sizeof(packVariedMem2))	\
	+GXMISC::IStream::SerialLen(packVariedMem3)	\
	+(sint32)(pMem4-pMem3-sizeof(packVariedMem3))	\
	+GXMISC::IStream::SerialLen(packVariedMem4)	\
	+(sint32)(pMem5-pMem4-sizeof(packVariedMem4))	\
	+GXMISC::IStream::SerialLen(packVariedMem5)	\
	+(sint32)(pMem6-pMem5-sizeof(packVariedMem5))	\
	+GXMISC::IStream::SerialLen(packVariedMem6)	\
	+(sint32)(pMem7-pMem6-sizeof(packVariedMem6))	\
	+GXMISC::IStream::SerialLen(packVariedMem7)	\
	+(sint32)(pMem8-pMem7-sizeof(packVariedMem7))	\
	+GXMISC::IStream::SerialLen(packVariedMem8)	\
	+(sint32)(pMem9-pMem8-sizeof(packVariedMem8))	\
	+GXMISC::IStream::SerialLen(packVariedMem9)	\
	+(sint32)(pMem10-pMem9-sizeof(packVariedMem9))	\
	+GXMISC::IStream::SerialLen(packVariedMem10)	\
	+(sint32)(pMem11-pMem10-sizeof(packVariedMem10))	\
	+GXMISC::IStream::SerialLen(packVariedMem11)	\
	+(sint32)(pMem12-pMem11-sizeof(packVariedMem11))	\
	+GXMISC::IStream::SerialLen(packVariedMem12)	\
	+(sint32)((sizeof(*this)+((char*)this))-pMem12-sizeof(packVariedMem12));	\
	flag = totalLen & 0xff;	\
	return totalLen;	\
	}	\
	\
	sint32 serial(GXMISC::IStream& f)	\
	{	\
	serialPackHeader(f);	\
	char* pMyPack = ((char*)this)+sizeof(TBaseType);	\
	char* pMem1 = (char*)(&(this->packVariedMem1));	\
	gxAssert(pMem1-pMyPack >= 0);	\
	if(pMem1-pMyPack>0)	\
		{	\
		f.serialBuffer(pMyPack,(uint32)(pMem1-pMyPack));	\
		}	\
		f.serial(this->packVariedMem1);	\
		char* pMem2 = (char*)(&(this->packVariedMem2));	\
		gxAssert(pMem2-pMem1-sizeof(this->packVariedMem1) >= 0);	\
		if(pMem2-pMem1-sizeof(this->packVariedMem1) > 0)	\
		{	\
		f.serialBuffer(pMem1+sizeof(this->packVariedMem1),(uint32)(pMem2-pMem1-sizeof(this->packVariedMem1)));	\
		}	\
		f.serial(this->packVariedMem2);	\
		char* pMem3 = (char*)(&(this->packVariedMem3));	\
		gxAssert(pMem3-pMem2-sizeof(this->packVariedMem2) >= 0);	\
		if(pMem3-pMem2-sizeof(this->packVariedMem2) > 0)	\
		{	\
		f.serialBuffer(pMem2+sizeof(this->packVariedMem2),(uint32)(pMem3-pMem2-sizeof(this->packVariedMem2)));	\
		}	\
		f.serial(this->packVariedMem3);	\
		char* pMem4 = (char*)(&(this->packVariedMem4));	\
		gxAssert(pMem4-pMem3-sizeof(this->packVariedMem3) >= 0);	\
		if(pMem4-pMem3-sizeof(this->packVariedMem3) > 0)	\
		{	\
		f.serialBuffer(pMem3+sizeof(this->packVariedMem3),(uint32)(pMem4-pMem3-sizeof(this->packVariedMem3)));	\
		}	\
		f.serial(this->packVariedMem4);	\
		char* pMem5 = (char*)(&(this->packVariedMem5));	\
		gxAssert(pMem5-pMem4-sizeof(this->packVariedMem4) >= 0);	\
		if(pMem5-pMem4-sizeof(this->packVariedMem4) > 0)	\
		{	\
		f.serialBuffer(pMem4+sizeof(this->packVariedMem4),(uint32)(pMem5-pMem4-sizeof(this->packVariedMem4)));	\
		}	\
		f.serial(this->packVariedMem5);	\
		char* pMem6 = (char*)(&(this->packVariedMem6));	\
		gxAssert(pMem6-pMem5-sizeof(this->packVariedMem5) >= 0);	\
		if(pMem6-pMem5-sizeof(this->packVariedMem5) > 0)	\
		{	\
		f.serialBuffer(pMem5+sizeof(this->packVariedMem5),(uint32)(pMem6-pMem5-sizeof(this->packVariedMem5)));	\
		}	\
		f.serial(this->packVariedMem6);	\
		char* pMem7 = (char*)(&(this->packVariedMem7));	\
		gxAssert(pMem7-pMem6-sizeof(this->packVariedMem6) >= 0);	\
		if(pMem7-pMem6-sizeof(this->packVariedMem6) > 0)	\
		{	\
		f.serialBuffer(pMem6+sizeof(this->packVariedMem6),(uint32)(pMem7-pMem6-sizeof(this->packVariedMem6)));	\
		}	\
		f.serial(this->packVariedMem7);	\
		char* pMem8 = (char*)(&(this->packVariedMem8));	\
		gxAssert(pMem8-pMem7-sizeof(this->packVariedMem7) >= 0);	\
		if(pMem8-pMem7-sizeof(this->packVariedMem7) > 0)	\
		{	\
		f.serialBuffer(pMem7+sizeof(this->packVariedMem7),(uint32)(pMem8-pMem7-sizeof(this->packVariedMem7)));	\
		}	\
		f.serial(this->packVariedMem8);	\
		char* pMem9 = (char*)(&(this->packVariedMem9));	\
		gxAssert(pMem9-pMem8-sizeof(this->packVariedMem8) >= 0);	\
		if(pMem9-pMem8-sizeof(this->packVariedMem8) > 0)	\
		{	\
		f.serialBuffer(pMem8+sizeof(this->packVariedMem8),(uint32)(pMem9-pMem8-sizeof(this->packVariedMem8)));	\
		}	\
		f.serial(this->packVariedMem9);	\
		char* pMem10 = (char*)(&(this->packVariedMem10));	\
		gxAssert(pMem10-pMem9-sizeof(this->packVariedMem9) >= 0);	\
		if(pMem10-pMem9-sizeof(this->packVariedMem9) > 0)	\
		{	\
		f.serialBuffer(pMem9+sizeof(this->packVariedMem9),(uint32)(pMem10-pMem9-sizeof(this->packVariedMem9)));	\
		}	\
		f.serial(this->packVariedMem10);	\
		char* pMem11 = (char*)(&(this->packVariedMem11));	\
		gxAssert(pMem11-pMem10-sizeof(this->packVariedMem10) >= 0);	\
		if(pMem11-pMem10-sizeof(this->packVariedMem10) > 0)	\
		{	\
		f.serialBuffer(pMem10+sizeof(this->packVariedMem10),(uint32)(pMem11-pMem10-sizeof(this->packVariedMem10)));	\
		}	\
		f.serial(this->packVariedMem11);	\
		char* pMem12 = (char*)(&(this->packVariedMem12));	\
		gxAssert(pMem12-pMem11-sizeof(this->packVariedMem11) >= 0);	\
		if(pMem12-pMem11-sizeof(this->packVariedMem11) > 0)	\
		{	\
		f.serialBuffer(pMem11+sizeof(this->packVariedMem11),(uint32)(pMem12-pMem11-sizeof(this->packVariedMem11)));	\
		}	\
		f.serial(this->packVariedMem12);	\
		sint32 selfPackLen = sizeof(*this)-sizeof(TBaseType);	\
		gxAssert(pMyPack+selfPackLen-pMem12-sizeof(this->packVariedMem12) >= 0);	\
		if(pMyPack+selfPackLen-pMem12-sizeof(this->packVariedMem12) > 0)	\
		{	\
		f.serialBuffer(pMem12+sizeof(this->packVariedMem12), (uint32)(pMyPack+selfPackLen-pMem12-sizeof(this->packVariedMem12)));	\
		}	\
		return 1;	\
	}	\
	sint32 unSerial(GXMISC::IUnStream& f)	\
	{	\
	\
	char* pMyPack = ((char*)this)+sizeof(TBaseType);	\
	char* pMem1 = (char*)(&(this->packVariedMem1));	\
	gxAssert(pMem1-pMyPack >= 0);	\
	if(pMem1-pMyPack>0)	\
		{	\
		f.serialBuffer(pMyPack,(uint32)(pMem1-pMyPack));	\
		}	\
		f.serial(this->packVariedMem1);	\
		char* pMem2 = (char*)(&(this->packVariedMem2));	\
		gxAssert(pMem2-pMem1-sizeof(this->packVariedMem1) >= 0);	\
		if(pMem2-pMem1-sizeof(this->packVariedMem1) > 0)	\
		{	\
		f.serialBuffer(pMem1+sizeof(this->packVariedMem1),(uint32)(pMem2-pMem1-sizeof(this->packVariedMem1)));	\
		}	\
		f.serial(this->packVariedMem2);	\
		char* pMem3 = (char*)(&(this->packVariedMem3));	\
		gxAssert(pMem3-pMem2-sizeof(this->packVariedMem2) >= 0);	\
		if(pMem3-pMem2-sizeof(this->packVariedMem2) > 0)	\
		{	\
		f.serialBuffer(pMem2+sizeof(this->packVariedMem2),(uint32)(pMem3-pMem2-sizeof(this->packVariedMem2)));	\
		}	\
		f.serial(this->packVariedMem3);	\
		char* pMem4 = (char*)(&(this->packVariedMem4));	\
		gxAssert(pMem4-pMem3-sizeof(this->packVariedMem3) >= 0);	\
		if(pMem4-pMem3-sizeof(this->packVariedMem3) > 0)	\
		{	\
		f.serialBuffer(pMem3+sizeof(this->packVariedMem3),(uint32)(pMem4-pMem3-sizeof(this->packVariedMem3)));	\
		\
	}	\
	f.serial(this->packVariedMem4);	\
	char* pMem5 = (char*)(&(this->packVariedMem5));	\
	gxAssert(pMem5-pMem4-sizeof(this->packVariedMem4) >= 0);	\
	if(pMem5-pMem4-sizeof(this->packVariedMem4) > 0)	\
		{	\
		f.serialBuffer(pMem4+sizeof(this->packVariedMem4),(uint32)(pMem5-pMem4-sizeof(this->packVariedMem4)));	\
		}	\
		f.serial(this->packVariedMem5);	\
		char* pMem6 = (char*)(&(this->packVariedMem6));	\
		gxAssert(pMem6-pMem5-sizeof(this->packVariedMem5) >= 0);	\
		if(pMem6-pMem5-sizeof(this->packVariedMem5) > 0)	\
		{	\
		f.serialBuffer(pMem5+sizeof(this->packVariedMem5),(uint32)(pMem6-pMem5-sizeof(this->packVariedMem5)));	\
		}	\
		f.serial(this->packVariedMem6);	\
		char* pMem7 = (char*)(&(this->packVariedMem7));	\
		gxAssert(pMem7-pMem6-sizeof(this->packVariedMem6) >= 0);	\
		if(pMem7-pMem6-sizeof(this->packVariedMem6) > 0)	\
		{	\
		f.serialBuffer(pMem6+sizeof(this->packVariedMem6),(uint32)(pMem7-pMem6-sizeof(this->packVariedMem6)));	\
		}	\
		f.serial(this->packVariedMem7);	\
		char* pMem8 = (char*)(&(this->packVariedMem8));	\
		gxAssert(pMem8-pMem7-sizeof(this->packVariedMem7) >= 0);	\
		if(pMem8-pMem7-sizeof(this->packVariedMem7) > 0)	\
		{	\
		f.serialBuffer(pMem7+sizeof(this->packVariedMem7),(uint32)(pMem8-pMem7-sizeof(this->packVariedMem7)));	\
		}	\
		\
		f.serial(this->packVariedMem8);	\
		char* pMem9 = (char*)(&(this->packVariedMem9));	\
		gxAssert(pMem9-pMem8-sizeof(this->packVariedMem8) >= 0);	\
		if(pMem9-pMem8-sizeof(this->packVariedMem8) > 0)	\
		{	\
		f.serialBuffer(pMem8+sizeof(this->packVariedMem8),(uint32)(pMem9-pMem8-sizeof(this->packVariedMem8)));	\
		}	\
		f.serial(this->packVariedMem9);	\
		char* pMem10 = (char*)(&(this->packVariedMem10));	\
		gxAssert(pMem10-pMem9-sizeof(this->packVariedMem9) >= 0);	\
		if(pMem10-pMem9-sizeof(this->packVariedMem9) > 0)	\
		{	\
		f.serialBuffer(pMem9+sizeof(this->packVariedMem9),(uint32)(pMem10-pMem9-sizeof(this->packVariedMem9)));	\
		}	\
		f.serial(this->packVariedMem10);	\
		char* pMem11 = (char*)(&(this->packVariedMem11));	\
		gxAssert(pMem11-pMem10-sizeof(this->packVariedMem10) >= 0);	\
		if(pMem11-pMem10-sizeof(this->packVariedMem10) > 0)	\
		{	\
		f.serialBuffer(pMem10+sizeof(this->packVariedMem10),(uint32)(pMem11-pMem10-sizeof(this->packVariedMem10)));	\
		}	\
		f.serial(this->packVariedMem11);	\
		char* pMem12 = (char*)(&(this->packVariedMem12));	\
		gxAssert(pMem12-pMem11-sizeof(this->packVariedMem11) >= 0);	\
		if(pMem12-pMem11-sizeof(this->packVariedMem11) > 0)	\
		{	\
		f.serialBuffer(pMem11+sizeof(this->packVariedMem11),(uint32)(pMem12-pMem11-sizeof(this->packVariedMem11)));	\
		}	\
		f.serial(this->packVariedMem12);	\
		sint32 selfPackLen = sizeof(*this)-sizeof(TBaseType);	\
		gxAssert(pMyPack+selfPackLen-pMem12-sizeof(this->packVariedMem12) >= 0);	\
		if(pMyPack+selfPackLen-pMem12-sizeof(this->packVariedMem12) > 0)	\
		{	\
		f.serialBuffer(pMem12+sizeof(this->packVariedMem12), (uint32)(pMyPack+selfPackLen-pMem12-sizeof(this->packVariedMem12)));	\
		}	\
		return 1;	\
	}	\
	static void Setup()		\
	{	\
	_Helper.doVoid();		\
	CGameSocketPacketHandler::RegisteUnpacketHandler(PACKET_ID, sizeof(TMyType), (TUnpacketHandler)Unpacket);		\
	}		\
	static void Unsetup()		\
	{	\
	}	\
	static bool Unpacket(TMyType* pBase, const char * buff, sint32 len)		\
	{		\
	GXMISC::CMemInputStream f;	\
	f.init(len, (char*)(buff));	\
	pBase->unserialPackHeader(f);	\
	f.serial(*pBase);	\
	return true;	\
	}

#endif	// _STREAMABLE_UTIL_H_