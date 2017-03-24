-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.6.33 - MySQL Community Server (GPL)
-- Server OS:                    linux-glibc2.5
-- HeidiSQL Version:             9.4.0.5138
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for eauctiontender
DROP DATABASE IF EXISTS `eauctiontender`;
CREATE DATABASE IF NOT EXISTS `eauctiontender` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `eauctiontender`;

-- Dumping structure for table eauctiontender.hibernate_sequence
DROP TABLE IF EXISTS `hibernate_sequence`;
CREATE TABLE IF NOT EXISTS `hibernate_sequence` (
  `next_val` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.hibernate_sequence: ~2 rows (approximately)
/*!40000 ALTER TABLE `hibernate_sequence` DISABLE KEYS */;
INSERT INTO `hibernate_sequence` (`next_val`) VALUES
	(957),
	(957);
/*!40000 ALTER TABLE `hibernate_sequence` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_bidder
DROP TABLE IF EXISTS `tbl_bidder`;
CREATE TABLE IF NOT EXISTS `tbl_bidder` (
  `bidderId` int(10) NOT NULL AUTO_INCREMENT,
  `emailId` varchar(25) NOT NULL,
  `personName` varchar(25) NOT NULL,
  `companyName` varchar(25) NOT NULL,
  `address` varchar(250) NOT NULL,
  `countryId` int(10) NOT NULL,
  `stateId` int(10) NOT NULL,
  `city` varchar(25) NOT NULL,
  `phoneNo` varchar(11) DEFAULT NULL,
  `mobileNo` varchar(11) NOT NULL,
  `website` varchar(25) DEFAULT NULL,
  `keyword` varchar(25) DEFAULT NULL,
  `cstatus` int(10) NOT NULL,
  `userId` int(10) NOT NULL,
  `datecreated` datetime NOT NULL,
  `datemodified` datetime DEFAULT NULL,
  `createdBy` int(11) NOT NULL,
  `modifiedBy` int(11) DEFAULT NULL,
  `companyId` int(11) NOT NULL,
  PRIMARY KEY (`bidderId`),
  KEY `countryId` (`countryId`),
  KEY `stateId` (`stateId`),
  KEY `FK_tbl_bidder_company` (`companyId`),
  CONSTRAINT `FK_tbl_bidder_company` FOREIGN KEY (`companyId`) REFERENCES `tbl_company` (`companyid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tbl_bidder_ibfk_1` FOREIGN KEY (`countryId`) REFERENCES `tbl_country` (`countryId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tbl_bidder_ibfk_2` FOREIGN KEY (`stateId`) REFERENCES `tbl_state` (`stateId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=945 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_bidder: ~9 rows (approximately)
/*!40000 ALTER TABLE `tbl_bidder` DISABLE KEYS */;
INSERT INTO `tbl_bidder` (`bidderId`, `emailId`, `personName`, `companyName`, `address`, `countryId`, `stateId`, `city`, `phoneNo`, `mobileNo`, `website`, `keyword`, `cstatus`, `userId`, `datecreated`, `datemodified`, `createdBy`, `modifiedBy`, `companyId`) VALUES
	(256, 'bidder4@mail.com', 'bidderfour', 'AON', 'ahmedabad', 1, 1, 'ahmedabad', '9865321245', '7845123256', 'www.aon.comdddd', 'AUTO', 0, 254, '2016-12-07 17:48:05', NULL, 1, NULL, 255),
	(282, 'bidder7@mail.com', 'bidderseven', 'indiaovtltd', 'ahmedabad', 1, 1, 'ahmedabad', '8905221921', '9876543456', 'www.cahoot.co.in', 'car56456', 0, 280, '2016-12-08 06:19:25', '2016-12-08 06:19:25', 1, 1, 281),
	(293, 'bidder3@mail.com', 'bidder three', 'AON', 'abad', 1, 1, 'abad', '78965412', '411512', 'www.cahoot.co.in', 'test', 0, 291, '2016-12-08 08:46:25', NULL, 1, NULL, 292),
	(296, 'b1@mail.com', 'b one', 'AON', 'abadgggg', 1, 1, 'abad', '111111', '2222222', 'www.test.com', 'test', 0, 294, '2016-12-21 17:16:05', '2016-12-21 17:16:05', 1, 1, 295),
	(301, 'b2@mail.com', 'Bidder two', 'Cahoot Tech', 'abad', 1, 1, 'abad', '7896415', '78414534', 'www.cahoot.co.in', 'test', 0, 299, '2016-12-08 11:33:31', NULL, 1, NULL, 300),
	(846, 'b12@mail.com', 'bonetwo', 'jjsdf', 'sdfds', 1, 1, 'dfg', '3453', '5464564', 'www.cahoot.co.in', 'dfgd', 0, 844, '2016-12-21 16:32:42', NULL, 1, NULL, 845),
	(890, 'bidder44@mail.com', 'Bidder fourty four', 'Bidder', 'Ahm', 1, 1, 'Ahm', '999999', '9999999999', 'www.abcdefghijklm.com', 'Civil works', 0, 888, '2016-12-22 07:03:21', NULL, 1, NULL, 889),
	(895, 'blipi@mail.com', 'blipi', 'C-Lipi', 'abad', 1, 1, 'abad', '123456789', '45687455656', 'www.ca.co.in', 'test', 0, 893, '2016-12-22 09:50:13', '2016-12-22 09:50:13', 1, 1, 894),
	(910, 'bidder45@mail.com', 'biidewrfou', 'BiDF', 'abac', 1, 1, 'abs', '784654787', '484', 'www.ca.co.in', 'test', 0, 908, '2016-12-22 11:53:50', '2016-12-22 11:53:50', 1, 1, 909),
	(922, 'biddertest@mail.com', 'Test Bidder', 'Test bidder', 'Ahm', 1, 1, 'Ahmedabad', '9999999999', '9999999999', '', '', 0, 920, '2016-12-26 20:49:24', NULL, 1, NULL, 921),
	(944, 'testbidder@gmail.com', 'aspirine', 'aspirine', 'aspirine', 1, 1, 'ahmedabad', '8956231245', '8956231245', 'www.aon.co', 'car', 0, 942, '2016-12-26 21:58:07', NULL, 1, NULL, 943);
/*!40000 ALTER TABLE `tbl_bidder` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_bidderapprovaldetail
DROP TABLE IF EXISTS `tbl_bidderapprovaldetail`;
CREATE TABLE IF NOT EXISTS `tbl_bidderapprovaldetail` (
  `bidderApprovalId` int(11) NOT NULL AUTO_INCREMENT,
  `createdBy` int(11) NOT NULL,
  `createdOn` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
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
  CONSTRAINT `FK_tbl_bidderapprovaldetail_tender` FOREIGN KEY (`tenderid`) REFERENCES `tbl_tender` (`tenderId`),
  CONSTRAINT `FKagklumqrp1kw34lp6buvo4jo7` FOREIGN KEY (`finalSubmissionId`) REFERENCES `tbl_finalsubmission` (`finalSubmissionId`),
  CONSTRAINT `FKexr7bhp4awb4wyyhxc84j6y6j` FOREIGN KEY (`envelopeid`) REFERENCES `tbl_tenderenvelope` (`envelopeId`)
) ENGINE=InnoDB AUTO_INCREMENT=957 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_bidderapprovaldetail: ~18 rows (approximately)
/*!40000 ALTER TABLE `tbl_bidderapprovaldetail` DISABLE KEYS */;
INSERT INTO `tbl_bidderapprovaldetail` (`bidderApprovalId`, `createdBy`, `createdOn`, `isApproved`, `remarks`, `companyid`, `finalSubmissionId`, `tenderid`, `envelopeid`, `bidderid`) VALUES
	(252, 2, '2016-12-07 12:16:23', 1, 'fghfgh', 1, 8, 3, 11, 9),
	(253, 2, '2016-12-07 12:27:37', 1, 'yrdy', 1, 9, 4, 12, 9),
	(273, 4, '2016-12-07 18:52:13', 1, 'Approved', 1, 10, 10, 13, 9),
	(288, 2, '2016-12-08 06:45:04', 1, 'fghfgh', 1, 11, 5, 7, 256),
	(289, 1, '2016-12-08 07:50:39', 1, 'approved', 1, 12, 13, 16, 256),
	(290, 1, '2016-12-08 07:50:39', 0, 'rejected', 281, 13, 13, 16, 282),
	(297, 2, '2016-12-08 09:25:19', 0, 'tredt', 295, 14, 14, 17, 296),
	(298, 2, '2016-12-08 09:25:19', 1, 'hkhu', 292, 15, 14, 17, 293),
	(376, 2, '2016-12-08 12:08:08', 1, 'test', 300, 16, 15, 18, 301),
	(377, 2, '2016-12-08 12:08:08', 0, 'test', 292, 17, 15, 18, 293),
	(891, 4, '2016-12-22 09:23:49', 1, 'test', 255, 18, 39, 56, 256),
	(915, 4, '2016-12-22 12:33:13', 1, 'test', 255, 20, 44, 61, 256),
	(951, 263, '2016-12-28 03:28:04', 1, 'Approved', 255, 23, 58, 80, 256),
	(952, 263, '2016-12-28 03:28:04', 0, 'Rejected', 921, 24, 58, 80, 922),
	(953, 263, '2016-12-28 03:28:57', 1, 'Apporved', 255, 23, 58, 81, 256),
	(954, 263, '2016-12-28 03:28:57', 1, NULL, 921, 24, 58, 81, 922),
	(955, 263, '2016-12-28 03:29:25', 1, 'Apporved', 255, 23, 58, 82, 256),
	(956, 263, '2016-12-28 03:29:25', 1, 'Rejected', 921, 24, 58, 82, 922);
/*!40000 ALTER TABLE `tbl_bidderapprovaldetail` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_bidderapprovalhistory
DROP TABLE IF EXISTS `tbl_bidderapprovalhistory`;
CREATE TABLE IF NOT EXISTS `tbl_bidderapprovalhistory` (
  `bidderApprovalHistoryId` int(11) NOT NULL AUTO_INCREMENT,
  `bidderId` int(11) NOT NULL,
  `companyId` int(11) NOT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `createdOn` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `envelopeId` int(11) NOT NULL,
  `finalSubmissionId` int(11) NOT NULL,
  `isApproved` int(11) DEFAULT NULL,
  `remarks` longtext,
  `tenderId` int(11) NOT NULL,
  PRIMARY KEY (`bidderApprovalHistoryId`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_bidderapprovalhistory: ~19 rows (approximately)
/*!40000 ALTER TABLE `tbl_bidderapprovalhistory` DISABLE KEYS */;
INSERT INTO `tbl_bidderapprovalhistory` (`bidderApprovalHistoryId`, `bidderId`, `companyId`, `createdBy`, `createdOn`, `envelopeId`, `finalSubmissionId`, `isApproved`, `remarks`, `tenderId`) VALUES
	(1, 9, 1, 235, '2016-12-07 11:26:54', 10, 1, 1, 'test', 2),
	(2, 9, 1, 2, '2016-12-07 12:16:23', 11, 8, 1, 'fghfgh', 3),
	(3, 9, 1, 2, '2016-12-07 12:27:37', 12, 9, 1, 'yrdy', 4),
	(4, 9, 1, 4, '2016-12-07 18:52:13', 13, 10, 1, 'Approved', 10),
	(5, 256, 1, 2, '2016-12-08 06:45:04', 7, 11, 1, 'fghfgh', 5),
	(6, 256, 1, 1, '2016-12-08 07:50:39', 16, 12, 1, 'approved', 13),
	(7, 282, 281, 1, '2016-12-08 07:50:40', 16, 13, 0, 'rejected', 13),
	(8, 296, 295, 2, '2016-12-08 09:25:19', 17, 14, 0, 'tredt', 14),
	(9, 293, 292, 2, '2016-12-08 09:25:19', 17, 15, 1, 'hkhu', 14),
	(10, 301, 300, 2, '2016-12-08 12:08:08', 18, 16, 1, 'test', 15),
	(11, 293, 292, 2, '2016-12-08 12:08:08', 18, 17, 0, 'test', 15),
	(12, 256, 255, 4, '2016-12-22 09:23:49', 56, 18, 1, 'test', 39),
	(13, 256, 255, 4, '2016-12-22 12:33:13', 61, 20, 1, 'test', 44),
	(14, 256, 255, 263, '2016-12-28 03:28:04', 80, 23, 1, 'Approved', 58),
	(15, 922, 921, 263, '2016-12-28 03:28:04', 80, 24, 0, 'Rejected', 58),
	(16, 256, 255, 263, '2016-12-28 03:28:57', 81, 23, 1, 'Apporved', 58),
	(17, 922, 921, 263, '2016-12-28 03:28:57', 81, 24, 1, NULL, 58),
	(18, 256, 255, 263, '2016-12-28 03:29:25', 82, 23, 1, 'Apporved', 58),
	(19, 922, 921, 263, '2016-12-28 03:29:25', 82, 24, 1, 'Rejected', 58);
/*!40000 ALTER TABLE `tbl_bidderapprovalhistory` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_biddetail
DROP TABLE IF EXISTS `tbl_biddetail`;
CREATE TABLE IF NOT EXISTS `tbl_biddetail` (
  `bidDetailId` int(11) NOT NULL AUTO_INCREMENT,
  `cellId` int(11) NOT NULL,
  `cellValue` longtext NOT NULL,
  `companyId` int(11) NOT NULL,
  `formId` int(11) NOT NULL,
  PRIMARY KEY (`bidDetailId`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_biddetail: ~80 rows (approximately)
/*!40000 ALTER TABLE `tbl_biddetail` DISABLE KEYS */;
INSERT INTO `tbl_biddetail` (`bidDetailId`, `cellId`, `cellValue`, `companyId`, `formId`) VALUES
	(29, 129, 'f', 255, 44),
	(30, 128, 't1', 255, 44),
	(31, 130, 'f', 255, 44),
	(32, 129, 'h', 255, 44),
	(33, 128, 't2', 255, 44),
	(34, 130, 't', 255, 44),
	(35, 135, 'r', 255, 47),
	(36, 134, 'a', 255, 47),
	(37, 136, 't', 255, 47),
	(38, 135, 'r', 255, 47),
	(39, 134, 'b', 255, 47),
	(40, 136, 't', 255, 47),
	(41, 136, 't', 255, 47),
	(42, 135, 'r', 255, 47),
	(43, 134, 'c', 255, 47),
	(44, 142, 'T1', 255, 49),
	(45, 141, 'Name1', 255, 49),
	(46, 143, 'T23', 255, 49),
	(47, 142, 'T11', 255, 49),
	(48, 141, 'Name2', 255, 49),
	(49, 143, 'T21', 255, 49),
	(50, 143, 'T24', 255, 49),
	(51, 142, 'T12', 255, 49),
	(52, 141, 'Name3', 255, 49),
	(61, 153, 'mca', 255, 52),
	(62, 154, 'lipi', 255, 52),
	(63, 155, 'bcom', 255, 52),
	(64, 156, 'name2', 255, 52),
	(65, 157, 'bca', 255, 52),
	(66, 158, 'name1', 255, 52),
	(67, 159, 'ba', 255, 52),
	(68, 160, 'name3', 255, 52),
	(69, 161, '10', 255, 53),
	(70, 162, 'item4', 255, 53),
	(71, 163, 'item1', 255, 53),
	(72, 164, '5', 255, 53),
	(73, 165, '5', 255, 53),
	(74, 166, '52', 255, 53),
	(75, 167, 'item2', 255, 53),
	(76, 168, '160', 255, 53),
	(77, 169, '20', 255, 53),
	(78, 170, '660', 255, 53),
	(79, 171, '15', 255, 53),
	(80, 172, '54', 255, 53),
	(81, 173, '1', 255, 53),
	(82, 174, 'item3', 255, 53),
	(83, 175, '2184', 255, 53),
	(84, 176, '52', 255, 53),
	(89, 205, 'aaa', 255, 62),
	(90, 206, 'a', 255, 62),
	(91, 207, 'bbbbbb', 255, 62),
	(92, 208, 'b', 255, 62),
	(93, 209, '4', 255, 63),
	(94, 210, 'i1', 255, 63),
	(95, 211, '42', 255, 63),
	(96, 212, '7', 255, 63),
	(97, 213, '5', 255, 63),
	(98, 214, 'i2', 255, 63),
	(99, 215, '20', 255, 63),
	(100, 216, '5', 255, 63),
	(101, 217, '6', 255, 63),
	(102, 218, 'i3', 255, 63),
	(103, 219, '30', 255, 63),
	(104, 220, '6', 255, 63),
	(105, 221, '2016-12-23', 921, 64),
	(106, 222, 'EMD Date', 921, 64),
	(107, 223, '4 GB RAM and 500 Gb Hard disk i3 Processor', 921, 65),
	(108, 224, 'Specifications of the product', 921, 65),
	(109, 225, '20', 921, 66),
	(110, 226, 'laptop', 921, 66),
	(111, 227, '800000', 921, 66),
	(112, 228, '50000', 921, 66),
	(113, 221, '2016-12-21', 255, 64),
	(114, 222, 'EMD Date', 255, 64),
	(115, 223, '8 GB RAM 1 TB hard disk i5 processor', 255, 65),
	(116, 224, 'Specifications of the product', 255, 65),
	(117, 225, '20', 255, 66),
	(118, 226, 'laptop', 255, 66),
	(119, 227, '960000', 255, 66),
	(120, 228, '60000', 255, 66);
/*!40000 ALTER TABLE `tbl_biddetail` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_bidwithdrawal
DROP TABLE IF EXISTS `tbl_bidwithdrawal`;
CREATE TABLE IF NOT EXISTS `tbl_bidwithdrawal` (
  `bidWithdrawalId` int(11) NOT NULL AUTO_INCREMENT,
  `createdBy` int(11) NOT NULL,
  `createdOn` datetime DEFAULT CURRENT_TIMESTAMP,
  `finalSubmissionDate` datetime NOT NULL,
  `finalSubmissionIPAddress` varchar(200) NOT NULL,
  `ipAddress` varchar(200) NOT NULL,
  `remark` varchar(200) NOT NULL,
  `companyId` int(11) NOT NULL,
  `tenderId` int(11) NOT NULL,
  `bidderId` int(11) NOT NULL,
  PRIMARY KEY (`bidWithdrawalId`),
  KEY `FK_tbl_bidwithdrawal_tender` (`tenderId`),
  KEY `FK_tbl_bidwithdrawal_company` (`companyId`),
  CONSTRAINT `FK_tbl_bidwithdrawal_company` FOREIGN KEY (`companyId`) REFERENCES `tbl_company` (`companyid`),
  CONSTRAINT `FK_tbl_bidwithdrawal_tender` FOREIGN KEY (`tenderId`) REFERENCES `tbl_tender` (`tenderId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_bidwithdrawal: ~0 rows (approximately)
/*!40000 ALTER TABLE `tbl_bidwithdrawal` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_bidwithdrawal` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_clientbidterm
DROP TABLE IF EXISTS `tbl_clientbidterm`;
CREATE TABLE IF NOT EXISTS `tbl_clientbidterm` (
  `clientBidTermId` int(11) NOT NULL AUTO_INCREMENT,
  `bidTerm` varchar(512) NOT NULL,
  `isActive` int(11) DEFAULT '0',
  PRIMARY KEY (`clientBidTermId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_clientbidterm: ~0 rows (approximately)
/*!40000 ALTER TABLE `tbl_clientbidterm` DISABLE KEYS */;
INSERT INTO `tbl_clientbidterm` (`clientBidTermId`, `bidTerm`, `isActive`) VALUES
	(1, 'We, hereby declare that, \n<br>&#8195;&#8195;1.&#8195;We have read, examined and understood the tender document pertaining to this tender notice and have no reservations to the same,. \n<br>&#8195;&#8195;2.&#8195;We offer to execute the works in conformity with the tender Documents \n<br>&#8195;&#8195;3.&#8195;Our bid shall be valid for a period as mentioned in the tender document and it shall remain binding upon us. \n<br>&#8195;&#8195;4.&#8195;We understand that you are not bound to accept the lowest evaluate', 1);
/*!40000 ALTER TABLE `tbl_clientbidterm` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_columntype
DROP TABLE IF EXISTS `tbl_columntype`;
CREATE TABLE IF NOT EXISTS `tbl_columntype` (
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

-- Dumping data for table eauctiontender.tbl_columntype: ~6 rows (approximately)
/*!40000 ALTER TABLE `tbl_columntype` DISABLE KEYS */;
INSERT INTO `tbl_columntype` (`columnTypeId`, `columnName`, `lang1`, `lang2`, `lang3`, `lang4`, `lang5`, `lang6`, `lang7`, `lang8`) VALUES
	(1, 'Item Description', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(2, 'Quantity', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(3, 'Unit Rate', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(4, 'Total Rate', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(5, 'Category', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(6, 'Others', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `tbl_columntype` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_committee
DROP TABLE IF EXISTS `tbl_committee`;
CREATE TABLE IF NOT EXISTS `tbl_committee` (
  `committeeId` int(11) NOT NULL AUTO_INCREMENT,
  `committeeName` varchar(30) NOT NULL,
  `committeeType` int(11) NOT NULL,
  `createdBy` int(11) NOT NULL,
  `createdOn` datetime NOT NULL DEFAULT '2016-11-08 17:46:36',
  `isActive` int(11) NOT NULL,
  `isApproved` int(11) NOT NULL,
  `isStandard` int(11) NOT NULL,
  `publishedBy` int(11) DEFAULT NULL,
  `publishedOn` datetime DEFAULT NULL,
  `remarks` longtext,
  `tenderId` int(11) DEFAULT NULL,
  PRIMARY KEY (`committeeId`),
  KEY `FK8dftvx6sg30oucx69y5h6ukyh` (`tenderId`),
  CONSTRAINT `FK8dftvx6sg30oucx69y5h6ukyh` FOREIGN KEY (`tenderId`) REFERENCES `tbl_tender` (`tenderId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_committee: ~87 rows (approximately)
/*!40000 ALTER TABLE `tbl_committee` DISABLE KEYS */;
INSERT INTO `tbl_committee` (`committeeId`, `committeeName`, `committeeType`, `createdBy`, `createdOn`, `isActive`, `isApproved`, `isStandard`, `publishedBy`, `publishedOn`, `remarks`, `tenderId`) VALUES
	(36, 'PrebidCommitte', 3, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 1),
	(37, 'Committee', 1, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 1),
	(38, 'Committee', 2, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 1),
	(39, 'PrebidCommitte', 3, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 1),
	(40, 'Committee', 1, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 1),
	(41, 'Committee', 1, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 1),
	(42, 'Committee', 2, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 1),
	(43, 'PrebidCommitte', 3, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 1),
	(44, 'PrebidCommitte', 3, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 1),
	(45, 'Committee', 1, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 1),
	(46, 'Committee', 2, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 1),
	(47, 'Committee', 1, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 2),
	(48, 'Committee', 2, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 2),
	(49, 'Committee', 1, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 3),
	(50, 'Committee', 2, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 2),
	(51, 'Committee', 2, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 3),
	(52, 'Committee', 1, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 4),
	(53, 'Committee', 2, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 4),
	(54, 'Committee', 1, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 10),
	(55, 'Committee', 1, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 10),
	(56, 'Committee', 1, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 10),
	(57, 'Committee', 1, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 10),
	(58, 'Committee', 2, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 10),
	(59, 'Committee', 1, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 10),
	(64, 'Committee', 1, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 11),
	(65, 'Committee', 2, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 11),
	(69, 'PrebidCommitte', 3, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 5),
	(70, 'Committee', 1, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 5),
	(71, 'Committee', 2, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 5),
	(72, 'PrebidCommitte', 3, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 12),
	(73, 'Committee', 1, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 12),
	(74, 'Committee', 2, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 12),
	(75, 'Committee', 1, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 13),
	(76, 'Committee', 2, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 13),
	(77, 'Committee', 1, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 14),
	(78, 'Committee', 2, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 14),
	(79, 'Committee', 1, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 15),
	(80, 'Committee', 2, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 15),
	(81, 'PrebidCommitte', 3, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 17),
	(82, 'Committee', 1, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 17),
	(83, 'Committee', 2, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 17),
	(84, 'Committee', 1, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 23),
	(85, 'Committee', 2, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 23),
	(86, 'PrebidCommitte', 3, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 1),
	(87, 'Committee', 1, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 27),
	(88, 'PrebidCommitte', 3, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 29),
	(89, 'Committee', 1, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 29),
	(90, 'Committee', 2, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 29),
	(91, 'Bid Opening committee', 1, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 30),
	(92, 'Bid Evaluation committee', 2, 263, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, NULL, 30),
	(93, 'PrebidCommitte', 3, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 30),
	(94, 'PrebidCommitte', 3, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 31),
	(95, 'PrebidCommitte', 3, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 32),
	(96, 'Bid Opening committee', 1, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 34),
	(97, 'Bid Evaluation committee', 2, 263, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, NULL, 34),
	(98, 'PrebidCommitte', 3, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 34),
	(99, 'Bid Opening committee', 1, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 35),
	(100, 'Bid Evaluation committee', 2, 263, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, NULL, 35),
	(101, 'PrebidCommitte', 3, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 35),
	(102, 'PrebidCommitte', 3, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 36),
	(103, 'Bid Opening committee', 1, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 36),
	(104, 'Bid Evaluation committee', 2, 263, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, NULL, 36),
	(105, 'Bid Opening committee', 1, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 37),
	(106, 'Bid Evaluation committee', 2, 263, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, NULL, 37),
	(107, 'Bid Opening committee', 1, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 38),
	(108, 'Bid Evaluation committee', 2, 4, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, NULL, 38),
	(109, 'Bid Opening committee', 1, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 39),
	(110, 'Bid Evaluation committee', 2, 4, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, NULL, 39),
	(111, 'Bid Opening committee', 1, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 41),
	(112, 'Bid Evaluation committee', 2, 4, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, NULL, 41),
	(113, 'Bid Opening committee', 1, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 44),
	(114, 'Bid Evaluation committee', 2, 4, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, NULL, 44),
	(115, 'Bid Opening committee', 1, 1, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 51),
	(116, 'Bid Evaluation committee', 2, 2, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, NULL, 51),
	(117, 'Bid Opening committee', 1, 4, '2016-11-08 17:46:36', 1, 1, 0, 0, NULL, '', 53),
	(118, 'Bid Evaluation committee', 2, 4, '2016-11-08 17:46:36', 1, 1, 0, 0, NULL, NULL, 53),
	(119, 'PrebidCommitte', 3, 1, '2016-11-08 17:46:36', 1, 1, 0, 0, NULL, '', 54),
	(120, 'Bid Opening committee', 1, 1, '2016-11-08 17:46:36', 1, 1, 0, 0, NULL, '', 54),
	(121, 'Bid Evaluation committee', 2, 932, '2016-11-08 17:46:36', 1, 1, 0, 0, NULL, NULL, 54),
	(122, 'PrebidCommitte', 3, 1, '2016-11-08 17:46:36', 1, 1, 0, 0, NULL, '', 53),
	(123, 'Bid Opening committee', 1, 1, '2016-11-08 17:46:36', 1, 1, 0, 0, NULL, '', 55),
	(124, 'Bid Evaluation committee', 2, 263, '2016-11-08 17:46:36', 1, 1, 0, 0, NULL, NULL, 55),
	(125, 'Bid Opening committee', 1, 1, '2016-11-08 17:46:36', 1, 1, 0, 0, NULL, '', 57),
	(126, 'Bid Evaluation committee', 2, 2, '2016-11-08 17:46:36', 1, 1, 0, 0, NULL, NULL, 57),
	(127, 'PrebidCommitte', 3, 1, '2016-11-08 17:46:36', 1, 1, 0, 0, NULL, '', 58),
	(128, 'Bid Opening committee', 1, 1, '2016-11-08 17:46:36', 1, 1, 0, 0, NULL, '', 58),
	(129, 'Bid Evaluation committee', 2, 263, '2016-11-08 17:46:36', 1, 1, 0, 0, NULL, NULL, 58),
	(130, 'PrebidCommitte', 3, 263, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 59),
	(131, 'Bid Opening committee', 1, 263, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, '', 59),
	(132, 'Bid Evaluation committee', 2, 263, '2016-11-08 17:46:36', 1, 0, 0, 0, NULL, NULL, 59);
/*!40000 ALTER TABLE `tbl_committee` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_committeeenvelope
DROP TABLE IF EXISTS `tbl_committeeenvelope`;
CREATE TABLE IF NOT EXISTS `tbl_committeeenvelope` (
  `committeeEnvelopeId` int(11) NOT NULL AUTO_INCREMENT,
  `minMemberApproval` int(11) NOT NULL,
  `committeeid` int(11) DEFAULT NULL,
  `envelopeid` int(11) DEFAULT NULL,
  PRIMARY KEY (`committeeEnvelopeId`),
  KEY `FK8vnubglekdv2qhno11gybxebh` (`envelopeid`),
  KEY `FKa8geya8pb0eqriw68cwdd3yc` (`committeeid`),
  CONSTRAINT `FK8vnubglekdv2qhno11gybxebh` FOREIGN KEY (`envelopeid`) REFERENCES `tbl_tenderenvelope` (`envelopeId`),
  CONSTRAINT `FKa8geya8pb0eqriw68cwdd3yc` FOREIGN KEY (`committeeid`) REFERENCES `tbl_committee` (`committeeId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=198 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_committeeenvelope: ~102 rows (approximately)
/*!40000 ALTER TABLE `tbl_committeeenvelope` DISABLE KEYS */;
INSERT INTO `tbl_committeeenvelope` (`committeeEnvelopeId`, `minMemberApproval`, `committeeid`, `envelopeid`) VALUES
	(63, 1, 37, 1),
	(64, 1, 37, 2),
	(65, 1, 38, 1),
	(66, 1, 38, 2),
	(69, 1, 40, 1),
	(70, 1, 40, 2),
	(73, 1, 41, 1),
	(74, 1, 41, 2),
	(75, 0, 42, 1),
	(76, 0, 42, 2),
	(77, 1, 45, 1),
	(78, 1, 45, 2),
	(79, 0, 46, 1),
	(80, 0, 46, 2),
	(82, 1, 47, 10),
	(84, 1, 48, 10),
	(85, 1, 49, 11),
	(86, 1, 50, 10),
	(87, 0, 51, 11),
	(88, 1, 52, 12),
	(89, 1, 53, 12),
	(90, 1, 54, 13),
	(91, 1, 55, 13),
	(92, 1, 56, 13),
	(93, 1, 57, 13),
	(95, 0, 58, 13),
	(96, 1, 59, 13),
	(103, 0, 65, 14),
	(106, 1, 64, 14),
	(111, 2, 70, 7),
	(112, 1, 71, 7),
	(113, 1, 73, 15),
	(114, 1, 74, 15),
	(115, 1, 75, 16),
	(116, 1, 76, 16),
	(117, 1, 77, 17),
	(118, 1, 78, 17),
	(119, 1, 79, 18),
	(120, 1, 80, 18),
	(121, 1, 82, 21),
	(122, 1, 82, 22),
	(123, 1, 83, 21),
	(124, 1, 83, 22),
	(125, 1, 84, 29),
	(126, 1, 85, 29),
	(127, 1, 87, 36),
	(128, 1, 89, 39),
	(129, 1, 89, 40),
	(130, 1, 90, 39),
	(131, 1, 90, 40),
	(132, 1, 91, 41),
	(133, 1, 91, 42),
	(134, 1, 92, 41),
	(135, 1, 92, 42),
	(140, 1, 96, 47),
	(141, 1, 96, 48),
	(142, 1, 97, 47),
	(143, 1, 97, 48),
	(148, 1, 99, 49),
	(149, 1, 99, 50),
	(150, 1, 100, 49),
	(151, 1, 100, 50),
	(152, 1, 103, 51),
	(153, 1, 103, 52),
	(154, 1, 104, 51),
	(155, 1, 104, 52),
	(156, 1, 105, 53),
	(157, 1, 106, 53),
	(158, 1, 107, 54),
	(159, 1, 107, 55),
	(160, 1, 108, 54),
	(161, 1, 108, 55),
	(164, 1, 109, 56),
	(165, 1, 110, 56),
	(166, 1, 111, 58),
	(167, 1, 112, 58),
	(168, 1, 113, 61),
	(169, 1, 114, 61),
	(170, 1, 115, 68),
	(171, 1, 115, 69),
	(172, 1, 116, 68),
	(173, 1, 116, 69),
	(177, 1, 120, 74),
	(179, 1, 121, 74),
	(180, 1, 123, 76),
	(181, 1, 124, 76),
	(182, 1, 125, 78),
	(183, 1, 125, 79),
	(184, 1, 126, 78),
	(185, 1, 126, 79),
	(186, 1, 128, 80),
	(187, 1, 128, 81),
	(188, 1, 128, 82),
	(189, 1, 129, 80),
	(190, 1, 129, 81),
	(191, 1, 129, 82),
	(192, 1, 131, 83),
	(193, 1, 131, 84),
	(194, 1, 131, 85),
	(195, 1, 132, 83),
	(196, 1, 132, 84),
	(197, 1, 132, 85);
/*!40000 ALTER TABLE `tbl_committeeenvelope` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_committeeuser
DROP TABLE IF EXISTS `tbl_committeeuser`;
CREATE TABLE IF NOT EXISTS `tbl_committeeuser` (
  `committeeUserId` int(11) NOT NULL AUTO_INCREMENT,
  `approvedBy` int(11) DEFAULT NULL,
  `approvedOn` datetime DEFAULT NULL,
  `childId` int(11) NOT NULL,
  `createdBy` int(11) NOT NULL,
  `createdOn` datetime NOT NULL DEFAULT '2016-11-08 17:46:36',
  `encryptionLevel` int(11) NOT NULL,
  `isApproved` int(11) NOT NULL,
  `isDecryptor` int(11) NOT NULL,
  `remarks` longtext,
  `userRoleId` int(11) DEFAULT NULL,
  `committeeid` int(11) DEFAULT NULL,
  `officerid` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`committeeUserId`),
  KEY `FK8j2ge5l95msnu230icjerrd4q` (`officerid`),
  KEY `FKmf5stuv3qdg1ijeptd6m7v4ay` (`committeeid`),
  CONSTRAINT `FK8j2ge5l95msnu230icjerrd4q` FOREIGN KEY (`officerid`) REFERENCES `tbl_officer` (`id`),
  CONSTRAINT `FKmf5stuv3qdg1ijeptd6m7v4ay` FOREIGN KEY (`committeeid`) REFERENCES `tbl_committee` (`committeeId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=251 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_committeeuser: ~196 rows (approximately)
/*!40000 ALTER TABLE `tbl_committeeuser` DISABLE KEYS */;
INSERT INTO `tbl_committeeuser` (`committeeUserId`, `approvedBy`, `approvedOn`, `childId`, `createdBy`, `createdOn`, `encryptionLevel`, `isApproved`, `isDecryptor`, `remarks`, `userRoleId`, `committeeid`, `officerid`) VALUES
	(3, 2, '2016-12-07 11:11:35', 10, 1, '2016-11-08 17:46:36', 0, 1, 0, '', 0, 47, 236),
	(4, 2, '2016-12-07 11:11:35', 10, 1, '2016-11-08 17:46:36', 0, 1, 0, 'test', 0, 47, 2),
	(7, 235, '2016-12-07 11:26:45', 10, 1, '2016-11-08 17:46:36', 0, 1, 0, 'test', 0, 48, 236),
	(8, 0, NULL, 10, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 48, 3),
	(9, 0, NULL, 10, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 48, 1),
	(10, 0, NULL, 11, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 49, 1),
	(11, 2, '2016-12-07 12:06:20', 11, 1, '2016-11-08 17:46:36', 0, 1, 0, 'test', 0, 49, 2),
	(12, 0, NULL, 10, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 50, 1),
	(13, 0, NULL, 10, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 50, 2),
	(14, 0, NULL, 11, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 51, 1),
	(15, 2, '2016-12-07 12:16:14', 11, 1, '2016-11-08 17:46:36', 0, 1, 0, 'dgfdg', 0, 51, 2),
	(16, 0, NULL, 12, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 52, 1),
	(17, 2, '2016-12-07 12:24:26', 12, 1, '2016-11-08 17:46:36', 0, 1, 0, 'dfgdf', 0, 52, 2),
	(18, 0, NULL, 12, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 53, 1),
	(19, 2, '2016-12-07 12:27:31', 12, 1, '2016-11-08 17:46:36', 0, 1, 0, 'dfg', 0, 53, 2),
	(20, 0, NULL, 13, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 54, 1),
	(21, 0, NULL, 13, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 55, 2),
	(22, 4, '2016-12-07 18:51:10', 13, 1, '2016-11-08 17:46:36', 0, 1, 0, 'test', 0, 56, 4),
	(23, 0, NULL, 13, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 56, 1),
	(24, 0, NULL, 13, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 57, 4),
	(27, 4, '2016-12-07 18:51:57', 13, 1, '2016-11-08 17:46:36', 0, 1, 0, 'test', 0, 58, 4),
	(28, 0, NULL, 13, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 59, 4),
	(39, 0, NULL, 14, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 65, 264),
	(40, 0, NULL, 14, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 65, 4),
	(44, 0, NULL, 14, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 64, 4),
	(45, 0, NULL, 14, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 64, 264),
	(60, 0, NULL, 0, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 69, 2),
	(61, 0, NULL, 0, 1, '2016-11-08 17:46:36', 1, 0, 0, '', 0, 69, 3),
	(62, 0, NULL, 0, 1, '2016-11-08 17:46:36', 2, 0, 0, '', 0, 69, 1),
	(63, 0, NULL, 7, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 70, 1),
	(64, 2, '2016-12-08 06:44:33', 7, 1, '2016-11-08 17:46:36', 0, 1, 0, 'dgdfg', 0, 70, 2),
	(65, 0, NULL, 7, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 70, 3),
	(66, 0, NULL, 7, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 70, 4),
	(67, 0, NULL, 7, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 71, 1),
	(68, 2, '2016-12-08 06:44:54', 7, 1, '2016-11-08 17:46:36', 0, 1, 0, 'fgh', 0, 71, 2),
	(69, 0, NULL, 7, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 71, 3),
	(70, 0, NULL, 7, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 71, 66),
	(71, 0, NULL, 0, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 72, 4),
	(72, 0, NULL, 15, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 73, 264),
	(73, 0, NULL, 15, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 74, 4),
	(74, 263, '2016-12-08 07:48:14', 16, 1, '2016-11-08 17:46:36', 0, 1, 0, 'sdfsdf', 0, 75, 264),
	(75, 1, '2016-12-08 07:50:24', 16, 1, '2016-11-08 17:46:36', 0, 1, 0, 'dfgdfg', 0, 76, 1),
	(76, 0, NULL, 17, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 77, 1),
	(77, 2, '2016-12-08 09:24:36', 17, 1, '2016-11-08 17:46:36', 0, 1, 0, 'gkjgkj', 0, 77, 2),
	(78, 2, '2016-12-08 09:24:59', 17, 1, '2016-11-08 17:46:36', 0, 1, 0, 'hjhkjh', 0, 78, 2),
	(79, 0, NULL, 17, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 78, 3),
	(80, 0, NULL, 18, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 79, 305),
	(81, 2, '2016-12-08 12:03:59', 18, 1, '2016-11-08 17:46:36', 0, 1, 0, 'test', 0, 79, 2),
	(82, 0, NULL, 18, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 79, 1),
	(83, 0, NULL, 18, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 80, 1),
	(84, 2, '2016-12-08 12:05:08', 18, 1, '2016-11-08 17:46:36', 0, 1, 0, 'test', 0, 80, 2),
	(85, 0, NULL, 0, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 81, 264),
	(86, 0, NULL, 21, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 82, 264),
	(87, 0, NULL, 22, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 82, 264),
	(88, 0, NULL, 21, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 83, 4),
	(89, 0, NULL, 22, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 83, 4),
	(90, 0, NULL, 29, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 84, 264),
	(91, 0, NULL, 29, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 85, 264),
	(92, 0, NULL, 0, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 86, 4),
	(93, 0, NULL, 36, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 87, 501),
	(94, 0, NULL, 0, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 88, 264),
	(95, 0, NULL, 39, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 89, 264),
	(96, 0, NULL, 40, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 89, 264),
	(97, 0, NULL, 39, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 89, 4),
	(98, 0, NULL, 40, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 89, 4),
	(99, 0, NULL, 39, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 90, 264),
	(100, 0, NULL, 40, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 90, 264),
	(101, 0, NULL, 39, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 90, 4),
	(102, 0, NULL, 40, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 90, 4),
	(103, 0, NULL, 41, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 91, 4),
	(104, 0, NULL, 42, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 91, 4),
	(105, 0, NULL, 41, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 91, 489),
	(106, 0, NULL, 42, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 91, 489),
	(107, 0, NULL, 41, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 92, 4),
	(108, 0, NULL, 42, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 92, 4),
	(109, 0, NULL, 41, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 92, 489),
	(110, 0, NULL, 42, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 92, 489),
	(111, 0, NULL, 0, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 93, 264),
	(112, 0, NULL, 0, 1, '2016-11-08 17:46:36', 1, 0, 0, '', 0, 93, 489),
	(113, 0, NULL, 0, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 94, 1),
	(114, 0, NULL, 0, 1, '2016-11-08 17:46:36', 1, 0, 0, '', 0, 94, 4),
	(115, 0, NULL, 0, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 95, 264),
	(124, 0, NULL, 0, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 98, 264),
	(125, 0, NULL, 0, 1, '2016-11-08 17:46:36', 1, 0, 0, '', 0, 98, 856),
	(126, 0, NULL, 47, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 96, 264),
	(127, 0, NULL, 48, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 96, 264),
	(128, 0, NULL, 47, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 96, 4),
	(129, 0, NULL, 48, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 96, 4),
	(130, 0, NULL, 47, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 96, 856),
	(131, 0, NULL, 48, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 96, 856),
	(132, 0, NULL, 47, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 97, 4),
	(133, 0, NULL, 48, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 97, 4),
	(134, 0, NULL, 47, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 97, 264),
	(135, 0, NULL, 48, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 97, 264),
	(136, 0, NULL, 47, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 97, 856),
	(137, 0, NULL, 48, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 97, 856),
	(143, 0, NULL, 0, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 101, 856),
	(144, 0, NULL, 0, 1, '2016-11-08 17:46:36', 1, 0, 0, '', 0, 101, 264),
	(145, 0, NULL, 49, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 99, 264),
	(146, 0, NULL, 50, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 99, 264),
	(147, 0, NULL, 49, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 99, 856),
	(148, 0, NULL, 50, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 99, 856),
	(149, 0, NULL, 49, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 100, 264),
	(150, 0, NULL, 50, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 100, 264),
	(151, 0, NULL, 49, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 100, 856),
	(152, 0, NULL, 50, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 100, 856),
	(153, 0, NULL, 0, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 102, 264),
	(154, 0, NULL, 51, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 103, 264),
	(155, 0, NULL, 52, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 103, 264),
	(156, 0, NULL, 51, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 103, 4),
	(157, 0, NULL, 52, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 103, 4),
	(158, 0, NULL, 51, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 104, 264),
	(159, 0, NULL, 52, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 104, 264),
	(160, 0, NULL, 51, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 104, 4),
	(161, 0, NULL, 52, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 104, 4),
	(162, 0, NULL, 53, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 105, 264),
	(163, 0, NULL, 53, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 105, 856),
	(164, 0, NULL, 53, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 106, 264),
	(165, 0, NULL, 53, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 106, 856),
	(166, 0, NULL, 54, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 107, 2),
	(167, 0, NULL, 55, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 107, 2),
	(168, 0, NULL, 54, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 107, 382),
	(169, 0, NULL, 55, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 107, 382),
	(170, 0, NULL, 54, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 107, 4),
	(171, 0, NULL, 55, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 107, 4),
	(172, 0, NULL, 54, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 108, 2),
	(173, 0, NULL, 55, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 108, 2),
	(174, 0, NULL, 54, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 108, 382),
	(175, 0, NULL, 55, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 108, 382),
	(176, 0, NULL, 54, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 108, 4),
	(177, 0, NULL, 55, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 108, 4),
	(182, 0, NULL, 56, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 109, 1),
	(183, 0, NULL, 56, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 109, 2),
	(184, 4, '2016-12-22 09:23:02', 56, 1, '2016-11-08 17:46:36', 0, 1, 0, 'test', 0, 109, 4),
	(185, 0, NULL, 56, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 110, 2),
	(186, 0, NULL, 56, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 110, 1),
	(187, 4, '2016-12-22 09:23:41', 56, 1, '2016-11-08 17:46:36', 0, 1, 0, 'dfg', 0, 110, 4),
	(188, 0, NULL, 58, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 111, 4),
	(189, 0, NULL, 58, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 112, 4),
	(190, 4, '2016-12-22 12:32:36', 61, 1, '2016-11-08 17:46:36', 0, 1, 0, 'Test opening consent', 0, 113, 4),
	(191, 0, NULL, 61, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 113, 3),
	(192, 4, '2016-12-22 12:33:04', 61, 1, '2016-11-08 17:46:36', 0, 1, 0, 'Tender evaluation consent', 0, 114, 4),
	(193, 0, NULL, 61, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 114, 3),
	(194, 4, '2016-12-26 13:43:42', 68, 1, '2016-11-08 17:46:36', 0, 1, 0, 'test', 0, 115, 4),
	(195, 4, '2016-12-26 13:56:36', 69, 1, '2016-11-08 17:46:36', 0, 1, 0, 'dfgdfgdfg', 0, 115, 4),
	(196, 0, NULL, 68, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 115, 3),
	(197, 0, NULL, 69, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 115, 3),
	(198, 0, NULL, 68, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 116, 4),
	(199, 0, NULL, 69, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 116, 4),
	(200, 0, NULL, 68, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 116, 3),
	(201, 0, NULL, 69, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 116, 3),
	(202, 4, '2016-12-22 12:32:36', 61, 4, '2016-11-08 17:46:36', 0, 1, 0, 'Test opening consent', 0, 117, 4),
	(203, 0, NULL, 61, 4, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 117, 3),
	(204, 4, '2016-12-22 12:33:04', 61, 4, '2016-11-08 17:46:36', 0, 1, 0, 'Tender evaluation consent', 0, 118, 4),
	(205, 0, NULL, 61, 4, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 118, 3),
	(206, 0, NULL, 0, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 119, 264),
	(207, 0, NULL, 0, 1, '2016-11-08 17:46:36', 1, 0, 0, '', 0, 119, 933),
	(209, 0, NULL, 74, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 120, 264),
	(211, 0, NULL, 74, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 120, 933),
	(213, 0, NULL, 74, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 121, 264),
	(215, 0, NULL, 74, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 121, 933),
	(216, 0, NULL, 0, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 122, 264),
	(217, 0, NULL, 76, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 123, 933),
	(218, 0, NULL, 76, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 124, 933),
	(219, 0, NULL, 78, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 125, 2),
	(220, 0, NULL, 79, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 125, 2),
	(221, 0, NULL, 78, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 126, 2),
	(222, 0, NULL, 79, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 126, 2),
	(223, 0, NULL, 0, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 127, 264),
	(224, 0, NULL, 0, 1, '2016-11-08 17:46:36', 1, 0, 0, '', 0, 127, 933),
	(225, 263, '2016-12-28 03:24:44', 80, 1, '2016-11-08 17:46:36', 0, 1, 0, 'test', 0, 128, 264),
	(226, 263, '2016-12-28 03:26:01', 81, 1, '2016-11-08 17:46:36', 0, 1, 0, 'Proceed', 0, 128, 264),
	(227, 263, '2016-12-28 03:26:26', 82, 1, '2016-11-08 17:46:36', 0, 1, 0, 'proceed', 0, 128, 264),
	(228, 0, NULL, 80, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 128, 933),
	(229, 0, NULL, 81, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 128, 933),
	(230, 0, NULL, 82, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 128, 933),
	(231, 263, '2016-12-28 03:27:44', 80, 1, '2016-11-08 17:46:36', 0, 1, 0, 'test', 0, 129, 264),
	(232, 263, '2016-12-28 03:28:24', 81, 1, '2016-11-08 17:46:36', 0, 1, 0, 'proceed', 0, 129, 264),
	(233, 263, '2016-12-28 03:29:09', 82, 1, '2016-11-08 17:46:36', 0, 1, 0, 'proceed', 0, 129, 264),
	(234, 0, NULL, 80, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 129, 933),
	(235, 0, NULL, 81, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 129, 933),
	(236, 0, NULL, 82, 1, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 129, 933),
	(237, 0, NULL, 0, 263, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 130, 264),
	(238, 0, NULL, 0, 263, '2016-11-08 17:46:36', 1, 0, 0, '', 0, 130, 933),
	(239, 263, '2016-12-28 03:24:44', 80, 263, '2016-11-08 17:46:36', 0, 1, 0, 'test', 0, 131, 264),
	(240, 0, NULL, 80, 263, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 131, 933),
	(241, 263, '2016-12-28 03:26:01', 81, 263, '2016-11-08 17:46:36', 0, 1, 0, 'Proceed', 0, 131, 264),
	(242, 0, NULL, 81, 263, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 131, 933),
	(243, 263, '2016-12-28 03:26:26', 82, 263, '2016-11-08 17:46:36', 0, 1, 0, 'proceed', 0, 131, 264),
	(244, 0, NULL, 82, 263, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 131, 933),
	(245, 263, '2016-12-28 03:27:44', 80, 263, '2016-11-08 17:46:36', 0, 1, 0, 'test', 0, 132, 264),
	(246, 0, NULL, 80, 263, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 132, 933),
	(247, 263, '2016-12-28 03:28:24', 81, 263, '2016-11-08 17:46:36', 0, 1, 0, 'proceed', 0, 132, 264),
	(248, 0, NULL, 81, 263, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 132, 933),
	(249, 263, '2016-12-28 03:29:09', 82, 263, '2016-11-08 17:46:36', 0, 1, 0, 'proceed', 0, 132, 264),
	(250, 0, NULL, 82, 263, '2016-11-08 17:46:36', 0, 0, 0, '', 0, 132, 933);
/*!40000 ALTER TABLE `tbl_committeeuser` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_commonlisting
DROP TABLE IF EXISTS `tbl_commonlisting`;
CREATE TABLE IF NOT EXISTS `tbl_commonlisting` (
  `listingId` int(11) NOT NULL AUTO_INCREMENT,
  `actionItem` varchar(255) DEFAULT NULL,
  `columnName` varchar(2000) DEFAULT NULL,
  `commonAction` varchar(255) DEFAULT NULL,
  `discription` varchar(255) DEFAULT NULL,
  `fromClause` varchar(255) DEFAULT NULL,
  `isHQL` bit(1) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `srnoCol` tinyint(2) DEFAULT '1',
  PRIMARY KEY (`listingId`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_commonlisting: ~14 rows (approximately)
/*!40000 ALTER TABLE `tbl_commonlisting` DISABLE KEYS */;
INSERT INTO `tbl_commonlisting` (`listingId`, `actionItem`, `columnName`, `commonAction`, `discription`, `fromClause`, `isHQL`, `status`, `srnoCol`) VALUES
	(1, 'edit,view,dashboard', 'tenderId:Event Id.:1,tenderNo:Tender No.:1,tenderBrief:Tender Brief:1,keywordText:Keyword:1,submissionStartDate:Start Date:1,submissionEndDate:End Date:1,openingDate:Opening Date:1', NULL, NULL, 'from tbl_tender where 1=1 and cstatus = 0', b'0', 1, 1),
	(2, 'edit', 'deptName:Department name:1,deptId:deptId:0,address:Address:1', 'Edit', NULL, 'from tbl_department where 1=1', b'0', 1, 1),
	(3, 'edit', 'designationName:Designation name:1,designationId:designationId:0,deptName:Department:1', 'Edit', NULL, 'from tbl_designation inner join tbl_department on tbl_department.deptId=tbl_designation.deptId where 1=1', b'0', 1, 1),
	(4, 'View,Dashboard', 'tenderId:Event Id.:1,tenderNo:Tender No.:1,tenderBrief:Tender Brief:1,keywordText:Keyword:1,submissionStartDate:Start Date:1,submissionEndDate:End Date:1,openingDate:Opening Date:1,corrigendumCount:Corrigendum:1', NULL, 'Future Tender', 'from tbl_tender where cstatus = 1 and submissionStartDate>now()', b'0', 1, 1),
	(5, 'Edit,View,Dashboard', 'tenderId:Event Id.:1,tenderNo:Tender No.:1,tenderBrief:Tender Brief:1,keywordText:Keyword:1,submissionStartDate:Start Date:1,submissionEndDate:End Date:1,openingDate:Opening Date:1,corrigendumCount:Corrigendum:1', NULL, 'Archive Tender', 'from tbl_tender where cstatus = 1 and submissionEndDate<now()', b'0', 1, 1),
	(6, 'View,Dashboard', 'tenderId:Event Id.:1,tenderNo:Tender No.:1,tenderBrief:Tender Brief:1,keywordText:Keyword:1,submissionStartDate:Start Date:1,submissionEndDate:End Date:1,openingDate:Opening Date:1,corrigendumCount:Corrigendum:1', NULL, 'Live Tender', 'from tbl_tender where cstatus = 1 and submissionStartDate<now() and submissionEndDate>now()', b'0', 1, 1),
	(7, 'edit', 'officername:Name:1,emailid:emailId:1,id:officerId:0,mobileno:mobileNo:1,b.deptName:Department:1,c.designationName:Designation:1', '2', NULL, 'from tbl_officer a inner join tbl_department b on a.deptId=b.deptId inner join tbl_designation c on c.designationId=a.designationId where 1=1', NULL, 1, 1),
	(8, 'edit', 'personName:Name:1,emailId:emailId:1,address:address:1,bidderId:bidderId:0,phoneNo:Phone No:1', '1', NULL, 'from tbl_bidder where 1=1', NULL, 1, 1),
	(9, 'edit', 'linkName:Link name:1,linkId:linkId:0,link:URL:1', 'Edit', NULL, 'from tbl_link where 1=1', NULL, 1, 1),
	(10, 'View,Dashboard', 'tenderId:Event Id.:1,tenderNo:Tender No.:1,tenderDetail:Tender Detail:1', NULL, 'Bidder Live Tender', 'from tbl_tender where cstatus = 1 and submissionStartDate<now() and submissionEndDate>now()', b'0', 1, 1),
	(11, 'Process', 'tenderId:Event No.:1,(case when (corrigendumId <> 0) then \'Corrigendum\' else \'Notice & Document\' end) as workflowFor:Workflow for:1,(case when (action=1) then \'Forward for approval\'  when (action=2) then \'Approved\' when (action=3) then \'Rejected\' when (action=4) then \'Return\' end ) as action:Action taken:1,remarks:Remarks:1,createdDate:created Date:1,workflowId:workflowId:0,corrigendumId:corrigendumId:0', NULL, 'Pending workflow list', 'from tbl_tenderworkflow where cstatus =0', b'1', 1, 1),
	(12, 'View', 'tenderId:Event No.:1,(case when (corrigendumId <> 0) then \'Corrigendum\' else \'Notice & Document\' end) as workflowFor:Workflow for:1,(case when (action=1) then \'Forward for approval\'  when (action=2) then \'Approved\' when (action=3) then \'Rejected\' when (action=4) then \'Return\' end ) as action:Action taken:1,remarks:Remarks:1,createdDate:created Date:1,workflowId:workflowId:0,corrigendumId:corrigendumId:0', NULL, 'Pending workflow list', 'from tbl_tenderworkflow where 1=1', b'1', 1, 1),
	(13, 'View,Dashboard', 'tenderId:Event Id.:1,tenderNo:Tender No.:1,tenderDetail:Tender Detail:1', NULL, 'Bidder Archive Tender', 'from tbl_tender where cstatus = 1 and submissionEndDate<now()', b'0', 1, 1),
	(14, 'View,Dashboard', 'tenderId:Event Id.:1,tenderNo:Tender No.:1,tenderDetail:Tender Detail:1', NULL, 'Bidder Future Tender', 'from tbl_tender where cstatus = 1 and submissionStartDate>now()', b'0', 1, 1),
	(17, 'View,Dashboard', 'tenderId:Event Id.:1,tenderNo:Tender No.:1,tenderBrief:Tender Brief:1,keywordText:Keyword:1,submissionStartDate:Start Date:1,submissionEndDate:End Date:1,openingDate:Opening Date:1,corrigendumCount:Corrigendum:1', NULL, 'Cancel Tender', 'from tbl_tender where cstatus = 2', b'1', 1, 1),
	(18, 'View,Dashboard', 'tenderId:Event Id.:1,tenderNo:Tender No.:1,tenderBrief:Tender Brief:1,keywordText:Keyword:1,submissionStartDate:Start Date:1,submissionEndDate:End Date:1,openingDate:Opening Date:1,corrigendumCount:Corrigendum:1', NULL, 'All Tender', 'from tbl_tender where 1=1 ', b'1', 1, 1),
	(19, 'View', 'tenderId:Event Id.:1,tenderNo:Tender No.:1,tenderBrief:Tender Brief:1,keywordText:Keyword:1,submissionStartDate:Start Date:1,submissionEndDate:End Date:1,openingDate:Opening Date:1,corrigendumCount:Corrigendum:1', NULL, 'View Tender Before Login', 'from tbl_tender where cstatus = 1 and submissionStartDate<now() and submissionEndDate>now() and TenderMode = 1', b'1', 1, 1);
/*!40000 ALTER TABLE `tbl_commonlisting` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_company
DROP TABLE IF EXISTS `tbl_company`;
CREATE TABLE IF NOT EXISTS `tbl_company` (
  `companyid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Company Id PK',
  `companyName` longtext NOT NULL COMMENT 'Company Name',
  `createdBy` int(11) NOT NULL,
  `createdOn` datetime NOT NULL DEFAULT '2016-11-08 17:46:36',
  PRIMARY KEY (`companyid`)
) ENGINE=InnoDB AUTO_INCREMENT=944 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_company: ~9 rows (approximately)
/*!40000 ALTER TABLE `tbl_company` DISABLE KEYS */;
INSERT INTO `tbl_company` (`companyid`, `companyName`, `createdBy`, `createdOn`) VALUES
	(1, 'Cahoot', 1, '2016-11-08 17:46:36'),
	(2, 'Cahoot Pvt', 1, '2016-11-08 17:46:36'),
	(255, 'AON', 1, '2016-12-07 17:48:05'),
	(281, 'indiaovtltd', 1, '2016-12-08 06:19:25'),
	(292, 'AON', 1, '2016-12-08 08:46:25'),
	(295, 'AON', 1, '2016-12-21 17:16:05'),
	(300, 'Cahoot Tech', 1, '2016-12-08 11:33:31'),
	(845, 'jjsdf', 1, '2016-12-21 16:32:42'),
	(889, 'Bidder', 1, '2016-12-22 07:03:21'),
	(894, 'C-Lipi', 1, '2016-12-22 09:50:13'),
	(909, 'BiDF', 1, '2016-12-22 11:53:50'),
	(921, 'Test bidder', 1, '2016-12-26 20:49:24'),
	(943, 'aspirine', 1, '2016-12-26 21:58:07');
/*!40000 ALTER TABLE `tbl_company` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_consortium
DROP TABLE IF EXISTS `tbl_consortium`;
CREATE TABLE IF NOT EXISTS `tbl_consortium` (
  `consortiumId` int(11) NOT NULL AUTO_INCREMENT,
  `createdBy` int(11) NOT NULL,
  `createdOn` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deletedOn` datetime DEFAULT NULL,
  `isActive` int(11) NOT NULL,
  `tenderId` int(11) NOT NULL,
  `approvedOn` datetime DEFAULT NULL,
  PRIMARY KEY (`consortiumId`),
  KEY `FK_tbl_consortium_tender` (`tenderId`),
  CONSTRAINT `FK_tbl_consortium_tender` FOREIGN KEY (`tenderId`) REFERENCES `tbl_tender` (`tenderId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_consortium: ~0 rows (approximately)
/*!40000 ALTER TABLE `tbl_consortium` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_consortium` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_consortiumdetail
DROP TABLE IF EXISTS `tbl_consortiumdetail`;
CREATE TABLE IF NOT EXISTS `tbl_consortiumdetail` (
  `consortiumDetailId` int(11) NOT NULL AUTO_INCREMENT,
  `createdBy` int(11) NOT NULL,
  `createdOn` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cstatus` int(11) NOT NULL,
  `partnerStake` decimal(10,0) NOT NULL,
  `partnerType` int(11) NOT NULL,
  `rejectedOn` datetime DEFAULT NULL,
  `remarks` varchar(100) NOT NULL,
  `companyId` int(11) NOT NULL,
  `consortiumId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  PRIMARY KEY (`consortiumDetailId`),
  KEY `FK_tbl_consortiumdetail_consor` (`consortiumId`),
  KEY `FK_tbl_consortiumdetail_company` (`companyId`),
  CONSTRAINT `FK_tbl_consortiumdetail_company` FOREIGN KEY (`companyId`) REFERENCES `tbl_company` (`companyid`),
  CONSTRAINT `FK_tbl_consortiumdetail_consor` FOREIGN KEY (`consortiumId`) REFERENCES `tbl_consortium` (`consortiumId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_consortiumdetail: ~0 rows (approximately)
/*!40000 ALTER TABLE `tbl_consortiumdetail` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_consortiumdetail` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_corrigendum
DROP TABLE IF EXISTS `tbl_corrigendum`;
CREATE TABLE IF NOT EXISTS `tbl_corrigendum` (
  `corrigendumId` int(11) NOT NULL AUTO_INCREMENT,
  `corrigendumText` varchar(5000) DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `createdOn` datetime DEFAULT NULL,
  `cstatus` int(11) DEFAULT NULL,
  `objectId` int(11) DEFAULT NULL,
  `publishedBy` int(11) DEFAULT NULL,
  `publishedOn` datetime DEFAULT NULL,
  `remarks` longtext,
  `processid` int(11) DEFAULT NULL,
  PRIMARY KEY (`corrigendumId`),
  KEY `FKcx2y2wgl0pvbkts45q20tofkl` (`processid`),
  CONSTRAINT `FKcx2y2wgl0pvbkts45q20tofkl` FOREIGN KEY (`processid`) REFERENCES `tbl_process` (`processId`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_corrigendum: ~28 rows (approximately)
/*!40000 ALTER TABLE `tbl_corrigendum` DISABLE KEYS */;
INSERT INTO `tbl_corrigendum` (`corrigendumId`, `corrigendumText`, `createdBy`, `createdOn`, `cstatus`, `objectId`, `publishedBy`, `publishedOn`, `remarks`, `processid`) VALUES
	(1, '<p>test corrigendum11</p>', 0, NULL, 1, 2, 0, '2016-12-07 09:23:39', 'ttestest', 1),
	(2, '<p>test</p>', 2, '2016-12-07 09:15:20', 0, 6, 0, '2016-12-07 09:15:20', NULL, 1),
	(3, '<p>test 2</p>', 2, '2016-12-07 09:23:57', 1, 2, 0, '2016-12-07 09:25:29', 'bbcvfb', 1),
	(4, '<p>test</p>', 4, '2016-12-07 18:11:51', 1, 10, 0, '2016-12-07 18:13:35', 'test', 1),
	(5, '<p>test</p>', 0, NULL, 1, 10, 0, '2016-12-07 18:49:38', 'test', 1),
	(6, '<p>test</p>', 4, '2016-12-07 19:21:25', 1, 11, 0, '2016-12-07 19:26:48', 'test', 1),
	(7, '<p>test</p>', 263, '2016-12-08 03:05:22', 0, 12, 0, '2016-12-08 03:05:22', NULL, 1),
	(8, '<p>test</p>', 2, '2016-12-08 06:39:03', 1, 5, 0, '2016-12-08 06:39:46', 'gyjgy', 1),
	(9, '<p>test</p>', 2, '2016-12-08 11:53:05', 1, 15, 0, '2016-12-08 12:01:42', 'tewst 1ggg', 1),
	(10, '<p>Yezt</p>', 263, '2016-12-19 02:16:08', 0, 23, 0, '2016-12-19 02:16:08', NULL, 1),
	(11, '<p>Test</p>', 263, '2016-12-19 02:26:30', 1, 24, 0, '2016-12-19 02:34:43', '<p>Test</p>', 1),
	(12, '<p>Test</p>', 263, '2016-12-19 02:37:16', 0, 24, 0, '2016-12-19 02:37:16', NULL, 1),
	(13, '<p>test</p>', 263, '2016-12-21 15:32:34', 0, 30, 0, '2016-12-21 15:32:34', NULL, 1),
	(14, '<p>test</p>', 855, '2016-12-21 19:44:23', 1, 35, 0, '2016-12-21 19:45:53', '<p>test</p>', 1),
	(15, '<p>test1</p>', 4, '2016-12-22 12:18:26', 0, 44, 0, '2016-12-22 12:18:26', NULL, 1),
	(16, '<p>sda da</p>', 4, '2016-12-22 18:40:33', 1, 4, 0, '2016-12-22 18:41:25', '<p>publish</p>', 1),
	(17, '<p>scs</p>', 4, '2016-12-24 13:19:03', 0, 3, 0, '2016-12-24 13:19:03', NULL, 1),
	(18, '<p>test</p>', 263, '2016-12-25 17:15:05', 1, 46, 0, '2016-12-25 17:17:13', '<p>tesr</p>', 1),
	(19, '<p>test</p>', 263, '2016-12-25 17:20:00', 0, 46, 0, '2016-12-25 17:20:00', NULL, 1),
	(20, '<p>test</p>', 4, '2016-12-26 13:24:13', 1, 51, 0, '2016-12-26 15:57:37', '<p>test publish</p>', 1),
	(21, '<p>test</p>', 932, '2016-12-26 22:54:27', 1, 54, 0, '2016-12-26 22:55:41', '<p>tst</p>', 1),
	(22, '<p>dfbgf</p>', 932, '2016-12-26 22:58:36', 1, 54, 0, '2016-12-26 23:00:13', '<p>ghbgf</p>', 1),
	(23, '<p>hghgf</p>', 263, '2016-12-26 23:16:14', 0, 53, 0, '2016-12-26 23:16:14', NULL, 1),
	(24, '<p>gfggfh</p>', 932, '2016-12-26 23:24:55', 1, 55, 0, '2016-12-26 23:25:46', '<p>bnbnv</p>', 1),
	(25, '<p>tygjgh</p>', 263, '2016-12-26 23:26:43', 1, 55, 0, '2016-12-26 23:27:18', '<p>vvbvc</p>', 1),
	(26, '<p>ghgfhf</p>', 263, '2016-12-26 23:28:56', 0, 55, 0, '2016-12-26 23:28:56', NULL, 1),
	(27, '<p>test1</p>', 2, '2016-12-27 09:12:38', 1, 57, 0, '2016-12-27 09:13:06', '<p>test1</p>', 1),
	(28, '<p>Amendments in Cornsortium</p>', 932, '2016-12-28 03:19:05', 1, 58, 0, '2016-12-28 03:19:38', '<p>test</p>', 1),
	(29, '<p>extension</p>', 932, '2016-12-28 03:19:55', 1, 58, 0, '2016-12-28 03:20:33', '<p>test</p>', 1);
/*!40000 ALTER TABLE `tbl_corrigendum` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_corrigendumdetail
DROP TABLE IF EXISTS `tbl_corrigendumdetail`;
CREATE TABLE IF NOT EXISTS `tbl_corrigendumdetail` (
  `corrigendumDetailId` int(11) NOT NULL AUTO_INCREMENT,
  `actionType` int(11) DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `createdOn` datetime DEFAULT NULL,
  `fieldLabel` varchar(200) DEFAULT NULL,
  `fieldName` varchar(100) DEFAULT NULL,
  `newValue` varchar(100) DEFAULT NULL,
  `objectId` int(11) DEFAULT NULL,
  `oldValue` varchar(100) DEFAULT NULL,
  `corrigendumid` int(11) DEFAULT NULL,
  `processid` int(11) DEFAULT NULL,
  PRIMARY KEY (`corrigendumDetailId`),
  KEY `processid` (`processid`),
  KEY `corrigendumid` (`corrigendumid`),
  CONSTRAINT `tbl_corrigendumdetail_ibfk_1` FOREIGN KEY (`processid`) REFERENCES `tbl_process` (`processId`),
  CONSTRAINT `tbl_corrigendumdetail_ibfk_2` FOREIGN KEY (`corrigendumid`) REFERENCES `tbl_corrigendum` (`corrigendumId`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_corrigendumdetail: ~40 rows (approximately)
/*!40000 ALTER TABLE `tbl_corrigendumdetail` DISABLE KEYS */;
INSERT INTO `tbl_corrigendumdetail` (`corrigendumDetailId`, `actionType`, `createdBy`, `createdOn`, `fieldLabel`, `fieldName`, `newValue`, `objectId`, `oldValue`, `corrigendumid`, `processid`) VALUES
	(4, 2, 0, '2016-12-07 09:16:00', 'field_bidopeningstartdate', 'openingDate', '2016-12-25 16:53:00', 6, '2016-12-24 16:53:00.0', 2, 1),
	(5, 2, 0, '2016-12-07 09:16:00', 'fields_fees_amt', 'isDocfeesApplicable', 'label_notrequired::0', 6, 'label_eventwise::1', 2, 1),
	(6, 2, 0, '2016-12-07 09:16:00', 'lbl_security_fee', 'isSecurityfeesApplicable', 'label_dontallow::0', 6, 'label_allow::1', 2, 1),
	(7, 2, 0, '2016-12-07 09:16:00', 'lbl_emd_fee', 'isEMDApplicable', 'label_notrequired::0', 6, 'label_eventwise::1', 2, 1),
	(8, 2, 0, '2016-12-07 09:22:51', 'fields_fees_amt', 'isDocfeesApplicable', 'label_eventwise::1', 2, 'label_notrequired::0', 1, 1),
	(9, 2, 0, '2016-12-07 09:22:51', 'fields_fees_amt', 'documentFee', '12.00', 2, '-', 1, 1),
	(10, 2, 0, '2016-12-07 09:22:51', 'field_docfees_payableat', 'docFeePaymentAddress', 'ssada d', 2, '', 1, 1),
	(11, 2, 0, '2016-12-07 09:22:51', 'fields_tender_keywords', 'keywordText', 'new tendernew tender 454545', 2, 'new tendernew tender', 1, 1),
	(12, 2, 0, '2016-12-07 09:24:10', 'fields_tender_keywords', 'keywordText', 'new tendernew tender key', 2, 'new tendernew tender 454545', 3, 1),
	(15, 2, 0, '2016-12-07 18:13:23', 'field_bidsubmissionenddate', 'submissionEndDate', '2016-12-07 23:46:00', 10, '2016-12-08 21:36:00.0', 4, 1),
	(16, 2, 0, '2016-12-07 18:13:23', 'field_bidopeningstartdate', 'openingDate', '2016-12-07 23:47:00', 10, '2016-12-08 22:00:00.0', 4, 1),
	(17, 2, 0, '2016-12-07 18:49:24', 'field_bidsubmissionenddate', 'submissionEndDate', '2016-12-07 18:46:00', 10, '2016-12-07 23:46:00.0', 5, 1),
	(18, 2, 0, '2016-12-07 18:49:24', 'field_bidopeningstartdate', 'openingDate', '2016-12-07 18:47:00', 10, '2016-12-07 23:47:00.0', 5, 1),
	(19, 2, 0, '2016-12-07 19:21:43', 'field_emdamt', 'emdAmount', '12345.00', 11, '1234.00', 6, 1),
	(20, 2, 0, '2016-12-08 03:06:25', 'field_bidsubmissionenddate', 'submissionEndDate', '2016-12-08 08:38:00', 12, '2016-12-08 04:25:00.0', 7, 1),
	(21, 2, 0, '2016-12-08 03:06:25', 'field_bidopeningstartdate', 'openingDate', '2016-12-08 08:39:00', 12, '2016-12-08 04:26:00.0', 7, 1),
	(22, 2, 0, '2016-12-08 03:06:25', 'field_emdamt', 'emdAmount', '10000.00', 12, '1000.00', 7, 1),
	(23, 2, 0, '2016-12-08 06:39:32', 'field_tender_detail', 'tenderDetail', 'new tendernew tender 67', 5, 'new tendernew tender', 8, 1),
	(24, 2, 0, '2016-12-08 11:53:20', 'field_tender_detail', 'tenderDetail', '<p>details&nbsp;</p>', 15, '<p>dl&#8195;</p>', 9, 1),
	(25, 2, 263, '2016-12-21 15:34:12', 'lbl_document_end_date', 'documentEndDate', '2016-12-22 03:40:00', 30, '2016-12-22 03:10:00.0', 13, 1),
	(26, 2, 263, '2016-12-21 15:34:12', 'field_bidsubmissionenddate', 'submissionEndDate', '2016-12-22 03:40:00', 30, '2016-12-22 03:10:00.0', 13, 1),
	(27, 2, 263, '2016-12-21 15:34:12', 'field_bidopeningstartdate', 'openingDate', '2016-12-22 03:41:00', 30, '2016-12-22 03:11:00.0', 13, 1),
	(28, 2, 263, '2016-12-21 15:34:12', 'lbl_emd_paymentMode', 'emdPaymentMode', 'label_offline::2', 30, '-', 13, 1),
	(29, 2, 263, '2016-12-21 15:34:12', 'field_emdpaymentat', 'emdPaymentAddress', 'test', 30, '', 13, 1),
	(31, 2, 855, '2016-12-21 19:45:09', 'field_bidsubmissionenddate', 'submissionEndDate', '2016-12-22 01:04:00', 35, '2016-12-22 01:05:00.0', 14, 1),
	(32, 2, 855, '2016-12-21 19:45:09', 'field_emdamt', 'emdAmount', '123.00', 35, '54.00', 14, 1),
	(37, 2, 4, '2016-12-22 18:41:09', 'field_tender_detail', 'tenderDetail', 'new tendernew tender this.', 4, 'new tendernew tender', 16, 1),
	(38, 2, 4, '2016-12-24 13:17:37', 'field_bidsubmissionenddate', 'submissionEndDate', '2016-12-23 12:30:00', 44, '2016-12-22 12:30:58.0', 15, 1),
	(39, 2, 4, '2016-12-24 13:17:37', 'field_bidopeningstartdate', 'openingDate', '2016-12-23 12:31:00', 44, '2016-12-22 12:31:58.0', 15, 1),
	(40, 2, 4, '2016-12-24 13:19:12', 'fields_refenceno', 'tenderNo', 'new tender 3', 3, 'new tender 3\r\n', 17, 1),
	(41, 2, 263, '2016-12-25 17:15:31', 'lbl_document_end_date', 'documentEndDate', '2016-12-28 16:00:00', 46, '2016-12-28 17:00:00.0', 18, 1),
	(42, 2, 263, '2016-12-25 17:15:31', 'field_bidsubmissionenddate', 'submissionEndDate', '2016-12-28 16:00:00', 46, '2016-12-28 17:00:00.0', 18, 1),
	(43, 2, 4, '2016-12-26 13:24:52', 'field_bidsubmissionenddate', 'submissionEndDate', '2016-12-26 01:30:00', 51, '2016-12-26 01:25:00.0', 20, 1),
	(44, 2, 4, '2016-12-26 13:24:52', 'field_bidopeningstartdate', 'openingDate', '2016-12-26 01:31:00', 51, '2016-12-26 01:26:00.0', 20, 1),
	(45, 2, 932, '2016-12-26 22:55:26', 'field_bidsubmissionenddate', 'submissionEndDate', '2016-12-26 11:58:00', 54, '2016-12-26 10:58:00.0', 21, 1),
	(46, 2, 932, '2016-12-26 22:55:26', 'field_bidopeningstartdate', 'openingDate', '2016-12-26 11:59:00', 54, '2016-12-26 10:59:00.0', 21, 1),
	(47, 2, 932, '2016-12-26 22:59:55', 'field_bidsubmissionenddate', 'submissionEndDate', '2016-12-27 04:58:00', 54, '2016-12-26 11:58:00.0', 22, 1),
	(48, 2, 932, '2016-12-26 22:59:55', 'field_bidopeningstartdate', 'openingDate', '2016-12-27 04:59:00', 54, '2016-12-26 11:59:00.0', 22, 1),
	(49, 2, 932, '2016-12-26 23:25:34', 'field_bidsubmissionenddate', 'submissionEndDate', '2016-12-26 12:00:00', 55, '2016-12-26 11:28:00.0', 24, 1),
	(50, 2, 932, '2016-12-26 23:25:35', 'field_bidopeningstartdate', 'openingDate', '2016-12-26 12:01:00', 55, '2016-12-26 11:29:00.0', 24, 1),
	(51, 2, 263, '2016-12-26 23:27:07', 'field_bidsubmissionenddate', 'submissionEndDate', '2016-12-27 16:00:00', 55, '2016-12-26 12:00:00.0', 25, 1),
	(52, 2, 263, '2016-12-26 23:27:07', 'field_bidopeningstartdate', 'openingDate', '2016-12-27 16:00:00', 55, '2016-12-26 12:01:00.0', 25, 1),
	(53, 2, 2, '2016-12-27 09:12:57', 'field_bidsubmissionenddate', 'submissionEndDate', '2016-12-27 09:20:00', 57, '2016-12-27 08:45:00.0', 27, 1),
	(54, 2, 2, '2016-12-27 09:12:57', 'field_bidopeningstartdate', 'openingDate', '2016-12-27 09:21:00', 57, '2016-12-27 08:46:00.0', 27, 1),
	(55, 2, 932, '2016-12-28 03:19:25', 'lbl_consortium', 'isConsortiumAllowed', 'label_dontallow::0', 58, 'label_allow::1', 28, 1),
	(56, 2, 932, '2016-12-28 03:20:23', 'field_bidsubmissionenddate', 'submissionEndDate', '2016-12-28 03:23:00', 58, '2016-12-28 03:19:00.0', 29, 1),
	(57, 2, 932, '2016-12-28 03:20:23', 'field_bidopeningstartdate', 'openingDate', '2016-12-28 03:24:00', 58, '2016-12-28 03:20:00.0', 29, 1);
/*!40000 ALTER TABLE `tbl_corrigendumdetail` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_country
DROP TABLE IF EXISTS `tbl_country`;
CREATE TABLE IF NOT EXISTS `tbl_country` (
  `countryId` int(11) NOT NULL AUTO_INCREMENT,
  `countryName` varchar(25) NOT NULL,
  `countryCode` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`countryId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_country: ~2 rows (approximately)
/*!40000 ALTER TABLE `tbl_country` DISABLE KEYS */;
INSERT INTO `tbl_country` (`countryId`, `countryName`, `countryCode`) VALUES
	(1, 'India', 'IN'),
	(2, 'USA', 'US'),
	(3, 'Canada', 'CD');
/*!40000 ALTER TABLE `tbl_country` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_currency
DROP TABLE IF EXISTS `tbl_currency`;
CREATE TABLE IF NOT EXISTS `tbl_currency` (
  `currencyId` int(11) NOT NULL AUTO_INCREMENT,
  `currencyName` varchar(50) DEFAULT NULL,
  `isActive` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`currencyId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_currency: ~2 rows (approximately)
/*!40000 ALTER TABLE `tbl_currency` DISABLE KEYS */;
INSERT INTO `tbl_currency` (`currencyId`, `currencyName`, `isActive`) VALUES
	(1, 'INR', 1),
	(2, 'POUND', 1);
/*!40000 ALTER TABLE `tbl_currency` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_department
DROP TABLE IF EXISTS `tbl_department`;
CREATE TABLE IF NOT EXISTS `tbl_department` (
  `deptId` int(100) NOT NULL AUTO_INCREMENT,
  `deptName` varchar(250) NOT NULL,
  `address` varchar(500) DEFAULT NULL,
  `countryId` int(100) DEFAULT NULL,
  `stateId` int(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `phoneNo` varchar(15) DEFAULT NULL,
  `parentDeptId` int(100) DEFAULT '0',
  `grandParentDeptId` int(10) NOT NULL,
  `createdOn` datetime DEFAULT NULL,
  `createdBy` int(10) DEFAULT NULL,
  PRIMARY KEY (`deptId`)
) ENGINE=InnoDB AUTO_INCREMENT=929 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_department: ~35 rows (approximately)
/*!40000 ALTER TABLE `tbl_department` DISABLE KEYS */;
INSERT INTO `tbl_department` (`deptId`, `deptName`, `address`, `countryId`, `stateId`, `city`, `phoneNo`, `parentDeptId`, `grandParentDeptId`, `createdOn`, `createdBy`) VALUES
	(57, 'Dept1', 'ADD', NULL, NULL, NULL, NULL, 0, 303, NULL, NULL),
	(58, 'Dept2', 'ADD2', NULL, NULL, NULL, NULL, 57, 303, NULL, NULL),
	(59, 'Dept3', 'ADD4', NULL, NULL, NULL, NULL, 0, 303, NULL, NULL),
	(159, 'Test Department', 'Address 1', NULL, NULL, NULL, NULL, 0, 303, NULL, NULL),
	(160, 'Test Department 1', 'Address 2', NULL, NULL, NULL, NULL, 59, 303, NULL, NULL),
	(228, 'depart12', 'fhf', NULL, NULL, NULL, NULL, 57, 303, NULL, NULL),
	(229, 'test1212', 'yfuyf', NULL, NULL, NULL, NULL, 0, 303, NULL, NULL),
	(230, 'Department1234', 'testr', NULL, NULL, NULL, NULL, 229, 303, NULL, NULL),
	(233, 'Test7', 'Test7 address', NULL, NULL, NULL, NULL, 0, 303, NULL, NULL),
	(260, 'Demo Department 1', 'Ahmedabad', NULL, NULL, NULL, NULL, 0, 303, NULL, NULL),
	(261, 'Demo Department 2', 'Ahmedabad', NULL, NULL, NULL, NULL, 260, 303, NULL, NULL),
	(283, 'Sales', 'Address 1', NULL, NULL, NULL, NULL, 0, 303, NULL, NULL),
	(302, 'Test1 Department Demo1', 'test 1', NULL, NULL, NULL, NULL, 0, 303, NULL, NULL),
	(303, 'organization1', 'address', NULL, NULL, NULL, NULL, 0, 0, NULL, 1),
	(472, 'test department 10', 'test', NULL, NULL, NULL, NULL, 57, 303, NULL, NULL),
	(473, 'test department 10', 'test', NULL, NULL, NULL, NULL, 57, 303, NULL, NULL),
	(474, 'New Department', 'Test', NULL, NULL, NULL, NULL, 0, 0, NULL, NULL),
	(475, 'New Department', 'Test', NULL, NULL, NULL, NULL, 0, 0, NULL, NULL),
	(476, 'New Department', 'Test', NULL, NULL, NULL, NULL, 0, 0, NULL, NULL),
	(479, 'Department A', 'Ahmedabad', NULL, NULL, NULL, NULL, 0, 0, NULL, NULL),
	(480, 'Department B', 'Ahmedabad', NULL, NULL, NULL, NULL, 0, 479, NULL, NULL),
	(481, 'Department C', 'Ahmedabad', NULL, NULL, NULL, NULL, 480, 479, NULL, NULL),
	(482, 'Department D', 'Ahm', NULL, NULL, NULL, NULL, 0, 479, NULL, NULL),
	(483, 'Department E', 'Ahm', NULL, NULL, NULL, NULL, 482, 479, NULL, NULL),
	(484, 'Department F', 'Ahm', NULL, NULL, NULL, NULL, 480, 479, NULL, NULL),
	(485, 'Department G', 'ahm', NULL, NULL, NULL, NULL, 482, 479, NULL, NULL),
	(837, 'T demo 1', 'test', NULL, NULL, NULL, NULL, 283, 303, NULL, NULL),
	(873, 'D1', 'd1 addresss', NULL, NULL, NULL, NULL, 0, 0, NULL, NULL),
	(874, 'D2', 'D2 address', NULL, NULL, NULL, NULL, 0, 873, NULL, NULL),
	(875, 'D3', 'D3 address', NULL, NULL, NULL, NULL, 874, 873, NULL, NULL),
	(900, 'Petrolium', 'tesst', NULL, NULL, NULL, NULL, 874, 873, NULL, NULL),
	(924, 'Department 11', 'Ahm', NULL, NULL, NULL, NULL, 0, 0, NULL, NULL),
	(925, 'Department 22', 'Ahm', NULL, NULL, NULL, NULL, 0, 924, NULL, NULL),
	(926, 'Department 33', 'Ahm', NULL, NULL, NULL, NULL, 925, 924, NULL, NULL),
	(928, 'Department 44', 'Ahm', NULL, NULL, NULL, NULL, 925, 924, NULL, NULL);
/*!40000 ALTER TABLE `tbl_department` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_designation
DROP TABLE IF EXISTS `tbl_designation`;
CREATE TABLE IF NOT EXISTS `tbl_designation` (
  `designationId` int(20) NOT NULL AUTO_INCREMENT,
  `designationName` varchar(50) NOT NULL,
  `deptId` int(20) NOT NULL,
  `createdBy` int(10) NOT NULL,
  `createDate` datetime NOT NULL,
  `modifiedBy` int(10) DEFAULT NULL,
  `modifiedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`designationId`),
  KEY `deptId` (`deptId`)
) ENGINE=InnoDB AUTO_INCREMENT=932 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_designation: ~24 rows (approximately)
/*!40000 ALTER TABLE `tbl_designation` DISABLE KEYS */;
INSERT INTO `tbl_designation` (`designationId`, `designationName`, `deptId`, `createdBy`, `createDate`, `modifiedBy`, `modifiedDate`) VALUES
	(45, 'Design12', 57, 1, '2016-11-19 07:08:55', 1, '2016-11-19 07:08:55'),
	(49, 'Desig3', 57, 1, '2016-11-25 00:27:19', 1, '2016-11-25 00:27:19'),
	(50, 'Desig4', 57, 1, '2016-11-25 00:27:27', 1, '2016-11-25 00:27:27'),
	(60, 'Desig5', 57, 1, '2016-11-25 00:28:27', NULL, NULL),
	(161, 'Test Designation', 159, 1, '2016-12-05 17:49:12', NULL, NULL),
	(162, 'Test Designation', 59, 1, '2016-12-05 17:54:18', NULL, NULL),
	(227, 'designation', 160, 1, '2016-12-05 18:10:01', NULL, NULL),
	(231, 'Designation', 230, 1, '2016-12-05 18:32:59', NULL, NULL),
	(232, 'Designation 12345', 229, 1, '2016-12-05 18:33:43', NULL, NULL),
	(234, 'desg 7', 159, 1, '2016-12-07 08:54:10', 1, '2016-12-07 08:54:10'),
	(262, 'Demo Designation', 261, 1, '2016-12-07 18:26:46', NULL, NULL),
	(284, 'Sales Manager', 283, 1, '2016-12-08 06:18:47', NULL, NULL),
	(303, 'test design demo1', 302, 1, '2016-12-08 11:36:34', NULL, NULL),
	(486, 'Designation F', 484, 1, '2016-12-20 01:17:26', NULL, NULL),
	(487, 'Designation G', 485, 1, '2016-12-20 01:17:54', NULL, NULL),
	(498, 'Designation A', 479, 1, '2016-12-20 19:44:29', NULL, NULL),
	(499, 'Designation B', 480, 1, '2016-12-20 19:45:57', NULL, NULL),
	(876, 'DES1', 873, 1, '2016-12-21 22:18:34', NULL, NULL),
	(877, 'DES2', 874, 1, '2016-12-21 22:19:04', NULL, NULL),
	(878, 'DES3', 875, 1, '2016-12-21 22:19:19', NULL, NULL),
	(901, 'Designation test 1', 900, 1, '2016-12-22 11:47:24', NULL, NULL),
	(927, 'Designation 11', 924, 1, '2016-12-26 21:00:01', NULL, NULL),
	(929, 'Designation 11', 924, 1, '2016-12-26 21:18:41', NULL, NULL),
	(930, 'Designation 22', 925, 1, '2016-12-26 21:24:05', 1, '2016-12-26 21:24:05'),
	(931, 'Designation 33', 926, 1, '2016-12-26 21:24:54', NULL, NULL);
/*!40000 ALTER TABLE `tbl_designation` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_envelope
DROP TABLE IF EXISTS `tbl_envelope`;
CREATE TABLE IF NOT EXISTS `tbl_envelope` (
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

-- Dumping data for table eauctiontender.tbl_envelope: ~5 rows (approximately)
/*!40000 ALTER TABLE `tbl_envelope` DISABLE KEYS */;
INSERT INTO `tbl_envelope` (`envId`, `isActive`, `lang1`, `lang10`, `lang11`, `lang12`, `lang13`, `lang14`, `lang15`, `lang2`, `lang3`, `lang4`, `lang5`, `lang6`, `lang7`, `lang8`, `lang9`, `sortOrder`) VALUES
	(1, 1, 'Emd & Document Fee', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1),
	(2, 0, 'Pre Qualification', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1),
	(3, 1, 'Technical bid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1),
	(4, 1, 'Price bid', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1),
	(5, 1, 'Techno commercial', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1);
/*!40000 ALTER TABLE `tbl_envelope` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_eventtermandconditions
DROP TABLE IF EXISTS `tbl_eventtermandconditions`;
CREATE TABLE IF NOT EXISTS `tbl_eventtermandconditions` (
  `termNcondId` int(25) DEFAULT NULL,
  `termNcondition` varchar(6000) DEFAULT NULL,
  `eventType` int(11) DEFAULT NULL,
  `eventId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_eventtermandconditions: ~7 rows (approximately)
/*!40000 ALTER TABLE `tbl_eventtermandconditions` DISABLE KEYS */;
INSERT INTO `tbl_eventtermandconditions` (`termNcondId`, `termNcondition`, `eventType`, `eventId`) VALUES
	(854, 'We, hereby declare that, \r\n<br>&#8195;&#8195;1.&#8195;We have read, examined and understood the tender document pertaining to this tender notice and have no reservations to the same,. \r\n<br>&#8195;&#8195;2.&#8195;We offer to execute the works in conformity with the tender Documents \r\n<br>&#8195;&#8195;3.&#8195;Our bid shall be valid for a period as mentioned in the tender document and it shall remain binding upon us. \r\n<br>&#8195;&#8195;4.&#8195;We understand that you are not bound to accept the lowest evaluate', 1, 31),
	(862, 'We, hereby declare that, \r\n<br>&#8195;&#8195;1.&#8195;We have read, examined and understood the tender document pertaining to this tender notice and have no reservations to the same,. \r\n<br>&#8195;&#8195;2.&#8195;We offer to execute the works in conformity with the tender Documents \r\n<br>&#8195;&#8195;3.&#8195;Our bid shall be valid for a period as mentioned in the tender document and it shall remain binding upon us. \r\n<br>&#8195;&#8195;4.&#8195;We understand that you are not bound to accept the lowest evaluate <div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;5. &nbsp; Terms and conditions</div>', 1, 32),
	(864, 'We, hereby declare that, \r\n<br>&#8195;&#8195;1.&#8195;We have read, examined and understood the tender document pertaining to this tender notice and have no reservations to the same,. \r\n<br>&#8195;&#8195;2.&#8195;We offer to execute the works in conformity with the tender Documents \r\n<br>&#8195;&#8195;3.&#8195;Our bid shall be valid for a period as mentioned in the tender document and it shall remain binding upon us. \r\n<br>&#8195;&#8195;4.&#8195;We understand that you are not bound to accept the lowest evaluate <div>5. terms</div>', 1, 34),
	(872, 'We, hereby declare that, \r\n<br>&#8195;&#8195;1.&#8195;We have read, examined and understood the tender document pertaining to this tender notice and have no reservations to the same,. \r\n<br>&#8195;&#8195;2.&#8195;We offer to execute the works in conformity with the tender Documents \r\n<br>&#8195;&#8195;3.&#8195;Our bid shall be valid for a period as mentioned in the tender document and it shall remain binding upon us. \r\n<br>&#8195;&#8195;4.&#8195;We understand that you are not bound to accept the lowest evaluate <div>5. terms</div>', 1, 37),
	(885, 'We, hereby declare that, \r\n<br>&#8195;&#8195;1.&#8195;We have read, examined and understood the tender document pertaining to this tender notice and have no reservations to the same,. \r\n<br>&#8195;&#8195;2.&#8195;We offer to execute the works in conformity with the tender Documents \r\n<br>&#8195;&#8195;3.&#8195;Our bid shall be valid for a period as mentioned in the tender document and it shall remain binding upon us. \r\n<br>&#8195;&#8195;4.&#8195;We understand that you are not bound to accept the lowest evaluate', 1, 39),
	(892, 'We, hereby declare that, \r\n<br>&#8195;&#8195;1.&#8195;We have read, examined and understood the tender document pertaining to this tender notice and have no reservations to the same,. \r\n<br>&#8195;&#8195;2.&#8195;We offer to execute the works in conformity with the tender Documents \r\n<br>&#8195;&#8195;3.&#8195;Our bid shall be valid for a period as mentioned in the tender document and it shall remain binding upon us. \r\n<br>&#8195;&#8195;4.&#8195;We understand that you are not bound to accept the lowest evaluate', 1, 41),
	(912, 'We, hereby declare that, \r\n<br>&#8195;&#8195;1.&#8195;We have read, examined and understood the tender document pertaining to this tender notice and have no reservations to the same,. \r\n<br>&#8195;&#8195;2.&#8195;We offer to execute the works in conformity with the tender Documents \r\n<br>&#8195;&#8195;3.&#8195;Our bid shall be valid for a period as mentioned in the tender document and it shall remain binding upon us. \r\n<br>&#8195;&#8195;4.&#8195;We understand that you are not bound to accept the lowest evaluate', 1, 44),
	(947, 'We, hereby declare that, \r\n<br>&#8195;&#8195;1.&#8195;We have read, examined and understood the tender document pertaining to this tender notice and have no reservations to the same,. \r\n<br>&#8195;&#8195;2.&#8195;We offer to execute the works in conformity with the tender Documents \r\n<br>&#8195;&#8195;3.&#8195;Our bid shall be valid for a period as mentioned in the tender document and it shall remain binding upon us. \r\n<br>&#8195;&#8195;4.&#8195;We understand that you are not bound to accept the lowest evaluate <div>5.&nbsp;</div>', 1, 54);
/*!40000 ALTER TABLE `tbl_eventtermandconditions` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_exceptionlog
DROP TABLE IF EXISTS `tbl_exceptionlog`;
CREATE TABLE IF NOT EXISTS `tbl_exceptionlog` (
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

-- Dumping data for table eauctiontender.tbl_exceptionlog: ~0 rows (approximately)
/*!40000 ALTER TABLE `tbl_exceptionlog` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_exceptionlog` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_fildnamemapping
DROP TABLE IF EXISTS `tbl_fildnamemapping`;
CREATE TABLE IF NOT EXISTS `tbl_fildnamemapping` (
  `fieldid` int(11) NOT NULL AUTO_INCREMENT,
  `labelname` varchar(100) DEFAULT NULL,
  `displayproperty` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`fieldid`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_fildnamemapping: ~91 rows (approximately)
/*!40000 ALTER TABLE `tbl_fildnamemapping` DISABLE KEYS */;
INSERT INTO `tbl_fildnamemapping` (`fieldid`, `labelname`, `displayproperty`) VALUES
	(1, 'officerName', 'fields_tender_departmentofficial'),
	(2, 'departmentName', 'label_tender_department'),
	(3, 'tenderId', 'fields_tenderid'),
	(4, 'tenderNo', 'fields_refenceno'),
	(5, 'tenderBrief', 'field_brief'),
	(6, 'tenderDetail', 'field_tender_detail'),
	(7, 'keywordText', 'fields_tender_keywords'),
	(8, 'envolopeName', 'lbl_envelope'),
	(9, 'procurementNature', 'lbl_type_of_contract'),
	(10, 'projectDuration', 'lbl_projectduration'),
	(11, 'downloadDocument', 'lbl_downloaddocument'),
	(12, 'isItemwiseWinner', 'lbl_itemwise_lh'),
	(13, 'eachLineItem', 'lbl_each_line_item'),
	(14, 'grandTotal', 'lbl_grandtotalwise_item'),
	(15, 'tenderMode', 'lbl_bidding_access'),
	(16, 'isConsortiumAllowed', 'lbl_consortium'),
	(17, 'submissionMode', 'lbl_mode_of_submission'),
	(18, 'notAllowd', 'lbl_notallowed'),
	(19, 'allowed', 'lbl_allowed'),
	(20, 'isBidWithdrawal', 'lbl_bidwithdrawal'),
	(21, 'biddingVariant', 'lbl_bidding_variant'),
	(22, 'autoResultSharing', 'lbl_auto_result_sharing'),
	(23, 'auto', 'lbl_auto'),
	(24, 'manual', 'lbl_manual'),
	(25, 'open', 'lbl_open'),
	(26, 'buy', 'lbl_buy'),
	(27, 'sell', 'lbl_sell'),
	(28, 'isPreBidMeeting', 'lbl_prebid_meeting'),
	(29, 'limited', 'lbl_limited'),
	(30, 'proprietary', 'lbl_proprietary'),
	(31, 'single', 'lbl_single'),
	(32, 'validityPeriod', 'lbl_bid_validity_period'),
	(33, 'nomination', 'lbl_nomination'),
	(34, 'prebidMode', 'lbl_modeof_prebid_meeting'),
	(35, 'isWorkflowRequire', 'lbl_workflow_requires'),
	(36, 'preBidAddress', 'lbl_prebid_address'),
	(37, 'biddingType', 'lbl_biddingType'),
	(38, 'nationalCurrency', 'lbl_national_competitive_bidding'),
	(39, 'internationalCurrency', 'lbl_international_competitive_bidding'),
	(40, 'baseCurrency', 'lbl_base_currency'),
	(41, 'workflowType', 'lbl_workflow_type'),
	(42, 'isQuestionAnswer', 'lbl_question_answer'),
	(43, 'documentStartDate', 'lbl_document_start_date'),
	(44, 'submissionStartDate', 'lbl_bid_submission_start_date'),
	(45, 'submissionEndDate', 'lbl_bid_submission_end_date'),
	(46, 'documentEndDate', 'lbl_document_end_date'),
	(47, 'yes', 'label_yes'),
	(48, 'no', 'label_no'),
	(49, 'submit', 'label_submit'),
	(50, 'docfee', 'title_doc_emd_secfees'),
	(51, 'isDocfeesApplicable', 'lbl_document_fees'),
	(52, 'isSecurityfeesApplicable', 'lbl_security_fee'),
	(53, 'isEMDApplicable', 'lbl_emd_fee'),
	(54, 'bidSub', 'title_bid_submission_conf'),
	(55, 'fieldBaseVurrency', 'fields_basecurrency'),
	(56, 'online', 'lbl_online'),
	(57, 'offline', 'lbl_offline'),
	(58, 'both', 'lbl_both'),
	(59, 'isDocfeesApplicable', 'fields_fees_amt'),
	(60, 'isDocfeesAddress', 'field_docfees_payableat'),
	(61, 'docFeePaymentMode', 'lbl_security_paymentMode'),
	(62, 'securityFee', 'field_tendersec_fees_amt'),
	(63, 'secFeePaymentAddress', 'field_tendersec_fee_payment_at'),
	(64, 'emdPaymentMode', 'lbl_emd_paymentMode'),
	(65, 'emdAmount', 'field_emdamt'),
	(66, 'emdPaymentAddress', 'field_emdpaymentat'),
	(67, 'registrationChargesMode', 'lbl_reg_paymentMode'),
	(68, 'registrationCharges', 'lbl_tender_registration_charges'),
	(69, 'openingDate', 'field_bidopeningstartdate'),
	(70, 'tenderValue', 'lbl_tender_value'),
	(71, 'preBidStartDate', 'field_bidsubmissionenddate'),
	(72, 'preBidEndDate', 'fields_prebidmeet_enddate'),
	(73, 'questionAnswerEndDate', 'field_queans_enddate'),
	(74, 'questionAnswerStartDate', 'field_queans_startdate'),
	(75, 'submissionEndDate', 'field_bidsubmissionenddate'),
	(76, 'preBidStartDate', 'fields_prebidmeet_startdate'),
	(77, 'preBidEndDate', 'fields_prebidmeet_enddate'),
	(78, 'openingDate', 'field_bidopeningstartdate'),
	(79, 'docFeePaymentAddress', 'field_docfees_payableat'),
	(80, 'documentFee', 'fields_fees_amt'),
	(81, 'securityFee', 'field_tendersec_fees_amt'),
	(82, 'secFeePaymentAddress', 'field_tendersec_fee_payment_at'),
	(83, 'emdPaymentAddress', 'field_emdpaymentat'),
	(84, 'registrationCharges', 'fields_regfees_amt'),
	(85, 'preBidStartDate', 'fields_prebidmeet_startdate'),
	(86, 'preBidEndDate', 'fields_prebidmeet_enddate'),
	(87, 'submissionEndDate', 'field_bidsubmissionenddate'),
	(88, 'openingDate', 'field_bidopeningstartdate'),
	(89, 'questionAnswerStartDate', 'field_queans_startdate'),
	(90, 'questionAnswerEndDate', 'field_queans_enddate'),
	(91, 'procurementNatureId', 'lbl_type_of_contract'),
	(92, 'isRebateApplicable', 'field_rebate');
/*!40000 ALTER TABLE `tbl_fildnamemapping` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_finalsubmission
DROP TABLE IF EXISTS `tbl_finalsubmission`;
CREATE TABLE IF NOT EXISTS `tbl_finalsubmission` (
  `finalSubmissionId` int(11) NOT NULL AUTO_INCREMENT,
  `consortiumId` int(11) DEFAULT NULL,
  `partnerType` int(11) DEFAULT NULL,
  `isActive` int(4) NOT NULL,
  `createdBy` int(11) NOT NULL,
  `createdOn` datetime DEFAULT CURRENT_TIMESTAMP,
  `ipAddress` longtext NOT NULL,
  `companyid` int(11) NOT NULL,
  `tenderid` int(11) NOT NULL,
  `bidderid` int(11) NOT NULL,
  PRIMARY KEY (`finalSubmissionId`),
  KEY `FK_tbl_finalsubmission_company` (`companyid`),
  KEY `FK_tbl_finalsubmission_tender` (`tenderid`),
  CONSTRAINT `FK676xkpfrq1q9wv96mrucutdl3` FOREIGN KEY (`tenderid`) REFERENCES `tbl_tender` (`tenderId`),
  CONSTRAINT `FK_tbl_finalsubmission_company` FOREIGN KEY (`companyid`) REFERENCES `tbl_company` (`companyid`),
  CONSTRAINT `FK_tbl_finalsubmission_tender` FOREIGN KEY (`tenderid`) REFERENCES `tbl_tender` (`tenderId`),
  CONSTRAINT `FKlcacmgqt2iv7kqvo4v4kl2kax` FOREIGN KEY (`companyid`) REFERENCES `tbl_company` (`companyid`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_finalsubmission: ~13 rows (approximately)
/*!40000 ALTER TABLE `tbl_finalsubmission` DISABLE KEYS */;
INSERT INTO `tbl_finalsubmission` (`finalSubmissionId`, `consortiumId`, `partnerType`, `isActive`, `createdBy`, `createdOn`, `ipAddress`, `companyid`, `tenderid`, `bidderid`) VALUES
	(7, 1, 1, 1, 4, '2016-11-24 17:00:00', '192.168.0.1', 1, 2, 9),
	(8, 1, 1, 1, 4, '2016-11-24 17:00:00', '192.168.0.1', 1, 3, 9),
	(9, 1, 1, 1, 4, '2016-11-24 17:00:00', '192.168.0.1', 1, 4, 9),
	(10, 1, 1, 1, 4, '2016-11-24 17:00:00', '192.168.0.1', 1, 10, 9),
	(11, 1, 1, 1, 4, '2016-11-24 17:00:00', '192.168.0.1', 1, 5, 256),
	(12, 1, 1, 1, 4, '2016-11-24 17:00:00', '192.168.0.1', 1, 13, 256),
	(13, 1, 1, 1, 4, '2016-11-24 17:00:00', '192.168.0.1', 281, 13, 282),
	(14, 1, 1, 1, 4, '2016-11-24 17:00:00', '192.168.0.1', 295, 14, 296),
	(15, 1, 1, 1, 4, '2016-11-24 17:00:00', '192.168.0.1', 292, 14, 293),
	(16, 1, 1, 1, 4, '2016-11-24 17:00:00', '192.168.0.1', 300, 15, 301),
	(17, 1, 1, 1, 4, '2016-11-24 17:00:00', '192.168.0.1', 292, 15, 293),
	(18, NULL, 0, 1, 254, '2016-12-22 09:20:46', '122.169.94.122', 255, 39, 256),
	(19, NULL, 0, 1, 254, '2016-12-22 09:43:58', '122.169.94.122', 255, 41, 256),
	(20, NULL, 0, 1, 254, '2016-12-22 12:28:12', '122.169.94.122', 255, 44, 256),
	(21, NULL, 0, 1, 254, '2016-12-26 13:40:51', '122.169.94.122', 255, 51, 256),
	(22, NULL, 0, 1, 254, '2016-12-27 09:14:17', '122.169.94.122', 255, 57, 256),
	(23, NULL, 0, 1, 254, '2016-12-28 03:20:59', '49.34.62.52', 255, 58, 256),
	(24, NULL, 0, 1, 920, '2016-12-28 03:21:34', '49.34.62.52', 921, 58, 922);
/*!40000 ALTER TABLE `tbl_finalsubmission` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_itemselection
DROP TABLE IF EXISTS `tbl_itemselection`;
CREATE TABLE IF NOT EXISTS `tbl_itemselection` (
  `bidderItemId` int(11) NOT NULL AUTO_INCREMENT,
  `createdBy` int(11) DEFAULT NULL,
  `createdOn` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isSelected` int(11) NOT NULL,
  `isBidded` int(11) NOT NULL,
  `rowId` int(11) NOT NULL,
  `companyId` int(11) NOT NULL,
  `tenderId` int(11) NOT NULL,
  `envelopeId` int(11) NOT NULL,
  `formId` int(11) NOT NULL,
  `tableId` int(11) NOT NULL,
  `bidderId` int(11) NOT NULL,
  PRIMARY KEY (`bidderItemId`),
  KEY `FK_tbl_itemselection_tender` (`tenderId`),
  KEY `FK_tbl_itemselection_envelope` (`envelopeId`),
  KEY `FK_tbl_itemselection_form` (`formId`),
  KEY `FK_tbl_itemselection_table` (`tableId`),
  KEY `FK_tbl_itemselection_company` (`companyId`),
  CONSTRAINT `FK_tbl_itemselection_company` FOREIGN KEY (`companyId`) REFERENCES `tbl_company` (`companyid`),
  CONSTRAINT `FK_tbl_itemselection_envelope` FOREIGN KEY (`envelopeId`) REFERENCES `tbl_tenderenvelope` (`envelopeId`),
  CONSTRAINT `FK_tbl_itemselection_form` FOREIGN KEY (`formId`) REFERENCES `tbl_tenderform` (`formId`),
  CONSTRAINT `FK_tbl_itemselection_table` FOREIGN KEY (`tableId`) REFERENCES `tbl_tendertable` (`tableId`),
  CONSTRAINT `FK_tbl_itemselection_tender` FOREIGN KEY (`tenderId`) REFERENCES `tbl_tender` (`tenderId`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_itemselection: ~9 rows (approximately)
/*!40000 ALTER TABLE `tbl_itemselection` DISABLE KEYS */;
INSERT INTO `tbl_itemselection` (`bidderItemId`, `createdBy`, `createdOn`, `isSelected`, `isBidded`, `rowId`, `companyId`, `tenderId`, `envelopeId`, `formId`, `tableId`, `bidderId`) VALUES
	(1, 254, '2016-12-22 08:29:17', 1, 1, 1, 255, 39, 56, 44, 42, 256),
	(2, 254, '2016-12-22 09:43:53', 1, 1, 1, 255, 41, 58, 47, 44, 256),
	(3, 254, '2016-12-22 12:26:56', 1, 1, 1, 255, 44, 61, 49, 46, 256),
	(5, 254, '2016-12-26 13:40:31', 1, 1, 1, 255, 51, 68, 52, 49, 256),
	(7, 254, '2016-12-27 09:14:00', 1, 1, 1, 255, 57, 78, 62, 59, 256),
	(8, 920, '2016-12-28 03:13:40', 1, 1, 1, 921, 58, 80, 64, 61, 922),
	(9, 920, '2016-12-28 03:14:12', 1, 1, 1, 921, 58, 81, 65, 62, 922),
	(10, 254, '2016-12-28 03:15:42', 1, 1, 1, 255, 58, 80, 64, 61, 256),
	(11, 254, '2016-12-28 03:16:18', 1, 1, 1, 255, 58, 81, 65, 62, 256);
/*!40000 ALTER TABLE `tbl_itemselection` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_link
DROP TABLE IF EXISTS `tbl_link`;
CREATE TABLE IF NOT EXISTS `tbl_link` (
  `linkId` int(11) NOT NULL AUTO_INCREMENT,
  `linkName` varchar(100) NOT NULL,
  `module` varchar(25) DEFAULT NULL,
  `link` varchar(100) NOT NULL,
  `description` varchar(50) NOT NULL,
  PRIMARY KEY (`linkId`)
) ENGINE=InnoDB AUTO_INCREMENT=339 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_link: ~112 rows (approximately)
/*!40000 ALTER TABLE `tbl_link` DISABLE KEYS */;
INSERT INTO `tbl_link` (`linkId`, `linkName`, `module`, `link`, `description`) VALUES
	(1, 'create event', 'tender', '/etender/buyer/createevent/', 'create tender'),
	(2, 'tender dashboard', 'tender', '/eProcurement/etenderdashboard', 'dashboard'),
	(3, 'unauthorizedaccess', 'common', '/eProcurement/unauthorizedaccess', 'unauthorizedaccess'),
	(4, 'logout', 'common', '/eProcurement/submitlogout', 'logout'),
	(5, 'create prebid committee', 'tender', '/eProcurement/etender/buyer/addcommittee', 'prebid add committee'),
	(6, 'edit prebid committee', 'tender', '/eProcurement/etender/buyer/editcommittee', 'prebid edit committee'),
	(7, 'edit prebid committee', 'tender', '/eProcurement/etender/buyer/posteditcommittee', 'prebid edit committee'),
	(8, 'tender dashboard tab', 'tender', '/eProcurement/etender/buyer/gettendertabcontent', 'tenderdashboard content'),
	(9, 'create bid opening commit', 'tender', '/eProcurement/etender/buyer/getcreatecommitee', 'bid opening committe creation'),
	(10, 'officer list', 'tender', '/eProcurement/etender/buyer/officers/', 'get officer list'),
	(11, 'edit opening committee', 'tender', '/eProcurement/etender/buyer/geteditcommitee', 'edit opening committe'),
	(12, 'view committe', 'tender', '/eProcurement/etender/buyer/getviewcommitee/', 'view committee'),
	(13, 'submit prebid committe', 'tender', '/eProcurement/etender/buyer/submitprebidcomittee', 'submit prebid committe'),
	(14, 'create committee', 'tender', '/eProcurement/etender/buyer/createcommittee', 'create committe'),
	(15, 'loginfailed', 'common', '/eProcurement/loginfailed', 'login failed'),
	(16, 'view tender', 'tender', '/etender/buyer/viewtender', 'view tender'),
	(17, 'submit tender', 'tender', '/etender/buyer/addtender', 'submit tender'),
	(18, 'tender list', 'tender', '/etender/buyer/tenderListing', 'tender listing'),
	(19, 'create corrigendum', 'tender', '/etender/buyer/createcorrigendum', 'create corrigendum'),
	(20, 'submit corrigendum', 'tender', '/etender/buyer/submittendercorrigendum', 'submit corrigendum'),
	(21, 'tender corrigendum', 'tender', '/etender/buyer/tendercorrigendum', 'tender corrigendum'),
	(22, 'tender corrigendim submit', 'tender', '/etender/buyer/tendercorrigendumsubmit', 'corringendum submit'),
	(23, 'Listing', 'common', '/etender/commonListPage', 'Listing'),
	(24, 'Listing grid', 'common', '/etender/commonDataGrid', 'Grid'),
	(25, 'department list', 'common', '/common/user/getdepartments', 'get departments'),
	(26, 'department exists', 'common', '/common/user/isdepartmentexist/', 'department exists'),
	(27, 'add departments', 'common', '/common/user/addDept', 'add departments'),
	(28, 'edit departments', 'common', '/common/user/geteditdepartment/', 'edit departments'),
	(29, 'edit departments', 'common', '/common/user/editDept', 'edit departments'),
	(30, 'get designation', 'common', '/common/user/getdesignation', 'get designations'),
	(31, 'add designation', 'common', '/common/user/addDesignation', 'add designation'),
	(32, 'edit designation', 'common', '/common/user/geteditdesignation/', 'edit designation'),
	(33, 'edit designation', 'common', '/common/user/editDesignation', 'edit designation'),
	(34, 'is designation exists', 'commmon', '/common/user/isdesignationexists/', 'is desingation exists'),
	(35, 'create officer', 'common', '/common/user/getcreateofficer', 'create officer'),
	(36, 'edit officer', 'common', '/common/user/geteditofficer/', 'edit officer'),
	(37, 'add officer', 'common', '/common/user/adduser', 'add officer'),
	(38, 'manage user', 'common', '/common/user/getmanageuser', 'manage user'),
	(39, 'getsubdepartments', 'common', '/common/user/getsubdepartments', 'get sub departments'),
	(40, 'get designation by deptud', 'common', '/common/user/getdesignationbydeptid', 'get designation by deptid'),
	(41, 'managebidder', 'common', '/common/user/getmanagebidder', 'get manage bidder'),
	(42, 'edit bidder', 'common', '/common/user/geteditbidder', 'edit bidder'),
	(43, 'map bidder', 'tender', '/etender/buyer/biddermapping/', 'bidder map'),
	(44, 'search unmapped bidder', 'tender', '/etender/buyer/searchunmappedbidder', 'search unmapped bidder'),
	(45, 'map bidder', 'tender', '/etender/buyer/mapbidder', 'mapbidder'),
	(46, 'remove mapped bidder', 'tender', '/etender/buyer/removemappedbidder', 'remove mapped bidder'),
	(47, 'View mapped bidder', 'tender', '/etender/buyer/viewmappedbidders/', 'View mapped bidder'),
	(48, 'Add link', 'common', '/common/user/getaddlink', 'Add link'),
	(49, 'Add link post', 'common', '/common/user/addlink', 'Add link post'),
	(50, 'edit link', 'common', '/common/user/geteditlink', 'edit link'),
	(51, 'link exists', 'common', '/common/user/islinkexists', 'link exists'),
	(52, 'roles link', 'common', '/common/user/getroleslink', 'role links'),
	(53, 'search roleslink', 'common', '/common/user/searchlinksbyrole', 'search roleslink'),
	(54, 'addlinkstorole', 'common', '/common/user/addlinkstorole', 'add links to roles'),
	(55, 'Manage Links', 'common', '/common/user/managelinks', 'manage links'),
	(100, 'Corrigendum Dashboard', 'tender', '/etender/buyer/corrigendumdashboard', 'Corrigendum Dashboard'),
	(101, 'View Corrigendum', 'tender', '/etender/buyer/viewcorrigendum', 'View Corrigendum'),
	(102, 'Publish Corrigendum', 'tender', '/etender/buyer/showpublishcorrigendum', 'Publish Corrigendum'),
	(103, 'Tender Dashboard', 'tedner', '/etender/buyer/tenderDashboard', 'Tender Dashboard'),
	(104, 'Publish Tender', 'tender', '/etender/buyer/publishtender', 'publish tender'),
	(118, 'Submit workflow', 'workflow', '/etender/buyer/addworkflow', 'Submit workflow'),
	(120, 'Tender Evaluation', 'tender', '/etender/buyer/gettabcontent/', 'Tender Evaluation'),
	(249, 'Tender Opening', 'tender', '/etender/buyer/gettabcontent/', 'Tender Opening'),
	(250, 'create bidding form', 'tender', '/eProcurement/eBid/Bid/createForm', 'create bidding form'),
	(251, 'View Bidding Form', 'tender', '/eProcurement/eBid/Bid/viewForm', 'View bidding form'),
	(252, 'Save Bidding Form', 'tender', '/eProcurement/eBid/Bid/saveForm', 'save bidding form structure'),
	(253, 'Save Bidding Form Value', 'tender', '/eProcurement/eBid/Bid/updateBiddingFormValue', 'Add/Edit bidding form value'),
	(255, 'Tender Listing', 'tender', '/eProcurement/eBid/Bid/tenderListing', 'Tender Listing'),
	(256, 'workflow', 'tender', '/eProcurement/etender/buyer/tenderworkflow', 'workflow'),
	(257, 'Submit Publish Corrigendum', 'tender', '/etender/buyer/publishcorrigendum', 'Submit Publish Corrigendum'),
	(258, 'get file upload', 'tender', '/etender/bidder/uploadbr', 'get file upload'),
	(259, 'document content', 'tender', '/etender/bidder/briefca', 'document content'),
	(260, 'document upload post', 'tender', '/ajax/submitbriefcase', 'document upload post'),
	(261, 'get all document', 'tender', 'ajax/getbriefcaseuploadeddocs', 'get all documents'),
	(262, 'remove document', 'tender', '/ajax/deletebriefcasefil', 'remove document'),
	(263, 'download document', 'tender', '/ajax/downloadbriefcasefile', 'download document'),
	(264, 'tender nit document', 'tender', '/etender/buyer/tendernit', 'get tender nit document'),
	(265, 'Bidder Listing', 'Bidder', 'etender/bidder/bidderTenderListing', 'Bidder Listing'),
	(266, 'View Tender', 'Bidder', 'etender/bidder/viewtender', 'View Tender'),
	(267, 'Dashboard', 'Bidder', 'etender/bidder/biddingTenderDashboard', 'Dashboard'),
	(268, 'Dashboard Content', 'Bidder', 'etender/bidder/biddingtenderdashboardcontent', 'Dashboard Content'),
	(269, 'Save Bidder Declaration', 'Bidder', 'etender/bidder/bidderIagree', 'Save Bidder Declaration'),
	(270, 'Save Final Submission', 'Bidder', 'etender/bidder/finalsubmission', 'Save Final Submission'),
	(271, 'Bid Withdraw', 'Bidder', 'etender/bidder/showbidwithdraw', 'Bid Withdraw'),
	(272, 'Save Bid Withdraw', 'Bidder', 'etender/bidder/withdrawbid', 'Save Bid Withdraw'),
	(273, 'Consent Remarks', 'tender', 'etender/buyer/getcommitteeuserremark', 'Tender Opening Consent Remarks'),
	(274, 'Submit Consent Remarks', 'tender', 'etender/buyer/addusercommitteeremarks', 'Submit Consent Remarks'),
	(275, 'Price Bid ICB', 'tender', 'etender/buyer/pricebidICB', 'Price Bid ICB'),
	(276, 'Configure Price Bid Opening Date', 'tender', 'etender/buyer/pricebidopeningdate', 'Configure Price Bid Opening Date'),
	(277, 'Edit Price Bid Opening Date', 'tender', 'etender/buyer/editpricebidopeningdate', 'Edit Price Bid Opening Date'),
	(278, 'Publish Price Bid Opening Date', 'tender', 'etender/buyer/publishpricebidopeningdate', 'Publish Price Bid Opening Date'),
	(279, 'View Price Bid Opening Date', 'tender', 'etender/buyer/viewpricebidopeningdate', 'View Price Bid Opening Date'),
	(280, 'Evaluate Bidder', 'tender', 'etender/buyer/evaluatebidders', 'Evaluate Bidder'),
	(281, 'Save Price Bid ICB', 'tender', 'etender/buyer/updatepricebidICB', 'Save Price Bid ICB'),
	(282, 'Save Price Bid Opening Date', 'tender', 'etender/buyer/updatepricebidopeningdate', 'Save Price Bid Opening Date'),
	(283, 'Save Evaluate Bidder', 'tender', 'etender/buyer/saveevlutbiderstatus', 'Save Evaluate Bidder'),
	(292, 'List Document', 'document', '/etender/buyer/getDocumentList', 'List Document'),
	(293, 'Individual Report Buyer', 'tender', 'etender/buyer/tenderindividualreport', 'Individual Report Buyer'),
	(294, 'Individual Report Bidder', 'Bidder', 'etender/bidder/tenderindividualreport', 'Individual Report Bidder'),
	(295, 'publish prebid mom', 'tender', 'etender/buyer/publishprebidmom/', 'publish prebid mom'),
	(296, 'EditBidding Form', 'tender', '/eProcurement/eBid/Bid/EditBiddingForm', 'EditBidding Form'),
	(297, 'EditBidding Info ', 'tender', '/eBid/Bid/GetFormInfo', 'EditBidding Info'),
	(298, 'Publish Bidding form Info ', 'tender', '/eBid/Bid/PublishBiddingForm', 'Publish Bidding form'),
	(299, 'EditBiddingForm Table Structure  ', 'tender', '/eBid/Bid/GetTableStructure', 'EditBiddingForm Table Structure'),
	(300, 'Fill BiddingForm  ', 'tender', '/eBid/Bid/FillBiddingForm', 'Fill BiddingForm '),
	(301, 'Get Formula Column', 'tender', '/eBid/Bid/GetFormulaColumns', 'Get Formula Column'),
	(302, 'Save Evaluation Column', 'tender', '/eBid/Bid/saveEvaluationColumn', 'Save Evaluation Column'),
	(303, 'Get Evaluation Column', 'tender', '/eBid/Bid/getEvaluationColumn', 'Get Evaluation Column'),
	(304, 'Save Formula', 'tender', '/eBid/Bid/SaveFormula', 'Save Formula'),
	(305, 'Edit Document Form', 'tender', '/eBid/Bid/EditDocumentForm', 'Edit Document Form '),
	(306, 'Update Document Form', 'tender', '/eBid/Bid/UpdateDocumentform', 'Update Document Form'),
	(307, 'Delect Form Document', 'tender', '/eBid/Bid/deleteFormDocument', 'Delect Form Document'),
	(308, 'Edit Evaluation Column', 'tender', '/eBid/Bid/EditEvaluationColumn', 'Edit evaluation Column '),
	(309, 'Update Evaluation Column', 'tender', '/eBid/Bid/UpdateEvaluationColumn', 'Update Evaluation Column'),
	(310, 'Delete Evaluation Column', 'tender', '/eBid/Bid/deleteEvaluationColumn', 'Delete Evaluation Column'),
	(311, 'Remove Form Formula', 'tender', '/eBid/Bid/RemoveFormula', 'Remove Form Formula'),
	(312, 'Workflow List', 'workflow', '/etender/buyer/workflowlist', 'Workflow listing in left panel'),
	(313, 'get tender terms and cond', 'tender', '/etender/buyer/getcreatetermandconditions', 'get tender terms and cond.'),
	(314, 'add tender terms and cond', 'tender', '/etender/buyer/addtermandconditions', 'add tender term and cond.'),
	(315, 'EditBidding Structure', 'tender', 'eBid/Bid/editForm', 'EditBidding Structure'),
	(316, 'view Bidding Form values for edit', 'tender', '/eBid/Bid/viewFormForEdit', 'view Bidding Form values for edit'),
	(318, 'Update Bidding Form Values For Edit', 'tender', '/eBid/Bid/updateBiddingFormValueForEdit', 'Update Bidding Form Values For Edit'),
	(319, 'addEditMarquee', 'common', '/common/addEditMarquee', 'Marquee'),
	(320, 'submit marquee', 'common', '/common/submitMarquee', 'Marquee'),
	(321, 'view marquee', 'common', '/common/viewMarquee', 'Marquee'),
	(322, 'remove marquee', 'common', '/common/removeMarquee', 'Marquee'),
	(323, 'get cancel tender', 'tender', '/etender/buyer/getcanceltender/', 'get cancel tender'),
	(324, 'add cancel tender', 'tender', '/etender/buyer/canceltender', 'add cancel tender'),
	(325, 'submit publish tender', 'tender', '/etender/buyer/submitPublishtender', 'publish tender'),
	(329, 'copy tender', 'tender', '/etender/buyer/copytender/', 'copy tender'),
	(330, 'Delete Form ', 'tender', '/eBid/Bid/DeleteForm', 'Delete Form '),
	(331, 'Test Bidding Form', 'tender', '/eBid/Bid/GetFormInfoForTest', 'Test Bidding Form '),
	(332, 'Delete Bid', 'Bidder', 'etender/bidder/deletebid', 'Delete Bid'),
	(335, 'add bidder', 'common', '/common/user/addbidder', 'add bidder'),
	(336, 'Country Integration', 'common', '/etender/buyer/getCountry', 'Country Integration'),
	(337, 'State Integration', 'common', '/etender/buyer/getStates', 'State Integration'),
	(338, 'City Integration', 'common', '/etender/buyer/getCities', 'City Integration');
/*!40000 ALTER TABLE `tbl_link` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_marquee
DROP TABLE IF EXISTS `tbl_marquee`;
CREATE TABLE IF NOT EXISTS `tbl_marquee` (
  `marqueeId` int(11) NOT NULL AUTO_INCREMENT,
  `startDate` datetime DEFAULT NULL,
  `endDate` datetime DEFAULT NULL,
  `marqueeText` varchar(5000) DEFAULT NULL,
  `createdOn` datetime DEFAULT NULL,
  `createdBy` int(11) DEFAULT NULL,
  `isActive` int(11) DEFAULT '1',
  PRIMARY KEY (`marqueeId`)
) ENGINE=InnoDB AUTO_INCREMENT=887 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_marquee: ~0 rows (approximately)
/*!40000 ALTER TABLE `tbl_marquee` DISABLE KEYS */;
INSERT INTO `tbl_marquee` (`marqueeId`, `startDate`, `endDate`, `marqueeText`, `createdOn`, `createdBy`, `isActive`) VALUES
	(886, '2016-12-21 08:00:00', '2016-12-30 09:00:00', '<p>New Tender system is available for you soon. This is test marqee</p>', '2016-12-26 21:28:18', 263, 1);
/*!40000 ALTER TABLE `tbl_marquee` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_officer
DROP TABLE IF EXISTS `tbl_officer`;
CREATE TABLE IF NOT EXISTS `tbl_officer` (
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
  CONSTRAINT `tbl_officer_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `tbl_userlogin` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tbl_officer_ibfk_2` FOREIGN KEY (`designationId`) REFERENCES `tbl_designation` (`designationId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tbl_officer_ibfk_3` FOREIGN KEY (`deptId`) REFERENCES `tbl_department` (`deptId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_officer: ~11 rows (approximately)
/*!40000 ALTER TABLE `tbl_officer` DISABLE KEYS */;
INSERT INTO `tbl_officer` (`id`, `address`, `city`, `companyname`, `countryid`, `createdby`, `datecreated`, `datemodified`, `emailid`, `mobileno`, `modifiedby`, `officername`, `stateid`, `cstatus`, `userId`, `designationId`, `deptId`, `phoneNo`) VALUES
	(1, NULL, NULL, NULL, NULL, 1, '2016-12-21 17:15:10', '2016-12-21 17:15:10', 'officer1@mail.com', '2147483647', 1, 'officeronee', NULL, 1, 1, 45, 57, '232323'),
	(2, 'ahmdeabad', 'ahmdeabad', 'cp2', 1, 1, '2016-11-11 04:34:44', '2016-11-11 04:34:47', 'officer2@mail.com', '562312445', 1, 'officer2', 1, 1, 2, 45, 57, NULL),
	(3, 'ahmedabad', 'ahmdabad', 'cp3', 1, 1, '2016-11-11 04:35:32', '2016-11-11 04:35:35', 'officer3@mail.com', '12345678', 1, 'officer3', 1, 1, 3, 45, 57, NULL),
	(4, NULL, NULL, NULL, NULL, 1, '2016-12-21 22:22:18', '2016-12-21 22:22:18', 'officer4@mail.com', '2147483647', 1, 'officerfour', NULL, 1, 4, 486, 484, '8956231245'),
	(64, NULL, NULL, NULL, NULL, 1, '2016-11-25 02:28:24', NULL, 'officer5@gmail.com', '12121212', NULL, 'Nirav', NULL, 1, 63, 45, 57, '12121212'),
	(66, NULL, NULL, NULL, NULL, 1, '2016-11-25 17:39:34', '2016-11-25 17:39:34', 'officer6@mail.com', '111111111', 1, 'officersiXdf', NULL, 1, 65, 60, 57, '111111111'),
	(164, NULL, NULL, NULL, NULL, 1, '2016-12-05 17:54:44', NULL, 'officer9@mail.com', '9998970504', NULL, 'Officer', NULL, 1, 163, 162, 59, '9998970504'),
	(236, NULL, NULL, NULL, NULL, 1, '2016-12-07 06:43:04', '2016-12-07 06:43:04', 'officer7@mail.com', '1186535135', 1, 'Officer Super', NULL, 1, 235, 234, 233, '78945655'),
	(264, NULL, NULL, NULL, NULL, 1, '2016-12-07 18:45:54', '2016-12-07 18:45:54', 'officer11@mail.com', '9998970504', 1, 'Officer Eleven', NULL, 1, 263, 262, 261, '9998970503'),
	(305, NULL, NULL, NULL, NULL, 1, '2016-12-08 11:38:37', NULL, 'odemo@mail.com', '48484', NULL, 'demo user', NULL, 1, 304, 303, 302, '78965135'),
	(379, NULL, NULL, NULL, NULL, 1, '2016-12-08 12:25:54', NULL, 'sharmila@bgi.com', '78764765', NULL, 'sharmila', NULL, 1, 378, 284, 283, '343657'),
	(382, NULL, NULL, NULL, NULL, 1, '2016-12-15 10:55:00', NULL, 'user1@mail.in', '8657456345', NULL, 'sharmila', NULL, 1, 381, 45, 57, '43654757'),
	(489, NULL, NULL, NULL, NULL, 1, '2016-12-20 01:23:47', '2016-12-20 01:23:47', 'officer100@mail.com', '9898989898', 1, 'Officer hundred', NULL, 1, 488, 486, 484, '9898989898'),
	(501, NULL, NULL, NULL, NULL, 1, '2016-12-20 19:47:40', NULL, 'a@b.com', '3232323233', NULL, 'Officer A', NULL, 1, 500, 499, 480, '2323232323'),
	(839, NULL, NULL, NULL, NULL, 1, '2016-12-21 16:30:26', NULL, 'b11@mail.com', '435345', NULL, 'boneone', NULL, 1, 838, 284, 283, '345345'),
	(856, NULL, NULL, NULL, NULL, 1, '2016-12-21 17:29:34', NULL, 'officer15@mail.com', '99999999', NULL, 'Officer Fifteen', NULL, 1, 855, 487, 485, '99999999'),
	(880, NULL, NULL, NULL, NULL, 1, '2016-12-21 22:20:32', NULL, 'usertest@mail.com', '8956231245', NULL, 'usertest', NULL, 1, 879, 878, 875, '8956232145'),
	(903, NULL, NULL, NULL, NULL, 1, '2016-12-22 11:50:39', NULL, 'officer89@mail.com', '7484684', NULL, 'officereightnine', NULL, 1, 902, 45, 57, '78945613'),
	(933, NULL, NULL, NULL, NULL, 1, '2016-12-26 21:27:34', '2016-12-26 21:27:34', 'officer33@mail.com', '9999999999', 1, 'Officer Thirty-three', NULL, 1, 932, 931, 926, '9999999999');
/*!40000 ALTER TABLE `tbl_officer` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_officerdocument
DROP TABLE IF EXISTS `tbl_officerdocument`;
CREATE TABLE IF NOT EXISTS `tbl_officerdocument` (
  `officerDocId` int(250) NOT NULL AUTO_INCREMENT,
  `fileName` varchar(750) NOT NULL,
  `description` varchar(750) DEFAULT NULL,
  `path` varchar(300) NOT NULL,
  `fileType` varchar(750) NOT NULL,
  `fileSize` int(200) DEFAULT NULL,
  `tenderId` int(100) NOT NULL,
  `objectId` int(100) NOT NULL,
  `childId` int(100) DEFAULT NULL,
  `subChildId` int(100) DEFAULT NULL,
  `officerId` int(100) NOT NULL,
  `createdOn` datetime NOT NULL,
  `cstatus` int(11) NOT NULL,
  PRIMARY KEY (`officerDocId`)
) ENGINE=InnoDB AUTO_INCREMENT=951 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_officerdocument: ~25 rows (approximately)
/*!40000 ALTER TABLE `tbl_officerdocument` DISABLE KEYS */;
INSERT INTO `tbl_officerdocument` (`officerDocId`, `fileName`, `description`, `path`, `fileType`, `fileSize`, `tenderId`, `objectId`, `childId`, `subChildId`, `officerId`, `createdOn`, `cstatus`) VALUES
	(477, 'Diwali-2016-Profile-Images-For-FacebookWhatsapp.jpg', 'Sample document', '/23/1', 'jpg', 177033, 23, 1, 23, 0, 263, '2016-12-19 01:43:16', 0),
	(478, 'TV production.jpg', 'test', '/26/1', 'jpg', 262886, 26, 1, 26, 0, 263, '2016-12-19 19:13:58', 0),
	(506, 'A B C D E F G H I J K L M N O P Q R S T U V W X Y Z.docx', 'test', '/29/1', 'docx', 13499, 29, 1, 29, 0, 4, '2016-12-20 20:13:13', 0),
	(728, 'CONV_Online_Application_Form.pdf', 'test', '/30/1', 'pdf', 60174, 30, 1, 30, 0, 263, '2016-12-21 14:50:24', 0),
	(853, 'Chrysanthemum.jpg', 'test1', '/31/1', 'jpg', 879394, 31, 1, 31, 0, 4, '2016-12-21 17:24:27', 0),
	(861, 'CONV_Online_Application_Form.pdf', 'form', '/32/1', 'pdf', 60174, 32, 1, 32, 0, 855, '2016-12-21 17:41:42', 0),
	(863, 'CONV_Online_Application_Form.pdf', 'test', '/34/1', 'pdf', 60174, 34, 1, 34, 0, 263, '2016-12-21 18:14:58', 0),
	(865, 'books-magazines-building-school-large.jpg', 'test', '/34/2', 'jpg', 148274, 34, 2, 0, 11, 263, '2016-12-21 18:22:51', 0),
	(869, 'CONV_Online_Application_Form.pdf', 'tesr', '/35/1', 'pdf', 60174, 35, 1, 35, 0, 263, '2016-12-21 19:17:29', 0),
	(870, 'CONV_Online_Application_Form.pdf', 'test', '/35/2', 'pdf', 60174, 35, 2, 0, 12, 263, '2016-12-21 19:34:41', 0),
	(871, 'books-magazines-building-school-large.jpg', 'tye', '/36/1', 'jpg', 148274, 36, 1, 36, 0, 263, '2016-12-21 19:54:28', 0),
	(884, 'Chrysanthemum.jpg', 'test1', '/39/1', 'jpg', 879394, 39, 1, 39, 0, 4, '2016-12-22 05:32:11', 0),
	(887, 'Desert.jpg', 'test', '/39/2', 'jpg', 845941, 39, 2, 0, 13, 4, '2016-12-22 05:47:36', 0),
	(897, 'Desert.jpg', 'test1', '/42/2', 'jpg', 845941, 42, 2, 0, 14, 4, '2016-12-22 09:53:34', 0),
	(898, 'Hydrangeas.jpg', 'test', '/42/2', 'jpg', 595284, 42, 2, 0, 15, 2, '2016-12-22 10:02:06', 0),
	(899, 'Tulips.jpg', 'bnnn', '/42/2', 'jpg', 620888, 42, 2, 0, 16, 4, '2016-12-22 10:05:03', 0),
	(911, 'Chrysanthemum.jpg', 'Test one doc', '/44/1', 'jpg', 879394, 44, 1, 44, 0, 4, '2016-12-22 11:58:55', 0),
	(913, 'Chrysanthemum.jpg', 'Test1', '/44/2', 'jpg', 879394, 44, 2, 0, 20, 4, '2016-12-22 12:07:49', 0),
	(914, 'Penguins.jpg', 'test1', '/44/2', 'jpg', 777835, 44, 2, 0, 24, 4, '2016-12-22 12:12:50', 0),
	(916, 'test.txt', 'test', '/46/1', 'txt', 180, 46, 1, 46, 19, 4, '2016-12-25 18:56:03', 0),
	(917, 'test (1).txt', 'test', '/46/1', 'txt', 180, 46, 1, 46, 0, 4, '2016-12-25 18:56:50', 0),
	(918, 'A B C D E F G H I J K L M N O P Q R S T U V W X Y Z.docx', 'fdfd', '/46/1', 'docx', 13499, 46, 1, 46, 19, 263, '2016-12-25 19:05:57', 0),
	(919, 'Achilles-Procurement-Toolkit-Support-for-Sourcing-and-Supplier-Management.pdf', 'fgf', '/46/1', 'pdf', 578635, 46, 1, 46, 19, 263, '2016-12-25 19:06:45', 0),
	(946, 'A B C D E F G H I J K L M N O P Q R S T U V W X Y Z.docx', 'test', '/54/1', 'docx', 13499, 54, 1, 54, 0, 932, '2016-12-26 22:23:31', 0),
	(948, 'A B C D E F G H I J K L M N O P Q R S T U V W X Y Z.docx', 'dfgf', '/54/3', 'docx', 13499, 54, 3, 119, 0, 932, '2016-12-26 22:56:00', 0),
	(949, 'Kuwait.jpg', 'test', '/58/1', 'jpg', 15033, 58, 1, 58, 0, 263, '2016-12-28 02:55:43', 0),
	(950, 'Kuwait.jpg', 'test', '/58/2', 'jpg', 15033, 58, 2, 0, 28, 263, '2016-12-28 03:09:02', 0);
/*!40000 ALTER TABLE `tbl_officerdocument` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_process
DROP TABLE IF EXISTS `tbl_process`;
CREATE TABLE IF NOT EXISTS `tbl_process` (
  `processId` int(11) NOT NULL AUTO_INCREMENT,
  `isActive` int(11) DEFAULT NULL,
  `processName` varchar(255) DEFAULT NULL,
  `tableName` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`processId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_process: ~4 rows (approximately)
/*!40000 ALTER TABLE `tbl_process` DISABLE KEYS */;
INSERT INTO `tbl_process` (`processId`, `isActive`, `processName`, `tableName`) VALUES
	(1, 1, 'tender', 'tbl_Tender'),
	(2, 1, 'tendercurrency', 'tbl_TenderCurrency'),
	(3, 1, 'tenderevnolope', 'tbl_TenderEnvelope'),
	(4, 1, 'tenderform', 'tbl_TenderForm');
/*!40000 ALTER TABLE `tbl_process` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_procurementnature
DROP TABLE IF EXISTS `tbl_procurementnature`;
CREATE TABLE IF NOT EXISTS `tbl_procurementnature` (
  `procurementNatureId` int(11) NOT NULL AUTO_INCREMENT,
  `procurementName` varchar(200) DEFAULT NULL,
  `cStatus` int(11) DEFAULT NULL COMMENT '0:inactive,1:active',
  PRIMARY KEY (`procurementNatureId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_procurementnature: ~5 rows (approximately)
/*!40000 ALTER TABLE `tbl_procurementnature` DISABLE KEYS */;
INSERT INTO `tbl_procurementnature` (`procurementNatureId`, `procurementName`, `cStatus`) VALUES
	(1, 'Goods', 1),
	(2, 'Service', 1),
	(3, 'Works', 1),
	(4, 'Turnkey Project', 1),
	(5, 'Other', 1);
/*!40000 ALTER TABLE `tbl_procurementnature` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_rebate
DROP TABLE IF EXISTS `tbl_rebate`;
CREATE TABLE IF NOT EXISTS `tbl_rebate` (
  `rebateId` int(11) NOT NULL AUTO_INCREMENT,
  `createdBy` int(11) NOT NULL,
  `createdOn` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ipAddress` varchar(20) NOT NULL,
  `isRebateForm` int(5) DEFAULT NULL,
  `reportName` varchar(20) DEFAULT NULL,
  `tenderId` int(11) NOT NULL,
  PRIMARY KEY (`rebateId`),
  KEY `FK_tbl_rebate_tender` (`tenderId`),
  CONSTRAINT `FK_tbl_rebate_tender` FOREIGN KEY (`tenderId`) REFERENCES `tbl_tender` (`tenderId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_rebate: ~0 rows (approximately)
/*!40000 ALTER TABLE `tbl_rebate` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_rebate` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_rebatedetail
DROP TABLE IF EXISTS `tbl_rebatedetail`;
CREATE TABLE IF NOT EXISTS `tbl_rebatedetail` (
  `cellValue` longtext NOT NULL,
  `createdBy` int(11) NOT NULL,
  `createdOn` datetime NOT NULL,
  `rebateDetailId` int(11) NOT NULL,
  `companyid` int(11) NOT NULL,
  `tenderid` int(11) NOT NULL,
  `bidtableid` int(11) NOT NULL,
  `cellid` int(11) NOT NULL,
  PRIMARY KEY (`rebateDetailId`),
  KEY `FK_tbl_rebatedetail_company` (`companyid`),
  KEY `FK_tbl_rebatedetail_tender` (`tenderid`),
  KEY `FK_tbl_rebatedetail_bidmatrix` (`bidtableid`),
  KEY `FK_tbl_rebatedetail_cell` (`cellid`),
  CONSTRAINT `FK6ywgnims36lpxbdy4fjieyyp4` FOREIGN KEY (`tenderid`) REFERENCES `tbl_tender` (`tenderId`),
  CONSTRAINT `FK_tbl_rebatedetail` FOREIGN KEY (`bidtableid`) REFERENCES `tbl_tenderbidmatrix` (`bidTableId`),
  CONSTRAINT `FK_tbl_rebatedetail_cell` FOREIGN KEY (`cellid`) REFERENCES `tbl_tendercell` (`cellId`),
  CONSTRAINT `FK_tbl_rebatedetail_company` FOREIGN KEY (`companyid`) REFERENCES `tbl_company` (`companyid`),
  CONSTRAINT `FK_tbl_rebatedetail_tender` FOREIGN KEY (`tenderid`) REFERENCES `tbl_tender` (`tenderId`),
  CONSTRAINT `FKl4giyg83shnh80siq92kr1qf4` FOREIGN KEY (`cellid`) REFERENCES `tbl_tendercell` (`cellId`),
  CONSTRAINT `FKqfp2otms5q97hmq5tluovyok5` FOREIGN KEY (`companyid`) REFERENCES `tbl_company` (`companyid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_rebatedetail: ~0 rows (approximately)
/*!40000 ALTER TABLE `tbl_rebatedetail` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_rebatedetail` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_rebateform
DROP TABLE IF EXISTS `tbl_rebateform`;
CREATE TABLE IF NOT EXISTS `tbl_rebateform` (
  `rebateFormId` int(11) NOT NULL AUTO_INCREMENT,
  `createdBy` int(11) NOT NULL,
  `createdOn` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ipAddress` varchar(20) NOT NULL,
  `rebateId` int(11) NOT NULL,
  `cellId` int(11) NOT NULL,
  `formId` int(11) NOT NULL,
  PRIMARY KEY (`rebateFormId`),
  KEY `FK_tbl_rebateform_rebate` (`rebateId`),
  KEY `FK_tbl_rebateform_cell` (`cellId`),
  KEY `FK_tbl_rebateform_form` (`formId`),
  CONSTRAINT `FK_tbl_rebateform_cell` FOREIGN KEY (`cellId`) REFERENCES `tbl_tendercell` (`cellId`),
  CONSTRAINT `FK_tbl_rebateform_form` FOREIGN KEY (`formId`) REFERENCES `tbl_tenderform` (`formId`),
  CONSTRAINT `FK_tbl_rebateform_rebate` FOREIGN KEY (`rebateId`) REFERENCES `tbl_rebate` (`rebateId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_rebateform: ~0 rows (approximately)
/*!40000 ALTER TABLE `tbl_rebateform` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_rebateform` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_rolelinkmapping
DROP TABLE IF EXISTS `tbl_rolelinkmapping`;
CREATE TABLE IF NOT EXISTS `tbl_rolelinkmapping` (
  `rolelinkmapId` int(10) NOT NULL AUTO_INCREMENT,
  `linkId` int(10) NOT NULL,
  `roleId` int(10) NOT NULL,
  PRIMARY KEY (`rolelinkmapId`),
  KEY `rolev` (`roleId`),
  KEY `linkv` (`linkId`),
  CONSTRAINT `linkv` FOREIGN KEY (`linkId`) REFERENCES `tbl_link` (`linkId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rolev` FOREIGN KEY (`roleId`) REFERENCES `tbl_roles` (`roleId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=882 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_rolelinkmapping: ~157 rows (approximately)
/*!40000 ALTER TABLE `tbl_rolelinkmapping` DISABLE KEYS */;
INSERT INTO `tbl_rolelinkmapping` (`rolelinkmapId`, `linkId`, `roleId`) VALUES
	(250, 249, 3),
	(377, 265, 5),
	(378, 266, 5),
	(379, 267, 5),
	(380, 268, 5),
	(381, 269, 5),
	(382, 270, 5),
	(383, 271, 5),
	(384, 272, 5),
	(536, 294, 5),
	(537, 293, 1),
	(729, 1, 1),
	(730, 2, 1),
	(731, 5, 1),
	(732, 6, 1),
	(733, 7, 1),
	(734, 8, 1),
	(735, 9, 1),
	(736, 10, 1),
	(737, 11, 1),
	(738, 12, 1),
	(739, 13, 1),
	(740, 14, 1),
	(741, 16, 1),
	(742, 17, 1),
	(743, 18, 1),
	(744, 19, 1),
	(745, 20, 1),
	(746, 21, 1),
	(747, 22, 1),
	(748, 43, 1),
	(749, 44, 1),
	(750, 45, 1),
	(751, 46, 1),
	(752, 47, 1),
	(753, 100, 1),
	(754, 101, 1),
	(755, 102, 1),
	(756, 104, 1),
	(757, 120, 1),
	(758, 249, 1),
	(759, 250, 1),
	(760, 251, 1),
	(761, 252, 1),
	(762, 253, 1),
	(763, 255, 1),
	(764, 256, 1),
	(765, 257, 1),
	(766, 258, 1),
	(767, 259, 1),
	(768, 260, 1),
	(769, 261, 1),
	(770, 262, 1),
	(771, 263, 1),
	(772, 264, 1),
	(773, 273, 1),
	(774, 274, 1),
	(775, 275, 1),
	(776, 276, 1),
	(777, 277, 1),
	(778, 278, 1),
	(779, 279, 1),
	(780, 280, 1),
	(781, 281, 1),
	(782, 282, 1),
	(783, 283, 1),
	(785, 295, 1),
	(786, 296, 1),
	(787, 297, 1),
	(788, 298, 1),
	(789, 299, 1),
	(790, 300, 1),
	(791, 301, 1),
	(792, 302, 1),
	(793, 303, 1),
	(794, 304, 1),
	(795, 305, 1),
	(796, 306, 1),
	(797, 307, 1),
	(798, 309, 1),
	(799, 310, 1),
	(800, 313, 1),
	(801, 314, 1),
	(802, 3, 1),
	(803, 4, 1),
	(804, 15, 1),
	(805, 23, 1),
	(806, 24, 1),
	(807, 25, 1),
	(808, 26, 1),
	(809, 27, 1),
	(810, 28, 1),
	(811, 29, 1),
	(812, 30, 1),
	(813, 31, 1),
	(814, 32, 1),
	(815, 33, 1),
	(816, 35, 1),
	(817, 36, 1),
	(818, 37, 1),
	(819, 38, 1),
	(820, 39, 1),
	(821, 40, 1),
	(822, 41, 1),
	(823, 42, 1),
	(824, 48, 1),
	(825, 49, 1),
	(826, 50, 1),
	(827, 51, 1),
	(828, 52, 1),
	(829, 53, 1),
	(830, 54, 1),
	(831, 55, 1),
	(832, 118, 1),
	(833, 312, 1),
	(834, 34, 1),
	(835, 292, 1),
	(836, 103, 1),
	(837, 315, 1),
	(838, 316, 1),
	(839, 318, 1),
	(840, 18, 5),
	(841, 23, 5),
	(842, 24, 5),
	(843, 3, 5),
	(844, 4, 5),
	(845, 15, 5),
	(846, 300, 5),
	(847, 319, 1),
	(848, 320, 1),
	(849, 321, 1),
	(850, 322, 1),
	(852, 315, 5),
	(853, 253, 5),
	(854, 318, 5),
	(855, 311, 1),
	(856, 251, 5),
	(857, 252, 5),
	(858, 296, 5),
	(859, 297, 5),
	(860, 301, 5),
	(861, 304, 5),
	(862, 305, 5),
	(863, 306, 5),
	(864, 307, 5),
	(865, 316, 5),
	(866, 324, 1),
	(867, 323, 1),
	(868, 325, 1),
	(872, 329, 1),
	(873, 330, 1),
	(874, 331, 1),
	(875, 332, 5),
	(878, 335, 5),
	(879, 336, 1),
	(880, 337, 1),
	(881, 338, 1);
/*!40000 ALTER TABLE `tbl_rolelinkmapping` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_roles
DROP TABLE IF EXISTS `tbl_roles`;
CREATE TABLE IF NOT EXISTS `tbl_roles` (
  `roleId` int(10) NOT NULL AUTO_INCREMENT,
  `roleName` varchar(100) NOT NULL,
  `isShown` int(11) DEFAULT '1',
  PRIMARY KEY (`roleId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_roles: ~4 rows (approximately)
/*!40000 ALTER TABLE `tbl_roles` DISABLE KEYS */;
INSERT INTO `tbl_roles` (`roleId`, `roleName`, `isShown`) VALUES
	(1, 'Creator', 1),
	(2, 'Approver', 1),
	(3, 'Opener', 1),
	(4, 'Evalutor', 1),
	(5, 'Bidder', 0);
/*!40000 ALTER TABLE `tbl_roles` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_sharereport
DROP TABLE IF EXISTS `tbl_sharereport`;
CREATE TABLE IF NOT EXISTS `tbl_sharereport` (
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

-- Dumping data for table eauctiontender.tbl_sharereport: ~0 rows (approximately)
/*!40000 ALTER TABLE `tbl_sharereport` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_sharereport` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_sharereportdetail
DROP TABLE IF EXISTS `tbl_sharereportdetail`;
CREATE TABLE IF NOT EXISTS `tbl_sharereportdetail` (
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

-- Dumping data for table eauctiontender.tbl_sharereportdetail: ~0 rows (approximately)
/*!40000 ALTER TABLE `tbl_sharereportdetail` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_sharereportdetail` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_state
DROP TABLE IF EXISTS `tbl_state`;
CREATE TABLE IF NOT EXISTS `tbl_state` (
  `stateId` int(11) NOT NULL AUTO_INCREMENT,
  `stateName` varchar(25) NOT NULL,
  `countryId` int(11) NOT NULL,
  PRIMARY KEY (`stateId`),
  KEY `countryId` (`countryId`),
  CONSTRAINT `tbl_state_ibfk_1` FOREIGN KEY (`countryId`) REFERENCES `tbl_country` (`countryId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_state: ~4 rows (approximately)
/*!40000 ALTER TABLE `tbl_state` DISABLE KEYS */;
INSERT INTO `tbl_state` (`stateId`, `stateName`, `countryId`) VALUES
	(1, 'Gujarat', 1),
	(2, 'Mumbai', 1),
	(3, 'Bangluore', 1),
	(4, 'Goa', 1);
/*!40000 ALTER TABLE `tbl_state` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_tender
DROP TABLE IF EXISTS `tbl_tender`;
CREATE TABLE IF NOT EXISTS `tbl_tender` (
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
  `docFeePaymentAddress` longtext,
  `docFeePaymentMode` int(11) NOT NULL DEFAULT '2',
  `documentEndDate` datetime DEFAULT NULL,
  `documentFee` varchar(50) DEFAULT NULL,
  `documentStartDate` datetime DEFAULT NULL,
  `documentSubmission` longtext,
  `downloadDocument` int(11) DEFAULT '2',
  `emdAmount` varchar(50) DEFAULT NULL,
  `emdPaymentAddress` longtext,
  `emdPaymentMode` int(11) NOT NULL DEFAULT '2',
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
  `otherProcurementNature` varchar(50) DEFAULT NULL,
  `preBidAddress` longtext,
  `preBidEndDate` datetime DEFAULT NULL,
  `preBidMode` int(11) NOT NULL DEFAULT '2',
  `preBidStartDate` datetime DEFAULT NULL,
  `prequalification` varchar(50) DEFAULT NULL,
  `prevEstimatedValue` decimal(19,2) NOT NULL,
  `productId` int(11) NOT NULL,
  `projectDuration` varchar(255) DEFAULT NULL,
  `publishedBy` int(11) DEFAULT NULL,
  `publishedOn` datetime DEFAULT NULL,
  `questionAnswerEndDate` datetime DEFAULT NULL,
  `questionAnswerStartDate` datetime DEFAULT NULL,
  `registrationCharges` varchar(50) DEFAULT NULL,
  `registrationChargesMode` int(11) NOT NULL,
  `remark` longtext,
  `resultSharing` int(11) NOT NULL,
  `secFeePaymentAddress` longtext,
  `secFeePaymentMode` int(11) NOT NULL DEFAULT '2',
  `securityFee` varchar(50) DEFAULT NULL,
  `showBidDetail` int(11) NOT NULL,
  `showBidderWiseForm` int(11) NOT NULL,
  `showNoOfBidders` int(11) NOT NULL,
  `showResultOnHomePage` int(11) NOT NULL,
  `sorVariation` decimal(19,2) DEFAULT NULL,
  `submissionEndDate` datetime DEFAULT NULL,
  `submissionMode` int(11) NOT NULL,
  `submissionStartDate` datetime DEFAULT NULL,
  `tenderBrief` varchar(1000) DEFAULT NULL,
  `tenderDetail` varchar(1000) DEFAULT NULL,
  `tenderMode` int(11) NOT NULL,
  `tenderNo` longtext,
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
  `cancelRemarks` varchar(500) DEFAULT NULL,
  `cancelDate` datetime DEFAULT NULL,
  `cancelBy` int(11) DEFAULT '0',
  `isRebateApplicable` int(11) DEFAULT '0',
  `copyFrom` int(11) DEFAULT '0',
  PRIMARY KEY (`tenderId`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_tender: ~47 rows (approximately)
/*!40000 ALTER TABLE `tbl_tender` DISABLE KEYS */;
INSERT INTO `tbl_tender` (`tenderId`, `POType`, `assignUserId`, `biddingType`, `biddingVariant`, `brdMode`, `corrigendumCount`, `createRfxFromEvent`, `procurementNatureId`, `createdBy`, `createdOn`, `cstatus`, `currencyId`, `decimalValueUpto`, `decryptorRequired`, `docFeePaymentAddress`, `docFeePaymentMode`, `documentEndDate`, `documentFee`, `documentStartDate`, `documentSubmission`, `downloadDocument`, `emdAmount`, `emdPaymentAddress`, `emdPaymentMode`, `encryptionLevel`, `envelopeType`, `evaluationMode`, `forHomePage`, `formContract`, `isBidWithdrawal`, `isCentralizedTECRequired`, `isCentralizedTOCRequired`, `isCertRequired`, `isConsortiumAllowed`, `isCreateAuction`, `isDemoTender`, `isDisplayClarificationDoc`, `isDocfeesApplicable`, `isDocumentFeeByBidder`, `isEMDApplicable`, `isEMDByBidder`, `isEMDdoneByTOC`, `isEncDocumentOnly`, `isEncodedName`, `isEvaluationByCommittee`, `isEvaluationRequired`, `isFinalPriceSheetReq`, `isFormConfirmationReq`, `isItemSelectionPageRequired`, `isItemwiseWinner`, `isMandatoryDocument`, `isNegotiationAllowed`, `isOpeningByCommittee`, `isPartialFillingAllowed`, `isParticipationFeesBy`, `isPastEvent`, `isPreBidMeeting`, `isProcessingFeeByBidder`, `isProxyBid`, `isQuestionAnswer`, `isReEvaluationReq`, `isRebateForm`, `isRegistrationCharges`, `isRestOfEventMoney`, `isRevisePriceBid`, `isReworkRequired`, `isSORApplicable`, `isSecurityfeesApplicable`, `isSplitPOAllowed`, `isSystemGeneratedTenderDoc`, `isTwoStageEvaluation`, `isTwoStageOpening`, `isWeightageEvaluationRequired`, `isWorkflowRequired`, `keywordText`, `multiLevelEvaluationReq`, `officerId`, `openingDate`, `otherProcurementNature`, `preBidAddress`, `preBidEndDate`, `preBidMode`, `preBidStartDate`, `prequalification`, `prevEstimatedValue`, `productId`, `projectDuration`, `publishedBy`, `publishedOn`, `questionAnswerEndDate`, `questionAnswerStartDate`, `registrationCharges`, `registrationChargesMode`, `remark`, `resultSharing`, `secFeePaymentAddress`, `secFeePaymentMode`, `securityFee`, `showBidDetail`, `showBidderWiseForm`, `showNoOfBidders`, `showResultOnHomePage`, `sorVariation`, `submissionEndDate`, `submissionMode`, `submissionStartDate`, `tenderBrief`, `tenderDetail`, `tenderMode`, `tenderNo`, `tenderResult`, `tenderSector`, `tenderValue`, `updatedBy`, `updatedOn`, `validityPeriod`, `winningReportMode`, `workflowForBidOpening`, `workflowForNegotiation`, `workflowForTEC`, `workflowForTOC`, `workflowTypeId`, `departmentId`, `eventTypeId`, `autoResultSharing`, `cancelRemarks`, `cancelDate`, `cancelBy`, `isRebateApplicable`, `copyFrom`) VALUES
	(1, 0, 1, 1, 1, 0, 1, 0, 0, 1, '2016-11-13 20:31:51', 1, 1, 2, 0, '', 2, '2016-11-10 09:09:00', '', '2016-11-10 09:09:00', '', 2, '', '', 2, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'no idTest tender updateTest Test tender updatetender update', 0, 1, '2016-11-10 12:09:00', '', '', NULL, 2, NULL, '', 10000.00, 0, '10', 1, '2016-11-13 20:32:36', '2016-11-24 09:13:08', '2016-11-18 09:13:14', '', 0, '', 1, '', 2, '', 1, 1, 1, 1, 1.00, '2016-11-10 11:09:00', 1, '2016-11-10 10:09:00', 'no idTest tender upTest tender updatedatTest tender updateeTestTest tender update tender updaTest tender updateTest 111', 'no idTest tender updatTest tender updateeTest tendeTest tender updater updatTest tender updatee', 1, 'Test tender update test1', 1, 0, 2500.00, 1, '2016-12-07 09:04:20', 120, 1, 1, 1, 1, 1, 3, 233, 1, 0, NULL, NULL, NULL, 0, 0),
	(2, 0, 1, 1, 1, 0, 2, 0, 1, 1, NULL, 1, 1, 0, 1, 'ssada d', 2, '2016-12-07 23:29:00', '12.00', '2016-12-06 23:29:00', '', 2, '', '', 2, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'new tendernew tender key', 0, 1, '2016-11-24 14:00:00', '', '', NULL, 2, NULL, '', 0.00, 0, '10', 0, NULL, NULL, NULL, '', 0, '', 1, '', 2, '', 0, 0, 0, 0, 0.00, '2016-12-10 23:29:00', 1, '2016-12-05 23:29:00', 'new tendernew tendernew tendernew tender', 'new tendernew tender', 2, 'new tender', 1, 0, 0.00, 1, '2016-12-06 17:59:44', 0, 0, 0, 0, 0, 0, 3, 57, 1, 0, NULL, NULL, NULL, 0, 0),
	(3, 0, 1, 1, 1, 0, 0, 0, 1, 1, NULL, 1, 1, 0, 1, '', 2, '2016-12-06 17:23:00', '', '2016-12-06 17:22:00', '', 2, '', '', 2, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'new tendernew tender', 0, 1, '2016-12-06 17:26:00', '', '', NULL, 2, NULL, '', 0.00, 0, '10', 0, NULL, NULL, NULL, '', 0, '', 1, '', 2, '', 0, 0, 0, 0, 0.00, '2016-12-06 17:25:00', 1, '2016-12-06 17:24:00', 'new tendernew tendernew tendernew tender', 'new tendernew tender', 2, 'new tender 3\r\n', 1, 0, 0.00, 1, '2016-12-07 11:53:18', 0, 0, 0, 0, 0, 0, 3, 233, 1, 0, NULL, NULL, NULL, 0, 0),
	(4, 0, 1, 1, 1, 0, 1, 0, 1, 1, NULL, 1, 1, 0, 1, '', 2, '2016-12-06 17:50:00', '', '2016-12-06 17:49:00', '', 2, '', '', 2, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'new tendernew tender', 0, 1, '2016-12-06 17:53:00', '', '', NULL, 2, NULL, '', 0.00, 0, '10', 0, NULL, NULL, NULL, '', 0, '', 1, '', 2, '', 0, 0, 0, 0, 0.00, '2016-12-06 17:52:00', 1, '2016-12-06 17:51:00', 'new tendernew tendernew tendernew tender', 'new tendernew tender this.', 2, 'new tender 4', 1, 0, 0.00, 1, '2016-12-07 12:20:10', 0, 0, 0, 0, 0, 0, 3, 233, 1, 0, NULL, NULL, NULL, 0, 0),
	(5, 0, 1, 1, 1, 0, 1, 0, 0, 1, NULL, 1, 1, 0, 1, '', 2, '2016-12-06 23:58:00', '', '2016-12-07 23:36:00', '', 2, '', '', 2, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 'new tendernew tender', 0, 1, '2016-12-08 00:11:00', '', '', NULL, 2, NULL, '', 0.00, 0, '10', 0, NULL, NULL, NULL, '', 0, '', 1, 'ahmedabad', 2, '988989898', 0, 0, 0, 0, 0.00, '2016-12-08 00:10:00', 1, '2016-12-07 23:36:00', 'new tendernew tendernew tendernew tender', 'new tendernew tender 67', 2, 'new tender', 1, 0, 0.00, 1, '2016-12-07 22:33:10', 0, 0, 0, 0, 0, 0, 3, 0, 1, 0, NULL, NULL, NULL, 0, 0),
	(6, 0, 1, 1, 1, 0, 0, 0, 1, 1, NULL, 1, 1, 0, 1, '', 2, '2016-12-05 16:53:00', '34', '2016-12-04 16:52:00', '', 2, '12', '', 2, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 'new tendernew tender', 0, 1, '2016-12-24 16:53:00', '', '', NULL, 2, NULL, '', 0.00, 0, '10', 0, NULL, NULL, NULL, '', 0, '', 1, '', 2, '23', 0, 0, 0, 0, 0.00, '2016-12-09 16:53:00', 1, '2016-12-03 16:53:00', 'new tendernew tendernew tendernew tender', 'new tendernew tender', 2, 'new tender', 1, 0, 0.00, 1, '2016-12-04 11:25:06', 0, 0, 0, 0, 0, 0, 3, 57, 1, 0, NULL, NULL, NULL, 0, 0),
	(7, 0, 1, 1, 1, 0, 0, 0, 1, 1, NULL, 1, 1, 0, 1, '', 2, NULL, '', NULL, '', 2, '', '', 2, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Djdj', 0, 2, NULL, '', '', NULL, 2, NULL, '', 0.00, 0, '12', 0, NULL, NULL, NULL, '', 0, '', 1, '', 2, '', 0, 0, 0, 0, 0.00, NULL, 1, NULL, 'Djdjd', '<p>Djdjd</p>', 2, 'Djdj', 1, 0, 1234.00, 1, '2016-12-04 03:13:17', 0, 0, 0, 0, 0, 0, 3, 57, 1, 0, NULL, NULL, NULL, 0, 0),
	(8, 0, 1, 1, 1, 0, 0, 0, 1, 1, NULL, 1, 1, 0, 1, '', 2, NULL, '', NULL, '', 2, '', '', 2, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Corrigendum Test', 0, 1, NULL, '', '', NULL, 2, NULL, '', 0.00, 0, '0', 0, NULL, NULL, NULL, '', 0, '', 1, '', 2, '', 0, 0, 0, 0, 0.00, NULL, 1, NULL, 'Corrigendum Test', '<p>Corrigendum Test<br></p>', 2, 'Corrigendum Test', 1, 0, 0.00, 1, '2016-12-04 09:14:48', 0, 0, 0, 0, 0, 0, 3, 57, 1, 0, NULL, NULL, NULL, 0, 0),
	(9, 0, 1, 1, 1, 0, 0, 0, 1, 1, NULL, 1, 1, 0, 1, '', 2, NULL, '', NULL, '', 2, '323', 'Test Corrigendum', 2, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Test Corrigendum', 0, 64, NULL, '', '', NULL, 2, NULL, '', 0.00, 0, '0', 0, NULL, NULL, NULL, '', 0, '', 1, '', 2, '', 0, 0, 0, 0, 0.00, NULL, 1, NULL, 'Test Corrigendum', '<p>Test Corrigendum<br></p>', 2, 'Test Corrigendum', 1, 0, 0.00, 1, '2016-12-05 17:09:31', 0, 0, 0, 0, 0, 0, 3, 58, 1, 0, NULL, NULL, NULL, 0, 0),
	(10, 0, 1, 1, 1, 0, 2, 0, 1, 1, NULL, 1, 1, 0, 1, '', 2, '2016-12-07 22:00:00', '', '2016-12-07 22:00:00', '', 2, '2121', 'Ahmedabad', 2, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'Test Keywords', 0, 1, '2016-12-07 18:47:00', '', '', NULL, 2, NULL, '', 0.00, 0, '0', 0, NULL, NULL, NULL, '', 0, '', 1, '', 2, '', 0, 0, 0, 0, 0.00, '2016-12-07 18:46:00', 1, '2016-12-07 22:00:00', 'Test Scope', '<p>Test Details</p>', 2, 'Reference Number', 1, 0, 0.00, 1, '2016-12-07 16:07:25', 0, 0, 0, 0, 0, 0, 3, 159, 1, 0, NULL, NULL, NULL, 0, 0),
	(11, 0, 1, 1, 1, 0, 1, 0, 1, 1, NULL, 1, 1, 0, 1, '', 2, '2016-12-07 19:30:00', '', '2016-12-07 19:00:00', '', 2, '12345.00', 'Ahmedabad', 2, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Demo Keywords', 0, 264, '2016-12-07 19:31:00', '', '', NULL, 2, NULL, '', 0.00, 0, '12', 0, NULL, NULL, NULL, '', 0, '', 1, '', 2, '', 0, 0, 0, 0, 0.00, '2016-12-07 19:30:00', 1, '2016-12-07 19:00:00', 'Demo Scope', '<p>Demo Details&#8195;</p>', 1, 'Demo Reference No.', 1, 0, 121212.00, 1, '2016-12-07 18:56:04', 0, 0, 0, 0, 0, 0, 3, 261, 1, 0, NULL, NULL, NULL, 0, 0),
	(12, 0, 1, 1, 1, 0, 0, 0, 1, 1, NULL, 1, 1, 0, 1, '', 2, '2016-12-08 04:25:00', '', '2016-12-08 03:25:00', '', 2, '1000', 'ahmedabad', 2, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Demo keywords', 0, 1, '2016-12-08 04:26:00', '', '', NULL, 2, NULL, '', 0.00, 0, '0', 0, NULL, NULL, NULL, '', 0, '', 1, '', 2, '', 0, 0, 0, 0, 0.00, '2016-12-08 04:25:00', 1, '2016-12-08 03:25:00', 'Demo Scope', '<p>Demo Details</p>', 2, 'Demo Tender 2', 1, 0, 0.00, 1, '2016-12-08 02:56:29', 0, 0, 0, 0, 0, 0, 3, 261, 1, 0, NULL, NULL, NULL, 0, 0),
	(13, 0, 1, 1, 1, 0, 0, 0, 1, 1, NULL, 1, 1, 0, 1, '', 2, '2016-12-07 13:04:00', '', '2016-12-07 13:03:00', '', 2, '', '', 2, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'test 12/8', 0, 1, '2016-12-07 13:07:00', '', '', NULL, 2, NULL, '', 0.00, 0, '10', 0, NULL, NULL, NULL, '', 0, '', 1, '', 2, '', 0, 0, 0, 0, 0.00, '2016-12-08 13:06:00', 1, '2016-12-07 13:05:00', 'test 12/8', '<p>test 12/8<br></p>', 2, 'test 12/8', 1, 0, 1000.00, 1, '2016-12-08 07:33:04', 0, 0, 0, 0, 0, 0, 3, 57, 1, 0, NULL, NULL, NULL, 0, 0),
	(14, 0, 1, 1, 1, 0, 0, 0, 1, 1, NULL, 1, 1, 0, 1, '', 2, '2016-12-08 09:01:00', '', '2016-12-08 09:00:00', '', 2, '', '', 2, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'test', 0, 1, '2016-12-08 09:04:00', '', '', NULL, 2, NULL, '', 0.00, 0, '0', 0, NULL, NULL, NULL, '', 0, '', 1, '', 2, '', 0, 0, 0, 0, 0.00, '2016-12-08 09:03:00', 1, '2016-12-08 09:02:00', 'test2', '<p>tet&nbsp;</p>', 2, 'test 2', 1, 0, 0.00, 1, '2016-12-08 09:22:08', 0, 0, 0, 0, 0, 0, 3, 57, 1, 0, NULL, NULL, NULL, 0, 0),
	(15, 0, 1, 1, 1, 0, 1, 0, 1, 1, NULL, 1, 1, 0, 1, '', 2, '2016-12-07 17:13:00', '', '2016-12-07 17:12:00', '', 2, '', '', 2, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'test', 0, 1, '2016-12-07 17:16:00', '', '', NULL, 2, NULL, '', 0.00, 0, '10', 0, NULL, NULL, NULL, '', 0, '', 1, '', 2, '', 0, 0, 0, 0, 0.00, '2016-12-07 17:15:00', 1, '2016-12-07 17:14:00', 'Brieef', '<p>details&nbsp;</p>', 2, 'Demo 1 23', 1, 0, 1000.00, 1, '2016-12-08 11:43:17', 0, 0, 0, 0, 0, 0, 3, 302, 1, 0, NULL, NULL, NULL, 0, 0),
	(16, 0, 1, 1, 1, 0, 0, 0, 1, 1, NULL, 1, 1, 0, 1, '', 2, NULL, '', NULL, '', 2, '', '', 2, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'ref1', 0, 1, NULL, '', '', NULL, 2, NULL, '', 0.00, 0, '0', 0, NULL, NULL, NULL, '', 0, '', 1, '', 2, '', 0, 0, 0, 0, 0.00, NULL, 1, NULL, 'test ref1', '<p>test ref1<br></p>', 2, 'ref/1', 1, 0, 0.00, 1, '2016-12-10 09:59:51', 0, 0, 0, 0, 0, 0, 3, 159, 1, 0, NULL, NULL, NULL, 0, 0),
	(17, 0, 1, 1, 1, 0, 0, 0, 1, 1, NULL, 0, 1, 0, 1, '', 0, NULL, '', NULL, '', 2, '1212', 'test', 2, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'Test Scope Work', 0, 1, NULL, '', '', NULL, 2, NULL, '', 0.00, 0, '0', 0, NULL, NULL, NULL, '', 0, '', 1, '', 0, '', 0, 0, 0, 0, 0.00, NULL, 1, NULL, 'Test Scope Work', '<p>Test Scope Work<br></p>', 2, 'Test Reference', 2, 0, 0.00, 4, '2016-12-24 06:13:29', 0, 0, 0, 0, 0, 0, 3, 57, 1, 0, NULL, NULL, NULL, 0, 0),
	(18, 0, 1, 1, 1, 0, 0, 0, 1, 1, NULL, 0, 1, 0, 1, '', 2, NULL, '', NULL, '', 2, '564', 'test', 2, 2, 2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'Test1', 0, 1, NULL, '', '', NULL, 2, NULL, '', 0.00, 0, '0', 0, NULL, NULL, NULL, '', 0, '', 1, '', 2, '', 0, 0, 0, 0, 0.00, NULL, 1, NULL, 'Test1', '<p>qTest1&#8195;</p>', 2, 'Test1', 1, 0, 0.00, 1, '2016-12-13 18:46:45', 0, 0, 0, 0, 0, 0, 3, 57, 1, 0, NULL, NULL, NULL, 0, 0),
	(19, 0, 1, 1, 1, 0, 0, 0, 1, 1, NULL, 0, 1, 0, 1, '', 2, NULL, '', NULL, '', 2, '2121', 'fg', 2, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'gfg', 0, 2, NULL, '', '', NULL, 2, NULL, '', 0.00, 0, '0', 0, NULL, NULL, NULL, '', 0, '', 1, '', 2, '', 0, 0, 0, 0, 0.00, NULL, 1, NULL, 'gfd', '<p>gffgf</p>', 2, 'ggfd', 1, 0, 0.00, 1, '2016-12-13 18:51:48', 0, 0, 0, 0, 0, 0, 3, 58, 1, 0, NULL, NULL, NULL, 0, 0),
	(20, 0, 1, 1, 1, 0, 0, 0, 1, 1, NULL, 0, 1, 0, 1, '', 2, NULL, '', NULL, '', 2, '', '', 2, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'gfg', 0, 2, NULL, '', '', NULL, 2, NULL, '', 0.00, 0, '0', 0, NULL, NULL, NULL, '', 0, '', 1, '', 2, '', 0, 0, 0, 0, 0.00, NULL, 1, NULL, 'fgfgfg', '<p>gfgfg</p>', 2, 'dfgfdg', 1, 0, 0.00, 1, '2016-12-13 18:53:16', 0, 0, 0, 0, 0, 0, 3, 58, 1, 0, NULL, NULL, NULL, 0, 0),
	(21, 0, 1, 1, 1, 0, 0, 0, 1, 1, NULL, 0, 1, 0, 1, '', 2, NULL, '', NULL, '', 2, '', '', 2, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'Test1', 0, 1, NULL, '', '', NULL, 2, NULL, '', 0.00, 0, '0', 0, NULL, NULL, NULL, '', 0, '', 1, '', 2, '', 0, 0, 0, 0, 0.00, NULL, 1, NULL, 'Test1', '<p>Test1<br></p>', 2, 'c', 1, 0, 0.00, 1, '2016-12-13 18:58:36', 0, 0, 0, 0, 0, 0, 3, 57, 1, 0, NULL, NULL, NULL, 0, 0),
	(22, 0, 1, 1, 1, 0, 0, 0, 1, 1, NULL, 0, 1, 0, 1, '', 2, NULL, '', NULL, '', 2, '', '', 2, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'fg', 0, 1, NULL, '', '', NULL, 2, NULL, '', 0.00, 0, '0', 0, NULL, NULL, NULL, '', 0, '', 1, '', 2, '', 0, 0, 0, 0, 0.00, NULL, 1, NULL, 'gfgf', '<p>gf</p>', 2, 'gfgf', 1, 0, 0.00, 1, '2016-12-13 19:00:37', 0, 0, 0, 0, 0, 0, 3, 57, 1, 0, NULL, NULL, NULL, 0, 0),
	(23, 0, 1, 1, 1, 0, 0, 0, 2, 1, NULL, 1, 1, 0, 1, '', 2, NULL, '', NULL, '', 2, '', '', 2, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'Cjd', 0, 1, NULL, '', '', NULL, 2, NULL, '', 0.00, 0, '0', 0, NULL, NULL, NULL, '', 0, '', 1, '', 2, '', 0, 0, 0, 0, 0.00, NULL, 1, NULL, 'Dj', '<p>Jd</p>', 2, 'Fjd', 2, 0, 0.00, 1, '2016-12-19 01:40:41', 0, 0, 0, 0, 0, 0, 3, 57, 1, 0, NULL, NULL, NULL, 0, 0),
	(24, 0, 1, 1, 1, 0, 1, 0, 1, 1, NULL, 1, 1, 0, 1, '', 2, '2016-12-19 08:10:00', '', '2016-12-19 07:53:00', '', 2, '', '', 2, 2, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'Fjfjd', 0, 1, '2016-12-19 08:11:00', '', '', NULL, 2, NULL, '', 0.00, 0, '0', 0, NULL, NULL, NULL, '', 0, '', 1, '', 2, '', 0, 0, 0, 0, 0.00, '2016-12-19 08:10:00', 1, '2016-12-19 07:53:00', 'F HD j', '<p>Fhfjd</p>', 1, 'Bidding testing', 1, 0, 0.00, 1, '2016-12-19 02:20:55', 0, 0, 0, 0, 0, 0, 3, 57, 1, 0, NULL, NULL, NULL, 0, 0),
	(25, 0, 1, 1, 1, 0, 0, 0, 3, 1, NULL, 0, 1, 0, 1, '', 2, NULL, '', NULL, '', 2, '', '', 2, 2, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'Dbd', 0, 1, NULL, '', '', NULL, 2, NULL, '', 0.00, 0, '0', 0, NULL, NULL, NULL, '', 0, '', 1, '', 2, '', 0, 0, 0, 0, 0.00, NULL, 1, NULL, 'Bdn', '<p>Dhh</p>', 1, 'Djd', 1, 0, 0.00, 1, '2016-12-20 04:31:13', 0, 0, 0, 0, 0, 0, 3, 260, 1, 0, NULL, NULL, NULL, 0, 0),
	(26, 0, 1, 1, 1, 0, 0, 0, 3, 1, NULL, 0, 1, 0, 1, '', 2, '2016-12-20 01:01:00', '', '2016-12-20 00:45:00', '', 2, '100', '', 2, 2, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'Test for the Demo', 0, 1, '2016-12-20 01:02:00', '', '', '2016-12-20 00:59:00', 2, '2016-12-20 00:45:00', '', 0.00, 0, '0', 0, NULL, NULL, NULL, '', 0, '', 1, '', 2, '', 0, 0, 0, 0, 0.00, '2016-12-20 01:00:00', 1, '2016-12-20 00:45:00', 'Test for the Demo', '<p>Test for the Demo<br></p>', 3, 'Test for the Demo', 2, 0, 0.00, 1, '2016-12-19 19:20:16', 0, 0, 0, 0, 0, 0, 3, 58, 1, 0, NULL, NULL, NULL, 0, 0),
	(27, 0, 1, 1, 1, 0, 0, 0, 2, 1, NULL, 0, 1, 0, 1, '', 2, NULL, '', NULL, '', 2, '', '', 2, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'test', 0, 4, NULL, '', '', NULL, 2, NULL, '', 0.00, 0, '0', 0, NULL, NULL, NULL, '', 0, '', 1, '', 2, '', 0, 0, 0, 0, 0.00, NULL, 1, NULL, 'tet', '<p>tedt</p>', 2, 'test', 2, 0, 0.00, 1, '2016-12-20 19:53:02', 0, 0, 0, 0, 0, 0, 3, 160, 1, 0, NULL, NULL, NULL, 0, 0),
	(28, 0, 1, 1, 1, 0, 0, 0, 1, 1, NULL, 0, 1, 0, 1, '', 0, '2016-12-25 10:18:00', '', '2016-12-23 10:18:00', '', 2, '122', 'emd', 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 'Testing for the demo', 0, 1, '2016-12-26 10:18:00', '', '', NULL, 2, NULL, '', 0.00, 0, '0', 0, NULL, NULL, NULL, '', 0, '', 1, 'adress', 2, '112', 0, 0, 0, 0, 0.00, '2016-12-25 10:18:00', 1, '2016-12-23 10:18:00', 'Testing for the demo', '<p>Testing for the demo<br></p>', 2, 'Testing for the demo', 2, 0, 0.00, 4, '2016-12-24 04:49:19', 0, 0, 0, 0, 0, 0, 3, 57, 1, 0, NULL, NULL, NULL, 0, 0),
	(29, 0, 1, 1, 1, 0, 0, 0, 1, 1, NULL, 0, 1, 0, 1, '', 0, '2016-12-21 06:55:00', '', '2016-12-21 06:43:00', '', 2, '123', 'test', 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'Demo Event', 0, 1, '2016-12-21 06:57:00', '', '', '2016-12-21 06:54:00', 2, '2016-12-21 06:43:00', '', 0.00, 0, '0', 0, NULL, NULL, NULL, '', 0, '', 1, '', 0, '', 0, 0, 0, 0, 0.00, '2016-12-21 06:55:00', 1, '2016-12-21 06:43:00', 'Demo Event', '<p>Demo Event<br></p>', 2, 'Demo Event', 2, 0, 0.00, 1, '2016-12-20 21:19:33', 0, 0, 0, 0, 0, 0, 3, 261, 1, 0, NULL, NULL, NULL, 0, 0),
	(30, 0, 1, 1, 1, 0, 0, 0, 1, 263, NULL, 1, 1, 0, 1, '', 0, '2016-12-22 03:10:00', '', '2016-12-22 02:55:00', '', 2, '120', '', 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Demo event 1', 0, 1, '2016-12-22 03:11:00', '', 'test', '2016-12-22 02:59:00', 2, '2016-12-22 02:55:00', '', 0.00, 0, '0', 0, NULL, NULL, NULL, '', 0, '', 1, '', 0, '', 0, 0, 0, 0, 0.00, '2016-12-22 03:10:00', 1, '2016-12-22 02:55:00', 'Demo event 1', '<p>Demo event 1<br></p>', 2, 'Demo event 1', 1, 0, 0.00, 263, '2016-12-21 15:23:12', 0, 0, 0, 0, 0, 0, 3, 57, 1, 0, NULL, NULL, NULL, 0, 0),
	(31, 0, 1, 1, 1, 0, 0, 0, 1, 4, NULL, 0, 1, 0, 1, '', 0, '2016-12-21 22:11:00', '', '2016-12-21 22:10:00', '', 2, '', '', 0, 2, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'dfg', 0, 1, '2016-12-22 22:06:00', '', '', NULL, 2, NULL, '', 0.00, 0, '12', 0, NULL, NULL, NULL, '', 0, '', 1, '', 0, '', 0, 0, 0, 0, 0.00, '2016-12-22 22:05:00', 1, '2016-12-21 22:12:00', 'dfg', '<p>dg</p>', 2, 'Test tender update test1', 1, 0, 12.00, 4, '2016-12-21 17:25:28', 0, 0, 0, 0, 0, 0, 3, 57, 1, 0, NULL, NULL, NULL, 0, 0),
	(32, 0, 1, 1, 1, 0, 0, 0, 1, 855, NULL, 0, 1, 0, 1, '', 0, '2016-12-22 04:50:00', '', '2016-12-22 04:40:00', '', 2, '12345', '', 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'Workflow Testing', 0, 856, '2016-12-22 04:51:00', '', 'test', '2016-12-22 04:45:00', 2, '2016-12-22 04:41:00', '', 0.00, 0, '0', 0, NULL, NULL, NULL, '', 0, '', 1, '', 0, '', 0, 0, 0, 0, 0.00, '2016-12-22 04:50:00', 1, '2016-12-22 04:40:00', 'Workflow Testing', '<p>Workflow Testing<br></p>', 2, 'Workflow Testing', 1, 0, 0.00, 855, '2016-12-21 17:33:43', 0, 0, 0, 0, 0, 0, 3, 485, 1, 0, NULL, NULL, NULL, 0, 0),
	(33, 0, 1, 1, 1, 0, 0, 0, 1, 4, NULL, 0, 1, 0, 1, 'test', 2, '2016-12-22 23:10:00', '12', '2016-12-20 23:10:00', '', 2, '', '', 0, 2, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'test by bharat 01', 0, 4, '2016-12-31 23:11:00', '', 'address', '2016-12-22 23:11:00', 2, '2016-12-21 23:11:00', '', 0.00, 0, '12', 0, NULL, NULL, NULL, '', 0, '', 1, '', 0, '', 0, 0, 0, 0, 0.00, '2016-12-24 23:11:00', 1, '2016-12-19 23:10:00', 'test by bharat 01', '<p>test by bharat 01<br></p>', 1, 'test by bharat 01', 2, 0, 12.00, 4, '2016-12-21 17:49:45', 0, 0, 0, 0, 0, 0, 3, 57, 1, 0, NULL, NULL, NULL, 0, 0),
	(34, 0, 1, 1, 1, 0, 0, 0, 3, 263, NULL, 1, 1, 0, 1, '', 0, '2016-12-22 06:40:00', '', '2016-12-22 06:25:00', '', 2, '100', 'test', 2, 2, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'demo', 0, 1, '2016-12-22 06:41:00', '', 'test', '2016-12-22 06:30:00', 2, '2016-12-22 06:25:00', '', 0.00, 0, '0', 0, NULL, NULL, NULL, '', 0, '', 1, '', 0, '', 0, 0, 0, 0, 0.00, '2016-12-22 06:40:00', 1, '2016-12-22 06:25:00', 'demo', '<p>demo<br></p>', 2, 'demo', 2, 0, 0.00, 263, '2016-12-21 18:16:16', 0, 0, 0, 0, 0, 0, 3, 485, 1, 0, NULL, NULL, NULL, 0, 0),
	(35, 0, 1, 1, 1, 0, 1, 0, 1, 263, NULL, 1, 1, 0, 1, '', 0, '2016-12-22 01:05:00', '', '2016-12-22 00:51:00', '', 2, '123.00', 'fdf', 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'Workflow Testing', 0, 856, '2016-12-22 01:06:00', '', 'test', '2016-12-22 01:01:00', 2, '2016-12-22 01:00:00', '', 0.00, 0, '0', 0, NULL, NULL, NULL, '', 0, '', 1, '', 0, '', 0, 0, 0, 0, 0.00, '2016-12-22 01:04:00', 1, '2016-12-22 00:51:00', 'Workflow Testing', '<p>Workflow Testing<br></p>', 2, 'Workflow Testing', 2, 0, 0.00, 263, '2016-12-21 19:16:44', 0, 0, 0, 0, 0, 0, 3, 485, 1, 0, NULL, NULL, NULL, 0, 0),
	(36, 0, 1, 1, 1, 0, 0, 0, 1, 263, NULL, 1, 1, 0, 1, '', 0, '2016-12-21 20:12:00', '', '2016-12-21 20:00:00', '', 2, '12345', 'test', 2, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'bid submission testing', 0, 856, '2016-12-21 20:16:00', '', '', NULL, 2, NULL, '', 0.00, 0, '0', 0, NULL, NULL, NULL, '', 0, '', 1, '', 0, '', 0, 0, 0, 0, 0.00, '2016-12-21 20:15:00', 1, '2016-12-21 20:00:00', 'bid submission testing', '<p>bid submission testing<br></p>', 2, 'bid submission testing', 2, 0, 0.00, 263, '2016-12-21 19:53:14', 0, 0, 0, 0, 0, 0, 3, 485, 1, 0, NULL, NULL, NULL, 0, 0),
	(37, 0, 1, 1, 1, 0, 0, 0, 1, 263, NULL, 1, 1, 0, 1, '', 0, '2016-12-21 20:47:00', '', '2016-12-21 20:40:00', '', 2, '12', 'evd', 2, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Bid submission re&#45;test', 0, 856, '2016-12-21 20:48:00', '', '', NULL, 2, NULL, '', 0.00, 0, '0', 0, NULL, NULL, NULL, '', 0, '', 1, '', 0, '', 0, 0, 0, 0, 0.00, '2016-12-21 20:47:00', 1, '2016-12-21 20:40:00', 'Bid submission re&#45;test', '<p>Bid submission re-test<br></p>', 2, 'Bid submission re&#45;test', 1, 0, 0.00, 263, '2016-12-21 20:04:38', 0, 0, 0, 0, 0, 0, 3, 485, 1, 0, NULL, NULL, NULL, 0, 0),
	(38, 0, 1, 1, 1, 0, 0, 0, 2, 4, NULL, 0, 1, 0, 1, '', 0, '2016-12-26 03:55:00', '', '2016-12-23 03:55:00', '', 2, '', '', 0, 2, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'car', 0, 489, '2016-12-29 03:55:00', '', 'dddddddd', '2016-12-27 03:55:00', 2, '2016-12-24 03:55:00', '', 0.00, 0, '1212', 0, NULL, NULL, NULL, '', 0, '', 1, '', 0, '', 0, 0, 0, 0, 0.00, '2016-12-28 03:55:00', 1, '2016-12-23 03:55:00', 'Department hirarchy test tender by nirav', '<p>Department hirarchy test tender by nirav<br></p>', 2, 'Department hirarchy test tender by nirav', 2, 0, 1212.00, 4, '2016-12-21 22:28:53', 0, 0, 0, 0, 0, 0, 3, 484, 1, 1, NULL, NULL, NULL, 0, 0),
	(39, 0, 1, 1, 1, 0, 0, 0, 1, 4, NULL, 1, 1, 0, 1, '', 0, '2016-12-22 11:05:00', '', '2016-12-22 11:00:00', '', 2, '', '', 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'test11111', 0, 489, '2016-12-22 09:26:06', '', '', NULL, 2, NULL, '', 0.00, 0, '12', 0, NULL, NULL, NULL, '', 0, '', 1, '', 0, '', 0, 0, 0, 0, 0.00, '2016-12-22 09:25:06', 1, '2016-12-22 07:35:50', 'test11111', '<p>test11111<br></p>', 2, 'test11111', 1, 0, 12.00, 4, '2016-12-22 05:30:49', 0, 0, 0, 0, 0, 0, 3, 484, 1, 0, NULL, NULL, NULL, 0, 0),
	(40, 0, 1, 1, 1, 0, 0, 0, 1, 4, NULL, 0, 1, 0, 1, '', 0, NULL, '', NULL, '', 2, '', '', 0, 2, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'workflow', 0, 4, NULL, '', 'offline', NULL, 2, NULL, '', 0.00, 0, '12', 0, NULL, NULL, NULL, '', 0, '', 1, '', 0, '', 0, 0, 0, 0, 0.00, NULL, 1, NULL, 'tesy by bharat', '<p>tesy by bharat<br></p>', 1, 'tesy by bharat', 2, 0, 10.00, 4, '2016-12-22 05:39:15', 0, 0, 0, 0, 0, 0, 3, 484, 1, 0, NULL, NULL, NULL, 0, 0),
	(41, 0, 1, 1, 1, 0, 0, 0, 1, 4, NULL, 1, 1, 0, 1, '', 0, '2016-12-22 09:39:00', '', '2016-12-22 09:37:00', '', 2, '', '', 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'sdf', 0, 0, '2016-12-22 09:52:00', '', '', '2016-12-22 09:45:00', 2, '2016-12-22 09:41:00', '', 0.00, 0, '45', 0, NULL, NULL, NULL, '', 0, '', 1, '', 0, '', 0, 0, 0, 0, 0.00, '2016-12-22 09:50:00', 1, '2016-12-22 09:40:00', 'sdfsdfsdf', '<p>sdf</p>', 2, 'dsf', 1, 0, 4545.00, 4, '2016-12-22 09:35:45', 0, 0, 0, 0, 0, 0, 3, 481, 1, 0, NULL, NULL, NULL, 0, 0),
	(42, 0, 1, 1, 1, 0, 0, 0, 1, 4, NULL, 0, 1, 0, 1, '', 0, '2016-12-22 09:59:00', '', '2016-12-22 09:56:00', '', 2, '', '', 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'workflow test', 0, 4, '2016-12-22 10:21:00', '', '', NULL, 2, NULL, '', 0.00, 0, '3232', 0, NULL, NULL, NULL, '', 0, '', 1, '', 0, '', 0, 0, 0, 0, 0.00, '2016-12-22 10:20:00', 1, '2016-12-22 10:05:00', 'workflow test', '<p>workflow test&#8195;<br></p>', 2, 'workflow test', 1, 0, 43434.00, 4, '2016-12-22 09:52:19', 0, 0, 0, 0, 0, 0, 3, 484, 1, 1, NULL, NULL, NULL, 0, 0),
	(43, 0, 1, 1, 1, 0, 0, 0, 1, 4, NULL, 1, 1, 0, 1, '', 0, '2016-12-22 22:19:00', '', '2016-12-22 22:18:00', '', 2, '', '', 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Techprice', 0, 4, '2016-12-22 22:26:00', '', '', NULL, 2, NULL, '', 0.00, 0, '12', 0, NULL, NULL, NULL, '', 0, '', 1, '', 0, '', 0, 0, 0, 0, 0.00, '2016-12-22 22:25:00', 1, '2016-12-22 22:20:00', 'Techprice', '<p>Techprice<br></p>', 2, 'Techprice', 1, 0, 100.00, 4, '2016-12-22 10:18:34', 0, 0, 0, 0, 0, 0, 3, 484, 1, 0, NULL, NULL, NULL, 0, 0),
	(44, 0, 1, 1, 1, 0, 0, 0, 1, 4, NULL, 1, 1, 0, 1, '', 0, '2016-12-22 11:58:00', '', '2016-12-22 11:57:00', '', 2, '', '', 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'Demo Test Two', 0, 4, '2016-12-22 12:31:58', '', '', '2016-12-22 12:09:00', 2, '2016-12-22 12:00:00', '', 0.00, 0, '15', 0, NULL, NULL, NULL, '', 0, '', 1, '', 0, '', 0, 0, 0, 0, 0.00, '2016-12-22 12:30:58', 1, '2016-12-22 11:59:00', 'Demo Test Two', '<p>Demo Test Two<br></p>', 2, 'Demo Test Two', 1, 0, 1000.00, 4, '2016-12-22 11:56:50', 0, 0, 0, 0, 0, 0, 3, 484, 1, 0, NULL, NULL, NULL, 0, 0),
	(45, 0, 1, 1, 1, 0, 0, 0, 1, 4, NULL, 0, 1, 0, 1, '', 0, '2016-12-27 12:04:00', '', '2016-12-24 12:04:00', '', 2, '', '', 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'car', 0, 489, '2016-12-30 12:04:00', '', '', NULL, 2, NULL, '', 0.00, 0, '1222', 0, NULL, NULL, NULL, '', 0, '', 1, '', 0, '', 0, 0, 0, 0, 0.00, '2016-12-29 12:04:00', 1, '2016-12-24 12:04:00', 'tender hirarchy test', '<p>tender hirarchy test&#8195;<br></p>', 2, 'tender hirarchy test', 2, 0, 12222.00, 4, '2016-12-24 06:34:53', 0, 0, 0, 0, 0, 0, 3, 484, 1, 1, NULL, NULL, NULL, 0, 0),
	(46, 0, 1, 1, 1, 0, 1, 0, 1, 263, NULL, 2, 1, 0, 1, '', 0, '2016-12-28 16:00:00', '', '2016-12-25 17:00:00', '', 2, '121', 'fdfd', 2, 2, 2, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Smoke Test', 0, 264, '2016-12-28 17:01:00', '', '', NULL, 2, NULL, '', 0.00, 0, '0', 0, NULL, NULL, NULL, '', 0, '<p>tesr</p>', 1, '', 0, '', 0, 0, 0, 0, 0.00, '2016-12-28 16:00:00', 1, '2016-12-25 17:00:00', 'Smoke Test', '<p>Smoke Test<br></p>', 1, 'Smoke Test', 1, 0, 0.00, 263, '2016-12-25 17:08:57', 0, 0, 0, 0, 0, 0, 3, 261, 1, 0, '<p>fgdhgf</p>', '2016-12-26 23:37:48', 263, 1, 0),
	(47, 0, 1, 1, 1, 0, 0, 0, 1, 263, NULL, 2, 1, 0, 1, '', 0, '2016-12-28 16:00:00', '', '2016-12-25 17:00:00', '', 2, '121', 'fdfd', 2, 2, 2, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Smoke Test', 0, 264, '2016-12-28 17:01:00', '', '', NULL, 2, NULL, '', 0.00, 0, '0', 0, NULL, NULL, NULL, '', 0, '<p>dfd</p>', 1, '', 0, '', 0, 0, 0, 0, 0.00, '2016-12-28 16:00:00', 1, '2016-12-25 17:00:00', 'Smoke Test', '<p>Smoke Test<br></p>', 1, 'Smoke Test', 1, 0, 0.00, 263, '2016-12-25 17:08:57', 0, 0, 0, 0, 0, 0, 3, 261, 1, 0, '<p>terstr</p>', '2016-12-25 17:30:29', 263, 1, 46),
	(48, 0, 1, 1, 1, 0, 0, 0, 1, 263, NULL, 0, 1, 0, 1, '', 0, '2016-12-28 16:00:00', '', '2016-12-25 17:00:00', '', 2, '121', 'fdfd', 2, 2, 2, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Smoke Test', 0, 264, '2016-12-28 17:01:00', '', '', NULL, 2, NULL, '', 0.00, 0, '0', 0, NULL, NULL, NULL, '', 0, '<p>tesr</p>', 1, '', 0, '', 0, 0, 0, 0, 0.00, '2016-12-28 16:00:00', 1, '2016-12-25 17:00:00', 'Smoke Test', '<p>Smoke Test<br></p>', 1, 'Smoke Test', 1, 0, 0.00, 263, '2016-12-25 17:08:57', 0, 0, 0, 0, 0, 0, 3, 261, 1, 0, NULL, NULL, NULL, 1, 46),
	(49, 0, 1, 1, 1, 0, 0, 0, 1, 263, NULL, 1, 1, 0, 1, '', 0, '2016-12-28 16:00:00', '', '2016-12-25 17:00:00', '', 2, '121', 'fdfd', 2, 2, 2, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Smoke Test', 0, 264, '2016-12-28 17:01:00', '', '', NULL, 2, NULL, '', 0.00, 0, '0', 0, NULL, NULL, NULL, '', 0, '<p>tete</p>', 1, '', 0, '', 0, 0, 0, 0, 0.00, '2016-12-28 16:00:00', 1, '2016-12-25 17:00:00', 'Smoke Test1', '<p>Smoke Test<br></p>', 2, 'Smoke Test1', 1, 0, 0.00, 263, '2016-12-25 18:02:06', 0, 0, 0, 0, 0, 0, 3, 261, 1, 0, NULL, NULL, NULL, 0, 46),
	(50, 0, 1, 1, 1, 0, 0, 0, 1, 263, NULL, 0, 1, 0, 1, '', 0, '2016-12-28 16:00:00', '', '2016-12-25 17:00:00', '', 2, '121', 'fdfd', 2, 2, 2, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Smoke Test', 0, 264, '2016-12-28 17:01:00', '', '', NULL, 2, NULL, '', 0.00, 0, '0', 0, NULL, NULL, NULL, '', 0, '', 1, '', 0, '', 0, 0, 0, 0, 0.00, '2016-12-28 16:00:00', 1, '2016-12-25 17:00:00', 'Smoke Test1', '<p>Smoke Test<br></p>', 2, 'Smoke Test1', 1, 0, 0.00, 263, '2016-12-25 18:08:28', 0, 0, 0, 0, 0, 0, 3, 261, 1, 0, NULL, NULL, NULL, 0, 49),
	(51, 0, 1, 1, 1, 0, 1, 0, 1, 4, NULL, 1, 1, 0, 1, '', 0, '2016-12-26 01:17:00', '', '2016-12-26 01:16:00', '', 2, '', '', 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'test026', 0, 4, '2016-12-26 01:31:00', '', '', NULL, 2, NULL, '', 0.00, 0, '10', 0, NULL, NULL, NULL, '', 0, '<p>gjhgjhhg</p>', 1, '', 0, '', 0, 0, 0, 0, 0.00, '2016-12-26 01:30:00', 1, '2016-12-26 13:31:57', 'test026', '<p>test026&#8195;<br></p>', 2, 'test026', 1, 0, 1200.00, 4, '2016-12-26 13:15:52', 0, 0, 0, 0, 0, 0, 3, 484, 1, 0, NULL, NULL, NULL, 0, 0),
	(52, 0, 1, 1, 1, 0, 0, 0, 2, 263, NULL, 0, 1, 0, 1, 'tedt', 2, NULL, '353', NULL, '', 2, '', '', 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'Smoke test3', 0, 264, NULL, '', '', NULL, 2, NULL, '', 0.00, 0, '0', 0, NULL, NULL, NULL, '', 0, '', 1, '', 0, '', 0, 0, 0, 0, 0.00, NULL, 1, NULL, 'Smoke test3', '<p>Smoke test3<br></p>', 2, 'Smoke test3', 1, 0, 0.00, 263, '2016-12-26 15:51:53', 0, 0, 0, 0, 0, 0, 3, 261, 1, 0, NULL, NULL, NULL, 1, 0),
	(53, 0, 1, 1, 1, 0, 0, 0, 1, 4, NULL, 1, 1, 0, 1, '', 0, '2016-12-27 04:54:00', '', '2016-12-27 04:40:00', '', 2, '', '', 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'Demo Test Two', 0, 4, '2016-12-27 04:55:00', '', '', '2016-12-27 04:42:00', 2, '2016-12-27 04:40:00', '', 0.00, 0, '15', 0, NULL, NULL, NULL, '', 0, '<p>ghfg</p>', 1, '', 0, '', 0, 0, 0, 0, 0.00, '2016-12-27 04:54:00', 1, '2016-12-27 04:40:00', 'Demo Test Two', '<p>Demo Test Two<br></p>', 2, 'Demo Test Two', 1, 0, 1000.00, 932, '2016-12-26 23:09:53', 0, 0, 0, 0, 0, 0, 3, 484, 1, 0, NULL, NULL, NULL, 0, 44),
	(54, 0, 1, 1, 1, 0, 2, 0, 1, 932, NULL, 1, 1, 0, 1, '', 0, '2016-12-26 10:35:00', '', '2016-12-26 10:25:00', '', 2, '4343', '54354', 2, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'Demo Run', 0, 933, '2016-12-27 04:59:00', '', 'test', '2016-12-26 10:28:00', 2, '2016-12-26 10:25:00', '', 0.00, 0, '0', 0, NULL, NULL, NULL, '', 0, '<p>test</p>', 1, '', 0, '', 0, 0, 0, 0, 0.00, '2016-12-27 04:58:00', 1, '2016-12-26 10:25:00', 'Demo Run', '<p>Demo Run<br></p>', 2, 'Demo Run', 2, 0, 0.00, 263, '2016-12-26 22:51:07', 0, 0, 0, 0, 0, 0, 3, 926, 1, 0, NULL, NULL, NULL, 0, 0),
	(55, 0, 1, 1, 1, 0, 2, 0, 2, 263, NULL, 1, 1, 0, 1, '', 0, '2016-12-26 11:25:00', '', '2016-12-26 11:20:00', '', 2, '', '', 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'tedst', 0, 264, '2016-12-27 16:00:00', '', '', NULL, 2, NULL, '', 0.00, 0, '0', 0, NULL, NULL, NULL, '', 0, '<p>vgngf</p>', 1, '', 0, '', 0, 0, 0, 0, 0.00, '2016-12-27 16:00:00', 1, '2016-12-26 11:20:00', 'test', '<p>test</p>', 2, 'test', 2, 0, 0.00, 263, '2016-12-26 23:19:52', 0, 0, 0, 0, 0, 0, 3, 261, 1, 0, NULL, NULL, NULL, 0, 0),
	(56, 0, 1, 1, 1, 0, 0, 0, 1, 263, NULL, 2, 1, 0, 1, '', 0, NULL, '', NULL, '', 2, '', '', 0, 2, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'gfg', 0, 264, NULL, '', '', NULL, 2, NULL, '', 0.00, 0, '0', 0, NULL, NULL, NULL, '', 0, '', 1, '', 0, '', 0, 0, 0, 0, 0.00, NULL, 1, NULL, 'dgffd', '<p>fdfd</p>', 1, 'fdf', 2, 0, 0.00, 263, '2016-12-26 23:36:15', 0, 0, 0, 0, 0, 0, 3, 261, 1, 1, '<p>test</p>', '2016-12-27 09:27:09', 2, 0, 0),
	(57, 0, 1, 1, 1, 0, 1, 0, 1, 2, NULL, 1, 1, 0, 1, '', 0, '2016-12-27 08:37:00', '', '2016-12-27 08:36:00', '', 2, '', '', 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'test 27/12', 0, 164, '2016-12-27 09:21:00', '', '', NULL, 2, NULL, '', 0.00, 0, '10', 0, NULL, NULL, NULL, '', 0, '<p>test</p>', 1, '', 0, '', 0, 0, 0, 0, 0.00, '2016-12-27 09:20:00', 1, '2016-12-27 08:38:00', 'test 27/12', '<p>27/12/2016 08:45<br></p>', 2, 'test 27/12', 2, 0, 1000.00, 2, '2016-12-27 08:36:38', 0, 0, 0, 0, 0, 0, 3, 59, 1, 0, NULL, NULL, NULL, 0, 0),
	(58, 0, 1, 1, 1, 0, 2, 0, 2, 263, NULL, 1, 1, 0, 1, '', 0, '2016-12-28 03:19:00', '', '2016-12-28 03:13:00', '', 2, '100', 'Ahmedabad', 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'hardware', 0, 264, '2016-12-28 03:24:00', '', 'Ahmedabad', '2016-12-28 02:39:00', 2, '2016-12-28 02:30:00', '', 0.00, 0, '0', 0, NULL, NULL, NULL, '', 0, '<p>test</p>', 1, '', 0, '', 0, 0, 0, 0, 0.00, '2016-12-28 03:23:00', 1, '2016-12-28 03:13:00', 'Purchase of laptop', '<p>Purchase of laptop<br></p>', 2, 'ABCD/1234', 1, 0, 0.00, 263, '2016-12-28 02:54:18', 0, 0, 0, 0, 0, 0, 3, 261, 1, 0, NULL, NULL, NULL, 1, 0),
	(59, 0, 1, 1, 1, 0, 0, 0, 2, 263, NULL, 2, 1, 0, 1, '', 0, '2016-12-28 03:19:00', '', '2016-12-28 03:13:00', '', 2, '100', 'Ahmedabad', 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 'hardware', 0, 264, '2016-12-28 03:24:00', '', 'Ahmedabad', '2016-12-28 02:39:00', 2, '2016-12-28 02:30:00', '', 0.00, 0, '0', 0, NULL, NULL, NULL, '', 0, '<p>test</p>', 1, '', 0, '', 0, 0, 0, 0, 0.00, '2016-12-28 03:23:00', 1, '2016-12-28 03:13:00', 'Purchase of laptop', '<p>Purchase of laptop<br></p>', 2, 'ABCD/1234', 1, 0, 0.00, 263, '2016-12-28 02:54:18', 0, 0, 0, 0, 0, 0, 3, 261, 1, 0, '<p>test</p>', '2016-12-28 03:30:51', 263, 1, 58);
/*!40000 ALTER TABLE `tbl_tender` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_tenderaudittrail
DROP TABLE IF EXISTS `tbl_tenderaudittrail`;
CREATE TABLE IF NOT EXISTS `tbl_tenderaudittrail` (
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

-- Dumping data for table eauctiontender.tbl_tenderaudittrail: ~0 rows (approximately)
/*!40000 ALTER TABLE `tbl_tenderaudittrail` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_tenderaudittrail` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_tenderbid
DROP TABLE IF EXISTS `tbl_tenderbid`;
CREATE TABLE IF NOT EXISTS `tbl_tenderbid` (
  `bidId` int(11) NOT NULL AUTO_INCREMENT,
  `bidPrice` decimal(10,0) DEFAULT NULL,
  `createdBy` int(11) NOT NULL,
  `createdOn` datetime DEFAULT CURRENT_TIMESTAMP,
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
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_tenderbid: ~24 rows (approximately)
/*!40000 ALTER TABLE `tbl_tenderbid` DISABLE KEYS */;
INSERT INTO `tbl_tenderbid` (`bidId`, `bidPrice`, `createdBy`, `createdOn`, `cstatus`, `ipAddress`, `companyid`, `tenderid`, `envelopeid`, `formid`, `bidderid`) VALUES
	(1, 10, 4, '2016-11-24 17:00:00', 1, '192.168.2.1', 1, 2, 10, 1, 9),
	(2, 10, 4, '2016-11-24 17:00:00', 1, '192.168.2.1', 1, 3, 11, 2, 9),
	(3, 10, 4, '2016-11-24 17:00:00', 1, '192.168.2.1', 1, 4, 12, 3, 9),
	(4, 10, 4, '2016-11-24 17:00:00', 1, '192.168.2.1', 1, 10, 13, 6, 9),
	(5, 10, 4, '2016-11-24 17:00:00', 1, '192.168.2.1', 1, 5, 7, 9, 256),
	(6, 10, 4, '2016-11-24 17:00:00', 1, '192.168.2.1', 1, 13, 16, 10, 256),
	(7, 10, 4, '2016-11-24 17:00:00', 1, '192.168.2.1', 281, 13, 16, 10, 282),
	(8, 10, 4, '2016-11-24 17:00:00', 1, '192.168.2.1', 295, 14, 17, 11, 296),
	(9, 10, 4, '2016-11-24 17:00:00', 1, '192.168.2.1', 292, 14, 17, 11, 293),
	(10, 10, 4, '2016-11-24 17:00:00', 1, '192.168.2.1', 300, 15, 18, 12, 301),
	(11, 10, 4, '2016-11-24 17:00:00', 1, '192.168.2.1', 292, 15, 18, 12, 293),
	(13, 0, 254, '2016-12-22 08:29:17', 2, '122.169.94.122', 255, 39, 56, 44, 256),
	(14, 0, 254, '2016-12-22 09:43:53', 2, '122.169.94.122', 255, 41, 58, 47, 256),
	(15, 0, 254, '2016-12-22 12:26:56', 2, '122.169.94.122', 255, 44, 61, 49, 256),
	(17, 0, 254, '2016-12-26 13:40:31', 2, '122.169.94.122', 255, 51, 68, 52, 256),
	(18, 0, 254, '2016-12-26 13:40:47', 2, '122.169.94.122', 255, 51, 69, 53, 256),
	(20, 0, 254, '2016-12-27 09:14:00', 2, '122.169.94.122', 255, 57, 78, 62, 256),
	(21, 0, 254, '2016-12-27 09:14:13', 2, '122.169.94.122', 255, 57, 79, 63, 256),
	(22, 0, 920, '2016-12-28 03:13:40', 2, '49.34.62.52', 921, 58, 80, 64, 922),
	(23, 0, 920, '2016-12-28 03:14:12', 2, '49.34.62.52', 921, 58, 81, 65, 922),
	(24, 0, 920, '2016-12-28 03:14:33', 2, '49.34.62.52', 921, 58, 82, 66, 922),
	(25, 0, 254, '2016-12-28 03:15:42', 2, '49.34.62.52', 255, 58, 80, 64, 256),
	(26, 0, 254, '2016-12-28 03:16:18', 2, '49.34.62.52', 255, 58, 81, 65, 256),
	(27, 0, 254, '2016-12-28 03:16:29', 2, '49.34.62.52', 255, 58, 82, 66, 256);
/*!40000 ALTER TABLE `tbl_tenderbid` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_tenderbidconfirmation
DROP TABLE IF EXISTS `tbl_tenderbidconfirmation`;
CREATE TABLE IF NOT EXISTS `tbl_tenderbidconfirmation` (
  `bidConfirmationId` int(11) NOT NULL AUTO_INCREMENT,
  `createdBy` int(11) NOT NULL,
  `createdOn` datetime DEFAULT CURRENT_TIMESTAMP,
  `encodedName` longtext,
  `ipAddress` longtext NOT NULL,
  `companyid` int(11) NOT NULL,
  `tenderid` int(11) NOT NULL,
  `bidderid` int(11) NOT NULL,
  `termNcondId` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`bidConfirmationId`),
  KEY `FK_tbl_tenderbidconfirmation_tender` (`tenderid`),
  KEY `FK_tbl_tenderbidconfirmation_company` (`companyid`),
  CONSTRAINT `FK7jgdp6wkl4cj6wum1go3cl5a3` FOREIGN KEY (`companyid`) REFERENCES `tbl_company` (`companyid`),
  CONSTRAINT `FK_tbl_tenderbidconfirmation_company` FOREIGN KEY (`companyid`) REFERENCES `tbl_company` (`companyid`),
  CONSTRAINT `FK_tbl_tenderbidconfirmation_tender` FOREIGN KEY (`tenderid`) REFERENCES `tbl_tender` (`tenderId`),
  CONSTRAINT `FKb1s590y4enveq9b79draepwcu` FOREIGN KEY (`tenderid`) REFERENCES `tbl_tender` (`tenderId`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_tenderbidconfirmation: ~5 rows (approximately)
/*!40000 ALTER TABLE `tbl_tenderbidconfirmation` DISABLE KEYS */;
INSERT INTO `tbl_tenderbidconfirmation` (`bidConfirmationId`, `createdBy`, `createdOn`, `encodedName`, `ipAddress`, `companyid`, `tenderid`, `bidderid`, `termNcondId`) VALUES
	(22, 254, '2016-12-26 13:38:06', 'test', '122.169.94.122', 255, 51, 256, 1),
	(23, 920, '2016-12-26 23:27:51', 'test', '49.34.149.217', 921, 55, 922, 1),
	(24, 254, '2016-12-27 08:41:51', 'test', '122.169.94.122', 255, 57, 256, 1),
	(25, 920, '2016-12-28 03:13:06', 'test', '49.34.62.52', 921, 58, 922, 1),
	(26, 254, '2016-12-28 03:15:29', 'test', '49.34.62.52', 255, 58, 256, 1);
/*!40000 ALTER TABLE `tbl_tenderbidconfirmation` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_tenderbidcurrency
DROP TABLE IF EXISTS `tbl_tenderbidcurrency`;
CREATE TABLE IF NOT EXISTS `tbl_tenderbidcurrency` (
  `bidCurrencyId` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) NOT NULL,
  `tenderCurrencyId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  PRIMARY KEY (`bidCurrencyId`),
  KEY `FK_tbl_tenderbidcurrency_company` (`companyId`),
  KEY `FK_tbl_tenderbidcurrency_currency` (`tenderCurrencyId`),
  CONSTRAINT `FK_tbl_tenderbidcurrency_company` FOREIGN KEY (`companyId`) REFERENCES `tbl_company` (`companyid`),
  CONSTRAINT `FK_tbl_tenderbidcurrency_currency` FOREIGN KEY (`tenderCurrencyId`) REFERENCES `tbl_tendercurrency` (`tenderCurrencyId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_tenderbidcurrency: ~0 rows (approximately)
/*!40000 ALTER TABLE `tbl_tenderbidcurrency` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_tenderbidcurrency` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_tenderbiddermap
DROP TABLE IF EXISTS `tbl_tenderbiddermap`;
CREATE TABLE IF NOT EXISTS `tbl_tenderbiddermap` (
  `mapBidderId` int(11) NOT NULL AUTO_INCREMENT,
  `tenderId` int(11) NOT NULL,
  `bidderId` int(11) NOT NULL,
  `userId` bigint(20) NOT NULL,
  `createdBy` int(11) NOT NULL,
  `ipAddress` varchar(50) NOT NULL,
  `createdOn` datetime NOT NULL,
  PRIMARY KEY (`mapBidderId`),
  KEY `FKtender` (`tenderId`),
  KEY `FKbidder` (`bidderId`),
  KEY `FKuser` (`userId`),
  CONSTRAINT `FKbidder` FOREIGN KEY (`bidderId`) REFERENCES `tbl_bidder` (`bidderId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FKtender` FOREIGN KEY (`tenderId`) REFERENCES `tbl_tender` (`tenderId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FKuser` FOREIGN KEY (`userId`) REFERENCES `tbl_userlogin` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_tenderbiddermap: ~50 rows (approximately)
/*!40000 ALTER TABLE `tbl_tenderbiddermap` DISABLE KEYS */;
INSERT INTO `tbl_tenderbiddermap` (`mapBidderId`, `tenderId`, `bidderId`, `userId`, `createdBy`, `ipAddress`, `createdOn`) VALUES
	(6, 11, 256, 254, 1, '14.97.10.159', '2016-12-07 19:16:06'),
	(8, 12, 256, 254, 1, '14.97.86.123', '2016-12-08 02:59:02'),
	(10, 5, 282, 280, 1, '43.243.38.19', '2016-12-08 06:28:52'),
	(11, 5, 256, 254, 1, '43.243.38.19', '2016-12-08 06:29:24'),
	(12, 13, 256, 254, 1, '43.243.38.19', '2016-12-08 07:34:15'),
	(13, 13, 282, 280, 1, '43.243.38.19', '2016-12-08 07:34:27'),
	(14, 14, 296, 294, 1, '43.243.38.19', '2016-12-08 09:14:22'),
	(15, 14, 256, 254, 1, '43.243.38.19', '2016-12-08 09:14:35'),
	(16, 14, 293, 291, 1, '43.243.38.19', '2016-12-08 09:14:35'),
	(17, 15, 301, 299, 1, '43.243.38.19', '2016-12-08 11:44:37'),
	(18, 17, 256, 254, 1, '115.117.224.101', '2016-12-13 17:48:12'),
	(19, 17, 301, 299, 1, '115.117.224.101', '2016-12-13 17:48:49'),
	(20, 23, 256, 254, 1, '49.34.56.119', '2016-12-19 02:01:20'),
	(21, 23, 293, 291, 1, '49.34.56.119', '2016-12-19 02:01:20'),
	(22, 23, 296, 294, 1, '49.34.56.119', '2016-12-19 02:01:20'),
	(25, 26, 256, 254, 1, '14.97.16.47', '2016-12-19 19:21:19'),
	(26, 29, 256, 254, 1, '14.97.242.189', '2016-12-20 20:11:20'),
	(27, 29, 293, 291, 1, '14.97.242.189', '2016-12-20 20:11:52'),
	(28, 30, 256, 254, 1, '14.97.187.80', '2016-12-21 14:49:20'),
	(29, 30, 296, 294, 1, '14.97.187.80', '2016-12-21 14:49:33'),
	(30, 31, 301, 299, 1, '117.196.69.199', '2016-12-21 17:26:18'),
	(31, 31, 256, 254, 1, '117.196.69.199', '2016-12-21 17:26:39'),
	(32, 31, 293, 291, 1, '117.196.69.199', '2016-12-21 17:26:39'),
	(33, 31, 296, 294, 1, '117.196.69.199', '2016-12-21 17:26:39'),
	(34, 32, 256, 254, 1, '14.97.187.80', '2016-12-21 17:41:13'),
	(35, 34, 282, 280, 1, '14.97.187.80', '2016-12-21 18:14:13'),
	(36, 34, 293, 291, 1, '14.97.187.80', '2016-12-21 18:14:25'),
	(37, 34, 256, 254, 1, '14.97.187.80', '2016-12-21 18:14:37'),
	(38, 36, 256, 254, 1, '14.97.187.80', '2016-12-21 19:53:54'),
	(39, 36, 293, 291, 1, '14.97.187.80', '2016-12-21 19:54:06'),
	(40, 37, 256, 254, 1, '14.97.187.80', '2016-12-21 20:33:13'),
	(41, 37, 293, 291, 1, '14.97.187.80', '2016-12-21 20:33:25'),
	(42, 39, 256, 254, 1, '122.169.94.122', '2016-12-22 05:31:35'),
	(43, 39, 296, 294, 1, '122.169.94.122', '2016-12-22 05:31:35'),
	(44, 41, 256, 254, 1, '122.169.94.122', '2016-12-22 09:36:17'),
	(45, 41, 282, 280, 1, '122.169.94.122', '2016-12-22 09:36:17'),
	(46, 17, 895, 893, 1, '122.169.94.122', '2016-12-22 09:50:41'),
	(47, 43, 256, 254, 1, '122.169.94.122', '2016-12-22 10:22:20'),
	(48, 44, 256, 254, 1, '122.169.94.122', '2016-12-22 11:57:47'),
	(50, 44, 296, 294, 1, '122.169.94.122', '2016-12-22 11:57:47'),
	(51, 51, 301, 299, 1, '122.169.94.122', '2016-12-26 13:16:17'),
	(52, 51, 895, 893, 1, '122.169.94.122', '2016-12-26 13:16:17'),
	(53, 51, 256, 254, 1, '122.169.94.122', '2016-12-26 13:22:53'),
	(54, 53, 256, 254, 4, '', '2016-12-26 18:43:30'),
	(55, 54, 922, 920, 1, '49.34.149.217', '2016-12-26 22:22:37'),
	(56, 54, 910, 908, 1, '49.34.149.217', '2016-12-26 22:22:53'),
	(57, 54, 256, 254, 1, '49.34.149.217', '2016-12-26 23:04:28'),
	(58, 53, 922, 920, 1, '49.34.149.217', '2016-12-26 23:07:14'),
	(59, 55, 922, 920, 1, '49.34.149.217', '2016-12-26 23:20:20'),
	(60, 57, 256, 254, 1, '122.169.94.122', '2016-12-27 08:40:42'),
	(61, 58, 922, 920, 1, '49.34.69.144', '2016-12-28 02:54:58'),
	(62, 58, 256, 254, 1, '49.34.69.144', '2016-12-28 02:55:12'),
	(63, 59, 256, 254, 263, '', '2016-12-28 03:30:17'),
	(64, 59, 922, 920, 263, '', '2016-12-28 03:30:17');
/*!40000 ALTER TABLE `tbl_tenderbiddermap` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_tenderbiddetail
DROP TABLE IF EXISTS `tbl_tenderbiddetail`;
CREATE TABLE IF NOT EXISTS `tbl_tenderbiddetail` (
  `bidDetailId` int(11) NOT NULL AUTO_INCREMENT,
  `cellNo` int(11) NOT NULL,
  `cellValue` longtext NOT NULL,
  `bidtableid` int(11) NOT NULL,
  `cellid` int(11) NOT NULL,
  PRIMARY KEY (`bidDetailId`),
  KEY `FK_tbl_tenderbiddetail_tableId` (`bidtableid`),
  KEY `FK_tbl_tenderbiddetail_cellId` (`cellid`),
  CONSTRAINT `FK_tbl_tenderbiddetail_bidtable` FOREIGN KEY (`bidtableid`) REFERENCES `tbl_tenderbidmatrix` (`bidTableId`),
  CONSTRAINT `FK_tbl_tenderbiddetail_cellId` FOREIGN KEY (`cellid`) REFERENCES `tbl_tendercell` (`cellId`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_tenderbiddetail: ~56 rows (approximately)
/*!40000 ALTER TABLE `tbl_tenderbiddetail` DISABLE KEYS */;
INSERT INTO `tbl_tenderbiddetail` (`bidDetailId`, `cellNo`, `cellValue`, `bidtableid`, `cellid`) VALUES
	(1, 0, 'name3', 32, 160),
	(2, 1, 'bcom', 32, 155),
	(3, 0, 'name2', 32, 156),
	(4, 1, 'mca', 32, 153),
	(5, 0, 'lipi', 32, 154),
	(6, 1, 'ba', 32, 159),
	(7, 1, 'bca', 32, 157),
	(8, 0, 'name1', 32, 158),
	(9, 3, '5', 33, 164),
	(10, 2, '5', 33, 165),
	(11, 1, '52', 33, 166),
	(12, 0, 'item2', 33, 167),
	(13, 3, '160', 33, 168),
	(14, 2, '20', 33, 169),
	(15, 3, '2184', 33, 175),
	(16, 2, '52', 33, 176),
	(17, 3, '660', 33, 170),
	(18, 2, '15', 33, 171),
	(19, 1, '54', 33, 172),
	(20, 1, '1', 33, 173),
	(21, 0, 'item3', 33, 174),
	(22, 0, 'item1', 33, 163),
	(23, 1, '10', 33, 161),
	(24, 0, 'item4', 33, 162),
	(25, 1, 'bbbbbb', 35, 207),
	(26, 0, 'b', 35, 208),
	(27, 1, 'aaa', 35, 205),
	(28, 0, 'a', 35, 206),
	(29, 3, '42', 36, 211),
	(30, 2, '7', 36, 212),
	(31, 1, '5', 36, 213),
	(32, 0, 'i2', 36, 214),
	(33, 0, 'i1', 36, 210),
	(34, 3, '30', 36, 219),
	(35, 1, '4', 36, 209),
	(36, 2, '6', 36, 220),
	(37, 3, '20', 36, 215),
	(38, 2, '5', 36, 216),
	(39, 1, '6', 36, 217),
	(40, 0, 'i3', 36, 218),
	(41, 1, '2016-12-21', 40, 221),
	(42, 0, 'EMD Date', 40, 222),
	(43, 1, '8 GB RAM 1 TB hard disk i5 processor', 41, 223),
	(44, 0, 'Specifications of the product', 41, 224),
	(45, 3, '960000', 42, 227),
	(46, 2, '60000', 42, 228),
	(47, 1, '20', 42, 225),
	(48, 0, 'laptop', 42, 226),
	(49, 1, '2016-12-23', 37, 221),
	(50, 0, 'EMD Date', 37, 222),
	(51, 1, '4 GB RAM and 500 Gb Hard disk i3 Processor', 38, 223),
	(52, 0, 'Specifications of the product', 38, 224),
	(53, 3, '800000', 39, 227),
	(54, 2, '50000', 39, 228),
	(55, 1, '20', 39, 225),
	(56, 0, 'laptop', 39, 226);
/*!40000 ALTER TABLE `tbl_tenderbiddetail` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_tenderbidmatrix
DROP TABLE IF EXISTS `tbl_tenderbidmatrix`;
CREATE TABLE IF NOT EXISTS `tbl_tenderbidmatrix` (
  `bidJson` longtext NOT NULL,
  `bidTableId` int(11) NOT NULL AUTO_INCREMENT,
  `encryptedBid` longtext,
  `bidid` int(11) NOT NULL,
  `tableid` int(11) NOT NULL,
  PRIMARY KEY (`bidTableId`),
  KEY `FK_tbl_tenderbidmatrix_tenderbid` (`bidid`),
  KEY `FK_tbl_tenderbidmatrix_tendertable` (`tableid`),
  CONSTRAINT `FK_tbl_tenderbidmatrix_tenderbid` FOREIGN KEY (`bidid`) REFERENCES `tbl_tenderbid` (`bidId`),
  CONSTRAINT `FK_tbl_tenderbidmatrix_tendertable` FOREIGN KEY (`tableid`) REFERENCES `tbl_tendertable` (`tableId`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_tenderbidmatrix: ~34 rows (approximately)
/*!40000 ALTER TABLE `tbl_tenderbidmatrix` DISABLE KEYS */;
INSERT INTO `tbl_tenderbidmatrix` (`bidJson`, `bidTableId`, `encryptedBid`, `bidid`, `tableid`) VALUES
	('{"val":"f","colNo":1,"row":"0","key":"129"}', 7, '{"val":"f","colNo":1,"row":"0","key":"129"}', 13, 42),
	('{"val":"t1","colNo":0,"row":"0","key":"128"}', 8, '{"val":"t1","colNo":0,"row":"0","key":"128"}', 13, 42),
	('{"val":"f","colNo":2,"row":"1","key":"130"}', 9, '{"val":"f","colNo":2,"row":"1","key":"130"}', 13, 42),
	('{"val":"h","colNo":1,"row":"1","key":"129"}', 10, '{"val":"h","colNo":1,"row":"1","key":"129"}', 13, 42),
	('{"val":"t2","colNo":0,"row":"1","key":"128"}', 11, '{"val":"t2","colNo":0,"row":"1","key":"128"}', 13, 42),
	('{"val":"t","colNo":2,"row":"0","key":"130"}', 12, '{"val":"t","colNo":2,"row":"0","key":"130"}', 13, 42),
	('{"val":"r","colNo":1,"row":"0","key":"135"}', 13, '{"val":"r","colNo":1,"row":"0","key":"135"}', 14, 44),
	('{"val":"a","colNo":0,"row":"0","key":"134"}', 14, '{"val":"a","colNo":0,"row":"0","key":"134"}', 14, 44),
	('{"val":"t","colNo":2,"row":"1","key":"136"}', 15, '{"val":"t","colNo":2,"row":"1","key":"136"}', 14, 44),
	('{"val":"r","colNo":1,"row":"1","key":"135"}', 16, '{"val":"r","colNo":1,"row":"1","key":"135"}', 14, 44),
	('{"val":"b","colNo":0,"row":"1","key":"134"}', 17, '{"val":"b","colNo":0,"row":"1","key":"134"}', 14, 44),
	('{"val":"t","colNo":2,"row":"0","key":"136"}', 18, '{"val":"t","colNo":2,"row":"0","key":"136"}', 14, 44),
	('{"val":"t","colNo":2,"row":"2","key":"136"}', 19, '{"val":"t","colNo":2,"row":"2","key":"136"}', 14, 44),
	('{"val":"r","colNo":1,"row":"2","key":"135"}', 20, '{"val":"r","colNo":1,"row":"2","key":"135"}', 14, 44),
	('{"val":"c","colNo":0,"row":"2","key":"134"}', 21, '{"val":"c","colNo":0,"row":"2","key":"134"}', 14, 44),
	('{"val":"T1","colNo":1,"row":"0","key":"142"}', 22, '{"val":"T1","colNo":1,"row":"0","key":"142"}', 15, 46),
	('{"val":"Name1","colNo":0,"row":"0","key":"141"}', 23, '{"val":"Name1","colNo":0,"row":"0","key":"141"}', 15, 46),
	('{"val":"T23","colNo":2,"row":"1","key":"143"}', 24, '{"val":"T23","colNo":2,"row":"1","key":"143"}', 15, 46),
	('{"val":"T11","colNo":1,"row":"1","key":"142"}', 25, '{"val":"T11","colNo":1,"row":"1","key":"142"}', 15, 46),
	('{"val":"Name2","colNo":0,"row":"1","key":"141"}', 26, '{"val":"Name2","colNo":0,"row":"1","key":"141"}', 15, 46),
	('{"val":"T21","colNo":2,"row":"0","key":"143"}', 27, '{"val":"T21","colNo":2,"row":"0","key":"143"}', 15, 46),
	('{"val":"T24","colNo":2,"row":"2","key":"143"}', 28, '{"val":"T24","colNo":2,"row":"2","key":"143"}', 15, 46),
	('{"val":"T12","colNo":1,"row":"2","key":"142"}', 29, '{"val":"T12","colNo":1,"row":"2","key":"142"}', 15, 46),
	('{"val":"Name3","colNo":0,"row":"2","key":"141"}', 30, '{"val":"Name3","colNo":0,"row":"2","key":"141"}', 15, 46),
	('[{"160_0":[{"cellValue":"name3"}],"155_1":[{"cellValue":"bcom"}],"156_0":[{"cellValue":"name2"}],"153_1":[{"cellValue":"mca"}],"154_0":[{"cellValue":"lipi"}],"159_1":[{"cellValue":"ba"}],"157_1":[{"cellValue":"bca"}],"158_0":[{"cellValue":"name1"}]}]', 32, '{"160_0":[{"cellValue":"name3"}],"155_1":[{"cellValue":"bcom"}],"156_0":[{"cellValue":"name2"}],"153_1":[{"cellValue":"mca"}],"154_0":[{"cellValue":"lipi"}],"159_1":[{"cellValue":"ba"}],"157_1":[{"cellValue":"bca"}],"158_0":[{"cellValue":"name1"}]}', 17, 49),
	('[{"164_3":[{"cellValue":"5"}],"165_2":[{"cellValue":"5"}],"166_1":[{"cellValue":"52"}],"167_0":[{"cellValue":"item2"}],"168_3":[{"cellValue":"160"}],"169_2":[{"cellValue":"20"}],"175_3":[{"cellValue":"2184"}],"176_2":[{"cellValue":"52"}],"170_3":[{"cellValue":"660"}],"171_2":[{"cellValue":"15"}],"172_1":[{"cellValue":"54"}],"173_1":[{"cellValue":"1"}],"174_0":[{"cellValue":"item3"}],"163_0":[{"cellValue":"item1"}],"161_1":[{"cellValue":"10"}],"162_0":[{"cellValue":"item4"}]}]', 33, '{"164_3":[{"cellValue":"5"}],"165_2":[{"cellValue":"5"}],"166_1":[{"cellValue":"52"}],"167_0":[{"cellValue":"item2"}],"168_3":[{"cellValue":"160"}],"169_2":[{"cellValue":"20"}],"175_3":[{"cellValue":"2184"}],"176_2":[{"cellValue":"52"}],"170_3":[{"cellValue":"660"}],"171_2":[{"cellValue":"15"}],"172_1":[{"cellValue":"54"}],"173_1":[{"cellValue":"1"}],"174_0":[{"cellValue":"item3"}],"163_0":[{"cellValue":"item1"}],"161_1":[{"cellValue":"10"}],"162_0":[{"cellValue":"item4"}]}', 18, 50),
	('[{"207_1":[{"cellValue":"bbbbbb"}],"208_0":[{"cellValue":"b"}],"205_1":[{"cellValue":"aaa"}],"206_0":[{"cellValue":"a"}]}]', 35, '{"207_1":[{"cellValue":"bbbbbb"}],"208_0":[{"cellValue":"b"}],"205_1":[{"cellValue":"aaa"}],"206_0":[{"cellValue":"a"}]}', 20, 59),
	('[{"211_3":[{"cellValue":"42"}],"212_2":[{"cellValue":"7"}],"213_1":[{"cellValue":"5"}],"214_0":[{"cellValue":"i2"}],"210_0":[{"cellValue":"i1"}],"219_3":[{"cellValue":"30"}],"209_1":[{"cellValue":"4"}],"220_2":[{"cellValue":"6"}],"215_3":[{"cellValue":"20"}],"216_2":[{"cellValue":"5"}],"217_1":[{"cellValue":"6"}],"218_0":[{"cellValue":"i3"}]}]', 36, '{"211_3":[{"cellValue":"42"}],"212_2":[{"cellValue":"7"}],"213_1":[{"cellValue":"5"}],"214_0":[{"cellValue":"i2"}],"210_0":[{"cellValue":"i1"}],"219_3":[{"cellValue":"30"}],"209_1":[{"cellValue":"4"}],"220_2":[{"cellValue":"6"}],"215_3":[{"cellValue":"20"}],"216_2":[{"cellValue":"5"}],"217_1":[{"cellValue":"6"}],"218_0":[{"cellValue":"i3"}]}', 21, 60),
	('[{"221_1":[{"cellValue":"2016-12-23"}],"222_0":[{"cellValue":"EMD Date"}]}]', 37, '{"221_1":[{"cellValue":"2016-12-23"}],"222_0":[{"cellValue":"EMD Date"}]}', 22, 61),
	('[{"223_1":[{"cellValue":"4 GB RAM and 500 Gb Hard disk i3 Processor"}],"224_0":[{"cellValue":"Specifications of the product"}]}]', 38, '{"223_1":[{"cellValue":"4 GB RAM and 500 Gb Hard disk i3 Processor"}],"224_0":[{"cellValue":"Specifications of the product"}]}', 23, 62),
	('[{"227_3":[{"cellValue":"800000"}],"228_2":[{"cellValue":"50000"}],"225_1":[{"cellValue":"20"}],"226_0":[{"cellValue":"laptop"}]}]', 39, '{"227_3":[{"cellValue":"800000"}],"228_2":[{"cellValue":"50000"}],"225_1":[{"cellValue":"20"}],"226_0":[{"cellValue":"laptop"}]}', 24, 63),
	('[{"221_1":[{"cellValue":"2016-12-21"}],"222_0":[{"cellValue":"EMD Date"}]}]', 40, '{"221_1":[{"cellValue":"2016-12-21"}],"222_0":[{"cellValue":"EMD Date"}]}', 25, 61),
	('[{"223_1":[{"cellValue":"8 GB RAM 1 TB hard disk i5 processor"}],"224_0":[{"cellValue":"Specifications of the product"}]}]', 41, '{"223_1":[{"cellValue":"8 GB RAM 1 TB hard disk i5 processor"}],"224_0":[{"cellValue":"Specifications of the product"}]}', 26, 62),
	('[{"227_3":[{"cellValue":"960000"}],"228_2":[{"cellValue":"60000"}],"225_1":[{"cellValue":"20"}],"226_0":[{"cellValue":"laptop"}]}]', 42, '{"227_3":[{"cellValue":"960000"}],"228_2":[{"cellValue":"60000"}],"225_1":[{"cellValue":"20"}],"226_0":[{"cellValue":"laptop"}]}', 27, 63);
/*!40000 ALTER TABLE `tbl_tenderbidmatrix` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_tenderbidopensign
DROP TABLE IF EXISTS `tbl_tenderbidopensign`;
CREATE TABLE IF NOT EXISTS `tbl_tenderbidopensign` (
  `bidOpenSignId` int(11) NOT NULL AUTO_INCREMENT,
  `bidSignText` longtext,
  `createdBy` int(11) DEFAULT NULL,
  `createdOn` datetime DEFAULT NULL,
  `decryptedBid` longtext,
  `bidtableid` int(11) NOT NULL,
  PRIMARY KEY (`bidOpenSignId`),
  KEY `FK_tbl_tenderbidopensign` (`bidtableid`),
  CONSTRAINT `FK_tbl_tenderbidopensign` FOREIGN KEY (`bidtableid`) REFERENCES `tbl_tenderbidmatrix` (`bidTableId`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_tenderbidopensign: ~24 rows (approximately)
/*!40000 ALTER TABLE `tbl_tenderbidopensign` DISABLE KEYS */;
INSERT INTO `tbl_tenderbidopensign` (`bidOpenSignId`, `bidSignText`, `createdBy`, `createdOn`, `decryptedBid`, `bidtableid`) VALUES
	(1, '{"val":"f","colNo":1,"row":"0","key":"129"}', 254, NULL, '{"val":"f","colNo":1,"row":"0","key":"129"}', 7),
	(2, '{"val":"t1","colNo":0,"row":"0","key":"128"}', 254, NULL, '{"val":"t1","colNo":0,"row":"0","key":"128"}', 8),
	(3, '{"val":"f","colNo":2,"row":"1","key":"130"}', 254, NULL, '{"val":"f","colNo":2,"row":"1","key":"130"}', 9),
	(4, '{"val":"h","colNo":1,"row":"1","key":"129"}', 254, NULL, '{"val":"h","colNo":1,"row":"1","key":"129"}', 10),
	(5, '{"val":"t2","colNo":0,"row":"1","key":"128"}', 254, NULL, '{"val":"t2","colNo":0,"row":"1","key":"128"}', 11),
	(6, '{"val":"t","colNo":2,"row":"0","key":"130"}', 254, NULL, '{"val":"t","colNo":2,"row":"0","key":"130"}', 12),
	(7, '{"val":"r","colNo":1,"row":"0","key":"135"}', 254, NULL, '{"val":"r","colNo":1,"row":"0","key":"135"}', 13),
	(8, '{"val":"a","colNo":0,"row":"0","key":"134"}', 254, NULL, '{"val":"a","colNo":0,"row":"0","key":"134"}', 14),
	(9, '{"val":"t","colNo":2,"row":"1","key":"136"}', 254, NULL, '{"val":"t","colNo":2,"row":"1","key":"136"}', 15),
	(10, '{"val":"r","colNo":1,"row":"1","key":"135"}', 254, NULL, '{"val":"r","colNo":1,"row":"1","key":"135"}', 16),
	(11, '{"val":"b","colNo":0,"row":"1","key":"134"}', 254, NULL, '{"val":"b","colNo":0,"row":"1","key":"134"}', 17),
	(12, '{"val":"t","colNo":2,"row":"0","key":"136"}', 254, NULL, '{"val":"t","colNo":2,"row":"0","key":"136"}', 18),
	(13, '{"val":"t","colNo":2,"row":"2","key":"136"}', 254, NULL, '{"val":"t","colNo":2,"row":"2","key":"136"}', 19),
	(14, '{"val":"r","colNo":1,"row":"2","key":"135"}', 254, NULL, '{"val":"r","colNo":1,"row":"2","key":"135"}', 20),
	(15, '{"val":"c","colNo":0,"row":"2","key":"134"}', 254, NULL, '{"val":"c","colNo":0,"row":"2","key":"134"}', 21),
	(16, '{"val":"T1","colNo":1,"row":"0","key":"142"}', 254, NULL, '{"val":"T1","colNo":1,"row":"0","key":"142"}', 22),
	(17, '{"val":"Name1","colNo":0,"row":"0","key":"141"}', 254, NULL, '{"val":"Name1","colNo":0,"row":"0","key":"141"}', 23),
	(18, '{"val":"T23","colNo":2,"row":"1","key":"143"}', 254, NULL, '{"val":"T23","colNo":2,"row":"1","key":"143"}', 24),
	(19, '{"val":"T11","colNo":1,"row":"1","key":"142"}', 254, NULL, '{"val":"T11","colNo":1,"row":"1","key":"142"}', 25),
	(20, '{"val":"Name2","colNo":0,"row":"1","key":"141"}', 254, NULL, '{"val":"Name2","colNo":0,"row":"1","key":"141"}', 26),
	(21, '{"val":"T21","colNo":2,"row":"0","key":"143"}', 254, NULL, '{"val":"T21","colNo":2,"row":"0","key":"143"}', 27),
	(22, '{"val":"T24","colNo":2,"row":"2","key":"143"}', 254, NULL, '{"val":"T24","colNo":2,"row":"2","key":"143"}', 28),
	(23, '{"val":"T12","colNo":1,"row":"2","key":"142"}', 254, NULL, '{"val":"T12","colNo":1,"row":"2","key":"142"}', 29),
	(24, '{"val":"Name3","colNo":0,"row":"2","key":"141"}', 254, NULL, '{"val":"Name3","colNo":0,"row":"2","key":"141"}', 30);
/*!40000 ALTER TABLE `tbl_tenderbidopensign` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_tendercell
DROP TABLE IF EXISTS `tbl_tendercell`;
CREATE TABLE IF NOT EXISTS `tbl_tendercell` (
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
) ENGINE=InnoDB AUTO_INCREMENT=229 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_tendercell: ~197 rows (approximately)
/*!40000 ALTER TABLE `tbl_tendercell` DISABLE KEYS */;
INSERT INTO `tbl_tendercell` (`cellId`, `cellNo`, `cellValue`, `dataType`, `objectId`, `rowId`, `columnid`, `formid`, `tableid`) VALUES
	(1, 1, '', 0, 1, 0, 30, 12, 12),
	(2, 0, 'item1', 0, 1, 0, 29, 12, 12),
	(3, 3, '', 0, 1, 0, 32, 12, 12),
	(4, 2, '', 0, 1, 0, 31, 12, 12),
	(5, 1, '', 0, 1, 0, 58, 20, 20),
	(6, 0, 'Item 1', 0, 1, 0, 57, 20, 20),
	(7, 1, '1', 0, 1, 0, 64, 25, 22),
	(8, 0, 'Item 1', 0, 1, 0, 63, 25, 22),
	(9, 1, '3', 0, 1, 1, 64, 25, 22),
	(10, 0, 'Item 2', 0, 1, 1, 63, 25, 22),
	(11, 3, '', 0, 1, 0, 66, 25, 22),
	(12, 2, '', 0, 1, 0, 65, 25, 22),
	(13, 3, '', 0, 1, 1, 66, 25, 22),
	(14, 2, '', 0, 1, 1, 65, 25, 22),
	(15, 1, '', 0, 1, 0, 68, 26, 23),
	(16, 0, 'test 1 for d1', 0, 1, 0, 67, 26, 23),
	(17, 1, '', 0, 1, 0, 70, 27, 24),
	(18, 0, 'item1', 0, 1, 0, 69, 27, 24),
	(19, 1, '', 0, 1, 1, 70, 27, 24),
	(20, 0, 'item2', 0, 1, 1, 69, 27, 24),
	(21, 3, '1', 0, 1, 0, 72, 27, 24),
	(22, 2, '', 0, 1, 0, 71, 27, 24),
	(23, 3, '2', 0, 1, 1, 72, 27, 24),
	(24, 2, '', 0, 1, 1, 71, 27, 24),
	(25, 1, '1', 0, 1, 0, 74, 28, 25),
	(26, 0, 'Item 1', 0, 1, 0, 73, 28, 25),
	(27, 3, '', 0, 1, 2, 76, 28, 25),
	(28, 2, '', 0, 1, 2, 75, 28, 25),
	(29, 1, '2', 0, 1, 1, 74, 28, 25),
	(30, 0, 'Item 2', 0, 1, 1, 73, 28, 25),
	(31, 3, '', 0, 1, 0, 76, 28, 25),
	(32, 2, '', 0, 1, 0, 75, 28, 25),
	(33, 1, '3', 0, 1, 2, 74, 28, 25),
	(34, 0, 'Item 3', 0, 1, 2, 73, 28, 25),
	(35, 3, '', 0, 1, 1, 76, 28, 25),
	(36, 2, '', 0, 1, 1, 75, 28, 25),
	(37, 1, '12', 0, 1, 0, 78, 29, 26),
	(38, 0, 'Item 1', 0, 1, 0, 77, 29, 26),
	(39, 1, '15', 0, 1, 1, 78, 29, 26),
	(40, 0, 'item 2', 0, 1, 1, 77, 29, 26),
	(41, 3, '', 0, 1, 0, 80, 29, 26),
	(42, 2, '', 0, 1, 0, 79, 29, 26),
	(43, 3, '', 0, 1, 1, 80, 29, 26),
	(44, 2, '', 0, 1, 1, 79, 29, 26),
	(45, 1, '12', 0, 1, 0, 86, 31, 28),
	(46, 0, 'item 1', 0, 1, 0, 85, 31, 28),
	(47, 3, '', 0, 1, 2, 88, 31, 28),
	(48, 2, '', 0, 1, 2, 87, 31, 28),
	(49, 1, '12', 0, 1, 1, 86, 31, 28),
	(50, 0, 'Item 2', 0, 1, 1, 85, 31, 28),
	(51, 3, '', 0, 1, 0, 88, 31, 28),
	(52, 2, '', 0, 1, 0, 87, 31, 28),
	(53, 1, '12', 0, 1, 2, 86, 31, 28),
	(54, 0, 'item 3', 0, 1, 2, 85, 31, 28),
	(55, 3, '', 0, 1, 1, 88, 31, 28),
	(56, 2, '', 0, 1, 1, 87, 31, 28),
	(57, 1, '12', 0, 1, 0, 82, 31, 27),
	(58, 0, 'Item 1', 0, 1, 0, 81, 31, 27),
	(59, 3, '', 0, 1, 0, 84, 31, 27),
	(60, 2, '', 0, 1, 0, 83, 31, 27),
	(61, 1, '', 0, 1, 0, 106, 36, 34),
	(62, 0, 'Requirement 1', 0, 1, 0, 105, 36, 34),
	(63, 1, '', 0, 1, 1, 106, 36, 34),
	(64, 0, 'Requirement 1', 0, 1, 1, 105, 36, 34),
	(65, 1, '12', 0, 1, 0, 108, 37, 35),
	(66, 0, 'Itme 1', 0, 1, 0, 107, 37, 35),
	(67, 1, '13', 0, 1, 1, 108, 37, 35),
	(68, 0, 'itme 2', 0, 1, 1, 107, 37, 35),
	(69, 3, '', 0, 1, 0, 110, 37, 35),
	(70, 2, '', 0, 1, 0, 109, 37, 35),
	(71, 3, '', 0, 1, 1, 110, 37, 35),
	(72, 2, '', 0, 1, 1, 109, 37, 35),
	(73, 1, '20', 0, 1, 0, 113, 39, 37),
	(74, 0, 'Item 1', 0, 1, 0, 112, 39, 37),
	(75, 1, '30', 0, 1, 1, 113, 39, 37),
	(76, 0, 'Item 2', 0, 1, 1, 112, 39, 37),
	(77, 3, '', 0, 1, 0, 115, 39, 37),
	(78, 2, '', 0, 1, 0, 114, 39, 37),
	(79, 3, '', 0, 1, 1, 115, 39, 37),
	(80, 2, '', 0, 1, 1, 114, 39, 37),
	(81, 1, '1000', 0, 1, 0, 117, 40, 38),
	(82, 0, 'item1', 0, 1, 0, 116, 40, 38),
	(83, 1, '2000', 0, 1, 1, 117, 40, 38),
	(84, 0, 'item2', 0, 1, 1, 116, 40, 38),
	(85, 3, '', 0, 1, 0, 119, 40, 38),
	(86, 2, '', 0, 1, 0, 118, 40, 38),
	(87, 3, '', 0, 1, 1, 119, 40, 38),
	(88, 2, '', 0, 1, 1, 118, 40, 38),
	(89, 1, '', 0, 1, 0, 121, 41, 39),
	(90, 0, 'Item 1', 0, 1, 0, 120, 41, 39),
	(91, 1, '', 0, 1, 1, 121, 41, 39),
	(92, 0, 'Item 2', 0, 1, 1, 120, 41, 39),
	(93, 1, '23', 0, 1, 0, 123, 42, 40),
	(94, 0, 'Item 1', 0, 1, 0, 122, 42, 40),
	(95, 1, '34', 0, 1, 1, 123, 42, 40),
	(96, 0, 'Item 2', 0, 1, 1, 122, 42, 40),
	(97, 3, '', 0, 1, 0, 125, 42, 40),
	(98, 2, '', 0, 1, 0, 124, 42, 40),
	(99, 3, '', 0, 1, 1, 125, 42, 40),
	(100, 2, '', 0, 1, 1, 124, 42, 40),
	(101, 1, '', 0, 1, 0, 127, 43, 41),
	(102, 0, 'test', 0, 1, 0, 126, 43, 41),
	(103, 1, '', 0, 1, 0, 129, 44, 42),
	(104, 0, 't1', 0, 1, 0, 128, 44, 42),
	(105, 2, '', 0, 1, 1, 130, 44, 42),
	(106, 1, '', 0, 1, 1, 129, 44, 42),
	(107, 0, 't2', 0, 1, 1, 128, 44, 42),
	(108, 2, '', 0, 1, 0, 130, 44, 42),
	(109, 1, '', 0, 1, 0, 132, 45, 43),
	(110, 0, '100', 0, 1, 0, 131, 45, 43),
	(111, 2, '', 0, 1, 1, 133, 45, 43),
	(112, 1, '', 0, 1, 1, 132, 45, 43),
	(113, 0, '20o', 0, 1, 1, 131, 45, 43),
	(114, 2, '', 0, 1, 0, 133, 45, 43),
	(115, 1, '', 0, 1, 0, 135, 47, 44),
	(116, 0, 'a', 0, 1, 0, 134, 47, 44),
	(117, 2, '', 0, 1, 1, 136, 47, 44),
	(118, 1, '', 0, 1, 1, 135, 47, 44),
	(119, 0, 'b', 0, 1, 1, 134, 47, 44),
	(120, 2, '', 0, 1, 0, 136, 47, 44),
	(121, 2, '', 0, 1, 2, 136, 47, 44),
	(122, 1, '', 0, 1, 2, 135, 47, 44),
	(123, 0, 'c', 0, 1, 2, 134, 47, 44),
	(124, 1, '', 0, 1, 0, 138, 48, 45),
	(125, 0, 'item 1', 0, 1, 0, 137, 48, 45),
	(126, 1, '', 0, 1, 1, 138, 48, 45),
	(127, 0, 'item2', 0, 1, 1, 137, 48, 45),
	(128, 3, '1', 0, 1, 0, 140, 48, 45),
	(129, 2, '', 0, 1, 0, 139, 48, 45),
	(130, 3, '2', 0, 1, 1, 140, 48, 45),
	(131, 2, '', 0, 1, 1, 139, 48, 45),
	(132, 1, '', 0, 1, 0, 142, 49, 46),
	(133, 0, 'Name1', 0, 1, 0, 141, 49, 46),
	(134, 2, '', 0, 1, 1, 143, 49, 46),
	(135, 1, '', 0, 1, 1, 142, 49, 46),
	(136, 0, 'Name2', 0, 1, 1, 141, 49, 46),
	(137, 2, '', 0, 1, 0, 143, 49, 46),
	(138, 2, '', 0, 1, 2, 143, 49, 46),
	(139, 1, '', 0, 1, 2, 142, 49, 46),
	(140, 0, 'Name3', 0, 1, 2, 141, 49, 46),
	(141, 1, '3', 0, 1, 0, 145, 50, 47),
	(142, 0, 'Item 1', 0, 1, 0, 144, 50, 47),
	(143, 1, '4', 0, 1, 1, 145, 50, 47),
	(144, 0, 'item 2', 0, 1, 1, 144, 50, 47),
	(145, 3, '', 0, 1, 0, 147, 50, 47),
	(146, 2, '1', 0, 1, 0, 146, 50, 47),
	(147, 3, '', 0, 1, 1, 147, 50, 47),
	(148, 2, '1', 0, 1, 1, 146, 50, 47),
	(149, 1, '', 0, 1, 0, 149, 51, 48),
	(150, 0, '10', 0, 1, 0, 148, 51, 48),
	(151, 3, '', 0, 1, 0, 151, 51, 48),
	(152, 2, '', 0, 1, 0, 150, 51, 48),
	(153, 1, '', 0, 1, 0, 153, 52, 49),
	(154, 0, 'lipi', 0, 1, 0, 152, 52, 49),
	(155, 1, '', 0, 1, 2, 153, 52, 49),
	(156, 0, 'name2', 0, 1, 2, 152, 52, 49),
	(157, 1, '', 0, 1, 1, 153, 52, 49),
	(158, 0, 'name1', 0, 1, 1, 152, 52, 49),
	(159, 1, '', 0, 1, 3, 153, 52, 49),
	(160, 0, 'name3', 0, 1, 3, 152, 52, 49),
	(161, 1, '', 0, 1, 0, 155, 53, 50),
	(162, 0, 'item4', 0, 1, 3, 154, 53, 50),
	(163, 0, 'item1', 0, 1, 0, 154, 53, 50),
	(164, 3, '', 0, 1, 2, 157, 53, 50),
	(165, 2, '', 0, 1, 2, 156, 53, 50),
	(166, 1, '', 0, 1, 1, 155, 53, 50),
	(167, 0, 'item2', 0, 1, 1, 154, 53, 50),
	(168, 3, '', 0, 1, 0, 157, 53, 50),
	(169, 2, '', 0, 1, 0, 156, 53, 50),
	(170, 3, '', 0, 1, 3, 157, 53, 50),
	(171, 2, '', 0, 1, 3, 156, 53, 50),
	(172, 1, '', 0, 1, 3, 155, 53, 50),
	(173, 1, '', 0, 1, 2, 155, 53, 50),
	(174, 0, 'item3', 0, 1, 2, 154, 53, 50),
	(175, 3, '', 0, 1, 1, 157, 53, 50),
	(176, 2, '', 0, 1, 1, 156, 53, 50),
	(179, 1, '', 0, 1, 0, 159, 55, 52),
	(180, 0, 'Test 1', 0, 1, 0, 158, 55, 52),
	(181, 1, '', 0, 1, 1, 159, 55, 52),
	(182, 0, 'Test 2', 0, 1, 1, 158, 55, 52),
	(183, 1, '12', 0, 1, 0, 161, 56, 53),
	(184, 0, 'item 1', 0, 1, 0, 160, 56, 53),
	(185, 3, '50', 0, 1, 0, 163, 56, 53),
	(186, 2, '5', 0, 1, 0, 162, 56, 53),
	(187, 1, '', 0, 1, 0, 167, 58, 55),
	(188, 0, 'testrng', 0, 1, 0, 166, 58, 55),
	(189, 1, '34', 0, 1, 0, 169, 59, 56),
	(190, 0, 'test', 0, 1, 0, 168, 59, 56),
	(191, 3, '', 0, 1, 0, 171, 59, 56),
	(192, 2, '', 0, 1, 0, 170, 59, 56),
	(197, 1, '121', 0, 1, 0, 173, 60, 57),
	(198, 0, 'vv', 0, 1, 0, 172, 60, 57),
	(199, 3, '', 0, 1, 0, 175, 60, 57),
	(200, 2, '', 0, 1, 0, 174, 60, 57),
	(201, 1, '454', 0, 1, 0, 177, 61, 58),
	(202, 0, 'vbvb', 0, 1, 0, 176, 61, 58),
	(203, 3, '', 0, 1, 0, 179, 61, 58),
	(204, 2, '', 0, 1, 0, 178, 61, 58),
	(205, 1, '', 0, 1, 0, 181, 62, 59),
	(206, 0, 'a', 0, 1, 0, 180, 62, 59),
	(207, 1, '', 0, 1, 1, 181, 62, 59),
	(208, 0, 'b', 0, 1, 1, 180, 62, 59),
	(209, 1, '', 0, 1, 0, 183, 63, 60),
	(210, 0, 'i1', 0, 1, 0, 182, 63, 60),
	(211, 3, '', 0, 1, 2, 185, 63, 60),
	(212, 2, '', 0, 1, 2, 184, 63, 60),
	(213, 1, '', 0, 1, 1, 183, 63, 60),
	(214, 0, 'i2', 0, 1, 1, 182, 63, 60),
	(215, 3, '', 0, 1, 0, 185, 63, 60),
	(216, 2, '', 0, 1, 0, 184, 63, 60),
	(217, 1, '', 0, 1, 2, 183, 63, 60),
	(218, 0, 'i3', 0, 1, 2, 182, 63, 60),
	(219, 3, '', 0, 1, 1, 185, 63, 60),
	(220, 2, '', 0, 1, 1, 184, 63, 60),
	(221, 1, '', 0, 1, 0, 187, 64, 61),
	(222, 0, 'EMD Date', 0, 1, 0, 186, 64, 61),
	(223, 1, '', 0, 1, 0, 189, 65, 62),
	(224, 0, 'Specifications of the product', 0, 1, 0, 188, 65, 62),
	(225, 1, '20', 0, 1, 0, 191, 66, 63),
	(226, 0, 'laptop', 0, 1, 0, 190, 66, 63),
	(227, 3, '', 0, 1, 0, 193, 66, 63),
	(228, 2, '5000', 0, 1, 0, 192, 66, 63);
/*!40000 ALTER TABLE `tbl_tendercell` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_tendercolumn
DROP TABLE IF EXISTS `tbl_tendercolumn`;
CREATE TABLE IF NOT EXISTS `tbl_tendercolumn` (
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
) ENGINE=InnoDB AUTO_INCREMENT=194 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_tendercolumn: ~171 rows (approximately)
/*!40000 ALTER TABLE `tbl_tendercolumn` DISABLE KEYS */;
INSERT INTO `tbl_tendercolumn` (`columnId`, `columnHeader`, `columnNo`, `dataType`, `filledBy`, `isCurrConvReq`, `isShown`, `sortOrder`, `columntypeid`, `formid`, `tableid`) VALUES
	(1, 'Item Name', 1, 2, 1, 0, 1, 1, 1, 1, 1),
	(2, 'Qty', 2, 5, 2, 0, 1, 1, 1, 1, 1),
	(3, 'Unit Rate', 3, 5, 2, 0, 1, 1, 1, 1, 1),
	(4, 'Total', 4, 6, 3, 0, 1, 1, 1, 1, 1),
	(5, 't', 1, 5, 1, 0, 1, 1, 1, 2, 2),
	(6, 't', 2, 5, 1, 0, 1, 1, 1, 2, 2),
	(7, 'h', 1, 6, 1, 0, 1, 1, 1, 3, 3),
	(8, 'f', 2, 6, 1, 0, 1, 1, 1, 3, 3),
	(9, 'test', 1, 5, 1, 0, 1, 1, 1, 5, 5),
	(10, '', -1, -1, -1, 0, 1, 1, 1, 5, 5),
	(11, '', -1, -1, -1, 0, 1, 1, 1, 5, 5),
	(12, '', -1, -1, -1, 0, 1, 1, 1, 5, 5),
	(13, '', -1, -1, -1, 0, 1, 1, 1, 5, 5),
	(14, 'item desc', 1, 2, 1, 0, 1, 1, 1, 6, 6),
	(15, 'qty', 2, 5, 2, 0, 1, 1, 1, 6, 6),
	(16, 'rate', 3, 5, 2, 0, 1, 1, 1, 6, 6),
	(17, 'Item Description', 1, 1, 1, 0, 1, 1, 1, 7, 7),
	(18, 'Qty', 2, 5, 1, 0, 1, 1, 1, 7, 7),
	(19, 'Unit Rate', 3, 5, 2, 0, 1, 1, 1, 7, 7),
	(20, 'Total Rate', 4, 6, 3, 0, 1, 1, 1, 7, 7),
	(21, 'Item name', 1, 1, 1, 0, 1, 1, 1, 8, 8),
	(22, 'Qty', 2, 5, 1, 0, 1, 1, 1, 8, 8),
	(23, 'Unit Rate', 3, 5, 2, 0, 1, 1, 1, 8, 8),
	(24, 'Total Rate', 4, 5, 3, 0, 1, 1, 1, 8, 8),
	(25, '1', 1, 5, 1, 0, 1, 1, 1, 9, 9),
	(26, 't', 1, 6, 1, 0, 1, 1, 1, 10, 10),
	(27, 't', 1, 2, 1, 0, 1, 1, 1, 10, 10),
	(28, 't', 1, 1, 1, 0, 1, 1, 1, 11, 11),
	(29, 'Item Desc', 1, 1, 1, 0, 1, 1, 1, 12, 12),
	(30, 'Qty', 2, 5, 2, 0, 1, 1, 1, 12, 12),
	(31, 'Unit Rate', 3, 5, 2, 0, 1, 1, 1, 12, 12),
	(32, 'Total Rate', 3, 5, 3, 0, 1, 1, 1, 12, 12),
	(33, 'H1', 1, 1, 1, 0, 1, 1, 1, 13, 13),
	(34, 'H2', 2, 5, 1, 0, 1, 1, 1, 13, 13),
	(35, 'H3', 3, 5, 2, 0, 1, 1, 1, 13, 13),
	(36, 'H4', 4, 5, 3, 0, 1, 1, 1, 13, 13),
	(37, 'Column 1', 1, 1, 1, 0, 1, 1, 1, 15, 15),
	(38, 'Column 2', 2, 5, 1, 0, 1, 1, 1, 15, 15),
	(39, 'Column 3', 3, 5, 2, 0, 1, 1, 1, 15, 15),
	(40, 'Column 4', 4, 5, 3, 0, 1, 1, 1, 15, 15),
	(41, '1', 1, 5, 1, 0, 1, 1, 1, 16, 16),
	(42, '2', 22, 5, 1, 0, 1, 1, 1, 16, 16),
	(43, '3', 3, 5, 2, 0, 1, 1, 1, 16, 16),
	(44, '4', 4, 5, 3, 0, 1, 1, 1, 16, 16),
	(45, '1', 11, 1, 1, 0, 1, 1, 1, 17, 17),
	(46, '2', 2, 5, 1, 0, 1, 1, 1, 17, 17),
	(47, '3', 3, 5, 2, 0, 1, 1, 1, 17, 17),
	(48, '4', 4, 5, 3, 0, 1, 1, 1, 17, 17),
	(49, 'dsd', -1, 1, 1, 0, 1, 1, 1, 18, 18),
	(50, 'sdss', -1, 5, 1, 0, 1, 1, 1, 18, 18),
	(51, 'sds', -1, 5, 2, 0, 1, 1, 1, 18, 18),
	(52, 'sds', -1, 5, 3, 0, 1, 1, 1, 18, 18),
	(53, 'sfdf', -1, 1, 1, 0, 1, 1, 1, 19, 19),
	(54, 'dfd', -1, 5, 1, 0, 1, 1, 1, 19, 19),
	(55, 'dfdf', -1, 5, 2, 0, 1, 1, 1, 19, 19),
	(56, '', -1, 5, 3, 0, 1, 1, 1, 19, 19),
	(57, 'Header 1', 1, 1, 1, 0, 1, 1, 1, 20, 20),
	(58, 'Header 2', 2, 1, 2, 0, 1, 1, 1, 20, 20),
	(59, 'Header 1', 1, 1, 1, 0, 1, 1, 1, 21, 21),
	(60, 'Header 2', 2, 5, 1, 0, 1, 1, 1, 21, 21),
	(61, 'Header 3', 3, 5, 2, 0, 1, 1, 1, 21, 21),
	(62, 'Header 4', 4, 5, 3, 0, 1, 1, 1, 21, 21),
	(63, 'Item Desc', 1, 1, 1, 0, 1, 1, 1, 25, 22),
	(64, 'Qty', 2, 5, 1, 0, 1, 1, 1, 25, 22),
	(65, 'UR', 3, 5, 2, 0, 1, 1, 1, 25, 22),
	(66, 'TR', 4, 5, 3, 0, 1, 1, 1, 25, 22),
	(67, 'name', 1, 2, 1, 0, 1, 1, 1, 26, 23),
	(68, 'teste', 2, 2, 2, 0, 1, 1, 1, 26, 23),
	(69, 'item name', 1, 1, 1, 0, 1, 1, 1, 27, 24),
	(70, 'qty', 2, 4, 2, 0, 1, 1, 1, 27, 24),
	(71, 'unit rate', 3, 4, 2, 0, 1, 1, 1, 27, 24),
	(72, 'total rate', 4, 6, 3, 0, 1, 1, 1, 27, 24),
	(73, 'Item Name', 1, 1, 1, 0, 1, 1, 1, 28, 25),
	(74, 'Qty', 2, 5, 1, 0, 1, 1, 1, 28, 25),
	(75, 'UR', 3, 5, 2, 0, 1, 1, 1, 28, 25),
	(76, 'TR', 4, 5, 3, 0, 1, 1, 1, 28, 25),
	(77, 'item Name', 1, 1, 1, 0, 1, 1, 1, 29, 26),
	(78, 'Qty', 2, 5, 1, 0, 1, 1, 1, 29, 26),
	(79, 'Unit Rate', 3, 5, 2, 0, 1, 1, 1, 29, 26),
	(80, 'Total Rate', 4, 5, 3, 0, 1, 1, 1, 29, 26),
	(81, 'item 1', 1, 1, 1, 0, 1, 1, 1, 31, 27),
	(82, 'Qty1', 2, 5, 1, 0, 1, 1, 1, 31, 27),
	(83, 'Ur 1', 3, 5, 2, 0, 1, 1, 1, 31, 27),
	(84, 'TR 1', 4, 5, 3, 0, 1, 1, 1, 31, 27),
	(85, 'Item ', 1, 1, 1, 0, 1, 1, 1, 31, 28),
	(86, 'Qty', 2, 5, 1, 0, 1, 1, 1, 31, 28),
	(87, 'UR', 3, 5, 2, 0, 1, 1, 1, 31, 28),
	(88, 'TR', 4, 5, 3, 0, 1, 1, 1, 31, 28),
	(90, 'Name', 1, 1, 1, 0, 1, 1, 1, 33, 30),
	(91, 'test1', 2, 2, 2, 0, 1, 1, 1, 33, 30),
	(92, 'test2', 3, 2, 2, 0, 1, 1, 1, 33, 30),
	(93, 'Item Desc', 1, 1, 1, 0, 1, 1, 1, 34, 31),
	(94, 'Qty', 2, 5, 1, 0, 1, 1, 1, 34, 31),
	(95, 'Unit Rate', 3, 5, 2, 0, 1, 1, 1, 34, 31),
	(96, 'Total Rate', 4, 5, 3, 0, 1, 1, 1, 34, 31),
	(97, 'item name', 1, 1, 1, 0, 1, 1, 1, 34, 32),
	(98, 'Qty', 2, 5, 1, 0, 1, 1, 1, 34, 32),
	(99, 'Unit rate', 3, 5, 2, 0, 1, 1, 1, 34, 32),
	(100, 'Total Rate', 4, 5, 3, 0, 1, 1, 1, 34, 32),
	(101, 'Item name', 1, 1, 1, 0, 1, 1, 1, 35, 33),
	(102, 'Qty', 2, 5, 1, 0, 1, 1, 1, 35, 33),
	(103, 'Unit Rate', 3, 5, 2, 0, 1, 1, 1, 35, 33),
	(104, 'Total Rate', 4, 5, 3, 0, 1, 1, 1, 35, 33),
	(105, 'Requirement', 1, 1, 1, 0, 1, 1, 1, 36, 34),
	(106, 'Response', 2, 2, 2, 0, 1, 1, 1, 36, 34),
	(107, 'Item', 1, 1, 1, 0, 1, 1, 1, 37, 35),
	(108, 'Qty', 2, 5, 1, 0, 1, 1, 1, 37, 35),
	(109, 'UR', 3, 5, 2, 0, 1, 1, 1, 37, 35),
	(110, 'TR', 4, 5, 3, 0, 1, 1, 1, 37, 35),
	(111, 'Requirement 12', 1, 1, 1, 0, 1, 1, 1, 38, 36),
	(112, 'Item Desc', 1, 1, 1, 0, 1, 1, 1, 39, 37),
	(113, 'Qty', 2, 5, 1, 0, 1, 1, 1, 39, 37),
	(114, 'Unit Rate', 3, 5, 2, 0, 1, 1, 1, 39, 37),
	(115, 'Total Rate', 4, 5, 3, 0, 1, 1, 1, 39, 37),
	(116, 'Item', 1, 2, 1, 0, 1, 1, 1, 40, 38),
	(117, 'Qty', 2, 5, 1, 0, 1, 1, 1, 40, 38),
	(118, 'Price', 3, 5, 2, 0, 1, 1, 1, 40, 38),
	(119, 'Total', 4, 5, 3, 0, 1, 1, 1, 40, 38),
	(120, 'Requirement', 1, 1, 1, 0, 1, 1, 6, 41, 39),
	(121, 'Response', 2, 2, 2, 0, 1, 1, 6, 41, 39),
	(122, 'Item Desc', 1, 1, 1, 0, 1, 1, 1, 42, 40),
	(123, 'Qty', 2, 5, 1, 0, 1, 1, 2, 42, 40),
	(124, 'Unit Rate', 3, 5, 2, 0, 1, 1, 3, 42, 40),
	(125, 'Total Rate', 4, 5, 3, 0, 1, 1, 4, 42, 40),
	(126, 'Req', 1, 1, 1, 0, 1, 1, 6, 43, 41),
	(127, 'Response', 2, 2, 2, 0, 1, 1, 6, 43, 41),
	(128, 'a', 1, 1, 1, 0, 1, 1, 6, 44, 42),
	(129, 'b', 2, 1, 2, 0, 1, 1, 6, 44, 42),
	(130, 'c', 3, 1, 2, 0, 1, 1, 6, 44, 42),
	(131, 'col1', 1, 1, 1, 0, 1, 1, 1, 45, 43),
	(132, 'col2', 2, 2, 2, 0, 1, 1, 2, 45, 43),
	(133, 'col3', 3, 1, 3, 0, 1, 1, 4, 45, 43),
	(134, 'a', 1, 1, 1, 0, 1, 1, 6, 47, 44),
	(135, 'b', 2, 1, 2, 0, 1, 1, 6, 47, 44),
	(136, 'c', 3, 1, 2, 0, 1, 1, 6, 47, 44),
	(137, 'Item desc', 1, 1, 1, 0, 1, 1, 1, 48, 45),
	(138, 'qty', 2, 5, 2, 0, 1, 1, 2, 48, 45),
	(139, 'unit reate', 3, 5, 2, 0, 1, 1, 3, 48, 45),
	(140, 'total', 4, 6, 3, 0, 1, 1, 4, 48, 45),
	(141, 'Name', 1, 1, 1, 0, 1, 1, 6, 49, 46),
	(142, 'Title1', 2, 2, 2, 0, 1, 1, 6, 49, 46),
	(143, 'Title2', 3, 2, 2, 0, 1, 1, 6, 49, 46),
	(144, 'Item 1', 1, 1, 1, 0, 1, 1, 1, 50, 47),
	(145, 'Qty', 2, 5, 1, 0, 1, 1, 2, 50, 47),
	(146, 'UT', 3, 5, 2, 0, 1, 1, 3, 50, 47),
	(147, 'TR', 4, 5, 3, 0, 1, 1, 4, 50, 47),
	(148, 'item', 1, 1, 1, 0, 1, 1, 1, 51, 48),
	(149, 'qty', 2, 5, 2, 0, 1, 1, 2, 51, 48),
	(150, 'total', 3, 5, 2, 0, 1, 1, 3, 51, 48),
	(151, 'ut', 4, 5, 3, 0, 1, 1, 4, 51, 48),
	(152, 'name', 1, 2, 1, 0, 1, 1, 6, 52, 49),
	(153, 'desingnation', 2, 2, 2, 0, 1, 1, 6, 52, 49),
	(154, 'item desc', 1, 2, 1, 0, 1, 1, 1, 53, 50),
	(155, 'qty', 2, 5, 2, 0, 1, 1, 2, 53, 50),
	(156, 'rate', 3, 5, 2, 0, 1, 1, 3, 53, 50),
	(157, 'total rate', 4, 5, 3, 0, 1, 1, 4, 53, 50),
	(158, 'Column 1', 1, 1, 1, 0, 1, 1, 1, 55, 52),
	(159, 'Column 2', 1, 1, 2, 0, 1, 1, 6, 55, 52),
	(160, 'Item', 1, 1, 1, 0, 1, 1, 1, 56, 53),
	(161, 'Qty', 2, 5, 1, 0, 1, 1, 2, 56, 53),
	(162, 'UR', 3, 5, 2, 0, 1, 1, 3, 56, 53),
	(163, 'TR', 4, 5, 3, 0, 1, 1, 4, 56, 53),
	(166, 're', 2, 1, 1, 0, 1, 1, 1, 58, 55),
	(167, 'rer', 1, 1, 2, 0, 1, 1, 6, 58, 55),
	(168, 'Item', 1, 1, 1, 0, 1, 1, 1, 59, 56),
	(169, 'Qty', 2, 5, 1, 0, 1, 1, 2, 59, 56),
	(170, 'UT', 3, 5, 2, 0, 1, 1, 3, 59, 56),
	(171, 'TR', 4, 5, 3, 0, 1, 1, 4, 59, 56),
	(172, 'g', 1, 1, 1, 0, 1, 1, 1, 60, 57),
	(173, 'ghfd', 2, 5, 1, 0, 1, 1, 2, 60, 57),
	(174, 'fghfhg', 3, 5, 2, 0, 1, 1, 3, 60, 57),
	(175, 'gfhgf', 4, 5, 3, 0, 1, 1, 4, 60, 57),
	(176, 'bvc', 1, 1, 1, 0, 1, 1, 1, 61, 58),
	(177, 'vcbvc', 2, 5, 1, 0, 1, 1, 2, 61, 58),
	(178, 'bvcb', 3, 5, 2, 0, 1, 1, 3, 61, 58),
	(179, 'vbbvc', 4, 5, 3, 0, 1, 1, 4, 61, 58),
	(180, 't2', 1, 2, 1, 0, 1, 1, 6, 62, 59),
	(181, 'r1', 2, 2, 2, 0, 1, 1, 6, 62, 59),
	(182, 'item', 1, 2, 1, 0, 1, 1, 1, 63, 60),
	(183, 'qty', 2, 5, 2, 0, 1, 1, 2, 63, 60),
	(184, 'rate', 3, 5, 2, 0, 1, 1, 3, 63, 60),
	(185, 'total rate', 4, 5, 3, 0, 1, 1, 4, 63, 60),
	(186, 'EMD Details', 1, 1, 1, 0, 1, 1, 6, 64, 61),
	(187, 'Response', 1, 7, 2, 0, 1, 1, 6, 64, 61),
	(188, 'Requirement', 1, 1, 1, 0, 1, 1, 5, 65, 62),
	(189, 'Response', 1, 2, 2, 0, 1, 1, 6, 65, 62),
	(190, 'Item name', 1, 1, 1, 0, 1, 1, 1, 66, 63),
	(191, 'Qty', 2, 5, 1, 0, 1, 1, 2, 66, 63),
	(192, 'Unit Rate', 3, 5, 2, 0, 1, 1, 3, 66, 63),
	(193, 'Total Rate', 4, 5, 3, 0, 1, 1, 4, 66, 63);
/*!40000 ALTER TABLE `tbl_tendercolumn` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_tendercurrency
DROP TABLE IF EXISTS `tbl_tendercurrency`;
CREATE TABLE IF NOT EXISTS `tbl_tendercurrency` (
  `tenderCurrencyId` int(11) NOT NULL AUTO_INCREMENT,
  `currencyId` int(11) DEFAULT NULL,
  `exchangeRate` decimal(19,2) NOT NULL,
  `isActive` int(11) NOT NULL,
  `isDefault` int(11) NOT NULL,
  `tenderid` int(11) DEFAULT NULL,
  `bidCurrencyId` int(11) DEFAULT NULL,
  PRIMARY KEY (`tenderCurrencyId`),
  KEY `FKr9mq7c4tmf6qymsi7u6wp9q0f` (`tenderid`),
  KEY `FK_tbl_tendercurrency` (`currencyId`),
  KEY `FK_tbl_tendercurrency_bidCurrencyId` (`bidCurrencyId`),
  CONSTRAINT `FK_tbl_tendercurrency` FOREIGN KEY (`currencyId`) REFERENCES `tbl_currency` (`currencyId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_tbl_tendercurrency_bidCurrencyId` FOREIGN KEY (`bidCurrencyId`) REFERENCES `tbl_tenderbidcurrency` (`bidCurrencyId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FKr9mq7c4tmf6qymsi7u6wp9q0f` FOREIGN KEY (`tenderid`) REFERENCES `tbl_tender` (`tenderId`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_tendercurrency: ~35 rows (approximately)
/*!40000 ALTER TABLE `tbl_tendercurrency` DISABLE KEYS */;
INSERT INTO `tbl_tendercurrency` (`tenderCurrencyId`, `currencyId`, `exchangeRate`, `isActive`, `isDefault`, `tenderid`, `bidCurrencyId`) VALUES
	(1, 1, 1.00, 1, 1, 23, NULL),
	(2, 1, 1.00, 1, 1, 24, NULL),
	(5, 1, 1.00, 1, 1, 26, NULL),
	(6, 1, 1.00, 1, 1, 25, NULL),
	(10, 1, 1.00, 1, 1, 27, NULL),
	(12, 1, 1.00, 1, 1, 29, NULL),
	(16, 1, 1.00, 1, 1, 30, NULL),
	(18, 1, 1.00, 1, 1, 31, NULL),
	(19, 1, 1.00, 1, 1, 32, NULL),
	(20, 1, 1.00, 1, 1, 33, NULL),
	(22, 1, 1.00, 1, 1, 34, NULL),
	(23, 1, 1.00, 1, 1, 35, NULL),
	(24, 1, 1.00, 1, 1, 36, NULL),
	(25, 1, 1.00, 1, 1, 37, NULL),
	(27, 1, 1.00, 1, 1, 38, NULL),
	(28, 1, 1.00, 1, 1, 39, NULL),
	(29, 1, 1.00, 1, 1, 40, NULL),
	(30, 1, 1.00, 1, 1, 41, NULL),
	(31, 1, 1.00, 1, 1, 42, NULL),
	(32, 1, 1.00, 1, 1, 43, NULL),
	(33, 1, 1.00, 1, 1, 44, NULL),
	(34, 1, 1.00, 1, 1, 28, NULL),
	(35, 1, 1.00, 1, 1, 17, NULL),
	(36, 1, 1.00, 1, 1, 45, NULL),
	(37, 1, 1.00, 1, 1, 46, NULL),
	(38, 1, 1.00, 1, 1, 47, NULL),
	(39, 1, 1.00, 1, 1, 48, NULL),
	(41, 1, 1.00, 1, 1, 49, NULL),
	(43, 1, 1.00, 1, 1, 50, NULL),
	(44, 1, 1.00, 1, 1, 51, NULL),
	(45, 1, 1.00, 1, 1, 52, NULL),
	(49, 1, 1.00, 1, 1, 54, NULL),
	(50, 1, 1.00, 1, 1, 53, NULL),
	(51, 1, 1.00, 1, 1, 55, NULL),
	(52, 1, 1.00, 1, 1, 56, NULL),
	(53, 1, 1.00, 1, 1, 57, NULL),
	(54, 1, 1.00, 1, 1, 58, NULL),
	(55, 1, 1.00, 1, 1, 59, NULL);
/*!40000 ALTER TABLE `tbl_tendercurrency` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_tenderdocument
DROP TABLE IF EXISTS `tbl_tenderdocument`;
CREATE TABLE IF NOT EXISTS `tbl_tenderdocument` (
  `documentId` int(11) NOT NULL AUTO_INCREMENT,
  `documentName` longtext NOT NULL,
  `isMandatory` int(11) NOT NULL,
  `formId` int(11) NOT NULL,
  `tenderId` int(11) NOT NULL,
  PRIMARY KEY (`documentId`),
  KEY `FK_tbl_tenderdocument_form` (`formId`),
  KEY `FK_tbl_tenderdocument_tender` (`tenderId`),
  CONSTRAINT `FK_tbl_tenderdocument_tender1` FOREIGN KEY (`tenderId`) REFERENCES `tbl_tender` (`tenderId`),
  CONSTRAINT `FK_tbl_tenderformula_form1` FOREIGN KEY (`formId`) REFERENCES `tbl_tenderform` (`formId`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_tenderdocument: ~10 rows (approximately)
/*!40000 ALTER TABLE `tbl_tenderdocument` DISABLE KEYS */;
INSERT INTO `tbl_tenderdocument` (`documentId`, `documentName`, `isMandatory`, `formId`, `tenderId`) VALUES
	(2, 'testOne111', 0, 26, 17),
	(3, 'PAN card', 1, 28, 30),
	(4, 'ID Proof', 0, 28, 30),
	(5, 'PAN 1', 1, 29, 30),
	(6, 'PAN 1', 1, 31, 30),
	(7, 'PAN 2', 0, 31, 30),
	(8, 'Doc 1', 1, 36, 34),
	(9, 'PAN Card', 1, 27, 17),
	(10, 'tgest', 0, 47, 41),
	(11, 'PAN Card', 1, 45, 28),
	(12, 'test1', 1, 48, 43),
	(13, 'testOne', 1, 49, 44);
/*!40000 ALTER TABLE `tbl_tenderdocument` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_tenderenvelope
DROP TABLE IF EXISTS `tbl_tenderenvelope`;
CREATE TABLE IF NOT EXISTS `tbl_tenderenvelope` (
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
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_tenderenvelope: ~78 rows (approximately)
/*!40000 ALTER TABLE `tbl_tenderenvelope` DISABLE KEYS */;
INSERT INTO `tbl_tenderenvelope` (`envelopeId`, `createdBy`, `createdOn`, `cstatus`, `envelopeName`, `isEvaluated`, `isOpened`, `minEvaluator`, `minFormsReqForBidding`, `minOpeningMember`, `noOfFormsReq`, `openingDate`, `openingDatePublishedBy`, `openingDatePublishedOn`, `openingDateStatus`, `publishedBy`, `publishedOn`, `remark`, `sortOrder`, `envid`, `tenderid`) VALUES
	(1, 1, '2016-11-12 20:03:12', 1, 'Technical EnvelopeName', 0, 0, 2, 1, 2, 1, '2016-11-23 20:03:59', 1, '2016-11-12 20:04:08', 1, 1, '2016-11-12 20:04:21', 'asdfasdfads', 1, 1, 1),
	(2, 1, '2016-11-17 20:07:53', 1, 'Price bid Envelope', 0, 0, 2, 1, 2, 1, '2016-11-18 20:08:38', 1, '2016-11-26 21:35:37', 1, 1, '2016-11-18 21:35:48', 'asfasdfads', 2, 2, 1),
	(3, 1, '2016-12-04 03:13:17', 1, 'Pre Qualification', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 1, 2, 7),
	(4, 1, '2016-12-04 03:13:17', 1, 'Techno commercial', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 2, 5, 7),
	(5, 1, '2016-12-04 09:14:48', 1, 'Price bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 1, 4, 8),
	(6, 1, '2016-12-04 11:24:28', 1, 'Price bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 1, 4, 6),
	(7, 1, '2016-12-04 11:25:01', 1, 'Price bid', 1, 1, 1, 0, 1, 0, '2016-12-08 00:11:00', 4, '2016-12-08 00:11:00', 1, 0, NULL, '', 1, 4, 5),
	(8, 1, '2016-12-05 17:09:31', 1, 'Price bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 1, 4, 9),
	(10, 1, '2016-12-06 17:59:44', 1, 'Price bid', 1, 1, 1, 0, 1, 0, '2016-11-24 17:00:00', 4, '2016-11-24 14:00:00', 1, 0, NULL, '', 1, 4, 2),
	(11, 1, '2016-12-07 11:52:29', 1, 'Price bid', 1, 1, 1, 0, 1, 0, '2016-12-06 17:26:00', 4, '2016-12-06 17:26:00', 1, 0, NULL, '', 1, 4, 3),
	(12, 1, '2016-12-07 12:20:10', 1, 'Price bid', 1, 1, 1, 1, 1, 0, '2016-12-06 17:53:00', 4, '2016-12-06 17:53:00', 1, 0, NULL, '', 1, 4, 4),
	(13, 1, '2016-12-07 16:07:25', 1, 'Price bid', 1, 1, 1, 1, 1, 0, '2016-12-07 18:47:00', 4, '2016-12-08 22:00:00', 1, 0, NULL, '', 1, 4, 10),
	(14, 1, '2016-12-07 18:56:04', 1, 'Price bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 1, 4, 11),
	(15, 1, '2016-12-08 02:53:42', 1, 'Price bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 1, 4, 12),
	(16, 1, '2016-12-08 07:33:04', 1, 'Price bid', 1, 1, 1, 0, 1, 0, '2016-12-07 13:07:00', 4, '2016-12-07 13:07:00', 1, 0, NULL, '', 1, 4, 13),
	(17, 1, '2016-12-08 09:13:55', 1, 'Price bid', 1, 1, 1, 0, 1, 0, '2016-12-08 09:04:00', 4, '2016-12-08 09:04:00', 1, 0, NULL, '', 1, 4, 14),
	(18, 1, '2016-12-08 11:42:44', 1, 'Price bid', 1, 1, 1, 1, 1, 0, '2016-12-07 17:16:00', 4, '2016-12-07 17:16:00', 1, 0, NULL, '', 1, 4, 15),
	(20, 1, '2016-12-10 09:59:51', 1, 'Price bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 1, 4, 16),
	(21, 1, '2016-12-13 16:54:44', 1, 'Technical bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 1, 3, 17),
	(22, 1, '2016-12-13 16:54:44', 1, 'Price bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 2, 4, 17),
	(23, 1, '2016-12-13 18:46:45', 1, 'Technical bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 1, 3, 18),
	(24, 1, '2016-12-13 18:46:45', 1, 'Price bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 2, 4, 18),
	(25, 1, '2016-12-13 18:51:48', 1, 'Price bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 1, 4, 19),
	(26, 1, '2016-12-13 18:53:16', 1, 'Price bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 1, 4, 20),
	(27, 1, '2016-12-13 18:58:36', 1, 'Price bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 1, 4, 21),
	(28, 1, '2016-12-13 19:00:37', 1, 'Price bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 1, 4, 22),
	(29, 1, '2016-12-19 01:40:41', 1, 'Price bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 1, 4, 23),
	(30, 1, '2016-12-19 02:20:55', 1, 'Technical bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 1, 3, 24),
	(31, 1, '2016-12-19 02:20:55', 1, 'Price bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 2, 4, 24),
	(32, 1, '2016-12-19 02:31:43', 1, 'Technical bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 1, 3, 25),
	(33, 1, '2016-12-19 02:31:43', 1, 'Price bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 2, 4, 25),
	(34, 1, '2016-12-19 19:09:46', 1, 'Technical bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 1, 3, 26),
	(35, 1, '2016-12-19 19:09:46', 1, 'Price bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 2, 4, 26),
	(36, 1, '2016-12-20 17:48:03', 1, 'Price bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 1, 4, 27),
	(37, 1, '2016-12-20 19:36:14', 1, 'Technical bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 1, 3, 28),
	(38, 1, '2016-12-20 19:36:14', 1, 'Price bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 2, 4, 28),
	(39, 1, '2016-12-20 20:08:53', 1, 'Technical bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 1, 3, 29),
	(40, 1, '2016-12-20 20:08:53', 1, 'Price bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 2, 4, 29),
	(41, 263, '2016-12-21 14:48:41', 1, 'Technical bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 1, 3, 30),
	(42, 263, '2016-12-21 15:09:08', 1, 'Price bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 2, 4, 30),
	(43, 4, '2016-12-21 16:35:21', 1, 'Technical bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 1, 3, 31),
	(44, 855, '2016-12-21 17:33:43', 1, 'Technical bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 1, 3, 32),
	(45, 855, '2016-12-21 17:33:43', 1, 'Price bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 2, 4, 32),
	(46, 4, '2016-12-21 17:49:45', 1, 'Price bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 1, 4, 33),
	(47, 263, '2016-12-21 18:13:07', 1, 'Technical bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 1, 3, 34),
	(48, 263, '2016-12-21 18:13:07', 1, 'Price bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 2, 4, 34),
	(49, 263, '2016-12-21 19:16:44', 1, 'Technical bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 1, 3, 35),
	(50, 263, '2016-12-21 19:16:44', 1, 'Price bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 2, 4, 35),
	(51, 263, '2016-12-21 19:53:14', 1, 'Technical bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 1, 3, 36),
	(52, 263, '2016-12-21 19:53:14', 1, 'Price bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 2, 4, 36),
	(53, 263, '2016-12-21 20:04:38', 1, 'Technical bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 1, 3, 37),
	(54, 4, '2016-12-21 22:24:16', 1, 'Technical bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 1, 3, 38),
	(55, 4, '2016-12-21 22:24:16', 1, 'Price bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 2, 4, 38),
	(56, 4, '2016-12-22 05:30:49', 1, 'Technical bid', 1, 1, 1, 1, 1, 0, '2016-12-22 08:42:29', 4, '2016-12-22 08:42:29', 1, 0, NULL, '', 1, 3, 39),
	(57, 4, '2016-12-22 05:39:15', 1, 'Price bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 1, 4, 40),
	(58, 4, '2016-12-22 09:35:45', 1, 'Technical bid', 0, 0, 1, 1, 1, 0, '2016-12-22 09:52:00', 4, '2016-12-22 09:52:00', 1, 0, NULL, '', 1, 3, 41),
	(59, 4, '2016-12-22 09:52:19', 1, 'Technical bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 1, 3, 42),
	(60, 4, '2016-12-22 10:18:34', 1, 'Price bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 1, 4, 43),
	(61, 4, '2016-12-22 11:56:50', 1, 'Technical bid', 1, 1, 1, 1, 1, 0, '2016-12-22 12:31:58', 4, '2016-12-22 12:31:58', 1, 0, NULL, '', 1, 3, 44),
	(62, 4, '2016-12-24 06:34:53', 1, 'Technical bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 1, 3, 45),
	(63, 4, '2016-12-24 06:34:53', 1, 'Price bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 2, 4, 45),
	(64, 263, '2016-12-25 18:02:06', 1, 'Technical bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 1, 3, 49),
	(65, 263, '2016-12-25 18:02:06', 1, 'Price bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 2, 4, 49),
	(66, 263, '2016-12-25 18:08:00', 1, 'Technical bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 1, 3, 50),
	(67, 263, '2016-12-25 18:08:00', 1, 'Price bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 2, 4, 50),
	(68, 4, '2016-12-26 13:15:52', 1, 'Technical bid', 0, 1, 1, 1, 1, 0, '2016-12-26 01:31:00', 4, '2016-12-07 17:16:00', 1, 0, NULL, '', 1, 3, 51),
	(69, 4, '2016-12-26 13:15:52', 1, 'Price bid', 0, 1, 1, 1, 1, 0, '2016-12-26 01:31:00', 4, '2016-12-07 17:16:00', 1, 0, NULL, '', 2, 4, 51),
	(70, 263, '2016-12-26 15:51:53', 1, 'Technical bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 1, 3, 52),
	(71, 263, '2016-12-26 15:51:53', 1, 'Price bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 2, 4, 52),
	(73, 932, '2016-12-26 22:20:39', 1, 'Technical bid', 0, 0, 1, 0, 1, 0, '2016-12-26 10:59:00', 263, '2016-12-26 22:51:33', 1, 0, NULL, '', 1, 3, 54),
	(74, 932, '2016-12-26 22:20:39', 1, 'Price bid', 0, 0, 1, 0, 1, 0, '2016-12-26 10:59:00', 263, '2016-12-26 22:51:33', 1, 0, NULL, '', 2, 4, 54),
	(75, 932, '2016-12-26 23:09:53', 1, 'Price bid', 0, 0, 1, 0, 1, 0, '2016-12-27 04:55:00', 932, '2016-12-26 23:13:53', 1, 0, NULL, '', 1, 4, 53),
	(76, 263, '2016-12-26 23:19:52', 1, 'Price bid', 0, 0, 1, 1, 1, 0, '2016-12-26 11:29:00', 263, '2016-12-26 23:23:16', 1, 0, NULL, '', 1, 4, 55),
	(77, 263, '2016-12-26 23:36:15', 1, 'Price bid', 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 0, 0, NULL, '', 1, 4, 56),
	(78, 2, '2016-12-27 08:36:38', 1, 'Technical bid', 0, 0, 1, 1, 1, 0, '2016-12-27 08:46:00', 2, '2016-12-27 08:41:20', 1, 0, NULL, '', 1, 3, 57),
	(79, 2, '2016-12-27 08:36:39', 1, 'Price bid', 0, 0, 1, 1, 1, 0, '2016-12-27 08:46:00', 2, '2016-12-27 08:41:20', 1, 0, NULL, '', 2, 4, 57),
	(80, 263, '2016-12-28 02:54:18', 1, 'Emd & Document Fee', 1, 1, 1, 1, 1, 0, '2016-12-28 03:20:00', 932, '2016-12-28 03:12:02', 1, 0, NULL, '', 1, 1, 58),
	(81, 263, '2016-12-28 02:54:18', 1, 'Technical bid', 1, 1, 1, 1, 1, 0, '2016-12-28 03:20:00', 932, '2016-12-28 03:12:02', 1, 0, NULL, '', 2, 3, 58),
	(82, 263, '2016-12-28 02:54:18', 1, 'Price bid', 1, 1, 1, 1, 1, 0, '2016-12-28 03:20:00', 932, '2016-12-28 03:12:02', 1, 0, NULL, '', 3, 4, 58),
	(83, 263, '2016-12-28 03:30:17', 1, 'Emd & Document Fee', 0, 0, 0, 1, 0, 0, '2016-12-28 03:20:00', 0, NULL, 1, 0, NULL, '', 1, 1, 59),
	(84, 263, '2016-12-28 03:30:17', 1, 'Technical bid', 0, 0, 0, 1, 0, 0, '2016-12-28 03:20:00', 0, NULL, 1, 0, NULL, '', 2, 3, 59),
	(85, 263, '2016-12-28 03:30:17', 1, 'Price bid', 0, 0, 0, 1, 0, 0, '2016-12-28 03:20:00', 0, NULL, 1, 0, NULL, '', 3, 4, 59);
/*!40000 ALTER TABLE `tbl_tenderenvelope` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_tenderform
DROP TABLE IF EXISTS `tbl_tenderform`;
CREATE TABLE IF NOT EXISTS `tbl_tenderform` (
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
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_tenderform: ~52 rows (approximately)
/*!40000 ALTER TABLE `tbl_tenderform` DISABLE KEYS */;
INSERT INTO `tbl_tenderform` (`formId`, `cancelledBy`, `cancelledOn`, `createdBy`, `createdOn`, `cstatus`, `formFooter`, `formHeader`, `formName`, `incrementItems`, `isDocumentReq`, `isEncryptedDocument`, `isEncryptionReq`, `isEvaluationReq`, `isItemWiseDocAllowed`, `isMandatory`, `isMultipleFilling`, `isPriceBid`, `isSecondary`, `loadNoOfItems`, `masterFormId`, `minTablesReqForBidding`, `noOfTables`, `parentFormId`, `publishedBy`, `publishedOn`, `sortOrder`, `tenderid`, `envelopeid`) VALUES
	(1, NULL, NULL, 1, '2016-12-07 09:40:48', 1, 'Footer', 'Header', 'Price Bid Form1', -1, 2, 2, 2, 1, 2, 1, 2, 1, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 2, 10),
	(2, NULL, NULL, 1, '2016-12-07 12:05:23', 1, '', '', 'test 2', -1, 1, 1, 1, 1, 1, 1, 1, 2, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 3, 11),
	(3, NULL, NULL, 1, '2016-12-07 12:22:49', 1, 'footer', 'header', 'form 1', -1, 1, 1, 1, 1, 1, 1, 1, 2, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 4, 12),
	(5, NULL, NULL, 1, '2016-12-07 16:04:05', -1, 'Price bid2', 'Price bid1', 'Price bid', -1, 1, 2, 2, 1, 1, 1, 1, 2, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 2, 10),
	(6, NULL, NULL, 1, '2016-12-07 16:28:13', 1, 'footer', 'header', 'price bid form 1', -1, 1, 1, 1, 1, 1, 1, 1, 2, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 10, 13),
	(7, NULL, NULL, 1, '2016-12-07 19:24:37', -1, 'Demo Price Bid', 'Demo Price Bid', 'Demo Price Bid', -1, 1, 1, 1, 1, 1, 1, 1, 2, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 11, 14),
	(8, NULL, NULL, 1, '2016-12-08 03:04:40', -1, 'Price bid Form', 'Price bid Form', 'Price bid Form', -1, 1, 1, 1, 1, 1, 1, 1, 2, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 12, 15),
	(9, NULL, NULL, 1, '2016-12-08 06:43:49', 1, 'f', 'f', 'f', -1, 1, 1, 1, 1, 1, 1, 1, 2, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 5, 7),
	(10, NULL, NULL, 1, '2016-12-08 07:40:55', 1, 'footer', 'header', 'Food n beverages', -1, 1, 1, 1, 1, 1, 1, 1, 2, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 13, 16),
	(11, NULL, NULL, 1, '2016-12-08 09:15:15', 1, 'fdsf', 'header1', 'form nam1', -1, 1, 1, 1, 1, 1, 1, 1, 2, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 14, 17),
	(12, NULL, NULL, 1, '2016-12-08 11:48:57', 1, 'header footer', 'header test', 'Form name 1', -1, 1, 1, 1, 1, 1, 1, 1, 2, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 15, 18),
	(13, NULL, NULL, 1, '2016-12-13 17:40:19', 0, '', '', 'P1', -1, 1, 1, 1, 1, 1, 1, 1, 2, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 17, 22),
	(15, NULL, NULL, 1, '2016-12-19 19:24:42', 0, '', '', 'Price bid', -1, 1, 1, 1, 1, 1, 1, 1, 2, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 26, 35),
	(16, NULL, NULL, 1, '2016-12-20 16:55:28', 0, 'test', 'test', 'test', -1, 1, 1, 1, 1, 1, 1, 1, 2, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 26, 35),
	(17, NULL, NULL, 1, '2016-12-20 17:31:06', 0, '', '', 'test', -1, 1, 1, 1, 1, 1, 1, 1, 2, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 26, 35),
	(18, NULL, NULL, 1, '2016-12-20 17:49:47', 0, '', '', 'test', -1, 1, 1, 1, 1, 1, 1, 1, 2, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 27, 36),
	(19, NULL, NULL, 1, '2016-12-20 17:51:37', 0, '', '', 'test', -1, 1, 1, 1, 1, 1, 1, 1, 2, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 27, 36),
	(20, NULL, NULL, 1, '2016-12-20 20:15:54', 0, 'Technical form', 'Technical form', 'Technical form', -1, 1, 1, 1, 1, 1, 1, 1, 2, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 29, 39),
	(21, NULL, NULL, 1, '2016-12-20 20:17:34', 0, 'Price bid', 'Price bid', 'Price bid', -1, 1, 1, 1, 1, 1, 1, 1, 2, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 29, 40),
	(25, NULL, NULL, 1, '2016-12-20 20:22:54', 1, 'Price bid', 'Price bid', 'Price bid', -1, 1, 1, 1, 1, 1, 1, 1, 2, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 29, 40),
	(26, NULL, NULL, 4, '2016-12-21 05:53:57', 0, 'form footer', 'form header', 'technical form 1', -1, 1, 1, 1, 1, 1, 1, 1, 0, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 17, 21),
	(27, NULL, NULL, 4, '2016-12-21 06:15:53', 0, 'price bid footer', 'price bid header', 'price bid', -1, 1, 1, 1, 1, 1, 1, 1, 1, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 17, 22),
	(28, NULL, NULL, 263, '2016-12-21 14:55:30', 0, 'Tech 1', 'Tech 1', 'Tech 1', -1, 1, 1, 1, 1, 1, 1, 1, 0, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 30, 41),
	(29, NULL, NULL, 263, '2016-12-21 15:10:38', 0, 'Price bid', 'Price bid', 'Price bid', -1, 1, 1, 1, 1, 1, 1, 1, 1, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 30, 42),
	(31, NULL, NULL, 263, '2016-12-21 15:29:46', 0, '', '', 'Price bid form', -1, 1, 1, 1, 1, 1, 1, 1, 1, -1, 1, 1, 1, 2, 1, 1, NULL, 1, 30, 42),
	(33, NULL, NULL, 4, '2016-12-21 18:33:09', 0, 'Technical Footer', 'Technical Header', 'Technical Form name', -1, 0, 1, 1, 1, 1, 0, 1, 0, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 31, 43),
	(34, NULL, NULL, 855, '2016-12-21 17:47:55', 0, '', '', 'Price Bid', -1, 0, 1, 1, 1, 1, 0, 1, 1, -1, 1, 1, 1, 2, 1, 1, NULL, 1, 32, 45),
	(35, NULL, NULL, 855, '2016-12-21 17:54:12', 0, '', '', 'Technical Form', -1, 1, 1, 1, 1, 1, 1, 1, 0, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 32, 44),
	(36, NULL, NULL, 263, '2016-12-21 18:17:55', 0, '', '', 'Technical Form', -1, 1, 1, 1, 1, 1, 1, 1, 0, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 34, 47),
	(37, NULL, NULL, 263, '2016-12-21 18:21:03', 0, '', '', 'Price Bid', -1, 1, 1, 1, 1, 1, 1, 1, 1, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 34, 48),
	(38, NULL, NULL, 263, '2016-12-21 19:23:56', 1, '', '', 'Tech Form 1', -1, 0, 1, 1, 1, 1, 0, 1, 0, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 35, 49),
	(39, NULL, NULL, 263, '2016-12-21 19:29:24', 1, '', '', 'Price bid', -1, 1, 1, 1, 1, 1, 1, 1, 1, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 35, 50),
	(40, NULL, NULL, 263, '2016-12-22 07:49:52', 0, 'footer', 'Test header', 'Test form changed', -1, 1, 1, 1, 1, 1, 1, 1, 1, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 28, 38),
	(41, NULL, NULL, 263, '2016-12-21 19:55:25', 0, '', '', 'Tech Form 1', -1, 1, 1, 1, 1, 1, 1, 1, 0, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 36, 51),
	(42, NULL, NULL, 263, '2016-12-21 19:56:43', 0, '', '', 'Price bid', -1, 1, 1, 1, 1, 1, 1, 1, 1, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 36, 52),
	(43, NULL, NULL, 263, '2016-12-21 20:07:20', 1, '', '', 'form', -1, 1, 1, 1, 1, 1, 1, 1, 0, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 37, 53),
	(44, NULL, NULL, 4, '2016-12-22 07:19:29', 1, 't', 't', 't1111', -1, 0, 1, 1, 1, 1, 0, 1, 0, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 39, 56),
	(45, NULL, NULL, 263, '2016-12-22 09:51:36', 0, 'Footer', 'Header', 'demo Technical', -1, 1, 1, 1, 1, 1, 1, 1, 0, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 28, 37),
	(47, NULL, NULL, 4, '2016-12-22 09:42:08', 1, 's', 's', 's', -1, 1, 1, 1, 1, 1, 1, 1, 0, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 41, 58),
	(48, NULL, NULL, 4, '2016-12-22 10:19:40', 1, 'p', 'p', 'p', -1, 1, 1, 1, 1, 1, 1, 1, 1, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 43, 60),
	(49, NULL, NULL, 4, '2016-12-22 12:03:20', 1, 'Tech Form 1 Footer', 'Tech Form 1 HEader', 'Tech Form 1', -1, 1, 1, 1, 1, 1, 1, 1, 0, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 44, 61),
	(50, NULL, NULL, 263, '2016-12-27 10:22:07', 0, '', 'Item 1', 'Price bid 1', -1, 1, 1, 1, 1, 1, 1, 1, 1, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 50, 67),
	(51, NULL, NULL, 263, '2016-12-25 18:20:01', 0, '', 'Form 2', 'Form 2', -1, 1, 1, 1, 1, 1, 1, 1, 1, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 50, 67),
	(52, NULL, NULL, 4, '2016-12-26 13:17:52', 1, 'tech form f', 'tech form h', 'tech form', -1, 1, 1, 1, 1, 1, 1, 1, 0, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 51, 68),
	(53, NULL, NULL, 4, '2016-12-26 13:19:50', 1, 'Price Bid Form1 f', 'Price Bid Form1 h', 'Price Bid Form1', -1, 1, 1, 1, 1, 1, 1, 1, 1, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 51, 69),
	(54, NULL, NULL, 263, '2016-12-26 16:20:12', 0, '', 'Tech form1', 'Tech form1', -1, 1, 1, 1, 1, 1, 1, 1, 0, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 52, 70),
	(55, NULL, NULL, 932, '2016-12-26 22:25:32', 2, '', 'Tech Form 1', 'Tech Form 1', -1, 1, 1, 1, 1, 1, 1, 1, 0, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 54, 73),
	(56, NULL, NULL, 932, '2016-12-26 22:30:24', 0, '', 'Price bid 1', 'Price bid 1', -1, 1, 1, 1, 1, 1, 1, 1, 1, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 54, 74),
	(58, NULL, NULL, 932, '2016-12-26 22:36:05', 2, '', 'tet', 'test', -1, 1, 1, 1, 1, 1, 1, 1, 0, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 54, 73),
	(59, NULL, NULL, 932, '2016-12-26 23:11:14', 1, '', 'hgf', 'hgfh', -1, 1, 1, 1, 1, 1, 1, 1, 1, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 53, 75),
	(60, NULL, NULL, 263, '2016-12-26 23:21:40', 1, '', 'ghjgh', 'ghjgh', -1, 1, 1, 1, 1, 1, 1, 1, 1, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 55, 76),
	(61, NULL, NULL, 263, '2016-12-26 23:30:04', 1, '', 'fghfg', 'nfghgf', -1, 1, 1, 1, 1, 1, 1, 1, 1, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 55, 76),
	(62, NULL, NULL, 2, '2016-12-27 08:37:22', 1, '', 't2', 't1', -1, 1, 1, 1, 1, 1, 1, 1, 0, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 57, 78),
	(63, NULL, NULL, 263, '2016-12-27 10:27:30', 0, '', 't2', 't2', -1, 1, 1, 1, 1, 1, 1, 1, 1, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 57, 79),
	(64, NULL, NULL, 263, '2016-12-28 02:58:46', 1, '', 'EMD form', 'EMD form', -1, 1, 1, 1, 1, 1, 1, 1, 0, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 58, 80),
	(65, NULL, NULL, 263, '2016-12-28 02:59:54', 1, '', 'Technical specification of the laptop', 'Technical specification of the laptop', -1, 1, 1, 1, 1, 1, 1, 1, 0, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 58, 81),
	(66, NULL, NULL, 263, '2016-12-28 03:01:48', 1, '', 'Price bid details', 'Price bid details', -1, 1, 1, 1, 1, 1, 1, 1, 1, -1, 1, 1, 1, 1, 1, 1, NULL, 1, 58, 82);
/*!40000 ALTER TABLE `tbl_tenderform` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_tenderformula
DROP TABLE IF EXISTS `tbl_tenderformula`;
CREATE TABLE IF NOT EXISTS `tbl_tenderformula` (
  `cellId` int(11) NOT NULL,
  `cellNo` int(11) NOT NULL,
  `colFormula` longtext NOT NULL,
  `columnNo` int(11) NOT NULL,
  `displayFormula` longtext NOT NULL,
  `formula` longtext NOT NULL,
  `formulaId` int(11) NOT NULL AUTO_INCREMENT,
  `formulaType` int(11) NOT NULL,
  `columnId` int(11) NOT NULL,
  `formId` int(11) NOT NULL,
  `tableId` int(11) NOT NULL,
  `validationMessage` longtext,
  PRIMARY KEY (`formulaId`),
  KEY `FK_tbl_tenderformula_column` (`columnId`),
  KEY `FK_tbl_tenderformula_form` (`formId`),
  KEY `FK_tbl_tenderformula_table` (`tableId`),
  CONSTRAINT `FK_tbl_tenderformula_column` FOREIGN KEY (`columnId`) REFERENCES `tbl_tendercolumn` (`columnId`),
  CONSTRAINT `FK_tbl_tenderformula_form` FOREIGN KEY (`formId`) REFERENCES `tbl_tenderform` (`formId`),
  CONSTRAINT `FK_tbl_tenderformula_table` FOREIGN KEY (`tableId`) REFERENCES `tbl_tendertable` (`tableId`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_tenderformula: ~14 rows (approximately)
/*!40000 ALTER TABLE `tbl_tenderformula` DISABLE KEYS */;
INSERT INTO `tbl_tenderformula` (`cellId`, `cellNo`, `colFormula`, `columnNo`, `displayFormula`, `formula`, `formulaId`, `formulaType`, `columnId`, `formId`, `tableId`, `validationMessage`) VALUES
	(0, 0, '', 0, 'total rate = qty*unit rate', 'txtcell_0_70*txtcell_0_71', 1, 0, 72, 27, 19, ''),
	(0, 0, '', 0, 'Total Rate = Qty*Unit Rate', 'txtcell_0_78*txtcell_0_79', 2, 0, 80, 29, 19, ''),
	(0, 0, '', 0, 'TR 1 = Qty1*Ur 1', 'txtcell_0_82*txtcell_0_83', 3, 0, 84, 31, 19, ''),
	(0, 0, '', 0, 'TR = Qty*UR', 'txtcell_0_86*txtcell_0_87', 4, 0, 88, 31, 19, ''),
	(0, 0, '', 0, 'TR = Qty*UR', 'txtcell_0_108*txtcell_0_109', 5, 0, 110, 37, 19, ''),
	(0, 0, '', 0, 'Total Rate = Qty*Unit Rate', 'txtcell_0_123*txtcell_0_124', 6, 0, 125, 42, 19, ''),
	(0, 0, '', 0, 'Total = Qty*Price', 'txtcell_0_117*txtcell_0_118', 7, 0, 119, 40, 19, ''),
	(0, 0, '', 0, 'Total Rate = Qty+Unit Rate', 'txtcell_0_113+txtcell_0_114', 8, 0, 115, 39, 19, ''),
	(0, 0, '', 0, 'total = qty*unit reate', 'txtcell_0_138*txtcell_0_139', 9, 0, 140, 48, 19, ''),
	(0, 0, '', 0, 'ut = qty*total', 'txtcell_0_149*txtcell_0_150', 10, 0, 151, 51, 19, ''),
	(0, 0, '', 0, 'total rate = qty*rate', 'txtcell_0_155*txtcell_0_156', 11, 0, 157, 53, 19, ''),
	(0, 0, '', 0, 'TR = Qty*UR', 'txtcell_0_161*txtcell_0_162', 12, 0, 163, 56, 19, ''),
	(0, 0, '', 0, 'TR = Qty*UT', 'txtcell_0_169*txtcell_0_170', 13, 0, 171, 59, 19, ''),
	(0, 0, '', 0, 'gfhgf = ghfd*fghfhg', 'txtcell_0_173*txtcell_0_174', 14, 0, 175, 60, 19, ''),
	(0, 0, '', 0, 'vbbvc = vcbvc*bvcb', 'txtcell_0_177*txtcell_0_178', 15, 0, 179, 61, 19, ''),
	(0, 0, '', 0, 'Total Rate = Qty+Unit Rate', 'txtcell_0_94+txtcell_0_95', 16, 0, 96, 34, 19, ''),
	(0, 0, '', 0, 'total rate = qty*rate', 'txtcell_0_183*txtcell_0_184', 17, 0, 185, 63, 19, ''),
	(0, 0, '', 0, 'TR = UT*Qty', 'txtcell_0_146*txtcell_0_145', 18, 0, 147, 50, 19, ''),
	(0, 0, '', 0, 'ut = qty*total', 'txtcell_0_149*txtcell_0_150', 19, 0, 151, 51, 19, ''),
	(0, 0, '', 0, 'Total Rate = Qty*Unit Rate', 'txtcell_0_191*txtcell_0_192', 20, 0, 193, 66, 19, '');
/*!40000 ALTER TABLE `tbl_tenderformula` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_tendergovcolumn
DROP TABLE IF EXISTS `tbl_tendergovcolumn`;
CREATE TABLE IF NOT EXISTS `tbl_tendergovcolumn` (
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_tendergovcolumn: ~15 rows (approximately)
/*!40000 ALTER TABLE `tbl_tendergovcolumn` DISABLE KEYS */;
INSERT INTO `tbl_tendergovcolumn` (`govColumnId`, `cellId`, `columnNo`, `ipAddress`, `tenderid`, `columnid`, `formid`, `tableid`) VALUES
	(1, 0, 0, '0.0.0.0', 17, 70, 27, 24),
	(3, 0, 0, '0.0.0.0', 17, 71, 27, 24),
	(4, 0, 0, '0.0.0.0', 30, 79, 29, 26),
	(5, 0, 0, '0.0.0.0', 30, 87, 31, 28),
	(6, 0, 0, '0.0.0.0', 30, 84, 31, 27),
	(7, 0, 0, '0.0.0.0', 34, 109, 37, 35),
	(8, 0, 0, '0.0.0.0', 35, 114, 39, 37),
	(9, 0, 0, '0.0.0.0', 36, 124, 42, 40),
	(11, 0, 0, '0.0.0.0', 28, 118, 40, 38),
	(12, 0, 0, '0.0.0.0', 35, 114, 39, 37),
	(13, 0, 0, '0.0.0.0', 43, 138, 48, 45),
	(14, 0, 0, '0.0.0.0', 54, 163, 56, 53),
	(15, 0, 0, '0.0.0.0', 54, 162, 56, 53),
	(16, 0, 0, '0.0.0.0', 53, 170, 59, 56),
	(17, 0, 0, '0.0.0.0', 55, 174, 60, 57),
	(18, 0, 0, '0.0.0.0', 55, 178, 61, 58),
	(19, 0, 0, '0.0.0.0', 57, 183, 63, 60),
	(20, 0, 0, '0.0.0.0', 58, 192, 66, 63);
/*!40000 ALTER TABLE `tbl_tendergovcolumn` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_tendermatrixjson
DROP TABLE IF EXISTS `tbl_tendermatrixjson`;
CREATE TABLE IF NOT EXISTS `tbl_tendermatrixjson` (
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

-- Dumping data for table eauctiontender.tbl_tendermatrixjson: ~0 rows (approximately)
/*!40000 ALTER TABLE `tbl_tendermatrixjson` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_tendermatrixjson` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_tenderopen
DROP TABLE IF EXISTS `tbl_tenderopen`;
CREATE TABLE IF NOT EXISTS `tbl_tenderopen` (
  `tenderOpenId` int(11) NOT NULL AUTO_INCREMENT,
  `bidSignData` longtext,
  `createdBy` int(11) NOT NULL,
  `createdOn` datetime DEFAULT CURRENT_TIMESTAMP,
  `decryptionLevel` int(11) NOT NULL,
  `ipAddress` longtext NOT NULL,
  `companyid` int(11) NOT NULL,
  `tenderid` int(11) NOT NULL,
  `envelopeid` int(11) NOT NULL,
  `formid` int(11) NOT NULL,
  `bidderid` int(11) NOT NULL,
  PRIMARY KEY (`tenderOpenId`),
  KEY `FK_tbl_tenderopen_tender` (`tenderid`),
  KEY `FK_tbl_tenderopen_company` (`companyid`),
  KEY `FK_tbl_tenderopen_envelope` (`envelopeid`),
  KEY `FK_tbl_tenderopen_form` (`formid`),
  CONSTRAINT `FK7p2abua96nvpbbm8wy31oah28` FOREIGN KEY (`tenderid`) REFERENCES `tbl_tender` (`tenderId`),
  CONSTRAINT `FK_tbl_tenderopen_company` FOREIGN KEY (`companyid`) REFERENCES `tbl_company` (`companyid`),
  CONSTRAINT `FK_tbl_tenderopen_envelope` FOREIGN KEY (`envelopeid`) REFERENCES `tbl_tenderenvelope` (`envelopeId`),
  CONSTRAINT `FK_tbl_tenderopen_form` FOREIGN KEY (`formid`) REFERENCES `tbl_tenderform` (`formId`),
  CONSTRAINT `FK_tbl_tenderopen_tender` FOREIGN KEY (`tenderid`) REFERENCES `tbl_tender` (`tenderId`),
  CONSTRAINT `FKbn9il2t8bhym6uj8wn4712bsk` FOREIGN KEY (`envelopeid`) REFERENCES `tbl_tenderenvelope` (`envelopeId`),
  CONSTRAINT `FKr67cw2tddltmqtebb8jxspj6` FOREIGN KEY (`companyid`) REFERENCES `tbl_company` (`companyid`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_tenderopen: ~24 rows (approximately)
/*!40000 ALTER TABLE `tbl_tenderopen` DISABLE KEYS */;
INSERT INTO `tbl_tenderopen` (`tenderOpenId`, `bidSignData`, `createdBy`, `createdOn`, `decryptionLevel`, `ipAddress`, `companyid`, `tenderid`, `envelopeid`, `formid`, `bidderid`) VALUES
	(16, NULL, 4, '2016-11-24 17:00:00', 1, '192.168.0.1', 1, 2, 10, 1, 9),
	(17, NULL, 4, '2016-11-24 17:00:00', 1, '192.168.0.1', 1, 3, 11, 2, 9),
	(18, NULL, 4, '2016-11-24 17:00:00', 1, '192.168.0.1', 1, 4, 12, 3, 9),
	(19, NULL, 4, '2016-11-24 17:00:00', 1, '192.168.0.1', 1, 10, 13, 6, 9),
	(20, NULL, 4, '2016-11-24 17:00:00', 1, '192.168.0.1', 1, 5, 7, 9, 256),
	(21, NULL, 4, '2016-11-24 17:00:00', 1, '192.168.0.1', 1, 13, 16, 10, 256),
	(22, NULL, 4, '2016-11-24 17:00:00', 1, '192.168.0.1', 281, 13, 16, 10, 282),
	(23, NULL, 4, '2016-11-24 17:00:00', 1, '192.168.0.1', 295, 14, 17, 11, 296),
	(24, NULL, 4, '2016-11-24 17:00:00', 1, '192.168.0.1', 292, 14, 17, 11, 293),
	(25, NULL, 4, '2016-11-24 17:00:00', 1, '192.168.0.1', 300, 15, 18, 12, 301),
	(26, NULL, 4, '2016-11-24 17:00:00', 1, '192.168.0.1', 292, 15, 18, 12, 293),
	(27, NULL, 254, '2016-12-22 09:20:46', 1, '122.169.94.122', 255, 39, 56, 44, 256),
	(28, NULL, 254, '2016-12-22 09:43:58', 1, '122.169.94.122', 255, 41, 58, 47, 256),
	(29, NULL, 254, '2016-12-22 12:28:12', 1, '122.169.94.122', 255, 44, 61, 49, 256),
	(30, NULL, 254, '2016-12-26 13:40:51', 1, '122.169.94.122', 255, 51, 68, 52, 256),
	(31, NULL, 254, '2016-12-26 13:40:51', 1, '122.169.94.122', 255, 51, 69, 53, 256),
	(32, NULL, 254, '2016-12-27 09:14:17', 1, '122.169.94.122', 255, 57, 78, 62, 256),
	(33, NULL, 254, '2016-12-27 09:14:17', 1, '122.169.94.122', 255, 57, 79, 63, 256),
	(34, NULL, 254, '2016-12-28 03:20:59', 1, '49.34.62.52', 255, 58, 80, 64, 256),
	(35, NULL, 254, '2016-12-28 03:20:59', 1, '49.34.62.52', 255, 58, 81, 65, 256),
	(36, NULL, 254, '2016-12-28 03:20:59', 1, '49.34.62.52', 255, 58, 82, 66, 256),
	(37, NULL, 920, '2016-12-28 03:21:35', 1, '49.34.62.52', 921, 58, 80, 64, 922),
	(38, NULL, 920, '2016-12-28 03:21:35', 1, '49.34.62.52', 921, 58, 81, 65, 922),
	(39, NULL, 920, '2016-12-28 03:21:35', 1, '49.34.62.52', 921, 58, 82, 66, 922);
/*!40000 ALTER TABLE `tbl_tenderopen` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_tenderproxybid
DROP TABLE IF EXISTS `tbl_tenderproxybid`;
CREATE TABLE IF NOT EXISTS `tbl_tenderproxybid` (
  `cellValue` varchar(11) NOT NULL,
  `createdBy` int(11) NOT NULL,
  `createdOn` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ipAddress` varchar(11) NOT NULL,
  `proxyBidId` int(11) NOT NULL AUTO_INCREMENT,
  `rowId` int(11) NOT NULL,
  `isUpdatedFrom` int(11) NOT NULL,
  `tenderId` int(11) NOT NULL,
  `cellId` int(11) NOT NULL,
  `columnId` int(11) NOT NULL,
  `tableId` int(11) NOT NULL,
  `companyId` int(11) NOT NULL,
  PRIMARY KEY (`proxyBidId`),
  KEY `FK_tbl_tenderproxybid_table` (`tableId`),
  KEY `FK_tbl_tenderproxybid_column` (`columnId`),
  KEY `FK_tbl_tenderproxybid_cell` (`cellId`),
  KEY `FK_tbl_tenderproxybid_tender` (`tenderId`),
  KEY `FK_tbl_tenderproxybid_company` (`companyId`),
  CONSTRAINT `FK_tbl_tenderproxybid_cell` FOREIGN KEY (`cellId`) REFERENCES `tbl_tendercell` (`cellId`),
  CONSTRAINT `FK_tbl_tenderproxybid_column` FOREIGN KEY (`columnId`) REFERENCES `tbl_tendercolumn` (`columnId`),
  CONSTRAINT `FK_tbl_tenderproxybid_company` FOREIGN KEY (`companyId`) REFERENCES `tbl_company` (`companyid`),
  CONSTRAINT `FK_tbl_tenderproxybid_table` FOREIGN KEY (`tableId`) REFERENCES `tbl_tendertable` (`tableId`),
  CONSTRAINT `FK_tbl_tenderproxybid_tender` FOREIGN KEY (`tenderId`) REFERENCES `tbl_tender` (`tenderId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_tenderproxybid: ~0 rows (approximately)
/*!40000 ALTER TABLE `tbl_tenderproxybid` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_tenderproxybid` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_tenderrebate
DROP TABLE IF EXISTS `tbl_tenderrebate`;
CREATE TABLE IF NOT EXISTS `tbl_tenderrebate` (
  `tenderRebateId` int(11) NOT NULL AUTO_INCREMENT,
  `createdBy` int(11) NOT NULL,
  `createdOn` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `rebateEncrypt` varchar(20) NOT NULL,
  `rebateValue` varchar(20) NOT NULL,
  `companyId` int(11) NOT NULL,
  `rebateId` int(11) NOT NULL,
  PRIMARY KEY (`tenderRebateId`),
  KEY `FK_tbl_tenderrebate_company` (`companyId`),
  KEY `FK_tbl_tenderrebate_rebate` (`rebateId`),
  CONSTRAINT `FK_tbl_tenderrebate_company` FOREIGN KEY (`companyId`) REFERENCES `tbl_company` (`companyid`),
  CONSTRAINT `FK_tbl_tenderrebate_rebate` FOREIGN KEY (`rebateId`) REFERENCES `tbl_rebate` (`rebateId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_tenderrebate: ~0 rows (approximately)
/*!40000 ALTER TABLE `tbl_tenderrebate` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_tenderrebate` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_tenderrebatedetail
DROP TABLE IF EXISTS `tbl_tenderrebatedetail`;
CREATE TABLE IF NOT EXISTS `tbl_tenderrebatedetail` (
  `decryptionLevel` int(11) NOT NULL,
  `rebateValue` varchar(20) NOT NULL,
  `tenderRebateId` int(11) NOT NULL,
  `tenderRebateDetailId` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`tenderRebateDetailId`),
  KEY `FK_tbl_tenderrebatedetail` (`tenderRebateId`),
  CONSTRAINT `FK_tbl_tenderrebatedetail` FOREIGN KEY (`tenderRebateId`) REFERENCES `tbl_tenderrebate` (`tenderRebateId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_tenderrebatedetail: ~0 rows (approximately)
/*!40000 ALTER TABLE `tbl_tenderrebatedetail` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_tenderrebatedetail` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_tendertable
DROP TABLE IF EXISTS `tbl_tendertable`;
CREATE TABLE IF NOT EXISTS `tbl_tendertable` (
  `tableId` int(11) NOT NULL AUTO_INCREMENT,
  `createdBy` int(11) NOT NULL,
  `createdOn` datetime NOT NULL,
  `formid` int(11) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_tendertable: ~57 rows (approximately)
/*!40000 ALTER TABLE `tbl_tendertable` DISABLE KEYS */;
INSERT INTO `tbl_tendertable` (`tableId`, `createdBy`, `createdOn`, `formid`, `hasGTRow`, `isMandatory`, `isMultipleFilling`, `isPartialFillingAllowed`, `noOfCols`, `noOfRows`, `sortOrder`, `tableFooter`, `tableHeader`, `tableName`, `updatedBy`, `updatedOn`) VALUES
	(1, 0, '2016-12-07 09:40:48', 1, 0, 0, 0, 0, 4, 3, 1, 'Table footer', 'Table Header 1', 'Table name 1', 1, '2016-12-07 09:40:48'),
	(2, 0, '2016-12-07 12:05:23', 2, 0, 0, 0, 0, 2, 1, 1, '', 'test', 'test', 1, '2016-12-07 12:05:23'),
	(3, 0, '2016-12-07 12:22:49', 3, 0, 0, 0, 0, 2, 1, 1, 'dgf', 'table 1', 'tes', 1, '2016-12-07 12:22:49'),
	(4, 0, '2016-12-07 15:34:35', 0, 0, 0, 0, 0, -1, -1, 1, '', '', '', 1, '2016-12-07 15:34:35'),
	(5, 0, '2016-12-07 16:04:05', 5, 0, 0, 0, 0, 5, 2, 1, '', 'Test Table1', 'Test Table', 1, '2016-12-07 16:04:05'),
	(6, 0, '2016-12-07 16:28:13', 6, 0, 0, 0, 0, 3, 1, 1, 'test', 'Table header', 'Table name 1', 1, '2016-12-07 16:28:13'),
	(7, 0, '2016-12-07 19:24:37', 7, 0, 0, 0, 0, 4, 2, 1, 'Demo Price Bid', 'Demo Price Bid', 'Demo Price Bid Table', 1, '2016-12-07 19:24:37'),
	(8, 0, '2016-12-08 03:04:40', 8, 0, 0, 0, 0, 4, 3, 1, 'Price bid Form', 'Price bid Form', 'Price bid Form', 1, '2016-12-08 03:04:40'),
	(9, 0, '2016-12-08 06:43:49', 9, 0, 0, 0, 0, 1, 1, 1, 'f', 'f', 'f', 1, '2016-12-08 06:43:49'),
	(10, 0, '2016-12-08 07:40:55', 10, 0, 0, 0, 0, 2, 1, 1, '', 'table', '1', 1, '2016-12-08 07:40:55'),
	(11, 0, '2016-12-08 09:15:15', 11, 0, 0, 0, 0, 1, 1, 1, 'est', 'test', 'test', 1, '2016-12-08 09:15:15'),
	(12, 0, '2016-12-08 11:48:57', 12, 0, 0, 0, 0, 4, 1, 1, '', 'table header 1', 'table name 1', 1, '2016-12-08 11:48:57'),
	(13, 0, '2016-12-13 17:40:19', 13, 0, 0, 0, 0, 4, -1, 1, '', '', '', 1, '2016-12-13 17:40:19'),
	(14, 0, '2016-12-19 02:22:33', 0, 0, 0, 0, 0, -1, -1, 1, '', '', '', 1, '2016-12-19 02:22:33'),
	(15, 0, '2016-12-19 19:24:42', 15, 0, 0, 0, 0, 4, 2, 1, '', 'Price bid Table', 'Price bid Table', 1, '2016-12-19 19:24:42'),
	(16, 0, '2016-12-20 16:55:28', 16, 0, 0, 0, 0, 4, 2, 1, '', 'test', 'testr', 1, '2016-12-20 16:55:28'),
	(17, 0, '2016-12-20 17:31:06', 17, 0, 0, 0, 0, 4, 1, 1, '', 'test', 'test', 1, '2016-12-20 17:31:06'),
	(18, 0, '2016-12-20 17:49:47', 18, 0, 0, 0, 0, 4, -1, 1, '', '', 'test', 1, '2016-12-20 17:49:47'),
	(19, 0, '2016-12-20 17:51:37', 19, 0, 0, 0, 0, 4, -1, 1, '', '', 'test', 1, '2016-12-20 17:51:37'),
	(20, 0, '2016-12-20 20:15:54', 20, 0, 0, 0, 0, 2, 1, 1, '', 'Technical form', 'Technical form', 1, '2016-12-20 20:15:54'),
	(21, 0, '2016-12-20 20:17:34', 21, 0, 0, 0, 0, 4, -1, 1, '', 'Price bid', 'Price bid', 1, '2016-12-20 20:17:34'),
	(22, 0, '2016-12-20 20:22:54', 25, 0, 0, 0, 0, 4, 2, 1, '', '', '', 1, '2016-12-20 20:22:54'),
	(23, 4, '2016-12-21 05:53:57', 26, 0, 0, 0, 0, 2, 1, 1, 'test', 'table header 1', 'table name 1', 1, '2016-12-21 05:53:57'),
	(24, 4, '2016-12-21 06:15:53', 27, 0, 0, 0, 0, 4, 2, 1, 'test', 'table name header', 'table name ', 1, '2016-12-21 06:15:53'),
	(25, 263, '2016-12-21 14:55:30', 28, 0, 0, 0, 0, 4, 3, 1, '', 'Tech 1', 'Tech 1', 1, '2016-12-21 14:55:30'),
	(26, 263, '2016-12-21 15:10:38', 29, 0, 0, 0, 0, 4, 2, 1, '', 'Price bid ', 'Price bid ', 1, '2016-12-21 15:10:38'),
	(27, 263, '2016-12-21 15:29:46', 31, 0, 0, 0, 0, 4, 1, 1, '', '', 'Price bid form table 2', 1, '2016-12-21 15:29:46'),
	(28, 263, '2016-12-21 15:29:46', 31, 0, 0, 0, 0, 4, 3, 1, '', '', 'Price bid form', 1, '2016-12-21 15:29:46'),
	(29, 4, '2016-12-21 17:31:33', 32, 0, 1, 0, 0, 3, 3, 1, 'test footer', 'Technical Table Header', 'Technical Table name', 1, '2016-12-21 17:31:33'),
	(30, 4, '2016-12-21 17:37:23', 33, 0, 1, 0, 0, 3, 3, 1, 'Technical Table ', 'Technical Table  Header', 'Technical Table Name', 1, '2016-12-21 17:37:23'),
	(31, 855, '2016-12-21 17:45:29', 34, 0, 1, 0, 0, 4, 2, 1, '', '', 'Price Bid ', 1, '2016-12-21 17:45:29'),
	(32, 855, '2016-12-21 17:45:29', 34, 0, 1, 0, 0, 4, 2, 1, '', '', 'Price Bid ', 1, '2016-12-21 17:45:29'),
	(33, 855, '2016-12-21 17:54:13', 35, 0, 1, 0, 0, 4, 1, 1, '', '', 'Technical Form', 1, '2016-12-21 17:54:13'),
	(34, 263, '2016-12-21 18:17:55', 36, 0, 1, 0, 0, 2, 2, 1, '', '', 'Technical Form', 1, '2016-12-21 18:17:55'),
	(35, 263, '2016-12-21 18:21:03', 37, 0, 1, 0, 0, 4, 2, 1, '', '', 'Price bid', 1, '2016-12-21 18:21:03'),
	(36, 263, '2016-12-21 19:18:18', 38, 0, 1, 0, 0, 1, 1, 1, '', '', 'Tech Form 12', 1, '2016-12-21 19:18:18'),
	(37, 263, '2016-12-21 19:29:24', 39, 0, 1, 0, 0, 4, 2, 1, '', '', 'price bid', 1, '2016-12-21 19:29:24'),
	(38, 263, '2016-12-21 19:31:31', 40, 0, 1, 0, 0, 4, 2, 1, 'Footer', 'table1', 'tbl name', 1, '2016-12-21 19:31:31'),
	(39, 263, '2016-12-21 19:55:25', 41, 0, 1, 0, 0, 2, 2, 1, '', '', 'tech form', 1, '2016-12-21 19:55:25'),
	(40, 263, '2016-12-21 19:56:43', 42, 0, 1, 0, 0, 4, 2, 1, '', '', 'Price bid', 1, '2016-12-21 19:56:43'),
	(41, 263, '2016-12-21 20:07:20', 43, 0, 1, 0, 0, 2, 1, 1, '', '', '', 1, '2016-12-21 20:07:20'),
	(42, 4, '2016-12-22 05:34:00', 44, 0, 1, 0, 0, 3, 2, 1, 't', 't1', 't', 1, '2016-12-22 05:34:00'),
	(43, 263, '2016-12-22 08:55:15', 45, 0, 1, 0, 0, 3, 2, 1, 'Footer ', 'header', 'table 1', 1, '2016-12-22 08:55:15'),
	(44, 4, '2016-12-22 09:42:08', 47, 0, 1, 0, 0, 3, 3, 1, 'test', 's', 's', 1, '2016-12-22 09:42:08'),
	(45, 4, '2016-12-22 10:19:40', 48, 0, 1, 0, 0, 4, 2, 1, 'teset', 'p', 'p', 1, '2016-12-22 10:19:40'),
	(46, 4, '2016-12-22 12:03:20', 49, 0, 1, 0, 0, 3, 3, 1, 'Tech Table 1 Footer', 'Tech Table 1 Header', 'Tech Table 1 Name', 1, '2016-12-22 12:03:20'),
	(47, 263, '2016-12-27 10:22:07', 50, 0, 1, 0, 0, 4, 2, 1, '', '', 'Price bid 1', 1, '2016-12-27 10:22:07'),
	(48, 263, '2016-12-25 18:20:01', 51, 0, 1, 0, 0, 4, 1, 1, '', '', 'Form 2', 1, '2016-12-25 18:20:01'),
	(49, 4, '2016-12-26 13:17:52', 52, 0, 1, 0, 0, 2, 4, 1, 'footer', 'tech form table h', 'tech form table', 1, '2016-12-26 13:17:52'),
	(50, 4, '2016-12-26 13:19:50', 53, 0, 1, 0, 0, 4, 4, 1, 'test', 'Price Bid Form1 Table  h', 'Price Bid Form1 Table', 1, '2016-12-26 13:19:50'),
	(51, 263, '2016-12-26 16:20:12', 54, 0, 1, 0, 0, -2, 2, 1, '', '', 'Tech Table', 1, '2016-12-26 16:20:12'),
	(52, 932, '2016-12-26 22:25:32', 55, 0, 1, 0, 0, 2, 2, 1, '', '', 'Tech Form 1', 1, '2016-12-26 22:25:32'),
	(53, 932, '2016-12-26 22:30:24', 56, 0, 1, 0, 0, 4, 1, 1, '', '', 'Price bid 1', 1, '2016-12-26 22:30:24'),
	(54, 932, '2016-12-26 22:34:18', 0, 0, 1, 0, 0, 2, 1, 1, '', '', 'Tech Form 2', 1, '2016-12-26 22:34:18'),
	(55, 932, '2016-12-26 22:36:05', 58, 0, 1, 0, 0, 2, 1, 1, '', '', 'test', 1, '2016-12-26 22:36:05'),
	(56, 932, '2016-12-26 23:11:14', 59, 0, 1, 0, 0, 4, 1, 1, '', '', 'hghg', 1, '2016-12-26 23:11:14'),
	(57, 263, '2016-12-26 23:21:40', 60, 0, 1, 0, 0, 4, 1, 1, '', '', 'ghjgh', 1, '2016-12-26 23:21:40'),
	(58, 263, '2016-12-26 23:30:04', 61, 0, 1, 0, 0, 4, 1, 1, '', '', 'gfhf', 1, '2016-12-26 23:30:04'),
	(59, 2, '2016-12-27 08:37:22', 62, 0, 1, 0, 0, 2, 2, 1, 'test', 'g3', 'g4', 1, '2016-12-27 08:37:22'),
	(60, 263, '2016-12-27 10:27:30', 63, 0, 1, 0, 0, 4, 3, 1, 'test', 'dfg', 'dfv', 1, '2016-12-27 10:27:30'),
	(61, 263, '2016-12-28 02:58:46', 64, 0, 1, 0, 0, 2, 1, 1, '', '', 'EMD form', 1, '2016-12-28 02:58:46'),
	(62, 263, '2016-12-28 02:59:54', 65, 0, 1, 0, 0, 2, 1, 1, '', '', 'Technical specification of the laptop', 1, '2016-12-28 02:59:54'),
	(63, 263, '2016-12-28 03:01:48', 66, 0, 1, 0, 0, 4, 1, 1, '', '', 'Price bid details', 1, '2016-12-28 03:01:48');
/*!40000 ALTER TABLE `tbl_tendertable` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_tenderworkflow
DROP TABLE IF EXISTS `tbl_tenderworkflow`;
CREATE TABLE IF NOT EXISTS `tbl_tenderworkflow` (
  `workflowId` int(11) NOT NULL AUTO_INCREMENT,
  `action` int(11) DEFAULT NULL,
  `remarks` varchar(5000) DEFAULT NULL,
  `officerId` bigint(11) DEFAULT NULL,
  `tenderId` int(11) DEFAULT NULL,
  `parentWorkflowId` int(11) DEFAULT NULL,
  `cstatus` int(11) DEFAULT NULL,
  `createdById` int(11) DEFAULT NULL,
  `createdbyName` varchar(50) DEFAULT NULL,
  `modifiedById` int(11) DEFAULT NULL,
  `modifiedByName` varchar(50) DEFAULT NULL,
  `createdDate` datetime DEFAULT NULL,
  `ModifiedDate` datetime DEFAULT NULL,
  `corrigendumId` int(11) DEFAULT '0',
  PRIMARY KEY (`workflowId`),
  KEY `FK_tbl_tederworkflow` (`tenderId`),
  KEY `FK_tbl_tederworkflow_officer` (`officerId`),
  CONSTRAINT `FK_tbl_tederworkflow` FOREIGN KEY (`tenderId`) REFERENCES `tbl_tender` (`tenderId`),
  CONSTRAINT `FK_tbl_tederworkflow_officer` FOREIGN KEY (`officerId`) REFERENCES `tbl_officer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_tenderworkflow: ~25 rows (approximately)
/*!40000 ALTER TABLE `tbl_tenderworkflow` DISABLE KEYS */;
INSERT INTO `tbl_tenderworkflow` (`workflowId`, `action`, `remarks`, `officerId`, `tenderId`, `parentWorkflowId`, `cstatus`, `createdById`, `createdbyName`, `modifiedById`, `modifiedByName`, `createdDate`, `ModifiedDate`, `corrigendumId`) VALUES
	(1, 1, '<p>test</p>', 264, 17, 0, 0, 263, NULL, 0, NULL, '2016-12-13 17:54:57', NULL, 0),
	(2, 1, '<p>test</p>', 4, 18, 0, 1, 263, NULL, 0, NULL, '2016-12-13 18:47:26', NULL, 0),
	(3, 1, '<p>test</p>', 1, 18, 0, 1, 4, NULL, 0, NULL, '2016-12-13 18:48:53', NULL, 0),
	(4, 1, '<p>test</p>', 264, 18, 0, 0, 1, NULL, 0, NULL, '2016-12-13 18:49:37', NULL, 0),
	(5, 1, '<p>test</p>', 264, 19, 0, 0, 263, NULL, 0, NULL, '2016-12-13 18:52:42', NULL, 0),
	(6, 1, '<p>gfh</p>', 4, 20, 0, 1, 263, NULL, 0, NULL, '2016-12-13 18:53:44', NULL, 0),
	(7, 1, '<p>gfg</p>', 1, 20, 0, 1, 4, NULL, 0, NULL, '2016-12-13 18:54:31', NULL, 0),
	(8, 1, '<p>fgh</p>', 2, 20, 0, 1, 1, NULL, 0, NULL, '2016-12-13 18:55:53', NULL, 0),
	(9, 1, '<p>jghjg</p>', 264, 20, 0, 0, 2, NULL, 0, NULL, '2016-12-13 18:57:20', NULL, 0),
	(10, 1, '<p>hfh</p>', 4, 21, 0, 2, 263, NULL, 0, NULL, '2016-12-13 18:58:59', NULL, 0),
	(11, 1, '<p>test</p>', 856, 34, 0, 0, 264, NULL, 0, NULL, '2016-12-21 18:22:54', NULL, 0),
	(12, 1, '<p>test</p>', 856, 35, 0, 0, 264, NULL, 0, NULL, '2016-12-21 19:34:46', NULL, 0),
	(13, 1, '<p>testes</p>', 1, 39, 0, 0, 4, NULL, 0, NULL, '2016-12-22 05:47:41', NULL, 0),
	(14, 1, '<p>test</p>', 2, 42, 0, 2, 4, NULL, 0, NULL, '2016-12-22 09:53:37', NULL, 0),
	(15, 3, '<p>test reject</p>', 4, 42, 0, 2, 2, NULL, 0, NULL, '2016-12-22 10:02:40', NULL, 0),
	(16, 1, '<p>test 11</p>', 264, 42, 0, 2, 4, NULL, 0, NULL, '2016-12-22 10:05:07', NULL, 0),
	(17, 4, '<p>test return</p>', 4, 42, 0, 2, 264, NULL, 0, NULL, '2016-12-22 10:05:39', NULL, 0),
	(18, 1, '<p>testest</p>', 264, 42, 0, 2, 4, NULL, 0, NULL, '2016-12-22 10:06:08', NULL, 0),
	(19, 2, '<p>dggggggggggggggggggg</p>', 4, 42, 0, 2, 264, NULL, 0, NULL, '2016-12-22 10:06:39', NULL, 0),
	(20, 1, '<p>Test Worflow one&nbsp;</p>', 2, 44, 0, 2, 4, NULL, 0, NULL, '2016-12-22 12:07:56', NULL, 0),
	(21, 3, '<p>Reject</p>', 4, 44, 0, 2, 2, NULL, 0, NULL, '2016-12-22 12:08:56', NULL, 0),
	(22, 1, '<p>another officeer forward</p>', 264, 44, 0, 2, 4, NULL, 0, NULL, '2016-12-22 12:09:49', NULL, 0),
	(23, 4, '<p>return workflow&#8195;</p>', 4, 44, 0, 2, 264, NULL, 0, NULL, '2016-12-22 12:10:53', NULL, 0),
	(24, 1, '<p>again forward</p>', 264, 44, 0, 2, 4, NULL, 0, NULL, '2016-12-22 12:12:54', NULL, 0),
	(25, 2, '<p>test</p>', 4, 44, 0, 2, 264, NULL, 0, NULL, '2016-12-22 12:13:35', NULL, 0),
	(26, 1, '<p>test</p>', 264, 54, 0, 2, 933, NULL, 0, NULL, '2016-12-26 22:41:53', NULL, 0),
	(27, 2, '<p>test</p>', 933, 54, 0, 2, 264, NULL, 0, NULL, '2016-12-26 22:43:27', NULL, 0),
	(28, 1, '<p>Please Approve</p>', 933, 58, 0, 2, 264, NULL, 0, NULL, '2016-12-28 03:09:14', NULL, 0),
	(29, 2, '<p>Approved</p>', 264, 58, 0, 2, 933, NULL, 0, NULL, '2016-12-28 03:10:09', NULL, 0);
/*!40000 ALTER TABLE `tbl_tenderworkflow` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_userlogin
DROP TABLE IF EXISTS `tbl_userlogin`;
CREATE TABLE IF NOT EXISTS `tbl_userlogin` (
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
  `userType` int(10) NOT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=943 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_userlogin: ~23 rows (approximately)
/*!40000 ALTER TABLE `tbl_userlogin` DISABLE KEYS */;
INSERT INTO `tbl_userlogin` (`userId`, `createdby`, `datecreated`, `datemodified`, `failedattempt`, `loginid`, `modifiedby`, `password`, `salt`, `cstatus`, `designationId`, `userType`) VALUES
	(1, 1, '2016-11-08 17:42:00', '2016-11-08 17:43:20', 0, 'officer1@mail.com', 1, 'auction@123', NULL, 1, 45, 1),
	(2, 1, '2016-11-08 17:43:41', NULL, 0, 'officer2@mail.com', 0, 'auction@123', '1111', 1, 0, 1),
	(3, 1, '2016-11-08 17:44:15', NULL, 0, 'officer3@mail.com', 0, 'auction@123', '1111', 1, 0, 1),
	(4, 1, '2016-11-08 17:45:01', NULL, 0, 'officer4@mail.com', 1, 'auction@123', NULL, 1, 486, 1),
	(63, 1, NULL, NULL, 0, 'officer5@gmail.com', 0, 'auction@123', NULL, 1, 45, 1),
	(65, 1, NULL, NULL, NULL, 'officer6@mail.com', 1, 'auction@123', NULL, 1, 60, 1),
	(157, 1, NULL, NULL, NULL, 'bidder@mail.com', NULL, 'auction@123', NULL, 0, 0, 2),
	(163, 1, NULL, NULL, 0, 'officer9@mail.com', NULL, 'auction@123', NULL, 1, 162, 1),
	(235, 1, NULL, NULL, 0, 'officer7@mail.com', 1, 'auction@123', NULL, 1, 234, 1),
	(254, 1, NULL, NULL, 1, 'bidder4@mail.com', 1, 'auction@123', NULL, 0, 0, 2),
	(263, 1, NULL, NULL, 0, 'officer11@mail.com', 1, 'auction@123', NULL, 1, 262, 1),
	(280, 1, NULL, NULL, NULL, 'bidder7@mail.com', 1, 'auction@123', NULL, 0, 0, 2),
	(291, 1, NULL, NULL, NULL, 'bidder3@mail.com', NULL, 'auction@123', NULL, 0, 0, 2),
	(294, 1, NULL, NULL, NULL, 'b1@mail.com', 1, 'auction@123', NULL, 0, 0, 2),
	(299, 1, NULL, NULL, NULL, 'b2@mail.com', NULL, 'auction@123', NULL, 0, 0, 2),
	(304, 1, NULL, NULL, 0, 'odemo@mail.com', NULL, 'auction@123', NULL, 1, 303, 1),
	(378, 1, NULL, NULL, 0, 'sharmila@bgi.com', NULL, 'sharmi@123', NULL, 1, 284, 1),
	(381, 1, NULL, NULL, 0, 'user1@mail.in', NULL, '123test@45', NULL, 1, 45, 1),
	(488, 1, NULL, NULL, 0, 'officer100@mail.com', 1, 'auction@123', NULL, 1, 486, 1),
	(500, 1, NULL, NULL, 0, 'a@b.com', NULL, 'auction@123', NULL, 1, 499, 1),
	(838, 1, NULL, NULL, 0, 'b11@mail.com', NULL, 'auction@123', NULL, 1, 284, 1),
	(844, 1, NULL, NULL, NULL, 'b12@mail.com', NULL, 'auction@123', NULL, 0, 0, 2),
	(855, 1, NULL, NULL, 0, 'officer15@mail.com', NULL, 'auction@123', NULL, 1, 487, 1),
	(879, 1, NULL, NULL, 0, 'usertest@mail.com', NULL, 'auction@123', NULL, 1, 878, 1),
	(888, 1, NULL, NULL, NULL, 'bidder44@mail.com', NULL, 'auction@123', NULL, 0, 0, 2),
	(893, 1, NULL, NULL, NULL, 'blipi@mail.com', 1, 'auction@123', NULL, 0, 0, 2),
	(902, 1, NULL, NULL, 0, 'officer89@mail.com', NULL, 'auction@123', NULL, 1, 45, 1),
	(908, 1, NULL, NULL, NULL, 'bidder45@mail.com', 1, 'auction@123', NULL, 0, 0, 2),
	(920, 1, NULL, NULL, 0, 'biddertest@mail.com', NULL, 'auction@123', NULL, 0, 0, 2),
	(932, 1, NULL, NULL, 0, 'officer33@mail.com', 1, 'auction@123', NULL, 1, 931, 1),
	(942, 1, NULL, NULL, 0, 'testbidder@gmail.com', NULL, 'aspirine@123', NULL, 0, 0, 2);
/*!40000 ALTER TABLE `tbl_userlogin` ENABLE KEYS */;

-- Dumping structure for table eauctiontender.tbl_userrolemapping
DROP TABLE IF EXISTS `tbl_userrolemapping`;
CREATE TABLE IF NOT EXISTS `tbl_userrolemapping` (
  `userrolemapId` int(10) NOT NULL AUTO_INCREMENT,
  `roleId` int(10) NOT NULL,
  `userId` bigint(10) NOT NULL,
  PRIMARY KEY (`userrolemapId`),
  KEY `user` (`userId`),
  KEY `role` (`roleId`),
  CONSTRAINT `role` FOREIGN KEY (`roleId`) REFERENCES `tbl_roles` (`roleId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user` FOREIGN KEY (`userId`) REFERENCES `tbl_userlogin` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=946 DEFAULT CHARSET=latin1;

-- Dumping data for table eauctiontender.tbl_userrolemapping: ~45 rows (approximately)
/*!40000 ALTER TABLE `tbl_userrolemapping` DISABLE KEYS */;
INSERT INTO `tbl_userrolemapping` (`userrolemapId`, `roleId`, `userId`) VALUES
	(93, 1, 65),
	(94, 4, 65),
	(165, 1, 163),
	(166, 2, 163),
	(245, 1, 235),
	(246, 2, 235),
	(247, 3, 235),
	(248, 4, 235),
	(269, 1, 263),
	(270, 2, 263),
	(271, 3, 263),
	(272, 4, 263),
	(306, 1, 304),
	(307, 2, 304),
	(308, 3, 304),
	(309, 4, 304),
	(380, 1, 378),
	(383, 1, 381),
	(494, 1, 488),
	(495, 2, 488),
	(496, 3, 488),
	(497, 4, 488),
	(502, 1, 500),
	(503, 2, 500),
	(504, 3, 500),
	(505, 4, 500),
	(840, 1, 838),
	(841, 2, 838),
	(842, 3, 838),
	(843, 4, 838),
	(844, 5, 254),
	(857, 1, 855),
	(858, 2, 855),
	(859, 3, 855),
	(860, 4, 855),
	(881, 1, 879),
	(882, 2, 879),
	(883, 1, 4),
	(884, 2, 4),
	(885, 1, 2),
	(904, 1, 902),
	(905, 2, 902),
	(906, 3, 902),
	(907, 4, 902),
	(923, 5, 920),
	(938, 1, 932),
	(939, 2, 932),
	(940, 3, 932),
	(941, 4, 932),
	(945, 5, 942);
/*!40000 ALTER TABLE `tbl_userrolemapping` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
