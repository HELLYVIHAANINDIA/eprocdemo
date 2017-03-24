alter table tbl_tender add isEvaluationDone int  Not Null DEFAULT 0;


insert into `tbl_commonlisting` (listingId, `actionItem`, `columnName`, `commonAction`, `discription`, `fromClause`, `isHQL`, `status`, `srnoCol`) 
values(26,'View,Dashboard','tenderId:Event Id.:1,tenderNo:Tender No.:1,tenderBrief:Tender Brief:1,keywordText:Keyword:1,submissionStartDate:Start Date:1,submissionEndDate:End Date:1,openingDate:Opening Date:1'
,NULL,'Tender Evalution','from tbl_tender where 1=1 and cstatus = 1 and isEvaluationDone = 0',NULL,'1','1');

insert into tbl_link (linkName,module,link,description) 
values('tender evalution pending list','tender','/etender/buyer/getpendingevaluation','tender evalution pending list');
insert into tbl_rolelinkmapping (linkId,roleId) values((select linkId from tbl_link where link='/etender/buyer/getpendingevaluation'),1);


update tbl_commonlisting set actionItem = 'View' where listingId In(13,14);