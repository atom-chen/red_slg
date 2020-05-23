#ifndef _DB_SQL_DEFINE_H_
#define _DB_SQL_DEFINE_H_

// ================================== ����˺� ==================================
// ��ѯ�˺�
//#define DLoadAccount			"select account_id,last_server_id,gm_power from %s where account='%s' and password='%s'"
#define DLoadAccount			"select account_id,last_server_id,gm_power from %s where account='%s'"
#define DInsertAccount			"insert into %s (account,password,platUID,macid,source_way,chisource_way) values('%s','%s','%s','%s','%s','%s')"
#define DLoadAccountInfo		"select account_id,account,platUID,macid from %s where account_id = '%"I64_FMT"u'"
#define DUpdateAccountInfo		"update %s set last_server_id=%d where account_id='%"I64_FMT"u'"

// ================================== ��ҽ�ɫ ==================================
// ��ѯ����RoleUID��ObjUID
#define DSelectMaxRoleUID		"select max(role_uid),max(obj_uid) from %s"
// ����ɫ�����Ƿ��Ѿ��ظ�
#define DCheckNameRepeat		"select * from "DB_ROLE_TBL" where name='%s'"
// ��ȡ������ֵ��������
#define DGetMaxRandRoleName		"SELECT `name` FROM "DB_ROLE_TBL" WHERE `name` LIKE 'GMR%' GROUP BY `name` DESC LIMIT 1;"
// ͨ���˺�ID�õ���ɫUID
#define DGetRoleUIDByAccountID "select role_uid from "DB_ROLE_TBL" where account_id=%"I64_FMT"u"

//================================== ����������û� ==================================
// ����User����
#define DLoadUserData	"select close_server_time, user_flag from %s where role_uid = '%s'"

//================================== Ԫ����ֵ ==================================
// Ԫ����ֵ
#define DQueryRoleRmb			"select rmb,bind_rmb,total_rmb from "DB_ROLE_TBL" where role_uid='%"I64_FMT"u'"
#define DQueryAccountRmb		"select rmb,bind_rmb from "DB_ACCOUNT_TBL" where account_id='%"I64_FMT"u'"
#define DAddAccountRmb			"update "DB_ACCOUNT_TBL" set rmb=if(rmb+%d>0, rmb+%d, 0), bind_rmb=if(bind_rmb+%d>0, bind_rmb+%d, 0) where account_id='%"I64_FMT"u';"
#define DQueryLastTimeRoleUID	"select role_uid from "DB_ROLE_TBL" where account_id='%"I64_FMT"u' order by logout_time desc limit 1;"
#define DInsertTempRmbRecord	"insert into "DB_RECHARGE_TEMP_TBL" (serial_no,account_id,rmb,bind_rmb,status) values('%s',%"I64_FMT"u,%d,%d,%u)"
#define DDelTempRmbRecord		"delete "DB_RECHARGE_TEMP_TBL" where serial_no='%s';"
#define DUpdateTempRmbRecordStatus "update "DB_RECHARGE_TEMP_TBL" set status='%u' where serial_no='%s';"

// Ԫ��, ��Ǯ����
#define DAwardAllRoleBindRmb		"update "DB_ACCOUNT_TBL" set bind_rmb=bind_rmb+%d"
#define DAwardAllRoleGameMoney		"update "DB_ROLE_TBL" set game_money=game_money+%d"
#define DAwardRoleBindRmb			"update "DB_ACCOUNT_TBL" set bind_rmb=bind_rmb+%d where account_id=%"I64_FMT"u"
#define DAwardRoleGameMoney			"update "DB_ROLE_TBL" set game_money=game_money+%d where role_uid=%"I64_FMT"u"

//================================== ���������־���� ==================================
// ���ص�ǰ���µ���������
#define DLoadCurWAllSourceWay	"select distinct source_way, chisource_way from RoleTbl"
// ��ȡĳʱ���µ����ʺ�(��ɫ)������������
#define DLoadWNewRegisterNum	"select count(*) from  RoleTbl where source_way = '%s' and chisource_way = '%s' and create_stamp >= '%u';"

//================================== ��־������־���� ==================================
// ���ص�ǰ���µ���������
#define DLoadCurRAllSourceWay	"select distinct pf, pd from m_roleinfo"
// ��ȡĳʱ���µ����ʺ�(��ɫ)������������
#define DLoadRNewRegisterNum	"select count(*) from  m_roleinfo where pf = '%s' and pd = '%s' and register_time >= '%u';"
// ��ȡ������ɫ(�ʺ�)����
#define DLoadRAllNewRegisterNum	"select count(*) from m_roleinfo where register_time >= '%u';"
// ��ȡ(�Ա�/�ȼ�)��Ӧ�Ľ�ɫ����
#define DLoadRoleNumBySexAndLvL "select count(*) from m_roleinfo where register_time >= '%u' and role_sex = '%u' and role_lvl = '%u';"
// ���ص����ɫ��������Ԫ������
#define DLoadCurRAllYB	"select coalesce(sum(role_rmb + role_bindrmb), 0) from m_roleinfo where date >= '%u' and date < '%u' and pf = '%s' and pd = '%s';"
// ���ؽ�ɫ��������Ԫ��
#define DLoadRAllYB	"select coalesce(sum(role_rmb + role_bindrmb), 0) from m_roleinfo where pf = '%s' and pd = '%s';"
// ���ص�������������ʯ����
#define BYB "61"	//����ʯ
#define YB	"20"	//��ʯ
#define WASTETYPE "1" //����
#define DLoadRCurAllWasteYB	"select coalesce(sum(change_num), 0) from m_moneywaste where money_type = "YB" and change_type = "WASTETYPE" and `date` >= '%u' and `date` < '%u' and pf = '%s' and pd = '%s';"
// ��������������ʯ����
#define DLoadRAllWasteYB	"select coalesce(sum(change_num), 0) from m_moneywaste where money_type = "YB" and change_type = "WASTETYPE" and pf = '%s' and pd = '%s';"
// ���浱����Ϸ����
#define DSaveGameCollect "insert into m_gamedata (`date`,`time`,accnum,newacc,rolenum,newrole,logins,paytotal,consume,totalwaste,newwaste,curinventory,inventory,pf,pd,serverid,updatetime) VALUES\
('%u','%u','%u','%u','%u','%u','%u','%u','%u','%u','%u','%u','%u','%s','%s','%u','%s') ON DUPLICATE KEY UPDATE accnum=VALUES(accnum),newacc=VALUES(newacc),rolenum=VALUES(rolenum),newrole=VALUES(newrole),\
logins=VALUES(logins),paytotal=VALUES(paytotal),consume=VALUES(consume),totalwaste=VALUES(totalwaste),newwaste=VALUES(newwaste),curinventory=VALUES(curinventory),inventory=VALUES(inventory),updatetime=VALUES(updatetime);"


#endif	// _DB_SQL_DEFINE_H_