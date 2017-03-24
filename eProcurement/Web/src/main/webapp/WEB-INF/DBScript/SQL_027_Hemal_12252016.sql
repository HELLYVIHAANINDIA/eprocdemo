

select * from tbl_link where link='/eBid/Bid/GetFormInfoForTest';
insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) 
values('Delete Form ','tender','/eBid/Bid/DeleteForm','Delete Form ');
insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkid from tbl_link where linkName = 'Delete Form '),'1');

insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) 
values('Test Bidding Form','tender','/eBid/Bid/GetFormInfoForTest','Test Bidding Form ');
insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkid from tbl_link where linkName = 'Test Bidding Form'),'1');