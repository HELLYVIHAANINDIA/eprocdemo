INSERT INTO `eauctiontender`.`tbl_roles` (`roleName`) VALUES ('Admin');
insert into tbl_rolelinkmapping (linkid, roleid) select linkid,6 from tbl_link;