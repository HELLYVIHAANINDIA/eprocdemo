insert into `tbl_link`(`linkName`,`module`,`link`,`description`)values('List Document','document','/etender/buyer/getDocumentList','List Document');
insert into tbl_rolelinkmapping (linkId,roleId) values ((select linkId from tbl_link where linkname='List Document'),1 );
