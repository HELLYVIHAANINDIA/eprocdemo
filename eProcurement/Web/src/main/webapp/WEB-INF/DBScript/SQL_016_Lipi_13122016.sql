insert  into `tbl_link`(`linkName`,`module`,`link`,`description`) values 
('Consent Remarks','tender','etender/buyer/getcommitteeuserremark','Tender Opening Consent Remarks'),
('Submit Consent Remarks','tender','etender/buyer/addusercommitteeremarks','Submit Consent Remarks'),
('Price Bid ICB','tender','etender/buyer/pricebidICB','Price Bid ICB'),
('Configure Price Bid Opening Date','tender','etender/buyer/pricebidopeningdate','Configure Price Bid Opening Date'),
('Edit Price Bid Opening Date','tender','etender/buyer/editpricebidopeningdate','Edit Price Bid Opening Date'),
('Publish Price Bid Opening Date','tender','etender/buyer/publishpricebidopeningdate','Publish Price Bid Opening Date'),
('View Price Bid Opening Date','tender','etender/buyer/viewpricebidopeningdate','View Price Bid Opening Date'),
('Evaluate Bidder','tender','etender/buyer/evaluatebidders','Evaluate Bidder'),
('Save Price Bid ICB','tender','etender/buyer/updatepricebidICB','Save Price Bid ICB'),
('Save Price Bid Opening Date','tender','etender/buyer/updatepricebidopeningdate','Save Price Bid Opening Date'),
('Save Evaluate Bidder','tender','etender/buyer/saveevlutbiderstatus','Save Evaluate Bidder');


insert into tbl_rolelinkmapping (linkId,roleId) values ((select linkId from tbl_link where link='etender/buyer/getcommitteeuserremark'),1 );
insert into tbl_rolelinkmapping (linkId,roleId) values ((select linkId from tbl_link where link='etender/buyer/addusercommitteeremarks'),1 );
insert into tbl_rolelinkmapping (linkId,roleId) values ((select linkId from tbl_link where link='etender/buyer/pricebidICB'),1 );
insert into tbl_rolelinkmapping (linkId,roleId) values ((select linkId from tbl_link where link='etender/buyer/pricebidopeningdate'),1 );
insert into tbl_rolelinkmapping (linkId,roleId) values ((select linkId from tbl_link where link='etender/buyer/editpricebidopeningdate'),1 );
insert into tbl_rolelinkmapping (linkId,roleId) values ((select linkId from tbl_link where link='etender/buyer/publishpricebidopeningdate'),1 );
insert into tbl_rolelinkmapping (linkId,roleId) values ((select linkId from tbl_link where link='etender/buyer/viewpricebidopeningdate'),1 );
insert into tbl_rolelinkmapping (linkId,roleId) values ((select linkId from tbl_link where link='etender/buyer/evaluatebidders'),1 );
insert into tbl_rolelinkmapping (linkId,roleId) values ((select linkId from tbl_link where link='etender/buyer/updatepricebidICB'),1 );
insert into tbl_rolelinkmapping (linkId,roleId) values ((select linkId from tbl_link where link='etender/buyer/updatepricebidopeningdate'),1 );
insert into tbl_rolelinkmapping (linkId,roleId) values ((select linkId from tbl_link where link='etender/buyer/saveevlutbiderstatus'),1 );
