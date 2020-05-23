#set has_constructor = False
#if $current_class.methods.has_key('constructor')
#set has_constructor = True
#end if
#
#set generator = $current_class.generator
#set methods = $current_class.methods_clean()
#set st_methods = $current_class.static_methods_clean()

${current_class.class_name} = {
#if $current_class.desc
  description = $current_class.desc,
#end if
  type = "class",
#if len($current_class.parents) > 0
  #set parents = $current_class.parents
  #set instr = ""
  #for m in parents
  #set $instr = $instr+$generator.get_class_or_rename_class($m.class_name)+" "
  #end for
  inherits = "$instr",
#end if
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "${current_class.class_name}",
      valuetype = "${current_class.class_name}",
    },
#if len($methods) or len($st_methods)
  #for m in methods
    #set mimpl = m['impl']
    #if mimpl.is_override != True
    ${m['name']}={
      #if mimpl.desc
      description = #mimpl.desc,
      #end if
      type = "method",
      #set argstr = "("
      #set $count = 0
      #while $count < len(mimpl.arguments)
      #if $argstr != "("
      #set $argstr = $argstr+","
      #end if
      #set $argstr = $argstr+$mimpl.arguments[$count].name.replace('std::', '')+": "+$mimpl.argumtntTips[$count]
      #set $count = $count+1
      #end while
      args="$argstr)",
      returns = "${mimpl.ret_type.name.replace('std::', '')}",
      valuetype = "${mimpl.ret_type.name.replace('*', '').replace('std::', '')}"
    },
    #end if
  #end for
  #for m in st_methods
    #set mimpl = m['impl']
    #if mimpl.is_override != True
    ${m['name']}={
      #if mimpl.desc
      description = #mimpl.desc,
      #end if
      type = "method",
      #set argstr = "("
      #set $count = 0
      #while $count < len(mimpl.arguments)
      #if $argstr != "("
      #set $argstr = $argstr+","
      #end if
      #set $argstr = $argstr+$mimpl.arguments[$count].name.replace('std::', '')+": "+$mimpl.argumtntTips[$count]
      #set $count = $count+1
      #end while
      args="$argstr)",
      returns = "${mimpl.ret_type.name.replace('std::', '')}",
      valuetype = "${mimpl.ret_type.name.replace('*', '').replace('std::', '')}"
    },
    #end if
  #end for
#end if
  },
},
