Config = Class("Config");

Config.lineSP = "\n";
Config.msgMgrDBPath = "db\\msg\\";
Config.moduleDBPath = "db\\";
Config.mailDBPath = "db\\mails\\";
Config.chatDBPath = "db\\chats\\";
Config.rechargeDBPath = "db\\recharge\\"
Config.indianaPath = "db\\indiana\\"
Config.tradePath = "db\\trade\\"
Config.tradeRolePath = "db\\trade\\role\\"
Config.shopDBPath = "db\\shop\\"
Config.shopRecordDBPath = "db\\shop\\record\\"
Config.shopDBRolePath = "db\\shop\\role\\"
Config.logCoinDir = "db\\log\\coin\\"

---------------DEBUG
Config.enableGetGolds = true;

---------------
Config.systemUID=1;
Config.decReachGolds = {{10000,1000},{100000,20000},{1000000,300000},{10000000,3000000}}
Config.indianaAddInterval = 10;
Config.freeGoldsOnce = 2000;
Config.freeGoldsInterval = 7200;
Config.minFreeGolds = 2000;
Config.maxRankRobotNum = 100;
Config.robotResetScore = 100000;
Config.mailExpireTime = 1296000;
Config.mailDeleteTime = 3888000;
Config.roleMailExpireTime = 1296000;
Config.accountPrefix = "yy"
Config.accountNumLen = 6;
Config.passSuffix = "xjf"
Config.passwdLen = 14;
Config.uploadURL = ""
Config.robotUserType = 1000;
Config.genRobotNum = 100;
Config.sysIconNum = 6;
Config.offlineLimitGolds = 1000;
Config.offlineTimeRate = 1;
Config.lotteryItems = {
	{{weight=50,jewels=4},{weight=40,jewels=5},{weight=30,jewels=6}},
	{{weight=50,jewels=10},{weight=40,jewels=11},{weight=30,jewels=12},{weight=20,jewels=13}},
	{{weight=50,jewels=30},{weight=40,jewels=31},{weight=30,jewels=32},{weight=20,jewels=33}},
}
Config.lotteryOdds = {}
Config.lotteryConsumes = {25000,50000,300000}
Config.prompts = {
	{min=10,max=20},
--	{min=15,max=25},
}
Config.sevenAwards = {1000,1000,1000,1000,1000,1000,3000};
Config.robotInitCharmss = {30, 1000};
Config.robotInitGolds = {300000, 5000000};
Config.robotInitJewels = {300, 5000};
Config.robotInitLevel = {5, 30};
Config.robotVipLevel = {1, 10};
Config.robotGiftNums = {20, 100};
Config.giftIdNum = 5;
Config.maxRoomRoleNum = 3;
Config.robotChangeGolds = {10000, 100000}
Config.robotEnterGolds = {{50000, 80000}, {100000, 150000}, {150000, 250000}}
Config.roomTicketInterval = 30
Config.roomTicketOdds = 20
Config.roomTicketOtherInterval = 10
Config.roomTicketOtherOdds = 700
Config.roomEnterLimitNormal = {{3000, 5000}, {3000, 5000}, {3000, 5000}}
Config.roomAddLimitNormal = {{3000, 5000}, {4000, 6000}, {5000, 7000}}
Config.roomSpecialMinLimit = {5000, 15000, 50000}
Config.roomDiffLimitNormal = {7000, 8000, 9000}
Config.roomNormalMaxInterval = 5
Config.roomNormalMaxSub = {300, 600, 1000}
Config.goldsWaveCount = 5
Config.waveGolds = {4000,10000,300000}
Config.goldsWaveInterval = 600;
Config.roomAddGoldOnce = 400;
Config.roomChangeGoldOnce = 2000;
Config.roomTicketInterval = 1000000; -- minute
Config.roomTicketLimit = 2000;
Config.roomTicketOnce = {min=50,max=100};
Config.roomTickOdds = 10;
Config.roomLogTime = 10;
Config.maxRoomGainLimitGolds = {20000, 50000, 300000}
Config.maxRoomLimitGolds = {120000,300000,3000000}
Config.roomDecLimitNormal = {-30000,-100000,-300000}
Config.initReachGolds = 20000;
Config.maxGainStartTime = 48*3600;
Config.maxGainRoomTime = 7200;
Config.maxGainRoomCount = 100;
Config.maxGainLoseRate = 1.3;
Config.initGolds = 5000;
Config.roomGiveGiftInterval = 2*24*3600;
Config.roomAddFrientInterval = 3*24*3600;
Config.roomGiveGiftLimit = 50;
Config.roomAddFriendLimit = 15;
Config.decLimit = {roomTimes = 3600,enterRoomCount=40,gainGolds=50000,gainCount=15}
Config.gainOddsStartGolds = 5000;
Config.decRoomLimitGolds = 100;
Config.vipOdds = {0.1,0.1,0.1};
Config.vipLevels = {
	{exp=1,shopAdd=0.05,tradeAdd=0.05,charmAdd=0.05,loginAdd=0.5,catAdd=0,onlineAdd=0.5},
	{exp=20,shopAdd=0.05,tradeAdd=0.1,charmAdd=0.1,loginAdd=1.0,catAdd=0,onlineAdd=1.0},
	{exp=100,shopAdd=0.05,tradeAdd=0.15,charmAdd=0.15,loginAdd=1.0,catAdd=0.2,onlineAdd=1.0},
	{exp=200,shopAdd=0.1,tradeAdd=0.2,charmAdd=0.2,loginAdd=1.0,catAdd=0.4,onlineAdd=1.0},
	{exp=500,shopAdd=0.1,tradeAdd=0.25,charmAdd=0.25,loginAdd=1.0,catAdd=0.6,onlineAdd=1.0},
	{exp=1000,shopAdd=0.15,tradeAdd=0.3,charmAdd=0.3,loginAdd=1.0,catAdd=1.0,onlineAdd=1.0}
};
Config.tradeItems = {
	{0, 30, "4", 3000, 1},
	{0, 50, "5", 5000, 2},
	{0, 100, "6", 10000, 3},
	{5000, 0, "1", 100, 4},
	{10000, 0, "1", 200, 5},
	{50000, 0, "2", 1000, 6},
	{100000, 0, "2", 2000, 7},
	{500000, 0, "3", 10000, 8},
	{1000000, 0, "3", 20000, 9}
}
Config.charmItems = {
	{5000, "1", 100, 1},
	{10000, "1", 200, 2},
	{50000, "2", 1000, 3},
	{100000, "2", 2000, 4},
	{500000, "3", 10000, 5},
	{1000000, "3", 20000, 6}
}

-- 1-golds 2:cannon 3:giftPacks
Config.mallItems = {
	---- Golds 1-50
	[1] = {golds=5000, paycode=1, price=30, type=1, desc="一大堆金币", name="5000金币", icon="1"},
	[2] = {golds=6000, paycode=2, price=50, type=1, desc="一大堆金币", name="5000金币", icon="1"},
	[3] = {golds=7000, paycode=3, price=100, type=1, desc="一大堆金币", name="5000金币", icon="2"},
	[4] = {golds=8000, paycode=4, price=150, type=1, desc="一大堆金币", name="5000金币", icon="2"},
	[5] = {golds=9000, paycode=5, price=300, type=1, desc="一大堆金币", name="5000金币", icon="3"},
	[6] = {golds=10000, paycode=6, price=1000, type=1, desc="一大堆金币", name="5000金币", icon="3"},

	---- Cannon 51-100
	[51] = {id=5, bc=1, paycode=101, price=30, type=2, desc="威力极强", name="激光炮", icon="5"},
	[52] = {id=6, bc=1, paycode=102, price=50, type=2, desc="威力极强", name="冰冻炮", icon="6"},
	[53] = {id=7, bc=3, paycode=103, price=100, type=2, desc="威力极强", name="镭陨炮", icon="7"},
	[54] = {id=8, bc=3, paycode=104, price=150, type=2, desc="威力极强", name="辐射炮", icon="8"},
	[55] = {id=9, bc=3, paycode=105, price=300, type=2, desc="威力极强", name="闪电炮", icon="9"},
	--[56] = {id=10, bc=1, paycode=106, price=1000, type=2, desc="威力极强", name="焚天炮", icon="10"},

	---- GiftPack 101-150
	[101] = {
		paycode=201, price=30, type=3, desc="优惠礼包", name="激光炮礼包", icon="01",
		items={
			{itemType=1,golds=1000},
			{itemType=4,id=5,bc=1},
		}
	},
	[102] = {
		paycode=202, price=30, type=3, desc="优惠礼包", name="冰冻炮礼包", icon="01",
		items={
			{itemType=1,golds=1000},
			{itemType=4,id=6,bc=1},
		}
	},
	[103] = {
		paycode=203, price=30, type=3, desc="优惠礼包", name="镭陨炮礼包", icon="01",
		items={
			{itemType=1,golds=1000},
			{itemType=4,id=7,bc=3},
		}
	},
	[104] = {
		paycode=204, price=30, type=3, desc="优惠礼包", name="闪电炮礼包", icon="01",
		items={
			{itemType=1,golds=1000},
			{itemType=4,id=8,bc=3},
		}
	},
	[105] = {
		paycode=205, price=30, type=3, desc="优惠礼包", name="焚天炮礼包", icon="01",
		items={
			{itemType=1,golds=1000},
			{itemType=4,id=9,bc=3},
		}
	},
	[106] = {
		paycode=206, price=30, type=3, desc="优惠礼包", name="超值礼包", icon="01",
		items={
			{itemType=1,golds=1000},
			{itemType=4,id=10,bc=1},
		}
	},
}

Config.cannons = {
	{lvl=2,id=4,bc=1},
	{lvl=10,id=5,bc=1},
	{lvl=20,id=6,bc=1},
	{lvl=30,id=7,bc=1},
	{lvl=35,id=7,bc=2},
	{lvl=40,id=7,bc=3},
	{lvl=45,id=8,bc=1},
	{lvl=50,id=8,bc=2},
	{lvl=55,id=8,bc=3},
	{lvl=60,id=9,bc=1},
	{lvl=65,id=9,bc=2},
	{lvl=70,id=9,bc=3}
}
Config.levels = {
	{lvl=1,exp=5},
	{lvl=2,exp=180},
	{lvl=3,exp=900},
}
-- type: 1-gold 2-jewel
Config.luckyItems = {
	{type=1,num=1000,weight=150,index=1,anim="01"},
	{type=1,num=2000,weight=20,index=2,anim="02"},
	{type=1,num=3000,weight=4,index=3,anim="03"},
	{type=1,num=4000,weight=0,index=4,anim="04"},
	{type=1,num=5000,weight=0,index=5,anim="05"},
	{type=1,num=10000,weight=0,index=6,anim="06"},
	{type=2,num=1,weight=10,index=7,anim="07"},
	{type=2,num=5,weight=0,index=8,anim="08"},
}
Config.luckyGolds = {};
Config.luckyJewels = {};
Config.luckyGoldsOdds = 0;
Config.luckyJewelsOdds = 0;
