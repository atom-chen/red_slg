
template<typename HandlerType, typename PacketHandlerType>
bool GXMISC::GxService::openServerListener( const char* hosts, TPort_t port, sint32 tag )
{
	return _openListener<HandlerType, PacketHandlerType, GXMISC::CDefaultSocketServerListener<HandlerType, PacketHandlerType> >(hosts, port, tag);
}
template<typename HandlerType, typename PacketHandlerType>
bool GxService::openClientListener( const char* hosts, TPort_t port, sint32 tag )
{
	return _openListener<HandlerType, PacketHandlerType, GXMISC::CDefaultSocketServerListener<HandlerType, PacketHandlerType> >(hosts, port, tag);
}
template<typename HandlerType, typename PacketHandlerType, typename P1, typename P2, typename P3, typename P4, typename P5>
bool GXMISC::GxService::openServerConnector( const char* hosts, TPort_t port, uint32 diff, sint32 tag, P1& p1, P2& p2, P3& p3, P4& p4, P5& p5, bool blockFlag )
{
	return _openConnector<HandlerType, PacketHandlerType, GXMISC::CDefaultSocketConnector5<HandlerType, PacketHandlerType, P1, P2, P3, P4, P5>, P1, P2, P3, P4, P5>
		(hosts, port, diff, tag, p1, p2, p3, p4, p5, blockFlag);
}
template<typename HandlerType, typename PacketHandlerType, typename P1, typename P2, typename P3, typename P4>
bool GXMISC::GxService::openServerConnector( const char* hosts, TPort_t port, uint32 diff, sint32 tag, P1& p1, P2& p2, P3& p3, P4& p4, bool blockFlag )
{
	return _openConnector<HandlerType, PacketHandlerType,  GXMISC::CDefaultSocketConnector4<HandlerType, PacketHandlerType, P1, P2, P3, P4>, P1, P2, P3, P4>
		(hosts, port, diff, tag, p1, p2, p3, p4, blockFlag);
}
template<typename HandlerType, typename PacketHandlerType, typename P1, typename P2, typename P3>
bool GXMISC::GxService::openServerConnector( const char* hosts, TPort_t port, uint32 diff, sint32 tag, P1& p1, P2& p2, P3& p3, bool blockFlag )
{
	return _openConnector<HandlerType, PacketHandlerType,  GXMISC::CDefaultSocketConnector3<HandlerType, PacketHandlerType, P1, P2, P3>, P1, P2, P3>
		(hosts, port, diff, tag, p1, p2, p3, blockFlag);
}
template<typename HandlerType, typename PacketHandlerType, typename P1, typename P2>
bool GXMISC::GxService::openServerConnector( const char* hosts, TPort_t port, uint32 diff, sint32 tag, P1& p1, P2& p2, bool blockFlag )
{
	return _openConnector<HandlerType, PacketHandlerType,  GXMISC::CDefaultSocketConnector2<HandlerType, PacketHandlerType, P1, P2>, P1, P2>
		(hosts, port, diff, tag, p1, p2, blockFlag);
}
template<typename HandlerType, typename PacketHandlerType, typename P1>
bool GXMISC::GxService::openServerConnector( const char* hosts, TPort_t port, uint32 diff, sint32 tag, P1 p1, bool blockFlag )
{
	return _openConnector<HandlerType, PacketHandlerType,  GXMISC::CDefaultSocketConnector1<HandlerType, PacketHandlerType, P1>, P1>(hosts, port, diff, tag, p1, blockFlag);
}
template<typename HandlerType, typename PacketHandlerType>
bool GXMISC::GxService::openServerConnector( const char* hosts, TPort_t port, uint32 diff, sint32 tag, bool blockFlag )
{
	return _openConnector<HandlerType, PacketHandlerType,  GXMISC::CDefaultSocketConnector<HandlerType, PacketHandlerType> >(hosts, port, diff, tag, blockFlag);
}
template<typename HandlerType, typename PacketHandlerType, typename P1, typename P2, typename P3, typename P4, typename P5>
bool GXMISC::GxService::openClientConnector( const char* hosts, TPort_t port, uint32 diff, sint32 tag, P1& p1, P2& p2, P3& p3, P4& p4, P5& p5, bool blockFlag )
{
	return _openConnector<HandlerType, PacketHandlerType, GXMISC::CDefaultSocketConnector5<HandlerType, PacketHandlerType, P1, P2, P3, P4, P5 >, P1, P2, P3, P4, P5>
		(hosts, port, diff, tag, p1, p2, p3, p4, p5, blockFlag);
}
template<typename HandlerType, typename PacketHandlerType, typename P1, typename P2, typename P3, typename P4>
bool GXMISC::GxService::openClientConnector( const char* hosts, TPort_t port, uint32 diff, sint32 tag, P1& p1, P2& p2, P3& p3, P4& p4, bool blockFlag )
{
	return _openConnector<HandlerType, PacketHandlerType, GXMISC::CDefaultSocketConnector4<HandlerType, PacketHandlerType, P1, P2, P3, P4>, P1, P2, P3, P4>
		(hosts, port, diff, tag, p1, p2, p3, p4, blockFlag);
}
template<typename HandlerType, typename PacketHandlerType, typename P1, typename P2, typename P3>
bool GXMISC::GxService::openClientConnector( const char* hosts, TPort_t port, uint32 diff, sint32 tag, P1& p1, P2& p2, P3& p3, bool blockFlag )
{
	return _openConnector<HandlerType, PacketHandlerType, GXMISC::CDefaultSocketConnector3<HandlerType, PacketHandlerType, P1, P2, P3>, P1, P2, P3>
		(hosts, port, diff, tag, p1, p2, p3, blockFlag);
}
template<typename HandlerType, typename PacketHandlerType, typename P1, typename P2>
bool GXMISC::GxService::openClientConnector( const char* hosts, TPort_t port, uint32 diff, sint32 tag, P1& p1, P2& p2, bool blockFlag )
{
	return _openConnector<HandlerType, PacketHandlerType, GXMISC::CDefaultSocketConnector2<HandlerType, PacketHandlerType, P1, P2>, P1, P2>
		(hosts, port, tag, diff, p1, p2, blockFlag);
}
template<typename HandlerType, typename PacketHandlerType, typename P1>
bool GXMISC::GxService::openClientConnector( const char* hosts, TPort_t port, uint32 diff, sint32 tag, P1& p1, bool blockFlag )
{
	return _openConnector<HandlerType, PacketHandlerType, GXMISC::CDefaultSocketConnector1<HandlerType, PacketHandlerType, P1>, P1>(hosts, port, diff, tag, p1, blockFlag);
}
template<typename HandlerType, typename PacketHandlerType>
bool GXMISC::GxService::openClientConnector( const char* hosts, TPort_t port, uint32 diff, sint32 tag, bool blockFlag )
{
	return _openConnector<HandlerType, PacketHandlerType, GXMISC::CDefaultSocketConnector<HandlerType, PacketHandlerType> >(hosts, port, diff, tag, blockFlag);
}

template<typename HandlerType, typename PacketHandlerType, typename ListenerType>
bool GXMISC::GxService::_openListener( const char* hosts, TPort_t port, sint32 tag )
{
	CSocketListener* listener = new ListenerType(getNetMgr(), hosts, port, tag);
	if(false == listener->start())
	{
		ListenerType* ptr=(ListenerType*)listener;	
		DSafeDelete(ptr);
		return false;
	}

	if(false == getNetMgr()->addListener(listener))
	{
		DSafeDelete(listener);
		return false;
	}

	gxInfo("Open listener: hosts = {0}, port = {1}\n", hosts, port);

	return true;
}

template<typename HandlerType, typename PacketHandlerType, typename ListenerType, typename P>
bool GXMISC::GxService::_openListener( const char* hosts, TPort_t port, sint32 tag, P& p)
{
	CSocketListener* listener = new ListenerType(getNetMgr(), hosts, port, tag, p);
	if(false == listener->start())
	{
		ListenerType* ptr=(ListenerType*)listener;	
		DSafeDelete(ptr);
		return false;
	}

	if(false == getNetMgr()->addListener(listener))
	{
		DSafeDelete(listener);
		return false;
	}

	gxInfo("Open listener: hosts = {0}, port = {1}\n", hosts, port);

	return true;
}

template<typename HandlerType, typename PacketHandlerType, typename ConnectorType>
bool GxService::_openConnector( const char* hosts, TPort_t port, uint32 diff, sint32 tag, bool blockFlag)
{
	CSocketConnector* connector = new ConnectorType(tag);
	if(false == connector->create())
	{
		DSafeDelete(connector);
		return false;
	}

	if(!_addConnector(hosts, port, diff, connector, blockFlag))
	{
		DSafeDelete(connector);
		return false;
	}

	gxInfo("Add connector: host = {0}, port = {1}", hosts, port);

	return true;
}

template<typename HandlerType, typename PacketHandlerType, typename ConnectorType, typename P1>
bool GxService::_openConnector(const char* hosts, TPort_t port, uint32 diff, sint32 tag, P1 p1, bool blockFlag)
{
	CSocketConnector* connector = new ConnectorType(tag, p1);
	if(false == connector->create())
	{
		DSafeDelete(connector);
		return false;
	}

	if(!_addConnector(hosts, port, diff, connector, blockFlag))
	{
		DSafeDelete(connector);
		return false;
	}

	gxInfo("Add connector: host = {0}, port = {1}", hosts, port);

	return true;
}

template<typename HandlerType, typename PacketHandlerType, typename ConnectorType, typename P1, typename P2>
bool GxService::_openConnector(const char* hosts, TPort_t port, uint32 diff, sint32 tag, P1& p1, P2& p2, bool blockFlag)
{
	CSocketConnector* connector = new ConnectorType(tag, p1, p2);
	if(false == connector->create())
	{
		DSafeDelete(connector);
		return false;
	}

	if(!_addConnector(hosts, port, diff, connector, blockFlag))
	{
		DSafeDelete(connector);
		return false;
	}

	gxInfo("Add connector: host = {0}, port = {1}", hosts, port);

	return true;
}

template<typename HandlerType, typename PacketHandlerType, typename ConnectorType, typename P1, typename P2, typename P3>
bool GxService::_openConnector(const char* hosts, TPort_t port, uint32 diff, sint32 tag, P1& p1, P2& p2, P3& p3, bool blockFlag)
{
	ConnectorType* connector = new ConnectorType(tag, p1, p2, p3);
	if(false == connector->create())
	{
		DSafeDelete(connector);
		return false;
	}

	if(!_addConnector(hosts, port, diff, connector, blockFlag))
	{
		DSafeDelete(connector);
		return false;
	}

	gxInfo("Add connector: host = {0}, port = {1}", hosts, port);

	return true;
}

template<typename HandlerType, typename PacketHandlerType, typename ConnectorType, typename P1, typename P2, typename P3, typename P4>
bool GxService::_openConnector(const char* hosts, TPort_t port, uint32 diff, sint32 tag, P1& p1, P2& p2, P3& p3, P4& p4, bool blockFlag)
{
	CSocketConnector* connector = new ConnectorType(tag, p1, p2, p3, p4);
	if(false == connector->create())
	{
		DSafeDelete(connector);
		return false;
	}

	if(!_addConnector(hosts, port, diff, connector, blockFlag))
	{
		DSafeDelete(connector);
		return false;
	}

	gxInfo("Add connector: host = {0}, port = {1}", hosts, port);

	return true;
}

template<typename HandlerType, typename PacketHandlerType, typename ConnectorType, typename P1, typename P2, typename P3, typename P4, typename P5>
bool GxService::_openConnector(const char* hosts, TPort_t port, uint32 diff, sint32 tag, P1& p1, P2& p2, P3& p3, P4& p4, P5& p5, bool blockFlag)
{
	CSocketConnector* connector = new ConnectorType(tag, p1, p2, p3, p4, p5);
	if(false == connector->create())
	{
		DSafeDelete(connector);
		return false;
	}

	if(!_addConnector(hosts, port, diff, connector, blockFlag))
	{
		DSafeDelete(connector);
		return false;
	}

	gxInfo("Add connector: host = {0}, port = {1}", hosts, port);

	return true;
}