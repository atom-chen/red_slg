/*
SQLyog Ultimate v8.32 
MySQL - 5.1.69 : Database - GameDB
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

/*Table structure for table `AccountTbl` */

/*DROP TABLE IF EXISTS `AccountTbl`; */

CREATE TABLE `AccountTbl` (
  `account_id` bigint(20) unsigned zerofill NOT NULL,
  `rmb` int(11) NOT NULL,
  `bind_rmb` int(11) NOT NULL,
  `total_charge_rmb` int(11) NOT NULL,
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin CHECKSUM=1;


/*Table structure for table `RoleTbl` */

/*DROP TABLE IF EXISTS `RoleTbl`; */

CREATE TABLE `RoleTbl` (
  `db_version` int(10) unsigned zerofill NOT NULL COMMENT '版本',
  `role_uid` bigint(20) unsigned zerofill NOT NULL COMMENT '角色UID',
  `object_uid` int(10) unsigned zerofill NOT NULL COMMENT '对象UID',
  `protype_id` tinyint(4) unsigned zerofill NOT NULL COMMENT '原型UID',
  `account_id` bigint(20) unsigned zerofill NOT NULL COMMENT '账号UID',
  `name` char(50) COLLATE utf8_bin NOT NULL COMMENT '名字',
  `level` tinyint(4) unsigned zerofill NOT NULL COMMENT '等级',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `logout_time` datetime NOT NULL COMMENT '登出时间',
  `scene_id` bigint(20) unsigned zerofill NOT NULL COMMENT '场景ID',
  `map_id` smallint(5) unsigned zerofill NOT NULL COMMENT '地图ID',
  `x` int(10) unsigned zerofill NOT NULL COMMENT 'X坐标',
  `y` int(10) unsigned zerofill NOT NULL COMMENT 'Y坐标',
  `last_scene_id` bigint(20) unsigned zerofill NOT NULL COMMENT '上次场景ID',
  `last_map_id` smallint(5) unsigned zerofill NOT NULL COMMENT '上次地图ID',
  `last_pos_x` int(10) unsigned zerofill NOT NULL COMMENT '上次X坐标',
  `last_pos_y` int(10) unsigned zerofill NOT NULL COMMENT '上次Y坐标',
  `login_count_one_day` int(10) unsigned zerofill NOT NULL COMMENT '一天之内的登陆次数',
  `bind_rmb` int(10) unsigned zerofill NOT NULL COMMENT '绑定元宝',
  `game_money` int(10) unsigned zerofill NOT NULL COMMENT '游戏币',
  `exp` int(10) unsigned zerofill NOT NULL COMMENT '经验',
  `pet_type_id` int(10) unsigned zerofill NOT NULL COMMENT '宠物类型ID',
  `accept_mission` longtext COLLATE utf8_bin NOT NULL COMMENT '当前接受的任务',
  `finish_mission` longtext COLLATE utf8_bin NOT NULL COMMENT '完成的任务列表',
  `last_finish_mission` int(10) unsigned zerofill NOT NULL COMMENT '上次完成的任务',
  `vip_level` smallint(5) unsigned zerofill NOT NULL COMMENT 'VIP等级',
  `vip_exp` int(10) unsigned zerofill NOT NULL COMMENT 'VIP经验',
  `bag_grid_num` tinyint(3) unsigned zerofill NOT NULL COMMENT '背包格子',
  `source_way` char(50) COLLATE utf8_bin NOT NULL COMMENT '渠道',
  `chisource_way` char(50) COLLATE utf8_bin NOT NULL COMMENT '子渠道',
  `sex` tinyint(3) unsigned zerofill NOT NULL COMMENT '性别',
  
  `strength` int(10) unsigned zerofill NOT NULL COMMENT '体力',

  PRIMARY KEY (`role_uid`),
  KEY `account_id_index` (`account_id`),
  KEY `name_index` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin CHECKSUM=1;

/*Table structure for table `WorldServerTbl` */

/*DROP TABLE IF EXISTS `WorldServerTbl`; */

CREATE TABLE `WorldServerTbl` (
  `server_id` int(10) unsigned zerofill NOT NULL,
  `add_diamod_time` datetime NOT NULL,
  PRIMARY KEY (`server_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin CHECKSUM=1;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
