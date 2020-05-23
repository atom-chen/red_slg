#ifndef _DB_UTIL_H_
#define _DB_UTIL_H_

#include "carray.h"
#include "types_def.h"
#include "time_manager.h"
#include "mystring.h"
#include "debug.h"

class RTTIFieldDescriptor;
namespace GXMISC{

	// 数据库列数据类型
	enum EDB_FIELD_TYPE
	{
		DB_TYPEBEGIN,

		// 当前用到的类型
		DB_BYTE,				// 字节 uint8
		DB_BYTES,				// 字节 sint8
		DB_WORD,				// 双字节 uint16
		DB_WORDS,				// 双字节 sint16
		DB_DWORD,				// 四字节 uint32
		DB_DWORDS,				// 四字节 sint32
		DB_QWORD,				// 八字节 uint64
		DB_QWORDS,				// 八字节 uint64
		DB_FLOAT,				// 浮点数 float
		DB_DOUBLE,				// 双精度 double
		DB_RAW_STR,				// 原生字符串 CFixArray
		DB_TINY_STR,			// 变长字符串 CCharArray[uint8]
		DB_STR,					// 变长字符串 CCharArray[uint16]
		DB_BIG_STR,				// 变长字符串 CCharArray[uint32]
		DB_DATETIME,			// 日期 TGameTime_t
		DB_OBJECT,				// 结构对象

		// 未用到的类型
		DB_BIN,					// 二进制
		DB_ZIP,					// 压缩二进制
		DB_BIN2,				// 二进制
		DB_ZIP2,				// 压缩二进制

		DB_TYPEEND,
	};

	EDB_FIELD_TYPE ConvertRtti2Dbtype(RTTIFieldDescriptor* pfield);


	// 转换基础类型
	template<typename T>
	inline void conv(T& t, const mysqlpp::String& str, const T& inv)
	{
		if(!str.is_null())
		{
			t = str.conv<T>(0);
		}
		else
		{
			t = inv;
		}
	}
	template<typename T>
	inline void conv1(T& t, const mysqlpp::String& str)
	{
		if(!str.is_null())
		{
			t = str.conv<T>(0);
		}
		else
		{
			t = 0;
		}
	}
	template<>
	inline void conv1<std::string>(std::string& t, const mysqlpp::String& str)
	{
		if(!str.is_null())
		{
			t = str.c_str();
		}
		else
		{
			t = "";
		}
	}

	// 转换字符串(包括定长定符串CFixString，变长字符串CCharArray)
	template<typename T>
	inline void convString(T& outString, const mysqlpp::String& str){
		if(!str.is_null())
		{
			outString = str.c_str();
		}
		else
		{
			outString = "";
		}
	}

	// 转换时间
	inline void convTime(TGameTime_t& t, const mysqlpp::String& str, const TGameTime_t& inv)
	{
		t = inv;
		if(!str.is_null())
		{
			mysqlpp::DateTime tt = str.conv<mysqlpp::DateTime>(mysqlpp::DateTime());
			t = TGameTime_t(tt);
		}
	}

	// 转换char*
	inline  void convBuf(char* buf, const mysqlpp::String& str)
	{
		if(!str.is_null())
		{
			memcpy(buf, str.c_str(), str.size());
			buf[str.size()] = '\0';
		}
		else
		{
			buf[0] = '\0';
		}
	}

// 	template<typename T> @TODO
// 	inline bool convBStrToStruct(T& data, const mysqlpp::String& str)
// 	{
// 		if(!str.is_null() && str.size() > 0)
// 		{
// 			return GXMISC::BStrToStruct(data, str.c_str());
// 		}
// 
// 		return false;
// 	}

	/// 数据库条件类型
	enum EDbCondType{
		DB_COND_TYPE_INVALID,	///< 无效
		DB_COND_TYPE_EV,		///< 赋值
		DB_COND_TYPE_NEQ,		///< 不等于
		DB_COND_TYPE_EQ,		///< 等于
		DB_COND_TYPE_LE,		///< 小于等于
		DB_COND_TYPE_LT,		///< 小于
		DB_COND_TYPE_GE,		///< 大于等于
		DB_COND_TYPE_GT,		///< 大于
	};

	static const std::string dbCondTypeToString(EDbCondType type)
	{
		switch(type){
		case DB_COND_TYPE_NEQ:
			{
				return "<>";
			}break;
		case DB_COND_TYPE_EQ:
			{
				return "=";
			}break;
		case DB_COND_TYPE_LE:
			{
				return "<=";
			}break;
		case DB_COND_TYPE_LT:
			{
				return "<";
			}break;
		case DB_COND_TYPE_GE:
			{
				return ">=";
			}break;
		case DB_COND_TYPE_GT:
			{
				return ">";
			}break;
		default:
			{
				return "";
			}
		}

		return "";
	}

	template<typename T>
	static std::string dbToString(const std::string& name, const T& val, EDbCondType type){
		std::string out;
// 		std::string fmt = name+dbCondTypeToString(type)+"'{0}'";
// 		fastformat::fmt(out, fmt, val);
		out = name;
		out.append(dbCondTypeToString(type));
		std::stringstream streamstr;
		streamstr<<val;
		out.append("'"+streamstr.str()+"'");
		return out;
	}

#define DDbEQ(name, val) GXMISC::dbToString(name, val, GXMISC::DB_COND_TYPE_EQ).c_str()
#define DDbNEQ(name, val) GXMISC::dbToString(name, val, GXMISC::DB_COND_TYPE_NEQ).c_str()
#define DDbLT(name, val) GXMISC::dbToString(name, val, GXMISC::DB_COND_TYPE_LT).c_str()
#define DDbLE(name, val) GXMISC::dbToString(name, val, GXMISC::DB_COND_TYPE_LE).c_str()
#define DDbGT(name, val) GXMISC::dbToString(name, val, GXMISC::DB_COND_TYPE_GT).c_str()
#define DDbGE(name, val) GXMISC::dbToString(name, val, GXMISC::DB_COND_TYPE_GE).c_str()

	// sql操作
#define MAX_SQL_LENGTH			4096								// 短Sql语句
#define MAX_LONG_SQL_LENGTH		204800								// 长Sql语句
#define MAX_CHECK_SQL_CONNECTTION_TIME	30000						// 30秒检查一次数据库连接

	typedef GXMISC::CCharArray<MAX_SQL_LENGTH> TDbSqlStr;
	typedef GXMISC::CCharArray<MAX_LONG_SQL_LENGTH> TDbLongSqlStr;

	template<typename T>
	class CDbSqlDef
	{
	protected:
		T sqlStr;	// 执行的Sql语句

	public:
		CDbSqlDef()
		{
			clear();
		}		

	public:
		void clear()
		{
			sqlStr.clear();
		}

		void parse(const char* pTemplate, ...)
		{
			va_list argptr;
			va_start(argptr, pTemplate);
			int nchars  = DVsnprintf( sqlStr.curData(), sqlStr.capacity(), pTemplate, argptr );
			va_end(argptr);

			if (nchars == -1 || nchars > (int)sqlStr.capacity() )
			{
				gxAssert(false);
				return;
			}

			sqlStr.resize(sqlStr.size()+nchars);
		}

		const char* data()
		{
			return sqlStr.data();
		}

		sint32 size()
		{
			return sqlStr.size();
		}
	};

	typedef CDbSqlDef<TDbSqlStr> TDBSql;
	typedef CDbSqlDef<TDbLongSqlStr> TLongDBSql;

	template<typename T1, typename T2=sint32, typename T3=sint32, typename T4=sint32, typename T5=sint32>
	class CSimpleQueryResult
	{
	public:
		CSimpleQueryResult(){
// 			value1 = (T1)0.0f;
// 			value2 = (T2)0.0f;
// 			value3 = (T3)0.0f;
// 			value4 = (T4)0.0f;
// 			value5 = (T5)0.0f;
		}
		~CSimpleQueryResult(){}

	public:
		bool succFlag;
		T1 value1;
		T2 value2;
		T3 value3;
		T4 value4;
		T5 value5;
	};
}

#endif