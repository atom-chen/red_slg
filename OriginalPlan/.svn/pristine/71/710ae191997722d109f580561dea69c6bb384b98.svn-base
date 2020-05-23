require "api/lua/cpprootdir"
require "api/lua/cppapi"

do return{

LayoutParameter = {
  description = "",
  type = "class",
  inherits = "Ref ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "LayoutParameter",
      valuetype = "LayoutParameter",
    },
    clone={
      description = "",
      type = "method",
      args="()",
      returns = "LayoutParameter*",
      valuetype = "LayoutParameter"
    },
    getLayoutType={
      description = "",
      type = "method",
      args="()",
      returns = "Type",
      valuetype = "Type"
    },
    createCloneInstance={
      description = "",
      type = "method",
      args="()",
      returns = "LayoutParameter*",
      valuetype = "LayoutParameter"
    },
    copyProperties={
      description = "",
      type = "method",
      args="(LayoutParameter*: model)",
      returns = "void",
      valuetype = "void"
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "LayoutParameter*",
      valuetype = "LayoutParameter"
    },
  },
},

LinearLayoutParameter = {
  description = "",
  type = "class",
  inherits = "LayoutParameter ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "LinearLayoutParameter",
      valuetype = "LinearLayoutParameter",
    },
    setGravity={
      description = "",
      type = "method",
      args="(LinearGravity: gravity)",
      returns = "void",
      valuetype = "void"
    },
    getGravity={
      description = "",
      type = "method",
      args="()",
      returns = "LinearGravity",
      valuetype = "LinearGravity"
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "LinearLayoutParameter*",
      valuetype = "LinearLayoutParameter"
    },
  },
},

RelativeLayoutParameter = {
  description = "",
  type = "class",
  inherits = "LayoutParameter ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "RelativeLayoutParameter",
      valuetype = "RelativeLayoutParameter",
    },
    setAlign={
      description = "",
      type = "method",
      args="(RelativeAlign: align)",
      returns = "void",
      valuetype = "void"
    },
    setRelativeToWidgetName={
      description = "",
      type = "method",
      args="(string: name)",
      returns = "void",
      valuetype = "void"
    },
    getRelativeName={
      description = "",
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    getRelativeToWidgetName={
      description = "",
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    setRelativeName={
      description = "",
      type = "method",
      args="(string: name)",
      returns = "void",
      valuetype = "void"
    },
    getAlign={
      description = "",
      type = "method",
      args="()",
      returns = "RelativeAlign",
      valuetype = "RelativeAlign"
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "RelativeLayoutParameter*",
      valuetype = "RelativeLayoutParameter"
    },
  },
},

Widget = {
  description = "",
  type = "class",
  inherits = "ProtectedNode LayoutParameterProtocol ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "Widget",
      valuetype = "Widget",
    },
    setLayoutComponentEnabled={
      description = "",
      type = "method",
      args="(bool: enable)",
      returns = "void",
      valuetype = "void"
    },
    setSizePercent={
      description = "",
      type = "method",
      args="(Vec2: percent)",
      returns = "void",
      valuetype = "void"
    },
    getCustomSize={
      description = "",
      type = "method",
      args="()",
      returns = "Size",
      valuetype = "Size"
    },
    getLeftBoundary={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    setFlippedX={
      description = "",
      type = "method",
      args="(bool: flippedX)",
      returns = "void",
      valuetype = "void"
    },
    setCallbackName={
      description = "",
      type = "method",
      args="(string: callbackName)",
      returns = "void",
      valuetype = "void"
    },
    getVirtualRenderer={
      description = "",
      type = "method",
      args="()",
      returns = "Node*",
      valuetype = "Node"
    },
    setPropagateTouchEvents={
      description = "",
      type = "method",
      args="(bool: isPropagate)",
      returns = "void",
      valuetype = "void"
    },
    isUnifySizeEnabled={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getSizePercent={
      description = "",
      type = "method",
      args="()",
      returns = "Vec2",
      valuetype = "Vec2"
    },
    setPositionPercent={
      description = "",
      type = "method",
      args="(Vec2: percent)",
      returns = "void",
      valuetype = "void"
    },
    setSwallowTouches={
      description = "",
      type = "method",
      args="(bool: swallow)",
      returns = "void",
      valuetype = "void"
    },
    getLayoutSize={
      description = "",
      type = "method",
      args="()",
      returns = "Size",
      valuetype = "Size"
    },
    setHighlighted={
      description = "",
      type = "method",
      args="(bool: hilight)",
      returns = "void",
      valuetype = "void"
    },
    setPositionType={
      description = "",
      type = "method",
      args="(PositionType: type)",
      returns = "void",
      valuetype = "void"
    },
    isIgnoreContentAdaptWithSize={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getVirtualRendererSize={
      description = "",
      type = "method",
      args="()",
      returns = "Size",
      valuetype = "Size"
    },
    isHighlighted={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getPositionType={
      description = "",
      type = "method",
      args="()",
      returns = "PositionType",
      valuetype = "PositionType"
    },
    getTopBoundary={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    ignoreContentAdaptWithSize={
      description = "",
      type = "method",
      args="(bool: ignore)",
      returns = "void",
      valuetype = "void"
    },
    findNextFocusedWidget={
      description = "",
      type = "method",
      args="(FocusDirection: direction,Widget*: current)",
      returns = "Widget*",
      valuetype = "Widget"
    },
    isEnabled={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isFocused={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getTouchBeganPosition={
      description = "",
      type = "method",
      args="()",
      returns = "Vec2",
      valuetype = "Vec2"
    },
    isTouchEnabled={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getCallbackName={
      description = "",
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    getActionTag={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getWorldPosition={
      description = "",
      type = "method",
      args="()",
      returns = "Vec2",
      valuetype = "Vec2"
    },
    isFocusEnabled={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setFocused={
      description = "",
      type = "method",
      args="(bool: focus)",
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
    setTouchEnabled={
      description = "",
      type = "method",
      args="(bool: enabled)",
      returns = "void",
      valuetype = "void"
    },
    setFlippedY={
      description = "",
      type = "method",
      args="(bool: flippedY)",
      returns = "void",
      valuetype = "void"
    },
    setEnabled={
      description = "",
      type = "method",
      args="(bool: enabled)",
      returns = "void",
      valuetype = "void"
    },
    getRightBoundary={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    setBrightStyle={
      description = "",
      type = "method",
      args="(BrightStyle: style)",
      returns = "void",
      valuetype = "void"
    },
    setLayoutParameter={
      description = "",
      type = "method",
      args="(LayoutParameter*: parameter)",
      returns = "void",
      valuetype = "void"
    },
    clone={
      description = "",
      type = "method",
      args="()",
      returns = "Widget*",
      valuetype = "Widget"
    },
    setFocusEnabled={
      description = "",
      type = "method",
      args="(bool: enable)",
      returns = "void",
      valuetype = "void"
    },
    getBottomBoundary={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    isBright={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setUnifySizeEnabled={
      description = "",
      type = "method",
      args="(bool: enable)",
      returns = "void",
      valuetype = "void"
    },
    isPropagateTouchEvents={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getCurrentFocusedWidget={
      description = "",
      type = "method",
      args="()",
      returns = "Widget*",
      valuetype = "Widget"
    },
    hitTest={
      description = "",
      type = "method",
      args="(Vec2: pt)",
      returns = "bool",
      valuetype = "bool"
    },
    isLayoutComponentEnabled={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    requestFocus={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getTouchMovePosition={
      description = "",
      type = "method",
      args="()",
      returns = "Vec2",
      valuetype = "Vec2"
    },
    getSizeType={
      description = "",
      type = "method",
      args="()",
      returns = "SizeType",
      valuetype = "SizeType"
    },
    getCallbackType={
      description = "",
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    getTouchEndPosition={
      description = "",
      type = "method",
      args="()",
      returns = "Vec2",
      valuetype = "Vec2"
    },
    getPositionPercent={
      description = "",
      type = "method",
      args="()",
      returns = "Vec2",
      valuetype = "Vec2"
    },
    isFlippedX={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isFlippedY={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isClippingParentContainsPoint={
      description = "",
      type = "method",
      args="(Vec2: pt)",
      returns = "bool",
      valuetype = "bool"
    },
    setSizeType={
      description = "",
      type = "method",
      args="(SizeType: type)",
      returns = "void",
      valuetype = "void"
    },
    setBright={
      description = "",
      type = "method",
      args="(bool: bright)",
      returns = "void",
      valuetype = "void"
    },
    setCallbackType={
      description = "",
      type = "method",
      args="(string: callbackType)",
      returns = "void",
      valuetype = "void"
    },
    isSwallowTouches={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    enableDpadNavigation={
	  description = "",
      type = "method",
      args="(bool: enable)",
      returns = "void",
      valuetype = "void"
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "Widget*",
      valuetype = "Widget"
    },
  },
},

Layout = {
  description = "",
  type = "class",
  inherits = "Widget LayoutProtocol ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "Layout",
      valuetype = "Layout",
    },
    setBackGroundColorVector={
      description = "",
      type = "method",
      args="(Vec2: vector)",
      returns = "void",
      valuetype = "void"
    },
    setClippingType={
      description = "",
      type = "method",
      args="(ClippingType: type)",
      returns = "void",
      valuetype = "void"
    },
    setBackGroundColorType={
      description = "",
      type = "method",
      args="(BackGroundColorType: type)",
      returns = "void",
      valuetype = "void"
    },
    setLoopFocus={
      description = "",
      type = "method",
      args="(bool: loop)",
      returns = "void",
      valuetype = "void"
    },
    setBackGroundImageColor={
      description = "",
      type = "method",
      args="(Color3B: color)",
      returns = "void",
      valuetype = "void"
    },
    getBackGroundColorVector={
      description = "",
      type = "method",
      args="()",
      returns = "Vec2",
      valuetype = "Vec2"
    },
    getClippingType={
      description = "",
      type = "method",
      args="()",
      returns = "ClippingType",
      valuetype = "ClippingType"
    },
    isLoopFocus={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    removeBackGroundImage={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getBackGroundColorOpacity={
      description = "",
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    isClippingEnabled={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setBackGroundImageOpacity={
      description = "",
      type = "method",
      args="(unsigned char: opacity)",
      returns = "void",
      valuetype = "void"
    },
    setBackGroundImage={
      description = "",
      type = "method",
      args="(string: fileName,TextureResType: texType)",
      returns = "void",
      valuetype = "void"
    },
    requestDoLayout={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getBackGroundImageCapInsets={
      description = "",
      type = "method",
      args="()",
      returns = "Rect",
      valuetype = "Rect"
    },
    getBackGroundColor={
      description = "",
      type = "method",
      args="()",
      returns = "Color3B",
      valuetype = "Color3B"
    },
    setClippingEnabled={
      description = "",
      type = "method",
      args="(bool: enabled)",
      returns = "void",
      valuetype = "void"
    },
    getBackGroundImageColor={
      description = "",
      type = "method",
      args="()",
      returns = "Color3B",
      valuetype = "Color3B"
    },
    isBackGroundImageScale9Enabled={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getBackGroundColorType={
      description = "",
      type = "method",
      args="()",
      returns = "BackGroundColorType",
      valuetype = "BackGroundColorType"
    },
    getBackGroundEndColor={
      description = "",
      type = "method",
      args="()",
      returns = "Color3B",
      valuetype = "Color3B"
    },
    setBackGroundColorOpacity={
      description = "",
      type = "method",
      args="(unsigned char: opacity)",
      returns = "void",
      valuetype = "void"
    },
    getBackGroundImageOpacity={
      description = "",
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    isPassFocusToChild={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setBackGroundImageCapInsets={
      description = "",
      type = "method",
      args="(Rect: capInsets)",
      returns = "void",
      valuetype = "void"
    },
    getBackGroundImageTextureSize={
      description = "",
      type = "method",
      args="()",
      returns = "Size",
      valuetype = "Size"
    },
    forceDoLayout={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getLayoutType={
      description = "",
      type = "method",
      args="()",
      returns = "Type",
      valuetype = "Type"
    },
    setPassFocusToChild={
      description = "",
      type = "method",
      args="(bool: pass)",
      returns = "void",
      valuetype = "void"
    },
    getBackGroundStartColor={
      description = "",
      type = "method",
      args="()",
      returns = "Color3B",
      valuetype = "Color3B"
    },
    setBackGroundImageScale9Enabled={
      description = "",
      type = "method",
      args="(bool: enabled)",
      returns = "void",
      valuetype = "void"
    },
    setLayoutType={
      description = "",
      type = "method",
      args="(Type: type)",
      returns = "void",
      valuetype = "void"
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "Layout*",
      valuetype = "Layout"
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

Button = {
  description = "",
  type = "class",
  inherits = "Widget ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "Button",
      valuetype = "Button",
    },
    getTitleText={
      description = "",
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    setTitleFontSize={
      description = "",
      type = "method",
      args="(float: size)",
      returns = "void",
      valuetype = "void"
    },
    setScale9Enabled={
      description = "",
      type = "method",
      args="(bool: able)",
      returns = "void",
      valuetype = "void"
    },
    getTitleRenderer={
      description = "",
      type = "method",
      args="()",
      returns = "Label*",
      valuetype = "Label"
    },
    getZoomScale={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    getCapInsetsDisabledRenderer={
      description = "",
      type = "method",
      args="()",
      returns = "Rect",
      valuetype = "Rect"
    },
    setTitleColor={
      description = "",
      type = "method",
      args="(Color3B: color)",
      returns = "void",
      valuetype = "void"
    },
    setCapInsetsDisabledRenderer={
      description = "",
      type = "method",
      args="(Rect: capInsets)",
      returns = "void",
      valuetype = "void"
    },
    setCapInsets={
      description = "",
      type = "method",
      args="(Rect: capInsets)",
      returns = "void",
      valuetype = "void"
    },
    loadTextureDisabled={
      description = "",
      type = "method",
      args="(string: disabled,TextureResType: texType)",
      returns = "void",
      valuetype = "void"
    },
    setTitleText={
      description = "",
      type = "method",
      args="(string: text)",
      returns = "void",
      valuetype = "void"
    },
    setCapInsetsNormalRenderer={
      description = "",
      type = "method",
      args="(Rect: capInsets)",
      returns = "void",
      valuetype = "void"
    },
    loadTexturePressed={
      description = "",
      type = "method",
      args="(string: selected,TextureResType: texType)",
      returns = "void",
      valuetype = "void"
    },
    setTitleFontName={
      description = "",
      type = "method",
      args="(string: fontName)",
      returns = "void",
      valuetype = "void"
    },
    getCapInsetsNormalRenderer={
      description = "",
      type = "method",
      args="()",
      returns = "Rect",
      valuetype = "Rect"
    },
    getCapInsetsPressedRenderer={
      description = "",
      type = "method",
      args="()",
      returns = "Rect",
      valuetype = "Rect"
    },
    loadTextures={
      description = "",
      type = "method",
      args="(string: normal,string: selected,string: disabled,TextureResType: texType)",
      returns = "void",
      valuetype = "void"
    },
    isScale9Enabled={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    loadTextureNormal={
      description = "",
      type = "method",
      args="(string: normal,TextureResType: texType)",
      returns = "void",
      valuetype = "void"
    },
    setCapInsetsPressedRenderer={
      description = "",
      type = "method",
      args="(Rect: capInsets)",
      returns = "void",
      valuetype = "void"
    },
    getTitleFontSize={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    getTitleFontName={
      description = "",
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    getTitleColor={
      description = "",
      type = "method",
      args="()",
      returns = "Color3B",
      valuetype = "Color3B"
    },
    setPressedActionEnabled={
      description = "",
      type = "method",
      args="(bool: enabled)",
      returns = "void",
      valuetype = "void"
    },
    setZoomScale={
      description = "",
      type = "method",
      args="(float: scale)",
      returns = "void",
      valuetype = "void"
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

CheckBox = {
  description = "",
  type = "class",
  inherits = "Widget ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CheckBox",
      valuetype = "CheckBox",
    },
    loadTextureBackGroundSelected={
      description = "",
      type = "method",
      args="(string: backGroundSelected,TextureResType: texType)",
      returns = "void",
      valuetype = "void"
    },
    loadTextureBackGroundDisabled={
      description = "",
      type = "method",
      args="(string: backGroundDisabled,TextureResType: texType)",
      returns = "void",
      valuetype = "void"
    },
    setSelected={
      description = "",
      type = "method",
      args="(bool: selected)",
      returns = "void",
      valuetype = "void"
    },
    addEventListener={
      description = "",
      type = "method",
      args="(function: callback)",
      returns = "void",
      valuetype = "void"
    },
    loadTextureFrontCross={
      description = "",
      type = "method",
      args="(string: ,TextureResType: texType)",
      returns = "void",
      valuetype = "void"
    },
    isSelected={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    loadTextures={
      description = "",
      type = "method",
      args="(string: backGround,string: backGroundSelected,string: cross,string: backGroundDisabled,string: frontCrossDisabled,TextureResType: texType)",
      returns = "void",
      valuetype = "void"
    },
    getZoomScale={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    loadTextureBackGround={
      description = "",
      type = "method",
      args="(string: backGround,TextureResType: type)",
      returns = "void",
      valuetype = "void"
    },
    setZoomScale={
      description = "",
      type = "method",
      args="(float: scale)",
      returns = "void",
      valuetype = "void"
    },
    loadTextureFrontCrossDisabled={
      description = "",
      type = "method",
      args="(string: frontCrossDisabled,TextureResType: texType)",
      returns = "void",
      valuetype = "void"
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

ImageView = {
  description = "",
  type = "class",
  inherits = "Widget ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ImageView",
      valuetype = "ImageView",
    },
    loadTexture={
      description = "",
      type = "method",
      args="(string: fileName,TextureResType: texType)",
      returns = "void",
      valuetype = "void"
    },
    setScale9Enabled={
      description = "",
      type = "method",
      args="(bool: able)",
      returns = "void",
      valuetype = "void"
    },
    setTextureRect={
      description = "",
      type = "method",
      args="(Rect: rect)",
      returns = "void",
      valuetype = "void"
    },
    setCapInsets={
      description = "",
      type = "method",
      args="(Rect: capInsets)",
      returns = "void",
      valuetype = "void"
    },
    getCapInsets={
      description = "",
      type = "method",
      args="()",
      returns = "Rect",
      valuetype = "Rect"
    },
    isScale9Enabled={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
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

Text = {
  description = "",
  type = "class",
  inherits = "Widget ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "Text",
      valuetype = "Text",
    },
    enableShadow={
      description = "",
      type = "method",
      args="(Color4B: shadowColor,Size: offset,int: blurRadius)",
      returns = "void",
      valuetype = "void"
    },
    getFontSize={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getString={
      description = "",
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    disableEffect={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getTextColor={
      description = "",
      type = "method",
      args="()",
      returns = "Color4B",
      valuetype = "Color4B"
    },
    setTextVerticalAlignment={
      description = "",
      type = "method",
      args="(TextVAlignment: alignment)",
      returns = "void",
      valuetype = "void"
    },
    setFontName={
      description = "",
      type = "method",
      args="(string: name)",
      returns = "void",
      valuetype = "void"
    },
    setTouchScaleChangeEnabled={
      description = "",
      type = "method",
      args="(bool: enabled)",
      returns = "void",
      valuetype = "void"
    },
    setString={
      description = "",
      type = "method",
      args="(string: text)",
      returns = "void",
      valuetype = "void"
    },
    isTouchScaleChangeEnabled={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getFontName={
      description = "",
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    setTextAreaSize={
      description = "",
      type = "method",
      args="(Size: size)",
      returns = "void",
      valuetype = "void"
    },
    getStringLength={
      description = "",
      type = "method",
      args="()",
      returns = "long",
      valuetype = "long"
    },
    getAutoRenderSize={
      description = "",
      type = "method",
      args="()",
      returns = "Size",
      valuetype = "Size"
    },
    enableOutline={
      description = "",
      type = "method",
      args="(Color4B: outlineColor,int: outlineSize)",
      returns = "void",
      valuetype = "void"
    },
    getType={
      description = "",
      type = "method",
      args="()",
      returns = "Type",
      valuetype = "Type"
    },
    getTextHorizontalAlignment={
      description = "",
      type = "method",
      args="()",
      returns = "TextHAlignment",
      valuetype = "TextHAlignment"
    },
    setFontSize={
      description = "",
      type = "method",
      args="(int: size)",
      returns = "void",
      valuetype = "void"
    },
    setTextColor={
      description = "",
      type = "method",
      args="(Color4B: color)",
      returns = "void",
      valuetype = "void"
    },
    enableGlow={
      description = "",
      type = "method",
      args="(Color4B: glowColor)",
      returns = "void",
      valuetype = "void"
    },
    getTextVerticalAlignment={
      description = "",
      type = "method",
      args="()",
      returns = "TextVAlignment",
      valuetype = "TextVAlignment"
    },
    getTextAreaSize={
      description = "",
      type = "method",
      args="()",
      returns = "Size",
      valuetype = "Size"
    },
    setTextHorizontalAlignment={
      description = "",
      type = "method",
      args="(TextHAlignment: alignment)",
      returns = "void",
      valuetype = "void"
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

TextAtlas = {
  description = "",
  type = "class",
  inherits = "Widget ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "TextAtlas",
      valuetype = "TextAtlas",
    },
    getStringLength={
      description = "",
      type = "method",
      args="()",
      returns = "long",
      valuetype = "long"
    },
    getString={
      description = "",
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    setString={
      description = "",
      type = "method",
      args="(string: value)",
      returns = "void",
      valuetype = "void"
    },
    setProperty={
      description = "",
      type = "method",
      args="(string: stringValue,string: charMapFile,int: itemWidth,int: itemHeight,string: startCharMap)",
      returns = "void",
      valuetype = "void"
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

LoadingBar = {
  description = "",
  type = "class",
  inherits = "Widget ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "LoadingBar",
      valuetype = "LoadingBar",
    },
    setPercent={
      description = "",
      type = "method",
      args="(float: percent)",
      returns = "void",
      valuetype = "void"
    },
    loadTexture={
      description = "",
      type = "method",
      args="(string: texture,TextureResType: texType)",
      returns = "void",
      valuetype = "void"
    },
    setDirection={
      description = "",
      type = "method",
      args="(Direction: direction)",
      returns = "void",
      valuetype = "void"
    },
    setScale9Enabled={
      description = "",
      type = "method",
      args="(bool: enabled)",
      returns = "void",
      valuetype = "void"
    },
    setCapInsets={
      description = "",
      type = "method",
      args="(Rect: capInsets)",
      returns = "void",
      valuetype = "void"
    },
    getDirection={
      description = "",
      type = "method",
      args="()",
      returns = "Direction",
      valuetype = "Direction"
    },
    getCapInsets={
      description = "",
      type = "method",
      args="()",
      returns = "Rect",
      valuetype = "Rect"
    },
    isScale9Enabled={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getPercent={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
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

ScrollView = {
  description = "",
  type = "class",
  inherits = "Layout ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ScrollView",
      valuetype = "ScrollView",
    },
    scrollToTop={
      description = "",
      type = "method",
      args="(float: time,bool: attenuated)",
      returns = "void",
      valuetype = "void"
    },
    scrollToPercentHorizontal={
      description = "",
      type = "method",
      args="(float: percent,float: time,bool: attenuated)",
      returns = "void",
      valuetype = "void"
    },
    isInertiaScrollEnabled={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    scrollToPercentBothDirection={
      description = "",
      type = "method",
      args="(Vec2: percent,float: time,bool: attenuated)",
      returns = "void",
      valuetype = "void"
    },
    getDirection={
      description = "",
      type = "method",
      args="()",
      returns = "Direction",
      valuetype = "Direction"
    },
    scrollToBottomLeft={
      description = "",
      type = "method",
      args="(float: time,bool: attenuated)",
      returns = "void",
      valuetype = "void"
    },
    getInnerContainer={
      description = "",
      type = "method",
      args="()",
      returns = "Layout*",
      valuetype = "Layout"
    },
    jumpToBottom={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    setDirection={
      description = "",
      type = "method",
      args="(Direction: dir)",
      returns = "void",
      valuetype = "void"
    },
    scrollToTopLeft={
      description = "",
      type = "method",
      args="(float: time,bool: attenuated)",
      returns = "void",
      valuetype = "void"
    },
    jumpToTopRight={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    jumpToBottomLeft={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    setInnerContainerSize={
      description = "",
      type = "method",
      args="(Size: size)",
      returns = "void",
      valuetype = "void"
    },
    getInnerContainerSize={
      description = "",
      type = "method",
      args="()",
      returns = "Size",
      valuetype = "Size"
    },
    isBounceEnabled={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    jumpToPercentVertical={
      description = "",
      type = "method",
      args="(float: percent)",
      returns = "void",
      valuetype = "void"
    },
    addEventListener={
      description = "",
      type = "method",
      args="(function: callback)",
      returns = "void",
      valuetype = "void"
    },
    setInertiaScrollEnabled={
      description = "",
      type = "method",
      args="(bool: enabled)",
      returns = "void",
      valuetype = "void"
    },
    jumpToTopLeft={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    jumpToPercentHorizontal={
      description = "",
      type = "method",
      args="(float: percent)",
      returns = "void",
      valuetype = "void"
    },
    jumpToBottomRight={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    setBounceEnabled={
      description = "",
      type = "method",
      args="(bool: enabled)",
      returns = "void",
      valuetype = "void"
    },
    jumpToTop={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    scrollToLeft={
      description = "",
      type = "method",
      args="(float: time,bool: attenuated)",
      returns = "void",
      valuetype = "void"
    },
    jumpToPercentBothDirection={
      description = "",
      type = "method",
      args="(Vec2: percent)",
      returns = "void",
      valuetype = "void"
    },
    scrollToPercentVertical={
      description = "",
      type = "method",
      args="(float: percent,float: time,bool: attenuated)",
      returns = "void",
      valuetype = "void"
    },
    scrollToBottom={
      description = "",
      type = "method",
      args="(float: time,bool: attenuated)",
      returns = "void",
      valuetype = "void"
    },
    scrollToBottomRight={
      description = "",
      type = "method",
      args="(float: time,bool: attenuated)",
      returns = "void",
      valuetype = "void"
    },
    jumpToLeft={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    scrollToRight={
      description = "",
      type = "method",
      args="(float: time,bool: attenuated)",
      returns = "void",
      valuetype = "void"
    },
    jumpToRight={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    scrollToTopRight={
      description = "",
      type = "method",
      args="(float: time,bool: attenuated)",
      returns = "void",
      valuetype = "void"
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "ScrollView*",
      valuetype = "ScrollView"
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

ListView = {
  description = "",
  type = "class",
  inherits = "ScrollView ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ListView",
      valuetype = "ListView",
    },
    getIndex={
      description = "",
      type = "method",
      args="(Widget*: item)",
      returns = "long",
      valuetype = "long"
    },
    removeAllItems={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    setGravity={
      description = "",
      type = "method",
      args="(Gravity: gravity)",
      returns = "void",
      valuetype = "void"
    },
    pushBackCustomItem={
      description = "",
      type = "method",
      args="(Widget*: item)",
      returns = "void",
      valuetype = "void"
    },
    getItems={
      description = "",
      type = "method",
      args="()",
      returns = "Vector<cocos2d::ui::Widget *>",
      valuetype = "Vector<cocos2d::ui::Widget >"
    },
    removeItem={
      description = "",
      type = "method",
      args="(long: index)",
      returns = "void",
      valuetype = "void"
    },
    getCurSelectedIndex={
      description = "",
      type = "method",
      args="()",
      returns = "long",
      valuetype = "long"
    },
    insertDefaultItem={
      description = "",
      type = "method",
      args="(long: index)",
      returns = "void",
      valuetype = "void"
    },
    requestRefreshView={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    setItemsMargin={
      description = "",
      type = "method",
      args="(float: margin)",
      returns = "void",
      valuetype = "void"
    },
    refreshView={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    removeLastItem={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getItemsMargin={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    addEventListener={
      description = "",
      type = "method",
      args="(function: callback)",
      returns = "void",
      valuetype = "void"
    },
    getItem={
      description = "",
      type = "method",
      args="(long: index)",
      returns = "Widget*",
      valuetype = "Widget"
    },
    setItemModel={
      description = "",
      type = "method",
      args="(Widget*: model)",
      returns = "void",
      valuetype = "void"
    },
    pushBackDefaultItem={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    insertCustomItem={
      description = "",
      type = "method",
      args="(Widget*: item,long: index)",
      returns = "void",
      valuetype = "void"
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "ListView*",
      valuetype = "ListView"
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

Slider = {
  description = "",
  type = "class",
  inherits = "Widget ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "Slider",
      valuetype = "Slider",
    },
    setPercent={
      description = "",
      type = "method",
      args="(int: percent)",
      returns = "void",
      valuetype = "void"
    },
    loadSlidBallTextureDisabled={
      description = "",
      type = "method",
      args="(string: disabled,TextureResType: resType)",
      returns = "void",
      valuetype = "void"
    },
    loadSlidBallTextureNormal={
      description = "",
      type = "method",
      args="(string: normal,TextureResType: resType)",
      returns = "void",
      valuetype = "void"
    },
    loadBarTexture={
      description = "",
      type = "method",
      args="(string: fileName,TextureResType: resType)",
      returns = "void",
      valuetype = "void"
    },
    loadProgressBarTexture={
      description = "",
      type = "method",
      args="(string: fileName,TextureResType: resType)",
      returns = "void",
      valuetype = "void"
    },
    loadSlidBallTextures={
      description = "",
      type = "method",
      args="(string: normal,string: pressed,string: disabled,TextureResType: texType)",
      returns = "void",
      valuetype = "void"
    },
    setCapInsetProgressBarRebderer={
      description = "",
      type = "method",
      args="(Rect: capInsets)",
      returns = "void",
      valuetype = "void"
    },
    setCapInsetsBarRenderer={
      description = "",
      type = "method",
      args="(Rect: capInsets)",
      returns = "void",
      valuetype = "void"
    },
    getCapInsetsProgressBarRebderer={
      description = "",
      type = "method",
      args="()",
      returns = "Rect",
      valuetype = "Rect"
    },
    setScale9Enabled={
      description = "",
      type = "method",
      args="(bool: able)",
      returns = "void",
      valuetype = "void"
    },
    setZoomScale={
      description = "",
      type = "method",
      args="(float: scale)",
      returns = "void",
      valuetype = "void"
    },
    setCapInsets={
      description = "",
      type = "method",
      args="(Rect: capInsets)",
      returns = "void",
      valuetype = "void"
    },
    getZoomScale={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    addEventListener={
      description = "",
      type = "method",
      args="(function: callback)",
      returns = "void",
      valuetype = "void"
    },
    loadSlidBallTexturePressed={
      description = "",
      type = "method",
      args="(string: pressed,TextureResType: resType)",
      returns = "void",
      valuetype = "void"
    },
    isScale9Enabled={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getCapInsetsBarRenderer={
      description = "",
      type = "method",
      args="()",
      returns = "Rect",
      valuetype = "Rect"
    },
    getPercent={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
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

TextField = {
  description = "",
  type = "class",
  inherits = "Widget ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "TextField",
      valuetype = "TextField",
    },
    setAttachWithIME={
      description = "",
      type = "method",
      args="(bool: attach)",
      returns = "void",
      valuetype = "void"
    },
    getFontSize={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getString={
      description = "",
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    setPasswordStyleText={
      description = "",
      type = "method",
      args="(char*: styleText)",
      returns = "void",
      valuetype = "void"
    },
    getDeleteBackward={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getPlaceHolder={
      description = "",
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    getAttachWithIME={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setFontName={
      description = "",
      type = "method",
      args="(string: name)",
      returns = "void",
      valuetype = "void"
    },
    getInsertText={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setInsertText={
      description = "",
      type = "method",
      args="(bool: insertText)",
      returns = "void",
      valuetype = "void"
    },
    setString={
      description = "",
      type = "method",
      args="(string: text)",
      returns = "void",
      valuetype = "void"
    },
    getDetachWithIME={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setTextVerticalAlignment={
      description = "",
      type = "method",
      args="(TextVAlignment: alignment)",
      returns = "void",
      valuetype = "void"
    },
    addEventListener={
      description = "",
      type = "method",
      args="(function: callback)",
      returns = "void",
      valuetype = "void"
    },
    didNotSelectSelf={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getFontName={
      description = "",
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    setTextAreaSize={
      description = "",
      type = "method",
      args="(Size: size)",
      returns = "void",
      valuetype = "void"
    },
    attachWithIME={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getStringLength={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getAutoRenderSize={
      description = "",
      type = "method",
      args="()",
      returns = "Size",
      valuetype = "Size"
    },
    setPasswordEnabled={
      description = "",
      type = "method",
      args="(bool: enable)",
      returns = "void",
      valuetype = "void"
    },
    getPlaceHolderColor={
      description = "",
      type = "method",
      args="()",
      returns = "Color4B",
      valuetype = "Color4B"
    },
    getPasswordStyleText={
      description = "",
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
    setMaxLengthEnabled={
      description = "",
      type = "method",
      args="(bool: enable)",
      returns = "void",
      valuetype = "void"
    },
    isPasswordEnabled={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setDeleteBackward={
      description = "",
      type = "method",
      args="(bool: deleteBackward)",
      returns = "void",
      valuetype = "void"
    },
    setFontSize={
      description = "",
      type = "method",
      args="(int: size)",
      returns = "void",
      valuetype = "void"
    },
    setPlaceHolder={
      description = "",
      type = "method",
      args="(string: value)",
      returns = "void",
      valuetype = "void"
    },
    setTextHorizontalAlignment={
      description = "",
      type = "method",
      args="(TextHAlignment: alignment)",
      returns = "void",
      valuetype = "void"
    },
    setTextColor={
      description = "",
      type = "method",
      args="(Color4B: textColor)",
      returns = "void",
      valuetype = "void"
    },
    getMaxLength={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    isMaxLengthEnabled={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setDetachWithIME={
      description = "",
      type = "method",
      args="(bool: detach)",
      returns = "void",
      valuetype = "void"
    },
    setTouchAreaEnabled={
      description = "",
      type = "method",
      args="(bool: enable)",
      returns = "void",
      valuetype = "void"
    },
    hitTest={
      description = "",
      type = "method",
      args="(Vec2: pt)",
      returns = "bool",
      valuetype = "bool"
    },
    setMaxLength={
      description = "",
      type = "method",
      args="(int: length)",
      returns = "void",
      valuetype = "void"
    },
    setTouchSize={
      description = "",
      type = "method",
      args="(Size: size)",
      returns = "void",
      valuetype = "void"
    },
    getTouchSize={
      description = "",
      type = "method",
      args="()",
      returns = "Size",
      valuetype = "Size"
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

TextBMFont = {
  description = "",
  type = "class",
  inherits = "Widget ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "TextBMFont",
      valuetype = "TextBMFont",
    },
    setFntFile={
      description = "",
      type = "method",
      args="(string: fileName)",
      returns = "void",
      valuetype = "void"
    },
    getStringLength={
      description = "",
      type = "method",
      args="()",
      returns = "long",
      valuetype = "long"
    },
    setString={
      description = "",
      type = "method",
      args="(string: value)",
      returns = "void",
      valuetype = "void"
    },
    getString={
      description = "",
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
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

PageView = {
  description = "",
  type = "class",
  inherits = "Layout ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PageView",
      valuetype = "PageView",
    },
    getCustomScrollThreshold={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    getCurPageIndex={
      description = "",
      type = "method",
      args="()",
      returns = "long",
      valuetype = "long"
    },
    addWidgetToPage={
      description = "",
      type = "method",
      args="(Widget*: widget,long: pageIdx,bool: forceCreate)",
      returns = "void",
      valuetype = "void"
    },
    isUsingCustomScrollThreshold={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getPage={
      description = "",
      type = "method",
      args="(long: index)",
      returns = "Layout*",
      valuetype = "Layout"
    },
    removePage={
      description = "",
      type = "method",
      args="(Layout*: page)",
      returns = "void",
      valuetype = "void"
    },
    addEventListener={
      description = "",
      type = "method",
      args="(function: callback)",
      returns = "void",
      valuetype = "void"
    },
    setUsingCustomScrollThreshold={
      description = "",
      type = "method",
      args="(bool: flag)",
      returns = "void",
      valuetype = "void"
    },
    setCustomScrollThreshold={
      description = "",
      type = "method",
      args="(float: threshold)",
      returns = "void",
      valuetype = "void"
    },
    insertPage={
      description = "",
      type = "method",
      args="(Layout*: page,int: idx)",
      returns = "void",
      valuetype = "void"
    },
    scrollToPage={
      description = "",
      type = "method",
      args="(long: idx)",
      returns = "void",
      valuetype = "void"
    },
    removePageAtIndex={
      description = "",
      type = "method",
      args="(long: index)",
      returns = "void",
      valuetype = "void"
    },
    getPages={
      description = "",
      type = "method",
      args="()",
      returns = "Vector<cocos2d::ui::Layout *>",
      valuetype = "Vector<cocos2d::ui::Layout >"
    },
    removeAllPages={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    addPage={
      description = "",
      type = "method",
      args="(Layout*: page)",
      returns = "void",
      valuetype = "void"
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "PageView*",
      valuetype = "PageView"
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

Helper = {
  description = "",
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "Helper",
      valuetype = "Helper",
    },
    getSubStringOfUTF8String={
	  description = "",
      type = "method",
      args="(string: str,unsigned int: start,unsigned int: length)",
      returns = "string",
      valuetype = "string"
    },
    changeLayoutSystemActiveState={
	  description = "",
      type = "method",
      args="(bool: bActive)",
      returns = "void",
      valuetype = "void"
    },
    seekActionWidgetByActionTag={
	  description = "",
      type = "method",
      args="(Widget*: root,int: tag)",
      returns = "Widget*",
      valuetype = "Widget"
    },
    seekWidgetByName={
	  description = "",
      type = "method",
      args="(Widget*: root,string: name)",
      returns = "Widget*",
      valuetype = "Widget"
    },
    seekWidgetByTag={
	  description = "",
      type = "method",
      args="(Widget*: root,int: tag)",
      returns = "Widget*",
      valuetype = "Widget"
    },
    restrictCapInsetRect={
	  description = "",
      type = "method",
      args="(Rect: capInsets,Size: textureSize)",
      returns = "Rect",
      valuetype = "Rect"
    },
    doLayout={
	  description = "",
      type = "method",
      args="(Node*: rootNode)",
      returns = "void",
      valuetype = "void"
    },
  },
},

RichElement = {
  description = "",
  type = "class",
  inherits = "Ref ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "RichElement",
      valuetype = "RichElement",
    },
    init={
      description = "",
      type = "method",
      args="(int: tag,Color3B: color,unsigned char: opacity)",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

RichElementText = {
  description = "",
  type = "class",
  inherits = "RichElement ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "RichElementText",
      valuetype = "RichElementText",
    },
    init={
      description = "",
      type = "method",
      args="(int: tag,Color3B: color,unsigned char: opacity,string: text,string: fontName,float: fontSize)",
      returns = "bool",
      valuetype = "bool"
    },
    create={
	  description = "",
      type = "method",
      args="(int: tag,Color3B: color,unsigned char: opacity,string: text,string: fontName,float: fontSize)",
      returns = "RichElementText*",
      valuetype = "RichElementText"
    },
  },
},

RichElementImage = {
  description = "",
  type = "class",
  inherits = "RichElement ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "RichElementImage",
      valuetype = "RichElementImage",
    },
    init={
      description = "",
      type = "method",
      args="(int: tag,Color3B: color,unsigned char: opacity,string: filePath)",
      returns = "bool",
      valuetype = "bool"
    },
    create={
	  description = "",
      type = "method",
      args="(int: tag,Color3B: color,unsigned char: opacity,string: filePath)",
      returns = "RichElementImage*",
      valuetype = "RichElementImage"
    },
  },
},

RichElementCustomNode = {
  description = "",
  type = "class",
  inherits = "RichElement ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "RichElementCustomNode",
      valuetype = "RichElementCustomNode",
    },
    init={
      description = "",
      type = "method",
      args="(int: tag,Color3B: color,unsigned char: opacity,Node*: customNode)",
      returns = "bool",
      valuetype = "bool"
    },
    create={
	  description = "",
      type = "method",
      args="(int: tag,Color3B: color,unsigned char: opacity,Node*: customNode)",
      returns = "RichElementCustomNode*",
      valuetype = "RichElementCustomNode"
    },
  },
},

RichText = {
  description = "",
  type = "class",
  inherits = "Widget ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "RichText",
      valuetype = "RichText",
    },
    insertElement={
      description = "",
      type = "method",
      args="(RichElement*: element,int: index)",
      returns = "void",
      valuetype = "void"
    },
    setAnchorPoint={
      description = "",
      type = "method",
      args="(Vec2: pt)",
      returns = "void",
      valuetype = "void"
    },
    pushBackElement={
      description = "",
      type = "method",
      args="(RichElement*: element)",
      returns = "void",
      valuetype = "void"
    },
    ignoreContentAdaptWithSize={
      description = "",
      type = "method",
      args="(bool: ignore)",
      returns = "void",
      valuetype = "void"
    },
    setVerticalSpace={
      description = "",
      type = "method",
      args="(float: space)",
      returns = "void",
      valuetype = "void"
    },
    formatText={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "RichText*",
      valuetype = "RichText"
    },
  },
},

HBox = {
  description = "",
  type = "class",
  inherits = "Layout ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "HBox",
      valuetype = "HBox",
    },
  },
},

VBox = {
  description = "",
  type = "class",
  inherits = "Layout ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "VBox",
      valuetype = "VBox",
    },
  },
},

RelativeBox = {
  description = "",
  type = "class",
  inherits = "Layout ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "RelativeBox",
      valuetype = "RelativeBox",
    },
  },
},

Scale9Sprite = {
  description = "",
  type = "class",
  inherits = "Node ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "Scale9Sprite",
      valuetype = "Scale9Sprite",
    },
    isFlippedX={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setScale9Enabled={
      description = "",
      type = "method",
      args="(bool: enabled)",
      returns = "void",
      valuetype = "void"
    },
    setFlippedY={
      description = "",
      type = "method",
      args="(bool: flippedY)",
      returns = "void",
      valuetype = "void"
    },
    setFlippedX={
      description = "",
      type = "method",
      args="(bool: flippedX)",
      returns = "void",
      valuetype = "void"
    },
    resizableSpriteWithCapInsets={
      description = "",
      type = "method",
      args="(Rect: capInsets)",
      returns = "Scale9Sprite*",
      valuetype = "Scale9Sprite"
    },
    setState={
      description = "",
      type = "method",
      args="(State: state)",
      returns = "void",
      valuetype = "void"
    },
    setInsetBottom={
      description = "",
      type = "method",
      args="(float: bottomInset)",
      returns = "void",
      valuetype = "void"
    },
    getSprite={
      description = "",
      type = "method",
      args="()",
      returns = "Sprite*",
      valuetype = "Sprite"
    },
    setInsetTop={
      description = "",
      type = "method",
      args="(float: topInset)",
      returns = "void",
      valuetype = "void"
    },
    setPreferredSize={
      description = "",
      type = "method",
      args="(Size: size)",
      returns = "void",
      valuetype = "void"
    },
    setSpriteFrame={
      description = "",
      type = "method",
      args="(SpriteFrame*: spriteFrame,Rect: capInsets)",
      returns = "void",
      valuetype = "void"
    },
    getInsetBottom={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    getCapInsets={
      description = "",
      type = "method",
      args="()",
      returns = "Rect",
      valuetype = "Rect"
    },
    isScale9Enabled={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getInsetRight={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    getOriginalSize={
      description = "",
      type = "method",
      args="()",
      returns = "Size",
      valuetype = "Size"
    },
    getInsetTop={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    setInsetLeft={
      description = "",
      type = "method",
      args="(float: leftInset)",
      returns = "void",
      valuetype = "void"
    },
    getPreferredSize={
      description = "",
      type = "method",
      args="()",
      returns = "Size",
      valuetype = "Size"
    },
    setCapInsets={
      description = "",
      type = "method",
      args="(Rect: rect)",
      returns = "void",
      valuetype = "void"
    },
    isFlippedY={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getInsetLeft={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    setInsetRight={
      description = "",
      type = "method",
      args="(float: rightInset)",
      returns = "void",
      valuetype = "void"
    },
  },
},

EditBox = {
  description = "",
  type = "class",
  inherits = "Widget IMEDelegate ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "EditBox",
      valuetype = "EditBox",
    },
    getScriptEditBoxHandler={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getText={
      description = "",
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
    setPlaceholderFontName={
      description = "",
      type = "method",
      args="(char*: pFontName)",
      returns = "void",
      valuetype = "void"
    },
    getPlaceHolder={
      description = "",
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
    setFontName={
      description = "",
      type = "method",
      args="(char*: pFontName)",
      returns = "void",
      valuetype = "void"
    },
    registerScriptEditBoxHandler={
      description = "",
      type = "method",
      args="(int: handler)",
      returns = "void",
      valuetype = "void"
    },
    setPlaceholderFontSize={
      description = "",
      type = "method",
      args="(int: fontSize)",
      returns = "void",
      valuetype = "void"
    },
    setInputMode={
      description = "",
      type = "method",
      args="(InputMode: inputMode)",
      returns = "void",
      valuetype = "void"
    },
    unregisterScriptEditBoxHandler={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    setPlaceholderFontColor={
      description = "",
      type = "method",
      args="(Color3B: color)",
      returns = "void",
      valuetype = "void"
    },
    setFontColor={
      description = "",
      type = "method",
      args="(Color3B: color)",
      returns = "void",
      valuetype = "void"
    },
    touchDownAction={
      description = "",
      type = "method",
      args="(Ref*: sender,TouchEventType: controlEvent)",
      returns = "void",
      valuetype = "void"
    },
    setPlaceholderFont={
      description = "",
      type = "method",
      args="(char*: pFontName,int: fontSize)",
      returns = "void",
      valuetype = "void"
    },
    setFontSize={
      description = "",
      type = "method",
      args="(int: fontSize)",
      returns = "void",
      valuetype = "void"
    },
    setPlaceHolder={
      description = "",
      type = "method",
      args="(char*: pText)",
      returns = "void",
      valuetype = "void"
    },
    setReturnType={
      description = "",
      type = "method",
      args="(KeyboardReturnType: returnType)",
      returns = "void",
      valuetype = "void"
    },
    setInputFlag={
      description = "",
      type = "method",
      args="(InputFlag: inputFlag)",
      returns = "void",
      valuetype = "void"
    },
    getMaxLength={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    setText={
      description = "",
      type = "method",
      args="(char*: pText)",
      returns = "void",
      valuetype = "void"
    },
    setMaxLength={
      description = "",
      type = "method",
      args="(int: maxLength)",
      returns = "void",
      valuetype = "void"
    },
    setFont={
      description = "",
      type = "method",
      args="(char*: pFontName,int: fontSize)",
      returns = "void",
      valuetype = "void"
    },
  },
},

LayoutComponent = {
  description = "",
  type = "class",
  inherits = "Component ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "LayoutComponent",
      valuetype = "LayoutComponent",
    },
    setStretchWidthEnabled={
      description = "",
      type = "method",
      args="(bool: isUsed)",
      returns = "void",
      valuetype = "void"
    },
    setPercentWidth={
      description = "",
      type = "method",
      args="(float: percentWidth)",
      returns = "void",
      valuetype = "void"
    },
    getAnchorPosition={
      description = "",
      type = "method",
      args="()",
      returns = "Vec2",
      valuetype = "Vec2"
    },
    setPositionPercentXEnabled={
      description = "",
      type = "method",
      args="(bool: isUsed)",
      returns = "void",
      valuetype = "void"
    },
    setStretchHeightEnabled={
      description = "",
      type = "method",
      args="(bool: isUsed)",
      returns = "void",
      valuetype = "void"
    },
    setActiveEnabled={
      description = "",
      type = "method",
      args="(bool: enable)",
      returns = "void",
      valuetype = "void"
    },
    getRightMargin={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    getSize={
      description = "",
      type = "method",
      args="()",
      returns = "Size",
      valuetype = "Size"
    },
    setAnchorPosition={
      description = "",
      type = "method",
      args="(Vec2: point)",
      returns = "void",
      valuetype = "void"
    },
    refreshLayout={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    isPercentWidthEnabled={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setVerticalEdge={
      description = "",
      type = "method",
      args="(VerticalEdge: vEage)",
      returns = "void",
      valuetype = "void"
    },
    getTopMargin={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    setSizeWidth={
      description = "",
      type = "method",
      args="(float: width)",
      returns = "void",
      valuetype = "void"
    },
    getPercentContentSize={
      description = "",
      type = "method",
      args="()",
      returns = "Vec2",
      valuetype = "Vec2"
    },
    getVerticalEdge={
      description = "",
      type = "method",
      args="()",
      returns = "VerticalEdge",
      valuetype = "VerticalEdge"
    },
    setPercentWidthEnabled={
      description = "",
      type = "method",
      args="(bool: isUsed)",
      returns = "void",
      valuetype = "void"
    },
    isStretchWidthEnabled={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setLeftMargin={
      description = "",
      type = "method",
      args="(float: margin)",
      returns = "void",
      valuetype = "void"
    },
    getSizeWidth={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    setPositionPercentYEnabled={
      description = "",
      type = "method",
      args="(bool: isUsed)",
      returns = "void",
      valuetype = "void"
    },
    getSizeHeight={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    getPositionPercentY={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    getPositionPercentX={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    setTopMargin={
      description = "",
      type = "method",
      args="(float: margin)",
      returns = "void",
      valuetype = "void"
    },
    getPercentHeight={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    getUsingPercentContentSize={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setPositionPercentY={
      description = "",
      type = "method",
      args="(float: percentMargin)",
      returns = "void",
      valuetype = "void"
    },
    setPositionPercentX={
      description = "",
      type = "method",
      args="(float: percentMargin)",
      returns = "void",
      valuetype = "void"
    },
    setRightMargin={
      description = "",
      type = "method",
      args="(float: margin)",
      returns = "void",
      valuetype = "void"
    },
    isPositionPercentYEnabled={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setPercentHeight={
      description = "",
      type = "method",
      args="(float: percentHeight)",
      returns = "void",
      valuetype = "void"
    },
    setPercentOnlyEnabled={
      description = "",
      type = "method",
      args="(bool: enable)",
      returns = "void",
      valuetype = "void"
    },
    setHorizontalEdge={
      description = "",
      type = "method",
      args="(HorizontalEdge: hEage)",
      returns = "void",
      valuetype = "void"
    },
    setPosition={
      description = "",
      type = "method",
      args="(Vec2: position)",
      returns = "void",
      valuetype = "void"
    },
    setUsingPercentContentSize={
      description = "",
      type = "method",
      args="(bool: isUsed)",
      returns = "void",
      valuetype = "void"
    },
    getLeftMargin={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    getPosition={
      description = "",
      type = "method",
      args="()",
      returns = "Vec2",
      valuetype = "Vec2"
    },
    setSizeHeight={
      description = "",
      type = "method",
      args="(float: height)",
      returns = "void",
      valuetype = "void"
    },
    isPositionPercentXEnabled={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getBottomMargin={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    setPercentHeightEnabled={
      description = "",
      type = "method",
      args="(bool: isUsed)",
      returns = "void",
      valuetype = "void"
    },
    setPercentContentSize={
      description = "",
      type = "method",
      args="(Vec2: percent)",
      returns = "void",
      valuetype = "void"
    },
    isPercentHeightEnabled={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getPercentWidth={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    getHorizontalEdge={
      description = "",
      type = "method",
      args="()",
      returns = "HorizontalEdge",
      valuetype = "HorizontalEdge"
    },
    isStretchHeightEnabled={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setBottomMargin={
      description = "",
      type = "method",
      args="(float: margin)",
      returns = "void",
      valuetype = "void"
    },
    setSize={
      description = "",
      type = "method",
      args="(Size: size)",
      returns = "void",
      valuetype = "void"
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "LayoutComponent*",
      valuetype = "LayoutComponent"
    },
    bindLayoutComponent={
	  description = "",
      type = "method",
      args="(Node*: node)",
      returns = "LayoutComponent*",
      valuetype = "LayoutComponent"
    },
  },
},

}
end