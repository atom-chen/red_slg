

void RegisterAll${prefix}(lua_State* L)
{
	#for jsclass in $sorted_classes
	#if $in_listed_classes(jsclass)
	lua_register_${prefix}_${jsclass}(L);
	#end if
	#end for
}

