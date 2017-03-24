  
  ALTER TABLE `eauctiontender`.`tbl_department`   
  ADD COLUMN `cstatus` INT(11) DEFAULT 0  NULL AFTER `mailPassword`;
ALTER TABLE `eauctiontender`.`tbl_department`   
  ADD COLUMN `deptDocId` INT(11) NULL AFTER `cstatus`;
ALTER TABLE `eauctiontender`.`tbl_department`   
  ADD COLUMN `remarks` VARCHAR(250) NULL AFTER `deptDocId`;


INSERT INTO `eauctiontender`.`tbl_link` (`linkName`, `module`, `link`, `description`) VALUES ('Manage organization', 'Common', '/common/user/manageorganization', 'Manage organization');
INSERT INTO `eauctiontender`.`tbl_link` (`linkName`, `module`, `link`, `description`) VALUES ('change organization status', 'common', '/common/user/addorganizationstatus', 'change organization status');

insert into tbl_rolelinkmapping (linkId,roleId) values ((select linkId from tbl_link where link='/common/user/manageorganization'),1 );
insert into tbl_rolelinkmapping (linkId,roleId) values ((select linkId from tbl_link where link='/common/user/addorganizationstatus'),1 );

INSERT INTO `eauctiontender`.`tbl_commonlisting` (`actionItem`) VALUES ('View');
UPDATE `eauctiontender`.`tbl_commonlisting` SET `columnName`='deptName:Organization:1~address:Address:1~deptId:deptId:0', `discription`='Approved organization', `fromClause`='FROM  tbl_department WHERE parentDeptId=0 AND grandParentDeptId=0 and cstatus=1' WHERE  `listingId`=40;
UPDATE `eauctiontender`.`tbl_commonlisting` SET `status`='1' WHERE  `listingId`=40;

UPDATE `eauctiontender`.`tbl_commonlisting` SET `actionItem`='View' WHERE  `listingId`=21;
UPDATE `eauctiontender`.`tbl_commonlisting` SET `fromClause`='FROM  tbl_department WHERE parentDeptId=0 AND grandParentDeptId=0 and cstatus=0' WHERE  `listingId`=21;



