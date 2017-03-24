
DROP TABLE IF EXISTS `tbl_tederworkflow`;

CREATE TABLE `tbl_tenderworkflow` (
  `workflowId` int(11) NOT NULL auto_increment,
  `action` int(11) default NULL,
  `remarks` varchar(5000) default NULL,
  `officerId` bigint(11) default NULL,
  `tenderId` int(11) default NULL,
  `parentWorkflowId` int(11) default NULL,
  `cstatus` int(11) default NULL,
  `createdById` int(11) default NULL,
  `createdbyName` varchar(50) default NULL,
  `modifiedById` int(11) default NULL,
  `modifiedByName` varchar(50) default NULL,
  `createdDate` datetime default NULL,
  `ModifiedDate` datetime default NULL,
  PRIMARY KEY  (`workflowId`),
  KEY `FK_tbl_tederworkflow` (`tenderId`),
  KEY `FK_tbl_tederworkflow_officer` (`officerId`),
  CONSTRAINT `FK_tbl_tederworkflow` FOREIGN KEY (`tenderId`) REFERENCES `tbl_tender` (`tenderId`),
  CONSTRAINT `FK_tbl_tederworkflow_officer` FOREIGN KEY (`officerId`) REFERENCES `tbl_officer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


insert into `tbl_link`(`linkName`,`module`,`link`,`description`)values('workflow','tender','/eProcurement/etender/buyer/tenderworkflow','workflow');

insert into tbl_rolelinkmapping (linkid,roleid) values((select linkid from tbl_link where linkName = 'workflow'),1);


update tbl_process set isActive = 1;

alter table `eauctiontender`.`tbl_tendercurrency` change `bidCurrencyId` `bidCurrencyId` int(11) NULL ;