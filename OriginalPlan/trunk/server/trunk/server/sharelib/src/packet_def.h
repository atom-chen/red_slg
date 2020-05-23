#ifndef _PACKET_DEF_H_
#define _PACKET_DEF_H_

#include "core/string_common.h"
#include "core/base_util.h"

// 定义一些需要打印的变量及toString()函数, 其中变量会主动定义
#define DPacketToStringDef(PackType, VarType, Var)   \
	public:     \
	VarType Var;    \
	std::string toString() const  \
	{   \
	DStaticAssert(sizeof(VarType) == sizeof(Var));   \
	std::string fmt = GXMISC::gxToString(""#Var"=%s;", GXMISC::TFS<VarType>::FMT); \
	return GXMISC::gxToString(fmt.c_str(), Var);    \
	}

#define DPacketToString2Def(PackType, VarType, Var, VarType2, Var2)   \
	public: \
	VarType Var;    \
	VarType2 Var2;  \
	std::string toString() const  \
	{   \
	DStaticAssert(sizeof(VarType) == sizeof(Var));   \
	DStaticAssert(sizeof(VarType2) == sizeof(Var2));   \
	std::string fmt = GXMISC::gxToString(""#Var"=%s,"#Var2"=%s;", GXMISC::TFS<VarType>::FMT, GXMISC::TFS<VarType2>::FMT); \
	return GXMISC::gxToString(fmt.c_str(), Var, Var2);    \
	}

#define DPacketToString3Def(PackType, VarType, Var, VarType2, Var2, VarType3, Var3)   \
	public: \
	VarType Var;    \
	VarType2 Var2;  \
	VarType3 Var3;  \
	std::string toString() const  \
	{   \
	DStaticAssert(sizeof(VarType) == sizeof(Var));   \
	DStaticAssert(sizeof(VarType2) == sizeof(Var2));   \
	DStaticAssert(sizeof(VarType3) == sizeof(Var3));   \
	std::string fmt = GXMISC::gxToString(""#Var"=%s,"#Var2"=%s,"#Var3"=%s;", GXMISC::TFS<VarType>::FMT, GXMISC::TFS<VarType2>::FMT, GXMISC::TFS<VarType3>::FMT); \
	return GXMISC::gxToString(fmt.c_str(), Var, Var2, Var3);    \
	}

#define DPacketToString4Def(PackType, VarType, Var, VarType2, Var2, VarType3, Var3, VarType4, Var4)   \
	public: \
	VarType Var;    \
	VarType2 Var2;  \
	VarType3 Var3;  \
	VarType4 Var4;  \
	std::string toString() const  \
	{   \
	DStaticAssert(sizeof(VarType) == sizeof(Var));   \
	DStaticAssert(sizeof(VarType2) == sizeof(Var2));   \
	DStaticAssert(sizeof(VarType3) == sizeof(Var3));   \
	DStaticAssert(sizeof(VarType4) == sizeof(Var4));   \
	std::string fmt = GXMISC::gxToString(""#Var"=%s,"#Var2"=%s,"#Var3"=%s,"#Var4"=%s;", \
	GXMISC::TFS<VarType>::FMT, GXMISC::TFS<VarType2>::FMT, GXMISC::TFS<VarType3>::FMT, GXMISC::TFS<VarType4>::FMT); \
	return GXMISC::gxToString(fmt.c_str(), Var, Var2, Var3, Var4);    \
	}

#define DPacketToString5Def(PackType, VarType, Var, VarType2, Var2, VarType3, Var3, VarType4, Var4, VarType5, Var5)   \
	public: \
	VarType Var;    \
	VarType2 Var2;  \
	VarType3 Var3;  \
	VarType4 Var4;  \
	VarType5 Var5;  \
	std::string toString() const  \
	{   \
	DStaticAssert(sizeof(VarType) == sizeof(Var));   \
	DStaticAssert(sizeof(VarType2) == sizeof(Var2));   \
	DStaticAssert(sizeof(VarType3) == sizeof(Var3));   \
	DStaticAssert(sizeof(VarType4) == sizeof(Var4));   \
	DStaticAssert(sizeof(VarType5) == sizeof(Var5));   \
	std::string fmt = GXMISC::gxToString(""#Var"=%s,"#Var2"=%s,"#Var3"=%s,"#Var4"=%s,"#Var5"=%s;", \
	GXMISC::TFS<VarType>::FMT, GXMISC::TFS<VarType2>::FMT, GXMISC::TFS<VarType3>::FMT, GXMISC::TFS<VarType4>::FMT, GXMISC::TFS<VarType5>::FMT); \
	return GXMISC::gxToString(fmt.c_str(), Var, Var2, Var3, Var4, Var5);    \
	}

#define DPacketToString6Def(PackType, VarType, Var, VarType2, Var2, VarType3, Var3, VarType4, Var4, VarType5, Var5, VarType6, Var6)   \
	public: \
	VarType Var;    \
	VarType2 Var2;  \
	VarType3 Var3;  \
	VarType4 Var4;  \
	VarType5 Var5;  \
	VarType6 Var6;  \
	std::string toString() const  \
	{   \
	DStaticAssert(sizeof(VarType) == sizeof(Var));   \
	DStaticAssert(sizeof(VarType2) == sizeof(Var2));   \
	DStaticAssert(sizeof(VarType3) == sizeof(Var3));   \
	DStaticAssert(sizeof(VarType4) == sizeof(Var4));   \
	DStaticAssert(sizeof(VarType5) == sizeof(Var5));   \
	DStaticAssert(sizeof(VarType6) == sizeof(Var6));   \
	std::string fmt = GXMISC::gxToString(""#Var"=%s,"#Var2"=%s,"#Var3"=%s,"#Var4"=%s,"#Var5"=%s,"#Var6"=%s;", \
	GXMISC::TFS<VarType>::FMT, GXMISC::TFS<VarType2>::FMT, GXMISC::TFS<VarType3>::FMT, GXMISC::TFS<VarType4>::FMT, GXMISC::TFS<VarType5>::FMT, GXMISC::TFS<VarType6>::FMT); \
	return GXMISC::gxToString(fmt.c_str(), Var, Var2, Var3, Var4, Var5, Var6);    \
	}

#define DPacketToString7Def(PackType, VarType, Var, VarType2, Var2, VarType3, Var3, VarType4, Var4, VarType5, Var5, VarType6, Var6, VarType7, Var7)   \
	public: \
	VarType Var;    \
	VarType2 Var2;  \
	VarType3 Var3;  \
	VarType4 Var4;  \
	VarType5 Var5;  \
	VarType6 Var6;  \
	VarType7 Var7;  \
	std::string toString() const  \
	{   \
	DStaticAssert(sizeof(VarType) == sizeof(Var));   \
	DStaticAssert(sizeof(VarType2) == sizeof(Var2));   \
	DStaticAssert(sizeof(VarType3) == sizeof(Var3));   \
	DStaticAssert(sizeof(VarType4) == sizeof(Var4));   \
	DStaticAssert(sizeof(VarType5) == sizeof(Var5));   \
	DStaticAssert(sizeof(VarType6) == sizeof(Var6));   \
	DStaticAssert(sizeof(VarType7) == sizeof(Var7));   \
	std::string fmt = GXMISC::gxToString(""#Var"=%s,"#Var2"=%s,"#Var3"=%s,"#Var4"=%s,"#Var5"=%s,"#Var6"=%s,"#Var7"=%s;", \
	GXMISC::TFS<VarType>::FMT, GXMISC::TFS<VarType2>::FMT, GXMISC::TFS<VarType3>::FMT, GXMISC::TFS<VarType4>::FMT, GXMISC::TFS<VarType5>::FMT,  \
	GXMISC::TFS<VarType6>::FMT, GXMISC::TFS<VarType7>::FMT); \
	return GXMISC::gxToString(fmt.c_str(), Var, Var2, Var3, Var4, Var5, Var6, Var7);    \
	}

#define DPacketToString8Def(PackType, VarType, Var, VarType2, Var2, VarType3, Var3, VarType4, Var4, VarType5, Var5, VarType6, Var6, VarType7, Var7, VarType8, Var8)   \
	public: \
	VarType Var;    \
	VarType2 Var2;  \
	VarType3 Var3;  \
	VarType4 Var4;  \
	VarType5 Var5;  \
	VarType6 Var6;  \
	VarType7 Var7;  \
	VarType8 Var8;  \
	std::string toString() const  \
	{   \
	DStaticAssert(sizeof(VarType) == sizeof(Var));   \
	DStaticAssert(sizeof(VarType2) == sizeof(Var2));   \
	DStaticAssert(sizeof(VarType3) == sizeof(Var3));   \
	DStaticAssert(sizeof(VarType4) == sizeof(Var4));   \
	DStaticAssert(sizeof(VarType5) == sizeof(Var5));   \
	DStaticAssert(sizeof(VarType6) == sizeof(Var6));   \
	DStaticAssert(sizeof(VarType7) == sizeof(Var7));   \
	DStaticAssert(sizeof(VarType8) == sizeof(Var8));   \
	std::string fmt = GXMISC::gxToString(""#Var"=%s,"#Var2"=%s,"#Var3"=%s,"#Var4"=%s,"#Var5"=%s,"#Var6"=%s,"#Var7"=%s,"#Var8"=%s;", \
	GXMISC::TFS<VarType>::FMT, GXMISC::TFS<VarType2>::FMT, GXMISC::TFS<VarType3>::FMT, GXMISC::TFS<VarType4>::FMT, GXMISC::TFS<VarType5>::FMT,  \
	GXMISC::TFS<VarType6>::FMT, GXMISC::TFS<VarType7>::FMT, GXMISC::TFS<VarType8>::FMT); \
	return GXMISC::gxToString(fmt.c_str(), Var, Var2, Var3, Var4, Var5, Var6, Var7, Var8);    \
	}

#define DPacketToString9Def(PackType, VarType, Var, VarType2, Var2, VarType3, Var3, VarType4, Var4, VarType5, Var5, VarType6, Var6, VarType7, Var7, VarType8, Var8, VarType9, Var9)   \
	public: \
	VarType Var;    \
	VarType2 Var2;  \
	VarType3 Var3;  \
	VarType4 Var4;  \
	VarType5 Var5;  \
	VarType6 Var6;  \
	VarType7 Var7;  \
	VarType8 Var8;  \
	VarType9 Var9;  \
	std::string toString() const  \
	{   \
	DStaticAssert(sizeof(VarType) == sizeof(Var));   \
	DStaticAssert(sizeof(VarType2) == sizeof(Var2));   \
	DStaticAssert(sizeof(VarType3) == sizeof(Var3));   \
	DStaticAssert(sizeof(VarType4) == sizeof(Var4));   \
	DStaticAssert(sizeof(VarType5) == sizeof(Var5));   \
	DStaticAssert(sizeof(VarType6) == sizeof(Var6));   \
	DStaticAssert(sizeof(VarType7) == sizeof(Var7));   \
	DStaticAssert(sizeof(VarType8) == sizeof(Var8));   \
	DStaticAssert(sizeof(VarType9) == sizeof(Var9));   \
	std::string fmt = GXMISC::gxToString(""#Var"=%s,"#Var2"=%s,"#Var3"=%s,"#Var4"=%s,"#Var5"=%s,"#Var6"=%s,"#Var7"=%s,"#Var8"=%s,"#Var9"=%s;", \
	GXMISC::TFS<VarType>::FMT, GXMISC::TFS<VarType2>::FMT, GXMISC::TFS<VarType3>::FMT, GXMISC::TFS<VarType4>::FMT, GXMISC::TFS<VarType5>::FMT,  \
	GXMISC::TFS<VarType6>::FMT, GXMISC::TFS<VarType7>::FMT, GXMISC::TFS<VarType8>::FMT, GXMISC::TFS<VarType9>::FMT); \
	return GXMISC::gxToString(fmt.c_str(), Var, Var2, Var3, Var4, Var5, Var6, Var7, Var8, Var9);    \
	}

#define DPacketToString10Def(PackType, VarType, Var, VarType2, Var2, VarType3, Var3, VarType4, Var4, VarType5, Var5, VarType6, Var6 \
	, VarType7, Var7, VarType8, Var8, VarType9, Var9, VarType10, Var10)   \
	public: \
	VarType Var;    \
	VarType2 Var2;  \
	VarType3 Var3;  \
	VarType4 Var4;  \
	VarType5 Var5;  \
	VarType6 Var6;  \
	VarType7 Var7;  \
	VarType8 Var8;  \
	VarType9 Var9;  \
	VarType10 Var10;  \
	std::string toString() const  \
	{   \
	DStaticAssert(sizeof(VarType) == sizeof(Var));   \
	DStaticAssert(sizeof(VarType2) == sizeof(Var2));   \
	DStaticAssert(sizeof(VarType3) == sizeof(Var3));   \
	DStaticAssert(sizeof(VarType4) == sizeof(Var4));   \
	DStaticAssert(sizeof(VarType5) == sizeof(Var5));   \
	DStaticAssert(sizeof(VarType6) == sizeof(Var6));   \
	DStaticAssert(sizeof(VarType7) == sizeof(Var7));   \
	DStaticAssert(sizeof(VarType8) == sizeof(Var8));   \
	DStaticAssert(sizeof(VarType9) == sizeof(Var9));   \
	DStaticAssert(sizeof(VarType10) == sizeof(Var10));   \
	std::string fmt = GXMISC::gxToString(""#Var"=%s,"#Var2"=%s,"#Var3"=%s,"#Var4"=%s,"#Var5"=%s,"#Var6"=%s,"#Var7"=%s,"#Var8"=%s,"#Var9"=%s,"#Var10"=%s;", \
	GXMISC::TFS<VarType>::FMT, GXMISC::TFS<VarType2>::FMT, GXMISC::TFS<VarType3>::FMT, GXMISC::TFS<VarType4>::FMT, GXMISC::TFS<VarType5>::FMT,  \
	GXMISC::TFS<VarType6>::FMT, GXMISC::TFS<VarType7>::FMT, GXMISC::TFS<VarType8>::FMT, GXMISC::TFS<VarType9>::FMT, GXMISC::TFS<VarType10>::FMT); \
	return GXMISC::gxToString(fmt.c_str(), Var, Var2, Var3, Var4, Var5, Var6, Var7, Var8, Var9, Var10);    \
	}

// 定义一些需要打印的变量及toString()函数, 变量不会定义
#define DPacketToString(PackType, VarType, Var)   \
	public: \
	std::string toString() const  \
	{   \
	DStaticAssert(sizeof(VarType) == sizeof(Var));   \
	std::string fmt = GXMISC::gxToString(""#Var"=%s;", GXMISC::TFS<VarType>::FMT); \
	return GXMISC::gxToString(fmt.c_str(), Var);    \
	}

#define DPacketToString2(PackType, VarType, Var, VarType2, Var2)   \
	public: \
	std::string toString() const  \
	{   \
	DStaticAssert(sizeof(VarType) == sizeof(Var));   \
	DStaticAssert(sizeof(VarType2) == sizeof(Var2));   \
	std::string fmt = GXMISC::gxToString(""#Var"=%s,"#Var2"=%s;", GXMISC::TFS<VarType>::FMT, GXMISC::TFS<VarType2>::FMT); \
	return GXMISC::gxToString(fmt.c_str(), Var, Var2);    \
	}

#define DPacketToString3(PackType, VarType, Var, VarType2, Var2, VarType3, Var3)   \
	public: \
	std::string toString() const  \
	{   \
	DStaticAssert(sizeof(VarType) == sizeof(Var));   \
	DStaticAssert(sizeof(VarType2) == sizeof(Var2));   \
	DStaticAssert(sizeof(VarType3) == sizeof(Var3));   \
	std::string fmt = GXMISC::gxToString(""#Var"=%s,"#Var2"=%s,"#Var3"=%s;", GXMISC::TFS<VarType>::FMT, GXMISC::TFS<VarType2>::FMT, GXMISC::TFS<VarType3>::FMT); \
	return GXMISC::gxToString(fmt.c_str(), Var, Var2, Var3);    \
	}

#define DPacketToString4(PackType, VarType, Var, VarType2, Var2, VarType3, Var3, VarType4, Var4)   \
	public: \
	std::string toString() const  \
	{   \
	DStaticAssert(sizeof(VarType) == sizeof(Var));   \
	DStaticAssert(sizeof(VarType2) == sizeof(Var2));   \
	DStaticAssert(sizeof(VarType3) == sizeof(Var3));   \
	DStaticAssert(sizeof(VarType4) == sizeof(Var4));   \std::string fmt = GXMISC::gxToString(""#Var"=%s,"#Var2"=%s,"#Var3"=%s,"#Var4"=%s;", \
	GXMISC::TFS<VarType>::FMT, GXMISC::TFS<VarType2>::FMT, GXMISC::TFS<VarType3>::FMT, GXMISC::TFS<VarType4>::FMT); \
	return GXMISC::gxToString(fmt.c_str(), Var, Var2, Var3, Var4);    \
	}

#define DPacketToString5(PackType, VarType, Var, VarType2, Var2, VarType3, Var3, VarType4, Var4, VarType5, Var5)   \
	public: \
	std::string toString() const  \
	{   \
	DStaticAssert(sizeof(VarType) == sizeof(Var));   \
	DStaticAssert(sizeof(VarType2) == sizeof(Var2));   \
	DStaticAssert(sizeof(VarType3) == sizeof(Var3));   \
	DStaticAssert(sizeof(VarType4) == sizeof(Var4));   \
	DStaticAssert(sizeof(VarType5) == sizeof(Var5));   \
	std::string fmt = GXMISC::gxToString(""#Var"=%s,"#Var2"=%s,"#Var3"=%s,"#Var4"=%s,"#Var5"=%s;", \
	GXMISC::TFS<VarType>::FMT, GXMISC::TFS<VarType2>::FMT, GXMISC::TFS<VarType3>::FMT, GXMISC::TFS<VarType4>::FMT, GXMISC::TFS<VarType5>::FMT); \
	return GXMISC::gxToString(fmt.c_str(), Var, Var2, Var3, Var4, Var5);    \
	}

template<typename T>
inline std::string PackToStringFmt(const char* packName, const T& val, const char* valName)
{
	return GXMISC::gxToString("PackName=%s;%s=%s;", packName, valName, GXMISC::TFS<T>::FMT);
}
template<typename T1, typename T2>
inline std::string PackToStringFmt(const char* packName, const T1& val1, const char* val1Name, const T2& val2, const char* val2Name)
{
	return GXMISC::gxToString("PackName=%s;%s=%s;%s=%s;", packName, val1Name, GXMISC::TFS<T1>::FMT, val2Name, GXMISC::TFS<T2>::FMT);
}
template<typename T1, typename T2, typename T3>
inline std::string PackToStringFmt(const char* packName, const T1& val1, const char* val1Name, const T2 val2, const char* val2Name, const T3& val3, const char* val3Name)
{
	return GXMISC::gxToString("PackName=%s;%s=%s;%s=%s;%s=%s;", packName, val1Name, GXMISC::TFS<T1>::FMT, val2Name, GXMISC::TFS<T2>::FMT, val3Name, GXMISC::TFS<T3>::FMT);
}
template<typename T1, typename T2, typename T3, typename T4>
inline std::string PackToStringFmt(const char* packName, const T1& val1, const char* val1Name, const T2& val2, const char* val2Name, const T3& val3, const char* val3Name, const T4& val4, const char* val4Name)
{
	return GXMISC::gxToString("PackName=%s;%s=%s;%s=%s;%s=%s;%s=%s;", packName, val1Name, GXMISC::TFS<T1>::FMT, val2Name, GXMISC::TFS<T2>::FMT, val3Name, GXMISC::TFS<T3>::FMT, val4Name, GXMISC::TFS<T4>::FMT);
}
template<typename T1, typename T2, typename T3, typename T4, typename T5>
inline std::string PackToStringFmt(const char* packName, const T1& val1, const char* val1Name, const T2& val2, const char* val2Name, const T3& val3, const char* val3Name,
	const T4& val4, const char* val4Name, const T5& val5, const char* val5Name)
{
	return GXMISC::gxToString("PackName=%s;%s=%s;%s=%s;%s=%s;%s=%s;%s=%s;", packName, val1Name, GXMISC::TFS<T1>::FMT, val2Name, GXMISC::TFS<T2>::FMT, val3Name, GXMISC::TFS<T3>::FMT, val4Name, GXMISC::TFS<T4>::FMT,
		val5Name, GXMISC::TFS<T5>::FMT);
}
template<typename T1, typename T2, typename T3, typename T4, typename T5, typename T6>
inline std::string PackToStringFmt(const char* packName, const T1& val1, const char* val1Name, const T2& val2, const char* val2Name, const T3& val3, const char* val3Name, const T4& val4, const char* val4Name,
	const T5& val5, const char* val5Name, const T6& val6, const char* val6Name)
{
	return GXMISC::gxToString("PackName=%s;%s=%s;%s=%s;%s=%s;%s=%s;%s=%s;%s=%s;", packName, val1Name, GXMISC::TFS<T1>::FMT, val2Name, GXMISC::TFS<T2>::FMT, val3Name, GXMISC::TFS<T3>::FMT, val4Name, GXMISC::TFS<T4>::FMT,
		val5Name, GXMISC::TFS<T5>::FMT, val6Name, GXMISC::TFS<T6>::FMT);
}
template<typename T1, typename T2, typename T3, typename T4, typename T5, typename T6, typename T7>
inline std::string PackToStringFmt(const char* packName, const T1& val1, const char* val1Name, const T2& val2, const char* val2Name, const T3& val3, const char* val3Name,
	const T4& val4, const char* val4Name, const T5& val5, const char* val5Name, const T6& val6, const char* val6Name, const T7& val7, const char* val7Name)
{
	return GXMISC::gxToString("PackName=%s;%s=%s;%s=%s;%s=%s;%s=%s;%s=%s;%s=%s;%s=%s;", packName, val1Name, GXMISC::TFS<T1>::FMT, val2Name, GXMISC::TFS<T2>::FMT, val3Name, GXMISC::TFS<T3>::FMT, val4Name, GXMISC::TFS<T4>::FMT,
		val5Name, GXMISC::TFS<T5>::FMT, val6Name, GXMISC::TFS<T6>::FMT, val7Name, GXMISC::TFS<T7>::FMT);
}
template<typename T1, typename T2, typename T3, typename T4, typename T5, typename T6, typename T7, typename T8>
inline std::string PackToStringFmt(const char* packName, const T1& val1, const char* val1Name, const T2& val2, const char* val2Name, const T3& val3, const char* val3Name, const T4& val4, const char* val4Name,
	const T5& val5, const char* val5Name, const T6& val6, const char* val6Name, const T7& val7, const char* val7Name, const T8& val8, const char* val8Name)
{
	return GXMISC::gxToString("PackName=%s;%s=%s;%s=%s;%s=%s;%s=%s;%s=%s;%s=%s;%s=%s;%s=%s;", packName, val1Name, GXMISC::TFS<T1>::FMT, val2Name, GXMISC::TFS<T2>::FMT, val3Name, GXMISC::TFS<T3>::FMT, val4Name, GXMISC::TFS<T4>::FMT,
		val5Name, GXMISC::TFS<T5>::FMT, val6Name, GXMISC::TFS<T6>::FMT, val7Name, GXMISC::TFS<T7>::FMT, val8Name, GXMISC::TFS<T8>::FMT);
}

// 定义一些需要打印的变量及toString()函数, 变量不会定义
#define DFastPacketToString(PackType, Var)   \
	public: \
	typedef uint32 _TPackToStringT;	\
	std::string toString() const  \
{   \
	std::string fmt = PackToStringFmt(#PackType, Var, #Var); \
	return GXMISC::gxToString(fmt.c_str(), Var);    \
}

#define DFastPacketToString2(PackType, Var, Var2)   \
	public: \
	typedef uint32 _TPackToStringT;	\
	std::string toString() const  \
{   \
	std::string fmt = PackToStringFmt(#PackType, Var, #Var, Var2, #Var2); \
	return GXMISC::gxToString(fmt.c_str(), Var, Var2);    \
}

#define DFastPacketToString3(PackType, Var, Var2, Var3)   \
	public: \
	typedef uint32 _TPackToStringT;	\
	std::string toString() const  \
{   \
	std::string fmt = PackToStringFmt(#PackType, Var, #Var, Var2, #Var2, Var3, #Var3); \
	return GXMISC::gxToString(fmt.c_str(), Var, Var2, Var3);    \
}

#define DFastPacketToString4(PackType, Var, Var2, Var3, Var4)   \
	public: \
	typedef uint32 _TPackToStringT;	\
	std::string toString() const  \
{   \
	std::string fmt = PackToStringFmt(#PackType, Var, #Var, Var2, #Var2, Var3, #Var3, Var4, #Var4); \
	return GXMISC::gxToString(fmt.c_str(), Var, Var2, Var3, Var4);    \
}

#define DFastPacketToString5(PackType, Var, Var2, Var3, Var4, Var5)   \
	public: \
	typedef uint32 _TPackToStringT;	\
	std::string toString() const  \
{   \
	std::string fmt = PackToStringFmt(#PackType, Var, #Var, Var2, #Var2, Var3, #Var3, Var4, #Var4, Var5, #Var5); \
	return GXMISC::gxToString(fmt.c_str(), Var, Var2, Var3, Var4, Var5);    \
}

#define DFastPacketToString6(PackType, Var, Var2, Var3, Var4, Var5, Var6)   \
	public: \
	typedef uint32 _TPackToStringT;	\
	std::string toString() const  \
{   \
	std::string fmt = PackToStringFmt(#PackType, Var, #Var, Var2, #Var2, Var3, #Var3, Var4, #Var4, Var5, #Var5, Var6, #Var6); \
	return GXMISC::gxToString(fmt.c_str(), Var, Var2, Var3, Var4, Var5, Var6);    \
}

#define DFastPacketToString7(PackType, Var, Var2, Var3, Var4, Var5, Var6, Var7)   \
	public: \
	typedef uint32 _TPackToStringT;	\
	std::string toString() const  \
{   \
	std::string fmt = PackToStringFmt(#PackType, Var, #Var, Var2, #Var2, Var3, #Var3, Var4, #Var4, Var5, #Var5, Var6, #Var6, Var7, #Var7); \
	return GXMISC::gxToString(fmt.c_str(), Var, Var2, Var3, Var4, Var5, Var6, Var7);    \
}

#define DFastPacketToString8(PackType, Var, Var2, Var3, Var4, Var5, Var6, Var7, Var8)   \
	public: \
	typedef uint32 _TPackToStringT;	\
	std::string toString() const  \
{   \
	std::string fmt = PackToStringFmt(#PackType, Var, #Var, Var2, #Var2, Var3, #Var3, Var4, #Var4, Var5, #Var5, Var6, #Var6, Var7, #Var7, Var8, #Var8); \
	return GXMISC::gxToString(fmt.c_str(), Var, Var2, Var3, Var4, Var5, Var6, Var7, Var8);    \
}

#define DFastPacketToString9(PackType, Var, Var2, Var3, Var4, Var5, Var6, Var7, Var8, Var9)   \
	public: \
	typedef uint32 _TPackToStringT;	\
	std::string toString() const  \
{   \
	std::string fmt = PackToStringFmt(#PackType, Var, #Var, Var2, #Var2, Var3, #Var3, Var4, #Var4, Var5, #Var5, Var6, #Var6, Var7, #Var7, Var8, #Var8, Var9, #Var9); \
	return GXMISC::gxToString(fmt.c_str(), Var, Var2, Var3, Var4, Var5, Var6, Var7, Var8, Var9);    \
}

// 定义一些需要打印的变量及toString()函数, 变量不会定义, toString()会显示变量的别名
#define DPacketToStringAlias(PackType, VarType, VarName, Var)   \
	public: \
	std::string toString() const  \
{   \
	DStaticAssert(sizeof(VarType) == sizeof(Var));   \
	std::string fmt = GXMISC::gxToString(""#VarName"=%s;", GXMISC::TFS<VarType>::FMT); \
	return GXMISC::gxToString(fmt.c_str(), Var);    \
}

#define DPacketToString2Alias(PackType, VarType, VarName, Var, VarType2, VarName2, Var2)   \
	public: \
	std::string toString() const  \
{   \
	DStaticAssert(sizeof(VarType) == sizeof(Var));   \
	DStaticAssert(sizeof(VarType2) == sizeof(Var2));   \
	std::string fmt = GXMISC::gxToString(""#VarName"=%s,"#VarName2"=%s;", GXMISC::TFS<VarType>::FMT, GXMISC::TFS<VarType2>::FMT); \
	return GXMISC::gxToString(fmt.c_str(), Var, Var2);    \
}

#define DPacketToString3Alias(PackType, VarType, VarName, Var, VarType2, VarName2, Var2, VarType3, VarName3, Var3)   \
	public: \
	std::string toString() const  \
{   \
	DStaticAssert(sizeof(VarType) == sizeof(Var));   \
	DStaticAssert(sizeof(VarType2) == sizeof(Var2));   \
	DStaticAssert(sizeof(VarType3) == sizeof(Var3));   \
	std::string fmt = GXMISC::gxToString(""#VarName"=%s,"#VarName2"=%s,"#VarName3"=%s;",    \
	GXMISC::TFS<VarType>::FMT, GXMISC::TFS<VarType2>::FMT, GXMISC::TFS<VarType3>::FMT); \
	return GXMISC::gxToString(fmt.c_str(), Var, Var2, Var3);    \
}

#define DPacketToString4Alias(PackType, VarType, VarName, Var, VarType2, VarName2, Var2, VarType3, VarName3, Var3, VarType4, VarName4, Var4)   \
	public: \
	std::string toString() const  \
{   \
	DStaticAssert(sizeof(VarType) == sizeof(Var));   \
	DStaticAssert(sizeof(VarType2) == sizeof(Var2));   \
	DStaticAssert(sizeof(VarType3) == sizeof(Var3));   \
	DStaticAssert(sizeof(VarType4) == sizeof(Var4));   \
	std::string fmt = GXMISC::gxToString(""#VarName"=%s,"#VarName2"=%s,"#VarName3"=%s,"#VarName4"=%s;", \
	GXMISC::TFS<VarType>::FMT, GXMISC::TFS<VarType2>::FMT, GXMISC::TFS<VarType3>::FMT, GXMISC::TFS<VarType4>::FMT); \
	return GXMISC::gxToString(fmt.c_str(), Var, Var2, Var3, Var4);    \
}

#define DPacketToString5Alias(PackType, VarType, VarName, Var, VarType2, VarName2, Var2, VarType3, VarName3, Var3, VarType4, VarName4, Var4, VarType5, VarName5, Var5)   \
	public: \
	std::string toString() const  \
{   \
	DStaticAssert(sizeof(VarType) == sizeof(Var));   \
	DStaticAssert(sizeof(VarType2) == sizeof(Var2));   \
	DStaticAssert(sizeof(VarType3) == sizeof(Var3));   \
	DStaticAssert(sizeof(VarType4) == sizeof(Var4));   \
	DStaticAssert(sizeof(VarType5) == sizeof(Var5));   \
	std::string fmt = GXMISC::gxToString(""#VarName"=%s,"#VarName2"=%s,"#VarName3"=%s,"#VarName4"=%s,"#VarName5"=%s;", \
	GXMISC::TFS<VarType>::FMT, GXMISC::TFS<VarType2>::FMT, GXMISC::TFS<VarType3>::FMT, GXMISC::TFS<VarType4>::FMT, GXMISC::TFS<VarType5>::FMT); \
	return GXMISC::gxToString(fmt.c_str(), Var, Var2, Var3, Var4, Var5);    \
}

#endif		// _PACKET_DEF_H_