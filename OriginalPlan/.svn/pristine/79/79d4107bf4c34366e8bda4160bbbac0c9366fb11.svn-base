// @BEGNODOC
#ifndef _BASE_PACKET_DEF_H_
#define _BASE_PACKET_DEF_H_

#include "core/types_def.h"
#include "core/carray.h"
#include "core/stream_impl.h"
#include "core/base_util.h"
#include "core/script/lua_base_conversions_impl.h"

#include "game_errno.h"
#include "server_define.h"

typedef uint16 TRetCode_t;						///< 返回码类型
typedef uint16 TPackLen_t;                      ///< 协议长度
typedef uint8  TPackFlag_t;						///< 协议标记
typedef uint16 TPacketID_t;						///< 协议ID
static const TPacketID_t INVALID_PACKET_ID = 0;

#pragma pack(push, 1)

enum
{
	COMPRESS_FLAG = 0x80000000,				// 压缩标记
	ENCRYPT_FLAG = 0x40000000,				// 加密标记
};
// @ENDDOC
//class CBasePacket;
/** @defgroup BasePacket 基本协议结构定义
* @{
*/
struct CBasePacket
{
public:	// @NODOC
	typedef uint8 _TPackToStringT;		// @NODOC

public:
	TPackLen_t      totalLen;
	TPacketID_t     packetID;
	TPackFlag_t		flag;

public:
	TPackLen_t getTotalLen() const { return totalLen; }
	void setTotalLen(TPackLen_t val) { totalLen = val; }
	TPackFlag_t getFlag() const { return flag; }
	void setFlag(TPackFlag_t val) { flag = val; }
	TPacketID_t getPacketID() const { return packetID; }
	void setPacketID(TPacketID_t val) { packetID = val; }

public:
	CBasePacket(TPacketID_t id)
	{
		memset(this, 0, sizeof(CBasePacket));
		packetID = id;
	}

public:
	TPacketID_t getPacketID()
	{
		return packetID;
	}

	bool check()
	{
		return true;
	}

	bool isCrypt()
	{
		return false;
	}

	bool isCompress()
	{
		return false;
	}

	void setUnCompressed()
	{

	}

	void setCompressed()
	{

	}

	const char* data()
	{
		return (char*)this;
	}
};

// 请求包
struct CRequestPacket : public CBasePacket
{
public:
	CRequestPacket(TPacketID_t id) : CBasePacket(id){
		memset(this, 0, sizeof(CRequestPacket));
		packetID = id;
	}
	CRequestPacket() : CBasePacket(0){}

public:
	void serialPackHeader(GXMISC::IStream& f) const
	{
		f.serial(totalLen,flag,packetID);
	}

	uint32 serialPackHeaderLen() const
	{
		return GXMISC::IStream::SerialLen(totalLen,packetID,flag);
	}

	void unserialPackHeader(GXMISC::IUnStream& f) const
	{
		f.serial(totalLen, flag, packetID);
	}
};

// 响应包
struct CResponsePacket : public CBasePacket
{
public:
	bool isSuccess()
	{
		return retCode == RC_SUCCESS;
	}

	CResponsePacket(TPacketID_t id) : CBasePacket(id)
	{
		memset(this, 0, sizeof(CResponsePacket));
		retCode = RC_FAILED;
		packetID = id;
	}
	CResponsePacket() : CBasePacket(0)
	{
		retCode = RC_FAILED;
	}

	void serialPackHeader(GXMISC::IStream& f) const
	{
		f.serial(totalLen,flag,packetID,retCode);
	}

	uint32 serialPackHeaderLen() const
	{
		return GXMISC::IStream::SerialLen(totalLen,packetID,flag,retCode);
	}
	void unserialPackHeader(GXMISC::IUnStream& f) const
	{
		f.serial(totalLen, flag, packetID, retCode);
	}

public:
	TRetCode_t getRetCode() const { return retCode; }
	void setRetCode(TRetCode_t val) { retCode = val; }

	// @member
protected:
	TRetCode_t retCode;
};

#define SERVER_PACKET_RETCODE 0
#ifdef SERVER_PACKET_RETCODE
// 主动包
struct CServerPacket : public CResponsePacket
{
public:
	CServerPacket() : CResponsePacket(0)
	{
		setRetCode(RC_SUCCESS);
	}
	CServerPacket(TPacketID_t id) : CResponsePacket(id)
	{
		setRetCode(RC_SUCCESS);
	}
};
#else
// 主动包
struct CServerPacket : public CBasePacket
{
public:
	CServerPacket() : CBasePacket(0)
	{}
	CServerPacket(TPacketID_t id) : CBasePacket(id){}
};
#endif

/** @}*/
// @BEGNODOC
// 清理包结构
#define DCleanPacketStruct(basepack)   \
	char* ba = ((char*)this)+sizeof(basepack);   \
	sint32 len = sizeof(*this)-sizeof(basepack); \
	memset(ba, 0, len);

//typedef MYTYPE TMyType;	

#define DPACKET_BASE_DEF(MYTYPE, PID, PBTYPE)	\
public:	\
	typedef PBTYPE TBaseType;	\
	enum{PACKET_ID = PID};	\
	MYTYPE() : TBaseType(PACKET_ID){ DCleanPacketStruct(TBaseType);}	\
	~MYTYPE(){}

#define DUNSTREAM_IMPL	\
public:	\
	static void Setup()	\
	{	\
		_Helper.doVoid();	\
		CGameSocketPacketHandler::RegisteUnpacketHandler(PACKET_ID, sizeof(TMyType), (TUnpacketHandler)Unpacket);	\
	}	\
	static void Unsetup()	\
	{	\
	}	\
	static bool Unpacket(TMyType* pBase, const char * buff, sint32 len)	\
	{	\
		GXMISC::CMemInputStream inStream;	\
		memcpy(pBase, buff, sizeof(TBaseType));	\
		inStream.init(len, (char*)(buff+sizeof(TBaseType)));	\
		inStream.serial(*pBase);	\
		return true;	\
	}

#define DPACK_LEN	\
public:	\
	TPackLen_t getPackLen()	\
	{	\
		totalLen = (TPackLen_t)sizeof(*this);  \
		flag = totalLen & 0xff;	\
		return totalLen;   \
	}

#define DPACK_LEN_1ARY(ary)	\
public:	\
	TPackLen_t getPackLen()	\
	{	\
		totalLen = (TPackLen_t)(sizeof(*this)-sizeof(ary));	\
		totalLen += ary.sizeInBytes();	\
		flag = totalLen & 0xff;	\
		return totalLen;	\
	}

// 请求包
#define DReqPacketImpl(name, id)    \
	public: \
enum{ PACKET_ID = id };	\
	name() : CRequestPacket(id)    \
{   \
	DCleanPacketStruct(CRequestPacket);   \
}   \
	\
	public: \
	TPackLen_t getPackLen() \
{   \
	totalLen = (TPackLen_t)sizeof(*this);  \
	flag = totalLen & 0xff;	\
	return totalLen;   \
}

// 响应包
#define DResPacketImpl(name, id)   \
	public: \
enum{ PACKET_ID = EPacketIDDef::id };	\
	name() : CResponsePacket(id)    \
{   \
	DCleanPacketStruct(CResponsePacket);   \
}   \
	\
	public: \
	TPackLen_t getPackLen() \
{   \
	totalLen = (TPackLen_t)sizeof(*this);  \
	flag = totalLen & 0xff;	\
	return totalLen;   \
}

// 主动包
#define DSvrPacketImpl(name, id)   \
	public: \
enum{ PACKET_ID = id };	\
	name() : CServerPacket(id)    \
{   \
	DCleanPacketStruct(CServerPacket);   \
}   \
	\
	public: \
	TPackLen_t getPackLen() \
{   \
	totalLen = (TPackLen_t)sizeof(*this);  \
	flag = totalLen & 0xff;	\
	return totalLen;   \
}
// @ENDDOC

template<typename T, uint32 N = MAX_ARRAY_NUM>
class CArray1 : public GXMISC::CArray<T, N, uint8>
{
public:
	typedef GXMISC::CArray<T, N, uint8>				TBaseType;

	typedef typename TBaseType::value_type			value_type;
	typedef typename TBaseType::iterator			iterator;
	typedef typename TBaseType::const_iterator		const_iterator;
	typedef typename TBaseType::reference			reference;
	typedef typename TBaseType::const_reference		const_reference;
	typedef typename TBaseType::size_type			size_type;
	typedef typename TBaseType::difference_type	    difference_type;

public:
	CArray1() : TBaseType()
	{
	}
	~CArray1(){}

public:
	template <typename T2>
	CArray1<T,N>& operator = (const CArray1<T2,N>& rhs)
	{
		std::copy(rhs.begin(),rhs.end(), this->begin());
		this->_length = rhs.size();
		return *this;
	}

	CArray1<T,N>& operator = (const CArray1<T,N>& rhs)
	{
		std::copy(rhs.begin(), rhs.end(), this->begin());
		this->_length = rhs.size();
		return *this;
	}
};

template<typename T, uint32 N = MAX_ARRAY2_NUM>
class CArray2 : public GXMISC::CArray<T, N, uint16>
{
public:
	typedef GXMISC::CArray<T, N, uint16>			TBaseType;

	typedef typename TBaseType::value_type			value_type;
	typedef typename TBaseType::iterator			iterator;
	typedef typename TBaseType::const_iterator		const_iterator;
	typedef typename TBaseType::reference			reference;
	typedef typename TBaseType::const_reference		const_reference;
	typedef typename TBaseType::size_type			size_type;
	typedef typename TBaseType::difference_type	    difference_type;

public:
	CArray2() : TBaseType()
	{
	}
	~CArray2(){}

public:
	template <typename T2>
	CArray2<T,N>& operator = (const CArray2<T2,N>& rhs)
	{
		std::copy(rhs.begin(),rhs.end(), this->begin());
		this->_length = rhs.size();
		return *this;
	}

	CArray2<T,N>& operator = (const CArray2<T,N>& rhs)
	{
		std::copy(rhs.begin(), rhs.end(), this->begin());
		this->_length = rhs.size();
		return *this;
	}
};

template<uint32 N = MAX_CHAR_ARRAY1_NUM>
class CCharArray1 : public GXMISC::CCharArray<N, uint8>
{
public:
	typedef GXMISC::CCharArray<N, uint8>			TBaseType;

	typedef typename TBaseType::value_type			value_type;
	typedef typename TBaseType::iterator			iterator;
	typedef typename TBaseType::const_iterator		const_iterator;
	typedef typename TBaseType::reference			reference;
	typedef typename TBaseType::const_reference		const_reference;
	typedef typename TBaseType::size_type			size_type;
	typedef typename TBaseType::difference_type	    difference_type;

public:
	CCharArray1() : TBaseType(){}
	CCharArray1(typename TBaseType::HashKeyType key)
	{
		this->clear();
		this->pushBack(key);
	}
	CCharArray1(const char* msg)
	{
		this->clear();
		this->pushBack(msg, (size_type)strlen(msg));
	}
	CCharArray1(const std::string& msg)
	{
		this->clear();
		this->pushBack(msg.c_str(), (size_type)msg.size());
	}
	~CCharArray1(){}

public:
	

	CCharArray1<N>& operator=(const char* msg)
	{
		this->clear();
		this->pushBack(msg, (size_type)strlen(msg));
		return *this;
	}
	CCharArray1<N>& operator=(const char msg)
	{
		this->clear();
		this->pushBack(msg);
		return *this;
	}
	CCharArray1<N>& operator=(const std::string& msg)
	{
		this->clear();
		*this = msg.c_str();
		return *this;
	}
	CCharArray1<N>& operator= (const CCharArray1<N>& rhs)
	{
		this->clear();
		memcpy(this->_elems, rhs.data(),rhs.size());
		this->_length = rhs.size();
		return *this;
	}
	bool operator == (const CCharArray1<N>& rhs) const
	{
		if(rhs.size() != this->size()){
			return false;
		}

		return strcmp(this->data(), rhs.data()) == 0;
	}

	bool operator != (const CCharArray1<N>& rhs) const
	{
		return !(*this == rhs);
	}

	bool operator == (char ch)
	{
		if(this->size() > 1){
			return false;
		}
		if(ch == 0){
			if(!this->empty()){
				return false;
			}

			return true;
		}else{
			if(this->empty()){
				return false;
			}

			return this->at(0) == ch;
		}

		return false;
	}

	bool operator != (char ch)
	{
		return !(*this == ch);
	}

	operator char(){
		return '\0';
	}
};
typedef CCharArray1<> TCharArray1;

template<uint32 N = MAX_CHAR_ARRAY2_NUM>
class CCharArray2 : public GXMISC::CCharArray<N, uint16>
{
public:
	typedef GXMISC::CCharArray<N, uint16>			TBaseType;

	typedef typename TBaseType::value_type			value_type;
	typedef typename TBaseType::iterator			iterator;
	typedef typename TBaseType::const_iterator		const_iterator;
	typedef typename TBaseType::reference			reference;
	typedef typename TBaseType::const_reference		const_reference;
	typedef typename TBaseType::size_type			size_type;
	typedef typename TBaseType::difference_type	    difference_type;

public:
	CCharArray2() : TBaseType(){}
	CCharArray2(typename TBaseType::HashKeyType key)
	{
		this->clear();
		this->pushBack(key);
	}
	CCharArray2(const char* msg)
	{
		this->clear();
		this->pushBack(msg, (size_type)strlen(msg));
	}
	CCharArray2(const std::string& msg)
	{
		this->clear();
		this->pushBack(msg.c_str(), (size_type)msg.size());
	}
	~CCharArray2(){}

public:
	CCharArray2<N>& operator=(const char* msg)
	{
		this->clear();
		this->pushBack(msg, (size_type)strlen(msg));
		return *this;
	}
	CCharArray2<N>& operator=(const char msg)
	{
		this->clear();
		this->pushBack(msg);
		return *this;
	}
	CCharArray2<N>& operator=(const std::string& msg)
	{
		this->clear();
		*this = msg.c_str();
		return *this;
	}
	CCharArray2<N>& operator= (const CCharArray2<N>& rhs)
	{
		this->clear();
		memcpy(this->_elems, rhs.data(),rhs.size());
		this->_length = rhs.size();
		return *this;
	}

	bool operator == (const CCharArray2<N>& rhs) const
	{
		if(rhs.size() != this->size()){
			return false;
		}

		return strcmp(this->data(), rhs.data()) == 0;
	}

	bool operator != (const CCharArray2<N>& rhs) const
	{
		return !(*this == rhs);
	}

	bool operator==(const std::string &other) const
	{
		if(other.size() != this->size())
		{
			return false;
		}

		return strcmp(this->data(), other.c_str());
	}

	bool operator==(const char* other) const
	{
		if(NULL == other)
		{
			return false;
		}

		return strcmp(this->data(), other) == 0;
	}

	bool operator!=(const std::string &other) const
	{
		return !(*this == other);
	}

	bool operator!=(const char* other) const
	{
		return !(*this == other);
	}

	bool operator == (char ch)
	{
		if(this->size() > 1){
			return false;
		}
		if(ch == 0){
			if(!this->empty()){
				return false;
			}

			return true;
		}else{
			if(this->empty()){
				return false;
			}

			return this->at(0) == ch;
		}

		return false;
	}

	bool operator != (char ch)
	{
		return !(*this == ch);
	}

	operator char(){
		return '\0';
	}
};
typedef CCharArray2<> TCharArray2;

template<int N>
void array_string1_to_luaval(lua_State* L, const CCharArray1<N>& inValue)
{
	lua_pushlstring(L, (char*)inValue.data(), inValue.size());
}

template<int N>
void array_string2_to_luaval(lua_State* L, const CCharArray2<N>& inValue)
{
	lua_pushlstring(L, (char*)inValue.data(), inValue.size());
}

template<int N>
bool luaval_to_array_string1(lua_State* L, int lo, CCharArray1<N>* outValue, const char* funcName = "")
{
	return luaval_to_array_string(L, lo, (typename CCharArray1<N>::TBaseType*)outValue, funcName);
}

template<int N>
bool luaval_to_array_string2(lua_State* L, int lo, CCharArray2<N>* outValue, const char* funcName = "")
{
	return luaval_to_array_string(L, lo, (typename CCharArray2<N>::TBaseType*)outValue, funcName);
}

template <typename T, int N>
inline bool luaval_to_array1(lua_State* L, int lo, const char* type, CArray1<T, N>* ret, const char* funcName)
{
	return _luaval_to_container<T, CArray1<T, N>, is_base_type<T>::value>::Invoke(L, lo, type, ret, funcName);
}

template <typename T, int N>
inline bool luaval_to_array2(lua_State* L, int lo, const char* type, CArray2<T, N>* ret, const char* funcName)
{
	return _luaval_to_container<T, CArray2<T, N>, is_base_type<T>::value>::Invoke(L, lo, type, ret, funcName);
}

template<typename T, int N>
void array1_to_luaval(lua_State* L, const char* type, const CArray1<T, N>& inValue)
{
	return _container_to_luaval<T, CArray1<T, N>, is_base_type<T>::value>::Invoke(L, type, inValue);
}

template<typename T, int N>
void array2_to_luaval(lua_State* L, const char* type, const CArray2<T, N>& inValue)
{
	return _container_to_luaval<T, CArray2<T, N>, is_base_type<T>::value>::Invoke(L, type, inValue);
}

// @BEGNODOC
#pragma pack(pop)

#endif
// @ENDDOC