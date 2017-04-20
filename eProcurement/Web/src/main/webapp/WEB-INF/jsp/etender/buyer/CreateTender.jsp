<%@include file="../../includes/head.jsp"%>
<%@include file="../../includes/masterheader.jsp"%>
<script src="${pageContext.servletContext.contextPath}/resources/js/jQuery/jquery.datetimepicker.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/tenderCommonJS.js"></script>
	<spring:message code="client_dateformate_hhmm" var="client_dateformate_hhmm"/>
	<spring:message code="lbl_notallowed" var="notallowed"/>
	<spring:message code="lbl_allowed" var="allowed"/>
	<spring:message code="label_online" var="online"/>
	<spring:message code="label_offline" var="offline"/>
	<spring:message code="label_select" var="label_select"></spring:message>
	<spring:message code="lbl_projectduration" var="lbl_projectduration"/>
	<spring:message code="label_yes" var="label_yes"/>
	<spring:message code="label_no" var="label_no"/>
	<spring:message code="field_rebate" var="field_rebate"/>
	<spring:message code="lbl_weight_evaluation_require" var="lbl_weight_evaluation_require"/>
<div class="content-wrapper">
	<section class="content-header">
	<h1 class="inline">
		<c:choose>
			<c:when test="${not empty tenderDtBean}">
			<spring:message code="lbl_edit_tender"/>
			</c:when>
			<c:otherwise>
			<spring:message code="lbl_create_tender"/>
			</c:otherwise>
		</c:choose>
	</h1>
	<a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderListing" class="g g-back"><< <spring:message code="lbl_back_tenderlist"/></a>
	<c:if test="${not empty tenderDtBean}">
	 <a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}" class="g g-back" style="margin-right:7px;"><< <spring:message code="lbl_back_dashboard"/></a>
	</c:if>
</section>

<form id="tenderDtBean" name="tenderDtBean" onsubmit="return validateTenderSubmit();" action="${pageContext.servletContext.contextPath}/etender/buyer/addtender" method="post">

<div class="panel-container">

<section class="content">
	<div class="row">
		<div class="col-xs-12">
			<div class="box">
				<div class="box-header with-border">
					<h3 class="box-title">Organization Details</h3>
					<font size="1" class="pull-right mandatory m-top2" style="font-size: 12px; font-weight:400; float: right;"><spring:message code="msg_mandatoryFields"/></font>
                    <input type="hidden" id="hdIsDateValidationAllow" name="hdIsDateValidationAllow" value="2">
					<input type="hidden" name="isPastEvent" value="0">
                    <input type="hidden" name="selDecimalValueUpto" value="">
				</div>
				<div class="box-body">
					<div class="row">
						<div class="col-xs-12">
							                                                                                                                                     
                              <div class="row">
                              
                                             <div class="col-xs-6" id="deptTd">
                                             
                                             	 
                                             	 	<div class="row">
                                             	 		<div class="col-xs-3"><label class="lbl-3"><spring:message code="lbl_Organization"/></label></div>
                                             	 		<div class="col-xs-9"><div id="organization" class="lbl-2"></div><input type="hidden" name="organization" value="${grandParentDeptId}" /> </div>
                                             	 	</div>
                                             	 	
                                             	 	<div class="row">
                                             	 		<div class="col-xs-3"><label class="lbl-3"><spring:message code="lbl_department"/></label></div>
                                             	 		<div class="col-xs-9">
                                             	 		<c:choose>
	                                             	 		<c:when test="${parentDeptId gt 0}">
	                                             	 			<div id="parentDeptName" class="lbl-2"></div>
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
                                             	 	                       	 
                                                 </div>
                                                 
                                                 <div class="col-xs-6" id="tdDeptOfficer"> 
                                                 <div class="row">
                                                 <div class="col-xs-3"><label class="lbl-3"><spring:message code="lbl_username"/></label></div>
                                                 <div class="col-xs-9">
                                                 <div id="officerName" class="lbl-2">></div>
                                                     <select class="form-control" style="display: none" id="selName" name="selDeptOfficial"  onblur="javascript:{if(true){}}" title="Department Officer">
															<option value="${officerId}">${label_select}</option>
															</select>
                                                 </div>
                                                 </div>
                                                 <div class="row">
                                             	 		<div class="col-xs-3"><label class="lbl-3"><spring:message code="lbl_subdepartment"/></label></div>
                                             	 		<div class="col-xs-9">
                                             	 		<c:choose>
	                                             	 		<c:when test="${subDeptId gt 0}">
	                                             	 			<div id="subDeptName" class="lbl-2"></div>
	                                             	 		</c:when>
    	                                         	 		<c:otherwise>
    	                                         	 			<div>-</div>
    	                                         	 		</c:otherwise>
                                             	 		</c:choose>
                                             	 		<select style="display: none;" class="form-control" id="subDept" name="subDept"  onblur="javascript:{if(true){getOfficerList();}}" title="sub department">
															<option value="${subDeptId}">${label_select}</option>
															</select>
														</div>
                                             	 	</div>                                                                                              
                                                 </div>
                              </div>
                              </div>
                              </div>
                              </div>
                              </div>
                              </div>
                              
                              
                            <div class="col-xs-12">
					<div class="box">
				<div class="box-header with-border">
					<h3 class="box-title">Tender Basic Details</h3>
				</div>  
                  <div class="box-body">
                  <div class="row">
                              
                              	<div class="col-xs-6">
                              		<label class="lbl-1"><spring:message code="field_eventtype" var="varEventType"/>${varEventType}<span class="red"> *</span></label>
                                        		
                                        		                                      
                                   <select class="form-control" isrequired="true" title="${varEventType}" name="txtEventType" id="txtEventType">
                                   		<option value="">${label_select}</option>
                                        <c:forEach var="lstEventType" items="${eventTypeList}" > 
                                            <option value="${lstEventType[0]}">${lstEventType[1]}</option>
                                        </c:forEach>
                                    </select>
                                    <label class="lbl-1"><spring:message code="fields_refenceno"/><span class="red"> *</span></label>
                                      <input id="txtTenderNo" class=" form-control " name="txtTenderNo" type="text" validarr="required@@length:0,1000" tovalid="true" onblur="validateTextComponent(this)" title="<spring:message code="fields_refenceno"/>">
                                </div>
                                <div class="col-xs-6">
                                
                                </div>
                              </div>
                              
                              <div class="row">
                                  <div class="col-xs-12">                               
                                      <label class="lbl-1"><spring:message code="field_brief"/><span class="red"> *</span> </label>
                                      <textarea  class=" form-control "  id="txtaTenderBrief" name="txtaTenderBrief" validarr="required@@length:0,1000" tovalid="true" onblur="validateTextComponent(this)" validationmsg="Allows Max. 1000 alphabets, numbers and special characters" title="<spring:message code="field_brief"/>" class="line-height" cols="20" rows="10"></textarea>
                                  </div>
                              </div>
                              
                              <div class="row">
                                  <div class="col-xs-12">
                                  <label class="lbl-1"><spring:message code="field_tender_detail" var="description"/> 
                                      ${description}<span class="red"> *</span></label>
										<textarea  class="form-control rtfTenderDetail"  id="rtfTenderDetail" name="rtfTenderDetail" tovalid="true"  validarr="required@@length:0,10000"  title="${description}" cols="20" rows="10" >  </textarea>
                                  </div>
                              </div>  
                                  
                              <div class="row">
							              	<div class="col-xs-6">
							              	<label class="lbl-1"><spring:message code="lbl_bidding_variant"/><span class="red"> *</span></label>
                                                      <select class="form-control" title="<spring:message code="lbl_bidding_variant"/>" onchange="validateCombo(this)" isrequired="true" name="selBiddingVariant" id="selBiddingVariant">
                                                      <option value="">${label_select}</option>
                                                      <option value="1" ><spring:message code="label_buy"/></option><option value="2"><spring:message code="label_sell"/></option></select>
							              	</div>
							              </div>
                                  
                              <div class="row">
                              		<div class="col-xs-6">
                              		<label class="lbl-1"><spring:message code="lbl_type_of_contract"/><span class="red"> *</span></label>
                                        		<select class="form-control" title="<spring:message code="lbl_type_of_contract"/>" isrequired="true"   name="selProcurementNatureId" id="selProcurementNatureId" onchange="javascript:{if(validateCombo(this)){checkForOtherOption(this);}}">
                                        		<option value="">${label_select}</option>
                                        		<c:forEach items="${tblProcurementNature}" var="item"> 
                                        			<option value="${item[0]}">${item[1]}</option>
                                        		</c:forEach>
                                        		</select>
                              		</div>
                                    <div class="col-xs-6"> 
                                       <div width="50%" style="display: none" id="trOtherProcNature">
                                  	<label class="lbl-1">&nbsp;</label>
                                  	<input id="txtOtherProcNature" name="txtOtherProcNature" class=" form-control " type="text" 
                                  	validarr="required@@length:0,50@@tenderbrief" tovalid="false" onblur="validateTextComponent(this)" title="Type of contract" 
                                  	validationmsg="Alphabets and special characters ((, ), dot,-,comma, /) with Max. allowed length 50 characters ">
                                  	</div>         
                                    </div>                                   
                              </div>
                                                          
                           	  <div class="row" id="keywordTR">
                                  <div class="col-xs-6" id="keywordTd"> 
                                      <label class="lbl-1"><spring:message code="fields_tender_keywords" var="lblkeyword"/> 
                                      ${lblkeyword }<span class="red"> *</span></label>
                                      <select id="selKeywords" class="form-control" multiple="multiple" name="selKeywords" title="${lblkeyword}" onchange="validateCombo(this)" >
										<c:if test="${not empty categoryList }">
											<c:forEach items="${categoryList}" var="category">
												<option selected="selected" value="${category[0]}">${category[1]}</option>
											</c:forEach>
										</c:if>
									</select>
									<input type="hidden" name="categoryText" id="categoryText">
                                  </div>
                                 
                              </div>
                              
                              
                              
                              <div class="row">
                                  <div class="col-xs-6">
                                      <label class="lbl-1"><spring:message code="lbl_tender_value"/></label>
                                      <input id="txtTenderValue" name="txtTenderValue" validarr="length:0,12@@numanduptodecimal:2" tovalid="false" onblur="validateTextComponent(this)" type="text" class=" form-control "
                                        title="<spring:message code="lbl_tender_value"/>" maxlength="12">
                                  </div>
                                  <div class="col-xs-6">
                                              <label class="lbl-1">${lbl_projectduration}<span></span></label>
                                              <input id="txtProjectDuration" name="txtProjectDuration" class=" form-control " 
                                              type="text" validarr="length:0,8@@numanduptodecimal:2" maxlength="8" tovalid="false" onblur="validateTextComponent(this)" 
                                              title="Project duration / delivery or completion period">
                                 </div>
                              </div>
                              
                              <div class="row">
                                  
                                 <div class="col-xs-6">
                                 <label class="lbl-1"><spring:message code="fields_basecurrency"/><span class="red"> *</span></label>
                                      <select class="form-control" title="<spring:message code="fields_basecurrency"/>" name="selCurrencyId" id="selCurrencyId" 
                                      onchange="javascript:{if(validateCombo(this)){setGlobalCurrencySelect(this)}}" isrequired="true">
                                   	<option value="">${label_select}</option>
                                   	<c:forEach items="${tblCurrencyList}" var="currencyVar"> 
                                   		<c:choose>
                                   			<c:when test="${empty tblCurrencyMapList}">
                                   				<option value="${currencyVar[0]}">${currencyVar[1]}</option>
                                   			</c:when>
                                   			<c:when test="${tblCurrencyMapList[currencyVar[0]] eq currencyVar[0]}">
                                   				<option value="${currencyVar[0]}">${currencyVar[1]}</option>
                                   			</c:when>
                                   		</c:choose>
                                   	</c:forEach></select>
                                 </div>
                              </div>
                              
                              <div class="row">
                              	  <div class="col-xs-6"> 
                                              <label class="lbl-1"><spring:message code="lbl_biddingType"/><span class="red"> *</span></label>
                                              <select class="form-control"  name="selBiddingType" id="selBiddingType" onchange="changeBiddingType(this)" >
                                              <option value="1" ><spring:message code="lbl_national_competitive_bidding" /></option>
                                              <option value="2"><spring:message code="lbl_international_competitive_bidding" /></option>
                                              </select>
								  </div>
                                  <div class="col-xs-6"> 
                                     <div id="trBidCurrency" style="display: none">
                                     	<input type="hidden" name="txtCommaSepCur" id="txtCommaSepCur" value="">
                                      <table width="100%" id="tableCurrency" cellpadding="0" cellspacing="0" border="0" class="no-border">
                                           <tbody><tr>
                                           	<td class="currency-checkbox p-bottom-none" colspan="2">
													<label class="lbl-1"><spring:message code="label_bidding_currency"/></label>
                                               	    <div class="row">
                                               	    <c:forEach items="${tblCurrencyList}" var="currencyVar" varStatus="indx">
														<c:choose>
															<c:when test="${empty tblCurrencyMapList}">
																<div class="col-md-2">
																<input type="checkbox" name="chkCurrency" id="chkCurrency_${indx.index}" onclick="return keepSelectedCurrency(this);"
																	value="${currencyVar[0]}">${currencyVar[1]}
																	</div>
	                                  							</c:when>
															<c:when test="${tblCurrencyMapList[currencyVar[0]] eq currencyVar[0]}">
																<div  class="col-md-2">
																<input type="checkbox" name="chkCurrency" id="chkCurrency_${indx.index}" onclick="return keepSelectedCurrency(this);"
																	value="${currencyVar[0]}">${currencyVar[1]}
																	</div>
	                                  							</c:when>
														</c:choose>
													</c:forEach>
													</div>
                                           </td>
                                           </tr>
                                      </tbody></table>
                                     </div>  
                                  </div>                                
                              </div>
                              
                              
                              
                              
                          
                                  <input type="hidden" id="txtRmvFormList" name="txtRmvFormList" value="">
                          
						</div>
					</div>
				</div>
			
		
		
		<div class="col-xs-12">
			<div class="box">
				<div class="box-header with-border">
					<h3 class="box-title"><spring:message code="title_bid_submission_conf"/></h3>
				</div>
				<div class="box-body">
					<div class="row">
						<div class="col-xs-12">
						
						<div class="clearfix formfield">
						
						<div class="row">
                                  <div class="col-xs-4">
                                      <label class="lbl-1"><spring:message code="lbl_envelope"/><span class="red"> *</span></label>		
                                      <select class="form-control"  name="selFormType" id="selFormType" 
                                      onchange="javascript:{if(validateCombo(this)){changeInEnvelopeSelection(this)}}" 
                                      isrequired="true" title="Envelope" size="5" multiple="">
                                      <c:forEach items="${listTblEnv}" var="tblEnv"> 
                                      <option value="${tblEnv.envId}">${tblEnv.lang1}</option>
                                      </c:forEach>
                                      </select>
                                      <span id="errFormTypeValidation" class="red"></span>
                                  </div>
                                  <div class="col-xs-6">
                                  
                                  </div>
                              </div>
						
						<div class="row">
							<div class="col-xs-4">
							<div id="tdIsItemwiseWinner">
							<spring:message code="lbl_itemwise_lh" var="lbl_itemwise_lh"/> 
                                              <label class="lbl-1">${lbl_itemwise_lh}<span class="red"> *</span></label>
                                              <select class="form-control" isrequired="true" title="${lbl_itemwise_lh}" onchange="javascript:{if(validateCombo(this)){changeRebate($('#selFormType'));showWeightEvaluation(this);}}" name="selIsItemwiseWinner" id="selIsItemwiseWinner">
                                              <option value="">${label_select}</option>
                                              <option value="1"><spring:message code="label_itemwise"/></option>
                                              <option value="0" ><spring:message code="label_eventwise"/></option>
                                              </select>
							</div>
							</div>
							<div class="col-xs-4">
							<div id="tdIsRebateApplicable">
							<label class="lbl-1">${field_rebate}<span class="red">  *</span></label>
                                              <select class="form-control"  name="selIsRebateApplicable" title="${field_rebate}" id="selIsRebateApplicable" onchange="validateCombo(this)">
                                              <option value="">${label_select}</option>
                                              <option value="1">${allowed}</option>
                                              <option value="0" selected="selected">${notallowed}</option>
                                              </select>
							</div>
							</div>
							<div class="col-xs-4">
							<div id="tdIsWeightEval">
							<label class="lbl-1">${lbl_weight_evaluation_require}<span class="red"> *</span></label>
                                              <select class="form-control"  name="selIsWeightageEvaluationRequired" title="${lbl_weight_evaluation_require}" id="selIsWeightageEvaluationRequired" onchange="validateCombo(this)">
                                              <option value="">${label_select}</option>
                                              <option value="1">${allowed}</option>
                                              <option value="0" selected="selected">${notallowed}</option>
                                              </select>
							</div>
							</div>
						</div>
						
						<div class="row">
							<div class="col-xs-4">
							 <label class="lbl-1"><spring:message code="lbl_bidding_access"/><span class="red"> *</span></label>
                                              <select class="form-control" isrequired="true" onchange="validateCombo(this)" title="<spring:message code="lbl_bidding_access"/>" name="selTenderMode" id="selTenderMode">
                                              <option value="">${label_select}</option>
                                              <option value="1"><spring:message code="label_open"/></option>
                                              <option value="2" ><spring:message code="label_limited"/></option>
                                              <option value="3"><spring:message code="label_single"/></option>
                                              </select>
							</div>
							<div class="col-xs-4">
							<div id="trDocSubmission" style="display: none;">
							<label class="lbl-1">Document to be submitted physically<span class="red"> *</span></label>
                                                          <textarea class=" form-control "  id="txtaDocumentSubmission" name="txtaDocumentSubmission" 
                                                          validarr="required@@tenderbrief:1000" tovalid="false" onblur="validateTextComponent(this)"
                                                          title="Document to be submitted physically" style="width:78%;" cols="20" rows="3"></textarea>
							</div>
							<label class="lbl-1"><spring:message code="lbl_consortium"/><span class="red"> *</span></label>
                                              <select class="form-control" title="<spring:message code="lbl_consortium"/>" name="selIsFormBasedConsortium" onchange="validateCombo(this)" isrequired="true" id="selIsFormBasedConsortium">
                                              <option value="">${label_select}</option>
                                              <option value="1">${allowed}</option><option value="0" >${notallowed}</option></select>
							</div>
							<div class="col-xs-4">
							<label class="lbl-1"><spring:message code="lbl_bidwithdrawal"/><span class="red"> *</span></label>
                                              <select title="<spring:message code="lbl_bidwithdrawal"/>" class="form-control"  name="selIsBidWithdrawal" id="selIsBidWithdrawal" onchange="validateCombo(this)" isrequired="true">
                                              <option value="">${label_select}</option>
                                              <option value="1" >${allowed}</option><option value="0">${notallowed}</option></select>
							</div>
						</div>
						
						<div class="row">
                               <div class="col-xs-4">
                                  <label class="lbl-1"><spring:message code="lbl_emvelope_type" var="lbl_emvelope_type"/>${lbl_emvelope_type}<span class="red"> *</span></label>
                                              <select class="form-control" isrequired="true" title="${lbl_emvelope_type}" name="selEnvelopeType" id="selEnvelopeType" onchange="javascript:{if(validateCombo(this)){changeEnvelopeValue(this)}};">
                                              <option value="">${label_select}</option>
                                              <option value="1" ><spring:message code="lbl_evaluation_singlestage"/> </option><option value="2"><spring:message code="lbl_evaluation_multiestage"/></option>
                                              </select>
                                  </div>
                                  			
                                  <div class="col-xs-4">
							              		<label class="lbl-1"><spring:message code="lbl_workflow_requires"/><span class="red"> *</span></label>
                                                              <select class="form-control" title="<spring:message code="lbl_workflow_requires"/>" isrequired="true" onchange="validateCombo(this)" name="selIsWorkflowRequired" id="selIsWorkflowRequired">
                                                              <option value="">${label_select}</option>
                                                              <option value="1" >${label_yes}</option><option value="0">${label_no}</option>
                                                              </select>
							              	</div>
							              	<div class="col-xs-4">
							              		<label class="lbl-1"><spring:message code="lbl_auto_result_sharing"/><span class="red"> *</span></label>
                                                              <select class="form-control" title="<spring:message code="lbl_auto_result_sharing"/>" onchange="validateCombo(this)" isrequired="true" name="selAutoResultSharing" id="selAutoResultSharing"  >
                                                              <option value="">${label_select}</option>
                                                              <option value="0" ><spring:message code="lbl_auto"/></option>
                                                              <option value="1"><spring:message code="lbl_manual"/></option>
                                                              </select>
							              	</div>			
							              	
                              </div>
                              
                              <div class="row">
                              
                              <div class="col-xs-4">
							              		<label class="lbl-1"><spring:message code="lbl_prebid_meeting"/><span class="red"> *</span></label>
                                                    <select class="form-control" title="<spring:message code="lbl_prebid_meeting"/>"  onchange="javascript:{if(validateCombo(this)){modeOfPrebidMeeting(this)}}" isrequired="true" name="selIsPreBidMeeting" id="selIsPreBidMeeting">
                                                    <option value="">${label_select}</option>
                                                    <option value="1">${allowed}</option><option value="0" >${notallowed}</option>
                                                    </select>
							              	</div>
							              	<div class="col-xs-4">
							              		<div id="trPreBidMeetingAddress" style="display: none;">
							              			<spring:message code="lbl_prebid_address" var="lbl_prebid_address"/>
                                                          <label class="lbl-1">${lbl_prebid_address}<span class="red">*</span></label>
                                                          <textarea class=" form-control "  id="txtaPreBidAddress" name="txtaPreBidAddress"
                                                           validarr="required@@tenderbrief:1000" tovalid="false" onblur="validateTextComponent(this)" 
                                                           title="${lbl_prebid_address}" cols="20" rows="10"></textarea>
							              		</div>
							              		
							              	</div>
                              
							              	
							              </div>
                              
                        
						                        
              </div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="clearfix formfield" id="paymentfees">
		
		<div class="col-xs-12">
			<div class="box">
				<div class="box-header with-border">
					<h3 class="box-title"><spring:message code="title_doc_emd_secfees"/></h3>
				</div>
				<div class="box-body">
					<div class="row">
						<div class="col-xs-12">
							
							<div id="feesDtl">
							
								<div class="row">
									<div class="col-xs-6">
									<div id="docfeesApplicableTd">
									<label><spring:message code="lbl_document_fees"/><span class="red"> *</span></label>
                                                                                          <select class="form-control" title="<spring:message code="lbl_document_fees"/>"  name="selIsDocfeesApplicable" id="selIsDocfeesApplicable" onchange="javascript:{if(validateCombo(this)){changeDocFeeDetail(this)}}" class="form-control" >
                                                                                          <option value="">${label_select}</option>
                                                                                          <option value="1">${allowed}</option>
                                                                                          <option value="0" selected="selected">${notallowed}</option></select>
									</div>
									</div>
									<div id="trDocAmtAndAdd" style="display: none;">
									<div class="col-xs-6">
										<label><spring:message code="fields_fees_amt"/><span class="red"> *</span></label>
                                        <input id="txtDocumentFee" name="txtDocumentFee"  type="text" validarr="required@@lengthForNum:8@@numanduptodecimal:2@@onetonine" maxlength="8" tovalid="false" onblur="validateTextComponent(this)" title="<spring:message code="fields_fees_amt"/>" class="form-control">
									</div>
									<div class="col-xs-12">
										<div id="docAddress2">
                                          <label class="lbl-1"><spring:message code="field_docfees_payableat"/><span class="red"> *</span></label>
                                          <textarea class=" form-control "  id="txtaDocFeePaymentAddress" name="txtaDocFeePaymentAddress" validarr="required@@tenderbrief:1000" tovalid="false" onblur="validateTextComponent(this)" title="<spring:message code="field_docfees_payableat"/>" cols="20" rows="10"></textarea></div>
									</div>
									</div>
								</div>
								
								<div class="row">
									<div class="col-xs-6">
										<label class="lbl-1"><spring:message code="lbl_security_fee"/><span class="red"> *</span></label>
                                                                                    <select class="form-control" title="<spring:message code="lbl_security_fee"/>" name="selIsSecurityfeesApplicable" id="selIsSecurityfeesApplicable" onchange="javascript:{if(validateCombo(this)){getSecurityFeesDetail(this)}}">
                                                                                    <option value="">${label_select}</option>
                                                                                    <option value="1">${allowed}</option>
                                                                                    <option value="0" selected="selected">${notallowed}</option></select>
									</div>
									<div id="trSecFeeAllowed" style="display: none;">
										<div class="col-xs-6">
											<label class="lbl-1"><spring:message code="field_tendersec_fees_amt"/><span class="red"> *</span></label>
                                            <input id="txtSecurityFee" class="form-control" name="txtSecurityFee"  type="text" validarr="required@@lengthForNum:8@@numanduptodecimal:2@@onetonine" tovalid="false" maxlength="8" onblur="validateTextComponent(this)" title="Event security fees amount">
										</div>
										<div class="col-xs-12">
											<label class="lbl-1"><spring:message code="field_tendersec_fee_payment_at"/><span class="red"> *</span></label>
                                                                                      <textarea class=" form-control "  id="txtaSecFeePaymentAddress" 
                                                                                      name="txtaSecFeePaymentAddress" validarr="required@@tenderbrief:1000" 
                                                                                      tovalid="false" class="form-control" onblur="validateTextComponent(this)" title="<spring:message code="field_tendersec_fee_payment_at"/>" cols="20" rows="10"></textarea>
										</div>
									</div>
								</div>
								
								<div class="row">
									<div class="col-xs-6">
										<label class="lbl-1"><spring:message code="lbl_emd_fee"/><span class="red"> *</span></label>
                                                                                                  <select class="form-control" title="<spring:message code="lbl_emd_fee"/>" onchange="javascript:{if(validateCombo(this)){changeEmdDetail(this)}};"  name="selIsEMDApplicable" id="selIsEMDApplicable">
                                                                                                  <option value="">${label_select}</option>
                                                                                                  <option value="1">${allowed}</option>
                                                                                                  <option value="0" selected="selected">${notallowed}</option></select>
									</div>
									<div id="trEmdAllowed" style="display: none;">
										<div class="col-xs-6">
											<label class="lbl-1"><spring:message code="field_emdamt"/><span class="red"> *</span></label>
                                            <input id="txtEmdAmount" name="txtEmdAmount" class="form-control"  type="text" validarr="required@@lengthForNum:8@@numanduptodecimal:2" maxlength="8" tovalid="false" onblur="validateTextComponent(this)" title="<spring:message code="field_emdamt"/>">
										</div>
										<div class="col-xs-12">
											<label class="lbl-1"><spring:message code="field_emdpaymentat"/><span class="red"> *</span></label>
                                                                                          <textarea class=" form-control "  id="txtaEmdPaymentAddress" name="txtaEmdPaymentAddress" validarr="required@@tenderbrief:1000" tovalid="false" onblur="validateTextComponent(this)" title="<spring:message code="field_emdpaymentat"/>" cols="20" rows="10"></textarea>
										</div>
									</div>
								</div>
							
							</div>
							
						</div>
					</div>
				</div>
			</div>
		</div>
		
		</div>
		
		<div class="col-xs-12">
			<div class="box">
				<div class="box-header with-border">
					<h3 class="box-title"><spring:message code="title_dates_conf"/></h3>
				</div>
				<div class="box-body">
					<div class="row">
						<div class="col-xs-12">
							 <div class="clearfix formfield">
							 
							 	<div class="row">
							 		<div class="col-xs-6">
							 		<label class="lbl-1"><spring:message code="lbl_document_start_date" /><!-- <span> *</span> --></label>
                                                                          <input id="txtDocumentStartDate" name="txtDocumentStartDate"  type="text"  
                                                                           onblur="changeDtValidationWhenReq(this)" datepicker="yes" dtrequired="false" 
                                                                           placeholder="${client_dateformate_hhmm}" title="<spring:message code="lbl_document_start_date" />" 
                                                                           class="dateBox pull-left form-control">
							 		</div>
							 		<div class="col-xs-6">
							 			<label class="lbl-1"><spring:message code="lbl_document_end_date" /><!-- <span> *</span> --></label>
                                                                          <input id="txtDocumentEndDate" name="txtDocumentEndDate"  type="text"  
                                                                          onblur="changeDtValidationWhenReq(this)" datepicker="yes" dtrequired="false" placeholder="${client_dateformate_hhmm}" 
                                                                          title="<spring:message code="lbl_document_end_date" />" class="dateBox pull-left form-control">
							 		</div>
							 	</div>
							 	
							 	<div class="row">
							 		<div class="col-xs-6">
							 			<label class="lbl-1"><spring:message code="lbl_bid_submission_start_date" /><!-- <span> *</span> --></label>
                                                                              <input id="txtSubmissionStartDate" name="txtSubmissionStartDate"  type="text"
                                                                               onblur="changeDtValidationWhenReq(this)" datepicker="yes" dtrequired="false" placeholder="${client_dateformate_hhmm}" 
                                                                               title="<spring:message code="lbl_bid_submission_start_date" />" class="dateBox pull-left form-control">
							 		</div>
							 		<div class="col-xs-6">
							 		 <label class="lbl-1"><spring:message code="lbl_bid_submission_end_date" /><!-- <span> *</span> --></label>
                                                                      <input id="txtSubmissionEndDate" name="txtSubmissionEndDate"  type="text"  onblur="changeDtValidationWhenReq(this)" datepicker="yes" 
                                                                      dtrequired="false" placeholder="${client_dateformate_hhmm}" title="<spring:message code="lbl_bid_submission_end_date" />" class="dateBox pull-left form-control">
							 		</div>
							 	</div>
							 	
							 	<div class="row">
							 		<div class="col-xs-6">
							 			<label class="lbl-1"><spring:message code="field_bidopeningstartdate" /><!-- <span> *</span> --></label>
                                                                      <input id="txtBidOpenDate" name="txtBidOpenDate"  type="text"  onblur="changeDtValidationWhenReq(this)" datepicker="yes" dtrequired="false"  
                                                                       placeholder="${client_dateformate_hhmm}" title="<spring:message code="field_bidopeningstartdate" />" class="dateBox pull-left form-control">
							 		</div>
							 		<div class="col-xs-6"></div>
							 	</div>
							 	
							 	<div class="row">
							 		<div id="trPreBidMeetingDate" style="display: none;">
							 		<div class="col-xs-6">
							 			<label class="lbl-1"><spring:message code="fields_prebidmeet_startdate" /><!-- <span> *</span> --></label>
                                                                      <input id="txtPreBidStartDate" name="txtPreBidStartDate"  type="text" onblur="validateEmptyDt(this)" datepicker="yes" placeholder="${client_dateformate_hhmm}" title="<spring:message code="fields_prebidmeet_startdate" />" 
                                                                      class="form-control dateBox pull-left">
							 		</div>
							 		<div class="col-xs-6">
							 			<label class="lbl-1"><spring:message code="fields_prebidmeet_enddate" /><!-- <span> *</span> --></label>
                                                                      <input id="txtPreBidEndDate" name="txtPreBidEndDate"  
                                                                      type="text" onblur="validateEmptyDt(this)" datepicker="yes" placeholder="${client_dateformate_hhmm}" 
                                                                      title="<spring:message code="fields_prebidmeet_enddate" />" class="dateBox pull-left form-control">
							 		</div>
							 		</div>
							 	</div>
							
                                     </div>
						</div>
					</div>
				</div>
			</div>
		</div>	
		
		<div class="col-xs-12">
		<div class="clearfix formfield">
		<button type="submit" class="btn btn-submit">Submit</button>
		</div>
		</div>
		
	</div>
</section>

</div>

<input type="hidden" id="hdDeptId" name="hdDeptId" value="1">
<input type="hidden" id="hdEventTypeId" name="hdEventTypeId" value="1">
<input type="hidden" id="hdOpType" name="hdOpType" value="">
<input type="hidden" id="hdTenderId" name="hdTenderId" value="">
</form>

</div>
                                                         

<script src="${pageContext.request.contextPath}/resources/js/tenderCommonJS.js"></script>
<script type="text/javascript">
            var wysihtml5Editor = "";
            var contextPath="${pageContext.servletContext.contextPath}";
            var onLoadFormType;
            var cstatus = 0;
            var opType = "";
           var dateFieldObject = new Object();
       	   $(document).ready(function(){
			     $('#organization').html('${organization}');
			     $('#parentDeptName').html('${parentDeptName}');
			     $('#subDeptName').html('${subDeptName}');
			     $('#officerName').html('${officerName}');
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
		       			step: 15
		       		});
		       	});
		       	 var arr = new Array();
		       	  <c:if test="${not empty tenderEnvelopeList}">
		       	   <c:forEach items="${tenderEnvelopeList}" var="tenderENV">
		       		   var key = ${tenderENV[2]};
		       			arr.push(key);
	      			</c:forEach>
		       	 </c:if>
		       	$("[name='selFormType']").val(arr)
		       	  
		       	wysihtml5Editor = $("#rtfTenderDetail").wysihtml5(); 
		       	onLoadFormType=$('#selFormType').val();              
                opType=$("#hdOpType").val();
                checkForOtherOption($("#selProcurementNatureId"));
	       		changeBiddingType($("#selBiddingType"));
	       		getSecurityFeesDetail($("#selIsSecurityfeesApplicable"))
	       		changeDocFeeDetail($("#selIsDocfeesApplicable"))
	       		changeEmdDetail($("#selIsEMDApplicable"));
	       		modeOfPrebidMeeting($("#selIsPreBidMeeting"))
	       		doProcessOnLoad();
	       		<c:forEach items="${tblTenderCurrency}" var="item">
	       			$("[name='chkCurrency'][value='${item[0]}']").prop("checked",true);
	       		</c:forEach>
       	   		});
        </script>   
        <%@include file="../../includes/footer.jsp"%>
