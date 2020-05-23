#ifndef _GAME_SOCKET_PACKET_HANDLER_H_
#define _GAME_SOCKET_PACKET_HANDLER_H_

#include "zlib.h"

#include "core/socket.h"
#include "core/net_task.h"
#include "core/types_def.h"
#include "core/socket_packet_handler.h"
#include "core/socket_event_loop_wrap.h"

#include "base_packet_def.h"
#include "socket_attr.h"

// 压缩协议
#pragma pack(push, 1)

#define PACKET_MC_COMPRESS 0x1				// 协议ID
class MCCompress : public CServerPacket
{
public:
	CCharArray2<MAX_COMPRESS_LEN> msg;

	MCCompress() : CServerPacket(PACKET_MC_COMPRESS)
	{
		DCleanPacketStruct(CServerPacket);
	}

	TPackLen_t getPackLen()
	{
		totalLen = (TPackLen_t)sizeof(CServerPacket)
			+ msg.sizeInBytes();

		return totalLen;
	}
};
#pragma pack(pop)

typedef struct PackCompress
{
	sint16 compressLen;
}TPackCompress;
typedef struct PackEncrypt
{
	sint16 encryptLen;
}TPackEncrypt;

class CBasePackHandleAry : public GXMISC::CPackHandleAry
{
public:
	CBasePackHandleAry(){}
	~CBasePackHandleAry(){}

public:
	bool parse(const char* msg, sint32 len);
	CBasePacket* getBasePack(sint32 index);
};

typedef bool (*TUnpacketHandler)(CBasePacket* packet, const char* buffer, sint32 len);			// 变长消息解包处理函数
typedef struct TUnpacketIDHandler
{
	TPacketID_t pid;				// 包ID
	sint32 packMaxLen;				// 包的最大长度
	TUnpacketHandler func;			// 包处理函数
}TUnpacketIDHandler;
typedef CHashMap<TPacketID_t, TUnpacketIDHandler> TUnpacketHandlerHash;						// 变长消息处理函数哈希映射表

typedef TUnpacketIDHandler TUnpacketIDHandlerAry[1000];

class CGameSocketPacketHandler : public GXMISC::ISocketPacketHandler
{
public:
	CGameSocketPacketHandler();
	~CGameSocketPacketHandler(){}

public:
	static void Setup();

public:
	static bool OnFlushDataToNetLoop(GXMISC::CNetLoopWrap* netWrap, const char* msg, sint32 len, GXMISC::TUniqueIndex_t index);

	// 主逻辑线程调用的函数, 这些函数都是不安全的, 不能在底层线程调用
	// @todo 做线程安全检测
public:
	void setAttr(TSockExtAttr* attr);
	sint32 doCompress(const char* buff, sint32 len, char* outBuff, sint32& outLen);
	sint32 doEncrypt(const char* buff, sint32 len, char* outBuff, sint32& outLen);

public:
	static void RegisteUnpacketHandler(TPacketID_t id, sint32 maxLen, TUnpacketHandler handler)
	{
		UnpacketHandlers[UnpacketHandlerNum].func = handler;
		UnpacketHandlers[UnpacketHandlerNum].pid = id;
		UnpacketHandlers[UnpacketHandlerNum].packMaxLen = maxLen;
		UnpacketHandlerNum++;
	}
public:
	virtual bool parsePack(GXMISC::CPackHandleAry* packAry, const char* msg, sint32 len) override;
	virtual bool needHandle(GXMISC::ISocketPacketHandler::EPackOpt opt);
	virtual sint32 canReadPack(const char* buff, sint32 len);
	virtual sint32 canUnpacket();
	virtual sint32 getPackHeaderLen();
	virtual sint32 getMaxVarPackLen(const char* buff);
	virtual bool isVarPacket(const char* buff, sint32 len);

	// @todo 当前数据包是否需要单独处理, 有些数据包可能需要单独处理
	virtual bool canCompress(CBasePacket* pBasePack);

	virtual void onSendPack(const char* msg, sint32 len, bool singalFlag);
	virtual void onRecvPack(const char* msg, sint32 len, bool singalFlag);
	virtual sint32 onBeforeFlushToSocket(const char* buff, sint32 len, char* outBuff, sint32& outLen);
	virtual sint32 onAfterReadFromSocket(const char* buff, sint32 len, char* outBuff, sint32& outLen);
	virtual sint32 onPackBeforeFlushToSocket(const char* buff, sint32 len, char* outBuff, sint32& outLen);
	virtual sint32 onPackAfterFromSocket(const char* buff, sint32 len, char* outBuff, sint32& outLen);
	virtual void onHandleVarUnpacket(char* buff, const char* varBuff, sint32 len);

protected:
	TUnpacketIDHandler* getUnpacketHandler(TPacketID_t packetID);

protected:
	std::set<TPacketID_t> _filterPacket;
	TPackHandleAttr _attr;

private:
	static uint32 UnpacketHandlerNum;					// 变长消息名解包处理函数个数
	static TUnpacketIDHandlerAry UnpacketHandlers;		// 变长消息解包处理函数数组
	static TUnpacketHandlerHash HandlerHashs;			// 变长消息解包处理函数哈希表
};

#endif