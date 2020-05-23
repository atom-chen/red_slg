#ifndef _WORLD_PLAYER_H_
#define _WORLD_PLAYER_H_

#include "packet_struct.h"
#include "game_util.h"
#include "base_util.h"
#include "socket_handler.h"
#include "world_server_util.h"
#include "string_common.h"
#include "server_define.h"
#include "game_player_mgr.h"
#include "world_player_handler.h"
#include "world_map_player_mgr.h"
#include "world_login_role_list.h"
#include "user_struct.h"
#include "login_status.h"

#include "core/multi_index.h"

class CWorldPlayerHandler;
class CWorldDbHandler;
class CWorldUser;

/**
* 1. �����ɫ����������״̬, �����˳���½, ����ȴ�������ɲ����˳���½, ����״̬�ᱻ����
* 2. ���ܷ����ظ�������, ����ᵼ��������˳�����һ��
* 3. ��������״̬, �κ����󶼻�ȴ����߷��ش���
* 4. ����Ѿ���Ч������ʧ��
*/

// ��ɫ�˺����������������
class CWorldPlayer
{
public:
    CWorldPlayer();
    ~CWorldPlayer();

public:
    void update(GXMISC::TDiffTime_t diff);

    // �ڲ���Ա����
public:
    CWorldPlayerHandler* getSocketHandler(bool logFlag = true);
    CWorldDbHandler* getDbHandler(bool logFlag = true);
	CWorldUser* getCurrentUser();
    TAccountID_t getAccountID();
    void setAccountID(TAccountID_t accountID);
    void setSocketIndex(GXMISC::TSocketIndex_t socketIndex);
    GXMISC::TSocketIndex_t getSocketIndex();
    void setDbIndex(GXMISC::TUniqueIndex_t index);
    GXMISC::TDbIndex_t getDbIndex();
    TServerID_t getMapServerID();
    void setMapServerID(TServerID_t mapServerID);
    TChangeLineWait* getChangeLineWait();
	void setLoginKey(TLoginKey_t loginKey);
	TLoginKey_t getLoginKey();
	void setSourceWay(TSourceWayID_t sourceWay, TSourceWayID_t chisourceWay);
	TSourceWayID_t getSourceWay() const { return _sourceWay; }
	void setSourceWay(TSourceWayID_t val) { _sourceWay = val; }
	TSourceWayID_t getChisourceWay() const { return _chisourceWay; }
	void setChisourceWay(TSourceWayID_t val) { _chisourceWay = val; }
	GXMISC::CGameTime getLoginTime() const { return _logintime; }
	void setLoginTime(GXMISC::CGameTime val) {_logintime = val; }
	CLoginWaiterManager* getLoginManager() { return &_loginManager; }
	void setLoginManager(CLoginWaiterManager* val) { _loginManager = *val; }
	TGmPower_t getGmPower() const { return _gmPower; }
	void setGmPower(TGmPower_t val) { _gmPower = val; }

    // ��ɫ����
public:
    void addRole(TLoginRole* role);		// ��ӽ�ɫ
    bool hasRole(TRoleUID_t roleUID);	// ��ǰ�˺��Ƿ��д˽�ɫ
    bool isMaxRoleNum();				// �Ƿ��Ѿ��ﵽ��ɫ������
    void cleanRole();					// �����ɫ
    TRoleUID_t getCurrentRoleUID();		// ��ǰRoleUID
    TObjUID_t getCurrentObjUID();		// ��ǰObjUID
	sint32 getRoleNum();				// ��ȡ����ɫ��Ŀ
	TRoleUID_t getFirstRoleUID();		// �õ���һ����ɫ��UID

private:
    void getRoleList(TPackLoginRoleArray& roleList);
    bool selectRole(TRoleUID_t roleUID);

    // ���й���
public:
	bool onAddToEnter();
	bool onAddToReady();
	bool onAddToLogout();
	void onRemoveFromEnter();
	void onRemoveFromReady();
	void onRemoveFromLogout();
	EManagerQueType getQueType();
	void onUpdateEnterQue(GXMISC::TDiffTime_t diff)     {}
	void onUpdateReadyQue(GXMISC::TDiffTime_t diff)     {}
	void onUpdateLogoutQue(GXMISC::TDiffTime_t diff)    {}

    // �¼�����
public:
    // ������Ϸǰ����
    void onBeforeLogin(TServerID_t mapID);
    void onAfterLogin(TServerID_t mapServerID);
    /// ��������ǰ�¼�(�����ǰ����Ѿ�ʧЧ�򷵻�ʧ��)
    EGameRetCode onBeforeRequst(EWPlayerActionType requstType);
    // ������Ӧǰ�¼�
    EGameRetCode onBeforeResponse(EWPlayerActionType requstType);
	void onBerforeLoadRoleData( TObjUID_t objUID, TSceneID_t sceneID, TMapID_t mapID );

    // �˳�����
public:
    // �˳���Ϸ��Ψһ�ӿ�
    // @notice ���ô˷���֮����Ҳ����ʹ�ô�player����
    void quit(bool isForce, const char* quitReason = "");
    // ֪ͨMapServer��ǰ������Ҫ����, ����true��ʾ��Ҫ�ȴ�, ����ֱ���������
    bool kickByOtherPlayer();
    // Socket�Ͽ�����
    void quitBySocketClose();
    // ���ݿ�Ͽ�����, ��������������ϵ��������, �˳���Ϸ
    void quitByDbClose();
    // MapServer�Ͽ�����
    void quitByMapServerClose();
private:
    // ���˶�����ڲ�����, ���ô˷���֮����Ҳ����ʹ�ô�player����
    void clean();
    void cleanSocketHandler();
    void cleanDbHandler();
    // !!! ��ǰ�����Ѿ���ɾ��, ����ʹ�õ�ǰ�����е��κγ�Ա����
    void onQuit(TAccountID_t accountID);
    // !!! �����������, ����User
    void cleanAll();
    // ����ǰ�������ó���Ч
    void setInvalid(EUnloadRoleType unloadType);			// @TODO ��������Ч�ĺ����ĵ������߼�����, �ͷ����ݷ�����Ҫ�ж϶����Ƿ���Ч
    bool isValid();

    // ���ݼ�鼰�Ŵ� @todo
public:
    // ������ݼ��غ�, ֪ͨ�����������������ͷ�
    // ͬ�������Ϣ
    // ��ʱ���

    // ��Ҳ���
public:
    // �˺���֤�ɹ�, ��ɫ�б��Ѿ�����
    void loginSuccess();
    // ������ɫ
    void createRoleReq(TRoleName_t& name, TRoleProtypeID_t typeID);
    EGameRetCode createRoleSuccess(TRetCode_t retCode, TLoginRole* role);
    void createRoleFailed(TLoginRole* role);
    // ɾ����ɫ
    //void deleteRoleReq(TRoleUID_t roleUID);
    // C->W��½��Ϸ
    void loginGameReq(TRoleUID_t roleUID, bool enterDynamicMapFlag);
    // M->W��½��Ϸ��Ӧ
    EGameRetCode loginGameRes(CWorldUserData* data, TServerID_t mapServerID);
    // M->W���ؽ�ɫ����
    EGameRetCode loadRoleDataSuccess(CWorldUserData* data, TServerID_t mapServerID, TMapID_t mapID);
    bool loadRoleDataFailed(const TLoadRoleData* loadData, EGameRetCode retCode);
    // �ͻ���֪ͨ�˳���½, ��ʱ��ʾ�Ѿ����ӵ�MapServer, WorldServer�ı����״̬
    void loginQuitReq();
    // M->W�˳���Ϸ����
    void quitGameReq(TRoleUID_t roleUID);
    // W->M�˳���Ϸ��Ӧ
    void quitGameRes();
    // W->M�ͷŽ�ɫ��������
    bool unloadRoleDataReq(EUnloadRoleType unloadType, bool flag = true);
    // W->M ֪ͨ���з������ͷŽ�ɫ����,����Ҫ����
    bool unloadRoleDataAll();
    // �ͷŽ�ɫ����
    EGameRetCode unloadRoleDataSuccess(TRoleUID_t roleUID);
    void unloadRoleDataFailed(TRoleUID_t roleUID);
    // ��������(M->W)
    EGameRetCode changeLineReq(TSceneID_t sceneID, TAxisPos& pos, TServerID_t mapServerID, 
        TSceneID_t lastSceneID, TAxisPos& lastPos, TServerID_t lastMapServerID, TChangeLineTempData* tempData);		// ��������
    EGameRetCode changeLineUnloadRes();													                                // �ͷ�Դ��������ɫ������Ӧ
    EGameRetCode changeLineLoadRes(CWorldUserData* data, TServerID_t mapServerID, TMapID_t mapID);	                // ����Ŀ���������ɫ������Ӧ
    // ���߷���(W->M)
    EGameRetCode changeLineUnloadReq();													                                // �ͷ�Դ��������ɫ��������
    EGameRetCode changeLineLoadReq();													                                // ����Ŀ���������ɫ��������
    EGameRetCode changeLineRes(TServerID_t mapServerID, TMapID_t mapID);                                             // ������Ӧ

    // ���븱������
    //EGameRetCode openDynamicMapReq(TMapID_t mapID, ESceneType sceneType);                                             // ���¸�������
    void setChangeLine(TServerID_t mapServerID, TSceneID_t sceneID, const TAxisPos& pos);                            // ����������Ϣ

    // ��ɫ��½
    void onUserLogin();
    void onRoleHeart();
    bool heartOutTime();

private:
    // ���ؽ�ɫ��������
    void loadRoleDataReq(CWorldMapPlayer* mapPlayer, ELoadRoleType loadType, TSceneID_t sceneID, TAxisPos& pos, bool needOpenMap, TMapID_t mapID);

    // ״̬�ж�
public:
    // �Ƿ�ͨ���˺���֤
    bool isVerifyPass();
    // �Ƿ�Ϊ��Ϸ״̬
    bool isPlaying();
    // �Ƿ�Ϊ��½��Ϸ�������ɹ�״̬
    bool isLoginGame();
    // �Ƿ�Ϊ����
    bool isIdle();
    // �Ƿ����ڼ�������
    bool isLoadRoleDataReq();

    // �Ƿ�Ϊ����״̬
    bool isRequstStatus();
    // �Ƿ��ڵ�½״̬, �����������״̬��, Scoket�Ͽ����ӻ��������
    bool isAccountVerifyStatus();
    // �����Ƿ���Ҫ�ͷ�״̬(��Ҫ֪ͨMap�������ͷ�����)
    bool isDataNeedFreeStatus();
    // �����Ƿ��Ѿ��ͷ�
    bool isDataHasFreedStatus();
    // �Ƿ�Ϊ���ؽ�ɫ����״̬
    bool isLoadRoleDataStatus();
    // ����״̬
    bool isChangeLineStatus();
	// �Ƿ�Ϊ������Ϸ״̬
	bool isEnterGame();

    // ״̬���
public:
    bool checkRequest();

public:
    // �˺���֤�ɹ���Ҫ���������
    void doLoginVerify();

	// ת��������Ϣ
public:
	void transLimitInfo(void);

public:
	bool isRechargeStatus();
	void startRecharge();
	void closeRecharge();

public:
	void setPlayerStatus(EPlayerStatus status);
	EPlayerStatus getPlayerStatus();

public:
    const char* toString() const;

public:
	CWorldLoginRoleList* getCWorldLoginRoleList() {return &_roleList;}
private:
    void genStrName();
    std::string changeLineString();

private:
    TAccountID_t _accountID;				    // �˺�ID
    CWorldLoginRoleList _roleList;			    // ��ɫ�б�
    GXMISC::TSocketIndex_t _socketIndex;	    // Socket����
    GXMISC::TDbIndex_t _dbIndex;				// ���ݿ�����
    EPlayerStatus _playerStatus;			    // ���״̬
    TServerID_t _mapServerID;					// ������ID
    GXMISC::TGameTime_t _lastHeartTime;         // ��һ������ʱ��
	TLoginKey_t _loginKey;						// ��½Key
	TSourceWayID_t _sourceWay;					// ����
	TSourceWayID_t _chisourceWay;				// ������
	TGmPower_t _gmPower;						///< GMȨ��
	bool _valid;							    // �Ƿ���Ч
    EManagerQueType _queType;				    // ��������
    EUnloadRoleType _unloadType;			    // �˳�֪ͨMap�������ͷ�����ԭ��

    // ��������
    TChangeLineTempData _changeLineTempData;	// ���ߵ���ʱ����
    TChangeLineWait _changeLineWait;            // ���ߵȴ���Ϣ
	// ��¼ʱ��
	GXMISC::CGameTime	_logintime;				// ��¼ʱ��
	CLoginWaiterManager	_loginManager;			///< ��½������(�������뼰�ǳ�) @TODO ʵ�ִ˹���

private:
    std::string _strName;

private:
	bool _rechargeFlag;							// ��ֵ���

public:
    DMultiIndexImpl1(TAccountID_t, _accountID, INVALID_ACCOUNT_ID);
    DMultiIndexImpl2(GXMISC::TSocketIndex_t, _socketIndex, GXMISC::INVALID_SOCKET_INDEX);

public:
    template<typename T>
	void sendPacket(T& packet) {
		CWorldPlayerHandler* socketHandler = getSocketHandler();
		if (NULL != socketHandler) {
			socketHandler->sendPacket(packet);
		} else {
			gxWarning("Can't find socket handler! SocketIndex = {0}, PacketID = {1}", _socketIndex, packet.getPacketID());
		}
	}

    template<typename T>
    void sendToMapServer(T& packet)
    {
        CWorldMapPlayer* player = DWorldMapPlayerMgr.findMapPlayer(getMapServerID());
        if(NULL != player)
        {
            player->sendPacket(packet);
        }
    }
};

#endif
