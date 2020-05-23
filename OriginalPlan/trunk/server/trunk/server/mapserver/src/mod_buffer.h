#ifndef _MOD_BUFFER_H_
#define _MOD_BUFFER_H_

//#include "buffer_manager.h"
#include "game_module.h"

class CModBuffer : public CGameRoleModule
{
public:
	CModBuffer();
	~CModBuffer();

public:
	virtual bool onLoad();
	virtual void onSave(bool offLineFlag);
	virtual void onSendData();
	virtual void update(GXMISC::TDiffTime_t diff);

public:
//	CBufferManager* getBufferMgr();

private:
//	CBufferManager _bufferMgr;
};

#endif	// _MOD_BUFFER_H_