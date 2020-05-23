require "api/lua/cpprootdir"
require "api/lua/cppapi"

do return{

PhysicsShape = {
  description = "",
  type = "class",
  inherits = "Ref ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PhysicsShape",
      valuetype = "PhysicsShape",
    },
    getFriction={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    setGroup={
      description = "",
      type = "method",
      args="(int: group)",
      returns = "void",
      valuetype = "void"
    },
    setDensity={
      description = "",
      type = "method",
      args="(float: density)",
      returns = "void",
      valuetype = "void"
    },
    getMass={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    getMaterial={
      description = "",
      type = "method",
      args="()",
      returns = "PhysicsMaterial",
      valuetype = "PhysicsMaterial"
    },
    getCollisionBitmask={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getArea={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    setCategoryBitmask={
      description = "",
      type = "method",
      args="(int: bitmask)",
      returns = "void",
      valuetype = "void"
    },
    getGroup={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    setMoment={
      description = "",
      type = "method",
      args="(float: moment)",
      returns = "void",
      valuetype = "void"
    },
    containsPoint={
      description = "",
      type = "method",
      args="(Vec2: point)",
      returns = "bool",
      valuetype = "bool"
    },
    getCategoryBitmask={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getType={
      description = "",
      type = "method",
      args="()",
      returns = "Type",
      valuetype = "Type"
    },
    getContactTestBitmask={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getCenter={
      description = "",
      type = "method",
      args="()",
      returns = "Vec2",
      valuetype = "Vec2"
    },
    getDensity={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    setMass={
      description = "",
      type = "method",
      args="(float: mass)",
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
    calculateDefaultMoment={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    setCollisionBitmask={
      description = "",
      type = "method",
      args="(int: bitmask)",
      returns = "void",
      valuetype = "void"
    },
    getMoment={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    getOffset={
      description = "",
      type = "method",
      args="()",
      returns = "Vec2",
      valuetype = "Vec2"
    },
    getRestitution={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    setFriction={
      description = "",
      type = "method",
      args="(float: friction)",
      returns = "void",
      valuetype = "void"
    },
    setMaterial={
      description = "",
      type = "method",
      args="(PhysicsMaterial: material)",
      returns = "void",
      valuetype = "void"
    },
    setTag={
      description = "",
      type = "method",
      args="(int: tag)",
      returns = "void",
      valuetype = "void"
    },
    setContactTestBitmask={
      description = "",
      type = "method",
      args="(int: bitmask)",
      returns = "void",
      valuetype = "void"
    },
    setRestitution={
      description = "",
      type = "method",
      args="(float: restitution)",
      returns = "void",
      valuetype = "void"
    },
    getBody={
      description = "",
      type = "method",
      args="()",
      returns = "PhysicsBody*",
      valuetype = "PhysicsBody"
    },
  },
},

PhysicsShapeCircle = {
  description = "",
  type = "class",
  inherits = "PhysicsShape ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PhysicsShapeCircle",
      valuetype = "PhysicsShapeCircle",
    },
    getRadius={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    create={
	  description = "",
      type = "method",
      args="(float: radius,PhysicsMaterial: material,Vec2: offset)",
      returns = "PhysicsShapeCircle*",
      valuetype = "PhysicsShapeCircle"
    },
    calculateArea={
	  description = "",
      type = "method",
      args="(float: radius)",
      returns = "float",
      valuetype = "float"
    },
    calculateMoment={
	  description = "",
      type = "method",
      args="(float: mass,float: radius,Vec2: offset)",
      returns = "float",
      valuetype = "float"
    },
  },
},

PhysicsShapePolygon = {
  description = "",
  type = "class",
  inherits = "PhysicsShape ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PhysicsShapePolygon",
      valuetype = "PhysicsShapePolygon",
    },
    getPointsCount={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getPoint={
      description = "",
      type = "method",
      args="(int: i)",
      returns = "Vec2",
      valuetype = "Vec2"
    },
  },
},

PhysicsShapeBox = {
  description = "",
  type = "class",
  inherits = "PhysicsShapePolygon ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PhysicsShapeBox",
      valuetype = "PhysicsShapeBox",
    },
    getSize={
      description = "",
      type = "method",
      args="()",
      returns = "Size",
      valuetype = "Size"
    },
    create={
	  description = "",
      type = "method",
      args="(Size: size,PhysicsMaterial: material,Vec2: offset)",
      returns = "PhysicsShapeBox*",
      valuetype = "PhysicsShapeBox"
    },
  },
},

PhysicsShapeEdgeSegment = {
  description = "",
  type = "class",
  inherits = "PhysicsShape ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PhysicsShapeEdgeSegment",
      valuetype = "PhysicsShapeEdgeSegment",
    },
    getPointB={
      description = "",
      type = "method",
      args="()",
      returns = "Vec2",
      valuetype = "Vec2"
    },
    getPointA={
      description = "",
      type = "method",
      args="()",
      returns = "Vec2",
      valuetype = "Vec2"
    },
    create={
	  description = "",
      type = "method",
      args="(Vec2: a,Vec2: b,PhysicsMaterial: material,float: border)",
      returns = "PhysicsShapeEdgeSegment*",
      valuetype = "PhysicsShapeEdgeSegment"
    },
  },
},

PhysicsShapeEdgePolygon = {
  description = "",
  type = "class",
  inherits = "PhysicsShape ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PhysicsShapeEdgePolygon",
      valuetype = "PhysicsShapeEdgePolygon",
    },
    getPointsCount={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
  },
},

PhysicsShapeEdgeBox = {
  description = "",
  type = "class",
  inherits = "PhysicsShapeEdgePolygon ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PhysicsShapeEdgeBox",
      valuetype = "PhysicsShapeEdgeBox",
    },
    create={
	  description = "",
      type = "method",
      args="(Size: size,PhysicsMaterial: material,float: border,Vec2: offset)",
      returns = "PhysicsShapeEdgeBox*",
      valuetype = "PhysicsShapeEdgeBox"
    },
  },
},

PhysicsShapeEdgeChain = {
  description = "",
  type = "class",
  inherits = "PhysicsShape ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PhysicsShapeEdgeChain",
      valuetype = "PhysicsShapeEdgeChain",
    },
    getPointsCount={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
  },
},

PhysicsBody = {
  description = "",
  type = "class",
  inherits = "Ref ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PhysicsBody",
      valuetype = "PhysicsBody",
    },
    isGravityEnabled={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    resetForces={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getVelocityLimit={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    setGroup={
      description = "",
      type = "method",
      args="(int: group)",
      returns = "void",
      valuetype = "void"
    },
    getMass={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    getCollisionBitmask={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getRotationOffset={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    getRotation={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    getMoment={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    setRotationOffset={
      description = "",
      type = "method",
      args="(float: rotation)",
      returns = "void",
      valuetype = "void"
    },
    addShape={
      description = "",
      type = "method",
      args="(PhysicsShape*: shape,bool: addMassAndMoment)",
      returns = "PhysicsShape*",
      valuetype = "PhysicsShape"
    },
    applyTorque={
      description = "",
      type = "method",
      args="(float: torque)",
      returns = "void",
      valuetype = "void"
    },
    getAngularVelocityLimit={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    setAngularVelocityLimit={
      description = "",
      type = "method",
      args="(float: limit)",
      returns = "void",
      valuetype = "void"
    },
    getVelocity={
      description = "",
      type = "method",
      args="()",
      returns = "Vec2",
      valuetype = "Vec2"
    },
    getLinearDamping={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    removeAllShapes={
      description = "",
      type = "method",
      args="(bool: reduceMassAndMoment)",
      returns = "void",
      valuetype = "void"
    },
    setAngularDamping={
      description = "",
      type = "method",
      args="(float: damping)",
      returns = "void",
      valuetype = "void"
    },
    setVelocityLimit={
      description = "",
      type = "method",
      args="(float: limit)",
      returns = "void",
      valuetype = "void"
    },
    setResting={
      description = "",
      type = "method",
      args="(bool: rest)",
      returns = "void",
      valuetype = "void"
    },
    getPositionOffset={
      description = "",
      type = "method",
      args="()",
      returns = "Vec2",
      valuetype = "Vec2"
    },
    setCategoryBitmask={
      description = "",
      type = "method",
      args="(int: bitmask)",
      returns = "void",
      valuetype = "void"
    },
    getWorld={
      description = "",
      type = "method",
      args="()",
      returns = "PhysicsWorld*",
      valuetype = "PhysicsWorld"
    },
    getAngularVelocity={
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
    setGravityEnable={
      description = "",
      type = "method",
      args="(bool: enable)",
      returns = "void",
      valuetype = "void"
    },
    getGroup={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    setMoment={
      description = "",
      type = "method",
      args="(float: moment)",
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
    local2World={
      description = "",
      type = "method",
      args="(Vec2: point)",
      returns = "Vec2",
      valuetype = "Vec2"
    },
    getCategoryBitmask={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    setDynamic={
      description = "",
      type = "method",
      args="(bool: dynamic)",
      returns = "void",
      valuetype = "void"
    },
    getFirstShape={
      description = "",
      type = "method",
      args="()",
      returns = "PhysicsShape*",
      valuetype = "PhysicsShape"
    },
    getShapes={
      description = "",
      type = "method",
      args="()",
      returns = "Vector<cocos2d::PhysicsShape *>",
      valuetype = "Vector<cocos2d::PhysicsShape >"
    },
    getContactTestBitmask={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    setAngularVelocity={
      description = "",
      type = "method",
      args="(float: velocity)",
      returns = "void",
      valuetype = "void"
    },
    setEnable={
      description = "",
      type = "method",
      args="(bool: enable)",
      returns = "void",
      valuetype = "void"
    },
    world2Local={
      description = "",
      type = "method",
      args="(Vec2: point)",
      returns = "Vec2",
      valuetype = "Vec2"
    },
    isEnabled={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setMass={
      description = "",
      type = "method",
      args="(float: mass)",
      returns = "void",
      valuetype = "void"
    },
    addMoment={
      description = "",
      type = "method",
      args="(float: moment)",
      returns = "void",
      valuetype = "void"
    },
    setVelocity={
      description = "",
      type = "method",
      args="(Vec2: velocity)",
      returns = "void",
      valuetype = "void"
    },
    setLinearDamping={
      description = "",
      type = "method",
      args="(float: damping)",
      returns = "void",
      valuetype = "void"
    },
    setCollisionBitmask={
      description = "",
      type = "method",
      args="(int: bitmask)",
      returns = "void",
      valuetype = "void"
    },
    setPositionOffset={
      description = "",
      type = "method",
      args="(Vec2: position)",
      returns = "void",
      valuetype = "void"
    },
    setRotationEnable={
      description = "",
      type = "method",
      args="(bool: enable)",
      returns = "void",
      valuetype = "void"
    },
    isRotationEnabled={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getCPBody={
      description = "",
      type = "method",
      args="()",
      returns = "cpBody*",
      valuetype = "cpBody"
    },
    getAngularDamping={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    getVelocityAtLocalPoint={
      description = "",
      type = "method",
      args="(Vec2: point)",
      returns = "Vec2",
      valuetype = "Vec2"
    },
    isResting={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    addMass={
      description = "",
      type = "method",
      args="(float: mass)",
      returns = "void",
      valuetype = "void"
    },
    getShape={
      description = "",
      type = "method",
      args="(int: tag)",
      returns = "PhysicsShape*",
      valuetype = "PhysicsShape"
    },
    setTag={
      description = "",
      type = "method",
      args="(int: tag)",
      returns = "void",
      valuetype = "void"
    },
    getVelocityAtWorldPoint={
      description = "",
      type = "method",
      args="(Vec2: point)",
      returns = "Vec2",
      valuetype = "Vec2"
    },
    setContactTestBitmask={
      description = "",
      type = "method",
      args="(int: bitmask)",
      returns = "void",
      valuetype = "void"
    },
    removeFromWorld={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    isDynamic={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getNode={
      description = "",
      type = "method",
      args="()",
      returns = "Node*",
      valuetype = "Node"
    },
    createBox={
	  description = "",
      type = "method",
      args="(Size: size,PhysicsMaterial: material,Vec2: offset)",
      returns = "PhysicsBody*",
      valuetype = "PhysicsBody"
    },
    createEdgeSegment={
	  description = "",
      type = "method",
      args="(Vec2: a,Vec2: b,PhysicsMaterial: material,float: border)",
      returns = "PhysicsBody*",
      valuetype = "PhysicsBody"
    },
    createEdgeBox={
	  description = "",
      type = "method",
      args="(Size: size,PhysicsMaterial: material,float: border,Vec2: offset)",
      returns = "PhysicsBody*",
      valuetype = "PhysicsBody"
    },
    createCircle={
	  description = "",
      type = "method",
      args="(float: radius,PhysicsMaterial: material,Vec2: offset)",
      returns = "PhysicsBody*",
      valuetype = "PhysicsBody"
    },
  },
},

PhysicsContact = {
  description = "",
  type = "class",
  inherits = "EventCustom ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PhysicsContact",
      valuetype = "PhysicsContact",
    },
    getContactData={
      description = "",
      type = "method",
      args="()",
      returns = "PhysicsContactData*",
      valuetype = "PhysicsContactData"
    },
    getEventCode={
      description = "",
      type = "method",
      args="()",
      returns = "EventCode",
      valuetype = "EventCode"
    },
    getPreContactData={
      description = "",
      type = "method",
      args="()",
      returns = "PhysicsContactData*",
      valuetype = "PhysicsContactData"
    },
    getShapeA={
      description = "",
      type = "method",
      args="()",
      returns = "PhysicsShape*",
      valuetype = "PhysicsShape"
    },
    getShapeB={
      description = "",
      type = "method",
      args="()",
      returns = "PhysicsShape*",
      valuetype = "PhysicsShape"
    },
  },
},

PhysicsContactPreSolve = {
  description = "",
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PhysicsContactPreSolve",
      valuetype = "PhysicsContactPreSolve",
    },
    getFriction={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    getRestitution={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    setFriction={
      description = "",
      type = "method",
      args="(float: friction)",
      returns = "void",
      valuetype = "void"
    },
    ignore={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getSurfaceVelocity={
      description = "",
      type = "method",
      args="()",
      returns = "Vec2",
      valuetype = "Vec2"
    },
    setSurfaceVelocity={
      description = "",
      type = "method",
      args="(Vec2: velocity)",
      returns = "void",
      valuetype = "void"
    },
    setRestitution={
      description = "",
      type = "method",
      args="(float: restitution)",
      returns = "void",
      valuetype = "void"
    },
  },
},

PhysicsContactPostSolve = {
  description = "",
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PhysicsContactPostSolve",
      valuetype = "PhysicsContactPostSolve",
    },
    getFriction={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    getSurfaceVelocity={
      description = "",
      type = "method",
      args="()",
      returns = "Vec2",
      valuetype = "Vec2"
    },
    getRestitution={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
  },
},

EventListenerPhysicsContact = {
  description = "",
  type = "class",
  inherits = "EventListenerCustom ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "EventListenerPhysicsContact",
      valuetype = "EventListenerPhysicsContact",
    },
    create={
	  description = "",
      type = "method",
      args="()",
      returns = "EventListenerPhysicsContact*",
      valuetype = "EventListenerPhysicsContact"
    },
  },
},

EventListenerPhysicsContactWithBodies = {
  description = "",
  type = "class",
  inherits = "EventListenerPhysicsContact ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "EventListenerPhysicsContactWithBodies",
      valuetype = "EventListenerPhysicsContactWithBodies",
    },
    create={
	  description = "",
      type = "method",
      args="(PhysicsBody*: bodyA,PhysicsBody*: bodyB)",
      returns = "EventListenerPhysicsContactWithBodies*",
      valuetype = "EventListenerPhysicsContactWithBodies"
    },
  },
},

EventListenerPhysicsContactWithShapes = {
  description = "",
  type = "class",
  inherits = "EventListenerPhysicsContact ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "EventListenerPhysicsContactWithShapes",
      valuetype = "EventListenerPhysicsContactWithShapes",
    },
    create={
	  description = "",
      type = "method",
      args="(PhysicsShape*: shapeA,PhysicsShape*: shapeB)",
      returns = "EventListenerPhysicsContactWithShapes*",
      valuetype = "EventListenerPhysicsContactWithShapes"
    },
  },
},

EventListenerPhysicsContactWithGroup = {
  description = "",
  type = "class",
  inherits = "EventListenerPhysicsContact ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "EventListenerPhysicsContactWithGroup",
      valuetype = "EventListenerPhysicsContactWithGroup",
    },
    create={
	  description = "",
      type = "method",
      args="(int: group)",
      returns = "EventListenerPhysicsContactWithGroup*",
      valuetype = "EventListenerPhysicsContactWithGroup"
    },
  },
},

PhysicsJoint = {
  description = "",
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PhysicsJoint",
      valuetype = "PhysicsJoint",
    },
    getBodyA={
      description = "",
      type = "method",
      args="()",
      returns = "PhysicsBody*",
      valuetype = "PhysicsBody"
    },
    getBodyB={
      description = "",
      type = "method",
      args="()",
      returns = "PhysicsBody*",
      valuetype = "PhysicsBody"
    },
    getMaxForce={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    setMaxForce={
      description = "",
      type = "method",
      args="(float: force)",
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
    setEnable={
      description = "",
      type = "method",
      args="(bool: enable)",
      returns = "void",
      valuetype = "void"
    },
    setCollisionEnable={
      description = "",
      type = "method",
      args="(bool: enable)",
      returns = "void",
      valuetype = "void"
    },
    getWorld={
      description = "",
      type = "method",
      args="()",
      returns = "PhysicsWorld*",
      valuetype = "PhysicsWorld"
    },
    setTag={
      description = "",
      type = "method",
      args="(int: tag)",
      returns = "void",
      valuetype = "void"
    },
    removeFormWorld={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    isCollisionEnabled={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getTag={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
  },
},

PhysicsJointFixed = {
  description = "",
  type = "class",
  inherits = "PhysicsJoint ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PhysicsJointFixed",
      valuetype = "PhysicsJointFixed",
    },
    construct={
	  description = "",
      type = "method",
      args="(PhysicsBody*: a,PhysicsBody*: b,Vec2: anchr)",
      returns = "PhysicsJointFixed*",
      valuetype = "PhysicsJointFixed"
    },
  },
},

PhysicsJointLimit = {
  description = "",
  type = "class",
  inherits = "PhysicsJoint ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PhysicsJointLimit",
      valuetype = "PhysicsJointLimit",
    },
    setAnchr2={
      description = "",
      type = "method",
      args="(Vec2: anchr2)",
      returns = "void",
      valuetype = "void"
    },
    setAnchr1={
      description = "",
      type = "method",
      args="(Vec2: anchr1)",
      returns = "void",
      valuetype = "void"
    },
    setMax={
      description = "",
      type = "method",
      args="(float: max)",
      returns = "void",
      valuetype = "void"
    },
    getAnchr2={
      description = "",
      type = "method",
      args="()",
      returns = "Vec2",
      valuetype = "Vec2"
    },
    getAnchr1={
      description = "",
      type = "method",
      args="()",
      returns = "Vec2",
      valuetype = "Vec2"
    },
    getMin={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    getMax={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    setMin={
      description = "",
      type = "method",
      args="(float: min)",
      returns = "void",
      valuetype = "void"
    },
  },
},

PhysicsJointPin = {
  description = "",
  type = "class",
  inherits = "PhysicsJoint ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PhysicsJointPin",
      valuetype = "PhysicsJointPin",
    },
  },
},

PhysicsJointDistance = {
  description = "",
  type = "class",
  inherits = "PhysicsJoint ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PhysicsJointDistance",
      valuetype = "PhysicsJointDistance",
    },
    setDistance={
      description = "",
      type = "method",
      args="(float: distance)",
      returns = "void",
      valuetype = "void"
    },
    getDistance={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    construct={
	  description = "",
      type = "method",
      args="(PhysicsBody*: a,PhysicsBody*: b,Vec2: anchr1,Vec2: anchr2)",
      returns = "PhysicsJointDistance*",
      valuetype = "PhysicsJointDistance"
    },
  },
},

PhysicsJointSpring = {
  description = "",
  type = "class",
  inherits = "PhysicsJoint ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PhysicsJointSpring",
      valuetype = "PhysicsJointSpring",
    },
    setAnchr2={
      description = "",
      type = "method",
      args="(Vec2: anchr2)",
      returns = "void",
      valuetype = "void"
    },
    setAnchr1={
      description = "",
      type = "method",
      args="(Vec2: anchr1)",
      returns = "void",
      valuetype = "void"
    },
    getDamping={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    setStiffness={
      description = "",
      type = "method",
      args="(float: stiffness)",
      returns = "void",
      valuetype = "void"
    },
    getRestLength={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    getAnchr2={
      description = "",
      type = "method",
      args="()",
      returns = "Vec2",
      valuetype = "Vec2"
    },
    getAnchr1={
      description = "",
      type = "method",
      args="()",
      returns = "Vec2",
      valuetype = "Vec2"
    },
    getStiffness={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    setRestLength={
      description = "",
      type = "method",
      args="(float: restLength)",
      returns = "void",
      valuetype = "void"
    },
    setDamping={
      description = "",
      type = "method",
      args="(float: damping)",
      returns = "void",
      valuetype = "void"
    },
    construct={
	  description = "",
      type = "method",
      args="(PhysicsBody*: a,PhysicsBody*: b,Vec2: anchr1,Vec2: anchr2,float: stiffness,float: damping)",
      returns = "PhysicsJointSpring*",
      valuetype = "PhysicsJointSpring"
    },
  },
},

PhysicsJointGroove = {
  description = "",
  type = "class",
  inherits = "PhysicsJoint ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PhysicsJointGroove",
      valuetype = "PhysicsJointGroove",
    },
    setAnchr2={
      description = "",
      type = "method",
      args="(Vec2: anchr2)",
      returns = "void",
      valuetype = "void"
    },
    setGrooveA={
      description = "",
      type = "method",
      args="(Vec2: grooveA)",
      returns = "void",
      valuetype = "void"
    },
    setGrooveB={
      description = "",
      type = "method",
      args="(Vec2: grooveB)",
      returns = "void",
      valuetype = "void"
    },
    getGrooveA={
      description = "",
      type = "method",
      args="()",
      returns = "Vec2",
      valuetype = "Vec2"
    },
    getGrooveB={
      description = "",
      type = "method",
      args="()",
      returns = "Vec2",
      valuetype = "Vec2"
    },
    getAnchr2={
      description = "",
      type = "method",
      args="()",
      returns = "Vec2",
      valuetype = "Vec2"
    },
    construct={
	  description = "",
      type = "method",
      args="(PhysicsBody*: a,PhysicsBody*: b,Vec2: grooveA,Vec2: grooveB,Vec2: anchr2)",
      returns = "PhysicsJointGroove*",
      valuetype = "PhysicsJointGroove"
    },
  },
},

PhysicsJointRotarySpring = {
  description = "",
  type = "class",
  inherits = "PhysicsJoint ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PhysicsJointRotarySpring",
      valuetype = "PhysicsJointRotarySpring",
    },
    getDamping={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    setRestAngle={
      description = "",
      type = "method",
      args="(float: restAngle)",
      returns = "void",
      valuetype = "void"
    },
    getStiffness={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    setStiffness={
      description = "",
      type = "method",
      args="(float: stiffness)",
      returns = "void",
      valuetype = "void"
    },
    setDamping={
      description = "",
      type = "method",
      args="(float: damping)",
      returns = "void",
      valuetype = "void"
    },
    getRestAngle={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    construct={
	  description = "",
      type = "method",
      args="(PhysicsBody*: a,PhysicsBody*: b,float: stiffness,float: damping)",
      returns = "PhysicsJointRotarySpring*",
      valuetype = "PhysicsJointRotarySpring"
    },
  },
},

PhysicsJointRotaryLimit = {
  description = "",
  type = "class",
  inherits = "PhysicsJoint ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PhysicsJointRotaryLimit",
      valuetype = "PhysicsJointRotaryLimit",
    },
    getMax={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    setMin={
      description = "",
      type = "method",
      args="(float: min)",
      returns = "void",
      valuetype = "void"
    },
    setMax={
      description = "",
      type = "method",
      args="(float: max)",
      returns = "void",
      valuetype = "void"
    },
    getMin={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
  },
},

PhysicsJointRatchet = {
  description = "",
  type = "class",
  inherits = "PhysicsJoint ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PhysicsJointRatchet",
      valuetype = "PhysicsJointRatchet",
    },
    getAngle={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    setAngle={
      description = "",
      type = "method",
      args="(float: angle)",
      returns = "void",
      valuetype = "void"
    },
    setPhase={
      description = "",
      type = "method",
      args="(float: phase)",
      returns = "void",
      valuetype = "void"
    },
    getPhase={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    setRatchet={
      description = "",
      type = "method",
      args="(float: ratchet)",
      returns = "void",
      valuetype = "void"
    },
    getRatchet={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    construct={
	  description = "",
      type = "method",
      args="(PhysicsBody*: a,PhysicsBody*: b,float: phase,float: ratchet)",
      returns = "PhysicsJointRatchet*",
      valuetype = "PhysicsJointRatchet"
    },
  },
},

PhysicsJointGear = {
  description = "",
  type = "class",
  inherits = "PhysicsJoint ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PhysicsJointGear",
      valuetype = "PhysicsJointGear",
    },
    setRatio={
      description = "",
      type = "method",
      args="(float: ratchet)",
      returns = "void",
      valuetype = "void"
    },
    getPhase={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    setPhase={
      description = "",
      type = "method",
      args="(float: phase)",
      returns = "void",
      valuetype = "void"
    },
    getRatio={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    construct={
	  description = "",
      type = "method",
      args="(PhysicsBody*: a,PhysicsBody*: b,float: phase,float: ratio)",
      returns = "PhysicsJointGear*",
      valuetype = "PhysicsJointGear"
    },
  },
},

PhysicsJointMotor = {
  description = "",
  type = "class",
  inherits = "PhysicsJoint ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PhysicsJointMotor",
      valuetype = "PhysicsJointMotor",
    },
    setRate={
      description = "",
      type = "method",
      args="(float: rate)",
      returns = "void",
      valuetype = "void"
    },
    getRate={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    construct={
	  description = "",
      type = "method",
      args="(PhysicsBody*: a,PhysicsBody*: b,float: rate)",
      returns = "PhysicsJointMotor*",
      valuetype = "PhysicsJointMotor"
    },
  },
},

PhysicsWorld = {
  description = "",
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PhysicsWorld",
      valuetype = "PhysicsWorld",
    },
    setGravity={
      description = "",
      type = "method",
      args="(Vec2: gravity)",
      returns = "void",
      valuetype = "void"
    },
    getAllBodies={
      description = "",
      type = "method",
      args="()",
      returns = "Vector<cocos2d::PhysicsBody *>",
      valuetype = "Vector<cocos2d::PhysicsBody >"
    },
    getDebugDrawMask={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    setSubsteps={
      description = "",
      type = "method",
      args="(int: steps)",
      returns = "void",
      valuetype = "void"
    },
    setAutoStep={
      description = "",
      type = "method",
      args="(bool: autoStep)",
      returns = "void",
      valuetype = "void"
    },
    addJoint={
      description = "",
      type = "method",
      args="(PhysicsJoint*: joint)",
      returns = "void",
      valuetype = "void"
    },
    removeAllJoints={
      description = "",
      type = "method",
      args="(bool: destroy)",
      returns = "void",
      valuetype = "void"
    },
    isAutoStep={
      description = "",
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    removeJoint={
      description = "",
      type = "method",
      args="(PhysicsJoint*: joint,bool: destroy)",
      returns = "void",
      valuetype = "void"
    },
    getShapes={
      description = "",
      type = "method",
      args="(Vec2: point)",
      returns = "Vector<cocos2d::PhysicsShape *>",
      valuetype = "Vector<cocos2d::PhysicsShape >"
    },
    step={
      description = "",
      type = "method",
      args="(float: delta)",
      returns = "void",
      valuetype = "void"
    },
    setDebugDrawMask={
      description = "",
      type = "method",
      args="(int: mask)",
      returns = "void",
      valuetype = "void"
    },
    getGravity={
      description = "",
      type = "method",
      args="()",
      returns = "Vec2",
      valuetype = "Vec2"
    },
    setUpdateRate={
      description = "",
      type = "method",
      args="(int: rate)",
      returns = "void",
      valuetype = "void"
    },
    getSubsteps={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getSpeed={
      description = "",
      type = "method",
      args="()",
      returns = "float",
      valuetype = "float"
    },
    getUpdateRate={
      description = "",
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    removeAllBodies={
      description = "",
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    setSpeed={
      description = "",
      type = "method",
      args="(float: speed)",
      returns = "void",
      valuetype = "void"
    },
    getShape={
      description = "",
      type = "method",
      args="(Vec2: point)",
      returns = "PhysicsShape*",
      valuetype = "PhysicsShape"
    },
    getBody={
      description = "",
      type = "method",
      args="(int: tag)",
      returns = "PhysicsBody*",
      valuetype = "PhysicsBody"
    },
  },
},

PhysicsDebugDraw = {
  description = "",
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PhysicsDebugDraw",
      valuetype = "PhysicsDebugDraw",
    },
  },
},

}
end