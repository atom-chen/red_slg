#include "core/time_manager.h"
#include "core/perfor_stat.h"

#include "script_engine_common.h"
#include "game_pos.h"
#include "base_packet_def.h"
#include "curl_util.h"
#include "md5_ext.h"
#include "game_rand.h"
#include "constant_tbl.h"


void luaScriptTest(int* a, TAxisPos* pos)
{
	gxDebug("a={0},x={1},y={2}", *a, pos->x, pos->y);
}

std::string luaURLRequest(std::string url)
{
	TUrlDownFile urlFile;
	GetUrlFile(urlFile, url.c_str(), "", "", false);
	urlFile.buff[urlFile.curLen] = 0;
	return urlFile.buff;
}
// MD5
std::string luaMD5(std::string str)
{
	std::string md5Msg;
	MD5_DIGEST realMD5Str;
	if(MD5String(str.c_str(), &realMD5Str))
	{
		for(uint32 i = 0; i < sizeof(MD5_DIGEST); ++i)
		{
			md5Msg += GXMISC::gxToString("%.2x", realMD5Str[i]);
		}
	}

	return md5Msg;
}

// 得到随机器
CRandGen* luaRand()
{
	return &DRandGen;
}
// 得到随机数
sint32 luaRandNum(sint32 minNum, sint32 maxNum)
{
	return DRandGen.getRand(minNum, maxNum);
}

// 得到常量
sint32 luaGetConstantInt(const sint32 indexString)
{
	return GetConstant<sint32>(indexString);
}
// 得到字符串常量
std::string luaGetConstantString(const sint32 indexString)
{
	return GetConstant<std::string>(indexString);
}

// 得到当前系统时间
GXMISC::TGameTime_t luaGetTime()
{
	return DTimeManager.nowSysTime();
}

// 输出性能统计数据
void luaPrefStop()
{
	GXMISC::PerfStop();
}

// 性能统计数据刷新
void luaPrefFlush()
{
	GXMISC::PerfFlush();
}

bool ShareLibraryBindFunc(CScriptEngineCommon::TScriptState* pState)
{
	// 脚本测试
// 	lua_tinker::def(pState, "luaScriptTest", &luaScriptTest);
// 
// 	// 第三方函数
// 	lua_tinker::def(pState, "luaURLRequest", &luaURLRequest);
// 	lua_tinker::def(pState, "luaMD5", &luaMD5);
// 
// 	// 基础函数
// 	lua_tinker::def(pState, "luaRand", &luaRand);
// 	lua_tinker::def(pState, "luaRandNum", &luaRandNum);
// 	lua_tinker::def(pState, "luaGetConstInt", &luaGetConstantInt);
// 	lua_tinker::def(pState, "luaGetConstStr", &luaGetConstantString);
// 	lua_tinker::def(pState, "luaGetTime", &luaGetTime);
// 	lua_tinker::def(pState, "luaPrefStop", &luaPrefStop);
// 	lua_tinker::def(pState, "luaPrefFlush", &luaPrefFlush);

	return true;
}