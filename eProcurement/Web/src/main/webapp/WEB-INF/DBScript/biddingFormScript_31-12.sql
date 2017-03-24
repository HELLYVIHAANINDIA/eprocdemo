insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) 
values('Save Price Summary Column','tender','/eBid/Bid/savePriceSummaryColumn','Save Price Summary Column');
insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkid from tbl_link where linkName = 'Save Price Summary Column'),'1');

ALTER TABLE tbl_tendercolumn     ADD COLUMN `isPriceSummary` INT(11) DEFAULT 0  ;
update tbl_tendercolumn set isPriceSummary=0 ;

insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) 
values('Save Grand Total','tender','/eBid/Bid/SaveGrandTotal','Save Grand Total');
insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkid from tbl_link where linkName = 'Save Grand Total'),'1');
