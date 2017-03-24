alter table `tbl_tender` add  EMDFees int  NULL DEFAULT 0 , add  `allowsAutoExtension` int NULL default 0;

alter table `tbl_tender` add  AuctionEndDate datetime  NULL DEFAULT CURRENT_TIMESTAMP , add  `auctionMethod` int NULL default 0,
add auctionReservePrice int null default 0,add AuctionStartDate datetime null default CURRENT_TIMESTAMP,add autoExtensionMode int null default 0,
add bidSubmissionfor int null default 0,add biddingAccess int null default 0,add contractTypeId int null default 0, add displayIPAddress int null default 0,
add estimatedValue int null default 0,add extendTimeBy int null default 0,add extendTimeWhen int null default 0,add incrementDecrementValues int null default 0,
add isAuction int null default 0,add NoOfExtension int null default 0,add participationFees int null default 0,add productLocation int null,
add startPrice int null default 0;
alter table tbl_tender add EMDRequired int null default 0;

alter table tbl_tender modify productLocation varchar(200);

insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) 
values('Create Auction','auction','/eBid/Bid/createAuction','Create Auction');
insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkid from tbl_link where linkName = 'Create Auction'),'1');
insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) 
values('Save Auction Detail','auction','/eBid/Bid/addAuction','Save Auction Detail');
insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkid from tbl_link where linkName = 'Save Auction Detail'),'1');
insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) 
values('View Auction Detail','auction','/eBid/Bid/viewAuction','View Auction Detail');
insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkid from tbl_link where linkName = 'View Auction Detail'),'1');
select * from tbl_link;
insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) 
values('Auction Listing','auction','/eBid/Bid/auctionListing','Auction Listing');
insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkid from tbl_link where linkName = 'Auction Listing'),'1');

insert into tbl_commonlisting(actionItem,columnName,discription,fromClause,isHQL,status,srnoCol)
values('edit,view,dashboard','tenderId:Tender Id.:1~(select concat(case when grandparentdeptId <> 0 then(select d1.deptName from tbl_department d1 where d1.deptId=tbldept.grandparentdeptId) else '' end ,case when parentdeptId <> 0 then (select concat('/',d2.deptName) from tbl_department d2 where d2.deptId=tbldept.parentdeptId) else ''  end ,(select concat('/',d3.deptName) from tbl_department d3 where d3.deptId=tbldept.deptId)) from tbl_department tbldept where tbldept.deptId = tbl_tender.departmentId) as deptName:Department Name:1~tenderNo:Tender ref. no.:1~tenderBrief:Tender Brief:1~keywordText:Keywords:1~convert_tz(submissionStartDate$utcTimeZone$userTimeZone) as submissionStartDate:Start Date:1~convert_tz(submissionEndDate$utcTimeZone$userTimeZone) as submissionEndDate:Due Date:1~convert_tz(openingDate$utcTimeZone$userTimeZone) as openingDate:Opening Date:1',
'Pending Tender','from tbl_tender where 1=1 and cstatus = 0 and isAuction=1','(Binary/Index)',1,1);

update tbl_commonlisting set columnName='tenderId:Tender Id.:1~(select concat(case when grandparentdeptId <> 0 then(select d1.deptName from tbl_department d1 where d1.deptId=tbldept.grandparentdeptId) else '' end ,case when parentdeptId <> 0 then (select concat('/',d2.deptName) from tbl_department d2 where d2.deptId=tbldept.parentdeptId) else ''  end ,(select concat('/',d3.deptName) from tbl_department d3 where d3.deptId=tbldept.deptId)) from tbl_department tbldept where tbldept.deptId = tbl_tender.departmentId) as deptName:Department Name:1~tenderNo:Tender ref. no.:1~tenderBrief:Tender Brief:1~keywordText:Keywords:1~convert_tz(submissionStartDate$utcTimeZone$userTimeZone) as submissionStartDate:Start Date:1~convert_tz(submissionEndDate$utcTimeZone$userTimeZone) as submissionEndDate:Due Date:1~convert_tz(openingDate$utcTimeZone$userTimeZone) as openingDate:Opening Date:1'
where listingId=29
