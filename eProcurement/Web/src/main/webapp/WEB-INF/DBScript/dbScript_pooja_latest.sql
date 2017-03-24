
insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) 
values('Envelope Validation Form Library','tender','/eBid/Bid/checkForEnv','Envelope Validation Form Library');
insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkid from tbl_link where linkName = 'Envelope Validation Form Library'),'1');


insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) 
values('Delete Price Summary Column','tender','/eBid/Bid/deletePriceSummaryColumn','Delete Price Summary Column');
insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkid from tbl_link where linkName = 'Delete Price Summary Column'),'1');


insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) 
values('Edit Price Summary Column','tender','/eBid/Bid/EditPriceSummaryColumn','Edit Price Summary Column');
insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkid from tbl_link where linkName = 'Edit Price Summary Column'),'1');



insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) 
values('Update Price Summary Column','tender','/eBid/Bid/UpdatePriceSummaryColumn','Update Price Summary Column');
insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkid from tbl_link where linkName = 'Update Price Summary Column'),'1');

insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) 
values('delete table','tender','/eBid/Bid/deleteTableFromBiddingForm','delete table');
insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkid from tbl_link where linkName = 'delete table'),'1');