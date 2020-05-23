require "api/lua/cpprootdir"
require "api/lua/cppapi"

do return{

ActionFrame = {
  description = "",
  type = "class",
  inherits = "Ref ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ActionFrame",
      valuetype = "ActionFrame",
    },
    getFrameType={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    setFrameTime={
      description = "",
      type = "method",
      args="(float: fTime)",
      returns = "void",
      valuetype = "void"
    },
    setEasingType={
      description = "",
      type = "method",
      args="(int: easingType)",
      returns = "void",
      valuetype = "void"
    },
    getFrameTime={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    getFrameIndex={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    setFrameType={
      description = "",
      type = "method",
      args="(int: frameType)",
      returns = "void",
      valuetype = "void"
    },
    setFrameIndex={
      description = "",
      type = "method",
      args="(int: index)",
      returns = "void",
      valuetype = "void"
    },
    setEasingParameter={
      description = "",
      type = "method",
      args="(vector<float, allocator<float> >: parameter)",
      returns = "void",
      valuetype = "void"
    },
    getEasingType={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
  },
},

ActionMoveFrame = {
  description = "",
  type = "class",
  inherits = "ActionFrame ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ActionMoveFrame",
      valuetype = "ActionMoveFrame",
    },
    setPosition={
      description = "",
      type = "method",
      args="(Vec2: pos)",
      returns = "void",
      valuetype = "void"
    },
    getAction={
      description = "",
      type = "method",
      args="(float: duration)",
      returns = "ActionInterval*",
      valuetype = "ActionInterval"
    },
    getPosition={
      description = "",
      type = "method",
      args="()",
      returns = "Vec2",
      valuetype = "Vec2"
    },
  },
},

ActionScaleFrame = {
  description = "",
  type = "class",
  inherits = "ActionFrame ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ActionScaleFrame",
      valuetype = "ActionScaleFrame",
    },
    setScaleY={
      description = "",
      type = "method",
      args="(float: scaleY)",
      returns = "void",
      valuetype = "void"
    },
    setScaleX={
      description = "",
      type = "method",
      args="(float: scaleX)",
      returns = "void",
      valuetype = "void"
    },
    getScaleY={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    getScaleX={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    getAction={
      description = "",
      type = "method",
      args="(float: duration)",
      returns = "ActionInterval*",
      valuetype = "ActionInterval"
    },
  },
},

ActionRotationFrame = {
  description = "",
  type = "class",
  inherits = "ActionFrame ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ActionRotationFrame",
      valuetype = "ActionRotationFrame",
    },
    setRotation={
      description = "",
      type = "method",
      args="(float: rotation)",
      returns = "void",
      valuetype = "void"
    },
    getRotation={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
  },
},

ActionFadeFrame = {
  description = "",
  type = "class",
  inherits = "ActionFrame ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ActionFadeFrame",
      valuetype = "ActionFadeFrame",
    },
    getOpacity={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getAction={
      description = "",
      type = "method",
      args="(float: duration)",
      returns = "ActionInterval*",
      valuetype = "ActionInterval"
    },
    setOpacity={
      description = "",
      type = "method",
      args="(int: opacity)",
      returns = "void",
      valuetype = "void"
    },
  },
},

ActionTintFrame = {
  description = "",
  type = "class",
  inherits = "ActionFrame ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ActionTintFrame",
      valuetype = "ActionTintFrame",
    },
    getColor={
      description = "",
      type = "method",
      args="()",
      returns = "Color3B",
      valuetype = "Color3B"
    },
    getAction={
      description = "",
      type = "method",
      args="(float: duration)",
      returns = "ActionInterval*",
      valuetype = "ActionInterval"
    },
    setColor={
      description = "",
      type = "method",
      args="(Color3B: ccolor)",
      returns = "void",
      valuetype = "void"
    },
  },
},

ActionObject = {
  description = "",
  type = "class",
  inherits = "Ref ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ActionObject",
      valuetype = "ActionObject",
    },
    setCurrentTime={
      description = "",
      type = "method",
      args="(float: fTime)",
      returns = "void",
      valuetype = "void"
    },
    pause={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    setName={
      description = "",
      type = "method",
      args="(char*: name)",
      returns = "void",
      valuetype = "void"
    },
    setUnitTime={
      description = "",
      type = "method",
      args="(float: fTime)",
      returns = "void",
      valuetype = "void"
    },
    getTotalTime={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    getName={
      description = "",
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
    stop={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getCurrentTime={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    removeActionNode={
      description = "",
      type = "method",
      args="(ActionNode*: node)",
      returns = "void",
      valuetype = "void"
    },
    getLoop={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    addActionNode={
      description = "",
      type = "method",
      args="(ActionNode*: node)",
      returns = "void",
      valuetype = "void"
    },
    getUnitTime={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    isPlaying={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    updateToFrameByTime={
      description = "",
      type = "method",
      args="(float: fTime)",
      returns = "void",
      valuetype = "void"
    },
    setLoop={
      description = "",
      type = "method",
      args="(bool: bLoop)",
      returns = "void",
      valuetype = "void"
    },
    simulationActionUpdate={
      description = "",
      type = "method",
      args="(float: dt)",
      returns = "void",
      valuetype = "void"
    },
  },
},

ActionManagerEx = {
  description = "",
  type = "class",
  inherits = "Ref ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ActionManagerEx",
      valuetype = "ActionManagerEx",
    },
    stopActionByName={
      description = "",
      type = "method",
      args="(char*: jsonName,char*: actionName)",
      returns = "ActionObject*",
      valuetype = "ActionObject"
    },
    getActionByName={
      description = "",
      type = "method",
      args="(char*: jsonName,char*: actionName)",
      returns = "ActionObject*",
      valuetype = "ActionObject"
    },
    releaseActions={
      description = "",
      type = "method",
      args="()",
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
      returns = "ActionManagerEx*",
      valuetype = "ActionManagerEx"
    },
  },
},

BaseData = {
  description = "",
  type = "class",
  inherits = "Ref ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "BaseData",
      valuetype = "BaseData",
    },
    getColor={
      description = "",
      type = "method",
      args="()",
      returns = "Color4B",
      valuetype = "Color4B"
    },
    setColor={
      description = "",
      type = "method",
      args="(Color4B: color)",
      returns = "void",
      valuetype = "void"
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "BaseData*",
      valuetype = "BaseData"
    },
  },
},

DisplayData = {
  description = "",
  type = "class",
  inherits = "Ref ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "DisplayData",
      valuetype = "DisplayData",
    },
    copy={
      description = "",
      type = "method",
      args="(DisplayData*: displayData)",
      returns = "void",
      valuetype = "void"
    },
    changeDisplayToTexture={
	  description = "",
      type = "method",
      args="(string: displayName)",
      returns = "string",
      valuetype = "string"
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "DisplayData*",
      valuetype = "DisplayData"
    },
  },
},

SpriteDisplayData = {
  description = "",
  type = "class",
  inherits = "DisplayData ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "SpriteDisplayData",
      valuetype = "SpriteDisplayData",
    },
    copy={
      description = "",
      type = "method",
      args="(DisplayData*: displayData)",
      returns = "void",
      valuetype = "void"
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "SpriteDisplayData*",
      valuetype = "SpriteDisplayData"
    },
  },
},

ArmatureDisplayData = {
  description = "",
  type = "class",
  inherits = "DisplayData ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ArmatureDisplayData",
      valuetype = "ArmatureDisplayData",
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "ArmatureDisplayData*",
      valuetype = "ArmatureDisplayData"
    },
  },
},

ParticleDisplayData = {
  description = "",
  type = "class",
  inherits = "DisplayData ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ParticleDisplayData",
      valuetype = "ParticleDisplayData",
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "ParticleDisplayData*",
      valuetype = "ParticleDisplayData"
    },
  },
},

BoneData = {
  description = "",
  type = "class",
  inherits = "BaseData ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "BoneData",
      valuetype = "BoneData",
    },
    getDisplayData={
      description = "",
      type = "method",
      args="(int: index)",
      returns = "DisplayData*",
      valuetype = "DisplayData"
    },
    init={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    addDisplayData={
      description = "",
      type = "method",
      args="(DisplayData*: displayData)",
      returns = "void",
      valuetype = "void"
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "BoneData*",
      valuetype = "BoneData"
    },
  },
},

ArmatureData = {
  description = "",
  type = "class",
  inherits = "Ref ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ArmatureData",
      valuetype = "ArmatureData",
    },
    addBoneData={
      description = "",
      type = "method",
      args="(BoneData*: boneData)",
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
    getBoneData={
      description = "",
      type = "method",
      args="(string: boneName)",
      returns = "BoneData*",
      valuetype = "BoneData"
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "ArmatureData*",
      valuetype = "ArmatureData"
    },
  },
},

FrameData = {
  description = "",
  type = "class",
  inherits = "BaseData ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "FrameData",
      valuetype = "FrameData",
    },
    copy={
      description = "",
      type = "method",
      args="(BaseData*: baseData)",
      returns = "void",
      valuetype = "void"
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "FrameData*",
      valuetype = "FrameData"
    },
  },
},

MovementBoneData = {
  description = "",
  type = "class",
  inherits = "Ref ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MovementBoneData",
      valuetype = "MovementBoneData",
    },
    init={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getFrameData={
      description = "",
      type = "method",
      args="(int: index)",
      returns = "FrameData*",
      valuetype = "FrameData"
    },
    addFrameData={
      description = "",
      type = "method",
      args="(FrameData*: frameData)",
      returns = "void",
      valuetype = "void"
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "MovementBoneData*",
      valuetype = "MovementBoneData"
    },
  },
},

MovementData = {
  description = "",
  type = "class",
  inherits = "Ref ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MovementData",
      valuetype = "MovementData",
    },
    getMovementBoneData={
      description = "",
      type = "method",
      args="(string: boneName)",
      returns = "MovementBoneData*",
      valuetype = "MovementBoneData"
    },
    addMovementBoneData={
      description = "",
      type = "method",
      args="(MovementBoneData*: movBoneData)",
      returns = "void",
      valuetype = "void"
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "MovementData*",
      valuetype = "MovementData"
    },
  },
},

AnimationData = {
  description = "",
  type = "class",
  inherits = "Ref ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "AnimationData",
      valuetype = "AnimationData",
    },
    getMovement={
      description = "",
      type = "method",
      args="(string: movementName)",
      returns = "MovementData*",
      valuetype = "MovementData"
    },
    getMovementCount={
      description = "",
      type = "method",
      args="()",
      returns = "long",
      valuetype = "long"
    },
    addMovement={
      description = "",
      type = "method",
      args="(MovementData*: movData)",
      returns = "void",
      valuetype = "void"
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "AnimationData*",
      valuetype = "AnimationData"
    },
  },
},

ContourData = {
  description = "",
  type = "class",
  inherits = "Ref ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ContourData",
      valuetype = "ContourData",
    },
    init={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    addVertex={
      description = "",
      type = "method",
      args="(Vec2: vertex)",
      returns = "void",
      valuetype = "void"
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "ContourData*",
      valuetype = "ContourData"
    },
  },
},

TextureData = {
  description = "",
  type = "class",
  inherits = "Ref ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "TextureData",
      valuetype = "TextureData",
    },
    getContourData={
      description = "",
      type = "method",
      args="(int: index)",
      returns = "ContourData*",
      valuetype = "ContourData"
    },
    init={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    addContourData={
      description = "",
      type = "method",
      args="(ContourData*: contourData)",
      returns = "void",
      valuetype = "void"
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "TextureData*",
      valuetype = "TextureData"
    },
  },
},

Tween = {
  description = "",
  type = "class",
  inherits = "ProcessBase ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "Tween",
      valuetype = "Tween",
    },
    getAnimation={
      description = "",
      type = "method",
      args="()",
      returns = "ArmatureAnimation*",
      valuetype = "ArmatureAnimation"
    },
    gotoAndPause={
      description = "",
      type = "method",
      args="(int: frameIndex)",
      returns = "void",
      valuetype = "void"
    },
    play={
      description = "",
      type = "method",
      args="(MovementBoneData*: movementBoneData,int: durationTo,int: durationTween,int: loop,int: tweenEasing)",
      returns = "void",
      valuetype = "void"
    },
    gotoAndPlay={
      description = "",
      type = "method",
      args="(int: frameIndex)",
      returns = "void",
      valuetype = "void"
    },
    init={
      description = "",
      type = "method",
      args="(Bone*: bone)",
      returns = "bool",
      valuetype = "bool"
    },
    setAnimation={
      description = "",
      type = "method",
      args="(ArmatureAnimation*: animation)",
      returns = "void",
      valuetype = "void"
    },
    create={
	  description = "",
      type = "method",
      args="(Bone*: bone)",
      returns = "Tween*",
      valuetype = "Tween"
    },
  },
},

DisplayManager = {
  description = "",
  type = "class",
  inherits = "Ref ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "DisplayManager",
      valuetype = "DisplayManager",
    },
    getDisplayRenderNode={
      description = "",
      type = "method",
      args="()",
      returns = "Node*",
      valuetype = "Node"
    },
    getAnchorPointInPoints={
      description = "",
      type = "method",
      args="()",
      returns = "Vec2",
      valuetype = "Vec2"
    },
    getDisplayRenderNodeType={
      description = "",
      type = "method",
      args="()",
      returns = "DisplayType",
      valuetype = "DisplayType"
    },
    removeDisplay={
      description = "",
      type = "method",
      args="(int: index)",
      returns = "void",
      valuetype = "void"
    },
    setForceChangeDisplay={
      description = "",
      type = "method",
      args="(bool: force)",
      returns = "void",
      valuetype = "void"
    },
    init={
      description = "",
      type = "method",
      args="(Bone*: bone)",
      returns = "bool",
      valuetype = "bool"
    },
    getContentSize={
      description = "",
      type = "method",
      args="()",
      returns = "Size",
      valuetype = "Size"
    },
    getBoundingBox={
      description = "",
      type = "method",
      args="()",
      returns = "Rect",
      valuetype = "Rect"
    },
    changeDisplayWithIndex={
      description = "",
      type = "method",
      args="(int: index,bool: force)",
      returns = "void",
      valuetype = "void"
    },
    changeDisplayWithName={
      description = "",
      type = "method",
      args="(string: name,bool: force)",
      returns = "void",
      valuetype = "void"
    },
    isForceChangeDisplay={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getCurrentDisplayIndex={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getAnchorPoint={
      description = "",
      type = "method",
      args="()",
      returns = "Vec2",
      valuetype = "Vec2"
    },
    getDecorativeDisplayList={
      description = "",
      type = "method",
      args="()",
      returns = "Vector<cocostudio::DecorativeDisplay *>",
      valuetype = "Vector<cocostudio::DecorativeDisplay >"
    },
    isVisible={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setVisible={
      description = "",
      type = "method",
      args="(bool: visible)",
      returns = "void",
      valuetype = "void"
    },
    create={
	  description = "",
      type = "method",
      args="(Bone*: bone)",
      returns = "DisplayManager*",
      valuetype = "DisplayManager"
    },
  },
},

Bone = {
  description = "",
  type = "class",
  inherits = "Node ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "Bone",
      valuetype = "Bone",
    },
    isTransformDirty={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setBlendFunc={
      description = "",
      type = "method",
      args="(BlendFunc: blendFunc)",
      returns = "void",
      valuetype = "void"
    },
    isIgnoreMovementBoneData={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    updateZOrder={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getDisplayRenderNode={
      description = "",
      type = "method",
      args="()",
      returns = "Node*",
      valuetype = "Node"
    },
    isBlendDirty={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    addChildBone={
      description = "",
      type = "method",
      args="(Bone*: child)",
      returns = "void",
      valuetype = "void"
    },
    getWorldInfo={
      description = "",
      type = "method",
      args="()",
      returns = "BaseData*",
      valuetype = "BaseData"
    },
    getTween={
      description = "",
      type = "method",
      args="()",
      returns = "Tween*",
      valuetype = "Tween"
    },
    getParentBone={
      description = "",
      type = "method",
      args="()",
      returns = "Bone*",
      valuetype = "Bone"
    },
    setTransformDirty={
      description = "",
      type = "method",
      args="(bool: dirty)",
      returns = "void",
      valuetype = "void"
    },
    getDisplayRenderNodeType={
      description = "",
      type = "method",
      args="()",
      returns = "DisplayType",
      valuetype = "DisplayType"
    },
    removeDisplay={
      description = "",
      type = "method",
      args="(int: index)",
      returns = "void",
      valuetype = "void"
    },
    setBoneData={
      description = "",
      type = "method",
      args="(BoneData*: boneData)",
      returns = "void",
      valuetype = "void"
    },
    setParentBone={
      description = "",
      type = "method",
      args="(Bone*: parent)",
      returns = "void",
      valuetype = "void"
    },
    getBlendFunc={
      description = "",
      type = "method",
      args="()",
      returns = "BlendFunc",
      valuetype = "BlendFunc"
    },
    removeFromParent={
      description = "",
      type = "method",
      args="(bool: recursion)",
      returns = "void",
      valuetype = "void"
    },
    getColliderDetector={
      description = "",
      type = "method",
      args="()",
      returns = "ColliderDetector*",
      valuetype = "ColliderDetector"
    },
    getChildArmature={
      description = "",
      type = "method",
      args="()",
      returns = "Armature*",
      valuetype = "Armature"
    },
    getTweenData={
      description = "",
      type = "method",
      args="()",
      returns = "FrameData*",
      valuetype = "FrameData"
    },
    changeDisplayWithIndex={
      description = "",
      type = "method",
      args="(int: index,bool: force)",
      returns = "void",
      valuetype = "void"
    },
    changeDisplayWithName={
      description = "",
      type = "method",
      args="(string: name,bool: force)",
      returns = "void",
      valuetype = "void"
    },
    setArmature={
      description = "",
      type = "method",
      args="(Armature*: armature)",
      returns = "void",
      valuetype = "void"
    },
    setBlendDirty={
      description = "",
      type = "method",
      args="(bool: dirty)",
      returns = "void",
      valuetype = "void"
    },
    removeChildBone={
      description = "",
      type = "method",
      args="(Bone*: bone,bool: recursion)",
      returns = "void",
      valuetype = "void"
    },
    setChildArmature={
      description = "",
      type = "method",
      args="(Armature*: childArmature)",
      returns = "void",
      valuetype = "void"
    },
    getNodeToArmatureTransform={
      description = "",
      type = "method",
      args="()",
      returns = "Mat4",
      valuetype = "Mat4"
    },
    getDisplayManager={
      description = "",
      type = "method",
      args="()",
      returns = "DisplayManager*",
      valuetype = "DisplayManager"
    },
    getArmature={
      description = "",
      type = "method",
      args="()",
      returns = "Armature*",
      valuetype = "Armature"
    },
    getBoneData={
      description = "",
      type = "method",
      args="()",
      returns = "BoneData*",
      valuetype = "BoneData"
    },
  },
},

BatchNode = {
  description = "",
  type = "class",
  inherits = "Node ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "BatchNode",
      valuetype = "BatchNode",
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "BatchNode*",
      valuetype = "BatchNode"
    },
  },
},

ArmatureAnimation = {
  description = "",
  type = "class",
  inherits = "ProcessBase ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ArmatureAnimation",
      valuetype = "ArmatureAnimation",
    },
    getSpeedScale={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    pause={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    setSpeedScale={
      description = "",
      type = "method",
      args="(float: speedScale)",
      returns = "void",
      valuetype = "void"
    },
    init={
      description = "",
      type = "method",
      args="(Armature*: armature)",
      returns = "bool",
      valuetype = "bool"
    },
    playWithIndexes={
      description = "",
      type = "method",
      args="(vector<int, allocator<int> >: movementIndexes,int: durationTo,bool: loop)",
      returns = "void",
      valuetype = "void"
    },
    play={
      description = "",
      type = "method",
      args="(string: animationName,int: durationTo,int: loop)",
      returns = "void",
      valuetype = "void"
    },
    gotoAndPause={
      description = "",
      type = "method",
      args="(int: frameIndex)",
      returns = "void",
      valuetype = "void"
    },
    resume={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    stop={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    update={
      description = "",
      type = "method",
      args="(float: dt)",
      returns = "void",
      valuetype = "void"
    },
    getAnimationData={
      description = "",
      type = "method",
      args="()",
      returns = "AnimationData*",
      valuetype = "AnimationData"
    },
    playWithIndex={
      description = "",
      type = "method",
      args="(int: animationIndex,int: durationTo,int: loop)",
      returns = "void",
      valuetype = "void"
    },
    getCurrentMovementID={
      description = "",
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    setAnimationData={
      description = "",
      type = "method",
      args="(AnimationData*: data)",
      returns = "void",
      valuetype = "void"
    },
    gotoAndPlay={
      description = "",
      type = "method",
      args="(int: frameIndex)",
      returns = "void",
      valuetype = "void"
    },
    playWithNames={
      description = "",
      type = "method",
      args="(vector<basic_string<char>, allocator<basic_string<char> > >: movementNames,int: durationTo,bool: loop)",
      returns = "void",
      valuetype = "void"
    },
    getMovementCount={
      description = "",
      type = "method",
      args="()",
      returns = "long",
      valuetype = "long"
    },
    create={
	  description = "",
      type = "method",
      args="(Armature*: armature)",
      returns = "ArmatureAnimation*",
      valuetype = "ArmatureAnimation"
    },
  },
},

ArmatureDataManager = {
  description = "",
  type = "class",
  inherits = "Ref ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ArmatureDataManager",
      valuetype = "ArmatureDataManager",
    },
    removeAnimationData={
      description = "",
      type = "method",
      args="(string: id)",
      returns = "void",
      valuetype = "void"
    },
    addArmatureData={
      description = "",
      type = "method",
      args="(string: id,ArmatureData*: armatureData,string: configFilePath)",
      returns = "void",
      valuetype = "void"
    },
    removeArmatureFileInfo={
      description = "",
      type = "method",
      args="(string: configFilePath)",
      returns = "void",
      valuetype = "void"
    },
    getTextureDatas={
      description = "",
      type = "method",
      args="()",
      returns = "Map<basic_string<char>, cocostudio::TextureData *>",
      valuetype = "Map<basic_string<char>, cocostudio::TextureData >"
    },
    getTextureData={
      description = "",
      type = "method",
      args="(string: id)",
      returns = "TextureData*",
      valuetype = "TextureData"
    },
    getArmatureData={
      description = "",
      type = "method",
      args="(string: id)",
      returns = "ArmatureData*",
      valuetype = "ArmatureData"
    },
    getAnimationData={
      description = "",
      type = "method",
      args="(string: id)",
      returns = "AnimationData*",
      valuetype = "AnimationData"
    },
    addAnimationData={
      description = "",
      type = "method",
      args="(string: id,AnimationData*: animationData,string: configFilePath)",
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
    removeArmatureData={
      description = "",
      type = "method",
      args="(string: id)",
      returns = "void",
      valuetype = "void"
    },
    getArmatureDatas={
      description = "",
      type = "method",
      args="()",
      returns = "Map<basic_string<char>, cocostudio::ArmatureData *>",
      valuetype = "Map<basic_string<char>, cocostudio::ArmatureData >"
    },
    removeTextureData={
      description = "",
      type = "method",
      args="(string: id)",
      returns = "void",
      valuetype = "void"
    },
    addTextureData={
      description = "",
      type = "method",
      args="(string: id,TextureData*: textureData,string: configFilePath)",
      returns = "void",
      valuetype = "void"
    },
    getAnimationDatas={
      description = "",
      type = "method",
      args="()",
      returns = "Map<basic_string<char>, cocostudio::AnimationData *>",
      valuetype = "Map<basic_string<char>, cocostudio::AnimationData >"
    },
    isAutoLoadSpriteFile={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    addSpriteFrameFromFile={
      description = "",
      type = "method",
      args="(string: plistPath,string: imagePath,string: configFilePath)",
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
      returns = "ArmatureDataManager*",
      valuetype = "ArmatureDataManager"
    },
  },
},

Armature = {
  description = "",
  type = "class",
  inherits = "Node BlendProtocol ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "Armature",
      valuetype = "Armature",
    },
    getBone={
      description = "",
      type = "method",
      args="(string: name)",
      returns = "Bone*",
      valuetype = "Bone"
    },
    changeBoneParent={
      description = "",
      type = "method",
      args="(Bone*: bone,string: parentName)",
      returns = "void",
      valuetype = "void"
    },
    setAnimation={
      description = "",
      type = "method",
      args="(ArmatureAnimation*: animation)",
      returns = "void",
      valuetype = "void"
    },
    getBoneAtPoint={
      description = "",
      type = "method",
      args="(float: x,float: y)",
      returns = "Bone*",
      valuetype = "Bone"
    },
    getArmatureTransformDirty={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setVersion={
      description = "",
      type = "method",
      args="(float: version)",
      returns = "void",
      valuetype = "void"
    },
    updateOffsetPoint={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getParentBone={
      description = "",
      type = "method",
      args="()",
      returns = "Bone*",
      valuetype = "Bone"
    },
    removeBone={
      description = "",
      type = "method",
      args="(Bone*: bone,bool: recursion)",
      returns = "void",
      valuetype = "void"
    },
    getBatchNode={
      description = "",
      type = "method",
      args="()",
      returns = "BatchNode*",
      valuetype = "BatchNode"
    },
    setParentBone={
      description = "",
      type = "method",
      args="(Bone*: parentBone)",
      returns = "void",
      valuetype = "void"
    },
    setBatchNode={
      description = "",
      type = "method",
      args="(BatchNode*: batchNode)",
      returns = "void",
      valuetype = "void"
    },
    setArmatureData={
      description = "",
      type = "method",
      args="(ArmatureData*: armatureData)",
      returns = "void",
      valuetype = "void"
    },
    addBone={
      description = "",
      type = "method",
      args="(Bone*: bone,string: parentName)",
      returns = "void",
      valuetype = "void"
    },
    getArmatureData={
      description = "",
      type = "method",
      args="()",
      returns = "ArmatureData*",
      valuetype = "ArmatureData"
    },
    getVersion={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    getAnimation={
      description = "",
      type = "method",
      args="()",
      returns = "ArmatureAnimation*",
      valuetype = "ArmatureAnimation"
    },
    getOffsetPoints={
      description = "",
      type = "method",
      args="()",
      returns = "Vec2",
      valuetype = "Vec2"
    },
    getBoneDic={
      description = "",
      type = "method",
      args="()",
      returns = "Map<basic_string<char>, cocostudio::Bone *>",
      valuetype = "Map<basic_string<char>, cocostudio::Bone >"
    },
  },
},

Skin = {
  description = "",
  type = "class",
  inherits = "Sprite ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "Skin",
      valuetype = "Skin",
    },
    getBone={
      description = "",
      type = "method",
      args="()",
      returns = "Bone*",
      valuetype = "Bone"
    },
    getNodeToWorldTransformAR={
      description = "",
      type = "method",
      args="()",
      returns = "Mat4",
      valuetype = "Mat4"
    },
    getDisplayName={
      description = "",
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    updateArmatureTransform={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    setBone={
      description = "",
      type = "method",
      args="(Bone*: bone)",
      returns = "void",
      valuetype = "void"
    },
    createWithSpriteFrameName={
	  description = "",
      type = "method",
      args="(string: pszSpriteFrameName)",
      returns = "Skin*",
      valuetype = "Skin"
    },
  },
},

ComAttribute = {
  description = "",
  type = "class",
  inherits = "Component ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ComAttribute",
      valuetype = "ComAttribute",
    },
    getFloat={
      description = "",
      type = "method",
      args="(string: key,float: def)",
      returns = "float",
      valuetype = "float"
    },
    getString={
      description = "",
      type = "method",
      args="(string: key,string: def)",
      returns = "string",
      valuetype = "string"
    },
    setFloat={
      description = "",
      type = "method",
      args="(string: key,float: value)",
      returns = "void",
      valuetype = "void"
    },
    setString={
      description = "",
      type = "method",
      args="(string: key,string: value)",
      returns = "void",
      valuetype = "void"
    },
    getBool={
      description = "",
      type = "method",
      args="(string: key,bool: def)",
      returns = "bool",
      valuetype = "bool"
    },
    setInt={
      description = "",
      type = "method",
      args="(string: key,int: value)",
      returns = "void",
      valuetype = "void"
    },
    parse={
      description = "",
      type = "method",
      args="(string: jsonFile)",
      returns = "bool",
      valuetype = "bool"
    },
    getInt={
      description = "",
      type = "method",
      args="(string: key,int: def)",
      returns = "int",
      valuetype = "int"
    },
    setBool={
      description = "",
      type = "method",
      args="(string: key,bool: value)",
      returns = "void",
      valuetype = "void"
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "ComAttribute*",
      valuetype = "ComAttribute"
    },
    createInstance={
	  description = "",
      type = "method",
      args="()",
      returns = "Ref*",
      valuetype = "Ref"
    },
  },
},

ComAudio = {
  description = "",
  type = "class",
  inherits = "Component ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ComAudio",
      valuetype = "ComAudio",
    },
    stopAllEffects={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getEffectsVolume={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    stopEffect={
      description = "",
      type = "method",
      args="(unsigned int: nSoundId)",
      returns = "void",
      valuetype = "void"
    },
    getBackgroundMusicVolume={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    willPlayBackgroundMusic={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setBackgroundMusicVolume={
      description = "",
      type = "method",
      args="(float: volume)",
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
    pauseBackgroundMusic={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    isBackgroundMusicPlaying={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isLoop={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    resumeAllEffects={
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
    preloadBackgroundMusic={
      description = "",
      type = "method",
      args="(char*: pszFilePath)",
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
    setLoop={
      description = "",
      type = "method",
      args="(bool: bLoop)",
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
    rewindBackgroundMusic={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    pauseEffect={
      description = "",
      type = "method",
      args="(unsigned int: nSoundId)",
      returns = "void",
      valuetype = "void"
    },
    resumeBackgroundMusic={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    setFile={
      description = "",
      type = "method",
      args="(char*: pszFilePath)",
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
    getFile={
      description = "",
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
    resumeEffect={
      description = "",
      type = "method",
      args="(unsigned int: nSoundId)",
      returns = "void",
      valuetype = "void"
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "ComAudio*",
      valuetype = "ComAudio"
    },
    createInstance={
	  description = "",
      type = "method",
      args="()",
      returns = "Ref*",
      valuetype = "Ref"
    },
  },
},

ComController = {
  description = "",
  type = "class",
  inherits = "Component InputDelegate ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ComController",
      valuetype = "ComController",
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "ComController*",
      valuetype = "ComController"
    },
    createInstance={
	  description = "",
      type = "method",
      args="()",
      returns = "Ref*",
      valuetype = "Ref"
    },
  },
},

ComRender = {
  description = "",
  type = "class",
  inherits = "Component ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ComRender",
      valuetype = "ComRender",
    },
    setNode={
      description = "",
      type = "method",
      args="(Node*: node)",
      returns = "void",
      valuetype = "void"
    },
    getNode={
      description = "",
      type = "method",
      args="()",
      returns = "Node*",
      valuetype = "Node"
    },
    createInstance={
	  description = "",
      type = "method",
      args="()",
      returns = "Ref*",
      valuetype = "Ref"
    },
  },
},

GUIReader = {
  description = "",
  type = "class",
  inherits = "Ref ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "GUIReader",
      valuetype = "GUIReader",
    },
    setFilePath={
      description = "",
      type = "method",
      args="(string: strFilePath)",
      returns = "void",
      valuetype = "void"
    },
    widgetFromJsonFile={
      description = "",
      type = "method",
      args="(char*: fileName)",
      returns = "Widget*",
      valuetype = "Widget"
    },
    getFilePath={
      description = "",
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    widgetFromBinaryFile={
      description = "",
      type = "method",
      args="(char*: fileName)",
      returns = "Widget*",
      valuetype = "Widget"
    },
    getVersionInteger={
      description = "",
      type = "method",
      args="(char*: str)",
      returns = "int",
      valuetype = "int"
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
      returns = "GUIReader*",
      valuetype = "GUIReader"
    },
  },
},

SceneReader = {
  description = "",
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "SceneReader",
      valuetype = "SceneReader",
    },
    setTarget={
      description = "",
      type = "method",
      args="(function: selector)",
      returns = "void",
      valuetype = "void"
    },
    createNodeWithSceneFile={
      description = "",
      type = "method",
      args="(string: fileName,AttachComponentType: attachComponent)",
      returns = "Node*",
      valuetype = "Node"
    },
    getAttachComponentType={
      description = "",
      type = "method",
      args="()",
      returns = "AttachComponentType",
      valuetype = "AttachComponentType"
    },
    getNodeByTag={
      description = "",
      type = "method",
      args="(int: nTag)",
      returns = "Node*",
      valuetype = "Node"
    },
    destroyInstance={
	  description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    sceneReaderVersion={
	  description = "",
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
    getInstance={
	  description = "",
      type = "method",
      args="()",
      returns = "SceneReader*",
      valuetype = "SceneReader"
    },
  },
},

ActionTimelineCache = {
  description = "",
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ActionTimelineCache",
      valuetype = "ActionTimelineCache",
    },
    createActionFromJson={
      description = "",
      type = "method",
      args="(string: fileName)",
      returns = "ActionTimeline*",
      valuetype = "ActionTimeline"
    },
    createActionWithFlatBuffersFile={
      description = "",
      type = "method",
      args="(string: fileName)",
      returns = "ActionTimeline*",
      valuetype = "ActionTimeline"
    },
    loadAnimationActionWithFlatBuffersFile={
      description = "",
      type = "method",
      args="(string: fileName)",
      returns = "ActionTimeline*",
      valuetype = "ActionTimeline"
    },
    purge={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    init={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    loadAnimationActionWithFile={
      description = "",
      type = "method",
      args="(string: fileName)",
      returns = "ActionTimeline*",
      valuetype = "ActionTimeline"
    },
    loadAnimationActionWithContent={
      description = "",
      type = "method",
      args="(string: fileName,string: content)",
      returns = "ActionTimeline*",
      valuetype = "ActionTimeline"
    },
    removeAction={
      description = "",
      type = "method",
      args="(string: fileName)",
      returns = "void",
      valuetype = "void"
    },
    createActionWithFlatBuffersForSimulator={
      description = "",
      type = "method",
      args="(string: fileName)",
      returns = "ActionTimeline*",
      valuetype = "ActionTimeline"
    },
    destroyInstance={
	  description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    createAction={
	  description = "",
      type = "method",
      args="(string: fileName)",
      returns = "ActionTimeline*",
      valuetype = "ActionTimeline"
    },
  },
},

Frame = {
  description = "",
  type = "class",
  inherits = "Ref ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "Frame",
      valuetype = "Frame",
    },
    clone={
      description = "",
      type = "method",
      args="()",
      returns = "Frame*",
      valuetype = "Frame"
    },
    setNode={
      description = "",
      type = "method",
      args="(Node*: node)",
      returns = "void",
      valuetype = "void"
    },
    setTimeline={
      description = "",
      type = "method",
      args="(Timeline*: timeline)",
      returns = "void",
      valuetype = "void"
    },
    isEnterWhenPassed={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getFrameIndex={
      description = "",
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    apply={
      description = "",
      type = "method",
      args="(float: percent)",
      returns = "void",
      valuetype = "void"
    },
    isTween={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setFrameIndex={
      description = "",
      type = "method",
      args="(unsigned int: frameIndex)",
      returns = "void",
      valuetype = "void"
    },
    setTween={
      description = "",
      type = "method",
      args="(bool: tween)",
      returns = "void",
      valuetype = "void"
    },
    getTimeline={
      description = "",
      type = "method",
      args="()",
      returns = "Timeline*",
      valuetype = "Timeline"
    },
    getNode={
      description = "",
      type = "method",
      args="()",
      returns = "Node*",
      valuetype = "Node"
    },
  },
},

VisibleFrame = {
  description = "",
  type = "class",
  inherits = "Frame ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "VisibleFrame",
      valuetype = "VisibleFrame",
    },
    isVisible={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setVisible={
      description = "",
      type = "method",
      args="(bool: visible)",
      returns = "void",
      valuetype = "void"
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "VisibleFrame*",
      valuetype = "VisibleFrame"
    },
  },
},

TextureFrame = {
  description = "",
  type = "class",
  inherits = "Frame ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "TextureFrame",
      valuetype = "TextureFrame",
    },
    getTextureName={
      description = "",
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    setNode={
      description = "",
      type = "method",
      args="(Node*: node)",
      returns = "void",
      valuetype = "void"
    },
    setTextureName={
      description = "",
      type = "method",
      args="(string: textureName)",
      returns = "void",
      valuetype = "void"
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "TextureFrame*",
      valuetype = "TextureFrame"
    },
  },
},

RotationFrame = {
  description = "",
  type = "class",
  inherits = "Frame ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "RotationFrame",
      valuetype = "RotationFrame",
    },
    setRotation={
      description = "",
      type = "method",
      args="(float: rotation)",
      returns = "void",
      valuetype = "void"
    },
    getRotation={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "RotationFrame*",
      valuetype = "RotationFrame"
    },
  },
},

SkewFrame = {
  description = "",
  type = "class",
  inherits = "Frame ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "SkewFrame",
      valuetype = "SkewFrame",
    },
    getSkewY={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    setSkewX={
      description = "",
      type = "method",
      args="(float: skewx)",
      returns = "void",
      valuetype = "void"
    },
    setSkewY={
      description = "",
      type = "method",
      args="(float: skewy)",
      returns = "void",
      valuetype = "void"
    },
    getSkewX={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "SkewFrame*",
      valuetype = "SkewFrame"
    },
  },
},

RotationSkewFrame = {
  description = "",
  type = "class",
  inherits = "SkewFrame ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "RotationSkewFrame",
      valuetype = "RotationSkewFrame",
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "RotationSkewFrame*",
      valuetype = "RotationSkewFrame"
    },
  },
},

PositionFrame = {
  description = "",
  type = "class",
  inherits = "Frame ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PositionFrame",
      valuetype = "PositionFrame",
    },
    getX={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    getY={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    setPosition={
      description = "",
      type = "method",
      args="(Vec2: position)",
      returns = "void",
      valuetype = "void"
    },
    setX={
      description = "",
      type = "method",
      args="(float: x)",
      returns = "void",
      valuetype = "void"
    },
    setY={
      description = "",
      type = "method",
      args="(float: y)",
      returns = "void",
      valuetype = "void"
    },
    getPosition={
      description = "",
      type = "method",
      args="()",
      returns = "Vec2",
      valuetype = "Vec2"
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "PositionFrame*",
      valuetype = "PositionFrame"
    },
  },
},

ScaleFrame = {
  description = "",
  type = "class",
  inherits = "Frame ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ScaleFrame",
      valuetype = "ScaleFrame",
    },
    setScaleY={
      description = "",
      type = "method",
      args="(float: scaleY)",
      returns = "void",
      valuetype = "void"
    },
    setScaleX={
      description = "",
      type = "method",
      args="(float: scaleX)",
      returns = "void",
      valuetype = "void"
    },
    getScaleY={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    getScaleX={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    setScale={
      description = "",
      type = "method",
      args="(float: scale)",
      returns = "void",
      valuetype = "void"
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "ScaleFrame*",
      valuetype = "ScaleFrame"
    },
  },
},

AnchorPointFrame = {
  description = "",
  type = "class",
  inherits = "Frame ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "AnchorPointFrame",
      valuetype = "AnchorPointFrame",
    },
    setAnchorPoint={
      description = "",
      type = "method",
      args="(Vec2: point)",
      returns = "void",
      valuetype = "void"
    },
    getAnchorPoint={
      description = "",
      type = "method",
      args="()",
      returns = "Vec2",
      valuetype = "Vec2"
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "AnchorPointFrame*",
      valuetype = "AnchorPointFrame"
    },
  },
},

InnerActionFrame = {
  description = "",
  type = "class",
  inherits = "Frame ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "InnerActionFrame",
      valuetype = "InnerActionFrame",
    },
    getEndFrameIndex={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getStartFrameIndex={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getInnerActionType={
      description = "",
      type = "method",
      args="()",
      returns = "InnerActionType",
      valuetype = "InnerActionType"
    },
    setEndFrameIndex={
      description = "",
      type = "method",
      args="(int: frameIndex)",
      returns = "void",
      valuetype = "void"
    },
    setEnterWithName={
      description = "",
      type = "method",
      args="(bool: isEnterWithName)",
      returns = "void",
      valuetype = "void"
    },
    setSingleFrameIndex={
      description = "",
      type = "method",
      args="(int: frameIndex)",
      returns = "void",
      valuetype = "void"
    },
    setStartFrameIndex={
      description = "",
      type = "method",
      args="(int: frameIndex)",
      returns = "void",
      valuetype = "void"
    },
    getSingleFrameIndex={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    setInnerActionType={
      description = "",
      type = "method",
      args="(InnerActionType: type)",
      returns = "void",
      valuetype = "void"
    },
    setAnimationName={
      description = "",
      type = "method",
      args="(string: animationNamed)",
      returns = "void",
      valuetype = "void"
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "InnerActionFrame*",
      valuetype = "InnerActionFrame"
    },
  },
},

ColorFrame = {
  description = "",
  type = "class",
  inherits = "Frame ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ColorFrame",
      valuetype = "ColorFrame",
    },
    getAlpha={
      description = "",
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    getColor={
      description = "",
      type = "method",
      args="()",
      returns = "Color3B",
      valuetype = "Color3B"
    },
    setAlpha={
      description = "",
      type = "method",
      args="(unsigned char: alpha)",
      returns = "void",
      valuetype = "void"
    },
    setColor={
      description = "",
      type = "method",
      args="(Color3B: color)",
      returns = "void",
      valuetype = "void"
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "ColorFrame*",
      valuetype = "ColorFrame"
    },
  },
},

AlphaFrame = {
  description = "",
  type = "class",
  inherits = "Frame ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "AlphaFrame",
      valuetype = "AlphaFrame",
    },
    getAlpha={
      description = "",
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    setAlpha={
      description = "",
      type = "method",
      args="(unsigned char: alpha)",
      returns = "void",
      valuetype = "void"
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "AlphaFrame*",
      valuetype = "AlphaFrame"
    },
  },
},

EventFrame = {
  description = "",
  type = "class",
  inherits = "Frame ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "EventFrame",
      valuetype = "EventFrame",
    },
    setEvent={
      description = "",
      type = "method",
      args="(string: event)",
      returns = "void",
      valuetype = "void"
    },
    init={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    setNode={
      description = "",
      type = "method",
      args="(Node*: node)",
      returns = "void",
      valuetype = "void"
    },
    getEvent={
      description = "",
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "EventFrame*",
      valuetype = "EventFrame"
    },
  },
},

ZOrderFrame = {
  description = "",
  type = "class",
  inherits = "Frame ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ZOrderFrame",
      valuetype = "ZOrderFrame",
    },
    getZOrder={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    setZOrder={
      description = "",
      type = "method",
      args="(int: zorder)",
      returns = "void",
      valuetype = "void"
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "ZOrderFrame*",
      valuetype = "ZOrderFrame"
    },
  },
},

Timeline = {
  description = "",
  type = "class",
  inherits = "Ref ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "Timeline",
      valuetype = "Timeline",
    },
    clone={
      description = "",
      type = "method",
      args="()",
      returns = "Timeline*",
      valuetype = "Timeline"
    },
    gotoFrame={
      description = "",
      type = "method",
      args="(int: frameIndex)",
      returns = "void",
      valuetype = "void"
    },
    setNode={
      description = "",
      type = "method",
      args="(Node*: node)",
      returns = "void",
      valuetype = "void"
    },
    getActionTimeline={
      description = "",
      type = "method",
      args="()",
      returns = "ActionTimeline*",
      valuetype = "ActionTimeline"
    },
    insertFrame={
      description = "",
      type = "method",
      args="(Frame*: frame,int: index)",
      returns = "void",
      valuetype = "void"
    },
    setActionTag={
      description = "",
      type = "method",
      args="(int: tag)",
      returns = "void",
      valuetype = "void"
    },
    addFrame={
      description = "",
      type = "method",
      args="(Frame*: frame)",
      returns = "void",
      valuetype = "void"
    },
    getFrames={
      description = "",
      type = "method",
      args="()",
      returns = "Vector<cocostudio::timeline::Frame *>",
      valuetype = "Vector<cocostudio::timeline::Frame >"
    },
    getActionTag={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getNode={
      description = "",
      type = "method",
      args="()",
      returns = "Node*",
      valuetype = "Node"
    },
    removeFrame={
      description = "",
      type = "method",
      args="(Frame*: frame)",
      returns = "void",
      valuetype = "void"
    },
    setActionTimeline={
      description = "",
      type = "method",
      args="(ActionTimeline*: action)",
      returns = "void",
      valuetype = "void"
    },
    stepToFrame={
      description = "",
      type = "method",
      args="(int: frameIndex)",
      returns = "void",
      valuetype = "void"
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "Timeline*",
      valuetype = "Timeline"
    },
  },
},

ActionTimelineData = {
  description = "",
  type = "class",
  inherits = "Ref ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ActionTimelineData",
      valuetype = "ActionTimelineData",
    },
    setActionTag={
      description = "",
      type = "method",
      args="(int: actionTag)",
      returns = "void",
      valuetype = "void"
    },
    getActionTag={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    create={
	  description = "",
      type = "method",
      args="(int: actionTag)",
      returns = "ActionTimelineData*",
      valuetype = "ActionTimelineData"
    },
  },
},

ActionTimeline = {
  description = "",
  type = "class",
  inherits = "Action ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ActionTimeline",
      valuetype = "ActionTimeline",
    },
    addTimeline={
      description = "",
      type = "method",
      args="(Timeline*: timeline)",
      returns = "void",
      valuetype = "void"
    },
    getCurrentFrame={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getStartFrame={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    pause={
      description = "",
      type = "method",
      args="()",
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
    removeTimeline={
      description = "",
      type = "method",
      args="(Timeline*: timeline)",
      returns = "void",
      valuetype = "void"
    },
    clearFrameEventCallFunc={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    setLastFrameCallFunc={
      description = "",
      type = "method",
      args="(function: listener)",
      returns = "void",
      valuetype = "void"
    },
    getTimelines={
      description = "",
      type = "method",
      args="()",
      returns = "Vector<cocostudio::timeline::Timeline *>",
      valuetype = "Vector<cocostudio::timeline::Timeline >"
    },
    play={
      description = "",
      type = "method",
      args="(string: animationName,bool: loop)",
      returns = "void",
      valuetype = "void"
    },
    getAnimationInfo={
      description = "",
      type = "method",
      args="(string: animationName)",
      returns = "AnimationInfo",
      valuetype = "AnimationInfo"
    },
    resume={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    removeAnimationInfo={
      description = "",
      type = "method",
      args="(string: animationName)",
      returns = "void",
      valuetype = "void"
    },
    getTimeSpeed={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    addAnimationInfo={
      description = "",
      type = "method",
      args="(AnimationInfo: animationInfo)",
      returns = "void",
      valuetype = "void"
    },
    getDuration={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    gotoFrameAndPause={
      description = "",
      type = "method",
      args="(int: startIndex)",
      returns = "void",
      valuetype = "void"
    },
    isPlaying={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    IsAnimationInfoExists={
      description = "",
      type = "method",
      args="(string: animationName)",
      returns = "bool",
      valuetype = "bool"
    },
    getEndFrame={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    setTimeSpeed={
      description = "",
      type = "method",
      args="(float: speed)",
      returns = "void",
      valuetype = "void"
    },
    clearLastFrameCallFunc={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    setDuration={
      description = "",
      type = "method",
      args="(int: duration)",
      returns = "void",
      valuetype = "void"
    },
    setCurrentFrame={
      description = "",
      type = "method",
      args="(int: frameIndex)",
      returns = "void",
      valuetype = "void"
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "ActionTimeline*",
      valuetype = "ActionTimeline"
    },
  },
},

ActionTimelineNode = {
  description = "",
  type = "class",
  inherits = "Node ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ActionTimelineNode",
      valuetype = "ActionTimelineNode",
    },
    getRoot={
      description = "",
      type = "method",
      args="()",
      returns = "Node*",
      valuetype = "Node"
    },
    getActionTimeline={
      description = "",
      type = "method",
      args="()",
      returns = "ActionTimeline*",
      valuetype = "ActionTimeline"
    },
    setActionTimeline={
      description = "",
      type = "method",
      args="(ActionTimeline*: action)",
      returns = "void",
      valuetype = "void"
    },
    setRoot={
      description = "",
      type = "method",
      args="(Node*: root)",
      returns = "void",
      valuetype = "void"
    },
    create={
	  description = "",
      type = "method",
      args="(Node*: root,ActionTimeline*: action)",
      returns = "ActionTimelineNode*",
      valuetype = "ActionTimelineNode"
    },
  },
},

}
end