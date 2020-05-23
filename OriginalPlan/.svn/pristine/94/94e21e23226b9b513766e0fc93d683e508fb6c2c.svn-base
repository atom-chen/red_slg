#ifndef _TBL_TEST_H_
#define _TBL_TEST_H_


class CTestTbl : public CConfigTbl
{
public:
	uint32 id;							///< ½ÇÉ«±àºÅ

public:
	DMultiIndexImpl1(uint32, id, 0);
	DObjToString(CTestTbl, uint32, id);
};

class  CTestTblLoader :
	public CConfigLoader<CTestTblLoader, CTestTbl>
{
public:
	virtual bool readRow(const lua_tinker::s_object& row, sint32 count, CTestTbl* destRow) override
	{
		gxInfo("test config={0}", row.get<sint32>("npcId"));
		gxInfo("test config={0}", row.get<sint32>("entry"));
		gxInfo("test config={0}", row.get<sint32>("res_id"));
		std::vector<sint32> ary = row.get<std::vector<sint32>>("ary");
		std::vector<std::string> arys = row.get<std::vector<std::string>>("arys");
		std::map<sint32, std::string> maps = row.get<std::map<sint32, std::string>>("arys");
		return true;
	}
};

#endif