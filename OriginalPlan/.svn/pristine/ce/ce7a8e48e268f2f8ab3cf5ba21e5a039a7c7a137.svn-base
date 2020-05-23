// #include "core/game_exception.h"
// 
// #include "msg_bag.h"
// #include "game_module.h"
// #include "role.h"
// #include "module_def.h"
// #include "packet_cm_bag.h"
// 
// CMsgBag::CMsgBag()
// {
// 
// }
// 
// CMsgBag::~CMsgBag()
// {
// 
// }
// 
// void CMsgBag::sendItemList( const TItemInfoAry & arydata, EBagType bagtype, uint8 gridnum )
// {
// 	FUNC_BEGIN(BAG_MOD);
// 
// 	MCBagItemList packet;
// 	packet.itemary = arydata;
// 	packet.gridNum = gridnum;
// 	packet.bagtype = static_cast<uint8>(bagtype);
// 	getRole()->sendPacket(packet);
// 
// 	FUNC_END(DRET_NULL);
// }
// 
// void CMsgBag::sendItemOperator( const uint8 optype, EBagType bagtype, EGameRetCode retcode )
// {
// 	FUNC_BEGIN(BAG_MOD);
// 
// 	MCOperatorItem packet;
// 	packet.setRetCode(retcode);
// 	packet.bagtype = static_cast<uint8>(bagtype);
// 	packet.itemOperator = optype;
// 	getRole()->sendPacket(packet);
// 
// 	FUNC_END(DRET_NULL);
// }
// 
// void CMsgBag::sendItemBuyGrid(const TItemContainerSize_t itemnum, EBagType bagtype, EGameRetCode retcode)
// {
// 	FUNC_BEGIN(BAG_MOD);
// 
// 	MCBuyItemGrid packet;
// 	packet.setRetCode(retcode);
// 	packet.bagtype = static_cast<uint8>(bagtype);
// 	packet.capacity = itemnum;
// 	getRole()->sendPacket(packet);
// 
// 	FUNC_END(DRET_NULL);
// }
// 
// void CMsgBag::sendActAddItem( const TItemInfoAry & objvec, EBagType bagtype, EItemRecordType cirs )
// {
// 	FUNC_BEGIN(BAG_MOD);
// 
// 	MCActiveAddItem packet;
// 	packet.bagtype = static_cast<uint8>(bagtype);
// 	packet.additemary = objvec;
// 	packet.additemcircs = static_cast<uint8>(cirs);
// 	getRole()->sendPacket(packet);
// 
// 	FUNC_END(DRET_NULL);
// }
// 
// //void CMsgBag::sendActUseItem( const TActUseItemAry & objvec )
// //{
// //	FUNC_BEGIN(EMPLOY_MOD);
// //
// //	MCActiveUseItem packet;
// //	packet.useitemary = objvec;
// //	getRole()->sendPacket(packet);
// //
// //	FUNC_END(DRET_NULL);
// //}
// 
// void CMsgBag::sendActDeleteItem( const TDeleteItemAry & objvec, EBagType bagtype )
// {
// 	FUNC_BEGIN(BAG_MOD);
// 
// 	MCActiveDeleteItem packet;
// 	packet.bagtype = static_cast<uint8>(bagtype);
// 	packet.deleteitemary = objvec;
// 	getRole()->sendPacket(packet);
// 
// 	FUNC_END(DRET_NULL);
// }
// 
// void CMsgBag::sendNeatenBagResult( EBagType bagtype, const TUpdateItemInfoAry & updateitemattrary, const TDeleteItemInfoAry & deleteitemattrary, EGameRetCode retcode )
// {
// 	FUNC_BEGIN(BAG_MOD);
// 
// 	MCNeatenItem packet;
// 	packet.setRetCode(retcode);
// 	packet.bagtype = static_cast<uint8>(bagtype);
// 	packet.deleteItemAry			= deleteitemattrary;
// 	packet.updateItemInfoAry		= updateitemattrary;
// 	getRole()->sendPacket(packet);
// 
// 	FUNC_END(DRET_NULL);
// }
// 
// void CMsgBag::sendActUpdateItem( const TActUpdateItemAry & objvec, EBagType bagtype, EGameRetCode retcode )
// {
// 	FUNC_BEGIN(BAG_MOD);
// 
// 	MCActiveUpdateItem packet;
// 	packet.bagtype = static_cast<uint8>(bagtype);
// 	packet.updateitemary = objvec;
// 	getRole()->sendPacket(packet);
// 
// 	FUNC_END(DRET_NULL)
// }