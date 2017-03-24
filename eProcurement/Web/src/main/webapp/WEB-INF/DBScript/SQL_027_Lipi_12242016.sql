
insert into tbl_link (linkName,module,link,description) values('Delete Bid','Bidder','etender/bidder/deletebid','Delete Bid');
INSERT INTO `tbl_rolelinkmapping` ( `linkId`, `roleId`) VALUES
	( (select linkId from tbl_link where linkName='Delete Bid'), 1);
	