#ifndef _OBJECT_H_
#define _OBJECT_H_

#include "core/multi_index.h"

#include "game_util.h"
#include "game_struct.h"
#include "game_define.h"
#include "game_misc.h"
#include "game_pos.h"
#include "block.h"
#include "object_util.h"

class CMapSceneBase;
class CRoleBase;
class CCharacterObject;
class CGameObject	
{
protected:
	CGameObject();
public:
	virtual ~CGameObject();

public:
	virtual void cleanUp();
	virtual bool init( const TObjInit* inits );
	// 击活了的Obj所执行的逻辑
	virtual bool update( uint32 diff );
	// 未被击活的Obj所执行的逻辑 @todo 子类必须处理此函数
	virtual bool updateOutBlock( uint32 diff ) { return true; } 

	// 事件处理
public:
	//virtual void onKillObject( TObjUID_t objID ) {}

	// 基础属性
public:
	TObjUID_t getObjUID() const{ return _objUID; } 
	void setObjUID(TObjUID_t objUID){ _objUID = objUID; genStrName(); } 
	void setObjType(EObjType type){ _objType = type; genStrName(); } 
	EObjType getObjType() const{ return _objType; } 
	TObjListNode* getObjNode(){ return &_objNode; } 
	TBlockID_t getBlockID() const{ return _blockID;} 
	void setBlockID(TBlockID_t blockID){ _blockID = blockID; } 
	bool isActive() const{ return _active; } 
	void setActive(bool flag){ _active = flag; } 
	TAxisPos* getAxisPos(){ return &_axisPos; }
	virtual void setAxisPos(const TAxisPos* pos); 
	virtual void setDir(TDir_t dir){ _dir = dir; } 
	TDir_t getDir() const { return _dir; } 
	CMapSceneBase* getScene() const { return _scene; } 
	void setScene(CMapSceneBase* scene) {_scene = scene; genStrName(); } 
	virtual void setMapID(TMapID_t mapID) { _mapID = mapID; genStrName(); } 
	TMapID_t getMapID() const { return _mapID; } 
	TObjGUID_t getObjGUID() const {return _objGUID; } 
	void setObjGUID(TObjGUID_t guid){ _objGUID = guid; } 
	TSceneID_t getSceneID(){ return _sceneID; } 
	virtual void setSceneID(TSceneID_t sceneID); 

	// 场景管理
public:
	virtual bool isNeedUpdateBlock(); 
	virtual bool updateBlock(); 
	virtual void onEnterScene(CMapSceneBase* pScene);
	virtual void onLeaveScene(CMapSceneBase* pScene);
	virtual void onRegisterToBlock(void);
	virtual void onUnregisterFromBlock(void);
	virtual bool isCanViewMe(const CGameObject *pObj){ return true; }
public:
	// 是否在有效范围内
	bool isInValidRadius(TMapID_t mapID, const TAxisPos* pPos, uint8 range);
	// 是否在有效范围内
	bool isInValidRadius(TMapID_t mapID, TAxisPos_t x1, TAxisPos_t y1, TAxisPos_t x2, TAxisPos_t y2, uint8 range);
	// 是否在有效范围内
	bool isInValidRadius(const CGameObject *pOb, uint8 range); 
	// 能否离开场景 
	bool isCanLeaveScene();         
	// 在对象更新的时候是否能离开场景
	bool isCanUpdateLeaveScene(); 
	// 离开场景块
	void leaveBlock();
public:
	// 是否在有效范围内
	static bool IsInValidRadius(TAxisPos_t x1, TAxisPos_t y1, TAxisPos_t x2, TAxisPos_t y2, uint8 range);

	// 对象管理
public:
	bool isRole() const { return _objType == OBJ_TYPE_ROLE; }
	bool isMonster() const { return _objType == OBJ_TYPE_MONSTER; }
	bool isCharacter() const { return CGameObject::IsCharacter(this); }
	bool isPet() const { return _objType == OBJ_TYPE_PET; }
	bool isObj(){ return true; }
public:
	template<typename T>
	T* toObj()
	{
		return dynamic_cast<T*>(this);
	}
	CCharacterObject* toCharacter();
	CRoleBase* toRoleBase();
	const CRoleBase* toRoleBase() const;

public:
	virtual uint16 getShapeData(char* data, uint32 maxSize) = 0;
	void setRoleAttr(EObjType objType); 
	void setMonsterAttr(EObjType objType); 
	void setPetAttr(EObjType objType); 

public:
	static bool IsCharacter( const CGameObject* pObj);
	static bool IsDynamic(const CGameObject* pObj);
	static const char* ObjTypeToStr(EObjType objType);

protected:
	TObjUID_t       _objUID;    // 对象UID
	TObjGUID_t      _objGUID;   // 对象GUID
	EObjType        _objType;   // 对象类型
	TObjListNode    _objNode;   // 在block中的存储结点
	TBlockID_t      _blockID;   // 块ID
	bool            _active;    // 是否已经进入场景
	TAxisPos        _axisPos;   // 坐标位置
	TDir_t          _dir;       // 方向
	CMapSceneBase*  _scene;     // 场景
	TSceneID_t      _sceneID;   // 场景ID
	TMapID_t        _mapID;     // 地图ID

public:
	virtual const char* toString() const; 
	virtual const std::string getObjString() const; 

public:
	virtual void genStrName();

protected:
	std::string _strName;

	DMultiIndexImpl1(TObjUID_t, _objUID, INVALID_OBJ_UID);
};

typedef std::list<CGameObject*>     TObjectList;
typedef std::vector<CGameObject*>   TObjectVector;

#endif	// _OBJECT_H_