alter table tbl_committeeuser modify createdOn datetime NULL DEFAULT CURRENT_TIMESTAMP;
alter table tbl_committee modify createdOn datetime NULL DEFAULT CURRENT_TIMESTAMP;


/*
SQLyog Community Edition- MySQL GUI v7.14 
MySQL - 5.6.24-log : Database - eauctiontender
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`eauctiontender` /*!40100 DEFAULT CHARACTER SET latin1 */;

/*Table structure for table `tbl_eventtype` */

CREATE TABLE `tbl_eventtype` (
  `eventTypeId` int(11) NOT NULL AUTO_INCREMENT,
  `eventTypeName` varchar(100) NOT NULL,
  `isActive` int(5) NOT NULL DEFAULT '1',
  PRIMARY KEY (`eventTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `tbl_eventtype` */

insert  into `tbl_eventtype`(`eventTypeId`,`eventTypeName`,`isActive`) values (1,'RFT(Request For Tender)',1),(2,'PQ(Pre-Qualification)',1),(3,'REOI(Request for Expression Of Information)',1),(4,'RFI(Request For Information)',1),(5,'RFP(Request For Proposal)',1),(6,'RFQ(Request For Quotation)',1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;