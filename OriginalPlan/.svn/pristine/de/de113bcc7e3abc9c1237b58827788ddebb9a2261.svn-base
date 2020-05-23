#ifndef _PERFOR_STAT_H_
#define _PERFOR_STAT_H_

#include "types_def.h"

namespace GXMISC
{
#ifdef OS_UNIX

#include <google/profiler.h>
	static void PerfStart(const char* name)
	{
		ProfilerStart(name);
	}
	static void PerfStop()
	{
		ProfilerStop();
	}
	static void PerfFlush()
	{
		ProfilerFlush();
	}
#else
	static void PerfStart(const char* name){}
	static void PerfStop(){}
	static void PerfFlush(){}
#endif
}

#endif // _PERFOR_STAT_H_
