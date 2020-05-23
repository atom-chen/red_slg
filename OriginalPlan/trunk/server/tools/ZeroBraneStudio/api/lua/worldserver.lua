require "api/lua/cpprootdir"
require "api/lua/cppapi"

do return{

CBasePacket = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CBasePacket",
      valuetype = "CBasePacket",
    },
    getFlag={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    isCompress={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setPacketID={
      type = "method",
      args="(unsigned short: val)",
      returns = "void",
      valuetype = "void"
    },
    setUnCompressed={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    data={
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
    setTotalLen={
      type = "method",
      args="(unsigned short: val)",
      returns = "void",
      valuetype = "void"
    },
    setFlag={
      type = "method",
      args="(unsigned char: val)",
      returns = "void",
      valuetype = "void"
    },
    setCompressed={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    isCrypt={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    unPackHeader={
      type = "method",
      args="(CMemInputStream*: f)",
      returns = "void",
      valuetype = "void"
    },
    getTotalLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    check={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    packHeader={
      type = "method",
      args="(CMemOutputStream*: f)",
      returns = "void",
      valuetype = "void"
    },
  },
},

CRequestPacket = {
  type = "class",
  inherits = "CBasePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CRequestPacket",
      valuetype = "CRequestPacket",
    },
  },
},

CResponsePacket = {
  type = "class",
  inherits = "CBasePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CResponsePacket",
      valuetype = "CResponsePacket",
    },
    isSuccess={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setRetCode={
      type = "method",
      args="(unsigned short: val)",
      returns = "void",
      valuetype = "void"
    },
    getRetCode={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
  },
},

CServerPacket = {
  type = "class",
  inherits = "CBasePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CServerPacket",
      valuetype = "CServerPacket",
    },
  },
},

PackBuffer = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PackBuffer",
      valuetype = "PackBuffer",
    },
  },
},

PackSimpleBuff = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PackSimpleBuff",
      valuetype = "PackSimpleBuff",
    },
  },
},

PackLoginRole = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PackLoginRole",
      valuetype = "PackLoginRole",
    },
    setParam={
      type = "method",
      args="(char*: name,unsigned long long: uid,unsigned char: sex,unsigned char: job,unsigned char: level,unsigned int: createTime,unsigned int: logoutTime)",
      returns = "void",
      valuetype = "void"
    },
    toString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
  },
},

PackRoleShape = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PackRoleShape",
      valuetype = "PackRoleShape",
    },
  },
},

PackMonsterShape = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PackMonsterShape",
      valuetype = "PackMonsterShape",
    },
  },
},

PacketSourceWay = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PacketSourceWay",
      valuetype = "PacketSourceWay",
    },
  },
},

PacketNewRegister = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PacketNewRegister",
      valuetype = "PacketNewRegister",
    },
  },
},

PacketLoginTime = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PacketLoginTime",
      valuetype = "PacketLoginTime",
    },
  },
},

PacketSingletonInfo = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PacketSingletonInfo",
      valuetype = "PacketSingletonInfo",
    },
  },
},

PacketGameCollectInfo = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PacketGameCollectInfo",
      valuetype = "PacketGameCollectInfo",
    },
  },
},

PacketCreateBrforeInfo = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PacketCreateBrforeInfo",
      valuetype = "PacketCreateBrforeInfo",
    },
  },
},

TAdjust = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "TAdjust",
      valuetype = "TAdjust",
    },
  },
},

AxisPos = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "AxisPos",
      valuetype = "AxisPos",
    },
    toSinglePos={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    isValid={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getDirect={
      type = "method",
      args="(AxisPos*: pos)",
      returns = "int",
      valuetype = "int"
    },
    getX={
      type = "method",
      args="()",
      returns = "short",
      valuetype = "short"
    },
    getY={
      type = "method",
      args="()",
      returns = "short",
      valuetype = "short"
    },
    cleanUp={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    toString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    setX={
      type = "method",
      args="(short: val)",
      returns = "void",
      valuetype = "void"
    },
    setY={
      type = "method",
      args="(short: val)",
      returns = "void",
      valuetype = "void"
    },
  },
},

AreaRect = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "AreaRect",
      valuetype = "AreaRect",
    },
  },
},

MapPos = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MapPos",
      valuetype = "MapPos",
    },
  },
},

CRandGen = {
  type = "class",
  inherits = "CManualSingleton<CRandGen> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CRandGen",
      valuetype = "CRandGen",
    },
    reset={
      type = "method",
      args="(unsigned int: seed)",
      returns = "void",
      valuetype = "void"
    },
    randBool={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    randOdds={
      type = "method",
      args="(unsigned int: baseNum,unsigned int: rateNum)",
      returns = "bool",
      valuetype = "bool"
    },
    randUInt={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    randNumList={
      type = "method",
      args="(vector<int, allocator<int> >*: outList,int: minSize,int: maxSize,int: minNum,int: maxNum,bool: repeat)",
      returns = "bool",
      valuetype = "bool"
    },
    randDouble={
      type = "method",
      args="()",
      returns = "double",
      valuetype = "double"
    },
    GetPtr={
      type = "method",
      args="()",
      returns = "CRandGen*",
      valuetype = "CRandGen"
    },
  },
},

CGameMisc = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CGameMisc",
      valuetype = "CGameMisc",
    },
    GenSceneID={
      type = "method",
      args="(unsigned short: serverID,unsigned char: mapType,unsigned short: mapID,unsigned int: copyID)",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    GenRoleUID={
      type = "method",
      args="(unsigned long long: roleUID,unsigned short: worldID)",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    ToSeconds={
      type = "method",
      args="(char: hour,char: mins,char: seconds)",
      returns = "int",
      valuetype = "int"
    },
    IsInValidRadius={
      type = "method",
      args="(short: x1,short: y1,short: x2,short: y2,unsigned char: range)",
      returns = "bool",
      valuetype = "bool"
    },
    IsSameDay={
      type = "method",
      args="(unsigned int: time1,unsigned int: time2)",
      returns = "bool",
      valuetype = "bool"
    },
    GetDir={
      type = "method",
      args="(AxisPos: pos1,AxisPos: pos2)",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    GetWorldIDByRoleUID={
      type = "method",
      args="(unsigned long long: roleUID)",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    GetOpposeDir={
      type = "method",
      args="(unsigned char: dir)",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    GetMapType={
      type = "method",
      args="(unsigned long long: sceneID)",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    RandDir={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    GetMapServerID={
      type = "method",
      args="(unsigned long long: sceneID)",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    GetMapID={
      type = "method",
      args="(unsigned long long: sceneID)",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    GetDirForAngle={
      type = "method",
      args="(AxisPos: pos1,AxisPos: pos2)",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    IsNormalMap={
      type = "method",
      args="(ESceneType: sceneType)",
      returns = "bool",
      valuetype = "bool"
    },
    ToNumber={
      type = "method",
      args="(string: str)",
      returns = "int",
      valuetype = "int"
    },
    GetRoleUIDSeedByRoleUID={
      type = "method",
      args="(unsigned long long: roleUID)",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    MySqrt={
      type = "method",
      args="(AxisPos: pCur,AxisPos: pTar)",
      returns = "float",
      valuetype = "float"
    },
    GetFourDir={
      type = "method",
      args="(AxisPos: pos1,AxisPos: pos2)",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    MyAngle={
      type = "method",
      args="(AxisPos: pCur,AxisPos: pTar)",
      returns = "double",
      valuetype = "double"
    },
    IsDynamicMap={
      type = "method",
      args="(ESceneType: sceneType)",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

IAttrBase = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "IAttrBase",
      valuetype = "IAttrBase",
    },
    setStrength={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    addMaxHp={
      type = "method",
      args="(int: val)",
      returns = "int",
      valuetype = "int"
    },
    setDamage={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    addPhysicDefense={
      type = "method",
      args="(int: val)",
      returns = "int",
      valuetype = "int"
    },
    addPower={
      type = "method",
      args="(int: val)",
      returns = "int",
      valuetype = "int"
    },
    getDamageReduce={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    addDamageReduce={
      type = "method",
      args="(int: val)",
      returns = "int",
      valuetype = "int"
    },
    getStrength={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    setHp={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    getMoveSpeed={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    addDodge={
      type = "method",
      args="(int: val)",
      returns = "int",
      valuetype = "int"
    },
    addWisdom={
      type = "method",
      args="(int: val)",
      returns = "int",
      valuetype = "int"
    },
    getCrit={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    setWisdom={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    getPhysicDefense={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    addSkillAttack={
      type = "method",
      args="(int: val)",
      returns = "int",
      valuetype = "int"
    },
    setPower={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    setDodge={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    setAgility={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    getPhysicAttck={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getWisdom={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getMp={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    addAgility={
      type = "method",
      args="(int: val)",
      returns = "int",
      valuetype = "int"
    },
    setPhysicDefense={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    addCrit={
      type = "method",
      args="(int: val)",
      returns = "int",
      valuetype = "int"
    },
    getDodge={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    setValue={
      type = "method",
      args="(char: index,int: val)",
      returns = "void",
      valuetype = "void"
    },
    addEnergy={
      type = "method",
      args="(int: val)",
      returns = "int",
      valuetype = "int"
    },
    getMaxHp={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    setMp={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    setMaxEnergy={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    getDamage={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    addStrength={
      type = "method",
      args="(int: val)",
      returns = "int",
      valuetype = "int"
    },
    setSkillAttack={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    setMaxHp={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    setPhysicAttck={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    getPower={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getAgility={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    addHp={
      type = "method",
      args="(int: val)",
      returns = "int",
      valuetype = "int"
    },
    getValue={
      type = "method",
      args="(char: index)",
      returns = "int",
      valuetype = "int"
    },
    getMaxEnergy={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    setDamageReduce={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    addDamage={
      type = "method",
      args="(int: val)",
      returns = "int",
      valuetype = "int"
    },
    addMaxEnergy={
      type = "method",
      args="(int: val)",
      returns = "int",
      valuetype = "int"
    },
    addPhysicAttck={
      type = "method",
      args="(int: val)",
      returns = "int",
      valuetype = "int"
    },
    addMoveSpeed={
      type = "method",
      args="(int: val)",
      returns = "int",
      valuetype = "int"
    },
    setMoveSpeed={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    addValue={
      type = "method",
      args="(char: index,int: val)",
      returns = "int",
      valuetype = "int"
    },
    getHp={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    setCrit={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    getSkillAttack={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
  },
},

AddAttr = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "AddAttr",
      valuetype = "AddAttr",
    },
    setAddType={
      type = "method",
      args="(char: val)",
      returns = "void",
      valuetype = "void"
    },
    isValid={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setAttrValue={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    getAttrValue={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    cleanUp={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    isRate={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getAddType={
      type = "method",
      args="()",
      returns = "char",
      valuetype = "char"
    },
  },
},

Attr = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "Attr",
      valuetype = "Attr",
    },
    setAttrType={
      type = "method",
      args="(char: val)",
      returns = "void",
      valuetype = "void"
    },
    getAttrType={
      type = "method",
      args="()",
      returns = "char",
      valuetype = "char"
    },
    isValid={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setAttrValue={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    getAttrValue={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    cleanUp={
      type = "method",
      args="(EAttributes: attrType,int: values)",
      returns = "void",
      valuetype = "void"
    },
  },
},

ExtendAttr = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ExtendAttr",
      valuetype = "ExtendAttr",
    },
    getValueType={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    setAttrType={
      type = "method",
      args="(char: val)",
      returns = "void",
      valuetype = "void"
    },
    getAttrType={
      type = "method",
      args="()",
      returns = "char",
      valuetype = "char"
    },
    setAttrValue={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    setValueType={
      type = "method",
      args="(unsigned char: val)",
      returns = "void",
      valuetype = "void"
    },
    getAttrValue={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    cleanUp={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    isRate={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

CActionBan = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CActionBan",
      valuetype = "CActionBan",
    },
    cleanUp={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    reset={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    setValue={
      type = "method",
      args="(char: index,bool: flag)",
      returns = "void",
      valuetype = "void"
    },
    getValue={
      type = "method",
      args="(char: index)",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

SkillAttr = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "SkillAttr",
      valuetype = "SkillAttr",
    },
    setValue={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    getRate={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getValue={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    setRate={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    add={
      type = "method",
      args="(SkillAttr*: rhs)",
      returns = "void",
      valuetype = "void"
    },
    cleanUp={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    addRate={
      type = "method",
      args="(int: val)",
      returns = "int",
      valuetype = "int"
    },
    addValue={
      type = "method",
      args="(int: val)",
      returns = "int",
      valuetype = "int"
    },
    isEmpty={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

CSkillAttr = {
  type = "class",
  inherits = "CDetailAttrBase<int, 49> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CSkillAttr",
      valuetype = "CSkillAttr",
    },
    addFixCritHurt={
      type = "method",
      args="(unsigned char: valueType,int: val)",
      returns = "int",
      valuetype = "int"
    },
    getAppendCritRate={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    setFixCritHurt={
      type = "method",
      args="(unsigned char: valueType,int: val)",
      returns = "void",
      valuetype = "void"
    },
    cleanUp={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    isFixCritHurt={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setAppendCritRate={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
  },
},

CBufferAttr = {
  type = "class",
  inherits = "CDetailAttrBase<int, 49> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CBufferAttr",
      valuetype = "CBufferAttr",
    },
    reset={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    toString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    resetBase={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
  },
},

ServerPwdInfo = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ServerPwdInfo",
      valuetype = "ServerPwdInfo",
    },
  },
},

SceneData = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "SceneData",
      valuetype = "SceneData",
    },
  },
},

ChangeLineWait = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ChangeLineWait",
      valuetype = "ChangeLineWait",
    },
  },
},

LoadWaitEnter = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "LoadWaitEnter",
      valuetype = "LoadWaitEnter",
    },
  },
},

RoleSceneRecord = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "RoleSceneRecord",
      valuetype = "RoleSceneRecord",
    },
  },
},

LoadRoleData = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "LoadRoleData",
      valuetype = "LoadRoleData",
    },
  },
},

MapServerUpdate = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MapServerUpdate",
      valuetype = "MapServerUpdate",
    },
  },
},

BuffImpact = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "BuffImpact",
      valuetype = "BuffImpact",
    },
  },
},

AttackorImpact = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "AttackorImpact",
      valuetype = "AttackorImpact",
    },
    isInvalid={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    cleanUp={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    toString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
  },
},

OwnSkill = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "OwnSkill",
      valuetype = "OwnSkill",
    },
  },
},

ExtUseSkill = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ExtUseSkill",
      valuetype = "ExtUseSkill",
    },
  },
},

ItemIDNum = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ItemIDNum",
      valuetype = "ItemIDNum",
    },
  },
},

MapIDRangePos = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MapIDRangePos",
      valuetype = "MapIDRangePos",
    },
  },
},

MapRangePos = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MapRangePos",
      valuetype = "MapRangePos",
    },
  },
},

MapIDPos = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MapIDPos",
      valuetype = "MapIDPos",
    },
  },
},

ZoneServer = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ZoneServer",
      valuetype = "ZoneServer",
    },
  },
},

LoginServerLog = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "LoginServerLog",
      valuetype = "LoginServerLog",
    },
  },
},

OwnerBuffer = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "OwnerBuffer",
      valuetype = "OwnerBuffer",
    },
  },
},

LimitServerIDInfo = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "LimitServerIDInfo",
      valuetype = "LimitServerIDInfo",
    },
    clean={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
  },
},

LimitAccountInfo = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "LimitAccountInfo",
      valuetype = "LimitAccountInfo",
    },
    cleanUp={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
  },
},

LimitChatInfo = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "LimitChatInfo",
      valuetype = "LimitChatInfo",
    },
    cleanUp={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
  },
},

LimitAccount = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "LimitAccount",
      valuetype = "LimitAccount",
    },
    clean={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
  },
},

LimitChat = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "LimitChat",
      valuetype = "LimitChat",
    },
    clean={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
  },
},

LimitAccountDB = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "LimitAccountDB",
      valuetype = "LimitAccountDB",
    },
    clean={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
  },
},

LimitChatDB = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "LimitChatDB",
      valuetype = "LimitChatDB",
    },
    clean={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
  },
},

CWBRegiste = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWBRegiste",
      valuetype = "CWBRegiste",
    },
  },
},

CBWRegisteRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CBWRegisteRet",
      valuetype = "CBWRegisteRet",
    },
  },
},

BWRecharge = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "BWRecharge",
      valuetype = "BWRecharge",
    },
    toString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
  },
},

WBRechargeRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "WBRechargeRet",
      valuetype = "WBRechargeRet",
    },
  },
},

CBillMod = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CBillMod",
      valuetype = "CBillMod",
    },
    RechargeToAccount={
      type = "method",
      args="(CCharArray2<50>: serialNo,unsigned long long: accountID,int: rmb,int: bindRmb,CWorldPlayer*: pPlayer,CWorldUser*: pUser)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    OnChargeRmb={
      type = "method",
      args="(CCharArray2<50>: serialNo,unsigned long long: accountID,unsigned long long: roleUID,int: rmb,int: bindRmb)",
      returns = "void",
      valuetype = "void"
    },
    RechargeToMapServer={
      type = "method",
      args="(BWRecharge*: packet,CWorldPlayer*: pPlayer,CWorldUser*: pUser)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    OnFirstChargeRmb={
      type = "method",
      args="(unsigned long long: accountID,unsigned long long: roleUID,CCharArray2<50>: serialNo,int: rmb)",
      returns = "void",
      valuetype = "void"
    },
  },
},

CScene = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CScene",
      valuetype = "CScene",
    },
    canEnter={
      type = "method",
      args="(unsigned int: logoutTime)",
      returns = "bool",
      valuetype = "bool"
    },
    getOwner={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    isKey={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    keyToString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    getMapServerID={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    getKey={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    isRiskScene={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    init={
      type = "method",
      args="(SceneData*: sceneData)",
      returns = "void",
      valuetype = "void"
    },
    setKey={
      type = "method",
      args="(unsigned long long: key)",
      returns = "void",
      valuetype = "void"
    },
    toString={
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
    changeOwner={
      type = "method",
      args="(unsigned int: objUID)",
      returns = "void",
      valuetype = "void"
    },
    getSceneType={
      type = "method",
      args="()",
      returns = "ESceneType",
      valuetype = "ESceneType"
    },
    getSceneID={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    isNormalScene={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

CMap = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMap",
      valuetype = "CMap",
    },
    setMapID={
      type = "method",
      args="(unsigned short: mapID)",
      returns = "void",
      valuetype = "void"
    },
    toString={
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
    isKey={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    keyToString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    getMapID={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    getKey={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    addScene={
      type = "method",
      args="(CScene*: pScene)",
      returns = "bool",
      valuetype = "bool"
    },
    delScene={
      type = "method",
      args="(unsigned long long: sceneID)",
      returns = "void",
      valuetype = "void"
    },
    setKey={
      type = "method",
      args="(unsigned short: key)",
      returns = "void",
      valuetype = "void"
    },
  },
},

CMapManager = {
  type = "class",
  inherits = "CHashMultiIndex<CMap, false, 0> CManualSingleton<CMapManager> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMapManager",
      valuetype = "CMapManager",
    },
    getNext={
      type = "method",
      args="()",
      returns = "CMap*",
      valuetype = "CMap"
    },
    getBegin={
      type = "method",
      args="()",
      returns = "CMap*",
      valuetype = "CMap"
    },
    addMap={
      type = "method",
      args="(unsigned short: mapID)",
      returns = "CMap*",
      valuetype = "CMap"
    },
    update={
      type = "method",
      args="(unsigned int: diff)",
      returns = "void",
      valuetype = "void"
    },
    findMap={
      type = "method",
      args="(unsigned short: mapID)",
      returns = "CMap*",
      valuetype = "CMap"
    },
    isMapExist={
      type = "method",
      args="(unsigned short: mapID)",
      returns = "bool",
      valuetype = "bool"
    },
    init={
      type = "method",
      args="(unsigned int: maxNum)",
      returns = "bool",
      valuetype = "bool"
    },
    addScene={
      type = "method",
      args="(CScene*: pScene)",
      returns = "bool",
      valuetype = "bool"
    },
    delScene={
      type = "method",
      args="(unsigned long long: sceneID)",
      returns = "void",
      valuetype = "void"
    },
    delMap={
      type = "method",
      args="(unsigned short: mapID)",
      returns = "void",
      valuetype = "void"
    },
    size={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    GetPtr={
      type = "method",
      args="()",
      returns = "CMapManager*",
      valuetype = "CMapManager"
    },
  },
},

CConfigTbl = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CConfigTbl",
      valuetype = "CConfigTbl",
    },
  },
},

UrlDownFile = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "UrlDownFile",
      valuetype = "UrlDownFile",
    },
  },
},

CCconfigLoaderParam = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CCconfigLoaderParam",
      valuetype = "CCconfigLoaderParam",
    },
  },
},

CConfigLoaderBase = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CConfigLoaderBase",
      valuetype = "CConfigLoaderBase",
    },
    checkConfig={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

CRoleNameRandTbl = {
  type = "class",
  inherits = "CConfigTbl ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CRoleNameRandTbl",
      valuetype = "CRoleNameRandTbl",
    },
    getString={
      type = "method",
      args="(unsigned char: sex,unsigned int: index)",
      returns = "string",
      valuetype = "string"
    },
    isKey={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getLength={
      type = "method",
      args="(unsigned char: sex)",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    keyToString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    getKey={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    setKey={
      type = "method",
      args="(unsigned int: key)",
      returns = "void",
      valuetype = "void"
    },
    toString={
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
  },
},

CRandRoleNameTblLoader = {
  type = "class",
  inherits = "CConfigLoader<CRandRoleNameTblLoader, CRoleNameRandTbl> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CRandRoleNameTblLoader",
      valuetype = "CRandRoleNameTblLoader",
    },
    readRow={
      type = "method",
      args="(TiXmlElement*: row,int: count,CRoleNameRandTbl*: randNameRow)",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

_LoginRole = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "_LoginRole",
      valuetype = "_LoginRole",
    },
    setParam={
      type = "method",
      args="(char*: name,unsigned long long: roleUID,unsigned int: objUID,unsigned char: sex,unsigned char: job,unsigned char: level,unsigned int: createTime,AxisPos: pos,unsigned long long: sceneID,unsigned char: gridNum,unsigned int: logOutTime)",
      returns = "void",
      valuetype = "void"
    },
    getMapID={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    getPackLoginRole={
      type = "method",
      args="(PackLoginRole*: packRole)",
      returns = "void",
      valuetype = "void"
    },
    cleanUp={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    toString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    getSceneID={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    isDynamicMap={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

CWorldLoginRoleList = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWorldLoginRoleList",
      valuetype = "CWorldLoginRoleList",
    },
    genStrName={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    selectRole={
      type = "method",
      args="(unsigned long long: roleUID)",
      returns = "bool",
      valuetype = "bool"
    },
    getLastLoginRoleUID={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    getCurrentRole={
      type = "method",
      args="()",
      returns = "_LoginRole*",
      valuetype = "_LoginRole"
    },
    getCurrentRoleUID={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    toString={
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
    isMaxRoleNum={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    clean={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    delRole={
      type = "method",
      args="(unsigned long long: roleUID)",
      returns = "void",
      valuetype = "void"
    },
    addRole={
      type = "method",
      args="(_LoginRole*: role)",
      returns = "void",
      valuetype = "void"
    },
    getFirstRoleUID={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    getCurrentObjUID={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    isRole={
      type = "method",
      args="(unsigned long long: roleUID)",
      returns = "bool",
      valuetype = "bool"
    },
    size={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
  },
},

CWorldUserSimpleData = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWorldUserSimpleData",
      valuetype = "CWorldUserSimpleData",
    },
    key2ToString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    isKey={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    key3ToString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    keyToString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    setKey3={
      type = "method",
      args="(CCharArray2<50>: key)",
      returns = "void",
      valuetype = "void"
    },
    getKey2={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    getKey={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    isKey3={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setKey={
      type = "method",
      args="(unsigned int: key)",
      returns = "void",
      valuetype = "void"
    },
    toString={
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
    getKey3={
      type = "method",
      args="()",
      returns = "CCharArray2<50>",
      valuetype = "CCharArray2<50>"
    },
    isKey2={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setKey2={
      type = "method",
      args="(unsigned long long: key)",
      returns = "void",
      valuetype = "void"
    },
  },
},

CWorldAllUserMgr = {
  type = "class",
  inherits = "CManualSingleton<CWorldAllUserMgr> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWorldAllUserMgr",
      valuetype = "CWorldAllUserMgr",
    },
    updateUser={
      type = "method",
      args="(unsigned int: objUID,unsigned char: level)",
      returns = "void",
      valuetype = "void"
    },
    loadAll={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getObjUID={
      type = "method",
      args="(unsigned long long: roleUID)",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    getRoleUID={
      type = "method",
      args="(unsigned int: objUID)",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    init={
      type = "method",
      args="(unsigned int: maxNum)",
      returns = "bool",
      valuetype = "bool"
    },
    size={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    GetPtr={
      type = "method",
      args="()",
      returns = "CWorldAllUserMgr*",
      valuetype = "CWorldAllUserMgr"
    },
  },
},

CCheckText = {
  type = "class",
  inherits = "CManualSingleton<CCheckText> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CCheckText",
      valuetype = "CCheckText",
    },
    getFilterContentVec={
      type = "method",
      args="()",
      returns = "vector<basic_string<char>, allocator<basic_string<char> > >",
      valuetype = "vector<basic_string<char>, allocator<basic_string<char> > >"
    },
    isTextPass={
      type = "method",
      args="(string: checkText)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    init={
      type = "method",
      args="(string: filePath)",
      returns = "bool",
      valuetype = "bool"
    },
    isFilterContent={
      type = "method",
      args="(string: content)",
      returns = "bool",
      valuetype = "bool"
    },
    GetPtr={
      type = "method",
      args="()",
      returns = "CCheckText*",
      valuetype = "CCheckText"
    },
  },
},

CRandRoleName = {
  type = "class",
  inherits = "CManualSingleton<CRandRoleName> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CRandRoleName",
      valuetype = "CRandRoleName",
    },
    randRoleName={
      type = "method",
      args="(unsigned char: sex)",
      returns = "string",
      valuetype = "string"
    },
    GetPtr={
      type = "method",
      args="()",
      returns = "CRandRoleName*",
      valuetype = "CRandRoleName"
    },
  },
},

CSceneManager = {
  type = "class",
  inherits = "CHashMultiIndex<CScene, false, 18446744073709551615> CManualSingleton<CSceneManager> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CSceneManager",
      valuetype = "CSceneManager",
    },
    getNext={
      type = "method",
      args="()",
      returns = "CScene*",
      valuetype = "CScene"
    },
    isSceneExist={
      type = "method",
      args="(unsigned long long: sceneID)",
      returns = "bool",
      valuetype = "bool"
    },
    getBegin={
      type = "method",
      args="()",
      returns = "CScene*",
      valuetype = "CScene"
    },
    findScene={
      type = "method",
      args="(unsigned long long: sceneID)",
      returns = "CScene*",
      valuetype = "CScene"
    },
    getSceneOwner={
      type = "method",
      args="(unsigned long long: sceneID)",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    update={
      type = "method",
      args="(unsigned int: diff)",
      returns = "void",
      valuetype = "void"
    },
    delMapServer={
      type = "method",
      args="(unsigned short: mapServerID)",
      returns = "void",
      valuetype = "void"
    },
    changeSceneOwner={
      type = "method",
      args="(unsigned long long: sceneID,unsigned int: objUID)",
      returns = "void",
      valuetype = "void"
    },
    init={
      type = "method",
      args="(unsigned int: maxNum)",
      returns = "bool",
      valuetype = "bool"
    },
    addScene={
      type = "method",
      args="(SceneData*: data)",
      returns = "CScene*",
      valuetype = "CScene"
    },
    delScene={
      type = "method",
      args="(unsigned long long: sceneID)",
      returns = "void",
      valuetype = "void"
    },
    size={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    GetPtr={
      type = "method",
      args="()",
      returns = "CSceneManager*",
      valuetype = "CSceneManager"
    },
  },
},

PackHandleAttr = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PackHandleAttr",
      valuetype = "PackHandleAttr",
    },
  },
},

SockAttr = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "SockAttr",
      valuetype = "SockAttr",
    },
  },
},

CWorldServerConfig = {
  type = "class",
  inherits = "CGxServiceConfig ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWorldServerConfig",
      valuetype = "CWorldServerConfig",
    },
    getRecordeSocketAttr={
      type = "method",
      args="()",
      returns = "SockAttr*",
      valuetype = "SockAttr"
    },
    getBillSocketAttr={
      type = "method",
      args="()",
      returns = "SockAttr*",
      valuetype = "SockAttr"
    },
    getToClientPort={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    getManagerServerPort={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    getPwdSocketAttr={
      type = "method",
      args="()",
      returns = "SockAttr*",
      valuetype = "SockAttr"
    },
    getHttpCheck={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getPwdIP={
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
    getRecordeServerPort={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    getBillListenIP={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    getToClientIP={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    isConfigRemotePath={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getClientListenIP={
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
    getMapListenPort={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    getCheckTextFileName={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    getHttpListenIP={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    getManagerServerIP={
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
    getGmCheck={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getWorldServerID={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    getHttpListenPort={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    getMapServerSocketAttr={
      type = "method",
      args="()",
      returns = "SockAttr*",
      valuetype = "SockAttr"
    },
    getClientListenPort={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    getLoginServerPort={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    setGmCheck={
      type = "method",
      args="(bool: val)",
      returns = "void",
      valuetype = "void"
    },
    getDbPwd={
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
    getMapListenIP={
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
    setHttpCheck={
      type = "method",
      args="(bool: val)",
      returns = "void",
      valuetype = "void"
    },
    getBillListenPort={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    getGmListenPort={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    getDbHostIP={
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
    getGmSocketAttr={
      type = "method",
      args="()",
      returns = "SockAttr*",
      valuetype = "SockAttr"
    },
    getDbPort={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    getGmListenIP={
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
    setHttpListenPort={
      type = "method",
      args="(unsigned short: val)",
      returns = "void",
      valuetype = "void"
    },
    getDbName={
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
    getConfigTblPath={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    getSvrMgrSocketAttr={
      type = "method",
      args="()",
      returns = "SockAttr*",
      valuetype = "SockAttr"
    },
    getDbUser={
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
    getClientSocketAttr={
      type = "method",
      args="()",
      returns = "SockAttr*",
      valuetype = "SockAttr"
    },
    getLoginPlayerNum={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    getRecordeServerIP={
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
    setHttpListenIP={
      type = "method",
      args="(string: val)",
      returns = "void",
      valuetype = "void"
    },
    getPwdPort={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    getClientNum={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    getLoginServerIP={
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
    getMapServerNum={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
  },
},

CWorldServerInfo = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWorldServerInfo",
      valuetype = "CWorldServerInfo",
    },
    getFirstStartTime={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    getOpenTime={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    setOpenTime={
      type = "method",
      args="(unsigned int: val)",
      returns = "void",
      valuetype = "void"
    },
    setFirstStartTime={
      type = "method",
      args="(unsigned int: val)",
      returns = "void",
      valuetype = "void"
    },
  },
},

ServerData = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ServerData",
      valuetype = "ServerData",
    },
    cleanUp={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
  },
},

LoginServerData = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "LoginServerData",
      valuetype = "LoginServerData",
    },
  },
},

WorldServerName = {
  type = "class",
  inherits = "IArrayEnable<WorldServerName> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "WorldServerName",
      valuetype = "WorldServerName",
    },
  },
},

WorldServerData = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "WorldServerData",
      valuetype = "WorldServerData",
    },
  },
},

RoleHeart = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "RoleHeart",
      valuetype = "RoleHeart",
    },
  },
},

CLGetZoneList = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CLGetZoneList",
      valuetype = "CLGetZoneList",
    },
  },
},

LCGetZoneListRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "LCGetZoneListRet",
      valuetype = "LCGetZoneListRet",
    },
  },
},

CLGetHasRoleZoneList = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CLGetHasRoleZoneList",
      valuetype = "CLGetHasRoleZoneList",
    },
  },
},

LCGetHasRoleZoneListRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "LCGetHasRoleZoneListRet",
      valuetype = "LCGetHasRoleZoneListRet",
    },
  },
},

CLVerifyAccount = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CLVerifyAccount",
      valuetype = "CLVerifyAccount",
    },
    toString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
  },
},

LCVerifyAccountRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "LCVerifyAccountRet",
      valuetype = "LCVerifyAccountRet",
    },
  },
},

ItemPosition = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ItemPosition",
      valuetype = "ItemPosition",
    },
    isValid={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    cleanUp={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
  },
},

HoleGemInfo = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "HoleGemInfo",
      valuetype = "HoleGemInfo",
    },
    cleanUp={
      type = "method",
      args="(unsigned char: pos,unsigned short: id)",
      returns = "void",
      valuetype = "void"
    },
  },
},

_ItemType = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "_ItemType",
      valuetype = "_ItemType",
    },
  },
},

MoveItem = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MoveItem",
      valuetype = "MoveItem",
    },
  },
},

UpdateItem = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "UpdateItem",
      valuetype = "UpdateItem",
    },
  },
},

SimpleItem = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "SimpleItem",
      valuetype = "SimpleItem",
    },
  },
},

ExtItem = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ExtItem",
      valuetype = "ExtItem",
    },
  },
},

ItemReward = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ItemReward",
      valuetype = "ItemReward",
    },
    clean={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
  },
},

PackItem = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PackItem",
      valuetype = "PackItem",
    },
    toString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
  },
},

MCAddItems = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCAddItems",
      valuetype = "MCAddItems",
    },
    toString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
  },
},

MCDelItems = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCDelItems",
      valuetype = "MCDelItems",
    },
  },
},

MCUpdateItems = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCUpdateItems",
      valuetype = "MCUpdateItems",
    },
  },
},

MCMoveItems = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCMoveItems",
      valuetype = "MCMoveItems",
    },
  },
},

MCExchangeItem = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCExchangeItem",
      valuetype = "MCExchangeItem",
    },
  },
},

CMBagOperate = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMBagOperate",
      valuetype = "CMBagOperate",
    },
  },
},

MCBagOperateRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCBagOperateRet",
      valuetype = "MCBagOperateRet",
    },
  },
},

CMBagExtend = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMBagExtend",
      valuetype = "CMBagExtend",
    },
  },
},

MCBagExtendRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCBagExtendRet",
      valuetype = "MCBagExtendRet",
    },
  },
},

MCBagExtend = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCBagExtend",
      valuetype = "MCBagExtend",
    },
  },
},

CMExchangeGiftReq = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMExchangeGiftReq",
      valuetype = "CMExchangeGiftReq",
    },
  },
},

MCExchangeGiftRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCExchangeGiftRet",
      valuetype = "MCExchangeGiftRet",
    },
  },
},

RoleDetail = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "RoleDetail",
      valuetype = "RoleDetail",
    },
  },
},

MCEnterView = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCEnterView",
      valuetype = "MCEnterView",
    },
    size={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
  },
},

MCLeaveView = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCLeaveView",
      valuetype = "MCLeaveView",
    },
    push={
      type = "method",
      args="(unsigned int: objUID,unsigned char: objType)",
      returns = "void",
      valuetype = "void"
    },
  },
},

MCSceneData = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCSceneData",
      valuetype = "MCSceneData",
    },
  },
},

CMMove = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMMove",
      valuetype = "CMMove",
    },
  },
},

MCMoveRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCMoveRet",
      valuetype = "MCMoveRet",
    },
  },
},

MCMoveBroad = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCMoveBroad",
      valuetype = "MCMoveBroad",
    },
    toString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
  },
},

CMJump = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMJump",
      valuetype = "CMJump",
    },
  },
},

MCJumpRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCJumpRet",
      valuetype = "MCJumpRet",
    },
  },
},

CMDrop = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMDrop",
      valuetype = "CMDrop",
    },
  },
},

MCDropRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCDropRet",
      valuetype = "MCDropRet",
    },
  },
},

CMLand = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMLand",
      valuetype = "CMLand",
    },
  },
},

MCLandRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCLandRet",
      valuetype = "MCLandRet",
    },
  },
},

MCResetPos = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCResetPos",
      valuetype = "MCResetPos",
    },
  },
},

MCEnterScene = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCEnterScene",
      valuetype = "MCEnterScene",
    },
  },
},

CMEnterScene = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMEnterScene",
      valuetype = "CMEnterScene",
    },
  },
},

MCEnterSceneRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCEnterSceneRet",
      valuetype = "MCEnterSceneRet",
    },
  },
},

CMChangeMap = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMChangeMap",
      valuetype = "CMChangeMap",
    },
  },
},

MCChangeMapRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCChangeMapRet",
      valuetype = "MCChangeMapRet",
    },
  },
},

CMDynamicMapList = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMDynamicMapList",
      valuetype = "CMDynamicMapList",
    },
  },
},

MCDynamicMapListRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCDynamicMapListRet",
      valuetype = "MCDynamicMapListRet",
    },
  },
},

CMChat = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMChat",
      valuetype = "CMChat",
    },
  },
},

MCChatBroad = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCChatBroad",
      valuetype = "MCChatBroad",
    },
  },
},

MCAnnouncement = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCAnnouncement",
      valuetype = "MCAnnouncement",
    },
  },
},

CMTransmite = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMTransmite",
      valuetype = "CMTransmite",
    },
  },
},

MCTransmiteRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCTransmiteRet",
      valuetype = "MCTransmiteRet",
    },
  },
},

MCSyncRoleData = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCSyncRoleData",
      valuetype = "MCSyncRoleData",
    },
    reset={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    isDirty={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

MCCallBackRetCode = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCCallBackRetCode",
      valuetype = "MCCallBackRetCode",
    },
  },
},

CMRenameRoleName = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMRenameRoleName",
      valuetype = "CMRenameRoleName",
    },
  },
},

MCRenameRoleNameRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCRenameRoleNameRet",
      valuetype = "MCRenameRoleNameRet",
    },
  },
},

CMRandRoleName = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMRandRoleName",
      valuetype = "CMRandRoleName",
    },
  },
},

MCRandRoleNameRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCRandRoleNameRet",
      valuetype = "MCRandRoleNameRet",
    },
  },
},

MCKickRole = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCKickRole",
      valuetype = "MCKickRole",
    },
  },
},

CMOpenDynamicMap = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMOpenDynamicMap",
      valuetype = "CMOpenDynamicMap",
    },
  },
},

MCOpenDynamicMapRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCOpenDynamicMapRet",
      valuetype = "MCOpenDynamicMapRet",
    },
  },
},

CMWorldChatMsg = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMWorldChatMsg",
      valuetype = "CMWorldChatMsg",
    },
  },
},

MCWorldChatMsg = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCWorldChatMsg",
      valuetype = "MCWorldChatMsg",
    },
  },
},

CMRoomChatMsg = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMRoomChatMsg",
      valuetype = "CMRoomChatMsg",
    },
  },
},

MCRoomChatMsg = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCRoomChatMsg",
      valuetype = "MCRoomChatMsg",
    },
  },
},

MCScreenAnnounce = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCScreenAnnounce",
      valuetype = "MCScreenAnnounce",
    },
  },
},

MCAttackBroad = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCAttackBroad",
      valuetype = "MCAttackBroad",
    },
    toString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
  },
},

MCAttackImpact = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCAttackImpact",
      valuetype = "MCAttackImpact",
    },
    toString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
  },
},

MCObjActionBan = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCObjActionBan",
      valuetype = "MCObjActionBan",
    },
  },
},

MCAddBuffer = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCAddBuffer",
      valuetype = "MCAddBuffer",
    },
  },
},

MCDelBuffer = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCDelBuffer",
      valuetype = "MCDelBuffer",
    },
  },
},

CMBuffArray = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMBuffArray",
      valuetype = "CMBuffArray",
    },
  },
},

MCBuffArrayRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCBuffArrayRet",
      valuetype = "MCBuffArrayRet",
    },
  },
},

CMViewBuff = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMViewBuff",
      valuetype = "CMViewBuff",
    },
  },
},

MCViewBuffRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCViewBuffRet",
      valuetype = "MCViewBuffRet",
    },
  },
},

CMFightOpenChapter = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMFightOpenChapter",
      valuetype = "CMFightOpenChapter",
    },
  },
},

MCFightOpenChapterRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCFightOpenChapterRet",
      valuetype = "MCFightOpenChapterRet",
    },
  },
},

CMFightFinish = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMFightFinish",
      valuetype = "CMFightFinish",
    },
  },
},

MCFightFinishRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCFightFinishRet",
      valuetype = "MCFightFinishRet",
    },
  },
},

TUserFlag = {
  type = "class",
  inherits = "TDBStructBase ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "TUserFlag",
      valuetype = "TUserFlag",
    },
  },
},

UserDbData = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "UserDbData",
      valuetype = "UserDbData",
    },
  },
},

CWorldUserData = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWorldUserData",
      valuetype = "CWorldUserData",
    },
    isValid={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    toString={
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
  },
},

W2MUserDataUpdate = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "W2MUserDataUpdate",
      valuetype = "W2MUserDataUpdate",
    },
  },
},

M2WRoleDataUpdate = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "M2WRoleDataUpdate",
      valuetype = "M2WRoleDataUpdate",
    },
  },
},

_ChangeMapSaveData = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "_ChangeMapSaveData",
      valuetype = "_ChangeMapSaveData",
    },
  },
},

ChangeLineTempData = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ChangeLineTempData",
      valuetype = "ChangeLineTempData",
    },
    cleanUp={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
  },
},

RoleManageInfo = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "RoleManageInfo",
      valuetype = "RoleManageInfo",
    },
  },
},

CharmsItemBeanReader = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CharmsItemBeanReader",
      valuetype = "CharmsItemBeanReader",
    },
  },
},

GiftBeanReader = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "GiftBeanReader",
      valuetype = "GiftBeanReader",
    },
  },
},

PlayerInfoBeanReader = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PlayerInfoBeanReader",
      valuetype = "PlayerInfoBeanReader",
    },
  },
},

GiveGiftBeanReader = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "GiveGiftBeanReader",
      valuetype = "GiveGiftBeanReader",
    },
  },
},

FriendPageBeanReader = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "FriendPageBeanReader",
      valuetype = "FriendPageBeanReader",
    },
  },
},

SimplePlayerInfoBeanReader = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "SimplePlayerInfoBeanReader",
      valuetype = "SimplePlayerInfoBeanReader",
    },
  },
},

GiveGiftSimpleBeanReader = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "GiveGiftSimpleBeanReader",
      valuetype = "GiveGiftSimpleBeanReader",
    },
  },
},

FriendSimplePageBeanReader = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "FriendSimplePageBeanReader",
      valuetype = "FriendSimplePageBeanReader",
    },
  },
},

GuessBeanReader = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "GuessBeanReader",
      valuetype = "GuessBeanReader",
    },
  },
},

LoginAwardBeanReader = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "LoginAwardBeanReader",
      valuetype = "LoginAwardBeanReader",
    },
  },
},

MailBeanReader = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MailBeanReader",
      valuetype = "MailBeanReader",
    },
  },
},

MyGuessBeanReader = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MyGuessBeanReader",
      valuetype = "MyGuessBeanReader",
    },
  },
},

PeriodReportReader = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PeriodReportReader",
      valuetype = "PeriodReportReader",
    },
  },
},

PlayerPeriodActionReader = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PlayerPeriodActionReader",
      valuetype = "PlayerPeriodActionReader",
    },
  },
},

PlayerSeatBeanReader = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PlayerSeatBeanReader",
      valuetype = "PlayerSeatBeanReader",
    },
  },
},

RankBeanReader = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "RankBeanReader",
      valuetype = "RankBeanReader",
    },
  },
},

RankDayBeanReader = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "RankDayBeanReader",
      valuetype = "RankDayBeanReader",
    },
  },
},

RechargeOrderBeanReader = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "RechargeOrderBeanReader",
      valuetype = "RechargeOrderBeanReader",
    },
  },
},

SeatPlayerBeanReader = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "SeatPlayerBeanReader",
      valuetype = "SeatPlayerBeanReader",
    },
  },
},

SelfPeriodReportReader = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "SelfPeriodReportReader",
      valuetype = "SelfPeriodReportReader",
    },
  },
},

ServerBeanReader = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ServerBeanReader",
      valuetype = "ServerBeanReader",
    },
  },
},

ShopItemBeanReader = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ShopItemBeanReader",
      valuetype = "ShopItemBeanReader",
    },
  },
},

SimpleRankBeanReader = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "SimpleRankBeanReader",
      valuetype = "SimpleRankBeanReader",
    },
  },
},

TradeItemBeanReader = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "TradeItemBeanReader",
      valuetype = "TradeItemBeanReader",
    },
  },
},

TwoValueBeanReader = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "TwoValueBeanReader",
      valuetype = "TwoValueBeanReader",
    },
  },
},

VipInfoBeanReader = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "VipInfoBeanReader",
      valuetype = "VipInfoBeanReader",
    },
  },
},

ChatMsgBeanReader = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ChatMsgBeanReader",
      valuetype = "ChatMsgBeanReader",
    },
  },
},

CannonBeanReader = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CannonBeanReader",
      valuetype = "CannonBeanReader",
    },
  },
},

CMLoginServer = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMLoginServer",
      valuetype = "CMLoginServer",
    },
  },
},

MCLoginServerRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCLoginServerRet",
      valuetype = "MCLoginServerRet",
    },
  },
},

MCServerListSvr = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCServerListSvr",
      valuetype = "MCServerListSvr",
    },
  },
},

CMLoginLogList = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMLoginLogList",
      valuetype = "CMLoginLogList",
    },
  },
},

MCLoginLogListRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCLoginLogListRet",
      valuetype = "MCLoginLogListRet",
    },
  },
},

CMSelectServerMsg = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMSelectServerMsg",
      valuetype = "CMSelectServerMsg",
    },
  },
},

MCSelectServerMsgRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCSelectServerMsgRet",
      valuetype = "MCSelectServerMsgRet",
    },
  },
},

CMLoginGameServer = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMLoginGameServer",
      valuetype = "CMLoginGameServer",
    },
  },
},

MCLoginGameServerRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCLoginGameServerRet",
      valuetype = "MCLoginGameServerRet",
    },
  },
},

MCGameServerReady = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCGameServerReady",
      valuetype = "MCGameServerReady",
    },
  },
},

CMLocalLoginGame = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMLocalLoginGame",
      valuetype = "CMLocalLoginGame",
    },
  },
},

MCLocalLoginGameRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCLocalLoginGameRet",
      valuetype = "MCLocalLoginGameRet",
    },
  },
},

CMLocalLoginGameAccount = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMLocalLoginGameAccount",
      valuetype = "CMLocalLoginGameAccount",
    },
  },
},

MCLocalLoginGameAccountRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCLocalLoginGameAccountRet",
      valuetype = "MCLocalLoginGameAccountRet",
    },
    initData={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
  },
},

CMEnterGame = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMEnterGame",
      valuetype = "CMEnterGame",
    },
  },
},

MCEnterGameRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCEnterGameRet",
      valuetype = "MCEnterGameRet",
    },
  },
},

MCPlayerHeart = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCPlayerHeart",
      valuetype = "MCPlayerHeart",
    },
  },
},

CMPlayerHeartRet = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMPlayerHeartRet",
      valuetype = "CMPlayerHeartRet",
    },
  },
},

MissionParam = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MissionParam",
      valuetype = "MissionParam",
    },
    setNParam={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    setNMaxParam={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    getNParam={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    isMaxParam={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getNMaxParam={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
  },
},

MissionBase = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MissionBase",
      valuetype = "MissionBase",
    },
    isDialog={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getEventTypeStr={
      type = "method",
      args="(EMissionEvent: eventType)",
      returns = "string",
      valuetype = "string"
    },
    isCollectItem={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isEvent={
      type = "method",
      args="(EMissionEvent: events)",
      returns = "bool",
      valuetype = "bool"
    },
    getEventType={
      type = "method",
      args="()",
      returns = "EMissionEvent",
      valuetype = "EMissionEvent"
    },
    isGuanQia={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getStatus={
      type = "method",
      args="()",
      returns = "EMissionStatus",
      valuetype = "EMissionStatus"
    },
    setEventType={
      type = "method",
      args="(EMissionEvent: val)",
      returns = "void",
      valuetype = "void"
    },
    setMissionID={
      type = "method",
      args="(unsigned short: val)",
      returns = "void",
      valuetype = "void"
    },
    isActiveMission={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setStatus={
      type = "method",
      args="(EMissionStatus: val)",
      returns = "void",
      valuetype = "void"
    },
    getAcceptLevel={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    getMissionID={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    cleanUp={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    setAcceptLevel={
      type = "method",
      args="(unsigned char: val)",
      returns = "void",
      valuetype = "void"
    },
    setAcceptTime={
      type = "method",
      args="(unsigned int: val)",
      returns = "void",
      valuetype = "void"
    },
    isKillMonster={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    toString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    getAcceptTime={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
  },
},

PackMission = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PackMission",
      valuetype = "PackMission",
    },
    cleanUp={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
  },
},

PackMissionParams = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PackMissionParams",
      valuetype = "PackMissionParams",
    },
  },
},

DBAcceptMission = {
  type = "class",
  inherits = "TDBStructBase ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "DBAcceptMission",
      valuetype = "DBAcceptMission",
    },
  },
},

DBFinishMissionBit = {
  type = "class",
  inherits = "TDBStructBase ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "DBFinishMissionBit",
      valuetype = "DBFinishMissionBit",
    },
  },
},

MCUpdateMissionList = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCUpdateMissionList",
      valuetype = "MCUpdateMissionList",
    },
  },
},

MCUpdateMissionParam = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCUpdateMissionParam",
      valuetype = "MCUpdateMissionParam",
    },
  },
},

MCDeleteMission = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCDeleteMission",
      valuetype = "MCDeleteMission",
    },
  },
},

CMMissionOperate = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMMissionOperate",
      valuetype = "CMMissionOperate",
    },
  },
},

MCMissionOperateRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCMissionOperateRet",
      valuetype = "MCMissionOperateRet",
    },
  },
},

CWVerifyConnect = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWVerifyConnect",
      valuetype = "CWVerifyConnect",
    },
  },
},

WCVerifyConnectRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "WCVerifyConnectRet",
      valuetype = "WCVerifyConnectRet",
    },
  },
},

CWRandGenName = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWRandGenName",
      valuetype = "CWRandGenName",
    },
  },
},

WCRandGenNameRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "WCRandGenNameRet",
      valuetype = "WCRandGenNameRet",
    },
  },
},

CWCreateRole = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWCreateRole",
      valuetype = "CWCreateRole",
    },
    isValid={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

WCCreateRoleRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "WCCreateRoleRet",
      valuetype = "WCCreateRoleRet",
    },
  },
},

CWLoginGame = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWLoginGame",
      valuetype = "CWLoginGame",
    },
  },
},

WCLoginGameRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "WCLoginGameRet",
      valuetype = "WCLoginGameRet",
    },
    toString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
  },
},

CWLoginQuit = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWLoginQuit",
      valuetype = "CWLoginQuit",
    },
  },
},

WCLoginQuitRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "WCLoginQuitRet",
      valuetype = "WCLoginQuitRet",
    },
  },
},

CWLRegiste = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWLRegiste",
      valuetype = "CWLRegiste",
    },
  },
},

CLWRegisteRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CLWRegisteRet",
      valuetype = "CLWRegisteRet",
    },
  },
},

CWLRoleLogin = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWLRoleLogin",
      valuetype = "CWLRoleLogin",
    },
  },
},

CLWRoleLoginRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CLWRoleLoginRet",
      valuetype = "CLWRoleLoginRet",
    },
  },
},

CWLRoleCreate = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWLRoleCreate",
      valuetype = "CWLRoleCreate",
    },
  },
},

CLWRoleCreateRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CLWRoleCreateRet",
      valuetype = "CLWRoleCreateRet",
    },
  },
},

CWLDataUpdate = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWLDataUpdate",
      valuetype = "CWLDataUpdate",
    },
  },
},

CLWLimitInfoUpdate = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CLWLimitInfoUpdate",
      valuetype = "CLWLimitInfoUpdate",
    },
  },
},

CLWLimitAccountInfo = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CLWLimitAccountInfo",
      valuetype = "CLWLimitAccountInfo",
    },
  },
},

CLWLimitChatInfo = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CLWLimitChatInfo",
      valuetype = "CLWLimitChatInfo",
    },
  },
},

CWLLimitInfoReq = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWLLimitInfoReq",
      valuetype = "CWLLimitInfoReq",
    },
  },
},

MWRegiste = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MWRegiste",
      valuetype = "MWRegiste",
    },
    toString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
  },
},

WMRegisteRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "WMRegisteRet",
      valuetype = "WMRegisteRet",
    },
  },
},

MWBroadPacket = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MWBroadPacket",
      valuetype = "MWBroadPacket",
    },
  },
},

MWTransPacket = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MWTransPacket",
      valuetype = "MWTransPacket",
    },
  },
},

MWTrans2WorldPacket = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MWTrans2WorldPacket",
      valuetype = "MWTrans2WorldPacket",
    },
  },
},

WMTransPacketError = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "WMTransPacketError",
      valuetype = "WMTransPacketError",
    },
  },
},

WMUpdateServer = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "WMUpdateServer",
      valuetype = "WMUpdateServer",
    },
  },
},

MWUpdateServer = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MWUpdateServer",
      valuetype = "MWUpdateServer",
    },
  },
},

MWOpenScene = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MWOpenScene",
      valuetype = "MWOpenScene",
    },
    toString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
  },
},

MWCloseScene = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MWCloseScene",
      valuetype = "MWCloseScene",
    },
    toString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
  },
},

MMChangeScene = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MMChangeScene",
      valuetype = "MMChangeScene",
    },
  },
},

MWChangeLine = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MWChangeLine",
      valuetype = "MWChangeLine",
    },
  },
},

WMChangeLine = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "WMChangeLine",
      valuetype = "WMChangeLine",
    },
    toString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
  },
},

WMChangeLineRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "WMChangeLineRet",
      valuetype = "WMChangeLineRet",
    },
    toString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
  },
},

WMLoadRoleData = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "WMLoadRoleData",
      valuetype = "WMLoadRoleData",
    },
    toString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
  },
},

MWLoadRoleDataRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MWLoadRoleDataRet",
      valuetype = "MWLoadRoleDataRet",
    },
    toString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
  },
},

WMUnloadRoleData = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "WMUnloadRoleData",
      valuetype = "WMUnloadRoleData",
    },
    toString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
  },
},

MWUnloadRoleDataRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MWUnloadRoleDataRet",
      valuetype = "MWUnloadRoleDataRet",
    },
    toString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
  },
},

MWRoleQuit = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MWRoleQuit",
      valuetype = "MWRoleQuit",
    },
    toString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
  },
},

MWUserLogin = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MWUserLogin",
      valuetype = "MWUserLogin",
    },
  },
},

MWRoleHeart = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MWRoleHeart",
      valuetype = "MWRoleHeart",
    },
  },
},

WMRoleHeartRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "WMRoleHeartRet",
      valuetype = "WMRoleHeartRet",
    },
  },
},

MWRoleKick = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MWRoleKick",
      valuetype = "MWRoleKick",
    },
  },
},

WMUpdateUserData = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "WMUpdateUserData",
      valuetype = "WMUpdateUserData",
    },
  },
},

MWUpdateRoleData = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MWUpdateRoleData",
      valuetype = "MWUpdateRoleData",
    },
  },
},

MWRandRoleName = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MWRandRoleName",
      valuetype = "MWRandRoleName",
    },
  },
},

WMRandRoleNameRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "WMRandRoleNameRet",
      valuetype = "WMRandRoleNameRet",
    },
  },
},

MWRenameRoleName = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MWRenameRoleName",
      valuetype = "MWRenameRoleName",
    },
  },
},

WMRenameRoleNameRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "WMRenameRoleNameRet",
      valuetype = "WMRenameRoleNameRet",
    },
  },
},

MWGetRandNameList = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MWGetRandNameList",
      valuetype = "MWGetRandNameList",
    },
  },
},

WMGetRandNameListRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "WMGetRandNameListRet",
      valuetype = "WMGetRandNameListRet",
    },
  },
},

WMRecharge = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "WMRecharge",
      valuetype = "WMRecharge",
    },
  },
},

MWRechargeRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MWRechargeRet",
      valuetype = "MWRechargeRet",
    },
  },
},

WMServerInfo = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "WMServerInfo",
      valuetype = "WMServerInfo",
    },
  },
},

WMAwardBindRmb = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "WMAwardBindRmb",
      valuetype = "WMAwardBindRmb",
    },
  },
},

MWAnnoucement = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MWAnnoucement",
      valuetype = "MWAnnoucement",
    },
  },
},

CWMLimitAccountInfo = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWMLimitAccountInfo",
      valuetype = "CWMLimitAccountInfo",
    },
  },
},

CWMLimitChatInfo = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWMLimitChatInfo",
      valuetype = "CWMLimitChatInfo",
    },
  },
},

CMWLimitInfoReq = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMWLimitInfoReq",
      valuetype = "CMWLimitInfoReq",
    },
  },
},

MWExchangeGiftReq = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MWExchangeGiftReq",
      valuetype = "MWExchangeGiftReq",
    },
  },
},

WMExchangeGiftRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "WMExchangeGiftRet",
      valuetype = "WMExchangeGiftRet",
    },
  },
},

XMServerRegiste = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "XMServerRegiste",
      valuetype = "XMServerRegiste",
    },
  },
},

MXServerRegisteRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MXServerRegisteRet",
      valuetype = "MXServerRegisteRet",
    },
  },
},

CMRRecorde = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMRRecorde",
      valuetype = "CMRRecorde",
    },
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
  },
},

CWRRecorde = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWRRecorde",
      valuetype = "CWRRecorde",
    },
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
  },
},

CLRRecorde = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CLRRecorde",
      valuetype = "CLRRecorde",
    },
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
  },
},

CRRRecorde = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CRRRecorde",
      valuetype = "CRRRecorde",
    },
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
  },
},

CBRRecorde = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CBRRecorde",
      valuetype = "CBRRecorde",
    },
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
  },
},

CRWRequestServerInfo = {
  type = "class",
  inherits = "CRequestPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CRWRequestServerInfo",
      valuetype = "CRWRequestServerInfo",
    },
  },
},

CWRRequestServerInfoRet = {
  type = "class",
  inherits = "CResponsePacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWRRequestServerInfoRet",
      valuetype = "CWRRequestServerInfoRet",
    },
  },
},

MCCompress = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCCompress",
      valuetype = "MCCompress",
    },
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
  },
},

PackCompress = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PackCompress",
      valuetype = "PackCompress",
    },
  },
},

PackEncrypt = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PackEncrypt",
      valuetype = "PackEncrypt",
    },
  },
},

CBasePackHandleAry = {
  type = "class",
  inherits = "CPackHandleAry ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CBasePackHandleAry",
      valuetype = "CBasePackHandleAry",
    },
    parse={
      type = "method",
      args="(char*: msg,int: len)",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

TUnpacketIDHandler = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "TUnpacketIDHandler",
      valuetype = "TUnpacketIDHandler",
    },
  },
},

CGameSocketPacketHandler = {
  type = "class",
  inherits = "ISocketPacketHandler ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CGameSocketPacketHandler",
      valuetype = "CGameSocketPacketHandler",
    },
    onPackAfterFromSocket={
      type = "method",
      args="(char*: buff,int: len,char*: outBuff,int: outLen)",
      returns = "int",
      valuetype = "int"
    },
    onPackBeforeFlushToSocket={
      type = "method",
      args="(char*: buff,int: len,char*: outBuff,int: outLen)",
      returns = "int",
      valuetype = "int"
    },
    onBeforeFlushToSocket={
      type = "method",
      args="(char*: buff,int: len,char*: outBuff,int: outLen)",
      returns = "int",
      valuetype = "int"
    },
    setAttr={
      type = "method",
      args="(SockAttr*: attr)",
      returns = "void",
      valuetype = "void"
    },
    onSendPack={
      type = "method",
      args="(char*: msg,int: len,bool: singalFlag)",
      returns = "void",
      valuetype = "void"
    },
    doCompress={
      type = "method",
      args="(char*: buff,int: len,char*: outBuff,int: outLen)",
      returns = "int",
      valuetype = "int"
    },
    onAfterReadFromSocket={
      type = "method",
      args="(char*: buff,int: len,char*: outBuff,int: outLen)",
      returns = "int",
      valuetype = "int"
    },
    doEncrypt={
      type = "method",
      args="(char*: buff,int: len,char*: outBuff,int: outLen)",
      returns = "int",
      valuetype = "int"
    },
    canCompress={
      type = "method",
      args="(CBasePacket*: pBasePack)",
      returns = "bool",
      valuetype = "bool"
    },
    getMaxVarPackLen={
      type = "method",
      args="(char*: buff)",
      returns = "int",
      valuetype = "int"
    },
    needHandle={
      type = "method",
      args="(EPackOpt: opt)",
      returns = "bool",
      valuetype = "bool"
    },
    getPackHeaderLen={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    canUnpacket={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    canReadPack={
      type = "method",
      args="(char*: buff,int: len)",
      returns = "int",
      valuetype = "int"
    },
    isVarPacket={
      type = "method",
      args="(char*: buff,int: len)",
      returns = "bool",
      valuetype = "bool"
    },
    onHandleVarUnpacket={
      type = "method",
      args="(char*: buff,char*: varBuff,int: len)",
      returns = "void",
      valuetype = "void"
    },
    onRecvPack={
      type = "method",
      args="(char*: msg,int: len,bool: singalFlag)",
      returns = "void",
      valuetype = "void"
    },
    Setup={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    OnFlushDataToNetLoop={
      type = "method",
      args="(CNetLoopWrap*: netWrap,char*: msg,int: len,unsigned long long: index)",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

PacketPush = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "PacketPush",
      valuetype = "PacketPush",
    },
  },
},

CGameDatabaseHandler = {
  type = "class",
  inherits = "CDatabaseHandler ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CGameDatabaseHandler",
      valuetype = "CGameDatabaseHandler",
    },
    breath={
      type = "method",
      args="(int: diff)",
      returns = "void",
      valuetype = "void"
    },
    getSocketIndex={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    setSocketIndex={
      type = "method",
      args="(unsigned long long: socketIndex)",
      returns = "void",
      valuetype = "void"
    },
    setSocketMgr={
      type = "method",
      args="(CNetModule*: mgr)",
      returns = "void",
      valuetype = "void"
    },
  },
},

CWorldDbServerHandler = {
  type = "class",
  inherits = "CGameDatabaseHandler ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWorldDbServerHandler",
      valuetype = "CWorldDbServerHandler",
    },
    handle={
      type = "method",
      args="(char*: msg,unsigned int: len)",
      returns = "EHandleRet",
      valuetype = "EHandleRet"
    },
    sendGameInitTask={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    breath={
      type = "method",
      args="(int: diff)",
      returns = "void",
      valuetype = "void"
    },
    start={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    sendServerInitTask={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    close={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    sendLoadUserData={
      type = "method",
      args="(unsigned long long: roleUID)",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

CWorldServerData = {
  type = "class",
  inherits = "CManualSingleton<CWorldServerData> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWorldServerData",
      valuetype = "CWorldServerData",
    },
    getDataPtr={
      type = "method",
      args="()",
      returns = "WorldServerData*",
      valuetype = "WorldServerData"
    },
    update={
      type = "method",
      args="(int: diff)",
      returns = "void",
      valuetype = "void"
    },
    getDbHandler={
      type = "method",
      args="(bool: logFlag)",
      returns = "CWorldDbServerHandler*",
      valuetype = "CWorldDbServerHandler"
    },
    GetPtr={
      type = "method",
      args="()",
      returns = "CWorldServerData*",
      valuetype = "CWorldServerData"
    },
  },
},

CScriptEngineCommon = {
  type = "class",
  inherits = "CLuaVM ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CScriptEngineCommon",
      valuetype = "CScriptEngineCommon",
    },
    bindToScript={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

CWorldScriptEngine = {
  type = "class",
  inherits = "CScriptEngineCommon CManualSingleton<CWorldScriptEngine> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWorldScriptEngine",
      valuetype = "CWorldScriptEngine",
    },
    bindToScript={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

CWorldManagerServerHandler = {
  type = "class",
  inherits = "CGameExtendSocketHandler<CWorldManagerServerHandler> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWorldManagerServerHandler",
      valuetype = "CWorldManagerServerHandler",
    },
    connectToLoginServer={
      type = "method",
      args="(string: ip,unsigned short: port)",
      returns = "bool",
      valuetype = "bool"
    },
    sendRegiste={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    Setup={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    UnSetup={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
  },
},

CStopTimer = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CStopTimer",
      valuetype = "CStopTimer",
    },
    setService={
      type = "method",
      args="(GxService*: val)",
      returns = "void",
      valuetype = "void"
    },
    setStopLastTime={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    isStop={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setStopStartTime={
      type = "method",
      args="(unsigned int: val)",
      returns = "void",
      valuetype = "void"
    },
    getStopLastTime={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getStopSaveTime={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getScriptEngine={
      type = "method",
      args="()",
      returns = "CScriptEngineCommon*",
      valuetype = "CScriptEngineCommon"
    },
    update={
      type = "method",
      args="(int: diff)",
      returns = "void",
      valuetype = "void"
    },
    doStopSave={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getService={
      type = "method",
      args="()",
      returns = "GxService*",
      valuetype = "GxService"
    },
    setScriptEngine={
      type = "method",
      args="(CScriptEngineCommon*: val)",
      returns = "void",
      valuetype = "void"
    },
    setStopSaveTime={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    initData={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    doStop={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    isSaveTime={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isStopTime={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getStopStartTime={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    onStop={
      type = "method",
      args="(int: lastStopTime,int: saveTime)",
      returns = "void",
      valuetype = "void"
    },
  },
},

CWorldServer = {
  type = "class",
  inherits = "GxService CGamePassTimerBase CManualSingleton<CWorldServer> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWorldServer",
      valuetype = "CWorldServer",
    },
    load={
      type = "method",
      args="(string: serverName)",
      returns = "bool",
      valuetype = "bool"
    },
    getGameDbHandler={
      type = "method",
      args="()",
      returns = "CWorldDbServerHandler*",
      valuetype = "CWorldDbServerHandler"
    },
    getOpenTime={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    getStopTimer={
      type = "method",
      args="()",
      returns = "CStopTimer*",
      valuetype = "CStopTimer"
    },
    initServer={
      type = "method",
      args="(ServerPwdInfo*: pwdInfo)",
      returns = "bool",
      valuetype = "bool"
    },
    getStartTime={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    getWorldServerID={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    getConfig={
      type = "method",
      args="()",
      returns = "CWorldServerConfig*",
      valuetype = "CWorldServerConfig"
    },
    getLoginDbHandler={
      type = "method",
      args="()",
      returns = "CWorldDbServerHandler*",
      valuetype = "CWorldDbServerHandler"
    },
    getServerListDbHandler={
      type = "method",
      args="()",
      returns = "CWorldDbServerHandler*",
      valuetype = "CWorldDbServerHandler"
    },
    initFromDb={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    clear={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getFirstStartTime={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    getServerStatus={
      type = "method",
      args="()",
      returns = "EServerStatus",
      valuetype = "EServerStatus"
    },
  },
},

CWorldChargingServerHandler = {
  type = "class",
  inherits = "CGameExtendSocketHandler<CWorldChargingServerHandler> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWorldChargingServerHandler",
      valuetype = "CWorldChargingServerHandler",
    },
    sendRechargeRet={
      type = "method",
      args="(BWRecharge*: packet,EGameRetCode: retCode)",
      returns = "void",
      valuetype = "void"
    },
    sendRegiste={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    Setup={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    Unsetup={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
  },
},

CWorldDbGameInitTask = {
  type = "class",
  inherits = "CDbWrapTask ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWorldDbGameInitTask",
      valuetype = "CWorldDbGameInitTask",
    },
  },
},

CWorldDbGameInitRetTask = {
  type = "class",
  inherits = "CDbConnTask ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWorldDbGameInitRetTask",
      valuetype = "CWorldDbGameInitRetTask",
    },
    doRun={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
  },
},

CWorldDbServerInitTask = {
  type = "class",
  inherits = "CDbWrapTask ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWorldDbServerInitTask",
      valuetype = "CWorldDbServerInitTask",
    },
  },
},

CWorldDbServerInitRetTask = {
  type = "class",
  inherits = "CDbConnTask ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWorldDbServerInitRetTask",
      valuetype = "CWorldDbServerInitRetTask",
    },
    doRun={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
  },
},

CWorldDbResponseTask = {
  type = "class",
  inherits = "CDbConnTask ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWorldDbResponseTask",
      valuetype = "CWorldDbResponseTask",
    },
    doRun={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
  },
},

CWorldDbRequestTask = {
  type = "class",
  inherits = "CDbWrapTask ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWorldDbRequestTask",
      valuetype = "CWorldDbRequestTask",
    },
  },
},

CWorldDbAccountVerifyRetTask = {
  type = "class",
  inherits = "CDbConnTask ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWorldDbAccountVerifyRetTask",
      valuetype = "CWorldDbAccountVerifyRetTask",
    },
    doRun={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
  },
},

CWorldDbAccountVerifyTask = {
  type = "class",
  inherits = "CDbWrapTask ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWorldDbAccountVerifyTask",
      valuetype = "CWorldDbAccountVerifyTask",
    },
  },
},

CWorldDbConnectVerifyRetTask = {
  type = "class",
  inherits = "CDbConnTask ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWorldDbConnectVerifyRetTask",
      valuetype = "CWorldDbConnectVerifyRetTask",
    },
    doRun={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
  },
},

CWorldDbConnectVerifyTask = {
  type = "class",
  inherits = "CDbWrapTask ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWorldDbConnectVerifyTask",
      valuetype = "CWorldDbConnectVerifyTask",
    },
  },
},

CWorldCreateRoleRetTask = {
  type = "class",
  inherits = "CWorldDbResponseTask ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWorldCreateRoleRetTask",
      valuetype = "CWorldCreateRoleRetTask",
    },
  },
},

CWorldDbRoleCreateTask = {
  type = "class",
  inherits = "CWorldDbRequestTask ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWorldDbRoleCreateTask",
      valuetype = "CWorldDbRoleCreateTask",
    },
  },
},

CWorldLoadUserDataTask = {
  type = "class",
  inherits = "CDbWrapTask ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWorldLoadUserDataTask",
      valuetype = "CWorldLoadUserDataTask",
    },
  },
},

CWorldLoadUserDataRetTask = {
  type = "class",
  inherits = "CDbConnTask ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWorldLoadUserDataRetTask",
      valuetype = "CWorldLoadUserDataRetTask",
    },
  },
},

CWorldDbHandler = {
  type = "class",
  inherits = "CGameDatabaseHandler ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWorldDbHandler",
      valuetype = "CWorldDbHandler",
    },
    quit={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    sendVerifyConnectTask={
      type = "method",
      args="(unsigned long long: loginKey,CCharArray2<300>: sourceWay,CCharArray2<300>: chiSourceWay,unsigned char: gmPower)",
      returns = "bool",
      valuetype = "bool"
    },
    handle={
      type = "method",
      args="(char*: msg,unsigned int: len)",
      returns = "EHandleRet",
      valuetype = "EHandleRet"
    },
    getAccountID={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    sendVerifyAccountTask={
      type = "method",
      args="(CCharArray2<300>: accountName,CCharArray2<300>: pass)",
      returns = "bool",
      valuetype = "bool"
    },
    sendCreateRoleTask={
      type = "method",
      args="(char*: name,unsigned char: typeID,CCharArray2<300>: sourceway,CCharArray2<300>: chisourceway)",
      returns = "bool",
      valuetype = "bool"
    },
    breath={
      type = "method",
      args="(int: diff)",
      returns = "void",
      valuetype = "void"
    },
    start={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    toString={
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
    freeWorldDbTask={
      type = "method",
      args="(CWorldDbRequestTask*: task)",
      returns = "void",
      valuetype = "void"
    },
    close={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    setAccountID={
      type = "method",
      args="(unsigned long long: accountID)",
      returns = "void",
      valuetype = "void"
    },
  },
},

CLoginPlayer = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CLoginPlayer",
      valuetype = "CLoginPlayer",
    },
    getAccountID={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    kickByOtherPlayer={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    keyToString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    setLoginQuick={
      type = "method",
      args="(bool: flag)",
      returns = "void",
      valuetype = "void"
    },
    getWorldPlayerHandler={
      type = "method",
      args="()",
      returns = "CWorldPlayerHandler*",
      valuetype = "CWorldPlayerHandler"
    },
    isKey2={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isTimeOut={
      type = "method",
      args="(unsigned int: curTime)",
      returns = "bool",
      valuetype = "bool"
    },
    getSourceWay={
      type = "method",
      args="()",
      returns = "CCharArray2<300>",
      valuetype = "CCharArray2<300>"
    },
    isDelete={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setAccountID={
      type = "method",
      args="(unsigned long long: accoutID)",
      returns = "void",
      valuetype = "void"
    },
    quit={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    setNeedReLogin={
      type = "method",
      args="(bool: flag)",
      returns = "void",
      valuetype = "void"
    },
    doLoginOutTime={
      type = "method",
      args="(unsigned int: curTime)",
      returns = "void",
      valuetype = "void"
    },
    setDbIndex={
      type = "method",
      args="(unsigned long long: dbIndex)",
      returns = "void",
      valuetype = "void"
    },
    setChisourceWay={
      type = "method",
      args="(CCharArray2<300>: val)",
      returns = "void",
      valuetype = "void"
    },
    doReLogin={
      type = "method",
      args="(unsigned int: currTime)",
      returns = "void",
      valuetype = "void"
    },
    setKey={
      type = "method",
      args="(unsigned long long: key)",
      returns = "void",
      valuetype = "void"
    },
    toString={
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
    setSocketIndex={
      type = "method",
      args="(unsigned long long: index)",
      returns = "void",
      valuetype = "void"
    },
    isNeedDelete={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setLoginKey={
      type = "method",
      args="(unsigned long long: loginKey)",
      returns = "void",
      valuetype = "void"
    },
    update={
      type = "method",
      args="(int: diff)",
      returns = "void",
      valuetype = "void"
    },
    getKey2={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    getSocketIndex={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    setDelete={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getLoginQuick={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getWorldDbHandler={
      type = "method",
      args="()",
      returns = "CWorldDbHandler*",
      valuetype = "CWorldDbHandler"
    },
    getDbIndex={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    getWorldPlayer={
      type = "method",
      args="(bool: logFlag)",
      returns = "CWorldPlayer*",
      valuetype = "CWorldPlayer"
    },
    key2ToString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    isKey={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setKey2={
      type = "method",
      args="(unsigned long long: key)",
      returns = "void",
      valuetype = "void"
    },
    getChisourceWay={
      type = "method",
      args="()",
      returns = "CCharArray2<300>",
      valuetype = "CCharArray2<300>"
    },
    getKey={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    setGmPower={
      type = "method",
      args="(unsigned char: val)",
      returns = "void",
      valuetype = "void"
    },
    otherPlayerOffline={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getGmPower={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
  },
},

CLoginPlayerMgr = {
  type = "class",
  inherits = "CHashMultiIndex2<CLoginPlayer, false, 18446744073709551615, 18446744073709551615> CManualSingleton<CLoginPlayerMgr> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CLoginPlayerMgr",
      valuetype = "CLoginPlayerMgr",
    },
    getNext={
      type = "method",
      args="()",
      returns = "CLoginPlayer*",
      valuetype = "CLoginPlayer"
    },
    getBegin={
      type = "method",
      args="()",
      returns = "CLoginPlayer*",
      valuetype = "CLoginPlayer"
    },
    isExistByAccountID={
      type = "method",
      args="(unsigned long long: id)",
      returns = "bool",
      valuetype = "bool"
    },
    delPlayerByAccountID={
      type = "method",
      args="(unsigned long long: id)",
      returns = "void",
      valuetype = "void"
    },
    isExistBySocketIndex={
      type = "method",
      args="(unsigned long long: index)",
      returns = "bool",
      valuetype = "bool"
    },
    update={
      type = "method",
      args="(int: diff)",
      returns = "void",
      valuetype = "void"
    },
    freePlayer={
      type = "method",
      args="(CLoginPlayer*: val)",
      returns = "void",
      valuetype = "void"
    },
    init={
      type = "method",
      args="(unsigned int: num)",
      returns = "bool",
      valuetype = "bool"
    },
    delPlayerBySocketIndex={
      type = "method",
      args="(unsigned long long: index)",
      returns = "void",
      valuetype = "void"
    },
    findByAccountID={
      type = "method",
      args="(unsigned long long: id)",
      returns = "CLoginPlayer*",
      valuetype = "CLoginPlayer"
    },
    findBySocketIndex={
      type = "method",
      args="(unsigned long long: index)",
      returns = "CLoginPlayer*",
      valuetype = "CLoginPlayer"
    },
    GetPtr={
      type = "method",
      args="()",
      returns = "CLoginPlayerMgr*",
      valuetype = "CLoginPlayerMgr"
    },
  },
},

CWorldLoginServerHandler = {
  type = "class",
  inherits = "CGameSocketHandler<CWorldLoginServerHandler> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWorldLoginServerHandler",
      valuetype = "CWorldLoginServerHandler",
    },
    sendRoleLimit={
      type = "method",
      args="(unsigned long long: accountID,unsigned long long: roleUID,unsigned short: serverID)",
      returns = "void",
      valuetype = "void"
    },
    sendUpdateData={
      type = "method",
      args="(int: roleNum)",
      returns = "void",
      valuetype = "void"
    },
    sendRegiste={
      type = "method",
      args="(CWorldServerConfig*: pConfig)",
      returns = "void",
      valuetype = "void"
    },
    sendRoleCreate={
      type = "method",
      args="(unsigned long long: loginKey)",
      returns = "void",
      valuetype = "void"
    },
    sendRoleLogin={
      type = "method",
      args="(unsigned long long: loginKey,unsigned long long: accountID,unsigned long long: roleUID,string: roleName,unsigned short: serverID,string: clientIP)",
      returns = "void",
      valuetype = "void"
    },
    Setup={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    UnSetup={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
  },
},

CWorldLoginServer = {
  type = "class",
  inherits = "IArrayEnable<CWorldLoginServer> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWorldLoginServer",
      valuetype = "CWorldLoginServer",
    },
    getServerHandler={
      type = "method",
      args="()",
      returns = "CWorldLoginServerHandler*",
      valuetype = "CWorldLoginServerHandler"
    },
  },
},

CWorldLoginServerManager = {
  type = "class",
  inherits = "CSingleton<CWorldLoginServerManager> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWorldLoginServerManager",
      valuetype = "CWorldLoginServerManager",
    },
    findByServerID={
      type = "method",
      args="(unsigned short: serverID)",
      returns = "CWorldLoginServer*",
      valuetype = "CWorldLoginServer"
    },
    getRandServer={
      type = "method",
      args="()",
      returns = "CWorldLoginServer*",
      valuetype = "CWorldLoginServer"
    },
    deleteByServerID={
      type = "method",
      args="(unsigned short: serverID)",
      returns = "void",
      valuetype = "void"
    },
    isExistByServerID={
      type = "method",
      args="(unsigned short: serverID)",
      returns = "bool",
      valuetype = "bool"
    },
    addServer={
      type = "method",
      args="(LoginServerData*: serverData,unsigned long long: socketIndex)",
      returns = "void",
      valuetype = "void"
    },
    deleteBySocketIndex={
      type = "method",
      args="(unsigned long long: socketIndex)",
      returns = "void",
      valuetype = "void"
    },
    size={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
  },
},

CWorldMapServerHandlerBase = {
  type = "class",
  inherits = "CGameSocketHandler<CWorldMapServerHandlerBase> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWorldMapServerHandlerBase",
      valuetype = "CWorldMapServerHandlerBase",
    },
    genStrName={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    quit={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getServerID={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    toString={
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
    setServerID={
      type = "method",
      args="(unsigned short: serverID)",
      returns = "void",
      valuetype = "void"
    },
    getWorldMapPlayer={
      type = "method",
      args="()",
      returns = "CWorldMapPlayer*",
      valuetype = "CWorldMapPlayer"
    },
  },
},

CWorldMapServerHandler = {
  type = "class",
  inherits = "CWorldMapServerHandlerBase ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWorldMapServerHandler",
      valuetype = "CWorldMapServerHandler",
    },
    Setup={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    Unsetup={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
  },
},

CWorldMapPlayer = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWorldMapPlayer",
      valuetype = "CWorldMapPlayer",
    },
    keyToString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    setClientListenPort={
      type = "method",
      args="(unsigned short: port)",
      returns = "void",
      valuetype = "void"
    },
    isNormalServer={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getServerType={
      type = "method",
      args="()",
      returns = "EServerType",
      valuetype = "EServerType"
    },
    canEnter={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getClientListenIP={
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
    setRoleSceneID={
      type = "method",
      args="(unsigned long long: roleUID,unsigned long long: sceneID)",
      returns = "void",
      valuetype = "void"
    },
    getServerID={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    send={
      type = "method",
      args="(char*: buf,unsigned int: len)",
      returns = "void",
      valuetype = "void"
    },
    setKey={
      type = "method",
      args="(unsigned short: key)",
      returns = "void",
      valuetype = "void"
    },
    setServerID={
      type = "method",
      args="(unsigned short: serverID)",
      returns = "void",
      valuetype = "void"
    },
    setSocketIndex={
      type = "method",
      args="(unsigned long long: socketIndex)",
      returns = "void",
      valuetype = "void"
    },
    isHalfNum={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    sendUnloadRoleData={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isMaxNum={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getClientListenPort={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    setServerType={
      type = "method",
      args="(EServerType: serverType)",
      returns = "void",
      valuetype = "void"
    },
    getSocketIndex={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    setClientListenIP={
      type = "method",
      args="(string: ip)",
      returns = "void",
      valuetype = "void"
    },
    isDynamicServer={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isKey={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getMapServerHandler={
      type = "method",
      args="()",
      returns = "CWorldMapServerHandler*",
      valuetype = "CWorldMapServerHandler"
    },
    getKey={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    leave={
      type = "method",
      args="(CWorldPlayer*: player)",
      returns = "void",
      valuetype = "void"
    },
    updateData={
      type = "method",
      args="(MapServerUpdate*: data)",
      returns = "void",
      valuetype = "void"
    },
    getRoleSceneID={
      type = "method",
      args="(unsigned long long: roleUID)",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    getRoleNum={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    enter={
      type = "method",
      args="(CScene*: pScene,unsigned long long: sceneID,CWorldPlayer*: player)",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

CWorldMapPlayerMgr = {
  type = "class",
  inherits = "CHashMultiIndex<CWorldMapPlayer, false, 0> CManualSingleton<CWorldMapPlayerMgr> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWorldMapPlayerMgr",
      valuetype = "CWorldMapPlayerMgr",
    },
    getNext={
      type = "method",
      args="()",
      returns = "CWorldMapPlayer*",
      valuetype = "CWorldMapPlayer"
    },
    updateServerInfo={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getBegin={
      type = "method",
      args="()",
      returns = "CWorldMapPlayer*",
      valuetype = "CWorldMapPlayer"
    },
    delMapPlayer={
      type = "method",
      args="(unsigned short: serverID)",
      returns = "void",
      valuetype = "void"
    },
    getLeastNormalMapServer={
      type = "method",
      args="()",
      returns = "CWorldMapPlayer*",
      valuetype = "CWorldMapPlayer"
    },
    update={
      type = "method",
      args="(int: diff)",
      returns = "void",
      valuetype = "void"
    },
    getLeastDynamicServer={
      type = "method",
      args="()",
      returns = "CWorldMapPlayer*",
      valuetype = "CWorldMapPlayer"
    },
    init={
      type = "method",
      args="(unsigned int: num)",
      returns = "bool",
      valuetype = "bool"
    },
    findMapPlayer={
      type = "method",
      args="(unsigned short: serverID)",
      returns = "CWorldMapPlayer*",
      valuetype = "CWorldMapPlayer"
    },
    addMapPlayer={
      type = "method",
      args="(unsigned short: serverID)",
      returns = "CWorldMapPlayer*",
      valuetype = "CWorldMapPlayer"
    },
    GetPtr={
      type = "method",
      args="()",
      returns = "CWorldMapPlayerMgr*",
      valuetype = "CWorldMapPlayerMgr"
    },
  },
},

IPlayer = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "IPlayer",
      valuetype = "IPlayer",
    },
    onAddToLogout={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    onRemoveFromReady={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    onRemoveFromEnter={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    onAddToReady={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    onAddToEnter={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    onUpdateReadyQue={
      type = "method",
      args="(int: diff)",
      returns = "void",
      valuetype = "void"
    },
    onUpdateEnterQue={
      type = "method",
      args="(int: diff)",
      returns = "void",
      valuetype = "void"
    },
    onUpdateLogoutQue={
      type = "method",
      args="(int: diff)",
      returns = "void",
      valuetype = "void"
    },
    onRemoveFromLogout={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
  },
},

CWorldPlayerHandler = {
  type = "class",
  inherits = "CGameExtendSocketHandler<CWorldPlayerHandler> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWorldPlayerHandler",
      valuetype = "CWorldPlayerHandler",
    },
    quit={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getAccountID={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    getDbHandler={
      type = "method",
      args="()",
      returns = "CWorldDbHandler*",
      valuetype = "CWorldDbHandler"
    },
    getWorldPlayer={
      type = "method",
      args="()",
      returns = "CWorldPlayer*",
      valuetype = "CWorldPlayer"
    },
    onBeforeHandlePacket={
      type = "method",
      args="(CBasePacket*: packet)",
      returns = "bool",
      valuetype = "bool"
    },
    setDbIndex={
      type = "method",
      args="(unsigned long long: index)",
      returns = "void",
      valuetype = "void"
    },
    toString={
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
    setAccountID={
      type = "method",
      args="(unsigned long long: accountID)",
      returns = "void",
      valuetype = "void"
    },
    getDbIndex={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    Setup={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    Unsetup={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
  },
},

CTimeWaiter = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CTimeWaiter",
      valuetype = "CTimeWaiter",
    },
    setWaitTime={
      type = "method",
      args="(unsigned int: val)",
      returns = "void",
      valuetype = "void"
    },
    update={
      type = "method",
      args="(int: diff)",
      returns = "void",
      valuetype = "void"
    },
    isTimeout={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setStartTime={
      type = "method",
      args="(unsigned int: val)",
      returns = "void",
      valuetype = "void"
    },
    getWaitTime={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    cleanup={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getStartTime={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
  },
},

CLoginWaiter = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CLoginWaiter",
      valuetype = "CLoginWaiter",
    },
    setLoadType={
      type = "method",
      args="(ELoadRoleType: val)",
      returns = "void",
      valuetype = "void"
    },
    getSocketIndex={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    getLoadType={
      type = "method",
      args="()",
      returns = "ELoadRoleType",
      valuetype = "ELoadRoleType"
    },
    setSocketIndex={
      type = "method",
      args="(unsigned long long: val)",
      returns = "void",
      valuetype = "void"
    },
    cleanup={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
  },
},

CLogoutWaiter = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CLogoutWaiter",
      valuetype = "CLogoutWaiter",
    },
    setSocketIndex={
      type = "method",
      args="(unsigned long long: val)",
      returns = "void",
      valuetype = "void"
    },
    setUnloadType={
      type = "method",
      args="(EUnloadRoleType: val)",
      returns = "void",
      valuetype = "void"
    },
    getNeedRet={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getUnloadType={
      type = "method",
      args="()",
      returns = "EUnloadRoleType",
      valuetype = "EUnloadRoleType"
    },
    getSocketIndex={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    cleanup={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    setNeedRet={
      type = "method",
      args="(bool: val)",
      returns = "void",
      valuetype = "void"
    },
  },
},

CLoginWaiterManager = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CLoginWaiterManager",
      valuetype = "CLoginWaiterManager",
    },
    isLogin={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isLogout={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    onLogin={
      type = "method",
      args="(ELoadRoleType: loadType,unsigned long long: index)",
      returns = "void",
      valuetype = "void"
    },
    onLogout={
      type = "method",
      args="(EUnloadRoleType: unLoadType,unsigned long long: index)",
      returns = "void",
      valuetype = "void"
    },
  },
},

CWorldPlayer = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWorldPlayer",
      valuetype = "CWorldPlayer",
    },
    isDataNeedFreeStatus={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    onUpdateLogoutQue={
      type = "method",
      args="(int: diff)",
      returns = "void",
      valuetype = "void"
    },
    getSocketHandler={
      type = "method",
      args="(bool: logFlag)",
      returns = "CWorldPlayerHandler*",
      valuetype = "CWorldPlayerHandler"
    },
    setAccountID={
      type = "method",
      args="(unsigned long long: accountID)",
      returns = "void",
      valuetype = "void"
    },
    getChangeLineWait={
      type = "method",
      args="()",
      returns = "ChangeLineWait*",
      valuetype = "ChangeLineWait"
    },
    getLoginTime={
      type = "method",
      args="()",
      returns = "CGameTime",
      valuetype = "CGameTime"
    },
    onUpdateReadyQue={
      type = "method",
      args="(int: diff)",
      returns = "void",
      valuetype = "void"
    },
    isKey2={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    changeLineLoadRes={
      type = "method",
      args="(CWorldUserData*: data,unsigned short: mapServerID,unsigned short: mapID)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    changeLineLoadReq={
      type = "method",
      args="()",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    changeLineUnloadRes={
      type = "method",
      args="()",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    toString={
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
    changeLineUnloadReq={
      type = "method",
      args="()",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    setLoginManager={
      type = "method",
      args="(CLoginWaiterManager*: val)",
      returns = "void",
      valuetype = "void"
    },
    closeRecharge={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    setLoginKey={
      type = "method",
      args="(unsigned long long: loginKey)",
      returns = "void",
      valuetype = "void"
    },
    getCurrentUser={
      type = "method",
      args="()",
      returns = "CWorldUser*",
      valuetype = "CWorldUser"
    },
    onAddToEnter={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    onUserLogin={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getDbIndex={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    isMaxRoleNum={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    createRoleReq={
      type = "method",
      args="(CCharArray2<50>: name,unsigned char: typeID)",
      returns = "void",
      valuetype = "void"
    },
    key2ToString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    isEnterGame={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    onRemoveFromEnter={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    onAddToReady={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getChisourceWay={
      type = "method",
      args="()",
      returns = "CCharArray2<300>",
      valuetype = "CCharArray2<300>"
    },
    setGmPower={
      type = "method",
      args="(unsigned char: val)",
      returns = "void",
      valuetype = "void"
    },
    getGmPower={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    setKey2={
      type = "method",
      args="(unsigned long long: key)",
      returns = "void",
      valuetype = "void"
    },
    onBeforeRequst={
      type = "method",
      args="(EWPlayerActionType: requstType)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    isLoadRoleDataStatus={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    quitGameRes={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    quitGameReq={
      type = "method",
      args="(unsigned long long: roleUID)",
      returns = "void",
      valuetype = "void"
    },
    setMapServerID={
      type = "method",
      args="(unsigned short: mapServerID)",
      returns = "void",
      valuetype = "void"
    },
    quitByDbClose={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    createRoleFailed={
      type = "method",
      args="(_LoginRole*: role)",
      returns = "void",
      valuetype = "void"
    },
    loadRoleDataSuccess={
      type = "method",
      args="(CWorldUserData*: data,unsigned short: mapServerID,unsigned short: mapID)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    setDbIndex={
      type = "method",
      args="(unsigned long long: index)",
      returns = "void",
      valuetype = "void"
    },
    loginSuccess={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    isAccountVerifyStatus={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    onRoleHeart={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    isVerifyPass={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isLoginGame={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getKey2={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    isIdle={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isPlaying={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    onRemoveFromReady={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getCurrentRoleUID={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    getLoginManager={
      type = "method",
      args="()",
      returns = "CLoginWaiterManager*",
      valuetype = "CLoginWaiterManager"
    },
    loadRoleDataFailed={
      type = "method",
      args="(LoadRoleData*: loadData,EGameRetCode: retCode)",
      returns = "bool",
      valuetype = "bool"
    },
    cleanRole={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    checkRequest={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    onBerforeLoadRoleData={
      type = "method",
      args="(unsigned int: objUID,unsigned long long: sceneID,unsigned short: mapID)",
      returns = "void",
      valuetype = "void"
    },
    getAccountID={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    onAddToLogout={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    keyToString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    getSourceWay={
      type = "method",
      args="()",
      returns = "CCharArray2<300>",
      valuetype = "CCharArray2<300>"
    },
    unloadRoleDataFailed={
      type = "method",
      args="(unsigned long long: roleUID)",
      returns = "void",
      valuetype = "void"
    },
    quit={
      type = "method",
      args="(bool: isForce,char*: quitReason)",
      returns = "void",
      valuetype = "void"
    },
    hasRole={
      type = "method",
      args="(unsigned long long: roleUID)",
      returns = "bool",
      valuetype = "bool"
    },
    transLimitInfo={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    unloadRoleDataReq={
      type = "method",
      args="(EUnloadRoleType: unloadType,bool: flag)",
      returns = "bool",
      valuetype = "bool"
    },
    doLoginVerify={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    createRoleSuccess={
      type = "method",
      args="(unsigned short: retCode,_LoginRole*: role)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    onUpdateEnterQue={
      type = "method",
      args="(int: diff)",
      returns = "void",
      valuetype = "void"
    },
    getLoginKey={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    getMapServerID={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    getSocketIndex={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    addRole={
      type = "method",
      args="(_LoginRole*: role)",
      returns = "void",
      valuetype = "void"
    },
    isRechargeStatus={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    heartOutTime={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    onBeforeResponse={
      type = "method",
      args="(EWPlayerActionType: requstType)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    isKey={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    loginQuitReq={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    changeLineRes={
      type = "method",
      args="(unsigned short: mapServerID,unsigned short: mapID)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    changeLineReq={
      type = "method",
      args="(unsigned long long: sceneID,AxisPos: pos,unsigned short: mapServerID,unsigned long long: lastSceneID,AxisPos: lastPos,unsigned short: lastMapServerID,ChangeLineTempData*: tempData)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    getCurrentObjUID={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    getQueType={
      type = "method",
      args="()",
      returns = "EManagerQueType",
      valuetype = "EManagerQueType"
    },
    kickByOtherPlayer={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setChangeLine={
      type = "method",
      args="(unsigned short: mapServerID,unsigned long long: sceneID,AxisPos: pos)",
      returns = "void",
      valuetype = "void"
    },
    setPlayerStatus={
      type = "method",
      args="(EPlayerStatus: status)",
      returns = "void",
      valuetype = "void"
    },
    getKey={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    onBeforeLogin={
      type = "method",
      args="(unsigned short: mapID)",
      returns = "void",
      valuetype = "void"
    },
    getCWorldLoginRoleList={
      type = "method",
      args="()",
      returns = "CWorldLoginRoleList*",
      valuetype = "CWorldLoginRoleList"
    },
    isChangeLineStatus={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    unloadRoleDataAll={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setChisourceWay={
      type = "method",
      args="(CCharArray2<300>: val)",
      returns = "void",
      valuetype = "void"
    },
    setKey={
      type = "method",
      args="(unsigned long long: key)",
      returns = "void",
      valuetype = "void"
    },
    setSocketIndex={
      type = "method",
      args="(unsigned long long: socketIndex)",
      returns = "void",
      valuetype = "void"
    },
    startRecharge={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    quitBySocketClose={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    isLoadRoleDataReq={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    loginGameRes={
      type = "method",
      args="(CWorldUserData*: data,unsigned short: mapServerID)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    loginGameReq={
      type = "method",
      args="(unsigned long long: roleUID,bool: enterDynamicMapFlag)",
      returns = "void",
      valuetype = "void"
    },
    update={
      type = "method",
      args="(int: diff)",
      returns = "void",
      valuetype = "void"
    },
    getPlayerStatus={
      type = "method",
      args="()",
      returns = "EPlayerStatus",
      valuetype = "EPlayerStatus"
    },
    onAfterLogin={
      type = "method",
      args="(unsigned short: mapServerID)",
      returns = "void",
      valuetype = "void"
    },
    setLoginTime={
      type = "method",
      args="(CGameTime: val)",
      returns = "void",
      valuetype = "void"
    },
    getFirstRoleUID={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    onRemoveFromLogout={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    unloadRoleDataSuccess={
      type = "method",
      args="(unsigned long long: roleUID)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    getDbHandler={
      type = "method",
      args="(bool: logFlag)",
      returns = "CWorldDbHandler*",
      valuetype = "CWorldDbHandler"
    },
    quitByMapServerClose={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getRoleNum={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    isRequstStatus={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isDataHasFreedStatus={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

CWorldPlayerMgr = {
  type = "class",
  inherits = "CGamePlayerMgr2Pool<CWorldPlayer> CManualSingleton<CWorldPlayerMgr> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWorldPlayerMgr",
      valuetype = "CWorldPlayerMgr",
    },
    genRoleName={
      type = "method",
      args="()",
      returns = "CCharArray2<50>",
      valuetype = "CCharArray2<50>"
    },
    genRoleUID={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    findInEnterByAccountID={
      type = "method",
      args="(unsigned long long: _key,bool: logFlag)",
      returns = "CWorldPlayer*",
      valuetype = "CWorldPlayer"
    },
    setGenRoleUID={
      type = "method",
      args="(unsigned long long: roleUID,unsigned int: objUID,unsigned int: maxNameID)",
      returns = "void",
      valuetype = "void"
    },
    findInReadyBySocketIndex={
      type = "method",
      args="(unsigned long long: _key,bool: logFlag)",
      returns = "CWorldPlayer*",
      valuetype = "CWorldPlayer"
    },
    genTempRoleUID={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    findInQueTypeBySocketIndex={
      type = "method",
      args="(EManagerQueType: tp,unsigned long long: _key,bool: logFlag)",
      returns = "CWorldPlayer*",
      valuetype = "CWorldPlayer"
    },
    findInQueTypeByAccountID={
      type = "method",
      args="(EManagerQueType: tp,unsigned long long: _key,bool: logFlag)",
      returns = "CWorldPlayer*",
      valuetype = "CWorldPlayer"
    },
    findByAccountID={
      type = "method",
      args="(unsigned long long: _key,bool: logFlag)",
      returns = "CWorldPlayer*",
      valuetype = "CWorldPlayer"
    },
    update={
      type = "method",
      args="(int: diff)",
      returns = "void",
      valuetype = "void"
    },
    findInEnterBySocketIndex={
      type = "method",
      args="(unsigned long long: _key,bool: logFlag)",
      returns = "CWorldPlayer*",
      valuetype = "CWorldPlayer"
    },
    kickPlayerByAccountID={
      type = "method",
      args="(unsigned long long: accountID)",
      returns = "void",
      valuetype = "void"
    },
    findInLogoutByAccountID={
      type = "method",
      args="(unsigned long long: _key,bool: logFlag)",
      returns = "CWorldPlayer*",
      valuetype = "CWorldPlayer"
    },
    findBySocketIndex={
      type = "method",
      args="(unsigned long long: _key,bool: logFlag)",
      returns = "CWorldPlayer*",
      valuetype = "CWorldPlayer"
    },
    findInReadyByAccountID={
      type = "method",
      args="(unsigned long long: _key,bool: logFlag)",
      returns = "CWorldPlayer*",
      valuetype = "CWorldPlayer"
    },
    getTempRoleUID={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    closeByMapServer={
      type = "method",
      args="(unsigned short: mapServerID)",
      returns = "void",
      valuetype = "void"
    },
    findInLogoutBySocketIndex={
      type = "method",
      args="(unsigned long long: _key,bool: logFlag)",
      returns = "CWorldPlayer*",
      valuetype = "CWorldPlayer"
    },
    GetPtr={
      type = "method",
      args="()",
      returns = "CWorldPlayerMgr*",
      valuetype = "CWorldPlayerMgr"
    },
  },
},

CSqlConnectionManagerBase = {
  type = "class",
  inherits = "CDbConnectionManager<CSqlConnectionManagerBase> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CSqlConnectionManagerBase",
      valuetype = "CSqlConnectionManagerBase",
    },
    getRoleUIDByAccountID={
      type = "method",
      args="(unsigned long long: accountID)",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    loadUserData={
      type = "method",
      args="(UserDbData*: data)",
      returns = "bool",
      valuetype = "bool"
    },
    addAwardBindRmb={
      type = "method",
      args="(int: rmb,int: gameMoney)",
      returns = "bool",
      valuetype = "bool"
    },
    updateUserData={
      type = "method",
      args="(unsigned long long: roleUID,UserDbData*: newData)",
      returns = "bool",
      valuetype = "bool"
    },
    addRoleAwardBindRmb={
      type = "method",
      args="(unsigned long long: roleUID,unsigned long long: accountID,int: rmb,int: gameMoney)",
      returns = "bool",
      valuetype = "bool"
    },
    loadAllUser={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getLastLoginRoleUIDByAccountID={
      type = "method",
      args="(unsigned long long: accountID)",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    addAwardItem={
      type = "method",
      args="(unsigned long long: roleUID,unsigned short: itemID,short: num)",
      returns = "bool",
      valuetype = "bool"
    },
    changeRoleObjUID={
      type = "method",
      args="(unsigned long long: roleUID,unsigned int: objUID)",
      returns = "bool",
      valuetype = "bool"
    },
    addAccountRmb={
      type = "method",
      args="(unsigned long long: accountID,int: rmb,int: bindRmb)",
      returns = "bool",
      valuetype = "bool"
    },
    deleteUserData={
      type = "method",
      args="(unsigned long long: roleUID)",
      returns = "bool",
      valuetype = "bool"
    },
    loadAllUserRoleUID={
      type = "method",
      args="(vector<unsigned long long, allocator<unsigned long long> >: data)",
      returns = "bool",
      valuetype = "bool"
    },
    addUserData={
      type = "method",
      args="(UserDbData*: data)",
      returns = "bool",
      valuetype = "bool"
    },
    delRole={
      type = "method",
      args="(unsigned long long: roleUID,char*: roleStr)",
      returns = "bool",
      valuetype = "bool"
    },
    getRoleNameByRoleId={
      type = "method",
      args="(unsigned long long: roleUID)",
      returns = "CCharArray2<50>",
      valuetype = "CCharArray2<50>"
    },
    addTempRechargeRecord={
      type = "method",
      args="(CCharArray2<50>: serialNo,unsigned long long: accountID,int: rmb,int: bindRmb)",
      returns = "bool",
      valuetype = "bool"
    },
    getRoleLevelByRoleId={
      type = "method",
      args="(unsigned long long: roleUID)",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    delTempRechargeRecord={
      type = "method",
      args="(CCharArray2<50>: serialNo)",
      returns = "bool",
      valuetype = "bool"
    },
    updateTempRechargeRecord={
      type = "method",
      args="(CCharArray2<50>: serialNo,char: status)",
      returns = "bool",
      valuetype = "bool"
    },
    accountRmbQuery={
      type = "method",
      args="(unsigned long long: accountID,int: rmb,int: bindRmb)",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

CSqlConnectionManager = {
  type = "class",
  inherits = "CSqlConnectionManagerBase ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CSqlConnectionManager",
      valuetype = "CSqlConnectionManager",
    },
  },
},

CWorldUser = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWorldUser",
      valuetype = "CWorldUser",
    },
    setObjUID={
      type = "method",
      args="(unsigned int: objUID)",
      returns = "void",
      valuetype = "void"
    },
    getAccountID={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    keyToString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    isKey2={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getMapPlayer={
      type = "method",
      args="()",
      returns = "CWorldMapPlayer*",
      valuetype = "CWorldMapPlayer"
    },
    getRoleUpdateData={
      type = "method",
      args="()",
      returns = "M2WRoleDataUpdate*",
      valuetype = "M2WRoleDataUpdate"
    },
    setAccountID={
      type = "method",
      args="(unsigned long long: accountID)",
      returns = "void",
      valuetype = "void"
    },
    setCloseServerTime={
      type = "method",
      args="(unsigned int: closeTime)",
      returns = "void",
      valuetype = "void"
    },
    setMapServerID={
      type = "method",
      args="(unsigned short: serverID)",
      returns = "void",
      valuetype = "void"
    },
    onBeforeChangeLine={
      type = "method",
      args="(ChangeLineTempData*: tempData,ESceneType: sceneType,unsigned short: mapID)",
      returns = "void",
      valuetype = "void"
    },
    key3ToString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    getName={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    getLevel={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    getRoleUID={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    isKey3={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setKey={
      type = "method",
      args="(unsigned int: key)",
      returns = "void",
      valuetype = "void"
    },
    toString={
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
    isKey4={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setJob={
      type = "method",
      args="(unsigned char: job)",
      returns = "void",
      valuetype = "void"
    },
    setRoleUpdateData={
      type = "method",
      args="(M2WRoleDataUpdate*: roleData)",
      returns = "void",
      valuetype = "void"
    },
    setRoleUID={
      type = "method",
      args="(unsigned long long: roleUID)",
      returns = "void",
      valuetype = "void"
    },
    updateUserData={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    setName={
      type = "method",
      args="(string: name)",
      returns = "void",
      valuetype = "void"
    },
    getKey4={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    setLevel={
      type = "method",
      args="(unsigned char: lev)",
      returns = "void",
      valuetype = "void"
    },
    online={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    update={
      type = "method",
      args="(int: diff)",
      returns = "void",
      valuetype = "void"
    },
    getMapServerID={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    getKey3={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    getObjUID={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    getJob={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    getKey2={
      type = "method",
      args="()",
      returns = "CCharArray2<50>",
      valuetype = "CCharArray2<50>"
    },
    offLine={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    onAfterChangeLine={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getWorldPlayer={
      type = "method",
      args="(bool: flag)",
      returns = "CWorldPlayer*",
      valuetype = "CWorldPlayer"
    },
    setUserData={
      type = "method",
      args="(CWorldUserData*: data)",
      returns = "void",
      valuetype = "void"
    },
    key2ToString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    isKey={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setSex={
      type = "method",
      args="(unsigned char: sex)",
      returns = "void",
      valuetype = "void"
    },
    setKey3={
      type = "method",
      args="(unsigned long long: key)",
      returns = "void",
      valuetype = "void"
    },
    setKey4={
      type = "method",
      args="(unsigned long long: key)",
      returns = "void",
      valuetype = "void"
    },
    getSex={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    getKey={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    getIsLoadingDataFromDB={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    loadDataFromDB={
      type = "method",
      args="(UserDbData*: userData)",
      returns = "void",
      valuetype = "void"
    },
    onUserPassDay={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    setKey2={
      type = "method",
      args="(CCharArray2<50>: key)",
      returns = "void",
      valuetype = "void"
    },
    key4ToString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
  },
},

CWorldUserMgr = {
  type = "class",
  inherits = "CHashMultiIndex4<CWorldUser, false, 4294967295, '0', 0, 18446744073709551615> CManualSingleton<CWorldUserMgr> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CWorldUserMgr",
      valuetype = "CWorldUserMgr",
    },
    getNext={
      type = "method",
      args="()",
      returns = "CWorldUser*",
      valuetype = "CWorldUser"
    },
    delUserByRoleUID={
      type = "method",
      args="(unsigned long long: roleUID)",
      returns = "void",
      valuetype = "void"
    },
    getBegin={
      type = "method",
      args="()",
      returns = "CWorldUser*",
      valuetype = "CWorldUser"
    },
    isExistByAccountID={
      type = "method",
      args="(unsigned long long: accountID)",
      returns = "bool",
      valuetype = "bool"
    },
    addUser={
      type = "method",
      args="(unsigned int: objUID,unsigned short: mapServerID,CWorldUserData*: data)",
      returns = "CWorldUser*",
      valuetype = "CWorldUser"
    },
    findUserByAccountID={
      type = "method",
      args="(unsigned long long: accountID)",
      returns = "CWorldUser*",
      valuetype = "CWorldUser"
    },
    delUserByObjUID={
      type = "method",
      args="(unsigned int: objUID)",
      returns = "void",
      valuetype = "void"
    },
    isExistByRoleUID={
      type = "method",
      args="(unsigned long long: roleUID)",
      returns = "bool",
      valuetype = "bool"
    },
    update={
      type = "method",
      args="(int: diff)",
      returns = "void",
      valuetype = "void"
    },
    isExistByRoleName={
      type = "method",
      args="(CCharArray2<50>: roleName)",
      returns = "bool",
      valuetype = "bool"
    },
    delUser={
      type = "method",
      args="(unsigned int: objUID,unsigned long long: roleUID,CCharArray2<50>: name,unsigned long long: accountID)",
      returns = "void",
      valuetype = "void"
    },
    init={
      type = "method",
      args="(unsigned int: num)",
      returns = "bool",
      valuetype = "bool"
    },
    delUserByAccountID={
      type = "method",
      args="(unsigned long long: accountID)",
      returns = "void",
      valuetype = "void"
    },
    findUserByRoleName={
      type = "method",
      args="(CCharArray2<50>: name)",
      returns = "CWorldUser*",
      valuetype = "CWorldUser"
    },
    delUserByRoleName={
      type = "method",
      args="(CCharArray2<50>: name)",
      returns = "void",
      valuetype = "void"
    },
    findUserByObjUID={
      type = "method",
      args="(unsigned int: objUID)",
      returns = "CWorldUser*",
      valuetype = "CWorldUser"
    },
    findUserByRoleUID={
      type = "method",
      args="(unsigned long long: roleUID)",
      returns = "CWorldUser*",
      valuetype = "CWorldUser"
    },
    isExistByObjUID={
      type = "method",
      args="(unsigned int: objUID)",
      returns = "bool",
      valuetype = "bool"
    },
    renameRoleName={
      type = "method",
      args="(unsigned long long: roleUID,string: name)",
      returns = "bool",
      valuetype = "bool"
    },
    size={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    GetPtr={
      type = "method",
      args="()",
      returns = "CWorldUserMgr*",
      valuetype = "CWorldUserMgr"
    },
  },
},

}
end