#ifndef _SCAN_H_
#define _SCAN_H_

#include "core/carray.h"

#include "game_util.h"

class CRoleBase;
class CGameObject;
class CMapSceneBase;

// 扫描器
#define MAX_SCAN_ROLE_NUM 1000
typedef std::vector<CRoleBase*> TScanRoleBaseList;
//typedef std::vector<CRole*> TScanRoleList;
#define MAX_SCAN_OJB_NUM 1000
typedef std::vector<CGameObject*> TScanObjList;

enum EScanReturn
{
	SCAN_RETURN_CONTINUE = 0 ,  //继续扫描下一个object
	SCAN_RETURN_BREAK,          //停止在当前Block里的扫描，转到下一个Block上去
	SCAN_RETURN_RETURN,         //中断扫描操作
	SCAN_RETURN_NUMBER ,
};

typedef struct _ScanOperatorInit
{
public:
	// 场景指针
	CMapSceneBase* scene ;
	// 搜索的中心Block
	TBlockID_t blockID ;
	// 搜索的半径（以Block数量为单位）
	sint8 scanRange ;
	// true搜索RoleList, false搜索ObjectList
	bool scanRole ;

	_ScanOperatorInit( )
	{
		scene = NULL ;
		blockID = INVALID_BLOCK_ID ;
		scanRange = 0 ;
		scanRole = false ;
	};
	~_ScanOperatorInit()
	{
		scene = NULL ;
		blockID = INVALID_BLOCK_ID ;
		scanRange = 0 ;
		scanRole = false ;
	}

	_ScanOperatorInit& operator = (const _ScanOperatorInit& rhs)
	{
		if(this == &rhs)
		{
			return *this;
		}

		scene = rhs.scene;
		blockID = rhs.blockID;
		scanRange = rhs.scanRange;
		scanRole = rhs.scanRole;
	}

	CMapSceneBase* getScene()
	{
		return scene;
	}

}TScanOperatorInit;

class CScanOperator
{
public :
	CScanOperator( ) {}
	virtual ~CScanOperator( ) {}

	//初始化扫描控制器
	virtual bool init( TScanOperatorInit* pInit )
	{
		_init = pInit;
		return true;
	}
	//扫描操作开始前回调
	virtual bool onBeforeScan( ) { return true ; }
	//判断参数中的Zone是否需要扫描
	virtual bool isNeedScan( TBlockID_t blockID ){ return true ; }
	//搜索到一个Obj, 返回值见 SCANRETURN
	virtual EScanReturn onFindObject( CGameObject* pObj ){ return SCAN_RETURN_CONTINUE ; }
	//扫描操作完成后回调
	virtual void onAfterScan() {}

	// 获取初始化数据
	CMapSceneBase* getScene() const { return _init->scene; }
	bool isOnlyScanRole() const { return _init->scanRole; }
	uint8 getScanRange() const { return _init->scanRange; }
	TBlockID_t getBlockID() const { return _init->blockID; }

protected :
	TScanOperatorInit* _init;
};


#endif