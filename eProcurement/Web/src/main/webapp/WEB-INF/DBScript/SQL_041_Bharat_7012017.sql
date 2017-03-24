update tbl_commonlisting set columnname = replace (columnname,',','~');
alter table `eauctiontender`.`tbl_commonlisting` change `columnName` `columnName` text NULL ;

update tbl_commonlisting set columnName = replace(columnName,'tenderId:Event Id.:1~tenderNo:Tender No.:1','tenderId:Event Id.:1~(select concat(case when grandparentdeptId <> 0 then(select d1.deptName from tbl_department d1 where d1.deptId=tbldept.grandparentdeptId) else '''' end ,case when parentdeptId <> 0 then (select concat(''/'',d2.deptName) from tbl_department d2 where d2.deptId=tbldept.parentdeptId) else ''''  end ,(select concat(''/'',d3.deptName) from tbl_department d3 where d3.deptId=tbldept.deptId)) from tbl_department tbldept where tbldept.deptId = tbl_tender.departmentId) as deptName:Department Name:1~tenderNo:Tender No.:1') 
 where columnName like 'tenderId:Event Id.:1~tenderNo:Tender No.:1%';
