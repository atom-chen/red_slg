#include "core/game_exception.h"

#include "role_base.h"
#include "module_def.h"
#include "map_server_util.h"
#include "map_server_instance_base.h"
#include "map_db_player_handler_base.h"
#include "map_scene_base.h"
//#include "../../mapserver/src/script_engine.h"

CRoleBase::CRoleBase()
{
	cleanUp();
}

CRoleBase::~CRoleBase()
{
}

void CRoleBase::cleanUp()
{
	TBaseType::cleanUp();

	_loginTime = GXMISC::MAX_GAME_TIME;
	_logoutTime = GXMISC::MAX_GAME_TIME;
	_socketIndex = GXMISC::INVALID_SOCKET_INDEX;
	_roleNode.setObj(this);
	_sceneGroupID = INVALID_SCENE_GROUP_ID;
	_loginPlayerSockIndex = GXMISC::INVALID_SOCKET_INDEX;

// 	ERoleStatus						_status;						// 角色状态 @TODO
// 	TRoleUID_t						_roleUID;						// 角色UID	
// 	TAccountID_t					_accountID;						// 账号UID	
// 	bool							_isAdult;						// 是否成年人
// 	GXMISC::TGameTime_t				_lastAgainstIndulgeNoticeTime;	// 上次防沉迷提示时间
// 	GXMISC::TDiffTime_t				_lastAgainstIndulgeTime;		// 上次防沉迷时间
// 	bool							_isOffOverDay;					// 是否离线过天
// 	TGmPower_t						_gmPower;						// GM权限
// 	TObjListNode					_roleNode;						// 在Block中的结点
// 	TSceneGroupID_t					_sceneGroupID;					// 在场景里的ID
// 
// 	// 通讯及数据库交互信息
// private:
// 	GXMISC::TGameTime_t				_loginTime;						// 登陆时间
// 	GXMISC::TDiffTime_t				_loginLastTime;					// 登陆持续时间
// 	GXMISC::TGameTime_t				_logoutTime;					// 登出时间
// 	GXMISC::TGameTime_t             _readyTime;                     // 放入登陆队列的时间
// 	GXMISC::TDiffTime_t				_logoutLastTime;				// 登出持续时间
// 	GXMISC::TGameTime_t				_enterGameTime;					// 进入游戏的时间
// 	GXMISC::TSocketIndex_t			_socketIndex;					// Socket索引
// 	GXMISC::TDbIndex_t				_dbIndex;						// Db索引
// 	EManagerQueType					_queType;						// 队列类型
// 	bool							_needQuitRet;					// 退出是否需要返回
// 	GXMISC::TSocketIndex_t          _worldPlayerSockIndex;          // 世界服务器Player对象的唯一标识
// 	TSaveIndex_t                    _dbUpdateSaveIndex;             // 定时保存数据标识
// 	GXMISC::TGameTime_t             _lastSaveTime;					// 上一次更新时间
// 	bool							_updateSaveDirty;				// 更新脏标记
}

bool CRoleBase::init( const TCharacterInit* inits )
{
	TBaseType::init(inits);

	return true;
}

bool CRoleBase::update( GXMISC::TDiffTime_t diff )
{
	TBaseType::update(diff);

	return true;
}

bool CRoleBase::updateOutBlock( GXMISC::TDiffTime_t diff )
{
	TBaseType::updateOutBlock(diff);

	return true;
}

void CRoleBase::setSocketIndex( GXMISC::TSocketIndex_t sockIndex )
{
	_socketIndex = sockIndex;
}

GXMISC::TSocketIndex_t CRoleBase::getSocketIndex() const
{
	return _socketIndex;
}

void CRoleBase::setDbIndex( GXMISC::TDbIndex_t dbIndex )
{
	_dbIndex = dbIndex;
}

GXMISC::TDbIndex_t CRoleBase::getDbIndex() const
{
	return _dbIndex;
}

void CRoleBase::setManagerQueType( EManagerQueType type )
{
	_queType = type;
}

EManagerQueType CRoleBase::getManagerQueType() const
{
	return _queType;
}

void CRoleBase::setQuitRet( bool retFlag )
{
	_needQuitRet = retFlag;
}

bool CRoleBase::getQuitRet() const
{
	return _needQuitRet;
}

void CRoleBase::setLoginPlayerSocketIndex( GXMISC::TSocketIndex_t index )
{
	_loginPlayerSockIndex = index;
}

GXMISC::TSocketIndex_t CRoleBase::getLoginPlayerSocketIndex() const
{
	return _loginPlayerSockIndex;
}

void CRoleBase::setDbSaveIndex( TSaveIndex_t index )
{
	_dbUpdateSaveIndex = index;
}

TSaveIndex_t CRoleBase::getDbSaveIndex() const
{
	return _dbUpdateSaveIndex;
}

void CRoleBase::setLastSaveTime( GXMISC::TGameTime_t times )
{
	_lastSaveTime = times;
}

GXMISC::TGameTime_t CRoleBase::getLastSaveTime() const
{
	return _lastSaveTime;
}

void CRoleBase::setUpdateSaveDirty( bool dirty )
{
	_updateSaveDirty = dirty;
}

bool CRoleBase::getUpdateSaveDirty() const
{
	return _updateSaveDirty;
}

void CRoleBase::setIPAddress(std::string straddress)
{
	_macAddress = straddress; 
}

std::string CRoleBase::getIPAddress() const 
{
	return _macAddress; 
}

CMapPlayerHandlerBase* CRoleBase::getPlayerHandlerBase(bool logFlag /* = true */ )
{
	CMapPlayerHandlerBase* handler = dynamic_cast<CMapPlayerHandlerBase*>(DMapNetMgr->getSocketHandler(getSocketIndex()));
	if(NULL == handler && logFlag)
	{
		gxError("Can't find CMapPlayerHandlerBase! {0}", toString());
		return NULL;
	}

	return handler;
}

bool CRoleBase::isTimeOutForLogout()
{
	if(_logoutTime == GXMISC::MAX_GAME_TIME)
	{
		return false;
	}

	return GXMISC::TDiffTime_t(DTimeManager.nowSysTime()-_logoutTime) > _logoutLastTime;
}

bool CRoleBase::isTimeOutForReady()
{
	if(_loginTime == GXMISC::MAX_GAME_TIME)
	{
		return false;
	}

	return int((DTimeManager.nowSysTime()-_loginTime)) > _loginLastTime;
}

void CRoleBase::onLoginTimeout()
{

}

void CRoleBase::onLogoutTimeout()
{
}

void CRoleBase::on0Timer()
{
	FUNC_BEGIN(ROLE_MOD);

	FUNC_END(DRET_NULL);
}

void CRoleBase::on12Timer()
{
	FUNC_BEGIN(ROLE_MOD);

	FUNC_END(DRET_NULL);
}

GXMISC::TDbHandlerTag CRoleBase::getDbHandlerTag()
{
	FUNC_BEGIN(ROLE_MOD);

	CMapDbPlayerHandlerBase* pDbHandler = getDbHandlerBase(false);
	if(NULL == pDbHandler)
	{
		return 0;
	}

	return pDbHandler->getTag();

	FUNC_END(GXMISC::INVALID_DB_HANDLER_TAG);
}

CMapDbPlayerHandlerBase* CRoleBase::getDbHandlerBase( bool logFlag /*= true*/ )
{
	FUNC_BEGIN(ROLE_MOD);

	CMapDbPlayerHandlerBase* handler = dynamic_cast<CMapDbPlayerHandlerBase*>(DMapDbMgr->getUser(getDbIndex()));
	if(NULL == handler && logFlag)
	{
		gxError("Can't find CMapDbPlayerHandlerBase!{0}", toString());
		return NULL;
	}

	return handler;

	FUNC_END(NULL);
}

bool CRoleBase::onAddToReady()
{
	_readyTime = DTimeManager.nowSysTime();
	_loginTime = DTimeManager.nowSysTime();
	_queType = MGR_QUE_TYPE_READY;
	setLoginLastTime(60); // @TODO
	_logoutTime = GXMISC::MAX_GAME_TIME;
	gxInfo("Add to ready queue!{0}", toString());
	return true;
}

bool CRoleBase::onAddToLogout()
{
	onLogout();

	_queType = MGR_QUE_TYPE_LOGOUT;
	_readyTime = GXMISC::MAX_GAME_TIME;
	_loginTime = GXMISC::MAX_GAME_TIME;
	_logoutTime = DTimeManager.nowSysTime();
	if(_dbUpdateSaveIndex != INVALID_SAVE_INDEX)
	{
		DRoleMgrBase->putSaveIndex(_dbUpdateSaveIndex);
	}
	_dbUpdateSaveIndex = INVALID_SAVE_INDEX;
	gxInfo("Add to logout queue!{0}", toString());
	
	return true;
}

bool CRoleBase::onAddToEnter()
{
	FUNC_BEGIN(ROLE_MOD);

	_queType = MGR_QUE_TYPE_ENTER;
	_logoutTime = GXMISC::MAX_GAME_TIME;
	_readyTime = GXMISC::MAX_GAME_TIME;
	setDbSaveIndex(DRoleMgrBase->getSaveIndex());

	onEnter();

	return true;

	FUNC_END(false);
}

void CRoleBase::onRemoveFromEnter()
{
	_queType = MGR_QUE_TYPE_INVALID;
	_logoutTime = GXMISC::MAX_GAME_TIME;
}

void CRoleBase::onRemoveFromReady()
{
	_queType = MGR_QUE_TYPE_INVALID;
	_logoutTime = GXMISC::MAX_GAME_TIME;
}

void CRoleBase::onRemoveFromLogout()
{
	_queType = MGR_QUE_TYPE_INVALID;
	_logoutTime = GXMISC::MAX_GAME_TIME;
}

bool CRoleBase::isReady()
{
	return _queType == MGR_QUE_TYPE_READY;
}

bool CRoleBase::isEnter()
{
	return _queType == MGR_QUE_TYPE_ENTER;
}

bool CRoleBase::isLogout()
{
	return _queType == MGR_QUE_TYPE_LOGOUT;
}

void CRoleBase::resetLogoutTime( uint32 seconds )
{
	_logoutTime = DTimeManager.nowSysTime();
	_logoutLastTime = seconds;
}

void CRoleBase::addRoleToLogout(uint32 secs)
{
	if(isLogout())
	{
		return;
	}

	CRoleBase* pRole = DRoleMgrBase->remove(getRoleUID());
	if(NULL == pRole)
	{
		return;
	}

	DRoleMgrBase->addToLogout(pRole);
	resetLogoutTime(secs);
}

void CRoleBase::addRoleToReady()
{
	if(isReady())
	{
		return;
	}

	CRoleBase* pRole = DRoleMgrBase->remove(getRoleUID());
	if(NULL == pRole)
	{
		return;
	}

	DRoleMgrBase->addToReady(pRole);
}

bool CRoleBase::onLogout()
{
	return true;
}

void CRoleBase::onIdle()
{
}

bool CRoleBase::onEnter()
{
	return true;
}

void CRoleBase::onHourTimer( sint8 hour )
{
}

void CRoleBase::waitReconnect()
{
}

bool CRoleBase::isCanViewMe( const CGameObject *pObj )
{
	if(!TBaseType::isCanViewMe(pObj)){
		return false;
	}

	if(pObj->isRole()){
		const CRoleBase* pRoleBase = pObj->toRoleBase();
		if(NULL == pRoleBase){
			return true;
		}

		return getGroupID() == pRoleBase->getGroupID();
	}

	return true;
}

void CRoleBase::onEnterScene( CMapSceneBase* pScene )
{
	TBaseType::onEnterScene(pScene);

	setSceneGroupID(pScene->getEmptyGroupID());
}

void CRoleBase::onLeaveScene( CMapSceneBase* pScene )
{
	TBaseType::onLeaveScene(pScene);

	pScene->putEmptyGourpID(getSceneGroupID());

	setSceneGroupID(INVALID_SCENE_GROUP_ID);
}

TSceneGroupID_t CRoleBase::getGroupID() const
{
	return _sceneGroupID;
}

TRoleHeart CRoleBase::getHeartInfo()
{
	TRoleHeart heart;
	heart.accountID = getAccountID();
	heart.roleUID = getRoleUID();
	heart.onlineFlag = true;

	return heart;
}
