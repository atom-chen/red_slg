#ifndef _SOCKET_HANDLER_H_
#define _SOCKET_HANDLER_H_

#include "types_def.h"

#include "handler.h"
#include "base_util.h"
#include "socket_util.h"
#include "interface.h"
#include "net_task.h"
#include "socket_packet_handler.h"
#include "hash_util.h"
#include "carray.h"
#include "stream_impl.h"
#include "socket_event_loop_wrap.h"
#include "script_object_base.h"

namespace GXMISC
{
	class CSocketHandler : public IHandler
	{
		friend class CNetModule;

	protected:
		// 禁止在这里面就发送数据
		CSocketHandler();
	public:
		virtual ~CSocketHandler();

	public:
		virtual void reset(){}
		virtual bool isValid();
		virtual void onDelete();
		virtual const std::string getString();

	public:
		void init(CNetLoopWrap* loopWrap, TUniqueIndex_t index);
		void cleanUp();

	public:
		CSocketHandler* getOtherHandler(TUniqueIndex_t socketIndex);
		CMemOutputStream* getBufferStream();
		CNetLoopWrap*	getNetLoopWrap();
		sint32 getWaitSecs();
		void setAddr(const std::string& ip, sint32 port);
		void setRemoteAddr(const std::string& ip, sint32 port);
		sint32 getLocalPort();
		std::string getLocalIp();
		sint32 getRemotePort();
		std::string getRemoteIp();
		TUniqueIndex_t getSocketIndex();
		virtual bool isScriptHandler();

	public:
		// 发送消息
		void send(const char* msg, sint32 len, const char* name = NULL);
		void kick(sint32 secs = 0);
		virtual void breath(GXMISC::TDiffTime_t);
		void flush();
		virtual bool onFlushData(const char* msg, sint32 len);

	public:
		// 发送消息
		template<typename T>
		void send(T& msg)
		{
			gxAssert(!isInvalid());
			if(!isInvalid())
			{
				uint32 len = msg.serialLen();
				if(_dataBuff.maxSize() < (uint32)(len+_dataBuff.size()))
				{
					flush();
				}

				_dataBuff.serial(msg);
			}
		}

		// 广播消息(主要用于一些可以丢失的广播消息, 如聊天，广播, 掉血等)
		template<typename T>
		void broadMsg(const T& msg, const TSockIndexAry& socks)
		{
			if (!socks.empty())
			{
				_netLoop->broadMsg((const char*)&msg, msg.getPackLen(), socks);
			}
		}

	protected:
		CNetLoopWrap* _netLoop;								// 底层循环包装
		CMemOutputStream _dataBuff;							// 数据缓冲区
		TTime_t _lastKickTime;								// 上次被Kick掉的时候
		sint32	_kickSeconds;								// 需要等待多久才能真正断开连接
		std::string _IPStr;									// IP
		sint32 _port;										// 端口 
		std::string _remoteIPStr;							// 远程ip
		sint32 _remotePort;									// 远程端口
	};

	class CDefaultSocketHandler : public CSocketHandler
	{
	public:
		CDefaultSocketHandler() : CSocketHandler(){}
		virtual ~CDefaultSocketHandler(){}
	public:
		virtual bool start(){ return true;}
		virtual EHandleRet handle(char* msg, uint32 len){return HANDLE_RET_OK;}
		virtual void close(){}
	};

	class CScriptSocketHandler : public CSocketHandler
	{
	public:
		typedef CSocketHandler TBaseType;

	public:
		CScriptSocketHandler();
		virtual ~CScriptSocketHandler();

	public:
		virtual bool start();
		virtual EHandleRet handle(char* msg, uint32 len);
		virtual void close();

	public:
		virtual bool initScriptObject(CLuaVM* scriptEngine);

	public:
		virtual bool isScriptHandler();
	};

	typedef struct _SSocketParmHandler
	{
	public:
		_SSocketParmHandler(CSocketHandler* handler1, ISocketPacketHandler* handler2, sint32 tag);
		_SSocketParmHandler();
		virtual ~_SSocketParmHandler();

		void freeAll();
		bool isValid();

	public:
		CSocketHandler* socketHandler;
		ISocketPacketHandler* packetHandler;
		sint32 tag;
	}TSocketParmHandler;
}

#endif