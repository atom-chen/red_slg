#ifndef _WORLD_LOGIN_PLAYER_MGR_H_
#define _WORLD_LOGIN_PLAYER_MGR_H_

#include "game_util.h"
#include "packet_struct.h"
#include "server_define.h"
#include "world_login_role_list.h"

#include "core/multi_index.h"
#include "core/obj_mem_fix_pool.h"
#include "core/time_util.h"

class CWorldDbHandler;
class CWorldPlayerHandler;
class CWorldPlayer;

/**
* @brief 排队等待登陆的玩家, 此玩家等待同账号对象下线才能登陆
*/
class CLoginPlayer {
public:
	CLoginPlayer();
	~CLoginPlayer();

public:
	void doLoginOutTime(GXMISC::TGameTime_t curTime);
	void setAccountID(TAccountID_t accoutID);
	void setDbIndex(GXMISC::TDbIndex_t dbIndex);
	void setSocketIndex(GXMISC::TSocketIndex_t index);
	void setLoginRoleList(TLoginRoleArray& roleList);
	void setLoginKey(TLoginKey_t loginKey);
	TSourceWayID_t getSourceWay() const { return _sourceWay; }
	void setSourceWay(TSourceWayID_t val) { _sourceWay = val; }
	TSourceWayID_t getChisourceWay() const { return _chisourceWay; }
	void setChisourceWay(TSourceWayID_t val) { _chisourceWay = val; }
	TGmPower_t getGmPower() const { return _gmPower; }
	void setGmPower(TGmPower_t val) { _gmPower = val; }

public:
	bool isNeedDelete()
	{
		return _isNeedDelete;
	}
	void setDelete() {
		_isNeedDelete = true;
	}
	bool isDelete() {
		return _isNeedDelete;
	}
	bool isTimeOut(GXMISC::TGameTime_t curTime);
	GXMISC::TSocketIndex_t getSocketIndex() {
		return _socketIndex;
	}
	TAccountID_t getAccountID() {
		return _accountID;
	}
	GXMISC::TDbIndex_t getDbIndex() {
		return _dbIndex;
	}
	TLoginRoleArray& getLoginRoleList() {
		return _roleList;
	}

	void waitLogin(GXMISC::TSocketIndex_t index, TAccountID_t accountID, TLoginRoleArray& roleList, 
		GXMISC::TDbIndex_t dbIndex);
	void kickByOtherPlayer();
	void otherPlayerOffline();
	CWorldPlayerHandler* getWorldPlayerHandler();
	CWorldDbHandler* getWorldDbHandler();
	CWorldPlayer* getWorldPlayer(bool logFlag = true);
	void setNeedReLogin(bool flag);
	void doReLogin(GXMISC::TGameTime_t currTime);
	void setLoginQuick(bool flag);
	bool getLoginQuick();
	void setSourceWay(TSourceWayID_t sourceWay, TSourceWayID_t chisourceWay);

public:
	void update(GXMISC::TDiffTime_t diff);
	void quit();

private:
	GXMISC::TGameTime_t _loginTime;			// 登陆时间
	GXMISC::TSocketIndex_t _socketIndex;	// Socket标识
	TAccountID_t _accountID;				// 账号ID
	GXMISC::TDbIndex_t _dbIndex;			// 数据库账号
	TLoginKey_t _loginKey;					// 登陆Key
	TSourceWayID_t _sourceWay;				// 渠道
	TSourceWayID_t _chisourceWay;			// 子渠道
	TGmPower_t _gmPower;					// GM权限
	bool _isNeedReLogin;					// 是否需要重新登陆
	GXMISC::TGameTime_t _lastReloginTime;	// 上次需重登陆时间
	bool _isNeedDelete;						// 是否需要删除
	TLoginRoleArray _roleList;				// 角色列表
	bool _quickLoginFlag;					// 快速登陆标记

public:
	DMultiIndexImpl1(GXMISC::TSocketIndex_t, _socketIndex, GXMISC::INVALID_SOCKET_INDEX);
	DMultiIndexImpl2(TAccountID_t, _accountID, INVALID_ACCOUNT_ID);

	DFastObjToString3Alias(CLoginPlayer, GXMISC::TSocketIndex_t, DSocketIndex, _socketIndex, TAccountID_t,
		DAccountID, _accountID, GXMISC::TDbIndex_t, DDbIndex, _dbIndex);
};

// 登陆等待队列
class CLoginPlayerMgr : public GXMISC::CHashMultiIndex2<CLoginPlayer>,
	public GXMISC::CManualSingleton<CLoginPlayerMgr> {
public:
	typedef GXMISC::CHashMultiIndex<CLoginPlayer> TBaseType;
	DSingletonImpl();
	DMultiIndexIterFunc(CLoginPlayer);

public:
	CLoginPlayerMgr() {
		_lastHandleLoginPlayerTime = DTimeManager.nowSysTime();
	}
	~CLoginPlayerMgr() {
	}

	bool init(uint32 num);

public:
	void update(GXMISC::TDiffTime_t diff);

public:
	bool isExistBySocketIndex(GXMISC::TSocketIndex_t index);
	bool isExistByAccountID(TAccountID_t id);
	TBaseType::ValueType findBySocketIndex(GXMISC::TSocketIndex_t index);
	TBaseType::ValueType findByAccountID(TAccountID_t id);
	TBaseType::ValueType addPlayer(GXMISC::TSocketIndex_t index, TAccountID_t accountID,
		TLoginRoleArray& roleList, GXMISC::TDbIndex_t dbIndex);
	void freePlayer(TBaseType::ValueType val);
	void delPlayerBySocketIndex(GXMISC::TSocketIndex_t index);
	void delPlayerByAccountID(TAccountID_t id);

private:
	GXMISC::CFixObjPool<CLoginPlayer> _objPool;			// 玩家对像池
	GXMISC::TGameTime_t _lastHandleLoginPlayerTime;		// 上次处理登陆玩家的时间
	sint32 _loginPlayerNum;								// 登陆玩家数目
};

#define DLoginPlayerMgr CLoginPlayerMgr::GetInstance()

#endif
