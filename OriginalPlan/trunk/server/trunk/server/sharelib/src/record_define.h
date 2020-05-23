#ifndef _RECORD_DEFINE_H_
#define _RECORD_DEFINE_H_

#include "core/string_common.h"

// ��Ǯ��������
enum EMoneyRecordTouchType
{
	MONEYRECORDDEFINE = 0,			// Ĭ������
	MALL_BUYITEM = 1,				// �̳ǵ��߹���
	OPEN_BAGGUID = 2,				// ������������
	LEVELRAWARD = 3,				// ��������
	RECORD_SELL_ITEM = 4,			// ���۵���
	RECORD_NEW_ROLE_AWARD = 5,		// �½�ɫ���͵Ľ�Ǯ
	RECORD_COMPENSATE_RMB = 6,		// ��̨����
	RECORD_NEW_ROLE_RMB = 7,		// �½�ɫ���͵�Ԫ��
	RECORD_MISSION_AWARD = 22,		// ��������Ǯ

	MONEY_GM = 250,					// GM����

};
DToStringDef(EMoneyRecordTouchType);

// ���ߴ�������
enum EItemRecordType
{
	ITEM_RECORD_DEFAULT = 0,			// Ĭ��(�����ɾ��)״̬
	ITEM_RECORD_MALL_BUY = 1,			// �̳ǹ���
	ITEM_RECORD_USE_ITEM = 2,			// ����ʹ��
	ITEM_RECORD_NEW_ROLE = 3,			// �½�ɫ����
	ITEM_RECORD_EXCHANGE_GIFT = 4,		// �һ���һ��Ľ���
	ITEM_RECORD_DROP = 5,				// ��������

	ITEM_RECORD_ITEM_GM = 250,			// GM����
};
DToStringDef(EItemRecordType);

#endif