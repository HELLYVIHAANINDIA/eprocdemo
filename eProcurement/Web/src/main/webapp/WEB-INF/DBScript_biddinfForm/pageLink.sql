
insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) 
values('create bidding form','tender','/eProcurement/eBid/Bid/createForm','create bidding form');
 
insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkid from tbl_link where link = '/eProcurement/eBid/Bid/createForm'),'1');

 insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) 
values('View Bidding Form','tender','/eProcurement/eBid/Bid/viewForm','View bidding form');

insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkid from tbl_link where link = '/eProcurement/eBid/Bid/viewForm'),'1');

  insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) 
values('Save Bidding Form','tender','/eProcurement/eBid/Bid/saveForm','save bidding form structure');

insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkid from tbl_link where link = '/eProcurement/eBid/Bid/saveForm'),'1');

 insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) 
values('Save Bidding Form Value','tender','/eProcurement/eBid/Bid/updateBiddingFormValue','Add/Edit bidding form value');

insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkid from tbl_link where link = '/eProcurement/eBid/Bid/updateBiddingFormValue'),'1');

 insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) 
values('Tender Listing','tender','/eProcurement/eBid/Bid/tenderListing','Tender Listing');

insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkid from tbl_link where link = '/eProcurement/eBid/Bid/tenderListing'),'1');
