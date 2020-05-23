#set generator = $current_class.generator
#set methods = $current_class.methods_cleans()
#set st_methods = $current_class.static_methods_clean()
#set members = $current_class.fields;

#set parent = ""
#if len($current_class.parents) > 0
	#set $parent = $current_class.parents[0].class_name
#end if
#if ($parent == "CRequestPacket" or $parent == "CResponsePacket" or $parent == "CServerPacket")

------------------------${current_class.ref_commments}------------------------
#if $parent == "CRequestPacket"
${current_class.class_name} = class("${current_class.class_name}", BaseRequest)
#else
${current_class.class_name} = class("${current_class.class_name}", BaseResponse)
#end if
${current_class.class_name}.PackID = $current_class.packet_id;
_G.Protocol["${current_class.class_name}"] = $current_class.packet_id;
_G.Protocol[$current_class.packet_id] = "${current_class.class_name}";
#else
${current_class.class_name} = class("${current_class.class_name}", BaseStruct)
#end if
#if 1
function ${current_class.class_name}:ctor()
	#for m in members
	#if len(m.itertype) > 1
	#if m.itertype[len(m.itertype)-1]['type'] == 'class'
	--! $m.itertype[len(m.itertype)-1]['typestr']
	#end if
	self.${m.name} = {};        -------- $m.comments
	#else
    #if m.itertype[0]['type'] == 'class'
	--! $m.itertype[0]['typestr']
    #end if
	self.${m.name} = nil;       -------- $m.comments
	#end if
	#end for
end
#end if

function ${current_class.class_name}:Read(stream)
	#for m in members
	#set typenum = len(m.itertype)
	#set count = 0;
	#set sp = ""
	#while $count < ($typenum-1)
	#set sppc = 0
	#while $sppc < $count
		#set $sp = $sp+"    "
		#set $sppc = $sppc + 1
	#end while
	#if $count == 0
	${sp}local _${m.name}_${count}_t = {};		-------- $m.comments
	#else
	${sp}local _${m.name}_${count}_t = {};
	#end if
	${sp}local _${m.name}_${count}_len = stream:read${m.itertype[$count]['streamstr']}();
	${sp}for _$count=1,_${m.name}_${count}_len,1 do
	#set $count = $count + 1
	#end while
	#set memtype = m.itertype[$typenum-1]['type']
	#if $count > 0
	#set $sp = $sp+"    "
	#if $memtype == "base"
	${sp}table.insert(_${m.name}_${count-1}_t, stream:read${m.itertype[$typenum-1]['streamstr']}());
	#else
	${sp}local _${m.name}_${typenum}_o = ${m.itertype[$typenum-1]['typestr']}.new();
	${sp}_${m.name}_${typenum}_o:Read(stream);
	${sp}table.insert(_${m.name}_${count-1}_t, _${m.name}_${typenum}_o);
	#end if
	#else
	#if $memtype == "base"
	${sp}self.${m.name} = stream:read${m.itertype[$typenum-1]['streamstr']}();		-------- $m.comments
	#else
	${sp}self.${m.name} = ${m.itertype[$typenum-1]['typestr']}.new();		-------- $m.comments
	${sp}self.${m.name}:Read(stream);
	#end if
	#end if 
	#set count = $typenum-1;
	#while $count > 0
		#set sppc = 0
		#set sp = ""
		#while $sppc < ($count-1)
			#set $sp = $sp+"    "
			#set $sppc = $sppc + 1
		#end while
	${sp}end
	#if $count > 1
	${sp}table.insert(_${m.name}_${count-2}_t, _${m.name}_${count-1}_t);
	#end if
	#set $count = $count - 1
	#end while
	#if $typenum > 1
	self.${m.name} = _${m.name}_0_t;
	#end if
	#end for
end

function ${current_class.class_name}:Write(stream)
	#for m in members
	#set typenum = len(m.itertype)
	#set count = 0;
	#set sp = ""
	#if $typenum > 1
	local _${m.name}_0_t = self.${m.name}; ## ------self.${m.name}
	#end if
	#while $count < ($typenum-1)
	#set sppc = 0
	#while $sppc < $count
		#set $sp = $sp+"    "
		#set $sppc = $sppc + 1
	#end while
	${sp}stream:write${m.itertype[$count]['streamstr']}(#_${m.name}_${count}_t)
	${sp}for _,_${m.name}_${count+1}_t in pairs(_${m.name}_${count}_t) do
	#set $count = $count + 1
	#end while
	#set memtype = m.itertype[$typenum-1]['type']
	#if $count > 0
	#set $sp = $sp+"    "
	#if $memtype == "base"
	${sp}stream:write${m.itertype[$typenum-1]['streamstr']}(_${m.name}_${count}_t);
	#else
	${sp}_${m.name}_${count}_t:Write(stream);
	#end if
	#else
	#if $memtype == "base"
	${sp}stream:write${m.itertype[$typenum-1]['streamstr']}(self.${m.name}); ## ------self.${m.name}
	#else
	${sp}self.${m.name}:Write(stream);
	#end if
	#end if
	#set count = $typenum-1;
	#while $count > 0
		#set sppc = 0
		#set sp = ""
		#while $sppc < ($count-1)
			#set $sp = $sp+"    "
			#set $sppc = $sppc + 1
		#end while
	${sp}end
	#set $count = $count - 1
	#end while
	#end for
end