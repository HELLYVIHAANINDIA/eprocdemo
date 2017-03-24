update tbl_commonlisting set columnName='tenderId:Event Id.:1,tenderNo:Tender No.:1,tenderBrief:Tender Brief:1,keywordText:Keyword:1,submissionStartDate:Start Date:1,submissionEndDate:End Date:1,openingDate:Opening Date:1,corrigendumCount:Corrigendum:1'
where listingId in (10,13,14);

drop table if exists tbl_rebatedetail;
CREATE TABLE `tbl_rebatedetail` (
  `cellValue` longtext NOT NULL,
  `createdBy` int(11) NOT NULL,
  `createdOn` datetime NOT NULL,
  `rebateDetailId` int(11) NOT NULL AUTO_INCREMENT,
  `companyid` int(11) NOT NULL,
  `tenderid` int(11) NOT NULL,
  `bidtableid` int(11) NOT NULL,
  `columnId` int(11) NOT NULL,
  PRIMARY KEY (`rebateDetailId`),
  KEY `FK_tbl_rebatedetail_bidmatrix` (`bidtableid`),
  KEY `FK_tbl_rebatedetail_cell` (`columnId`),
  KEY `FK_tbl_rebatedetail_company` (`companyid`),
  KEY `FK_tbl_rebatedetail_tender` (`tenderid`),
  CONSTRAINT `FK_tbl_rebatedetail` FOREIGN KEY (`bidtableid`) REFERENCES `tbl_tenderbidmatrix` (`bidTableId`),
  CONSTRAINT `FK_tbl_rebatedetail_column` FOREIGN KEY (`columnId`) REFERENCES `tbl_tendercolumn` (`columnId`),
  CONSTRAINT `FK_tbl_rebatedetail_company` FOREIGN KEY (`companyid`) REFERENCES `tbl_company` (`companyid`),
  CONSTRAINT `FK_tbl_rebatedetail_tender` FOREIGN KEY (`tenderid`) REFERENCES `tbl_tender` (`tenderId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;



alter table `eauctiontender`.`tbl_TenderCellGrandTotal` modify `GTValue` varchar(20) NULL;


alter table `eauctiontender`.`tbl_rebatedetail` CHANGE `createdOn` createdOn datetime default CURRENT_TIMESTAMP;

alter table `eauctiontender`.`tbl_TenderCellGrandTotal` CHANGE `Id` cellGrandTotalId int(11) not null auto_increment ;