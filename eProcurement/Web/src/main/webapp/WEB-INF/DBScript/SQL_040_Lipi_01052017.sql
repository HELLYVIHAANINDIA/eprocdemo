ALTER TABLE tbl_commonlisting modify fromClause text NULL;

UPDATE `eauctiontender`.`tbl_commonlisting` SET `columnName`='personName:Name:1,emailId:emailId:1,address:address:1,bidderId:bidderId:0,phoneNo:Phone No:1' WHERE  `listingId`=8;


ALTER TABLE tbl_tenderrebate DROP FOREIGN KEY FK_tbl_tenderrebate_rebate;
ALTER TABLE tbl_tenderrebate DROP COLUMN rebateId;

ALTER TABLE tbl_tenderrebate ADD COLUMN tenderId int(11) NOT NULL;

ALTER TABLE tbl_tenderrebate
ADD CONSTRAINT FK_tbl_tenderrebate_tender
FOREIGN KEY (tenderId)
REFERENCES tbl_tender(tenderId);

insert into tbl_link (linkName,module,link,description) values('Edit Rebate','Bidder','/etender/bidder/editrebate','Edit Rebate for save');
INSERT INTO `tbl_rolelinkmapping` ( `linkId`, `roleId`) VALUES
	( (select linkId from tbl_link where link='/etender/bidder/editrebate'), 5);