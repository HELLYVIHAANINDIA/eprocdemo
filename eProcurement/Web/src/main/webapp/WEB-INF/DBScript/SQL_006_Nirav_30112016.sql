drop table if exists tbl_tenderbiddermap;

CREATE TABLE `eauctiontender`.`tbl_tenderbiddermap`(  
  `bidderMapId` INT(11) NOT NULL AUTO_INCREMENT,
  `tenderId` INT(11) NOT NULL,
  `bidderId` INT(11) NOT NULL,
  `userId` BIGINT(20) NOT NULL,
  `mappedBy` INT(11) NOT NULL,
  `mappedDate` DATETIME NOT NULL,
  PRIMARY KEY (`bidderMapId`),
  CONSTRAINT `FKtender` FOREIGN KEY (`tenderId`) REFERENCES `eauctiontender`.`tbl_tender`(`tenderId`) ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT `FKbidder` FOREIGN KEY (`bidderId`) REFERENCES `eauctiontender`.`tbl_bidder`(`bidderId`) ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT `FKuser` FOREIGN KEY (`userId`) REFERENCES `eauctiontender`.`tbl_userlogin`(`userId`) ON UPDATE CASCADE ON DELETE CASCADE
);



insert into `tbl_link` (`linkId`, `linkName`, `module`, `link`, `description`) values('43','map bidder','tender','/etender/buyer/biddermapping/','bidder map');
insert into `tbl_link` (`linkId`, `linkName`, `module`, `link`, `description`) values('44','search unmapped bidder','tender','/etender/buyer/searchunmappedbidder','search unmapped bidder');
insert into `tbl_link` (`linkId`, `linkName`, `module`, `link`, `description`) values('45','map bidder','tender','/etender/buyer/mapbidder','mapbidder');
insert into `tbl_link` (`linkId`, `linkName`, `module`, `link`, `description`) values('46','remove mapped bidder','tender','/etender/buyer/removemappedbidder','remove mapped bidder');

insert into `tbl_rolelinkmapping` (`rolelinkmapId`, `linkId`, `roleId`) values('43','43','1');
insert into `tbl_rolelinkmapping` (`rolelinkmapId`, `linkId`, `roleId`) values('44','44','1');
insert into `tbl_rolelinkmapping` (`rolelinkmapId`, `linkId`, `roleId`) values('45','45','1');
insert into `tbl_rolelinkmapping` (`rolelinkmapId`, `linkId`, `roleId`) values('46','46','1');
