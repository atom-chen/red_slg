#ifndef _MAP_DB_ROLE_PROCESS_H_
#define _MAP_DB_ROLE_PROCESS_H_

#include "map_db_common.h"
#include "map_db_item.h"
#include "map_db_role_data.h"
#include "map_db_mission.h"

/// 玩家整个数据结构
struct CHumanDBData : public GXMISC::TDBStructBase
{
public:
	CHumanBaseData				baseData;			///< 玩家基础数据
//	CHumanBagItemData			bagitemData;		///< 背包数据
//	CHumanMissionData			missionData;		///< 任务数据

	// 保存到文件中, 直接保存整个结构体
public:
	bool dumpToFile(FILE* pf);
	bool dumpFromFile(FILE* pf);

public:
	void getUserData(CWorldUserData* data);
};

/// 角色基础属性
class CHumanDBBaseLoad : public CDBLoadBase
{
public:
	CHumanBaseData*	_data;

public:
	CHumanDBBaseLoad()
	{
		cleanUp();
	}

	void initData( CHumanBaseData* data )
	{
		_data = data;
	}

	void cleanUp()
	{
		_data = NULL;
	}

public:
	static void GenDbColAry(GXMISC::TDbColAry& cols, TRoleUID_t& roleUID, GXMISC::TDBVersion_t& version,
		CHumanBaseData& data, bool loadFlag = false);
	static void GenRmbDbColAry(GXMISC::TDbColAry& cols, TRoleUID_t& roleUID, GXMISC::TDBVersion_t& version,
		CHumanBaseData& data);

protected:
	virtual bool load(mysqlpp::Connection * conn);							// 加载数据
	virtual bool save(mysqlpp::Connection * conn, bool offlineFlag);		// 保存数据

public:
	std::string toString();
};

class CHumanDBMissionLoad : public CDBLoadBase
{
public:
	CHumanMissionData* data;

public:
	CHumanDBMissionLoad()
	{
		cleanUp();
	}

	void initData(CHumanMissionData* data)
	{
		this->data = data;
	}

	void cleanUp()
	{
		this->data = NULL;
	}

protected:
	virtual bool load(mysqlpp::Connection * conn);							// 加载数据
	virtual bool save(mysqlpp::Connection * conn, bool offlineFlag);		// 保存数据
};

class CHumanDBBackup;
// 角色数据库结构
class CHumanDB : public CDBLoadBase
{
public:
	typedef CDBLoadBase TBaseType;

public:
	CHumanDB();
	~CHumanDB();

public:
	ESaveRoleType saveDataType;

public:
	void initData(CHumanDBData* dbData);
	void cleanUp();
	void initLoad();
	void initHumanDBBackup(CHumanDBBackup* dbData);
	void initBufferData(const char* buffer, sint32 len);
public:
	ESaveRoleType getSaveDataType() const;
	void setSaveDataType(ESaveRoleType val);

public:
	CHumanDBData* getHumanDbData() const;
	CHumanBaseData* getBaseData() const;
	const char* getDataBuffer() const;
	void setDataBuffer(const char* buff, sint32 len);
public:
	bool roleIsExist(TRoleUID_t roleUID);
	bool dumpToFile(std::string path);
	bool dumpFromFile(std::string path);
	static std::string GenDBFileName(TRoleUID_t roleUID);

protected:
	virtual bool load(mysqlpp::Connection * conn);						// 加载数据
	virtual bool save(mysqlpp::Connection * conn, bool offlineFlag);    // 保存数据
	
public:
	CHumanDBBaseLoad baseLoad;									// 基本数据
//	CHunmanDBBagItemLoad bagitemLoad;							// 背包
	CHumanDBMissionLoad missionLoad;							// 任务

public:
	const std::string toString();

protected:
	ESaveRoleType _saveDataType;
	CHumanDBData* _dbData;
	std::string _buffer;
};

/// 角色数据库对象
class CHumanDBBackup : public CHumanDB
{
public:
	CHumanDBBackup(){
		_dbData = &_dbDataAll;
	}
	~CHumanDBBackup(){}

public:
	void initHumanData(CHumanDB* data);
	
private:
	CHumanDBData _dbDataAll;
};

#endif	// _MAP_DB_ROLE_PROCESS_H_