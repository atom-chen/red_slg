#include "handler.h"


namespace GXMISC
{
	const char* IHandler::getName()
	{
		return "";
	}
    void IHandler::setInvalid()
    {
        _invalid = true;
    }

    GXMISC::TUniqueIndex_t IHandler::getUniqueIndex()
    {
        return _index;
    }

    void IHandler::setUniqueIndex( TUniqueIndex_t index )
    {
        _index = index;
    }

	IHandler::IHandler(const IAllocatable* allocable, TUniqueIndex_t index) : _allocable(const_cast<IAllocatable*>(allocable)), _index(index)
    {
        _index = INVALID_UNIQUE_INDEX;
        _invalid = false;
        _startFlag = false;
    }

    IHandler::~IHandler()
    {
        _index = INVALID_UNIQUE_INDEX;
        _allocable = NULL;
        _invalid = true;
		_startFlag = false;
    }

	void IHandler::setParam(const IAllocatable* allocable, TUniqueIndex_t index)
    {
		_allocable = const_cast<IAllocatable*>(allocable);
        _index = index;
        _invalid = false;
    }

    bool IHandler::isInvalid()
    {
        return _invalid;
    }

	void IHandler::setStarted()
	{
		_startFlag = true;
	}

	bool IHandler::isStarted()
	{
		return _startFlag;
	}

	//void IHandler::freeObj( void* arg )
	//{
	//	_allocable->freeArg(arg);
	//}

}