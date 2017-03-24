
insert into `tbl_link` (`linkName`, `module`, `link`, `description`) values('save gtcolumn','tender','/etender/buyer/SaveGrandTotal','save gtcolumn');
INSERT INTO `tbl_rolelinkmapping`(`linkId`, `roleId`)VALUES((SELECT linkId FROM tbl_link WHERE link='/etender/buyer/SaveGrandTotal'),1);


insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) 
values('Delete Column From Bidding Form','tender','/eBid/Bid/deleteColumnFromBiddingForm','Delete Column From Bidding Form');
insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkid from tbl_link where linkName = 'Delete Column From Bidding Form'),'1');


insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) 
values('get Price Summary Column','tender','/eBid/Bid/getPriceSumaryColumn','get Price Summary Column');
insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkid from tbl_link where linkName = 'get Price Summary Column'),'1');


insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) 
values('Form Library','tender','/eProcurement/eBid/Bid/FormLibrary','Form Library');
insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkid from tbl_link where linkName = 'Form Library'),'1');


insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) 
values('get Form Library','tender','/eBid/Bid/getFormLibrary','get Form Library');
insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkid from tbl_link where linkName = 'get Form Library'),'1');

alter table tbl_tendercolumn add isGTColumn int DEFAULT 0

