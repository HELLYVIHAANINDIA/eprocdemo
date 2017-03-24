CREATE TABLE `tbl_eventtermandconditions` (
	`termNcondId` INT(25) NOT NULL DEFAULT NULL,
	`termNcondition` VARCHAR(6000) NULL DEFAULT NULL,
	`eventType` INT(11) NULL DEFAULT NULL,
	`eventId` INT(11) NULL DEFAULT NULL,
	PRIMARY KEY (`termNcondId`)
)

ALTER TABLE `tbl_eventtermandconditions`
	CHANGE COLUMN `termNcondId` `termNcondId` INT(25) NOT NULL DEFAULT NULL FIRST,
	ADD PRIMARY KEY (`termNcondId`);

	
insert into tbl_link(linkName,module,link,description) values ('get tender terms and cond','tender','/etender/buyer/getcreatetermandconditions','get tender terms and cond.');

insert into tbl_link(linkName,module,link,description) values ('add tender terms and cond','tender','/etender/buyer/addtermandconditions','add tender term and cond.');