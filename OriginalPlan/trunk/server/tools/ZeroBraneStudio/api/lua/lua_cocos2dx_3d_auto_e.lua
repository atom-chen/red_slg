require "api/lua/cpprootdir"
require "api/lua/cppapi"

do return{

Skeleton3D = {
  description = "",
  type = "class",
  inherits = "Ref ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "Skeleton3D",
      valuetype = "Skeleton3D",
    },
    getBoneByName={
      description = "",
      type = "method",
      args="(string: id)",
      returns = "Bone3D*",
      valuetype = "Bone3D"
    },
    getRootBone={
      description = "",
      type = "method",
      args="(int: index)",
      returns = "Bone3D*",
      valuetype = "Bone3D"
    },
    updateBoneMatrix={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getBoneByIndex={
      description = "",
      type = "method",
      args="(unsigned int: index)",
      returns = "Bone3D*",
      valuetype = "Bone3D"
    },
    getRootCount={
      description = "",
      type = "method",
      args="()",
      returns = "long",
      valuetype = "long"
    },
    getBoneIndex={
      description = "",
      type = "method",
      args="(Bone3D*: bone)",
      returns = "int",
      valuetype = "int"
    },
    getBoneCount={
      description = "",
      type = "method",
      args="()",
      returns = "long",
      valuetype = "long"
    },
  },
},

Sprite3D = {
  description = "",
  type = "class",
  inherits = "Node BlendProtocol ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "Sprite3D",
      valuetype = "Sprite3D",
    },
    isForceDepthWrite={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setCullFaceEnabled={
      description = "",
      type = "method",
      args="(bool: enable)",
      returns = "void",
      valuetype = "void"
    },
    getLightMask={
      description = "",
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    removeAllAttachNode={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getMesh={
      description = "",
      type = "method",
      args="()",
      returns = "Mesh*",
      valuetype = "Mesh"
    },
    setCullFace={
      description = "",
      type = "method",
      args="(unsigned int: cullFace)",
      returns = "void",
      valuetype = "void"
    },
    setLightMask={
      description = "",
      type = "method",
      args="(unsigned int: mask)",
      returns = "void",
      valuetype = "void"
    },
    getMeshCount={
      description = "",
      type = "method",
      args="()",
      returns = "long",
      valuetype = "long"
    },
    removeAttachNode={
      description = "",
      type = "method",
      args="(string: boneName)",
      returns = "void",
      valuetype = "void"
    },
    getSkeleton={
      description = "",
      type = "method",
      args="()",
      returns = "Skeleton3D*",
      valuetype = "Skeleton3D"
    },
    getMeshByIndex={
      description = "",
      type = "method",
      args="(int: index)",
      returns = "Mesh*",
      valuetype = "Mesh"
    },
    setForceDepthWrite={
      description = "",
      type = "method",
      args="(bool: value)",
      returns = "void",
      valuetype = "void"
    },
    getMeshByName={
      description = "",
      type = "method",
      args="(string: name)",
      returns = "Mesh*",
      valuetype = "Mesh"
    },
    getAttachNode={
      description = "",
      type = "method",
      args="(string: boneName)",
      returns = "AttachNode*",
      valuetype = "AttachNode"
    },
  },
},

Sprite3DCache = {
  description = "",
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "Sprite3DCache",
      valuetype = "Sprite3DCache",
    },
    removeSprite3DData={
      description = "",
      type = "method",
      args="(string: key)",
      returns = "void",
      valuetype = "void"
    },
    removeAllSprite3DData={
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
      returns = "Sprite3DCache*",
      valuetype = "Sprite3DCache"
    },
  },
},

Mesh = {
  description = "",
  type = "class",
  inherits = "Ref ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "Mesh",
      valuetype = "Mesh",
    },
    getMeshVertexAttribCount={
      description = "",
      type = "method",
      args="()",
      returns = "long",
      valuetype = "long"
    },
    getTexture={
      description = "",
      type = "method",
      args="()",
      returns = "Texture2D*",
      valuetype = "Texture2D"
    },
    getName={
      description = "",
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    setBlendFunc={
      description = "",
      type = "method",
      args="(BlendFunc: blendFunc)",
      returns = "void",
      valuetype = "void"
    },
    getVertexSizeInBytes={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getBlendFunc={
      description = "",
      type = "method",
      args="()",
      returns = "BlendFunc",
      valuetype = "BlendFunc"
    },
    getMeshVertexAttribute={
      description = "",
      type = "method",
      args="(int: idx)",
      returns = "MeshVertexAttrib",
      valuetype = "MeshVertexAttrib"
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
  },
},

Animation3D = {
  description = "",
  type = "class",
  inherits = "Ref ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "Animation3D",
      valuetype = "Animation3D",
    },
    getDuration={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    create={
	  description = "",
      type = "method",
      args="(string: filename,string: animationName)",
      returns = "Animation3D*",
      valuetype = "Animation3D"
    },
  },
},

Animate3D = {
  description = "",
  type = "class",
  inherits = "ActionInterval ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "Animate3D",
      valuetype = "Animate3D",
    },
    getSpeed={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    setWeight={
      description = "",
      type = "method",
      args="(float: weight)",
      returns = "void",
      valuetype = "void"
    },
    getOriginInterval={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    setSpeed={
      description = "",
      type = "method",
      args="(float: speed)",
      returns = "void",
      valuetype = "void"
    },
    setOriginInterval={
      description = "",
      type = "method",
      args="(float: interval)",
      returns = "void",
      valuetype = "void"
    },
    getWeight={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    getTransitionTime={
	  description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    createWithFrames={
	  description = "",
      type = "method",
      args="(Animation3D*: animation,int: startFrame,int: endFrame,float: frameRate)",
      returns = "Animate3D*",
      valuetype = "Animate3D"
    },
  },
},

AttachNode = {
  description = "",
  type = "class",
  inherits = "Node ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "AttachNode",
      valuetype = "AttachNode",
    },
    create={
	  description = "",
      type = "method",
      args="(Bone3D*: attachBone)",
      returns = "AttachNode*",
      valuetype = "AttachNode"
    },
  },
},

BillBoard = {
  description = "",
  type = "class",
  inherits = "Sprite ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "BillBoard",
      valuetype = "BillBoard",
    },
    getMode={
      description = "",
      type = "method",
      args="()",
      returns = "Mode",
      valuetype = "Mode"
    },
    visit={
      description = "",
      type = "method",
      args="(Renderer*: renderer,Mat4: parentTransform,unsigned int: parentFlags)",
      returns = "void",
      valuetype = "void"
    },
    setMode={
      description = "",
      type = "method",
      args="(Mode: mode)",
      returns = "void",
      valuetype = "void"
    },
    createWithTexture={
	  description = "",
      type = "method",
      args="(Texture2D*: texture,Mode: mode)",
      returns = "BillBoard*",
      valuetype = "BillBoard"
    },
  },
},

}
end