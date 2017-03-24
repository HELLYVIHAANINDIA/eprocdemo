  
 ALTER TABLE `eauctiontender`.`tbl_userlogin`   
  ADD COLUMN `lastLogin` DATETIME NULL AFTER `forgotpwdExpiryDate`;

  ALTER TABLE `eauctiontender`.`tbl_userlogin`   
  ADD COLUMN `isFirstLogin` INT DEFAULT 1  NULL AFTER `lastLogin`;
  
  insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) values('view user','common','/common/user/viewuser/','view user');
insert into tbl_rolelinkmapping (linkId,roleId) values ((select linkId from tbl_link where link='/common/user/viewuser/'),1 );