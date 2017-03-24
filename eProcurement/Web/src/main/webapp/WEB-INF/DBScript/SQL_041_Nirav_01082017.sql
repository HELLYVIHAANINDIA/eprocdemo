ALTER TABLE `eauctiontender`.`tbl_department`   
  ADD COLUMN `mailHostName` VARCHAR(250) NULL AFTER `createdBy`,
  ADD COLUMN `mailPort` VARCHAR(250) NULL AFTER `mailHostName`,
  ADD COLUMN `fromMailId` VARCHAR(250) NULL AFTER `mailPort`,
  ADD COLUMN `mailUsername` VARCHAR(250) NULL AFTER `fromMailId`,
  ADD COLUMN `mailPassword` VARCHAR(250) NULL AFTER `mailUsername`;
