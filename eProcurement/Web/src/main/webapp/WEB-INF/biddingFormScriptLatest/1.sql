CREATE TABLE `tbl_tenderdocument` (
  `documentId` int(11) NOT NULL AUTO_INCREMENT,
  `documentName` longtext NOT NULL,
  `isMandatory` int(11) NOT NULL,
  `formId` int(11) NOT NULL,
  `tenderId` int(11) NOT NULL,
  PRIMARY KEY (`documentId`),
  KEY `FK_tbl_tenderdocument_form` (`formId`),
  KEY `FK_tbl_tenderdocument_tender` (`tenderId`),
  CONSTRAINT `FK_tbl_tenderformula_form1` FOREIGN KEY (`formId`) REFERENCES `tbl_tenderform` (`formId`),
  CONSTRAINT `FK_tbl_tenderdocument_tender1` FOREIGN KEY (`tenderId`) REFERENCES `tbl_tender` (`tenderId`)
)

insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) 
values('EditBidding Form','tender','/eProcurement/eBid/Bid/EditBiddingForm','EditBidding Form');
insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkid from tbl_link where linkName = 'EditBidding Form'),'1');

insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) 
values('EditBidding Info ','tender','/eBid/Bid/GetFormInfo','EditBidding Info');
insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkid from tbl_link where linkName = 'EditBidding Form'),'1');

insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) 
values('Publish Bidding form Info ','tender','/eBid/Bid/PublishBiddingForm','Publish Bidding form');
insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values('259','1');



insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) 
values('EditBiddingForm Table Structure  ','tender','/eBid/Bid/GetTableStructure','EditBiddingForm Table Structure');

insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkid from tbl_link where linkName = 'EditBiddingForm Table Structure'),'1');



insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) 
values('Fill BiddingForm  ','tender','/eBid/Bid/FillBiddingForm','Fill BiddingForm ');

insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkid from tbl_link where linkName = 'Fill BiddingForm'),'1');



insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) 
values('Get Formula Column','tender','/eBid/Bid/GetFormulaColumns','Get Formula Column');

insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkid from tbl_link where linkName = 'Get Formula Column'),'1');


insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) 
values('Save Evaluation Column','tender','/eBid/Bid/saveEvaluationColumn','Save Evaluation Column');

insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkid from tbl_link where linkName = 'Save Evaluation Column'),'1');



insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) 
values('Get Evaluation Column','tender','/eBid/Bid/getEvaluationColumn','Get Evaluation Column');

insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkid from tbl_link where linkName = 'Get Evaluation Column'),'1');



insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) 
values('Save Formula','tender','/eBid/Bid/SaveFormula','Save Formula');

insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkid from tbl_link where linkName = 'Save Formula'),'1');



insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) 
values('Edit Document Form','tender','/eBid/Bid/EditDocumentForm','Edit Document Form ');

insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkid from tbl_link where linkName = 'Edit Document Form'),'1');







insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) 
values('Update Document Form','tender','/eBid/Bid/UpdateDocumentform','Update Document Form');



insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkid from tbl_link where linkName = 'Update Document Form'),'1');



insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) 
values('Delect Form Document','tender','/eBid/Bid/deleteFormDocument','Delect Form Document');

insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkid from tbl_link where linkName = 'Delect Form Document'),'1');





insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) 
values('Edit Evaluation Column','tender','/eBid/Bid/EditEvaluationColumn','Edit evaluation Column ');

insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkid from tbl_link where linkName = 'Edit Evaluation Column'),'1');



insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) 
values('Update Evaluation Column','tender','/eBid/Bid/UpdateEvaluationColumn','Update Evaluation Column');

insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkid from tbl_link where linkName = 'Update Evaluation Column'),'1');



insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) 
values('Delete Evaluation Column','tender','/eBid/Bid/deleteEvaluationColumn','Delete Evaluation Column');

insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkid from tbl_link where linkName = 'Delete Evaluation Column'),'1');



insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) 
values('Remove Form Formula','tender','/eBid/Bid/RemoveFormula','Remove Form Formula');

insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkid from tbl_link where linkName = 'Remove Form Formula'),'1');





