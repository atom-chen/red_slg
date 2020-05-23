#ifndef _OBJ_DYNAMIC_H_
#define _OBJ_DYNAMIC_H_

#include "object.h"

class CDynamicObject : public CGameObject	
{
public:
	typedef CGameObject TBaseType;

protected:
	CDynamicObject() : TBaseType() {}
public:
	virtual ~CDynamicObject( ){}

public:
	virtual void cleanUp(){ TBaseType::cleanUp(); }
	virtual bool init( const TObjInit* objInit ){ return TBaseType::init(objInit); }
	virtual bool update( uint32 diff ){ return TBaseType::update(diff); }
	virtual bool updateOutBlock( uint32 diff ){ return TBaseType::updateOutBlock(diff); }
};
#endif