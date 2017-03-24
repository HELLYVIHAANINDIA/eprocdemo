CREATE TABLE `tbl_TenderCellGrandTotal` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `tableId` int(11) DEFAULT NULL,
  `formId` int(11) DEFAULT NULL,
 `tenderId` int(11) DEFAULT NULL,
`columnId` int(11) DEFAULT NULL,
`bidderId` int(11) DEFAULT NULL,
`GTValue` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_tbl_tender` FOREIGN KEY (`tenderId`) REFERENCES `tbl_tender` (`tenderId`),
CONSTRAINT `fk_tbl_tendertable` FOREIGN KEY (`tableId`) REFERENCES `tbl_tendertable` (`tableId`),
CONSTRAINT `fk_tbl_tenderform` FOREIGN KEY (`formId`) REFERENCES `tbl_tenderform` (`formId`),
CONSTRAINT `fk_tbl_tendercolumn` FOREIGN KEY (`columnId`) REFERENCES `tbl_tendercolumn` (`columnId`),
CONSTRAINT `fk_tbl_tenderbiddermap` FOREIGN KEY (`bidderId`) REFERENCES `tbl_bidder` (`bidderId`)
)