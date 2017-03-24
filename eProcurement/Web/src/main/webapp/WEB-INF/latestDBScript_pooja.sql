insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) 
values('EditBidding Structure','tender','/etender/Bid/editForm','EditBidding Structure');
insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkid from tbl_link where linkName = 'EditBidding Form step 2'),'1');


insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkid from tbl_link where linkName = 'EditBidding Structure'),'1');
update tbl_tendercolumn set columnHeader= , columnNo= ,dataType= ,filledBy= ,isShown=,columntypeid= where columnId=
select * from tbl_tendercolumn

insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) 
values('view Bidding Form values for edit','tender','/eBid/Bid/viewFormForEdit','view Bidding Form values for edit');
insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkid from tbl_link where linkName = 'view Bidding Form values for edit');

insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) 
values('Update Bidding Form Values For Edit','tender','/eBid/Bid/updateBiddingFormValueForEdit','Update Bidding Form Values For Edit');
insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkid from tbl_link where linkName = 'Update Bidding Form Values For Edit'),'1');






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

/*Table structure for table `tbl_columntype` */

DROP TABLE IF EXISTS `tbl_columntype`;

CREATE TABLE `tbl_columntype` (
  `columnTypeId` int(11) NOT NULL AUTO_INCREMENT,
  `columnName` varchar(255) NOT NULL,
  `lang1` varchar(255) DEFAULT NULL,
  `lang2` varchar(255) DEFAULT NULL,
  `lang3` varchar(255) DEFAULT NULL,
  `lang4` varchar(255) DEFAULT NULL,
  `lang5` varchar(255) DEFAULT NULL,
  `lang6` varchar(255) DEFAULT NULL,
  `lang7` varchar(255) DEFAULT NULL,
  `lang8` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`columnTypeId`),
  UNIQUE KEY `UK_gdbpol6gsk8cspfgvbn0tsoui` (`columnName`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `tbl_columntype` */

insert  into `tbl_columntype`(`columnTypeId`,`columnName`,`lang1`,`lang2`,`lang3`,`lang4`,`lang5`,`lang6`,`lang7`,`lang8`) values (1,'Item Description',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,'Quantity',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(3,'Unit Rate',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(4,'Total Rate',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(5,'Category',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6,'Others',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;

