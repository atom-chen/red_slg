require "api/lua/cpprootdir"
require "api/lua/cppapi"

do return{

Controller = {
  description = "",
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "Controller",
      valuetype = "Controller",
    },
    receiveExternalKeyEvent={
      description = "",
      type = "method",
      args="(int: externalKeyCode,bool: receive)",
      returns = "void",
      valuetype = "void"
    },
    getDeviceName={
      description = "",
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    isConnected={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getDeviceId={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    setTag={
      description = "",
      type = "method",
      args="(int: tag)",
      returns = "void",
      valuetype = "void"
    },
    getTag={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    startDiscoveryController={
	  description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    stopDiscoveryController={
	  description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getControllerByTag={
	  description = "",
      type = "method",
      args="(int: tag)",
      returns = "Controller*",
      valuetype = "Controller"
    },
  },
},

EventController = {
  description = "",
  type = "class",
  inherits = "Event ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "EventController",
      valuetype = "EventController",
    },
    getControllerEventType={
      description = "",
      type = "method",
      args="()",
      returns = "ControllerEventType",
      valuetype = "ControllerEventType"
    },
    setConnectStatus={
      description = "",
      type = "method",
      args="(bool: isConnected)",
      returns = "void",
      valuetype = "void"
    },
    isConnected={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setKeyCode={
      description = "",
      type = "method",
      args="(int: keyCode)",
      returns = "void",
      valuetype = "void"
    },
    getController={
      description = "",
      type = "method",
      args="()",
      returns = "Controller*",
      valuetype = "Controller"
    },
    getKeyCode={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
  },
},

EventListenerController = {
  description = "",
  type = "class",
  inherits = "EventListener ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "EventListenerController",
      valuetype = "EventListenerController",
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "EventListenerController*",
      valuetype = "EventListenerController"
    },
  },
},

}
end