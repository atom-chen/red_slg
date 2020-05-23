#ifndef _LIMIT_MANAGER_H_
#define _LIMIT_MANAGER_H_

#include "game_util.h"
#include "game_struct.h"

typedef std::vector<TLimitAccountInfo>		        LimitAccountInfoContainer;    //改成了列表结构
typedef LimitAccountInfoContainer::iterator		    LimitInfoItr;
typedef LimitAccountInfoContainer::const_iterator	LimitInfoCItr;

typedef std::vector<TLimitChatInfo>			        LimitChatInfoVec;

class CLimitManager : public GXMISC::CSingleton<CLimitManager>
{
public:
	CLimitManager();
	~CLimitManager();

public:
	void	update( uint32 diff );

public:
	//初始化封号列表
	void	initLimitAccountIDList(const TLimitAccountDBAry * dataary);
	//初始化禁言列表
	void	initLimitChatList(const TLimitChatDBAry * dataary);

	//添加封号
	EGameRetCode	addLimitAccount(const TLimitAccountInfo * data);
	//添加禁言
	EGameRetCode	addLimitChat(const TLimitChatInfo * data);

	//添加封号(针对map)
	EGameRetCode	addLimitAccountMap(const TLimitAccountInfo * data);
	//添加禁言(针对map)
	EGameRetCode	addLimitChatMap(const TLimitChatInfo * data);

	//删除封号
	EGameRetCode	deleteLimitAccount(const TServerOperatorId_t uniqueId );
	//删除禁言
	EGameRetCode	deleteLinitChat(const TServerOperatorId_t uniqueId);

	//更新封号时间
	EGameRetCode	updateLimitAccount(const TLimitAccountInfo * data);
	//更新禁言时间
	EGameRetCode	updateLimitChat(const TLimitChatInfo * data);

	//检查是否存在相同的封号记录
	bool isExistLimitAccountInfo(const TLimitAccountInfo * data );
	//检查是否存在相同的禁言记录
	bool isExistLimitChatInfo(const TLimitChatInfo * data );

	//查找封号信息位置
	LimitAccountInfoContainer::size_type findLimitAccountPos( const TServerOperatorId_t uniqueId  );
	//查找禁言信息位置
	LimitChatInfoVec::size_type findLimitChatPos( const TServerOperatorId_t uniqueId  );

	//通过账号id,查找封号信息
	void getLimitAccountByAccountId( TLimitAccountInfoVec *vec, TAccountID_t id );
	//通过账号id,查找禁言信息
	void getLimitChatByAccountId( TLimitChatInfoVec *vec, TAccountID_t id );

	//查该玩家是否在禁言期间
	bool isForbbidChat(TAccountID_t id);

public:
	bool				loadLimitInfoFromDB( const std::vector<TLimitAccountInfo>* data );

public:
	bool				checkLimitLogin( TAccountID_t accountID ) const;
	bool				checkLimitLogin( const std::string ip ) const;
	bool				checkLimitChat(TAccountID_t accountID) const;

public:
	void				updateLimitRole( ERoleLimitType limitType, TAccountID_t accountID, uint8 limitVal, GXMISC::TGameTime_t limitTime );
	void				updateLimitRole( ERoleLimitType limitType, const std::string& limitKey, uint8 limitVal, GXMISC::TGameTime_t limitTime );

private:
	void				cleanUp();
	TServerOperatorId_t getUniqueId();

private:
	// GXMISC::GXManuaTimer			_timer;						///< 定时器      @TODO 不知道干嘛，暂时关闭
	LimitAccountInfoContainer		_limitAccountInfo;			///< 封号信息列表
	LimitChatInfoVec				_limitChatVec;				///< 禁言信息列表
	TServerOperatorId_t             _maxMakeId;                 ///< 系统分配的最大id,一直递增，超过32位会出问题               
};

#define DCLLimitManager CLimitManager::GetInstance()

#endif