#ifndef _GM_MANAGER_H_
#define _GM_MANAGER_H_

#include <string>

#include "game_util.h"

#include "core/hash_util.h"

class CRole;

// GMȨ�޵ȼ�����ͨ���Ȩ��Ϊ0�����Ȩ��Ϊ9
enum EGmPowerLevel
{
	GM_POWER_INVALID = 0,
	GM_POWER_LEVEL_1,
	GM_POWER_LEVEL_2,
	GM_POWER_LEVEL_3,
	GM_POWER_LEVEL_4,
	GM_POWER_LEVEL_5,
	GM_POWER_DEBUG,
};

typedef EGameRetCode (*Func)(CRole*);
struct TGMFunc
{
	Func			pFuncName;		// ������
	TGmPower_t		powerLev;		// Ȩ��
	std::string		name;			// ����
	std::string		comment;		// ע��
	bool			isHelpShow;		// �����������Ƿ���ʾ
	TGMFunc() : pFuncName(NULL),powerLev((TGmPower_t)GM_POWER_INVALID) {}
	TGMFunc( Func pFunc, TGmPower_t power, const std::string& cmdName, const std::string& comments, bool isShow) :
	pFuncName(pFunc), powerLev(power), name(cmdName), comment(comments), isHelpShow(isShow) {}
};

class CGmCmdFunc : public GXMISC::CManualSingleton<CGmCmdFunc>
{
public:
	typedef CHashMap<uint32, TGMFunc>	FuncMap;
	typedef FuncMap::iterator			FuncMapItr;
	DSingletonImpl();

public:
	CGmCmdFunc();
	~CGmCmdFunc();

public:
	EGameRetCode		parse( CRole* pRole, TGmCmdStr_t& str );
	void				init( const std::string& str );

private:
	std::string			_gmHeadStr;
};

#define DGmCmdMgr CGmCmdFunc::GetInstance()

#endif	// _GM_MANAGER_H_