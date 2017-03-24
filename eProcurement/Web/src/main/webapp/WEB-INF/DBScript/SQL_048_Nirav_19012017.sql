ALTER TABLE `tbl_bidder`
	ADD COLUMN `lastName` VARCHAR(25) NOT NULL AFTER `personName`,
	ADD COLUMN `middleName` VARCHAR(25) NOT NULL AFTER `lastName`,
	ADD COLUMN `bidderDocId` INT(100) NULL DEFAULT NULL AFTER `timezoneId`;
	
	UPDATE `eauctiontender`.`tbl_commonlisting` SET `actionItem`='View' WHERE  `listingId`=8;
