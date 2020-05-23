
#include "timespan.h"
#include <algorithm>


namespace GXMISC {

	const TTimeDiff_t CTimespan::MINUTES      =   60;
	const TTimeDiff_t CTimespan::HOURS        =   60*CTimespan::MINUTES;
	const TTimeDiff_t CTimespan::DAYS         =   24*CTimespan::HOURS;


	CTimespan::CTimespan():
	_span(0)
	{
	}


	CTimespan::CTimespan(TTimeDiff_t seconds):
	_span(seconds)
	{
	}

	CTimespan::CTimespan(sint32 days, sint32 hours, sint32 minutes, sint32 seconds):
	_span( TTimeDiff_t(seconds) + TTimeDiff_t(minutes)*MINUTES + TTimeDiff_t(hours)*HOURS + TTimeDiff_t(days)*DAYS)
	{
	}


	CTimespan::CTimespan(const CTimespan& timespan):
	_span(timespan._span)
	{
	}

	CTimespan::~CTimespan()
	{
	}


	CTimespan& CTimespan::operator = (const CTimespan& timespan)
	{
		_span = timespan._span;
		return *this;
	}


	CTimespan& CTimespan::operator = (TTimeDiff_t seconds)
	{
		_span = seconds;
		return *this;
	}


	CTimespan& CTimespan::assign(sint32 days, sint32 hours, sint32 minutes, sint32 seconds)
	{
		_span = TTimeDiff_t(seconds) + TTimeDiff_t(minutes)*MINUTES + TTimeDiff_t(hours)*HOURS + TTimeDiff_t(days)*DAYS;
		return *this;
	}


	void CTimespan::swap(CTimespan& timespan)
	{
		std::swap(_span, timespan._span);
	}

	TTimeDiff_t CTimespan::getTimeSpan() const
	{
		return _span;
	}

	CTimespan CTimespan::operator + (const CTimespan& d) const
	{
		return CTimespan(_span + d._span);
	}


	CTimespan CTimespan::operator - (const CTimespan& d) const
	{
		return CTimespan(_span - d._span);
	}


	CTimespan& CTimespan::operator += (const CTimespan& d)
	{
		_span += d._span;
		return *this;
	}


	CTimespan& CTimespan::operator -= (const CTimespan& d)
	{
		_span -= d._span;
		return *this;
	}


	CTimespan CTimespan::operator + (TTimeDiff_t microseconds) const
	{
		return CTimespan(_span + microseconds);
	}


	CTimespan CTimespan::operator - (TTimeDiff_t microseconds) const
	{
		return CTimespan(_span - microseconds);
	}


	CTimespan& CTimespan::operator += (TTimeDiff_t microseconds)
	{
		_span += microseconds;
		return *this;
	}


	CTimespan& CTimespan::operator -= (TTimeDiff_t microseconds)
	{
		_span -= microseconds;
		return *this;
	}

	void CTimespan::reset()
	{
		_span = 0;
	}

} // namespace GXMISC
