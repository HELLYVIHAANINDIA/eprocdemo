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

/*Table structure for table `tbl_tenderform` */

DROP TABLE IF EXISTS `tbl_tenderform`;

CREATE TABLE `tbl_tenderform` (
  `formId` int(11) NOT NULL AUTO_INCREMENT,
  `cancelledBy` int(11) DEFAULT NULL,
  `cancelledOn` datetime DEFAULT NULL,
  `createdBy` int(11) NOT NULL,
  `createdOn` datetime NOT NULL,
  `cstatus` int(11) NOT NULL,
  `formFooter` varchar(255) NOT NULL,
  `formHeader` varchar(255) NOT NULL,
  `formName` longtext NOT NULL,
  `incrementItems` int(11) NOT NULL,
  `isDocumentReq` int(11) NOT NULL,
  `isEncryptedDocument` int(11) NOT NULL,
  `isEncryptionReq` int(11) NOT NULL,
  `isEvaluationReq` int(11) NOT NULL,
  `isItemWiseDocAllowed` int(11) NOT NULL,
  `isMandatory` int(11) NOT NULL,
  `isMultipleFilling` int(11) NOT NULL,
  `isPriceBid` int(11) NOT NULL,
  `isSecondary` int(11) NOT NULL,
  `loadNoOfItems` int(11) NOT NULL,
  `masterFormId` int(11) NOT NULL,
  `minTablesReqForBidding` int(11) NOT NULL,
  `noOfTables` int(11) NOT NULL,
  `parentFormId` int(11) NOT NULL,
  `publishedBy` int(11) DEFAULT NULL,
  `publishedOn` datetime DEFAULT NULL,
  `sortOrder` int(11) NOT NULL,
  `tenderid` int(11) DEFAULT NULL,
  `envelopeid` int(11) DEFAULT NULL,
  PRIMARY KEY (`formId`),
  KEY `FKh2rmytopuwdx45or99lxti1j8` (`tenderid`),
  KEY `FKkcc0dq67qh25t9f23f4epeiyb` (`envelopeid`),
  CONSTRAINT `FKh2rmytopuwdx45or99lxti1j8` FOREIGN KEY (`tenderid`) REFERENCES `tbl_tender` (`tenderId`),
  CONSTRAINT `FKkcc0dq67qh25t9f23f4epeiyb` FOREIGN KEY (`envelopeid`) REFERENCES `tbl_tenderenvelope` (`envelopeId`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

/*Data for the table `tbl_tenderform` */

insert  into `tbl_tenderform`(`formId`,`cancelledBy`,`cancelledOn`,`createdBy`,`createdOn`,`cstatus`,`formFooter`,`formHeader`,`formName`,`incrementItems`,`isDocumentReq`,`isEncryptedDocument`,`isEncryptionReq`,`isEvaluationReq`,`isItemWiseDocAllowed`,`isMandatory`,`isMultipleFilling`,`isPriceBid`,`isSecondary`,`loadNoOfItems`,`masterFormId`,`minTablesReqForBidding`,`noOfTables`,`parentFormId`,`publishedBy`,`publishedOn`,`sortOrder`,`tenderid`,`envelopeid`) values (9,NULL,NULL,1,'2016-12-02 10:54:58',-1,'This is Form Footer','This is Form Header','Test Bidding Form',-1,1,1,1,1,1,1,1,2,-1,1,1,1,3,1,1,NULL,1,1,1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
