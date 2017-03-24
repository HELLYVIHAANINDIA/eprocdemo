insert into `tbl_commonlisting` (`listingId`, `actionItem`, `columnName`, `commonAction`, `discription`, `fromClause`, `isHQL`, `status`, `srnoCol`) values('24','Edit,Block','personName:Name:1,emailId:emailId:1,address:address:1,bidderId:bidderId:0,phoneNo:Phone No:1',NULL,'approved bidder','from tbl_bidder where cstatus=1',NULL,'1','1');
insert into `tbl_commonlisting` (`listingId`, `actionItem`, `columnName`, `commonAction`, `discription`, `fromClause`, `isHQL`, `status`, `srnoCol`) values('25','Edit,Unblock','personName:Name:1,emailId:emailId:1,address:address:1,bidderId:bidderId:0,phoneNo:Phone No:1',NULL,'black listed','from tbl_bidder where cstatus=3',NULL,'1','1');
UPDATE `eauctiontender`.`tbl_commonlisting` SET `actionItem`='Edit,Approve,Reject' WHERE  `listingId`=8;


ALTER TABLE `eauctiontender`.`tbl_bidder`   
  ADD COLUMN `remarks` VARCHAR(500) NULL AFTER `companyId`;

insert into `tbl_link` (`linkId`, `linkName`, `module`, `link`, `description`) values('1155','get user status','common','/common/user/getuserstatus','get user status');
insert into `tbl_link` (`linkId`, `linkName`, `module`, `link`, `description`) values('1156','change user status','common','/common/user/addbidderstatus','change user status');

insert into tbl_rolelinkmapping (linkId,roleId) values ((select linkId from tbl_link where link='/common/user/getuserstatus'),1 );
insert into tbl_rolelinkmapping (linkId,roleId) values ((select linkId from tbl_link where link='/common/user/addbidderstatus'),1 );


UPDATE `eauctiontender`.`tbl_commonlisting` SET `fromClause`='from tbl_bidder where cstatus=0' WHERE  `listingId`=8;