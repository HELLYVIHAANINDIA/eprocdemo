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
	<spring:message code="label_select" var="label_select"></spring:message>
	<spring:message code="lbl_projectduration" var="lbl_projectduration"/>
	<spring:message code="label_yes" var="label_yes"/>
	<spring:message code="label_no" var="label_no"/>
    <spring:message code="label_online" var="online"/>
	<spring:message code="label_offline" var="offline"/>
        <script>
            var sel="";
            var wysihtml5Editor = "";
            var nodedata="";
            var map=new Array();
            var hideMap=new Array();
            var contextPath="${pageContext.servletContext.contextPath}";
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
		       	$(".dateBox").prop("readonly",true); // use only calander.
		       	$(".dateBox").each(function(){
		       		var tenderDates = $(this).attr("tenderdate");
		       		if(tenderDates != undefined && tenderDates != ""){
		       			tenderDates = convertDateStringFormate(tenderDates,"yyyy-mm-dd HH:mm",CLIENT_DATE_FORMATE);
		       		}else{
		       			tenderDates="";
		       		}
		       		$(this).datetimepicker({
		       			format:'d-M-Y H:i',
		       		    minDate:tenderDates != ""?tenderDates:false,
		       			formatDate:'d-M-Y H:i'
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
                map['BiddingType']=$("#selBiddingType").val();
                map['IsPreBidMeeting']="0";
                map['preBidMode']="2";
                map['isDocfeesApplicable']="0";
                map['docFeePaymentMode']= 2;//$("#selDocFeePaymentMode").val();
                map['isSecurityfeesApplicable']="1";
                map['isEMDApplicable']="1";
                map['submissionMode']="1";
                map['secFeePaymentMode']= 2;//$("#selSecFeePaymentMode").val();
                map['isEMDApplicable']=""
                map['emdPaymentMode']= 2;//$("#selEmdPaymentMode").val();
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
	       		modeOfPrebidMeeting($("#selIsPreBidMeeting"));
	       		
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
<spring:message code="field_rebate" var="field_rebate"/>
</head>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="../../includes/leftaccordion.jsp"%>

	<div class="content-wrapper">

		<section class="content-header">
		<a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}"><< <spring:message code="lbl_back_dashboard"/></a>
<!-- 		onsubmit="return validation();" -->

<spring:url value="/etender/buyer/addtenderCorrigendum/${tenderId}" var="actionUrl"/>                              
<form id="tenderDtBean" name="tenderDtBean" onsubmit="return validation();" action="${actionUrl}" method="post" >
<div class="main_container o-hidden" id="temp">

          <div class="panel-container">
               <div class="page-title prefix_1 o-hidden">
                  <h1 class="pull-left grid_12">
                      &nbsp;Corrigendum</h1>
                  </div>
              <table style="width: 100%">
                  <tbody><tr class="gradi">
                      <td class="title-td1 border-top-none">
                          <h2>
                            Basic details</h2>                                                   
                      </td>
                  </tr>
              </tbody></table>
                    
              
                          
                     	<div class="clearfix formfield">
                              <font size="1" class="pull-right mandatory">(<b class="red"> *</b>) Mandatory fields</font>
                              <input type="hidden" id="hdIsDateValidationAllow" name="hdIsDateValidationAllow" value="2">
                              <input type="hidden" id="hdIndentId" name="hdIndentId" value="">
                              <input type="hidden" id="hdIsCategoryAllow" name="hdIsCategoryAllow" value="">
                              <input type="hidden" id="hdBrdMode" name="hdBrdMode" value=""><input type="hidden" name="isPastEvent" value="0">
                              <input type="hidden" name="selDecimalValueUpto" value="">                                                    
                              <table width="100%">
                              <tbody><tr> <!-- no modified -->
                                             <td id="deptTd" width="50%" >
                                                 <label>Department<span> *</span></label>
                                                 <select disabled="disabled" name="txtParentDepartment" id="txtParentDepartment" isrequired="true" title="Department"  onchange="validateCombo(this)" >
                                                     <option value="0">${label_select}</option>
	                                                   <c:forEach items="${tblDepartmentList}" var="item"> 
	                                                     <option value="${item[0]}">${item[1]}</option>
	                                                   </c:forEach>
                                                 </select>
                                                 <%-- <input type="text" class="form-control easyui-combotree combotree-f combo-f" id="txtParentDepartment"
				onchange="getDepartmentOfficer()" style="display: none;" comboname="txtParentDepartment">
				
				<span class="combo" style="width: 166px; height: 6px;">
				<input type="text" class="form-control combo-text validatebox-text" autocomplete="off" readonly="readonly" style="width: 436px; height: 18px; 
					line-height: 18px;" placeholder="-- Please Select --"><span><span class="combo-arrow" style="height: 18px;"></span></span>
					<input type="hidden" class="combo-value" name="txtParentDepartment" value=""></span>
                                                 <input type="hidden" id="hdIsFullTree" name="hdIsFullTree" value="yeRpiwaGN10=">
				<input type="hidden" id="jhdIsFullTree" name="jhdIsFullTree" value="false"><br>
                                                 <span id="errSpanParentDepartmentMsg" class="red"></span>--%>
                                             </td>
                                                 <td id="tdDeptOfficer" width="50%"> 
                                                     <label>Department officer<span> *</span></label>
                                                     <select name="selDeptOfficial" disabled="disabled" id="selDeptOfficial" onchange="validateCombo(this)" 
                                                     isrequired="true" title="Department officer">
                                                     <option value="">${label_select}</option>
	                                                   <c:forEach items="${tblOfficerList}" var="item"> 
	                                                     <option value="${item[0]}">${item[1]}</option>
	                                                   </c:forEach>
                                                     </select>
                                                 </td>
                                         </tr>
                              <tr> <!-- no modified -->
                                  <td> 
                                      <label><spring:message code="fields_refenceno"/><span> *</span></label>
                                      <input id="txtTenderNo"  readonly="readonly" class=" form-control " name="txtTenderNo" type="text" validarr="required@@tenderbrief:1000" tovalid="true" onblur="validateTxtComp(this)" title="<spring:message code="fields_refenceno"/>"></td>
                              </tr>
                              <tr> <!-- no modified -->
                                  <td colspan="2">
                                  
                                      <label><spring:message code="field_brief"/><span> *</span> </label>
                                      	<textarea readonly="readonly"  class=" form-control "  id="txtaTenderBrief" name="txtaTenderBrief" validarr="required@@length:0,1000" tovalid="true" onblur="validateTxtComp(this)" validationmsg="Allows Max. 1000 alphabets, numbers and special characters" title="<spring:message code="field_brief"/>" class="line-height" cols="20" rows="10"></textarea></td>
                              </tr>  
                              <tr> <!--  no modified -->
                                  <td colspan="2"> 
                                      <label><spring:message code="field_tender_detail"/><span></span></label>
                                      <textarea  class="form-control rtfTenderDetail"  id="rtfTenderDetail" name="rtfTenderDetail" tovalid="true"  validarr="required@@length:0,10000"  title="Details" cols="20" rows="10" >  </textarea>
                                  </td>
                                  </tr>
                                  <!-- Bharat Start category combo. -->
                           
                           <tr id="keywordTR">
                                  <td colspan="2"> 
                                      <label><spring:message code="fields_tender_keywords"/><span> *</span></label>
                                      <%-- <textarea class=" form-control "  id="txtaKeyword" name="txtaKeyword" validarr="required@@length:0,1000@@commonkeyword" tovalid="true" onblur="validateTxtComp(this)" title="Product / service / work keywords" style="width:385px;min-height:50px !important;" cols="10" rows="3"></textarea>
                                      <div class="divResult" style="display: none;">
                                          <div class="loading">Loading..</div>
                                          <div class="record no-border" style="height: 100px;"></div>
                                      </div> --%>
                                       <select id="selKeywords" class="form-control" multiple="multiple" name="selKeywords" title="keyword" onchange="validateCombo(this)" >
										<c:if test="${not empty categoryList }">
											<c:forEach items="${categoryList}" var="category">
												<option selected="selected" value="${category[0]}">${category[1]}</option>
											</c:forEach>
										</c:if>
									   </select>
										<input type="hidden" id="categoryText" name="categoryText">
                                   </td>
                              </tr>
                              <tr>
                                  <td width="50%" > <!--  no modified -->
                                              <label><spring:message code="lbl_emvelope_type"/><span> *</span></label>
                                              <select readonly="readonly" disabled="disabled" class="form-control"  name="selEnvelopeType" id="selEnvelopeType" onchange="javascript:{if(validateCombo(this)){getFormType(this)}};">
                                                <option value="">${label_select}</option>
												<option value="1" ><spring:message code="lbl_evaluation_singlestage"/> </option><option value="2"><spring:message code="lbl_evaluation_multiestage"/></option>
                                              </select>
                                      <td width="50%">
                                      <label><spring:message code="lbl_envelope"/><span> *</span></label>
                                      <select class="form-control"  readonly="readonly" disabled="disabled" name="selFormType" id="selFormType" 
                                      onchange="javascript:{if(validateCombo(this)){getFormSelection(this)}}" 
                                      isrequired="true" title="<spring:message code="lbl_envelope"/>" size="5" multiple="">
                                      <c:forEach items="${listTblEnv}" var="tblEnv"> 
                                      <option value="${tblEnv.envId}">${tblEnv.lang1}</option>
                                      </c:forEach>
                                      </select>
                                      <span id="errFormTypeValidation" class="red"></span>
                                  </td>
                              </tr>
                              <tr>
                                  <td style="display: none" width="50%"> 
                                                    <label><spring:message code="lbl_projectduration"/><span> *</span></label>
                                                    <input id="txtValidityPeriod" name="txtValidityPeriod" class=" form-control " type="text" maxlength="5"
                                                     value="0" title="<spring:message code="lbl_projectduration"/>"></td>
                                            <td style="display: none;"> 
                                                <label><spring:message code="lbl_downloaddocument"/><span> *</span></label>
                                                <select class="form-control"  isrequired="true" title="<spring:message code="lbl_downloaddocument"/>" onchange="validateCombo(this)" name="selDownloadDocument" id="selDownloadDocument" class="pull-left">
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
                                            </td>
                                        </tr>
                                <tr>
                                    <td width="50%"> 
                                                <label><spring:message code="lbl_type_of_contract"/><span> *</span></label>
                                        		<select class="form-control" title="<spring:message code="lbl_type_of_contract"/>" isrequired="true"   name="selProcurementNatureId" id="selProcurementNatureId" onchange="javascript:{if(validateCombo(this)){getOtherProcNature(this);}}">
                                        		<option value="">${label_select}</option>
                                        		<c:forEach items="${tblProcurementNature}" var="item"> 
                                        			<option value="${item[0]}">${item[1]}</option>
                                        		</c:forEach>
                                        		</select>
                                        		</td>
                                        <td width="50%" style="display: none" id="trOtherProcNature">
                                  	<label>&nbsp;</label>
                                  	<input id="txtOtherProcNature" name="txtOtherProcNature" class=" form-control " type="text" 
                                  	validarr="required@@length:0,50@@tenderbrief" tovalid="false" onblur="validateTxtComp(this)" title="Type of contract" 
                                  	validationmsg="Alphabets and special characters ((, ), dot,-,comma, /) with Max. allowed length 50 characters ">
                                  	</td>
                              </tr>
                              <tr>
                                  <td>
                                              <label>${lbl_projectduration}<span></span></label>
                                              <input id="txtProjectDuration" name="txtProjectDuration" class=" form-control "  
                                              type="text" validarr="length:0,8@@numanduptodecimal:2" maxlength="8" tovalid="false" onblur="validateTxtComp(this)" 
                                              title="${lbl_projectduration}" 
                                              validationmsg="Allows Max. 50 numeric values.">
                                 </td>
                              </tr>
                              <tr>
                                  <td width="50%"> 
                                                  <label><spring:message code="lbl_tender_value"/></label>
                                                  <input id="txtTenderValue" name="txtTenderValue" type="text" class=" form-control " validarr="length:0,8@@numanduptodecimal:2" tovalid="false" onblur="validateTxtComp(this)"
                                                    title="<spring:message code="lbl_tender_value"/>" maxlength="8"></td>
                                          <td colspan="2" id="trDigitalCertRequired" style="display: none">  
                                                   <label>Digital certificate required<span> *</span></label>
                                                   <select class="form-control"  name="selDigiCertRequired" id="selDigiCertRequired"
                                                    title="Digital certificate required">
                                                    <option value="">${label_select}</option>
                                                    <option value="1">${label_yes}</option>
                                                    <option value="0">${label_no}</option>
                                                    </select>
                                     </td>
                                     
                              </tr>
                          </tbody></table>
                                  <input type="hidden" id="txtRmvFormList" name="txtRmvFormList" value="">
                          </div>
                           <table style="width: 100%">
                              <tbody><tr class="gradi">
                                  <td>        
                                      <h2>
                                          <spring:message code="title_bid_submission_conf"/></h2>
                                  </td>
                              </tr>
                           </tbody></table>
                                  
              <div class="clearfix formfield">
              <table width="100%" cellpadding="0" cellspacing="0" border="0" class="formField">
                  <tbody><tr>
                      <td>
                          <table width="100%" cellpadding="0" cellspacing="0" border="0" class="no-border">
                              <tbody><tr>
                                 <%--  <td style="display: none" width="50%"> 
                                               <label>Distribution of PO<span> *</span></label>
                                              <select class="form-control"  name="selIsSplitPOAllowed" id="selIsSplitPOAllowed">
                                              <option value="">${label_select}</option>
                                              <option value="1">${allowed}</option>
                                              <option value="0" >${notallowed}</option>
                                              </select>
                                              </td> --%>
                                              
                                      <td id="tdIsItemwiseWinner" width="50%">
                                      		  <spring:message code="lbl_itemwise_lh" var="lbl_itemwise_lh"/> 
                                              <label>${lbl_itemwise_lh}<span> *</span></label>
                                              <select class="form-control" isrequired="true" title="${lbl_itemwise_lh}" onchange="javascript:{if(validateCombo(this)){showHideRebateApplicable($('#selFormType'))}}" name="selIsItemwiseWinner" id="selIsItemwiseWinner">
                                              <option value="">${label_select}</option>
                                               <option value="1"><spring:message code="label_itemwise"/></option>
                                              <option value="0" ><spring:message code="label_eventwise"/></option>
                                              </select>
                                      </td>
                                      <td id="tdIsRebateApplicable" width="50%"> 
                                               <label>${field_rebate}<span> *</span></label>
                                              <select disabled="disabled" class="form-control"  name="selIsRebateApplicable" title="${field_rebate}" id="selIsRebateApplicable" onchange="validateCombo(this)">
                                              <option value="">${label_select}</option>
                                              <option value="1">${allowed}</option>
                                              <option value="0" selected="selected">${notallowed}</option>
                                              </select>
                                      </td>
                                      </tr>                     
                              <tr>
                                  <td width="50%" style="display: none;"> 
                                  <label><spring:message code="lbl_mode_of_submission"/><span> *</span></label>
								 <select class="form-control"  name="selSubmissionMode" id="selSubmissionMode"  isrequired="true" onchange="javascript:{if(validateCombo(this)){modeOfTenderSubmission(this)}}"  title="Mode of bid submission">
								<option value="">${label_select}</option>
								<option value="1" selected="selected">${online}</option>
								<option value="2">${online}</option>
								</select>
								</td>
							<td width="50%"> 
                                               <label><spring:message code="lbl_bidding_access"/><span> *</span></label>
                                              <select class="form-control" isrequired="true" onchange="validateCombo(this)" title="biddong access" name="selTenderMode" id="selTenderMode">
                                              <option value="">${label_select}</option>
                                              <option value="1"><spring:message code="label_open"/></option>
                                              <option value="2" selected="selected"><spring:message code="label_limited"/></option>
                                              <option value="3"><spring:message code="label_single"/></option>
                                              <!-- <option value="3">Proprietary</option><option value="4">Nomination</option> -->
                                              </select>
                                   </td>
                                      </tr>
                              <tr id="trDocSubmission" style="display: none;">
                                              <td width="50%"> 
                                                          <label>Document to be submitted physically<span> *</span></label>
                                                          <textarea class=" form-control "  id="txtaDocumentSubmission" name="txtaDocumentSubmission" 
                                                          validarr="required@@tenderbrief:1000" tovalid="false" onblur="validateTxtComp(this)"
                                                          title="Document to be submitted physically" style="width:78%;" cols="20" rows="3"></textarea>
                                                          
                                                          </td>

                                                  </tr>
                              <tr>
                                  <td> 
                                       <label><spring:message code="fields_basecurrency"/><span> *</span></label>
                                      <select class="form-control" title="<spring:message code="fields_basecurrency"/>" name="selCurrencyId" id="selCurrencyId" 
                                      onchange="javascript:{if(validateCombo(this)){getBaseCurrSelect(this)}}" isrequired="true">
                                   	<option value="">${label_select}</option>
                                   	<c:forEach items="${tblCurrencyList}" var="currencyVar"> 
                                   	  <option value="${currencyVar[0]}">${currencyVar[1]}</option>
                                   	</c:forEach></select>
                                      </td>
                                  <td width="50%"> <!--  no modified -->
                                              <label><spring:message code="lbl_biddingType"/><span> *</span></label>
                                              <select  disabled="disabled"  class="form-control"  name="selBiddingType" id="selBiddingType" onchange="getBidCurrency(this)">
                                              <option value="1" selected="selected"><spring:message code="lbl_national_competitive_bidding" /></option>
                                              <option value="2"><spring:message code="lbl_international_competitive_bidding" /></option>
                                              </select>
<td>
                                      </tr>
                              <tr id="trBidCurrency" style="display: none">
                                  <td colspan="2">
                                      <input type="hidden" name="txtCommaSepCur" id="txtCommaSepCur" value="">
                                      <table width="100%" id="tableCurrency" cellpadding="0" cellspacing="0" border="0" class="no-border">
                                           <tbody><tr>
                                           	<td class="currency-checkbox p-bottom-none" colspan="2">
													<label class="alpha1"><spring:message code="label_bidding_currency"/></label>
                                               	    <c:forEach items="${tblCurrencyList}" var="currencyVar" varStatus="indx"> 
				                                   	<div class="check-box">
                                               	    <label>
                                               	    <input type="checkbox" name="chkCurrency" id="chkCurrency_${indx.index}" 
                                               	    onclick="return callme(this);" value="${currencyVar[0]}">${currencyVar[1]}
                                               	    </label>
                                               	   </div>
				                                   	</c:forEach>
                                           </td>
                                           </tr>
                                      </tbody></table>
                                  </td>
                              </tr>
                              <tr>
                                  <td width="50%"> 
                                              <label><spring:message code="lbl_consortium"/><span> *</span></label>
                                              <select class="form-control" title="Consortium" name="selIsConsortiumAllowed" onchange="validateCombo(this)" isrequired="true" id="selIsConsortiumAllowed">
                                              <option value="">${label_select}</option>
                                              <option value="1">${allowed}</option><option value="0" >${notallowed}</option></select>
                                              </td>
                                      <td width="50%"> 
                                              <label><spring:message code="lbl_bidwithdrawal"/><span> *</span></label>
                                              <select title="<spring:message code="lbl_bidwithdrawal"/>" class="form-control"  name="selIsBidWithdrawal" id="selIsBidWithdrawal" onchange="validateCombo(this)" isrequired="true">
                                              <option value="">${label_select}</option>
                                              <option value="1" >${allowed}</option><option value="0">${notallowed}</option></select>
                                              </td>
                                      </tr>          
                          </tbody></table>
                      </td>
                  </tr>
              </tbody></table>
              </div>
              <table style="width: 100%">
                  <tbody><tr class="gradi">
                      <td>
                          <h2>
                              <spring:message code="title_key_conf"/></h2>
                      </td>
                  </tr>
               </tbody></table>
              <div class="clearfix formfield">
                  <table width="100%" cellpadding="0" cellspacing="0" border="0" class="formField" id="keyConfDtl">
                      <tbody><tr>
                          <td>
                              <table width="100%" cellpadding="0" cellspacing="0" border="0" class="no-border">       
                                  <tbody><tr>
                                          <td width="50%"> 
                                                       <label><spring:message code="lbl_bidding_variant"/><span> *</span></label>
                                                      <select class="form-control" title="<spring:message code="lbl_bidding_variant"/>" onchange="validateCombo(this)" isrequired="true" name="selBiddingVariant" id="selBiddingVariant">
                                                      <option value="">${label_select}</option>
                                                      <option value="1" ><spring:message code="label_buy"/></option><option value="2"><spring:message code="label_sell"/></option></select>
                                                      </td>
                                              <td></td>
                                      </tr>
                                      <tr>
                                              <td> 
                                                          <label><spring:message code="lbl_prebid_meeting"/><span> *</span></label>
                                                          <select class="form-control" disabled="disabled" title="<spring:message code="lbl_prebid_meeting"/>"  onchange="javascript:{if(validateCombo(this)){modeOfPrebidMeeting(this)}}" isrequired="true" name="selIsPreBidMeeting" id="selIsPreBidMeeting">
                                                          <option value="">${label_select}</option>
                                                          <option value="1">${allowed}</option><option value="0" >${notallowed}</option>
                                                          </select>
                                                  <td width="50%"> 
                                                          <div id="tdPreBidMode3" style="display: none;">
                                                              <label>Mode of pre-bid meeting<span> *</span></label>
                                                              <select class="form-control" disabled="disabled" onchange="javascript:{if(validateCombo(this)){preBidMeetingAdd(this)}}" isrequired="false" name="selPreBidMode" id="selPreBidMode">
                                                              <option value="">${label_select}</option>
                                                              <option value="1">Online</option><option value="2" selected="selected">Offline</option></select>
                                                              </div>
                                                      </td>
                                                  </tr>
                                          <tr id="trPreBidMeetingAddress" style="display: none;">
                                              <td></td>
                                              <td width="50%"> 
                                              <spring:message code="lbl_prebid_address" var="lbl_prebid_address"/>
                                                          <label>${lbl_prebid_address}<span> *</span></label>
                                                          <textarea class=" form-control "  id="txtaPreBidAddress" name="txtaPreBidAddress"
                                                           validarr="required@@tenderbrief:1000" tovalid="false" onblur="validateTxtComp(this)" 
                                                           title="Address" cols="20" rows="10"></textarea></td>
                                                  </tr>
                                          <tr>
                                                  		<td width="50%"> 
                                                              <label><spring:message code="lbl_workflow_requires"/><span> *</span></label>
                                                              <select class="form-control" disabled="disabled" title="<spring:message code="lbl_workflow_requires"/>" isrequired="true" onchange="javascript:{if(validateCombo(this)){workflowRequires(this)}}" name="selIsWorkflowRequired" id="selIsWorkflowRequired">
                                                              <option value="1" selected="selected">${label_yes}</option><option value="0">${label_no}</option>
                                                              </select>
                                                              </td>
                                                              <td width="50%"> 
                                                              <label><spring:message code="lbl_auto_result_sharing"/><span> *</span></label>
                                                              <select class="form-control" title="<spring:message code="lbl_auto_result_sharing"/>" onchange="validateCombo(this)" isrequired="true" name="selAutoResultSharing" id="selAutoResultSharing"  >
                                                              <option value="">${label_select}</option>
                                                              <option value="0" ><spring:message code="lbl_auto"/></option>
                                                              <option value="1"><spring:message code="lbl_manual"/></option>
                                                              </select>
                                                              </td>
                                                              
                                                          <td colspan="1" width="50%" style="display: none;"> 
                                                              <label><spring:message code="lbl_question_answer" /><span> *</span></label>
                                                              <select class="form-control"  name="selIsQuestionAnswer" id="selIsQuestionAnswer" onchange="javascript:{if(validateCombo(this)){getQueAnsDate(this)}}" title="<spring:message code="lbl_question_answer" />">
                                                               <option value="">${label_select}</option>
                                                               <option value="1">${label_yes}</option>
                                                               <option value="0" >${label_no}</option></select>
                                                               </td>
                                                      </tr>
                                              <!-- Krunal Add  IsWorkflowType -->
                                              <tr id="workflowTypeRow1" style="display: none;">
                                                  <td width="50%"> 
                                                      <label><spring:message code="lbl_workflow_type"/><span> *</span></label>
                                                      <select class="form-control"  name="selWorkflowType" id="selWorkflowType" title="<spring:message code="lbl_workflow_type"/>">
                                                      <option value="">${label_select}</option>
                                                      <option value="3" >Any to Any</option></select>
                                                      </td>
                                               </tr>
                                               <!-- Krunal End  IsWorkflowType -->
                                              </tbody></table>
                                              </td>
                                          </tr>
                                      </tbody></table>
              </div>
                    <table style="width: 100%">
                      <tbody><tr class="gradi">
                          <td>
                               <h2>
                                  <spring:message code="title_dates_conf"/> </h2>
                          </td>
                      </tr>
                    </tbody></table>
                                  <div class="clearfix formfield">
                                      <table width="100%" cellpadding="0" cellspacing="0" border="0" class="formField">
                                          <tbody><tr>
                                              <td>
                                                  <table width="100%" cellpadding="0" cellspacing="0" border="0" class="no-border">
                                                      <tbody><tr>
                                                              <td width="50%" style="position:relative;"> 
                                                                          <label><spring:message code="lbl_document_start_date" /><!-- <span> *</span> --></label>
                                                                          <input id="txtDocumentStartDate" name="txtDocumentStartDate" disabled="disabled" type="text"  
                                                                           onblur="doChangeForDateValidation(this)" datepicker="yes" dtrequired="false" 
                                                                           placeholder="${client_dateformate_hhmm}" title="<spring:message code="lbl_document_start_date" />" 
                                                                           class="dateBox pull-left form-control">&nbsp;
                                                                           </td>
                                                                  <td width="50%" style="position:relative;"> 
                                                                          <label><spring:message code="lbl_document_end_date" /><!-- <span> *</span> --></label>
                                                                          <input id="txtDocumentEndDate" tenderdate="${tblTender.documentEndDate}" name="txtDocumentEndDate"  type="text"  
                                                                          onblur="doChangeForDateValidation(this)" datepicker="yes" dtrequired="true" datevalidate='gt:txtDocumentStartDate' placeholder="${client_dateformate_hhmm}" 
                                                                          title="<label><spring:message code="lbl_document_end_date" /><!-- <span> *</span> --></label>" class="dateBox pull-left form-control">&nbsp;
                                                                          </td>
                                                                  </tr>
                                                          <tr>
                                                                  <td width="50%" style="position:relative;"> 
                                                                              <label><spring:message code="lbl_bid_submission_start_date" /><!-- <span> *</span> --></label>
                                                                              <input id="txtSubmissionStartDate" disabled="disabled"  name="txtSubmissionStartDate"  type="text"
                                                                               onblur="doChangeForDateValidation(this)" datepicker="yes" dtrequired="false" placeholder="${client_dateformate_hhmm}" 
                                                                               title="<spring:message code="lbl_bid_submission_start_date" />" class="dateBox pull-left form-control">&nbsp;
                                                                               </td>
                                                                      </tr>
                                                              <tr>
                                                                  <td width="50%" style="position:relative;"> 
                                                                      <label><spring:message code="lbl_bid_submission_end_date" /><!-- <span> *</span> --></label>
                                                                      <input id="txtSubmissionEndDate" name="txtSubmissionEndDate"  type="text"  onblur="doChangeForDateValidation(this)" datepicker="yes" 
                                                                      dtrequired="false" placeholder="${client_dateformate_hhmm}" datevalidate='lt:txtBidOpenDate' tenderdate="${tblTender.submissionEndDate}"  title="<spring:message code="lbl_bid_submission_end_date" />" class="dateBox pull-left form-control"></td>
                                                                  <td width="50%" style="position:relative;"> 
                                                                      <label><spring:message code="field_bidopeningstartdate" /><!-- <span> *</span> --></label>
                                                                      <input id="txtBidOpenDate" name="txtBidOpenDate"  type="text"  tenderdate="${tblTender.openingDate}"  onblur="doChangeForDateValidation(this)"  datepicker="yes" datevalidate='gt:txtSubmissionEndDate'  dtrequired="true"
                                                                       placeholder="${client_dateformate_hhmm}" title="<spring:message code="field_bidopeningstartdate" />" class="dateBox pull-left form-control"></td>
                                                              </tr>

                                                              <tr id="trPreBidMeetingDate" style="display: none;">
                                                                  <td width="50%" style="position:relative;"> 
                                                                      <label><spring:message code="fields_prebidmeet_startdate" /><!-- <span> *</span> --></label>
                                                                      <input id="txtPreBidStartDate" name="txtPreBidStartDate"  type="text" onblur="validateEmptyDt(this)" datepicker="yes" placeholder="${client_dateformate_hhmm}" title="<spring:message code="fields_prebidmeet_startdate" />" 
                                                                      class="form-control dateBox pull-left"></td>   
                                                                  <td width="50%" style="position:relative;"> 
                                                                      <label><spring:message code="fields_prebidmeet_enddate" /><!-- <span> *</span> --></label>
                                                                      <input id="txtPreBidEndDate" name="txtPreBidEndDate"  
                                                                      type="text" onblur="validateEmptyDt(this)" datepicker="yes" placeholder="${client_dateformate_hhmm}" 
                                                                      title="<spring:message code="fields_prebidmeet_enddate" />" class="dateBox pull-left form-control">&nbsp;
                                                                      </td>   
                                                              </tr>

                                                              <tr id="trQueAnsDate" style="display: none;">
                                                                  <td width="50%" style="position:relative;"> 
                                                                      <label><spring:message code="field_queans_startdate"/><!-- <span> *</span> --></label>
                                                                      <input id="txtQuestionAnswerStartDate" name="txtQuestionAnswerStartDate"  type="text" onblur="validateEmptyDt(this)" 
                                                                      datepicker="yes" placeholder="${client_dateformate_hhmm}" title="<spring:message code="field_queans_startdate"/>" class="form-control dateBox pull-left"></td>   
                                                                  <td width="50%" style="position:relative;"> 
                                                                      <label><spring:message code="field_queans_enddate"/><!-- <span> *</span> --></label>
                                                                      <input id="txtQuestionAnswerEndDate" name="txtQuestionAnswerEndDate"  type="text" onblur="validateEmptyDt(this)" datepicker="yes" placeholder="${client_dateformate_hhmm}" 
                                                                      title="<spring:message code="field_queans_enddate"/>" 
                                                                      class="form-control dateBox pull-left"></td>   
                                                              </tr>
                                                              </tbody></table>
                                                              </td>
                                                          </tr>
                                                  </tbody></table>
                                     </div>
                                    
                                    
                                        <div class="clearfix formfield" id="paymentfees">  
                                      	    <table style="width: 100%">
                                      		    <tbody><tr class="gradi">
                                         			     <td>
                                               				   <h2>
                                              			      <spring:message code="title_doc_emd_secfees"/> </h2>
                                             				 </td>
                                          			</tr>
                                    			  </tbody></table>  
                                              <table width="100%" cellpadding="0" cellspacing="0" border="0" class="formField" id="feesDtl">
                                                      <tbody><tr>
                                                          <td>
                                                              <table width="100%" cellpadding="0" cellspacing="0" border="0" class="no-border">  
                                                                  <tbody><tr>
                                                                              <td width="50%" id="docfeesApplicableTd">
                                                                                          <label><spring:message code="lbl_document_fees"/><span> *</span></label>
                                                                                          <select class="form-control" title="<spring:message code="lbl_document_fees"/>"  name="selIsDocfeesApplicable" id="selIsDocfeesApplicable" onchange="javascript:{if(validateCombo(this)){getDocDetail(this)}}" class="form-control" >
                                                                                          <option value="">${label_select}</option>
                                                                                          <option value="1">${allowed}</option>
                                                                                          <option value="0" selected="selected">${notallowed}</option></select>
                                                                                          </td>
                                                                                  <td id="docFeesMode2" width="50%" style="display: none;"> 
                                                                                      <div id="docFeesMode2">
                                                                                      	<div style="display: none;">
                                                                                          <label>Mode of document fees payment<span> *</span></label>
                                                                                          <select class="form-control"  name="selDocFeePaymentMode" id="selDocFeePaymentMode" onchange="javascript:{if(validateCombo(this)){return showDocAddress(this)}}">
                                                                                          <option value="">${label_select}</option>
                                                                                          <option value="2" selected="selected">${offline}</option>
                                                                                          <option value="3">Both</option>
                                                                                          </select></div>
                                                                                          </div>
                                                                                  </td>
                                                                              </tr>
                                                                      <tr id="trDocAmtAndAdd" style="display: none;">
                                                                          <td width="25%"> 
                                                                              <label>Document fees amount<span> *</span></label>
                                                                              <input id="txtDocumentFee" name="txtDocumentFee"  type="text" validarr="required@@lengthForNum:10@@numanduptodecimal:2@@onetonine" tovalid="false" onblur="validateTxtComp(this)" title="<spring:message code="fields_fees_amt"/>" wordconversion="false" class="form-control"></td>
                                                                          <td width="50%"> 
                                                                              <div id="docAddress2" style="display: none;">
                                                                                  <label>Document fees payable at<span> *</span></label>
                                                                                  <textarea class=" form-control "  id="txtaDocFeePaymentAddress" name="txtaDocFeePaymentAddress" validarr="required@@tenderbrief:1000" tovalid="false" onblur="validateTxtComp(this)" title="<spring:message code="field_docfees_payableat"/>" cols="20" rows="10"></textarea></div>
                                                                          </td>
                                                                      </tr>
                                                                      <tr>
                                                                                  <td width="50%"> 
                                                                                              <label><spring:message code="lbl_security_fee"/><span> *</span></label>
                                                                                              <select class="form-control" title="<spring:message code="lbl_security_fee"/>" name="selIsSecurityfeesApplicable" id="selIsSecurityfeesApplicable" onchange="javascript:{if(validateCombo(this)){getSecurityFeesDetail(this)}}">
                                                                                              <option value="">${label_select}</option>
                                                                                              <option value="1">${allowed}</option>
                                                                                              <option value="0" selected="selected">${notallowed}</option></select>
                                                                                              </td>
                                                                                      <td width="50%">
                                                                                          <div id="secPaymentMode2" style="display: none;"><div style="display: none;">
                                                                                              <label>Mode of security fee payment<span> *</span></label>
                                                                                              <select class="form-control"  name="selSecFeePaymentMode" 
                                                                                              id="selSecFeePaymentMode" onchange="javascript:{if(validateCombo(this)){getSecurityFees(this)}}">
                                                                                              <option value="">${label_select}</option>
                                                                                              <option value="2" selected="selected">${offline}</option>
                                                                                              <option value="3">Both</option>
                                                                                              </select></div>
                                                                                              </div>
                                                                                      </td>
                                                                                  </tr>
                                                                         <tr id="trSecurityFees" style="display: none;">
                                                                              <td width="25%"> 
                                                                                  <label><spring:message code="field_tendersec_fees_amt"/><span> *</span></label>
                                                                                  <input id="txtSecurityFee" class="form-control" name="txtSecurityFee"  type="text" validarr="required@@lengthForNum:10@@numanduptodecimal:2@@onetonine" tovalid="false" onblur="validateTxtComp(this)" title="Event security fees amount" wordconversion="false"></td>
                                                                              <td width="50%">
                                                                                  <div id="secFeesPaymentAt2">
                                                                                      <label><spring:message code="field_tendersec_fee_payment_at"/><span> *</span></label>
                                                                                      <textarea class=" form-control "  id="txtaSecFeePaymentAddress" 
                                                                                      name="txtaSecFeePaymentAddress" validarr="required@@tenderbrief:1000" 
                                                                                      tovalid="false" class="form-control" onblur="validateTxtComp(this)" title="<spring:message code="field_tendersec_fee_payment_at"/>" cols="20" rows="10"></textarea></div>
                                                                              </td>
                                                                          </tr>
                                                                          <tr>
                                                                                      <td width="50%"> 
                                                                                                  <label><spring:message code="lbl_emd_fee"/><span> *</span></label>
                                                                                                  <select class="form-control" title="<spring:message code="lbl_emd_fee"/>" onchange="javascript:{if(validateCombo(this)){getEmdDetail(this)}};"  name="selIsEMDApplicable" id="selIsEMDApplicable">
                                                                                                  <option value="">${label_select}</option>
                                                                                                  <option value="1">${allowed}</option>
                                                                                                  <option value="0" selected="selected">${notallowed}</option></select>
                                                                                                  </td>
                                                                                          <td width="50%"> 
                                                                                              <div id="emdMode2" style="display: none;"><div style="display: none;">
                                                                                                  <label>Mode of EMD payment<span> *</span></label>
                                                                                                  <select class="form-control"  name="selEmdPaymentMode" id="selEmdPaymentMode" onchange="getEmdAddress(this)">
                                                                                                  <option value="">${label_select}</option>
                                                                                                  <option value="2" selected="selected">${offline}</option>
                                                                                                  <option value="3">Both</option></select>
                                                                                                  </div></div>
                                                                                          </td>
                                                                                      </tr>
			<tr id="trEmdDetail" style="display: none;">
                                                                                  <td width="50%"> 
                                                                                      <div id="tdEmdAmt2">
                                                                                           id="tdEmdAmt2">
                                                                                          <label><spring:message code="field_emdamt"/><span> *</span></label>
                                                                                          <input id="txtEmdAmount" name="txtEmdAmount" class="form-control"  type="text" validarr="required@@lengthForNum:10@@numanduptodecimal:2" tovalid="false" onblur="validateTxtComp(this)" title="<spring:message code="field_emdamt"/>" wordconversion="false"></div>
                                                                                  </td>
                                                                                  <td width="25%">                                                                                                            
                                                                                      <div id="EmdPaymentAt2" style="display: none;"> 
                                                                                          <label><spring:message code="field_emdpaymentat"/><span> *</span></label>
                                                                                          <textarea class=" form-control "  id="txtaEmdPaymentAddress" name="txtaEmdPaymentAddress" validarr="required@@tenderbrief:1000" tovalid="false" onblur="validateTxtComp(this)" title="<spring:message code="field_emdpaymentat"/>" cols="20" rows="10"></textarea></div>
                                                                                  </td>
                                                                              </tr>
                                                                              <tr>
                                                    <td style="display:none"><label>Event wise registration charges applicable<span> *</span></label>
                                                    <div>
                                                    <select class="form-control"  name="selIsRegistrationCharges" id="selIsRegistrationCharges">
                                                    <option value="">${label_select}</option>
                                                    <option value="1">${allowed}</option><option value="0" selected="selected">${notallowed}</option>
                                                    </select>
                                                    </div>
                                                    </td>
                                                    <td>&nbsp;</td>
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
                                                                                      <button type="submit" class="blue-button-small a-center">Submit</button></td>
                                                                                          </tr>
                                      					</tbody></table>
                                      					</div>
                                                         
                                       
                        <input type="hidden" id="hdDeptId" name="hdDeptId" value="1">
                        <input type="hidden" id="hdEventTypeId" name="hdEventTypeId" value="1">
                        <input type="hidden" id="hdOpType" name="hdOpType" value="">
                        <input type="hidden" id="hdTenderId" name="hdTenderId" value=""></div>
                        <input type="hidden" id="hdcorrigendumId" name="hdcorrigendumId" value="${corrigendumId}"></div>
                        </form></section></div></div>
	<%@include file="../../includes/footer.jsp"%>
	</div></div></div>

</body>
</html>