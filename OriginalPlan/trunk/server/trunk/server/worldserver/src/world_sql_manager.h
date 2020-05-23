#ifndef _WORLD_SQL_MANAGER_H_
#define _WORLD_SQL_MANAGER_H_

#include "core/db_single_conn_manager.h"

#include "game_util.h"
#include "user_struct.h"
#include "server_struct.h"
#include "world_server_data.h"

class CSqlConnectionManagerBase : public GXMISC::CDbConnectionManager<CSqlConnectionManagerBase>
{
public:
	CSqlConnectionManagerBase();
	virtual ~CSqlConnectionManagerBase();

	// ��������Ϣ
public:
	//	bool	loadServerInfo();

	// �������
public:
	bool	loadAllUser();												///< �����������
	bool	loadAllUserRoleUID(std::vector<TRoleUID_t>& data);			///< �������е���ҵĽ�ɫUID

	// �������
public:
	bool	loadUserData(TUserDbData* data);							///< ���ؽ�ɫ����
	bool	addUserData(TUserDbData* data);								///< ��ӽ�ɫ���� 
	bool	updateUserData(TRoleUID_t roleUID, TUserDbData* newData);	///< ���½�ɫ����
	bool	deleteUserData(TRoleUID_t roleUID);							///< ɾ����ɫ����

	// ��ɫ����
public:
	bool		changeRoleObjUID(TRoleUID_t roleUID, TObjUID_t objUID);		///< ���½�ɫobjUID
	bool		delRole(TRoleUID_t roleUID, const char* roleStr);           ///< ɾ����ɫʱ������ݽӿ�
	TRoleUID_t	getRoleUIDByAccountID(TAccountID_t accountID);				///< ͨ���˺ŵõ���ɫUID
	TRoleName_t getRoleNameByRoleId(TRoleUID_t roleUID);					///< ͨ��uid��������
	TLevel_t	getRoleLevelByRoleId(TRoleUID_t roleUID);					///< ͨ��uid���ҵȼ�

	// ��ֵ
public:
	bool	addTempRechargeRecord(TSerialStr_t serialNo, TAccountID_t accountID, TRmb_t rmb, TRmb_t bindRmb);	///< ������ʱ��ֵ��¼
	bool	delTempRechargeRecord(TSerialStr_t serialNo);														///< ɾ����ʱ��ֵ��¼
	bool	updateTempRechargeRecord(TSerialStr_t serialNo, sint8 status);										///< ������ʱ��ֵ��¼
	bool	accountRmbQuery(TAccountID_t accountID, TRmb_t& rmb, TRmb_t& bindRmb);								///< �˺�Ԫ����ѯ
	bool	addAccountRmb(TAccountID_t accountID, TRmb_t rmb, TRmb_t bindRmb);									///< ����Ԫ��
	TRoleUID_t getLastLoginRoleUIDByAccountID(TAccountID_t accountID);											///< ��ȡ���һ�ε�½�����UID

public:
	bool addAwardBindRmb(TRmb_t rmb, TGold_t gameMoney);														///< ��̨�����������Ԫ��
	bool addAwardItem(TRoleUID_t roleUID, TItemTypeID_t itemID, TItemNum_t num);								///< ��̨������ҵ���
	bool addRoleAwardBindRmb(TRoleUID_t roleUID, TAccountID_t accountID, TRmb_t rmb, TGold_t gameMoney);		///< ��̨������ҽ�Ǯ
};

class CSqlConnectionManager : public CSqlConnectionManagerBase
{
public:
	CSqlConnectionManager();
	~CSqlConnectionManager();
};

#define DSqlConnectionMgr CSqlConnectionManager::GetInstance()

#endif	// _WORLD_SQL_MANAGER_H_