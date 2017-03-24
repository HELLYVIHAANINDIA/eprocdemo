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
CREATE DATABASE /*!32312 IF NOT EXISTS*/`eauctiontender` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `eauctiontender`;

/*Table structure for table `hibernate_sequence` */

DROP TABLE IF EXISTS `hibernate_sequence`;

CREATE TABLE `hibernate_sequence` (
  `next_val` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `hibernate_sequence` */

insert  into `hibernate_sequence`(`next_val`) values (95),(95);

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tbl_columntype` */

/*Table structure for table `tbl_committee` */

DROP TABLE IF EXISTS `tbl_committee`;

CREATE TABLE `tbl_committee` (
  `committeeId` int(11) NOT NULL AUTO_INCREMENT,
  `committeeName` varchar(20) NOT NULL,
  `committeeType` int(11) NOT NULL,
  `createdBy` int(11) NOT NULL,
  `createdOn` datetime NOT NULL DEFAULT '2016-11-08 17:46:36',
  `isActive` int(11) NOT NULL,
  `isApproved` int(11) NOT NULL,
  `isStandard` int(11) NOT NULL,
  `publishedBy` int(11) DEFAULT NULL,
  `publishedOn` datetime DEFAULT NULL,
  `remarks` longtext NOT NULL,
  `tenderId` int(11) DEFAULT NULL,
  PRIMARY KEY (`committeeId`),
  KEY `FK8dftvx6sg30oucx69y5h6ukyh` (`tenderId`),
  CONSTRAINT `FK8dftvx6sg30oucx69y5h6ukyh` FOREIGN KEY (`tenderId`) REFERENCES `tbl_tender` (`tenderId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=latin1;

/*Data for the table `tbl_committee` */

insert  into `tbl_committee`(`committeeId`,`committeeName`,`committeeType`,`createdBy`,`createdOn`,`isActive`,`isApproved`,`isStandard`,`publishedBy`,`publishedOn`,`remarks`,`tenderId`) values (36,'PrebidCommitte',3,1,'2016-11-08 17:46:36',1,0,0,0,NULL,'',1),(37,'Committee',1,1,'2016-11-08 17:46:36',1,0,0,0,NULL,'',1),(38,'Committee',2,1,'2016-11-08 17:46:36',1,0,0,0,NULL,'',1),(39,'PrebidCommitte',3,1,'2016-11-08 17:46:36',1,0,0,0,NULL,'',1),(40,'Committee',1,1,'2016-11-08 17:46:36',1,0,0,0,NULL,'',1),(41,'Committee',1,1,'2016-11-08 17:46:36',1,0,0,0,NULL,'',1),(42,'Committee',2,1,'2016-11-08 17:46:36',1,0,0,0,NULL,'',1),(43,'PrebidCommitte',3,1,'2016-11-08 17:46:36',1,0,0,0,NULL,'',1),(44,'PrebidCommitte',3,1,'2016-11-08 17:46:36',1,0,0,0,NULL,'',1),(45,'Committee',1,1,'2016-11-08 17:46:36',1,0,0,0,NULL,'',1),(46,'Committee',2,1,'2016-11-08 17:46:36',1,0,0,0,NULL,'',1);

/*Table structure for table `tbl_committeeenvelope` */

DROP TABLE IF EXISTS `tbl_committeeenvelope`;

CREATE TABLE `tbl_committeeenvelope` (
  `committeeEnvelopeId` int(11) NOT NULL AUTO_INCREMENT,
  `minMemberApproval` int(11) NOT NULL,
  `committeeid` int(11) DEFAULT NULL,
  `envelopeid` int(11) DEFAULT NULL,
  PRIMARY KEY (`committeeEnvelopeId`),
  KEY `FK8vnubglekdv2qhno11gybxebh` (`envelopeid`),
  KEY `FKa8geya8pb0eqriw68cwdd3yc` (`committeeid`),
  CONSTRAINT `FK8vnubglekdv2qhno11gybxebh` FOREIGN KEY (`envelopeid`) REFERENCES `tbl_tenderenvelope` (`envelopeId`),
  CONSTRAINT `FKa8geya8pb0eqriw68cwdd3yc` FOREIGN KEY (`committeeid`) REFERENCES `tbl_committee` (`committeeId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=latin1;

/*Data for the table `tbl_committeeenvelope` */

insert  into `tbl_committeeenvelope`(`committeeEnvelopeId`,`minMemberApproval`,`committeeid`,`envelopeid`) values (63,1,37,1),(64,1,37,2),(65,1,38,1),(66,1,38,2),(69,1,40,1),(70,1,40,2),(73,1,41,1),(74,1,41,2),(75,0,42,1),(76,0,42,2),(77,1,45,1),(78,1,45,2),(79,0,46,1),(80,0,46,2);

/*Table structure for table `tbl_committeeuser` */

DROP TABLE IF EXISTS `tbl_committeeuser`;

CREATE TABLE `tbl_committeeuser` (
  `committeeUserId` int(11) NOT NULL AUTO_INCREMENT,
  `approvedBy` int(11) DEFAULT NULL,
  `approvedOn` datetime DEFAULT NULL,
  `childId` int(11) NOT NULL,
  `createdBy` int(11) NOT NULL,
  `createdOn` datetime NOT NULL DEFAULT '2016-11-08 17:46:36',
  `encryptionLevel` int(11) NOT NULL,
  `isApproved` int(11) NOT NULL,
  `isDecryptor` int(11) NOT NULL,
  `remarks` longtext NOT NULL,
  `userRoleId` int(11) DEFAULT NULL,
  `committeeid` int(11) DEFAULT NULL,
  `officerid` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`committeeUserId`),
  KEY `FK8j2ge5l95msnu230icjerrd4q` (`officerid`),
  KEY `FKmf5stuv3qdg1ijeptd6m7v4ay` (`committeeid`),
  CONSTRAINT `FK8j2ge5l95msnu230icjerrd4q` FOREIGN KEY (`officerid`) REFERENCES `tbl_officer` (`id`),
  CONSTRAINT `FKmf5stuv3qdg1ijeptd6m7v4ay` FOREIGN KEY (`committeeid`) REFERENCES `tbl_committee` (`committeeId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tbl_committeeuser` */

/*Table structure for table `tbl_commonlisting` */

DROP TABLE IF EXISTS `tbl_commonlisting`;

CREATE TABLE `tbl_commonlisting` (
  `listingId` int(11) NOT NULL AUTO_INCREMENT,
  `actionItem` varchar(255) DEFAULT NULL,
  `columnName` varchar(255) DEFAULT NULL,
  `commonAction` varchar(255) DEFAULT NULL,
  `discription` varchar(255) DEFAULT NULL,
  `fromClause` varchar(255) DEFAULT NULL,
  `isHQL` bit(1) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`listingId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `tbl_commonlisting` */

insert  into `tbl_commonlisting`(`listingId`,`actionItem`,`columnName`,`commonAction`,`discription`,`fromClause`,`isHQL`,`status`) values (1,'edit,view','tenderNo:Tender No.:1,tenderDetail:Tender Detail:1,tenderId:tenderId:0','Edit',NULL,'from tbl_tender where 1=1','',1),(2,'edit','deptName:Department name:1,address:Address:1,deptId:deptId:0','Edit',NULL,'from tbl_department where 1=1','',1),(3,'edit','designationName:Designation name:1,deptId:Department:1,designationId:designationId:0','Edit',NULL,'from tbl_designation where 1=1','',1),(4,'edit',NULL,NULL,NULL,NULL,NULL,NULL);

/*Table structure for table `tbl_corrigendum` */

DROP TABLE IF EXISTS `tbl_corrigendum`;

CREATE TABLE `tbl_corrigendum` (
  `corrigendumId` int(11) NOT NULL AUTO_INCREMENT,
  `corrigendumText` varchar(0) NOT NULL,
  `createdBy` int(11) NOT NULL,
  `createdOn` datetime NOT NULL,
  `cstatus` int(11) NOT NULL,
  `objectId` int(11) NOT NULL,
  `publishedBy` int(11) DEFAULT NULL,
  `publishedOn` datetime DEFAULT NULL,
  `remarks` longtext NOT NULL,
  `processid` int(11) DEFAULT NULL,
  PRIMARY KEY (`corrigendumId`),
  KEY `FKcx2y2wgl0pvbkts45q20tofkl` (`processid`),
  CONSTRAINT `FKcx2y2wgl0pvbkts45q20tofkl` FOREIGN KEY (`processid`) REFERENCES `tbl_process` (`processId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tbl_corrigendum` */

/*Table structure for table `tbl_corrigendumdetail` */

DROP TABLE IF EXISTS `tbl_corrigendumdetail`;

CREATE TABLE `tbl_corrigendumdetail` (
  `corrigendumDetailId` int(11) NOT NULL AUTO_INCREMENT,
  `actionType` int(11) NOT NULL,
  `createdBy` int(11) NOT NULL,
  `createdOn` datetime NOT NULL,
  `fieldLabel` varchar(200) NOT NULL,
  `fieldName` varchar(100) NOT NULL,
  `newValue` varchar(0) NOT NULL,
  `objectId` int(11) NOT NULL,
  `oldValue` varchar(0) NOT NULL,
  `corrigendumid` int(11) DEFAULT NULL,
  `processid` int(11) DEFAULT NULL,
  PRIMARY KEY (`corrigendumDetailId`),
  KEY `FKqbaeq1ii8krlvihe9vho4s9p2` (`corrigendumid`),
  KEY `FK5gkdeank7uo145lb2jnx1mbdl` (`processid`),
  CONSTRAINT `FK5gkdeank7uo145lb2jnx1mbdl` FOREIGN KEY (`processid`) REFERENCES `tbl_process` (`processId`),
  CONSTRAINT `FKqbaeq1ii8krlvihe9vho4s9p2` FOREIGN KEY (`corrigendumid`) REFERENCES `tbl_corrigendum` (`corrigendumId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tbl_corrigendumdetail` */

/*Table structure for table `tbl_currency` */

DROP TABLE IF EXISTS `tbl_currency`;

CREATE TABLE `tbl_currency` (
  `currencyId` int(11) NOT NULL AUTO_INCREMENT,
  `currencyName` varchar(50) DEFAULT NULL,
  `isActive` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`currencyId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `tbl_currency` */

insert  into `tbl_currency`(`currencyId`,`currencyName`,`isActive`) values (1,'INR',1),(2,'POUND',1);

/*Table structure for table `tbl_department` */

DROP TABLE IF EXISTS `tbl_department`;

CREATE TABLE `tbl_department` (
  `deptId` int(100) NOT NULL AUTO_INCREMENT,
  `deptName` varchar(250) NOT NULL,
  `address` varchar(500) DEFAULT NULL,
  `countryId` int(100) DEFAULT NULL,
  `stateId` int(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `phoneNo` varchar(15) DEFAULT NULL,
  `parentDeptId` int(100) DEFAULT '0',
  `createdOn` datetime DEFAULT NULL,
  `createdBy` int(10) DEFAULT NULL,
  PRIMARY KEY (`deptId`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=latin1;

/*Data for the table `tbl_department` */

insert  into `tbl_department`(`deptId`,`deptName`,`address`,`countryId`,`stateId`,`city`,`phoneNo`,`parentDeptId`,`createdOn`,`createdBy`) values (57,'Dept1','ADD',NULL,NULL,NULL,NULL,0,NULL,NULL),(58,'Dept2','ADD2',NULL,NULL,NULL,NULL,57,NULL,NULL),(59,'Dept3','ADD4',NULL,NULL,NULL,NULL,0,NULL,NULL);

/*Table structure for table `tbl_designation` */

DROP TABLE IF EXISTS `tbl_designation`;

CREATE TABLE `tbl_designation` (
  `designationId` int(20) NOT NULL AUTO_INCREMENT,
  `designationName` varchar(50) NOT NULL,
  `deptId` int(20) NOT NULL,
  `createdBy` int(10) NOT NULL,
  `createDate` datetime NOT NULL,
  `modifiedBy` int(10) DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`designationId`),
  KEY `deptId` (`deptId`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=latin1;

/*Data for the table `tbl_designation` */

insert  into `tbl_designation`(`designationId`,`designationName`,`deptId`,`createdBy`,`createDate`,`modifiedBy`,`modifiedDate`) values (45,'Design12',57,1,'2016-11-19 07:08:55',1,'2016-11-19 07:08:55'),(49,'Desig3',57,1,'2016-11-25 00:27:19',1,'2016-11-25 00:27:19'),(50,'Desig4',57,1,'2016-11-25 00:27:27',1,'2016-11-25 00:27:27'),(60,'Desig5',57,1,'2016-11-25 00:28:27',NULL,NULL);

/*Table structure for table `tbl_envelope` */

DROP TABLE IF EXISTS `tbl_envelope`;

CREATE TABLE `tbl_envelope` (
  `envId` int(11) NOT NULL AUTO_INCREMENT,
  `isActive` int(11) NOT NULL,
  `lang1` varchar(50) DEFAULT NULL,
  `lang10` varchar(50) DEFAULT NULL,
  `lang11` varchar(50) DEFAULT NULL,
  `lang12` varchar(50) DEFAULT NULL,
  `lang13` varchar(50) DEFAULT NULL,
  `lang14` varchar(50) DEFAULT NULL,
  `lang15` varchar(50) DEFAULT NULL,
  `lang2` varchar(50) DEFAULT NULL,
  `lang3` varchar(50) DEFAULT NULL,
  `lang4` varchar(50) DEFAULT NULL,
  `lang5` varchar(50) DEFAULT NULL,
  `lang6` varchar(50) DEFAULT NULL,
  `lang7` varchar(50) DEFAULT NULL,
  `lang8` varchar(50) DEFAULT NULL,
  `lang9` varchar(50) DEFAULT NULL,
  `sortOrder` int(11) NOT NULL,
  PRIMARY KEY (`envId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `tbl_envelope` */

insert  into `tbl_envelope`(`envId`,`isActive`,`lang1`,`lang10`,`lang11`,`lang12`,`lang13`,`lang14`,`lang15`,`lang2`,`lang3`,`lang4`,`lang5`,`lang6`,`lang7`,`lang8`,`lang9`,`sortOrder`) values (1,0,'Document Fee',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),(2,1,'Pre Qualification',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),(3,1,'Technical bid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),(4,1,'Price bid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),(5,1,'Techno commercial',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1);

/*Table structure for table `tbl_exceptionlog` */

DROP TABLE IF EXISTS `tbl_exceptionlog`;

CREATE TABLE `tbl_exceptionlog` (
  `exceptionLogId` int(11) NOT NULL AUTO_INCREMENT,
  `className` varchar(100) NOT NULL,
  `createdBy` int(11) NOT NULL,
  `createdOn` datetime NOT NULL,
  `errorMessage` longtext NOT NULL,
  `fileName` varchar(100) NOT NULL,
  `lineNumber` int(11) NOT NULL,
  `linkId` int(11) NOT NULL,
  `method` varchar(100) NOT NULL,
  PRIMARY KEY (`exceptionLogId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tbl_exceptionlog` */

/*Table structure for table `tbl_link` */

DROP TABLE IF EXISTS `tbl_link`;

CREATE TABLE `tbl_link` (
  `linkId` int(11) NOT NULL AUTO_INCREMENT,
  `linkName` varchar(25) NOT NULL,
  `module` varchar(25) DEFAULT NULL,
  `link` varchar(50) NOT NULL,
  `description` varchar(50) NOT NULL,
  PRIMARY KEY (`linkId`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=latin1;

/*Data for the table `tbl_link` */

insert  into `tbl_link`(`linkId`,`linkName`,`module`,`link`,`description`) values (1,'create event','tender','/etender/buyer/createevent/','create tender'),(2,'tender dashboard','tender','/eProcurement/etenderdashboard','dashboard'),(3,'unauthorizedaccess','common','/eProcurement/unauthorizedaccess','unauthorizedaccess'),(4,'logout','common','/eProcurement/submitlogout','logout'),(5,'create prebid committee','tender','/eProcurement/etender/buyer/addcommittee','prebid add committee'),(6,'edit prebid committee','tender','/eProcurement/etender/buyer/editcommittee','prebid edit committee'),(7,'edit prebid committee','tender','/eProcurement/etender/buyer/posteditcommittee','prebid edit committee'),(8,'tender dashboard tab','tender','/eProcurement/etender/buyer/gettendertabcontent','tenderdashboard content'),(9,'create bid opening commit','tender','/eProcurement/etender/buyer/getcreatecommitee','bid opening committe creation'),(10,'officer list','tender','/eProcurement/etender/buyer/officers/','get officer list'),(11,'edit opening committee','tender','/eProcurement/etender/buyer/geteditcommitee','edit opening committe'),(12,'view committe','tender','/eProcurement/etender/buyer/getviewcommitee/','view committee'),(13,'submit prebid committe','tender','/eProcurement/etender/buyer/submitprebidcomittee','submit prebid committe'),(14,'create committee','tender','/eProcurement/etender/buyer/createcommittee','create committe'),(15,'loginfailed','common','/eProcurement/loginfailed','login failed'),(16,'view tender','tender','/etender/buyer/viewtender','view tender'),(17,'submit tender','tender','/etender/buyer/addtender','submit tender'),(18,'tender list','tender','/etender/buyer/tenderListing','tender listing'),(19,'create corrigendum','tender','/etender/buyer/createcorrigendum','create corrigendum'),(20,'submit corrigendum','tender','/etender/buyer/submittendercorrigendum','submit corrigendum'),(21,'tender corrigendum','tender','/etender/buyer/tendercorrigendum','tender corrigendum'),(22,'tender corrigendim submit','tender','/etender/buyer/tendercorrigendumsubmit','corringendum submit'),(23,'Listing','common','/etender/commonListPage','Listing'),(24,'Listing grid','common','/etender/commonDataGrid','Grid'),(25,'department list','common','/common/user/getdepartments','get departments'),(26,'department exists','common','/common/user/isdepartmentexist/','department exists'),(27,'add departments','common','/common/user/addDept','add departments'),(28,'edit departments','common','/common/user/geteditdepartment/','edit departments'),(29,'edit departments','common','/common/user/editDept','edit departments'),(30,'get designation','common','/common/user/getdesignation','get designations'),(31,'add designation','common','/common/user/addDesignation','add designation'),(32,'edit designation','common','/common/user/geteditdesignation/','edit designation'),(33,'edit designation','common','/common/user/editDesignation','edit designation'),(34,'is designation exists','commmon','/common/user/isdesignationexists/','is desingation exists'),(35,'create officer','common','/common/user/getcreateofficer','create officer'),(36,'edit officer','common','/common/user/geteditofficer/','edit officer'),(37,'add officer','common','/common/user/adduser','add officer'),(38,'manage user','common','/common/user/getmanageuser','manage user'),(39,'getsubdepartments','common','/common/user/getsubdepartments','get sub departments'),(40,'get designation by deptud','common','/common/user/getdesignationbydeptid','get designation by deptid');

/*Table structure for table `tbl_officer` */

DROP TABLE IF EXISTS `tbl_officer`;

CREATE TABLE `tbl_officer` (
  `id` bigint(20) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `companyname` varchar(250) DEFAULT NULL,
  `countryid` int(11) DEFAULT NULL,
  `createdby` int(11) NOT NULL,
  `datecreated` datetime NOT NULL,
  `datemodified` datetime DEFAULT NULL,
  `emailid` varchar(250) NOT NULL,
  `mobileno` varchar(11) NOT NULL,
  `modifiedby` int(11) DEFAULT NULL,
  `officername` varchar(250) NOT NULL,
  `stateid` int(11) DEFAULT NULL,
  `cstatus` int(11) NOT NULL,
  `userId` bigint(20) NOT NULL,
  `designationId` int(10) NOT NULL,
  `deptId` int(10) NOT NULL,
  `phoneNo` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKoatvevnol0jrf1hv5hemxr61m` (`userId`),
  KEY `designationId` (`designationId`),
  KEY `tbl_officer_ibfk_3` (`deptId`),
  CONSTRAINT `tbl_officer_ibfk_3` FOREIGN KEY (`deptId`) REFERENCES `tbl_department` (`deptId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tbl_officer_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `tbl_userlogin` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tbl_officer_ibfk_2` FOREIGN KEY (`designationId`) REFERENCES `tbl_designation` (`designationId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tbl_officer` */

insert  into `tbl_officer`(`id`,`address`,`city`,`companyname`,`countryid`,`createdby`,`datecreated`,`datemodified`,`emailid`,`mobileno`,`modifiedby`,`officername`,`stateid`,`cstatus`,`userId`,`designationId`,`deptId`,`phoneNo`) values (1,'ahmdeabad','ahmedabad','cp1',1,1,'2016-11-11 04:33:45','2016-11-11 04:33:47','officer1@mail.com','2147483647',1,'officer1',1,1,1,45,57,NULL),(2,'ahmdeabad','ahmdeabad','cp2',1,1,'2016-11-11 04:34:44','2016-11-11 04:34:47','officer2@mail.com','562312445',1,'officer2',1,1,2,45,57,NULL),(3,'ahmedabad','ahmdabad','cp3',1,1,'2016-11-11 04:35:32','2016-11-11 04:35:35','officer3@mail.com','12345678',1,'officer3',1,1,3,45,57,NULL),(4,'ahmedabad','ahmedabad','cp4',1,1,'2016-11-11 04:36:14','2016-11-11 04:36:17','officer4@mail.com','2147483647',1,'officer4',1,1,4,45,57,NULL),(64,NULL,NULL,NULL,NULL,1,'2016-11-25 02:28:24',NULL,'officer5@gmail.com','12121212',NULL,'Nirav',NULL,1,63,45,57,'12121212'),(66,NULL,NULL,NULL,NULL,1,'2016-11-25 17:39:34','2016-11-25 17:39:34','officer6@mail.com','111111111',1,'officersiXdf',NULL,1,65,60,57,'111111111');

/*Table structure for table `tbl_officerdocument` */

DROP TABLE IF EXISTS `tbl_officerdocument`;

CREATE TABLE `tbl_officerdocument` (
  `officerDocId` int(250) NOT NULL AUTO_INCREMENT,
  `docName` varchar(250) NOT NULL,
  `description` varbinary(100) DEFAULT NULL,
  `content` longblob NOT NULL,
  `docType` varchar(250) NOT NULL,
  `docSize` int(200) NOT NULL,
  `linkId` int(100) NOT NULL,
  `objectId` int(100) DEFAULT NULL,
  `childId` int(100) DEFAULT NULL,
  `subChildId` int(100) DEFAULT NULL,
  `officerId` int(100) NOT NULL,
  PRIMARY KEY (`officerDocId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tbl_officerdocument` */

/*Table structure for table `tbl_process` */

DROP TABLE IF EXISTS `tbl_process`;

CREATE TABLE `tbl_process` (
  `processId` int(11) NOT NULL AUTO_INCREMENT,
  `isActive` int(11) DEFAULT NULL,
  `processName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`processId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tbl_process` */

/*Table structure for table `tbl_procurementnature` */

DROP TABLE IF EXISTS `tbl_procurementnature`;

CREATE TABLE `tbl_procurementnature` (
  `procurementNatureId` int(11) NOT NULL AUTO_INCREMENT,
  `procurementName` varchar(200) DEFAULT NULL,
  `cStatus` int(11) DEFAULT NULL COMMENT '0:inactive,1:active',
  PRIMARY KEY (`procurementNatureId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `tbl_procurementnature` */

insert  into `tbl_procurementnature`(`procurementNatureId`,`procurementName`,`cStatus`) values (1,'Goods',1),(2,'Service',1),(3,'Works',1),(4,'Turnkey Project',1),(5,'Other',1);

/*Table structure for table `tbl_rolelinkmapping` */

DROP TABLE IF EXISTS `tbl_rolelinkmapping`;

CREATE TABLE `tbl_rolelinkmapping` (
  `rolelinkmapId` int(10) NOT NULL AUTO_INCREMENT,
  `linkId` int(10) NOT NULL,
  `roleId` int(10) NOT NULL,
  PRIMARY KEY (`rolelinkmapId`),
  KEY `rolev` (`roleId`),
  KEY `linkv` (`linkId`),
  CONSTRAINT `linkv` FOREIGN KEY (`linkId`) REFERENCES `tbl_link` (`linkId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rolev` FOREIGN KEY (`roleId`) REFERENCES `tbl_roles` (`roleId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=latin1;

/*Data for the table `tbl_rolelinkmapping` */

insert  into `tbl_rolelinkmapping`(`rolelinkmapId`,`linkId`,`roleId`) values (1,1,1),(2,2,1),(3,3,1),(4,4,1),(5,5,1),(6,6,1),(7,7,1),(8,8,1),(9,9,1),(10,10,1),(11,11,1),(12,12,1),(13,13,1),(14,14,1),(15,15,1),(16,16,1),(17,17,1),(18,18,1),(19,19,1),(20,20,1),(21,21,1),(22,22,1),(23,23,1),(24,24,1),(25,25,1),(26,26,1),(27,27,1),(28,28,1),(29,29,1),(30,30,1),(31,31,1),(32,32,1),(33,33,1),(34,34,1),(35,35,1),(36,36,1),(37,37,1),(38,38,1),(39,39,1),(40,40,1);

/*Table structure for table `tbl_roles` */

DROP TABLE IF EXISTS `tbl_roles`;

CREATE TABLE `tbl_roles` (
  `roleId` int(10) NOT NULL AUTO_INCREMENT,
  `roleName` varchar(100) NOT NULL,
  PRIMARY KEY (`roleId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `tbl_roles` */

insert  into `tbl_roles`(`roleId`,`roleName`) values (1,'Creator'),(2,'Approver'),(3,'Opener'),(4,'Evalutor');

/*Table structure for table `tbl_tender` */

DROP TABLE IF EXISTS `tbl_tender`;

CREATE TABLE `tbl_tender` (
  `tenderId` int(11) NOT NULL AUTO_INCREMENT,
  `POType` int(11) NOT NULL,
  `assignUserId` int(11) NOT NULL,
  `biddingType` int(11) NOT NULL,
  `biddingVariant` int(11) NOT NULL,
  `brdMode` int(11) NOT NULL,
  `corrigendumCount` int(11) NOT NULL,
  `createRfxFromEvent` int(11) NOT NULL,
  `procurementNatureId` int(10) NOT NULL DEFAULT '0',
  `createdBy` int(11) NOT NULL,
  `createdOn` datetime DEFAULT NULL,
  `cstatus` int(11) NOT NULL,
  `currencyId` int(11) NOT NULL,
  `decimalValueUpto` int(11) NOT NULL,
  `decryptorRequired` int(11) NOT NULL,
  `docFeePaymentAddress` longtext NOT NULL,
  `docFeePaymentMode` int(11) NOT NULL,
  `documentEndDate` datetime DEFAULT NULL,
  `documentFee` varchar(50) NOT NULL,
  `documentStartDate` datetime DEFAULT NULL,
  `documentSubmission` longtext NOT NULL,
  `downloadDocument` int(11) NOT NULL,
  `emdAmount` varchar(50) NOT NULL,
  `emdPaymentAddress` longtext NOT NULL,
  `emdPaymentMode` int(11) NOT NULL,
  `encryptionLevel` int(11) NOT NULL,
  `envelopeType` int(11) NOT NULL,
  `evaluationMode` int(11) NOT NULL,
  `forHomePage` int(11) NOT NULL,
  `formContract` int(11) NOT NULL,
  `isBidWithdrawal` int(11) NOT NULL,
  `isCentralizedTECRequired` int(11) NOT NULL,
  `isCentralizedTOCRequired` int(11) NOT NULL,
  `isCertRequired` int(11) NOT NULL,
  `isConsortiumAllowed` int(11) NOT NULL,
  `isCreateAuction` int(11) NOT NULL,
  `isDemoTender` int(11) NOT NULL,
  `isDisplayClarificationDoc` int(11) NOT NULL,
  `isDocfeesApplicable` int(11) NOT NULL,
  `isDocumentFeeByBidder` int(11) NOT NULL,
  `isEMDApplicable` int(11) NOT NULL,
  `isEMDByBidder` int(11) NOT NULL,
  `isEMDdoneByTOC` int(11) NOT NULL,
  `isEncDocumentOnly` int(11) NOT NULL,
  `isEncodedName` int(11) NOT NULL,
  `isEvaluationByCommittee` int(11) NOT NULL,
  `isEvaluationRequired` int(11) NOT NULL,
  `isFinalPriceSheetReq` int(11) NOT NULL,
  `isFormConfirmationReq` int(11) NOT NULL,
  `isItemSelectionPageRequired` int(11) NOT NULL,
  `isItemwiseWinner` int(11) NOT NULL,
  `isMandatoryDocument` int(11) NOT NULL,
  `isNegotiationAllowed` int(11) NOT NULL,
  `isOpeningByCommittee` int(11) NOT NULL,
  `isPartialFillingAllowed` int(11) NOT NULL,
  `isParticipationFeesBy` int(11) NOT NULL,
  `isPastEvent` int(11) NOT NULL,
  `isPreBidMeeting` int(11) NOT NULL,
  `isProcessingFeeByBidder` int(11) NOT NULL,
  `isProxyBid` int(11) NOT NULL,
  `isQuestionAnswer` int(11) NOT NULL,
  `isReEvaluationReq` int(11) NOT NULL,
  `isRebateForm` int(11) NOT NULL,
  `isRegistrationCharges` int(11) NOT NULL,
  `isRestOfEventMoney` int(11) DEFAULT NULL,
  `isRevisePriceBid` int(11) NOT NULL,
  `isReworkRequired` int(11) NOT NULL,
  `isSORApplicable` int(11) NOT NULL,
  `isSecurityfeesApplicable` int(11) NOT NULL,
  `isSplitPOAllowed` int(11) NOT NULL,
  `isSystemGeneratedTenderDoc` int(11) NOT NULL,
  `isTwoStageEvaluation` int(11) NOT NULL,
  `isTwoStageOpening` int(11) NOT NULL,
  `isWeightageEvaluationRequired` int(11) NOT NULL,
  `isWorkflowRequired` int(11) NOT NULL,
  `keywordText` varchar(1000) DEFAULT NULL,
  `multiLevelEvaluationReq` int(11) NOT NULL,
  `officerId` int(11) NOT NULL,
  `openingDate` datetime DEFAULT NULL,
  `otherProcurementNature` varchar(50) NOT NULL,
  `preBidAddress` longtext NOT NULL,
  `preBidEndDate` datetime DEFAULT NULL,
  `preBidMode` int(11) NOT NULL,
  `preBidStartDate` datetime DEFAULT NULL,
  `prequalification` varchar(50) NOT NULL,
  `prevEstimatedValue` decimal(19,2) NOT NULL,
  `productId` int(11) NOT NULL,
  `projectDuration` varchar(255) NOT NULL,
  `publishedBy` int(11) DEFAULT NULL,
  `publishedOn` datetime DEFAULT NULL,
  `questionAnswerEndDate` datetime DEFAULT NULL,
  `questionAnswerStartDate` datetime DEFAULT NULL,
  `registrationCharges` varchar(50) NOT NULL,
  `registrationChargesMode` int(11) NOT NULL,
  `remark` longtext NOT NULL,
  `resultSharing` int(11) NOT NULL,
  `secFeePaymentAddress` longtext NOT NULL,
  `secFeePaymentMode` int(11) NOT NULL,
  `securityFee` varchar(50) NOT NULL,
  `showBidDetail` int(11) NOT NULL,
  `showBidderWiseForm` int(11) NOT NULL,
  `showNoOfBidders` int(11) NOT NULL,
  `showResultOnHomePage` int(11) NOT NULL,
  `sorVariation` decimal(19,2) NOT NULL,
  `submissionEndDate` datetime DEFAULT NULL,
  `submissionMode` int(11) NOT NULL,
  `submissionStartDate` datetime DEFAULT NULL,
  `tenderBrief` varchar(1000) DEFAULT NULL,
  `tenderDetail` varchar(1000) DEFAULT NULL,
  `tenderMode` int(11) NOT NULL,
  `tenderNo` longtext NOT NULL,
  `tenderResult` int(11) NOT NULL,
  `tenderSector` int(11) NOT NULL,
  `tenderValue` decimal(19,2) NOT NULL,
  `updatedBy` int(11) NOT NULL,
  `updatedOn` datetime NOT NULL,
  `validityPeriod` int(11) NOT NULL,
  `winningReportMode` int(11) NOT NULL,
  `workflowForBidOpening` int(11) NOT NULL,
  `workflowForNegotiation` int(11) NOT NULL,
  `workflowForTEC` int(11) DEFAULT NULL,
  `workflowForTOC` int(11) DEFAULT NULL,
  `workflowTypeId` int(11) NOT NULL,
  `departmentId` int(11) DEFAULT NULL,
  `eventTypeId` int(11) DEFAULT NULL,
  `autoResultSharing` int(11) DEFAULT '0',
  PRIMARY KEY (`tenderId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `tbl_tender` */

insert  into `tbl_tender`(`tenderId`,`POType`,`assignUserId`,`biddingType`,`biddingVariant`,`brdMode`,`corrigendumCount`,`createRfxFromEvent`,`procurementNatureId`,`createdBy`,`createdOn`,`cstatus`,`currencyId`,`decimalValueUpto`,`decryptorRequired`,`docFeePaymentAddress`,`docFeePaymentMode`,`documentEndDate`,`documentFee`,`documentStartDate`,`documentSubmission`,`downloadDocument`,`emdAmount`,`emdPaymentAddress`,`emdPaymentMode`,`encryptionLevel`,`envelopeType`,`evaluationMode`,`forHomePage`,`formContract`,`isBidWithdrawal`,`isCentralizedTECRequired`,`isCentralizedTOCRequired`,`isCertRequired`,`isConsortiumAllowed`,`isCreateAuction`,`isDemoTender`,`isDisplayClarificationDoc`,`isDocfeesApplicable`,`isDocumentFeeByBidder`,`isEMDApplicable`,`isEMDByBidder`,`isEMDdoneByTOC`,`isEncDocumentOnly`,`isEncodedName`,`isEvaluationByCommittee`,`isEvaluationRequired`,`isFinalPriceSheetReq`,`isFormConfirmationReq`,`isItemSelectionPageRequired`,`isItemwiseWinner`,`isMandatoryDocument`,`isNegotiationAllowed`,`isOpeningByCommittee`,`isPartialFillingAllowed`,`isParticipationFeesBy`,`isPastEvent`,`isPreBidMeeting`,`isProcessingFeeByBidder`,`isProxyBid`,`isQuestionAnswer`,`isReEvaluationReq`,`isRebateForm`,`isRegistrationCharges`,`isRestOfEventMoney`,`isRevisePriceBid`,`isReworkRequired`,`isSORApplicable`,`isSecurityfeesApplicable`,`isSplitPOAllowed`,`isSystemGeneratedTenderDoc`,`isTwoStageEvaluation`,`isTwoStageOpening`,`isWeightageEvaluationRequired`,`isWorkflowRequired`,`keywordText`,`multiLevelEvaluationReq`,`officerId`,`openingDate`,`otherProcurementNature`,`preBidAddress`,`preBidEndDate`,`preBidMode`,`preBidStartDate`,`prequalification`,`prevEstimatedValue`,`productId`,`projectDuration`,`publishedBy`,`publishedOn`,`questionAnswerEndDate`,`questionAnswerStartDate`,`registrationCharges`,`registrationChargesMode`,`remark`,`resultSharing`,`secFeePaymentAddress`,`secFeePaymentMode`,`securityFee`,`showBidDetail`,`showBidderWiseForm`,`showNoOfBidders`,`showResultOnHomePage`,`sorVariation`,`submissionEndDate`,`submissionMode`,`submissionStartDate`,`tenderBrief`,`tenderDetail`,`tenderMode`,`tenderNo`,`tenderResult`,`tenderSector`,`tenderValue`,`updatedBy`,`updatedOn`,`validityPeriod`,`winningReportMode`,`workflowForBidOpening`,`workflowForNegotiation`,`workflowForTEC`,`workflowForTOC`,`workflowTypeId`,`departmentId`,`eventTypeId`,`autoResultSharing`) values (1,0,1,1,1,0,1,0,0,1,'2016-11-13 20:31:51',0,1,2,0,'',0,'2016-11-10 09:09:39','','2016-11-11 09:09:47','',1,'','',0,0,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'no idTest tender updateTest Test tender updatetender update',0,1,NULL,'','',NULL,1,NULL,'','10000.00',0,'10',1,'2016-11-13 20:32:36','2016-11-24 09:13:08','2016-11-18 09:13:14','',0,'',1,'',0,'',1,1,1,1,'1.00',NULL,1,NULL,'no idTest tender upTest tender updatedatTest tender updateeTestTest tender update tender updaTest tender updateTest tender updatete','no idTest tender updatTest tender updateeTest tendeTest tender updater updatTest tender updatee',1,'Test tender update',2,0,'2500.00',1,'2016-11-15 11:24:27',120,1,1,1,1,1,3,0,1,0),(2,0,1,1,1,0,0,0,0,1,NULL,0,1,0,1,'',0,NULL,'',NULL,'',2,'','',0,2,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,'new tendernew tender',0,1,NULL,'','',NULL,2,NULL,'','0.00',0,'10',0,NULL,NULL,NULL,'',0,'',1,'',0,'',0,0,0,0,'0.00',NULL,1,NULL,'new tendernew tendernew tendernew tender','new tendernew tender',2,'new tender',1,0,'0.00',1,'2016-11-14 10:43:03',0,0,0,0,0,0,3,0,1,0),(3,0,1,1,1,0,0,0,0,1,NULL,0,1,0,1,'',0,NULL,'',NULL,'',2,'','',0,2,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,'new tendernew tender',0,1,NULL,'','',NULL,2,NULL,'','0.00',0,'10',0,NULL,NULL,NULL,'',0,'',1,'',0,'',0,0,0,0,'0.00',NULL,1,NULL,'new tendernew tendernew tendernew tender','new tendernew tender',2,'new tender',1,0,'0.00',1,'2016-11-14 10:43:37',0,0,0,0,0,0,3,0,1,0),(4,0,1,1,1,0,0,0,0,1,NULL,0,1,0,1,'',0,NULL,'',NULL,'',2,'','',0,2,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,'new tendernew tender',0,1,NULL,'','',NULL,2,NULL,'','0.00',0,'10',0,NULL,NULL,NULL,'',0,'',1,'',0,'',0,0,0,0,'0.00',NULL,1,NULL,'new tendernew tendernew tendernew tender','new tendernew tender',2,'new tender',1,0,'0.00',1,'2016-11-14 10:43:49',0,0,0,0,0,0,3,0,1,0),(5,0,1,1,1,0,0,0,0,1,NULL,0,1,0,1,'',0,NULL,'',NULL,'',2,'','',0,2,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,'new tendernew tender',0,1,NULL,'','',NULL,2,NULL,'','0.00',0,'10',0,NULL,NULL,NULL,'',0,'',1,'',0,'',0,0,0,0,'0.00',NULL,1,NULL,'new tendernew tendernew tendernew tender','new tendernew tender',2,'new tender',1,0,'0.00',1,'2016-11-14 10:44:55',0,0,0,0,0,0,3,0,1,0),(6,0,1,1,1,0,0,0,0,1,NULL,0,1,0,1,'',0,NULL,'',NULL,'',2,'','',0,2,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,'new tendernew tender',0,1,NULL,'','',NULL,2,NULL,'','0.00',0,'10',0,NULL,NULL,NULL,'',0,'',1,'',0,'',0,0,0,0,'0.00',NULL,1,NULL,'new tendernew tendernew tendernew tender','new tendernew tender',2,'new tender',1,0,'0.00',1,'2016-11-14 10:46:19',0,0,0,0,0,0,3,0,1,0);

/*Table structure for table `tbl_tenderaudittrail` */

DROP TABLE IF EXISTS `tbl_tenderaudittrail`;

CREATE TABLE `tbl_tenderaudittrail` (
  `tenderAuditTrailId` bigint(20) NOT NULL AUTO_INCREMENT,
  `createdOn` datetime NOT NULL,
  `linkId` int(11) NOT NULL,
  `loginUserId` varchar(255) NOT NULL,
  `objectId` bigint(20) NOT NULL,
  `pageUrl` longtext NOT NULL,
  `remark` varchar(100) NOT NULL,
  `tenderId` int(11) NOT NULL,
  PRIMARY KEY (`tenderAuditTrailId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tbl_tenderaudittrail` */

/*Table structure for table `tbl_tendercell` */

DROP TABLE IF EXISTS `tbl_tendercell`;

CREATE TABLE `tbl_tendercell` (
  `cellId` int(11) NOT NULL AUTO_INCREMENT,
  `cellNo` int(11) NOT NULL,
  `cellValue` varchar(0) NOT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tbl_tendercell` */

/*Table structure for table `tbl_tendercolumn` */

DROP TABLE IF EXISTS `tbl_tendercolumn`;

CREATE TABLE `tbl_tendercolumn` (
  `columnId` int(11) NOT NULL AUTO_INCREMENT,
  `columnHeader` longtext NOT NULL,
  `columnNo` int(11) NOT NULL,
  `dataType` int(11) NOT NULL,
  `filledBy` int(11) NOT NULL,
  `isCurrConvReq` int(11) NOT NULL,
  `isShown` int(11) NOT NULL,
  `sortOrder` int(11) NOT NULL,
  `columntypeid` int(11) DEFAULT NULL,
  `formid` int(11) DEFAULT NULL,
  `tableid` int(11) DEFAULT NULL,
  PRIMARY KEY (`columnId`),
  KEY `FKflivw3ths63g1ntd2vd6hnqi9` (`columntypeid`),
  KEY `FKkto1wkralr8rhfhijv9kts44u` (`formid`),
  KEY `FKal1pay10o58tt0rq4rvv5sr45` (`tableid`),
  CONSTRAINT `FKal1pay10o58tt0rq4rvv5sr45` FOREIGN KEY (`tableid`) REFERENCES `tbl_tendertable` (`tableId`),
  CONSTRAINT `FKflivw3ths63g1ntd2vd6hnqi9` FOREIGN KEY (`columntypeid`) REFERENCES `tbl_columntype` (`columnTypeId`),
  CONSTRAINT `FKkto1wkralr8rhfhijv9kts44u` FOREIGN KEY (`formid`) REFERENCES `tbl_tenderform` (`formId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tbl_tendercolumn` */

/*Table structure for table `tbl_tendercurrency` */

DROP TABLE IF EXISTS `tbl_tendercurrency`;

CREATE TABLE `tbl_tendercurrency` (
  `tenderCurrencyId` int(11) NOT NULL AUTO_INCREMENT,
  `currencyId` varchar(255) DEFAULT NULL,
  `exchangeRate` decimal(19,2) NOT NULL,
  `isActive` int(11) NOT NULL,
  `isDefault` int(11) NOT NULL,
  `tenderid` int(11) DEFAULT NULL,
  PRIMARY KEY (`tenderCurrencyId`),
  KEY `FKr9mq7c4tmf6qymsi7u6wp9q0f` (`tenderid`),
  CONSTRAINT `FKr9mq7c4tmf6qymsi7u6wp9q0f` FOREIGN KEY (`tenderid`) REFERENCES `tbl_tender` (`tenderId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tbl_tendercurrency` */

/*Table structure for table `tbl_tenderenvelope` */

DROP TABLE IF EXISTS `tbl_tenderenvelope`;

CREATE TABLE `tbl_tenderenvelope` (
  `envelopeId` int(11) NOT NULL AUTO_INCREMENT,
  `createdBy` int(11) NOT NULL,
  `createdOn` datetime NOT NULL,
  `cstatus` int(11) NOT NULL,
  `envelopeName` varchar(50) NOT NULL,
  `isEvaluated` int(11) NOT NULL,
  `isOpened` int(11) NOT NULL,
  `minEvaluator` int(11) NOT NULL,
  `minFormsReqForBidding` int(11) NOT NULL,
  `minOpeningMember` int(11) NOT NULL,
  `noOfFormsReq` int(11) NOT NULL,
  `openingDate` datetime DEFAULT NULL,
  `openingDatePublishedBy` int(11) DEFAULT NULL,
  `openingDatePublishedOn` datetime DEFAULT NULL,
  `openingDateStatus` int(11) NOT NULL,
  `publishedBy` int(11) DEFAULT NULL,
  `publishedOn` datetime DEFAULT NULL,
  `remark` longtext NOT NULL,
  `sortOrder` int(11) NOT NULL,
  `envid` int(11) DEFAULT NULL,
  `tenderid` int(11) DEFAULT NULL,
  PRIMARY KEY (`envelopeId`),
  KEY `FKfbksx7rndmadm6s50p95qsxdi` (`envid`),
  KEY `FK5jlfl2uxve53py9qhdx7uwyp7` (`tenderid`),
  CONSTRAINT `FK5jlfl2uxve53py9qhdx7uwyp7` FOREIGN KEY (`tenderid`) REFERENCES `tbl_tender` (`tenderId`),
  CONSTRAINT `FKfbksx7rndmadm6s50p95qsxdi` FOREIGN KEY (`envid`) REFERENCES `tbl_envelope` (`envId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `tbl_tenderenvelope` */

insert  into `tbl_tenderenvelope`(`envelopeId`,`createdBy`,`createdOn`,`cstatus`,`envelopeName`,`isEvaluated`,`isOpened`,`minEvaluator`,`minFormsReqForBidding`,`minOpeningMember`,`noOfFormsReq`,`openingDate`,`openingDatePublishedBy`,`openingDatePublishedOn`,`openingDateStatus`,`publishedBy`,`publishedOn`,`remark`,`sortOrder`,`envid`,`tenderid`) values (1,1,'2016-11-12 20:03:12',1,'Technical EnvelopeName',0,0,2,1,2,1,'2016-11-23 20:03:59',1,'2016-11-12 20:04:08',1,1,'2016-11-12 20:04:21','asdfasdfads',1,1,1),(2,1,'2016-11-17 20:07:53',1,'Price bid Envelope',0,0,2,1,2,1,'2016-11-18 20:08:38',1,'2016-11-26 21:35:37',1,1,'2016-11-18 21:35:48','asfasdfads',2,2,1);

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tbl_tenderform` */

/*Table structure for table `tbl_tendergovcolumn` */

DROP TABLE IF EXISTS `tbl_tendergovcolumn`;

CREATE TABLE `tbl_tendergovcolumn` (
  `govColumnId` int(11) NOT NULL AUTO_INCREMENT,
  `cellId` int(11) NOT NULL,
  `columnNo` int(11) NOT NULL,
  `ipAddress` varchar(20) NOT NULL,
  `tenderid` int(11) DEFAULT NULL,
  `columnid` int(11) DEFAULT NULL,
  `formid` int(11) DEFAULT NULL,
  `tableid` int(11) DEFAULT NULL,
  PRIMARY KEY (`govColumnId`),
  KEY `FK5uu2v2oa7g16nq8q9v87oo335` (`tenderid`),
  KEY `FKahf5viqtf35e27svqim7dexld` (`columnid`),
  KEY `FKtbm3q4avwp3pgkscsg7y9yh0u` (`formid`),
  KEY `FK5ag1w92pip8uu8lqujrfq5lay` (`tableid`),
  CONSTRAINT `FK5ag1w92pip8uu8lqujrfq5lay` FOREIGN KEY (`tableid`) REFERENCES `tbl_tendertable` (`tableId`),
  CONSTRAINT `FK5uu2v2oa7g16nq8q9v87oo335` FOREIGN KEY (`tenderid`) REFERENCES `tbl_tender` (`tenderId`),
  CONSTRAINT `FKahf5viqtf35e27svqim7dexld` FOREIGN KEY (`columnid`) REFERENCES `tbl_tendercolumn` (`columnId`),
  CONSTRAINT `FKtbm3q4avwp3pgkscsg7y9yh0u` FOREIGN KEY (`formid`) REFERENCES `tbl_tenderform` (`formId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tbl_tendergovcolumn` */

/*Table structure for table `tbl_tendermatrixjson` */

DROP TABLE IF EXISTS `tbl_tendermatrixjson`;

CREATE TABLE `tbl_tendermatrixjson` (
  `matrixJsonId` int(11) NOT NULL AUTO_INCREMENT,
  `jsonData` varchar(0) NOT NULL,
  `formid` int(11) DEFAULT NULL,
  `tableid` int(11) DEFAULT NULL,
  PRIMARY KEY (`matrixJsonId`),
  KEY `FKnn36libdss8ft7hde4wm3icdx` (`formid`),
  KEY `FKfoldx1e3v3ejaa6k5lijpy9ct` (`tableid`),
  CONSTRAINT `FKfoldx1e3v3ejaa6k5lijpy9ct` FOREIGN KEY (`tableid`) REFERENCES `tbl_tendertable` (`tableId`),
  CONSTRAINT `FKnn36libdss8ft7hde4wm3icdx` FOREIGN KEY (`formid`) REFERENCES `tbl_tenderform` (`formId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tbl_tendermatrixjson` */

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tbl_tendertable` */

/*Table structure for table `tbl_userlogin` */

DROP TABLE IF EXISTS `tbl_userlogin`;

CREATE TABLE `tbl_userlogin` (
  `userId` bigint(20) NOT NULL AUTO_INCREMENT,
  `createdby` int(11) NOT NULL,
  `datecreated` datetime DEFAULT NULL,
  `datemodified` datetime DEFAULT NULL,
  `failedattempt` int(11) DEFAULT '0',
  `loginid` longtext NOT NULL,
  `modifiedby` int(11) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `salt` varchar(250) DEFAULT NULL,
  `cstatus` int(11) NOT NULL,
  `designationId` int(10) DEFAULT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=latin1;

/*Data for the table `tbl_userlogin` */

insert  into `tbl_userlogin`(`userId`,`createdby`,`datecreated`,`datemodified`,`failedattempt`,`loginid`,`modifiedby`,`password`,`salt`,`cstatus`,`designationId`) values (1,1,'2016-11-08 17:42:00','2016-11-08 17:43:20',0,'officer1@mail.com',0,'9898','1111',1,0),(2,1,'2016-11-08 17:43:41',NULL,0,'officer2@mail.com',0,'9898','1111',1,0),(3,1,'2016-11-08 17:44:15',NULL,0,'officer3@mail.com',0,'9898','1111',1,0),(4,1,'2016-11-08 17:45:01',NULL,0,'officer4@mail.com',0,'9898','1111',1,0),(63,1,NULL,NULL,0,'officer5@gmail.com',0,'Officer@123',NULL,1,45),(65,1,NULL,NULL,NULL,'officer6@mail.com',1,'Auction@123',NULL,1,60);

/*Table structure for table `tbl_userrolemapping` */

DROP TABLE IF EXISTS `tbl_userrolemapping`;

CREATE TABLE `tbl_userrolemapping` (
  `userrolemapId` int(10) NOT NULL AUTO_INCREMENT,
  `roleId` int(10) NOT NULL,
  `userId` bigint(10) NOT NULL,
  PRIMARY KEY (`userrolemapId`),
  KEY `user` (`userId`),
  KEY `role` (`roleId`),
  CONSTRAINT `role` FOREIGN KEY (`roleId`) REFERENCES `tbl_roles` (`roleId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user` FOREIGN KEY (`userId`) REFERENCES `tbl_userlogin` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=latin1;

/*Data for the table `tbl_userrolemapping` */

insert  into `tbl_userrolemapping`(`userrolemapId`,`roleId`,`userId`) values (2,1,4),(93,1,65),(94,4,65);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
