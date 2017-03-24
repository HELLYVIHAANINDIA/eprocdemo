insert into `tbl_commonlisting`(`listingId`,`actionItem`,`columnName`,`commonAction`,`discription`,`fromClause`,`isHQL`,`status`,`srnocol`)
values(17,'View,Dashboard','tenderId:Event Id.:1,tenderNo:Tender No.:1,tenderBrief:Tender Brief:1,keywordText:Keyword:1,submissionStartDate:Start Date:1,submissionEndDate:End Date:1,openingDate:Opening Date:1,corrigendumCount:Corrigendum:1',NULL,'Cancel Tender','from tbl_tender where cstatus = 2','0','1','1');

insert into `tbl_commonlisting`(`listingId`,`actionItem`,`columnName`,`commonAction`,`discription`,`fromClause`,`isHQL`,`status`,`srnocol`)values(18,'View,Dashboard','tenderId:Event Id.:1,tenderNo:Tender No.:1,tenderBrief:Tender Brief:1,keywordText:Keyword:1,submissionStartDate:Start Date:1,submissionEndDate:End Date:1,openingDate:Opening Date:1,corrigendumCount:Corrigendum:1',NULL,'All Tender','from tbl_tender where 1=1 ','0','1','1');

alter table `eauctiontender`.`tbl_tender` change `downloadDocument` `downloadDocument` int(11) default '2' NOT NULL;

update tbl_tender set downloadDocument = 2;


update tbl_commonlisting set columnname =
'tenderId:Event Id.:1,tenderNo:Tender No.:1,tenderBrief:Tender Brief:1,keywordText:Keyword:1,submissionStartDate:Start Date:1,submissionEndDate:End Date:1,openingDate:Opening Date:1,corrigendumCount:Corrigendum:1'
 where listingID in (4,5,6);
 
 update tbl_commonlisting set columnname =
'tenderId:Event Id.:1,tenderNo:Tender No.:1,tenderBrief:Tender Brief:1,keywordText:Keyword:1,submissionStartDate:Start Date:1,submissionEndDate:End Date:1,openingDate:Opening Date:1'
 where listingID in (1);