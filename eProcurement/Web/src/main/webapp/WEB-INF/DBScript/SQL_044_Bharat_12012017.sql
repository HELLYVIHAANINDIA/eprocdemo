update `tbl_commonlisting` set `fromClause`='from tbl_tender where cstatus <> 4 ' where `listingId`='18';


insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) 
values('Delete Tender','Tender','/etender/buyer/deleteTender','Delete Tender');
insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkid from tbl_link where linkName = 'Delete Tender'),'1');
