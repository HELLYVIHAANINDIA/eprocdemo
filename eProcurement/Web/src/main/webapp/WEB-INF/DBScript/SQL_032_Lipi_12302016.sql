insert into tbl_link (linkName,module,link,description) 
values('Add Rebate','bidder','/etender/bidder/crteditrebate','Add Rebate');
insert into tbl_link (linkName,module,link,description) 
values('Save Rebate','bidder','/etender/bidder/addrebate','Save Rebate');

insert into tbl_rolelinkmapping (linkId,roleId) values((select linkId from tbl_link where link='/etender/bidder/crteditrebate'),5);
insert into tbl_rolelinkmapping (linkId,roleId) values((select linkId from tbl_link where link='/etender/bidder/addrebate'),5);

ALTER TABLE `tbl_Tender` MODIFY `isEvaluationRequired` INT NOT NULL DEFAULT 1;


insert into tbl_link (linkName,module,link,description) 
values('Result Share','tender','/etender/buyer/getresultsharing','Result Share');

insert into tbl_rolelinkmapping (linkId,roleId) values((select linkId from tbl_link where link='/etender/buyer/getresultsharing'),1);


