#ifndef _TIME_SPAN_H_
#define _TIME_SPAN_H_

#include "types_def.h"
#include "base_util.h"

namespace GXMISC
{
	// @TODO �������ʱ����
	/**
	 * @brief ʱ�����
	 * @notice ��С��λΪ��
	 */
	class CTimespan
	{
	public:
		CTimespan();
		explicit CTimespan(TTimeDiff_t seconds);
		CTimespan(sint32 seconds, sint32 mins, sint32 hours, sint32 days);
		CTimespan(const CTimespan& timespan);
        
		~CTimespan();

	public:
		CTimespan& operator = (const CTimespan& timespan);
		CTimespan& operator = (TTimeDiff_t seconds);
	
	public:
		void reset();
		CTimespan& assign(sint32 seconds, sint32 mins = 0, sint32 hours = 0, sint32 days = 0);
		void swap(CTimespan& timespan);

	public:
		bool operator == (const CTimespan& ts) const;
		bool operator != (const CTimespan& ts) const;
		bool operator >  (const CTimespan& ts) const;
		bool operator >= (const CTimespan& ts) const;
		bool operator <  (const CTimespan& ts) const;
		bool operator <= (const CTimespan& ts) const;

		bool operator == (TTimeDiff_t microseconds) const;
		bool operator != (TTimeDiff_t microseconds) const;
		bool operator >  (TTimeDiff_t microseconds) const;
		bool operator >= (TTimeDiff_t microseconds) const;
		bool operator <  (TTimeDiff_t microseconds) const;
		bool operator <= (TTimeDiff_t microseconds) const;

		CTimespan operator + (const CTimespan& d) const;
		CTimespan operator - (const CTimespan& d) const;
		CTimespan& operator += (const CTimespan& d);
		CTimespan& operator -= (const CTimespan& d);

		CTimespan operator + (TTimeDiff_t seconds) const;
		CTimespan operator - (TTimeDiff_t seconds) const;
		CTimespan& operator += (TTimeDiff_t seconds);
		CTimespan& operator -= (TTimeDiff_t seconds);
			
	public:
		/// ����������
		sint32 days() const;

		/**
		 * @brief ����Сʱ
		 * @return 0-23
		 */
		sint32 hours() const;
	
		/// �����ܵ�Сʱ��
		sint32 totalHours() const;
		
		/**
		 * @brief ���ط���
		 * @return 0-59
		 */
		sint32 minutes() const;
		
		/// �����ܵķ�����
		sint32 totalMinutes() const;
		
		/**
		 * @brief ��������
		 * @return 0-59
		 */
		sint32 seconds() const;
		
		/// �����ܵ�����
		sint32 totalSeconds() const;

        // ��ȡ
		TTimeDiff_t getTimeSpan() const;

	public:
		static const TTimeDiff_t MINUTES;      /// һ�ֵ��ڶ�����
		static const TTimeDiff_t HOURS;        /// һʱ���ڶ�����
		static const TTimeDiff_t DAYS;         /// һ����ڶ�����

	private:
		TTimeDiff_t _span;						/// �ܵ�����
	};


	//
	// inlines
	//
	inline sint32 CTimespan::days() const
	{
		return sint32(_span/DAYS);
	}


	inline sint32 CTimespan::hours() const
	{
		return sint32((_span/HOURS) % 24);
	}


	inline sint32 CTimespan::totalHours() const
	{
		return sint32(_span/HOURS);
	}


	inline sint32 CTimespan::minutes() const
	{
		return sint32((_span/MINUTES) % 60);
	}


	inline sint32 CTimespan::totalMinutes() const
	{
		return sint32(_span/MINUTES);
	}


	inline sint32 CTimespan::seconds() const
	{
		return sint32((_span) % 60);
	}


	inline sint32 CTimespan::totalSeconds() const
	{
		return sint32(_span);
	}

	inline bool CTimespan::operator == (const CTimespan& ts) const
	{
		return _span == ts._span;
	}


	inline bool CTimespan::operator != (const CTimespan& ts) const
	{
		return _span != ts._span;
	}


	inline bool CTimespan::operator >  (const CTimespan& ts) const
	{
		return _span > ts._span;
	}


	inline bool CTimespan::operator >= (const CTimespan& ts) const
	{
		return _span >= ts._span;
	}


	inline bool CTimespan::operator <  (const CTimespan& ts) const
	{
		return _span < ts._span;
	}


	inline bool CTimespan::operator <= (const CTimespan& ts) const
	{
		return _span <= ts._span;
	}


	inline bool CTimespan::operator == (TTimeDiff_t microseconds) const
	{
		return _span == microseconds;
	}


	inline bool CTimespan::operator != (TTimeDiff_t microseconds) const
	{
		return _span != microseconds;
	}


	inline bool CTimespan::operator >  (TTimeDiff_t microseconds) const
	{
		return _span > microseconds;
	}


	inline bool CTimespan::operator >= (TTimeDiff_t microseconds) const
	{
		return _span >= microseconds;
	}


	inline bool CTimespan::operator <  (TTimeDiff_t microseconds) const
	{
		return _span < microseconds;
	}


	inline bool CTimespan::operator <= (TTimeDiff_t microseconds) const
	{
		return _span <= microseconds;
	}


	inline void swap(CTimespan& s1, CTimespan& s2)
	{
		s1.swap(s2);
	}

}               // namespace GXMISC


#endif			// _TIME_SPAN_H_
