/*
SQLyog Enterprise Trial - MySQL GUI v7.11 
MySQL - 5.6.12-log : Database - eauctiontender
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`eauctiontender` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `eauctiontender`;

/*Table structure for table `tbl_tendercolumn` */

DROP TABLE IF EXISTS `tbl_tendercolumn`;

CREATE TABLE `tbl_tendercolumn` (
  `columnId` int(11) NOT NULL AUTO_INCREMENT,
  `columnHeader` longtext NOT NULL,
  `columnNo` int(11) NOT NULL,
  `dataType` int(11) NOT NULL,
  `filledBy` int(11) NOT NULL,
  `isCurrConvReq` int(11) NOT NULL,
  `isShown` int(11) NOT NULL,
  `sortOrder` int(11) NOT NULL,
  `columntypeid` int(11) DEFAULT NULL,
  `formid` int(11) DEFAULT NULL,
  `tableid` int(11) DEFAULT NULL,
  PRIMARY KEY (`columnId`),
  KEY `FKflivw3ths63g1ntd2vd6hnqi9` (`columntypeid`),
  KEY `FKkto1wkralr8rhfhijv9kts44u` (`formid`),
  KEY `FKal1pay10o58tt0rq4rvv5sr45` (`tableid`),
  CONSTRAINT `FKal1pay10o58tt0rq4rvv5sr45` FOREIGN KEY (`tableid`) REFERENCES `tbl_tendertable` (`tableId`),
  CONSTRAINT `FKflivw3ths63g1ntd2vd6hnqi9` FOREIGN KEY (`columntypeid`) REFERENCES `tbl_columntype` (`columnTypeId`),
  CONSTRAINT `FKkto1wkralr8rhfhijv9kts44u` FOREIGN KEY (`formid`) REFERENCES `tbl_tenderform` (`formId`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;

/*Data for the table `tbl_tendercolumn` */

insert  into `tbl_tendercolumn`(`columnId`,`columnHeader`,`columnNo`,`dataType`,`filledBy`,`isCurrConvReq`,`isShown`,`sortOrder`,`columntypeid`,`formid`,`tableid`) values (22,'No',0,6,1,0,1,1,NULL,9,12),(23,'Item',0,1,1,0,1,1,NULL,9,12),(24,'Qty',0,4,1,0,1,1,NULL,9,12),(25,'Date',0,7,1,0,1,1,NULL,9,12),(26,'No',0,6,1,0,1,1,NULL,9,13),(27,'Item',0,1,1,0,1,1,NULL,9,13),(28,'Qty',0,4,1,0,1,1,NULL,9,13),(29,'No',0,6,1,0,1,1,NULL,9,14),(30,'Item',0,1,1,0,1,1,NULL,9,14),(31,'Qty',0,4,1,0,1,1,NULL,9,14);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
