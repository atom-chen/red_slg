/*
SQLyog Ultimate v8.32 
MySQL - 5.1.69 : Database - ServerDB
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `AccountTbl` */

DROP TABLE IF EXISTS `AccountTbl`;

CREATE TABLE `AccountTbl` (
  `account` char(16) COLLATE utf8_bin NOT NULL,
  `password` tinytext COLLATE utf8_bin NOT NULL,
  `account_id` bigint(20) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `last_server_id` int(10) unsigned zerofill NOT NULL,
  `platUID` char(20) COLLATE utf8_bin NOT NULL,
  `macid` char(20) COLLATE utf8_bin NOT NULL,
  `source_way` char(50) COLLATE utf8_bin NOT NULL,
  `chisource_way` char(50) COLLATE utf8_bin NOT NULL,
  `gm_power` int(11) NOT NULL,
  `servers` text COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`account`),
  KEY `account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Table structure for table `LimitAccountTbl` */

DROP TABLE IF EXISTS `LimitAccountTbl`;

CREATE TABLE `LimitAccountTbl` (
  `date` datetime NOT NULL,
  `role_accountid` bigint(20) unsigned NOT NULL,
  `role_uid` bigint(20) unsigned NOT NULL,
  `flag` tinyint(5) unsigned NOT NULL COMMENT '标识是否作用于全服',
  `serverid_ary` longtext COLLATE utf8_bin NOT NULL,
  `begin_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `unique_id` int(10) NOT NULL,
  PRIMARY KEY (`unique_id`),
  KEY `role_key` (`role_accountid`,`role_uid`),
  KEY `account_index` (`role_accountid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Table structure for table `LimitChatTbl` */

DROP TABLE IF EXISTS `LimitChatTbl`;

CREATE TABLE `LimitChatTbl` (
  `date` datetime NOT NULL,
  `role_accountid` bigint(20) unsigned NOT NULL,
  `role_uid` bigint(20) unsigned NOT NULL,
  `flag` tinyint(5) unsigned NOT NULL COMMENT '标识是否作用于全服',
  `serverid_ary` longtext COLLATE utf8_bin NOT NULL,
  `beign_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `unique_id` int(10) NOT NULL,
  PRIMARY KEY (`unique_id`),
  KEY `role_key` (`role_accountid`,`role_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Table structure for table `LoginServerTbl` */

DROP TABLE IF EXISTS `LoginServerTbl`;

CREATE TABLE `LoginServerTbl` (
  `server_id` int(11) NOT NULL,
  `ip` char(50) COLLATE utf8_bin NOT NULL,
  `port` int(11) NOT NULL,
  PRIMARY KEY (`server_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Table structure for table `RechargeLogTbl` */

DROP TABLE IF EXISTS `RechargeLogTbl`;

CREATE TABLE `RechargeLogTbl` (
  `serial_no` char(50) COLLATE utf8_bin NOT NULL,
  `account_id` bigint(20) unsigned NOT NULL,
  `rmb` int(11) NOT NULL,
  `bind_rmb` int(11) NOT NULL,
  `recharge_status` int(11) NOT NULL,
  `ret_code` int(11) NOT NULL,
  `server_id` int(11) NOT NULL,
  `date_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Table structure for table `RechargeRecordTbl` */

DROP TABLE IF EXISTS `RechargeRecordTbl`;

CREATE TABLE `RechargeRecordTbl` (
  `serial_no` char(50) COLLATE utf8_bin NOT NULL,
  `account_id` bigint(20) unsigned NOT NULL,
  `rmb` int(11) NOT NULL,
  `bind_rmb` int(11) NOT NULL,
  `recharge_status` int(11) NOT NULL,
  `date_time` datetime NOT NULL,
  PRIMARY KEY (`serial_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Table structure for table `ZoneServerTbl` */

DROP TABLE IF EXISTS `ZoneServerTbl`;

CREATE TABLE `ZoneServerTbl` (
  `server_id` int(10) unsigned NOT NULL,
  `client_listen_ip` tinytext COLLATE utf8_bin NOT NULL,
  `client_listen_port` int(10) unsigned NOT NULL,
  `server_name` tinytext COLLATE utf8_bin NOT NULL,
  `server_first_start_time` datetime NOT NULL,
  `server_open_time` datetime NOT NULL,
  `server_last_start_time` datetime NOT NULL,
  PRIMARY KEY (`server_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
