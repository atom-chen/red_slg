#ifndef _PROTOCOLSTRUCT_H_
#define _PROTOCOLSTRUCT_H_

#pragma pack(push, 1)

class CharmsItemBeanReader
{
public:
	sint32 charms;
	uint8 descFlag;
	TCharArray2 desc;
	sint32 golds;
	uint8 iconFlag;
	TCharArray2 icon;
	sint32 id;
	uint8 nameFlag;
	TCharArray2 name;
};
class GiftBeanReader
{
public:
	sint32 count;
	sint32 giftId;
	uint8 iconFlag;
	TCharArray2 icon;
};
class PlayerInfoBeanReader
{
public:
	sint32 charms;
	uint8 constellationFlag;
	TCharArray2 constellation;
	uint32 dataId;
	sint32 golds;
	sint32 jewels;
	sint32 level;
	uint8 locationFlag;
	TCharArray2 location;
	TCharArray2 city;
	uint8 mobileNumFlag;
	TCharArray2 mobileNum;
	uint8 nickNameFlag;
	TCharArray2 nickName;
	uint8 selfIconUrlFlag;
	TCharArray2 selfIconUrl;
	uint8 signatureFlag;
	TCharArray2 signature;
	sint32 systemIcon;
	uint8 titleFlag;
	TCharArray2 title;
	uint8 male;
	uint8 online;
	sint32 vipLevel;
	uint8 giftsFlag;
	CArray2<GiftBeanReader> gifts;
};
class GiveGiftBeanReader
{
public:
	uint32 dataId;
	sint32 giftId;
	sint32 id;
	sint32 num;
	uint8 playerFlag;
	PlayerInfoBeanReader player;
};
class FriendPageBeanReader
{
public:
	uint8 agreeResponsesFlag;
	CArray2<PlayerInfoBeanReader> agreeResponses;
	uint8 disagreeResponsesFlag;
	CArray2<PlayerInfoBeanReader> disagreeResponses;
	uint8 friendDeletesFlag;
	CArray2<PlayerInfoBeanReader> friendDeletes;
	uint8 friendRequestsFlag;
	CArray2<PlayerInfoBeanReader> friendRequests;
	uint8 friendsFlag;
	CArray2<PlayerInfoBeanReader> friends;
	uint8 giveGiftsFlag;
	CArray2<GiveGiftBeanReader> giveGifts;
};
class SimplePlayerInfoBeanReader
{
public:
	sint32 level;
	uint8 nicknameFlag;
	TCharArray2 nickname;
	uint32 playerId;
	uint8 selfIconUrlFlag;
	TCharArray2 selfIconUrl;
	sint32 systemIcon;
	sint32 vipLevel;
	uint8 male;
};
class GiveGiftSimpleBeanReader
{
public:
	uint32 dataId;
	sint32 giftId;
	sint32 id;
	sint32 num;
	uint8 playerFlag;
	SimplePlayerInfoBeanReader player;
};
class FriendSimplePageBeanReader
{
public:
	uint8 agreeResponsesFlag;
	CArray2<SimplePlayerInfoBeanReader> agreeResponses;
	uint8 disagreeResponsesFlag;
	CArray2<SimplePlayerInfoBeanReader> disagreeResponses;
	uint8 friendDeletesFlag;
	CArray2<SimplePlayerInfoBeanReader> friendDeletes;
	uint8 friendRequestsFlag;
	CArray2<SimplePlayerInfoBeanReader> friendRequests;
	uint8 friendsFlag;
	CArray2<SimplePlayerInfoBeanReader> friends;
	uint8 giveGiftsFlag;
	CArray2<GiveGiftSimpleBeanReader> giveGifts;
};
class GuessBeanReader
{
public:
	uint8 iconFlag;
	TCharArray2 icon;
	sint32 id;
};
class LoginAwardBeanReader
{
public:
	sint32 day;
	sint32 golds;
};
class MailBeanReader
{
public:
	uint8 contentFlag;
	TCharArray2 content;
	sint32 endTime;
	sint32 golds;
	sint32 id;
	sint32 jewels;
	uint8 senderFlag;
	TCharArray2 sender;
	uint8 titleFlag;
	TCharArray2 title;
	uint8 attach;
	uint8 read;
	sint32 createTime;
};
class MyGuessBeanReader
{
public:
	sint32 golds;
	sint32 id;
};
class PeriodReportReader
{
public:
	sint32 enterGolds;
	uint8 fishingActsFlag;
	TCharArray2 fishingActs;
	sint32 goldsChangeAll;
	uint32 playerId;
	sint32 pos;
	sint32 time;
	sint32 totalBosses;
	sint32 totalDisks;
	sint32 totalHalfscreenBoom;
	sint32 totalSameTypeBoom;
	sint32 totalScreenBoom;
	uint8 self;
};
class PlayerPeriodActionReader
{
public:
	uint8 fishAppearsFlag;
	TCharArray2 fishAppears;
	uint8 fishConfigsFlag;
	TCharArray2 fishConfigs;
	sint32 goldsChange;
};
class PlayerSeatBeanReader
{
public:
	uint8 playerInfoFlag;
	PlayerInfoBeanReader playerInfo;
	uint8 reportFlag;
	PeriodReportReader report;
};
class RankBeanReader
{
public:
	uint8 nicknameFlag;
	TCharArray2 nickname;
	sint32 num;
	uint8 playerFlag;
	PlayerInfoBeanReader player;
	sint32 rank;
};
class RankDayBeanReader
{
public:
	uint8 fishRanksFlag;
	CArray2<RankBeanReader> fishRanks;
	uint8 giftRanksFlag;
	CArray2<RankBeanReader> giftRanks;
};
class RechargeOrderBeanReader
{
public:
	uint8 orderIdFlag;
	TCharArray2 orderId;
	sint32 rechargeDate;
	sint32 status;
};
class SeatPlayerBeanReader
{
public:
	sint32 currGolds;
	sint32 enterGolds;
	sint32 jewels;
	uint8 fishingActsFlag;
	TCharArray2 fishingActs;
	sint32 goldsChangeAll;
	sint32 tempDescGolds;
	uint32 playerId;
	uint8 playerNameFlag;
	TCharArray2 playerName;
	sint32 pos;
	sint32 time;
	sint32 totalBosses;
	sint32 totalDisks;
	sint32 totalHalfscreenBoom;
	sint32 totalSameTypeBoom;
	sint32 totalScreenBoom;
	uint8 self;
	uint8 doubleGolds;
	uint8 freeBullets;
	uint8 reachTarget;
	sint32 playerLevel;
	sint32 vipLevel;
	uint8 selfIconUrlFlag;
	TCharArray2 selfIconUrl;
	sint32 systemIcon;
	uint8 sex;
};
class SelfPeriodReportReader
{
public:
	uint8 fishActsFlag;
	TCharArray2 fishActs;
	sint32 goldsChange;
};
class ServerBeanReader
{
public:
	sint32 id;
	uint8 ipFlag;
	TCharArray2 ip;
	uint8 nameFlag;
	TCharArray2 name;
	sint32 port;
	sint32 status;
	uint8 uploadUrlFlag;
	TCharArray2 uploadUrl;
	uint8 recommend;
};
class ShopItemBeanReader
{
public:
	sint32 id;
	uint8 type;
	sint32 paycode;
	sint32 price;
	sint32 count;	// [golds or itemid]
	TCharArray2 desc;
	TCharArray2 icon;
	TCharArray2 name;
};
class SimpleRankBeanReader
{
public:
	uint8 nicknameFlag;
	TCharArray2 nickname;
	sint32 num;
	uint32 playerId;
	sint32 rank;
	uint8 selfIconUrlFlag;
	TCharArray2 selfIconUrl;
	sint32 systemIcon;
	uint8 sex;
	sint32 vipLevel;
};
class TradeItemBeanReader
{
public:
	uint8 descFlag;
	TCharArray2 desc;
	sint32 golds;
	sint32 huafei;
	uint8 iconFlag;
	TCharArray2 icon;
	sint32 id;
	sint32 jewels;
	uint8 nameFlag;
	TCharArray2 name;
};
class TwoValueBeanReader
{
public:
	sint32 value1;
	sint32 value2;
};
class VipInfoBeanReader
{
public:
	uint8 detailDescFlag;
	TCharArray2 detailDesc;
	sint32 level;
	uint8 mainDescFlag;
	TCharArray2 mainDesc;
	sint32 needPayGold;
};
class ChatMsgBeanReader
{
public:
	uint32 dataId;
	TCharArray2 msg;
	uint32 dateTime;
};
class CannonBeanReader
{
public:
	uint8 id;
	uint8 bc;
};

#pragma pack(pop)

#endif // _PROTOCOLSTRUCT_H_