insert into `tbl_commonlisting`()`actionItem`,`columnName`,`commonAction`,`discription`,`fromClause`,`isHQL`,`status`)values('Process','tenderId:Event No.:1,createdDate:created Date:1,(case when (corrigendumId <> 0) then \'Corrigendum\' else \'Notice & Document\' end) as workflowFor:Workflow for:1,workflowId:workflowId:0',NULL,'Pending workflow list','from tbl_tenderworkflow where cstatus =0','0','1');

insert into `tbl_link`(`linkName`,`module`,`link`,`description`)values('Workflow List','workflow','/etender/buyer/workflowlist','Workflow listing in left panel');
insert into tbl_rolelinkmapping  (linkId, roleId) values ((select linkId from tbl_link where linkname ='Workflow List' ),1);

insert into `tbl_commonlisting`(`actionItem`,`columnName`,`commonAction`,`discription`,`fromClause`,`isHQL`,`status`)values('View','tenderId:Event No.:1,createdDate:created Date:1,(case when (corrigendumId <> 0) then \'Corrigendum\' else \'Notice & Document\' end) as workflowFor:Workflow for:1,workflowId:workflowId:0',NULL,'Pending workflow list','from tbl_tenderworkflow where cstatus <> 0','0','1');


update tbl_commonlisting set columnname = 'tenderId:Event No.:1,(case when (corrigendumId <> 0) then ''Corrigendum'' else ''Notice & Document'' end) as workflowFor:Workflow for:1,remarks:Remarks:1,createdDate:created Date:1,workflowId:workflowId:0,corrigendumId:corrigendumId:0'
 where listingId in (11,12);
 
 alter table `eauctiontender`.`tbl_commonlisting` add column `srnoCol` tinyint(2) DEFAULT '1' NULL after `status`;
 
 update tbl_commonlisting set srnocol = 1 ;
 
 alter table `eauctiontender`.`tbl_tender` change `docFeePaymentMode` `docFeePaymentMode` int(11) default '2' NOT NULL, change `emdPaymentMode` `emdPaymentMode` int(11) default '2' NOT NULL, change `secFeePaymentMode` `secFeePaymentMode` int(11) default '2' NOT NULL;
 update tbl_tender set docFeePaymentMode = 2,secFeePaymentMode = 2,emdPaymentMode = 2;
 
 update `tbl_commonlisting` set `listingId`='12',`actionItem`='View',`columnName`='tenderId:Event No.:1,(case when (corrigendumId <> 0) then \'Corrigendum\' else \'Notice & Document\' end) as workflowFor:Workflow for:1,remarks:Remarks:1,createdDate:created Date:1,workflowId:workflowId:0,corrigendumId:corrigendumId:0',`commonAction`=NULL,`discription`='Pending workflow list',`fromClause`='from tbl_tenderworkflow where 1=1',`isHQL`='0',`status`='1',`srnocol`='1' where `listingId`='12';