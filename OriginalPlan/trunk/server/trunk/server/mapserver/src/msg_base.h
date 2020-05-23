#ifndef _MSG_BASE_H_
#define _MSG_BASE_H_

#include "game_util.h"

class CRole;
class CMsgCallBackRetCode;

#define MSGRETCODE_CALLBACK(retcode, prole) \
	if(!prole)\
{\
	gxError("msg retcode callback role is null");\
	return;\
}\
	CMsgBase::handleCallBack(retcode, prole);\

#define MSGRETCODE_CALLBACK_EX(retcode, prole) \
	if(!prole)\
{\
	gxError("msg retcode callback role is null");\
	return RC_FAILED;\
}\
	CMsgBase::handleCallBack(retcode, prole);\

class CMsgBase
{
public:
	CMsgBase();
	virtual ~CMsgBase();

public:
	void setRole(CRole* pRole);
	CRole* getRole();

public:
	//·µ»Ø´íÎóÂë
	static void handleCallBack(EGameRetCode retcode, CRole* prole);

private:
	CRole* _pRole;
};

#endif	// _MSG_BASE_H_