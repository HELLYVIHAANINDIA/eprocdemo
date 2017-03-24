DROP TABLE IF EXISTS `tbl_fildnamemapping`;

CREATE TABLE `tbl_fildnamemapping` (
  `fieldid` int(11) NOT NULL auto_increment,
  `labelname` varchar(100) default NULL,
  `displayproperty` varchar(100) default NULL,
  PRIMARY KEY  (`fieldid`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=latin1;

/*Data for the table `tbl_fildnamemapping` */

insert  into `tbl_fildnamemapping`(`fieldid`,`labelname`,`displayproperty`) values (1,'officerName','fields_tender_departmentofficial'),(2,'departmentName','label_tender_department'),(3,'tenderId','fields_tenderid'),(4,'tenderNo','fields_refenceno'),(5,'tenderBrief','field_brief'),(6,'tenderDetail','field_tender_detail'),(7,'keywordText','fields_tender_keywords'),(8,'envolopeName','lbl_envelope'),(9,'procurementNature','lbl_type_of_contract'),(10,'projectDuration','lbl_projectduration'),(11,'downloadDocument','lbl_downloaddocument'),(12,'isItemwiseWinner','lbl_itemwise_lh'),(13,'eachLineItem','lbl_each_line_item'),(14,'grandTotal','lbl_grandtotalwise_item'),(15,'tenderMode','lbl_bidding_access'),(16,'isConsortiumAllowed','lbl_consortium'),(17,'submissionMode','lbl_mode_of_submission'),(18,'notAllowd','lbl_notallowed'),(19,'allowed','lbl_allowed'),(20,'isBidWithdrawal','lbl_bidwithdrawal'),(21,'biddingVariant','lbl_bidding_variant'),(22,'autoResultSharing','lbl_auto_result_sharing'),(23,'auto','lbl_auto'),(24,'manual','lbl_manual'),(25,'open','lbl_open'),(26,'buy','lbl_buy'),(27,'sell','lbl_sell'),(28,'isPreBidMeeting','lbl_prebid_meeting'),(29,'limited','lbl_limited'),(30,'proprietary','lbl_proprietary'),(31,'single','lbl_single'),(32,'validityPeriod','lbl_bid_validity_period'),(33,'nomination','lbl_nomination'),(34,'prebidMode','lbl_modeof_prebid_meeting'),(35,'isWorkflowRequire','lbl_workflow_requires'),(36,'preBidAddress','lbl_prebid_address'),(37,'biddingType','lbl_biddingType'),(38,'nationalCurrency','lbl_national_competitive_bidding'),(39,'internationalCurrency','lbl_international_competitive_bidding'),(40,'baseCurrency','lbl_base_currency'),(41,'workflowType','lbl_workflow_type'),(42,'isQuestionAnswer','lbl_question_answer'),(43,'documentStartDate','lbl_document_start_date'),(44,'submissionStartDate','lbl_bid_submission_start_date'),(45,'submissionEndDate','lbl_bid_submission_end_date'),(46,'documentEndDate','lbl_document_end_date'),(47,'yes','label_yes'),(48,'no','label_no'),(49,'submit','label_submit'),(50,'docfee','title_doc_emd_secfees'),(51,'isDocfeesApplicable','lbl_document_fees'),(52,'isSecurityfeesApplicable','lbl_security_fee'),(53,'isEMDApplicable','lbl_emd_fee'),(54,'bidSub','title_bid_submission_conf'),(55,'fieldBaseVurrency','fields_basecurrency'),(56,'online','lbl_online'),(57,'offline','lbl_offline'),(58,'both','lbl_both'),(59,'isDocfeesApplicable','fields_fees_amt'),(60,'isDocfeesAddress','field_docfees_payableat'),(61,'docFeePaymentMode','lbl_security_paymentMode'),(62,'securityFee','field_tendersec_fees_amt'),(63,'secFeePaymentAddress','field_tendersec_fee_payment_at'),(64,'emdPaymentMode','lbl_emd_paymentMode'),(65,'emdAmount','field_emdamt'),(66,'emdPaymentAddress','field_emdpaymentat'),(67,'registrationChargesMode','lbl_reg_paymentMode'),(68,'registrationCharges','lbl_tender_registration_charges'),(69,'openingDate','field_bidopeningstartdate'),(70,'tenderValue','lbl_tender_value'),(71,'preBidStartDate','field_bidsubmissionenddate'),(72,'preBidEndDate','fields_prebidmeet_enddate'),(73,'questionAnswerEndDate','field_queans_enddate'),(74,'questionAnswerStartDate','field_queans_startdate'),(75,'submissionEndDate','field_bidsubmissionenddate'),(76,'preBidStartDate','fields_prebidmeet_startdate'),(77,'preBidEndDate','fields_prebidmeet_enddate'),(78,'openingDate','field_bidopeningstartdate'),(79,'docFeePaymentAddress','field_docfees_payableat'),(80,'documentFee','fields_fees_amt'),(81,'securityFee','field_tendersec_fees_amt'),(82,'secFeePaymentAddress','field_tendersec_fee_payment_at'),(83,'emdPaymentAddress','field_emdpaymentat'),(84,'registrationCharges','fields_regfees_amt');


insert into tbl_link (linkid,linkname,module,link,description) values
 (100,'Corrigendum Dashboard','tender','/etender/buyer/corrigendumdashboard','Corrigendum Dashboard')
,(101,'View Corrigendum','tender','/etender/buyer/viewcorrigendum','View Corrigendum')
,(102,'Publish Corrigendum','tender','/etender/buyer/showpublishcorrigendum','Publish Corrigendum');
insert into `tbl_rolelinkmapping`(`rolelinkmapId`,`linkId`,`roleId`)values(100,'100','1')
,(101,'101','1')
,(102,'102','1');
