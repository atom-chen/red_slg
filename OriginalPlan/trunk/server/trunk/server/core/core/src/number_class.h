#ifndef _NUMBER_CLASS_H_
#define _NUMBER_CLASS_H_

#include "string_common.h"

// @TODO 测试接口完整性
namespace GXMISC
{
#pragma pack(push, 1)

	template<typename T>
	class CNumber
	{
	public:
		CNumber(){
			_val = (T)0;
		}
		CNumber(T val):_val(val){}
		CNumber(const std::string& str){
			T val = (T)0;
			if(GXMISC::gxFromString(str, val)){
				_val = val;
			}else{
				_val = (T)0;
			}
		}
		// 操作符重载
	public:
		//+    -    *    /    ==    <    <=
		template<typename T2>
		CNumber<T> operator+(const T2& val){
			T tempVal = _val + (T)val;
			return tempVal;
		}

		template<typename T2>
		CNumber<T> operator*(const T2& val){
			T tempVal = _val * (T)val;
			return tempVal;
		}

		template<typename T2>
		CNumber<T> operator-(const T2& val){
			T tempVal = _val - (T)val;
			return tempVal;
		}

		template<typename T2>
		CNumber<T> operator/(const T2& val){
			T tempVal = _val / (T)val;
			return tempVal;
		}

	public:
		template<typename T2>
		bool operator == (const T2& val) const
		{
			return _val == (T)val;
		}
		template<typename T2>
		bool operator < (const T2& val) const
		{
			return _val < (T)val;
		}
		template<typename T2>
		bool operator <= (const T2& val) const
		{
			return _val <= (T)val;
		}

	public:
		operator T() const
		{
			return _val;
		}
		operator std::string() const
		{
			return GXMISC::gxToString(_val);
		}

		// 赋值操作
	public:
		template<typename T2>
		CNumber<T> &operator=(const T2& val)
		{
			_val = (T)val;
		}
		CNumber<T> &operator=(const std::string& str){
			T val = (T)0;
			if(GXMISC::gxFromString(str, val)){
				_val = val;
			}else{
				_val = (T)0;
			}
		}

	private:
		T _val;
	};

	typedef CNumber<sint64> CNumber64;
	typedef CNumber<uint64> CNumber64u;

#pragma pack(pop)
}

#endif	// _NUMBER_CLASS_H_