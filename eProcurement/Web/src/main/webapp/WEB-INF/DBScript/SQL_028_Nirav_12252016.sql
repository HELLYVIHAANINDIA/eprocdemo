ALTER TABLE `eauctiontender`.`tbl_tender`   
  ADD COLUMN `copyFrom` INT(11) DEFAULT 0  NULL AFTER `isRebateApplicable`;

insert into `tbl_link` (`linkName`, `module`, `link`, `description`) values('copy tender','tender','/etender/buyer/copytender/','copy tender');
INSERT INTO `tbl_rolelinkmapping`(`linkId`, `roleId`)VALUES((SELECT linkId FROM tbl_link WHERE link='/etender/buyer/copytender/'),1);
