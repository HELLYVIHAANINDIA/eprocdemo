ALTER TABLE `eauctiontender`.`tbl_bidder`   
  ADD COLUMN `keyword` VARCHAR(25) NULL AFTER `website`,
  ADD COLUMN `cstatus` INT(10) NOT NULL AFTER `keyword`,
  ADD COLUMN `userId` INT(10) NOT NULL AFTER `cstatus`,
  ADD COLUMN `datecreated` DATETIME NOT NULL AFTER `userId`,
  ADD COLUMN `datemodified` DATETIME NULL AFTER `datecreated`,
  ADD COLUMN `createdBy` INT NOT NULL AFTER `datemodified`,
  ADD COLUMN `modifiedBy` INT NULL AFTER `createdBy`;

 -- ADD FOREIGN KEY (`tbl_userlogin_userId`) REFERENCES `eauctiontender`.`tbl_userlogin`(`userId`) ON UPDATE CASCADE ON DELETE CASCADE;
  
  
insert into `tbl_link` (`linkId`, `linkName`, `module`, `link`, `description`) values('41','managebidder','common','/common/user/getmanagebidder','get manage bidder');
insert into `tbl_link` (`linkId`, `linkName`, `module`, `link`, `description`) values('42','edit bidder','common','/common/user/geteditbidder','edit bidder');

insert into `tbl_rolelinkmapping` (`rolelinkmapId`, `linkId`, `roleId`) values('41','41','1');
insert into `tbl_rolelinkmapping` (`rolelinkmapId`, `linkId`, `roleId`) values('42','42','1');
 
 
  
