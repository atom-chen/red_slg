#ifndef _MAP_DB_TASK_BASE_H_
#define _MAP_DB_TASK_BASE_H_

#include "core/string_common.h"
#include "core/database_util.h"
#include "core/db_task.h"
#include "core/database_handler.h"

#include "game_errno.h"
#include "game_util.h"
#include "role_base.h"

/**
* @brief �����ݿ������Ϸ�߼��㷢�͵���Ӧ����, ��ɫUIDΪΨһ��ʶ
*/
class CMapDbResponseTask : public GXMISC::CDbConnTask
{
protected:
	CMapDbResponseTask();
public:
	virtual ~CMapDbResponseTask(){}

public:
	virtual void doRun();
	virtual void doWork(CRoleBase* role) = 0;

public:
	void setRoleUID(TRoleUID_t roleUID);
	TRoleUID_t getRoleUID();
	void setRetCode(TRetCode_t ret);
	void setErrLogFlag(bool errLogFag);
	CRoleBase* getRole();

public:
	template<typename T>
	void sendPacket(T& packet);

public:
	DObjToString2Alias(CMapDbResponseTask,
		GXMISC::TDbIndex_t, DbIndex, _uid,
		TRoleUID_t, RoleUID, roleUID);

protected:
	TRoleUID_t roleUID;         // ��ɫUID
	bool needErrLog;            // �Ҳ�����ɫ�Ƿ���Ҫ��ʾ������־
	TRetCode_t retCode;			// ������
};

template<typename T>
void CMapDbResponseTask::sendPacket(T& packet)
{
	CRoleBase* role = getRole();
	if(NULL != role)
	{
		role->sendPacket(packet);
	}
}

/**
* @brief ����Ϸ�߼��������ݿ�㷢����������, ��ɫUIDΪΨһ��ʶ
*/
class CMapDbRequestTask : public GXMISC::CDbWrapTask
{
public:
	typedef GXMISC::CDbWrapTask TBaseType;
protected:
	CMapDbRequestTask() : GXMISC::CDbWrapTask()
	{
		roleUID = INVALID_ROLE_UID;
		needErrLog = true;
	}
public:
	virtual ~CMapDbRequestTask(){}

public:
	template<typename TaskType>
	TaskType* newResponseTask()
	{
		TaskType* temp = newTask<TaskType>();
		temp->setRoleUID(roleUID);
		temp->setDbUserIndex(getDbUserIndex());
		temp->setErrLogFlag(needErrLog);
		return temp;
	}

	void freeResponseTask(CMapDbResponseTask* task)
	{
		getLoopThread()->freeTask(task);
	}

	void setRoleUID(TRoleUID_t roleUID);
	TRoleUID_t getRoleUID();
	void setErrLogFlag(bool errLogFlag);

protected:
	TRoleUID_t roleUID;         // ��ɫUID
	bool needErrLog;            // �Ҳ�����ɫ�Ƿ���Ҫ��ʾ������־
};


#endif	// _MAP_DB_TASK_BASE_H_