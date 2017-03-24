/*
SQLyog Community Edition- MySQL GUI v7.14 
MySQL - 5.6.24-log : Database - eauctiontender
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

/*Table structure for table `tbl_sharereport` */

CREATE TABLE `tbl_sharereport` (
  `createdBy` int(11) NOT NULL,
  `createdOn` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isActive` int(11) NOT NULL,
  `shareBidderStatus` int(11) NOT NULL,
  `shareClarificationReport` int(11) NOT NULL,
  `shareEvaluationReport` int(11) NOT NULL,
  `shareReport` int(11) NOT NULL,
  `shareReportId` int(11) NOT NULL AUTO_INCREMENT,
  `showAbstractReport` int(11) NOT NULL,
  `showL1Report` int(11) NOT NULL,
  `showResultBeforeLogin` int(11) NOT NULL,
  `tenderId` int(11) NOT NULL,
  PRIMARY KEY (`shareReportId`),
  KEY `FK_tbl_sharereport_tender` (`tenderId`),
  CONSTRAINT `FK_tbl_sharereport_tender` FOREIGN KEY (`tenderId`) REFERENCES `tbl_tender` (`tenderId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tbl_sharereport` */

/*Table structure for table `tbl_sharereportdetail` */

CREATE TABLE `tbl_sharereportdetail` (
  `shareComparativeReport` int(11) NOT NULL,
  `shareDocument` int(11) NOT NULL,
  `shareIndividualReport` int(11) NOT NULL,
  `shareReportDetailId` int(11) NOT NULL AUTO_INCREMENT,
  `shareReportId` int(11) NOT NULL,
  `formId` int(11) NOT NULL,
  UNIQUE KEY `shareReportDetailId` (`shareReportDetailId`),
  KEY `FK_tbl_sharereportdetail_form` (`formId`),
  KEY `FK_tbl_sharereportdetail_shareReport` (`shareReportId`),
  CONSTRAINT `FK_tbl_sharereportdetail_form` FOREIGN KEY (`formId`) REFERENCES `tbl_tenderform` (`formId`),
  CONSTRAINT `FK_tbl_sharereportdetail_shareReport` FOREIGN KEY (`shareReportId`) REFERENCES `tbl_sharereport` (`shareReportId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tbl_sharereportdetail` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;

insert  into `tbl_link`(`linkName`,`module`,`link`,`description`) values 
('Individual Report Buyer','tender','etender/buyer/tenderindividualreport','Individual Report Buyer'),
('Individual Report Bidder','Bidder','etender/bidder/tenderindividualreport','Individual Report Bidder');


insert into tbl_rolelinkmapping (linkId,roleId) values ((select linkId from tbl_link where link='etender/bidder/tenderindividualreport'),5 );
insert into tbl_rolelinkmapping (linkId,roleId) values ((select linkId from tbl_link where link='etender/buyer/tenderindividualreport'),5 );