<!DOCTYPE html>
<html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
	<%@include file="../../includes/header.jsp"%>
	<script src="${pageContext.request.contextPath}/resources/js/tender/tendercreate.js"></script>
	<script src="${pageContext.servletContext.contextPath}/resources/js/jQuery/jquery.datetimepicker.js"></script>
	<script src="${pageContext.servletContext.contextPath}/resources/js/blockUI.js" type="text/javascript"></script>
	<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/resources/css/jquery.datetimepicker.css">
	<spring:message code="client_dateformate_hhmm" var="client_dateformate_hhmm"/>
	<spring:message code="field_rebate" var="field_rebate"/>
	<spring:message code="lbl_notallowed" var="notallowed"/>
	<spring:message code="lbl_allowed" var="allowed"/>
	<spring:message code="label_online" var="online"/>
	<spring:message code="label_offline" var="offline"/>
	
	
	<%-- <script src="${pageContext.request.contextPath}/resources/js/ckeditor.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/config.js"></script>
	 --%>
<%-- 	 <script src="${pageContext.servletContext.contextPath}/resources/js/jquery-ui.min.js"></script> --%>
	
	<style type="text/css">
            /* CSS for Autocomplete functionality of Keywords */

            .divResult
            {
                position:absolute;
                /* background-color:#FFFFFF; */
                border-style:none;
                border-width:1px;
                border-color:#999999;
                /* padding:10px; */
                margin:0 auto;
                width:403px;
                text-align:left;
                display:none;
                margin-top:-9px;
            }
            .divResult select
            {	
            	border:1px solid #279CE7;
            	border-top:0;
            	padding:0px 0 0 7px;
           	}
           	.divResult select option
			   {
			   		line-height: 20px;
			  	}
           	 @-moz-document url-prefix() { 
			   .divResult
			   {
			   		width:399px;
			   }
			   .divResult select option
			   {
			   		padding:2px;
			  	}
			}
			@media screen and (-webkit-min-device-pixel-ratio:0) {
			.divResult
			   {
			   		width:399px;
			   		margin-top:-12px;
			   }
			}
            .txtResult
            {
                display:block;
                width:300px;
                height:60px;
                /* padding:5px;
                margin:5px; */
                color:#555555;
                font: 14pt tahoma;
                text-decoration:none;
            }
            .loading
            {
                font: 10pt tahoma;
                text-align:center;
            }
            .record
            {
            }

            /* option.keyword_option:hover { background-color: white; border: 10px solid red !important; } */
        </style>
        <script type="text/javascript">
            var sel="";
            var wysihtml5Editor = "";
            var nodedata="";
            var map=new Array();
            var hideMap=new Array();
            var contextPath="/eProcuremenet";
            var wordConversionFormat='0';
            
            var baseCurrency="0"; 
            var deptValidate='Please select parent department';
            var varformvalidate='Price Bid envelope and Techno Commercial envelope cannot be selected together, please select any one of them';
            var varformvalidatewithtechnicalenv = 'Technical Envelope and Techno-Commercial envelope cannot be selected together, please select any one of them';
            var varmultiformvalidate='For multistage evaluation multiple envelope selection is mandatory.';
            var isCategoryAllow='0';
            var brdMode='0';
            var isDRT='false';
            var isBank='false';            
            var isSarfaesi='false';
            var varFormType;
            var varConfirmRmvEnvelop="On removing envelop, bidding form(s) and committee member(s) mapped in selected envelop will be removed. Are you sure you want to proceed further?";
            var msg_mode_of_payment_for_document = "If download document is configured after payment, its mandatory to configure document fees as allow and set mode of payment as Online"; 
            var msg_consortium_nt_applicable_for_price_bid_env = "Consortium cannot be applicable for Price bid envelope";
            var zero = '';
            var one = '1';
            var cstatus = 0;
            var parentDeptId = '${parentDeptId}';
            var parentDeptJson = '${parentDeptJson}';
            var subDeptId = '${subDeptId}';
            var subDeptJson = '${subDeptJson}';
            var organization= '${organization}';
            var parentDeptName = '${parentDeptName}';
            var tenderDeptId='${tenderDeptId}';
            var tenderOfficerId='${tenderOfficerId}';
            var tenderOfficer='${tenderOfficer}';
            var officerId='${officerId}';
            var officerName='${officerName}';
            var subDeptName='${subDeptName}';
            
//             function getSubDepartments() {
//             	$.blockUI({message: '<h4><img src="http://s13.postimg.org/80vkv0coz/image.gif" /> Please Wait...</h4>'});
//             			var data = {};
//             			var searchValue;
//             			if(parentDeptId!=0){
//             				searchValue = parentDeptId+"@@1";
//             			}else{
//             				searchValue = $("#selDepartment").val()+"@@1";	
//             			}
                    	
//                     	$.ajax({
//                     		type : "POST",
//                     		contentType : "application/json",
//                     		url : "${pageContext.servletContext.contextPath}/common/user/getsubdepartments/"+searchValue,
//                     		data : data,
//                     		timeout : 100000,
//                     		success : function(data) {
//                     			var obj = jQuery.parseJSON(data);
//                     			$('#subDept').html('');
//                     		     $.each(obj, function (key, value) {
//                     		    $('#subDept').append($('<option>',
//                     		    		 {
//                     		    		    value: value.value,
//                     		    		    text : value.label
//                     		    		}));
//                     		     });
//                     		     $('select[id="subDept"] option:selected').attr("selected",null);
//                  	   	     	 $('select[id="subDept"] option[value="-1"]').attr("selected","selected");
//                     		     if(subDeptId==0){
//                     		    	 $("#subDept").val("-1");	 
//                     		     }else{
//                     		    	 $("#subDept").val(subDeptId);
//                     		     }
                    		     
//                     			console.log("SUCCESS: ", data);
//                     			$.unblockUI({});
//                     		},
//                     		error : function(e) {
//                     			console.log("ERROR: ", e);
//                     			$.unblockUI({});
//                     		},
//                     		done : function(e) {
//                     			console.log("DONE");
//                     			$.unblockUI({});
//                     		}
//                     	});
//                     	return true;
//             }
            
//             function getOfficerList() {
//             	var data = {};
//             	var keyword = $("#selSearch").val();
//             	var grandParentDept = '${grandParentDeptId}';
//             	var searchValue = "";
//             		var parentDept;
//             		var subDept;
//             			parentDept=$('#selDepartment').val();
//             			subDept=$('#subDept').val();
//             			if(parentDept==undefined){
//             				parentDept="-1";
//             			}
//             			if(subDept==undefined){
//             				subDept="-1";
//             			}
            				
//             		if(parentDept>0 && subDept=='-1'){
//             			searchValue = parentDept;
//             			keyword="deptId";	
//             		}else if(parentDept>0 && subDept>0){
//             			searchValue = subDept;
//             			keyword="deptId";	
//             		}else if(parentDept=='-1' && subDept=='-1'){
//             			searchValue = grandParentDept;
//             			keyword="deptId";	
//             		}else if(parentDept=='-1' && subDept>0){
//             			searchValue = subDept;
//             			keyword="deptId";	
//             		}
            	
//             	$.ajax({
//             		type : "POST",
//             		contentType : "application/json",
//             		url : "${pageContext.servletContext.contextPath}/etender/buyer/officers/"+searchValue+"/"+keyword,
//             		data : data,
//             		timeout : 100000,
//             		success : function(data) {
//             			console.log("SUCCESS: ", data);
//             			var obj = jQuery.parseJSON(data);
//             			$('#selName').html('');
//             		     $.each(obj, function (key, value) {
//             		    var c = value.value.split('@@')[4];
//             		    $('#selName').append($('<option>',
//             		    		 {
//             		    		    value: c,
//             		    		    text : value.label
//             		    		}));
//             		     });
            		     
//             		     if(tenderOfficer>0){
//             		    	 $('select[id="selName"] option:selected').attr("selected",null);
//              	     		$('select[id="selName"] option[value="'+tenderOfficer+'"]').attr("selected","selected");	 
//             		     }
//             		},
//             		error : function(e) {
//             			console.log("ERROR: ", e);
//             		},
//             		done : function(e) {
//             			console.log("DONE");
//             		}
//             	});
//             }
            
            
            
           /*  function GetCal(txtname, controlname, datetype) {
            	$("#"+txtname).datepicker();
            	return true;	
            	if (datetype == 'datetime') {
                    var date;
                    new Calendar({
                        inputField : txtname,
                        trigger : controlname,
                        dateFormat : DATETIMEFORMATE_CALENDAR,
                        showTime : true,
                        onSelect : function() {
                            date = this.selection.get()
                            date = Calendar.intToDate(date);
                            date = Calendar.printDate(date, DATETIMEFORMATE_CALENDAR);
                            this.hide();
                            if (txtname == 'txtdob') {
                                RndEndDt();
                            }
                            document.getElementById(txtname).focus();
                        }
                    });
                } else {
                    new Calendar({
                        inputField : txtname,
                        trigger : controlname,
                        showTime : false,
                        dateFormat : DATEFORMATE_CALENDAR,
                        onSelect : function() {
                            var date = Calendar.intToDate(this.selection.get());
                            LEFT_CAL.args.min = date;
                            LEFT_CAL.redraw();
                            this.hide();
                        }
                    });
                }
                var LEFT_CAL = Calendar.setup({
                    weekNumbers : false
                })
            } */
            
            function GetCal(txtname, controlname, datetype) {
            	 
            }

        var dateFieldObject = new Object();
            
            	/* if($('#tdPrequalificationShow').html() == undefined && $('#tdTenderSectorShow').html() == undefined && $('#tdFormContractShow').html() == undefined && $('#tdProductIdShow').html() == undefined){
            		if('false' =='true' && 'false' == 'true'){
            			$('#trShowCpppMsg').show();
                		$('#trShowCpppHeader').show();
                		$('#divShowCpppHeader').show();
            		}else{
            			$('#trShowCpppMsg').hide();
            			$('#trShowCpppHeader').hide();
            			$('#divShowCpppHeader').hide();
            		}
            	} */
            	/* if($('#tdPrequalificationShow').html() == undefined && $('#tdTenderSectorShow').html() == undefined && $('#tdFormContractShow').html() == undefined && $('#tdProductIdShow').html() == undefined && $('#tdPrequalificationHide').html() == undefined && $('#tdTenderSectorHide').html() == undefined && $('#tdFormContractHide').html() == undefined && $('#tdProductIdHide').html() == undefined){
            		if('false' =='true' && 'false' == 'true'){
            			$('#trShowCpppMsg').show();
                		$('#trShowCpppHeader').show();
                		$('#divShowCpppHeader').show();
            		}else{
            			$('#trShowCpppMsg').hide();
            			$('#trShowCpppHeader').hide();
            			$('#divShowCpppHeader').hide();
            		}
            	} */
            	
            	
                
                var isDisp="true";
                if(isDisp == "true"){
                    map['isPastEvent']="1";
                }else{
                    map['isPastEvent']="";
                }
                isDisp="true";
                if(isDisp){
                    map['procurementNatureId']="1";
                }else{
                    map['procurementNatureId']="";
                }
                var indentNoticeData = "";
                if(indentNoticeData != null && indentNoticeData != ""){
                	map['procurementNature']='';
                }else{
                	map['procurementNature']='1';                	
                }
                isDisp="false";
                hideMap['documentSubmission']=isDisp;
                isDisp="true";
                hideMap['preBidMode']=isDisp;
                isDisp="true";
                hideMap['preBidAddress']=isDisp;
                isDisp="false";
                hideMap['docFeePaymentMode']=isDisp;
                isDisp="false";
                hideMap['secFeePaymentMode']=isDisp;
                isDisp="false";
                hideMap['isEMDApplicable']=isDisp;
                isDisp="false";
                hideMap['submissionStartDate']=isDisp;
                isDisp="false";
                hideMap['documentStartDate']=isDisp;
                isDisp="false";
                hideMap['isDocfeesApplicable']=isDisp;
                isDisp="false";
                hideMap['isRegistrationCharges']=isDisp;
                isDisp="false";
                hideMap['registrationChargesMode']=isDisp;
              //  formLoadData();
                
                $('.combo-text').attr('placeholder','-- ${label_select} --');
                var deptJson;
           // $.ajax({type: "POST",url: "/eProcurement/common/admin/ajaxgetdeptlist",data : "hdFullTree="+$('#hdIsFullTree').val()+"&hdDeptId="+$('#hdDeptId').val(),async: false,success: function(j){if($.trim(j.toString())=="sessionexpired"){window.location.href="/eProcurement/sessionexpired";}else{deptJson = j;}}});
             //       $('#txtParentDepartment').combotree('loadData',deptJson);
                    var indentNoticeData = "";
                    if(indentNoticeData != null && indentNoticeData != ""){
                    	sel="" ;// only in form indent case
                    }else{
                    	sel="0" ;// only in edit case
                    }
                   /*  $('#txtParentDepartment').combotree({ onSelect: function (node) {
                            $("#deptTd").find('.placeholder').html('');
                            $("#selDeptOfficial").val("");
                            $("#errSpanParentDepartmentMsg").text("");
                            $("#txtParentDeptId").val(node["id"]);
                            nodedata=node["id"];
                            getDepartmentOfficer(node["id"]);
                        }
                    }); */
                    if(sel!=0 &&  sel != null && sel != "" && sel != undefined){
                        $('#txtParentDepartment').combotree('setValue', sel);
                    }
                    //$('li').tsort('span.tree-title');
                  
                    var infoTargetId='';
       	         	$("body").click(function(e) {
                           var clickedId = e.target.id;
                           if(clickedId.split("_")[1]!=undefined){
                               clickedId = "#pop_"+clickedId.split("_")[1];
                           }
                           else{
                               clickedId ='';
                           }
                           var targetId = infoTargetId;
                              if(clickedId != targetId){
                                   $(targetId).hide();    
                              }
                       });
       	      $('img.popper').click(function(e) {
                   $('.popbox').hide();
                   var targetId = '#' + ($(this).attr('data-popbox'));  
                   infoTargetId = targetId;
                   $(targetId).show();
               });
                       
       	   
       	   //CKEDITOR.replace('rtfTenderDetail');
/* 	       	   $('.dateBox').datepicker({
	       	      autoclose: true
	       	    });
 */	       	   $(document).ready(function(){
	 
     $('#organization').html(organization);
     $('#parentDeptName').html(parentDeptName);
     $('#subDeptName').html(subDeptName);
     $('#officerName').html(officerName);
     
//      if(parentDeptJson!=''){
//      		var obj = jQuery.parseJSON(parentDeptJson);
// 	     	$('#selDepartment').html('');
// 	     	$.each(obj, function (key, value) {
// 	    	$('#selDepartment').append($('<option>',
// 	    		 {
// 	    		    value: value.value,
// 	    		    text : value.label
// 	    		}));
// 	    	 });
	     	
// 	     	if(parentDeptId==0){
// 	    		$('select[id="selDepartment"] option:selected').attr("selected",null);
// 	   	     	$('select[id="selDepartment"] option[value="-1"]').attr("selected","selected");
// 	    	 }else{
// 	    		$('select[id="selDepartment"] option:selected').attr("selected",null);
// 	   	     	$('select[id="selDepartment"] option[value="'+parentDeptId+'"]').attr("selected","selected");
// 	     	}
// 	     	getSubDepartments();
// 	     	$.blockUI({message: '<h4><img src="http://s13.postimg.org/80vkv0coz/image.gif" /> Please Wait...</h4>'});
//    	     	setTimeout(function() {
//    	     	getOfficerList();
//    	    	}, 3000);
//    	     	$.unblockUI({});
//   		}else{
//   			var subDeptObj = jQuery.parseJSON(subDeptJson);
// 	   	     	$('#subDept').html('');
// 		     	$.each(subDeptObj, function (key, value) {
// 		    	$('#subDept').append($('<option>',
// 		    		 {
// 		    		    value: value.value,
// 		    		    text : value.label
// 		    		}));
// 		    	 });
// 		     	if(subDeptId==0){
// 		    		$('select[id="subDept"] option:selected').attr("selected",null);
// 		   	     	$('select[id="subDept"] option[value="-1"]').attr("selected","selected");
// 		    	 }else{
// 		    		$('select[id="subDept"] option:selected').attr("selected",null);
// 		   	     	$('select[id="subDept"] option[value="'+subDeptId+'"]').attr("selected","selected");
// 		     	}
// 		     	getOfficerList();
//   			}
	 
     		
     
	       		 <c:if test="${not empty tenderDtBean}">
		       	   var tenderDtBeanJson = ${tenderDtBean}
		       	   for(var indx in tenderDtBeanJson){
		       		   var key = indx;
		       		   var value = tenderDtBeanJson[indx];
		       		   if(value == undefined){
		       			   value = "";
		       		   }
		       		   value = reverseReplaceQuotes(value+"");
		       		   value = htmlNewLineReverseReplaceQuotes(value+"");
		       		
		       		   if(key.indexOf("hd") != -1 || key.indexOf("txt") != -1 ||  key.indexOf("rtf") != -1){
		       			   $("[name='"+key+"']").val(value);
		       		   }else  if(key.indexOf("sel") != -1){
		       			if($("[name='"+key+"'] option[value='"+value+"']").length > 0){
			       			   $("[name='"+key+"']").val(value);
			       			}
			       	   }else  if(key.indexOf("txta") != -1){
		       			   $("[name='"+key+"']").html(value);
		       		   }
		       	   }
		       	   </c:if>
		       	<c:if test="${empty tenderDtBean}">
			       	$("#hdOpType").val("create")
	                opType=$("#hdOpType").val();
		       	</c:if>
		       	$(".dateBox").each(function(){
		       		$(this).datetimepicker({
		       			format:'d-M-Y H:i',
		       		});
		       	});
		       	 
		     	//$(".dateBox").datepicker();
		       	 var arr = new Array();
		       	  <c:if test="${not empty tenderEnvelopeList}">
		       	   <c:forEach items="${tenderEnvelopeList}" var="tenderENV">
		       		   var key = ${tenderENV[2]};
		       			arr.push(key);
	      			</c:forEach>
		       	 </c:if>
		       	$("[name='selFormType']").val(arr)
		       	  
		       	wysihtml5Editor = $("#rtfTenderDetail").wysihtml5(); 
		        $("#selDownloadDocument option[value='1']").attr("title",'Before Login, without document fees payment');
                $("#selDownloadDocument option[value='2']").attr("title",'After Login, without document fees payment');
                $("#selDownloadDocument option[value='3']").attr("title",'After Login, After Document Fees Payment');
                
                
                map['envelopeType']="1";
                map['BiddingType']="1";
                map['IsPreBidMeeting']="0";
                map['preBidMode']="2";
                map['isDocfeesApplicable']="0";
                map['docFeePaymentMode']= $("#selDocFeePaymentMode").val();
                map['isSecurityfeesApplicable']="1";
                map['isEMDApplicable']="1";
                map['submissionMode']="1";
                map['secFeePaymentMode']=$("#selSecFeePaymentMode").val();
                map['isEMDApplicable']=""
                map['emdPaymentMode']= $("#selEmdPaymentMode").val();
                map['isQuestionAnswer']="0";
                map['isWorkflowRequired']="1";
                map['workflowType']="3";
                map['isItemwiseWinner']=$("#selIsItemwiseWinner").val();
                map['isRegistrationCharges']="0";
                map['registrationChargesMode']=$("#selRegistrationChargesMode").val();
                
                varFormType=$('#selFormType').val();              
                opType=$("#hdOpType").val();
                formLoadData();
	       		getOtherProcNature($("#selProcurementNatureId"));
	       		getBidCurrency($("#selBiddingType"));
	       		getSecurityFeesDetail($("#selIsSecurityfeesApplicable"))
	       		getDocDetail($("#selIsDocfeesApplicable"))
	       		getEmdDetail($("#selIsEMDApplicable"));
	       		modeOfPrebidMeeting($("#selIsPreBidMeeting"))
	       		
	       		<c:forEach items="${tblTenderCurrency}" var="item">
	       			$("[name='chkCurrency'][value='${item[0]}']").prop("checked",true);
	       		</c:forEach>
	       	   });
	       	  
            
                function getDepartmentOfficer(value){
                    var comboHTML;
                    $('#selDeptOfficial').remove();
                    $.ajax({type: "POST",url: "/eProcurement/eauction/auctioneer/ajax/getdepartmentofficer",data : "isSarfaesi="+isSarfaesi+"&isDRT="+isDRT+"&isBank="+isBank+"&deptId="+value,async: false,success: function(j){if($.trim(j.toString())=="sessionexpired"){window.location.href="/eProcurement/sessionexpired";}else{comboHTML = j;}}});
                    var options = (comboHTML.indexOf('<input', 0)!=-1) ? comboHTML.substring(0, comboHTML.indexOf('<input', 0)) : comboHTML;
                    var hidden = ((comboHTML.indexOf('<input', 0)!=-1)) ? comboHTML.substring(comboHTML.indexOf('<input', 0),comboHTML.length) : '';
                    $('#selDeptOfficial').html(options);
                    $('#tdDeptOfficer').append(hidden);
                    var isedit='create';
                    if(isedit=='edit' || '' == 'error'){
                       	$("#selDeptOfficial option[value='0']").attr("selected", "selected");
                    }else if(isedit=='create' || '' == 'error'){
                    	var indentNoticeData = "";
                        if(indentNoticeData != null && indentNoticeData != ""){
                        	$("#selDeptOfficial option[value='']").attr("selected", "selected");
                        }
                    }
                } 
        </script>    
<spring:message code="label_select" var="label_select"></spring:message>
<spring:message code="lbl_projectduration" var="lbl_projectduration"/>
<spring:message code="label_yes" var="label_yes"/>
<spring:message code="label_no" var="label_no"/>
<spring:message code="field_rebate" var="field_rebate"/>
</head>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="../../includes/leftaccordion.jsp"%>

<div class="content-wrapper">

<!-- 		onsubmit="return validation();" -->
<form id="tenderDtBean" name="tenderDtBean" onsubmit="return validation();" action="${pageContext.servletContext.contextPath}/etender/buyer/addtender" method="post" >

<section class="content-header">

<h1 class="pull-left">
<c:choose>
                  <c:when test="${not empty tenderDtBean}">
                  	<spring:message code="lbl_edit_tender"/>
                  </c:when>
                  <c:otherwise>
                  	<spring:message code="lbl_create_tender"/>
                  </c:otherwise>
                  </c:choose>
</h1>

<a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderListing" class="btn btn-submit pull-right" style="margin-top:0px; margin-bottom:0px;"><< <spring:message code="lbl_back_tenderlist"/></a>
<c:if test="${not empty tenderDtBean}">
<a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}" class="btn btn-submit pull-right" style="margin-top:0px; margin-bottom:0px; margin-right:5px;"><< <spring:message code="lbl_back_dashboard"/></a>
</c:if>

</section>

<section class="content">

<div class="row">

<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
<div class="box">
<div class="box-header with-border"><h3 class="box-title">Basic details</h3>
<font size="1" class="pull-right mandatory">(<b class="red"> *</b>) Mandatory fields</font>
</div>
<div class="box-body">
<div class="row">

<div class="col-md-12"></div>

<div class="col-md-12">
<input type="hidden" id="hdIsDateValidationAllow" name="hdIsDateValidationAllow" value="2">
<input type="hidden" id="hdIndentId" name="hdIndentId" value="">
<input type="hidden" id="hdIsCategoryAllow" name="hdIsCategoryAllow" value="">
<input type="hidden" id="hdBrdMode" name="hdBrdMode" value="">
<input type="hidden" name="isPastEvent" value="0">
<input type="hidden" name="selDecimalValueUpto" value="">
</div>

<div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
<div class="ct_filed1">Organization</div>
</div>

<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
<div id="organization"></div><div class="ct_filed2"><input type="hidden" name="organization" value="${grandParentDeptId}" /></div>
</div>

<div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
<div class="ct_filed1">Department</div>
</div>

<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
<c:choose>
<c:when test="${parentDeptId gt 0}">
<div class="ct_filed2"><div id="parentDeptName"></div></div>
</c:when>
<c:otherwise>
<div>-</div>
<select style="display: none;" class="form-control" id="selDepartment" name="selDepartment"  onblur="javascript:{if(true){getSubDepartments();getOfficerList();}}" title="department">
<option value="${parentDeptId}">${label_select}</option>
</select>	
</c:otherwise>
</c:choose>
</div>
</div>

<div class="row">

<div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
<div class="ct_filed1">Sub Department</div>
</div>

<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
<c:choose>
<c:when test="${subDeptId gt 0}">
<div id="subDeptName"></div>
</c:when>
<c:otherwise>
<div>-</div>
</c:otherwise>
</c:choose>
<select style="display: none;" class="form-control" id="subDept" name="subDept"  onblur="javascript:{if(true){getOfficerList();}}" title="sub department">
<option value="${subDeptId}">${label_select}</option>
</select>
</div>

<div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
<div class="ct_filed1"><spring:message code="fields_tender_departmentofficial"/><span> *</span></div>
</div>

<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
<div id="officerName"></div>
<select class="form-control" style="display: none" id="selName" name="selDeptOfficial"  onblur="javascript:{if(true){}}" title="Department Officer">
<option value="${officerId}">${label_select}</option>
</select>
</div>

</div>

<div class="row">

<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
<div class="form-f"><spring:message code="field_eventtype" var="varEventType"/>${varEventType}<span class="rd"> *</span></div>
<select class="form-control2" isrequired="true" title="${varEventType}" name="txtEventType" id="txtEventType">
<option value="">${label_select}</option>
<c:forEach var="lstEventType" items="${eventTypeList}" > 
<option value="${lstEventType[0]}">${lstEventType[1]}</option>
</c:forEach>
</select>
</div>

<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
<div class="form-f"><spring:message code="fields_refenceno"/><span class="rd"> *</span></div>
<input id="txtTenderNo" class=" form-control " name="txtTenderNo" type="text" validarr="required@@length:0,1000" tovalid="true" onblur="validateTxtComp(this)" title="<spring:message code="fields_refenceno"/>">
</div>

</div>

<div class="row">
<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
<div class="form-f"><spring:message code="field_brief"/><span class="rd"> *</span></div>
<textarea  class=" form-control2 "  id="txtaTenderBrief" name="txtaTenderBrief" validarr="required@@length:0,1000" tovalid="true" onblur="validateTxtComp(this)" validationmsg="Allows Max. 1000 alphabets, numbers and special characters" title="<spring:message code="field_brief"/>" class="line-height" cols="20" rows="10"></textarea>
</div>
</div>

<div class="row">
<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
<div class="form-f"><spring:message code="field_tender_detail"/><span></span></div>
<textarea  class="form-control2 rtfTenderDetail"  id="rtfTenderDetail" name="rtfTenderDetail" tovalid="true"  validarr="required@@length:0,10000"  title="Details" cols="20" rows="10" >  </textarea>
</div>
</div>

<div class="row">
<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
<div class="form-f"><spring:message code="fields_tender_keywords"/><span class="rd"> *</span></div>
<textarea class=" form-control2 "  id="txtaKeyword" name="txtaKeyword" validarr="required@@length:0,1000@@commonkeyword" tovalid="true" onblur="validateTxtComp(this)" title="Product / service / work keywords" cols="10" rows="3"></textarea>
<div class="divResult" style="display: none;">
<!--<div class="loading">Loading..</div> -->
<div class="record no-border" style="height: 100px;"></div>
</div>
</div>
</div>

<div class="row">
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
<div class="form-f"><spring:message code="lbl_emvelope_type"/><span class="rd"> *</span></div>
<select class="form-control2" isrequired="true" title="Stage" name="selEnvelopeType" id="selEnvelopeType" onchange="javascript:{if(validateCombo(this)){getFormType(this)}};">
<option value="">${label_select}</option>
<option value="1" ><spring:message code="lbl_evaluation_singlestage"/> </option>
<option value="2"><spring:message code="lbl_evaluation_multiestage"/></option>
</select>
</div>
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
<div class="form-f"><spring:message code="lbl_envelope"/><span class="rd"> *</span></div>
<select class="form-control2"  name="selFormType" id="selFormType" 
onchange="javascript:{if(validateCombo(this)){getFormSelection(this)}}" 
isrequired="true" title="Envelope" size="5" multiple="">
<c:forEach items="${listTblEnv}" var="tblEnv"> 
<option value="${tblEnv.envId}">${tblEnv.lang1}</option>
</c:forEach>
</select>
<span id="errFormTypeValidation" class="red"></span>
</div>
</div>

<div class="row">
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
<div class="form-f"><spring:message code="lbl_projectduration"/><span class="rd"> *</span></div>
<input id="txtValidityPeriod" name="txtValidityPeriod" class=" form-control2 " type="text" maxlength="5"
value="0" title="<spring:message code="lbl_projectduration"/>">
</div>
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
<div class="form-f"><spring:message code="lbl_downloaddocument"/><span class="rd"> *</span></div>
<select class="form-control2"  isrequired="true" title="Download document" onchange="validateCombo(this)" 
name="selDownloadDocument" id="selDownloadDocument" class="pull-left">
<option value="">${label_select}</option>
<option value="1" title="<spring:message code="label_beforelogin"/>"><spring:message code="label_beforelogin"/></option>
<option value="2" selected="selected" title="<spring:message code="label_afterlogin"/>"><spring:message code="label_afterlogin"/></option>
<%-- <option value="3" title="<spring:message code="label_afterpayment"/>"><spring:message code="label_afterpayment"/></option> --%>
</select>
<div class="info-div pull-left" onclick="$('.docInfo').toggle()">
<!-- <i class="fa fa-info"></i> -->
<div id="pop_1" class="popbox">    
<span></span>
<div class="docInfo" style="display: none;">
<b>Before Login</b> - Before Login, without document fees payment<br>
<b>After Login</b> - After Login, without document fees payment<br>
</div>
</div>
</div>
</div>
</div>

<div class="row">
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
<div class="form-f"><spring:message code="lbl_type_of_contract"/><span class="rd"> *</span></div>
<select class="form-control2" title="<spring:message code="lbl_type_of_contract"/>" isrequired="true"   name="selProcurementNatureId" id="selProcurementNatureId" onchange="javascript:{if(validateCombo(this)){getOtherProcNature(this);}}">
<option value="">${label_select}</option>
<c:forEach items="${tblProcurementNature}" var="item"> 
<option value="${item[0]}">${item[1]}</option>
</c:forEach>
</select>
</div>
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
<div class="form-f"></div>
<input id="txtOtherProcNature" name="txtOtherProcNature" class=" form-control2 tyc " type="text" 
validarr="required@@length:0,50@@tenderbrief" tovalid="false" onblur="validateTxtComp(this)" title="Type of contract" 
validationmsg="Alphabets and special characters ((, ), dot,-,comma, /) with Max. allowed length 50 characters ">
</div>
</div>

<div class="row">
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
<div class="form-f">${lbl_projectduration}<span></span></div>
<input id="txtProjectDuration" name="txtProjectDuration" class=" form-control2 " 
type="text" validarr="length:0,8@@numanduptodecimal:2" maxlength="8" tovalid="false" onblur="validateTxtComp(this)" 
title="Project duration / delivery or completion period">
</div>
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
<div class="form-f"><spring:message code="lbl_tender_value"/></div>
<input id="txtTenderValue" name="txtTenderValue" validarr="length:0,8@@numanduptodecimal:2" tovalid="false" onblur="validateTxtComp(this)" type="text" class=" form-control2 "
title="<spring:message code="lbl_tender_value"/>" maxlength="8">
</div>
</div>

<div class="row">
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
<div class="form-f">Digital certificate required<span class="rd"> *</span></div>
<select class="form-control2"  name="selDigiCertRequired" id="selDigiCertRequired"
title="Digital certificate required">
<option value="">${label_select}</option>
<option value="1">${label_yes}</option>
<option value="0">${label_no}</option>
</select>
</div>
</div>

</div>
</div>
</div>


<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
<div class="box">
<div class="box-header with-border"><h3 class="box-title"><spring:message code="title_bid_submission_conf" /></div></h3>

<div class="box-body">

<div class="row">

<div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
<spring:message code="lbl_itemwise_lh" var="lbl_itemwise_lh"/> 
<div class="form_filed">${lbl_itemwise_lh} <span class="rd">*</span></div>
</div>
<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
<select class="form-control" isrequired="true" title="${lbl_itemwise_lh}" onchange="javascript:{if(validateCombo(this)){showHideRebateApplicable($('#selFormType'))}}" name="selIsItemwiseWinner" id="selIsItemwiseWinner">
                                              <option value="">${label_select}</option>
                                              <option value="1"><spring:message code="label_itemwise"/></option>
                                              <option value="0" ><spring:message code="label_eventwise"/></option>
                                              </select>
</div>
<div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
<div class="form_filed">${field_rebate}<span class="rd"> *</span></div>
</div>
<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
<select class="form-control"  name="selIsRebateApplicable" title="${field_rebate}" id="selIsRebateApplicable" onchange="validateCombo(this)">
                                              <option value="">${label_select}</option>
                                              <option value="1">${allowed}</option>
                                              <option value="0" selected="selected">${notallowed}</option>
                                              </select>
</div>
</div>

<div class="row">
<div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
<div class="form_filed"><spring:message code="lbl_mode_of_submission"/><span class="rd"> *</span></div>
</div>
<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
<select class="form-control"  name="selSubmissionMode" id="selSubmissionMode"  isrequired="true" onchange="javascript:{if(validateCombo(this)){modeOfTenderSubmission(this)}}"  title="<spring:message code="lbl_mode_of_submission"/>">
								<option value="">${label_select}</option>
								<option value="1" selected="selected">${online}</option>
								<option value="2">${offline}</option>
								</select>
</div>
<div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
<div class="form_filed"><label><spring:message code="lbl_bidding_access"/><span class="rd"> *</span></label></div>
</div>
<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
 <select class="form-control" isrequired="true" onchange="validateCombo(this)" title="<spring:message code="lbl_bidding_access"/>" name="selTenderMode" id="selTenderMode">
                                              <option value="">${label_select}</option>
                                              <option value="1">Open</option>
                                              <option value="2" >Limited</option>
                                              <option value="3">Single</option>
                                              <!-- <option value="3">Proprietary</option><option value="4">Nomination</option> -->
                                              </select>
</div>
</div>

<div class="row">
<div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
<div class="form_filed">Document to be submitted physically<span class="rd"> *</span></div>
</div>
<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
<textarea class=" form-control "  id="txtaDocumentSubmission" name="txtaDocumentSubmission" 
validarr="required@@tenderbrief:1000" tovalid="false" onblur="validateTxtComp(this)"
title="Document to be submitted physically" cols="20" rows="3"></textarea>
</div>
<div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
<div class="form_filed"><spring:message code="fields_basecurrency"/><span class="rd"> *</span></div>
</div>
<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
<select class="form-control" title="<spring:message code="fields_basecurrency"/>" name="selCurrencyId" id="selCurrencyId" 
                                      onchange="javascript:{if(validateCombo(this)){getBaseCurrSelect(this)}}" isrequired="true">
                                   	<option value="">${label_select}</option>
                                   	<c:forEach items="${tblCurrencyList}" var="currencyVar"> 
                                   	  <option value="${currencyVar[0]}">${currencyVar[1]}</option>
                                   	</c:forEach></select>

</div>
</div>

<div class="row">
<div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
<div class="form_filed"><spring:message code="lbl_biddingType"/><span class="rd"> *</span></div>
</div>
<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
<select class="form-control"  name="selBiddingType" id="selBiddingType" onchange="getBidCurrency(this)" >
                                              <option value="1" ><spring:message code="lbl_national_competitive_bidding" /></option>
                                              <option value="2"><spring:message code="lbl_international_competitive_bidding" /></option>
                                              </select>
</div>
<div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
<div class="form_filed"><spring:message code="label_bidding_currency"/></div>
</div>
<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
 <c:forEach items="${tblCurrencyList}" var="currencyVar" varStatus="indx"> 
				                                   	<div class="check-box">
                                               	    <label>
                                               	    <input type="checkbox" name="chkCurrency" id="chkCurrency_${indx.index}" 
                                               	    onclick="return callme(this);" value="${currencyVar[0]}">${currencyVar[1]}
                                               	    </label>
                                               	   </div>
				                                   	</c:forEach>
</div>
</div>

<div class="row">
<div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
<div class="form_filed"><spring:message code="lbl_consortium"/><span class="rd"> *</span></div>
</div>
<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
<select class="form-control" title="<spring:message code="lbl_consortium"/>" name="selIsConsortiumAllowed" onchange="validateCombo(this)" isrequired="true" id="selIsConsortiumAllowed">
                                              <option value="">${label_select}</option>
                                              <option value="1">${allowed}</option>
                                              <option value="0" >${notallowed}</option>
                                              </select>
</div>
<div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
<div class="form_filed"><spring:message code="lbl_bidwithdrawal"/><span class="rd"> *</span></div>
</div>
<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
<select title="<spring:message code="lbl_bidwithdrawal"/>" class="form-control"  name="selIsBidWithdrawal" id="selIsBidWithdrawal" onchange="validateCombo(this)" isrequired="true">
                                              <option value="">${label_select}</option>
                                              <option value="1" >${allowed}</option>
                                              <option value="0">${notallowed}</option>
                                              </select>
</div>
</div>

</div>

</div>
</div>

<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
<div class="box">
<div class="box-header with-border"><h3 class="box-title">Key configuration</h3></div>
<div class="box-body">

<div class="row">
<div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
<div class="form_filed"><spring:message code="lbl_bidding_variant"/><span class="rd"> *</span></div>
</div>
<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
<select class="form-control" title="<spring:message code="lbl_bidding_variant"/>" onchange="validateCombo(this)" isrequired="true" name="selBiddingVariant" id="selBiddingVariant">
                                                      <option value="">${label_select}</option>
                                                      <option value="1" ><spring:message code="label_buy"/></option>
                                                      <option value="2"><spring:message code="label_sell"/></option>
                                                      </select>
</div>
<div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
<div class="form_filed"><spring:message code="lbl_prebid_meeting"/><span class="rd"> *</span></div>
</div>
<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
<select class="form-control" title="<spring:message code="lbl_prebid_meeting"/>"  onchange="javascript:{if(validateCombo(this)){modeOfPrebidMeeting(this)}}" isrequired="true" name="selIsPreBidMeeting" id="selIsPreBidMeeting">
                                                          <option value="">${label_select}</option>
                                                          <option value="1">${allowed}</option>
                                                          <option value="0" >${notallowed}</option>
                                                          </select>
</div>
</div>

<div class="row">
<div id="tdPreBidMode3" style="display: none;">                                                                                                                                                                                   
<div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
<div class="form_filed">Mode of pre-bid meeting<span class="rd"> *</span></div>
</div>
<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
<select class="form-control"  onchange="javascript:{if(validateCombo(this)){preBidMeetingAdd(this)}}" isrequired="false" name="selPreBidMode" id="selPreBidMode" 
                                                              >
                                                              <option value="">${label_select}</option>
                                                              <option value="1">${online}</option><option value="2"  selected="selected">${offline}</option>
                                                              </select>
</div>
</div>
<div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
<div class="form_filed">
<spring:message code="lbl_prebid_address" var="lbl_prebid_address"/>
${lbl_prebid_address}<span class="rd">*</span>
</div>
</div>
<div class="col-lg-8 col-md-8 col-sm-8 col-xs-12">
<textarea class=" form-control "  id="txtaPreBidAddress" name="txtaPreBidAddress"
validarr="required@@tenderbrief:1000" tovalid="false" onblur="validateTxtComp(this)" 
title="${lbl_prebid_address}" cols="20" rows="10"></textarea>
</div>
</div>

<div class="row">
<div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
<div class="form_filed"><spring:message code="lbl_workflow_requires"/><span class="rd"> *</span></div>
</div>
<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
<select class="form-control" title="<spring:message code="lbl_workflow_requires"/>" isrequired="true" onchange="javascript:{if(validateCombo(this)){workflowRequires(this)}}" name="selIsWorkflowRequired" id="selIsWorkflowRequired">
                                                              <option value="">${label_select}</option>
                                                              <option value="1" >${label_yes}</option>
                                                              <option value="0">${label_no}</option>
                                                              </select>
</div>
<div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
<div class="form_filed"><spring:message code="lbl_auto_result_sharing"/><span class="rd"> *</span></div>
</div>
<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
<select class="form-control" title="<spring:message code="lbl_auto_result_sharing"/>" onchange="validateCombo(this)" isrequired="true" name="selAutoResultSharing" id="selAutoResultSharing"  >
                                                              <option value="">${label_select}</option>
                                                              <option value="0" ><spring:message code="lbl_auto"/></option>
                                                              <option value="1"><spring:message code="lbl_manual"/></option>
                                                              </select>
</div>
</div>

<div class="row">
<div id="workflowTypeRow1" style="display: none;">
<div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
<div class="form_filed"><spring:message code="lbl_question_answer" /><span class="rd"> *</span></div>
</div>
<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
<select class="form-control"  name="selIsQuestionAnswer" id="selIsQuestionAnswer" onchange="javascript:{if(validateCombo(this)){getQueAnsDate(this)}}" title="<spring:message code="lbl_question_answer" />">
                                                               <option value="">${label_select}</option>
                                                               <option value="1">${label_yes}</option>
                                                               <option value="0" >${label_no}</option>
                                                               </select>
</div>
<div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
<div class="form_filed"><spring:message code="lbl_workflow_type"/><span class="rd"> *</span></div>
</div>
<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
<select class="form-control"  name="selWorkflowType" id="selWorkflowType" title="<spring:message code="lbl_workflow_type"/>">
<option value="">${label_select}</option>
<option value="3" >Any to Any</option>
</select>
</div>
</div>
</div>

</div>
</div>
</div>


<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
<div class="box">
<div class="box-header with-border"><h3 class="box-title"><spring:message code="title_dates_conf"/></h3></div>
<div class="box-body">

<div class="row">
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
<div class="form-f"><spring:message code="lbl_document_start_date" /></div>
<input id="txtDocumentStartDate" name="txtDocumentStartDate"  type="text"  
onblur="doChangeForDateValidation(this)" datepicker="yes" dtrequired="false" 
placeholder="${client_dateformate_hhmm}" title="<spring:message code="lbl_document_start_date" />" 
class="dateBox pull-left form-control2">
</div>
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
<div class="form-f"><spring:message code="lbl_document_end_date" /></div>
<input id="txtDocumentEndDate" name="txtDocumentEndDate"  type="text"  
onblur="doChangeForDateValidation(this)" datepicker="yes" dtrequired="false" placeholder="${client_dateformate_hhmm}" 
title="<spring:message code="lbl_document_end_date" />" class="dateBox pull-left form-control2">
</div>
</div>

<div class="row">
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
<div class="form-f"><spring:message code="lbl_bid_submission_start_date" /></div>
<input id="txtSubmissionStartDate" name="txtSubmissionStartDate"  type="text"
onblur="doChangeForDateValidation(this)" datepicker="yes" dtrequired="false" placeholder="${client_dateformate_hhmm}" 
title="<spring:message code="lbl_bid_submission_start_date" />" class="dateBox pull-left form-control2">
</div>
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
<div class="form-f"><spring:message code="lbl_bid_submission_end_date" /></div>
<input id="txtSubmissionEndDate" name="txtSubmissionEndDate"  type="text"  onblur="doChangeForDateValidation(this)" datepicker="yes" 
dtrequired="false" placeholder="${client_dateformate_hhmm}" title="<spring:message code="lbl_bid_submission_end_date" />" class="dateBox pull-left form-control2">
</div>
</div>

<div class="row">
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
<div class="form-f"><spring:message code="field_bidopeningstartdate" /></div>
<input id="txtBidOpenDate" name="txtBidOpenDate"  type="text"  onblur="doChangeForDateValidation(this)" datepicker="yes" dtrequired="false"  
placeholder="${client_dateformate_hhmm}" title="<spring:message code="field_bidopeningstartdate" />" class="dateBox pull-left form-control2">
</div>
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
<div class="form_filed"></div>
</div>
</div>

<div class="row">
<div id="trPreBidMeetingDate" style="display: none;">
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
<div class="form-f"><spring:message code="fields_prebidmeet_startdate" /></div>
<input id="txtPreBidStartDate" name="txtPreBidStartDate"  type="text" onblur="validateEmptyDt(this)" datepicker="yes" placeholder="${client_dateformate_hhmm}" title="<spring:message code="fields_prebidmeet_startdate" />" 
class="form-control2 dateBox pull-left">
</div>
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
<div class="form-f"><spring:message code="fields_prebidmeet_enddate" /></div>
<input id="txtPreBidEndDate" name="txtPreBidEndDate"  
type="text" onblur="validateEmptyDt(this)" datepicker="yes" placeholder="${client_dateformate_hhmm}" 
title="<spring:message code="fields_prebidmeet_enddate" />" class="dateBox pull-left form-control2">
</div>
</div>
</div>

<div class="row">
<div id="trQueAnsDate" style="display: none;">
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
<div class="form-f"><spring:message code="field_queans_startdate"/></div>
<input id="txtQuestionAnswerStartDate" name="txtQuestionAnswerStartDate"  type="text" onblur="validateEmptyDt(this)" 
datepicker="yes" placeholder="${client_dateformate_hhmm}" title="<spring:message code="field_queans_startdate"/>" class="form-control2 dateBox pull-left">
</div>
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
<div class="form-f"><spring:message code="field_queans_enddate"/></div>
<input id="txtQuestionAnswerEndDate" name="txtQuestionAnswerEndDate"  type="text" onblur="validateEmptyDt(this)" datepicker="yes" placeholder="${client_dateformate_hhmm}" 
title="<spring:message code="field_queans_enddate"/>" 
class="form-control2 dateBox pull-left">
</div>
</div>
</div>


</div>
</div>
</div>


<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
<div class="box">
<div class="box-header with-border"><h3 class="box-title"><spring:message code="title_doc_emd_secfees"/></h3>
<div class="box-body">

<div class="row">
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
<div class="form-f"><spring:message code="lbl_document_fees"/><span class="rd"> *</span></div>
<select class="form-control2" title="<spring:message code="lbl_document_fees"/>"  name="selIsDocfeesApplicable" id="selIsDocfeesApplicable" onchange="javascript:{if(validateCombo(this)){getDocDetail(this)}}" class="form-control" >
<option value="">${label_select}</option>
<option value="1">${allowed}</option>
<option value="0" selected="selected">${notallowed}</option>
</select>
</div>
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
<div id="docFeesMode2" width="50%" style="display: none;">
<div class="form-f">Mode of document fees payment<span class="rd"> *</span></div>
<select class="form-control2"  name="selDocFeePaymentMode" id="selDocFeePaymentMode" onchange="javascript:{if(validateCombo(this)){return showDocAddress(this)}}">
<option value="">${label_select}</option>
<option value="2" selected="selected">${offline}</option>
<option value="3">Both</option>
</select>
</div>
</div>
</div>

<div class="row">
<div id="trDocAmtAndAdd" style="display: none;">
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
<div class="form-f"><spring:message code="fields_fees_amt"/><span class="rd"> *</span></div>
<input id="txtDocumentFee" name="txtDocumentFee"  type="text" validarr="required@@lengthForNum:10@@numanduptodecimal:2@@onetonine" tovalid="false" onblur="validateTxtComp(this)" title="<spring:message code="fields_fees_amt"/>" wordconversion="false" class="form-control2">
</div>
<div id="docAddress2" style="display: none;">
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
<div class="form-f"><spring:message code="field_docfees_payableat"/><span class="rd"> *</span></div>
<textarea class=" form-control2 "  id="txtaDocFeePaymentAddress" name="txtaDocFeePaymentAddress" validarr="required@@tenderbrief:1000" tovalid="false" onblur="validateTxtComp(this)" title="<spring:message code="field_docfees_payableat"/>" cols="20" rows="10"></textarea>
</div>
</div>
</div>
</div>


<div class="row">
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
<div class="form-f"><spring:message code="lbl_security_fee"/><span class="rd"> *</span></div>
<select class="form-control2" title="<spring:message code="lbl_security_fee"/>" name="selIsSecurityfeesApplicable" id="selIsSecurityfeesApplicable" onchange="javascript:{if(validateCombo(this)){getSecurityFeesDetail(this)}}">
<option value="">${label_select}</option>
<option value="1">${allowed}</option>
<option value="0" selected="selected">${notallowed}</option>
</select>
</div>

<div id="secPaymentMode2" style="display: none;"><div style="display: none;">
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
<div class="form-f">Mode of security fee payment<span class="rd"> *</span></div>
<select class="form-control2"  name="selSecFeePaymentMode" 
id="selSecFeePaymentMode" onchange="javascript:{if(validateCombo(this)){getSecurityFees(this)}}">
<option value="">${label_select}</option>
<option value="2" selected="selected">${offline}</option>
<option value="3">Both</option>
</select>
</div>
<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
<div class="form-f"></div>
</div>
</div>
</div>

<div id="trSecurityFees" style="display: none;">
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
<div class="form-f"><spring:message code="field_tendersec_fees_amt"/><span class="rd"> *</span></div>
<input id="txtSecurityFee" class="form-control2" name="txtSecurityFee"  type="text" validarr="required@@lengthForNum:10@@numanduptodecimal:2@@onetonine" tovalid="false" onblur="validateTxtComp(this)" title="Event security fees amount" wordconversion="false">
</div>
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
<div class="form-f"><spring:message code="field_tendersec_fee_payment_at"/><span class="rd"> *</span></div>
<textarea class=" form-control2 "  id="txtaSecFeePaymentAddress" 
name="txtaSecFeePaymentAddress" validarr="required@@tenderbrief:1000" 
tovalid="false" class="form-control" onblur="validateTxtComp(this)" title="<spring:message code="field_tendersec_fee_payment_at"/>" cols="20" rows="10"></textarea>
</div>
</div>
</div>

<div class="row">

<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
<div class="form-f"><spring:message code="lbl_emd_fee"/><span class="rd"> *</span></div>
<select class="form-control2" title="<spring:message code="lbl_emd_fee"/>" onchange="javascript:{if(validateCombo(this)){getEmdDetail(this)}};"  name="selIsEMDApplicable" id="selIsEMDApplicable">
<option value="">${label_select}</option>
<option value="1">${allowed}</option>
<option value="0" selected="selected">${notallowed}</option>
</select>
</div>

<div id="emdMode2" style="display: none;">
<div style="display: none;">
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
<div class="form-f">Mode of EMD payment<span class="rd"> *</span></div>
<select class="form-control2"  name="selEmdPaymentMode" id="selEmdPaymentMode" onchange="getEmdAddress(this)">
<option value="">${label_select}</option>
<option value="2" selected="selected">${offline}</option>
<option value="3">Both</option>
</select>
</div>
</div>
</div>

<div id="trEmdDetail" style="display: none;">
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
<div class="form-f"><spring:message code="field_emdamt"/><span class="rd"> *</span></div>
<input id="txtEmdAmount" name="txtEmdAmount" class="form-control2"  type="text" validarr="required@@lengthForNum:10@@numanduptodecimal:2" tovalid="false" onblur="validateTxtComp(this)" title="<spring:message code="field_emdamt"/>" wordconversion="false">
</div>

<div id="EmdPaymentAt2" style="display: none;">
<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
<div class="form-f"><spring:message code="field_emdpaymentat"/><span class="rd"> *</span></div>
<textarea class=" form-control2 "  id="txtaEmdPaymentAddress" name="txtaEmdPaymentAddress" validarr="required@@tenderbrief:1000" tovalid="false" onblur="validateTxtComp(this)" title="<spring:message code="field_emdpaymentat"/>" cols="20" rows="10"></textarea>
</div>
</div>

</div>

</div>

<div class="row">
<div class="col-md-12">
<button type="submit" class="btn btn-submit">Submit</button>
</div>
</div>





</div>
</div>

</div>
</section>
                                   
<input type="hidden" name="txtCommaSepCur" id="txtCommaSepCur" value="">                                              
                                                                                  
                                        <div class="clearfix formfield" id="paymentfees">  
                                      	    
                                              <table width="100%" cellpadding="0" cellspacing="0" border="0" class="formField" id="feesDtl">
                                                      <tbody><tr>
                                                          <td>
                                                              <table width="100%" cellpadding="0" cellspacing="0" border="0" class="no-border">  
                                                                  <tbody>
                                                                      
                                                                      
                                                                         
                                                                         

                                                    <td style="display:none"><label>Event wise registration charges applicable<span> *</span></label>
                                                    <div>
                                                    <select class="form-control"  name="selIsRegistrationCharges" id="selIsRegistrationCharges">
                                                    <option value="">${label_select}</option>
                                                    <option value="1">${allowed}</option><option value="0" selected="selected">${notallowed}</option>
                                                    </select>
                                                    </div>
                                                    </td>
                                                    
                                                 </tr>
                                               <tr id="registrationChageTR" style="display: none;">
                                           <td id="trForHomePage"><label>Registration charges payment mode<span> *</span></label>
                                                   <div><select class="form-control"  name="selRegistrationChargesMode" id="selRegistrationChargesMode">
                                                   <option value="">${label_select}</option>
                                                   <option value="1">${online}</option><option value="2">${offline}</option><option value="3">Both</option>
                                                   </select>
                                                   </div>
                                                   </td>                                                                                                                                                           
                                               <td>
                                                 <label>Registration charges&nbsp;<span>*</span></label>
                                                 	<div><input id="txtRegistrationCharges" name="txtRegistrationCharges" type="text" validarr="required@@lengthForNum:10@@numanduptodecimal:2@@onetonine" tovalid="false" onblur="validateTxtComp(this)" title="Registration charges" wordconversion="false"></div>
                                                      </td>                                                                                                                                                           
                                               </tr>
                                                              </tbody></table>
                                                              </td></tr>
                                                         </tbody></table>
                                                       </div>
<div class="clearfix formfield">&nbsp;<br/>
                                                              <table style="width: 100%">
                                          					<tbody><tr>
                                                                                     
                                                                                      <td class="a-center" colspan="2">
                                                                                      </td>
                                                                                          </tr>
                                      					</tbody></table>
                                      					</div>
                                                         
                                       
                        <input type="hidden" id="hdDeptId" name="hdDeptId" value="1">
                        <input type="hidden" id="hdEventTypeId" name="hdEventTypeId" value="1">
                        <input type="hidden" id="hdOpType" name="hdOpType" value="">
                        <input type="hidden" id="hdTenderId" name="hdTenderId" value="">

</form>


</div>

<%@include file="../../includes/footer.jsp"%>

</div>

</body>

</html>