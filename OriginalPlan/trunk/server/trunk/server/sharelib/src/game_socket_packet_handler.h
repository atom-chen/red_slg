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

// ѹ��Э��
#pragma pack(push, 1)

#define PACKET_MC_COMPRESS 0x1				// Э��ID
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

typedef bool (*TUnpacketHandler)(CBasePacket* packet, const char* buffer, sint32 len);			// �䳤��Ϣ���������
typedef struct TUnpacketIDHandler
{
	TPacketID_t pid;				// ��ID
	sint32 packMaxLen;				// ������󳤶�
	TUnpacketHandler func;			// ��������
}TUnpacketIDHandler;
typedef CHashMap<TPacketID_t, TUnpacketIDHandler> TUnpacketHandlerHash;						// �䳤��Ϣ��������ϣӳ���

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

	// ���߼��̵߳��õĺ���, ��Щ�������ǲ���ȫ��, �����ڵײ��̵߳���
	// @todo ���̰߳�ȫ���
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

	// @todo ��ǰ���ݰ��Ƿ���Ҫ��������, ��Щ���ݰ�������Ҫ��������
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
	static uint32 UnpacketHandlerNum;					// �䳤��Ϣ���������������
	static TUnpacketIDHandlerAry UnpacketHandlers;		// �䳤��Ϣ�������������
	static TUnpacketHandlerHash HandlerHashs;			// �䳤��Ϣ�����������ϣ��
};

#endif