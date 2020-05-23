#if $current_enum.stdcomment == True
-------------------------------------------------------
-- @class enum
-- @name $current_enum.enum_name
-- @description $current_enum.comments
-- @usage 
#if $current_enum.enum_name == "EGameRetCode"
$current_enum.enum_name = {
	#set values = $current_enum.values
	#for v in $values
		[$v.value] = "$v.comments",
    #end for
};
#else
$current_enum.enum_name = {
	#set values = $current_enum.values
	#for v in $values
		$v.name = $v.value,			----- $v.comments
    #end for
};
#end if

#end if