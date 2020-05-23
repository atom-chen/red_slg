require "api/lua/cpprootdir"
require "api/lua/cppapi"

do return{

Control = {
  description = "",
  type = "class",
  inherits = "Layer ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "Control",
      valuetype = "Control",
    },
    setEnabled={
      description = "",
      type = "method",
      args="(bool: bEnabled)",
      returns = "void",
      valuetype = "void"
    },
    onTouchMoved={
      description = "",
      type = "method",
      args="(Touch*: touch,Event*: event)",
      returns = "void",
      valuetype = "void"
    },
    getState={
      description = "",
      type = "method",
      args="()",
      returns = "State",
      valuetype = "State"
    },
    onTouchEnded={
      description = "",
      type = "method",
      args="(Touch*: touch,Event*: event)",
      returns = "void",
      valuetype = "void"
    },
    sendActionsForControlEvents={
      description = "",
      type = "method",
      args="(EventType: controlEvents)",
      returns = "void",
      valuetype = "void"
    },
    setSelected={
      description = "",
      type = "method",
      args="(bool: bSelected)",
      returns = "void",
      valuetype = "void"
    },
    isEnabled={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    onTouchCancelled={
      description = "",
      type = "method",
      args="(Touch*: touch,Event*: event)",
      returns = "void",
      valuetype = "void"
    },
    needsLayout={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    onTouchBegan={
      description = "",
      type = "method",
      args="(Touch*: touch,Event*: event)",
      returns = "bool",
      valuetype = "bool"
    },
    hasVisibleParents={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isSelected={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isTouchInside={
      description = "",
      type = "method",
      args="(Touch*: touch)",
      returns = "bool",
      valuetype = "bool"
    },
    setHighlighted={
      description = "",
      type = "method",
      args="(bool: bHighlighted)",
      returns = "void",
      valuetype = "void"
    },
    getTouchLocation={
      description = "",
      type = "method",
      args="(Touch*: touch)",
      returns = "Vec2",
      valuetype = "Vec2"
    },
    isHighlighted={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "Control*",
      valuetype = "Control"
    },
  },
},

ControlButton = {
  description = "",
  type = "class",
  inherits = "Control ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ControlButton",
      valuetype = "ControlButton",
    },
    isPushed={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setSelected={
      description = "",
      type = "method",
      args="(bool: enabled)",
      returns = "void",
      valuetype = "void"
    },
    setTitleLabelForState={
      description = "",
      type = "method",
      args="(Node*: label,State: state)",
      returns = "void",
      valuetype = "void"
    },
    setAdjustBackgroundImage={
      description = "",
      type = "method",
      args="(bool: adjustBackgroundImage)",
      returns = "void",
      valuetype = "void"
    },
    setHighlighted={
      description = "",
      type = "method",
      args="(bool: enabled)",
      returns = "void",
      valuetype = "void"
    },
    setZoomOnTouchDown={
      description = "",
      type = "method",
      args="(bool: var)",
      returns = "void",
      valuetype = "void"
    },
    setTitleForState={
      description = "",
      type = "method",
      args="(string: title,State: state)",
      returns = "void",
      valuetype = "void"
    },
    setLabelAnchorPoint={
      description = "",
      type = "method",
      args="(Vec2: var)",
      returns = "void",
      valuetype = "void"
    },
    getLabelAnchorPoint={
      description = "",
      type = "method",
      args="()",
      returns = "Vec2",
      valuetype = "Vec2"
    },
    getTitleTTFSizeForState={
      description = "",
      type = "method",
      args="(State: state)",
      returns = "float",
      valuetype = "float"
    },
    setTitleTTFForState={
      description = "",
      type = "method",
      args="(string: fntFile,State: state)",
      returns = "void",
      valuetype = "void"
    },
    setTitleTTFSizeForState={
      description = "",
      type = "method",
      args="(float: size,State: state)",
      returns = "void",
      valuetype = "void"
    },
    setTitleLabel={
      description = "",
      type = "method",
      args="(Node*: var)",
      returns = "void",
      valuetype = "void"
    },
    setPreferredSize={
      description = "",
      type = "method",
      args="(Size: var)",
      returns = "void",
      valuetype = "void"
    },
    getCurrentTitleColor={
      description = "",
      type = "method",
      args="()",
      returns = "Color3B",
      valuetype = "Color3B"
    },
    setEnabled={
      description = "",
      type = "method",
      args="(bool: enabled)",
      returns = "void",
      valuetype = "void"
    },
    getBackgroundSpriteForState={
      description = "",
      type = "method",
      args="(State: state)",
      returns = "Scale9Sprite*",
      valuetype = "Scale9Sprite"
    },
    getHorizontalOrigin={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    needsLayout={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getScaleRatio={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    getTitleTTFForState={
      description = "",
      type = "method",
      args="(State: state)",
      returns = "string",
      valuetype = "string"
    },
    getBackgroundSprite={
      description = "",
      type = "method",
      args="()",
      returns = "Scale9Sprite*",
      valuetype = "Scale9Sprite"
    },
    getTitleColorForState={
      description = "",
      type = "method",
      args="(State: state)",
      returns = "Color3B",
      valuetype = "Color3B"
    },
    setTitleColorForState={
      description = "",
      type = "method",
      args="(Color3B: color,State: state)",
      returns = "void",
      valuetype = "void"
    },
    doesAdjustBackgroundImage={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setBackgroundSpriteFrameForState={
      description = "",
      type = "method",
      args="(SpriteFrame*: spriteFrame,State: state)",
      returns = "void",
      valuetype = "void"
    },
    setBackgroundSpriteForState={
      description = "",
      type = "method",
      args="(Scale9Sprite*: sprite,State: state)",
      returns = "void",
      valuetype = "void"
    },
    setScaleRatio={
      description = "",
      type = "method",
      args="(float: var)",
      returns = "void",
      valuetype = "void"
    },
    setBackgroundSprite={
      description = "",
      type = "method",
      args="(Scale9Sprite*: var)",
      returns = "void",
      valuetype = "void"
    },
    getTitleLabel={
      description = "",
      type = "method",
      args="()",
      returns = "Node*",
      valuetype = "Node"
    },
    getPreferredSize={
      description = "",
      type = "method",
      args="()",
      returns = "Size",
      valuetype = "Size"
    },
    getVerticalMargin={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getTitleLabelForState={
      description = "",
      type = "method",
      args="(State: state)",
      returns = "Node*",
      valuetype = "Node"
    },
    setMargins={
      description = "",
      type = "method",
      args="(int: marginH,int: marginV)",
      returns = "void",
      valuetype = "void"
    },
    setTitleBMFontForState={
      description = "",
      type = "method",
      args="(string: fntFile,State: state)",
      returns = "void",
      valuetype = "void"
    },
    getTitleBMFontForState={
      description = "",
      type = "method",
      args="(State: state)",
      returns = "string",
      valuetype = "string"
    },
    getZoomOnTouchDown={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getTitleForState={
      description = "",
      type = "method",
      args="(State: state)",
      returns = "string",
      valuetype = "string"
    },
  },
},

ControlHuePicker = {
  description = "",
  type = "class",
  inherits = "Control ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ControlHuePicker",
      valuetype = "ControlHuePicker",
    },
    setEnabled={
      description = "",
      type = "method",
      args="(bool: enabled)",
      returns = "void",
      valuetype = "void"
    },
    initWithTargetAndPos={
      description = "",
      type = "method",
      args="(Node*: target,Vec2: pos)",
      returns = "bool",
      valuetype = "bool"
    },
    setHue={
      description = "",
      type = "method",
      args="(float: val)",
      returns = "void",
      valuetype = "void"
    },
    getStartPos={
      description = "",
      type = "method",
      args="()",
      returns = "Vec2",
      valuetype = "Vec2"
    },
    getHue={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    getSlider={
      description = "",
      type = "method",
      args="()",
      returns = "Sprite*",
      valuetype = "Sprite"
    },
    setBackground={
      description = "",
      type = "method",
      args="(Sprite*: var)",
      returns = "void",
      valuetype = "void"
    },
    setHuePercentage={
      description = "",
      type = "method",
      args="(float: val)",
      returns = "void",
      valuetype = "void"
    },
    getBackground={
      description = "",
      type = "method",
      args="()",
      returns = "Sprite*",
      valuetype = "Sprite"
    },
    getHuePercentage={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    setSlider={
      description = "",
      type = "method",
      args="(Sprite*: var)",
      returns = "void",
      valuetype = "void"
    },
    create={
	  description = "",
      type = "method",
      args="(Node*: target,Vec2: pos)",
      returns = "ControlHuePicker*",
      valuetype = "ControlHuePicker"
    },
  },
},

ControlSaturationBrightnessPicker = {
  description = "",
  type = "class",
  inherits = "Control ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ControlSaturationBrightnessPicker",
      valuetype = "ControlSaturationBrightnessPicker",
    },
    getShadow={
      description = "",
      type = "method",
      args="()",
      returns = "Sprite*",
      valuetype = "Sprite"
    },
    initWithTargetAndPos={
      description = "",
      type = "method",
      args="(Node*: target,Vec2: pos)",
      returns = "bool",
      valuetype = "bool"
    },
    getStartPos={
      description = "",
      type = "method",
      args="()",
      returns = "Vec2",
      valuetype = "Vec2"
    },
    getOverlay={
      description = "",
      type = "method",
      args="()",
      returns = "Sprite*",
      valuetype = "Sprite"
    },
    setEnabled={
      description = "",
      type = "method",
      args="(bool: enabled)",
      returns = "void",
      valuetype = "void"
    },
    getSlider={
      description = "",
      type = "method",
      args="()",
      returns = "Sprite*",
      valuetype = "Sprite"
    },
    getBackground={
      description = "",
      type = "method",
      args="()",
      returns = "Sprite*",
      valuetype = "Sprite"
    },
    getSaturation={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    getBrightness={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    create={
	  description = "",
      type = "method",
      args="(Node*: target,Vec2: pos)",
      returns = "ControlSaturationBrightnessPicker*",
      valuetype = "ControlSaturationBrightnessPicker"
    },
  },
},

ControlColourPicker = {
  description = "",
  type = "class",
  inherits = "Control ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ControlColourPicker",
      valuetype = "ControlColourPicker",
    },
    setEnabled={
      description = "",
      type = "method",
      args="(bool: bEnabled)",
      returns = "void",
      valuetype = "void"
    },
    getHuePicker={
      description = "",
      type = "method",
      args="()",
      returns = "ControlHuePicker*",
      valuetype = "ControlHuePicker"
    },
    setColor={
      description = "",
      type = "method",
      args="(Color3B: colorValue)",
      returns = "void",
      valuetype = "void"
    },
    hueSliderValueChanged={
      description = "",
      type = "method",
      args="(Ref*: sender,EventType: controlEvent)",
      returns = "void",
      valuetype = "void"
    },
    getcolourPicker={
      description = "",
      type = "method",
      args="()",
      returns = "ControlSaturationBrightnessPicker*",
      valuetype = "ControlSaturationBrightnessPicker"
    },
    setBackground={
      description = "",
      type = "method",
      args="(Sprite*: var)",
      returns = "void",
      valuetype = "void"
    },
    setcolourPicker={
      description = "",
      type = "method",
      args="(ControlSaturationBrightnessPicker*: var)",
      returns = "void",
      valuetype = "void"
    },
    colourSliderValueChanged={
      description = "",
      type = "method",
      args="(Ref*: sender,EventType: controlEvent)",
      returns = "void",
      valuetype = "void"
    },
    setHuePicker={
      description = "",
      type = "method",
      args="(ControlHuePicker*: var)",
      returns = "void",
      valuetype = "void"
    },
    getBackground={
      description = "",
      type = "method",
      args="()",
      returns = "Sprite*",
      valuetype = "Sprite"
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "ControlColourPicker*",
      valuetype = "ControlColourPicker"
    },
  },
},

ControlPotentiometer = {
  description = "",
  type = "class",
  inherits = "Control ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ControlPotentiometer",
      valuetype = "ControlPotentiometer",
    },
    setPreviousLocation={
      description = "",
      type = "method",
      args="(Vec2: var)",
      returns = "void",
      valuetype = "void"
    },
    setValue={
      description = "",
      type = "method",
      args="(float: value)",
      returns = "void",
      valuetype = "void"
    },
    getProgressTimer={
      description = "",
      type = "method",
      args="()",
      returns = "ProgressTimer*",
      valuetype = "ProgressTimer"
    },
    getMaximumValue={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    angleInDegreesBetweenLineFromPoint_toPoint_toLineFromPoint_toPoint={
      description = "",
      type = "method",
      args="(Vec2: beginLineA,Vec2: endLineA,Vec2: beginLineB,Vec2: endLineB)",
      returns = "float",
      valuetype = "float"
    },
    potentiometerBegan={
      description = "",
      type = "method",
      args="(Vec2: location)",
      returns = "void",
      valuetype = "void"
    },
    setMaximumValue={
      description = "",
      type = "method",
      args="(float: maximumValue)",
      returns = "void",
      valuetype = "void"
    },
    getMinimumValue={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    setThumbSprite={
      description = "",
      type = "method",
      args="(Sprite*: var)",
      returns = "void",
      valuetype = "void"
    },
    getValue={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    distanceBetweenPointAndPoint={
      description = "",
      type = "method",
      args="(Vec2: point1,Vec2: point2)",
      returns = "float",
      valuetype = "float"
    },
    potentiometerEnded={
      description = "",
      type = "method",
      args="(Vec2: location)",
      returns = "void",
      valuetype = "void"
    },
    getPreviousLocation={
      description = "",
      type = "method",
      args="()",
      returns = "Vec2",
      valuetype = "Vec2"
    },
    setProgressTimer={
      description = "",
      type = "method",
      args="(ProgressTimer*: var)",
      returns = "void",
      valuetype = "void"
    },
    setMinimumValue={
      description = "",
      type = "method",
      args="(float: minimumValue)",
      returns = "void",
      valuetype = "void"
    },
    getThumbSprite={
      description = "",
      type = "method",
      args="()",
      returns = "Sprite*",
      valuetype = "Sprite"
    },
    initWithTrackSprite_ProgressTimer_ThumbSprite={
      description = "",
      type = "method",
      args="(Sprite*: trackSprite,ProgressTimer*: progressTimer,Sprite*: thumbSprite)",
      returns = "bool",
      valuetype = "bool"
    },
    potentiometerMoved={
      description = "",
      type = "method",
      args="(Vec2: location)",
      returns = "void",
      valuetype = "void"
    },
    create={
	  description = "",
      type = "method",
      args="(char*: backgroundFile,char*: progressFile,char*: thumbFile)",
      returns = "ControlPotentiometer*",
      valuetype = "ControlPotentiometer"
    },
  },
},

ControlSlider = {
  description = "",
  type = "class",
  inherits = "Control ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ControlSlider",
      valuetype = "ControlSlider",
    },
    getSelectedThumbSprite={
      description = "",
      type = "method",
      args="()",
      returns = "Sprite*",
      valuetype = "Sprite"
    },
    locationFromTouch={
      description = "",
      type = "method",
      args="(Touch*: touch)",
      returns = "Vec2",
      valuetype = "Vec2"
    },
    setSelectedThumbSprite={
      description = "",
      type = "method",
      args="(Sprite*: var)",
      returns = "void",
      valuetype = "void"
    },
    setProgressSprite={
      description = "",
      type = "method",
      args="(Sprite*: var)",
      returns = "void",
      valuetype = "void"
    },
    getMaximumAllowedValue={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    getMinimumAllowedValue={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    getMinimumValue={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    setThumbSprite={
      description = "",
      type = "method",
      args="(Sprite*: var)",
      returns = "void",
      valuetype = "void"
    },
    setMinimumValue={
      description = "",
      type = "method",
      args="(float: val)",
      returns = "void",
      valuetype = "void"
    },
    setMinimumAllowedValue={
      description = "",
      type = "method",
      args="(float: var)",
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
    setValue={
      description = "",
      type = "method",
      args="(float: val)",
      returns = "void",
      valuetype = "void"
    },
    setMaximumValue={
      description = "",
      type = "method",
      args="(float: val)",
      returns = "void",
      valuetype = "void"
    },
    needsLayout={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getBackgroundSprite={
      description = "",
      type = "method",
      args="()",
      returns = "Sprite*",
      valuetype = "Sprite"
    },
    getMaximumValue={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    isTouchInside={
      description = "",
      type = "method",
      args="(Touch*: touch)",
      returns = "bool",
      valuetype = "bool"
    },
    getValue={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    getThumbSprite={
      description = "",
      type = "method",
      args="()",
      returns = "Sprite*",
      valuetype = "Sprite"
    },
    getProgressSprite={
      description = "",
      type = "method",
      args="()",
      returns = "Sprite*",
      valuetype = "Sprite"
    },
    setBackgroundSprite={
      description = "",
      type = "method",
      args="(Sprite*: var)",
      returns = "void",
      valuetype = "void"
    },
    setMaximumAllowedValue={
      description = "",
      type = "method",
      args="(float: var)",
      returns = "void",
      valuetype = "void"
    },
  },
},

ControlStepper = {
  description = "",
  type = "class",
  inherits = "Control ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ControlStepper",
      valuetype = "ControlStepper",
    },
    setMinusSprite={
      description = "",
      type = "method",
      args="(Sprite*: var)",
      returns = "void",
      valuetype = "void"
    },
    getMinusLabel={
      description = "",
      type = "method",
      args="()",
      returns = "Label*",
      valuetype = "Label"
    },
    setWraps={
      description = "",
      type = "method",
      args="(bool: wraps)",
      returns = "void",
      valuetype = "void"
    },
    isContinuous={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getMinusSprite={
      description = "",
      type = "method",
      args="()",
      returns = "Sprite*",
      valuetype = "Sprite"
    },
    updateLayoutUsingTouchLocation={
      description = "",
      type = "method",
      args="(Vec2: location)",
      returns = "void",
      valuetype = "void"
    },
    setValueWithSendingEvent={
      description = "",
      type = "method",
      args="(double: value,bool: send)",
      returns = "void",
      valuetype = "void"
    },
    getPlusLabel={
      description = "",
      type = "method",
      args="()",
      returns = "Label*",
      valuetype = "Label"
    },
    stopAutorepeat={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    setMinimumValue={
      description = "",
      type = "method",
      args="(double: minimumValue)",
      returns = "void",
      valuetype = "void"
    },
    getPlusSprite={
      description = "",
      type = "method",
      args="()",
      returns = "Sprite*",
      valuetype = "Sprite"
    },
    setPlusSprite={
      description = "",
      type = "method",
      args="(Sprite*: var)",
      returns = "void",
      valuetype = "void"
    },
    setMinusLabel={
      description = "",
      type = "method",
      args="(Label*: var)",
      returns = "void",
      valuetype = "void"
    },
    setValue={
      description = "",
      type = "method",
      args="(double: value)",
      returns = "void",
      valuetype = "void"
    },
    setStepValue={
      description = "",
      type = "method",
      args="(double: stepValue)",
      returns = "void",
      valuetype = "void"
    },
    setMaximumValue={
      description = "",
      type = "method",
      args="(double: maximumValue)",
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
    startAutorepeat={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    initWithMinusSpriteAndPlusSprite={
      description = "",
      type = "method",
      args="(Sprite*: minusSprite,Sprite*: plusSprite)",
      returns = "bool",
      valuetype = "bool"
    },
    getValue={
      description = "",
      type = "method",
      args="()",
      returns = "double",
      valuetype = "double"
    },
    setPlusLabel={
      description = "",
      type = "method",
      args="(Label*: var)",
      returns = "void",
      valuetype = "void"
    },
    create={
	  description = "",
      type = "method",
      args="(Sprite*: minusSprite,Sprite*: plusSprite)",
      returns = "ControlStepper*",
      valuetype = "ControlStepper"
    },
  },
},

ControlSwitch = {
  description = "",
  type = "class",
  inherits = "Control ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ControlSwitch",
      valuetype = "ControlSwitch",
    },
    setEnabled={
      description = "",
      type = "method",
      args="(bool: enabled)",
      returns = "void",
      valuetype = "void"
    },
    isOn={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    hasMoved={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    locationFromTouch={
      description = "",
      type = "method",
      args="(Touch*: touch)",
      returns = "Vec2",
      valuetype = "Vec2"
    },
  },
},

ScrollView = {
  description = "",
  type = "class",
  inherits = "Layer ActionTweenDelegate ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ScrollView",
      valuetype = "ScrollView",
    },
    isClippingToBounds={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setContainer={
      description = "",
      type = "method",
      args="(Node*: pContainer)",
      returns = "void",
      valuetype = "void"
    },
    onTouchEnded={
      description = "",
      type = "method",
      args="(Touch*: touch,Event*: event)",
      returns = "void",
      valuetype = "void"
    },
    setContentOffsetInDuration={
      description = "",
      type = "method",
      args="(Vec2: offset,float: dt)",
      returns = "void",
      valuetype = "void"
    },
    setZoomScaleInDuration={
      description = "",
      type = "method",
      args="(float: s,float: dt)",
      returns = "void",
      valuetype = "void"
    },
    updateTweenAction={
      description = "",
      type = "method",
      args="(float: value,string: key)",
      returns = "void",
      valuetype = "void"
    },
    setMaxScale={
      description = "",
      type = "method",
      args="(float: maxScale)",
      returns = "void",
      valuetype = "void"
    },
    hasVisibleParents={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getDirection={
      description = "",
      type = "method",
      args="()",
      returns = "Direction",
      valuetype = "Direction"
    },
    getContainer={
      description = "",
      type = "method",
      args="()",
      returns = "Node*",
      valuetype = "Node"
    },
    setMinScale={
      description = "",
      type = "method",
      args="(float: minScale)",
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
    updateInset={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    initWithViewSize={
      description = "",
      type = "method",
      args="(Size: size,Node*: container)",
      returns = "bool",
      valuetype = "bool"
    },
    pause={
      description = "",
      type = "method",
      args="(Ref*: sender)",
      returns = "void",
      valuetype = "void"
    },
    setDirection={
      description = "",
      type = "method",
      args="(Direction: eDirection)",
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
    setContentOffset={
      description = "",
      type = "method",
      args="(Vec2: offset,bool: animated)",
      returns = "void",
      valuetype = "void"
    },
    isDragging={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isTouchEnabled={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isBounceable={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setTouchEnabled={
      description = "",
      type = "method",
      args="(bool: enabled)",
      returns = "void",
      valuetype = "void"
    },
    onTouchMoved={
      description = "",
      type = "method",
      args="(Touch*: touch,Event*: event)",
      returns = "void",
      valuetype = "void"
    },
    getContentOffset={
      description = "",
      type = "method",
      args="()",
      returns = "Vec2",
      valuetype = "Vec2"
    },
    resume={
      description = "",
      type = "method",
      args="(Ref*: sender)",
      returns = "void",
      valuetype = "void"
    },
    setClippingToBounds={
      description = "",
      type = "method",
      args="(bool: bClippingToBounds)",
      returns = "void",
      valuetype = "void"
    },
    setViewSize={
      description = "",
      type = "method",
      args="(Size: size)",
      returns = "void",
      valuetype = "void"
    },
    onTouchCancelled={
      description = "",
      type = "method",
      args="(Touch*: touch,Event*: event)",
      returns = "void",
      valuetype = "void"
    },
    getViewSize={
      description = "",
      type = "method",
      args="()",
      returns = "Size",
      valuetype = "Size"
    },
    maxContainerOffset={
      description = "",
      type = "method",
      args="()",
      returns = "Vec2",
      valuetype = "Vec2"
    },
    setBounceable={
      description = "",
      type = "method",
      args="(bool: bBounceable)",
      returns = "void",
      valuetype = "void"
    },
    onTouchBegan={
      description = "",
      type = "method",
      args="(Touch*: touch,Event*: event)",
      returns = "bool",
      valuetype = "bool"
    },
    isTouchMoved={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isNodeVisible={
      description = "",
      type = "method",
      args="(Node*: node)",
      returns = "bool",
      valuetype = "bool"
    },
    minContainerOffset={
      description = "",
      type = "method",
      args="()",
      returns = "Vec2",
      valuetype = "Vec2"
    },
  },
},

TableViewCell = {
  description = "",
  type = "class",
  inherits = "Node ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "TableViewCell",
      valuetype = "TableViewCell",
    },
    reset={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getIdx={
      description = "",
      type = "method",
      args="()",
      returns = "long",
      valuetype = "long"
    },
    setIdx={
      description = "",
      type = "method",
      args="(long: uIdx)",
      returns = "void",
      valuetype = "void"
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "TableViewCell*",
      valuetype = "TableViewCell"
    },
  },
},

TableView = {
  description = "",
  type = "class",
  inherits = "ScrollView ScrollViewDelegate ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "TableView",
      valuetype = "TableView",
    },
    updateCellAtIndex={
      description = "",
      type = "method",
      args="(long: idx)",
      returns = "void",
      valuetype = "void"
    },
    setVerticalFillOrder={
      description = "",
      type = "method",
      args="(VerticalFillOrder: order)",
      returns = "void",
      valuetype = "void"
    },
    _updateContentSize={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getVerticalFillOrder={
      description = "",
      type = "method",
      args="()",
      returns = "VerticalFillOrder",
      valuetype = "VerticalFillOrder"
    },
    removeCellAtIndex={
      description = "",
      type = "method",
      args="(long: idx)",
      returns = "void",
      valuetype = "void"
    },
    initWithViewSize={
      description = "",
      type = "method",
      args="(Size: size,Node*: container)",
      returns = "bool",
      valuetype = "bool"
    },
    reloadData={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    insertCellAtIndex={
      description = "",
      type = "method",
      args="(long: idx)",
      returns = "void",
      valuetype = "void"
    },
    cellAtIndex={
      description = "",
      type = "method",
      args="(long: idx)",
      returns = "TableViewCell*",
      valuetype = "TableViewCell"
    },
    dequeueCell={
      description = "",
      type = "method",
      args="()",
      returns = "TableViewCell*",
      valuetype = "TableViewCell"
    },
  },
},

AssetsManager = {
  description = "",
  type = "class",
  inherits = "Node ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "AssetsManager",
      valuetype = "AssetsManager",
    },
    setStoragePath={
      description = "",
      type = "method",
      args="(char*: storagePath)",
      returns = "void",
      valuetype = "void"
    },
    setPackageUrl={
      description = "",
      type = "method",
      args="(char*: packageUrl)",
      returns = "void",
      valuetype = "void"
    },
    checkUpdate={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getStoragePath={
      description = "",
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
    update={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    setConnectionTimeout={
      description = "",
      type = "method",
      args="(unsigned int: timeout)",
      returns = "void",
      valuetype = "void"
    },
    setVersionFileUrl={
      description = "",
      type = "method",
      args="(char*: versionFileUrl)",
      returns = "void",
      valuetype = "void"
    },
    getPackageUrl={
      description = "",
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
    getConnectionTimeout={
      description = "",
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    getVersion={
      description = "",
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    getVersionFileUrl={
      description = "",
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
    deleteVersion={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    create={
	  description = "",
      type = "method",
      args="(char*: packageUrl,char*: versionFileUrl,char*: storagePath,function: errorCallback,function: progressCallback,function: successCallback)",
      returns = "AssetsManager*",
      valuetype = "AssetsManager"
    },
  },
},

EventAssetsManagerEx = {
  description = "",
  type = "class",
  inherits = "EventCustom ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "EventAssetsManagerEx",
      valuetype = "EventAssetsManagerEx",
    },
    getAssetsManagerEx={
      description = "",
      type = "method",
      args="()",
      returns = "AssetsManagerEx*",
      valuetype = "AssetsManagerEx"
    },
    getAssetId={
      description = "",
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    getCURLECode={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getMessage={
      description = "",
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    getCURLMCode={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getPercentByFile={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    getEventCode={
      description = "",
      type = "method",
      args="()",
      returns = "EventCode",
      valuetype = "EventCode"
    },
    getPercent={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
  },
},

Manifest = {
  description = "",
  type = "class",
  inherits = "Ref ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "Manifest",
      valuetype = "Manifest",
    },
    getManifestFileUrl={
      description = "",
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    isVersionLoaded={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isLoaded={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getPackageUrl={
      description = "",
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    getVersion={
      description = "",
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    getVersionFileUrl={
      description = "",
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    getSearchPaths={
      description = "",
      type = "method",
      args="()",
      returns = "vector<basic_string<char>, allocator<basic_string<char> > >",
      valuetype = "vector<basic_string<char>, allocator<basic_string<char> > >"
    },
  },
},

AssetsManagerEx = {
  description = "",
  type = "class",
  inherits = "Ref ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "AssetsManagerEx",
      valuetype = "AssetsManagerEx",
    },
    getState={
      description = "",
      type = "method",
      args="()",
      returns = "State",
      valuetype = "State"
    },
    checkUpdate={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getStoragePath={
      description = "",
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    update={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getLocalManifest={
      description = "",
      type = "method",
      args="()",
      returns = "Manifest*",
      valuetype = "Manifest"
    },
    getRemoteManifest={
      description = "",
      type = "method",
      args="()",
      returns = "Manifest*",
      valuetype = "Manifest"
    },
    downloadFailedAssets={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    create={
	  description = "",
      type = "method",
      args="(string: manifestUrl,string: storagePath)",
      returns = "AssetsManagerEx*",
      valuetype = "AssetsManagerEx"
    },
  },
},

EventListenerAssetsManagerEx = {
  description = "",
  type = "class",
  inherits = "EventListenerCustom ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "EventListenerAssetsManagerEx",
      valuetype = "EventListenerAssetsManagerEx",
    },
  },
},

}
end