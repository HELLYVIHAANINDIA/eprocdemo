ALTER TABLE `eauctiontender`.`tbl_tender`   
  ADD COLUMN `cancelRemarks` VARCHAR(500) NULL AFTER `autoResultSharing`,
  ADD COLUMN `cancelDate` DATETIME NULL AFTER `cancelRemarks`,
  ADD COLUMN `cancelBy` INT NULL AFTER `cancelDate`;

 ALTER TABLE `eauctiontender`.`tbl_tender`   
  CHANGE `cancelBy` `cancelBy` INT(11) DEFAULT 0  NULL;

insert into `tbl_link` (`linkName`, `module`, `link`, `description`) values('get cancel tender','tender','/etender/buyer/getcanceltender/','get cancel tender');
insert into `tbl_link` (`linkName`, `module`, `link`, `description`) values('add cancel tender','tender','/etender/buyer/canceltender','add cancel tender');


INSERT INTO `tbl_rolelinkmapping`(`linkId`, `roleId`)VALUES((SELECT linkId FROM tbl_link WHERE link='/etender/buyer/canceltender'),1);
INSERT INTO `tbl_rolelinkmapping`(`linkId`, `roleId`)VALUES((SELECT linkId FROM tbl_link WHERE link='/etender/buyer/getcanceltender/'),1);