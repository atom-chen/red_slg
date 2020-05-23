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
	/*˽�ýӿ�*/


	virtual bool onLoad();
	// ��ʼ������	
	virtual bool init(CRole* role,uint32 time=0);

private:
	

	/*�����ӿ�*/
public:
	//��ɫ����󣬶����ɫ���Է���
	void updateMax();	
	// ����ʱ��
	void update(uint32 diff);
	// �ж�ʱ���Ƿ��ѹ�
	bool isTimePassed(uint8 chatChannel);
	// ���ü�ʱ��
	void reSetTime(uint8 chatChannel);
	
public:
	//GM����
	void chatGm(CMChat* packet);


	//���͸�����Ƶ�������е��ˣ�		
	void chatWorld(CMChat* packet );
	//�Ƿ��ܹ�����Ƶ������	
	EGameRetCode isCanChatWorld(CMChat* packet);


	//���͵�����Ƶ��(ͬһ���ɻ���ţ�	
	void chatFaction(CMChat* packet );
	//�Ƿ��ܹ�����Ƶ������                     //@TODO ��ʱ��������
	EGameRetCode isCanChatFaction(CMChat* packet );

	//˽��Ƶ���������ˣ�	
	void chatFriend(CMChat* packet );
	//�Ƿ��ܹ�˽��Ƶ������
	EGameRetCode isCanChatFriend(CMChat* packet );

	// ���͸�ϵͳƵ��
	void chatSystem(CMChat* packet );
	// �Ƿ��ܹ�ϵͳ�����棩Ƶ������
	EGameRetCode isCanChatSystem(CMChat* packet );

	

public:
	//������������Ƿ�ȫΪ�ո�
	bool isMsgContentAllSpace(TCharArray2& msg);
	//����Ƿ���������ֹ����
	bool isHaveOtherForbid(TCharArray2& msg);
	//	
	void toChatBroadMsg(MCChatBroad* broadMsg, CMChat* packet);

public:
	static std::vector<string> filterMsg;
	static std::set<string> filterMsgSet; 
	//�߳��޹صĹ����ַ�����
	void static doFilterContent(TCharArray2& msg, std::vector<string>& filterMsg );
	//���÷ָ��������ݣ���������
	void static doFilterContent2(TCharArray2& msg, std::set<string>& filterMsgSet);

private:
	GXMISC::CManualIntervalTimer _chatChannelLimitTime[CHAT_CHANNEL_NUMBER];
};


#endif
