
#ifndef _TIMER_H_
#define _TIMER_H_

#include "time/date_time.h"
#include "time/interval_timer.h"
#include "time_manager.h"
#include "base_util.h"
#include "debug.h"
#include "parse_misc.h"

/**
 * 定时器介绍:
 * 每个定时器都有开始时间, 结束时间, 持续时间
 * 1. 相对定时器(ST), 如: 每隔几天, 几小时,几分钟,几秒钟 触发 @TODO暂时不用
 * 2. 普通定时器(NT), 如: 每隔一定时间 触发
 * 3. 绝对定点定时器(AST), 如: 每分钟的5秒,10秒,....50秒,每小时的5分,10分...50分, 每天的1小时~24小时 触发
 * 4. 绝对定时器(AT), 如: 日,星期几 时:分 触发
 * 5. 持续定时器(IT), 如: 起始时间~结束时间有效
 */

namespace GXMISC
{
	/// 定时器函数
	enum EGameTimerFunc
	{
		GAME_TIMER_FUNC_START,		///< 开始
		GAME_TIMER_FUNC_END,		///< 结束
		GAME_TIMER_FUNC_INVALID,	///< 失效

		GAME_TIMER_FUNC_NUMBER,		///< 定时器数目
	};

	/// 定时器类型
	enum EATimeType
	{
		ATIME_INVALID,				///< 无效
		ATIME_DAY,					///< 每天的X点~X点
		ATIME_WEEKDAY,				///< 每周几
		ATIME_MONTH,				///< 每月第几天
	};

	/// 定时器类型
	enum ETimerType
	{
		TIMER_TYPE_INVALID,			///< 无效
		TIMER_TYPE_ST,				///< 定点定时器
		TIMER_TYPE_NT,				///< 普通定时器
		TIMER_TYPE_AST,				///< 绝对定点定时器
		TIMER_TYPE_AT,				///< 绝对定时器
		TIMER_TYPE_IT,				///< 持续定时器
	};
	
	/// 绝对定时器类型
	enum	EAbsoluteTimerType
	{
		INVALID_ABSOLUTE_TIMER = 0,		///< 无效类型
		MONTH_ABSOLUTE_TIMER,			///< 月 @TODO 废弃, 请使用定点定时器
		DAY_ABSOLUTE_TIMER,				///< 日 @TODO 废弃, 请使用定点定时器
		HOUR_ABSOLUTE_TIMER,			///< 小时 
		MINUTE_ABSOLUTE_TIMER,			///< 分钟
		SECOND_ABSOLUTE_TIMER,			///< 秒
	};

	typedef std::vector<TGameTimerID_t>		TTimerIDContainer;

	/// 定时器间隔
	typedef	struct _GameTimerInterval
	{
	public:
		sint32			year;		///< 年
		sint32			month;		///< 月
		sint32			day;		///< 天
		sint32			hour;		///< 时
		sint32			minute;		///< 分
		sint32			seconds;	///< 秒
		TDiffTime_t		lastTime;	///< 持续时间
		sint32			callTimes;	///< 调用次数

	public:
		_GameTimerInterval()
		{
			cleanUp();
		}

		_GameTimerInterval& operator = ( const _GameTimerInterval& ls )
		{
			year = ls.year;
			month = ls.month;
			day = ls.day;
			hour = ls.hour;
			minute = ls.minute;
			seconds = ls.seconds;
			callTimes = ls.callTimes;
			lastTime = ls.lastTime;
			return *this;
		}

		void cleanUp()
		{
			year = 0;
			month = 0;
			day = 0;
			hour = 0;
			minute = 0;
			seconds = 0;
			callTimes = MAX_UINT32_NUM;
			lastTime = INVALID_GAME_TIME;
		}

	}TGameTimerInterval;
	typedef std::vector<TGameTimerInterval>			TGameTimerIntervalVec;
	typedef TGameTimerIntervalVec::const_iterator	TGameTimerIntervalItr;

	class CTimerBase;
	typedef void (*TTimerFunc)(CTimerBase*, TGameTime_t, void*);

	class ITimer
	{
	public:
		virtual bool beginTriggerFunc(){ return true; }
		virtual bool endTriggerFunc(){ return true; }
		virtual bool invalidFunc(){ return true; }
	};

	static sint32 GetDiffInterval(sint32 sday, sint32 shour, sint32 smin, sint32 ssec, sint32 eday, sint32 ehour, sint32 emin, sint32 esec){
		sint32 sseconds = sday*SECOND_IN_DAY+shour*SECOND_IN_HOUR+smin*SECOND_IN_MINUTE+ssec;
		sint32 eseconds = eday*SECOND_IN_DAY+ehour*SECOND_IN_HOUR+emin*SECOND_IN_MINUTE+esec;
		return eseconds-sseconds;
	}
	static sint32 GetDiffInterval(sint32 sday, sint32 shour = 0, sint32 smin = 0, sint32 ssec = 0){
		sint32 sseconds = sday*SECOND_IN_DAY+shour*SECOND_IN_HOUR+smin*SECOND_IN_MINUTE+ssec;
		return sseconds;
	}
	
	// 指定时间是否在范围内
	// d:h:m:s
	static sint32 IsTimeInDay(sint32 sday, sint32 shour, sint32 smin, sint32 ssec, sint32 eday, sint32 ehour, sint32 emin, sint32 esec, TGameTime_t curTime)
	{
		sint32 year = DTimeManager.getYear();
		sint32 month = DTimeManager.getMonth();
		CDateTime sTime(year, month, sday, shour, smin, ssec);
		CDateTime eTime(year, month, eday, ehour, emin, esec);

		TGameTime_t startTime = sTime.totalSecs();
		TGameTime_t endTime = eTime.totalSecs();
		return curTime >= startTime && curTime < endTime;
	}
	// d:h:m
	static sint32 IsTimeInDay(sint32 sday, sint32 shour, sint32 smin, sint32 eday, sint32 ehour, sint32 emin, TGameTime_t curTime)
	{
		return IsTimeInDay(sday, shour, smin, 0, eday, ehour, emin, 0, curTime);
	}
	// h:m:s
	static sint32 IsTimeIn(sint32 shour, sint32 smin, sint32 ssec, sint32 ehour, sint32 emin, sint32 esec, TGameTime_t curTime)
	{
		return IsTimeInDay(0, shour, smin, ssec, 0, ehour, emin, esec, curTime);
	}
	// h:m
	static sint32 IsTimeIn(sint32 shour, sint32 smin, sint32 ehour, sint32 emin, TGameTime_t curTime)
	{
		return IsTimeInDay(0, shour, smin, 0, 0, ehour, emin, 0, curTime);
	}
	// 当前时间是否在范围内
	// d:h:m:s
	static sint32 IsTimeInDay(sint32 sday, sint32 shour, sint32 smin, sint32 ssec, sint32 eday, sint32 ehour, sint32 emin, sint32 esec)
	{
		return IsTimeInDay(sday, shour, smin, ssec, eday, ehour, emin, esec, DTimeManager.nowSysTime());
	}
	// d:h:m
	static sint32 IsTimeInDay(sint32 sday, sint32 shour, sint32 smin, sint32 eday, sint32 ehour, sint32 emin)
	{
		return IsTimeInDay(sday, shour, smin, 0, eday, ehour, emin, 0, DTimeManager.nowSysTime());
	}
	// h:m:s
	static sint32 IsTimeIn(sint32 shour, sint32 smin, sint32 ssec, sint32 ehour, sint32 emin, sint32 esec)
	{
		return IsTimeInDay(0, shour, smin, ssec, 0, ehour, emin, esec, DTimeManager.nowSysTime());
	}
	// h:m
	static sint32 IsTimeInDay(sint32 shour, sint32 smin, sint32 ehour, sint32 emin)
	{
		return IsTimeInDay(0, shour, smin, 0, 0, ehour, emin, 0, DTimeManager.nowSysTime());
	}
	// 指定的星期时间是否在范围内
	static sint32 IsTimeInWeek(sint32 sweek, sint32 shour, sint32 smin, sint32 ssec, sint32 eweek, sint32 ehour, sint32 emin, sint32 esec, TGameTime_t curTime)
	{
		CDateTime times((TTime)curTime);
		sint32 cweek = times.dayOfWeek();
		sint32 chour = times.hour();
		sint32 cmin = times.minute();
		sint32 csec = times.second();
		sint32 sseconds = GetDiffInterval(sweek, shour, smin, ssec);
		sint32 eseconds = GetDiffInterval(eweek, ehour, emin, esec);
		sint32 cseconds = GetDiffInterval(cweek, chour, cmin, csec);
		return cseconds >= sseconds && cseconds < eseconds;
	}
	static sint32 IsTimeInWeek(sint32 sweek, sint32 shour, sint32 smin, sint32 ssec, sint32 eweek, sint32 ehour, sint32 emin, sint32 esec)
	{
		return IsTimeInWeek(sweek, shour, smin, ssec, eweek, ehour, emin, esec, DTimeManager.nowSysTime());
	}
	class CTimerBase : public ITimer
	{
	public:
		/// 定时器状态
		enum ETimerStatus
		{ 
			TIMER_STATUS_INVALID,	///< 无效
			TIMER_STATUS_RUN,		///< 运行
			TIMER_STATUS_STOP,		///< 停止
			TIMER_STATUS_PAUSE		///< 暂停
		};
	public:
		typedef void (CTimerBase::*TGameTimerFunc)();
		typedef struct _TimeFuncData{
			TTimerFunc func;
			void* pObject;
		}TTimeFuncData;
	public:
		CTimerBase(TGameTimerID_t timeID)
		{
			cleanUp(); 
			setTimerID(timeID);
		}
		virtual ~CTimerBase(){ cleanUp(); }

	public:
		virtual TGameTime_t getNextStartSeconds(){ return MAX_GAME_TIME; }	// 得到距离下一次开始的时间(以秒为单位, 且活动与当前时间必须在同一天, 否则为最大时间)

	public:
		virtual bool needStart()	// 是否需要开始
		{ 
			if(!isInTimer())		// 在生命周期内
			{
				return false;
			}

			if(!isInInterval())		// 在持续周期内
			{
				return false;
			}

			return true;
		}
		virtual bool isInInterval(){ return false; }	// 是否在定时器持续时间内
		//virtual bool isTrigger(){ return false; }		// 是否发动触发
		virtual bool isNeedSave() { return false; }		// 是否需要保存
		virtual TGameTime_t getLastStartTime(){ return INVALID_GAME_TIME; }
		virtual bool isInTimer()						// 是否在定时器生命周期内
		{
			if(_startTime != INVALID_GAME_TIME && DTimeManager.nowSysTime() < _startTime){
				return false;
			}
			if(_endTime != INVALID_GAME_TIME && DTimeManager.nowSysTime() > _endTime){
				return false;
			}

			return true;
		}
		virtual bool isInvalid() // 定时器是否有效, 超过定时器最大时间则表示无效
		{
			// 到达了结束时间
			if(_endTime != INVALID_GAME_TIME && DTimeManager.nowSysTime() > _endTime){
				return true;
			}

			// 调用次数没有了
			if(_interval.callTimes != -1 && getCallTimes() >= _interval.callTimes){
				return true;
			}

			return false; 
		}
		virtual void update(TDiffTime_t diff)
		{
			if(isPause()){
				// 定时器已经停止
				return;
			}

			if(isStop() && needStart())
			{
				// 触发定时器
				gxAssert(isInTimer());
				run();
			}

			if(isRun() && !isInInterval()){
				gxAssert(isInTimer());
				// 结束定时器
				stop();
			}
		}
		
	public:
		virtual void registeAll()
		{
			_func[GAME_TIMER_FUNC_START] = (TGameTimerFunc)&CTimerBase::beginTriggerFunc;
			_func[GAME_TIMER_FUNC_END] = (TGameTimerFunc)&CTimerBase::endTriggerFunc;
			_func[GAME_TIMER_FUNC_INVALID] = (TGameTimerFunc)&CTimerBase::invalidFunc;
		}
		void registeBeginFunc(TTimerFunc func, void* pObject = NULL)
		{
			TTimeFuncData data;
			data.func = func;
			data.pObject = pObject;
			_nfunc[GAME_TIMER_FUNC_START] = data;
		}
		void registeEndFunc(TTimerFunc func, void* pObject = NULL)
		{
			TTimeFuncData data;
			data.func = func;
			data.pObject = pObject;
			_nfunc[GAME_TIMER_FUNC_END] = data;
		}
		void registeInvalidFunc(TTimerFunc func, void* pObject = NULL)
		{
			TTimeFuncData data;
			data.func = func;
			data.pObject = pObject;
			_nfunc[GAME_TIMER_FUNC_INVALID] = data;
		}
		void registeBeginFunc(TGameTimerFunc func)
		{
			_func[GAME_TIMER_FUNC_START] = func;
		}
		void registeEndFunc(TGameTimerFunc func)
		{
			_func[GAME_TIMER_FUNC_END] = func;
		}
		void registeInvalidFunc(TGameTimerFunc func)
		{
			_func[GAME_TIMER_FUNC_INVALID] = func;
		}
		void registeBeginFunc(const std::string& func)
		{
			_sfunc[GAME_TIMER_FUNC_START] = func.c_str();
		}
		void registeEndFunc(const std::string& func)
		{
			_sfunc[GAME_TIMER_FUNC_END] = func.c_str();
		}
		void registeInvalidFunc(const std::string& func)
		{
			_sfunc[GAME_TIMER_FUNC_INVALID] = func.c_str();
		}
		virtual void callScriptFunc(const std::string& func){}

	public:
		void cleanUp(){
			_status = TIMER_STATUS_INVALID;
			_timerType = TIMER_TYPE_INVALID;
			_interval.cleanUp();
			_lastActiveTime = INVALID_GAME_TIME;
			_startTime = INVALID_GAME_TIME;
			_endTime = INVALID_GAME_TIME;
			_createTime = INVALID_GAME_TIME;
			_callTimes = 0;
			memset(_func, 0, sizeof(_func));
			memset(_sfunc, 0, sizeof(_sfunc));
			memset(_nfunc, 0, sizeof(_nfunc));
		}

	public:
		bool isRun(){
			return getStatus() == TIMER_STATUS_RUN;
		}
		bool isPause(){
			return getStatus() == TIMER_STATUS_PAUSE;
		}
		bool isStop(){
			return getStatus() == TIMER_STATUS_STOP;
		}
		void pause(){
			gxAssert(isRun());
			setStatus(TIMER_STATUS_PAUSE);
		}
		void resume(){
			gxAssert(isPause());
			setStatus(TIMER_STATUS_RUN);
		}
		virtual void onInvalid(){		// 定时器已经无效事件
			gxAssert(isStop() || isPause());
			if(_func[GAME_TIMER_FUNC_INVALID] != NULL){
				(this->*_func[GAME_TIMER_FUNC_INVALID])();
			}
			if(!_sfunc[GAME_TIMER_FUNC_INVALID].empty()){
				callScriptFunc(_sfunc[GAME_TIMER_FUNC_INVALID].toString());
			}
			if(_nfunc[GAME_TIMER_FUNC_INVALID].func != NULL){
				TTimeFuncData data = _nfunc[GAME_TIMER_FUNC_INVALID];
				TGameTime_t curTime = CTimeManager::SysNowTime();
				(*(data.func))(this, curTime, data.pObject);
			}
		}
	public:
		void run(){
			gxAssert(isStop() || getStatus() == TIMER_STATUS_INVALID);
			if(_func[GAME_TIMER_FUNC_START] != NULL){
				(this->*_func[GAME_TIMER_FUNC_START])();
			}
			if(!_sfunc[GAME_TIMER_FUNC_START].empty()){
				callScriptFunc(_sfunc[GAME_TIMER_FUNC_START].toString());
			}
			if(_nfunc[GAME_TIMER_FUNC_START].func != NULL){
				TTimeFuncData data = _nfunc[GAME_TIMER_FUNC_START];
				TGameTime_t curTime = CTimeManager::SysNowTime();
				(data.func)(this, curTime, data.pObject);
			}
			_callTimes++;
			_lastActiveTime = DTimeManager.nowSysTime();
			setStatus(TIMER_STATUS_RUN);
		}

		void stop(){
			if(isRun() || isPause()){
				if(_func[GAME_TIMER_FUNC_END] != NULL){
					(this->*_func[GAME_TIMER_FUNC_END])();
				}
				if(!_sfunc[GAME_TIMER_FUNC_END].empty()){
					callScriptFunc(_sfunc[GAME_TIMER_FUNC_END].toString());
				}
				if(_nfunc[GAME_TIMER_FUNC_END].func != NULL){
					TTimeFuncData data = _nfunc[GAME_TIMER_FUNC_END];
					TGameTime_t curTime = CTimeManager::SysNowTime();
					(data.func)(this, curTime, data.pObject);
				}
			}
			setStatus(TIMER_STATUS_STOP);
		}
	public:
		GXMISC::CTimerBase::ETimerStatus getStatus() const { return _status; }
		void setStatus(GXMISC::CTimerBase::ETimerStatus val) { _status = val; }
		GXMISC::TGameTime_t getCreateTime() const { return _createTime; }
		void setCreateTime(GXMISC::TGameTime_t val) { _createTime = val; }
		GXMISC::ETimerType getTimerType() const { return _timerType; }
		void setTimerType(GXMISC::ETimerType val) { _timerType = val; }
		const GXMISC::TGameTimerInterval& getInterval() const { return _interval; }
		void setInterval(GXMISC::TGameTimerInterval& val) { _interval = val; }
		GXMISC::TGameTime_t getLastActiveTime() const { return _lastActiveTime; }
		void setLastActiveTime(GXMISC::TGameTime_t val) { _lastActiveTime = val; }
		GXMISC::TGameTime_t getStartTime() const { return _startTime; }
		void setStartTime(GXMISC::TGameTime_t val) { _startTime = val; }
		GXMISC::TGameTime_t getEndTime() const { return _endTime; }
		void setEndTime(GXMISC::TGameTime_t val) { _endTime = val; }
		sint32 getCallTimes() const { return _callTimes; }
		void setCallTimes(sint32 val) { _callTimes = val; }
		GXMISC::TGameTimerID_t getTimerID() const { return _timerID; }
		void setTimerID(GXMISC::TGameTimerID_t val) { _timerID = val; }

	public:
		void initTime(TGameTime_t startTime = INVALID_GAME_TIME, TGameTime_t endTime = INVALID_GAME_TIME, sint32 callTimes = -1){
			setStartTime(startTime);
			setEndTime(endTime);
			_interval.callTimes = callTimes;
		}
		void initInterval(sint32 interval, sint32 seconds, sint32 mins, sint32 hour, sint32 day, sint32 month, sint32 year){
			_interval.lastTime = interval;
			_interval.seconds = seconds;
			_interval.minute = mins;
			_interval.hour = hour;
			_interval.day = day;
			_interval.month = month;
			_interval.year = year;
		}
	protected:
		TGameTimerID_t		_timerID;								///< 定时器ID
		ETimerStatus		_status;								///< 运行状态
		ETimerType			_timerType;								///< 定时器类型
		TGameTimerInterval	_interval;								///< 定时器间隔
		TGameTime_t			_lastActiveTime;						///< 上一次触发时间
		TGameTime_t			_startTime;								///< 开始时间
		TGameTime_t			_endTime;								///< 结束时间
		TGameTime_t			_createTime;							///< 创建时间
		sint32				_callTimes;								///< 调用次数
		
		TTimeFuncData		_nfunc[GAME_TIMER_FUNC_NUMBER];			///< 普通回调函数
		TGameTimerFunc		_func[GAME_TIMER_FUNC_NUMBER];			///< 回调函数
		CCharArray<100>		_sfunc[GAME_TIMER_FUNC_NUMBER];			///< 脚本回调函数
	};

	// 绝对定时器(AT), 如: 日,星期几,隔几天 时:分 触发
	class CTimerAT : public CTimerBase
	{
	public:
		typedef CTimerBase TBaseType;
	public:
		CTimerAT(TGameTimerID_t timeID) : CTimerBase(timeID)
		{
			setTimerType(TIMER_TYPE_AT);
		}
		~CTimerAT(){}

	public:
		bool defaultInInterval()
		{
			// 开始时间+持续时间 > 当前时间则为真
			TGameTime_t curTime = DTimeManager.nowSysTime();
			TGameTime_t lastStartTime = getLastStartTime();
			if(curTime < (lastStartTime+_interval.lastTime) && curTime > lastStartTime)
			{
				return true;
			}

			return false;
		}

		virtual bool isInInterval()
		{
			return defaultInInterval();
		}
// 		virtual bool needStart(){
// 			switch(_timeType){
// 			case ATIME_DAY:
// 				{
// 					// 每天都会触发
// 					sint32 hour = DTimeManager.getHour();
// 					sint32 mins = DTimeManager.getMinute();
// 					sint32 seconds = DTimeManager.getSecond();
// 					sint32 cursecs = hour*3600+mins*60+seconds;
// 					sint32 ssecs = _interval.hour*3600+_interval.minute*60;
// 					return cursecs > ssecs && cursecs < (ssecs+_interval.lastTime);
// 				}break;
// 			case ATIME_WEEKDAY:
// 				{
// 					sint32 weekDay = DTimeManager.getWeek();
// 					if(_interval.day == weekDay){	// 每周的同一天会触发
// 						sint32 hour = DTimeManager.getHour();
// 						sint32 mins = DTimeManager.getMinute();
// 						sint32 seconds = DTimeManager.getSecond();
// 						sint32 cursecs = hour*3600+mins*60+seconds;
// 						sint32 ssecs = _interval.hour*3600+_interval.minute*60;
// 						return cursecs >= ssecs && cursecs <= ssecs+_interval.lastTime;
// 					}
// 					return false;
// 				}break;
// 			case ATIME_MONTH:
// 				{
// 					sint32 day = DTimeManager.getDay();
// 					if(_interval.day == day){	// 每月的同一天会触发
// 						sint32 hour = DTimeManager.getHour();
// 						sint32 mins = DTimeManager.getMinute();
// 						sint32 seconds = DTimeManager.getSecond();
// 						sint32 cursecs = hour*3600+mins*60+seconds;
// 						sint32 ssecs = _interval.hour*3600+_interval.minute*60;
// 						return cursecs >= ssecs && cursecs <= ssecs+_interval.lastTime;
// 					}
// 				}break;
// 			}
// 
// 			return false;
// 		}

		virtual void update(TDiffTime_t diff){
			TBaseType::update(diff);
		}
	public:
		GXMISC::EATimeType getTimeType() const { return _timeType; }
		void setTimeType(GXMISC::EATimeType val) { _timeType = val; }

	protected:
		EATimeType _timeType;
	};

	class CTimerATD : public CTimerAT
	{
	public:
		CTimerATD(TGameTimerID_t timeID) : CTimerAT(timeID) 
		{
			setTimeType(ATIME_DAY);
		}
		~CTimerATD(){}

	public:
		virtual TGameTime_t getLastStartTime()
		{
			sint32 year = DTimeManager.getYear();
			sint32 month = DTimeManager.getLocalMonth();
			sint32 day = DTimeManager.getDay();
			sint32 hour = _interval.hour;
			sint32 mins = _interval.minute;
			CDateTime dataTime(year, month, day, hour, mins, 0);
			return dataTime.totalSecs();
		}

// 		virtual bool needStart()
// 		{
// 			// 每天都会触发
// 			sint32 hour = DTimeManager.getHour();
// 			sint32 mins = DTimeManager.getMinute();
// 			sint32 seconds = DTimeManager.getSecond();
// 			sint32 cursecs = GetDiffInterval(0, hour, mins, seconds);
// 			sint32 ssecs = GetDiffInterval(0, _interval.hour, _interval.minute);
// 			return cursecs > ssecs && cursecs < (ssecs+_interval.lastTime);
// 		}
	};
	class CTimerATW : public CTimerAT
	{
	public:
		CTimerATW(TGameTimerID_t timeID) : CTimerAT(timeID) 
		{
			setTimeType(ATIME_WEEKDAY);
		}
		~CTimerATW(){}

	public:
		virtual TGameTime_t getLastStartTime(){
			sint32 year = DTimeManager.getYear();
			sint32 month = DTimeManager.getMonth();
			sint32 day = DTimeManager.getDay();
			sint32 hour = _interval.hour;
			sint32 mins = _interval.minute;
			CDateTime dataTime(year, month, day, hour, mins, 0);
			return dataTime.totalSecs();
		}

		virtual bool needStart(){
			// 每天都会触发
			sint32 hour = DTimeManager.getHour();
			sint32 mins = DTimeManager.getMinute();
			sint32 seconds = DTimeManager.getSecond();
			sint32 cursecs = GetDiffInterval(0, hour, mins, seconds);
			sint32 ssecs = GetDiffInterval(0, _interval.hour, _interval.minute);
			return cursecs > ssecs && cursecs < (ssecs+_interval.lastTime);
		}
	};
	class CTimerATM : public CTimerAT
	{
	public:
		CTimerATM(TGameTimerID_t timeID) : CTimerAT(timeID) 
		{
			setTimeType(ATIME_MONTH);
		}
		~CTimerATM(){}

	public:
		virtual TGameTime_t getLastStartTime(){
			sint32 year = DTimeManager.getYear();
			sint32 month = DTimeManager.getMonth();
			sint32 day = DTimeManager.getDay();
			sint32 hour = _interval.hour;
			sint32 mins = _interval.minute;
			CDateTime dataTime(year, month, day, hour, mins, 0);
			return dataTime.totalSecs();
		}

		virtual bool needStart(){
			// 每天都会触发
			sint32 hour = DTimeManager.getHour();
			sint32 mins = DTimeManager.getMinute();
			sint32 seconds = DTimeManager.getSecond();
			sint32 cursecs = GetDiffInterval(0, hour, mins, seconds);
			sint32 ssecs = GetDiffInterval(0, _interval.hour, _interval.minute);
			return cursecs > ssecs && cursecs < (ssecs+_interval.lastTime);
		}
	};
	// 持续定时器(IT), 如: 起始时间~结束时间有效
	class CTimerIT : public CTimerBase
	{
	public:
		CTimerIT(TGameTimerID_t timeID) : CTimerBase(timeID)
		{
			setTimerType(TIMER_TYPE_IT);
		}
		~CTimerIT(){}

	public:
		virtual bool isInInterval(){
			return isInTimer();
		}

		virtual bool needStart(){
			return isInTimer();
		}
	};
	/// 定时器管理
	class CTimerManager
	{
		typedef struct _TimerData{
			_TimerData(CTimerBase* timer, bool needFree){
				this->pTimer = timer;
				this->needFree = needFree;
			}
			CTimerBase* pTimer;
			bool needFree;
		}TTimerData;

		typedef std::map<TGameTimerID_t, TTimerData>			TGameTimerContainer;
		typedef TGameTimerContainer::iterator					TGameTimerItr;
		typedef	TGameTimerContainer::const_iterator				TGameTimerConstItr;

	public:
		static const TGameTimerID_t AutoBeginTimerID = 100000;

	public:
		CTimerManager()
		{
			cleanUp();
			_curTimerID = AutoBeginTimerID;
		}

		~CTimerManager()
		{
			cleanUp();
		}

	public:
		void update( TDiffTime_t diff )
		{
			TTimerIDContainer delTimer; 
			TTimerIDContainer sleepTimer;
			TTimerIDContainer unsleepTimer;

			// 处理已经被触发的定时器
			for ( TGameTimerItr itr = _timer.begin(); itr!=_timer.end(); ++itr )
			{
				CTimerBase* tempTimer = itr->second.pTimer;
				if ( !tempTimer->isInvalid() )
				{
					tempTimer->update(diff);
					if(tempTimer->isStop()){
						sleepTimer.push_back(tempTimer->getTimerID());
					}
				}
				else
				{
					delTimer.push_back(itr->first);
				}
			}

			// 处理休眠的定时器
			;
			for ( TGameTimerItr itr = _sleepTimer.begin(); itr!=_sleepTimer.end(); ++itr )
			{
				CTimerBase* tempTimer = itr->second.pTimer;
				if ( !tempTimer->isInvalid() )
				{
					tempTimer->update(diff);
					if(tempTimer->isInInterval()){
						unsleepTimer.push_back(tempTimer->getTimerID());
					}
				}
				else
				{
					delTimer.push_back(itr->first);
				}
			}

			// 删除掉已经过期的定时器
			;
			for ( TTimerIDContainer::iterator it = delTimer.begin(); it!=delTimer.end(); ++it )
			{
				removeTimer(*it);
			}

			// 处理已经苏醒的定时器
			;
			for ( TTimerIDContainer::iterator it = unsleepTimer.begin(); it!=unsleepTimer.end(); ++it )
			{
				TGameTimerContainer::iterator iter = _sleepTimer.find(*it);
				if(iter != _sleepTimer.end()){
					_timer.insert(TGameTimerContainer::value_type(*it, iter->second));
					_sleepTimer.erase(iter);
				}
			}

			// 处理已经休眠的定时器
			;
			for ( TTimerIDContainer::iterator it = sleepTimer.begin(); it!=sleepTimer.end(); ++it )
			{
				TGameTimerContainer::iterator iter = _timer.find(*it);
				if(iter != _timer.end()){
					_sleepTimer.insert(TGameTimerContainer::value_type(*it, iter->second));
					_timer.erase(iter);
				}
			}
		}

	public:
		void removeTimer(TGameTimerID_t timerID){
			TGameTimerItr itr = _timer.find(timerID);
			if ( itr != _timer.end() )
			{
				CTimerBase* pTimer = itr->second.pTimer;
				pTimer->onInvalid();
				if(itr->second.needFree){
					delete pTimer;
				}
				_timer.erase(timerID);
			}
			itr = _sleepTimer.find(timerID);
			if ( itr != _sleepTimer.end() )
			{
				CTimerBase* pTimer = itr->second.pTimer;
				pTimer->onInvalid();
				if(itr->second.needFree){
					delete pTimer;
				}
				_sleepTimer.erase(timerID);
			}
		}
		CTimerBase* getTimer(TGameTimerID_t timerID){
			TGameTimerItr itr = _timer.find(timerID);
			if ( itr != _timer.end() )
			{
				CTimerBase* pTimer = itr->second.pTimer;
				return pTimer;
			}
			itr = _sleepTimer.find(timerID);
			if ( itr != _sleepTimer.end() )
			{
				CTimerBase* pTimer = itr->second.pTimer;
				return pTimer;
			}
			return NULL;
		}

		bool isTimerExist(TGameTimerID_t timerID){
			return getTimer(timerID) != NULL;
		}

		void saveTimer(){
			gxAssert(false);
		}

		void loadTimer(){
			gxAssert(false);
		}

		TGameTimerID_t genTimerID(){
			return ++_curTimerID;
		}
	public:
		TGameTimerID_t registe( CTimerBase* baseTimer, bool needFree = false )
		{
			_timer.insert(TGameTimerContainer::value_type(baseTimer->getTimerID(), TTimerData(baseTimer, needFree)));
			baseTimer->stop();
			return baseTimer->getTimerID();
		}

	protected:
		bool registe(CTimerBase* pTimer, TGameTime_t startTime, TGameTime_t endTime, TDiffTime_t interval, sint32 secs, sint32 smin,
			sint32 shour, sint32 sday, sint32 smonth, sint32 syear)
		{
			gxAssert(startTime <= endTime);
			if(NULL != pTimer){
				pTimer->initTime(startTime, endTime);
				if(!pTimer->isInTimer()){
					//delete pTimer;
					return false;
				}
				pTimer->initInterval(interval, secs, smin, shour, sday, smonth, syear);
			}
			registe(pTimer, true);
			return true;
		}

	public:
		// =========================== 绝对定时器(AT), 如: 日,星期几,隔几天 时:分 触发 ===========================
		// 注册日绝对定时器
		CTimerBase* registeATD(TGameTime_t startTime, TGameTime_t endTime, sint32 shour, sint32 smin, sint32 ehour, sint32 emin){
			sint32 interval = GetDiffInterval(0, shour, smin, 0, 0, ehour, emin, 0);
			TGameTimerID_t timerID = genTimerID();
			gxAssert(timerID != INVALID_GAME_TIMER_ID);
			CTimerAT* pTimer = new CTimerATD(timerID);
			if(!registe(pTimer, startTime, endTime, interval, 0, smin, shour, 0, 0, 0)){
				delete pTimer;
				return NULL;
			}

			return pTimer;
		}
		CTimerBase* registeATD(sint32 shour, sint32 smin, sint32 ehour, sint32 emin){
			return registeATD(INVALID_GAME_TIME, INVALID_GAME_TIME, shour, smin, ehour, emin);
		}
		// 注册周绝对定时器
		// 注册月绝对定时器

		// =========================== 持续定时器(IT), 如: 起始时间~结束时间有效 ===========================
		CTimerBase* registeIT(TGameTime_t startTime, TGameTime_t endTime)
		{
			sint32 interval = endTime-startTime;
			TGameTimerID_t timerID = genTimerID();
			gxAssert(timerID != INVALID_GAME_TIMER_ID);
			CTimerIT* pTimer = new CTimerIT(timerID);
			if(NULL != pTimer){
				if(!registe(pTimer, startTime, endTime, interval, 0, 0, 0, 0, 0, 0)){
					delete pTimer;
					return NULL;
				}
			}

			return pTimer;
		}

	protected:
// 		CTimerBase* registeATimer(TGameTime_t startTime, TGameTime_t endTime, sint32 sday, sint32 shour, sint32 smin,
// 			sint32 eday, sint32 ehour, sint32 emin)
// 		{
// 			gxAssert(stimes < etimes);
// 			CTimerAT* pTimer = new CTimerAT();
// 			if(NULL != pTimer){
// 				pTimer->initTime(startTime, endTime);
// 				sint32 interval = GetDiffInterval(sday, shour, smin, 0, eday, ehour, emin, 0);
// 				pTimer->initInterval(interval, 0, smin, shour, 0, 0, 0);
// 			}
// 			registe(pTimer, true);
// 
// 			return pTimer;
// 		}
// 
// 		template <typename T>
// 		TGameTimerID_t registerTimer( CGameTimerBase* baseTimer, T* obj, TGameTime_t sTime, TGameTime_t eTime, const GameTimerIntervalVec& interval, uint32 updateTime = 1000 )
// 		{
// 			CGameTimer<T>* tempTimer = new CGameTimer<T>(obj, sTime, eTime, interval, updateTime);
// 			gxAssert(tempTimer);
// 			if ( tempTimer == NULL )
// 			{
// 				return INVALID_GAME_TIMER_ID;
// 			}
// 			*tempTimer = *(CGameTimer<T>*)baseTimer;
// 			++_curTimerID;
// 			_timer[_curTimerID] = tempTimer;
// 			return _curTimerID;
// 		}
// 
// 		template <typename T>
// 		void			resetTimer( TGameTimerID_t timerID, const TGameTimerInterval& interval )
// 		{
// 			GameTimerIntervalVec intervalVec;
// 			intervalVec.push_back(interval);
// 			resetTimer<T>(timerID, intervalVec);
// 		}
// 
// 		template <typename T>
// 		void			resetTimer( TGameTimerID_t timerID, const GameTimerIntervalVec& interval)
// 		{
// 			GameTimerItr itr = _timer.find(timerID);
// 			if ( itr == _timer.end() )
// 			{
// 				return ;
// 			}
// 			CGameTimerBase* tempTimer = itr->second;
// 			if ( tempTimer == NULL )
// 			{
// 				gxError("Timer ptr is NULL!!! timerID = {0}", timerID);
// 				gxAssert(false);
// 				return ;
// 			}
// 			CGameTimer<T>* pTimer = (CGameTimer<T>*)tempTimer;
// 			gxAssert(pTimer);
// 			pTimer->resetValue(interval);
// 		}

	private:
		void cleanUp()
		{
			_curTimerID = INVALID_GAME_TIMER_ID;
			TTimerIDContainer delTimer; 
			;
			for ( TGameTimerItr itr = _timer.begin(); itr!=_timer.end(); ++itr )
			{
				delTimer.push_back(itr->first);
			}
			for ( TGameTimerItr itr = _sleepTimer.begin(); itr!=_sleepTimer.end(); ++itr )
			{
				delTimer.push_back(itr->first);
			}

			std::vector<TGameTimerID_t>::iterator it = delTimer.begin();
			for ( ; it!=delTimer.end(); ++it )
			{
				removeTimer(*it);
			}
			_timer.clear();
		}

	private:
		TGameTimerID_t			_curTimerID;		///< 当前游戏定时器, 从100000开始至最大为普通定时器, 100000以下为特殊定时器
		TGameTimerContainer		_timer;				///< 定时器
		TGameTimerContainer		_sleepTimer;		///< 休眠定时器			
	};

	/// 游戏定时器接口
	class CGameTimerInterface
	{
	public:
		CGameTimerInterface()			{ _isNeedBegin = true; _lastActiveTime = INVALID_GAME_TIME; }
		virtual ~CGameTimerInterface()	{}

	public:
		virtual TGameTime_t	getLastActiveTime()	const	{ return _lastActiveTime; }

	public:
		bool				isNeedBegin() const			{ return _isNeedBegin; }

	public:
		bool getIsNeedBegin() const { return _isNeedBegin; }
		void setIsNeedBegin(bool val) { _isNeedBegin = val; }
		void setLastActiveTime(GXMISC::TGameTime_t val) { _lastActiveTime = val; }

	protected:
		bool				_isNeedBegin;		///< 是否需要开始(是指有些活动上次还没结束那么本次不再需要重新开始)
		TGameTime_t			_lastActiveTime;	///< 上一次触发时间
	};

	typedef void (CGameTimerInterface::*TGameTimerFunc)();	///< 回调函数接口

	/// 游戏定时器基类
	class CGameTimerBase
	{
	protected:
		CGameTimerBase(){}
	public:
		virtual ~CGameTimerBase()	{}
		virtual void operator ()( const EGameTimerFunc& funcType ) = 0;
		virtual bool registerFunc( const EGameTimerFunc& funcType, TGameTimerFunc funcName ) = 0;
		virtual	void update( uint32 diff ) = 0;
		virtual	bool isInvalid() const = 0;
	};

	// 注意：所有的T类型都必须继承CGameTimerInterface
// 	template <typename T>
// 	class CGameTimer : public CGameTimerBase
// 	{
// 	public:
// 		typedef void (T::*MemFunc)();
// 
// 	public:
// 		CGameTimer()
// 		{
// 			cleanUp();
// 		}
// 
// 		// 默认一分钟检测一次
// 		CGameTimer( T* object, TGameTime_t sTime, TGameTime_t eTime, const GameTimerIntervalVec& interval, uint32 uTime = MILL_SECOND_IN_MINUTE )
// 		{
// 			cleanUp();
// 			_obj = object;
// 			_startTime = sTime;
// 			_endTime = eTime;
// 			_interval.insert(_interval.begin(), interval.begin(), interval.end());
// 			_updateTime = uTime;
// 			_updateTimer.update(_updateTime);
// 			bool isDerive = boost::is_base_of<CGameTimerInterface, T>::value;
// 			gxAssert(isDerive == true);
// 		}
// 
// 		~CGameTimer()
// 		{
// 			cleanUp();
// 		}
// 
// 		void operator ()( const EGameTimerFunc& funcType )
// 		{
// 			gxAssert(_obj);
// 			if ( _obj == NULL )
// 			{
// 				return ;
// 			}
// 			gxAssert(_func[funcType]);
// 			if ( _func[funcType] != NULL )
// 			{
// 				(_obj->*_func[funcType])();
// 			}
// 		}
// 
// 		bool registerFunc( const EGameTimerFunc& funcType, TGameTimerFunc pFunc )
// 		{
// 			gxAssert(pFunc);
// 			if ( pFunc == NULL )
// 			{
// 				return false;
// 			}
// 			gxAssert( funcType >= GAME_TIMER_FUNC_START && funcType < GAME_TIMER_FUNC_NUMBER );
// 			if (  funcType >= GAME_TIMER_FUNC_START && funcType < GAME_TIMER_FUNC_NUMBER )
// 			{
// 				_func[funcType] = pFunc;
// 				return true;
// 			}
// 			return false;
// 		}
// 
// 		CGameTimerBase& operator = ( const CGameTimer& ls )
// 		{
// 			memcpy(&_func, &ls._func, sizeof(_func));
// 			return *this;
// 		}
// 
// 		void resetValue( const GameTimerIntervalVec& interval )
// 		{
// 			_funcType = GAME_TIMER_FUNC_NUMBER;
// 			_finishTime = INVALID_GAME_TIME;
// 			_interval.clear();
// 			_interval.insert(_interval.begin(), interval.begin(), interval.end());
// 		}
// 
// 	public:
// 		void update( uint32 diff )
// 		{
// 			if( !_updateTimer.update(diff); )
// 			{
// 				return ;
// 			}
// 			if ( _obj == NULL )
// 			{
// 				gxError("obj is null!!!");
// 				gxAssert(false);
// 				return ;
// 			}
// 			_updateTimer.reset(true);
// 			if( isInvalid() )
// 			{
// 				callFunc(GAME_TIMER_FUNC_INVALID);
// 			}
// 			else if( checkInterval() )
// 			{
// 				callFunc(GAME_TIMER_FUNC_START);
// 			}
// 			else if ( checkEnd() )
// 			{
// 				callFunc(GAME_TIMER_FUNC_END);
// 			}
// 		}
// 
// 	public:
// 		bool isInvalid() const
// 		{
// 			if ( _endTime == INVALID_GAME_TIME )
// 			{
// 				return false;
// 			}
// 			TGameTime_t curTime = DTimeManager.nowSysTime();
// 			if ( curTime < _startTime || curTime >= _endTime )
// 			{
// 				return true;
// 			}
// 			return false;
// 		}
// 
// 	private:
// 		bool checkInterval()
// 		{
// 			if ( _funcType == GAME_TIMER_FUNC_START )
// 			{
// 				return false;
// 			}
// 			sint32 leftDayNum = 0;
// 			for ( TGameTimerIndex_t index=0; index<_interval.size(); ++index )
// 			{
// 				const TGameTimerInterval& interval = _interval[index];
// 				switch(interval._timerType)
// 				{
// 				case GAME_TIMER_DAY:
// 					{
// 						if ( interval._count != 0 )
// 						{
// 							leftDayNum = (((DTimeManager.nowSysTime() - 0) / SECOND_IN_DAY) % interval._count);
// 						}
// 					}break;
// 				case GAME_TIMER_WEEKDAY:
// 					{
// 						sint32 curWeekday = DTimeManager.getWeek();
// 						if ( curWeekday < interval._count )
// 						{
// 							curWeekday += DAY_IN_WEEKDAY;
// 						}
// 						leftDayNum = curWeekday - interval._count;
// 					}break;
// 				default:
// 					{
// 						gxError("Unknow timer type!!! timerType = %u", (uint8)interval._timerType);
// 						gxAssert(false);
// 					}break;
// 				}
// 				TGameTime_t secs = DTimeManager.getHour() * SECOND_IN_HOUR + DTimeManager.getMinute() * SECOND_IN_MINUTE + DTimeManager.getSecond() + leftDayNum * SECOND_IN_DAY;
// 				TGameTime_t startSecs = interval._hour * SECOND_IN_HOUR + interval._minute * SECOND_IN_MINUTE;
// 				if ( (secs >= startSecs && (secs < (startSecs + interval._lastTime))) )
// 				{
// 					_finishTime = DTimeManager.nowSysTime() + startSecs + interval._lastTime - secs;
// 					_timerIndex = index;
// 					return true;
// 				}
// 			}
// 
// 			return false;
// 		}
// 
// 		bool checkEnd()
// 		{
// 			if ( _timerIndex == INVALID_GAME_TIMER_INDEX )
// 			{
// 				return false;
// 			}
// 			if ( DTimeManager.nowSysTime() >= _finishTime )
// 			{
// 				_timerIndex = INVALID_GAME_TIMER_INDEX;
// 				return true;
// 			}
// 			return false;
// 		}
// 
// 		void callFunc( EGameTimerFunc funcType )
// 		{
// 			if ( _funcType == funcType )
// 			{
// 				return ;
// 			}
// 			_funcType = funcType;
// 			if ( _obj == NULL || _func[_funcType] == NULL )
// 			{
// 				return ;
// 			}
// 			if ( _funcType == GAME_TIMER_FUNC_START )
// 			{
// 				if ( !_obj->isNeedBegin() )
// 				{
// 					return ;
// 				}
// 			}
// 			(_obj->*_func[_funcType])();
// 		}
// 
// 		void cleanUp()
// 		{
// 			_obj = NULL;
// 			_timerIndex = INVALID_GAME_TIMER_INDEX;
// 			_funcType = GAME_TIMER_FUNC_NUMBER;
// 			_finishTime = INVALID_GAME_TIME;
// 			_updateTime = INVALID_GAME_TIME;
// 			_interval.clear();
// 			for ( uint8 i=GAME_TIMER_FUNC_START; i<GAME_TIMER_FUNC_NUMBER; ++i )
// 			{
// 				_func[i] = NULL;
// 			}
// 		}
// 
// 	public:
// 		T*								_obj;							///< T类型的指针
// 		TGameTimerIndex_t				_timerIndex;					///< 当前有效的时间段的编号
// 		TGameTime_t						_finishTime;					///< 结束的时间(单位为s)
// 		EGameTimerFunc					_funcType;						///< 上一次调用的函数类型
// 		uint32							_updateTime;					///< 定时更新时间
// 		TGameTime_t						_startTime;						///< 开始时间
// 		TGameTime_t						_endTime;						///< 结束时间
// 		GameTimerIntervalVec			_interval;						///< 间隔时间
// 		TGameTimerFunc					_func[GAME_TIMER_FUNC_NUMBER];	///< 回调函数
// 		GXMISC::CManualIntervalTimer	_updateTimer;					///< 更新的定时器
// 	};

	/// 定时器管理
// 	class CGameTimerManager
// 	{
// 		typedef std::map<TGameTimerID_t, CGameTimerBase*>		GameTimerContainer;
// 		typedef GameTimerContainer::iterator					GameTimerItr;
// 		typedef	GameTimerContainer::const_iterator				GameTimerConstItr;
// 
// 	public:
// 		CGameTimerManager()
// 		{
// 			cleanUp();
// 		}
// 
// 		~CGameTimerManager()
// 		{
// 			cleanUp();
// 		}
// 
// 	public:
// 		bool checkTimerValid() const
// 		{
// 			GameTimerConstItr itr = _timer.begin();
// 			for ( ; itr!=_timer.end(); ++itr )
// 			{
// 				if ( !itr->second->isInvalid() )
// 				{
// 					return true;
// 				}
// 			}
// 			return false;
// 		}
// 
// 	public:
// 		void update( uint32 diff )
// 		{
// 			std::vector<TGameTimerID_t>	delTimer; 
// 			GameTimerItr itr = _timer.begin();
// 			for ( ; itr!=_timer.end(); ++itr )
// 			{
// 				CGameTimerBase* tempTimer = itr->second;
// 				if ( tempTimer != NULL )
// 				{
// 					(*tempTimer).update(diff);
// 				}
// 				else
// 				{
// 					delTimer.push_back(itr->first);
// 				}
// 			}
// 
// 			std::vector<TGameTimerID_t>::iterator it = delTimer.begin();
// 			for ( ; it!=delTimer.end(); ++it )
// 			{
// 				itr = _timer.find(*it);
// 				if ( itr != _timer.end() )
// 				{
// 					_timer.erase(itr);
// 				}
// 			}
// 		}
// 
// 	public:
// 		template <typename T>
// 		TGameTimerID_t registerTimer( CGameTimerBase* baseTimer,  T* obj, TGameTime_t startTime, TGameTime_t endTime, const TGameTimerInterval& interval, uint32 updateTime = 1000 )
// 		{
// 			GameTimerIntervalVec intervalVec;
// 			intervalVec.push_back(interval);
// 			return registerTimer(baseTimer, obj, startTime, endTime, intervalVec, updateTime);
// 		}
// 
// 		template <typename T>
// 		TGameTimerID_t registerTimer( CGameTimerBase* baseTimer, T* obj, TGameTime_t sTime, TGameTime_t eTime, const GameTimerIntervalVec& interval, uint32 updateTime = 1000 )
// 		{
// 			CGameTimer<T>* tempTimer = new CGameTimer<T>(obj, sTime, eTime, interval, updateTime);
// 			gxAssert(tempTimer);
// 			if ( tempTimer == NULL )
// 			{
// 				return INVALID_GAME_TIMER_ID;
// 			}
// 			*tempTimer = *(CGameTimer<T>*)baseTimer;
// 			++_curTimerID;
// 			_timer[_curTimerID] = tempTimer;
// 			return _curTimerID;
// 		}
// 
// 		template <typename T>
// 		void			resetTimer( TGameTimerID_t timerID, const TGameTimerInterval& interval )
// 		{
// 			GameTimerIntervalVec intervalVec;
// 			intervalVec.push_back(interval);
// 			resetTimer<T>(timerID, intervalVec);
// 		}
// 
// 		template <typename T>
// 		void			resetTimer( TGameTimerID_t timerID, const GameTimerIntervalVec& interval)
// 		{
// 			GameTimerItr itr = _timer.find(timerID);
// 			if ( itr == _timer.end() )
// 			{
// 				return ;
// 			}
// 			CGameTimerBase* tempTimer = itr->second;
// 			if ( tempTimer == NULL )
// 			{
// 				gxError("Timer ptr is NULL!!! timerID = {0}", timerID);
// 				gxAssert(false);
// 				return ;
// 			}
// 			CGameTimer<T>* pTimer = (CGameTimer<T>*)tempTimer;
// 			gxAssert(pTimer);
// 			pTimer->resetValue(interval);
// 		}
// 
// 	private:
// 		void cleanUp()
// 		{
// 			_curTimerID = INVALID_GAME_TIMER_ID;
// 			GameTimerItr itr = _timer.begin();
// 			for ( ; itr!=_timer.end(); )
// 			{
// 				CGameTimerBase* tempVal = itr->second;
// 				if ( tempVal != NULL )
// 				{
// 					delete tempVal;
// 				}
// 				tempVal = NULL;
// 				GameTimerItr tempItr = itr;
// 				++itr;
// 				_timer.erase(tempItr);
// 			}
// 			_timer.clear();
// 		}
// 
// 	private:
// 		TGameTimerID_t								_curTimerID;
// 		GameTimerContainer							_timer;
// 	};

	class CGamePassTimerBase
	{
	public:
		CGamePassTimerBase()
		{
			cleanUp();
		}

		virtual ~CGamePassTimerBase()
		{
			cleanUp();
		}

	public:
		bool			initTimer( TGameTime_t lastTime )
		{
			TTime tempTime = (TTime)lastTime;
			tm tempTm;
			tm* curTime = GXMISC::CTimeManager::LocalTime((TTime*)&tempTime, &tempTm);
			if ( curTime == NULL )
			{
				return false;
			}
			_lastMonth = curTime->tm_mon;
			_lastWeekday = curTime->tm_wday;
			_lastDay = curTime->tm_mday;
			_lastHour = curTime->tm_hour;
			return true;
		}

	public:
		void			updateTimer( uint32 diff )
		{
			sint32 curMonth = DTimeManager.getMonth();
			if ( curMonth != _lastMonth )
			{
				gxInfo("Last month = {0}, cur month = {1}", _lastMonth, curMonth);
				_lastMonth = curMonth;
				onPassMonth();
			}

			sint32 curWeekday = DTimeManager.getWeek();
			if ( curWeekday < _lastWeekday )
			{
				gxInfo("Last weekday = {0}, cur weekday = {1}", _lastWeekday, curWeekday);
				_lastWeekday = curWeekday;
				onPassWeekday();
			}

			sint32 curDay = DTimeManager.getDay();
			sint32 curHour = DTimeManager.getHour();
			if ( curHour != _lastHour )
			{
				// 				if ( curHour < _lastHour && curHour != 0 ) // @TODO 加上判断
				// 				{
				// 					return ;
				// 				}
				// 				if ( curHour == 0 && curDay == _lastDay )
				// 				{
				// 					return ;
				// 				}
				// 				else if ( curHour > (_lastHour + 1) )
				// 				{
				// 					return ;
				// 				}
				gxInfo("Last hour = {0}, cur hour = {1}", _lastHour, curHour);
				_lastHour = curHour;
				onPassHour();
			}

			if ( curDay != _lastDay )
			{
				gxInfo("Last day = {0}, cur day = {1}", _lastDay, curDay);
				_lastDay = curDay;
				onPassDay();
			}
		}

	public:
		virtual void	onPassMonth()	{}
		virtual void	onPassWeekday()	{}
		virtual void	onPassDay()		{}
		virtual void	onPassHour()	{}

	private:
		void			cleanUp()
		{
			_lastMonth = 0;
			_lastWeekday = 0;
			_lastDay = 0;
			_lastHour = 0;
		}

	private:
		sint32			_lastMonth;
		sint32			_lastWeekday;
		sint32			_lastDay;
		sint32			_lastHour;
	};

	template <typename T>
	struct TClassMemberFunc
	{
		typedef void (T::*TMemFunc)();
	};

#define DMemFunc(T)	TClassMemberFunc<T>::TMemFunc

	// 复杂定时器基类
	template <typename T>
	class CComplexTimerBase
	{
	public:
		CComplexTimerBase();
		virtual ~CComplexTimerBase();

	protected:
		void			initTimer( typename DMemFunc(T) pFunc );

		void			callFunc( T* obj );
		virtual void	cleanUp();

	protected:
		typename DMemFunc(T)	_func;
	};

	// 自动定时器(对timer的再度封装，无须再按update,reset,call func流程,会定时调用注册的函数)
	// 重载callAutoFunc函数无需注册可实现自动调用，也可自己写另外一个函数并注册一下实现自动调用
	template <typename T>
	class CAutoTimer : public CComplexTimerBase<T>
	{
	public:
		CAutoTimer( T* obj, TGameTime_t interval, typename DMemFunc(T) pFunc = NULL );
		virtual ~CAutoTimer();

	public:
		void			update( uint32 diff );
		void			setInvalid( bool invalid );

	private:
		void			init( T* obj, TGameTime_t interval, typename DMemFunc(T) pFunc = NULL );
		virtual void	cleanUp();

	private:
		bool			_invalid;
		GXManuaTimer	_timer;
		T*				_obj;
	};

	// 多定时器管理，注意所有时间单位为s
	template <typename T, TGameTime_t t1 = INVALID_GAME_TIME, TGameTime_t t2 = INVALID_GAME_TIME,
		TGameTime_t t3 = INVALID_GAME_TIME, TGameTime_t t4 = INVALID_GAME_TIME,
		TGameTime_t t5 = INVALID_GAME_TIME, TGameTime_t t6 = INVALID_GAME_TIME,
		TGameTime_t t7 = INVALID_GAME_TIME, TGameTime_t t8 = INVALID_GAME_TIME,
		TGameTime_t t9 = INVALID_GAME_TIME, TGameTime_t t10 = INVALID_GAME_TIME>
	class CMultiAutoTimer
	{
		typedef typename std::map<TGameTimerID_t, CAutoTimer<T> > AutoTimerContainer;
	public:
		CMultiAutoTimer();
		~CMultiAutoTimer();

	public:
		TGameTimerID_t	addAutoTimer( T* obj, TGameTime_t interval, typename DMemFunc(T) pFunc );
		void			init( T* obj, typename DMemFunc(T) f1 = NULL, typename DMemFunc(T) f2 = NULL, typename DMemFunc(T) f3 = NULL, typename DMemFunc(T) f4 = NULL, 
			typename DMemFunc(T) f5 = NULL, typename DMemFunc(T) f6 = NULL, typename DMemFunc(T) f7 = NULL, typename DMemFunc(T) f8 = NULL, 
			typename DMemFunc(T) f9 = NULL, typename DMemFunc(T) f10 = NULL );
		void			setInvalidByIndex( uint32 index, bool invalid = true );
		void			setInvalidByTimerID( TGameTimerID_t timerID, bool invalid = true );

	public:
		void			update( uint32 diff );

	private:
		TGameTimerID_t	getTimerID();

	private:
		void			cleanUp();

	private:
		TGameTimerID_t		_curTimerID;
		TTimerIDContainer	_timerIDContainer;
		AutoTimerContainer	_data;
	};

	// 绝对定时器基类
	template <typename T, TGameTime_t interval>
	class CAbsoluteTimerBase : public CComplexTimerBase<T>
	{
	public:
		CAbsoluteTimerBase();
		virtual ~CAbsoluteTimerBase();

	public:
		void			update( uint32 diff );
		void			init( typename DMemFunc(T) func );

	protected:
		virtual sint32	getCurValue() = 0;
		virtual void	registerFunc() {}

	private:
		virtual void	cleanUp();

	private:
		bool			_isFirst;
		sint32			_lastValue;
	};

	// 绝对定时器(如10s绝对定时器,无论在何时初始化,都只会在0s、10s、20s、30s、40s、50s自动调用注册的函数)
	template <typename T, TGameTime_t interval, EAbsoluteTimerType timerType = SECOND_ABSOLUTE_TIMER>
	class CAbsoluteTimer : public CAbsoluteTimerBase<T, interval>
	{
	public:
		CAbsoluteTimer()				{}
		virtual ~CAbsoluteTimer()		{}

	private:
		sint32			getCurValue()	{ return 0; }
	};

	// 所有定时器的基类的实现
	template <typename T>
	CComplexTimerBase<T>::CComplexTimerBase()
	{
		cleanUp();
	}

	template <typename T>
	CComplexTimerBase<T>::~CComplexTimerBase()
	{
		cleanUp();
	}

	template <typename T>
	void CComplexTimerBase<T>::initTimer( typename DMemFunc(T) pFunc )
	{
		if ( pFunc == NULL )
		{
			gxError("Obj is null or func ptr is null!!!");
			gxAssert(false);
			return ;
		}
		_func = pFunc;
	}

	template <typename T>
	void CComplexTimerBase<T>::callFunc( T* obj )
	{
		if ( obj == NULL || _func == NULL )
		{
			gxError("Obj is null or func ptr is null!!!");
			gxAssert(false);
			return ;
		}
		(obj->*_func)();
	}

	template <typename T>
	void CComplexTimerBase<T>::cleanUp()
	{
		_func = NULL;
	}

	// 普通定时器的实现
	template<typename T>
	CAutoTimer<T>::CAutoTimer( T* obj, TGameTime_t interval, typename DMemFunc(T) pFunc )
	{
		cleanUp();
		init(obj, interval, pFunc);
	}

	template<typename T>
	CAutoTimer<T>::~CAutoTimer()
	{
		cleanUp();
	}

	template<typename T>
	void CAutoTimer<T>::update( uint32 diff )
	{
		if ( _invalid )
		{
			return ;
		}
		if ( this->_timer.update(diff) )
		{
			this->_timer.reset();
			this->callFunc(_obj);
		}
	}

	template<typename T>
	void CAutoTimer<T>::setInvalid( bool invalid )
	{
		_invalid = invalid;
	}

	template<typename T>
	void CAutoTimer<T>::init( T* obj, TGameTime_t interval, typename DMemFunc(T) pFunc )
	{
		_invalid = false;
		_obj = obj;
		_timer.init(interval * MILL_SECOND_IN_SECOND);
		CComplexTimerBase<T>::initTimer(pFunc);
	}

	template<typename T>
	void CAutoTimer<T>::cleanUp()
	{
		CComplexTimerBase<T>::cleanUp();
		_invalid = true;
		_obj = NULL;
	}

	// 普通定时器的管理类的实现
	template <typename T, TGameTime_t t1, TGameTime_t t2, TGameTime_t t3, TGameTime_t t4, TGameTime_t t5, TGameTime_t t6, TGameTime_t t7, TGameTime_t t8, 
		TGameTime_t t9, TGameTime_t t10>
		CMultiAutoTimer<T, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10>::CMultiAutoTimer()
	{
		cleanUp();
	}

	template <typename T, TGameTime_t t1, TGameTime_t t2, TGameTime_t t3, TGameTime_t t4, TGameTime_t t5, TGameTime_t t6, TGameTime_t t7, TGameTime_t t8, 
		TGameTime_t t9, TGameTime_t t10>
		CMultiAutoTimer<T, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10>::~CMultiAutoTimer()
	{
		cleanUp();
	}

	template <typename T, TGameTime_t t1, TGameTime_t t2, TGameTime_t t3, TGameTime_t t4, TGameTime_t t5, TGameTime_t t6, TGameTime_t t7, TGameTime_t t8, 
		TGameTime_t t9, TGameTime_t t10>
		TGameTimerID_t CMultiAutoTimer<T, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10>::addAutoTimer( T* obj, TGameTime_t interval, typename DMemFunc(T) pFunc )
	{
		if ( interval == INVALID_GAME_TIME || pFunc == NULL )
		{
			return INVALID_GAME_TIMER_ID;
		}
		TGameTimerID_t timerID = getTimerID();
		_data.insert(typename AutoTimerContainer::value_type(timerID, CAutoTimer<T>(obj, interval, pFunc)));
		_timerIDContainer.push_back(timerID);
		return timerID;
	}

	template <typename T, TGameTime_t t1, TGameTime_t t2, TGameTime_t t3, TGameTime_t t4, TGameTime_t t5, TGameTime_t t6, TGameTime_t t7, TGameTime_t t8, 
		TGameTime_t t9, TGameTime_t t10>
		void CMultiAutoTimer<T, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10>::init( T* obj, typename DMemFunc(T) f1, typename DMemFunc(T) f2, 
		typename DMemFunc(T) f3, typename DMemFunc(T) f4, typename DMemFunc(T) f5, typename DMemFunc(T) f6, 
		typename DMemFunc(T) f7, typename DMemFunc(T) f8, typename DMemFunc(T) f9, typename DMemFunc(T) f10 )
	{
		addAutoTimer(obj, t1, f1);
		addAutoTimer(obj, t2, f2);
		addAutoTimer(obj, t3, f3);
		addAutoTimer(obj, t4, f4);
		addAutoTimer(obj, t5, f5);
		addAutoTimer(obj, t6, f6);
		addAutoTimer(obj, t7, f7);
		addAutoTimer(obj, t8, f8);
		addAutoTimer(obj, t9, f9);
		addAutoTimer(obj, t10, f10);
	}

	template <typename T, TGameTime_t t1, TGameTime_t t2, TGameTime_t t3, TGameTime_t t4, TGameTime_t t5, TGameTime_t t6, TGameTime_t t7, TGameTime_t t8, 
		TGameTime_t t9, TGameTime_t t10>
		void CMultiAutoTimer<T, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10>::setInvalidByIndex( uint32 index, bool invalid )
	{

		if ( _timerIDContainer.size() <= index )
		{
			gxError("TimerID index is invalid!!! index = {0}", index);
			gxAssert(false);
			return ;
		}
		TGameTimerID_t timerID = _timerIDContainer[index];
		setInvalidByTimerID(timerID, invalid);
	}

	template <typename T, TGameTime_t t1, TGameTime_t t2, TGameTime_t t3, TGameTime_t t4, TGameTime_t t5, TGameTime_t t6, TGameTime_t t7, TGameTime_t t8, 
		TGameTime_t t9, TGameTime_t t10>
		void CMultiAutoTimer<T, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10>::setInvalidByTimerID( TGameTimerID_t timerID, bool invalid )
	{
		typename AutoTimerContainer::iterator itr = _data.find(timerID);
		if ( itr != _data.end() )
		{
			(itr->second).setInvalid(invalid);
		}
	}

	template <typename T, TGameTime_t t1, TGameTime_t t2, TGameTime_t t3, TGameTime_t t4, TGameTime_t t5, TGameTime_t t6, TGameTime_t t7, TGameTime_t t8, 
		TGameTime_t t9, TGameTime_t t10>
		void CMultiAutoTimer<T, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10>::update( uint32 diff )
	{
		typename AutoTimerContainer::iterator itr = _data.begin();
		for ( ; itr!=_data.end(); ++itr )
		{
			(itr->second).update(diff);
		}
	}

	template <typename T, TGameTime_t t1, TGameTime_t t2, TGameTime_t t3, TGameTime_t t4, TGameTime_t t5, TGameTime_t t6, TGameTime_t t7, TGameTime_t t8, 
		TGameTime_t t9, TGameTime_t t10>
		TGameTimerID_t CMultiAutoTimer<T, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10>::getTimerID()
	{
		++_curTimerID;
		return _curTimerID;
	}

	template <typename T, TGameTime_t t1, TGameTime_t t2, TGameTime_t t3, TGameTime_t t4, TGameTime_t t5, TGameTime_t t6, TGameTime_t t7, TGameTime_t t8, 
		TGameTime_t t9, TGameTime_t t10>
		void CMultiAutoTimer<T, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10>::cleanUp()
	{
		_curTimerID = INVALID_GAME_TIMER_ID;
		_timerIDContainer.clear();
		_data.clear();
	}

	// 绝对定时器的实现
	template <typename T, TGameTime_t interval>
	CAbsoluteTimerBase<T, interval>::CAbsoluteTimerBase()
	{
		cleanUp();
	}

	template <typename T, TGameTime_t interval>
	CAbsoluteTimerBase<T, interval>::~CAbsoluteTimerBase()
	{
		cleanUp();
	}

	template <typename T, TGameTime_t interval>
	void CAbsoluteTimerBase<T, interval>::update( uint32 diff )
	{
		if ( _isFirst )
		{
			registerFunc();
			_isFirst = false;
		}
		sint32 curValue = getCurValue();
		if ( curValue == _lastValue )
		{
			return ;
		}
		if ( (curValue % interval) == 0 )
		{
			T* caller = (T*)this;
			this->callFunc(caller);
			_lastValue = curValue;
		}
	}

	template <typename T, TGameTime_t interval>
	void CAbsoluteTimerBase<T, interval>::init( typename DMemFunc(T) func )
	{
		CComplexTimerBase<T>::initTimer(func);
	}

	template <typename T, TGameTime_t interval>
	void CAbsoluteTimerBase<T, interval>::cleanUp()
	{
		CComplexTimerBase<T>::cleanUp();
		_lastValue = 0;
		_isFirst = true;
	}

	// 绝对定时器的特化
	template <typename T, TGameTime_t interval>
	class CAbsoluteTimer<T, interval, MONTH_ABSOLUTE_TIMER> : public CAbsoluteTimerBase<T, interval>
	{
	public:
		CAbsoluteTimer()				{}
		virtual ~CAbsoluteTimer()		{}

	private:
		sint32			getCurValue()	{ return (DTimeManager.getMonth() + 1); }
	};

	template <typename T, TGameTime_t interval>
	class CAbsoluteTimer<T, interval, DAY_ABSOLUTE_TIMER> : public CAbsoluteTimerBase<T, interval>
	{
	public:
		CAbsoluteTimer()				{}
		virtual ~CAbsoluteTimer()		{}

	private:
		sint32			getCurValue()	{ return DTimeManager.getDay(); }
	};

	template <typename T, TGameTime_t interval>
	class CAbsoluteTimer<T, interval, HOUR_ABSOLUTE_TIMER> : public CAbsoluteTimerBase<T, interval>
	{
	public:
		CAbsoluteTimer()				{}
		virtual ~CAbsoluteTimer()		{}

	private:
		sint32			getCurValue()	{ return DTimeManager.getHour(); }
	};

	template <typename T, TGameTime_t interval>
	class CAbsoluteTimer<T, interval, MINUTE_ABSOLUTE_TIMER> : public CAbsoluteTimerBase<T, interval>
	{
	public:
		CAbsoluteTimer()				{}
		virtual ~CAbsoluteTimer()		{}

	private:
		sint32			getCurValue()	{ return DTimeManager.getMinute(); }
	};

	template <typename T, TGameTime_t interval>
	class CAbsoluteTimer<T, interval, SECOND_ABSOLUTE_TIMER> : public CAbsoluteTimerBase<T, interval>
	{
	public:
		CAbsoluteTimer()				{}
		virtual ~CAbsoluteTimer()		{}

	private:
		sint32			getCurValue()	{ return DTimeManager.getSecond(); }
	};

	// 5 second绝对定时器(只需重载call5second函数就行，也可自己定义一个新的函数，新的函数需要调用init注册)
	template <typename T>
	class CAbsoluteTimer<T, 5, SECOND_ABSOLUTE_TIMER> : public CAbsoluteTimerBase<T, 5>
	{
	public:
		CAbsoluteTimer()				{}
		virtual ~CAbsoluteTimer()		{}

	protected:
		virtual void	call5second()	{}

	private:
		sint32			getCurValue()	{ return DTimeManager.getSecond(); }

		virtual void			registerFunc()
		{
			this->init(typename DMemFunc(T)(&CAbsoluteTimer<T, 5, SECOND_ABSOLUTE_TIMER>::call5second));
		}
	};

	// 10 second绝对定时器(只需重载call5second函数就行，也可自己定义一个新的函数，新的函数需要调用init注册)
	template <typename T>
	class CAbsoluteTimer<T, 10, SECOND_ABSOLUTE_TIMER> : public CAbsoluteTimerBase<T, 10>
	{
	public:
		CAbsoluteTimer()				{}
		virtual ~CAbsoluteTimer()		{}

	protected:
		virtual void	call10second()	{}

	private:
		sint32			getCurValue()	{ return DTimeManager.getSecond(); }

		void			registerFunc()
		{
			this->init(typename DMemFunc(T)(&CAbsoluteTimer<T, 10, SECOND_ABSOLUTE_TIMER>::call10second));
		}
	};

	// 30 second绝对定时器(只需重载call5second函数就行，也可自己定义一个新的函数，新的函数需要调用init注册)
	template <typename T>
	class CAbsoluteTimer<T, 30, SECOND_ABSOLUTE_TIMER> : public CAbsoluteTimerBase<T, 30>
	{
	public:
		CAbsoluteTimer()				{}
		virtual ~CAbsoluteTimer()		{}

	protected:
		virtual void	call30second()	{}

	private:
		sint32			getCurValue()	{ return DTimeManager.getSecond(); }

		void			registerFunc()
		{
			this->init(typename DMemFunc(T)(&CAbsoluteTimer<T, 30, SECOND_ABSOLUTE_TIMER>::call30second));
		}
	};

	// 1 minute绝对定时器(只需重载call5second函数就行，也可自己定义一个新的函数，新的函数需要调用init注册)
	template <typename T>
	class CAbsoluteTimer<T, 1, MINUTE_ABSOLUTE_TIMER> : public CAbsoluteTimerBase<T, 1>
	{
	public:
		CAbsoluteTimer()				{}
		virtual ~CAbsoluteTimer()		{}

	protected:
		virtual void	call1Minute()	{}

	private:
		sint32			getCurValue()	{ return DTimeManager.getMinute(); }

		void			registerFunc()
		{
			this->init(typename DMemFunc(T)(&CAbsoluteTimer<T, 1, MINUTE_ABSOLUTE_TIMER>::call1Minute));
		}
	};

	// 5 minute绝对定时器(只需重载call5second函数就行，也可自己定义一个新的函数，新的函数需要调用init注册)
	template <typename T>
	class CAbsoluteTimer<T, 5, MINUTE_ABSOLUTE_TIMER> : public CAbsoluteTimerBase<T, 5>
	{
	public:
		CAbsoluteTimer()				{}
		virtual ~CAbsoluteTimer()		{}

	protected:
		virtual void	call5Minute()	{}

	private:
		sint32			getCurValue()	{ return DTimeManager.getMinute(); }

		void			registerFunc()
		{
			this->init(typename DMemFunc(T)(&CAbsoluteTimer<T, 5, MINUTE_ABSOLUTE_TIMER>::call5Minute));
		}
	};

	// 10 minute绝对定时器(只需重载call5second函数就行，也可自己定义一个新的函数，新的函数需要调用init注册)
	template <typename T>
	class CAbsoluteTimer<T, 10, MINUTE_ABSOLUTE_TIMER> : public CAbsoluteTimerBase<T, 10>
	{
	public:
		CAbsoluteTimer()				{}
		virtual ~CAbsoluteTimer()		{}

	protected:
		virtual void	call10Minute()	{}

	private:
		sint32			getCurValue()	{ return DTimeManager.getMinute(); }

		void			registerFunc()
		{
			this->init(typename DMemFunc(T)(&CAbsoluteTimer<T, 10, MINUTE_ABSOLUTE_TIMER>::call10Minute));
		}
	};

	// 15 minute绝对定时器(只需重载call5second函数就行，也可自己定义一个新的函数，新的函数需要调用init注册)
	template <typename T>
	class CAbsoluteTimer<T, 15, MINUTE_ABSOLUTE_TIMER> : public CAbsoluteTimerBase<T, 15>
	{
	public:
		CAbsoluteTimer()				{}
		virtual ~CAbsoluteTimer()		{}

	protected:
		virtual void	call15Minute()	{}

	private:
		sint32			getCurValue()	{ return DTimeManager.getMinute(); }

		void			registerFunc()
		{
			this->init(typename DMemFunc(T)(&CAbsoluteTimer<T, 15, MINUTE_ABSOLUTE_TIMER>::call15Minute));
		}
	};

	// 30 minute绝对定时器(只需重载call5second函数就行，也可自己定义一个新的函数，新的函数需要调用init注册)
	template <typename T>
	class CAbsoluteTimer<T, 30, MINUTE_ABSOLUTE_TIMER> : public CAbsoluteTimerBase<T, 30>
	{
	public:
		CAbsoluteTimer()				{}
		virtual ~CAbsoluteTimer()		{}

	protected:
		virtual void	call30Minute()	{}

	private:
		sint32			getCurValue()	{ return DTimeManager.getMinute(); }

		void			registerFunc()
		{
			this->init(typename DMemFunc(T)(&CAbsoluteTimer<T, 30, MINUTE_ABSOLUTE_TIMER>::call30Minute));
		}
	};
}

#include "timer.hpp"

#endif