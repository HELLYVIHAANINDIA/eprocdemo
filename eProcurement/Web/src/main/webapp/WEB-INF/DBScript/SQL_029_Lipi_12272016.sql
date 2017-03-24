insert into tbl_link (linkName,module,link,description) values('Country Integration','common','/etender/buyer/getCountry','Country Integration');
insert into tbl_link (linkName,module,link,description) values('State Integration','common','/etender/buyer/getStates','State Integration');
insert into tbl_link (linkName,module,link,description) values('City Integration','common','/etender/buyer/getCities','City Integration');
insert into tbl_rolelinkmapping (linkId,roleId) values((select linkId from tbl_link where link='/etender/buyer/getCountry'),1);
insert into tbl_rolelinkmapping (linkId,roleId) values((select linkId from tbl_link where link='/etender/buyer/getStates'),1);
insert into tbl_rolelinkmapping (linkId,roleId) values((select linkId from tbl_link where link='/etender/buyer/getCities'),1);

INSERT INTO `tbl_rolelinkmapping` ( `linkId`, `roleId`) VALUES
	( (select linkId from tbl_link where linkName='Delete Bid'), 1);
	
	
	drop table tbl_tenderbidconfirmation;
	
CREATE TABLE `tbl_tenderbidconfirmation` (
  `bidConfirmationId` int(11) NOT NULL AUTO_INCREMENT,
  `createdBy` int(11) NOT NULL,
  `createdOn` datetime DEFAULT CURRENT_TIMESTAMP,
  `encodedName` longtext,
  `ipAddress` longtext NOT NULL,
  `companyid` int(11) NOT NULL,
  `tenderid` int(11) NOT NULL,
  `bidderid` int(11) NOT NULL,
  `termNcondId` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`bidConfirmationId`),
  KEY `FK_tbl_tenderbidconfirmation_tender` (`tenderid`),
  KEY `FK_tbl_tenderbidconfirmation_company` (`companyid`),
  CONSTRAINT `FK7jgdp6wkl4cj6wum1go3cl5a3` FOREIGN KEY (`companyid`) REFERENCES `tbl_company` (`companyid`),
  CONSTRAINT `FK_tbl_tenderbidconfirmation_company` FOREIGN KEY (`companyid`) REFERENCES `tbl_company` (`companyid`),
  CONSTRAINT `FK_tbl_tenderbidconfirmation_tender` FOREIGN KEY (`tenderid`) REFERENCES `tbl_tender` (`tenderId`),
  CONSTRAINT `FKb1s590y4enveq9b79draepwcu` FOREIGN KEY (`tenderid`) REFERENCES `tbl_tender` (`tenderId`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;	
