#ifndef _AREA_H_
#define _AREA_H_

#include "core/carray.h"

#include "game_util.h"
#include "game_struct.h"

class CArea
{
private:
	TAreaID_t   _areaID;
	TScriptID_t _scriptID;
	TAreaRect   _areaRect;

public:
	CArea()
	{
		cleanUp() ;
	}

	void cleanUp( )
	{
		_areaID     = INVALID_AREA_ID;
		_scriptID   = INVALID_SCRIPT_ID;
		_areaRect.cleanUp( ) ;
	}

	bool isContain( TAxisPos_t x, TAxisPos_t y ) const
	{
		return _areaRect.isContain( x, y );
	}
};

typedef std::vector<CArea> TAreaList;
class CAreaManager
{
	// public :
	//     CAreaManager( void );
	//     ~CAreaManager( void );
	// 
	//     bool init( const char *pathName );
	//     void term( void );
	// 
	//     void setScene( CMapScene* pScene ) { gxAssert( pScene ); _mapScene = pScene; }
	//     TBlockID_t getBlockID( TAxisPos_t x, TAxisPos_t y );
	// 
	//     void addArea(CArea& area);
	// 
	// protected:
	//     TAreaList _areaList;
	//     CMapScene* _mapScene;
};

#endif