alter table `eauctiontender`.`tbl_tenderworkflow` add column `corrigendumId` int default 0 after `ModifiedDate`;
update tbl_tenderworkflow set corrigendumId = 0;