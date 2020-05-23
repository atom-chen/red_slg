require "api/lua/cpprootdir"
require "api/lua/cppapi"

do return{

CCBAnimationManager = {
  description = "",
  type = "class",
  inherits = "Ref ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CCBAnimationManager",
      valuetype = "CCBAnimationManager",
    },
    moveAnimationsFromNode={
      description = "",
      type = "method",
      args="(Node*: fromNode,Node*: toNode)",
      returns = "void",
      valuetype = "void"
    },
    setAutoPlaySequenceId={
      description = "",
      type = "method",
      args="(int: autoPlaySequenceId)",
      returns = "void",
      valuetype = "void"
    },
    getDocumentCallbackNames={
      description = "",
      type = "method",
      args="()",
      returns = "vector<cocos2d::Value, allocator<cocos2d::Value> >",
      valuetype = "vector<cocos2d::Value, allocator<cocos2d::Value> >"
    },
    actionForSoundChannel={
      description = "",
      type = "method",
      args="(CCBSequenceProperty*: channel)",
      returns = "Sequence*",
      valuetype = "Sequence"
    },
    setBaseValue={
      description = "",
      type = "method",
      args="(Value: value,Node*: pNode,string: propName)",
      returns = "void",
      valuetype = "void"
    },
    getDocumentOutletNodes={
      description = "",
      type = "method",
      args="()",
      returns = "Vector<cocos2d::Node *>",
      valuetype = "Vector<cocos2d::Node >"
    },
    getLastCompletedSequenceName={
      description = "",
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    setRootNode={
      description = "",
      type = "method",
      args="(Node*: pRootNode)",
      returns = "void",
      valuetype = "void"
    },
    runAnimationsForSequenceNamedTweenDuration={
      description = "",
      type = "method",
      args="(char*: pName,float: fTweenDuration)",
      returns = "void",
      valuetype = "void"
    },
    addDocumentOutletName={
      description = "",
      type = "method",
      args="(string: name)",
      returns = "void",
      valuetype = "void"
    },
    getSequences={
      description = "",
      type = "method",
      args="()",
      returns = "Vector<cocosbuilder::CCBSequence *>",
      valuetype = "Vector<cocosbuilder::CCBSequence >"
    },
    getRootContainerSize={
      description = "",
      type = "method",
      args="()",
      returns = "Size",
      valuetype = "Size"
    },
    setDocumentControllerName={
      description = "",
      type = "method",
      args="(string: name)",
      returns = "void",
      valuetype = "void"
    },
    setObject={
      description = "",
      type = "method",
      args="(Ref*: obj,Node*: pNode,string: propName)",
      returns = "void",
      valuetype = "void"
    },
    getContainerSize={
      description = "",
      type = "method",
      args="(Node*: pNode)",
      returns = "Size",
      valuetype = "Size"
    },
    actionForCallbackChannel={
      description = "",
      type = "method",
      args="(CCBSequenceProperty*: channel)",
      returns = "Sequence*",
      valuetype = "Sequence"
    },
    getDocumentOutletNames={
      description = "",
      type = "method",
      args="()",
      returns = "vector<cocos2d::Value, allocator<cocos2d::Value> >",
      valuetype = "vector<cocos2d::Value, allocator<cocos2d::Value> >"
    },
    addDocumentCallbackControlEvents={
      description = "",
      type = "method",
      args="(EventType: eventType)",
      returns = "void",
      valuetype = "void"
    },
    init={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getKeyframeCallbacks={
      description = "",
      type = "method",
      args="()",
      returns = "vector<cocos2d::Value, allocator<cocos2d::Value> >",
      valuetype = "vector<cocos2d::Value, allocator<cocos2d::Value> >"
    },
    getDocumentCallbackControlEvents={
      description = "",
      type = "method",
      args="()",
      returns = "vector<cocos2d::Value, allocator<cocos2d::Value> >",
      valuetype = "vector<cocos2d::Value, allocator<cocos2d::Value> >"
    },
    setRootContainerSize={
      description = "",
      type = "method",
      args="(Size: rootContainerSize)",
      returns = "void",
      valuetype = "void"
    },
    runAnimationsForSequenceIdTweenDuration={
      description = "",
      type = "method",
      args="(int: nSeqId,float: fTweenDuraiton)",
      returns = "void",
      valuetype = "void"
    },
    getRunningSequenceName={
      description = "",
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
    getAutoPlaySequenceId={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    addDocumentCallbackName={
      description = "",
      type = "method",
      args="(string: name)",
      returns = "void",
      valuetype = "void"
    },
    getRootNode={
      description = "",
      type = "method",
      args="()",
      returns = "Node*",
      valuetype = "Node"
    },
    addDocumentOutletNode={
      description = "",
      type = "method",
      args="(Node*: node)",
      returns = "void",
      valuetype = "void"
    },
    getSequenceDuration={
      description = "",
      type = "method",
      args="(char*: pSequenceName)",
      returns = "float",
      valuetype = "float"
    },
    addDocumentCallbackNode={
      description = "",
      type = "method",
      args="(Node*: node)",
      returns = "void",
      valuetype = "void"
    },
    runAnimationsForSequenceNamed={
      description = "",
      type = "method",
      args="(char*: pName)",
      returns = "void",
      valuetype = "void"
    },
    getSequenceId={
      description = "",
      type = "method",
      args="(char*: pSequenceName)",
      returns = "int",
      valuetype = "int"
    },
    getDocumentCallbackNodes={
      description = "",
      type = "method",
      args="()",
      returns = "Vector<cocos2d::Node *>",
      valuetype = "Vector<cocos2d::Node >"
    },
    setSequences={
      description = "",
      type = "method",
      args="(Vector<cocosbuilder::CCBSequence *>: seq)",
      returns = "void",
      valuetype = "void"
    },
    debug={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getDocumentControllerName={
      description = "",
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
  },
},

CCBReader = {
  description = "",
  type = "class",
  inherits = "Ref ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CCBReader",
      valuetype = "CCBReader",
    },
    addOwnerOutletName={
      description = "",
      type = "method",
      args="(string: name)",
      returns = "void",
      valuetype = "void"
    },
    getOwnerCallbackNames={
      description = "",
      type = "method",
      args="()",
      returns = "vector<cocos2d::Value, allocator<cocos2d::Value> >",
      valuetype = "vector<cocos2d::Value, allocator<cocos2d::Value> >"
    },
    addDocumentCallbackControlEvents={
      description = "",
      type = "method",
      args="(EventType: eventType)",
      returns = "void",
      valuetype = "void"
    },
    setCCBRootPath={
      description = "",
      type = "method",
      args="(char*: ccbRootPath)",
      returns = "void",
      valuetype = "void"
    },
    addOwnerOutletNode={
      description = "",
      type = "method",
      args="(Node*: node)",
      returns = "void",
      valuetype = "void"
    },
    getOwnerCallbackNodes={
      description = "",
      type = "method",
      args="()",
      returns = "Vector<cocos2d::Node *>",
      valuetype = "Vector<cocos2d::Node >"
    },
    readSoundKeyframesForSeq={
      description = "",
      type = "method",
      args="(CCBSequence*: seq)",
      returns = "bool",
      valuetype = "bool"
    },
    getCCBRootPath={
      description = "",
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    getOwnerCallbackControlEvents={
      description = "",
      type = "method",
      args="()",
      returns = "vector<cocos2d::Value, allocator<cocos2d::Value> >",
      valuetype = "vector<cocos2d::Value, allocator<cocos2d::Value> >"
    },
    getOwnerOutletNodes={
      description = "",
      type = "method",
      args="()",
      returns = "Vector<cocos2d::Node *>",
      valuetype = "Vector<cocos2d::Node >"
    },
    readUTF8={
      description = "",
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    addOwnerCallbackControlEvents={
      description = "",
      type = "method",
      args="(EventType: type)",
      returns = "void",
      valuetype = "void"
    },
    getOwnerOutletNames={
      description = "",
      type = "method",
      args="()",
      returns = "vector<cocos2d::Value, allocator<cocos2d::Value> >",
      valuetype = "vector<cocos2d::Value, allocator<cocos2d::Value> >"
    },
    setActionManager={
      description = "",
      type = "method",
      args="(CCBAnimationManager*: pAnimationManager)",
      returns = "void",
      valuetype = "void"
    },
    readCallbackKeyframesForSeq={
      description = "",
      type = "method",
      args="(CCBSequence*: seq)",
      returns = "bool",
      valuetype = "bool"
    },
    getAnimationManagersForNodes={
      description = "",
      type = "method",
      args="()",
      returns = "Vector<cocosbuilder::CCBAnimationManager *>",
      valuetype = "Vector<cocosbuilder::CCBAnimationManager >"
    },
    getNodesWithAnimationManagers={
      description = "",
      type = "method",
      args="()",
      returns = "Vector<cocos2d::Node *>",
      valuetype = "Vector<cocos2d::Node >"
    },
    getActionManager={
      description = "",
      type = "method",
      args="()",
      returns = "CCBAnimationManager*",
      valuetype = "CCBAnimationManager"
    },
    setResolutionScale={
	  description = "",
      type = "method",
      args="(float: scale)",
      returns = "void",
      valuetype = "void"
    },
  },
},

}
end