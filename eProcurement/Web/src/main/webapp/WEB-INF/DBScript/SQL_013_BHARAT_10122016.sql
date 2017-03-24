
insert into `tbl_link`(`linkId`,`linkName`,`module`,`link`,`description`)values('118','Submit workflow','workflow','/etender/buyer/addworkflow','Submit workflow');
insert into tbl_rolelinkmapping (linkid,roleId) values ((select linkid from tbl_link where linkname  ='Submit workflow'),1);