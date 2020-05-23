#include "debug_control.h"
#include "mutex.h"

namespace GXMISC
{
	bool CDebugControl::isHandler( TUniqueIndex_t index )
	{
		if(!_handlerFlag)
		{
			return false;
		}
		
		CAutoMutex<> lock(_lock);
		return _handlerAry.find(index) != _handlerAry.end();
	}

	void CDebugControl::addHandler( TUniqueIndex_t index )
	{
		CAutoMutex<> lock(_lock);
		_handlerFlag = true;
		_handlerAry.insert(TDebugHandlerHash::value_type(index, 123));
	}

	void CDebugControl::setTaskVar( bool val )
	{
		_taskVar = val;
	}

	bool CDebugControl::getTaskVar()
	{
		return _taskVar;
	}

	void CDebugControl::setSocketProfileVar( bool val )
	{
		_socketProfileVar = val;
	}

	bool CDebugControl::getSocketProfileVar()
	{
		return _socketProfileVar;
	}

	void CDebugControl::setDatabaseProfileVar( bool val )
	{
		_databaseProfileVar = val;
	}

	bool CDebugControl::getDatabaseProfileVar()
	{
		return _databaseProfileVar;
	}

	void CDebugControl::setTaskProfileVar( bool val )
	{
		_taskProfileVar = val;
	}

	bool CDebugControl::getTaskProfileVar()
	{
		return _taskProfileVar;
	}

	void CDebugControl::setSocketLoopProfileVar( bool val )
	{
		_socketLoopProfileVar = val;
	}

	bool CDebugControl::getSocketLoopProfileVar()
	{
		return _socketLoopProfileVar;
	}

	void CDebugControl::setTaskBlockAllocVar( bool val )
	{
		_taskBlockAllocVar = val;
	}

	bool CDebugControl::getTaskBlockAllocVar()
	{
		return _taskBlockAllocVar;
	}

	void CDebugControl::setSocketBufferVar( bool val )
	{
		_socketBufferVar = val;
	}

	bool CDebugControl::getSocketBufferVar()
	{
		return _socketBufferVar;
	}

	CDebugControl::CDebugControl() : _lock("DebugControl")
	{
		_taskVar = false;											
		_socketProfileVar = false;									
		_databaseProfileVar = false;								
		_taskProfileVar = false;									
		_socketLoopProfileVar = false;								
		_taskBlockAllocVar = false;									
		_socketBufferVar = false;
		_handlerFlag = false;
		_mainLoopProfileVar = false;
        _serviceStop = false;
	}

	CDebugControl::~CDebugControl()
	{

	}

	void CDebugControl::setMainLoopProfileVar( bool val )
	{
		_mainLoopProfileVar = val;
	}

	bool CDebugControl::getMainLoopProfileVar()
	{
		return _mainLoopProfileVar;
	}

    void CDebugControl::setServiceStopVar(bool val)
    {
        _serviceStop = val;
    }

    bool CDebugControl::getServiceStopVar()
    {
        return _serviceStop;
    }
}