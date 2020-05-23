#ifndef _MAP_DATA_H_
#define _MAP_DATA_H_

#include "map_data_base.h"

class CMap : public CMapBase
{
public:
	CMap(){}
	~CMap(){}

public:
	virtual uint8 getMapType();

private:

};

#endif	// _MAP_DATA_H_