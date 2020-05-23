/********************************************************************
	created:	2013/09/16
	created:	16:9:2013   15:15
	file base:	world_mall_mgr
	file ext:	h
	author:		Z_Y_R
	
	purpose:	�̳ǹ�����
*********************************************************************/
#ifndef _WORLD_MALL_MGR_H_
#define _WORLD_MALL_MGR_H_

#include "core/singleton.h"

#include "game_util.h"
#include "world_db_mall.h"

class CMallTbl;

typedef std::vector<CMallGoodBaseObj>	GoodInfoVec;
typedef GoodInfoVec::iterator GoodIter;

class CWorldMallMgr : public GXMISC::CManualSingleton<CWorldMallMgr> 
{
public:
	CWorldMallMgr();
	~CWorldMallMgr();

public:
	void update(GXMISC::TDiffTime_t diff);

public:
	//�·�������map�Ķ�̬��Ʒ����(ͬ��)
	void sendMallGoodListToM();
	//������Ʒ
	void sendUpdateGoodListToM(const TGoodWTMapUpdateInfoArray & array);
	//���ع�����
	void sendRecvBuyResultToM(TRoleUID_t roleid, const TRoleBuyInfo & info, EGameRetCode retcode);
	//�㲥�����пͻ��ˣ������̳���Ʒ
	void sendAllPlayerUpdateGoodInfo(const TsendGoodInfoArray & array);

	//������ݴ�DB
	void fillDataFromDB(TGoodDBInfoArray & array);
	//�������ݵ�DB
	void saveDataToDB(TGoodDBInfoArray & array);

	//��ʼ������̬��Ʒ���ݣ�
	void initMallGoodList();
	//����(����1���ж��Ƿ���Ҫ�·�������map������,���и���)
	void updateMallGoodList(bool bflag = true);
	//����Ŀ����Ʒ����
	void updateTargetGood(TWgoodInfo & data);
	//ɾ��
	EGameRetCode deleteTargetGoodByMarkNum(TStoreMarkNum_t marknum);
	//��������Ʒ�߼�(MTW)
	void handleAskBuyGood(TRoleUID_t roleid, const TRoleBuyInfo & info);
private:
	//�������ñ��ʼ��
	void _initFromConfig();
	//������Ʒ����
	bool _updateTargetGood(TWgoodInfo & data, TstoreActType type);
	//��������Ʒ
	CMallGoodBaseObj * _findTargetMallGood(TStoreMarkNum_t marknum);
	//������Ʒ״̬
	void _handleGoodState(TWgoodInfo & data, TstoreActType type);
	//�������ڴ�������
	GXMISC::TGameTime_t _computusTouchDay(const CMallTbl * pmalltbl);
	//��Ʒ�Ƿ����ϼ�״̬
	uint8 _goodIsSpecial(GXMISC::TGameTime_t frontime, GXMISC::TGameTime_t lasttime);
	//��ʼ���������ϼ���Ʒ(ֻ����������Ʒ)
	void _handleOverTimeGood(TWgoodInfo & data, TstoreActType type);
	// ʱ������
	GXMISC::TGameTime_t _setTime(GXMISC::TGameTime_t temptime, sint32 h, sint32 m, sint32 s);
	// ������ƷΪ�¼�״̬����
	void _setTargetData(TWgoodInfo & data);
	// �ж���Ʒ״̬�Ƿ���ĳ״̬
	bool _isLocateState(TWgoodInfo & data, uint8 state);
	//����
	void dotest();
private:
	//GoodInfoMap		_goodInfoMap;
	GoodInfoVec			_goodInfoVec;
};

#define GetWorldMallMgr CWorldMallMgr::GetInstance()

#endif //_WORLD_MALL_MGR_H_
