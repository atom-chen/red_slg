
//namespace GXMISC{
	bool CSqlQueryBase::executeUnret(const char* sql, sint32 len, mysqlpp::Connection* pConn)
	{
		DB_BEGIN("DB_MOD;");
		if(NULL == pConn)
		{
			pConn = getConnection();
			if(NULL == pConn)
			{
				return false;
			}
		}
		mysqlpp::Query query = pConn->query(sql);
		mysqlpp::SimpleResult res = query.execute();;//query.execute(sql, len);
		if(res)
		{
			return true;
		}
		else
		{
			gxError("Sql error: ErrNum={0},ErrStr={1},sql={2}", query.errnum(), query.error(), sql);
		}
		return false;
		DB_END_RET_STR(false, sql);
	}

	bool CSqlQueryBase::exist(const char* sql, sint32 len)
	{
		DB_BEGIN("DB_MOD;");
		mysqlpp::Query query = getConnection()->query();
		mysqlpp::StoreQueryResult res = query.store(sql);
		return res.num_rows() > 0;
		DB_END_RET_STR(false, sql);
	}

	const std::string CSqlQueryBase::concatSql(const TDbCol *column, uint32 columnNum, const char* tableName, bool asce, const char* colNames, sint32 limitNum){
		return concatSql(column, columnNum, tableName, "", "", "", "", "", asce,colNames, limitNum);
	}
	const std::string CSqlQueryBase::concatSql(const TDbCol *column, uint32 columnNum, const char* tableName, const char* cond1,
		bool asce, const char* colNames, sint32 limitNum){
			return concatSql(column, columnNum, tableName, cond1, "", "", "", "", asce,colNames, limitNum);
	}
	const std::string CSqlQueryBase::concatSql(const TDbCol *column, uint32 columnNum, const char* tableName, const char* cond1, const char* cond2,
		bool asce, const char* colNames, sint32 limitNum){
			return concatSql(column, columnNum, tableName, cond1, cond2, "", "", "", asce,colNames, limitNum);
	}
	const std::string CSqlQueryBase::concatSql(const TDbCol *column, uint32 columnNum, const char* tableName, const char* cond1,
		const char* cond2, const char* cond3,bool asce, const char* colNames, sint32 limitNum){
			return concatSql(column, columnNum, tableName, cond1, cond2, cond3, "", "", asce,colNames, limitNum);
	}
	const std::string CSqlQueryBase::concatSql(const TDbCol *column, uint32 columnNum, const char* tableName, const char* cond1,
		const char* cond2, const char* cond3, const char* cond4,bool asce, const char* colNames, sint32 limitNum){
			return concatSql(column, columnNum, tableName, cond1, cond2, cond3, cond4, "", asce,colNames, limitNum);
	}
	const std::string CSqlQueryBase::concatSql(const TDbCol *column, uint32 columnNum, const char* tableName, const char* cond1,
		const char* cond2, const char* cond3, const char* cond4, const char* cond5,
		bool asce, const char* colNames, sint32 limitNum){
			DB_BEGIN("DB_MOD;");

			if(columnNum < 1){
				gxError("User db col num less than 1!TableName={0}", tableName);
				return "";
			}

			if(column[columnNum-1].name == NULL){
				columnNum--;
			}

			// 生成sql语句
			std::string sqlStr = "SELECT ";
			if(columnNum > 0){
				sqlStr += "`";
				sqlStr += column[0].name;
				sqlStr += "`";
				//sqlStr += "";
			}
			for(uint32 i = 1; i < columnNum; ++i){
				sqlStr += ",";
				sqlStr += "`";
				sqlStr += column[i].name;
				sqlStr += "`";
				//sqlStr += "";
			}

			sqlStr += " FROM ";
			sqlStr += tableName;
			//sqlStr += " ";

			if(strlen(cond1) != 0){
				sqlStr += " WHERE ";
				sqlStr += cond1;
				//sqlStr += " ";
			}

			if(strlen(cond2) != 0){
				sqlStr += " AND ";
				sqlStr += cond2;
				//sqlStr += " ";
			}

			if(strlen(cond3) != 0){
				sqlStr += " AND ";
				sqlStr += cond3;
				//sqlStr += " ";
			}

			if(strlen(cond4) != 0){
				sqlStr += " AND ";
				sqlStr += cond4;
				//sqlStr += " ";
			}

			if(strlen(cond5) != 0){
				sqlStr += " AND ";
				sqlStr += cond5;
				//sqlStr += " ";
			}

			if(strlen(colNames) != 0)
			{
				sqlStr += " ORDER BY ";
				sqlStr += colNames;
			}

			if(!asce){
				sqlStr += " DESC ";
			}

			if(limitNum != -1){
				sqlStr += " LIMIT ";
				sqlStr += gxToString(limitNum);
				//sqlStr += " ";
			}

			sqlStr += ";";

			return sqlStr;

			DB_END_RET("");
	}

	// 查询返回多条记录
	sint32 CSqlQueryBase::selectEx(const TDbCol *column, uint32 columnNum, const char* tableName, uint8* data,
		sint32 maxDataLen, bool asce, const char* colNames, sint32 limitNum)
	{
		DB_BEGIN("DB_MOD;");
		std::string sqlStr = concatSql(column, columnNum, tableName,asce,colNames,limitNum);
		if(_openLog)
		{
			gxDebug("sqlStr={0}", sqlStr);
		}
		_sqlString = sqlStr;
		mysqlpp::Query query = getConnection()->query();
		mysqlpp::StoreQueryResult res = query.store(sqlStr.c_str(), sqlStr.size());
		if(res)
		{
			return parseRecordData(res, column, columnNum, data, maxDataLen);
		}

		return -1;
		DB_END_RET(-1);
	}

	sint32 CSqlQueryBase::selectEx(const TDbCol *column, uint32 columnNum, const char* tableName, const char* cond1, uint8* data,
		sint32 maxDataLen, bool asce, const char* colNames, sint32 limitNum)
	{
		DB_BEGIN("DB_MOD;");
		std::string sqlStr = concatSql(column, columnNum, tableName,cond1,asce,colNames,limitNum);
		if(_openLog)
		{
			gxDebug("sqlStr={0}", sqlStr);
		}
		_sqlString = sqlStr;
		mysqlpp::Query query = getConnection()->query();
		mysqlpp::StoreQueryResult res = query.store(sqlStr.c_str(), sqlStr.size());
		if(res)
		{
			return parseRecordData(res, column, columnNum, data, maxDataLen);
		}else{
			gxError("Can't select from database!Sql={0}", sqlStr);
		}

		return -1;
		DB_END_RET(-1);
	}

	sint32 CSqlQueryBase::selectEx(const TDbCol *column, uint32 columnNum, const char* tableName, const char* cond1,
		const char* cond2, uint8* data,
		sint32 maxDataLen, bool asce, const char* colNames, sint32 limitNum)
	{
		DB_BEGIN("DB_MOD;");
		std::string sqlStr = concatSql(column, columnNum, tableName,cond1,cond2,asce,colNames,limitNum);
		if(_openLog)
		{
			gxDebug("sqlStr={0}", sqlStr);
		}
		_sqlString = sqlStr;
		mysqlpp::Query query = getConnection()->query();
		mysqlpp::StoreQueryResult res = query.store(sqlStr.c_str(), sqlStr.size());
		if(res)
		{
			return parseRecordData(res, column, columnNum, data, maxDataLen);
		}

		return -1;
		DB_END_RET(-1);
	}

	sint32 CSqlQueryBase::selectEx(const TDbCol *column, uint32 columnNum, const char* tableName, const char* cond1,
		const char* cond2, const char* cond3, uint8* data,
		sint32 maxDataLen, bool asce, const char* colNames, sint32 limitNum)
	{
		DB_BEGIN("DB_MOD;");
		std::string sqlStr = concatSql(column, columnNum, tableName,cond1,cond2,cond3,asce,colNames,limitNum);
		if(_openLog)
		{
			gxDebug("sqlStr={0}", sqlStr);
		}
		_sqlString = sqlStr;
		mysqlpp::Query query = getConnection()->query();
		mysqlpp::StoreQueryResult res = query.store(sqlStr.c_str(), sqlStr.size());
		if(res)
		{
			return parseRecordData(res, column, columnNum, data, maxDataLen);
		}

		return -1;
		DB_END_RET(-1);
	}

	sint32 CSqlQueryBase::selectEx(const TDbCol *column, uint32 columnNum, const char* tableName, const char* cond1,
		const char* cond2, const char* cond3, const char* cond4, uint8* data,
		sint32 maxDataLen, bool asce, const char* colNames, sint32 limitNum)
	{
		DB_BEGIN("DB_MOD;");
		std::string sqlStr = concatSql(column, columnNum, tableName,cond1,cond2,cond3,cond4,asce,colNames,limitNum);
		if(_openLog)
		{
			gxDebug("sqlStr={0}", sqlStr);
		}
		_sqlString = sqlStr;
		mysqlpp::Query query = getConnection()->query();
		mysqlpp::StoreQueryResult res = query.store(sqlStr.c_str(), sqlStr.size());
		if(res)
		{
			return parseRecordData(res, column, columnNum, data, maxDataLen);
		}

		return -1;
		DB_END_RET(-1);
	}

	sint32 CSqlQueryBase::selectEx(const TDbCol *column, uint32 columnNum, const char* tableName, const char* cond1,
		const char* cond2, const char* cond3, const char* cond4, const char* cond5, uint8* data,
		sint32 maxDataLen, bool asce, const char* colNames, sint32 limitNum)
	{
		DB_BEGIN("DB_MOD;");
		std::string sqlStr = concatSql(column, columnNum, tableName,cond1,cond2,cond3,cond4,cond5,asce,colNames,limitNum);
		if(_openLog)
		{
			gxDebug("sqlStr={0}", sqlStr);
		}
		_sqlString = sqlStr;
		mysqlpp::Query query = getConnection()->query();
		mysqlpp::StoreQueryResult res = query.store(sqlStr.c_str(), sqlStr.size());
		if(res)
		{
			return parseRecordData(res, column, columnNum, data, maxDataLen);
		}

		return -1;
		DB_END_RET(-1);
	}

	// 查询单条记录返回值直接转换到指定地址
	sint32 CSqlQueryBase::selectEx(const TDbCol *column, int columnNum, const char* tableName, bool asce, const char* colNames, sint32 limitNum)
	{
		DB_BEGIN("DB_MOD;");
		std::string sqlStr = concatSql(column, columnNum, tableName,asce,colNames,limitNum);
		if(_openLog)
		{
			gxDebug("sqlStr={0}", sqlStr);
		}
		_sqlString = sqlStr;
		mysqlpp::Query query = getConnection()->query();
		mysqlpp::StoreQueryResult res = query.store(sqlStr.c_str(), sqlStr.size());
		if(res)
		{
			parseRecordData(res, column, columnNum);
		}

		return -1;
		DB_END_RET(-1);
	}
	sint32 CSqlQueryBase::selectEx(const TDbCol *column, int columnNum, const char* tableName, const char* cond1, bool asce, const char* colNames, sint32 limitNum)
	{
		DB_BEGIN("DB_MOD;");
		std::string sqlStr = concatSql(column, columnNum, tableName,cond1,asce,colNames,limitNum);
		if(_openLog)
		{
			gxDebug("sqlStr={0}", sqlStr);
		}
		_sqlString = sqlStr;
		mysqlpp::Query query = getConnection()->query();
		mysqlpp::StoreQueryResult res = query.store(sqlStr.c_str(), sqlStr.size());
		if(res)
		{
			return parseRecordData(res, column, columnNum);
		}

		return -1;
		DB_END_RET(-1);
	}
	sint32 CSqlQueryBase::selectEx(const TDbCol *column, int columnNum, const char* tableName, const char* cond1,
		const char* cond2, bool asce, const char* colNames, sint32 limitNum)
	{
		DB_BEGIN("DB_MOD;");
		std::string sqlStr = concatSql(column, columnNum, tableName,cond1,cond2,asce,colNames,limitNum);
		if(_openLog)
		{
			gxDebug("sqlStr={0}", sqlStr);
		}
		_sqlString = sqlStr;
		mysqlpp::Query query = getConnection()->query();
		mysqlpp::StoreQueryResult res = query.store(sqlStr.c_str(), sqlStr.size());
		if(res)
		{
			return parseRecordData(res, column, columnNum);
		}

		return -1;
		DB_END_RET(-1);
	}
	sint32 CSqlQueryBase::selectEx(const TDbCol *column, int columnNum, const char* tableName, const char* cond1,
		const char* cond2, const char* cond3, bool asce, const char* colNames, sint32 limitNum)
	{
		DB_BEGIN("DB_MOD;");
		std::string sqlStr = concatSql(column, columnNum, tableName,cond1,cond2,cond3,asce,colNames,limitNum);
		if(_openLog)
		{
			gxDebug("sqlStr={0}", sqlStr);
		}
		_sqlString = sqlStr;
		mysqlpp::Query query = getConnection()->query();
		mysqlpp::StoreQueryResult res = query.store(sqlStr.c_str(), sqlStr.size());
		if(res)
		{
			return parseRecordData(res, column, columnNum);
		}

		return -1;
		DB_END_RET(-1);
	}
	sint32 CSqlQueryBase::selectEx(const TDbCol *column, int columnNum, const char* tableName, const char* cond1,
		const char* cond2, const char* cond3, const char* cond4, bool asce, const char* colNames, sint32 limitNum)
	{
		DB_BEGIN("DB_MOD;");
		std::string sqlStr = concatSql(column, columnNum, tableName,cond1,cond2,cond3,cond4,asce,colNames,limitNum);
		if(_openLog)
		{
			gxDebug("sqlStr={0}", sqlStr);
		}
		_sqlString = sqlStr;
		mysqlpp::Query query = getConnection()->query();
		mysqlpp::StoreQueryResult res = query.store(sqlStr.c_str(), sqlStr.size());
		if(res)
		{
			return parseRecordData(res, column, columnNum);
		}

		return -1;
		DB_END_RET(-1);
	}
	sint32 CSqlQueryBase::selectEx(const TDbCol *column, int columnNum, const char* tableName, const char* cond1,
		const char* cond2, const char* cond3, const char* cond4, const char* cond5, bool asce, const char* colNames, sint32 limitNum)
	{
		DB_BEGIN("DB_MOD;");
		std::string sqlStr = concatSql(column, columnNum, tableName,cond1,cond2,cond3,cond4,cond5,asce,colNames,limitNum);
		if(_openLog)
		{
			gxDebug("sqlStr={0}", sqlStr);
		}
		_sqlString = sqlStr;
		mysqlpp::Query query = getConnection()->query();
		mysqlpp::StoreQueryResult res = query.store(sqlStr.c_str(), sqlStr.size());
		if(res)
		{
			return parseRecordData(res, column, columnNum);
		}

		return -1;
		DB_END_RET(-1);
	}

	sint32 CSqlQueryBase::selectEx(const char* tableName, TDbColAryVec& dbCols, bool asce, const char* colNames, sint32 limitNum)
	{
		DB_BEGIN("DB_MOD;");
		if(dbCols.empty())
		{
			return 0;
		}

		std::string sqlStr = concatSql(dbCols[0].data(), dbCols[0].size(), tableName,asce,colNames,limitNum);
		if(_openLog)
		{
			gxDebug("sqlStr={0}", sqlStr);
		}
		_sqlString = sqlStr;
		mysqlpp::Query query = getConnection()->query();
		mysqlpp::StoreQueryResult res = query.store(sqlStr.c_str(), sqlStr.size());
		if(res)
		{
			sint32 i = 0; 
			gxAssert(dbCols.size() == res.size());
			if(dbCols.size() != res.size())
			{
				gxError("DbCols size not equal to db row size!DbColSize={0},DbRowSize={1}", dbCols.size(), res.size());
				return -1;
			}
			for(mysqlpp::StoreQueryResult::iterator iter = res.begin(); iter != res.end(); ++iter, ++i)
			{
				if(parseRecordData(*iter, dbCols[i].data(), dbCols[i].size()) < 0)
				{
					return -1;
				}
			}

			return (sint32)res.size();
		}

		return -1;
		DB_END_RET(-1);
	}
	sint32 CSqlQueryBase::selectEx(const char* tableName, TDbColAryVec& dbCols, const char* cond1, bool asce, const char* colNames, sint32 limitNum)
	{
		DB_BEGIN("DB_MOD;");
		if(dbCols.empty())
		{
			return 0;
		}

		std::string sqlStr = concatSql(dbCols[0].data(),dbCols[0].size(),tableName,cond1,asce,colNames,limitNum);
		if(_openLog)
		{
			gxDebug("sqlStr={0}", sqlStr);
		}
		_sqlString = sqlStr;
		mysqlpp::Query query = getConnection()->query();
		mysqlpp::StoreQueryResult res = query.store(sqlStr.c_str(), sqlStr.size());
		if(res)
		{
			sint32 i = 0; 
			gxAssert(dbCols.size() == res.size());
			if(dbCols.size() != res.size())
			{
				gxError("DbCols size not equal to db row size!DbColSize={0},DbRowSize={1}", dbCols.size(), res.size());
				return -1;
			}
			for(mysqlpp::StoreQueryResult::iterator iter = res.begin(); iter != res.end(); ++iter, ++i)
			{
				if(parseRecordData(*iter, dbCols[i].data(), dbCols[i].size()) < 0)
				{
					return -1;
				}
			}

			return (sint32)res.size();
		}

		return -1;
		DB_END_RET(-1);
	}
	sint32 CSqlQueryBase::selectEx(const char* tableName, TDbColAryVec& dbCols, const char* cond1,
		const char* cond2, bool asce, const char* colNames, sint32 limitNum)
	{
		DB_BEGIN("DB_MOD;");
		if(dbCols.empty())
		{
			return 0;
		}

		std::string sqlStr = concatSql(dbCols[0].data(),dbCols[0].size(),tableName,cond1,cond2,asce,colNames,limitNum);
		if(_openLog)
		{
			gxDebug("sqlStr={0}", sqlStr);
		}
		_sqlString = sqlStr;
		mysqlpp::Query query = getConnection()->query();
		mysqlpp::StoreQueryResult res = query.store(sqlStr.c_str(), sqlStr.size());
		if(res)
		{
			sint32 i = 0; 
			gxAssert(dbCols.size() == res.size());
			if(dbCols.size() != res.size())
			{
				gxError("DbCols size not equal to db row size!DbColSize={0},DbRowSize={1}", dbCols.size(), res.size());
				return -1;
			}
			for(mysqlpp::StoreQueryResult::iterator iter = res.begin(); iter != res.end(); ++iter, ++i)
			{
				if(parseRecordData(*iter, dbCols[i].data(), dbCols[i].size()) < 0)
				{
					return -1;
				}
			}

			return (sint32)res.size();
		}

		return -1;
		DB_END_RET(-1);
	}
	sint32 CSqlQueryBase::selectEx(const char* tableName, TDbColAryVec& dbCols, const char* cond1,
		const char* cond2, const char* cond3, bool asce, const char* colNames, sint32 limitNum)
	{
		DB_BEGIN("DB_MOD;");
		if(dbCols.empty())
		{
			return 0;
		}

		std::string sqlStr = concatSql(dbCols[0].data(),dbCols[0].size(),tableName,cond1,cond2,cond3,asce,colNames,limitNum);
		if(_openLog)
		{
			gxDebug("sqlStr={0}", sqlStr);
		}
		_sqlString = sqlStr;
		mysqlpp::Query query = getConnection()->query();
		mysqlpp::StoreQueryResult res = query.store(sqlStr.c_str(), sqlStr.size());
		if(res)
		{
			sint32 i = 0; 
			gxAssert(dbCols.size() == res.size());
			if(dbCols.size() != res.size())
			{
				gxError("DbCols size not equal to db row size!DbColSize={0},DbRowSize={1}", dbCols.size(), res.size());
				return -1;
			}
			for(mysqlpp::StoreQueryResult::iterator iter = res.begin(); iter != res.end(); ++iter, ++i)
			{
				if(parseRecordData(*iter, dbCols[i].data(), dbCols[i].size()) < 0)
				{
					return -1;
				}
			}

			return (sint32)res.size();
		}

		return -1;
		DB_END_RET(-1);
	}
	sint32 CSqlQueryBase::selectEx(const char* tableName, TDbColAryVec& dbCols, const char* cond1,
		const char* cond2, const char* cond3, const char* cond4, bool asce, const char* colNames, sint32 limitNum)
	{
		DB_BEGIN("DB_MOD;");
		if(dbCols.empty())
		{
			return 0;
		}

		std::string sqlStr = concatSql(dbCols[0].data(),dbCols[0].size(),tableName,cond1,cond2,cond3,cond4,asce,colNames,limitNum);
		if(_openLog)
		{
			gxDebug("sqlStr={0}", sqlStr);
		}
		_sqlString = sqlStr;
		mysqlpp::Query query = getConnection()->query();
		mysqlpp::StoreQueryResult res = query.store(sqlStr.c_str(), sqlStr.size());
		if(res)
		{
			sint32 i = 0; 
			gxAssert(dbCols.size() == res.size());
			if(dbCols.size() != res.size())
			{
				gxError("DbCols size not equal to db row size!DbColSize={0},DbRowSize={1}", dbCols.size(), res.size());
				return -1;
			}
			for(mysqlpp::StoreQueryResult::iterator iter = res.begin(); iter != res.end(); ++iter, ++i)
			{
				if(parseRecordData(*iter, dbCols[i].data(), dbCols[i].size()) < 0)
				{
					return -1;
				}
			}

			return (sint32)res.size();
		}

		return -1;
		DB_END_RET(-1);
	}
	sint32 CSqlQueryBase::selectEx(const char* tableName, TDbColAryVec& dbCols, const char* cond1,
		const char* cond2, const char* cond3, const char* cond4, const char* cond5,
		bool asce, const char* colNames, sint32 limitNum)
	{
		DB_BEGIN("DB_MOD;");
		if(dbCols.empty())
		{
			return 0;
		}

		std::string sqlStr = concatSql(dbCols[0].data(),dbCols[0].size(),tableName,cond1,cond2,cond3,cond4,cond5,asce,colNames,limitNum);
		if(_openLog)
		{
			gxDebug("sqlStr={0}", sqlStr);
		}
		_sqlString = sqlStr;
		mysqlpp::Query query = getConnection()->query();
		mysqlpp::StoreQueryResult res = query.store(sqlStr.c_str(), sqlStr.size());
		if(res)
		{
			sint32 i = 0; 
			gxAssert(dbCols.size() == res.size());
			if(dbCols.size() != res.size())
			{
				gxError("DbCols size not equal to db row size!DbColSize={0},DbRowSize={1}", dbCols.size(), res.size());
				return -1;
			}
			for(mysqlpp::StoreQueryResult::iterator iter = res.begin(); iter != res.end(); ++iter, ++i)
			{
				if(parseRecordData(*iter, dbCols[i].data(), dbCols[i].size()) < 0)
				{
					return -1;
				}
			}

			return (sint32)res.size();
		}

		return -1;
		DB_END_RET(-1);
	}

	sint32 GXMISC::CSqlQueryBase::parseRecordData( mysqlpp::Row& res, const TDbCol *column, uint32 columnNum )
	{
		DB_BEGIN("DB_MOD;");

		if(column[columnNum-1].name == NULL){
			columnNum--;
		}

		sint32 curPos = 0;
		for(mysqlpp::Row::size_type i = 0; i < res.size(); ++i){
#ifdef LIB_DEBUG
			// 检测名字是否相同
			// @todo mysql不提供名字访问的方式
#endif
			// 将数据转换成结构体字段
			sint32 retCode = dbFiledConvToData(column+i, res.at(i), (unsigned char*)column[i].data_addr, (sint32)0, (sint32)column[i].type_size);
			if( retCode < 0)
			{
				return -1;
			}

			curPos += retCode;
		}

		return 1;

		DB_END_RET(-1);
	}

	sint32 CSqlQueryBase::parseRecordData(mysqlpp::StoreQueryResult res, const TDbCol *column, uint32 columnNum)
	{
		DB_BEGIN("DB_MOD;");
		if(column[columnNum-1].name == NULL){
			columnNum--;
		}
		sint32 curPos = 0;
		sint32 getRecordNum = 0;
		for(mysqlpp::StoreQueryResult::iterator iter = res.begin(); iter != res.end(); ++iter)
		{
			if(columnNum != iter->size()){
				// 结果集列数与结构体的字段数不等
				gxError("DbCol num not equal to db return result row num!");
				return -1;
			}

			for(mysqlpp::Row::size_type i = 0; i < iter->size(); ++i){
#ifdef LIB_DEBUG
				// 检测名字是否相同
				// @todo mysql不提供名字访问的方式
#endif
				// 将数据转换成结构体字段
				sint32 retCode = dbFiledConvToData(column+i, iter->at(i), (unsigned char*)column[i].data_addr, (sint32)0, (sint32)column[i].type_size);
				if( retCode < 0)
				{
					return -1;
				}

				curPos += retCode;
			}

			getRecordNum++;

			break;
		}

		return getRecordNum;
		DB_END_RET(-1);
	}

	sint32 CSqlQueryBase::parseRecordData(mysqlpp::StoreQueryResult res, const TDbCol *column, uint32 columnNum, unsigned char* data, sint32 maxDataLen)
	{
		DB_BEGIN("DB_MOD;");
		if(column[columnNum-1].name == NULL){
			columnNum--;
		}

		sint32 columnTotalSize = GetColSize(column, NULL);
		sint32 recordNum = maxDataLen/columnTotalSize;
		gxAssert(maxDataLen%columnTotalSize == 0);

		sint32 curPos = 0;
		sint32 getRecordNum = 0;
		for(mysqlpp::StoreQueryResult::iterator iter = res.begin(); iter != res.end() && recordNum > 0; ++iter,recordNum--)
		{
			if(columnNum != iter->size()){
				// 结果集列数与结构体的字段数不等
				gxError("DbCol num not equal to db return result row num!");
				return -1;
			}

			for(mysqlpp::Row::size_type i = 0; i < iter->size(); ++i){
#ifdef LIB_DEBUG
				// 检测名字是否相同
				// @todo mysql不提供名字访问的方式
#endif
				// 将数据转换成结构体字段
				sint32 retCode = dbFiledConvToData(column+i, iter->at(i), data, curPos, maxDataLen);
				if( retCode < 0)
				{
					return -1;
				}

				curPos += retCode;
			}

			getRecordNum++;
		}

		return getRecordNum;
		DB_END_RET(-1);
	}

	// 查询记录返回值直接转换到指定地址
	sint32 CSqlQueryBase::selectExSql(const char *sql, const TDbCol *column, uint32 columnNum)
	{
		sint32 sqlLen = (sint32)strlen(sql);
		if(_openLog)
		{
			gxDebug("{0}", sql);
		}
		_sqlString = sql;
		mysqlpp::Query query = getConnection()->query();
		mysqlpp::StoreQueryResult res = query.store(sql, sqlLen);
		if(res)
		{
			return parseRecordData(res, column, columnNum);
		}

		return -1;
	}

	sint32 CSqlQueryBase::selectExSql(const char *sql, const TDbCol *column, uint32 columnNum, unsigned char*& data, sint32 maxDataLen)
	{
		mysqlpp::Query query = getConnection()->query();
		sint32 len = (sint32)strlen(sql);
		if(_openLog)
		{
			gxDebug("{0}", sql);
		}
		_sqlString = sql;
		mysqlpp::StoreQueryResult res = query.store(sql, len);
		if(res)
		{
			return parseRecordData(res, column, columnNum, data, maxDataLen);
		}

		return -1;
	}

	sint32 CSqlQueryBase::dbFiledConvToData(const TDbCol *column, const mysqlpp::String& row, unsigned char* data, sint32 curPos, sint32 maxDataLen)
	{
		DB_BEGIN("DB_MOD;");
		switch(column->type){
		case DB_BYTE:				// 字节 uint8
			{
				if(maxDataLen-curPos < (sint32)sizeof(uint8)){
					gxError("User data not enough to convertion!ColumnName={0}", column->name);
					return -1;
				}
				uint8& t = *((uint8*)(data+curPos));
				conv<uint8>(t, row, 0);
				return column->type_size;
			}break;
		case DB_BYTES:				// 字节 sint8
			{
				if(maxDataLen-curPos < (sint32)sizeof(sint8)){
					gxError("User data not enough to convertion!ColumnName={0}", column->name);
					return -1;
				}
				sint8& t = *((sint8*)(data+curPos));
				conv<sint8>(t, row, 0);
				return column->type_size;
			}break;
		case DB_WORD:				// 双字节 uint16
			{
				if(maxDataLen-curPos < (sint32)sizeof(uint16)){
					gxError("User data not enough to convertion!ColumnName={0}", column->name);
					return -1;
				}
				uint16& t = *((uint16*)(data+curPos));
				conv<uint16>(t, row, 0);
				return column->type_size;
			}break;
		case DB_WORDS:				// 双字节 sint16
			{
				if(maxDataLen-curPos < (sint32)sizeof(sint16)){
					gxError("User data not enough to convertion!ColumnName={0}", column->name);
					return -1;
				}
				sint16& t = *((sint16*)(data+curPos));
				conv<sint16>(t, row, 0);
				return column->type_size;
			}break;
		case DB_DWORD:				// 四字节 uint32
			{
				if(maxDataLen-curPos < (sint32)sizeof(uint32)){
					gxError("User data not enough to convertion!ColumnName={0}", column->name);
					return -1;
				}
				uint32& t = *((uint32*)(data+curPos));
				conv<uint32>(t, row, 0);
				return column->type_size;
			}break;
		case DB_DWORDS:				// 四字节 sint32
			{
				if(maxDataLen-curPos < (sint32)sizeof(sint32)){
					gxError("User data not enough to convertion!ColumnName={0}", column->name);
					return -1;
				}
				sint32& t = *((sint32*)(data+curPos));
				conv<sint32>(t, row, 0);
				return column->type_size;
			}break;
		case DB_QWORD:				// 八字节 uint64
			{
				if(maxDataLen-curPos < (sint32)sizeof(uint64)){
					gxError("User data not enough to convertion!ColumnName={0}", column->name);
					return -1;
				}
				uint64& t = *((uint64*)(data+curPos));
				conv<uint64>(t, row, 0);
				return column->type_size;
			}break;
		case DB_QWORDS:				// 八字节 sint64
			{
				if(maxDataLen-curPos < (sint32)sizeof(sint64)){
					gxError("User data not enough to convertion!ColumnName={0}", column->name);
					return -1;
				}
				sint64& t = *((sint64*)(data+curPos));
				conv<sint64>(t, row, 0);
				return column->type_size;
			}break;
		case DB_FLOAT:				// 浮点数 float
			{
				if(maxDataLen-curPos < (sint32)sizeof(float)){
					gxError("User data not enough to convertion!ColumnName={0}", column->name);
					return -1;
				}
				float& t = *((float*)(data+curPos));
				conv<float>(t, row, 0.0f);
				return column->type_size;
			}break;
		case DB_DOUBLE:				// 双精度 double
			{
				if(maxDataLen-curPos < (sint32)sizeof(double)){
					gxError("User data not enough to convertion!ColumnName={0}", column->name);
					return -1;
				}
				double& t = *((double*)(data+curPos));
				conv<double>(t, row, 0.0f);
				return column->type_size;
			}break;
		case DB_RAW_STR:				// 原生字符串 CFixArray
			{
				if((mysqlpp::String::size_type)maxDataLen-curPos < row.size()){
					gxError("User data not enough to convertion!ColumnName={0}", column->name);
					return -1;
				}

				if(row.size() > column->type_size){
					gxError("Db filed data great than user db col!DbColName = {0}", column->name);
					return -1;
				}

				char* destStr = (char*)(data+curPos);
				uint32 rowSize = (uint32)row.size();
				gxStrcpy(destStr, column->type_size, row.c_str(), rowSize);
				return column->type_size;
			}break;
		case DB_TINY_STR:					// 字符串 CCharArray[uint8]
			{
				if(((mysqlpp::String::size_type)maxDataLen-curPos) < (row.size()+1)){
					gxError("User data not enough to convertion!ColumnName={0}", column->name);
					return -1;
				}

				if(row.size() > column->type_size){
					gxError("Db filed data great than user db col!DbColName = {0}", column->name);
					return -1;
				}

				uint8& destLen = *((uint8*)(data+curPos));
				destLen = (uint8)row.size();
				char* destStr = (char*)(data+curPos+sizeof(uint8));
				uint32 rowSize = (uint32)row.size();
				gxStrcpy(destStr, column->type_size, row.c_str(), rowSize);
				return column->type_size;
			}break;
		case DB_STR:					// 字符串 CCharArray[uint16]
			{
				if((mysqlpp::String::size_type)maxDataLen-curPos < (row.size()+2)){
					gxError("User data not enough to convertion!ColumnName={0}", column->name);
					return -1;
				}

				if(row.size() > column->type_size){
					gxError("Db filed data great than user db col!DbColName = {0}", column->name);
					return -1;
				}

				uint16& destLen = *((uint16*)(data+curPos));
				destLen = (uint16)row.size();
				char* destStr = (char*)(data+curPos+sizeof(uint16));
				uint32 rowSize = (uint32)row.size();
				gxStrcpy(destStr, column->type_size, row.c_str(), rowSize);
				return column->type_size;

			}break;
		case DB_BIG_STR:					// 字符串 CCharArray[uint32]
			{
				if((mysqlpp::String::size_type)maxDataLen-curPos < (row.size()+2)){
					gxError("User data not enough to convertion!ColumnName={0}", column->name);
					return -1;
				}

				if(row.size() > column->type_size){
					gxError("Db filed data great than user db col!DbColName = {0}", column->name);
					return -1;
				}

				uint32& destLen = *((uint32*)(data+curPos));
				destLen = (uint32)row.size();
				char* destStr = (char*)(data+curPos+sizeof(uint32));
				uint32 rowSize = (uint32)row.size();
				gxStrcpy(destStr, column->type_size, row.c_str(), rowSize);
				return column->type_size;
			}break;
		case DB_DATETIME:			// 日期 TGameTime_t
			{
				if((mysqlpp::String::size_type)maxDataLen-curPos < sizeof(TGameTime_t)){
					gxError("User data not enough to convertion!ColumnName={0}", column->name);
					return -1;
				}

				TGameTime_t& gameTime = *((TGameTime_t*)(data+curPos));
				convTime(gameTime, row, 0);
				return column->type_size;
			}break;
		case DB_OBJECT:
			{
				// 将数据库字符串转换成二进制结构Buffer
				uint32 rowSize = (uint32)row.size();
				uint8* dbStructBuffer = NULL;
				sint32 dbStructSize = 0;
				TDBBuffer structBuffer;
				GXMISC::TDBVersion_t dbVersion = 0;
				if(rowSize == 0)
				{
					return column->type_size;
				}

				if(!dbStringToStruct(structBuffer, row.c_str(), rowSize, dbVersion))
				{
					gxError("Can't convert db filed, convert dbstring to struct failed!Name={0}", column->name);
					return -1;
				}
				dbStructBuffer = (uint8*)structBuffer.data();
				dbStructSize = (sint32)structBuffer.size();
				// 如果升级函数存在则升级
				TDBBuffer buffer;
				if(column->dbFieldToDataFuncPtr != NULL)
				{
				//	gxAssert(column->db_version != 0);
					sint32 returnCode = (column->dbFieldToDataFuncPtr)(buffer, structBuffer.data(), dbStructSize, dbVersion);
					if(returnCode < 0)
					{
						gxError("Can't convert db filed, convert func return error!ReturnCode={0}, Name={1}", returnCode, column->name);
						return -1;
					}
					gxAssert(buffer.size() <= column->type_size);
					if(buffer.size() > column->type_size){
						gxError("Can't convert db filed, convert data len great than struct filed size!Name={0},ConvertDataLen={1},StructFiledSize={2}",
							column->name, buffer.size(), column->type_size);
					}
					dbStructBuffer = (uint8*)buffer.data();
					dbStructSize = (sint32)buffer.size();
				}
				else{
					gxAssert(dbStructSize == (sint32)column->type_size);
					if(dbStructSize != (sint32)column->type_size)
					{
						gxError("After convert struct size not equal to current program struct define size!Name={0},DBStructSize={1},StructSize={2}",
							column->name, dbStructSize, column->type_size);
						return -1;
					}
				}
				memcpy(data+curPos, dbStructBuffer, dbStructSize);
				return column->type_size;
			}break;
		default:
			{
				gxAssertEx(false, "Dbcol can't convertion!Type={0}", column->type);
				return -1;
			}
		}

		return -1;
		DB_END_RET(-1);
	}

	bool CSqlQueryBase::dbStringToStruct( TDBBuffer& outBuffer, const char* pBStr, sint32 size, GXMISC::TDBVersion_t& dbVersion )
	{
		if ( strlen(pBStr) == 0 )
		{
			return true;
		}
		TBinaryStringHead strHead;
		sint32 strHeadLen = sizeof(strHead);
		if ( size <= strHeadLen )
		{
			gxError("Binary string length is too short!!! It must larger than {0}!", strHeadLen);
			gxAssert(false);
			return false;	// 该字符串的长度一定得大于等于字符串头的长度
		}
		uint32 index = 0;	// 当前解析二进制字符串的位置
		char* pStrHead = (char*)&strHead;
		for ( sint32 i=0; i<strHeadLen; ++i )
		{
			pStrHead[i] = BinaryCharToNumber(index, pBStr);
		}
		dbVersion = strHead._dbVersion;
		return ParseBStr(outBuffer, index, strHead._realLen, pBStr);
	}

	bool CSqlQueryBase::structToDbString( TDBBuffer& outBuffer, uint8* buffer, sint32 size, GXMISC::TDBVersion_t dbVersion )
	{
		DB_BEGIN("DB_MOD;");

		outBuffer.resize((size+sizeof(TBinaryStringHead))*3);

		uint32 index = 0;
		TBinaryStringHead strHead;
		strHead._realLen = size;
		strHead._year = DTimeManager.getYear();
		strHead._month = DTimeManager.getMonth() + 1;
		strHead._day = DTimeManager.getDay();
		strHead._hour = DTimeManager.getHour();
		strHead._minute = DTimeManager.getMinute();
		strHead._second = DTimeManager.getSecond();
		strHead._dbVersion = dbVersion;
		uint32 strHeadLen = sizeof(strHead);
		char* pStrHead = (char*)&strHead;
		for ( uint32 i=0; i<strHeadLen; ++i )
		{
			NumberToBinaryChar(pStrHead[i], (char*)outBuffer.data(), index);
		}
		char* pIn = (char*)buffer;
		for ( uint32 i=0; i<strHead._realLen; ++i )
		{
			NumberToBinaryChar(pIn[i], (char*)outBuffer.data(), index);
		}
		outBuffer[index] = '\0';
		outBuffer.resize(index+1);

		return true;

		DB_END_RET(false);
	}

	sint32 CSqlQueryBase::dataConvToDbFiled(std::ostringstream& outSql, const TDbCol *column, unsigned char* data,
		sint32 curPos, sint32 maxDataLen, char appChar)
	{
		DB_BEGIN("DB_MOD;");
		switch(column->type){
		case DB_BYTE:				// 字节 uint8
			{
				if(maxDataLen < (sint32)(sizeof(uint8)+curPos)){
					gxError("User data not enough to convertion!");
					return -1;
				}
				uint8& t = *((uint8*)(data+curPos));
				uint32 tempVal = t;
				outSql << appChar;
				outSql << tempVal;
				outSql << appChar;
				return column->type_size;
			}break;
		case DB_BYTES:				// 字节 sint8
			{
				if(maxDataLen < (sint32)(sizeof(sint8)+curPos)){
					gxError("User data not enough to convertion!");
					return -1;
				}
				sint8& t = *((sint8*)(data+curPos));
				sint32 tempVal = t;
				outSql << appChar;
				outSql << tempVal;
				outSql << appChar;
				return column->type_size;
			}break;
		case DB_WORD:				// 双字节 uint16
			{
				if(maxDataLen < (sint32)(sizeof(uint16)+curPos)){
					gxError("User data not enough to convertion!");
					return -1;
				}
				uint16& t = *((uint16*)(data+curPos));
				outSql <<appChar;
				outSql <<t;
				outSql <<appChar;
				return column->type_size;
			}break;
		case DB_WORDS:				// 双字节 sint16
			{
				if(maxDataLen < (sint32)(sizeof(sint16)+curPos)){
					gxError("User data not enough to convertion!");
					return -1;
				}
				sint16& t = *((sint16*)(data+curPos));
				outSql <<appChar;
				outSql <<t;
				outSql <<appChar;
				return column->type_size;
			}break;
		case DB_DWORD:				// 四字节 uint32
			{
				if(maxDataLen < (sint32)(sizeof(uint32)+curPos)){
					gxError("User data not enough to convertion!");
					return -1;
				}
				uint32& t = *((uint32*)(data+curPos));
				outSql <<appChar;
				outSql <<t;
				outSql <<appChar;
				return column->type_size;
			}break;
		case DB_DWORDS:				// 四字节 sint32
			{
				if(maxDataLen < (sint32)(sizeof(sint32)+curPos)){
					gxError("User data not enough to convertion!");
					return -1;
				}
				sint32& t = *((sint32*)(data+curPos));
				outSql <<appChar;
				outSql <<t;
				outSql <<appChar;
				return column->type_size;
			}break;
		case DB_QWORD:				// 八字节 uint64
			{
				if(maxDataLen < (sint32)(sizeof(uint64)+curPos)){
					gxError("User data not enough to convertion!");
					return -1;
				}
				uint64& t = *((uint64*)(data+curPos));
				outSql <<appChar;
				outSql <<t;
				outSql <<appChar;
				return column->type_size;
			}break;
		case DB_QWORDS:				// 八字节 sint64
			{
				if(maxDataLen < (sint32)(sizeof(sint64)+curPos)){
					gxError("User data not enough to convertion!");
					return -1;
				}
				sint64& t = *((sint64*)(data+curPos));
				outSql <<appChar;
				outSql <<t;
				outSql <<appChar;
				return column->type_size;
			}break;
		case DB_FLOAT:				// 浮点数 float
			{
				if(maxDataLen < (sint32)(sizeof(float)+curPos)){
					gxError("User data not enough to convertion!");
					return -1;
				}
				float& t = *((float*)(data+curPos));
				outSql <<appChar;
				outSql <<t;
				outSql <<appChar;
				return column->type_size;
			}break;
		case DB_DOUBLE:				// 双精度 double
			{
				if(maxDataLen < (sint32)(sizeof(double)+curPos)){
					gxError("User data not enough to convertion!");
					return -1;
				}
				double& t = *((double*)(data+curPos));
				outSql <<appChar;
				outSql <<t;
				outSql <<appChar;
				return column->type_size;
			}break;
		case DB_RAW_STR:				// 原生字符串 CFixArray
			{
				if(maxDataLen < (sint32)(column->type_size+curPos)){
					gxError("User data not enough to convertion!");
					return -1;
				}

				char* destStr = (char*)(data+curPos);
				outSql <<appChar;
				outSql <<destStr;
				outSql <<appChar;
				return column->type_size;
			}break;
		case DB_TINY_STR:					// 字符串 CCharArray[uint8]
			{
				if(maxDataLen < (sint32)(column->type_size+curPos)){
					gxError("User data not enough to convertion!");
					return -1;
				}

				//uint8& destLen = *((uint8*)(data+curPos));
				char* destStr = (char*)(data+curPos+sizeof(uint8));
				outSql <<appChar;
				outSql <<destStr;
				outSql <<appChar;
				return column->type_size;
			}break;
		case DB_STR:					// 字符串 CCharArray[uint16]
			{
				if(maxDataLen < (sint32)(column->type_size+curPos)){
					gxError("User data not enough to convertion!");
					return -1;
				}

				//uint16& destLen = *((uint16*)(data+curPos));
				char* destStr = (char*)(data+curPos+sizeof(uint16));
				outSql <<appChar;
				outSql <<destStr;
				outSql <<appChar;
				return column->type_size;
			}break;
		case DB_BIG_STR:					// 字符串 CCharArray[uint32]
			{
				if(maxDataLen < (sint32)(column->type_size+curPos)){
					gxError("User data not enough to convertion!ColumnName={0}", column->name);
					return -1;
				}

				//uint32& destLen = *((uint32*)(data+curPos));
				char* destStr = (char*)(data+curPos+sizeof(uint32));
				outSql <<appChar;
				outSql <<destStr;
				outSql <<appChar;
				return column->type_size;
			}break;
		case DB_DATETIME:			// 日期 TGameTime_t
			{
				if((mysqlpp::String::size_type)maxDataLen-curPos < column->type_size){
					gxError("User data not enough to convertion!ColumnName={0}", column->name);
					return -1;
				}
				gxAssert(sizeof(TGameTime_t) == column->type_size);
				CGameTime gameTime = *((TGameTime_t*)(data+curPos));
				outSql <<appChar;
				outSql <<std::string(gameTime);
				outSql <<appChar;
				return column->type_size;
			}break;
		case DB_OBJECT:				// 对象类型
			{
				uint8* structData = NULL;
				sint32 structDataSize = 0;
				TDBBuffer buffer;
				if(NULL != column->dataToDbFiledFuncPtr)
				{
					sint32 returnCode = column->dataToDbFiledFuncPtr(buffer, data+curPos, column->type_size, 0);
					if(returnCode <= 0)
					{
						gxError("Can't convert data to db filed!Str={0},ReturnCode={1},Name={2}",
							outSql.str().c_str(), returnCode, column->name);
						return -1;
					}

					structData = (uint8*)buffer.data();
					structDataSize = (sint32)buffer.size();
				}
				else
				{
					structData = data+curPos;
					structDataSize = column->type_size;
				}

				// 将二进制转换成text
				TDBBuffer dbStringBuffer;
				if(!structToDbString(dbStringBuffer, structData, structDataSize, column->db_version))
				{
					gxError("Can't convert data to db filed!Str={0},Name={1}",
						outSql.str().c_str(), column->name);
					return -1;
				}
				outSql <<appChar;
				outSql <<dbStringBuffer.data();
				outSql <<appChar;

				return column->type_size;
			}break;
		default:
			{
				gxAssertEx(false, "DBCol can't convert!Type={0},Name={1}", column->type, column->name);
				return -1;
			}
		}

		return -1;
		DB_END_RET(-1);
	}

	uint32 CSqlQueryBase::GetColSize(const TDbCol* column, unsigned char* data)
	{
		DB_BEGIN("DB_MOD;");
		return GetColInfo(column, data);
		DB_END_RET(0);
	}

	uint32 CSqlQueryBase::GetColInfo(const TDbCol* column, unsigned char* data)
	{
		DB_BEGIN("DB_MOD;");
		unsigned int retval = 0;

		if(column == NULL) return retval;

		const TDbCol *temp;
		temp = column;
		unsigned int maxoffset = 0;
		unsigned int maxoffset_size = 0;
		unsigned int ncursize = 0;

		while(temp->name)
		{
			// 			if(temp->type == DB_BIN2 || temp->type == DB_ZIP2)
			// 			{
			// 				if(temp->data_addr)
			// 				{
			// 					ncursize = 0;
			// 				}
			// 				else if(data)
			// 				{
			// 					ncursize = (sizeof(DWORD) + (*(DWORD*)(data + temp->data_offset)));
			// 				}
			// 				else
			// 				{
			// 					ncursize = sizeof(DWORD);
			// 				};
			// 			}
			// 			else
			{
				// 				if(temp->data_addr)
				// 				{
				// 					ncursize = 0;
				// 				}
				// 				else
				{
					ncursize = temp->type_size;
				}
			}

			retval += ncursize;
			maxoffset = std::max(maxoffset, temp->data_offset);
			maxoffset_size = std::max(maxoffset_size, temp->data_offset + ncursize);
			temp++;
		}

		retval = std::max(retval, maxoffset_size);
		if(temp->type_size > 0)
		{
			retval = std::max(retval, temp->type_size);
		}

		return retval;

		DB_END_RET(0);
	}

	const char * CSqlQueryBase::GetTypeString(uint32 type)
	{
		DB_BEGIN("DB_MOD;");
		const char *retval = "DB_NONE";

		switch(type)
		{
		case DB_BYTE:
			retval = "DB_BYTE";
			break;
		case DB_WORD:
			retval = "DB_WORD";
			break;
		case DB_DWORD:
			retval = "DB_DWORD";
			break;
		case DB_QWORD:
			retval = "DB_QWORD";
			break;
		case DB_FLOAT:
			retval = "DB_FLOAT";
			break;
		case DB_DOUBLE:
			retval = "DB_DOUBLE";
			break;
		case DB_RAW_STR :
			retval = "DB_RAW_STR";
			break;
		case DB_STR:
			retval = "DB_STR";
			break;
		case DB_DATETIME:
			retval = "DB_DATETIME";
			break;
		case DB_OBJECT:
			retval = "DB_OBJECT";
			break;
		case DB_BIN:
			retval = "DB_BIN";
			break;
		case DB_ZIP:
			retval = "DB_ZIP";
			break;
		case DB_BIN2:
			retval = "DB_BIN2";
			break;
		case DB_ZIP2:
			retval = "DB_ZIP2";
			break;
		default:
			retval = "UNKNOW";
			break;
		}

		return retval;

		DB_END_RET(NULL);
	}
	void CSqlQueryBase::DumpCol(const TDbCol *column, sint32 columnNum)
	{
		DB_BEGIN("DB_MOD;");
		const TDbCol *temp;
		temp = column;
		while(temp->name)
		{
			gxInfo("{{0},CSqlQueryBase::{1},{2},{3},NULL},", temp->name , GetTypeString(temp->type), temp->type_size, temp->data_offset);
			temp++;
		}
		DB_END_RET(DRET_NULL);
	}

	sint32 CSqlQueryBase::bindDataToDbFiled(const TDbCol *column, sint32 columnNum, void* data, sint32 maxDataLen){
		DB_BEGIN("DB_MOD;");

		return BindDataToDbFiled(column, columnNum, data, maxDataLen);

		DB_END_RET(-1);
	}

	sint32 CSqlQueryBase::BindDataToDbFiled( const TDbCol *column, sint32 columnNum, void* inputData, sint32 maxDataLen )
	{
		DB_BEGIN("DB_MOD;");

		if(column[columnNum-1].name == NULL)
		{
			columnNum--;
		}
		uint8* data = (uint8*)inputData;
		sint32 totalLen = 0;
		TDbCol * temp = (TDbCol *)column;
		for(sint32 i = 0; i < columnNum; ++i){
			if((uint32)(maxDataLen) < (temp[i].type_size+totalLen)){
				gxError("Can't bind data to db filed, user data len not enough!");
				return -1;
			}
			temp[i].data_addr = data+totalLen;
			totalLen += temp[i].type_size;
		}
		gxAssert(totalLen == maxDataLen);
		return totalLen;

		DB_END_RET(-1);
	}

	sint32 CSqlQueryBase::BindDataToDbFiled( TDbColVecs& columns, const TDbCol *column, sint32 columnNum, void* inputData, sint32 maxDataLen )
	{
		DB_BEGIN("DB_MOD;");

		sint32 columnTotalSize = GetColSize(column, NULL);
		sint32 recordNum = maxDataLen/columnTotalSize;
		gxAssert(maxDataLen%columnTotalSize == 0);

		if(column[columnNum-1].name == NULL)
		{
			columnNum--;
		}

		uint8* data = (uint8*)inputData;
		columns.resize(recordNum);
		sint32 totalLen = 0;
		for(sint32 i = 0; i < recordNum; ++i)
		{
			columns[i].resize(columnNum);
			for(sint32 j = 0; j < columnNum; ++j)
			{
				memcpy(&(columns[i][j]), column, sizeof(TDbCol));
			}
			TDbColFixAry dbCols;
			CSqlQueryBase::CloneDbCols(dbCols, &(columns[i][0]), columnNum, false);
			sint32 retCode = CSqlQueryBase::BindDataToDbFiled(dbCols.data(), columnNum, data+totalLen, columnTotalSize);
			if(retCode < 0){
				return retCode;
			}

			totalLen += retCode;
		}

		gxAssert(totalLen == maxDataLen);

		return totalLen;

		DB_END_RET(-1);
	}

	sint32 CSqlQueryBase::getCount(const char* tableName, const char* cond1, const char* cond2, const char* cond3,
		const char* cond4, const char* cond5)
	{
		DB_BEGIN("DB_MOD;");

		if(!tableName)
		{
			return 0;
		}

		uint32 count = 0;

		const TDbCol countColDef[] =
		{
			_DBC_SA_("RETCOUNT", DB_DWORD, count),
			_DBC_NULL_
		};

		std::string sql;
		sql = "SELECT COUNT(*) AS RETCOUNT FROM ";
		sql += tableName;
		sql += " ";
		if(strlen(cond1) != 0){
			sql += " WHERE ";
			sql += cond1;
			sql += " ";
		}
		if(strlen(cond2) != 0){
			sql += " AND ";
			sql += cond2;
			sql += " ";
		}
		if(strlen(cond3) != 0){
			sql += " AND ";
			sql += cond3;
			sql += " ";
		}
		if(strlen(cond4) != 0){
			sql += " AND ";
			sql += cond4;
			sql += " ";
		}
		if(strlen(cond5) != 0){
			sql += " AND ";
			sql += cond5;
			sql += " ";
		}
		sql += ";";
		if(selectExSql(sql.c_str(), countColDef, DCountOf(countColDef)) >= 0){
			return count;
		}

		DB_END_RET(0);
	}

	uint64 CSqlQueryBase::getInsertID()
	{
		// @todo 获取mysql的insertid
		return 0;
	}

	sint32 CSqlQueryBase::insertEx(const char* tableName, const TDbColAryVec& dbCols, bool duplicateKey)
	{
		DB_BEGIN("DB_MOD;")
		for(TDbColAryVec::size_type i = 0; i < dbCols.size(); ++i)
		{
			if(insertEx(tableName, dbCols[i].data(), (sint32)dbCols[i].size(), duplicateKey) < 0)
			{
				return -1;
			}
		}

		return 1;

		DB_END_RET(-1);
	}
	sint32 CSqlQueryBase::insertEx(const char* tableName, const GXMISC::TDbCol *column, sint32 columnNum, bool duplicateKey){
		DB_BEGIN("DB_MOD;")
			const TDbCol *temp = column;

		if(column[columnNum-1].name == NULL)
		{
			columnNum--;
		}

		std::ostringstream strSql;
		strSql << "INSERT INTO ";
		strSql << tableName;

		strSql << " (";
		bool first = true;
		while(temp->name)
		{
			if(temp->name[0] != 0)
			{
				if(first){
					first = false;
				}
				else{
					strSql << ", ";
				}
				strSql << "`";
				strSql << temp->name;
				strSql << "`";
			}

			temp++;
		}
		strSql << ")";

		strSql << " VALUES";
		strSql << "( ";
		temp = column;
		sint32 retCode= concatDataToSqlStr(strSql, temp, columnNum, false);
		if(retCode < 0){
			return retCode;
		}
		strSql << ")";

		// ON DUPLICATE KEY UPDATE 
		if(duplicateKey){
			// 重复key则执行更新
			strSql << " ON DUPLICATE KEY UPDATE ";
			temp = column;
			retCode = concatDataToSqlStr(strSql, temp, columnNum, true, false);
			if(retCode < 0){
				return retCode;
			}
		}

		strSql << ";";

		if(_openLog)
		{
			gxDebug("{0}", strSql.str());
		}
		_sqlString = strSql.str();

		if(executeUnret(strSql.str().c_str(), (sint32)strSql.str().length())){
			return 1;
		}

		return -1;

		DB_END_RET(-1);
	}

	sint32 CSqlQueryBase::insertEx(const char* tableName, const TDbCol *column, sint32 columnNum, const unsigned char *data
		, sint32 maxDataLen, bool duplicateKey)
	{
		DB_BEGIN("DB_MOD;");

		const TDbCol *temp = column;

		if(column[columnNum-1].name == NULL)
		{
			columnNum--;
		}

		std::ostringstream strSql;
		strSql << "INSERT INTO ";
		strSql << tableName;

		strSql << " (";
		bool first = true;
		while(temp->name)
		{
			if(temp->name[0] != 0)
			{
				if(first){
					first = false;
				}
				else{
					strSql << ",";
				}
				strSql << "`";
				strSql << temp->name;
				strSql << "`";
			}

			temp++;
		}
		strSql << ")";

		strSql << " VALUES";
		sint32 pos = 0;
		first = true;
		do{
			if(first){
				strSql << " (";
				first = false;
			}else{
				strSql << ",(";
			}
			unsigned char* tempData = (unsigned char*)(data+pos);
			temp = column;
			TDbColFixAry dbCols;
			CSqlQueryBase::CloneDbCols(dbCols, temp, columnNum, false);
			sint32 retCode = bindDataToDbFiled(dbCols.data(), columnNum, tempData, maxDataLen-pos);
			if(retCode < 0){
				return -1;
			}
			pos += retCode;

			retCode = concatDataToSqlStr(strSql, dbCols.data(), columnNum, false);
			if(retCode < 0){
				return -1;
			}
			strSql << ")";
		}while(pos < maxDataLen);

		int recordNum = maxDataLen/CSqlQueryBase::GetColSize(column, NULL);
		// ON DUPLICATE KEY UPDATE 
		// 只允许记录为1条的时候
		if(duplicateKey && recordNum == 1){
			// 重复key则执行更新
			strSql << " ON DUPLICATE KEY UPDATE ";
			sint32 pos = 0;
			do{
				unsigned char* tempData = (unsigned char*)(data+pos);
				temp = column;
				TDbColFixAry dbCols;
				CSqlQueryBase::CloneDbCols(dbCols, temp, columnNum, false);
				sint32 retCode = bindDataToDbFiled(dbCols.data(), columnNum, tempData, maxDataLen-pos);
				if(retCode < 0){
					return retCode;
				}
				pos += retCode;

				retCode = concatDataToSqlStr(strSql, dbCols.data(), columnNum, true, false);
				if(retCode < 0){
					return retCode;
				}
			}while(pos < maxDataLen);
		}

		strSql << ";";

		if(_openLog)
		{
			gxDebug("{0}", strSql.str());
		}
		_sqlString = strSql.str();

		if(executeUnret(strSql.str().c_str(), (sint32)strSql.str().length())){
			return 1;
		}

		return -1;

		DB_END_RET(-1);
	}

	sint32 CSqlQueryBase::deleteEx(const char* tableName, const char* cond1, const char* cond2, const char* cond3,
		const char* cond4, const char* cond5)
	{
		DB_BEGIN("DB_MOD;");

		std::string strSql = "DELETE FROM ";
		strSql += tableName;

		if(strlen(cond1) != 0)
		{
			strSql += " WHERE ";
			strSql += cond1;
			strSql += " ";
		}
		if(strlen(cond2) != 0){
			strSql += " AND ";
			strSql += cond2;
			strSql += " ";
		}
		if(strlen(cond3) != 0){
			strSql += " AND ";
			strSql += cond3;
			strSql += " ";
		}
		if(strlen(cond4) != 0){
			strSql += " AND ";
			strSql += cond4;
			strSql += " ";
		}
		if(strlen(cond5) != 0){
			strSql += " AND ";
			strSql += cond5;
			strSql += " ";
		}
		strSql += ";";

		if(_openLog)
		{
			gxDebug("{0}", strSql);
		}
		_sqlString = strSql;

		if(executeUnret(strSql.c_str(), (sint32)strSql.length())){
			return 1;
		}

		return -1;

		DB_END_RET(-1);
	}

	sint32 CSqlQueryBase::concatDataToSqlStr(std::ostringstream& sqlStr, const TDbCol *column, sint32 columnNum, bool needName, bool needKey)
	{
		DB_BEGIN("DB_MOD;");

		if(column[columnNum-1].name == NULL)
		{
			columnNum--;
		}

		bool first = true;
		const TDbCol *temp = NULL;
		temp = column;
		for(sint32 i = 0; i < columnNum; ++i)
		{
			if(temp[i].name != 0 && temp[i].canWrite())
			{
				if(!needKey && temp[i].isPrimary())
				{
					continue;
				}
				if(first){
					first = false;
				}else{
					sqlStr << ", ";
				}
				if(needName){
					sqlStr << "`";
					sqlStr << temp[i].name;
					sqlStr << "`";
					sqlStr << "=";
				}
				sint32 retCode = dataConvToDbFiled(sqlStr, &(temp[i]), (unsigned char*)temp[i].data_addr, (sint32)0, (sint32)temp[i].type_size);
				if( retCode < 0)
				{
					return -1;
				}
			}
		}

		return 0;

		DB_END_RET(-1);
	}

	sint32 CSqlQueryBase::updateEx(const char* tableName, const TDbCol *column, sint32 columnNum,
		const char* cond1, const char* cond2, const char* cond3, const char* cond4,
		const char* cond5)
	{
		DB_BEGIN("DB_MOD;");

		if(NULL == column || columnNum <= 0){
			gxError("Param is error!");
			return -1;
		}

		std::ostringstream tempSql;
		tempSql << "UPDATE " << tableName << " SET ";

		const TDbCol *temp = column;
		sint32 retCode = concatDataToSqlStr(tempSql, temp, columnNum);
		if(retCode < 0){
			return retCode;
		}

		if(strlen(cond1) != 0){
			tempSql << " WHERE " << cond1;
		}
		if(strlen(cond2) != 0){
			tempSql << " AND " << cond2;
		}
		if(strlen(cond3) != 0){
			tempSql << " AND " << cond3;
		}
		if(strlen(cond4) != 0){
			tempSql << " AND " << cond4;
		}
		if(strlen(cond5) != 0){
			tempSql << " AND " << cond5;
		}

		tempSql << ";";

		if(_openLog)
		{
			gxDebug("SqlStr={0}", tempSql.str());
		}
		_sqlString = tempSql.str();

		if(executeUnret(tempSql.str().c_str(), (sint32)tempSql.str().length())){
			return 1;
		}

		return -1;

		DB_END_RET(-1);
	}

	sint32 CSqlQueryBase::updateEx(const char* tableName, const TDbCol *column, sint32 columnNum, unsigned char *data, sint32 maxDataLen,
		const char* cond1, const char* cond2, const char* cond3, const char* cond4,
		const char* cond5)
	{
		DB_BEGIN("DB_MOD;");

		if(NULL == column || columnNum <= 0 || NULL == data || maxDataLen <= 0){
			gxError("Param is error!");
			return -1;
		}

		TDbColFixAry dbCols;
		CSqlQueryBase::CloneDbCols(dbCols, column, columnNum, false);
		sint32 retCode = bindDataToDbFiled(dbCols.data(), columnNum, (unsigned char*)(data), maxDataLen);
		if(retCode < 0){
			return retCode;
		}

		return updateEx(tableName, dbCols.data(), columnNum, cond1, cond2, cond3, cond4, cond5);

		DB_END_RET(-1);
	}

	sint32 GXMISC::CSqlQueryBase::updateEx( const char* tableName, TDbColAryVec& dbCols )
	{
		FUNC_BEGIN("DB_MOD;");

		for(TDbColAryVec::size_type i = 0; i < dbCols.size(); ++i){
			if(updateEx(tableName, dbCols[i].data(), dbCols[i].size()) < 0){
				return -1;
			}
		}

		return (sint32)dbCols.size();

		FUNC_END(-1);
	}

	sint32 GXMISC::CSqlQueryBase::updateEx( const char* tableName, TDbColAryVec& dbCols, const char* cond1 )
	{
		FUNC_BEGIN("DB_MOD;");

		for(TDbColAryVec::size_type i = 0; i < dbCols.size(); ++i){
			if(updateEx(tableName, dbCols[i].data(), dbCols[i].size(), cond1) < 0){
				return -1;
			}
		}

		return (sint32)dbCols.size();

		FUNC_END(-1);
	}

	sint32 GXMISC::CSqlQueryBase::updateEx( const char* tableName, TDbColAryVec& dbCols, const char* cond1, const char* cond2 )
	{
		FUNC_BEGIN("DB_MOD;");
		
		for(TDbColAryVec::size_type i = 0; i < dbCols.size(); ++i){
			if(updateEx(tableName, dbCols[i].data(), dbCols[i].size(), cond1, cond2) < 0){
				return -1;
			}
		}

		FUNC_END(-1);
	}

	sint32 GXMISC::CSqlQueryBase::updateEx( const char* tableName, TDbColAryVec& dbCols, const char* cond1, const char* cond2, const char* cond3 )
	{
		FUNC_BEGIN("DB_MOD;");

		for(TDbColAryVec::size_type i = 0; i < dbCols.size(); ++i){
			if(updateEx(tableName, dbCols[i].data(), dbCols[i].size(), cond1, cond2, cond3) < 0){
				return -1;
			}
		}

		FUNC_END(-1);
	}

	sint32 GXMISC::CSqlQueryBase::updateEx( const char* tableName, TDbColAryVec& dbCols, const char* cond1, const char* cond2, const char* cond3, const char* cond4 )
	{
		FUNC_BEGIN("DB_MOD;");

		for(TDbColAryVec::size_type i = 0; i < dbCols.size(); ++i){
			if(updateEx(tableName, dbCols[i].data(), dbCols[i].size(), cond1, cond2, cond3, cond4) < 0){
				return -1;
			}
		}

		FUNC_END(-1);
	}

	sint32 GXMISC::CSqlQueryBase::updateEx( const char* tableName, TDbColAryVec& dbCols, const char* cond1, const char* cond2,
		const char* cond3, const char* cond4, const char* cond5 )
	{
		FUNC_BEGIN("DB_MOD;");

		for(TDbColAryVec::size_type i = 0; i < dbCols.size(); ++i){
			if(updateEx(tableName, dbCols[i].data(), dbCols[i].size(), cond1, cond2, cond3, cond4, cond5) < 0){
				return -1;
			}
		}

		FUNC_END(-1);
	}

	void CSqlQueryBase::logSql()
	{
		FUNC_BEGIN("DB_MOD;");

		gxInfo("SqlStr={0}", _sqlString);

		FUNC_END(DRET_NULL);
	}

	bool CSqlQueryBase::CloneDbCols( TDbColFixAry& ary, const TDbCol *column, sint32 columnNum, bool memFlag )
	{
		FUNC_BEGIN("DB_MOD;");

		assert((uint32)columnNum <= ary.maxSize());
		if(memFlag)
		{
			memcpy(ary.data(), column, sizeof(TDbCol)*columnNum);
		}else
		{
			for(sint32 i = 0; i < columnNum; ++i)
			{
				ary[i] = *(column+i);
			}
		}

		return true;

		FUNC_END(false);
	}

//}