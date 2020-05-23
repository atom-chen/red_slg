#ifndef _WORLD_USER_H_
#define _WORLD_USER_H_

#include "game_misc.h"
#include "db_struct_base.h"
#include "world_map_player.h"
#include "user_struct.h"

#include "core/db_util.h"
#include "core/multi_index.h"
#include "core/stream.h"
#include "core/debug.h"
#include "core/time/interval_timer.h"


using namespace std;


class CWorldUser {
public:
	CWorldUser()
	{
		_isFirstOnline = true;
		_isLoadingData = true;
		_updateUserDataTimer.init(MAX_ROLE_USER_DATA_UPDATE_TIME);
	}
	~CWorldUser()
	{
	}

public:
	void setAccountID(TAccountID_t accountID);
	TAccountID_t getAccountID() const;
	void setRoleUID(TRoleUID_t roleUID);
	TRoleUID_t getRoleUID() const;
	void setObjUID(TObjUID_t objUID);
	TObjUID_t getObjUID() const;
	void setName(const std::string& name);
	const std::string getName() const;
	void setMapServerID(TServerID_t serverID);
	TServerID_t getMapServerID();
	void setLevel( const TLevel_t lev );
	TLevel_t getLevel();
	void setSex( const TSex_t sex);
	TSex_t getSex();
	void setJob( const TJob_t job );
	TJob_t getJob();
	void setRoleUpdateData(TM2WRoleDataUpdate* roleData);
	TM2WRoleDataUpdate* getRoleUpdateData()						{ return &_roleData; }
	void setCloseServerTime( GXMISC::TGameTime_t closeTime )	{ _dbUserData.closeServerTime = closeTime; }
	bool getIsLoadingDataFromDB() const							{ return _isLoadingData; }

public:
	void update(GXMISC::TDiffTime_t diff);							// 定时更新数据
	void updateUserData();											// 更新当前对象数据到地图服务器

public:
	void online();													// 上线
	void offLine();													// 离线
	void onAfterChangeLine();										// 换线
	void onBeforeChangeLine(TChangeLineTempData* tempData, ESceneType sceneType, TMapID_t mapID );
	void loadDataFromDB( const TUserDbData* userData );

private:
	void sendCommunicationRefuseMsg( uint8 communicationType, uint8 operationType, TObjUID_t objUID );
	void sendCommunicationTeamRefuseMsg( uint8 operationType, TObjUID_t objUID );
	void sendCommunicationRelationRefuseMsg( uint8 operationType, TObjUID_t objUID );

private:
	void updateAllUserData();   // 更新当前对象数据到WorldAllUserMgr中

private:
	void onlineUserData();		// 上线时处理玩家数据
	void offlineUserData();		// 下线时处理玩家数据

public:
	void onUserPassDay();	// 过天的函数，当前是0点或者离线过天都会调用此函数

public:
	void setUserData(CWorldUserData* data);

public:
	CWorldMapPlayer* getMapPlayer();
	CWorldPlayer* getWorldPlayer(bool flag=true);


private:
	bool				_isFirstOnline;			// 是否刚登陆
	bool				_isLoadingData;			// 是不是还在等待从数据库加载数据
	TObjUID_t		    _objUID;				// 对象UID
	CWorldUserData	    _usrData;				// 角色数据
	TServerID_t	    _mapServerID;				// 地图服务器ID
	TM2WRoleDataUpdate  _roleData;				// 地图服务器上更新的角色数据
	GXMISC::GXManuaTimer _updateUserDataTimer;	// 更新User定时器时间
	TUserDbData			_dbUserData;			// 玩家保存到数据库的数据

public:
	DMultiIndexImpl1(TObjUID_t, _objUID, INVALID_OBJ_UID);
	DMultiIndexImpl2(TRoleName_t, _usrData.roleName, '\0');
	DMultiIndexImpl3(TRoleUID_t, _usrData.roleUID, INVALID_ROLE_UID);
	DMultiIndexImpl4(TAccountID_t, _usrData.accountID, INVALID_ACCOUNT_ID);

	DFastObjToStringAlias(CWorldUser, const char*, UserData, _usrData.toString());

	static std::tr1::hash<TRoleName_t> roleNameDef;

private:
	template<typename T, bool flag >
	struct _SendPackTrans
	{
		void SendPacketTrans(T& packet, CWorldUser* pUser, TObjUID_t srcObjUID, bool failedNeedRes);
	};

	template<typename T>
	struct _SendPackTrans<T, false>
	{
		static void SendPacketTrans(T& packet, CWorldUser* pUser, TObjUID_t srcObjUID, bool failedNeedRes)
		{
			CWorldMapPlayer* mapPlayer = pUser->getMapPlayer();
			if(NULL == mapPlayer)
			{
				return;
			}

			MWTransPacket transPacket;
			transPacket.failedNeedRes = failedNeedRes;
			transPacket.srcObjUID = srcObjUID;
			transPacket.destObjUID = pUser->getObjUID();
			bool val = std::is_base_of<GXMISC::IStreamable, T>::value;
			gxAssert( val == false);									// 不允许发送从IStreamable继承下来的类
			transPacket.msg.pushBack((char*)&packet, packet.getPackLen());
			mapPlayer->sendPacket(transPacket);
		}
	};

	template<typename T>
	struct _SendPackTrans<T, true>
	{
		static void SendPacketTrans(T& packet, CWorldUser* pUser, TObjUID_t srcObjUID = INVALID_OBJ_UID, bool failedNeedRes = false)
		{
			CWorldMapPlayer* mapPlayer = pUser->getMapPlayer();
			if(NULL == mapPlayer)
			{
				return;
			}

#define MAX_SEND_PACKET_TRANS_BUF 32*1024

			GXMISC::CMemOutputStream outStream;
			uint32 len = packet.serialLen();
			if(len > MAX_SEND_PACKET_TRANS_BUF)
			{
				bool val = GXMISC::ICanStreamable<T>::value;
				gxAssert( val == true );								// 允许发送从IStreamable继承下来的类

				outStream.init(len+100);

				outStream.serial(packet);
				MWTransPacket transPacket;
				transPacket.failedNeedRes = failedNeedRes;
				transPacket.srcObjUID = srcObjUID;
				transPacket.destObjUID = pUser->getObjUID();
				transPacket.msg.pushBack((char*)outStream.data(), outStream.size());
				mapPlayer->sendPacket(transPacket);
			}
			else
			{
				char buf[MAX_SEND_PACKET_TRANS_BUF];
				memset(buf, 0, sizeof(buf));
				outStream.init(MAX_SEND_PACKET_TRANS_BUF, buf);

				outStream.serial(packet);

				MWTransPacket transPacket;
				transPacket.failedNeedRes = failedNeedRes;
				transPacket.srcObjUID = srcObjUID;
				transPacket.destObjUID = pUser->getObjUID();
				transPacket.msg.pushBack((char*)outStream.data(), outStream.size());
				mapPlayer->sendPacket(transPacket);
			}
		}
	};

	// 发送数据包
public:
	template<typename T>
	bool sendPacket(T& packet)
	{
		CWorldMapPlayer* mapPlayer = getMapPlayer();
		if(NULL != mapPlayer)
		{
			mapPlayer->sendPacket(packet);
			return true;
		}

		return false;
	}

	// 通过MapServer转发数据到客户端
	template<typename T>
	void sendPackTrans(T& packet, TObjUID_t srcObjUID = INVALID_OBJ_UID, bool failedNeedRes = false)
	{
		_SendPackTrans<T, GXMISC::ICanStreamable<T>::value >::SendPacketTrans(packet, this, srcObjUID, failedNeedRes);
	}

};

#endif