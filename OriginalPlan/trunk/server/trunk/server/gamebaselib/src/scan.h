#ifndef _SCAN_H_
#define _SCAN_H_

#include "core/carray.h"

#include "game_util.h"

class CRoleBase;
class CGameObject;
class CMapSceneBase;

// ɨ����
#define MAX_SCAN_ROLE_NUM 1000
typedef std::vector<CRoleBase*> TScanRoleBaseList;
//typedef std::vector<CRole*> TScanRoleList;
#define MAX_SCAN_OJB_NUM 1000
typedef std::vector<CGameObject*> TScanObjList;

enum EScanReturn
{
	SCAN_RETURN_CONTINUE = 0 ,  //����ɨ����һ��object
	SCAN_RETURN_BREAK,          //ֹͣ�ڵ�ǰBlock���ɨ�裬ת����һ��Block��ȥ
	SCAN_RETURN_RETURN,         //�ж�ɨ�����
	SCAN_RETURN_NUMBER ,
};

typedef struct _ScanOperatorInit
{
public:
	// ����ָ��
	CMapSceneBase* scene ;
	// ����������Block
	TBlockID_t blockID ;
	// �����İ뾶����Block����Ϊ��λ��
	sint8 scanRange ;
	// true����RoleList, false����ObjectList
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

	//��ʼ��ɨ�������
	virtual bool init( TScanOperatorInit* pInit )
	{
		_init = pInit;
		return true;
	}
	//ɨ�������ʼǰ�ص�
	virtual bool onBeforeScan( ) { return true ; }
	//�жϲ����е�Zone�Ƿ���Ҫɨ��
	virtual bool isNeedScan( TBlockID_t blockID ){ return true ; }
	//������һ��Obj, ����ֵ�� SCANRETURN
	virtual EScanReturn onFindObject( CGameObject* pObj ){ return SCAN_RETURN_CONTINUE ; }
	//ɨ�������ɺ�ص�
	virtual void onAfterScan() {}

	// ��ȡ��ʼ������
	CMapSceneBase* getScene() const { return _init->scene; }
	bool isOnlyScanRole() const { return _init->scanRole; }
	uint8 getScanRange() const { return _init->scanRange; }
	TBlockID_t getBlockID() const { return _init->blockID; }

protected :
	TScanOperatorInit* _init;
};


#endif