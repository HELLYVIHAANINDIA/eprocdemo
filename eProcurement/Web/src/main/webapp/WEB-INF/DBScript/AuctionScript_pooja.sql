#31

insert into tbl_commonlisting(actionItem,columnName,discription,fromClause,isHQL,status,srnoCol)
values ('View,Dashboard','tenderId:Auction Id.:1~(select concat(case when grandparentdeptId <> 0 then(select d1.deptName from tbl_department d1 where d1.deptId=tbldept.grandparentdeptId) else \'\' end ,case when parentdeptId <> 0 then (select concat(\'/\',d2.deptName) from tbl_department d2 where d2.deptId=tbldept.parentdeptId) else \'\'  end ,(select concat(\'/\',d3.deptName) from tbl_department d3 where d3.deptId=tbldept.deptId)) from tbl_department tbldept where tbldept.deptId = tbl_tender.departmentId) as deptName:Department Name:1~tenderNo:Auction ref. no.:1~tenderBrief:Auction Brief:1~keywordText:Keywords:1~convert_tz(submissionStartDate$utcTimeZone$userTimeZone) as submissionStartDate:Start Date:1~convert_tz(submissionEndDate$utcTimeZone$userTimeZone) as submissionEndDate:Due Date:1~convert_tz(openingDate$utcTimeZone$userTimeZone) as openingDate:Opening Date:1~corrigendumCount:Corrigendum:1
','Bidder Live Auction',
'from tbl_tender WHERE cstatus = 1  AND submissionStartDate<UTC_TIMESTAMP and submissionEndDate>UTC_TIMESTAMP and isAuction=1',
'(Binray/Index)',
1,
1);
#-------------------------------------------------------
#32

insert into tbl_commonlisting(actionItem,columnName,discription,fromClause,isHQL,status,srnoCol)
values ('View,Dashboard','tenderId:Auction Id.:1~(select concat(case when grandparentdeptId <> 0 then(select d1.deptName from tbl_department d1 where d1.deptId=tbldept.grandparentdeptId) else \'\' end ,case when parentdeptId <> 0 then (select concat(\'/\',d2.deptName) from tbl_department d2 where d2.deptId=tbldept.parentdeptId) else \'\'  end ,(select concat(\'/\',d3.deptName) from tbl_department d3 where d3.deptId=tbldept.deptId)) from tbl_department tbldept where tbldept.deptId = tbl_tender.departmentId) as deptName:Department Name:1~tenderNo:Auction ref. no.:1~tenderBrief:Brief scope of work.:1~tenderDetail:Auction Detail.:1','Future Auction',
'from tbl_tender where cstatus = 1 and AuctionStartDate>now() and isAuction=1',
'\0',
1,
1);
#-----------------------------------------------------------
#33
insert into tbl_commonlisting(actionItem,columnName,discription,fromClause,isHQL,status,srnoCol)
values ('View,Dashboard','tenderId:Auction Id.:1~(select concat(case when grandparentdeptId <> 0 then(select d1.deptName from tbl_department d1 where d1.deptId=tbldept.grandparentdeptId) else \'\' end ,case when parentdeptId <> 0 then (select concat(\'/\',d2.deptName) from tbl_department d2 where d2.deptId=tbldept.parentdeptId) else \'\'  end ,(select concat(\'/\',d3.deptName) from tbl_department d3 where d3.deptId=tbldept.deptId)) from tbl_department tbldept where tbldept.deptId = tbl_tender.departmentId) as deptName:Department Name:1~tenderNo:Auction ref. no.:1~tenderBrief:Brief scope of work.:1~tenderDetail:Auction Detail.:1','Archive Auction',
'from tbl_tender where cstatus = 1 and AuctionEndDate<now() and isAuction=1',
'\0',
1,
1);
#--------------------------------------------------------------
#34
insert into tbl_commonlisting(actionItem,columnName,discription,fromClause,isHQL,status,srnoCol)
values ('View,Dashboard','tenderId:Auction Id.:1~(select concat(case when grandparentdeptId <> 0 then(select d1.deptName from tbl_department d1 where d1.deptId=tbldept.grandparentdeptId) else \'\' end ,case when parentdeptId <> 0 then (select concat(\'/\',d2.deptName) from tbl_department d2 where d2.deptId=tbldept.parentdeptId) else \'\'  end ,(select concat(\'/\',d3.deptName) from tbl_department d3 where d3.deptId=tbldept.deptId)) from tbl_department tbldept where tbldept.deptId = tbl_tender.departmentId) as deptName:Department Name:1~tenderNo:Auction ref. no.:1~tenderBrief:Brief scope of work.:1~tenderDetail:Auction Detail.:1','Cancel Auction',
'from tbl_tender where cstatus = 2 and isAuction=1',
'\0',
1,
1);
#------------------------------------------------------------------
#35
insert into tbl_commonlisting(actionItem,columnName,discription,fromClause,isHQL,status,srnoCol)
values ('View,Dashboard','tenderId:Auction Id.:1~(select concat(case when grandparentdeptId <> 0 then(select d1.deptName from tbl_department d1 where d1.deptId=tbldept.grandparentdeptId) else \'\' end ,case when parentdeptId <> 0 then (select concat(\'/\',d2.deptName) from tbl_department d2 where d2.deptId=tbldept.parentdeptId) else \'\'  end ,(select concat(\'/\',d3.deptName) from tbl_department d3 where d3.deptId=tbldept.deptId)) from tbl_department tbldept where tbldept.deptId = tbl_tender.departmentId) as deptName:Department Name:1~tenderNo:Auction ref. no.:1~tenderBrief:Brief scope of work.:1~tenderDetail:Auction Detail.:1','All Auction',
'from tbl_tender where cstatus <> 4 and isAuction=1',
'\0',
1,
1);

#---------------------------------------------------------
#36


insert into tbl_commonlisting(actionItem,columnName,discription,fromClause,isHQL,status,srnoCol)
values ('View','tenderId:Auction Id.:1~(select concat(case when grandparentdeptId <> 0 then(select d1.deptName from tbl_department d1 where d1.deptId=tbldept.grandparentdeptId) else \'\' end ,case when parentdeptId <> 0 then (select concat(\'/\',d2.deptName) from tbl_department d2 where d2.deptId=tbldept.parentdeptId) else \'\'  end ,(select concat(\'/\',d3.deptName) from tbl_department d3 where d3.deptId=tbldept.deptId)) from tbl_department tbldept where tbldept.deptId = tbl_tender.departmentId) as deptName:Department Name:1~tenderNo:Auction ref. no.:1~tenderBrief:Auction Brief:1~keywordText:Keywords:1~convert_tz(submissionStartDate$utcTimeZone$userTimeZone) as submissionStartDate:Start Date:1~convert_tz(submissionEndDate$utcTimeZone$userTimeZone) as submissionEndDate:Due Date:1~convert_tz(openingDate$utcTimeZone$userTimeZone) as openingDate:Opening Date:1~corrigendumCount:Corrigendum:1','Bidder Archive Auction',
'from tbl_tender where cstatus = 1 and submissionEndDate<UTC_TIMESTAMP and isAuction=1','\0',1,1);


#---------------------------------------------------------

#37

insert into tbl_commonlisting(actionItem,columnName,discription,fromClause,isHQL,status,srnoCol)
values ('View','tenderId:Auction Id.:1~(select concat(case when grandparentdeptId <> 0 then(select d1.deptName from tbl_department d1 where d1.deptId=tbldept.grandparentdeptId) else \'\' end ,case when parentdeptId <> 0 then (select concat(\'/\',d2.deptName) from tbl_department d2 where d2.deptId=tbldept.parentdeptId) else \'\'  end ,(select concat(\'/\',d3.deptName) from tbl_department d3 where d3.deptId=tbldept.deptId)) from tbl_department tbldept where tbldept.deptId = tbl_tender.departmentId) as deptName:Department Name:1~tenderNo:Auction ref. no.:1~tenderBrief:Auction Brief:1~keywordText:Keywords:1~convert_tz(submissionStartDate$utcTimeZone$userTimeZone) as submissionStartDate:Start Date:1~convert_tz(submissionEndDate$utcTimeZone$userTimeZone) as submissionEndDate:Due Date:1~convert_tz(openingDate$utcTimeZone$userTimeZone) as openingDate:Opening Date:1~corrigendumCount:Corrigendum:1','Bidder Future Auction',
'from tbl_tender where cstatus = 1 and submissionStartDate>UTC_TIMESTAMP and isAuction=1','\0',1,1);


#-----------------------------------------------------------------------------
 update tbl_commonlisting set columnName='tenderId:Auction Id.:1~tenderNo:Auction ref. no.:1~(select case when auctionMethod=1 then \'Forward\' else \'Reverse\' end from tbl_tender t where t.tenderId=tbl_tender.tenderId) as auctionMethod:Auction type.:1~(select concat(case when grandparentdeptId <> 0 then(select d1.deptName from tbl_department d1 where d1.deptId=tbldept.grandparentdeptId) else \'\' end ,case when parentdeptId <> 0 then (select concat(\'/\',d2.deptName) from tbl_department d2 where d2.deptId=tbldept.parentdeptId) else \'\'  end ,(select concat(\'/\',d3.deptName) from tbl_department d3 where d3.deptId=tbldept.deptId)) from tbl_department tbldept where tbldept.deptId = tbl_tender.departmentId) as deptName:Department Name:1~tenderBrief:Auction brief.:1~AuctionStartDate:Start Date and Time.:1~AuctionEndDate:End Date and Time:1~(select case when biddingAccess=1 then \'Open\' else \'Limited\' end from tbl_tender t where t.tenderId=tbl_tender.tenderId) as biddingAccess:Bidding Access.:1'
where listingId in (29,30,32,33,34,35);

update tbl_commonlisting set actionItem="edit,view,viewReport,dashboard" where listingId=29

update tbl_commonlisting set actionItem="view,viewReport,dashboard" where listingId in (30,32,33,34,35);

insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) 
values('View Auction Result','auction','/eBid/Bid/viewAuctionResult','View Auction Result');
insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkid from tbl_link where linkName = 'View Auction Result'),'1');


DROP TABLE IF EXISTS `tbl_auctionstopresume`;
CREATE TABLE `tbl_auctionstopresume` (
  `auctionstopresumeId` int(11) NOT NULL AUTO_INCREMENT,
  `remark` varchar(2000),
  `status` int(11),
  `createdon` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `createdby` int(11),
  `auctionstartdate` datetime DEFAULT NULL,
  `auctionenddate` datetime DEFAULT NULL,
  `tenderId` int(11) DEFAULT NULL,
    PRIMARY KEY (`auctionstopresumeId`),
  KEY `FK_tbl_tender` (`tenderId`),
  CONSTRAINT `FK_tbl_tender` FOREIGN KEY (`tenderId`) REFERENCES `tbl_tender` (`tenderId`)
  
)


alter table tbl_tender add isAuctionStop int(11) default 0;


insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) 
values('Stop auction','auction','/eBid/Bid/stopResumeAuction','Stop auction');
insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkid from tbl_link where linkName = 'Stop auction'),'1');
select * from tbl_rolelinkmapping;
