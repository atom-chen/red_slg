#ifndef _DATABASE_CONN_H_
#define _DATABASE_CONN_H_

#include <string>

#include "msg_queue.h"
#include "mysql++.h"
#include "database_util.h"
#include "interface.h"
#include "db_task.h"
#include "thread.h"
#include "module_base.h"

class Connection;

namespace GXMISC
{
	class CDatabaseConfig;

	class CDatabaseConn : public CModuleThreadLoop
	{
		typedef CModuleThreadLoop TBaseType;

	public:
        CDatabaseConn();
		~CDatabaseConn();
	private:
		// ��������
		void _clearSelf();

	public:
		// ��ʼ��
		virtual bool init();
		// ����
        virtual bool start();
		// ��������
		virtual void cleanUp();

	protected:
		// ֡�����¼�
		virtual bool onBreath();
		// ֹͣ�¼�
		virtual void onStop();

	public:
		// �������ݿ�������Ϣ
		void setDbUrlInfo(const std::string& dbHost, const std::string& dbName, const std::string& dbUser, const std::string& dbPass);
		// ������������
		void setStartParam(uint32 reconnInterval);

	public:
		// ֹͣ��Ϣ����
        void stopMsgHandle();
		// �Ƿ��Ѿ�ֹͣ��Ϣ����
        bool isStopMsgHandle();
		// ���ݿ������Ƿ񻹴��
        bool isActive() const;
		// ��ȡ���ݿ�����
		mysqlpp::Connection* getConn();
		// ��ȡ�ַ�����
		std::string toString();
		// �Ƿ������(�û���Ϊ��, ����mysql, ֻ���յ�������)
		bool isEmptyConn() const;

	private:
		// ��ʱ����ping
		void updatePing(TDiffTime_t diff);
		// ����ɾ������
		void updateDelUser(TDiffTime_t diff);

    public:
		// ����
        bool reconnect(uint32 num = 1);
		// ��������
        bool ping();

	public:
		// ѹ������
        void pushTask(CDbConnTask* task, TUniqueIndex_t index);

	public:
		// ѹ��ɾ���û�
		void pushDelUser(TUniqueIndex_t uid);
		// �û��Ƿ��Ѿ�ɾ��
		bool isDelUser(TUniqueIndex_t uid);

    public:
		// ���ӹر��¼�
        void onClose();
		// ���ӳɹ��¼�
        void onConntected();

	private:
		// ����ǰ�¼�
		void onBeforeConn();
		// ���Ӻ��¼�
		void onAfterConn();

    private:
        bool _isConntected;			// �Ƿ��Ѿ����ӳɹ�
        uint32 _reconnInterval;		// �������
        bool _stopMsgHandle;		// ֹͣ��Ϣ����
        TTime_t _pingTime;			// �ϴ�ping��ʱ��
		TDbDelUserMap _delUserMap;	// ɾ���û���

    private:
        std::string _dbName;		// ���ݿ���
        std::string _dbHost;		// ���ݿ��ַ
        std::string _dbUser;		// ���ݿ��û���
        std::string _dbPass;		// ���ݿ�����

        mysqlpp::Connection* _dbConn; // ���ݿ�����
    };
}

#endif