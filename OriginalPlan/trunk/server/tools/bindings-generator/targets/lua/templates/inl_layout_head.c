\#include "script_lua_inc.h"
\#include "lua_tinker.h"
\#include "tolua++.h"
\#include "lua_base_conversions.h"
\#include "lua_base_conversions_impl.h"
\#include "tolua_fix.h"


#for header in $headers
\#include "${os.path.basename(header)}"
#end for
