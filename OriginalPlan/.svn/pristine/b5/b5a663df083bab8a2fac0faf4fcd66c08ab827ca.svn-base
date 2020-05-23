#include "debug.h"
#include "string_common.h"
#include "common.h"

#ifdef OS_WINDOWS
#	include <io.h>
#	include <tchar.h>
#elif defined OS_UNIX
#	include <unistd.h>
#	include <cerrno>
#	include <pthread.h>
#	include <sched.h>
#endif

using namespace std;

namespace	GXMISC
{
    /*
    * Portable Sleep() function that suspends the execution of the calling thread for a number of milliseconds.
    * Note: the resolution of the timer is system-dependant and may be more than 1 millisecond.
    */
    void gxSleep( TDiffTime_t ms )
    {
#ifdef OS_WINDOWS
#ifdef LIB_DEBUG
        // Sleep(0) 在调试模式下会阻塞线程
		ms = std::max(ms, (TDiffTime_t)1);
#endif
        Sleep( ms );
#elif defined OS_UNIX
        timespec ts;
        ts.tv_sec = ms/1000;
        ts.tv_nsec = (ms%1000)*1000000;
        int res;
        do
        {
            res = nanosleep( &ts, &ts ); // resolution: 10 ms (with common scheduling policy)
        }
        while ( (res != 0) && (errno==EINTR) );
#endif
    }

    /*
    * Returns Thread Id (note: on Linux, Process Id is the same as the Thread Id)
    */
    TThreadID_t gxGetThreadID()
    {
#ifdef OS_WINDOWS
        return TThreadID_t(GetCurrentThreadId());
#elif defined OS_UNIX
        return TThreadID_t(pthread_self());
        // doesnt work on linux kernel 2.6	return getpid();
#endif
    }

    /*
    * Returns a readable string from a vector of bytes. '\0' are replaced by ' '
    */
    string gxStringFromVector( const vector<uint8>& v, bool limited )
    {
        string s;

        if (!v.empty())
        {
            int size = (int)v.size ();
            if (limited && size > 1000)
            {
                string middle = "...<buf too big,skip middle part>...";
                s.resize (1000 + middle.size());
                memcpy (&*s.begin(), &*v.begin(), 500);
                memcpy (&*s.begin()+500, &*middle.begin(), middle.size());
                memcpy (&*s.begin()+500+middle.size(), &*v.begin()+size-500, 500);
            }
            else
            {
                s.resize (size);
                memcpy( &*s.begin(), &*v.begin(), v.size() );
            }

            // Replace '\0' characters
            string::iterator is;
            for ( is=s.begin(); is!=s.end(); ++is )
            {
                // remplace non printable char and % with '?' chat
                if ( ! isprint((uint8)(*is)) || (*is) == '%')
                {
                    (*is) = '?';
                }
            }
        }
        return s;
    }

    sint64 gxAtoiInt64 (const char *ident, sint64 base)
    {
        sint64 number = 0;
        bool neg = false;

        // NULL string
        gxAssert (ident != NULL);

        // empty string
        if (*ident == '\0') goto end;

        // + sign
        if (*ident == '+') ident++;

        // - sign
        if (*ident == '-') { neg = true; ident++; }

        while (*ident != '\0')
        {
            if (isdigit((unsigned char)*ident))
            {
                number *= base;
                number += (*ident)-'0';
            }
            else if (base > 10 && islower((unsigned char)*ident))
            {
                number *= base;
                number += (*ident)-'a'+10;
            }
            else if (base > 10 && isupper((unsigned char)*ident))
            {
                number *= base;
                number += (*ident)-'A'+10;
            }
            else
            {
                goto end;
            }
            ident++;
        }
end:
        if (neg) number = -number;
        return number;
    }

    void gxItoaInt64 (sint64 number, char *str, sint64 base)
    {
        str[0] = '\0';
        char b[256];
        if(!number)
        {
            str[0] = '0';
            str[1] = '\0';
            return;
        }
        memset(b,'\0',255);
        memset(b,'0',64);
        sint32 n;
        sint64 x = number;
        if (x < 0) x = -x;
        char baseTable[] = "0123456789abcdefghijklmnopqrstuvwyz";
        for(n = 0; n < 64; n ++)
        {
            sint32 num = (sint32)(x % base);
            b[64 - n] = baseTable[num];
            if(!x)
            {
                int k;
                int j = 0;

                if (number < 0)
                {
                    str[j++] = '-';
                }

                for(k = 64 - n + 1; k <= 64; k++)
                {
                    str[j ++] = b[k];
                }
                str[j] = '\0';
                break;
            }
            x /= base;
        }
    }

    uint32 gxRaiseToNextPowerOf2(uint32 v)
    {
        uint32	res=1;
        while(res<v)
            res<<=1;

        return res;
    }

    uint32	gxGetPowerOf2(uint32 v)
    {
        uint32	res=1;
        uint32	ret=0;
        while(res<v)
        {
            ret++;
            res<<=1;
        }

        return ret;
    }

    bool gxIsPowerOf2(sint32 v)
    {
        while(v)
        {
            if(v&1)
            {
                v>>=1;
                if(v)
                    return false;
            }
            else
                v>>=1;
        }

        return true;
    }

    string gxBytesToHumanReadable (const std::string &bytes)
    {
        return gxBytesToHumanReadable (gxAtoiInt64(bytes.c_str()));
    }

    string gxBytesToHumanReadable (uint64 bytes)
    {
        static const char *divTable[]= { "B", "KB", "MB", "GB", "TB" };
        uint32 div = 0;
        uint64 res = bytes;
        uint64 newres = res;
        for(;;)
        {
            newres /= 1024;
            if(newres < 8 || div > 3)
                break;
            div++;
            res = newres;
        }
        return gxToString ("%"I64_FMT"u%s", res, divTable[div]);
    }

    uint32 gxHumanReadableToBytes (const string &str)
    {
        uint32 res;

        if(str.empty())
            return 0;

        // not a number
        if(str[0]<'0' || str[0]>'9')
            return 0;

        res = atoi (str.c_str());

        if(str[str.size()-1] == 'B')
        {
            if (str.size()<3)
                return res;

            // there s no break and it's **normal**
            switch (str[str.size()-2])
            {
            case 'G': res *= 1024;
            break;
            case 'M': res *= 1024;
            break;
            case 'K': res *= 1024;
            break;
            default:
                break;
            }
        }

        return res;
    }

    string gxSecondsToHumanReadable (uint32 time)
    {
        static const char *divTable[] = { "s", "mn", "h", "d" };
        static uint32  divCoef[]  = { 60, 60, 24 };
        uint32 div = 0;
        uint32 res = time;
        uint32 newres = res;
        for(;;)
        {
            if(div > 2)
                break;

            newres /= divCoef[div];

            if(newres < 3)
                break;

            div++;
            res = newres;
        }
        return gxToString ("%u%s", res, divTable[div]);
    }

    uint32 gxFromHumanReadable (const std::string &str)
    {
        if (str.size() == 0)
            return 0;

        uint32 val;
        gxFromString(str, val);

        switch (str[str.size()-1])
        {
        case 's': return val;			// second
        case 'n': return val*60;		// minutes (mn)
        case 'h': return val*60*60;		// hour
        case 'd': return val*60*60*24;	// day
        case 'b':	// bytes
            switch (str[str.size()-2])
            {
            case 'k': return val*1024;
            case 'm': return val*1024*1024;
            case 'g': return val*1024*1024*1024;
            default : return val;
            }
            break;
        default: return val;
        }
    }

    std::string	gxToLower(const std::string &str)
    {
        string res;
        res.reserve(str.size());
        for(uint32 i = 0; i < str.size(); i++)
        {
            if( (str[i] >= 'A') && (str[i] <= 'Z') )
                res += str[i] - 'A' + 'a';
            else
                res += str[i];
        }
        return res;
    }

    char gxToLower(const char ch)
    {
        if( (ch >= 'A') && (ch <= 'Z') )
        {
            return ch - 'A' + 'a';
        }
        else
        {
            return ch;
        }
    }

    void gxToLower(char *str)
    {
        if (str == 0)
            return;

        while(*str != '\0')
        {
            if( (*str >= 'A') && (*str <= 'Z') )
            {
                *str = *str - 'A' + 'a';
            }
            str++;
        }
    }

    std::string	gxToUpper(const std::string &str)
    {
        string res;
        res.reserve(str.size());
        for(uint32 i = 0; i < str.size(); i++)
        {
            if( (str[i] >= 'a') && (str[i] <= 'z') )
                res += str[i] - 'a' + 'A';
            else
                res += str[i];
        }
        return res;
    }

    void gxToUpper(char *str)
    {
        if (str == 0)
            return;

        while(*str != '\0')
        {
            if( (*str >= 'a') && (*str <= 'z') )
            {
                *str = *str - 'a' + 'A';
            }
            str++;
        }
    }

    int	gxFseek64( FILE *stream, sint64 offset, int origin )
    {
#ifdef OS_WINDOWS
        fpos_t pos64 = 0;
        switch (origin)
        {
        case SEEK_CUR:
            if (fgetpos(stream, &pos64) != 0)
                return -1;
        case SEEK_END:
            pos64 = _filelengthi64(_fileno(stream));
            if (pos64 == -1L)
                return -1;
        };

        // Seek
        pos64 += offset;

        // Set the final position
        return fsetpos (stream, &pos64);

#else // OS_WINDOWS

        // This code doesn't work under windows : fseek() implementation uses a signed 32 bits offset. What ever we do, it can't seek more than 2 Go.
        // For the moment, i don't know if it works under linux for seek of more than 2 Go.

        gxAssert ((offset < SINT64_CONSTANT(2147483647)) && (offset > SINT64_CONSTANT(-2147483648)));

        bool first = true;
        do
        {
            // Get the size of the next fseek
            sint32 nextSeek;
            if (offset > 0)
                nextSeek = (sint32)std::min ((sint64)SINT64_CONSTANT(2147483647), offset);
            else
                nextSeek = (sint32)std::max ((sint64)-SINT64_CONSTANT(2147483648), offset);

            // Make a seek
            int result = fseek ( stream, nextSeek, first?origin:SEEK_CUR );
            if (result != 0)
                return result;

            // Remaining
            offset -= nextSeek;
            first = false;
        }
        while (offset);

        return 0;

#endif // OS_WINDOWS
    }

    sint64 gxFtell64(FILE *stream)
    {
#ifdef OS_WINDOWS
        fpos_t pos64 = 0;
        if (fgetpos(stream, &pos64) == 0)
        {
            return (sint64) pos64;
        }
        else
        {
            return -1;
        }
#else
        //gxError("Not impl!");
        return -1;
#endif
    }

	bool gxIsBigEndian()
	{
		sint16 val = 0x5678; 
		return (*((sint8*)&val) == 0x78); 
	}

	uint64 gxNetToHostT(uint64 n)
	{
		return (((uint64)ntohl((uint32)n)) << 32) | ntohl((uint32)(n >> 32));
	}
	uint32 gxNetToHostT(uint32 n)
	{
		return ntohl(n);
	}
	uint16 gxNetToHostT(uint16 n)
	{
		return ntohs(n);
	}
	sint64 gxNetToHostT(sint64 n)
	{
		return (((sint64)ntohl((uint32)n)) << 32) | ntohl((uint32)(n >> 32));
	}
	sint32 gxNetToHostT(sint32 n)
	{
		return ntohl(n);
	}
	sint16 gxNetToHostT(sint16 n)
	{
		return ntohs(n);
	}
	uint64 gxHostToNetT(uint64 n)
	{
		return (((uint64)htonl((uint32)n)) << 32) | htonl((uint32)(n >> 32));
	}
	uint32 gxHostToNetT(uint32 n)
	{
		return htonl(n);
	}
	uint16 gxHostToNetT(uint16 n)
	{
		return htons(n);
	}
	sint64 gxHostToNetT(sint64 n)
	{
		return (((sint64)htonl((uint32)n)) << 32) | htonl((uint32)(n >> 32));
	}
	sint32 gxHostToNetT(sint32 n)
	{
		return htonl(n);
	}
	sint16 gxHostToNetT(sint16 n)
	{
		return htons(n);
	}

} // GXMISC
