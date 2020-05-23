#ifndef _SCRIPT_LIBRARY_HEADER_H_
#define _SCRIPT_LIBRARY_HEADER_H_

#include "script_engine_common.h"

bool ShareLibraryBindClass(CScriptEngineCommon::TScriptState* pState);
bool ShareLibraryBindFunc(CScriptEngineCommon::TScriptState* pState);
bool sharelibAutoBindClass(CScriptEngineCommon::TScriptState* pState);

#endif	// _SCRIPT_LIBRARY_HEADER_H_