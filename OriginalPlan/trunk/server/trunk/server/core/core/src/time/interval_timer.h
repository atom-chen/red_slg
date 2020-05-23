#ifndef _INTERVAL_TIMER_H_
#define _INTERVAL_TIMER_H_

#include "stdcore.h"
#include "types_def.h"
#include "time_gx.h"
#include "singleton.h"
#include "time_util.h"

namespace GXMISC
{
	// @TODO ��ʱ����Ҫ�������

	/// ��󴥷�����
	static const uint32 INVALID_INTERVAL_TIMER_COUNT = std::numeric_limits<uint32>::max();
	
	class CIntervalTimer
	{
        friend class CIntervalTimerMgr;

	public:
		CIntervalTimer();
		CIntervalTimer(uint32 maxInterval, uint32 num = INVALID_INTERVAL_TIMER_COUNT);
		~CIntervalTimer();

	public:
		// ���������ʱ��
		void setMaxInterval(TTime maxInterval);
		// ���ô�������
		void setMaxNum(uint32 num);
        // ��ʼ�����ʱ��������󴥷�����
        void init(uint32 maxInterval, uint32 num = INVALID_INTERVAL_TIMER_COUNT);

	public:
		// ����ʱ��
		void update(TTime diff);
		// �ж��Ƿ��Ѿ�����ʱ��
		bool isPassed();
		// �ж϶�ʱ���Ƿ���Ч(�紥�������Զ���0)
		bool isValid();
		// ִ��һ�γ�ʱ����
		void doTimeout();
		// ����
		void reset(bool force = true);
		TTime getCurInterval();
		TTime getRemainInterval();
		sint32 getRemainSecs();
		sint32 getMaxSecs();

	public:
		// ��������
		virtual bool onTimeout(){return true;};

	private:
		bool isUnlimit();
        bool isNeedFree();
        void setNeedFree();

	private:
		uint32 _maxNum;				// ��󴥷�����
		uint32 _num;				// ��ʱ����������(INVALID_INTERVAL_TIMER_COUNT��ʾ�����ƴ���)
		TTime _curInterval;			// �����ʱ��(��λΪ����)
		TTime _maxInterval;			// ���õļ��ʱ��
        bool  _isNeedFree;          // �Ƿ���Ҫ�ͷ�
	};

	class CManualIntervalTimer
	{
	public:
		CManualIntervalTimer();
		CManualIntervalTimer(uint32 maxInterval);
		~CManualIntervalTimer();

	public:
		// ���������ʱ��
		void setMaxInterval(TTime maxInterval);
		// ��ʼ�����ʱ��������󴥷�����
		void init(uint32 maxInterval);

	public:
		// ����ʱ��
		bool update(TTime diff);
		// �ж��Ƿ��Ѿ�����ʱ��
		bool isPassed();
		// ����
		void reset(bool force = true);
		TTime getCurInterval();
		TTime getRemainInterval();
		sint32 getRemainSecs();
		sint32 getMaxSecs();

	private:
		TTime _curInterval;			// �����ʱ��(��λΪ����)
		TTime _maxInterval;			// ���õļ��ʱ��
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

	// ���嶨ʱ����������
	#define DIntervalTimerMgr CIntervalTimerMgr::GetInstance()
	typedef GXMISC::CManualIntervalTimer	GXManuaTimer;				///< �ֶ���ʱ��
}

#endif 