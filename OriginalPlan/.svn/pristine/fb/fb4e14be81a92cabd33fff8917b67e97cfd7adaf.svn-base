#ifndef _LOGIN_STATUS_H_
#define _LOGIN_STATUS_H_

#include "core/time_util.h"
#include "game_util.h"

/**
 * 请求等待队列
 * 作用及实现:
 *       1. 添加请求
 *       2. 过滤重复及互斥请求(比如说:退出的时候不能请求切线)
 *       3. 重复及互斥的请求必须要能提示对应的错误码
 *       4. 请求可以超时
 *       5. 请求的回调函数可以是脚本
 *		 6. 请求可以是继承于TimeWaiter对象
 *       7. 处理响应, 响应处理完后从队列中删除
 */

/// 等待对象
class CTimeWaiter
{
public:
	CTimeWaiter();
	virtual ~CTimeWaiter();

public:
	void cleanup();

public:
	GXMISC::TGameTime_t getStartTime() const { return _startTime; }
	void setStartTime(GXMISC::TGameTime_t val) { _startTime = val; }
	GXMISC::TGameTime_t getWaitTime() const { return _waitTime; }
	void setWaitTime(GXMISC::TGameTime_t val) { _waitTime = val; }

public:
	void update(GXMISC::TDiffTime_t diff);

public:
	virtual bool isTimeout();

private:
	GXMISC::TGameTime_t _startTime;
	GXMISC::TGameTime_t _waitTime;
};

/// 登陆等待对象
class CLoginWaiter //: public CTimeWaiter
{
public:
	CLoginWaiter();
	~CLoginWaiter();

public:
	void cleanup();

public:
	ELoadRoleType getLoadType() const { return _loadType; }
	void setLoadType(ELoadRoleType val) { _loadType = val; }
	GXMISC::TSocketIndex_t getSocketIndex() const { return _socketIndex; }
	void setSocketIndex(GXMISC::TSocketIndex_t val) { _socketIndex = val; }

private:
	ELoadRoleType _loadType;				///< 加载数据类型
	GXMISC::TSocketIndex_t _socketIndex;	///< 世界服务器玩家Socket标识
};
typedef std::list<CLoginWaiter> TLoginWaiterList;

/// 登出等待对象
class CLogoutWaiter //: public CTimeWaiter
{
public:
	CLogoutWaiter();
	~CLogoutWaiter();

public:
	void cleanup();

public:
	EUnloadRoleType getUnloadType() const { return _unloadType; }
	void setUnloadType(EUnloadRoleType val) { _unloadType = val; }
	bool getNeedRet() const { return _needRet; }
	void setNeedRet(bool val) { _needRet = val; }
	GXMISC::TSocketIndex_t getSocketIndex() const { return _socketIndex; }
	void setSocketIndex(GXMISC::TSocketIndex_t val) { _socketIndex = val; }

private:
	EUnloadRoleType _unloadType;			///< 释放数据类型
	bool _needRet;							///< 是否需要返回消息
	GXMISC::TSocketIndex_t _socketIndex;	///< 世界服务器玩家Socket标识
};
typedef std::list<CLogoutWaiter> TLogoutWaiterList;

/// 登陆登出管理器
class CLoginWaiterManager
{
public:
	void push(ELoadRoleType loadType, GXMISC::TSocketIndex_t index);
	void push(EUnloadRoleType unLoadType, bool needRet, GXMISC::TSocketIndex_t index);

public:
	bool isLogin();
	bool isLogout();

public:
	void onLogin(ELoadRoleType loadType, GXMISC::TSocketIndex_t index);
	void onLogout(EUnloadRoleType unLoadType, GXMISC::TSocketIndex_t index);

private:
	TLoginWaiterList _loginWaiters;
	TLogoutWaiterList _logoutWaiters;
};

#endif	// _LOGIN_STATUS_H_