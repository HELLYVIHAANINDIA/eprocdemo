insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) 
values('Copy form','tender','/eBid/Bid/copyForm','Copy form');
insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkid from tbl_link where linkName = 'Copy form'),'1');
