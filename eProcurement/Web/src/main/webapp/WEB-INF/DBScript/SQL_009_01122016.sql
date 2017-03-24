USE `eauctiontender`;

ALTER TABLE `tbl_bidderapprovaldetail` CHANGE `createdOn` `createdOn` DATEtime DEFAULT CURRENT_TIMESTAMP; 

ALTER TABLE `tbl_FinalSubmission` CHANGE `finalSubmissionId` `finalSubmissionId` int AUTO_INCREMENT; 

ALTER TABLE `tbl_tenderopen` CHANGE `createdOn` `createdOn` DATEtime DEFAULT CURRENT_TIMESTAMP; 