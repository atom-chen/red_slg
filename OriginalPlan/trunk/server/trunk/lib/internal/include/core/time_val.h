#ifndef _TIME_VAL_H_
#define _TIME_VAL_H_

#include "base_util.h"
#include "stdcore.h"

#ifdef OS_WINDOWS
#elif defined(OS_UNIX)
#include "sys/time.h"
#endif

typedef struct timeval TTimeVal_t;      // 时间

namespace GXMISC
{
    class CTimeVal
    {
    public:
        CTimeVal(uint32 diff)
        {
            memset(&_val, 0, sizeof(_val));
            _val.tv_sec = diff/1000;
            _val.tv_usec = (diff%1000)*1000;
        }

    public:
        TTimeVal_t* toTimeVal()
        {
            return &_val;
        }

    private:
        TTimeVal_t _val;
    };
}

#endif