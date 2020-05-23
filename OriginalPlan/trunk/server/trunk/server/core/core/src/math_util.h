#ifndef _MATH_UTIL_H_
#define _MATH_UTIL_H_

namespace GXMISC
{
	/** Pi constant in double format.
    */
    const double PI = 3.1415926535897932384626433832795;

    /** Return a float random inside the interval [0,mod]
    */
    inline float gxFloatRand(float mod)
    {
        double	r = (double) rand();
        r/= (double) RAND_MAX;
        return (float)(r * mod);
    }

    /** Return -1 if f<0, 0 if f==0, 1 if f>1
    */
    inline sint32 gxFloatSgn(double f)
    {
        if(f<0)
            return -1;
        else if(f>0)
            return 1;
        else
            return 0;
    }
	
	// 求2次幂
    template<class T>
	inline T gxSqr(const T &v)
    {
        return v * v;
    }

	// 截取值范围
    template<class T, class U, class V>	
	inline void gxClamp(T &v, const U &min, const V &max)
    {
        v = (v < min) ? min : v;
        v = (v > max) ? max : v;
    }

	// 求值是否在某个范围内
	template<class T, class U, class V> 
	inline bool gxBetween(const T& v, const U&min, const V&max)
	{
		return v > min && v < max;
	}
	template<class T, class U, class V> 
	inline bool gxBetweenEQ(const T& v, const U&min, const V&max)
	{
		return v >= min && v <= max;
	}
	template<class T, class U, class V> 
	inline bool gxBetweenLQ(const T& v, const U&min, const V&max)
	{
		return v >= min && v < max;
	}
	template<class T, class U, class V> 
	inline bool gxBetweenRQ(const T& v, const U&min, const V&max)
	{
		return v > min && v <= max;
	}

    /** MIN/MAX 扩展函数
    */
    template<class T>
	inline T gxMinOf(const T& a,  const T& b,  const T& c)
    {
		return std::min(std::min(a,b),c);
	}
    template<class T>
	inline T gxMinOf(const T& a,  const T& b,  const T& c,  const T& d)
    {
		return std::min(gxMinOf(a,b,c),d);
	}
    template<class T>
	inline T gxMinOf(const T& a,  const T& b,  const T& c,  const T& d,  const T& e)
    {
		return std::min(gxMinOf(a,b,c,d),e);
	}
    template<class T>
	inline T gxMaxOf(const T& a,  const T& b,  const T& c)
    {
		return std::max(std::max(a,b),c);
	}
    template<class T>
	inline T gxMaxOf(const T& a,  const T& b,  const T& c,  const T& d)
    {
		return std::max(gxMaxOf(a,b,c),d);
	}
    template<class T>
	inline T gxMaxOf(const T& a,  const T& b,  const T& c,  const T& d,  const T& e)
    {
		return std::max(gxMaxOf(a,b,c,d),e);
	}

    /** Return the value maximized to the next power of 2 of v.
    * Example:
    *   raiseToNextPowerOf2(8) is 8
    *   raiseToNextPowerOf2(5) is 8
    */
    uint32			gxRaiseToNextPowerOf2 (uint32 v);

    /** Return the power of 2 of v.
    * Example:
    *   getPowerOf2(8) is 3
    *   getPowerOf2(5) is 3
    */
    uint32			gxGetPowerOf2 (uint32 v);

    /** Return \c true if the value is a power of 2.
    */
    bool			gxIsPowerOf2 (sint32 v);


    /** Converts from degrees to radians
    */
    inline float	gxDegToRad( float deg )
    {
        return deg * (float)PI / 180.0f;
    }

    /** Converts from radians to degrees
    */
    inline float	gxRadToDeg( float rad )
    {
        return rad * 180.0f / (float)PI;
    }

    /** Return true if double is a valid value (not inf nor nan)
    */
	inline double	gxIsValidDouble (double v)
	{
#ifdef OS_WINDOWS
		return _finite(v) && !_isnan(v);
#else
#ifdef _STLPORT_VERSION
		return !isnan(v) && !isinf(v);
#else
		return !std::isnan(v) && !std::isinf(v);
#endif
#endif
	}

    // AntiBug method that return an epsilon if x==0, else x
    inline float	gxFavoid0(float x)
    {
        if(x==0)	return 0.00001f;
        return x;
    }
    inline double	gxDavoid0(double x)
    {
        if(x==0)	return 0.00001;
        return x;
    }
    // AntiBug method that return 1 if x==0, else x
    template<class T>
    inline T		gxIavoid0(T x)
    {
        if(x==0)	return 1;
        return x;
    }

	template<typename U>
	U gxDouble2Int(double TValue)
	{
		U iValue = (U)TValue;

		if(fabs(TValue-iValue)< 0.500000f)
		{
			return iValue;
		}
		else
		{
			return iValue+1 > std::numeric_limits<U>::max() ? std::numeric_limits<U>::max() : iValue+1;
		}
	}
}

#endif // _MATH_UTIL_H_