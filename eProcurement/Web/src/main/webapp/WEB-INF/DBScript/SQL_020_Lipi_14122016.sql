Alter table tbl_roles ADD column isShown int default 1;

insert  into `tbl_link`(`linkName`,`module`,`link`,`description`) values 
('Bidder Listing','Bidder','etender/bidder/bidderTenderListing','Bidder Listing'),
('View Tender','Bidder','etender/bidder/viewtender','View Tender'),
('Dashboard','Bidder','etender/bidder/biddingTenderDashboard','Dashboard'),
('Dashboard Content','Bidder','etender/bidder/biddingtenderdashboardcontent','Dashboard Content'),
('Save Bidder Declaration','Bidder','etender/bidder/bidderIagree','Save Bidder Declaration'),
('Save Final Submission','Bidder','etender/bidder/finalsubmission','Save Final Submission'),
('Bid Withdraw','Bidder','etender/bidder/showbidwithdraw','Bid Withdraw'),
('Save Bid Withdraw','Bidder','etender/bidder/withdrawbid','Save Bid Withdraw');

insert  into `tbl_roles`(`roleId`,`roleName`,`isShown`) values (5,'Bidder',0);
	
insert into tbl_rolelinkmapping (linkId,roleId) values ((select linkId from tbl_link where link='etender/bidder/bidderTenderListing'),5 );
insert into tbl_rolelinkmapping (linkId,roleId) values ((select linkId from tbl_link where link='etender/bidder/viewtender'),5 );
insert into tbl_rolelinkmapping (linkId,roleId) values ((select linkId from tbl_link where link='etender/bidder/biddingTenderDashboard'),5 );
insert into tbl_rolelinkmapping (linkId,roleId) values ((select linkId from tbl_link where link='etender/bidder/biddingtenderdashboardcontent'),5 );
insert into tbl_rolelinkmapping (linkId,roleId) values ((select linkId from tbl_link where link='etender/bidder/bidderIagree'),5 );
insert into tbl_rolelinkmapping (linkId,roleId) values ((select linkId from tbl_link where link='etender/bidder/finalsubmission'),5 );
insert into tbl_rolelinkmapping (linkId,roleId) values ((select linkId from tbl_link where link='etender/bidder/showbidwithdraw'),5 );
insert into tbl_rolelinkmapping (linkId,roleId) values ((select linkId from tbl_link where link='etender/bidder/withdrawbid'),5 );

/*
SQLyog Community Edition- MySQL GUI v7.14 
MySQL - 5.6.24-log : Database - eauctiontender
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

/*Table structure for table `tbl_bidwithdrawal` */

CREATE TABLE `tbl_bidwithdrawal` (
  `bidWithdrawalId` int(11) NOT NULL AUTO_INCREMENT,
  `createdBy` int(11) NOT NULL,
  `createdOn` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `finalSubmissionDate` datetime NOT NULL,
  `finalSubmissionIPAddress` varchar(200) NOT NULL,
  `ipAddress` varchar(200) NOT NULL,
  `remark` varchar(200) NOT NULL,
  `companyId` int(11) NOT NULL,
  `tenderId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  PRIMARY KEY (`bidWithdrawalId`),
  KEY `FK_tbl_bidwithdrawal_tender` (`tenderId`),
  KEY `FK_tbl_bidwithdrawal_company` (`companyId`),
  CONSTRAINT `FK_tbl_bidwithdrawal_company` FOREIGN KEY (`companyId`) REFERENCES `tbl_company` (`companyid`),
  CONSTRAINT `FK_tbl_bidwithdrawal_tender` FOREIGN KEY (`tenderId`) REFERENCES `tbl_tender` (`tenderId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tbl_bidwithdrawal` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;	

alter table tbl_finalsubmission 
CHANGE COLUMN `consortiumId` `consortiumId` INT(11) NULL ;

alter table tbl_finalsubmission 
CHANGE COLUMN `partnerType` `partnerType` INT(11) NULL ;

ALTER TABLE `tbl_finalsubmission` CHANGE `createdOn` `createdOn` DATEtime DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE `tbl_bidwithdrawal` CHANGE `createdOn` `createdOn` DATEtime DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE `tbl_bidwithdrawal` CHANGE `userId` `bidderId` int not null;