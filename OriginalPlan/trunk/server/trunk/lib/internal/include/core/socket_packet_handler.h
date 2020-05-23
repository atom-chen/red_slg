#ifndef _SOCKET_PACKET_HANDLER_H_
#define _SOCKET_PACKET_HANDLER_H_

#include "types_def.h"
#include "interface.h"

namespace GXMISC
{
	class CPackHandleAry
	{
	public:
		CPackHandleAry(){}
		~CPackHandleAry(){}

	public:
		sint32 getPackNum()
		{
			return (uint32)(_pack.size()-1);
		}

		const char* getPack(sint32 index)
		{
			return _msg+_pack[index];
		}

		sint32 getPackLen(sint32 startIndex, sint32 endIndex)
		{
			return _pack[endIndex]-_pack[startIndex];
		}

		sint32 getPackLen(sint32 index)
		{
			return getPackLen(index, index+1);
		}

		void push(const char* msg, sint32 len)
		{
			_msg = msg;
			_len = len;
			_pack.push_back(0);
			_pack.push_back(len);
		}

	protected:
		const char* _msg;
		sint32 _len;

	protected:
		std::vector<sint32> _pack;
	};

	class CSocket;
	class CNetSocketLoopTask;
	class ISocketPacketHandler : public IFreeable
	{
	public:
		enum
		{
			//...错误码请填写在这个的上面, 外部接收到这个错误码会断开连接或把数据不特殊处理
			PACK_HANDLE_ERR = 0,		// 包处理错误

			// 成功码及需要特殊处理的请填写在下面
			PACK_HANDLE_OK = 1,			// 包处理成功
			PACK_HANDLE_NO = 2,			// 包未需要处理
			PACK_HANDLE_SPECIAL = 3,	// 包特殊, 已处理, 前面累积的包需要立即处理
			PACK_HANDLE_NO_BUFF = 4,	// 缓冲不够
		};

		enum EPackOpt
		{
			PACK_READ,
			PACK_SEND,
		};
	protected:
		ISocketPacketHandler();
	public:
		virtual ~ISocketPacketHandler();

	public:
		void setSocket(CSocket* socket);
		void setUnpacketNum(sint32 unpacketNum);
		CSocket* getSocket();
		sint32 getUnpacketNum();

	public:
		virtual bool parsePack(CPackHandleAry* packAry, const char* msg, sint32 len);

	public:
		void sendPack(const char* msg, uint32 len);

	public:
		virtual sint32 canUnpacket() = 0;
		virtual bool unpacket(CNetSocketLoopTask* task, char* packBuff, sint32 packBuffLen, char* packBuffTempRead, sint32 packBuffTempReadLen);

	public:
		// 包列表组成的缓冲区
		virtual sint32 onBeforeFlushToSocket(const char* buff, sint32 len, char* outBuff, sint32& outLen);
		virtual sint32 onAfterReadFromSocket(const char* buff, sint32 len, char* outBuff, sint32& outLen);
		// 截出来的单个包
		virtual sint32 onPackBeforeFlushToSocket(const char* buff, sint32 len, char* outBuff, sint32& outLen);
		virtual sint32 onPackAfterFromSocket(const char* buff, sint32 len, char* outBuff, sint32& outLen);
		// 能否从缓冲区读出一个完整的数据包
		virtual sint32 canReadPack(const char* buff, sint32 len){ return 0; }
		// 是否需要处理包
		virtual bool needHandle(EPackOpt opt) { return false; }
		// 是否变长消息
		virtual bool isVarPacket(const char* buff, sint32 len){ return false;}
		// 包头有多长
		virtual sint32 getPackHeaderLen(){ return 0;}
		// 得到变长消息包最大有多长
		virtual sint32 getMaxVarPackLen(const char* buff){ return 0;}

	public:
		virtual void onSendPack(const char* buff, sint32 len, bool singalFlag){}
		virtual void onRecvPack(const char* buff, sint32 len, bool singalFlag){}
		virtual void onHandleVarUnpacket(char* buff, const char* varBuff, sint32 len){}

	protected:
		bool doUnpacket(CNetSocketLoopTask* task, sint32 len);
		bool doUnpacket(CNetSocketLoopTask* task, char* buff, sint32 len);

	protected:
		CSocket* _socket;
		sint32 _unpacketNum;
	};

	// 无包格式, 全部读取
	class CEmptyPacketHandler : public ISocketPacketHandler
	{
	public:
		CEmptyPacketHandler();
		~CEmptyPacketHandler();

	public:
		virtual sint32 getPackHeaderLen();
		virtual sint32 canUnpacket();
		virtual bool unpacket(CNetSocketLoopTask* task, char* packBuff, sint32 packBuffLen, char* packBuffTempRead, sint32 packBuffTempReadLen);
	};

	// 长度|数据 格式的包
	class CDefaultPacketHandler : public ISocketPacketHandler
	{
	public:
		CDefaultPacketHandler();
		~CDefaultPacketHandler();

	public:
	public:
		virtual sint32 getPackHeaderLen();
		virtual sint32 canUnpacket();
		virtual bool unpacket(CNetSocketLoopTask* task, char* packBuff, sint32 packBuffLen, char* packBuffTempRead, sint32 packBuffTempReadLen);
	};
}
#endif