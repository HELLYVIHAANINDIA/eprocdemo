 ALTER TABLE `eauctiontender`.`tbl_committee`   
  CHANGE `committeeName` `committeeName` VARCHAR(30) CHARSET latin1 COLLATE latin1_swedish_ci NOT NULL;

  
  ALTER TABLE `eauctiontender`.`tbl_committeeuser`   
  CHANGE `remarks` `remarks` LONGTEXT CHARSET latin1 COLLATE latin1_swedish_ci NULL;

  
  ALTER TABLE `eauctiontender`.`tbl_committee`   
  CHANGE `remarks` `remarks` LONGTEXT CHARSET latin1 COLLATE latin1_swedish_ci NULL;
  
  
insert into `tbl_link` (`linkName`, `module`, `link`, `description`) values('publish prebid mom','tender','etender/buyer/publishprebidmom/','publish prebid mom');


DROP table tbl_officerdocument;

CREATE TABLE `tbl_officerdocument` (
	`officerDocId` INT(250) NOT NULL AUTO_INCREMENT,
	`fileName` VARCHAR(750) NOT NULL,
	`description` VARCHAR(750) NULL DEFAULT NULL,
	`path` VARCHAR(300) NOT NULL,
	`fileType` VARCHAR(750) NOT NULL,
	`fileSize` INT(200) NULL DEFAULT NULL,
	`tenderId` INT(100) NOT NULL,
	`objectId` INT(100) NOT NULL,
	`childId` INT(100) NULL DEFAULT NULL,
	`subChildId` INT(100) NULL DEFAULT NULL,
	`officerId` INT(100) NOT NULL,
	`createdOn` DATETIME NOT NULL,
	`cstatus` INT(11) NOT NULL,
	PRIMARY KEY (`officerDocId`)
)
	
	
