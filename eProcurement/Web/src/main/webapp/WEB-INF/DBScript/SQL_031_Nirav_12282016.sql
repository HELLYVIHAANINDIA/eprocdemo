create table `tbl_auditlog` (
	`AUDIT_LOG_ID` bigint (20),
	`ACTION` varchar (300),
	`DETAIL` blob ,
	`CREATED_DATE` datetime ,
	`ENTITY_ID` bigint (20),
	`ENTITY_NAME` varchar (765),
	`EMAIL_ID` varchar (765),
	`PAGE_URL` varchar (765)
);

ALTER TABLE `tbl_userlogin`
	ADD COLUMN `forgotpwdHash` VARCHAR(250) NULL AFTER `userType`,
	ADD COLUMN `forgotpwdExpiryDate` DATETIME NULL AFTER `forgotpwdHash`;

INSERT INTO `eauctiontender`.`tbl_commonlisting` (`columnName`) VALUES ('ID:1,PAGE_URL:Url:1,DETAIL:Detail,ACTION:ACTION:1,CREATED_DATE:DATE:1,ENTITY_ID:Event ');
UPDATE `eauctiontender`.`tbl_commonlisting` SET `columnName`='ID:1,PAGE_URL:Url:1,DETAIL:Detail,ACTION:ACTION:1,CREATED_DATE:DATE:1,ENTITY_ID:Event Id', `fromClause`='FROM tbl_auditlog WHERE 1=1', `status`='1' WHERE  `listingId`=20;

insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) values('audittrial reports','common','/common/audittrial','Audit trial report');
insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) values('change password','common','/user/getpasswordchange/','change password');
insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) values('change password post','common','/user/postchangepassword','change password post');


insert into tbl_rolelinkmapping (linkId,roleId) values ((select linkId from tbl_link where link='/common/audittrial'),5 );
insert into tbl_rolelinkmapping (linkId,roleId) values ((select linkId from tbl_link where link='/user/getpasswordchange/'),5 );
insert into tbl_rolelinkmapping (linkId,roleId) values ((select linkId from tbl_link where link='/user/postchangepassword'),5 );