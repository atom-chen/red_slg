#ifndef _CHAT_PIPE_H_
#define _CHAT_PIPE_H_

#include "game_util.h"
#include "handler.h"
#include "carray.h"
#include "server_define.h"
#include "game_errno.h"
#include "stream_impl.h"
#include "base_packet_def.h"
#include "game_module.h"
#include "server_define.h"
#include "packet_cm_base.h"
#include "module_def.h"

class CRole;
class  CModChat : public CGameRoleModule
{	
public:
	CModChat(){ }
	~CModChat(){ }
	typedef CGameRoleModule TBaseType;
	/*私用接口*/


	virtual bool onLoad();
	// 初始化数据	
	virtual bool init(CRole* role,uint32 time=0);

private:
	

	/*公共接口*/
public:
	//角色进入后，定义角色可以发言
	void updateMax();	
	// 更新时间
	void update(uint32 diff);
	// 判断时间是否已过
	bool isTimePassed(uint8 chatChannel);
	// 重置计时器
	void reSetTime(uint8 chatChannel);
	
public:
	//GM命令
	void chatGm(CMChat* packet);


	//发送给世界频道（所有的人）		
	void chatWorld(CMChat* packet );
	//是否能够世界频道聊天	
	EGameRetCode isCanChatWorld(CMChat* packet);


	//发送到帮派频道(同一帮派或军团）	
	void chatFaction(CMChat* packet );
	//是否能够军团频道聊天                     //@TODO 暂时不考虑做
	EGameRetCode isCanChatFaction(CMChat* packet );

	//私聊频道（俩个人）	
	void chatFriend(CMChat* packet );
	//是否能够私聊频道聊天
	EGameRetCode isCanChatFriend(CMChat* packet );

	// 发送给系统频道
	void chatSystem(CMChat* packet );
	// 是否能够系统（公告）频道聊天
	EGameRetCode isCanChatSystem(CMChat* packet );

	

public:
	//检查聊天内容是否全为空格
	bool isMsgContentAllSpace(TCharArray2& msg);
	//检查是否有其他禁止内容
	bool isHaveOtherForbid(TCharArray2& msg);
	//	
	void toChatBroadMsg(MCChatBroad* broadMsg, CMChat* packet);

public:
	static std::vector<string> filterMsg;
	static std::set<string> filterMsgSet; 
	//线程无关的过滤字符函数
	void static doFilterContent(TCharArray2& msg, std::vector<string>& filterMsg );
	//采用分割聊天内容，过滤脏字
	void static doFilterContent2(TCharArray2& msg, std::set<string>& filterMsgSet);

private:
	GXMISC::CManualIntervalTimer _chatChannelLimitTime[CHAT_CHANNEL_NUMBER];
};


#endif
