ALTER TABLE `eauctiontender`.`tbl_userlogin`   
  ADD COLUMN `userType` INT(10) NOT NULL AFTER `designationId`;
  
CREATE TABLE `eauctiontender`.`tbl_country`(  
  `countryId` INT(11) NOT NULL AUTO_INCREMENT,
  `countryName` VARCHAR(25) NOT NULL,
  `countryCode` VARCHAR(10),
  PRIMARY KEY (`countryId`)
);

CREATE TABLE `eauctiontender`.`tbl_state`(  
  `stateId` INT(11) NOT NULL AUTO_INCREMENT,
  `stateName` VARCHAR(25) NOT NULL,
  `countryId` INT NOT NULL,
  PRIMARY KEY (`stateId`),
  FOREIGN KEY (`countryId`) REFERENCES `eauctiontender`.`tbl_country`(`countryId`) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE `eauctiontender`.`tbl_bidder`(  
  `bidderId` INT(10) NOT NULL AUTO_INCREMENT,
  `emailId` VARCHAR(25) NOT NULL,
  `personName` VARCHAR(25) NOT NULL,
  `companyName` VARCHAR(25) NOT NULL,
  `address` VARCHAR(250) NOT NULL,
  `countryId` INT(10) NOT NULL,
  `stateId` INT(10) NOT NULL,
  `city` VARCHAR(25) NOT NULL,
  `phoneNo` VARCHAR(11),
  `mobileNo` VARCHAR(11) NOT NULL,
  `website` VARCHAR(25),
  PRIMARY KEY (`bidderId`),
  FOREIGN KEY (`countryId`) REFERENCES `eauctiontender`.`tbl_country`(`countryId`) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (`stateId`) REFERENCES `eauctiontender`.`tbl_state`(`stateId`) ON UPDATE CASCADE ON DELETE CASCADE
);
 
  
