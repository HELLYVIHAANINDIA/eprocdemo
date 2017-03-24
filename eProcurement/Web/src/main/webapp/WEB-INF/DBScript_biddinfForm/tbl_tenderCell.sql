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

/*Table structure for table `tbl_tendercell` */

DROP TABLE IF EXISTS `tbl_tendercell`;

CREATE TABLE `tbl_tendercell` (
  `cellId` int(11) NOT NULL AUTO_INCREMENT,
  `cellNo` int(11) NOT NULL,
  `cellValue` varchar(1000) NOT NULL,
  `dataType` int(11) NOT NULL,
  `objectId` int(11) NOT NULL,
  `rowId` int(11) NOT NULL,
  `columnid` int(11) DEFAULT NULL,
  `formid` int(11) DEFAULT NULL,
  `tableid` int(11) DEFAULT NULL,
  PRIMARY KEY (`cellId`),
  KEY `FK3m6wtd1n69u9oyhp8utvuvnei` (`columnid`),
  KEY `FK25h1q2mm97yjf34ihbjpthhj0` (`formid`),
  KEY `FKdqnn5gshgcml8racn1j5xavyo` (`tableid`),
  CONSTRAINT `FK25h1q2mm97yjf34ihbjpthhj0` FOREIGN KEY (`formid`) REFERENCES `tbl_tenderform` (`formId`),
  CONSTRAINT `FK3m6wtd1n69u9oyhp8utvuvnei` FOREIGN KEY (`columnid`) REFERENCES `tbl_tendercolumn` (`columnId`),
  CONSTRAINT `FKdqnn5gshgcml8racn1j5xavyo` FOREIGN KEY (`tableid`) REFERENCES `tbl_tendertable` (`tableId`)
) ENGINE=InnoDB AUTO_INCREMENT=139 DEFAULT CHARSET=latin1;

/*Data for the table `tbl_tendercell` */

insert  into `tbl_tendercell`(`cellId`,`cellNo`,`cellValue`,`dataType`,`objectId`,`rowId`,`columnid`,`formid`,`tableid`) values (116,1,'Item6',0,1,0,30,9,14),(117,0,'1',0,1,0,29,9,14),(118,2,'6',0,1,1,31,9,14),(119,1,'Item6',0,1,1,30,9,14),(120,0,'2',0,1,1,29,9,14),(121,2,'5',0,1,0,31,9,14),(122,1,'Item3',0,1,0,27,9,13),(123,0,'1',0,1,0,26,9,13),(124,2,'3',0,1,1,28,9,13),(125,1,'Item4',0,1,1,27,9,13),(126,0,'2',0,1,1,26,9,13),(127,2,'2',0,1,0,28,9,13),(128,2,'9',0,1,2,28,9,13),(129,1,'Item5',0,1,2,27,9,13),(130,0,'3',0,1,2,26,9,13),(131,1,'item1',0,1,0,23,9,12),(132,0,'1',0,1,0,22,9,12),(133,1,'item2',0,1,1,23,9,12),(134,0,'2',0,1,1,22,9,12),(135,3,'2017-01-01',0,1,0,25,9,12),(136,2,'200',0,1,0,24,9,12),(137,3,'2017-04-04',0,1,1,25,9,12),(138,2,'300',0,1,1,24,9,12);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
