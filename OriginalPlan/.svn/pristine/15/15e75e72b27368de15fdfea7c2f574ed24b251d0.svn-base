#include "core/game_exception.h"

#include "gm_manager.h"
#include "gm_string_parse.h"
#include "map_server_instance.h"
#include "role.h"
#include "map_server.h"
#include "module_def.h"
#include "script_engine.h"

CGmCmdFunc::CGmCmdFunc()
{
}

CGmCmdFunc::~CGmCmdFunc()
{
}

EGameRetCode CGmCmdFunc::parse( CRole* pRole, TGmCmdStr_t& str )
{
	FUNC_BEGIN(GM_MOD);

	gxAssert(pRole);
	if ( pRole == NULL )
	{
		return RC_FAILED;
	}

	TGmCmdStr_t gmStr = str.toString();
	EGameRetCode retCode = DGmParseMgr.parseGmCmd(gmStr.data(), _gmHeadStr.c_str());
	if ( retCode != RC_SUCCESS )
	{
		return retCode;
	}
	if(DScriptEngine.bCall("IsGmExist", DGmParseMgr.getGmCmdKeyName())){
		// 脚本模块的GM命令存在
		retCode = RC_FAILED;
		if(DScriptEngine.call("HandleGmString", false, pRole, str.toString())){
			retCode = RC_SUCCESS;
		}
	}else
	{
		return RC_GM_CMD_NOT_FIND_GM_NAME;
	}

	if ( g_MapServer->isGmLog() )
	{
		gxGm("Gm str {0}, retCode = {1}, role info: {2}", str.toString(), (sint32)retCode, pRole->toString());
	}	

	return retCode;

	FUNC_END(RC_FAILED);
}

void CGmCmdFunc::init( const std::string& str )
{
	_gmHeadStr = str;
}
