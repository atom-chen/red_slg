#ifndef _CHAR_MOVE_CORE_H_
#define _CHAR_MOVE_CORE_H_

#include "core/time/interval_timer.h"

#include "path_finder.h"
#include "object_util.h"

class CCharacterObject;

class CCharMoveCore
	: public CAStar<1>				// A*寻路	
{
public:
	typedef CAStar<1> TBaseTypeAStar;

public:
	CCharMoveCore(){}
	~CCharMoveCore(){}

public:
	void	cleanUp();
	bool	init( const TCharacterInit* inits );
	bool	update( GXMISC::TDiffTime_t diff );
	bool	updateOutBlock( GXMISC::TDiffTime_t diff );

public:
	void setCharacter(CCharacterObject* character);

protected:
	EGameRetCode doIdle( void );
	EGameRetCode doStop( bool flag );
	EGameRetCode doMove( uint32 posNum, const TAxisPos *paTargetPos);
	EGameRetCode doMove( TLogicMovePosList* posList );

protected:
	// 是否可以移动
	virtual bool moveable(const TAxisPos *tempPos,const TAxisPos *destPos, const int radius);
	// 移动更新
	const TAxisPos doMoveUpdate(GXMISC::TDiffTime_t diff, sint32 movePosNum = MAX_MOVE_POS_NUM, bool forceSend = false);
	// 移动一步事件
	virtual void onMove(const TAxisPos* pos);
	// 移动一次事件
	virtual void onMoveOneTimes(const TAxisPos* pos);
	// 到达终点
	virtual void onArriveDestPos();			
	// 得到能移动的步数
	virtual uint8 getMovePosNum(GXMISC::TDiffTime_t diff);		
	// 清除移动位置
	void clearMovePos();		

public:		
	// 是否正在移动
	bool isMoving();		
	// 得到最终需要移动的目标位置
	TAxisPos* getFinalTarPos();
	// 直接移动到某个目标点, 不做可行走检测
	void directMoveTo(const TAxisPos* tarPos);
	// 清空路点列表, 并重新寻路
	bool move(const TAxisPos* tarPos, bool needRefixPos);
	// 向路点列表中压入可行走点
	bool move(TLogicMovePosList* posList, bool moveFlag);
	// 向路点列表中压入可行走点
	virtual bool move(TPackMovePosList* posList);
	// 直线行走
	bool moveLine(const TAxisPos* tarPos);
	// 周围是否有空位
	bool isRangeEmptyPos(TRange_t range);
	// 查找一个空位
	bool findEmptyPos(TAxisPos* pos, TRange_t range);
	// 随机查找一个空位
	bool findRandEmptyPos(TAxisPos* pos, TRange_t range);
	// 路点是否为空
	bool posListEmpty();
	// 获取自身到目标点的距离
	TRange_t getRange(const TAxisPos* tarPos);
	// 是否在安全区
	bool isSafeZone();

private:
	TMoveSpeed_t _getMoveSpeed();

protected:
	GXMISC::TAppTime_t _lastMoveTime;			// 上次移动时间
	GXMISC::CManualIntervalTimer _moveTimer;	// 移动定时器
	TLogicMovePosList _logicMovePosList;		// 移动位置

private:
	CCharacterObject* _character;
};

#endif	// _CHAR_MOVE_CORE_H_