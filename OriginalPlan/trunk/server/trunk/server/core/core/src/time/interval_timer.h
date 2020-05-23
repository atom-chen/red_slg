#ifndef _INTERVAL_TIMER_H_
#define _INTERVAL_TIMER_H_

#include "stdcore.h"
#include "types_def.h"
#include "time_gx.h"
#include "singleton.h"
#include "time_util.h"

namespace GXMISC
{
	// @TODO 定时器需要重新设计

	/// 最大触发次数
	static const uint32 INVALID_INTERVAL_TIMER_COUNT = std::numeric_limits<uint32>::max();
	
	class CIntervalTimer
	{
        friend class CIntervalTimerMgr;

	public:
		CIntervalTimer();
		CIntervalTimer(uint32 maxInterval, uint32 num = INVALID_INTERVAL_TIMER_COUNT);
		~CIntervalTimer();

	public:
		// 设置最大间隔时间
		void setMaxInterval(TTime maxInterval);
		// 设置触发次数
		void setMaxNum(uint32 num);
        // 初始化最大时间间隔及最大触发次数
        void init(uint32 maxInterval, uint32 num = INVALID_INTERVAL_TIMER_COUNT);

	public:
		// 更新时间
		void update(TTime diff);
		// 判断是否已经到达时间
		bool isPassed();
		// 判断定时器是否有效(如触发次数仍多于0)
		bool isValid();
		// 执行一次超时操作
		void doTimeout();
		// 重置
		void reset(bool force = true);
		TTime getCurInterval();
		TTime getRemainInterval();
		sint32 getRemainSecs();
		sint32 getMaxSecs();

	public:
		// 触发函数
		virtual bool onTimeout(){return true;};

	private:
		bool isUnlimit();
        bool isNeedFree();
        void setNeedFree();

	private:
		uint32 _maxNum;				// 最大触发次数
		uint32 _num;				// 定时器触发次数(INVALID_INTERVAL_TIMER_COUNT表示无限制触发)
		TTime _curInterval;			// 间隔的时间(单位为毫秒)
		TTime _maxInterval;			// 设置的间隔时间
        bool  _isNeedFree;          // 是否需要释放
	};

	class CManualIntervalTimer
	{
	public:
		CManualIntervalTimer();
		CManualIntervalTimer(uint32 maxInterval);
		~CManualIntervalTimer();

	public:
		// 设置最大间隔时间
		void setMaxInterval(TTime maxInterval);
		// 初始化最大时间间隔及最大触发次数
		void init(uint32 maxInterval);

	public:
		// 更新时间
		bool update(TTime diff);
		// 判断是否已经到达时间
		bool isPassed();
		// 重置
		void reset(bool force = true);
		TTime getCurInterval();
		TTime getRemainInterval();
		sint32 getRemainSecs();
		sint32 getMaxSecs();

	private:
		TTime _curInterval;			// 间隔的时间(单位为毫秒)
		TTime _maxInterval;			// 设置的间隔时间
	};

	typedef std::list<CIntervalTimer*> TIntervalTimerList;
	class CIntervalTimerMgr : public CManualSingleton<CIntervalTimerMgr>
	{
	public:
		CIntervalTimerMgr();
		~CIntervalTimerMgr();

	public:
		void addTimer(CIntervalTimer* timer, bool isNeedFree = true);
		void update(TTime diff);

	private:
		TIntervalTimerList _timerList;
	};

	// 定义定时器管理器宏
	#define DIntervalTimerMgr CIntervalTimerMgr::GetInstance()
	typedef GXMISC::CManualIntervalTimer	GXManuaTimer;				///< 手动定时器
}

#endif 