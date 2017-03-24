/*
SQLyog Community Edition- MySQL GUI v7.14 
MySQL - 5.6.24-log : Database - eauctiontender
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`eauctiontender` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `eauctiontender`;

/*Table structure for table `tbl_bidderapprovalhistory` */

DROP TABLE IF EXISTS `tbl_bidderapprovalhistory`;

CREATE TABLE `tbl_bidderapprovalhistory` (
  `bidderApprovalHistoryId` int(11) NOT NULL AUTO_INCREMENT,
  `bidderId` int(11) NOT NULL,
  `companyId` int(11) NOT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `createdOn` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `envelopeId` int(11) NOT NULL,
  `finalSubmissionId` int(11) NOT NULL,
  `isApproved` int(11) DEFAULT NULL,
  `remarks` longtext,
  `tenderId` int(11) NOT NULL,
  PRIMARY KEY (`bidderApprovalHistoryId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tbl_bidderapprovalhistory` */

/*Table structure for table `tbl_rebatedetail` */

DROP TABLE IF EXISTS `tbl_rebatedetail`;

CREATE TABLE `tbl_rebatedetail` (
  `cellValue` longtext NOT NULL,
  `createdBy` int(11) NOT NULL,
  `createdOn` datetime NOT NULL,
  `rebateDetailId` int(11) NOT NULL,
  `companyid` int(11) NOT NULL,
  `tenderid` int(11) NOT NULL,
  `bidtableid` int(11) NOT NULL,
  `cellid` int(11) NOT NULL,
  PRIMARY KEY (`rebateDetailId`),
  KEY `FK_tbl_rebatedetail_company` (`companyid`),
  KEY `FK_tbl_rebatedetail_tender` (`tenderid`),
  KEY `FK_tbl_rebatedetail_bidmatrix` (`bidtableid`),
  KEY `FK_tbl_rebatedetail_cell` (`cellid`),
  CONSTRAINT `FK_tbl_rebatedetail_bidmatrix` FOREIGN KEY (`bidtableid`) REFERENCES `tbl_tenderbidmatrix` (`bidTableId`),
  CONSTRAINT `FK_tbl_rebatedetail_cell` FOREIGN KEY (`cellid`) REFERENCES `tbl_tendercell` (`cellId`),
  CONSTRAINT `FK_tbl_rebatedetail_company` FOREIGN KEY (`companyid`) REFERENCES `tbl_company` (`companyid`),
  CONSTRAINT `FK_tbl_rebatedetail_tender` FOREIGN KEY (`tenderid`) REFERENCES `tbl_tender` (`tenderId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tbl_rebatedetail` */

/*Table structure for table `tbl_tenderbidmatrix` */

DROP TABLE IF EXISTS `tbl_tenderbidmatrix`;

CREATE TABLE `tbl_tenderbidmatrix` (
  `bidJson` longtext NOT NULL,
  `bidTableId` int(11) NOT NULL,
  `encryptedBid` longtext,
  `bidid` int(11) NOT NULL,
  `tableid` int(11) NOT NULL,
  PRIMARY KEY (`bidTableId`),
  KEY `FK_tbl_tenderbidmatrix_tenderbid` (`bidid`),
  KEY `FK_tbl_tenderbidmatrix_tendertable` (`tableid`),
  CONSTRAINT `FK_tbl_tenderbidmatrix_tenderbid` FOREIGN KEY (`bidid`) REFERENCES `tbl_tenderbid` (`bidId`),
  CONSTRAINT `FK_tbl_tenderbidmatrix_tendertable` FOREIGN KEY (`tableid`) REFERENCES `tbl_tendertable` (`tableId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tbl_tenderbidmatrix` */

/*Table structure for table `tbl_tenderbidopensign` */

DROP TABLE IF EXISTS `tbl_tenderbidopensign`;

CREATE TABLE `tbl_tenderbidopensign` (
  `bidOpenSignId` int(11) NOT NULL,
  `bidSignText` longtext,
  `createdBy` int(11) DEFAULT NULL,
  `createdOn` datetime DEFAULT NULL,
  `decryptedBid` longtext,
  `bidtableid` int(11) NOT NULL,
  PRIMARY KEY (`bidOpenSignId`),
  KEY `FK_tbl_tenderbidopensign` (`bidtableid`),
  CONSTRAINT `FK_tbl_tenderbidopensign` FOREIGN KEY (`bidtableid`) REFERENCES `tbl_tenderbidmatrix` (`bidTableId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tbl_tenderbidopensign` */

DROP TABLE IF EXISTS `tbl_tenderbiddetail`;

CREATE TABLE `tbl_tenderbiddetail` (
  `bidDetailId` int(11) NOT NULL,
  `cellNo` int(11) NOT NULL,
  `cellValue` longtext NOT NULL,
  `bidtableid` int(11) NOT NULL,
  `cellid` int(11) NOT NULL,
  PRIMARY KEY (`bidDetailId`),
  KEY `FK_tbl_tenderbiddetail_tableId` (`bidtableid`),
  KEY `FK_tbl_tenderbiddetail_cellId` (`cellid`),
  CONSTRAINT `FK_tbl_tenderbiddetail_cellId` FOREIGN KEY (`cellid`) REFERENCES `tbl_tendercell` (`cellId`),
  CONSTRAINT `FK_tbl_tenderbiddetail_tableId` FOREIGN KEY (`bidtableid`) REFERENCES `tbl_tenderbidmatrix` (`bidTableId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;

insert into `tbl_company`(`companyName`,`createdBy`,`createdOn`)values('Cahoot Pvt','1','2016-11-08 17:46:36');