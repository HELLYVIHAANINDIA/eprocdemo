alter table tbl_marquee add column marqueeTo integer default 0;
alter table tbl_marquee add column processId integer default 0;
alter table `eauctiontender`.`tbl_process` add column `processText` varchar(300) NULL after `tableName`;
insert into tbl_process (processId,processText) values (5,'Workflow is assign to you for (Event {tenderId} , Event ref No {tenderNo}).');
insert into tbl_process (processId,processText) values (6,'You are attached as committte member for (Event {tenderId} , Event ref No {tenderNo}) for {committeeType} committee.');
insert into tbl_process (processId,processText) values (7,'There is new corrigendum is float for (Event {tenderId} , Event ref No {tenderNo}).');
update `tbl_process` set `processId`='2',`isActive`='1',`processName`='tendercurrency',`tableName`='tbl_TenderCurrency',`processText`=NULL where `processId`='2';


/*[12:41:26 AM][  78 ms]*/ update `tbl_process` set `processId`='3',`isActive`='1',`processName`='tenderevnolope',`tableName`='tbl_TenderEnvelope',`processText`=NULL where `processId`='3';
/*[12:41:27 AM][  78 ms]*/ update `tbl_process` set `processId`='4',`isActive`='1',`processName`='tenderform',`tableName`='tbl_TenderForm',`processText`=NULL where `processId`='4';
/*[12:41:27 AM][  78 ms]*/ update `tbl_process` set `processId`='5',`isActive`='1',`processName`=NULL,`tableName`=NULL,`processText`='Workflow is assign to you for (Event {tenderId} , Event ref No {tenderNo}).' where `processId`='5';
/*[12:41:28 AM][  63 ms]*/ update `tbl_process` set `processId`='6',`isActive`='1',`processName`=NULL,`tableName`=NULL,`processText`='You are attached as committte member for (Event {tenderId} , Event ref No {tenderNo}) for {committeeType} committee.' where `processId`='6';
/*[12:41:30 AM][  62 ms]*/ update `tbl_process` set `processId`='7',`isActive`='1',`processName`=NULL,`tableName`=NULL,`processText`='There is new corrigendum is float for (Event {tenderId} , Event ref No {tenderNo}).' where `processId`='7';
/*[12:41:38 AM][  63 ms]*/ update `tbl_process` set `processId`='5',`isActive`='1',`processName`='Workflow notification',`tableName`=NULL,`processText`='Workflow is assign to you for (Event {tenderId} , Event ref No {tenderNo}).' where `processId`='5';
/*[12:41:45 AM][  78 ms]*/ update `tbl_process` set `processId`='6',`isActive`='1',`processName`='Committee Notification',`tableName`=NULL,`processText`='You are attached as committte member for (Event {tenderId} , Event ref No {tenderNo}) for {committeeType} committee.' where `processId`='6';
insert into tbl_process (processId,processName,isActive) values (8,'Open Notification',1);
update tbl_marquee set processId = 8;
alter table tbl_marquee add constraint fk_tbl_process foreign key (processId) references Tbl_process (processId);

insert into `tbl_link`(`linkId`,`linkName`,`module`,`link`,`description`)values(NULL,'Notification List','common','/common/user/notificationTab','Notification List');
insert into tbl_rolelinkmapping (linkid,roleId) (select linkid,1 from tbl_link where linkname ='Notification List') ;
insert into tbl_rolelinkmapping (linkid,roleId) (select linkid,5 from tbl_link where linkname ='Notification List') ;
insert into `tbl_commonlisting`(`listingId`,`actionItem`,`columnName`,`commonAction`,`discription`,`fromClause`,`isHQL`,`status`,`srnocol`) 
values(39,'','marqueeId:marqueeId:0~convert_tz(startDate$utcTimeZone$userTimeZone) as startDate:Notificaiton Date:1~marqueeText:Notification:1~p.processName:Notification For:1',NULL,'Notification List','from tbl_marquee m ,tbl_process p where p.processId=m.processId and p.processId<>8',NULL,'1','1');


