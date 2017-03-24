update tbl_tender set DocFeePaymentMode=2;
update tbl_tender set SecFeePaymentMode=2;
update tbl_tender set EmdPaymentMode=2;

update tbl_commonlisting set commonAction = null where listingid = 1;



insert into tbl_link (linkName,module,link,description)
 values ('Submit Publish Corrigendum','tender','/etender/buyer/publishcorrigendum','Submit Publish Corrigendum')



insert into tbl_rolelinkmapping (linkid,roleid) values ((select  linkid from tbl_link where link = '/etender/buyer/publishcorrigendum'),1)
 