/*
SQLyog Community Edition- MySQL GUI v7.14 
MySQL - 5.6.24-log : Database - eauctiontender
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`eauctiontender` /*!40100 DEFAULT CHARACTER SET latin1 */;

/*Table structure for table `tbl_bidderitems` */

CREATE TABLE `tbl_bidderitems` (
  `bidderItemId` int(11) NOT NULL AUTO_INCREMENT,
  `childId` int(11) NOT NULL,
  `isActive` int(11) NOT NULL DEFAULT '0',
  `createdBy` int(11) DEFAULT NULL,
  `isApproved` int(11) NOT NULL DEFAULT '0',
  `isCPRemarks` int(11) NOT NULL DEFAULT '0',
  `remarks` varchar(250) DEFAULT NULL,
  `rowId` int(11) NOT NULL,
  `companyId` int(11) NOT NULL,
  `tenderId` int(11) NOT NULL,
  `envelopeId` int(11) NOT NULL,
  `formId` int(11) NOT NULL,
  `tableId` int(11) NOT NULL,
  `bidderId` int(11) NOT NULL,
  `userRoleId` int(11) DEFAULT NULL,
  PRIMARY KEY (`bidderItemId`),
  KEY `FK_tbl_bidderitems_tender` (`tenderId`),
  KEY `FK_tbl_bidderitems_evnelope` (`envelopeId`),
  KEY `FK_tbl_bidderitems_form` (`formId`),
  KEY `FK_tbl_bidderitems_table` (`tableId`),
  KEY `FK_tbl_bidderitems_company` (`companyId`),
  KEY `FK_tbl_bidderitems_bidder` (`bidderId`),
  CONSTRAINT `FK_tbl_bidderitems_bidder` FOREIGN KEY (`bidderId`) REFERENCES `tbl_bidder` (`bidderId`),
  CONSTRAINT `FK_tbl_bidderitems_company` FOREIGN KEY (`companyId`) REFERENCES `tbl_company` (`companyid`),
  CONSTRAINT `FK_tbl_bidderitems_evnelope` FOREIGN KEY (`envelopeId`) REFERENCES `tbl_tenderenvelope` (`envelopeId`),
  CONSTRAINT `FK_tbl_bidderitems_form` FOREIGN KEY (`formId`) REFERENCES `tbl_tenderform` (`formId`),
  CONSTRAINT `FK_tbl_bidderitems_table` FOREIGN KEY (`tableId`) REFERENCES `tbl_tendertable` (`tableId`),
  CONSTRAINT `FK_tbl_bidderitems_tender` FOREIGN KEY (`tenderId`) REFERENCES `tbl_tender` (`tenderId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tbl_bidderitems` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;






insert into tbl_link (linkName,module,link,description) 
values('Save Bidder Wise Evaluation','tender','/etender/buyer/saveBidderWiseEvaluation','Save Bidder Wise Evaluation');
insert into tbl_rolelinkmapping (linkId,roleId) values((select linkId from tbl_link where link='/etender/buyer/saveBidderWiseEvaluation'),1);




insert into tbl_link (linkName,module,link,description) 
values('Bidder Wise Evaluation','tender','etender/buyer/bidderWiseevaluation','Bidder Wise Evaluation');
insert into tbl_rolelinkmapping (linkId,roleId) values((select linkId from tbl_link where link='etender/buyer/bidderWiseevaluation'),1);