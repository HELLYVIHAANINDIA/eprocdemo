insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) values('get organization','common','/common/user/getorganization','get organization');
insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) values('add organization','common','/common/user/addOrganization','add organization');
insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) values('edit organization','common','/common/user/editOrganization','edit organization');
insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) values('get edit organization','common','/common/user/geteditorganization/','get edit organization');
insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) values('get location department','common','/common/user/getlocationdepartment','get location department');
insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) values('add location department','common','/common/user/addlocationdepartment','add location department');
insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) values('edit location department','common','/common/user/editlocationdepartment','edit location department');
insert into `tbl_link` ( `linkName`, `module`, `link`, `description`) values('get edit location departm','common','/common/user/geteditlocationdepartment/','get edit location department');



insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkId from tbl_link where link='/common/user/getorganization'),'1');
insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkId from tbl_link where link='/common/user/addOrganization'),'1');
insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkId from tbl_link where link='/common/user/editOrganization'),'1');
insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkId from tbl_link where link='/common/user/geteditorganization/'),'1');
insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkId from tbl_link where link='/common/user/getlocationdepartment'),'1');
insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkId from tbl_link where link='/common/user/addlocationdepartment'),'1');
insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkId from tbl_link where link='/common/user/editlocationdepartment'),'1');
insert into `tbl_rolelinkmapping` ( `linkId`, `roleId`) values((select linkId from tbl_link where link='/common/user/geteditlocationdepartment/'),'1');