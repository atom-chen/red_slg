#ifndef _DB_SQL_DEFINE_H_
#define _DB_SQL_DEFINE_H_

// ================================== 玩家账号 ==================================
// 查询账号
//#define DLoadAccount			"select account_id,last_server_id,gm_power from %s where account='%s' and password='%s'"
#define DLoadAccount			"select account_id,last_server_id,gm_power from %s where account='%s'"
#define DInsertAccount			"insert into %s (account,password,platUID,macid,source_way,chisource_way) values('%s','%s','%s','%s','%s','%s')"
#define DLoadAccountInfo		"select account_id,account,platUID,macid from %s where account_id = '%"I64_FMT"u'"
#define DUpdateAccountInfo		"update %s set last_server_id=%d where account_id='%"I64_FMT"u'"

// ================================== 玩家角色 ==================================
// 查询最大的RoleUID和ObjUID
#define DSelectMaxRoleUID		"select max(role_uid),max(obj_uid) from %s"
// 检查角色名字是否已经重复
#define DCheckNameRepeat		"select * from "DB_ROLE_TBL" where name='%s'"
// 获取随机名字的最大名字
#define DGetMaxRandRoleName		"SELECT `name` FROM "DB_ROLE_TBL" WHERE `name` LIKE 'GMR%' GROUP BY `name` DESC LIMIT 1;"
// 通过账号ID得到角色UID
#define DGetRoleUIDByAccountID "select role_uid from "DB_ROLE_TBL" where account_id=%"I64_FMT"u"

//================================== 世界服务器用户 ==================================
// 加载User数据
#define DLoadUserData	"select close_server_time, user_flag from %s where role_uid = '%s'"

//================================== 元宝充值 ==================================
// 元宝充值
#define DQueryRoleRmb			"select rmb,bind_rmb,total_rmb from "DB_ROLE_TBL" where role_uid='%"I64_FMT"u'"
#define DQueryAccountRmb		"select rmb,bind_rmb from "DB_ACCOUNT_TBL" where account_id='%"I64_FMT"u'"
#define DAddAccountRmb			"update "DB_ACCOUNT_TBL" set rmb=if(rmb+%d>0, rmb+%d, 0), bind_rmb=if(bind_rmb+%d>0, bind_rmb+%d, 0) where account_id='%"I64_FMT"u';"
#define DQueryLastTimeRoleUID	"select role_uid from "DB_ROLE_TBL" where account_id='%"I64_FMT"u' order by logout_time desc limit 1;"
#define DInsertTempRmbRecord	"insert into "DB_RECHARGE_TEMP_TBL" (serial_no,account_id,rmb,bind_rmb,status) values('%s',%"I64_FMT"u,%d,%d,%u)"
#define DDelTempRmbRecord		"delete "DB_RECHARGE_TEMP_TBL" where serial_no='%s';"
#define DUpdateTempRmbRecordStatus "update "DB_RECHARGE_TEMP_TBL" set status='%u' where serial_no='%s';"

// 元宝, 金钱奖励
#define DAwardAllRoleBindRmb		"update "DB_ACCOUNT_TBL" set bind_rmb=bind_rmb+%d"
#define DAwardAllRoleGameMoney		"update "DB_ROLE_TBL" set game_money=game_money+%d"
#define DAwardRoleBindRmb			"update "DB_ACCOUNT_TBL" set bind_rmb=bind_rmb+%d where account_id=%"I64_FMT"u"
#define DAwardRoleGameMoney			"update "DB_ROLE_TBL" set game_money=game_money+%d where role_uid=%"I64_FMT"u"

//================================== 世界服务日志查找 ==================================
// 加载当前服下的所有渠道
#define DLoadCurWAllSourceWay	"select distinct source_way, chisource_way from RoleTbl"
// 获取某时间下的新帐号(角色)数量包含渠道
#define DLoadWNewRegisterNum	"select count(*) from  RoleTbl where source_way = '%s' and chisource_way = '%s' and create_stamp >= '%u';"

//================================== 日志服务日志查找 ==================================
// 加载当前服下的所有渠道
#define DLoadCurRAllSourceWay	"select distinct pf, pd from m_roleinfo"
// 获取某时间下的新帐号(角色)数量包含渠道
#define DLoadRNewRegisterNum	"select count(*) from  m_roleinfo where pf = '%s' and pd = '%s' and register_time >= '%u';"
// 获取创建角色(帐号)总数
#define DLoadRAllNewRegisterNum	"select count(*) from m_roleinfo where register_time >= '%u';"
// 获取(性别/等级)对应的角色数量
#define DLoadRoleNumBySexAndLvL "select count(*) from m_roleinfo where register_time >= '%u' and role_sex = '%u' and role_lvl = '%u';"
// 加载当天角色身上所有元宝数量
#define DLoadCurRAllYB	"select coalesce(sum(role_rmb + role_bindrmb), 0) from m_roleinfo where date >= '%u' and date < '%u' and pf = '%s' and pd = '%s';"
// 加载角色身上所有元宝
#define DLoadRAllYB	"select coalesce(sum(role_rmb + role_bindrmb), 0) from m_roleinfo where pf = '%s' and pd = '%s';"
// 加载当天所有消费钻石数量
#define BYB "61"	//绑定钻石
#define YB	"20"	//钻石
#define WASTETYPE "1" //消耗
#define DLoadRCurAllWasteYB	"select coalesce(sum(change_num), 0) from m_moneywaste where money_type = "YB" and change_type = "WASTETYPE" and `date` >= '%u' and `date` < '%u' and pf = '%s' and pd = '%s';"
// 加载所有消费钻石数量
#define DLoadRAllWasteYB	"select coalesce(sum(change_num), 0) from m_moneywaste where money_type = "YB" and change_type = "WASTETYPE" and pf = '%s' and pd = '%s';"
// 保存当天游戏汇总
#define DSaveGameCollect "insert into m_gamedata (`date`,`time`,accnum,newacc,rolenum,newrole,logins,paytotal,consume,totalwaste,newwaste,curinventory,inventory,pf,pd,serverid,updatetime) VALUES\
('%u','%u','%u','%u','%u','%u','%u','%u','%u','%u','%u','%u','%u','%s','%s','%u','%s') ON DUPLICATE KEY UPDATE accnum=VALUES(accnum),newacc=VALUES(newacc),rolenum=VALUES(rolenum),newrole=VALUES(newrole),\
logins=VALUES(logins),paytotal=VALUES(paytotal),consume=VALUES(consume),totalwaste=VALUES(totalwaste),newwaste=VALUES(newwaste),curinventory=VALUES(curinventory),inventory=VALUES(inventory),updatetime=VALUES(updatetime);"


#endif	// _DB_SQL_DEFINE_H_