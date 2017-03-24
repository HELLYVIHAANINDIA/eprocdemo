
insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) values('delete corrigendum','etender','/etender/buyer/deletecorrigendum','Delete corrigendum');
insert into tbl_rolelinkmapping (linkId,roleId) values ((select linkId from tbl_link where link='/etender/buyer/deletecorrigendum'),1 );
alter table `eauctiontender`.`tbl_auditlog` change `AUDIT_LOG_ID` `AUDIT_LOG_ID` bigint(20) NOT NULL AUTO_INCREMENT, add primary key(`AUDIT_LOG_ID`);