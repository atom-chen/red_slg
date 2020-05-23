#ifndef _RECHARGE_DEF_H_
#define _RECHARGE_DEF_H_

#include <vector>
#include <string>

#include "game_util.h"
#include "core/game_time.h"

// 充值日志(一次充值有多条日志)
enum ERechargeLog
{
	RECHARGE_LOG_PLAT_REQUEST = 1,			// 平台开始充值
	RECHARGE_LOG_SERIA_NO_ERR = 2,			// 充值序号无法找到
	RECHARGE_LOG_SEND_GAME = 3,				// 发送充值请求到游戏服务器
	RECHARGE_LOG_SEND_GAME_FAILED = 4,		// 游戏服务器未开放
	RECHARGE_LOG_ONLINE = 5,				// 玩家在线, 直接充值角色身上
	RECHARGE_LOG_OFFLINE = 6,				// 玩家不在线, 充值到数据库
	RECHARGE_LOG_FAILED = 7,				// 充值失败, 游戏返回充值错误消息
	RECHARGE_LOG_RETRY = 8,					// 充值补单请求
};

// 充值记录(唯一)
enum ERechargeRecordStatus
{
	RECHARGE_RECORD_STATUS_PALT = 1,				// 平台充值成功
	RECHARGE_RECORD_STATUS_ACCOUNT_SUCCESS = 2,		// 充值到玩家账号成功
	RECHARGE_RECORD_STATUS_ACCOUNT_FAILED = 3,		// 充值到玩家账号失败
	RECHARGE_RECORD_STATUS_RETRY_SUCCESS = 4,		// 补单到玩家账号成功
};

// 充值记录
typedef struct RechargeRecord
{
	TSerialStr_t serialNo;			// 充值序号
	TAccountID_t accountID;			// 账号ID
	TRmb_t rmb;						// 充值数
	GXMISC::CGameTime dateTime;		// 充值时间
	ERechargeRecordStatus status;	// 充值状态
}TRechargeRecord;
typedef std::vector<TRechargeRecord> TRechargeRecordAry;

// 玩家充值信息
class CRoleRmb
{
public:
	TAccountID_t accountID;	// 账号ID
	TRmb_t totalRmb;		// 总充值额
	TRmb_t curRmb;			// 当前充值额
	bool hasRecharge;		// 是否已经冲过值
	bool isFirstRecharge;	// 是否第一个充值
};

// 充值文件日志
#define DRECHARGE_LOG(serno, serverID, accountID, rmb, bindRmb, eno, msg){	\
	std::string fmt = msg;	\
	fmt += "!SerialNo={0},ServerID={1},AccountID={2},Rmb={3},BindRmb={4},Errno={5}.";	\
	gxInfo(fmt.c_str(), serno.toString(),serverID,accountID,rmb,bindRmb,eno);}

#endif // _RECHARGE_DEF_H_