insert into `tbl_link`(`linkName`,`module`,`link`,`description`)values('addEditMarquee','common','/common/addEditMarquee','Marquee');

insert into tbl_rolelinkmapping (linkid,roleId) values ((select linkId from tbl_link where linkname = 'addEditMarquee'),1);


CREATE TABLE `tbl_marquee` (
  `marqueeId` int(11) NOT NULL auto_increment,
  `startDate` datetime default NULL,
  `endDate` datetime default NULL,
  `marqueeText` varchar(5000) default NULL,
  `createdOn` datetime default NULL,
  `createdBy` int(11) default NULL,
  `isActive` int(11) default '1',
  PRIMARY KEY  (`marqueeId`)
);

 insert into `tbl_link`(`linkName`,`module`,`link`,`description`)values('submit marquee','common','/common/submitMarquee','Marquee');

insert into tbl_rolelinkmapping (linkid,roleId) values ((select linkId from tbl_link where linkname = 'submit marquee'),1);


insert into `tbl_link`(`linkName`,`module`,`link`,`description`)values('view marquee','common','/common/viewMarquee','Marquee');

insert into tbl_rolelinkmapping (linkid,roleId) values ((select linkId from tbl_link where linkname = 'view marquee'),1);


insert into `tbl_link`(`linkName`,`module`,`link`,`description`)values('remove marquee','common','/common/removeMarquee','Marquee');

insert into tbl_rolelinkmapping (linkid,roleId) values ((select linkId from tbl_link where linkname = 'remove marquee'),1);
