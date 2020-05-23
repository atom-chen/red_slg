// #ifndef _MSG_BAG_H_
// #define _MSG_BAG_H_
// 
// #include "bag_struct.h"
// #include "msg_base.h"
// #include "record_define.h"
// 
// class CMsgBag : public CMsgBase
// {
// public:
// 	CMsgBag();
// 	virtual ~CMsgBag();
// 
// public:
// 	//�·����������б�
// 	void sendItemList(const TItemInfoAry & arydata, EBagType bagtype, uint8 gridnum);
// 	//�·������������
// 	void sendItemOperator(const uint8 optype, EBagType bagtype, EGameRetCode retcode);
// 	//�·����򱳰����ӽ��
// 	void sendItemBuyGrid(const TItemContainerSize_t  itemnum, EBagType bagtype, EGameRetCode retcode);
// 	//�·����������Ʒ���
// 	void sendActAddItem(const TItemInfoAry & objvec, EBagType bagtype, EItemRecordType cirs);
// 	//�·�����ɾ����Ʒ���
// 	void sendActDeleteItem(const TDeleteItemAry & objvec, EBagType bagtype);
// 	//�·�����������Ʒ���
// 	void sendActUpdateItem(const TActUpdateItemAry & objvec, EBagType bagtype, EGameRetCode retcode);
// 	//�·����������
// 	void sendNeatenBagResult(EBagType bagtype, const TUpdateItemInfoAry & updateitemattrary, const TDeleteItemInfoAry & deleteitemattrary, EGameRetCode retcode);
// };
// 
// #endif //_MSG_BAG_H_