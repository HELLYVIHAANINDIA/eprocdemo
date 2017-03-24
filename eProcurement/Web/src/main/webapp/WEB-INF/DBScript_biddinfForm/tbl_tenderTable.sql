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

/*Table structure for table `tbl_tendertable` */

DROP TABLE IF EXISTS `tbl_tendertable`;

CREATE TABLE `tbl_tendertable` (
  `tableId` int(11) NOT NULL AUTO_INCREMENT,
  `createdBy` int(11) NOT NULL,
  `createdOn` datetime NOT NULL,
  `formId` varchar(255) NOT NULL,
  `hasGTRow` int(11) NOT NULL,
  `isMandatory` int(11) NOT NULL,
  `isMultipleFilling` int(11) NOT NULL,
  `isPartialFillingAllowed` int(11) NOT NULL,
  `noOfCols` int(11) NOT NULL,
  `noOfRows` int(11) NOT NULL,
  `sortOrder` int(11) NOT NULL,
  `tableFooter` varchar(255) NOT NULL,
  `tableHeader` varchar(255) NOT NULL,
  `tableName` longtext NOT NULL,
  `updatedBy` int(11) NOT NULL,
  `updatedOn` datetime NOT NULL,
  PRIMARY KEY (`tableId`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

/*Data for the table `tbl_tendertable` */

insert  into `tbl_tendertable`(`tableId`,`createdBy`,`createdOn`,`formId`,`hasGTRow`,`isMandatory`,`isMultipleFilling`,`isPartialFillingAllowed`,`noOfCols`,`noOfRows`,`sortOrder`,`tableFooter`,`tableHeader`,`tableName`,`updatedBy`,`updatedOn`) values (12,0,'2016-12-02 10:54:58','9',0,0,0,0,4,2,1,'Thank you for your interest','Please provide the below information','Table Bidding form',1,'2016-12-02 10:54:58'),(13,0,'2016-12-02 10:54:58','9',0,0,0,0,3,3,1,'* table footer','Please fill below Information','Bidding table Info',1,'2016-12-02 10:54:58'),(14,0,'2016-12-02 10:54:58','9',0,0,0,0,3,2,1,'Bidding Form Table  Footer','Bidding Form Table  Header','Bidding Form Table',1,'2016-12-02 10:54:58');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
