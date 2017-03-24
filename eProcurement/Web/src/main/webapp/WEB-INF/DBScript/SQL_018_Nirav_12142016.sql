ALTER TABLE `tbl_officerdocument`
	ALTER `fileName` DROP DEFAULT,
	ALTER `description` DROP DEFAULT,
	ALTER `path` DROP DEFAULT,
	ALTER `fileType` DROP DEFAULT,
	ALTER `tenderId` DROP DEFAULT,
	ALTER `objectId` DROP DEFAULT,
	ALTER `childId` DROP DEFAULT,
	ALTER `officerId` DROP DEFAULT,
	ALTER `createdOn` DROP DEFAULT,
	ALTER `cstatus` DROP DEFAULT;
	
ALTER TABLE `tbl_officerdocument`
	CHANGE COLUMN `officerDocId` `officerDocId` INT(250) NOT NULL AUTO_INCREMENT FIRST,
	CHANGE COLUMN `fileName` `fileName` VARCHAR(750) NOT NULL AFTER `officerDocId`,
	CHANGE COLUMN `description` `description` VARCHAR(750) NULL AFTER `fileName`,
	CHANGE COLUMN `path` `path` VARCHAR(300) NOT NULL AFTER `description`,
	CHANGE COLUMN `fileType` `fileType` VARCHAR(750) NOT NULL AFTER `path`,
	CHANGE COLUMN `tenderId` `tenderId` INT(100) NOT NULL AFTER `fileSize`,
	CHANGE COLUMN `objectId` `objectId` INT(100) NOT NULL AFTER `tenderId`,
	CHANGE COLUMN `childId` `childId` INT(100) NULL AFTER `objectId`,
	CHANGE COLUMN `officerId` `officerId` INT(100) NOT NULL AFTER `subChildId`,
	CHANGE COLUMN `createdOn` `createdOn` DATETIME NOT NULL AFTER `officerId`,
	CHANGE COLUMN `cstatus` `cstatus` INT(11) NOT NULL AFTER `createdOn`,
	ADD PRIMARY KEY (`officerDocId`);
	
	
insert into `tbl_link` (`linkName`, `module`, `link`, `description`) values('get file upload','tender','/etender/bidder/uploadbr','get file upload');
insert into `tbl_link` (`linkName`, `module`, `link`, `description`) values('document content','tender','/etender/bidder/briefca','document content');
insert into `tbl_link` (`linkName`, `module`, `link`, `description`) values('document upload post','tender','/ajax/submitbriefcase','document upload post');
insert into `tbl_link` (`linkName`, `module`, `link`, `description`) values('get all document','tender','ajax/getbriefcaseuploadeddocs','get all documents');
insert into `tbl_link` (`linkName`, `module`, `link`, `description`) values('remove document','tender','/ajax/deletebriefcasefil','remove document');
insert into `tbl_link` (`linkName`, `module`, `link`, `description`) values('download document','tender','/ajax/downloadbriefcasefile','download document');
insert into `tbl_link` (`linkName`, `module`, `link`, `description`) values('tender nit document','tender','/etender/buyer/tendernit','get tender nit document');


	
	
