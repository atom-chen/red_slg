#set generator = $current_class.generator
#set methods = $current_class.methods_clean()
#set st_methods = $current_class.static_methods_clean()
#
static void lua_register_${generator.prefix}_${current_class.class_name}(lua_State* L)
{
        lua_tinker::class_add<${current_class.namespaced_class_name}>(L,"${current_class.class_name}");
    #set $count = 0
    #set $basenum = len($current_class.parents)
    #while $count < $basenum
        lua_tinker::class_inh<${current_class.namespaced_class_name}, $current_class.parents[$count].namespaced_class_name>(L);
        #set $count = $count + 1
    #end while
    #for m in methods
        #set fn = m['impl']
		lua_tinker::class_def<${current_class.namespaced_class_name}>(L, "${m['name']}", &${current_class.namespaced_class_name}::${m['name']});
    #end for
    #for m in st_methods
        #set fn = m['impl']
		lua_tinker::class_def<${current_class.namespaced_class_name}>(L, "${m['name']}", &${current_class.namespaced_class_name}::${m['name']});
    #end for
}
