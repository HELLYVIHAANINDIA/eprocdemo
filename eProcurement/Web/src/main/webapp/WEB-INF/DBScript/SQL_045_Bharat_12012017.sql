alter table `eauctiontender`.`tbl_marquee` add column `tenderId` int DEFAULT '0' NULL after `isActive`;
update tbl_marquee set tenderId = 0;