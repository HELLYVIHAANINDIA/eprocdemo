
/*[1:00:22 AM][  78 ms]*/ insert into `tbl_link`(`linkId`,`linkName`,`module`,`link`,`description`)
values(104,'Publish Tender','tender','/etender/buyer/publishtender','publish tender');

/*[1:01:13 AM][  78 ms]*/ insert into `tbl_rolelinkmapping`(`rolelinkmapId`,`linkId`,`roleId`)values('104','104','1');

update `tbl_commonlisting` set `fromClause`='from tbl_tender where 1=1 from tbl_tender where 1=1 and cstatus = 0' where `listingId`='1';

delete from tbl_commonlisting  where listingId = 1
insert  into `tbl_commonlisting`(`listingId`,`actionItem`,`columnName`,`commonAction`,`discription`,`fromClause`,`isHQL`,`status`) 
values (1,'Edit,View,Dashboard','tenderNo:Tender No.:1,tenderDetail:Tender Detail:1,tenderId:tenderId:0','','Pending Tender','from tbl_tender where 1=1 and cstatus = 0','0',1),
(4,'View,Dashboard','tenderNo:Tender No.:1,tenderDetail:Tender Detail:1,tenderId:tenderId:0',NULL,'Future Tender','from tbl_tender where cstatus = 1 and submissionStartDate>now()','0',1),
(5,'Edit,View,Dashboard','tenderNo:Tender No.:1,tenderDetail:Tender Detail:1,tenderId:tenderId:0',NULL,'Archive Tender','from tbl_tender where cstatus = 1 and submissionEndDate<now()','0',1),
(6,'View,Dashboard','tenderNo:Tender No.:1,tenderDetail:Tender Detail:1,tenderId:tenderId:0',NULL,'Live Tender','from tbl_tender where cstatus = 1 and submissionStartDate<now() and submissionEndDate>now()','0',1);
