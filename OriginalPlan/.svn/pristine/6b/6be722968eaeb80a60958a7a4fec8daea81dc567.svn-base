#ifndef _DB_CONN_MANAGER_H_
#define _DB_CONN_MANAGER_H_

#include <string>

#include "time/interval_timer.h"
#include "mysql++.h"
#include "singleton.h"
#include "game_exception.h"
#include "db_util.h"
#include "db_filed_parse.h"
#include "debug.h"
#include "game_time.h"
#include "game_binary_string.h"

namespace GXMISC{

	class CSqlQueryBase
	{
	public:
		CSqlQueryBase(){ _openLog = false; }
		virtual ~CSqlQueryBase(){}

	public:
		virtual mysqlpp::Connection* getConnection() { return NULL; }

	public:
		inline bool executeUnret(const char* sql, sint32 len, mysqlpp::Connection* pConn = NULL);
		inline bool exist(const char* sql, sint32 len);
		template<typename T>
		CSimpleQueryResult<T> getMaxColValue(const std::string& tblName, const std::string& colName, mysqlpp::Connection* pConn = NULL)
		{
			GXMISC::TDBSql sqlStr;
			DB_BEGIN("DB_MOD;");

			sqlStr.parse("select MAX(%s) from %s;", colName.c_str(), tblName.c_str());
			return execute<T>(sqlStr.data(), sqlStr.size(), pConn);

			DB_END_RET_STR(CSimpleQueryResult<T>(), sqlStr.data());
		}

		// 执行
		template<typename T1, typename T2, typename T3, typename T4, typename T5>
		CSimpleQueryResult<T1,T2,T3,T4,T5> execute(const char* sql, sint32 len, mysqlpp::Connection* pConn = NULL)
		{
			CSimpleQueryResult<T1,T2,T3,T4,T5> result;
			DB_BEGIN("DB_MOD;");
			result.succFlag = false;
			if(NULL == pConn)
			{
				pConn = getConnection();
				if(NULL == pConn)
				{
					return result;
				}
			}
			mysqlpp::Query query = pConn->query();
			mysqlpp::StoreQueryResult res = query.store(sql, len);
			if(res)
			{
				for(mysqlpp::StoreQueryResult::iterator iter = res.begin(); iter != res.end(); ++iter)
				{
					mysqlpp::Row row = *iter;
					switch(row.size())
					{
					case 5:
						conv1<T5>(result.value5, row[4]);
					case 4:
						conv1<T4>(result.value4, row[3]);
					case 3:
						conv1<T3>(result.value3, row[2]);
					case 2:
						conv1<T2>(result.value2, row[1]);
					case 1:
						conv1<T1>(result.value1, row[0]);
					case 0:
					default:
						break;
					}
					result.succFlag = true;
					return result;
				}
			}

			return result;
			DB_END_RET_STR(result, sql);
		}

		template<typename T1, typename T2, typename T3, typename T4>
		CSimpleQueryResult<T1,T2,T3,T4> execute(const char* sql, sint32 len, mysqlpp::Connection* pConn = NULL)
		{
			return execute<T1,T2,T3,T4,sint32>(sql, len, pConn);
		}

		template<typename T1, typename T2, typename T3>
		CSimpleQueryResult<T1,T2,T3> execute(const char* sql, sint32 len, mysqlpp::Connection* pConn = NULL)
		{
			return execute<T1,T2,T3,sint32,sint32>(sql, len, pConn);
		}

		template<typename T1, typename T2>
		CSimpleQueryResult<T1,T2> execute(const char* sql, sint32 len, mysqlpp::Connection* pConn = NULL)
		{
			return execute<T1,T2,sint32,sint32,sint32>(sql, len, pConn);
		}

		template<typename T1>
		CSimpleQueryResult<T1> execute(const char* sql, sint32 len, mysqlpp::Connection* pConn = NULL)
		{
			return execute<T1,sint32,sint32,sint32,sint32>(sql, len, pConn);
		}

		// 执行select语句
		template<typename T1, typename T2, typename T3, typename T4, typename T5>
		CSimpleQueryResult<T1,T2,T3,T4,T5> execute(const std::string& tableName, const std::string& colName1, const std::string& colName2,
			const std::string& colName3, const std::string& colName4, const std::string& colName5, mysqlpp::Connection* pConn = NULL, const std::string& cond1 = "",
			const std::string& cond2 = "", const std::string& cond3 = "", const std::string& cond4 = "", const std::string& cond5 = "")
		{
			CSimpleQueryResult<T1,T2,T3,T4,T5> result;

			DB_BEGIN("DB_MOD;");
			result.succFlag = false;
			if(NULL == pConn)
			{
				pConn = getConnection();
				if(NULL == pConn)
				{
					return result;
				}
			}

			TDbColAry cols;
			cols.pushBack(_DBCOL_TYPE_OBJ_(colName1.c_str(), result.value1));
			cols.pushBack(_DBCOL_TYPE_OBJ_(colName2.c_str(), result.value2));
			cols.pushBack(_DBCOL_TYPE_OBJ_(colName3.c_str(), result.value3));
			cols.pushBack(_DBCOL_TYPE_OBJ_(colName4.c_str(), result.value4));
			cols.pushBack(_DBCOL_TYPE_OBJ_(colName5.c_str(), result.value5));

			TDbColAryVec colsVec;
			colsVec.push_back(cols);
			result.succFlag = selectEx(tableName.c_str(), colsVec, cond1.c_str(), cond2.c_str(), cond3.c_str(), cond4.c_str(), cond5.c_str()) > 0;

			return result;
			DB_END_RET_STR(result, tableName.c_str());
		}

		template<typename T1, typename T2, typename T3, typename T4>
		CSimpleQueryResult<T1,T2,T3,T4> execute(const std::string& tableName, const std::string& colName1, const std::string& colName2,
			const std::string& colName3, const std::string& colName4, mysqlpp::Connection* pConn = NULL, const std::string& cond1 = "",
			const std::string& cond2 = "", const std::string& cond3 = "", const std::string& cond4 = "", const std::string& cond5 = "")
		{
			CSimpleQueryResult<T1,T2,T3,T4> result;

			DB_BEGIN("DB_MOD;");
			result.succFlag = false;
			if(NULL == pConn)
			{
				pConn = getConnection();
				if(NULL == pConn)
				{
					return result;
				}
			}

			TDbColAry cols;
			cols.pushBack(_DBCOL_TYPE_OBJ_(colName1.c_str(), result.value1));
			cols.pushBack(_DBCOL_TYPE_OBJ_(colName2.c_str(), result.value2));
			cols.pushBack(_DBCOL_TYPE_OBJ_(colName3.c_str(), result.value3));
			cols.pushBack(_DBCOL_TYPE_OBJ_(colName4.c_str(), result.value4));

			TDbColAryVec colsVec;
			colsVec.push_back(cols);
			result.succFlag = selectEx(tableName.c_str(), colsVec, cond1.c_str(), cond2.c_str(), cond3.c_str(), cond4.c_str()) > 0;

			return result;
			DB_END_RET_STR(result, tableName.c_str());
		}

		template<typename T1, typename T2, typename T3>
		CSimpleQueryResult<T1,T2,T3> execute(const std::string& tableName, const std::string& colName1, const std::string& colName2,
			const std::string& colName3, mysqlpp::Connection* pConn = NULL, const std::string& cond1 = "",
			const std::string& cond2 = "", const std::string& cond3 = "", const std::string& cond4 = "", const std::string& cond5 = "")
		{
			CSimpleQueryResult<T1,T2,T3> result;

			DB_BEGIN("DB_MOD;");
			result.succFlag = false;
			if(NULL == pConn)
			{
				pConn = getConnection();
				if(NULL == pConn)
				{
					return result;
				}
			}

			TDbColAry cols;
			cols.pushBack(_DBCOL_TYPE_OBJ_(colName1.c_str(), result.value1));
			cols.pushBack(_DBCOL_TYPE_OBJ_(colName2.c_str(), result.value2));
			cols.pushBack(_DBCOL_TYPE_OBJ_(colName3.c_str(), result.value3));

			TDbColAryVec colsVec;
			colsVec.push_back(cols);
			result.succFlag = selectEx(tableName.c_str(), colsVec, cond1.c_str(), cond2.c_str(), cond3.c_str()) > 0;

			return result;
			DB_END_RET_STR(result, tableName.c_str());
		}

		template<typename T1, typename T2>
		CSimpleQueryResult<T1,T2> execute(const std::string& tableName, const std::string& colName1, const std::string& colName2,
			mysqlpp::Connection* pConn = NULL, const std::string& cond1 = "",
			const std::string& cond2 = "", const std::string& cond3 = "", const std::string& cond4 = "", const std::string& cond5 = "")
		{
			CSimpleQueryResult<T1,T2> result;

			DB_BEGIN("DB_MOD;");
			result.succFlag = false;
			if(NULL == pConn)
			{
				pConn = getConnection();
				if(NULL == pConn)
				{
					return result;
				}
			}

			TDbColAry cols;
			cols.pushBack(_DBCOL_TYPE_OBJ_(colName1.c_str(), result.value1));
			cols.pushBack(_DBCOL_TYPE_OBJ_(colName2.c_str(), result.value2));

			TDbColAryVec colsVec;
			colsVec.push_back(cols);

			result.succFlag = selectEx(tableName.c_str(), colsVec, cond1.c_str(), cond2.c_str()) > 0;

			return result;
			DB_END_RET_STR(result, tableName.c_str());
		}

		template<typename T1>
		CSimpleQueryResult<T1> execute(const std::string& tableName, const std::string& colName1,
			mysqlpp::Connection* pConn = NULL, const std::string& cond1 = "",
			const std::string& cond2 = "", const std::string& cond3 = "", const std::string& cond4 = "", const std::string& cond5 = "")
		{
			CSimpleQueryResult<T1> result;

			DB_BEGIN("DB_MOD;");
			result.succFlag = false;
			if(NULL == pConn)
			{
				pConn = getConnection();
				if(NULL == pConn)
				{
					return result;
				}
			}

			TDbColAry cols;
			cols.pushBack(_DBCOL_TYPE_OBJ_(colName1.c_str(), result.value1));

			TDbColAryVec colsVec;
			colsVec.push_back(cols);

			result.succFlag = selectEx(tableName.c_str(), colsVec, cond1.c_str()) > 0;

			return result;
			DB_END_RET_STR(result, tableName.c_str());
		}

		// 查询语句语法
		// SELECT    [ALL | DISTINCT | DISTINCTROW ]      [HIGH_PRIORITY]      [STRAIGHT_JOIN]      
		// [SQL_SMALL_RESULT] [SQL_BIG_RESULT] [SQL_BUFFER_RESULT]      [SQL_CACHE | SQL_NO_CACHE] [SQL_CALC_FOUND_ROWS]
		// select_expr, ...    [INTO OUTFILE 'file_name' export_options      | INTO DUMPFILE 'file_name']    [FROM table_references    
		// [WHERE where_definition]    [GROUP BY {col_name | expr | position}      [ASC | DESC], ... [WITH ROLLUP]]    
		// [HAVING where_definition]    [ORDER BY {col_name | expr | position}      [ASC | DESC] , ...]    
		// [LIMIT {[offset,] row_count | row_count OFFSET offset}]    [PROCEDURE procedure_name(argument_list)]    
		// [FOR UPDATE | LOCK IN SHARE MODE]]

		// 查询返回多条记录
		template<typename T>
		sint32 selectEx(const TDbCol *column, uint32 columnNum, const char* tableName, std::vector<T>& outRecords, bool asce = true, const char* colNames = "", sint32 limitNum = -1)
		{
			return selectEx(column, columnNum, tableName, outRecords, "", "", "", "", "", asce, colNames, limitNum);
		}

		template<typename T>
		sint32 selectEx(const TDbCol *column, uint32 columnNum, const char* tableName, std::vector<T>& outRecords, const char* cond1,
			bool asce = true, const char* colNames = "", sint32 limitNum = -1)
		{
			return selectEx(column, columnNum, tableName, outRecords, cond1, "", "", "", "", asce, colNames, limitNum);
		}

		template<typename T>
		sint32 selectEx(const TDbCol *column, uint32 columnNum, const char* tableName, std::vector<T>& outRecords, const char* cond1, const char* cond2,
			bool asce = true, const char* colNames = "", sint32 limitNum = -1)
		{
			return selectEx(column, columnNum, tableName, outRecords, cond1, cond2, "", "", "", asce, colNames, limitNum);
		}

		template<typename T>
		sint32 selectEx(const TDbCol *column, uint32 columnNum, const char* tableName, std::vector<T>& outRecords, const char* cond1,
			const char* cond2, const char* cond3, bool asce = true, const char* colNames = "", sint32 limitNum = -1)
		{
			return selectEx(column, columnNum, tableName, outRecords, cond1, cond2, cond3, "", "", asce, colNames, limitNum);
		}

		template<typename T>
		sint32 selectEx(const TDbCol *column, uint32 columnNum, const char* tableName, std::vector<T>& outRecords, const char* cond1,
			const char* cond2, const char* cond3, const char* cond4, bool asce = true, const char* colNames = "", sint32 limitNum = -1)
		{
			return selectEx(column, columnNum, tableName, outRecords, cond1, cond2, cond3, cond4, "", asce, colNames, limitNum);
		}

		template<typename T>
		sint32 selectEx(const TDbCol *column, uint32 columnNum, const char* tableName, std::vector<T>& outRecords, const char* cond1,
			const char* cond2, const char* cond3, const char* cond4, const char* cond5, bool asce = true, const char* colNames = "", sint32 limitNum = -1)
		{
			DB_BEGIN("DB_MOD;");
			std::string sqlStr = concatSql(column, columnNum, tableName,cond1,cond2,cond3,cond4,cond5,asce, colNames,limitNum);
			if(_openLog)
			{
				gxDebug("sqlStr={0}", sqlStr);
			}
			mysqlpp::Query query = getConnection()->query();
			mysqlpp::StoreQueryResult res = query.store(sqlStr.c_str(), sqlStr.size());
			if(res)
			{
				if(!res.empty()){
					outRecords.resize(res.size());
					return parseRecordData(res, column, columnNum, (unsigned char*)(&outRecords[0]), (sint32)(outRecords.size()*sizeof(T)));
				}

				return 0;
			}

			return -1;
			DB_END_RET(-1);
		}

		template<typename T>
		sint32 selectEx(const char* tableName, std::vector<T>& outRecords,
			bool asce = true, const char* colNames = "", sint32 limitNum = -1)
		{
			return selectEx((const TDbCol *)T::DbCols, DCountOf(T::DbCols), tableName, outRecords, asce, colNames, limitNum);
		}
		template<typename T>
		sint32 selectEx(const char* tableName, std::vector<T>& outRecords, const char* cond1, bool asce = true, const char* colNames = "", sint32 limitNum = -1)
		{
			return selectEx((const TDbCol *)T::DbCols, DCountOf(T::DbCols), tableName, outRecords, cond1, asce, colNames, limitNum);
		}
		template<typename T>
		sint32 selectEx(const char* tableName, std::vector<T>& outRecords, const char* cond1,
			const char* cond2, bool asce = true, const char* colNames = "", sint32 limitNum = -1)
		{
			return selectEx((const TDbCol *)T::DbCols, DCountOf(T::DbCols), tableName, outRecords, cond1, cond2, asce, colNames, limitNum);
		}
		template<typename T>
		sint32 selectEx(const char* tableName, std::vector<T>& outRecords, const char* cond1,
			const char* cond2, const char* cond3, bool asce = true, const char* colNames = "", sint32 limitNum = -1)
		{
			return selectEx((const TDbCol *)T::DbCols, DCountOf(T::DbCols), tableName, outRecords, cond1, cond2, cond3, asce, colNames, limitNum);
		}
		template<typename T>
		sint32 selectEx(const char* tableName, std::vector<T>& outRecords, const char* cond1,
			const char* cond2, const char* cond3, const char* cond4, bool asce = true, const char* colNames = "", sint32 limitNum = -1)
		{
			return selectEx((const TDbCol *)T::DbCols, DCountOf(T::DbCols), tableName, outRecords, cond1, cond2, cond3, cond4, asce, colNames, limitNum);
		}
		template<typename T>
		sint32 selectEx(const char* tableName, std::vector<T>& outRecords, const char* cond1,
			const char* cond2, const char* cond3, const char* cond4, const char* cond5, bool asce = true, const char* colNames = "", sint32 limitNum = -1)
		{
			return selectEx((const TDbCol *)T::DbCols, DCountOf(T::DbCols), tableName, outRecords, cond1, cond2, cond3, cond4, cond5, asce, colNames, limitNum);
		}

		// 查询返回多条记录
		inline sint32 selectEx(const TDbCol *column, uint32 columnNum, const char* tableName, uint8* data,
			sint32 maxDataLen, bool asce = true, const char* colNames = "", sint32 limitNum = -1);
		inline sint32 selectEx(const TDbCol *column, uint32 columnNum, const char* tableName, const char* cond1, uint8* data,
			sint32 maxDataLen, bool asce = true, const char* colNames = "", sint32 limitNum = -1);
		inline sint32 selectEx(const TDbCol *column, uint32 columnNum, const char* tableName, const char* cond1,
			const char* cond2, uint8* data,
			sint32 maxDataLen, bool asce = true, const char* colNames = "", sint32 limitNum = -1);
		inline sint32 selectEx(const TDbCol *column, uint32 columnNum, const char* tableName, const char* cond1,
			const char* cond2, const char* cond3, uint8* data,
			sint32 maxDataLen, bool asce = true, const char* colNames = "", sint32 limitNum = -1);
		inline sint32 selectEx(const TDbCol *column, uint32 columnNum, const char* tableName, const char* cond1,
			const char* cond2, const char* cond3, const char* cond4, uint8* data,
			sint32 maxDataLen, bool asce = true, const char* colNames = "", sint32 limitNum = -1);
		inline sint32 selectEx(const TDbCol *column, uint32 columnNum, const char* tableName, const char* cond1,
			const char* cond2, const char* cond3, const char* cond4, const char* cond5, uint8* data,
			sint32 maxDataLen, bool asce = true, const char* colNames = "", sint32 limitNum = -1);
		template<typename T>
		sint32 selectEx(const char* tableName, T& data, bool asce = true, const char* colNames = "", sint32 limitNum = -1)
		{
			return selectEx((const TDbCol *)T::DbCols, (uint32)(DCountOf(T::DbCols)), tableName, (uint8*)&data, ((sint32)sizeof(data)), asce, colNames, limitNum);
		}
		template<typename T>
		sint32 selectEx(const char* tableName, T& data, const char* cond1, bool asce = true, const char* colNames = "", sint32 limitNum = -1)
		{
			return selectEx((const TDbCol *)T::DbCols, (uint32)(DCountOf(T::DbCols)), tableName,
				cond1, (uint8*)&data, sizeof(data), asce, colNames, limitNum);
		}
		template<typename T>
		sint32 selectEx(const char* tableName, T& data, const char* cond1,
			const char* cond2, bool asce = true, const char* colNames = "", sint32 limitNum = -1)
		{
			return selectEx((const TDbCol *)T::DbCols, (uint32)(DCountOf(T::DbCols)), tableName,
				cond1, cond2, (uint8*)&data, sizeof(data), asce, colNames, limitNum);
		}
		template<typename T>
		sint32 selectEx(const char* tableName, T& data, const char* cond1,
			const char* cond2, const char* cond3, bool asce = true, const char* colNames = "", sint32 limitNum = -1)
		{
			return selectEx((const TDbCol *)T::DbCols, (uint32)(DCountOf(T::DbCols)), tableName,
				cond1, cond2, cond3, (uint8*)&data, sizeof(data), asce, colNames, limitNum);
		}
		template<typename T>
		sint32 selectEx(const char* tableName, T& data, const char* cond1,
			const char* cond2, const char* cond3, const char* cond4, bool asce = true, const char* colNames = "", sint32 limitNum = -1)
		{
			return selectEx((const TDbCol *)T::DbCols, (uint32)(DCountOf(T::DbCols)), tableName,
				cond1, cond2, cond3, cond4, (uint8*)&data, sizeof(data), asce, colNames, limitNum);
		}
		template<typename T>
		sint32 selectEx(const char* tableName, T& data, const char* cond1,
			const char* cond2, const char* cond3, const char* cond4, const char* cond5,
			bool asce = true, const char* colNames = "", sint32 limitNum = -1)
		{
			return selectEx((const TDbCol *)T::DbCols, (uint32)(DCountOf(T::DbCols)), tableName,
				cond1, cond2, cond3, cond4, cond5, (uint8*)&data, sizeof(data), asce, colNames, limitNum);
		}

		// 查询单条记录返回值直接转换到指定地址
		inline sint32 selectEx(const TDbCol *column, int columnNum, const char* tableName, bool asce = true, const char* colNames = "", sint32 limitNum = -1);
		inline sint32 selectEx(const TDbCol *column, int columnNum, const char* tableName, const char* cond1, bool asce = true, const char* colNames = "", sint32 limitNum = -1);
		inline sint32 selectEx(const TDbCol *column, int columnNum, const char* tableName, const char* cond1,
			const char* cond2, bool asce = true, const char* colNames = "", sint32 limitNum = -1);
		inline sint32 selectEx(const TDbCol *column, int columnNum, const char* tableName, const char* cond1,
			const char* cond2, const char* cond3, bool asce = true, const char* colNames = "", sint32 limitNum = -1);
		inline sint32 selectEx(const TDbCol *column, int columnNum, const char* tableName, const char* cond1,
			const char* cond2, const char* cond3, const char* cond4, bool asce = true, const char* colNames = "", sint32 limitNum = -1);
		inline sint32 selectEx(const TDbCol *column, int columnNum, const char* tableName, const char* cond1,
			const char* cond2, const char* cond3, const char* cond4, const char* cond5, bool asce = true, const char* colNames = "", sint32 limitNum = -1);

		template<typename T>
		sint32 selectEx(const char* tableName, bool asce = true, const char* colNames = "", sint32 limitNum = -1)
		{
			return selectEx((const TDbCol *)T::DbCols, (uint32)(DCountOf(T::DbCols)), tableName, asce, colNames, limitNum);
		}
		template<typename T>
		sint32 selectEx(const char* tableName, const char* cond1, bool asce = true, const char* colNames = "", sint32 limitNum = -1)
		{
			return selectEx((const TDbCol *)T::DbCols, (uint32)(DCountOf(T::DbCols)), tableName,
				cond1, asce, colNames, limitNum);
		}
		template<typename T>
		sint32 selectEx(const char* tableName, const char* cond1,
			const char* cond2, bool asce = true, const char* colNames = "", sint32 limitNum = -1)
		{
			return selectEx((const TDbCol *)T::DbCols, (uint32)(DCountOf(T::DbCols)),
				cond1, cond2, asce, colNames, limitNum);
		}
		template<typename T>
		sint32 selectEx(const char* tableName, const char* cond1,
			const char* cond2, const char* cond3, bool asce = true, const char* colNames = "", sint32 limitNum = -1)
		{
			return selectEx((const TDbCol *)T::DbCols, (uint32)(DCountOf(T::DbCols)), tableName,
				cond1, cond2, cond3, asce, colNames, limitNum);
		}
		template<typename T>
		sint32 selectEx(const char* tableName, const char* cond1,
			const char* cond2, const char* cond3, const char* cond4, bool asce = true, const char* colNames = "", sint32 limitNum = -1)
		{
			return selectEx((const TDbCol *)T::DbCols, (uint32)(DCountOf(T::DbCols)), tableName,
				cond1, cond2, cond3, cond4, asce, colNames, limitNum);
		}
		template<typename T>
		sint32 selectEx(const char* tableName, const char* cond1,
			const char* cond2, const char* cond3, const char* cond4, const char* cond5,
			bool asce = true, const char* colNames = "", sint32 limitNum = -1)
		{
			return selectEx((const TDbCol *)T::DbCols, (uint32)(DCountOf(T::DbCols)), tableName,
				cond1, cond2, cond3, cond4, cond5, asce, colNames, limitNum);
		}

		// 查询多条记录返回值直接转换到指定地址
		inline sint32 selectEx(const char* tableName, TDbColAryVec& dbCols, bool asce = true, const char* colNames = "", sint32 limitNum = -1);
		inline sint32 selectEx(const char* tableName, TDbColAryVec& dbCols, const char* cond1, bool asce = true, const char* colNames = "", sint32 limitNum = -1);
		inline sint32 selectEx(const char* tableName, TDbColAryVec& dbCols, const char* cond1,
			const char* cond2, bool asce = true, const char* colNames = "", sint32 limitNum = -1);
		inline sint32 selectEx(const char* tableName, TDbColAryVec& dbCols, const char* cond1,
			const char* cond2, const char* cond3, bool asce = true, const char* colNames = "", sint32 limitNum = -1);
		inline sint32 selectEx(const char* tableName, TDbColAryVec& dbCols, const char* cond1,
			const char* cond2, const char* cond3, const char* cond4, bool asce = true, const char* colNames = "", sint32 limitNum = -1);
		inline sint32 selectEx(const char* tableName, TDbColAryVec& dbCols, const char* cond1,
			const char* cond2, const char* cond3, const char* cond4, const char* cond5,
			bool asce = true, const char* colNames = "", sint32 limitNum = -1);

		// 通过SQL语句查询返回多条记录
		// 查询返回多条记录
		inline sint32 selectExSql(const char *sql, const TDbCol *column, uint32 columnNum, unsigned char*& data, sint32 maxDataLen);
		// 查询单条记录返回值直接转换到指定地址
		inline sint32 selectExSql(const char *sql, const TDbCol *column, uint32 columnNum);
		template<typename T>
		sint32 selectExSql(const char *sql, const TDbCol *column, int columnNum, std::vector<T>& outRecords)
		{
			sint32 sqlLen = (sint32)strlen(sql);
			mysqlpp::Query query = getConnection()->query();
			mysqlpp::StoreQueryResult res = query.store(sql, sqlLen);
			if(res)
			{
				if(!res.empty()){
					outRecords.resize(res.size());
					return parseRecordData(res, column, columnNum, (unsigned char*)(&outRecords[0]), (sint32)(outRecords.size()*sizeof(T)));
				}

				return 0;
			}

			return -1;
		}
		template<typename T>
		sint32 selectExSql(const char *sql, std::vector<T>& outRecords)
		{
			return selectExSql(sql, (const TDbCol *)T::DbCols, DCountOf(T::DbCols), outRecords);
		}
		template<typename T>
		sint32 selectExSql(const char *sql, T& data)
		{
			unsigned char* buff = (unsigned char*)&data;
			return selectExSql(sql, (const TDbCol *)T::DbCols, (uint32)DCountOf(T::DbCols), buff, (sint32)sizeof(data));
		}

		// 插入语句语法
		// INSERT [LOW_PRIORITY | DELAYED | HIGH_PRIORITY] [IGNORE]    [INTO] tbl_name [(col_name,...)]
		// VALUES ({expr | DEFAULT},...),(...),...    [ ON DUPLICATE KEY UPDATE col_name=expr, ... ]
		inline virtual sint32 insertEx(const char* tableName, const TDbCol *column, sint32 columnNum,
			const unsigned char *data, sint32 maxDataLen, bool duplicateKey = true);
		inline virtual sint32 insertEx(const char* tableName, const GXMISC::TDbCol *column, sint32 columnNum, bool duplicateKey = true);
		inline virtual sint32 insertEx(const char* tableName, const TDbColAryVec& dbCols, bool duplicateKey = true);
		template<typename T>
		sint32 insertEx(const char* tableName, const TDbCol *column, sint32 columnNum, const T& data, bool duplicateKey = true){
			return insertEx(tableName, column, columnNum, (unsigned char*)&data, (sint32)(sizeof(data)), duplicateKey);
		}
		template<typename T>
		sint32 insertEx(const char* tableName, const T& data, bool duplicateKey = true){
			return insertEx(tableName, (const TDbCol *)T::DbCols, DCountOf(T::DbCols), (unsigned char*)&data, (sint32)(sizeof(data)), duplicateKey);
		}
		template<typename T>
		sint32 insertEx(const char* tableName, const std::vector<T>& data, bool duplicateKey = true){
			return insertEx(tableName, (const TDbCol *)T::DbCols, DCountOf(T::DbCols), (unsigned char*)&data[0], (sint32)(data.size()*sizeof(T)), duplicateKey);
		}

		// 删除语句语法
		// DELETE [LOW_PRIORITY] [QUICK] [IGNORE] FROM tbl_name
		// [WHERE where_definition]    [ORDER BY ...]    [LIMIT row_count]
		// @todo 暂时没有实现[ORDER BY ...]    [LIMIT row_count]及多表的特性
		inline virtual sint32 deleteEx(const char* tableName, const char* cond1 = "", const char* cond2 = "", const char* cond3 = "",
			const char* cond4 = "", const char* cond5 = "");

		// 更新语句语法
		// UPDATE [LOW_PRIORITY] [IGNORE] tbl_name    SET col_name1=expr1 [, col_name2=expr2 ...]
		// [WHERE where_definition]    [ORDER BY ...]    [LIMIT row_count]
		// @todo 暂时没有实现[ORDER BY ...]    [LIMIT row_count]及多表的特性
		inline virtual sint32 updateEx(const char* tableName, const TDbCol *column, sint32 columnNum, unsigned char *data, sint32 maxDataLen,
			const char* cond1="", const char* cond2 = "", const char* cond3 = "", const char* cond4 = "", const char* cond5 = "");
		inline virtual sint32 updateEx(const char* tableName, const TDbCol *column, sint32 columnNum,
			const char* cond1="", const char* cond2 = "", const char* cond3 = "", const char* cond4 = "", const char* cond5 = "");
		template<typename T>
		sint32 updateEx(const char* tableName, const TDbCol *column, sint32 columnNum, const T& data,
			const char* cond1="", const char* cond2 = "", const char* cond3 = "", const char* cond4 = "", const char* cond5 = "")
		{
			return updateEx(tableName, column, columnNum, (unsigned char*)&data, sizeof(data), cond1, cond2, cond3, cond4, cond5);
		}
		template<typename T>
		sint32 updateEx(const char* tableName, const T& data,
			const char* cond1="", const char* cond2 = "", const char* cond3 = "", const char* cond4 = "", const char* cond5 = "")
		{
			return updateEx(tableName, (const TDbCol *)T::DbCols, DCountOf(T::DbCols), (unsigned char*)&data, sizeof(data),
				cond1, cond2, cond3, cond4, cond5);
		}
		template<typename T>
		sint32 updateEx(const char* tableName,const char* cond1="", const char* cond2 = "", const char* cond3 = "",
			const char* cond4 = "", const char* cond5 = "")
		{
			return updateEx(tableName, (const TDbCol *)T::DbCols, DCountOf(T::DbCols), cond1, cond2, cond3, cond4, cond5);
		}

		inline sint32 updateEx(const char* tableName, TDbColAryVec& dbCols);
		inline sint32 updateEx(const char* tableName, TDbColAryVec& dbCols, const char* cond1);
		inline sint32 updateEx(const char* tableName, TDbColAryVec& dbCols, const char* cond1,
			const char* cond2);
		inline sint32 updateEx(const char* tableName, TDbColAryVec& dbCols, const char* cond1,
			const char* cond2, const char* cond3);
		inline sint32 updateEx(const char* tableName, TDbColAryVec& dbCols, const char* cond1,
			const char* cond2, const char* cond3, const char* cond4);
		inline sint32 updateEx(const char* tableName, TDbColAryVec& dbCols, const char* cond1,
			const char* cond2, const char* cond3, const char* cond4, const char* cond5);

	public:
		// 连接字符串
		inline const std::string concatSql(const TDbCol *column, uint32 columnNum, const char* tableName, bool asce = true, const char* colNames = "", sint32 limitNum = -1);
		inline const std::string concatSql(const TDbCol *column, uint32 columnNum, const char* tableName, const char* cond1, bool asce = true
			, const char* colNames = "", sint32 limitNum = -1);
		inline const std::string concatSql(const TDbCol *column, uint32 columnNum, const char* tableName, const char* cond1, const char* cond2,
			bool asce = true, const char* colNames = "", sint32 limitNum = -1);
		inline const std::string concatSql(const TDbCol *column, uint32 columnNum, const char* tableName, const char* cond1,
			const char* cond2, const char* cond3,
			bool asce = true, const char* colNames = "", sint32 limitNum = -1);
		inline const std::string concatSql(const TDbCol *column, uint32 columnNum, const char* tableName, const char* cond1,
			const char* cond2, const char* cond3, const char* cond4,
			bool asce = true, const char* colNames = "", sint32 limitNum = -1);
		inline const std::string concatSql(const TDbCol *column, uint32 columnNum, const char* tableName, const char* cond1,
			const char* cond2, const char* cond3, const char* cond4, const char* cond5,
			bool asce = true, const char* colNames = "", sint32 limitNum = -1);
		// 解析记录到用户数据
		inline virtual sint32 parseRecordData(mysqlpp::StoreQueryResult res, const TDbCol *column, uint32 columnNum);
		inline virtual sint32 parseRecordData(mysqlpp::Row& res, const TDbCol *column, uint32 columnNum);
		inline virtual sint32 parseRecordData(mysqlpp::StoreQueryResult res, const TDbCol *column, uint32 columnNum, unsigned char* data, sint32 maxDataLen);
		// 表返回字段数据转换到用户数据
		inline sint32 dbFiledConvToData(const TDbCol *column, const mysqlpp::String& row, unsigned char* data, sint32 curPos, sint32 maxDataLen);
		// 用户数据转换到表字段数据
		inline sint32 dataConvToDbFiled(std::ostringstream& outSql, const TDbCol *column, unsigned char* data, sint32 curPos, sint32 maxDataLen, char appChar = '\'');
		// 将数据连接成指定格式的Sql语句 name1=xxx,name2=xxx,...|xxx,xxx,xxx
		inline sint32 concatDataToSqlStr(std::ostringstream& sqlStr, const TDbCol *column, sint32 columnNum, bool needName = true, bool needKey = true);
		// 将用户数据绑定到表字段定义结构中
		inline sint32 bindDataToDbFiled(const TDbCol *column, sint32 columnNum, void* data, sint32 maxDataLen);
		// 将数据库的text转换成结构体
		inline bool dbStringToStruct( TDBBuffer& outBuffer, const char* pBStr, sint32 size, GXMISC::TDBVersion_t& dbVersion );
		// 将数据库的text转换成结构体
		inline bool structToDbString( TDBBuffer& data, uint8* buffer, sint32 size, GXMISC::TDBVersion_t dbVersion );

	public:
		inline sint32 getCount(const char* tableName, const char* cond1 = "", const char* cond2 = "", const char* cond3 = "",
			const char* cond4 = "", const char* cond5 = "");
		// @todo 未实现
		inline uint64 getInsertID();

	public:
		// 得到列结构的大小
		inline static uint32 GetColSize(const TDbCol* column, unsigned char* data = NULL);
		// 得到列结构的信息
		inline static uint32 GetColInfo(const TDbCol* column, unsigned char* data = NULL);
		// 得到数据库类型对应的字符串
		inline static const char *GetTypeString(uint32 type);
		// 打印列结构
		inline static void DumpCol(const TDbCol *column, sint32 columnNum = -1);
		// 绑定数据到列结构数据指针
		inline static sint32 BindDataToDbFiled(const TDbCol *column, sint32 columnNum, void* inputData, sint32 maxDataLen);
		inline static sint32 BindDataToDbFiled(TDbColVecs& columns, const TDbCol *column, sint32 columnNum, void* inputData, sint32 maxDataLen);
		// 设置所有的列表为使用标记
		//static void SetAllUseFlag(const TDbCol *column, sint32 columnNum);
		// 清除列结构的数据指针
		inline static void ClearColsDataPtr(TDbCol *column, sint32 columnNum)
		{
			if(column[columnNum-1].name == NULL)
			{
				columnNum--;
			}
			for(sint32 i = 0; i < columnNum; ++i)
			{
				column[i].data_addr = NULL;
			}
		}
		// 绑定列结构的数据指针
		template<typename T>
		static bool BuildBindCols(TDbCol *column, sint32 columnNum, T& data1)
		{
			if(column[columnNum-1].name == NULL && columnNum > 1)
			{
				columnNum--;
			}
			gxAssert(columnNum == 1 && column->name != NULL);
			column[columnNum-1].data_addr = (uint8*)&data1;
			return true;
		}
		template<typename T, typename T2>
		static bool BuildBindCols(TDbCol *column, sint32 columnNum, T& data1, T2& data2)
		{
			if(column[columnNum-1].name == NULL)
			{
				columnNum--;
			}
			gxAssert(columnNum == 2 && column->name != NULL);
			BuildBindCols(column, columnNum-1, data1);
			column[columnNum-1].data_addr = (uint8*)&data2;
			return true;
		}
		template<typename T, typename T2, typename T3>
		static bool BuildBindCols(TDbCol *column, sint32 columnNum, T& data1, T2& data2, T3& data3)
		{
			if(column[columnNum-1].name == NULL)
			{
				columnNum--;
			}
			gxAssert(columnNum == 3 && column->name != NULL);
			BuildBindCols(column, columnNum-1, data1, data2);
			column[columnNum-1].data_addr = (uint8*)&data3;
			return true;
		}
		template<typename T, typename T2, typename T3, typename T4>
		static bool BuildBindCols(TDbCol *column, sint32 columnNum, T& data1, T2& data2, T3& data3, T4& data4)
		{
			if(column[columnNum-1].name == NULL)
			{
				columnNum--;
			}
			gxAssert(columnNum == 4 && column->name != NULL);
			BuildBindCols(column, columnNum-1, data1, data2, data3);
			column[columnNum-1].data_addr = (uint8*)&data4;
			return true;
		}
		template<typename T, typename T2, typename T3, typename T4, typename T5>
		static bool BuildBindCols(TDbCol *column, sint32 columnNum, T& data1, T2& data2, T3& data3, T4& data4, T5& data5)
		{
			if(column[columnNum-1].name == NULL)
			{
				columnNum--;
			}
			gxAssert(columnNum == 5 && column->name != NULL);
			BuildBindCols(column, columnNum-1, data1, data2, data3, data4);
			column[columnNum-1].data_addr = (uint8*)&data5;
			return true;
		}
		template<typename T, typename T2, typename T3, typename T4, typename T5, typename T6>
		static bool BuildBindCols(TDbCol *column, sint32 columnNum, T& data1, T2& data2, T3& data3, T4& data4, T5& data5, T6& data6)
		{
			if(column[columnNum-1].name == NULL)
			{
				columnNum--;
			}
			gxAssert(columnNum == 6 && column->name != NULL);
			BuildBindCols(column, columnNum-1, data1, data2, data3, data4, data5);
			column[columnNum-1].data_addr = (uint8*)&data6;
			return true;
		}
		template<typename T, typename T2, typename T3, typename T4, typename T5, typename T6, typename T7>
		static bool BuildBindCols(TDbCol *column, sint32 columnNum, T& data1, T2& data2, T3& data3, T4& data4, T5& data5, T6& data6, T7& data7)
		{
			if(column[columnNum-1].name == NULL)
			{
				columnNum--;
			}
			gxAssert(columnNum == 7 && column->name != NULL);
			BuildBindCols(column, columnNum-1, data1, data2, data3, data4, data5, data6);
			column[columnNum-1].data_addr = (uint8*)&data7;
			return true;
		}
		template<typename T, typename T2, typename T3, typename T4, typename T5, typename T6, typename T7, typename T8>
		static bool BuildBindCols(TDbCol *column, sint32 columnNum, T& data1, T2& data2, T3& data3, T4& data4, T5& data5, T6& data6, T7& data7, T8& data8)
		{
			if(column[columnNum-1].name == NULL)
			{
				columnNum--;
			}
			gxAssert(columnNum == 8 && column->name != NULL);
			BuildBindCols(column, columnNum-1, data1, data2, data3, data4, data5, data6, data7);
			column[columnNum-1].data_addr = (uint8*)&data8;
			return true;
		}
		template<typename T, typename T2, typename T3, typename T4, typename T5, typename T6, typename T7, typename T8, typename T9>
		static bool BuildBindCols(TDbCol *column, sint32 columnNum, T& data1, T2& data2, T3& data3, T4& data4,
			T5& data5, T6& data6, T7& data7, T8& data8, T9& data9)
		{
			if(column[columnNum-1].name == NULL)
			{
				columnNum--;
			}
			gxAssert(columnNum == 9 && column->name != NULL);
			BuildBindCols(column, columnNum-1, data1, data2, data3, data4, data5, data6, data7, data8);
			column[columnNum-1].data_addr = (uint8*)&data9;
			return true;
		}
		template<typename T, typename T2, typename T3, typename T4, typename T5, typename T6, typename T7, typename T8, typename T9, typename T10>
		static bool BuildBindCols(TDbCol *column, sint32 columnNum, T& data1, T2& data2, T3& data3, T4& data4,
			T5& data5, T6& data6, T7& data7, T8& data8, T9& data9, T10& data10)
		{
			if(column[columnNum-1].name == NULL)
			{
				columnNum--;
			}
			gxAssert(columnNum == 10 && column->name != NULL);
			BuildBindCols(column, columnNum-1, data1, data2, data3, data4, data5, data6, data7, data8, data9);
			column[columnNum-1].data_addr = (uint8*)&data10;
			return true;
		}

		inline static bool CloneDbCols(TDbColFixAry& ary, const TDbCol *column, sint32 columnNum, bool memFlag);

		inline void setLog(bool flag)
		{
			_openLog = flag;
		}
		inline void logSql();
	private:
		bool _openLog;
		std::string _sqlString;
	};

	// 简单sql查询类
	class CSimpleSqlQuery : public CSqlQueryBase
	{
	public:
		CSimpleSqlQuery(mysqlpp::Connection* conn) : CSqlQueryBase(){
			_conn = conn;
		}
		~CSimpleSqlQuery(){
			_conn = NULL;
		}

	public:
		virtual mysqlpp::Connection* getConnection() 
		{
			return _conn;
		}

	private:
		mysqlpp::Connection* _conn;
	};

	template<typename T>
	class CDbConnectionManager :
		public CSqlQueryBase,
		public GXMISC::CManualSingleton<T>
	{
	public:
		CDbConnectionManager()
		{
		}
		~CDbConnectionManager()
		{
			if(_conn.connected())
			{
				_conn.disconnect();
			}
		}

	public:
		virtual mysqlpp::Connection* getConnection()
		{
			return &_conn;
		}

	public:
		bool init(sint32 checkTimeDiff = MAX_CHECK_SQL_CONNECTTION_TIME)
		{
			_updateTimer.init(checkTimeDiff);
			return true;
		}

		void	update( uint32 diff )
		{
			_updateTimer.update(diff);
			if ( _updateTimer.isPassed() )
			{
				_updateTimer.reset();
				checkConn();
			}
		}

		bool start( const char* db, const char* server, const char* user, const char* pwd, unsigned int port )
		{
			DB_BEGIN("DB_MOD;");

			onBeforeConn();
			if ( !_conn.connect(db, server, user, pwd, port) )
			{
				gxError("Can't connect database!");
				return false;
			}
			onAfterConn();

			gxInfo("Connect database success!");

			this->db = db;
			this->server = server;
			this->user = user;
			this->pwd = pwd;
			this->port = port;

			return true;

			DB_END_RET(false);
		}

	private:
		void	onBeforeConn()
		{
			mysqlpp::Option* pOption = new mysqlpp::ReconnectOption(true);
			getConnection()->set_option(pOption);
			pOption = new mysqlpp::CompressOption();
			getConnection()->set_option(pOption);
			pOption = new mysqlpp::MultiStatementsOption(true);
			getConnection()->set_option(pOption);
		}

		void	onAfterConn()
		{
			mysqlpp::Query query = getConnection()->query("SET CHARACTER_SET_CONNECTION=utf8,character_set_results=utf8,character_set_client=BINARY,SQL_MODE='';");
			query.execute();
			query.clear();
			query = getConnection()->query("set interactive_timeout=8640000");
			query.execute();
			query.clear();
			/*
			query = getConnection()->query("set global max_allowed_packet=50*1024*1024");
			query.execute();
			query.clear();
			query = getConnection()->query("set global wait_timeout=8640000");
			query.execute();
			query.clear();
			*/
		}

		void checkConn()
		{
			try
			{
				if ( _conn.ping() )
				{
					return ;
				}

				gxError("Data base disconnected!");
				_conn.disconnect();
				onBeforeConn();
				for ( uint8 i=0; i < 10; ++i )
				{
					if ( _conn.connect(db.c_str(), server.c_str(), user.c_str(), pwd.c_str(), port) )
					{
						onAfterConn();
						return ;
					}
				}
			}
			catch( ... )
			{	
			}

			connFailed();
		}

		void connFailed()		// 重连失败处理
		{
			gxError("Database is disconnected!!!");
			gxAssert(false);
		}

	private:
		mysqlpp::Connection				_conn;
		GXMISC::CManualIntervalTimer	_updateTimer;

		std::string db;
		std::string server;
		std::string user;
		std::string pwd;
		sint32 port;
	};

#include "db_single_conn_manager.inl"
}

#endif // _DB_CONN_MANAGER_H_