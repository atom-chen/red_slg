require "api/lua/cpprootdir"
require "api/lua/cppapi"

do return{

SimpleAudioEngine = {
  description = "",
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "SimpleAudioEngine",
      valuetype = "SimpleAudioEngine",
    },
    preloadMusic={
      description = "",
      type = "method",
      args="(char*: pszFilePath)",
      returns = "void",
      valuetype = "void"
    },
    stopMusic={
      description = "",
      type = "method",
      args="(bool: bReleaseData)",
      returns = "void",
      valuetype = "void"
    },
    stopAllEffects={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getMusicVolume={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    resumeMusic={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    setMusicVolume={
      description = "",
      type = "method",
      args="(float: volume)",
      returns = "void",
      valuetype = "void"
    },
    preloadEffect={
      description = "",
      type = "method",
      args="(char*: pszFilePath)",
      returns = "void",
      valuetype = "void"
    },
    isMusicPlaying={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getEffectsVolume={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    willPlayMusic={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    pauseEffect={
      description = "",
      type = "method",
      args="(unsigned int: nSoundId)",
      returns = "void",
      valuetype = "void"
    },
    playEffect={
      description = "",
      type = "method",
      args="(char*: pszFilePath,bool: bLoop,float: pitch,float: pan,float: gain)",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    rewindMusic={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    playMusic={
      description = "",
      type = "method",
      args="(char*: pszFilePath,bool: bLoop)",
      returns = "void",
      valuetype = "void"
    },
    resumeAllEffects={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    setEffectsVolume={
      description = "",
      type = "method",
      args="(float: volume)",
      returns = "void",
      valuetype = "void"
    },
    stopEffect={
      description = "",
      type = "method",
      args="(unsigned int: nSoundId)",
      returns = "void",
      valuetype = "void"
    },
    pauseMusic={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    pauseAllEffects={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    unloadEffect={
      description = "",
      type = "method",
      args="(char*: pszFilePath)",
      returns = "void",
      valuetype = "void"
    },
    resumeEffect={
      description = "",
      type = "method",
      args="(unsigned int: nSoundId)",
      returns = "void",
      valuetype = "void"
    },
    destroyInstance={
	  description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getInstance={
	  description = "",
      type = "method",
      args="()",
      returns = "SimpleAudioEngine*",
      valuetype = "SimpleAudioEngine"
    },
  },
},

}
end