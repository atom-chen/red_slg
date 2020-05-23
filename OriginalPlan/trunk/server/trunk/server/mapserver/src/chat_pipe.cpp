#include "chat_pipe.h"
#include "role.h"
#include "game_exception.h"
#include "game_errno.h"
#include "map_world_handler.h"
#include "gm_manager.h"
#include "dirty_word_filter.h"

#define MAXCHATTIME     120000     //最大时间
#define MAX_CHAT_LEN    120        //聊天内容长度

std::vector<string> CModChat::filterMsg;              //@TODO 过滤字符需要提前加载好

bool CModChat::onLoad()
{		
	//让玩家第一次在发送消息后，马上进行第二次登陆，能够马上发送聊天消息
	updateMax();
	
	return true;
}

bool CModChat::init(CRole* role, uint32 time)
{
	if(!TBaseType::init(role))
	{
		return false;
	}
		
	//@TODO需读配置常量值
	//init会把最大时间设为5s, 过去的时间 设置为0
	_chatChannelLimitTime[CHAT_CHANNEL_WORLD].init(5*1000);	    // 世界频道	
	_chatChannelLimitTime[CHAT_CHANNEL_FACTION].init(0);        // 帮派频道		
	_chatChannelLimitTime[CHAT_CHANNEL_PRIVATE].init(0);  	    // 私聊频道	
	_chatChannelLimitTime[CHAT_CHANNEL_SYSTEM].init(0) ;    	// 系统频道

	return true;
}

void CModChat::update(uint32 diff)
{
	//role 执行 update函数，会执行该函数
	_chatChannelLimitTime[CHAT_CHANNEL_SYSTEM].update(diff);
	_chatChannelLimitTime[CHAT_CHANNEL_WORLD].update(diff);
	_chatChannelLimitTime[CHAT_CHANNEL_PRIVATE].update(diff);	
	_chatChannelLimitTime[CHAT_CHANNEL_FACTION].update(diff);	

	return ;
	
}

void CModChat::updateMax()
{

	_chatChannelLimitTime[CHAT_CHANNEL_SYSTEM].update(MAXCHATTIME);
	_chatChannelLimitTime[CHAT_CHANNEL_WORLD].update(MAXCHATTIME);
	_chatChannelLimitTime[CHAT_CHANNEL_PRIVATE].update(MAXCHATTIME);	
	_chatChannelLimitTime[CHAT_CHANNEL_FACTION].update(MAXCHATTIME);
	

	return ;	 
}

bool CModChat::isTimePassed(uint8 chatChannel)
{	
	return _chatChannelLimitTime[chatChannel].isPassed();
}

void CModChat::reSetTime(uint8 chatChannel)
{
	_chatChannelLimitTime[chatChannel].reset(true);
}


void CModChat::toChatBroadMsg(MCChatBroad* broadMsg, CMChat* packet)
{
	broadMsg->channelType = packet->channelType;
	broadMsg->objUid      = packet->objUid;
	broadMsg->roleName    = packet->roleName;
	broadMsg->msg         = packet->msg;
	broadMsg->perMsg      = packet->perMsg;

	return ;
}

bool CModChat::isMsgContentAllSpace(TCharArray2& msg)
{
	for(TCharArray2::iterator it=msg.begin(); it!=msg.end(); it++ )
	{
		if( *it != ' ')
		{
			return false;
		}
	}

	return true;
}

bool CModChat::isHaveOtherForbid(TCharArray2& msg)
{

	return false;
}

//线程无关的静态函数
void CModChat::doFilterContent(TCharArray2& msg, std::vector<string>& filterMsg )
{
	//替换禁止的内容	
	string str_msg;
	str_msg.clear();
	str_msg = msg.toString();
	//string str_msg(msg.begin(), msg.end());	
	filterMsg = DCheckText.getFilterContentVec();
	for( std::vector<string>::size_type t=0; t!=filterMsg.size(); t++)
	{
		while( true )
		{		
			string tmp_str;
			//处理windown和linux在处理换行时区别做的特殊处理（我们的过滤文档时现在windows环境生成的)
			if(filterMsg[t].size()>1 && filterMsg[t][ filterMsg[t].size()-1 ] == '\r')
			{
				copy(filterMsg[t].begin(), filterMsg[t].end()-1, back_inserter(tmp_str) );
			}
			else
			{
				//tmp_str = filterMsg[t];
				copy(filterMsg[t].begin(), filterMsg[t].end(), back_inserter(tmp_str) );
			}

			std::string::size_type index = str_msg.find(tmp_str);
			if( index != std::string::npos )
			{
				str_msg.replace(index, filterMsg[t].length(), string("**"));
			}
			else
			{
				break;
			}
		}

		//防止消息内容无限被替换
		if(str_msg.length()> MAX_CHAT_LEN )
		{
			break;
		}
	}
	
	msg.clear();
	msg = str_msg;

	return ;
}

//过滤方法2(暂时还没经过测试）
void CModChat::doFilterContent2(TCharArray2& msg, std::set<string>& filterMsgSet)
{
	//替换禁止的内容
	string str_msg(msg.begin(), msg.end());	
	std::vector<string> msg_vec;
	
	//分割聊天内容
	for( string::size_type i=1; i<= str_msg.length(); i++ )
	{
		for( string::size_type j=0; j+i <= str_msg.length(); j++)
		{	
			msg_vec.push_back( str_msg.substr(j, i));
		}
	}

	//匹配比较
	for(std::vector<string>::iterator it=msg_vec.begin(); it!=msg_vec.end(); it++)
	{
		if( !DCheckText.isFilterContent(*it) )
		{
			str_msg.replace(0, str_msg.length(), string("**"));
		}

		//防止消息内容无限被替换
		if(str_msg.length() > MAX_CHAT_LEN )
		{
			break;
		}
	}

	msg.clear();
	msg = str_msg;
}

void CModChat::chatGm(CMChat* packet)
{
	FUNC_BEGIN(CHAT_MOD);	
	EGameRetCode retCode=RC_SUCCESS;
	MCChatBroad broadMsg;
	broadMsg.setRetCode(RC_SUCCESS);

	TGmCmdStr_t chatText = packet->msg.toString();
	if ( chatText.size() > 3  && chatText[0] == 'g' && chatText[1] == 'm' )
	{
		//如果是GM命令则只发给本人
		EGameRetCode retCode = RC_SUCCESS;
		// 			if ( chatText.size() > 4 && chatText[3] == 'w' )	// @TODO
		// 			{
		// 				MWGmCmdStr gmCmdMsg;
		// 				gmCmdMsg.gmStr = chatText.data();
		// 				SendToWorld(gmCmdMsg);
		// 			}
		// 			else
		// 			{
		// 
		// 			}

		retCode = DGmCmdMgr.parse(getRole(), chatText);
		broadMsg.msg = packet->msg.toString();
		broadMsg.setRetCode(retCode);		
	}
	else
	{
		broadMsg.setRetCode(RC_CHAT_INVALID_GM_ERR);
	}
	getRole()->sendPacket( broadMsg );

	FUNC_END(DRET_NULL);
}

EGameRetCode CModChat::isCanChatWorld(CMChat* packet)
{
	//检查是否已被禁言	
	if( getRole()->isForbbidChat(getRole()->getAccountID()) )
	{
		return RC_CHAT_FORBBID_ERR;
	}

	// 检查角色等级
	if( getRole()->getLevel() < 0 )
	{
		return RC_CHAT_SMALL_LEVEL_ERR;
	}

	// 检查间隔时间                                         
	if( !isTimePassed( CHAT_CHANNEL_WORLD )  )
	{
		return RC_CHAT_GAP_TIME_TOO_SHORT_ERR;
	}

	// 检查聊天内容长度
	if( packet->msg.empty() )
	{
		return RC_CHAT_CONTENT_IS_EMPTY_ERR;
	}

	// 检查聊天内容是否只是一个或多个空格
	if( isMsgContentAllSpace(packet->msg) )
	{
		return RC_CHAT_CONTENT_ALL_EMPTY_ERR;
	}

	// 其他禁止字符
	if( isHaveOtherForbid(packet->msg) )
	{
		return RC_CHAT_OTHER_FORBID_CONTENT_ERR;
	}

	// 聊天内容长度限制
	if( packet->msg.size() > MAX_CHAT_LEN )
	{
		return RC_CHAT_CONTENT_TOO_LONG_ERR;
	}

	return RC_SUCCESS;
}

void CModChat::chatWorld(CMChat* packet )
{
	FUNC_BEGIN(CHAT_MOD);	

	EGameRetCode retCode=RC_SUCCESS;
	MCChatBroad broadMsg;
	broadMsg.setRetCode(RC_SUCCESS);

	retCode = isCanChatWorld(packet );
	if( retCode != RC_SUCCESS )
	{
		broadMsg.setRetCode(retCode);
		getRole()->sendPacket( broadMsg );
		gxError("retCode={0}", sint32(retCode) );
		return ;
	}

	//屏蔽处理方法2 @TODO 目前客户端，会出现死掉的现象
	//std::set<string> filterMsgSet;
	//doFilterContent2(packet->msg, filterMsgSet);


	//处理过滤字符
	doFilterContent(packet->msg, filterMsg);

	TObjUID_t srcObjUid = getRole()->getObjUID();
	TRoleName_t srcRoleName = getRole()->getRoleName();	
	
	toChatBroadMsg(&broadMsg, packet);
	broadMsg.objUid     = srcObjUid;
	broadMsg.roleName   = srcRoleName;

	BroadCastToWorld(broadMsg, getRole()->getObjUID(), true);

	//reSetTime  会把 过去的时间 设置为0
	reSetTime(packet->channelType);

	FUNC_END(DRET_NULL);
}

EGameRetCode CModChat::isCanChatFaction(CMChat* packet)
{
	// @TODO  常量暂时写死
	// 检查角色等级
	if( getRole()->getLevel() <= 10 )
	{
		return RC_CHAT_SMALL_LEVEL_ERR;
	}
		

	// 检查聊天内容长度
	if( packet->msg.empty() )
	{
		return RC_CHAT_CONTENT_IS_EMPTY_ERR;
	}

	// 检查聊天内容是否只是一个或多个空格
	if( isMsgContentAllSpace(packet->msg) )
	{
		return RC_CHAT_CONTENT_ALL_EMPTY_ERR;
	}

	// 其他禁止字符
	if( isHaveOtherForbid(packet->msg) )
	{
		return RC_CHAT_OTHER_FORBID_CONTENT_ERR;
	}

	// 聊天内容长度限制
	if( packet->msg.size() > MAX_CHAT_LEN )
	{
		return RC_CHAT_CONTENT_TOO_LONG_ERR;
	}

	// 检查是否加入军团
	//@TODO

	return RC_SUCCESS;
}

//发送到帮派频道(同一帮派或军团）	
void CModChat::chatFaction(CMChat* packet )
{
	FUNC_BEGIN(CHAT_MOD);
	EGameRetCode retCode=RC_SUCCESS;
	MCChatBroad broadMsg;
	broadMsg.setRetCode(RC_SUCCESS);

	retCode = isCanChatFaction(packet );
	if( retCode != RC_SUCCESS )
	{
		broadMsg.setRetCode(retCode);
		getRole()->sendPacket( broadMsg );
		gxError("retCode={0}", (sint32)retCode);
		return ;
	}

	//处理过滤字符
	doFilterContent(packet->msg, filterMsg);

	TRoleUID_t srcObjUid = getRole()->getObjUID();
	TRoleName_t srcRoleName = getRole()->getRoleName();

	toChatBroadMsg(&broadMsg, packet);

	BroadCastToWorld(broadMsg, getRole()->getObjUID(), true);

	FUNC_END(DRET_NULL);
}

EGameRetCode CModChat::isCanChatFriend(CMChat* packet)
{
	// @TODO  常量暂时写死
	// 检查角色等级
	if( getRole()->getLevel() <= 10 && false )        //@TODO
	{
		return RC_CHAT_SMALL_LEVEL_ERR;
	}
	
	// 检查聊天内容长度
	if( packet->msg.empty() )
	{
		return RC_CHAT_CONTENT_IS_EMPTY_ERR;
	}

	// 检查聊天内容是否只是一个或多个空格
	if( isMsgContentAllSpace(packet->msg) )
	{
		return RC_CHAT_CONTENT_ALL_EMPTY_ERR;
	}

	// 其他禁止字符
	if( isHaveOtherForbid(packet->msg) )
	{
		return RC_CHAT_OTHER_FORBID_CONTENT_ERR;
	}

	// 聊天内容长度限制
	if( packet->msg.size() > MAX_CHAT_LEN )
	{
		return RC_CHAT_CONTENT_TOO_LONG_ERR;
	}

	return RC_SUCCESS;
}

//私聊频道（俩个人）	
void CModChat::chatFriend(CMChat* packet)
{
	FUNC_BEGIN(CHAT_MOD);
	EGameRetCode retCode=RC_SUCCESS;
	MCChatBroad broadMsg;
	broadMsg.setRetCode(RC_SUCCESS);

	retCode = isCanChatFriend(packet );
	if( retCode != RC_SUCCESS )
	{
		broadMsg.setRetCode(retCode);
		getRole()->sendPacket( broadMsg );
		gxError("retCode={0}", sint32(retCode) );
		return ;
	}

	//处理过滤字符
	doFilterContent(packet->msg, filterMsg);

	TObjUID_t srcObjUid     = getRole()->getObjUID();
	TRoleName_t srcRoleName = getRole()->getRoleName();


	TObjUID_t objUid = packet->objUid;

	packet->roleName        = srcRoleName;
	packet->objUid          = srcObjUid;

	toChatBroadMsg(&broadMsg, packet);

	Trans2OtherMapServer(broadMsg, srcObjUid, objUid, false);

	FUNC_END(DRET_NULL);
}

EGameRetCode CModChat::isCanChatSystem(CMChat* packet)
{
	return RC_SUCCESS;
}

// 发送给系统频道
void CModChat::chatSystem(CMChat* packet)
{
	FUNC_BEGIN(CHAT_MOD);
	EGameRetCode retCode=RC_SUCCESS;
	MCChatBroad broadMsg;
	broadMsg.setRetCode(RC_SUCCESS);

	retCode = isCanChatSystem(packet );
	if( retCode != RC_SUCCESS )
	{
		broadMsg.setRetCode(retCode);
		getRole()->sendPacket( broadMsg );
		gxError("retCode={0}", sint32(retCode) );
		return ;
	}

	//处理过滤字符
	doFilterContent(packet->msg, filterMsg);

	TRoleUID_t srcObjUid = getRole()->getObjUID();
	TRoleName_t srcRoleName = getRole()->getRoleName();

	toChatBroadMsg(&broadMsg, packet);

	BroadCastToWorld(broadMsg, getRole()->getObjUID(), true);

	FUNC_END(DRET_NULL);
}

