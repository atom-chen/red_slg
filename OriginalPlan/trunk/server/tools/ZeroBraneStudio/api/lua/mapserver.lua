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
  inherits = "CResponsePacket ",
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

CAnnouncement = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CAnnouncement",
      valuetype = "CAnnouncement",
    },
    GetNumber={
      type = "method",
      args="(int: val)",
      returns = "string",
      valuetype = "string"
    },
    GetItemName={
      type = "method",
      args="(unsigned short: itemID)",
      returns = "string",
      valuetype = "string"
    },
    BroadSystem={
      type = "method",
      args="(unsigned short: id,string: msg)",
      returns = "void",
      valuetype = "void"
    },
    GetRoleName={
      type = "method",
      args="(CRole*: pRole)",
      returns = "string",
      valuetype = "string"
    },
  },
},

_PackBuffer = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "_PackBuffer",
      valuetype = "_PackBuffer",
    },
  },
},

_PackSimpleBuff = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "_PackSimpleBuff",
      valuetype = "_PackSimpleBuff",
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
  inherits = "IStreamableAll ",
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
  inherits = "IStreamableAll ",
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

CAnnouncementTbl = {
  type = "class",
  inherits = "CConfigTbl ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CAnnouncementTbl",
      valuetype = "CAnnouncementTbl",
    },
    isPassCond={
      type = "method",
      args="(int: cond)",
      returns = "bool",
      valuetype = "bool"
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
    getKey={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    setKey={
      type = "method",
      args="(unsigned short: key)",
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

CAnnouncementTblLoader = {
  type = "class",
  inherits = "CConfigLoader<CAnnouncementTblLoader, CAnnouncementTbl> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CAnnouncementTblLoader",
      valuetype = "CAnnouncementTblLoader",
    },
    getPassCondID={
      type = "method",
      args="(int: type,int: cond,char: systype)",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    findByKey={
      type = "method",
      args="(unsigned short: key)",
      returns = "CAnnouncementTbl*",
      valuetype = "CAnnouncementTbl"
    },
    readRow={
      type = "method",
      args="(TiXmlElement*: row,int: count,CAnnouncementTbl*: destRow)",
      returns = "bool",
      valuetype = "bool"
    },
    GetPtr={
      type = "method",
      args="()",
      returns = "CAnnouncementTblLoader*",
      valuetype = "CAnnouncementTblLoader"
    },
  },
},

CItemConfigTbl = {
  type = "class",
  inherits = "CConfigTbl ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CItemConfigTbl",
      valuetype = "CItemConfigTbl",
    },
    canSell={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isSexUnlimit={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getSellPrice={
      type = "method",
      args="(char: itemStre)",
      returns = "int",
      valuetype = "int"
    },
    isKey={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isTimeUnlimit={
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
    getKey={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    isTask={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isBind={
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
    getIsNeedRecorde={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isJobUnlimit={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    canDrop={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setKey={
      type = "method",
      args="(unsigned short: key)",
      returns = "void",
      valuetype = "void"
    },
    getBuyBackPrice={
      type = "method",
      args="(char: itemStre)",
      returns = "int",
      valuetype = "int"
    },
  },
},

CItemTblLoader = {
  type = "class",
  inherits = "CConfigLoader<CItemTblLoader, CItemConfigTbl> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CItemTblLoader",
      valuetype = "CItemTblLoader",
    },
    getConfigByQuality={
      type = "method",
      args="(EItemType: type,unsigned char: subType,unsigned char: quality)",
      returns = "CItemConfigTbl*",
      valuetype = "CItemConfigTbl"
    },
    getConfig={
      type = "method",
      args="(EItemType: type,unsigned char: subType)",
      returns = "CItemConfigTbl*",
      valuetype = "CItemConfigTbl"
    },
    findByKey={
      type = "method",
      args="(unsigned short: key)",
      returns = "CItemConfigTbl*",
      valuetype = "CItemConfigTbl"
    },
    readRow={
      type = "method",
      args="(TiXmlElement*: row,int: count,CItemConfigTbl*: destRow)",
      returns = "bool",
      valuetype = "bool"
    },
    GetPtr={
      type = "method",
      args="()",
      returns = "CItemTblLoader*",
      valuetype = "CItemTblLoader"
    },
  },
},

CMsgBase = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMsgBase",
      valuetype = "CMsgBase",
    },
    setRole={
      type = "method",
      args="(CRole*: pRole)",
      returns = "void",
      valuetype = "void"
    },
    getRole={
      type = "method",
      args="()",
      returns = "CRole*",
      valuetype = "CRole"
    },
    handleCallBack={
      type = "method",
      args="(EGameRetCode: retcode,CRole*: prole)",
      returns = "void",
      valuetype = "void"
    },
  },
},

CGameMoudle = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CGameMoudle",
      valuetype = "CGameMoudle",
    },
    onLoad={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    onSave={
      type = "method",
      args="(bool: offLineFlag)",
      returns = "void",
      valuetype = "void"
    },
    update={
      type = "method",
      args="(int: diff)",
      returns = "void",
      valuetype = "void"
    },
    init={
      type = "method",
      args="(CCharacterObject*: chart)",
      returns = "bool",
      valuetype = "bool"
    },
    getRole={
      type = "method",
      args="()",
      returns = "CRole*",
      valuetype = "CRole"
    },
  },
},

CGameRoleModule = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CGameRoleModule",
      valuetype = "CGameRoleModule",
    },
    onLoad={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    onSendData={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    onSave={
      type = "method",
      args="(bool: offLineFlag)",
      returns = "void",
      valuetype = "void"
    },
    update={
      type = "method",
      args="(int: diff)",
      returns = "void",
      valuetype = "void"
    },
    init={
      type = "method",
      args="(CRole*: role)",
      returns = "bool",
      valuetype = "bool"
    },
    getRole={
      type = "method",
      args="()",
      returns = "CRole*",
      valuetype = "CRole"
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
    getBasePack={
      type = "method",
      args="(int: index)",
      returns = "CBasePacket*",
      valuetype = "CBasePacket"
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

RoleDetail = {
  type = "class",
  inherits = "IStreamableAll ",
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
  inherits = "CServerPacket IStreamableStaticAll<MCEnterView> ",
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    Unpacket={
      type = "method",
      args="(MCEnterView*: pBase,char*: buff,int: len)",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

MCLeaveView = {
  type = "class",
  inherits = "CServerPacket IStreamableStaticAll<MCLeaveView> ",
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    Unpacket={
      type = "method",
      args="(MCLeaveView*: pBase,char*: buff,int: len)",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

MCSceneData = {
  type = "class",
  inherits = "CServerPacket IStreamableStaticAll<MCSceneData> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCSceneData",
      valuetype = "MCSceneData",
    },
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    Unpacket={
      type = "method",
      args="(MCSceneData*: pBase,char*: buff,int: len)",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

CMMove = {
  type = "class",
  inherits = "CRequestPacket IStreamableStaticAll<CMMove> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMMove",
      valuetype = "CMMove",
    },
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    Unpacket={
      type = "method",
      args="(CMMove*: pBase,char*: buff,int: len)",
      returns = "bool",
      valuetype = "bool"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
  },
},

MCMoveBroad = {
  type = "class",
  inherits = "CServerPacket IStreamableStaticAll<CMMove> ",
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    Unpacket={
      type = "method",
      args="(CMMove*: pBase,char*: buff,int: len)",
      returns = "bool",
      valuetype = "bool"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
  },
},

MCEnterSceneRet = {
  type = "class",
  inherits = "CResponsePacket IStreamableStaticAll<MCEnterSceneRet> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCEnterSceneRet",
      valuetype = "MCEnterSceneRet",
    },
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    Unpacket={
      type = "method",
      args="(MCEnterSceneRet*: pBase,char*: buff,int: len)",
      returns = "bool",
      valuetype = "bool"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
  },
},

MCDynamicMapListRet = {
  type = "class",
  inherits = "CResponsePacket IStreamableStaticAll<MCDynamicMapListRet> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCDynamicMapListRet",
      valuetype = "MCDynamicMapListRet",
    },
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    Unpacket={
      type = "method",
      args="(MCDynamicMapListRet*: pBase,char*: buff,int: len)",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

CMChat = {
  type = "class",
  inherits = "CRequestPacket IStreamableStaticAll<CMChat> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMChat",
      valuetype = "CMChat",
    },
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    Unpacket={
      type = "method",
      args="(CMChat*: pBase,char*: buff,int: len)",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

MCChatBroad = {
  type = "class",
  inherits = "CResponsePacket IStreamableStaticAll<MCChatBroad> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCChatBroad",
      valuetype = "MCChatBroad",
    },
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    Unpacket={
      type = "method",
      args="(MCChatBroad*: pBase,char*: buff,int: len)",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

MCAnnouncement = {
  type = "class",
  inherits = "CServerPacket IStreamableStaticAll<MCAnnouncement> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCAnnouncement",
      valuetype = "MCAnnouncement",
    },
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    Unpacket={
      type = "method",
      args="(MCAnnouncement*: pBase,char*: buff,int: len)",
      returns = "bool",
      valuetype = "bool"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
  },
},

CMRenameRoleName = {
  type = "class",
  inherits = "CRequestPacket IStreamableStaticAll<CMRenameRoleName> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMRenameRoleName",
      valuetype = "CMRenameRoleName",
    },
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    Unpacket={
      type = "method",
      args="(CMRenameRoleName*: pBase,char*: buff,int: len)",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

MCRenameRoleNameRet = {
  type = "class",
  inherits = "CResponsePacket IStreamableStaticAll<MCRenameRoleNameRet> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCRenameRoleNameRet",
      valuetype = "MCRenameRoleNameRet",
    },
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    Unpacket={
      type = "method",
      args="(MCRenameRoleNameRet*: pBase,char*: buff,int: len)",
      returns = "bool",
      valuetype = "bool"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
  },
},

MCRandRoleNameRet = {
  type = "class",
  inherits = "CResponsePacket IStreamableStaticAll<MCRandRoleNameRet> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCRandRoleNameRet",
      valuetype = "MCRandRoleNameRet",
    },
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    Unpacket={
      type = "method",
      args="(MCRandRoleNameRet*: pBase,char*: buff,int: len)",
      returns = "bool",
      valuetype = "bool"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
  },
},

CModChat = {
  type = "class",
  inherits = "CGameRoleModule ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CModChat",
      valuetype = "CModChat",
    },
    toChatBroadMsg={
      type = "method",
      args="(MCChatBroad*: broadMsg,CMChat*: packet)",
      returns = "void",
      valuetype = "void"
    },
    onLoad={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    reSetTime={
      type = "method",
      args="(unsigned char: chatChannel)",
      returns = "void",
      valuetype = "void"
    },
    chatFaction={
      type = "method",
      args="(CMChat*: packet)",
      returns = "void",
      valuetype = "void"
    },
    chatWorld={
      type = "method",
      args="(CMChat*: packet)",
      returns = "void",
      valuetype = "void"
    },
    isHaveOtherForbid={
      type = "method",
      args="(CCharArray2<250>: msg)",
      returns = "bool",
      valuetype = "bool"
    },
    isTimePassed={
      type = "method",
      args="(unsigned char: chatChannel)",
      returns = "bool",
      valuetype = "bool"
    },
    chatFriend={
      type = "method",
      args="(CMChat*: packet)",
      returns = "void",
      valuetype = "void"
    },
    update={
      type = "method",
      args="(unsigned int: diff)",
      returns = "void",
      valuetype = "void"
    },
    isCanChatSystem={
      type = "method",
      args="(CMChat*: packet)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    init={
      type = "method",
      args="(CRole*: role,unsigned int: time)",
      returns = "bool",
      valuetype = "bool"
    },
    isCanChatFaction={
      type = "method",
      args="(CMChat*: packet)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    isCanChatWorld={
      type = "method",
      args="(CMChat*: packet)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    chatGm={
      type = "method",
      args="(CMChat*: packet)",
      returns = "void",
      valuetype = "void"
    },
    isCanChatFriend={
      type = "method",
      args="(CMChat*: packet)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    isMsgContentAllSpace={
      type = "method",
      args="(CCharArray2<250>: msg)",
      returns = "bool",
      valuetype = "bool"
    },
    chatSystem={
      type = "method",
      args="(CMChat*: packet)",
      returns = "void",
      valuetype = "void"
    },
    updateMax={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    doFilterContent={
      type = "method",
      args="(CCharArray2<250>: msg,vector<basic_string<char>, allocator<basic_string<char> > >: filterMsg)",
      returns = "void",
      valuetype = "void"
    },
  },
},

CDhmTbl = {
  type = "class",
  inherits = "CConfigTbl ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CDhmTbl",
      valuetype = "CDhmTbl",
    },
    checkTblConfig={
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
    keyToString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    getKey={
      type = "method",
      args="()",
      returns = "short",
      valuetype = "short"
    },
    setKey={
      type = "method",
      args="(short: key)",
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

CDhmTblLoader = {
  type = "class",
  inherits = "CConfigLoader<CDhmTblLoader, CDhmTbl> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CDhmTblLoader",
      valuetype = "CDhmTblLoader",
    },
    findByKey={
      type = "method",
      args="(short: key)",
      returns = "CDhmTbl*",
      valuetype = "CDhmTbl"
    },
    readRow={
      type = "method",
      args="(TiXmlElement*: row,int: count,CDhmTbl*: destRow)",
      returns = "bool",
      valuetype = "bool"
    },
    setId={
      type = "method",
      args="(CDhmTbl*: destRow)",
      returns = "void",
      valuetype = "void"
    },
    GetPtr={
      type = "method",
      args="()",
      returns = "CDhmTblLoader*",
      valuetype = "CDhmTblLoader"
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
  inherits = "IStreamableAll ",
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

_DBAppendAttr = {
  type = "class",
  inherits = "TDBStructBase ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "_DBAppendAttr",
      valuetype = "_DBAppendAttr",
    },
  },
},

_DBGemFix = {
  type = "class",
  inherits = "TDBStructBase ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "_DBGemFix",
      valuetype = "_DBGemFix",
    },
  },
},

_DbBaseItem = {
  type = "class",
  inherits = "TDBStructBase ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "_DbBaseItem",
      valuetype = "_DbBaseItem",
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
    getRemainTime={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
  },
},

_DbItem = {
  type = "class",
  inherits = "TDbBaseItem ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "_DbItem",
      valuetype = "_DbItem",
    },
    isNull={
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

TGMFunc = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "TGMFunc",
      valuetype = "TGMFunc",
    },
  },
},

CGmCmdFunc = {
  type = "class",
  inherits = "CManualSingleton<CGmCmdFunc> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CGmCmdFunc",
      valuetype = "CGmCmdFunc",
    },
    parse={
      type = "method",
      args="(CRole*: pRole,CFixString<500>: str)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    init={
      type = "method",
      args="(string: str)",
      returns = "void",
      valuetype = "void"
    },
    GetPtr={
      type = "method",
      args="()",
      returns = "CGmCmdFunc*",
      valuetype = "CGmCmdFunc"
    },
  },
},

CItemHelper = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CItemHelper",
      valuetype = "CItemHelper",
    },
    BagMoveItem={
      type = "method",
      args="(CRole*: pRole,unsigned char: srcIndex,unsigned char: destIndex)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    AddItemToBag={
      type = "method",
      args="(EItemRecordType: recordType,CRole*: pRole,unsigned short: itemTypeID,short: itemNum,bool: sendMsg)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
  },
},

CItemInit = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CItemInit",
      valuetype = "CItemInit",
    },
  },
},

CItemTbls = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CItemTbls",
      valuetype = "CItemTbls",
    },
    getType={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    getSubType={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    isNull={
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
    isFashion={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setLoaded={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    isMission={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

CItem = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CItem",
      valuetype = "CItem",
    },
    getEmptyGemIndex={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    canSell={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isSkillBook={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    lock={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    setGemItem={
      type = "method",
      args="(unsigned short: itemTypeID,unsigned char: index)",
      returns = "void",
      valuetype = "void"
    },
    updatePos={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getItemTbls={
      type = "method",
      args="()",
      returns = "CItemTbls*",
      valuetype = "CItemTbls"
    },
    getRemainLayNum={
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
    getBind={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    newItem={
      type = "method",
      args="(unsigned short: typeID,short: num,unsigned char: quality,unsigned char: bind,unsigned int: createTime,unsigned int: remainTime,char: stre)",
      returns = "bool",
      valuetype = "bool"
    },
    toString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    check={
      type = "method",
      args="(bool: bindFlag,bool: lockFlag,bool: outDayFlag,bool: taskFlag,bool: rentFlag)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    isBuffer={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getIndex={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    getGemTypeID={
      type = "method",
      args="(unsigned char: index)",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    isLock={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isHoleEnchased={
      type = "method",
      args="(unsigned char: index)",
      returns = "bool",
      valuetype = "bool"
    },
    getEquipQuality={
      type = "method",
      args="()",
      returns = "EEquipQuality",
      valuetype = "EEquipQuality"
    },
    init={
      type = "method",
      args="(CItemInit*: pInit)",
      returns = "bool",
      valuetype = "bool"
    },
    getAppendAttrNum={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    canLevel={
      type = "method",
      args="(unsigned char: level)",
      returns = "bool",
      valuetype = "bool"
    },
    setRemainTime={
      type = "method",
      args="(unsigned int: remainTime)",
      returns = "void",
      valuetype = "void"
    },
    addStre={
      type = "method",
      args="(char: val)",
      returns = "void",
      valuetype = "void"
    },
    isConsume={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    canEquipBind={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getStre={
      type = "method",
      args="()",
      returns = "char",
      valuetype = "char"
    },
    isOutDay={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getItemTbl={
      type = "method",
      args="()",
      returns = "CItemConfigTbl*",
      valuetype = "CItemConfigTbl"
    },
    canBind={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getTypeID={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    decNum={
      type = "method",
      args="(short: num)",
      returns = "bool",
      valuetype = "bool"
    },
    getGemQuality={
      type = "method",
      args="()",
      returns = "EGemQuality",
      valuetype = "EGemQuality"
    },
    isGem={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    addGem={
      type = "method",
      args="(unsigned short: id,unsigned char: index)",
      returns = "void",
      valuetype = "void"
    },
    isMaxNum={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isEquip={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    hasGem={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getEquipPoint={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    addAppendAttr={
      type = "method",
      args="(char: attrType,unsigned char: valueType,int: attrValue)",
      returns = "void",
      valuetype = "void"
    },
    setBind={
      type = "method",
      args="(unsigned char: bind)",
      returns = "void",
      valuetype = "void"
    },
    getType={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    getMaxLayNum={
      type = "method",
      args="()",
      returns = "short",
      valuetype = "short"
    },
    addNum={
      type = "method",
      args="(short: num)",
      returns = "bool",
      valuetype = "bool"
    },
    canDestroy={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getSubType={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    getAppendAttr={
      type = "method",
      args="(unsigned char: index)",
      returns = "ExtendAttr*",
      valuetype = "ExtendAttr"
    },
    getObjUID={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    isDrug={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getCreateTime={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    getBufferID={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    getEquipType={
      type = "method",
      args="()",
      returns = "EEquipType",
      valuetype = "EEquipType"
    },
    isTask={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getItemValue={
      type = "method",
      args="()",
      returns = "_DbItem*",
      valuetype = "_DbItem"
    },
    setStre={
      type = "method",
      args="(char: num)",
      returns = "void",
      valuetype = "void"
    },
    setItemPos={
      type = "method",
      args="(EPackType: packType,unsigned char: index)",
      returns = "void",
      valuetype = "void"
    },
    unLock={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    delGem={
      type = "method",
      args="(unsigned char: index)",
      returns = "void",
      valuetype = "void"
    },
    setItemTypeID={
      type = "method",
      args="(unsigned short: typeID)",
      returns = "void",
      valuetype = "void"
    },
    getQuality={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    getGemNum={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    canStre={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getCanLayNum={
      type = "method",
      args="()",
      returns = "short",
      valuetype = "short"
    },
    setQuality={
      type = "method",
      args="(unsigned char: num)",
      returns = "void",
      valuetype = "void"
    },
    getNum={
      type = "method",
      args="()",
      returns = "short",
      valuetype = "short"
    },
    isBind={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    canWash={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    empty={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setNum={
      type = "method",
      args="(short: num)",
      returns = "void",
      valuetype = "void"
    },
    copyItemValue={
      type = "method",
      args="(CItem*: item)",
      returns = "void",
      valuetype = "void"
    },
    setCreateTime={
      type = "method",
      args="(unsigned int: createTime)",
      returns = "void",
      valuetype = "void"
    },
    isScroll={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getRemainTime={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    GetEquipPoint={
      type = "method",
      args="(EEquipType: equip)",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
  },
},

CTempItem = {
  type = "class",
  inherits = "CItem ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CTempItem",
      valuetype = "CTempItem",
    },
    setPos={
      type = "method",
      args="(unsigned char: type,unsigned char: index)",
      returns = "void",
      valuetype = "void"
    },
    setItem={
      type = "method",
      args="(CItem*: item)",
      returns = "void",
      valuetype = "void"
    },
  },
},

CItemContainer = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CItemContainer",
      valuetype = "CItemContainer",
    },
    checkContainerSize={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    countCanLay={
      type = "method",
      args="(unsigned short: itemTypeID,EItemAttrBindType: bindType)",
      returns = "int",
      valuetype = "int"
    },
    getContainerSize={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    getLastAddItemIndex={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    delItemByIndex={
      type = "method",
      args="(EItemRecordType: recordType,unsigned char: index,bool: sendMsg)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    getRoleContainerSize={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    getItemByTypeID={
      type = "method",
      args="(unsigned short: itemTypeID)",
      returns = "CItem*",
      valuetype = "CItem"
    },
    isBind={
      type = "method",
      args="(unsigned char: index)",
      returns = "bool",
      valuetype = "bool"
    },
    checkMemError={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getObjUIDByIndex={
      type = "method",
      args="(unsigned char: index)",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    canLaying={
      type = "method",
      args="(unsigned short: itemType,short: num,unsigned char: bind)",
      returns = "bool",
      valuetype = "bool"
    },
    getEmptyCount={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    getEmptyIndex={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    unLock={
      type = "method",
      args="(unsigned char: index)",
      returns = "bool",
      valuetype = "bool"
    },
    getItemByIndex={
      type = "method",
      args="(unsigned char: index)",
      returns = "CItem*",
      valuetype = "CItem"
    },
    init={
      type = "method",
      args="(unsigned char: maxSize,unsigned char: enableSize,EPackType: bagType,CRole*: role)",
      returns = "void",
      valuetype = "void"
    },
    initItems={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    isEmpty={
      type = "method",
      args="(unsigned char: index)",
      returns = "bool",
      valuetype = "bool"
    },
    getDbItem={
      type = "method",
      args="(unsigned char: index)",
      returns = "_DbItem*",
      valuetype = "_DbItem"
    },
    sendDelItem={
      type = "method",
      args="(unsigned char: index)",
      returns = "void",
      valuetype = "void"
    },
    extendContainer={
      type = "method",
      args="(unsigned char: extendSzie,unsigned char: srcSzie)",
      returns = "bool",
      valuetype = "bool"
    },
    canPackUp={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getItemNum={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    checkOutDayItem={
      type = "method",
      args="(vector<unsigned char, allocator<unsigned char> >: items)",
      returns = "void",
      valuetype = "void"
    },
    setBind={
      type = "method",
      args="(unsigned char: index,unsigned char: bind)",
      returns = "bool",
      valuetype = "bool"
    },
    update={
      type = "method",
      args="(int: diff,vector<unsigned char, allocator<unsigned char> >: items)",
      returns = "void",
      valuetype = "void"
    },
    delAllItems={
      type = "method",
      args="(EItemRecordType: recordType,vector<unsigned short, allocator<unsigned short> >: items,EItemAttrBindType: bindType)",
      returns = "bool",
      valuetype = "bool"
    },
    isFull={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getContainerType={
      type = "method",
      args="()",
      returns = "EPackType",
      valuetype = "EPackType"
    },
    packUp={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getLastAddItem={
      type = "method",
      args="()",
      returns = "CItem*",
      valuetype = "CItem"
    },
    lock={
      type = "method",
      args="(unsigned char: index)",
      returns = "bool",
      valuetype = "bool"
    },
    checkContainerItems={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getItemTypeByIndex={
      type = "method",
      args="(unsigned char: index)",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    getItemByObjUID={
      type = "method",
      args="(unsigned int: objUID)",
      returns = "CItem*",
      valuetype = "CItem"
    },
    autoCanLaying={
      type = "method",
      args="(unsigned short: itemType,short: num,unsigned char: bind,unsigned char: outIndex)",
      returns = "bool",
      valuetype = "bool"
    },
    getOwner={
      type = "method",
      args="()",
      returns = "CRole*",
      valuetype = "CRole"
    },
    delAllItem={
      type = "method",
      args="(EItemRecordType: recordType,unsigned short: itemTypeID,EItemAttrBindType: bindType)",
      returns = "bool",
      valuetype = "bool"
    },
    layItemInDiffCont={
      type = "method",
      args="(CItem*: item,bool: laying)",
      returns = "bool",
      valuetype = "bool"
    },
    sendUpdateItem={
      type = "method",
      args="(unsigned char: index)",
      returns = "bool",
      valuetype = "bool"
    },
    getAllItemObjUID={
      type = "method",
      args="(list<unsigned int, allocator<unsigned int> >: objUIDlIST)",
      returns = "void",
      valuetype = "void"
    },
  },
},

CItemManager = {
  type = "class",
  inherits = "CManualSingleton<CItemManager> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CItemManager",
      valuetype = "CItemManager",
    },
    genObjUID={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    init={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    GetPtr={
      type = "method",
      args="()",
      returns = "CItemManager*",
      valuetype = "CItemManager"
    },
  },
},

CItemOperator = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CItemOperator",
      valuetype = "CItemOperator",
    },
    MoveItem={
      type = "method",
      args="(CItemContainer*: itemConSRC,unsigned char: indexSRC,CItemContainer*: itemConDest,unsigned char: indexDest)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    ExchangeItem={
      type = "method",
      args="(CItemContainer*: itemConSRC,unsigned char: indexSRC,CItemContainer*: itemConDest,unsigned char: indexDest)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    EraseItem={
      type = "method",
      args="(CItemContainer*: itemConSRC,unsigned char: indexSRC)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    SplitItem={
      type = "method",
      args="(CItemContainer*: itemConSRC,unsigned char: indexSRC,short: splitCount,CItemContainer*: itemConDest,unsigned char: indexDest)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    MoveSpliceItem={
      type = "method",
      args="(CItemContainer*: itemConSRC,unsigned char: indexSRC,CItemContainer*: itemConDest,unsigned char: indexDest)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    PackUp={
      type = "method",
      args="(CItemContainer*: itemc)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    UseItem={
      type = "method",
      args="(CItemContainer*: pItemSrc,unsigned char: index)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
  },
},

CItemProperty = {
  type = "class",
  inherits = "CManualSingleton<CItemProperty> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CItemProperty",
      valuetype = "CItemProperty",
    },
    init={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    onUseItem={
      type = "method",
      args="(CRole*: pRole,CItem*: pItem,unsigned int: objUID)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    GetPtr={
      type = "method",
      args="()",
      returns = "CItemProperty*",
      valuetype = "CItemProperty"
    },
  },
},

_xinxiang = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "_xinxiang",
      valuetype = "_xinxiang",
    },
  },
},

CLevelUpTbl = {
  type = "class",
  inherits = "CConfigTbl ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CLevelUpTbl",
      valuetype = "CLevelUpTbl",
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
    setKey={
      type = "method",
      args="(unsigned char: key)",
      returns = "void",
      valuetype = "void"
    },
    toString={
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
    getKey={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
  },
},

CLevelUpTblLoader = {
  type = "class",
  inherits = "CConfigLoader<CLevelUpTblLoader, CLevelUpTbl> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CLevelUpTblLoader",
      valuetype = "CLevelUpTblLoader",
    },
    findByKey={
      type = "method",
      args="(unsigned char: key)",
      returns = "CLevelUpTbl*",
      valuetype = "CLevelUpTbl"
    },
    readRow={
      type = "method",
      args="(TiXmlElement*: row,int: count,CLevelUpTbl*: destRow)",
      returns = "bool",
      valuetype = "bool"
    },
    GetPtr={
      type = "method",
      args="()",
      returns = "CLevelUpTblLoader*",
      valuetype = "CLevelUpTblLoader"
    },
  },
},

CLimitHandle = {
  type = "class",
  inherits = "CSingleton<CLimitHandle> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CLimitHandle",
      valuetype = "CLimitHandle",
    },
    deleteLimitChat={
      type = "method",
      args="(unsigned long long: accountid,unsigned long long: roleid)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    addLimitChat={
      type = "method",
      args="(LimitChat*: datainfo)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    intitLimitChatList={
      type = "method",
      args="(CArray<LimitChatDB, 50, unsigned char>*: dataary)",
      returns = "void",
      valuetype = "void"
    },
    updateLimitChat={
      type = "method",
      args="(LimitChat*: datainfo)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
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

CScriptEngine = {
  type = "class",
  inherits = "CScriptEngineCommon CManualSingleton<CScriptEngine> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CScriptEngine",
      valuetype = "CScriptEngine",
    },
    bindToScript={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
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

CArea = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CArea",
      valuetype = "CArea",
    },
    isContain={
      type = "method",
      args="(short: x,short: y)",
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

_BlockRect = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "_BlockRect",
      valuetype = "_BlockRect",
    },
  },
},

_AxisRect = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "_AxisRect",
      valuetype = "_AxisRect",
    },
  },
},

_BlockInfo = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "_BlockInfo",
      valuetype = "_BlockInfo",
    },
    isValidBlockID={
      type = "method",
      args="(int: blockID)",
      returns = "bool",
      valuetype = "bool"
    },
    toString={
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
    getBlockID={
      type = "method",
      args="(short: w,short: h)",
      returns = "int",
      valuetype = "int"
    },
    getBlockIDByAxis={
      type = "method",
      args="(short: x,short: y)",
      returns = "int",
      valuetype = "int"
    },
  },
},

_ObjListNode = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "_ObjListNode",
      valuetype = "_ObjListNode",
    },
  },
},

CObjList = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CObjList",
      valuetype = "CObjList",
    },
    deleteNode={
      type = "method",
      args="(_ObjListNode*: pNode)",
      returns = "bool",
      valuetype = "bool"
    },
    addNode={
      type = "method",
      args="(_ObjListNode*: pNode)",
      returns = "bool",
      valuetype = "bool"
    },
    getHead={
      type = "method",
      args="()",
      returns = "_ObjListNode*",
      valuetype = "_ObjListNode"
    },
    getSize={
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
    getTail={
      type = "method",
      args="()",
      returns = "_ObjListNode*",
      valuetype = "_ObjListNode"
    },
  },
},

CBlock = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CBlock",
      valuetype = "CBlock",
    },
    getTop={
      type = "method",
      args="()",
      returns = "AxisPos",
      valuetype = "AxisPos"
    },
    addArea={
      type = "method",
      args="(CArea*: area)",
      returns = "void",
      valuetype = "void"
    },
    setBlockID={
      type = "method",
      args="(int: id)",
      returns = "void",
      valuetype = "void"
    },
    getBlockID={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getRoleList={
      type = "method",
      args="()",
      returns = "CObjList*",
      valuetype = "CObjList"
    },
    onObjectLeave={
      type = "method",
      args="(CGameObject*: pObj)",
      returns = "void",
      valuetype = "void"
    },
    getAreaCount={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    cleanUp={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getObjList={
      type = "method",
      args="()",
      returns = "CObjList*",
      valuetype = "CObjList"
    },
    getBottom={
      type = "method",
      args="()",
      returns = "AxisPos",
      valuetype = "AxisPos"
    },
    calcAxisPos={
      type = "method",
      args="(_BlockInfo*: blockInfo)",
      returns = "void",
      valuetype = "void"
    },
    hasRole={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    onObjectEnter={
      type = "method",
      args="(CGameObject*: pObj)",
      returns = "void",
      valuetype = "void"
    },
    getCurrentArea={
      type = "method",
      args="(AxisPos: axisPos)",
      returns = "CArea*",
      valuetype = "CArea"
    },
  },
},

_ObjInit = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "_ObjInit",
      valuetype = "_ObjInit",
    },
  },
},

_CharacterInit = {
  type = "class",
  inherits = "TObjInit ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "_CharacterInit",
      valuetype = "_CharacterInit",
    },
  },
},

CGameObject = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CGameObject",
      valuetype = "CGameObject",
    },
    setMapID={
      type = "method",
      args="(unsigned short: mapID)",
      returns = "void",
      valuetype = "void"
    },
    setBlockID={
      type = "method",
      args="(int: blockID)",
      returns = "void",
      valuetype = "void"
    },
    leaveBlock={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getAxisPos={
      type = "method",
      args="()",
      returns = "AxisPos*",
      valuetype = "AxisPos"
    },
    cleanUp={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    isCanViewMe={
      type = "method",
      args="(CGameObject*: pObj)",
      returns = "bool",
      valuetype = "bool"
    },
    setObjUID={
      type = "method",
      args="(unsigned int: objUID)",
      returns = "void",
      valuetype = "void"
    },
    toCharacter={
      type = "method",
      args="()",
      returns = "CCharacterObject*",
      valuetype = "CCharacterObject"
    },
    isObj={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isRole={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setPetAttr={
      type = "method",
      args="(EObjType: objType)",
      returns = "void",
      valuetype = "void"
    },
    updateOutBlock={
      type = "method",
      args="(unsigned int: diff)",
      returns = "bool",
      valuetype = "bool"
    },
    isMonster={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isPet={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    updateBlock={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getShapeData={
      type = "method",
      args="(char*: data,unsigned int: maxSize)",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    getMapID={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    setSceneID={
      type = "method",
      args="(unsigned long long: sceneID)",
      returns = "void",
      valuetype = "void"
    },
    onLeaveScene={
      type = "method",
      args="(CMapSceneBase*: pScene)",
      returns = "void",
      valuetype = "void"
    },
    init={
      type = "method",
      args="(_ObjInit*: inits)",
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
    setObjType={
      type = "method",
      args="(EObjType: type)",
      returns = "void",
      valuetype = "void"
    },
    setActive={
      type = "method",
      args="(bool: flag)",
      returns = "void",
      valuetype = "void"
    },
    getSceneID={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    setRoleAttr={
      type = "method",
      args="(EObjType: objType)",
      returns = "void",
      valuetype = "void"
    },
    keyToString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    onRegisterToBlock={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    genStrName={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    isCharacter={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isCanUpdateLeaveScene={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getObjType={
      type = "method",
      args="()",
      returns = "EObjType",
      valuetype = "EObjType"
    },
    update={
      type = "method",
      args="(unsigned int: diff)",
      returns = "bool",
      valuetype = "bool"
    },
    getObjNode={
      type = "method",
      args="()",
      returns = "_ObjListNode*",
      valuetype = "_ObjListNode"
    },
    getObjUID={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    setMonsterAttr={
      type = "method",
      args="(EObjType: objType)",
      returns = "void",
      valuetype = "void"
    },
    getObjGUID={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    setDir={
      type = "method",
      args="(unsigned char: dir)",
      returns = "void",
      valuetype = "void"
    },
    setAxisPos={
      type = "method",
      args="(AxisPos*: pos)",
      returns = "void",
      valuetype = "void"
    },
    isActive={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setScene={
      type = "method",
      args="(CMapSceneBase*: scene)",
      returns = "void",
      valuetype = "void"
    },
    getDir={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    isKey={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    onUnregisterFromBlock={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getBlockID={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    setObjGUID={
      type = "method",
      args="(unsigned long long: guid)",
      returns = "void",
      valuetype = "void"
    },
    getKey={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    onEnterScene={
      type = "method",
      args="(CMapSceneBase*: pScene)",
      returns = "void",
      valuetype = "void"
    },
    getScene={
      type = "method",
      args="()",
      returns = "CMapSceneBase*",
      valuetype = "CMapSceneBase"
    },
    getObjString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    isCanLeaveScene={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isNeedUpdateBlock={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    IsDynamic={
      type = "method",
      args="(CGameObject*: pObj)",
      returns = "bool",
      valuetype = "bool"
    },
    IsInValidRadius={
      type = "method",
      args="(short: x1,short: y1,short: x2,short: y2,unsigned char: range)",
      returns = "bool",
      valuetype = "bool"
    },
    ObjTypeToStr={
      type = "method",
      args="(EObjType: objType)",
      returns = "char*",
      valuetype = "char"
    },
    IsCharacter={
      type = "method",
      args="(CGameObject*: pObj)",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

CDynamicObject = {
  type = "class",
  inherits = "CGameObject ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CDynamicObject",
      valuetype = "CDynamicObject",
    },
    init={
      type = "method",
      args="(_ObjInit*: objInit)",
      returns = "bool",
      valuetype = "bool"
    },
    cleanUp={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    update={
      type = "method",
      args="(unsigned int: diff)",
      returns = "bool",
      valuetype = "bool"
    },
    updateOutBlock={
      type = "method",
      args="(unsigned int: diff)",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

CSkillBuff = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CSkillBuff",
      valuetype = "CSkillBuff",
    },
  },
},

CItemBuff = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CItemBuff",
      valuetype = "CItemBuff",
    },
  },
},

CBufferEffect = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CBufferEffect",
      valuetype = "CBufferEffect",
    },
    log={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getPackBuff={
      type = "method",
      args="(_PackBuffer*: buff)",
      returns = "void",
      valuetype = "void"
    },
    getOwnerBuff={
      type = "method",
      args="(OwnerBuffer*: buff)",
      returns = "void",
      valuetype = "void"
    },
    reload={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    toString={
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
    isActive={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isNeedSave={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getRemainTime={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
  },
},

CBufferImpactBase = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CBufferImpactBase",
      valuetype = "CBufferImpactBase",
    },
    getRange={
      type = "method",
      args="(char: level)",
      returns = "char",
      valuetype = "char"
    },
    getAttrs={
      type = "method",
      args="(CBufferEffect*: buff,CCharacterObject*: rMe,CBufferAttr*: buffAttrs)",
      returns = "void",
      valuetype = "void"
    },
    onDamage={
      type = "method",
      args="(CBufferEffect*: buff,CCharacterObject*: rMe)",
      returns = "void",
      valuetype = "void"
    },
    isRangeBuff={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    onReload={
      type = "method",
      args="(CBufferEffect*: buff,CCharacterObject*: rMe)",
      returns = "void",
      valuetype = "void"
    },
    getActionBan={
      type = "method",
      args="(CBufferEffect*: buff,CCharacterObject*: rMe,CActionBan*: bans)",
      returns = "void",
      valuetype = "void"
    },
    getBufferConfig={
      type = "method",
      args="()",
      returns = "CBufferConfigTbl*",
      valuetype = "CBufferConfigTbl"
    },
    getEffectType={
      type = "method",
      args="()",
      returns = "EBuffEffectType",
      valuetype = "EBuffEffectType"
    },
    enterView={
      type = "method",
      args="(CBufferEffect*: buff,CCharacterObject*: rMe,CCharacterObject*: other)",
      returns = "void",
      valuetype = "void"
    },
    onHit={
      type = "method",
      args="(CBufferEffect*: buff,CCharacterObject*: rMe)",
      returns = "void",
      valuetype = "void"
    },
    onAdd={
      type = "method",
      args="(CBufferEffect*: buff,CCharacterObject*: rMe)",
      returns = "void",
      valuetype = "void"
    },
    initFromData={
      type = "method",
      args="(CBufferEffect*: buff,CCharacterObject*: rMe,bool: loadDbFlag)",
      returns = "bool",
      valuetype = "bool"
    },
    onActive={
      type = "method",
      args="(CBufferEffect*: buff,CCharacterObject*: rMe)",
      returns = "int",
      valuetype = "int"
    },
    onFadeout={
      type = "method",
      args="(CBufferEffect*: buff,CCharacterObject*: rMe)",
      returns = "void",
      valuetype = "void"
    },
    getBuffEvent={
      type = "method",
      args="(CBufferEffect*: buff,CCharacterObject*: rMe,CFixBitSet<9>*: buffEvents)",
      returns = "void",
      valuetype = "void"
    },
    update={
      type = "method",
      args="(CBufferEffect*: buff,int: diff)",
      returns = "void",
      valuetype = "void"
    },
    logBuffer={
      type = "method",
      args="(CBufferEffect*: buff)",
      returns = "void",
      valuetype = "void"
    },
    updateBuff={
      type = "method",
      args="(CBufferEffect*: buff)",
      returns = "void",
      valuetype = "void"
    },
    isActionBan={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isRefreshAttr={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    loadFromDb={
      type = "method",
      args="(CBufferEffect*: ,CCharacterObject*: rMe)",
      returns = "bool",
      valuetype = "bool"
    },
    isCountTime={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    onDie={
      type = "method",
      args="(CBufferEffect*: buff,CCharacterObject*: rMe)",
      returns = "void",
      valuetype = "void"
    },
    isTimeout={
      type = "method",
      args="(CBufferEffect*: buff)",
      returns = "bool",
      valuetype = "bool"
    },
    reload={
      type = "method",
      args="(CBufferEffect*: buff,CCharacterObject*: rMe)",
      returns = "void",
      valuetype = "void"
    },
    isIntervaled={
      type = "method",
      args="(CBufferEffect*: buff)",
      returns = "bool",
      valuetype = "bool"
    },
    isDurationTime={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    markModifiedAttrDirty={
      type = "method",
      args="(CBufferEffect*: buff,CCharacterObject*: rMe)",
      returns = "void",
      valuetype = "void"
    },
    onEffectAtStart={
      type = "method",
      args="(CBufferEffect*: buff,CCharacterObject*: rMe)",
      returns = "void",
      valuetype = "void"
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

CBufferManager = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CBufferManager",
      valuetype = "CBufferManager",
    },
    isBuffIDExist={
      type = "method",
      args="(unsigned short: buffID)",
      returns = "bool",
      valuetype = "bool"
    },
    isReflectEvt={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isForceHateEvt={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isOnDamageEvt={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getBuff={
      type = "method",
      args="(unsigned short: buffID)",
      returns = "CBufferEffect*",
      valuetype = "CBufferEffect"
    },
    sendDelAllEffect={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    onHurt={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    calcItemAttr={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    onBeforeChangeLine={
      type = "method",
      args="(ChangeLineTempData*: tempData)",
      returns = "bool",
      valuetype = "bool"
    },
    clearActiveEffect={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    isOnDieEvt={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    logAttr={
      type = "method",
      args="(unsigned int: num)",
      returns = "void",
      valuetype = "void"
    },
    onHit={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getExpRate={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    onSave={
      type = "method",
      args="(bool: offLineFlag)",
      returns = "void",
      valuetype = "void"
    },
    getItemAttrs={
      type = "method",
      args="()",
      returns = "CBufferAttr*",
      valuetype = "CBufferAttr"
    },
    sendDel={
      type = "method",
      args="(CBufferEffect*: buffer)",
      returns = "void",
      valuetype = "void"
    },
    rebuildEventFlags={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    onLoad={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    processActiveEffect={
      type = "method",
      args="(int: diff)",
      returns = "void",
      valuetype = "void"
    },
    calcPassiveAttr={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getBuffAry={
      type = "method",
      args="(CArray1<_PackSimpleBuff, 500>*: buffAry)",
      returns = "void",
      valuetype = "void"
    },
    getPassiveAttrs={
      type = "method",
      args="()",
      returns = "CBufferAttr*",
      valuetype = "CBufferAttr"
    },
    sendAddAllEffect={
      type = "method",
      args="(CRoleBase*: pRole)",
      returns = "void",
      valuetype = "void"
    },
    update={
      type = "method",
      args="(int: diff)",
      returns = "void",
      valuetype = "void"
    },
    clearItemEffect={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getBuffAttrs={
      type = "method",
      args="()",
      returns = "CBufferAttr*",
      valuetype = "CBufferAttr"
    },
    rebuildActionFlags={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    isStopEvt={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    onBeUseSkill={
      type = "method",
      args="(CCharacterObject*: pAttacker)",
      returns = "void",
      valuetype = "void"
    },
    isSleepEvt={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    onAfterChangeLine={
      type = "method",
      args="(ChangeLineTempData*: tempData)",
      returns = "bool",
      valuetype = "bool"
    },
    addPassiveEffect={
      type = "method",
      args="(CSkillBuff*: buff,bool: isNew)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    sendAdd={
      type = "method",
      args="(CBufferEffect*: buffer)",
      returns = "void",
      valuetype = "void"
    },
    onDie={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    calcActiveAttr={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    isDizzEvt={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    processItemEffect={
      type = "method",
      args="(int: diff)",
      returns = "void",
      valuetype = "void"
    },
    loadPassiveEffect={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    processPassivEffect={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    onStudySkill={
      type = "method",
      args="(unsigned short: skillID,char: level)",
      returns = "void",
      valuetype = "void"
    },
    InitImpacts={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    CalcPassiveAttr={
      type = "method",
      args="(vector<OwnSkill, allocator<OwnSkill> >*: skills,CBufferAttr*: buffAttrs)",
      returns = "void",
      valuetype = "void"
    },
  },
},

CCharAttributeCore = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CCharAttributeCore",
      valuetype = "CCharAttributeCore",
    },
    setStrength={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    addMaxHp={
      type = "method",
      args="(int: val,bool: logFlag)",
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
    getFightPower={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getMaxExp={
      type = "method",
      args="(unsigned char: lvl)",
      returns = "int",
      valuetype = "int"
    },
    addPower={
      type = "method",
      args="(int: val,bool: logFlag)",
      returns = "int",
      valuetype = "int"
    },
    getDodge={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    setCharacter={
      type = "method",
      args="(CCharacterObject*: character)",
      returns = "void",
      valuetype = "void"
    },
    markAttrDirty={
      type = "method",
      args="(char: index)",
      returns = "void",
      valuetype = "void"
    },
    getFightAgility={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    addAttackRange={
      type = "method",
      args="(int: val)",
      returns = "int",
      valuetype = "int"
    },
    setDodge={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    getMoveSpeed={
      type = "method",
      args="()",
      returns = "short",
      valuetype = "short"
    },
    getFormulaAttrValue={
      type = "method",
      args="(char: attrType)",
      returns = "int",
      valuetype = "int"
    },
    setAttackSpeed={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    addDamage={
      type = "method",
      args="(int: val,bool: logFlag)",
      returns = "int",
      valuetype = "int"
    },
    setAttackRange={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    setExp={
      type = "method",
      args="(int: exp)",
      returns = "void",
      valuetype = "void"
    },
    logBufferAttr={
      type = "method",
      args="(bool: logFlag)",
      returns = "string",
      valuetype = "string"
    },
    addLevel={
      type = "method",
      args="(unsigned char: level,bool: logFlag)",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    getFightDamage={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getCrit={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    onLevelChanged={
      type = "method",
      args="(unsigned int: sLvl,unsigned int: dLvl)",
      returns = "void",
      valuetype = "void"
    },
    addPhysicAttack={
      type = "method",
      args="(int: val)",
      returns = "int",
      valuetype = "int"
    },
    setWisdom={
      type = "method",
      args="(int: hp)",
      returns = "void",
      valuetype = "void"
    },
    getAttackRange={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    updateOutBlock={
      type = "method",
      args="(int: diff)",
      returns = "bool",
      valuetype = "bool"
    },
    getMaxLevel={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    getFightWisdom={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getSkillAttr={
      type = "method",
      args="()",
      returns = "CSkillAttr*",
      valuetype = "CSkillAttr"
    },
    logEquipAttr={
      type = "method",
      args="(bool: logFlag)",
      returns = "string",
      valuetype = "string"
    },
    getPhysicDefense={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    doExpLevelUp={
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
    refreshFast={
      type = "method",
      args="(bool: sendFlag)",
      returns = "void",
      valuetype = "void"
    },
    setHp={
      type = "method",
      args="(int: hp)",
      returns = "void",
      valuetype = "void"
    },
    getLevel={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    setAgility={
      type = "method",
      args="(int: hp)",
      returns = "void",
      valuetype = "void"
    },
    getPhysicAttck={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    logBaseAttr={
      type = "method",
      args="(bool: logFlag)",
      returns = "string",
      valuetype = "string"
    },
    getWisdom={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    loadBaseAttr={
      type = "method",
      args="(CAttrBase<int, 49>*: baseAttr)",
      returns = "void",
      valuetype = "void"
    },
    setJob={
      type = "method",
      args="(unsigned char: job)",
      returns = "void",
      valuetype = "void"
    },
    addAgility={
      type = "method",
      args="(int: hp,bool: logFlag)",
      returns = "int",
      valuetype = "int"
    },
    getFightStrength={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getPower={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getFightDodge={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    addCrit={
      type = "method",
      args="(int: val)",
      returns = "int",
      valuetype = "int"
    },
    getNeedAddHpToMax={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getFightAttrValue={
      type = "method",
      args="(char: index)",
      returns = "int",
      valuetype = "int"
    },
    markAllAttrDirty={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getStrength={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    setLevel={
      type = "method",
      args="(unsigned char: level)",
      returns = "void",
      valuetype = "void"
    },
    addAttrValue={
      type = "method",
      args="(char: index,int: val)",
      returns = "int",
      valuetype = "int"
    },
    addAttackSpeed={
      type = "method",
      args="(int: val)",
      returns = "int",
      valuetype = "int"
    },
    update={
      type = "method",
      args="(int: diff)",
      returns = "bool",
      valuetype = "bool"
    },
    getMaxHp={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getAttrValue={
      type = "method",
      args="(char: index)",
      returns = "int",
      valuetype = "int"
    },
    getJob={
      type = "method",
      args="()",
      returns = "EJobType",
      valuetype = "EJobType"
    },
    addDodge={
      type = "method",
      args="(int: val,bool: logFlag)",
      returns = "int",
      valuetype = "int"
    },
    addStrength={
      type = "method",
      args="(int: hp,bool: logFlag)",
      returns = "int",
      valuetype = "int"
    },
    addExp={
      type = "method",
      args="(int: val,bool: logFlag)",
      returns = "int",
      valuetype = "int"
    },
    addWisdom={
      type = "method",
      args="(int: hp,bool: logFlag)",
      returns = "int",
      valuetype = "int"
    },
    getFightPhysicDefense={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    hpChange={
      type = "method",
      args="(int: incrememnt,CCharacterObject*: pDestObj)",
      returns = "int",
      valuetype = "int"
    },
    getBaseAttrValue={
      type = "method",
      args="(char: index)",
      returns = "int",
      valuetype = "int"
    },
    getFightCrit={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getExp={
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
      args="(int: hp,bool: logFlag)",
      returns = "int",
      valuetype = "int"
    },
    getDamage={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    logTotalAttr={
      type = "method",
      args="(bool: logFlag)",
      returns = "string",
      valuetype = "string"
    },
    getFightPhysicAttack={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    setAttrValue={
      type = "method",
      args="(char: index,unsigned int: val)",
      returns = "void",
      valuetype = "void"
    },
    getAttackSpeed={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    addMoveSpeed={
      type = "method",
      args="(int: val,bool: logFlag)",
      returns = "short",
      valuetype = "short"
    },
    setMoveSpeed={
      type = "method",
      args="(short: speed)",
      returns = "void",
      valuetype = "void"
    },
    cleanUp={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
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
    getNeedAddToMax={
      type = "method",
      args="(char: index)",
      returns = "int",
      valuetype = "int"
    },
    logCombatResult={
      type = "method",
      args="(bool: logFlag)",
      returns = "string",
      valuetype = "string"
    },
  },
},

CCharAttributeCoreExt = {
  type = "class",
  inherits = "CCharAttributeCore ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CCharAttributeCoreExt",
      valuetype = "CCharAttributeCoreExt",
    },
    energyChange={
      type = "method",
      args="(int: incrememnt,CCharacterObject*: pDestObj)",
      returns = "int",
      valuetype = "int"
    },
    getMaxEnergy={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getFightSkillAttack={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    setEnergy={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    getDamageReduce={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getNeedAddEnergyToMax={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getEnergy={
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
    getFightDamageReduce={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    addEnergy={
      type = "method",
      args="(int: val,bool: logFlag)",
      returns = "int",
      valuetype = "int"
    },
    setDamageReduce={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    addMaxEnergy={
      type = "method",
      args="(int: val,bool: logFlag)",
      returns = "int",
      valuetype = "int"
    },
    init={
      type = "method",
      args="(_CharacterInit*: inits)",
      returns = "bool",
      valuetype = "bool"
    },
    getBufferManager={
      type = "method",
      args="()",
      returns = "CBufferManager*",
      valuetype = "CBufferManager"
    },
    addDamageReduce={
      type = "method",
      args="(int: val,bool: logFlag)",
      returns = "int",
      valuetype = "int"
    },
    getSkillAttack={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
  },
},

_PathPoint = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "_PathPoint",
      valuetype = "_PathPoint",
    },
  },
},

CCharMoveCore = {
  type = "class",
  inherits = "CAStar<1, 15, 25> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CCharMoveCore",
      valuetype = "CCharMoveCore",
    },
    updateOutBlock={
      type = "method",
      args="(int: diff)",
      returns = "bool",
      valuetype = "bool"
    },
    isRangeEmptyPos={
      type = "method",
      args="(unsigned short: range)",
      returns = "bool",
      valuetype = "bool"
    },
    posListEmpty={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getRange={
      type = "method",
      args="(AxisPos*: tarPos)",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    isSafeZone={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setCharacter={
      type = "method",
      args="(CCharacterObject*: character)",
      returns = "void",
      valuetype = "void"
    },
    update={
      type = "method",
      args="(int: diff)",
      returns = "bool",
      valuetype = "bool"
    },
    findRandEmptyPos={
      type = "method",
      args="(AxisPos*: pos,unsigned short: range)",
      returns = "bool",
      valuetype = "bool"
    },
    init={
      type = "method",
      args="(_CharacterInit*: inits)",
      returns = "bool",
      valuetype = "bool"
    },
    cleanUp={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    directMoveTo={
      type = "method",
      args="(AxisPos*: tarPos)",
      returns = "void",
      valuetype = "void"
    },
    findEmptyPos={
      type = "method",
      args="(AxisPos*: pos,unsigned short: range)",
      returns = "bool",
      valuetype = "bool"
    },
    isMoving={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    moveLine={
      type = "method",
      args="(AxisPos*: tarPos)",
      returns = "bool",
      valuetype = "bool"
    },
    getFinalTarPos={
      type = "method",
      args="()",
      returns = "AxisPos*",
      valuetype = "AxisPos"
    },
  },
},

CCharMsgHandle = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CCharMsgHandle",
      valuetype = "CCharMsgHandle",
    },
    onResetPos={
      type = "method",
      args="(unsigned int: objUID,short: x,short: y,EResetPosType: type,bool: broadFlag)",
      returns = "void",
      valuetype = "void"
    },
    onActionBanChange={
      type = "method",
      args="(EActionBan: ban)",
      returns = "void",
      valuetype = "void"
    },
    onMoveUpdate={
      type = "method",
      args="(CArray1<AxisPos, 100>*: posList,unsigned int: objUID)",
      returns = "void",
      valuetype = "void"
    },
  },
},

_ScanOperatorInit = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "_ScanOperatorInit",
      valuetype = "_ScanOperatorInit",
    },
    getScene={
      type = "method",
      args="()",
      returns = "CMapSceneBase*",
      valuetype = "CMapSceneBase"
    },
  },
},

CScanOperator = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CScanOperator",
      valuetype = "CScanOperator",
    },
    isOnlyScanRole={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    onBeforeScan={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getScanRange={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    onFindObject={
      type = "method",
      args="(CGameObject*: pObj)",
      returns = "EScanReturn",
      valuetype = "EScanReturn"
    },
    isNeedScan={
      type = "method",
      args="(int: blockID)",
      returns = "bool",
      valuetype = "bool"
    },
    getBlockID={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    onAfterScan={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    init={
      type = "method",
      args="(_ScanOperatorInit*: pInit)",
      returns = "bool",
      valuetype = "bool"
    },
    getScene={
      type = "method",
      args="()",
      returns = "CMapSceneBase*",
      valuetype = "CMapSceneBase"
    },
  },
},

CAttackPos = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CAttackPos",
      valuetype = "CAttackPos",
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
      returns = "char*",
      valuetype = "char"
    },
  },
},

CAttackorList = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CAttackorList",
      valuetype = "CAttackorList",
    },
    logImpact={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getAttactorList={
      type = "method",
      args="(CArray1<unsigned int, 50>*: objs)",
      returns = "void",
      valuetype = "void"
    },
    getImpactSize={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    cleanUp={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getAttackObjSize={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
  },
},

CAttackTarget = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CAttackTarget",
      valuetype = "CAttackTarget",
    },
    getTotalAddHp={
      type = "method",
      args="(bool: calcMe,unsigned int: objUID)",
      returns = "double",
      valuetype = "double"
    },
    single={
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
    getTotalDescHp={
      type = "method",
      args="(bool: calcMe,unsigned int: objUID)",
      returns = "double",
      valuetype = "double"
    },
  },
},

CCharSkillCore = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CCharSkillCore",
      valuetype = "CCharSkillCore",
    },
    getSkillList={
      type = "method",
      args="(vector<OwnSkill, allocator<OwnSkill> >*: skills)",
      returns = "void",
      valuetype = "void"
    },
    getSkillLogicBase={
      type = "method",
      args="()",
      returns = "CSkillLogicBase*",
      valuetype = "CSkillLogicBase"
    },
    updateOutBlock={
      type = "method",
      args="(int: diff)",
      returns = "bool",
      valuetype = "bool"
    },
    getCommonSkill={
      type = "method",
      args="()",
      returns = "OwnSkill*",
      valuetype = "OwnSkill"
    },
    getSkillID={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    setCommSkillID={
      type = "method",
      args="(unsigned short: skillID,char: level)",
      returns = "void",
      valuetype = "void"
    },
    setCharacter={
      type = "method",
      args="(CCharacterObject*: character)",
      returns = "void",
      valuetype = "void"
    },
    getAttackors={
      type = "method",
      args="(CArray1<AttackorImpact, 50>*: attackors)",
      returns = "void",
      valuetype = "void"
    },
    use={
      type = "method",
      args="(unsigned int: destObjUID,unsigned short: skillTypeID,short: x,short: y)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    update={
      type = "method",
      args="(int: diff)",
      returns = "bool",
      valuetype = "bool"
    },
    onAfterUse={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    init={
      type = "method",
      args="(_CharacterInit*: inits)",
      returns = "bool",
      valuetype = "bool"
    },
    cleanUp={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getSN={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    getCommSkillAttackDis={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    getCommSkillID={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    getSkillLevel={
      type = "method",
      args="(unsigned short: skillID)",
      returns = "char",
      valuetype = "char"
    },
  },
},

CCooldown = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CCooldown",
      valuetype = "CCooldown",
    },
    reset={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    setCoolDownID={
      type = "method",
      args="(int: id)",
      returns = "void",
      valuetype = "void"
    },
    getCooldownTime={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    isInvalid={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setCooldownTime={
      type = "method",
      args="(int: nTime)",
      returns = "void",
      valuetype = "void"
    },
    getCoolDownID={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    setCooldownElapsed={
      type = "method",
      args="(int: nTime)",
      returns = "void",
      valuetype = "void"
    },
    heartBeat={
      type = "method",
      args="(int: nDeltaTime)",
      returns = "void",
      valuetype = "void"
    },
    getCooldownElapsed={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    isCooldowned={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getRemainTime={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
  },
},

DBSkillCoolDown = {
  type = "class",
  inherits = "TDBStructBase ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "DBSkillCoolDown",
      valuetype = "DBSkillCoolDown",
    },
  },
},

DBItemCoolDown = {
  type = "class",
  inherits = "TDBStructBase ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "DBItemCoolDown",
      valuetype = "DBItemCoolDown",
    },
  },
},

CSkillInfo = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CSkillInfo",
      valuetype = "CSkillInfo",
    },
    load={
      type = "method",
      args="(unsigned short: skillIDType,CCharacterObject*: pObj)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    isSingle={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isGroup={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isUseOwner={
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
    isPassiveSkill={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getNeedEnery={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getCommCD={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    getEffectSize={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getSkillTypeID={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    getCD={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    getAttackType={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    getLevel={
      type = "method",
      args="()",
      returns = "char",
      valuetype = "char"
    },
    getParamSize={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    getDistance={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    doEffect={
      type = "method",
      args="(CCharacterObject*: rObj,bool: des)",
      returns = "void",
      valuetype = "void"
    },
    isNeedJobCheck={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getType={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    getJob={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    isToEmeny={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getOdds={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    isActive={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isToSelf={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getTargetType={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    getDelayTime={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
  },
},

CSkillTargetScanInit = {
  type = "class",
  inherits = "TScanOperatorInit ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CSkillTargetScanInit",
      valuetype = "CSkillTargetScanInit",
    },
  },
},

CSkillTargetScan = {
  type = "class",
  inherits = "CScanOperator ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CSkillTargetScan",
      valuetype = "CSkillTargetScan",
    },
    onFindObject={
      type = "method",
      args="(CGameObject*: pObj)",
      returns = "EScanReturn",
      valuetype = "EScanReturn"
    },
  },
},

CSkillLogicBase = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CSkillLogicBase",
      valuetype = "CSkillLogicBase",
    },
    load={
      type = "method",
      args="(CCharacterObject*: rMe,CAttackPos*: pos)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    checkLevel={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    onAfterCalcHurt={
      type = "method",
      args="(CCharacterObject*: rMe,CAttackPos*: attackPos,CAttackTarget*: attackTarget)",
      returns = "void",
      valuetype = "void"
    },
    onLoad={
      type = "method",
      args="(CCharacterObject*: rMe,CAttackPos*: pos)",
      returns = "bool",
      valuetype = "bool"
    },
    needCalcHurt={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    onBeforeCalcHurt={
      type = "method",
      args="(CCharacterObject*: rMe,CAttackPos*: attackPos,CAttackTarget*: attackTarget)",
      returns = "void",
      valuetype = "void"
    },
    selectTarget={
      type = "method",
      args="(CCharacterObject*: rMe,CAttackPos*: attackPos,CAttackTarget*: attackTarget)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    showImpact={
      type = "method",
      args="(CCharacterObject*: rMe,CAttackPos*: attackPos,CAttackTarget*: attackTarget)",
      returns = "void",
      valuetype = "void"
    },
    onAfterUse={
      type = "method",
      args="(CCharacterObject*: rMe,CAttackPos*: attackPos,CAttackTarget*: attackTarget)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    getSkillInfo={
      type = "method",
      args="()",
      returns = "CSkillInfo*",
      valuetype = "CSkillInfo"
    },
    init={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    cleanUp={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getMaxAttackNum={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    onActivate={
      type = "method",
      args="(CCharacterObject*: rMe,CAttackPos*: attackPos,CAttackTarget*: attackTarget)",
      returns = "void",
      valuetype = "void"
    },
    calcHurt={
      type = "method",
      args="(CCharacterObject*: rMe,CAttackPos*: attackPos,CAttackTarget*: attackTarget)",
      returns = "void",
      valuetype = "void"
    },
    onAfterSelectTarget={
      type = "method",
      args="(CCharacterObject*: rMe,CAttackPos*: attackPos,CAttackTarget*: attackTarget)",
      returns = "void",
      valuetype = "void"
    },
    onBeforeUse={
      type = "method",
      args="(CCharacterObject*: rMe,CAttackPos*: attackPos,CAttackTarget*: attackTarget)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    check={
      type = "method",
      args="(CCharacterObject*: rMe,CAttackPos*: attackPos,CAttackTarget*: attackTarget)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    doConsume={
      type = "method",
      args="(CCharacterObject*: rMe,CAttackPos*: attackPos,CAttackTarget*: attackTarget)",
      returns = "void",
      valuetype = "void"
    },
  },
},

CSkillLogicManager = {
  type = "class",
  inherits = "CManualSingleton<CSkillLogicManager> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CSkillLogicManager",
      valuetype = "CSkillLogicManager",
    },
    initSkills={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getSkillLogic={
      type = "method",
      args="(unsigned short: skillID)",
      returns = "CSkillLogicBase*",
      valuetype = "CSkillLogicBase"
    },
    GetPtr={
      type = "method",
      args="()",
      returns = "CSkillLogicManager*",
      valuetype = "CSkillLogicManager"
    },
  },
},

CCombatResult = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CCombatResult",
      valuetype = "CCombatResult",
    },
    getMpChanged={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    setParam={
      type = "method",
      args="(int: index,int: paramVal)",
      returns = "void",
      valuetype = "void"
    },
    setMpChanged={
      type = "method",
      args="(int: mp)",
      returns = "void",
      valuetype = "void"
    },
    setHit={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    setHpChanged={
      type = "method",
      args="(int: hp)",
      returns = "void",
      valuetype = "void"
    },
    isHitBack={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getImpactType={
      type = "method",
      args="()",
      returns = "EAttackImpactType",
      valuetype = "EAttackImpactType"
    },
    isCrit={
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
    isDoubleHit={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isHit={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setImpactType={
      type = "method",
      args="(EAttackImpactType: type)",
      returns = "void",
      valuetype = "void"
    },
    getHpChanged={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    pushDoubleHitHp={
      type = "method",
      args="(int: hp)",
      returns = "void",
      valuetype = "void"
    },
    addHpChanged={
      type = "method",
      args="(int: hp)",
      returns = "int",
      valuetype = "int"
    },
  },
},

CCombatTempData = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CCombatTempData",
      valuetype = "CCombatTempData",
    },
    reset={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    canAttackTeammer={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

_ReliveInfo = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "_ReliveInfo",
      valuetype = "_ReliveInfo",
    },
  },
},

CAttackInfo = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CAttackInfo",
      valuetype = "CAttackInfo",
    },
  },
},

CCharFightCore = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CCharFightCore",
      valuetype = "CCharFightCore",
    },
    onAfterUseSkill={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    canBeAttack={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    useSkill={
      type = "method",
      args="(unsigned int: destObjUID,unsigned short: skillTypeID,short: x,short: y)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    setCharacter={
      type = "method",
      args="(CCharacterObject*: character)",
      returns = "void",
      valuetype = "void"
    },
    onBeforeHit={
      type = "method",
      args="(CCharacterObject*: character)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    attackBack={
      type = "method",
      args="(unsigned char: dir,unsigned short: range)",
      returns = "void",
      valuetype = "void"
    },
    isCommonSkillCdDown={
      type = "method",
      args="(unsigned short: skillID)",
      returns = "bool",
      valuetype = "bool"
    },
    getCombatState={
      type = "method",
      args="()",
      returns = "ECombatStateType",
      valuetype = "ECombatStateType"
    },
    onBeKill={
      type = "method",
      args="(CCharacterObject*: pDestObj)",
      returns = "void",
      valuetype = "void"
    },
    cleanLastCombatData={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    onBeUseSkill={
      type = "method",
      args="(CCharacterObject*: attackor,unsigned short: skill,bool: goodSkill)",
      returns = "bool",
      valuetype = "bool"
    },
    cleanUp={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    onAfterAttackOther={
      type = "method",
      args="(CCharacterObject*: pDestObj)",
      returns = "void",
      valuetype = "void"
    },
    setUnBeAttack={
      type = "method",
      args="(bool: flag)",
      returns = "void",
      valuetype = "void"
    },
    setActionBan={
      type = "method",
      args="(EActionBan: banType)",
      returns = "void",
      valuetype = "void"
    },
    canBeUseItem={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    relive={
      type = "method",
      args="(_ReliveInfo*: reliveInfo,CCharacterObject*: pChart)",
      returns = "bool",
      valuetype = "bool"
    },
    onRelive={
      type = "method",
      args="(unsigned int: caster)",
      returns = "void",
      valuetype = "void"
    },
    getCombatResult={
      type = "method",
      args="()",
      returns = "CCombatResult*",
      valuetype = "CCombatResult"
    },
    updateOutBlock={
      type = "method",
      args="(int: diff)",
      returns = "bool",
      valuetype = "bool"
    },
    onCombatStart={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    logState={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    canAttackMe={
      type = "method",
      args="(CCharacterObject*: pCharacter)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    isCombatEnd={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getLastAttackMeTime={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    setLastHurtOtherObjUID={
      type = "method",
      args="(unsigned int: objUID)",
      returns = "void",
      valuetype = "void"
    },
    init={
      type = "method",
      args="(_CharacterInit*: inits)",
      returns = "bool",
      valuetype = "bool"
    },
    logActionBan={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    onEnterArea={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getSkillCore={
      type = "method",
      args="()",
      returns = "CCharSkillCore*",
      valuetype = "CCharSkillCore"
    },
    getAssistantUID={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    setLastAttackMeTime={
      type = "method",
      args="(unsigned int: curTime)",
      returns = "void",
      valuetype = "void"
    },
    isCombatStart={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isSkillCoolDown={
      type = "method",
      args="(unsigned short: skillID)",
      returns = "bool",
      valuetype = "bool"
    },
    appendSkillBuff={
      type = "method",
      args="(CCharacterObject*: pCharacter,CSkillInfo*: skillInfo)",
      returns = "void",
      valuetype = "void"
    },
    onCombatChange={
      type = "method",
      args="(ECombatStateType: beforeState,ECombatStateType: curState)",
      returns = "void",
      valuetype = "void"
    },
    onStartAttackOther={
      type = "method",
      args="(CCharacterObject*: pDestObj)",
      returns = "void",
      valuetype = "void"
    },
    onAfterBeSkill={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    setLastAttackDieObjUID={
      type = "method",
      args="(unsigned int: objUID)",
      returns = "void",
      valuetype = "void"
    },
    update={
      type = "method",
      args="(int: diff)",
      returns = "bool",
      valuetype = "bool"
    },
    combatEnd={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    onCombatEnd={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    canMove={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    canAttackTeammer={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setLastHurtOtherObjType={
      type = "method",
      args="(EObjType: objType)",
      returns = "void",
      valuetype = "void"
    },
    onStateChange={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    resetReliveInfo={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    setReliveInfo={
      type = "method",
      args="(_ReliveInfo*: reliveInfo)",
      returns = "void",
      valuetype = "void"
    },
    clearActionBan={
      type = "method",
      args="(EActionBan: banType)",
      returns = "void",
      valuetype = "void"
    },
    getLastHurtMeObjUID={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    combatStart={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getLastHurtMeObjType={
      type = "method",
      args="()",
      returns = "EObjType",
      valuetype = "EObjType"
    },
    onHurt={
      type = "method",
      args="(int: hp,unsigned int: objUID)",
      returns = "void",
      valuetype = "void"
    },
    onActionBanChange={
      type = "method",
      args="(EActionBan: actionBan)",
      returns = "void",
      valuetype = "void"
    },
    onStartBeAttack={
      type = "method",
      args="(CCharacterObject*: pDestObj)",
      returns = "void",
      valuetype = "void"
    },
    onDie={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    checkAction={
      type = "method",
      args="(bool: moveFlag,bool: useSkillFlag,bool: beAttackFlag)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    onAttackChart={
      type = "method",
      args="(CCharacterObject*: pDestObj)",
      returns = "void",
      valuetype = "void"
    },
    getLastHurtOtherObjType={
      type = "method",
      args="()",
      returns = "EObjType",
      valuetype = "EObjType"
    },
    getLastAttackDieObjUID={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    onAfterBeAttack={
      type = "method",
      args="(CCharacterObject*: pDestObj)",
      returns = "void",
      valuetype = "void"
    },
    onKillObject={
      type = "method",
      args="(CCharacterObject*: pDestObj)",
      returns = "void",
      valuetype = "void"
    },
    getLastHurtOtherObjUID={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    canHit={
      type = "method",
      args="(CCharacterObject*: character)",
      returns = "bool",
      valuetype = "bool"
    },
    canUseSkill={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getReliveInfo={
      type = "method",
      args="()",
      returns = "_ReliveInfo*",
      valuetype = "_ReliveInfo"
    },
    canCrit={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

_ChartCampData = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "_ChartCampData",
      valuetype = "_ChartCampData",
    },
  },
},

CCharRelationCore = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CCharRelationCore",
      valuetype = "CCharRelationCore",
    },
    setCampID={
      type = "method",
      args="(int: campID)",
      returns = "void",
      valuetype = "void"
    },
    updateOutBlock={
      type = "method",
      args="(int: diff)",
      returns = "bool",
      valuetype = "bool"
    },
    setCharacter={
      type = "method",
      args="(CCharacterObject*: character)",
      returns = "void",
      valuetype = "void"
    },
    update={
      type = "method",
      args="(int: diff)",
      returns = "bool",
      valuetype = "bool"
    },
    isSameCamp={
      type = "method",
      args="(CCharacterObject*: obj)",
      returns = "bool",
      valuetype = "bool"
    },
    getCampData={
      type = "method",
      args="()",
      returns = "_ChartCampData*",
      valuetype = "_ChartCampData"
    },
    init={
      type = "method",
      args="(_CharacterInit*: inits)",
      returns = "bool",
      valuetype = "bool"
    },
    cleanUp={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getCampID={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    isTeamMember={
      type = "method",
      args="(CCharacterObject*: obj)",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

_ApproachObject = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "_ApproachObject",
      valuetype = "_ApproachObject",
    },
  },
},

ApproachObjectList = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "ApproachObjectList",
      valuetype = "ApproachObjectList",
    },
  },
},

CCharAICore = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CCharAICore",
      valuetype = "CCharAICore",
    },
    getCharacterAI={
      type = "method",
      args="()",
      returns = "CAICharacter*",
      valuetype = "CAICharacter"
    },
    updateOutBlock={
      type = "method",
      args="(int: diff)",
      returns = "bool",
      valuetype = "bool"
    },
    clearAllApproachMon={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    addApproachMon={
      type = "method",
      args="(unsigned int: objUID,EAddApproachObjectType: type)",
      returns = "void",
      valuetype = "void"
    },
    canBeApproach={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setCharacter={
      type = "method",
      args="(CCharacterObject*: character)",
      returns = "void",
      valuetype = "void"
    },
    setCharacterAI={
      type = "method",
      args="(CAICharacter*: charAI)",
      returns = "void",
      valuetype = "void"
    },
    delApproachByEnemy={
      type = "method",
      args="(unsigned int: objUID)",
      returns = "void",
      valuetype = "void"
    },
    update={
      type = "method",
      args="(int: diff)",
      returns = "bool",
      valuetype = "bool"
    },
    onDamageTarget={
      type = "method",
      args="(int: nDamage,CCharacterObject*: rTar,unsigned short: nSkillID)",
      returns = "void",
      valuetype = "void"
    },
    init={
      type = "method",
      args="(_CharacterInit*: inits)",
      returns = "bool",
      valuetype = "bool"
    },
    cleanUp={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    onDamage={
      type = "method",
      args="(int: nDamage,unsigned int: nAttackerID,bool: bCritical,unsigned short: nSkillID)",
      returns = "void",
      valuetype = "void"
    },
    delApproachMon={
      type = "method",
      args="(unsigned int: objUID,EDelApproachObjectType: type)",
      returns = "void",
      valuetype = "void"
    },
    needDropApproach={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getApproachMonSize={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    onAddApproach={
      type = "method",
      args="(unsigned int: objUID)",
      returns = "void",
      valuetype = "void"
    },
    onDelApproach={
      type = "method",
      args="(unsigned int: objUID)",
      returns = "void",
      valuetype = "void"
    },
  },
},

CCharacterObject = {
  type = "class",
  inherits = "CDynamicObject CCharAttributeCoreExt CCharMoveCore CCharSkillCore CCharFightCore CCharRelationCore CCharAICore ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CCharacterObject",
      valuetype = "CCharacterObject",
    },
    toRoleBase={
      type = "method",
      args="()",
      returns = "CRoleBase*",
      valuetype = "CRoleBase"
    },
    updateOutBlock={
      type = "method",
      args="(int: diff)",
      returns = "bool",
      valuetype = "bool"
    },
    getRoleBaseOwner={
      type = "method",
      args="()",
      returns = "CRoleBase*",
      valuetype = "CRoleBase"
    },
    getOwner={
      type = "method",
      args="()",
      returns = "CCharacterObject*",
      valuetype = "CCharacterObject"
    },
    setOwnerUID={
      type = "method",
      args="(unsigned int: objUID)",
      returns = "void",
      valuetype = "void"
    },
    resetPos={
      type = "method",
      args="(AxisPos*: pos,EResetPosType: type,bool: broadFlag,bool: randFlag)",
      returns = "void",
      valuetype = "void"
    },
    setDie={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    update={
      type = "method",
      args="(int: diff)",
      returns = "bool",
      valuetype = "bool"
    },
    onLeaveScene={
      type = "method",
      args="(CMapSceneBase*: pScene)",
      returns = "void",
      valuetype = "void"
    },
    onEnterScene={
      type = "method",
      args="(CMapSceneBase*: pScene)",
      returns = "void",
      valuetype = "void"
    },
    init={
      type = "method",
      args="(_CharacterInit*: inits)",
      returns = "bool",
      valuetype = "bool"
    },
    cleanUp={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getOwnerUID={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    isDie={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isTimeToLeaveScene={
      type = "method",
      args="(unsigned int: curTime)",
      returns = "bool",
      valuetype = "bool"
    },
    getLogicTime={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    onRegisterToBlock={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
  },
},

CGameServerSocketPacketHandler = {
  type = "class",
  inherits = "CGameSocketPacketHandler ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CGameServerSocketPacketHandler",
      valuetype = "CGameServerSocketPacketHandler",
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
  },
},

MCEnterGameRet = {
  type = "class",
  inherits = "CResponsePacket IStreamableStaticAll<MCEnterGameRet> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCEnterGameRet",
      valuetype = "MCEnterGameRet",
    },
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    Unpacket={
      type = "method",
      args="(MCEnterGameRet*: pBase,char*: buff,int: len)",
      returns = "bool",
      valuetype = "bool"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
  },
},

CMapPlayerHandlerBase = {
  type = "class",
  inherits = "CScriptSocketHandler ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMapPlayerHandlerBase",
      valuetype = "CMapPlayerHandlerBase",
    },
    getLastHeartTime={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    getWorldPlayerSockIndex={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    getAccountID={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    onBeforeHandlePacket={
      type = "method",
      args="(CBasePacket*: packet)",
      returns = "bool",
      valuetype = "bool"
    },
    doCloseWaitReconnect={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    breath={
      type = "method",
      args="(int: diff)",
      returns = "void",
      valuetype = "void"
    },
    setHeartOutDiffTime={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    handlePlayerHeart={
      type = "method",
      args="(MCPlayerHeart*: packet)",
      returns = "EHandleRet",
      valuetype = "EHandleRet"
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
    setLastSendHeartTime={
      type = "method",
      args="(unsigned int: val)",
      returns = "void",
      valuetype = "void"
    },
    setRoleInfo={
      type = "method",
      args="(unsigned long long: accountID,unsigned long long: roleUID,unsigned int: objUID)",
      returns = "void",
      valuetype = "void"
    },
    quit={
      type = "method",
      args="(int: sockWaitTime)",
      returns = "void",
      valuetype = "void"
    },
    setHeartDiffTime={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    getLastSendHeartTime={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    getRoleUID={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    start={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getHeartDiffTime={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    toString={
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
    checkPlayerHeart={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    setWorldPlayerSockIndex={
      type = "method",
      args="(unsigned long long: index)",
      returns = "void",
      valuetype = "void"
    },
    getRole={
      type = "method",
      args="(EManagerQueType: type)",
      returns = "CRoleBase*",
      valuetype = "CRoleBase"
    },
    setRoleUID={
      type = "method",
      args="(unsigned long long: roleUID)",
      returns = "void",
      valuetype = "void"
    },
    setLastHeartTime={
      type = "method",
      args="(unsigned int: val)",
      returns = "void",
      valuetype = "void"
    },
    isNeedFreeWorldRole={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getHeartOutDiffTime={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    initData={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getObjUID={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    isHeartOutTime={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setObjUID={
      type = "method",
      args="(unsigned int: objUID)",
      returns = "void",
      valuetype = "void"
    },
    doPlayerHeart={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    isNeedSendHeart={
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
  },
},

WMUpdateServer = {
  type = "class",
  inherits = "CServerPacket IStreamableStaticAll<WMUpdateServer> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "WMUpdateServer",
      valuetype = "WMUpdateServer",
    },
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    Unpacket={
      type = "method",
      args="(WMUpdateServer*: pBase,char*: buff,int: len)",
      returns = "bool",
      valuetype = "bool"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
  },
},

WMRoleHeartRet = {
  type = "class",
  inherits = "CResponsePacket IStreamableStaticAll<WMRoleHeartRet> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "WMRoleHeartRet",
      valuetype = "WMRoleHeartRet",
    },
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    Unpacket={
      type = "method",
      args="(WMRoleHeartRet*: pBase,char*: buff,int: len)",
      returns = "bool",
      valuetype = "bool"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
  },
},

MWAnnoucement = {
  type = "class",
  inherits = "CServerPacket IStreamableStaticAll<MWAnnoucement> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MWAnnoucement",
      valuetype = "MWAnnoucement",
    },
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    Unpacket={
      type = "method",
      args="(MWAnnoucement*: pBase,char*: buff,int: len)",
      returns = "bool",
      valuetype = "bool"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
  },
},

CMapWorldServerHandlerBase = {
  type = "class",
  inherits = "CGameSocketHandler<CMapWorldServerHandlerBase> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMapWorldServerHandlerBase",
      valuetype = "CMapWorldServerHandlerBase",
    },
    sendRegisteToWorld={
      type = "method",
      args="(unsigned short: serverID,EServerType: serverType,unsigned int: maxRoleNum,CFixString<20>: ip,unsigned short: port)",
      returns = "void",
      valuetype = "void"
    },
    quit={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    doBroadCast={
      type = "method",
      args="(CBasePacket*: packet,unsigned int: srcObjUID)",
      returns = "ETransCode",
      valuetype = "ETransCode"
    },
    handleRoleHeartRet={
      type = "method",
      args="(WMRoleHeartRet*: packet)",
      returns = "EHandleRet",
      valuetype = "EHandleRet"
    },
    handleRegisteToWorldRet={
      type = "method",
      args="(WMRegisteRet*: packet)",
      returns = "EHandleRet",
      valuetype = "EHandleRet"
    },
    handleRename={
      type = "method",
      args="(WMRenameRoleNameRet*: packet)",
      returns = "EHandleRet",
      valuetype = "EHandleRet"
    },
    handleTransError={
      type = "method",
      args="(WMTransPacketError*: packet)",
      returns = "EHandleRet",
      valuetype = "EHandleRet"
    },
    doTransError={
      type = "method",
      args="(CBasePacket*: packet,unsigned int: srcObjUID,unsigned int: destObjUID,EGameRetCode: retCode)",
      returns = "void",
      valuetype = "void"
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
    handleTrans={
      type = "method",
      args="(MWTransPacket*: packet)",
      returns = "EHandleRet",
      valuetype = "EHandleRet"
    },
    doTrans={
      type = "method",
      args="(CBasePacket*: packet,unsigned int: srcObjUID,unsigned int: destObjUID)",
      returns = "ETransCode",
      valuetype = "ETransCode"
    },
    close={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    handleServerInfo={
      type = "method",
      args="(WMServerInfo*: packet)",
      returns = "EHandleRet",
      valuetype = "EHandleRet"
    },
    handleBroadCast={
      type = "method",
      args="(MWBroadPacket*: packet)",
      returns = "EHandleRet",
      valuetype = "EHandleRet"
    },
    IsActive={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

CRoleBase = {
  type = "class",
  inherits = "CCharacterObject ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CRoleBase",
      valuetype = "CRoleBase",
    },
    isReady={
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
    setAccountID={
      type = "method",
      args="(unsigned long long: val)",
      returns = "void",
      valuetype = "void"
    },
    getLoginLastTime={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    isEnter={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getIsAdult={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getLoginTime={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    onUpdateReadyQue={
      type = "method",
      args="(int: diff)",
      returns = "void",
      valuetype = "void"
    },
    key3ToString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    setEnterGameTime={
      type = "method",
      args="(unsigned int: val)",
      returns = "void",
      valuetype = "void"
    },
    onLeaveScene={
      type = "method",
      args="(CMapSceneBase*: pScene)",
      returns = "void",
      valuetype = "void"
    },
    setLastAgainstIndulgeTime={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    init={
      type = "method",
      args="(_CharacterInit*: inits)",
      returns = "bool",
      valuetype = "bool"
    },
    isKey2={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getQuitRet={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    resetLogoutTime={
      type = "method",
      args="(unsigned int: seconds)",
      returns = "void",
      valuetype = "void"
    },
    setIPAddress={
      type = "method",
      args="(string: straddress)",
      returns = "void",
      valuetype = "void"
    },
    setRoleUID={
      type = "method",
      args="(unsigned long long: val)",
      returns = "void",
      valuetype = "void"
    },
    getLastAgainstIndulgeNoticeTime={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    setIsOffOverDay={
      type = "method",
      args="(bool: val)",
      returns = "void",
      valuetype = "void"
    },
    onAddToEnter={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getDbHandlerBase={
      type = "method",
      args="(bool: logFlag)",
      returns = "CMapDbPlayerHandlerBase*",
      valuetype = "CMapDbPlayerHandlerBase"
    },
    getDbIndex={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    onHourTimer={
      type = "method",
      args="(char: hour)",
      returns = "void",
      valuetype = "void"
    },
    key2ToString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    getLoginPlayerSocketIndex={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    onRemoveFromEnter={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    setKey3={
      type = "method",
      args="(unsigned long long: key)",
      returns = "void",
      valuetype = "void"
    },
    onAddToReady={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setDbSaveIndex={
      type = "method",
      args="(unsigned int: index)",
      returns = "void",
      valuetype = "void"
    },
    waitReconnect={
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
    setGmPower={
      type = "method",
      args="(unsigned char: val)",
      returns = "void",
      valuetype = "void"
    },
    setKey2={
      type = "method",
      args="(unsigned int: key)",
      returns = "void",
      valuetype = "void"
    },
    setLastAgainstIndulgeNoticeTime={
      type = "method",
      args="(unsigned int: val)",
      returns = "void",
      valuetype = "void"
    },
    getUpdateSaveDirty={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getPlayerHandlerBase={
      type = "method",
      args="(bool: logFlag)",
      returns = "CMapPlayerHandlerBase*",
      valuetype = "CMapPlayerHandlerBase"
    },
    getDbSaveIndex={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    getLastAgainstIndulgeTime={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    onEnterScene={
      type = "method",
      args="(CMapSceneBase*: pScene)",
      returns = "void",
      valuetype = "void"
    },
    setQuitRet={
      type = "method",
      args="(bool: retFlag)",
      returns = "void",
      valuetype = "void"
    },
    getStatus={
      type = "method",
      args="()",
      returns = "ERoleStatus",
      valuetype = "ERoleStatus"
    },
    setDbIndex={
      type = "method",
      args="(unsigned long long: dbIndex)",
      returns = "void",
      valuetype = "void"
    },
    getLogoutLastTime={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    onAddToLogout={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getIPAddress={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    onLogout={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isTimeOutForReady={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getKey3={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    getKey2={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    on12Timer={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    onRemoveFromReady={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getKey={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    addRoleToLogout={
      type = "method",
      args="(unsigned int: secs)",
      returns = "void",
      valuetype = "void"
    },
    isLogout={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    onEnter={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
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
    getLastSaveTime={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    on0Timer={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    cleanUp={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    isCanViewMe={
      type = "method",
      args="(CGameObject*: pObj)",
      returns = "bool",
      valuetype = "bool"
    },
    setRoleName={
      type = "method",
      args="(string: roleName)",
      returns = "void",
      valuetype = "void"
    },
    setStatus={
      type = "method",
      args="(ERoleStatus: val)",
      returns = "void",
      valuetype = "void"
    },
    getLogoutTime={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    setSceneGroupID={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    quitGame={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    quit={
      type = "method",
      args="(bool: forceQuit,char*: quitResult,int: sockWaitTime)",
      returns = "void",
      valuetype = "void"
    },
    setManagerQueType={
      type = "method",
      args="(EManagerQueType: type)",
      returns = "void",
      valuetype = "void"
    },
    onLogoutTimeout={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getDbHandlerTag={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    setLoginPlayerSocketIndex={
      type = "method",
      args="(unsigned long long: index)",
      returns = "void",
      valuetype = "void"
    },
    onUpdateEnterQue={
      type = "method",
      args="(int: diff)",
      returns = "void",
      valuetype = "void"
    },
    getIsOffOverDay={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    onIdle={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getRoleUIDString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    setLogoutLastTime={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    getSocketIndex={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    directKick={
      type = "method",
      args="(bool: needSave,bool: delFromMgr,bool: needRet,EKickType: kickType)",
      returns = "void",
      valuetype = "void"
    },
    onRename={
      type = "method",
      args="(EGameRetCode: retCode)",
      returns = "void",
      valuetype = "void"
    },
    setLastSaveTime={
      type = "method",
      args="(unsigned int: times)",
      returns = "void",
      valuetype = "void"
    },
    isKey={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getEnterGameTime={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    getGroupID={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getSceneGroupID={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    setLogoutTime={
      type = "method",
      args="(unsigned int: val)",
      returns = "void",
      valuetype = "void"
    },
    updateOutBlock={
      type = "method",
      args="(int: diff)",
      returns = "bool",
      valuetype = "bool"
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
      args="(unsigned long long: key)",
      returns = "void",
      valuetype = "void"
    },
    setSocketIndex={
      type = "method",
      args="(unsigned long long: sockIndex)",
      returns = "void",
      valuetype = "void"
    },
    addRoleToReady={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getManagerQueType={
      type = "method",
      args="()",
      returns = "EManagerQueType",
      valuetype = "EManagerQueType"
    },
    setLoginLastTime={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    update={
      type = "method",
      args="(int: diff)",
      returns = "bool",
      valuetype = "bool"
    },
    setIsAdult={
      type = "method",
      args="(bool: val)",
      returns = "void",
      valuetype = "void"
    },
    setUpdateSaveDirty={
      type = "method",
      args="(bool: dirty)",
      returns = "void",
      valuetype = "void"
    },
    setLoginTime={
      type = "method",
      args="(unsigned int: val)",
      returns = "void",
      valuetype = "void"
    },
    isTimeOutForLogout={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getRoleNode={
      type = "method",
      args="()",
      returns = "_ObjListNode*",
      valuetype = "_ObjListNode"
    },
    onRemoveFromLogout={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    onLoginTimeout={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
  },
},

CDBLoadBase = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CDBLoadBase",
      valuetype = "CDBLoadBase",
    },
    getLock={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setLock={
      type = "method",
      args="(bool: isLock)",
      returns = "bool",
      valuetype = "bool"
    },
    getRoleUID={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    init={
      type = "method",
      args="(unsigned long long: roleUID,CHumanDB*: human)",
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
  inherits = "IStreamableAll ",
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
  inherits = "IStreamableAll ",
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

CHumanMissionData = {
  type = "class",
  inherits = "TDBStructBase ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CHumanMissionData",
      valuetype = "CHumanMissionData",
    },
  },
},

CHumanBaseData = {
  type = "class",
  inherits = "TDBStructBase ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CHumanBaseData",
      valuetype = "CHumanBaseData",
    },
    setStrength={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    setMapID={
      type = "method",
      args="(unsigned short: val)",
      returns = "void",
      valuetype = "void"
    },
    getBindRmb={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    setbagOpenGridNum={
      type = "method",
      args="(unsigned char: val)",
      returns = "void",
      valuetype = "void"
    },
    getCreateTime={
      type = "method",
      args="()",
      returns = "CGameTime",
      valuetype = "CGameTime"
    },
    getAccountID={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    getRmb={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    setLogoutTime={
      type = "method",
      args="(unsigned int: val)",
      returns = "void",
      valuetype = "void"
    },
    getVipExp={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getStrength={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    setGameMoney={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    getbagOpenGridNum={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    isNewRole={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getGameMoney={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    setObjUID={
      type = "method",
      args="(unsigned int: val)",
      returns = "void",
      valuetype = "void"
    },
    setLastSceneID={
      type = "method",
      args="(unsigned long long: val)",
      returns = "void",
      valuetype = "void"
    },
    setLastMapPos={
      type = "method",
      args="(AxisPos*: val)",
      returns = "void",
      valuetype = "void"
    },
    setRoleName={
      type = "method",
      args="(string: val)",
      returns = "void",
      valuetype = "void"
    },
    getLogoutTime={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    setAccountID={
      type = "method",
      args="(unsigned long long: val)",
      returns = "void",
      valuetype = "void"
    },
    getSource_way={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    setChisource_way={
      type = "method",
      args="(string: val)",
      returns = "void",
      valuetype = "void"
    },
    getLastMapID={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    setSource_way={
      type = "method",
      args="(string: val)",
      returns = "void",
      valuetype = "void"
    },
    getOfflineOverunDays={
      type = "method",
      args="(char: hour,char: mins,char: seconds)",
      returns = "int",
      valuetype = "int"
    },
    getMapID={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    getLevel={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    setMapPos={
      type = "method",
      args="(AxisPos*: val)",
      returns = "void",
      valuetype = "void"
    },
    getRoleUID={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    getMapPos={
      type = "method",
      args="()",
      returns = "AxisPos*",
      valuetype = "AxisPos"
    },
    getLastMapPos={
      type = "method",
      args="()",
      returns = "AxisPos*",
      valuetype = "AxisPos"
    },
    getSceneID={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    setRoleUID={
      type = "method",
      args="(unsigned long long: val)",
      returns = "void",
      valuetype = "void"
    },
    getLastSceneID={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    setBindRmb={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    addChargeRmb={
      type = "method",
      args="(int: val)",
      returns = "int",
      valuetype = "int"
    },
    setLastMapID={
      type = "method",
      args="(unsigned short: val)",
      returns = "void",
      valuetype = "void"
    },
    setLevel={
      type = "method",
      args="(unsigned char: val)",
      returns = "void",
      valuetype = "void"
    },
    getLoginCountOneDay={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getObjUID={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    setExp={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    getChisource_way={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    setProtypeID={
      type = "method",
      args="(unsigned char: val)",
      returns = "void",
      valuetype = "void"
    },
    getTotalChargeRmb={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    setSceneID={
      type = "method",
      args="(unsigned long long: val)",
      returns = "void",
      valuetype = "void"
    },
    getExp={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getRoleName={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    setRmb={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    setCreateTime={
      type = "method",
      args="(CGameTime: val)",
      returns = "void",
      valuetype = "void"
    },
    getProtypeID={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    setTotalChargeRmb={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    setLoginCountOneDay={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    getVipLevel={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
  },
},

CHumanDBData = {
  type = "class",
  inherits = "TDBStructBase ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CHumanDBData",
      valuetype = "CHumanDBData",
    },
    getUserData={
      type = "method",
      args="(CWorldUserData*: data)",
      returns = "void",
      valuetype = "void"
    },
  },
},

CHumanDBMissionLoad = {
  type = "class",
  inherits = "CDBLoadBase ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CHumanDBMissionLoad",
      valuetype = "CHumanDBMissionLoad",
    },
    cleanUp={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    initData={
      type = "method",
      args="(CHumanMissionData*: data)",
      returns = "void",
      valuetype = "void"
    },
  },
},

CHumanDB = {
  type = "class",
  inherits = "CDBLoadBase ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CHumanDB",
      valuetype = "CHumanDB",
    },
    initBufferData={
      type = "method",
      args="(char*: buffer,int: len)",
      returns = "void",
      valuetype = "void"
    },
    setDataBuffer={
      type = "method",
      args="(char*: buff,int: len)",
      returns = "void",
      valuetype = "void"
    },
    initHumanDBBackup={
      type = "method",
      args="(CHumanDBBackup*: dbData)",
      returns = "void",
      valuetype = "void"
    },
    initLoad={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getDataBuffer={
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
    setSaveDataType={
      type = "method",
      args="(ESaveRoleType: val)",
      returns = "void",
      valuetype = "void"
    },
    getHumanDbData={
      type = "method",
      args="()",
      returns = "CHumanDBData*",
      valuetype = "CHumanDBData"
    },
    initData={
      type = "method",
      args="(CHumanDBData*: dbData)",
      returns = "void",
      valuetype = "void"
    },
    dumpFromFile={
      type = "method",
      args="(string: path)",
      returns = "bool",
      valuetype = "bool"
    },
    getBaseData={
      type = "method",
      args="()",
      returns = "CHumanBaseData*",
      valuetype = "CHumanBaseData"
    },
    cleanUp={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getSaveDataType={
      type = "method",
      args="()",
      returns = "ESaveRoleType",
      valuetype = "ESaveRoleType"
    },
    toString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    dumpToFile={
      type = "method",
      args="(string: path)",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

CHumanDBBackup = {
  type = "class",
  inherits = "CHumanDB ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CHumanDBBackup",
      valuetype = "CHumanDBBackup",
    },
    initHumanData={
      type = "method",
      args="(CHumanDB*: data)",
      returns = "void",
      valuetype = "void"
    },
  },
},

CModBag = {
  type = "class",
  inherits = "CGameRoleModule ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CModBag",
      valuetype = "CModBag",
    },
    isFullBagGuird={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    onLoad={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getEmptyGirdNum={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    isFullBag={
      type = "method",
      args="(unsigned short: itemTypeID,short: itemNum)",
      returns = "bool",
      valuetype = "bool"
    },
    onSendData={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    onSave={
      type = "method",
      args="(bool: offLineFlag)",
      returns = "void",
      valuetype = "void"
    },
    getBag={
      type = "method",
      args="()",
      returns = "CItemContainer*",
      valuetype = "CItemContainer"
    },
    findBagtype={
      type = "method",
      args="(EPackType: bagtype)",
      returns = "CItemContainer*",
      valuetype = "CItemContainer"
    },
  },
},

CModBuffer = {
  type = "class",
  inherits = "CGameRoleModule ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CModBuffer",
      valuetype = "CModBuffer",
    },
    onLoad={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    onSave={
      type = "method",
      args="(bool: offLineFlag)",
      returns = "void",
      valuetype = "void"
    },
    onSendData={
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
  },
},

AttrBackupBase = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "AttrBackupBase",
      valuetype = "AttrBackupBase",
    },
    init={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getSyncData={
      type = "method",
      args="()",
      returns = "MCSyncRoleData*",
      valuetype = "MCSyncRoleData"
    },
    setObjUID={
      type = "method",
      args="(unsigned int: uid)",
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

RoleAttrBackup = {
  type = "class",
  inherits = "AttrBackupBase ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "RoleAttrBackup",
      valuetype = "RoleAttrBackup",
    },
    getValue={
      type = "method",
      args="(unsigned char: type)",
      returns = "int",
      valuetype = "int"
    },
    isEqual={
      type = "method",
      args="(unsigned char: type,int: val)",
      returns = "bool",
      valuetype = "bool"
    },
    setValue={
      type = "method",
      args="(unsigned char: type,int: val)",
      returns = "void",
      valuetype = "void"
    },
  },
},

_MonsterAttrBackup = {
  type = "class",
  inherits = "TAttrBackupBase ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "_MonsterAttrBackup",
      valuetype = "_MonsterAttrBackup",
    },
    cleanUp={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
  },
},

_MissionKills = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "_MissionKills",
      valuetype = "_MissionKills",
    },
  },
},

_MissionItem = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "_MissionItem",
      valuetype = "_MissionItem",
    },
  },
},

CMissionConfigTbl = {
  type = "class",
  inherits = "CConfigTbl ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMissionConfigTbl",
      valuetype = "CMissionConfigTbl",
    },
    isDialog={
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
    checkConfig={
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
    initConfig={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getKey={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    isGuanQia={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setKey={
      type = "method",
      args="(unsigned short: key)",
      returns = "void",
      valuetype = "void"
    },
    toString={
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
    isKillMonster={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

CMissionTblLoader = {
  type = "class",
  inherits = "CConfigLoader<CMissionTblLoader, CMissionConfigTbl> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMissionTblLoader",
      valuetype = "CMissionTblLoader",
    },
    readRow={
      type = "method",
      args="(TiXmlElement*: row,int: count,CMissionConfigTbl*: missionRow)",
      returns = "bool",
      valuetype = "bool"
    },
    findByKey={
      type = "method",
      args="(unsigned short: key)",
      returns = "CMissionConfigTbl*",
      valuetype = "CMissionConfigTbl"
    },
    GetPtr={
      type = "method",
      args="()",
      returns = "CMissionTblLoader*",
      valuetype = "CMissionTblLoader"
    },
  },
},

_MissionDropItem = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "_MissionDropItem",
      valuetype = "_MissionDropItem",
    },
  },
},

_OwnMission = {
  type = "class",
  inherits = "TMissionBase ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "_OwnMission",
      valuetype = "_OwnMission",
    },
    getRemainItem={
      type = "method",
      args="(unsigned short: itemTypeID)",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    getMissionRow={
      type = "method",
      args="()",
      returns = "CMissionConfigTbl*",
      valuetype = "CMissionConfigTbl"
    },
    isItemFull={
      type = "method",
      args="(CRole*: pRole)",
      returns = "bool",
      valuetype = "bool"
    },
    isFinish={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

CModMission = {
  type = "class",
  inherits = "CGameRoleModule ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CModMission",
      valuetype = "CModMission",
    },
    getAcceptMissionPtrMap={
      type = "method",
      args="()",
      returns = "map<unsigned short, _OwnMission *, less<unsigned short>, allocator<pair<const unsigned short, _OwnMission *> > >",
      valuetype = "map<unsigned short, _OwnMission , less<unsigned short>, allocator<pair<const unsigned short, _OwnMission > > >"
    },
    onNpcDlg={
      type = "method",
      args="(unsigned short: npcID)",
      returns = "void",
      valuetype = "void"
    },
    awardExp={
      type = "method",
      args="(CRole*: pRole,int: exp)",
      returns = "void",
      valuetype = "void"
    },
    addGuanQiaCall={
      type = "method",
      args="(_OwnMission*: mission)",
      returns = "void",
      valuetype = "void"
    },
    isCollectItem={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isKillMonster={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    deleteFromAcceptMission={
      type = "method",
      args="(unsigned short: missionTypeID)",
      returns = "void",
      valuetype = "void"
    },
    rebuildItemFunc={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    onDesItem={
      type = "method",
      args="(unsigned short: itemTypeID,short: itemNum)",
      returns = "void",
      valuetype = "void"
    },
    sendDelMission={
      type = "method",
      args="(unsigned short: missionID)",
      returns = "void",
      valuetype = "void"
    },
    getTaskItemRemainNum={
      type = "method",
      args="(unsigned short: itemID)",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    isExist={
      type = "method",
      args="(unsigned short: missionID)",
      returns = "bool",
      valuetype = "bool"
    },
    sendUpdateParams={
      type = "method",
      args="(_OwnMission*: mission)",
      returns = "void",
      valuetype = "void"
    },
    sendAcceptableMission={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    submitMission={
      type = "method",
      args="(unsigned short: missionID)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    setLastFinishMissionID={
      type = "method",
      args="(unsigned short: missionTypeID)",
      returns = "void",
      valuetype = "void"
    },
    submitNormalGains={
      type = "method",
      args="(CMissionConfigTbl*: missionRow)",
      returns = "void",
      valuetype = "void"
    },
    submitConsume={
      type = "method",
      args="(CMissionConfigTbl*: missionRow)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    onSendData={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    onAddItem={
      type = "method",
      args="(unsigned short: itemTypeID,short: itemNum)",
      returns = "void",
      valuetype = "void"
    },
    onSave={
      type = "method",
      args="(bool: offLineFlag)",
      returns = "void",
      valuetype = "void"
    },
    init={
      type = "method",
      args="(CRole*: role)",
      returns = "bool",
      valuetype = "bool"
    },
    addCall={
      type = "method",
      args="(_OwnMission*: mission,bool: rebuildEventFlag)",
      returns = "void",
      valuetype = "void"
    },
    acceptMission={
      type = "method",
      args="(unsigned short: missionID)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    isDialog={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    onLoad={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    checkSubmit={
      type = "method",
      args="(_OwnMission*: mission)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    isEvent={
      type = "method",
      args="(EMissionEvent: events)",
      returns = "bool",
      valuetype = "bool"
    },
    rebuildKillMonsterFunc={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    addKillCall={
      type = "method",
      args="(_OwnMission*: mission)",
      returns = "void",
      valuetype = "void"
    },
    checkAccept={
      type = "method",
      args="(CMissionConfigTbl*: missionRow)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    rebuildData={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    isTaksItem={
      type = "method",
      args="(unsigned short: itemID)",
      returns = "bool",
      valuetype = "bool"
    },
    rebuildEvent={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    addToAcceptMission={
      type = "method",
      args="(_OwnMission*: mission)",
      returns = "void",
      valuetype = "void"
    },
    afterAccept={
      type = "method",
      args="(_OwnMission*: mission)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    sendAcceptedMission={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    addItemCall={
      type = "method",
      args="(_OwnMission*: mission)",
      returns = "void",
      valuetype = "void"
    },
    rebuildNpcDlgFunc={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    rebuildGuanQiaFunc={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    sendUpdateMission={
      type = "method",
      args="(_OwnMission*: mission)",
      returns = "void",
      valuetype = "void"
    },
    addDlgCall={
      type = "method",
      args="(_OwnMission*: mission)",
      returns = "void",
      valuetype = "void"
    },
    onOffline={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    isGuanQia={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    onFinishChapter={
      type = "method",
      args="(int: chapterTypeID)",
      returns = "void",
      valuetype = "void"
    },
    onMonsterKill={
      type = "method",
      args="(unsigned short: monsterTypeID,int: num)",
      returns = "void",
      valuetype = "void"
    },
    sendUpdateFinish={
      type = "method",
      args="(_OwnMission*: mission)",
      returns = "void",
      valuetype = "void"
    },
    submitGains={
      type = "method",
      args="(CMissionConfigTbl*: missionRow)",
      returns = "void",
      valuetype = "void"
    },
  },
},

CNewRoleTbl = {
  type = "class",
  inherits = "CConfigTbl ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CNewRoleTbl",
      valuetype = "CNewRoleTbl",
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

CNewRoleTblLoader = {
  type = "class",
  inherits = "CConfigLoader<CNewRoleTblLoader, CNewRoleTbl> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CNewRoleTblLoader",
      valuetype = "CNewRoleTblLoader",
    },
    getRow={
      type = "method",
      args="()",
      returns = "CNewRoleTbl*",
      valuetype = "CNewRoleTbl"
    },
    readRow={
      type = "method",
      args="(TiXmlElement*: row,int: count,CNewRoleTbl*: destRow)",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

CLimitManager = {
  type = "class",
  inherits = "CSingleton<CLimitManager> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CLimitManager",
      valuetype = "CLimitManager",
    },
    deleteLimitAccount={
      type = "method",
      args="(int: uniqueId)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    addLimitAccount={
      type = "method",
      args="(LimitAccountInfo*: data)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    isExistLimitChatInfo={
      type = "method",
      args="(LimitChatInfo*: data)",
      returns = "bool",
      valuetype = "bool"
    },
    checkLimitChat={
      type = "method",
      args="(unsigned long long: accountID)",
      returns = "bool",
      valuetype = "bool"
    },
    addLimitAccountMap={
      type = "method",
      args="(LimitAccountInfo*: data)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    addLimitChat={
      type = "method",
      args="(LimitChatInfo*: data)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    updateLimitChat={
      type = "method",
      args="(LimitChatInfo*: data)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    initLimitChatList={
      type = "method",
      args="(CArray<LimitChatDB, 50, unsigned char>*: dataary)",
      returns = "void",
      valuetype = "void"
    },
    update={
      type = "method",
      args="(unsigned int: diff)",
      returns = "void",
      valuetype = "void"
    },
    deleteLinitChat={
      type = "method",
      args="(int: uniqueId)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    loadLimitInfoFromDB={
      type = "method",
      args="(vector<LimitAccountInfo, allocator<LimitAccountInfo> >*: data)",
      returns = "bool",
      valuetype = "bool"
    },
    isExistLimitAccountInfo={
      type = "method",
      args="(LimitAccountInfo*: data)",
      returns = "bool",
      valuetype = "bool"
    },
    initLimitAccountIDList={
      type = "method",
      args="(CArray<LimitAccountDB, 50, unsigned char>*: dataary)",
      returns = "void",
      valuetype = "void"
    },
    isForbbidChat={
      type = "method",
      args="(unsigned long long: id)",
      returns = "bool",
      valuetype = "bool"
    },
    findLimitChatPos={
      type = "method",
      args="(int: uniqueId)",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    updateLimitAccount={
      type = "method",
      args="(LimitAccountInfo*: data)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    findLimitAccountPos={
      type = "method",
      args="(int: uniqueId)",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    addLimitChatMap={
      type = "method",
      args="(LimitChatInfo*: data)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
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

CConstantTbl = {
  type = "class",
  inherits = "CConfigTbl ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CConstantTbl",
      valuetype = "CConstantTbl",
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
    getKey2={
      type = "method",
      args="()",
      returns = "CCharArray2<250>",
      valuetype = "CCharArray2<250>"
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
    setKey2={
      type = "method",
      args="(CCharArray2<250>: key)",
      returns = "void",
      valuetype = "void"
    },
  },
},

CConstantTblLoader = {
  type = "class",
  inherits = "CConfigLoader2<CConstantTblLoader, CConstantTbl> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CConstantTblLoader",
      valuetype = "CConstantTblLoader",
    },
    readRow={
      type = "method",
      args="(TiXmlElement*: row,int: count,CConstantTbl*: destRow)",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

FightRecord = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "FightRecord",
      valuetype = "FightRecord",
    },
    openGuanQiaFight={
      type = "method",
      args="(int: chapterTypeID,unsigned short: mapID)",
      returns = "void",
      valuetype = "void"
    },
    cleanUp={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    isGuanQiaFight={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isFight={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

CModFight = {
  type = "class",
  inherits = "CGameRoleModule ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CModFight",
      valuetype = "CModFight",
    },
    getFightRecrod={
      type = "method",
      args="()",
      returns = "FightRecord*",
      valuetype = "FightRecord"
    },
  },
},

CTransportConfigTbl = {
  type = "class",
  inherits = "CConfigTbl ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CTransportConfigTbl",
      valuetype = "CTransportConfigTbl",
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
    setKey={
      type = "method",
      args="(int: key)",
      returns = "void",
      valuetype = "void"
    },
    toString={
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
    getKey={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
  },
},

CTransportTblLoader = {
  type = "class",
  inherits = "CConfigLoader<CTransportTblLoader, CTransportConfigTbl> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CTransportTblLoader",
      valuetype = "CTransportTblLoader",
    },
    getDestPos={
      type = "method",
      args="(int: id,unsigned short: mapID,AxisPos: pos)",
      returns = "bool",
      valuetype = "bool"
    },
    findByKey={
      type = "method",
      args="(int: key)",
      returns = "CTransportConfigTbl*",
      valuetype = "CTransportConfigTbl"
    },
    readRow={
      type = "method",
      args="(TiXmlElement*: row,int: count,CTransportConfigTbl*: destRow)",
      returns = "bool",
      valuetype = "bool"
    },
    GetPtr={
      type = "method",
      args="()",
      returns = "CTransportTblLoader*",
      valuetype = "CTransportTblLoader"
    },
  },
},

CRoleScriptObject = {
  type = "class",
  inherits = "IScriptObject ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CRoleScriptObject",
      valuetype = "CRoleScriptObject",
    },
  },
},

CRole = {
  type = "class",
  inherits = "CRoleBase ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CRole",
      valuetype = "CRole",
    },
    setStrength={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    getRmb={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    setGameMoney={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    sendOtherChangeScene={
      type = "method",
      args="(unsigned int: objUID,unsigned long long: sceneID,AxisPos*: pos)",
      returns = "void",
      valuetype = "void"
    },
    move={
      type = "method",
      args="(CArray1<AxisPos, 100>*: posList)",
      returns = "bool",
      valuetype = "bool"
    },
    getStrength={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getbagOpenGridNum={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    onMissionSubmit={
      type = "method",
      args="(unsigned short: missionTypeID,EMissionType: missionType,_OwnMission*: mission)",
      returns = "void",
      valuetype = "void"
    },
    getGameMoney={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    setLocalServerLogin={
      type = "method",
      args="(bool: flag)",
      returns = "void",
      valuetype = "void"
    },
    handleGetRoleAttr={
      type = "method",
      args="(EAttributes: attr)",
      returns = "int",
      valuetype = "int"
    },
    getScriptHandler={
      type = "method",
      args="()",
      returns = "CRoleScriptObject*",
      valuetype = "CRoleScriptObject"
    },
    getChangeLineWait={
      type = "method",
      args="()",
      returns = "ChangeLineWait*",
      valuetype = "ChangeLineWait"
    },
    getRoleUserData={
      type = "method",
      args="(CWorldUserData*: data)",
      returns = "void",
      valuetype = "void"
    },
    isChangeMap={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    setChangePos={
      type = "method",
      args="(unsigned long long: sceneID,AxisPos*: pos)",
      returns = "void",
      valuetype = "void"
    },
    onChangeMap={
      type = "method",
      args="(unsigned long long: sceneID,AxisPos*: pos,ETeleportType: type)",
      returns = "bool",
      valuetype = "bool"
    },
    isFirstLoginInDay={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    onLeaveScene={
      type = "method",
      args="(CMapSceneBase*: pScene)",
      returns = "void",
      valuetype = "void"
    },
    onAddToLogout={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getBufferMod={
      type = "method",
      args="()",
      returns = "CModBuffer*",
      valuetype = "CModBuffer"
    },
    isChangeLineWait={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getOfflineHours={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    isDbModBusy={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getBagMod={
      type = "method",
      args="()",
      returns = "CModBag*",
      valuetype = "CModBag"
    },
    getLastSceneID={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    kick={
      type = "method",
      args="(bool: needSave,int: sockWaitTime,string: reason)",
      returns = "void",
      valuetype = "void"
    },
    getScriptObject={
      type = "method",
      args="()",
      returns = "object*",
      valuetype = "object"
    },
    isFight={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    randName={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    isNeedInit={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    sendErrorCode={
      type = "method",
      args="(EGameRetCode: retCode)",
      returns = "void",
      valuetype = "void"
    },
    isOfflineDayTime={
      type = "method",
      args="(char: hour,char: mins,char: seconds)",
      returns = "bool",
      valuetype = "bool"
    },
    getOnlineMins={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    descAllRmb={
      type = "method",
      args="(int: val,bool: logFlag)",
      returns = "int",
      valuetype = "int"
    },
    onHourTimer={
      type = "method",
      args="(char: hour)",
      returns = "void",
      valuetype = "void"
    },
    getMapServerData={
      type = "method",
      args="()",
      returns = "CMapServerData*",
      valuetype = "CMapServerData"
    },
    setSex={
      type = "method",
      args="(unsigned char: val)",
      returns = "void",
      valuetype = "void"
    },
    onAddToReady={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getChatMod={
      type = "method",
      args="()",
      returns = "CModChat*",
      valuetype = "CModChat"
    },
    onEnterScene={
      type = "method",
      args="(CMapSceneBase*: pScene)",
      returns = "void",
      valuetype = "void"
    },
    toWorldKick={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    onEnter={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    onLogin={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    handleRoleAttr={
      type = "method",
      args="(EAttributes: attr,int: attrvar)",
      returns = "void",
      valuetype = "void"
    },
    getBindRmb={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    onAfterChangeMap={
      type = "method",
      args="(unsigned long long: sceneID,AxisPos*: pos,ELoadRoleType: changeType,ETeleportType: type)",
      returns = "bool",
      valuetype = "bool"
    },
    onUnloadRole={
      type = "method",
      args="(EUnloadRoleType: unloadType,bool: needRet)",
      returns = "void",
      valuetype = "void"
    },
    leaveScene={
      type = "method",
      args="(bool: exitFlag)",
      returns = "void",
      valuetype = "void"
    },
    getSex={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    handleAddMoneyPort={
      type = "method",
      args="(EAttributes: attr,int: moneyvar,EMoneyRecordTouchType: changeway)",
      returns = "void",
      valuetype = "void"
    },
    loadBaseAttr={
      type = "method",
      args="(CAttrBase<int, 49>*: baseAttr)",
      returns = "void",
      valuetype = "void"
    },
    onOldLogin={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getOfflineMins={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    getMaxLevel={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    sendKickMsg={
      type = "method",
      args="(EKickType: kickType)",
      returns = "void",
      valuetype = "void"
    },
    onAddItem={
      type = "method",
      args="(EItemRecordType: recordType,EPackType: packType,unsigned short: itemTypeID,short: num,unsigned char: quality)",
      returns = "void",
      valuetype = "void"
    },
    heartToWorld={
      type = "method",
      args="(int: diff)",
      returns = "void",
      valuetype = "void"
    },
    setLoadWaitInfo={
      type = "method",
      args="(ELoadRoleType: loadType,unsigned long long: sceneID,AxisPos*: pos,bool: sendAllDataFlag)",
      returns = "void",
      valuetype = "void"
    },
    onQuit={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isChangeLine={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    initClient={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    initCharacter={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    onNewLogin={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    onLoad={
      type = "method",
      args="(RoleManageInfo*: info,CHumanDBBackup*: hummanDB,LoadRoleData*: loadData,ChangeLineTempData*: tempData,bool: isAdult)",
      returns = "bool",
      valuetype = "bool"
    },
    onFiveSecondTimer={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    isMaxStrength={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    roleMove={
      type = "method",
      args="(CArray1<AxisPos, 100>*: posList,ERoleMoveType: moveType)",
      returns = "bool",
      valuetype = "bool"
    },
    addBindRmb={
      type = "method",
      args="(int: val,bool: logFlag)",
      returns = "int",
      valuetype = "int"
    },
    onLogout={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    sendTimerUpdateData={
      type = "method",
      args="(bool: forceFlag,ESaveRoleType: saveType)",
      returns = "void",
      valuetype = "void"
    },
    onFightFinish={
      type = "method",
      args="(bool: victory,int: killNum)",
      returns = "void",
      valuetype = "void"
    },
    getMissionMod={
      type = "method",
      args="()",
      returns = "CModMission*",
      valuetype = "CModMission"
    },
    onChangeLineRet={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    on12Timer={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getExp={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getScenData={
      type = "method",
      args="(CArray1<unsigned short, 100>*: npcs,CArray1<unsigned short, 100>*: trans)",
      returns = "void",
      valuetype = "void"
    },
    handleGetTokenOrItem={
      type = "method",
      args="(unsigned short: itemTypeID)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    changeLine={
      type = "method",
      args="(unsigned short: serverID,unsigned long long: sceneID,AxisPos*: pos,ETeleportType: type)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    reLogin={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getLoginManager={
      type = "method",
      args="()",
      returns = "CLoginWaiterManager*",
      valuetype = "CLoginWaiterManager"
    },
    getHumanBaseData={
      type = "method",
      args="()",
      returns = "CHumanBaseData*",
      valuetype = "CHumanBaseData"
    },
    isForbbidChat={
      type = "method",
      args="(unsigned long long: accountId)",
      returns = "bool",
      valuetype = "bool"
    },
    setExp={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    setVipExp={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    addVipLevel={
      type = "method",
      args="(unsigned char: val,bool: logFlag)",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    setCreateTime={
      type = "method",
      args="(unsigned int: val)",
      returns = "void",
      valuetype = "void"
    },
    getVipLevel={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    setMapID={
      type = "method",
      args="(unsigned short: mapID)",
      returns = "void",
      valuetype = "void"
    },
    setbagOpenGridNum={
      type = "method",
      args="(unsigned char: val)",
      returns = "void",
      valuetype = "void"
    },
    isEnoughWaste={
      type = "method",
      args="(EAttributes: attr,int: moneyvar)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    sendChat={
      type = "method",
      args="(string: msg)",
      returns = "void",
      valuetype = "void"
    },
    onIdle={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    setHummanDBData={
      type = "method",
      args="(CHumanDBData*: dbData)",
      returns = "void",
      valuetype = "void"
    },
    addGameMoney={
      type = "method",
      args="(int: val,bool: logFlag)",
      returns = "int",
      valuetype = "int"
    },
    saveRet={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    onOpenDynamicMap={
      type = "method",
      args="(unsigned long long: sceneID,AxisPos*: pos,unsigned short: mapServerID,EGameRetCode: retCode)",
      returns = "void",
      valuetype = "void"
    },
    waitReconnect={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    isCanViewMe={
      type = "method",
      args="(CGameObject*: pObj)",
      returns = "bool",
      valuetype = "bool"
    },
    updateLimitManger={
      type = "method",
      args="(int: diff)",
      returns = "void",
      valuetype = "void"
    },
    setRoleName={
      type = "method",
      args="(string: roleName)",
      returns = "void",
      valuetype = "void"
    },
    offlineSave={
      type = "method",
      args="(bool: saveNeedRet,ESaveRoleType: saveType)",
      returns = "void",
      valuetype = "void"
    },
    quitGame={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    quit={
      type = "method",
      args="(bool: forceQuit,char*: quitResult,int: sockWaitTime)",
      returns = "void",
      valuetype = "void"
    },
    toRoleString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    moveToDynamicMap={
      type = "method",
      args="(unsigned long long: sceneID,AxisPos*: pos,unsigned short: mapServerID)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    onBeforeChangeLine={
      type = "method",
      args="(ChangeLineTempData*: tempData,unsigned short: mapID,AxisPos*: pos,unsigned short: mapServerID,ETeleportType: type)",
      returns = "bool",
      valuetype = "bool"
    },
    onBeforeChangeMap={
      type = "method",
      args="(unsigned long long: sceneID,AxisPos*: pos,ELoadRoleType: changeType,ETeleportType: type)",
      returns = "bool",
      valuetype = "bool"
    },
    openDynamicMap={
      type = "method",
      args="(unsigned short: mapID)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    onScene={
      type = "method",
      args="(CMapScene*: pScene)",
      returns = "bool",
      valuetype = "bool"
    },
    sendUnloadRet={
      type = "method",
      args="(EGameRetCode: ret)",
      returns = "void",
      valuetype = "void"
    },
    getRoleAttrBackup={
      type = "method",
      args="()",
      returns = "RoleAttrBackup*",
      valuetype = "RoleAttrBackup"
    },
    setAxisPos={
      type = "method",
      args="(AxisPos*: pos)",
      returns = "void",
      valuetype = "void"
    },
    isWaitOffline={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    onSave={
      type = "method",
      args="(bool: offLineFlag)",
      returns = "bool",
      valuetype = "bool"
    },
    handleDeleteTokenOrItem={
      type = "method",
      args="(ItemReward*: iteminfo,int: changeway)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    renameName={
      type = "method",
      args="(string: roleName)",
      returns = "bool",
      valuetype = "bool"
    },
    onRemoveFromLogout={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    chargeRmb={
      type = "method",
      args="(int: val,bool: logFlag)",
      returns = "int",
      valuetype = "int"
    },
    onDescItem={
      type = "method",
      args="(EItemRecordType: recordType,EPackType: packType,unsigned short: itemTypeID,short: num,unsigned char: quality)",
      returns = "void",
      valuetype = "void"
    },
    onQuitHandle={
      type = "method",
      args="(ESaveRoleType: roleType)",
      returns = "void",
      valuetype = "void"
    },
    directKick={
      type = "method",
      args="(bool: needSave,bool: delFromMgr,bool: needRet,EKickType: kickType)",
      returns = "void",
      valuetype = "void"
    },
    onRename={
      type = "method",
      args="(EGameRetCode: retCode)",
      returns = "void",
      valuetype = "void"
    },
    setProtypeID={
      type = "method",
      args="(unsigned char: val)",
      returns = "void",
      valuetype = "void"
    },
    setVipLevel={
      type = "method",
      args="(unsigned char: val)",
      returns = "void",
      valuetype = "void"
    },
    getLoginsDay={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    sendEnterScene={
      type = "method",
      args="(ESceneType: type)",
      returns = "void",
      valuetype = "void"
    },
    getRoleDetailData={
      type = "method",
      args="(RoleDetail*: detail)",
      returns = "void",
      valuetype = "void"
    },
    initScript={
      type = "method",
      args="(string: functionName)",
      returns = "bool",
      valuetype = "bool"
    },
    getOnlineTime={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    onLogoutTimeout={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getHumanDBData={
      type = "method",
      args="()",
      returns = "CHumanDBData*",
      valuetype = "CHumanDBData"
    },
    getPlayerHandler={
      type = "method",
      args="(bool: logFlag)",
      returns = "CMapPlayerHandler*",
      valuetype = "CMapPlayerHandler"
    },
    transport={
      type = "method",
      args="(unsigned short: transportTypeID)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    getMaxStrength={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    setLogoutTime={
      type = "method",
      args="(unsigned int: val)",
      returns = "void",
      valuetype = "void"
    },
    changeMap={
      type = "method",
      args="(unsigned short: mapID,AxisPos*: pos,ETeleportType: type)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    getVipExp={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getLevelRow={
      type = "method",
      args="()",
      returns = "CLevelUpTbl*",
      valuetype = "CLevelUpTbl"
    },
    setLoginManager={
      type = "method",
      args="(CLoginWaiterManager*: val)",
      returns = "void",
      valuetype = "void"
    },
    getMaxExp={
      type = "method",
      args="(unsigned char: lvl)",
      returns = "int",
      valuetype = "int"
    },
    setLastSceneID={
      type = "method",
      args="(unsigned long long: val)",
      returns = "void",
      valuetype = "void"
    },
    setLastMapPos={
      type = "method",
      args="(AxisPos*: val)",
      returns = "void",
      valuetype = "void"
    },
    onMove={
      type = "method",
      args="(AxisPos*: pos)",
      returns = "void",
      valuetype = "void"
    },
    setLastMapID={
      type = "method",
      args="(unsigned short: val)",
      returns = "void",
      valuetype = "void"
    },
    getLoadWaitData={
      type = "method",
      args="()",
      returns = "LoadWaitEnter*",
      valuetype = "LoadWaitEnter"
    },
    onAfterChangeLine={
      type = "method",
      args="(ChangeLineTempData*: tempData,ETeleportType: type)",
      returns = "bool",
      valuetype = "bool"
    },
    getLastMapID={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    onLevelChanged={
      type = "method",
      args="(unsigned int: sLvl,unsigned int: dLvl)",
      returns = "void",
      valuetype = "void"
    },
    refreshFast={
      type = "method",
      args="(bool: sendFlag)",
      returns = "void",
      valuetype = "void"
    },
    getLevel={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    getLastMapPos={
      type = "method",
      args="()",
      returns = "AxisPos*",
      valuetype = "AxisPos"
    },
    setSceneID={
      type = "method",
      args="(unsigned long long: sceneID)",
      returns = "void",
      valuetype = "void"
    },
    updateUserData={
      type = "method",
      args="(W2MUserDataUpdate*: pData)",
      returns = "void",
      valuetype = "void"
    },
    getSceneRecord={
      type = "method",
      args="()",
      returns = "RoleSceneRecord*",
      valuetype = "RoleSceneRecord"
    },
    cleanAll={
      type = "method",
      args="(int: sockWaitTime)",
      returns = "void",
      valuetype = "void"
    },
    handleDescMoneyPort={
      type = "method",
      args="(EAttributes: attr,int: moneyvar,EMoneyRecordTouchType: changeway)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    setLevel={
      type = "method",
      args="(unsigned char: val)",
      returns = "void",
      valuetype = "void"
    },
    update={
      type = "method",
      args="(int: diff)",
      returns = "bool",
      valuetype = "bool"
    },
    getLoginCountOneDay={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getCreateTime={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    on0Timer={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    onMissionAccept={
      type = "method",
      args="(unsigned short: missionTypeID,EMissionType: missionType,_OwnMission*: mission)",
      returns = "void",
      valuetype = "void"
    },
    handleAddTokenOrItem={
      type = "method",
      args="(ItemReward*: iteminfo,int: changeway)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    setLoginCountOneDay={
      type = "method",
      args="(int: val)",
      returns = "void",
      valuetype = "void"
    },
    setHummanDBBuffer={
      type = "method",
      args="(char*: buff,int: len)",
      returns = "void",
      valuetype = "void"
    },
    onDeleteItem={
      type = "method",
      args="(EItemRecordType: recordType,EPackType: packType,unsigned short: itemTypeID,short: num,unsigned char: quality)",
      returns = "void",
      valuetype = "void"
    },
    getDbHandler={
      type = "method",
      args="(bool: isLogErr)",
      returns = "CMapDbPlayerHandler*",
      valuetype = "CMapDbPlayerHandler"
    },
    addVipExp={
      type = "method",
      args="(int: val,bool: logFlag)",
      returns = "int",
      valuetype = "int"
    },
    getHumanDB={
      type = "method",
      args="()",
      returns = "CHumanDB*",
      valuetype = "CHumanDB"
    },
    getLimitManager={
      type = "method",
      args="()",
      returns = "CLimitManager*",
      valuetype = "CLimitManager"
    },
    onOfflineOverrunDays={
      type = "method",
      args="(unsigned int: days)",
      returns = "void",
      valuetype = "void"
    },
    onLoginTimeout={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    sendAllData={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getProtypeID={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    isNeedUpdateBlock={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getAllRmb={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getNewRoleRow={
      type = "method",
      args="()",
      returns = "CNewRoleTbl*",
      valuetype = "CNewRoleTbl"
    },
  },
},

CMapDbResponseTask = {
  type = "class",
  inherits = "CDbConnTask ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMapDbResponseTask",
      valuetype = "CMapDbResponseTask",
    },
    doRun={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    setRetCode={
      type = "method",
      args="(unsigned short: ret)",
      returns = "void",
      valuetype = "void"
    },
    doWork={
      type = "method",
      args="(CRoleBase*: role)",
      returns = "void",
      valuetype = "void"
    },
    getRoleUID={
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
    setErrLogFlag={
      type = "method",
      args="(bool: errLogFag)",
      returns = "void",
      valuetype = "void"
    },
    getRole={
      type = "method",
      args="()",
      returns = "CRoleBase*",
      valuetype = "CRoleBase"
    },
    setRoleUID={
      type = "method",
      args="(unsigned long long: roleUID)",
      returns = "void",
      valuetype = "void"
    },
  },
},

CMapDbRequestTask = {
  type = "class",
  inherits = "CDbWrapTask ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMapDbRequestTask",
      valuetype = "CMapDbRequestTask",
    },
    freeResponseTask={
      type = "method",
      args="(CMapDbResponseTask*: task)",
      returns = "void",
      valuetype = "void"
    },
    getRoleUID={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    setRoleUID={
      type = "method",
      args="(unsigned long long: roleUID)",
      returns = "void",
      valuetype = "void"
    },
    setErrLogFlag={
      type = "method",
      args="(bool: errLogFlag)",
      returns = "void",
      valuetype = "void"
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

CMapDbPlayerHandlerBase = {
  type = "class",
  inherits = "CGameDatabaseHandler ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMapDbPlayerHandlerBase",
      valuetype = "CMapDbPlayerHandlerBase",
    },
    quit={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getRoleUID={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
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
    setRequestSocketIndex={
      type = "method",
      args="(unsigned long long: index)",
      returns = "void",
      valuetype = "void"
    },
    pushTask={
      type = "method",
      args="(CMapDbRequestTask*: task)",
      returns = "void",
      valuetype = "void"
    },
    getRequestSocketIndex={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
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
    getObjUID={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    setLoginPlayerSockIndex={
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
    setObjUID={
      type = "method",
      args="(unsigned int: objUID)",
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
    getRole={
      type = "method",
      args="(bool: logFlag)",
      returns = "CRoleBase*",
      valuetype = "CRoleBase"
    },
    setRoleUID={
      type = "method",
      args="(unsigned long long: roleUID)",
      returns = "void",
      valuetype = "void"
    },
    getLoginPlayerSockIndex={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
  },
},

_SrvMapTile = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "_SrvMapTile",
      valuetype = "_SrvMapTile",
    },
  },
},

_MapDataHeader = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "_MapDataHeader",
      valuetype = "_MapDataHeader",
    },
  },
},

_MapData = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "_MapData",
      valuetype = "_MapData",
    },
  },
},

CMapBase = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMapBase",
      valuetype = "CMapBase",
    },
    load={
      type = "method",
      args="(string: name)",
      returns = "bool",
      valuetype = "bool"
    },
    randStepPos={
      type = "method",
      args="(vector<AxisPos, allocator<AxisPos> >*: poss,AxisPos*: srcPos,unsigned short: nRange,unsigned int: maxSteps)",
      returns = "void",
      valuetype = "void"
    },
    isLineEmpty={
      type = "method",
      args="(AxisPos*: srcPos,AxisPos*: destPos,unsigned char: flag)",
      returns = "bool",
      valuetype = "bool"
    },
    setMapID={
      type = "method",
      args="(unsigned short: mapID)",
      returns = "void",
      valuetype = "void"
    },
    getMapConfig={
      type = "method",
      args="()",
      returns = "CConfigTbl*",
      valuetype = "CConfigTbl"
    },
    setMapConfig={
      type = "method",
      args="(CConfigTbl*: config)",
      returns = "void",
      valuetype = "void"
    },
    keyToString={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
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
    isSkillLineEmpty={
      type = "method",
      args="(AxisPos*: srcPos,AxisPos*: destPos,unsigned char: flag)",
      returns = "bool",
      valuetype = "bool"
    },
    randPos={
      type = "method",
      args="(AxisPos*: top,AxisPos*: buttom,AxisPos*: randP)",
      returns = "void",
      valuetype = "void"
    },
    getMonsterNum={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getTransports={
      type = "method",
      args="()",
      returns = "vector<unsigned short, allocator<unsigned short> >*",
      valuetype = "vector<unsigned short, allocator<unsigned short> >"
    },
    getMapType={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    getMapID={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    setKey={
      type = "method",
      args="(unsigned short: key)",
      returns = "void",
      valuetype = "void"
    },
    toString={
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
    pushMonster={
      type = "method",
      args="(unsigned short: monsterDistributeID,int: num)",
      returns = "void",
      valuetype = "void"
    },
    getNpcs={
      type = "method",
      args="()",
      returns = "vector<unsigned short, allocator<unsigned short> >*",
      valuetype = "vector<unsigned short, allocator<unsigned short> >"
    },
    setEmptyPos={
      type = "method",
      args="(AxisPos*: pos)",
      returns = "void",
      valuetype = "void"
    },
    getEmptyPos={
      type = "method",
      args="()",
      returns = "AxisPos*",
      valuetype = "AxisPos"
    },
    getMonsters={
      type = "method",
      args="()",
      returns = "vector<unsigned short, allocator<unsigned short> >*",
      valuetype = "vector<unsigned short, allocator<unsigned short> >"
    },
    getNpcNum={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    pushTransport={
      type = "method",
      args="(unsigned short: transID,int: num)",
      returns = "void",
      valuetype = "void"
    },
    findRobotPos={
      type = "method",
      args="(vector<AxisPos, allocator<AxisPos> >*: poss,AxisPos*: srcPos,AxisPos*: destPos)",
      returns = "void",
      valuetype = "void"
    },
    getLineEmptyPos={
      type = "method",
      args="(AxisPos*: srcPos,AxisPos*: destPos,AxisPos*: targetPos,unsigned char: flag)",
      returns = "bool",
      valuetype = "bool"
    },
    isKey={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getKey={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    pushNpc={
      type = "method",
      args="(unsigned short: npcTypeID,int: num)",
      returns = "void",
      valuetype = "void"
    },
  },
},

_ObjManagerInit = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "_ObjManagerInit",
      valuetype = "_ObjManagerInit",
    },
  },
},

CObjectManager = {
  type = "class",
  inherits = "CHashMultiIndex<CGameObject, false, 4294967295> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CObjectManager",
      valuetype = "CObjectManager",
    },
    genObjUID={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    findObj={
      type = "method",
      args="(unsigned int: uid)",
      returns = "CGameObject*",
      valuetype = "CGameObject"
    },
    update={
      type = "method",
      args="(int: diff)",
      returns = "void",
      valuetype = "void"
    },
    addObj={
      type = "method",
      args="(CGameObject*: val)",
      returns = "void",
      valuetype = "void"
    },
    init={
      type = "method",
      args="(_ObjManagerInit*: initMgr)",
      returns = "bool",
      valuetype = "bool"
    },
    isObjExist={
      type = "method",
      args="(unsigned int: key)",
      returns = "bool",
      valuetype = "bool"
    },
    delObj={
      type = "method",
      args="(unsigned int: key)",
      returns = "void",
      valuetype = "void"
    },
  },
},

CSceneObjectManager = {
  type = "class",
  inherits = "CObjectManager ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CSceneObjectManager",
      valuetype = "CSceneObjectManager",
    },
    setScene={
      type = "method",
      args="(CMapSceneBase*: pScene)",
      returns = "void",
      valuetype = "void"
    },
    init={
      type = "method",
      args="(CMapSceneBase*: pScene)",
      returns = "bool",
      valuetype = "bool"
    },
    getScene={
      type = "method",
      args="()",
      returns = "CMapSceneBase*",
      valuetype = "CMapSceneBase"
    },
    update={
      type = "method",
      args="(int: diff)",
      returns = "void",
      valuetype = "void"
    },
  },
},

CSceneRoleManager = {
  type = "class",
  inherits = "CSceneObjectManager ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CSceneRoleManager",
      valuetype = "CSceneRoleManager",
    },
    getAllRole={
      type = "method",
      args="(vector<CRoleBase *, allocator<CRoleBase *> >: data)",
      returns = "void",
      valuetype = "void"
    },
    getRole={
      type = "method",
      args="(unsigned int: uid)",
      returns = "CRoleBase*",
      valuetype = "CRoleBase"
    },
  },
},

CMapSceneBase = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMapSceneBase",
      valuetype = "CMapSceneBase",
    },
    isFull={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    initRoleInfo={
      type = "method",
      args="(int: maxRole,int: maxGroupNum)",
      returns = "void",
      valuetype = "void"
    },
    proInit={
      type = "method",
      args="(unsigned short: mapID)",
      returns = "bool",
      valuetype = "bool"
    },
    getRoleMgr={
      type = "method",
      args="()",
      returns = "CSceneRoleManager*",
      valuetype = "CSceneRoleManager"
    },
    getRelivePos={
      type = "method",
      args="(CRoleBase*: pRole,EReliveType: reliveType,MapIDRangePos*: relivePos)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    calcBlockID={
      type = "method",
      args="(AxisPos*: pos)",
      returns = "int",
      valuetype = "int"
    },
    putEmptyGourpID={
      type = "method",
      args="(int: groupID)",
      returns = "void",
      valuetype = "void"
    },
    init={
      type = "method",
      args="(CMapBase*: data)",
      returns = "bool",
      valuetype = "bool"
    },
    scanObject={
      type = "method",
      args="(int: blockID,unsigned char: range,vector<CGameObject *, allocator<CGameObject *> >: objList)",
      returns = "bool",
      valuetype = "bool"
    },
    getIsNeedClose={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    onRoleLeave={
      type = "method",
      args="(CRoleBase*: obj,bool: exitFlag)",
      returns = "void",
      valuetype = "void"
    },
    isMaxRoleNum={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    leave={
      type = "method",
      args="(CGameObject*: obj,bool: exitFlag)",
      returns = "void",
      valuetype = "void"
    },
    onRoleEnter={
      type = "method",
      args="(CRoleBase*: obj)",
      returns = "void",
      valuetype = "void"
    },
    findRandPos={
      type = "method",
      args="(AxisPos*: pos,unsigned short: range)",
      returns = "bool",
      valuetype = "bool"
    },
    getMaxNumInGroup={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    randStepPos={
      type = "method",
      args="(vector<AxisPos, allocator<AxisPos> >*: poss,AxisPos*: srcPos,unsigned short: nRange,unsigned int: maxSteps)",
      returns = "void",
      valuetype = "void"
    },
    proMonsterLeaveScene={
      type = "method",
      args="(unsigned int: monsterNum,unsigned short: monsterTypeID,unsigned int: objUID)",
      returns = "void",
      valuetype = "void"
    },
    posValidate={
      type = "method",
      args="(AxisPos*: pos)",
      returns = "bool",
      valuetype = "bool"
    },
    leaveBlock={
      type = "method",
      args="(CGameObject*: pObject)",
      returns = "void",
      valuetype = "void"
    },
    getBlocksInRange={
      type = "method",
      args="(vector<int, allocator<int> >*: ids,unsigned short: range,int: blockID,bool: rectOrCurFlag)",
      returns = "void",
      valuetype = "void"
    },
    proRoleEnterScene={
      type = "method",
      args="(CRoleBase*: pRole)",
      returns = "void",
      valuetype = "void"
    },
    objBlockRegister={
      type = "method",
      args="(CGameObject*: obj,int: blockID)",
      returns = "bool",
      valuetype = "bool"
    },
    getKickPos={
      type = "method",
      args="(MapIDRangePos*: kickPos,CRoleBase*: pRole)",
      returns = "bool",
      valuetype = "bool"
    },
    getCharacterByUID={
      type = "method",
      args="(unsigned int: objUID)",
      returns = "CCharacterObject*",
      valuetype = "CCharacterObject"
    },
    getObjectMgr={
      type = "method",
      args="()",
      returns = "CSceneObjectManager*",
      valuetype = "CSceneObjectManager"
    },
    kickSingleRole={
      type = "method",
      args="(CRoleBase*: pRole)",
      returns = "void",
      valuetype = "void"
    },
    clearObjectBlock={
      type = "method",
      args="(AxisPos*: pos)",
      returns = "void",
      valuetype = "void"
    },
    toString={
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
    isForceUpdateAllBlock={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getTile={
      type = "method",
      args="(AxisPos*: pos)",
      returns = "_SrvMapTile*",
      valuetype = "_SrvMapTile"
    },
    objBlockUnregister={
      type = "method",
      args="(CGameObject*: obj,int: blockID)",
      returns = "bool",
      valuetype = "bool"
    },
    isNormalScene={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    kickAllRole={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getAllRoleSocketIndex={
      type = "method",
      args="(CArray<unsigned long long, 10, unsigned char>*: socks)",
      returns = "void",
      valuetype = "void"
    },
    setOwnerObjUID={
      type = "method",
      args="(unsigned int: objUID)",
      returns = "void",
      valuetype = "void"
    },
    getMapData={
      type = "method",
      args="()",
      returns = "CMapBase*",
      valuetype = "CMapBase"
    },
    objBlockChanged={
      type = "method",
      args="(CGameObject*: obj,int: blockIDNew,int: blockIDOld)",
      returns = "bool",
      valuetype = "bool"
    },
    getKey={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    axisRange2BlockRange={
      type = "method",
      args="(AxisPos*: axisPos,unsigned char: range)",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    load={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    onUnload={
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
    getRectInRange={
      type = "method",
      args="(_BlockRect*: rect,char: range,int: blockID)",
      returns = "void",
      valuetype = "void"
    },
    cleanUp={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    blockRangeInTwo={
      type = "method",
      args="(int: blockID1,int: blockID2)",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    getObjByUID={
      type = "method",
      args="(unsigned int: objUID)",
      returns = "CGameObject*",
      valuetype = "CGameObject"
    },
    checkObjectBlock={
      type = "method",
      args="(AxisPos*: pos)",
      returns = "bool",
      valuetype = "bool"
    },
    getOwnerObjUID={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    getMapID={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    scanObjSub={
      type = "method",
      args="(int: blockIDA,int: blockIDB,unsigned char: range,vector<CGameObject *, allocator<CGameObject *> >: objList)",
      returns = "bool",
      valuetype = "bool"
    },
    setObjectBlock={
      type = "method",
      args="(AxisPos*: pos)",
      returns = "void",
      valuetype = "void"
    },
    getEmptyGroupID={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    setIsNeedClose={
      type = "method",
      args="(bool: needClose)",
      returns = "void",
      valuetype = "void"
    },
    isDynamicScene={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    proUpdate={
      type = "method",
      args="(int: diff)",
      returns = "bool",
      valuetype = "bool"
    },
    setSceneID={
      type = "method",
      args="(unsigned long long: sceneID)",
      returns = "void",
      valuetype = "void"
    },
    isKey={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    onInit={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    scanRoleSub={
      type = "method",
      args="(int: blockIDA,int: blockIDB,unsigned char: range,vector<CRoleBase *, allocator<CRoleBase *> >: roleList)",
      returns = "bool",
      valuetype = "bool"
    },
    isCanEnter={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isBlockDirty={
      type = "method",
      args="(int: blockID)",
      returns = "bool",
      valuetype = "bool"
    },
    isLineEmpty={
      type = "method",
      args="(AxisPos*: srcPos,AxisPos*: destPos)",
      returns = "bool",
      valuetype = "bool"
    },
    scan={
      type = "method",
      args="(CScanOperator*: scanOperator,bool: flag)",
      returns = "bool",
      valuetype = "bool"
    },
    getSceneData={
      type = "method",
      args="(SceneData*: data)",
      returns = "void",
      valuetype = "void"
    },
    getMaxRoleNum={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    randPos={
      type = "method",
      args="(AxisPos*: top,AxisPos*: buttom,AxisPos*: randP)",
      returns = "void",
      valuetype = "void"
    },
    proRoleLeaveScene={
      type = "method",
      args="(CRoleBase*: pRole,bool: exitFlag)",
      returns = "void",
      valuetype = "void"
    },
    setKey={
      type = "method",
      args="(unsigned long long: key)",
      returns = "void",
      valuetype = "void"
    },
    checkBlockID={
      type = "method",
      args="(int: blockID)",
      returns = "bool",
      valuetype = "bool"
    },
    getSceneID={
      type = "method",
      args="()",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    setSceneType={
      type = "method",
      args="(ESceneType: type)",
      returns = "void",
      valuetype = "void"
    },
    isInCurBlock={
      type = "method",
      args="(int: blockID,AxisPos*: axisPos,unsigned char: range)",
      returns = "bool",
      valuetype = "bool"
    },
    update={
      type = "method",
      args="(int: diff)",
      returns = "bool",
      valuetype = "bool"
    },
    getSceneType={
      type = "method",
      args="()",
      returns = "ESceneType",
      valuetype = "ESceneType"
    },
    canEnter={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getBlock={
      type = "method",
      args="(int: blockID)",
      returns = "CBlock*",
      valuetype = "CBlock"
    },
    unload={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    enter={
      type = "method",
      args="(CGameObject*: obj)",
      returns = "bool",
      valuetype = "bool"
    },
    signUpdateBlock={
      type = "method",
      args="(int: roleBlockNum)",
      returns = "void",
      valuetype = "void"
    },
  },
},

CAvoidOverlap = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CAvoidOverlap",
      valuetype = "CAvoidOverlap",
    },
    getIndex={
      type = "method",
      args="(AxisPos*: curPos,AxisPos*: tarPos)",
      returns = "short",
      valuetype = "short"
    },
    resetUsedDir={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    setSitPos={
      type = "method",
      args="(short: index)",
      returns = "void",
      valuetype = "void"
    },
  },
},

CMapScene = {
  type = "class",
  inherits = "CMapSceneBase ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMapScene",
      valuetype = "CMapScene",
    },
    load={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

MCUpdateMissionList = {
  type = "class",
  inherits = "CServerPacket IStreamableStaticAll<MCUpdateMissionList> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCUpdateMissionList",
      valuetype = "MCUpdateMissionList",
    },
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    Unpacket={
      type = "method",
      args="(MCUpdateMissionList*: pBase,char*: buff,int: len)",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

MCUpdateMissionParam = {
  type = "class",
  inherits = "CServerPacket IStreamableStaticAll<MCUpdateMissionParam> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCUpdateMissionParam",
      valuetype = "MCUpdateMissionParam",
    },
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    Unpacket={
      type = "method",
      args="(MCUpdateMissionParam*: pBase,char*: buff,int: len)",
      returns = "bool",
      valuetype = "bool"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
  },
},

MCAddItems = {
  type = "class",
  inherits = "CServerPacket IStreamableStaticAll<MCAddItems> ",
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    Unpacket={
      type = "method",
      args="(MCAddItems*: pBase,char*: buff,int: len)",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

MCDelItems = {
  type = "class",
  inherits = "CServerPacket IStreamableStaticAll<MCDelItems> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCDelItems",
      valuetype = "MCDelItems",
    },
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    Unpacket={
      type = "method",
      args="(MCDelItems*: pBase,char*: buff,int: len)",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

MCUpdateItems = {
  type = "class",
  inherits = "CServerPacket IStreamableStaticAll<MCUpdateItems> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCUpdateItems",
      valuetype = "MCUpdateItems",
    },
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    Unpacket={
      type = "method",
      args="(MCUpdateItems*: pBase,char*: buff,int: len)",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

MCMoveItems = {
  type = "class",
  inherits = "CServerPacket IStreamableStaticAll<MCMoveItems> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "MCMoveItems",
      valuetype = "MCMoveItems",
    },
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    Unpacket={
      type = "method",
      args="(MCMoveItems*: pBase,char*: buff,int: len)",
      returns = "bool",
      valuetype = "bool"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
  },
},

CMapPlayerHandler = {
  type = "class",
  inherits = "CMapPlayerHandlerBase ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMapPlayerHandler",
      valuetype = "CMapPlayerHandler",
    },
    handleJump={
      type = "method",
      args="(CMJump*: packet)",
      returns = "EHandleRet",
      valuetype = "EHandleRet"
    },
    handleMissionOperate={
      type = "method",
      args="(CMMissionOperate*: packet)",
      returns = "EHandleRet",
      valuetype = "EHandleRet"
    },
    handleDrop={
      type = "method",
      args="(CMDrop*: packet)",
      returns = "EHandleRet",
      valuetype = "EHandleRet"
    },
    handleTransmite={
      type = "method",
      args="(CMTransmite*: packet)",
      returns = "EHandleRet",
      valuetype = "EHandleRet"
    },
    handleLand={
      type = "method",
      args="(CMLand*: packet)",
      returns = "EHandleRet",
      valuetype = "EHandleRet"
    },
    handleRandRoleName={
      type = "method",
      args="(CMRandRoleName*: packet)",
      returns = "EHandleRet",
      valuetype = "EHandleRet"
    },
    handleChat={
      type = "method",
      args="(CMChat*: packet)",
      returns = "EHandleRet",
      valuetype = "EHandleRet"
    },
    handleLocalLogin={
      type = "method",
      args="(CMLocalLoginGame*: packet)",
      returns = "EHandleRet",
      valuetype = "EHandleRet"
    },
    start={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    handleEnterScene={
      type = "method",
      args="(CMEnterScene*: packet)",
      returns = "EHandleRet",
      valuetype = "EHandleRet"
    },
    handleEnterGame={
      type = "method",
      args="(CMEnterGame*: packet)",
      returns = "EHandleRet",
      valuetype = "EHandleRet"
    },
    handleMove={
      type = "method",
      args="(CMMove*: packet)",
      returns = "EHandleRet",
      valuetype = "EHandleRet"
    },
    handleRename={
      type = "method",
      args="(CMRenameRoleName*: packet)",
      returns = "EHandleRet",
      valuetype = "EHandleRet"
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

CMapDbPlayerHandler = {
  type = "class",
  inherits = "CMapDbPlayerHandlerBase ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMapDbPlayerHandler",
      valuetype = "CMapDbPlayerHandler",
    },
    sendLoadDataTask={
      type = "method",
      args="(LoadRoleData*: loadData,ChangeLineTempData*: changeLineTempData,unsigned long long: worldPlayerSockIndex,unsigned long long: requestSocketIndex,bool: isLocalServerLogin)",
      returns = "bool",
      valuetype = "bool"
    },
    sendUpdateRoleData={
      type = "method",
      args="(CHumanDB*: data,ESaveRoleType: saveType)",
      returns = "void",
      valuetype = "void"
    },
    sendSaveRoleData={
      type = "method",
      args="(CHumanDB*: data,unsigned long long: worldPlayerSockIndex,bool: needRet,ESaveRoleType: saveType)",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

CRoleManagerBase = {
  type = "class",
  inherits = "CGamePlayerMgr3<CRoleBase> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CRoleManagerBase",
      valuetype = "CRoleManagerBase",
    },
    findInEnterByAccountID={
      type = "method",
      args="(unsigned long long: _key,bool: logFlag)",
      returns = "CRoleBase*",
      valuetype = "CRoleBase"
    },
    findInQueTypeByObjUID={
      type = "method",
      args="(EManagerQueType: tp,unsigned int: _key,bool: logFlag)",
      returns = "CRoleBase*",
      valuetype = "CRoleBase"
    },
    findInEnterByRoleUID={
      type = "method",
      args="(unsigned long long: _key,bool: logFlag)",
      returns = "CRoleBase*",
      valuetype = "CRoleBase"
    },
    findInQueTypeByRoleUID={
      type = "method",
      args="(EManagerQueType: tp,unsigned long long: _key,bool: logFlag)",
      returns = "CRoleBase*",
      valuetype = "CRoleBase"
    },
    findInLogoutByRoleUID={
      type = "method",
      args="(unsigned long long: _key,bool: logFlag)",
      returns = "CRoleBase*",
      valuetype = "CRoleBase"
    },
    findByRoleUID={
      type = "method",
      args="(unsigned long long: _key,bool: logFlag)",
      returns = "CRoleBase*",
      valuetype = "CRoleBase"
    },
    findByAccountID={
      type = "method",
      args="(unsigned long long: _key,bool: logFlag)",
      returns = "CRoleBase*",
      valuetype = "CRoleBase"
    },
    findInReadyByAccountID={
      type = "method",
      args="(unsigned long long: _key,bool: logFlag)",
      returns = "CRoleBase*",
      valuetype = "CRoleBase"
    },
    findInLogoutByObjUID={
      type = "method",
      args="(unsigned int: _key,bool: logFlag)",
      returns = "CRoleBase*",
      valuetype = "CRoleBase"
    },
    updateTimer={
      type = "method",
      args="(unsigned int: timerID)",
      returns = "void",
      valuetype = "void"
    },
    getSaveSec={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    findByObjUID={
      type = "method",
      args="(unsigned int: _key,bool: logFlag)",
      returns = "CRoleBase*",
      valuetype = "CRoleBase"
    },
    renameRole={
      type = "method",
      args="(unsigned long long: roleUID,string: name)",
      returns = "bool",
      valuetype = "bool"
    },
    update={
      type = "method",
      args="(unsigned int: diff)",
      returns = "void",
      valuetype = "void"
    },
    findInLogoutByAccountID={
      type = "method",
      args="(unsigned long long: _key,bool: logFlag)",
      returns = "CRoleBase*",
      valuetype = "CRoleBase"
    },
    doProfile={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    kickAllRole={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    findInEnterByObjUID={
      type = "method",
      args="(unsigned int: _key,bool: logFlag)",
      returns = "CRoleBase*",
      valuetype = "CRoleBase"
    },
    findInQueTypeByAccountID={
      type = "method",
      args="(EManagerQueType: tp,unsigned long long: _key,bool: logFlag)",
      returns = "CRoleBase*",
      valuetype = "CRoleBase"
    },
    updateRoleIdle={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    findInReadyByObjUID={
      type = "method",
      args="(unsigned int: _key,bool: logFlag)",
      returns = "CRoleBase*",
      valuetype = "CRoleBase"
    },
    findInReadyByRoleUID={
      type = "method",
      args="(unsigned long long: _key,bool: logFlag)",
      returns = "CRoleBase*",
      valuetype = "CRoleBase"
    },
  },
},

CRoleManager = {
  type = "class",
  inherits = "CRoleManagerBase CManualSingleton<CRoleManager> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CRoleManager",
      valuetype = "CRoleManager",
    },
    findInEnterByAccountID={
      type = "method",
      args="(unsigned long long: _key,bool: logFlag)",
      returns = "CRole*",
      valuetype = "CRole"
    },
    findInQueTypeByObjUID={
      type = "method",
      args="(EManagerQueType: tp,unsigned int: _key,bool: logFlag)",
      returns = "CRole*",
      valuetype = "CRole"
    },
    initRolePool={
      type = "method",
      args="(int: num)",
      returns = "bool",
      valuetype = "bool"
    },
    findInEnterByRoleUID={
      type = "method",
      args="(unsigned long long: _key,bool: logFlag)",
      returns = "CRole*",
      valuetype = "CRole"
    },
    findInQueTypeByRoleUID={
      type = "method",
      args="(EManagerQueType: tp,unsigned long long: _key,bool: logFlag)",
      returns = "CRole*",
      valuetype = "CRole"
    },
    loadRoleData={
      type = "method",
      args="(LoadRoleData*: loadData,unsigned long long: requestSocketIndex,unsigned long long: playerSocketIndex,ChangeLineTempData*: changeLineTempData,bool: isLocalServerLogin)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    findInLogoutByRoleUID={
      type = "method",
      args="(unsigned long long: _key,bool: logFlag)",
      returns = "CRole*",
      valuetype = "CRole"
    },
    findByRoleUID={
      type = "method",
      args="(unsigned long long: _key,bool: logFlag)",
      returns = "CRole*",
      valuetype = "CRole"
    },
    findByAccountID={
      type = "method",
      args="(unsigned long long: _key,bool: logFlag)",
      returns = "CRole*",
      valuetype = "CRole"
    },
    init={
      type = "method",
      args="(int: maxPlayerNum)",
      returns = "bool",
      valuetype = "bool"
    },
    getRoleHummanDBPool={
      type = "method",
      args="()",
      returns = "CFixEmptyObjPool<CHumanDBData, unsigned long long, 1000>*",
      valuetype = "CFixEmptyObjPool<CHumanDBData, unsigned long long, 1000>"
    },
    findInReadyByAccountID={
      type = "method",
      args="(unsigned long long: _key,bool: logFlag)",
      returns = "CRole*",
      valuetype = "CRole"
    },
    delPlayer={
      type = "method",
      args="(unsigned long long: key1)",
      returns = "void",
      valuetype = "void"
    },
    roleHeart={
      type = "method",
      args="(int: diff)",
      returns = "void",
      valuetype = "void"
    },
    findInLogoutByObjUID={
      type = "method",
      args="(unsigned int: _key,bool: logFlag)",
      returns = "CRole*",
      valuetype = "CRole"
    },
    findByObjUID={
      type = "method",
      args="(unsigned int: _key,bool: logFlag)",
      returns = "CRole*",
      valuetype = "CRole"
    },
    update={
      type = "method",
      args="(unsigned int: diff)",
      returns = "void",
      valuetype = "void"
    },
    findInLogoutByAccountID={
      type = "method",
      args="(unsigned long long: _key,bool: logFlag)",
      returns = "CRole*",
      valuetype = "CRole"
    },
    newRole={
      type = "method",
      args="(unsigned long long: roleUID,unsigned int: objUID,unsigned long long: accountID,bool: addToReadyFlag)",
      returns = "CRole*",
      valuetype = "CRole"
    },
    addNewPlayer={
      type = "method",
      args="(unsigned long long: key1,unsigned int: key2,unsigned long long: key3,bool: isAddToReady)",
      returns = "CRole*",
      valuetype = "CRole"
    },
    findInEnterByObjUID={
      type = "method",
      args="(unsigned int: _key,bool: logFlag)",
      returns = "CRole*",
      valuetype = "CRole"
    },
    loadRoleDataRet={
      type = "method",
      args="(LoadRoleData*: loadData,unsigned long long: requestSocketIndex,unsigned long long: loginPlayerSockIndex,ChangeLineTempData*: changeLineTempData,unsigned long long: dbIndex,RoleManageInfo*: roleInfo,CHumanDBBackup*: humanDB,bool: isAdult,bool: isLocalServerLogin,CRole*: pRole)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    findInQueTypeByAccountID={
      type = "method",
      args="(EManagerQueType: tp,unsigned long long: _key,bool: logFlag)",
      returns = "CRole*",
      valuetype = "CRole"
    },
    unLoadRoleData={
      type = "method",
      args="(unsigned long long: roleUID,unsigned long long: loginPlayerSocketIndex,bool: needRet,EUnloadRoleType: unloadType)",
      returns = "EGameRetCode",
      valuetype = "EGameRetCode"
    },
    freeNewPlayer={
      type = "method",
      args="(CRole*: val)",
      returns = "void",
      valuetype = "void"
    },
    delRole={
      type = "method",
      args="(unsigned long long: roleUID)",
      returns = "void",
      valuetype = "void"
    },
    findInReadyByObjUID={
      type = "method",
      args="(unsigned int: _key,bool: logFlag)",
      returns = "CRole*",
      valuetype = "CRole"
    },
    findInReadyByRoleUID={
      type = "method",
      args="(unsigned long long: _key,bool: logFlag)",
      returns = "CRole*",
      valuetype = "CRole"
    },
    setNewRoleScriptFunctionName={
      type = "method",
      args="(string: functionName)",
      returns = "void",
      valuetype = "void"
    },
    GetPtr={
      type = "method",
      args="()",
      returns = "CRoleManager*",
      valuetype = "CRoleManager"
    },
  },
},

CMapDbServerHandler = {
  type = "class",
  inherits = "CGameDatabaseHandler ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMapDbServerHandler",
      valuetype = "CMapDbServerHandler",
    },
    handle={
      type = "method",
      args="(char*: msg,unsigned int: len)",
      returns = "EHandleRet",
      valuetype = "EHandleRet"
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
    close={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    sendSaveMapServerDataTask={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
  },
},

CMapConfigTbl = {
  type = "class",
  inherits = "CConfigTbl ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMapConfigTbl",
      valuetype = "CMapConfigTbl",
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
    getKey={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    setKey={
      type = "method",
      args="(unsigned short: key)",
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

CMapTblLoader = {
  type = "class",
  inherits = "CConfigLoader<CMapTblLoader, CMapConfigTbl> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMapTblLoader",
      valuetype = "CMapTblLoader",
    },
    findByKey={
      type = "method",
      args="(unsigned short: key)",
      returns = "CMapConfigTbl*",
      valuetype = "CMapConfigTbl"
    },
    readRow={
      type = "method",
      args="(TiXmlElement*: row,int: count,CMapConfigTbl*: destRow)",
      returns = "bool",
      valuetype = "bool"
    },
    GetPtr={
      type = "method",
      args="()",
      returns = "CMapTblLoader*",
      valuetype = "CMapTblLoader"
    },
  },
},

CBufferConfigTbl = {
  type = "class",
  inherits = "CConfigTbl ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CBufferConfigTbl",
      valuetype = "CBufferConfigTbl",
    },
    isParamOverlap={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getAttrAry={
      type = "method",
      args="(unsigned int: level)",
      returns = "vector<ExtendAttr, allocator<ExtendAttr> >*",
      valuetype = "vector<ExtendAttr, allocator<ExtendAttr> >"
    },
    isPermanence={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isInterval={
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
    isTimeOverlap={
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
    isShow={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getID={
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
    setKey={
      type = "method",
      args="(unsigned short: key)",
      returns = "void",
      valuetype = "void"
    },
    toString={
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
    getParam={
      type = "method",
      args="(unsigned int: index)",
      returns = "vector<int, allocator<int> >*",
      valuetype = "vector<int, allocator<int> >"
    },
    isOfflineCountTime={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getAttrArySize={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    isOfflineDisa={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getParamArySize={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
  },
},

CBufferConfigTblLoader = {
  type = "class",
  inherits = "CConfigLoader<CBufferConfigTblLoader, CBufferConfigTbl> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CBufferConfigTblLoader",
      valuetype = "CBufferConfigTblLoader",
    },
    readRow={
      type = "method",
      args="(TiXmlElement*: row,int: count,CBufferConfigTbl*: buffRow)",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

CMapServerBase = {
  type = "class",
  inherits = "GxService CGamePassTimerBase CManualSingleton<CMapServerBase> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMapServerBase",
      valuetype = "CMapServerBase",
    },
    getServerType={
      type = "method",
      args="()",
      returns = "EServerType",
      valuetype = "EServerType"
    },
    onRegisteToWorld={
      type = "method",
      args="(unsigned short: serverID)",
      returns = "void",
      valuetype = "void"
    },
    isDynamicServer={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    onLoad={
      type = "method",
      args="(CIni*: iniFile,string: fileName)",
      returns = "bool",
      valuetype = "bool"
    },
    isConfigRemotePath={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getToClientListenPort={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    canOpenDynamicMap={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getServerID={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    onAfterStart={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    init={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getToClientListenIP={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    getScenePoolNum={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getMaxRoleNum={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    onWorldServerInfo={
      type = "method",
      args="(WMServerInfo*: packet)",
      returns = "void",
      valuetype = "void"
    },
  },
},

CGameConfig = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CGameConfig",
      valuetype = "CGameConfig",
    },
    setBroadcastRange={
      type = "method",
      args="(unsigned int: val)",
      returns = "void",
      valuetype = "void"
    },
    setBlockSize={
      type = "method",
      args="(unsigned int: val)",
      returns = "void",
      valuetype = "void"
    },
    getSameScreenRadius={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
  },
},

CMapServerConfig = {
  type = "class",
  inherits = "CGxServiceConfig ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMapServerConfig",
      valuetype = "CMapServerConfig",
    },
    getProfileFrame={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    getRecordeSvrSocketAttr={
      type = "method",
      args="()",
      returns = "SockAttr*",
      valuetype = "SockAttr"
    },
    getMapDataPath={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    getManagerServerPort={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    getGmListenIP={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    onAfterLoad={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    setFrameNum={
      type = "method",
      args="(int: num)",
      returns = "void",
      valuetype = "void"
    },
    getRecordeServerPort={
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
    getWorldServerPort={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    getConfigTblPath={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    check={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getResourceSvrSocketAttr={
      type = "method",
      args="()",
      returns = "SockAttr*",
      valuetype = "SockAttr"
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
      returns = "string",
      valuetype = "string"
    },
    getResourceServerPort={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    getToClientListenPort={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    getOpenGmLog={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getClientListenSocketAttr={
      type = "method",
      args="()",
      returns = "SockAttr*",
      valuetype = "SockAttr"
    },
    getHttpListenIP={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    getRolePoolNum={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    getManagerServerIP={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    getOpenGmCheck={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getWorldServerIP={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    getResourceServerIP={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    getHttpListenPort={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    getGmListenSocketAttr={
      type = "method",
      args="()",
      returns = "SockAttr*",
      valuetype = "SockAttr"
    },
    isDynamicMapServer={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getManagerSvrSocketAttr={
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
    getMapServerID={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    setHttpCheck={
      type = "method",
      args="(bool: val)",
      returns = "void",
      valuetype = "void"
    },
    setRecordeSize={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getGmListenPort={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    getMapServerType={
      type = "method",
      args="()",
      returns = "EServerType",
      valuetype = "EServerType"
    },
    getHttpCheck={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getRiskSceneNum={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    getOpenRecordeServer={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    getWorldSvrSocketAttr={
      type = "method",
      args="()",
      returns = "SockAttr*",
      valuetype = "SockAttr"
    },
    getToClientListenIP={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    getRecordeServerIP={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    getScenePoolNum={
      type = "method",
      args="(int: serverType,int: pkType)",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    getMapIDs={
      type = "method",
      args="()",
      returns = "vector<unsigned short, allocator<unsigned short> >",
      valuetype = "vector<unsigned short, allocator<unsigned short> >"
    },
  },
},

BroadInfo = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "BroadInfo",
      valuetype = "BroadInfo",
    },
    setChatStr={
      type = "method",
      args="(CCharArray2<250>: val)",
      returns = "void",
      valuetype = "void"
    },
    cleanUp={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getChatStr={
      type = "method",
      args="()",
      returns = "CCharArray2<250>",
      valuetype = "CCharArray2<250>"
    },
  },
},

CBroadTimer = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CBroadTimer",
      valuetype = "CBroadTimer",
    },
    isNeedDel={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    update={
      type = "method",
      args="(int: diff)",
      returns = "bool",
      valuetype = "bool"
    },
    getID={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
    getMsg={
      type = "method",
      args="()",
      returns = "string",
      valuetype = "string"
    },
    init={
      type = "method",
      args="(unsigned short: id,BroadInfo*: info)",
      returns = "bool",
      valuetype = "bool"
    },
    setID={
      type = "method",
      args="(unsigned short: val)",
      returns = "void",
      valuetype = "void"
    },
  },
},

CAnnouncementSysManager = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CAnnouncementSysManager",
      valuetype = "CAnnouncementSysManager",
    },
    delBroad={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    addAnnouncement={
      type = "method",
      args="(vector<BroadInfo, allocator<BroadInfo> >*: data)",
      returns = "void",
      valuetype = "void"
    },
    update={
      type = "method",
      args="(int: diff,map<unsigned short, basic_string<char>, less<unsigned short>, allocator<pair<const unsigned short, basic_string<char> > > >: msgs)",
      returns = "void",
      valuetype = "void"
    },
    IsSystemID={
      type = "method",
      args="(unsigned short: id)",
      returns = "bool",
      valuetype = "bool"
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

CMapServer = {
  type = "class",
  inherits = "CMapServerBase ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMapServer",
      valuetype = "CMapServer",
    },
    getServerConfig={
      type = "method",
      args="()",
      returns = "CMapServerConfig*",
      valuetype = "CMapServerConfig"
    },
    onRegisteToWorld={
      type = "method",
      args="(unsigned short: serverID)",
      returns = "void",
      valuetype = "void"
    },
    getOpenTime={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    isDynamicServer={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    canOpenDynamicMap={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isGmLog={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isConfigRemotePath={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    getFirstStartTime={
      type = "method",
      args="()",
      returns = "unsigned int",
      valuetype = "unsigned int"
    },
    onWorldServerInfo={
      type = "method",
      args="(WMServerInfo*: packet)",
      returns = "void",
      valuetype = "void"
    },
    getStopTimer={
      type = "method",
      args="()",
      returns = "CStopTimer*",
      valuetype = "CStopTimer"
    },
    GetPtr={
      type = "method",
      args="()",
      returns = "CMapServerBase*",
      valuetype = "CMapServerBase"
    },
    InitStaticInstanace={
      type = "method",
      args="(lua_State*: L)",
      returns = "void",
      valuetype = "void"
    },
  },
},

CMap = {
  type = "class",
  inherits = "CMapBase ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMap",
      valuetype = "CMap",
    },
    getMapType={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
  },
},

CMapDataManagerBase = {
  type = "class",
  inherits = "CHashMultiIndex<CMapBase, false, 0> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMapDataManagerBase",
      valuetype = "CMapDataManagerBase",
    },
    getNormalMaps={
      type = "method",
      args="()",
      returns = "vector<unsigned short, allocator<unsigned short> >",
      valuetype = "vector<unsigned short, allocator<unsigned short> >"
    },
    isMapExist={
      type = "method",
      args="(unsigned short: key)",
      returns = "bool",
      valuetype = "bool"
    },
    findMap={
      type = "method",
      args="(unsigned short: uid)",
      returns = "CMapBase*",
      valuetype = "CMapBase"
    },
  },
},

CMapDataManager = {
  type = "class",
  inherits = "CMapDataManagerBase CManualSingleton<CMapDataManager> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMapDataManager",
      valuetype = "CMapDataManager",
    },
    addNewMap={
      type = "method",
      args="(unsigned short: mapID,string: mapName)",
      returns = "CMap*",
      valuetype = "CMap"
    },
    init={
      type = "method",
      args="(string: path)",
      returns = "bool",
      valuetype = "bool"
    },
    delMap={
      type = "method",
      args="(unsigned short: key)",
      returns = "void",
      valuetype = "void"
    },
    findMap={
      type = "method",
      args="(unsigned short: mapID)",
      returns = "CMap*",
      valuetype = "CMap"
    },
    GetPtr={
      type = "method",
      args="()",
      returns = "CMapDataManager*",
      valuetype = "CMapDataManager"
    },
  },
},

CLoadRoleDataTask = {
  type = "class",
  inherits = "CDbWrapTask ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CLoadRoleDataTask",
      valuetype = "CLoadRoleDataTask",
    },
    toString={
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
  },
},

CLoadRoleDataRetTask = {
  type = "class",
  inherits = "CDbConnTask ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CLoadRoleDataRetTask",
      valuetype = "CLoadRoleDataRetTask",
    },
    doRun={
      type = "method",
      args="()",
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

CSaveRoleDataTask = {
  type = "class",
  inherits = "CMapDbRequestTask ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CSaveRoleDataTask",
      valuetype = "CSaveRoleDataTask",
    },
    toString={
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
  },
},

CSaveRoleDataRetTask = {
  type = "class",
  inherits = "CMapDbResponseTask ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CSaveRoleDataRetTask",
      valuetype = "CSaveRoleDataRetTask",
    },
  },
},

CUpdateRoleDataTimerTask = {
  type = "class",
  inherits = "CMapDbRequestTask ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CUpdateRoleDataTimerTask",
      valuetype = "CUpdateRoleDataTimerTask",
    },
    toString={
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
  },
},

CMapServerData = {
  type = "class",
  inherits = "CManualSingleton<CMapServerData> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMapServerData",
      valuetype = "CMapServerData",
    },
    setMapServerID={
      type = "method",
      args="(unsigned short: id)",
      returns = "void",
      valuetype = "void"
    },
    getDbHandler={
      type = "method",
      args="(bool: logFlag)",
      returns = "CMapDbServerHandler*",
      valuetype = "CMapDbServerHandler"
    },
    initWorldServerInfo={
      type = "method",
      args="(CGameTime: openTime,CGameTime: firstStartTime)",
      returns = "void",
      valuetype = "void"
    },
    getWorldServerID={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    setPlatformID={
      type = "method",
      args="(unsigned char: id)",
      returns = "void",
      valuetype = "void"
    },
    setCDKeyStr={
      type = "method",
      args="(CFixString<50>: keyStr)",
      returns = "void",
      valuetype = "void"
    },
    setMapDbHandlerID={
      type = "method",
      args="(unsigned long long: index)",
      returns = "void",
      valuetype = "void"
    },
    getPlatformID={
      type = "method",
      args="()",
      returns = "unsigned char",
      valuetype = "unsigned char"
    },
    getCDKeyStr={
      type = "method",
      args="()",
      returns = "CFixString<50>",
      valuetype = "CFixString<50>"
    },
    setWorldServerID={
      type = "method",
      args="(unsigned short: id)",
      returns = "void",
      valuetype = "void"
    },
    getServerOpenDay={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    GetPtr={
      type = "method",
      args="()",
      returns = "CMapServerData*",
      valuetype = "CMapServerData"
    },
  },
},

CMapServerEvent = {
  type = "class",
  inherits = "IDumpHandler ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMapServerEvent",
      valuetype = "CMapServerEvent",
    },
    onDump={
      type = "method",
      args="(string: dumpName)",
      returns = "void",
      valuetype = "void"
    },
  },
},

CMapServerInitFlag = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMapServerInitFlag",
      valuetype = "CMapServerInitFlag",
    },
    setWorldRegiste={
      type = "method",
      args="(bool: flag)",
      returns = "void",
      valuetype = "void"
    },
    setServiceStart={
      type = "method",
      args="(bool: flag)",
      returns = "void",
      valuetype = "void"
    },
    setDbInit={
      type = "method",
      args="(bool: flag)",
      returns = "void",
      valuetype = "void"
    },
    clearInitSuccess={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    isServiceStart={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isInitSuccess={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
    isInitFaild={
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
  },
},

COpenDynamicScene = {
  type = "class",
  inherits = "CServiceTask ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "COpenDynamicScene",
      valuetype = "COpenDynamicScene",
    },
    setParam={
      type = "method",
      args="(unsigned int: objUID,unsigned short: mapID,AxisPos*: pos,ESceneType: sceneType)",
      returns = "void",
      valuetype = "void"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
  },
},

WLChargeRmb = {
  type = "class",
  inherits = "CServerPacket ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "WLChargeRmb",
      valuetype = "WLChargeRmb",
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
    getPackLen={
      type = "method",
      args="()",
      returns = "unsigned short",
      valuetype = "unsigned short"
    },
  },
},

CMapWorldServerHandler = {
  type = "class",
  inherits = "CMapWorldServerHandlerBase ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMapWorldServerHandler",
      valuetype = "CMapWorldServerHandler",
    },
    sendUnloadDataRet={
      type = "method",
      args="(EUnloadRoleType: retType,unsigned long long: accountID,unsigned long long: roleUID,unsigned long long: worldSockIndex)",
      returns = "void",
      valuetype = "void"
    },
    doBroadCast={
      type = "method",
      args="(CBasePacket*: packet,unsigned int: srcObjUID)",
      returns = "ETransCode",
      valuetype = "ETransCode"
    },
    handleUnloadRoleData={
      type = "method",
      args="(WMUnloadRoleData*: packet)",
      returns = "EHandleRet",
      valuetype = "EHandleRet"
    },
    handleRecharge={
      type = "method",
      args="(WMRecharge*: packet)",
      returns = "EHandleRet",
      valuetype = "EHandleRet"
    },
    handleUpdateUserata={
      type = "method",
      args="(WMUpdateUserData*: packet)",
      returns = "EHandleRet",
      valuetype = "EHandleRet"
    },
    handleLoadRoleData={
      type = "method",
      args="(WMLoadRoleData*: packet)",
      returns = "EHandleRet",
      valuetype = "EHandleRet"
    },
    sendRoleQuit={
      type = "method",
      args="(unsigned long long: accountID,unsigned int: objUID,unsigned long long: roleUID,unsigned long long: worldSockIndex)",
      returns = "void",
      valuetype = "void"
    },
    handleLimitChatInfo={
      type = "method",
      args="(CWMLimitChatInfo*: packet)",
      returns = "EHandleRet",
      valuetype = "EHandleRet"
    },
    handleLimitAccountInfo={
      type = "method",
      args="(CWMLimitAccountInfo*: packet)",
      returns = "EHandleRet",
      valuetype = "EHandleRet"
    },
    doTrans={
      type = "method",
      args="(CBasePacket*: packet,unsigned int: srcObjUID,unsigned int: destObjUID)",
      returns = "ETransCode",
      valuetype = "ETransCode"
    },
    handleLimitInfo={
      type = "method",
      args="(CLWLimitInfoUpdate*: packet)",
      returns = "EHandleRet",
      valuetype = "EHandleRet"
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

CNpcConfigTbl = {
  type = "class",
  inherits = "CConfigTbl ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CNpcConfigTbl",
      valuetype = "CNpcConfigTbl",
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
    setKey={
      type = "method",
      args="(int: key)",
      returns = "void",
      valuetype = "void"
    },
    toString={
      type = "method",
      args="()",
      returns = "char*",
      valuetype = "char"
    },
    getKey={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
  },
},

CNpcTblLoader = {
  type = "class",
  inherits = "CConfigLoader<CNpcTblLoader, CNpcConfigTbl> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CNpcTblLoader",
      valuetype = "CNpcTblLoader",
    },
    findByKey={
      type = "method",
      args="(int: key)",
      returns = "CNpcConfigTbl*",
      valuetype = "CNpcConfigTbl"
    },
    readRow={
      type = "method",
      args="(TiXmlElement*: row,int: count,CNpcConfigTbl*: destRow)",
      returns = "bool",
      valuetype = "bool"
    },
    GetPtr={
      type = "method",
      args="()",
      returns = "CNpcTblLoader*",
      valuetype = "CNpcTblLoader"
    },
  },
},

RandDropComInfo = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "RandDropComInfo",
      valuetype = "RandDropComInfo",
    },
  },
},

RandDropConfigInfo = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "RandDropConfigInfo",
      valuetype = "RandDropConfigInfo",
    },
  },
},

RandDropComInfoEx = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "RandDropComInfoEx",
      valuetype = "RandDropComInfoEx",
    },
  },
},

RandDropConfigInfoEx = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "RandDropConfigInfoEx",
      valuetype = "RandDropConfigInfoEx",
    },
  },
},

CRandDropTbl = {
  type = "class",
  inherits = "CConfigTbl ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CRandDropTbl",
      valuetype = "CRandDropTbl",
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

CRandDropTblLoader = {
  type = "class",
  inherits = "CConfigLoader<CRandDropTblLoader, CRandDropTbl> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CRandDropTblLoader",
      valuetype = "CRandDropTblLoader",
    },
    HandleConvert={
      type = "method",
      args="(string: strtemp,int: var,CRandDropTbl*: destRow,TiXmlElement*: row)",
      returns = "bool",
      valuetype = "bool"
    },
    findByKey={
      type = "method",
      args="(unsigned int: key)",
      returns = "CRandDropTbl*",
      valuetype = "CRandDropTbl"
    },
    getRow={
      type = "method",
      args="()",
      returns = "CRandDropTbl*",
      valuetype = "CRandDropTbl"
    },
    readRow={
      type = "method",
      args="(TiXmlElement*: row,int: count,CRandDropTbl*: destRow)",
      returns = "bool",
      valuetype = "bool"
    },
    GetPtr={
      type = "method",
      args="()",
      returns = "CRandDropTblLoader*",
      valuetype = "CRandDropTblLoader"
    },
  },
},

CranddropItemMgr = {
  type = "class",
  inherits = "CManualSingleton<CranddropItemMgr> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CranddropItemMgr",
      valuetype = "CranddropItemMgr",
    },
    randItemByDropId={
      type = "method",
      args="(unsigned int: dropid,vector<ItemReward, allocator<ItemReward> >*: iteminfovec)",
      returns = "void",
      valuetype = "void"
    },
    GetPtr={
      type = "method",
      args="()",
      returns = "CranddropItemMgr*",
      valuetype = "CranddropItemMgr"
    },
  },
},

CSceneManagerBase = {
  type = "class",
  inherits = "CHashMultiIndex<CMapSceneBase, false, 18446744073709551615> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CSceneManagerBase",
      valuetype = "CSceneManagerBase",
    },
    getNext={
      type = "method",
      args="()",
      returns = "CMapSceneBase*",
      valuetype = "CMapSceneBase"
    },
    addNewScene={
      type = "method",
      args="(unsigned long long: sceneID,unsigned char: mapType,bool: addFlag)",
      returns = "CMapSceneBase*",
      valuetype = "CMapSceneBase"
    },
    getBegin={
      type = "method",
      args="()",
      returns = "CMapSceneBase*",
      valuetype = "CMapSceneBase"
    },
    getDynamicMapNum={
      type = "method",
      args="()",
      returns = "int",
      valuetype = "int"
    },
    openDynamicScene={
      type = "method",
      args="(unsigned short: mapID,ESceneType: sceneType,unsigned int: objUID,bool: needSendToWorld)",
      returns = "CMapSceneBase*",
      valuetype = "CMapSceneBase"
    },
    sendOpenDynamicToWorld={
      type = "method",
      args="(CMapSceneBase*: pScene)",
      returns = "void",
      valuetype = "void"
    },
    findScene={
      type = "method",
      args="(unsigned long long: sceneID)",
      returns = "CMapSceneBase*",
      valuetype = "CMapSceneBase"
    },
    genSceneID={
      type = "method",
      args="(unsigned short: serverID,unsigned char: mapType,unsigned short: mapID)",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    update={
      type = "method",
      args="(int: diff)",
      returns = "void",
      valuetype = "void"
    },
    isSceneExist={
      type = "method",
      args="(unsigned long long: key)",
      returns = "bool",
      valuetype = "bool"
    },
    closeDynamicScene={
      type = "method",
      args="(unsigned long long: sceneID,bool: needSendToWorld)",
      returns = "void",
      valuetype = "void"
    },
    statDynamicSceneNum={
      type = "method",
      args="()",
      returns = "void",
      valuetype = "void"
    },
    getLeastScene={
      type = "method",
      args="(unsigned short: mapID)",
      returns = "CMapSceneBase*",
      valuetype = "CMapSceneBase"
    },
    sendCloseDynamicToWorld={
      type = "method",
      args="(unsigned long long: sceneID)",
      returns = "void",
      valuetype = "void"
    },
    delScene={
      type = "method",
      args="(unsigned long long: sceneID)",
      returns = "void",
      valuetype = "void"
    },
    initAllMap={
      type = "method",
      args="()",
      returns = "bool",
      valuetype = "bool"
    },
  },
},

CSceneManager = {
  type = "class",
  inherits = "CSceneManagerBase CManualSingleton<CSceneManager> ",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CSceneManager",
      valuetype = "CSceneManager",
    },
    addNewScene={
      type = "method",
      args="(unsigned long long: sceneID,unsigned char: mapType,bool: addFlag)",
      returns = "CMapSceneBase*",
      valuetype = "CMapSceneBase"
    },
    delScene={
      type = "method",
      args="(unsigned long long: sceneID)",
      returns = "void",
      valuetype = "void"
    },
    init={
      type = "method",
      args="(CMapServerConfig*: config)",
      returns = "bool",
      valuetype = "bool"
    },
    findScene={
      type = "method",
      args="(unsigned long long: sceneID)",
      returns = "CMapScene*",
      valuetype = "CMapScene"
    },
    GetPtr={
      type = "method",
      args="()",
      returns = "CSceneManager*",
      valuetype = "CSceneManager"
    },
  },
},

CMServerHelper = {
  type = "class",
  childs = {
    new = {
      description = "new object",
      type = "function",
      args = "()",
      returns = "CMServerHelper",
      valuetype = "CMServerHelper",
    },
    LuaGetRoleByName={
      type = "method",
      args="(string: roleName)",
      returns = "CRole*",
      valuetype = "CRole"
    },
    LuaGetRoleMgr={
      type = "method",
      args="()",
      returns = "CRoleManager*",
      valuetype = "CRoleManager"
    },
    LuaGetAnnouncementEventType={
      type = "method",
      args="(unsigned short: id)",
      returns = "int",
      valuetype = "int"
    },
    LuaGetServerData={
      type = "method",
      args="()",
      returns = "CMapServerData*",
      valuetype = "CMapServerData"
    },
    LuaAllAnnouncement={
      type = "method",
      args="(string: msg,int: lastTime,int: interval)",
      returns = "void",
      valuetype = "void"
    },
    LuaGetAllRole={
      type = "method",
      args="()",
      returns = "vector<CRole *, allocator<CRole *> >",
      valuetype = "vector<CRole , allocator<CRole > >"
    },
    LuaGetAnnouncementSysType={
      type = "method",
      args="(unsigned short: id)",
      returns = "char",
      valuetype = "char"
    },
    LuaToNum64={
      type = "method",
      args="(string: str)",
      returns = "unsigned long long",
      valuetype = "unsigned long long"
    },
    LuaKickRole={
      type = "method",
      args="(string: roleName)",
      returns = "void",
      valuetype = "void"
    },
    LuaGetRole={
      type = "method",
      args="(unsigned long long: roleUID)",
      returns = "CRole*",
      valuetype = "CRole"
    },
    LuaGetMapServer={
      type = "method",
      args="()",
      returns = "CMapServer*",
      valuetype = "CMapServer"
    },
    LuaChat={
      type = "method",
      args="(CRole*: pRole,string: msg)",
      returns = "void",
      valuetype = "void"
    },
  },
},

}
end