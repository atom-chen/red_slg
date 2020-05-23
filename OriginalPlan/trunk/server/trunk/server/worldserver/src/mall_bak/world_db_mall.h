/********************************************************************
	created:	2013/09/24
	created:	24:9:2013   15:48
	file base:	world_db_mall
	file ext:	h
	author:		Z_Y_R
	
	purpose:	world��mall db���ӿ�
*********************************************************************/
#ifndef _WORLD_DB_MALL_H_
#define _WORLD_DB_MALL_H_

#include "game_util.h"
#include "db_struct_base.h"
#include "game_time.h"

#pragma pack(push, 1)

/// �̳�DB���ݽṹ(Ŀǰ��ʱд������)
typedef struct _dbGoodInfo : public GXMISC::TDBStructBase
{
	TStoreMarkNum_t			storeMarkNum;			///< ��Ʒ���
	TStoreItemNum_t			storeItemSurNum;		///< ��Ʒʣ����Թ������
	GXMISC::TGameTime_t		storeValidTime;			///< ��Ʒʣ����Թ����ʱ��
	TstoreCycle_t			storeCycle;				///< ��Ʒ���ڼ�¼(�����Ʒͬ��)
	GXMISC::CGameTime		storeOperatorTime;		///< ��Ʒ����ʱ��
	TGoodStateLise			storeStateTypeList;		///< ��Ʒ״̬�б�: @ref EStoreType

	//������ֵ(���ڶ�̬�޸�����)
	//����
	//����ֵ
	//ʱ��
	//�޹�������

	_dbGoodInfo()
	{
		clean();
	}

	void clean()
	{
		DCleanSubStruct(GXMISC::TDBStructBase);
		//::memset(this, 0, sizeof(*this));
	}
}TdbGoodInfo;

typedef struct _WgoodInfo : public _dbGoodInfo, public GXMISC::IArrayEnableSimple<struct _WgoodInfo>
{
	//�����߼����ñ��浽DB
	//uint8					storeIsRecode;			///< �Ƿ�Ҫ��¼��DB
	TstoreActType			storeBuyType;			///< ������ʽ
	uint8					storeState;				///< ��Ʒ״̬
	uint8					storeIsSell;			///< ��Ʒ�Ƿ���ۼ�¼

	_WgoodInfo()
	{
		DArrayKey(storeMarkNum);
		clean();
	} 

	_WgoodInfo(TstoreActType type){
		DArrayKey(storeMarkNum);
		clean();
		storeBuyType = type;
	}

	void clean()
	{
		DCleanSubStruct(GXMISC::TDBStructBase);
		::memset(this, 0, sizeof(*this));
	}
}TWgoodInfo;

typedef CArray1<struct _WgoodInfo>	TGoodDBInfoArray;	///< ��Ʒ��̬����

struct CMallGoodData : public GXMISC::TDBStructBase
{
	TGoodDBInfoArray  goodarray;

	CMallGoodData()
	{
		clean();
	}

	void clean()
	{
		goodarray.clear();
	}
};

#pragma pack(pop)

class CMallGoodBaseObj
{
private:
	friend class CWorldMallMgr;

public:
	CMallGoodBaseObj();
	virtual ~CMallGoodBaseObj();

public:

	void clean();

private:
	TWgoodInfo  _dbGoodInfo;		//��̬����
};


#endif //_WORLD_DB_MALL_H_
