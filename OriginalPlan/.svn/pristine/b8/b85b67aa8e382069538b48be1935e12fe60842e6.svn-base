#set generator = $current_class.generator
#set methods = $current_class.methods_cleans()
#set st_methods = $current_class.static_methods_clean()
#set members = $current_class.fields
#set parent = ""
#set endstr = ""
#set sp = ""
#if len($current_class.parents) > 0
	#set $parent = $current_class.parents[0].class_name
#end if
#if ($parent == "CRequestPacket" or $parent == "CResponsePacket" or $parent == "CServerPacket")
[$current_class.packet_id]={
#if $parent == "CRequestPacket"
	s={},
	c={
#else
	c={},
	s={
#if $parent == "CResponsePacket"
		{"result","int16"},
#end if
#end if
#set endstr = "}"
#set sp = "	"
#else
${current_class.class_name}={
#end if
	#for m in members
	#set typenum = len(m.itertype)
	${sp}{"${m.name}",#slurp
	#set memtype = m.itertype[$typenum-1]['type']
	#if $typenum > 1
"array",#slurp
	#end if
	#if $memtype == "base"
"${m.itertype[$typenum-1]['streamstr']}"},
	#else
"${m.itertype[$typenum-1]['typestr']}"},
	#end if
	#end for
	#if $endstr != ""
	${endstr}
	#end if
},
