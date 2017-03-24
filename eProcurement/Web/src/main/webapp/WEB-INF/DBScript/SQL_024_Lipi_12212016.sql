insert  into `tbl_link`(`linkName`,`module`,`link`,`description`) values 
('Result Sharing','tender','etender/buyer/getresultsharing','Result Sharing');

insert into tbl_rolelinkmapping (linkId,roleId) values ((select linkId from tbl_link where link='etender/buyer/getresultsharing'),1);


CREATE TABLE `tbl_biddetail` (
  `bidDetailId` int(11) NOT NULL AUTO_INCREMENT,
  `cellId` int(11) NOT NULL,
  `cellValue` longtext NOT NULL,
  `companyId` int(11) NOT NULL,
  `formId` int(11) NOT NULL,
  PRIMARY KEY (`bidDetailId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `tbl_biddetail` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;


alter table tbl_tenderbid CHANGE createdon createdon DATEtime default CURRENT_TIMESTAMP;

alter table tbl_tenderbidopensign CHANGE bidOpenSignId bidOpenSignId int(11) default AUTO_INCREMENT;

insert  into `tbl_commonlisting`(`actionItem`,`columnName`,`commonAction`,`discription`,`fromClause`,`isHQL`,`status`,`srnoCol`) values 
('View,Dashboard','tenderId:Event Id.:1,tenderNo:Tender No.:1,tenderDetail:Tender Detail:1',NULL,'Bidder Archive Tender','from tbl_tender where cstatus = 1 and submissionEndDate<now()','\0',1,1),
('View,Dashboard','tenderId:Event Id.:1,tenderNo:Tender No.:1,tenderDetail:Tender Detail:1',NULL,'Bidder Future Tender','from tbl_tender where cstatus = 1 and submissionStartDate>now()','\0',1,1)
;

drop table if exists tbl_rebatedetail;

drop table if exists tbl_tenderbiddetail;

drop table if exists tbl_tenderbidopensign;

alter table `eauctiontender`.`tbl_tenderbidmatrix` change `bidTableId` `bidTableId` int(11) NOT NULL AUTO_INCREMENT;


alter table Tbl_ItemSelection change userId bidderId int(11) Not Null;


CREATE TABLE `tbl_rebatedetail` (
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

/*Data for the table `tbl_rebatedetail` */

/*Table structure for table `tbl_tenderbiddetail` */

CREATE TABLE `tbl_tenderbiddetail` (
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `tbl_tenderbidopensign` (
  `bidOpenSignId` int(11) NOT NULL AUTO_INCREMENT,
  `bidSignText` longtext,
  `createdBy` int(11) DEFAULT NULL,
  `createdOn` datetime DEFAULT NULL,
  `decryptedBid` longtext,
  `bidtableid` int(11) NOT NULL,
  PRIMARY KEY (`bidOpenSignId`),
  KEY `FK_tbl_tenderbidopensign` (`bidtableid`),
  CONSTRAINT `FK_tbl_tenderbidopensign` FOREIGN KEY (`bidtableid`) REFERENCES `tbl_tenderbidmatrix` (`bidTableId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

