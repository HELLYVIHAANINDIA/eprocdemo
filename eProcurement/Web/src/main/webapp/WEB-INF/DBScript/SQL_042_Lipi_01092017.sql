update tbl_commonlisting set fromclause='from tbl_tender WHERE cstatus = 1  AND submissionStartDate<UTC_TIMESTAMP and submissionEndDate>UTC_TIMESTAMP' where listingid = 10;

update tbl_commonlisting set fromclause='from tbl_tender where cstatus = 1 and submissionEndDate<UTC_TIMESTAMP' where listingid = 13;

update tbl_commonlisting set fromclause='from tbl_tender where cstatus = 1 and submissionStartDate>UTC_TIMESTAMP' where listingid = 14;