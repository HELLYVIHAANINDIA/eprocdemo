alter table tbl_tender add isRebateApplicable int default 0;
update tbl_tender set  isRebateApplicable = 0;

insert into `tbl_fildnamemapping`(`labelname`,`displayproperty`)values('isRebateApplicable','field_rebate');

insert into `tbl_link` (`linkName`, `module`, `link`, `description`) values('submit publish tender','tender','/etender/buyer/submitPublishtender','publish tender');

INSERT INTO `tbl_rolelinkmapping`(`linkId`, `roleId`)VALUES((SELECT linkId FROM tbl_link WHERE linkname='submit publish tender'),1);