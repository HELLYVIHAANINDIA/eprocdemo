UPDATE `eauctiontender`.`tbl_envelope` SET `isActive`='0' WHERE  `envId`=2;
UPDATE `eauctiontender`.`tbl_envelope` SET `isActive`='1', `lang1`='Emd & Document Fee' WHERE  `envId`=1;
alter table `eauctiontender`.`tbl_tender` change `preBidMode` `preBidMode` int(11) default '2' NOT NULL;
update tbl_tender set preBidMode = 2;