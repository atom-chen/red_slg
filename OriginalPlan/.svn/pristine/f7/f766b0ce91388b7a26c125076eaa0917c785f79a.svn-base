#ifndef _GAME_SOCKET_HANDLER_H_
#define _GAME_SOCKET_HANDLER_H_

#include <map>

//#include <boost/type_traits/is_base_of.hpp>

#include "game_handler.h"

template <typename ClassName>
class CGameSocketHandler :
	public CGameHandler<ClassName>
{
	typedef CGameHandler<ClassName> TBaseType;
protected:
	CGameSocketHandler(){};
	virtual ~CGameSocketHandler(){};

public:
	// 发送
	template<class T, bool flag>
	class _SocketHandlerUtil
	{
	public:
		static void Send(TBaseType& stream, T& packet);
	};
	template<class T>
	class _SocketHandlerUtil<T, true>
	{
	public:
		static void Send(TBaseType& stream, T& packet)
		{
			stream.send(packet);
		}
	};
	template<class T>
	class _SocketHandlerUtil<T, false>
	{
	public:
		static void Send(TBaseType& stream, T& packet)
		{
			stream.send((char*)&packet, packet.getPackLen(), typeid(packet).name());
		}
	};

	// 记录日志
	template<class T, typename LogType>
	class _PacketLog
	{
	public:
		static void Log(T& packet);
	};
	template<class T>
	class _PacketLog<T, uint8>
	{
	public:
		static void Log(T& packet){}
	};
	template<class T>
	class _PacketLog<T, uint32>
	{
	public:
		static void Log(T& packet)
		{
			gxDebug("{0}", packet.toString().c_str());
		}
	};

public:
	template<typename T>
	void sendPacket(T& packet)
	{	
#ifdef LIB_DEBUG
		_PacketLog<T, typename T::_TPackToStringT>::Log(packet);
#endif
		_SocketHandlerUtil<T, std::is_base_of<GXMISC::IStreamable, T>::value 
			|| std::is_base_of<GXMISC::IStreamableAll, T>::value>::Send(*this, packet);
	}

	virtual bool onBeforeHandlePacket(CBasePacket* packet){ return true;}
	virtual bool onAfterHandlePacket(CBasePacket* packet){ return true; }

public:
	GXMISC::TSocketIndex_t getSocketIndex()
	{
		return CGameHandler<ClassName>::getUniqueIndex();
	}

private:
	GXMISC::TUniqueIndex_t getUniqueIndex();
	void setUniqueIndex(GXMISC::TUniqueIndex_t);

protected:
	void send(const void* msg, uint32 len)
	{
		TBaseType::send((char*)msg, len);
	}
};
#endif