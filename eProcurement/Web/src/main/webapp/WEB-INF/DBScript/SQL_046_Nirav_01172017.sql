CREATE TABLE `eauctiontender`.`tbl_bidderdocument`(  
  `bidderDocId` INT(15) NOT NULL AUTO_INCREMENT,
  `fileName` VARCHAR(250) NOT NULL,
  `description` VARCHAR(250) NOT NULL,
  `path` VARCHAR(250) NOT NULL,
  `fileType` VARCHAR(250) NOT NULL,
  `fileSize` INT(15) NOT NULL,
  `tenderId` INT(15) NOT NULL,
  `objectId` INT(15),
  `childId` INT(15),
  `subChildId` INT(15),
  `otherSubChildId` INT(15),
  `bidderId` INT(15),
  `createdOn` DATETIME,
  `cstatus` INT(15),
  PRIMARY KEY (`bidderDocId`)
);


CREATE TABLE `tbl_seekclarification` (
	`clarificationId` INT(11) NOT NULL AUTO_INCREMENT,
	`createdBy` INT(11) NOT NULL DEFAULT '0',
	`createdOn` DATETIME NOT NULL DEFAULT '0',
	`isActive` INT(11) NOT NULL DEFAULT '0',
	`responseEndDate` INT(11) NOT NULL DEFAULT '0',
	`bidderId` INT(11) NOT NULL DEFAULT '0',
	`tenderid` INT(11) NOT NULL DEFAULT '0',
	`envelopeid` INT(11) NOT NULL DEFAULT '0',
	`officerId` INT(11) NOT NULL DEFAULT '0',
	PRIMARY KEY (`clarificationId`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;



CREATE TABLE `tbl_questionanswer` (
	`questionId` INT(11) NOT NULL AUTO_INCREMENT,
	`question` VARCHAR(500) NOT NULL DEFAULT '0',
	`answer` VARCHAR(500) NULL DEFAULT '0',
	`isActive` INT(11) NULL DEFAULT '0',
	`questionBy` INT(11) NULL DEFAULT '0',
	`questionDate` DATETIME NULL DEFAULT '0',
	`answerBy` INT(11) NULL DEFAULT '0',
	`answerDate` DATETIME NULL DEFAULT '0',
	`eventId` INT(11) NOT NULL DEFAULT '0',
	PRIMARY KEY (`questionId`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;


ALTER TABLE `eauctiontender`.`tbl_officerdocument`   
  ADD COLUMN `otherSubChildId` INT(100) NULL AFTER `subChildId`;
  
  
  
insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) values('Create seekclarification buyer','Tender','/buyer/createSeekClarificationQueryView','create seek clarifiaciton buyer');
insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) values('Post Query ','Tender','/buyer/postQuery','Post query buyer');
insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) values('seek clearification bidder list','Tender','/buyer/bidderwiseclaficationlist','bidder list for seek clarification');
insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) values('Configure seek clarification date','Tender','/buyer/configuredate/','configure seek clarification date');
insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) values('Edit configuration date','Tender','/buyer/editconfiguredate','Edit configuration date');
insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) values('Post configuration date','Tender','/buyer/postConfigureDate','Post configuration date');
insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) values('View Clarification query buyer side','Tender','/buyer/postConfigureDate','View Clarification query buyer side');
insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) values('View Question Answer','Tender','/buyer/viewQuestionAnswer/','View Question answer');
insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) values('Reconfigure date','Tender','/buyer/reconfiguredate','Reconfigure date');
insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) values('Bidder seek clarification','Tender','/bidder/responseQueryView','Bidder seek clarification');
insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) values('Bidder response post','Tender','/bidder/responseQueryPost','Bidder response post');
insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) values('Bidder view queries','Tender','/bidder/viewQueries','Bidder view queries');
insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) values('Bidder view question answer`','Tender','/bidder/viewQuestionAnswer','bidder view question answer');

insert into `tbl_rolelinkmapping` (`linkId`, `roleId`) values ((select linkId from tbl_Link where link='/buyer/createSeekClarificationQueryView'),1);
insert into `tbl_rolelinkmapping` (`linkId`, `roleId`) values ((select linkId from tbl_Link where link='/buyer/postQuery'),1);
insert into `tbl_rolelinkmapping` (`linkId`, `roleId`) values ((select linkId from tbl_Link where link='/buyer/bidderwiseclaficationlist'),1);
insert into `tbl_rolelinkmapping` (`linkId`, `roleId`) values ((select linkId from tbl_Link where link='/buyer/configuredate/'),1);
insert into `tbl_rolelinkmapping` (`linkId`, `roleId`) values ((select linkId from tbl_Link where link='/buyer/editconfiguredate'),1);
insert into `tbl_rolelinkmapping` (`linkId`, `roleId`) values ((select linkId from tbl_Link where link='/buyer/postConfigureDate'),1);
insert into `tbl_rolelinkmapping` (`linkId`, `roleId`) values ((select linkId from tbl_Link where link='/buyer/viewQuestionAnswer/'),1);
insert into `tbl_rolelinkmapping` (`linkId`, `roleId`) values ((select linkId from tbl_Link where link='/buyer/reconfiguredate'),1);
insert into `tbl_rolelinkmapping` (`linkId`, `roleId`) values ((select linkId from tbl_Link where link='/bidder/responseQueryView'),1);
insert into `tbl_rolelinkmapping` (`linkId`, `roleId`) values ((select linkId from tbl_Link where link='/bidder/responseQueryPost'),1);
insert into `tbl_rolelinkmapping` (`linkId`, `roleId`) values ((select linkId from tbl_Link where link='/bidder/viewQueries'),1);
insert into `tbl_rolelinkmapping` (`linkId`, `roleId`) values ((select linkId from tbl_Link where link='/bidder/viewQuestionAnswer'),1);


--select * from tbl_link where linkName like '%docu%'; take respective link id in below inserts

insert into `tbl_rolelinkmapping` (`linkId`, `roleId`) values (259,5);
insert into `tbl_rolelinkmapping` (`linkId`, `roleId`) values (260,5);
insert into `tbl_rolelinkmapping` (`linkId`, `roleId`) values (261,5);
insert into `tbl_rolelinkmapping` (`linkId`, `roleId`) values (262,5);
insert into `tbl_rolelinkmapping` (`linkId`, `roleId`) values (263,5);
insert into `tbl_rolelinkmapping` (`linkId`, `roleId`) values (292,5);



  
  
  