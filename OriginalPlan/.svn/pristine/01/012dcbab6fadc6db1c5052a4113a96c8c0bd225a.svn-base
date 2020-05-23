require "api/lua/cpprootdir"
require "api/lua/cppapi"

do return{

AudioProfile = {
  description = "",
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "AudioProfile",
      valuetype = "AudioProfile",
    },
  },
},

AudioEngine = {
  description = "",
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "AudioEngine",
      valuetype = "AudioEngine",
    },
    lazyInit={
	  description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setCurrentTime={
	  description = "",
      type = "method",
      args="(int: audioID,float: time)",
      returns = "bool",
      valuetype = "bool"
    },
    getVolume={
	  description = "",
      type = "method",
      args="(int: audioID)",
      returns = "float",
      valuetype = "float"
    },
    uncache={
	  description = "",
      type = "method",
      args="(string: filePath)",
      returns = "void",
      valuetype = "void"
    },
    resumeAll={
	  description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    stopAll={
	  description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    pause={
	  description = "",
      type = "method",
      args="(int: audioID)",
      returns = "void",
      valuetype = "void"
    },
    end={
	  description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getMaxAudioInstance={
	  description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getCurrentTime={
	  description = "",
      type = "method",
      args="(int: audioID)",
      returns = "float",
      valuetype = "float"
    },
    setMaxAudioInstance={
	  description = "",
      type = "method",
      args="(int: maxInstances)",
      returns = "bool",
      valuetype = "bool"
    },
    isLoop={
	  description = "",
      type = "method",
      args="(int: audioID)",
      returns = "bool",
      valuetype = "bool"
    },
    pauseAll={
	  description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    uncacheAll={
	  description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    setVolume={
	  description = "",
      type = "method",
      args="(int: audioID,float: volume)",
      returns = "void",
      valuetype = "void"
    },
    play2d={
	  description = "",
      type = "method",
      args="(string: filePath,bool: loop,float: volume,AudioProfile*: profile)",
      returns = "int",
      valuetype = "int"
    },
    getState={
	  description = "",
      type = "method",
      args="(int: audioID)",
      returns = "AudioState",
      valuetype = "AudioState"
    },
    resume={
	  description = "",
      type = "method",
      args="(int: audioID)",
      returns = "void",
      valuetype = "void"
    },
    stop={
	  description = "",
      type = "method",
      args="(int: audioID)",
      returns = "void",
      valuetype = "void"
    },
    getDuration={
	  description = "",
      type = "method",
      args="(int: audioID)",
      returns = "float",
      valuetype = "float"
    },
    setLoop={
	  description = "",
      type = "method",
      args="(int: audioID,bool: loop)",
      returns = "void",
      valuetype = "void"
    },
    getDefaultProfile={
	  description = "",
      type = "method",
      args="()",
      returns = "AudioProfile*",
      valuetype = "AudioProfile"
    },
  },
},

}
end