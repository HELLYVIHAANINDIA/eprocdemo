/*
SQLyog Community v9.63 
MySQL - 5.1.54-community : Database - eauctiontender
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

USE `eauctiontender`;

CREATE TABLE `tbl_company` (
  `companyid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Company Id PK',
  `companyName` longtext NOT NULL COMMENT 'Company Name',
  `createdBy` int(11) NOT NULL,
  `createdOn` datetime NOT NULL DEFAULT '2016-11-08 17:46:36',
  PRIMARY KEY (`companyid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `tbl_company` */

insert  into `tbl_company`(`companyid`,`companyName`,`createdBy`,`createdOn`) values (1,'Cahoot',1,'2016-11-08 17:46:36');


CREATE TABLE `tbl_finalsubmission` (
  `finalSubmissionId` int(11) NOT NULL,
  `consortiumId` int(11) NOT NULL,
  `partnerType` int(11) NOT NULL,
  `isActive` int(4) NOT NULL,
  `createdBy` int(11) NOT NULL,
  `createdOn` datetime NOT NULL,
  `ipAddress` longtext NOT NULL,
  `companyid` int(11) NOT NULL,
  `tenderid` int(11) NOT NULL,
  `bidderid` int(11) NOT NULL,
  PRIMARY KEY (`finalSubmissionId`),
  KEY `FK_tbl_finalsubmission_company` (`companyid`),
  KEY `FK_tbl_finalsubmission_tender` (`tenderid`),
  CONSTRAINT `FK_tbl_finalsubmission_company` FOREIGN KEY (`companyid`) REFERENCES `tbl_company` (`companyid`),
  CONSTRAINT `FK_tbl_finalsubmission_tender` FOREIGN KEY (`tenderid`) REFERENCES `tbl_tender` (`tenderId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tbl_finalsubmission` */

insert  into `tbl_finalsubmission`(`finalSubmissionId`,`consortiumId`,`partnerType`,`isActive`,`createdBy`,`createdOn`,`ipAddress`,`companyid`,`tenderid`,`bidderid`) values (1,1,1,1,1,'2016-11-08 17:46:36','190.168.0.1',1,1,1);

CREATE TABLE `tbl_tenderbidconfirmation` (
  `bidConfirmationId` int(11) NOT NULL,
  `createdBy` int(11) NOT NULL,
  `createdOn` datetime NOT NULL,
  `encodedName` longtext,
  `ipAddress` longtext NOT NULL,
  `companyid` int(11) NOT NULL,
  `tenderid` int(11) NOT NULL,
  `bidderid` int(11) NOT NULL,
  PRIMARY KEY (`bidConfirmationId`),
  KEY `FK_tbl_tenderbidconfirmation_tender` (`tenderid`),
  KEY `FK_tbl_tenderbidconfirmation_company` (`companyid`),
  CONSTRAINT `FK_tbl_tenderbidconfirmation_company` FOREIGN KEY (`companyid`) REFERENCES `tbl_company` (`companyid`),
  CONSTRAINT `FK_tbl_tenderbidconfirmation_tender` FOREIGN KEY (`tenderid`) REFERENCES `tbl_tender` (`tenderId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tbl_tenderbidconfirmation` */

insert  into `tbl_tenderbidconfirmation`(`bidConfirmationId`,`createdBy`,`createdOn`,`encodedName`,`ipAddress`,`companyid`,`tenderid`,`bidderid`) values (1,2,'2016-11-08 17:46:36',NULL,'192.168.0.1',1,1,1);



CREATE TABLE `tbl_tenderopen` (
  `tenderOpenId` int(11) NOT NULL AUTO_INCREMENT,
  `bidSignData` longtext,
  `createdBy` int(11) NOT NULL,
  `createdOn` datetime NOT NULL,
  `decryptionLevel` int(11) NOT NULL,
  `ipAddress` longtext NOT NULL,
  `companyid` int(11) NOT NULL,
  `tenderid` int(11) NOT NULL,
  `envelopeid` int(11) NOT NULL,
  `formid` int(11) NOT NULL,
  PRIMARY KEY (`tenderOpenId`),
  KEY `FK_tbl_tenderopen_tender` (`tenderid`),
  KEY `FK_tbl_tenderopen_company` (`companyid`),
  KEY `FK_tbl_tenderopen_envelope` (`envelopeid`),
  KEY `FK_tbl_tenderopen_form` (`formid`),
  CONSTRAINT `FK_tbl_tenderopen_company` FOREIGN KEY (`companyid`) REFERENCES `tbl_company` (`companyid`),
  CONSTRAINT `FK_tbl_tenderopen_envelope` FOREIGN KEY (`envelopeid`) REFERENCES `tbl_tenderenvelope` (`envelopeId`),
  CONSTRAINT `FK_tbl_tenderopen_form` FOREIGN KEY (`formid`) REFERENCES `tbl_tenderform` (`formId`),
  CONSTRAINT `FK_tbl_tenderopen_tender` FOREIGN KEY (`tenderid`) REFERENCES `tbl_tender` (`tenderId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tbl_tenderopen` */

insert  into `tbl_tenderopen`(`tenderOpenId`,`bidSignData`,`createdBy`,`createdOn`,`decryptionLevel`,`ipAddress`,`companyid`,`tenderid`,`envelopeid`,`formid`) values (1,NULL,1,'2016-11-08 17:46:36',1,'192.16.0.1',1,1,1,1);


CREATE TABLE `tbl_bidderapprovaldetail` (
  `bidderApprovalId` int(11) NOT NULL AUTO_INCREMENT,
  `createdBy` int(11) NOT NULL,
  `createdOn` datetime NOT NULL,
  `isApproved` int(11) NOT NULL,
  `remarks` longtext,
  `companyid` int(11) NOT NULL,
  `finalSubmissionId` int(11) NOT NULL,
  `tenderid` int(11) NOT NULL,
  `envelopeid` int(11) NOT NULL,
  `bidderid` int(11) NOT NULL,
  PRIMARY KEY (`bidderApprovalId`),
  KEY `FK_tbl_bidderapprovaldetail_tender` (`tenderid`),
  KEY `FK_tbl_bidderapprovaldetail_finalSubmission` (`finalSubmissionId`),
  KEY `FK_tbl_bidderapprovaldetail` (`envelopeid`),
  CONSTRAINT `FK_tbl_bidderapprovaldetail` FOREIGN KEY (`envelopeid`) REFERENCES `tbl_tenderenvelope` (`envelopeId`),
  CONSTRAINT `FK_tbl_bidderapprovaldetail_finalSubmission` FOREIGN KEY (`finalSubmissionId`) REFERENCES `tbl_finalsubmission` (`finalSubmissionId`),
  CONSTRAINT `FK_tbl_bidderapprovaldetail_tender` FOREIGN KEY (`tenderid`) REFERENCES `tbl_tender` (`tenderId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tbl_bidderapprovaldetail` */

insert  into `tbl_bidderapprovaldetail`(`bidderApprovalId`,`createdBy`,`createdOn`,`isApproved`,`remarks`,`companyid`,`finalSubmissionId`,`tenderid`,`envelopeid`,`bidderid`) values (1,1,'2016-11-08 17:46:36',1,NULL,1,1,7,1,1);


CREATE TABLE `tbl_tenderbid` (
  `bidId` int(11) NOT NULL AUTO_INCREMENT,
  `bidPrice` decimal(10,0) DEFAULT NULL,
  `createdBy` int(11) NOT NULL,
  `createdOn` datetime NOT NULL,
  `cstatus` int(11) NOT NULL,
  `ipAddress` longtext NOT NULL,
  `companyid` int(11) NOT NULL,
  `tenderid` int(11) NOT NULL,
  `envelopeid` int(11) NOT NULL,
  `formid` int(11) NOT NULL,
  `bidderid` int(11) NOT NULL,
  PRIMARY KEY (`bidId`),
  KEY `FK_tbl_tenderbid_form` (`formid`),
  KEY `FK_tbl_tenderbid_tender` (`tenderid`),
  KEY `FK_tbl_tenderbid_envelope` (`envelopeid`),
  KEY `FK_tbl_tenderbid_company` (`companyid`),
  CONSTRAINT `FK_tbl_tenderbid_company` FOREIGN KEY (`companyid`) REFERENCES `tbl_company` (`companyid`),
  CONSTRAINT `FK_tbl_tenderbid_envelope` FOREIGN KEY (`envelopeid`) REFERENCES `tbl_tenderenvelope` (`envelopeId`),
  CONSTRAINT `FK_tbl_tenderbid_form` FOREIGN KEY (`formid`) REFERENCES `tbl_tenderform` (`formId`),
  CONSTRAINT `FK_tbl_tenderbid_tender` FOREIGN KEY (`tenderid`) REFERENCES `tbl_tender` (`tenderId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `tbl_tenderbid` */

insert  into `tbl_tenderbid`(`bidId`,`bidPrice`,`createdBy`,`createdOn`,`cstatus`,`ipAddress`,`companyid`,`tenderid`,`envelopeid`,`formid`,`bidderid`) values (1,'10',1,'2016-11-24 16:27:00',1,'192.168.2.1',1,7,12,1,2),(2,'23',1,'2016-11-24 16:27:00',1,'192.168.0.1',1,7,13,1,2);