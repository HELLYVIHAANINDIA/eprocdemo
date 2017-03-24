ALTER TABLE `tbl_Tender` ADD `randPass` text NOT NULL;

update tbl_Tender set randPass = '' ;

insert  into `tbl_link`(`linkName`,`module`,`link`,`description`) values 
('Officer Comparative Report','tender','etender/buyer/tendercomparativereport','Officer Comparative Report');

insert into tbl_rolelinkmapping (linkId,roleId) values ((select linkId from tbl_link where link='etender/buyer/tendercomparativereport'),1);
insert into tbl_rolelinkmapping (linkId,roleId) values ((select linkId from tbl_link where link='etender/buyer/tendercomparativereport'),6);

insert  into `tbl_link`(`linkName`,`module`,`link`,`description`) values 
('Bidder Comparative Report','tender','etender/bidder/tendercomparativereport','Bidder Comparative Report');

insert into tbl_rolelinkmapping (linkId,roleId) values ((select linkId from tbl_link where link='etender/bidder/tendercomparativereport'),5);


ALTER TABLE tbl_TenderCellGrandTotal MODIFY GTValue TEXT NULL;



insert into tbl_link (linkName,module,link,description) 
values('Decrypt Bid','tender','/etender/buyer/getUserListForDecryptBid','Decrypt Bid');
insert into tbl_rolelinkmapping (linkId,roleId) values((select linkId from tbl_link where link='/etender/buyer/getUserListForDecryptBid'),1);
insert into tbl_rolelinkmapping (linkId,roleId) values((select linkId from tbl_link where link='/etender/buyer/getUserListForDecryptBid'),6);


insert into tbl_link (linkName,module,link,description) 
values('Verify Bid','tender','/etender/buyer/getUserListForVerifyBid','Verify Bid');
insert into tbl_rolelinkmapping (linkId,roleId) values((select linkId from tbl_link where link='/etender/buyer/getUserListForVerifyBid'),1);
insert into tbl_rolelinkmapping (linkId,roleId) values((select linkId from tbl_link where link='/etender/buyer/getUserListForVerifyBid'),6);