<!DOCTYPE html>
<html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../../includes/header.jsp"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script src="${pageContext.servletContext.contextPath}/resources/js/jquery-ui.min.js"></script>
<script type="text/javascript">
function confirmFinalsubmission(){
	if(confirm("After final submission you will not be allowed to alter anything within this tender.Are you sure want to do final submission ?")){
		$( "#finalFormId" ).submit();
	}
}
</script>
<spring:message code="lbl_back_dashboard" var='backDashboard'/>
<spring:message code="lbl_bid_prepare" var='lblPrepare'/>
<spring:message code="link_select_item" var="link_select_item"/>
<spring:message code="lbl_item_wise_doc" var="lblItemWiseDoc"/>
<spring:message code="link_delete" var="var_delete"/>
<spring:message code="link_tender_view" var="var_view"/>
<spring:message code="link_tender_fillagain" var="var_fillagain"/>
<spring:message code="link_tender_edit" var="var_edit"/>
<spring:message code='link_tender_mapdocs' var="varMap"/>
<spring:message code="lbl_mandatory_docname" var="mandatoryDoc"/>
<spring:message code="label_mappeddoc" var="mappedDoc"/>
<spring:message code='link_add' var="varAdd"/>
<spring:message code="link_edit" var="varEdit"/>
<spring:message code="link_tender_fill" var="var_fill"/>
<spring:message code="btn_finalsubmission" var="varFinalSubmission"/>
<spring:message code="msg_tender_delete_bid" var="var_msg_delbid"/>
<spring:message code="col_rebate" var="varRebate"/>
</head>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="../../includes/leftaccordion.jsp"%>

<div class="content-wrapper">

	<section class="content-header">
		<a href="${pageContext.servletContext.contextPath}/etender/bidder/biddingTenderDashboard/${tenderId}" class="btn btn-submit" style="margin-top:0px;"> 
			<c:if test="${tblTender.isAuction eq 0}"><< ${backDashboard}</c:if>
			<c:if test="${tblTender.isAuction eq 1}"><< Go To Auction Dashboard</c:if>
		</a>
	</section>

	<section class="content">
	  <div class="row">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			<div class="box">
				<c:if test="${not empty successMsg}">
					<div><span class="alert alert-success"><spring:message code="${successMsg}"/></span></div>
				</c:if>
				<c:if test="${not empty errorMsg}">
					<div><span class="alert alert-danger"><spring:message code="${errorMsg}"/></span></div>
				</c:if>
				<div class="box-header with-border">
					<h3 class="box-title">${lblPrepare}</h3>
				</div>
                                      
<div class="box-body">
	<div class="row">
		<div class="col-lg-12 col-md-12 col-xs-12">
			
     			<c:set var="isDisplayNotification" value="true" />
     			
			    <c:if test="${allowFinalSubmission ne 'Success' and allowFinalSubmission eq 'msg_tender_fs_finalsubmission_done'}">
			      <div class="alert alert-success">                               
			         <spring:message code="${allowFinalSubmission}" arguments="${msgArgumentOne};${msgArgumentTwo}" argumentSeparator=";"/>
			      </div>
			    </c:if>
			    
			    <div class="box-header with-border">
			    	<h3 class="box-title" style="font-size:15px;"><b><spring:message code="msg_bid_information" /></b></h3>
			    </div>
			                                     
			<c:if test = "${!isEncCertVerified}">
<%-- 		<div class="errorMsg t_space"><spring:message code="enc_notverified_certificate"/></div> --%>
					    </c:if>    
					    
					    <c:choose>
					         <c:when test="${not empty tenderFormLst and isCompanyMapped}">
                                                        
					                <c:set var="count" value="0"/>
                                                    
					                <c:if test="${isDisplayNotification}">
					                    <div class="m-top1 noticeMsg">
                                                               
					                        <c:if test="${false and isBidWithdrawal eq 1}"><spring:message code="msg_final_sub_notification_bid_withdraw"/></c:if>
					                    </div>
					                </c:if>
					                <c:forEach items="${tenderEnvelopeLst}" var="envData">
                                                           
					                <div class="row">
					                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
						                    <spring:message code="min_form_required_bidder" var="minFormRequiredForFS"/>
						                    <h3>${envData[1]}  (${minFormRequiredForFS} ${envData[3]})
							               		<c:if test="${!submissionEndDtLapse and !isFinalSubmission and tblTender.isItemSelectionPageRequired eq 1 and (tblTender.isItemwiseWinner ne 0) and (envData[2] eq 4 or envData[2] eq 5) and !isSecondaryPartner}">
													<font class="pull-right prefix1_10" size="3">
														<spring:url value="/etender/bidder/formitemselection/${tenderId}/${envData[0]}/0/0" var="urlSelectItem"/>
													<a href="${urlSelectItem}"></a>
													</font>
							                    </c:if>
					                    	</h3>
					                    </div>
					                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
											<font size="1" class="pull-right mandatory m-top1" style="margin-top:10px;">(<b class="red">*</b>) <spring:message code="msg_mandatoryFields"></spring:message></font>
									    </div>
									    <div class="col-lg-12 col-md-12 col-xs-12">
					                    <table class="table table-striped table-responsive">
					                    <c:choose>
					                    	<c:when test="${not empty tenderFormLst}">
                                                                    
					                        	<tr class="gradi">
			                                       <th width="35%" class="a-left"><spring:message code="lbl_form_name"/></th>
			                                       <th width="35%" class="a-left"><spring:message code="col_action"/></th>
			                                       <th width="22%" class="a-left"><spring:message code="col_refDoc"/></th>
			                                       <th width="22%" class="a-left"></th>
					                                       <c:if test="${tblTenderForm.isItemWiseDocAllowed eq 1}">
                                                                               
																<c:if test="${(envData[2] eq 4 || envData[2] eq 5)}"><th width="18%" class="a-left">${lblItemWiseDoc}</th></c:if>
					                                       </c:if>
					                            </tr>
					                            <c:forEach items="${tenderFormLst}" var="tndrFormData" varStatus="cnt">
					                            	<c:if test="${envData[0] eq tndrFormData[2]}">
                                                                          
					                                	<c:set value="0" var="hideFillLink"></c:set>
					                                     		<!--  If no item is selected by item selection then hide fill link -->
                                                                                      
															<c:if test="${tndrFormData[7] eq 1 and !submissionEndDtLapse and !isFinalSubmission and tblTender.isItemSelectionPageRequired eq 1 and tblTender.isItemwiseWinner ne 0 and (envData[2] eq 4 || envData[2] eq 5)}">
																
                                                                                                                            <c:if test="${biditemselected eq 0}"><c:set value="1" var="hideFillLink"></c:set></c:if>
										                    </c:if>
                      <!-- If any form is selected and other is not selected then show - to those   -->
					                                        <c:choose>
					                                         <c:when test="${tndrFormData[7] ne 1}">  <!--  IS pricebid --> 
					                                     		<c:set value="0" var="hideFillLink"></c:set>
					                                     	</c:when>
					                                     	<c:when test="${tblTender.isItemSelectionPageRequired eq 1 and biditemselected eq 1 and tndrFormData[7] eq 1 and not empty selFormByItemSelection and empty selFormByItemSelection[tndrFormData[0]]}">
					                                     		<c:set value="1" var="hideFillLink"></c:set>
					                                     	</c:when>
					                                    	</c:choose>
					                                    	
					                                        <c:choose>
					                                        	<c:when test="${tndrFormData[3] eq 'Cancelled'}">
					                                            	<tr>
					                                                	<td class="a-left">${tndrFormData[1]}</td>
					                                                    <td class="a-left">
					                                                    <span class="red"><spring:message code="lbl_tender_cancelled"/></span>
					                                                    	<c:if test="${tndrFormData[9] eq 0 and !isFinalSubmission}">
					                                                        <c:forEach items="${lstTenderBidDtls}" var="data" varStatus="stats">
					                                                       		<c:if test="${tndrFormData[0] eq data[2]}">
					                                                            |
																					<spring:url value="/eBid/Bid/viewForm/${tenderId}/${tndrFormData[0]}/${data[0]}/true" var="urlView"/>
					                                                            	<a href="${urlView}">${var_view}</a>
					                                                            |
																					<spring:url value="/etender/bidder/deletebid/${tenderId}/${tndrFormData[0]}/${data[0]}" var="urlDelete"/>
					                                                            	<a href="${urlDelete}" onclick="return confirm('${var_msg_delbid}')">${var_delete}</a>
																				</c:if>
					                                    					</c:forEach>
					                                						</c:if>
					                                                      </td>
					                                                    <td class="a-left">-</td>
					                                                    <c:if test="${tblTenderForm.isItemWiseDocAllowed eq 1 and (envData[2] eq 4 || envData[2] eq 5)}">
																		<td class="a-left">
																			<c:choose>  
                                                         						<c:when test="${tndrFormData[12] eq 1}">
                                                         							<c:set var="flag" value="0"/>	
                                                                					<c:if test="${tndrFormData[9] eq 0 and !isFinalSubmission}">
                                                                						<c:forEach items="${lstTenderBidDtls}" var="data" varStatus="stats">
                                                           									<c:if test="${tndrFormData[0] eq data[2]}">
	                                                           									<c:set var="flag" value="1"/>
						                                                                        <spring:url value="/eBid/Bid/viewForm/${tenderId}/${tndrFormData[0]}/${data[0]}/true" var="urlView"/>
					                                                            				<a href="${urlView}">${var_view}</a>
																							</c:if>
																						</c:forEach>
																					</c:if>
																					<c:if test="${flag eq 0}">-</c:if>
																				</c:when>
																                <c:otherwise> - </c:otherwise>
																                </c:choose>
																		</td>
																		</c:if>
                                                   					</tr>
				                                               </c:when>
				                                               <c:otherwise>
				                                                   <c:choose>
				                                                       <c:when test="${!submissionEndDtLapse and !isFinalSubmission}">
                                                           <c:choose>
                                                               <c:when test="${isBidPrepared}">
                                                                   <c:set var="counter" value="1"/>
                                                                   <c:set var="FBCount" value="0"/>
                                                                   <c:forEach items="${lstTenderBidDtls}" var="data" varStatus="stats">
                                                                       <c:choose>
                                                                           <c:when test="${tndrFormData[0] eq data[2]}">
                                                                               <tr>
                                                                                   <c:set var="count" value="${count+1}"/>
                                                                                   <c:choose>
                                                                                       <c:when test="${tndrFormData[9] eq 1}">
                                                                                           <c:choose>
                                                                                               <c:when test="${counter eq 1}">
                                                                                                   <td class="a-left">
                                                                                                       ${tndrFormData[1]}
                                                                                                       <c:if test="${tndrFormData[5] eq 1}"><span class="red">*</span></c:if>
                                                                                                       <c:if test="${allowFinalSubmission eq 'msg_tender_fs_fillall_draft_forms' and data[3] eq 1}"><br/>[<spring:message code="lbl_form_save_as_draft" />]</c:if>
                                                                                                           <br/><br/>
                                                                                                           <div class="a-right">
                                                                                                               (<spring:message code="lbl_bid" /> - ${counter})
                                                                                                       </div>
                                                                                                   </td>
                                                                                                   <td class="a-left">
<%-- 																										<spring:url value="/etender/bidder/bidform/${tenderId}/${envData[0]}/${tndrFormData[0]}/0" var="urlFillAgain"/> --%>
<%-- 					                                                            						<a href="#">${var_fillagain}</a> --%>
<!-- 																										<br/><br/> -->
	                                                                                                    <spring:url value="/eBid/Bid/viewForm/${tenderId}/${tndrFormData[0]}/${data[0]}/true" var="urlView"/>
						                                                            					<a href="${urlView}">${var_view}</a>
						                                                            					<spring:url value="/eBid/Bid/viewForm/${tenderId}/${tndrFormData[0]}/${data[0]}/false" var="urlEdit"/>
					                                                            						| <a href="${urlEdit}">${var_edit}</a>
					                                                            						<spring:url value="/etender/bidder/deletebid/${tenderId}/${tndrFormData[0]}/${data[0]}" var="urlDelete"/>
					                                                            						| <a href="${urlDelete}" onclick="return confirm('${var_msg_delbid}')">${var_delete}</a>
                                                                                                       <c:if test="${tndrFormData[10] eq 1}">
                                                                                                       	<spring:url value="/etender/bidder/uploadbriefcasedocuments/${data[0]}/${tndrFormData[0]}/${tenderlinkProperties.bid_preparation_and_submission_create_bid}/2" var="urlMap"/>
                                                                                                           | <a href="#">${varMap}</a>  
                                                                                                       </c:if>
                                                                                                   </td>
                                                                                               </c:when>
                                                                                               <c:otherwise>
                                                                                                   <td class="a-right">
                                                                                                       <c:if test="${allowFinalSubmission eq 'msg_tender_fs_fillall_draft_forms' and data[3] eq 1}"><br/>[<spring:message code="lbl_form_save_as_draft" />]</c:if>
                                                                                                        <br/><br/>(<spring:message code="lbl_bid" /> - ${counter})
                                                                                                   </td>
                                                                                                   <td class="a-left">
                                                                                                         <spring:url value="/eBid/Bid/viewForm/${tenderId}/${tndrFormData[0]}/${data[0]}/true" var="urlView"/>
						                                                            					 <a href="${urlView}">${var_view}</a>
						                                                            					 <spring:url value="/eBid/Bid/viewForm/${tenderId}/${tndrFormData[0]}/${data[0]}/false" var="urlEdit"/>
                                                                                                      	 
					                                                            						| <a href="${urlEdit}">${var_edit}</a>
					                                                            						
                                                                                                       <spring:url value="/etender/bidder/deletebid/${tenderId}/${tndrFormData[0]}/${data[0]}" var="urlDelete"/>
					                                                            						| <a href="${urlDelete}" onclick="return confirm('${var_msg_delbid}')">${var_delete}</a>
					                                                            						 
                                                                                                       <c:if test="${tndrFormData[10] eq 1}">
                                                                                                           <spring:url value="/etender/bidder/uploadbriefcasedocuments/${data[0]}/${tndrFormData[0]}/${tenderlinkProperties.bid_preparation_and_submission_create_bid}/2" var="urlMap"/>
                                                                                                           | <a href="#">${varMap}</a>   
                                                                                                       </c:if>
                                                                                                   </td>
                                                                                               </c:otherwise>
                                                                                           </c:choose>
                                                                                           <c:choose>
                                                                                               <c:when test="${isDocUploaded}">
                                                                                                   <c:set var="token" value="0"/>
                                                                                                   <td class="a-left">
                                                                                                        <c:choose>
                                                                                                           <c:when test="${tndrFormData[11] eq 0}">
                                                                                                               <c:forEach items="${lstTenderBidderDocs}" var="docData" varStatus="status">
                                                                                                                   <c:choose>
                                                                                                                       <c:when test="${docData[0] eq data[0]}">
                                                                                                                       		<spring:url value="/ajax/downloadbriefcasefile/${docData[3]}/${data[0]}" var="urlDownloadFile"/>
					                                                            											<a href="${urlDownloadFile}">${docData[5]}</a>
                                                                                                                           <c:set var="token" value="${status.count}"/>
                                                                                                                       </c:when>
                                                                                                                       <c:otherwise>
                                                                                                                           <c:if test="${fn:length(lstTenderBidderDocs) eq status.count and token eq 0}">
                                                                                                                               <div class="a-left">-</div>
                                                                                                                           </c:if>
                                                                                                                       </c:otherwise>
                                                                                                                   </c:choose>
                                                                                                               </c:forEach>
                                                                                                           </c:when>
                                                                                                           <c:otherwise>
                                                                                                               <c:set var="token" value="0"/>
                                                                                                               <div class="cleafix">
                                                                                                                       <table class="table">
                                                                                                                           <c:set var="docCnt" value="1"/>
                                                                                                                           <c:set var="oldDocId" value="0" />
                                                                                                                           <c:forEach items="${lstTenderBidderDocs}" var="docData" varStatus="status">
                                                                                                                               <c:if test="${docData[0] eq data[0]}">
                                                                                                                                   <c:if test="${docCnt eq 1}">
                                                                                                                                       <tr class="gradi">
                                                                                                                                           <th>${mandatoryDoc}</th>
                                                                                                                                           <th>${mappedDoc}</th>
                                                                                                                                       </tr>
                                                                                                                                   </c:if>
                                                                                                                                   <c:if test="${oldDocId ne docData[6]}">
                                                                                                                                       <tr>
                                                                                                                                           <td>${not empty docData[7] ? docData[7] : '-'}</td>
                                                                                                                                           <td>
                                                                                                                                               <c:set value="${docData[6]}_${data[0]}" var="documentBidId"/>
                                                                                                                                               <c:set value="${fn:split(MandatoryFormDoc[documentBidId], ',')}" var="gDocRemark"/>
                                                                                                                                               <c:set value="${fn:length(gDocRemark)}" var="gDocRemarkLength"/>
                                                                                                                                               <c:forEach items="${gDocRemark}" var="docDetails" varStatus="gDocsrno">
                                                                                                                                                   <c:set value="${fn:split(docDetails,'#')[0]}" var="varRemarks"/>
                                                                                                                                                   <c:set value="${fn:split(docDetails,'#')[1]}" var="varId"/>
                                                                                                                                                   <c:set value="${fn:split(docDetails,'#')[2]}" var="docBidId"/>
                                                                                                                                                   <spring:url value="/ajax/downloadbriefcasefile/${varId}/${docBidId}" var="urlDownloadRemarks"/>
					                                                            																	<a href="${urlDownloadRemarks}">${varRemarks}</a>
                                                                                                                                                   ${gDocsrno.count eq  gDocRemarkLength ? ' ' : ' <br /><br />'}
                                                                                                                                                   <c:set var="token" value="${status.count}"/>
                                                                                                                                               </c:forEach>
                                                                                                                                           </td>
                                                                                                                                       </tr>
                                                                                                                                       <c:set var="oldDocId" value="${docData[6]}" />
                                                                                                                                   </c:if>
                                                                                                                                   <c:set var="docCnt" value="${docCnt+1}"/>
                                                                                                                               </c:if>
                                                                                                                               <c:if test="${fn:length(lstTenderBidderDocs) eq status.count and token eq 0}">
                                                                                                                                   <div class="a-left">-</div>
                                                                                                                               </c:if>
                                                                                                                           </c:forEach>
                                                                                                                       </table>
                                                                                                               </div>
                                                                                                           </c:otherwise>
                                                                                                       </c:choose>
                                                                                                   </td>
                                                                                               </c:when>
                                                                                               <c:otherwise>
                                                                                                   <td class="a-left">-</td>
                                                                                               </c:otherwise>
                                                                                           </c:choose>
                                                                                           <c:set var="counter" value="${counter+1}"/>
                                                                                       </c:when>
                                                                                       <c:otherwise>
                                                                                           <td class="a-left">
                                                                                               ${tndrFormData[1]}
                                                                                               <c:if test="${tndrFormData[5] eq 1}"><span class="red">*</span></c:if>
                                                                                               <c:if test="${allowFinalSubmission eq 'msg_tender_fs_fillall_draft_forms' and data[3] eq 1}"><br/>[<spring:message code="lbl_form_save_as_draft" />]</c:if>
                                                                                               <br>(${minFormRequiredTables} ${tndrFormData[14]})
                                                                                               </td>
                                                                                               <td class="a-left">
                                                                                               <spring:url value="/eBid/Bid/viewForm/${tenderId}/${tndrFormData[0]}/${data[0]}/true" var="urlView"/>
					                                                            				|<a href="${urlView}">${var_view}</a>
                                                                                               	<spring:url value="/eBid/Bid/viewForm/${tenderId}/${tndrFormData[0]}/${data[0]}/false" var="urlEdit"/>
					                                                            						| <a href="${urlEdit}">${var_edit}</a>
                                                                                               <spring:url value="/etender/bidder/deletebid/${tenderId}/${tndrFormData[0]}/${data[0]}" var="urlDelete"/>
					                                                            				<a href="${urlDelete}" onclick="return confirm('${var_msg_delbid}')">${var_delete}</a> 
                                                                                               <c:if test="${tndrFormData[10] eq 1}">
                                                                                                   <spring:url value="/etender/bidder/uploadbriefcasedocuments/${data[0]}/${tndrFormData[0]}/${tenderlinkProperties.bid_preparation_and_submission_create_bid}/2" var="urlMap"/>
                                                                                                           | <a href="#">${varMap}</a> 
                                                                                               </c:if>
                                                                                           </td>
                                                                                           <c:choose>
                                                                                               <c:when test="${isDocUploaded}">
                                                                                                   <td class="a-left">
                                                                                                       <c:choose>
                                                                                                           <c:when test="${tndrFormData[11] eq 0}">
                                                                                                               <c:set var="cnt" value="0"/>
                                                                                                               <c:forEach items="${lstTenderBidderDocs}" var="docData" varStatus="stat">
                                                                                                                    <c:choose>
                                                                                                                           <c:when test="${docData[0] eq data[0]}">
                                                                                                                           	<spring:url value="/ajax/downloadbriefcasefile/${docData[3]}/${data[0]}" var="urlDownloadFile"/>
					                                                            											<a href="${urlDownloadFile}">${docData[5]}</a>
                                                                                                                               <c:set var="cnt" value="${stat.count}"/>
                                                                                                                           </c:when>
                                                                                                                           <c:otherwise>
                                                                                                                               <c:if test="${fn:length(lstTenderBidderDocs) eq stat.count and cnt eq 0}">
                                                                                                                                   <div class="a-left">-</div>
                                                                                                                               </c:if>
                                                                                                                           </c:otherwise>
                                                                                                                       </c:choose>
                                                                                                               </c:forEach>
                                                                                                           </c:when>
                                                                                                           <c:otherwise>
                                                                                                                   <c:set var="cnt" value="0"/>
                                                                                                                   <div class="cleafix">
                                                                                                                       <table class="table">
                                                                                                                           <c:set var="docCnt" value="1"/>
                                                                                                                           <c:set var="oldDocId" value="0" />
                                                                                                                           <c:forEach items="${lstTenderBidderDocs}" var="docData" varStatus="stat">
                                                                                                                                   <c:if test="${docData[0] eq data[0]}">
                                                                                                                                       <c:if test="${docCnt eq 1}">
                                                                                                                                           <tr class="gradi">
                                                                                                                                               <th>${mandatoryDoc}</th>
                                                                                                                                               <th>${mappedDoc}</th>
                                                                                                                                           </tr>
                                                                                                                                       </c:if>
                                                                                                                                       <c:if test="${oldDocId ne docData[6]}">
                                                                                                                                           <tr>
                                                                                                                                               <td>${not empty docData[7] ? docData[7] : '-'}</td>
                                                                                                                                               <td>
                                                                                                                                                   <c:set value="${docData[6]}_${data[0]}" var="documentBidId"/>
                                                                                                                                                   <c:set value="${fn:split(MandatoryFormDoc[documentBidId], ',')}" var="gDocRemark"/>
                                                                                                                                                   <c:set value="${fn:length(gDocRemark)}" var="gDocRemarkLength"/>
                                                                                                                                                   <c:forEach items="${gDocRemark}" var="docDetails" varStatus="gDocsrno">
                                                                                                                                                       <c:set value="${fn:split(docDetails,'#')[0]}" var="varRemarks"/>
                                                                                                                                                       <c:set value="${fn:split(docDetails,'#')[1]}" var="varId"/>
                                                                                                                                                       <c:set value="${fn:split(docDetails,'#')[2]}" var="docBidId"/>
                                                                                                                                                       <spring:url value="/ajax/downloadbriefcasefile/${varId}/${docBidId}" var="urlDownloadRemarks"/>
					                                                            																		<a href="${urlDownloadRemarks}">${varRemarks}</a>
                                                                                                                                                       ${gDocsrno.count eq  gDocRemarkLength ? ' ' : ' <br /><br />'}
                                                                                                                                                       <c:set var="cnt" value="${stat.count}"/>
                                                                                                                                                   </c:forEach>
                                                                                                                                               </td>
                                                                                                                                           </tr>
                                                                                                                                           <c:set var="oldDocId" value="${docData[6]}" />    
                                                                                                                                       </c:if>
                                                                                                                                       <c:set var="docCnt" value="${docCnt+1}"/>
                                                                                                                                   </c:if>
                                                                                                                                   <c:if test="${fn:length(lstTenderBidderDocs) eq stat.count and cnt eq 0}">
                                                                                                                                       <div class="a-left">-</div>
                                                                                                                                   </c:if>
                                                                                                                           </c:forEach>
                                                                                                                       </table>
                                                                                                               </div>
                                                                                                           </c:otherwise>
                                                                                                       </c:choose>
                                                                                                       
                                                                                                   </td>
                                                                                               </c:when>
                                                                                               <c:otherwise>
                                                                                                   <td class="a-left">-</td>
                                                                                               </c:otherwise>
                                                                                           </c:choose>
                                                                                       </c:otherwise>
                                                                                   </c:choose>
                                                                                   <c:choose>                                                                                                            
                                                                                       <c:when test="${tndrFormData[12] eq 1 and tndrFormData[7] ne 1 and (envData[2] eq 4 || envData[2] eq 5)}">
					                                                                 		 <td class="a-left">
					                                                                 		 	<spring:url value="/etender/bidder/itemWiseDocUpload/${tenderId}/${envData[0]}/${tndrFormData[0]}/${data[0]}" var="urlItemWiseDoc"/>
					                                                                 		 	<a href="${urlItemWiseDoc}">${linkUploadDocs}</a>
					                                                                 	</c:when>
					                                                                 	<c:otherwise>
					                                                                 	  <c:if test="${tblTenderForm.isItemWiseDocAllowed eq 1}">
					                                                                 		<c:if test="${envData[2] eq 4 || envData[2] eq 5}"><td class="a-left">-</td></c:if>
					                                                                 	</c:if>
					                                                                 	</c:otherwise>
					                                                                </c:choose>
                                                                               </tr>
                                                                               <c:set var="FBCount" value="${FBCount+1}"/>
                                                                           </c:when>
                                                                           <c:otherwise>
                                                                               <c:if test="${fn:length(lstTenderBidDtls) eq stats.count and FBCount eq 0}">
                                                                                   <tr>
                                                                                       <c:set var="count" value="${count+1}"/>
                                                                                       <td class="a-left">
                                                                                           ${tndrFormData[1]}
                                                                                           <c:if test="${tndrFormData[5] eq 1}"><span class="red">*</span></c:if>
                                                                                           <c:if test="${tndrFormData[8] eq 1 and !isPkiMapped and tblTender.getIsCertRequired() eq 1}">
                                                                                                   &nbsp;<spring:message code="msg_tender_buyer_pk_ntupld"/>
                                                                                           </c:if><br>(${minFormRequiredTables} ${tndrFormData[14]})
                                                                                           </td>
                                                                                           <td class="a-left">
                                                                                           <c:choose>
                                                                                               <c:when test="${tndrFormData[8] eq 1 and !isPkiMapped  and tblTender.getIsCertRequired() eq 1}">-</c:when>
                                                                                               <c:otherwise>
	                                                                                               <c:choose>
	                                                                                               <c:when test="${hideFillLink eq 1 }">
	                                                                                               -
	                                                                                               </c:when>
	                                                                                               <c:otherwise>
<%-- 	                                                                                               	   <spring:url value="/etender/bidder/bidform/${tenderId}/${envData[0]}/${tndrFormData[0]}/0" var="urlFill"/> --%>
<%-- 																											<spring:url value="/eBid/Bid/viewForm/${tenderId}/${tndrFormData[0]}" var="urlFill"/> --%>
<%-- 																												<spring:url value="/eBid/Bid/FillBiddingForm?formId=${tndrFormData[0]}" var="urlFill"/> --%>
																												<spring:url value="/eBid/Bid/viewFormForEdit/${tenderId}/${tndrFormData[0]}" var="urlFill"/>
						                                                            					<a href="${urlFill}">${var_fill}</a>
																									</c:otherwise>
	                                                                                               </c:choose>
                                                                                               </c:otherwise>
                                                                                           </c:choose>
                                                                                       </td>
                                                                                       <td class="a-left"> - </td>
                                                                                       <c:choose>
                                                                                       	<c:when test="${envData[2] eq 4 || envData[2] eq 5}">
                                                                                       	 <c:if test="${fn:length(isItemWiseDocAllowed) gt 0}">
                                                                                       		<td class="a-left">-</td>
                                                                                       		</c:if>
                                                                                       	</c:when>
                                                                                       </c:choose>
                                                                                   </tr>
                                                                               </c:if>
                                                                           </c:otherwise>
                                                                       </c:choose>
                                                                   </c:forEach>
                                                               </c:when>
                                                               <c:otherwise>
                                                                   <tr>
                                                                       <c:set var="count" value="${count+1}"/>
                                                                       <td class="a-left">
                                                                           ${tndrFormData[1]}
                                                                           <c:if test="${tndrFormData[5] eq 1}"><span class="red">*</span></c:if>
                                                                           </td>
                                                                           <td class="a-left">
                                                                           <c:choose>
                                                                               <c:when test="${tndrFormData[8] eq 1 and !isPkiMapped  and tblTender.getIsCertRequired() eq 1}">-</c:when>
                                                                               <c:otherwise>
                                                                                 <c:choose>
                                                                                   <c:when test="${tndrFormData[7] eq 1 && hideFillLink eq 1 }">
                                                                                   -
                                                                                   </c:when>
                                                                                   <c:otherwise>
																								<spring:url value="/eBid/Bid/viewFormForEdit/${tenderId}/${tndrFormData[0]}" var="urlFill"/>
					                                                            		<a href="${urlFill}">${var_fill}</a>
                                                                                   </c:otherwise>
                                                                                  </c:choose>
                                                                               </c:otherwise>
                                                                           </c:choose>
                                                                       </td>
                                                                       <td class="a-left"> - </td>
																			<c:choose>
                                                                           	<c:when test="${envData[2] eq 4 || envData[2] eq 5}">
                                                                           	     <c:if test="${tblTenderForm.isItemWiseDocAllowed eq 1}">	<td class="a-left">-</td></c:if>
                                                                           	</c:when>
                                                                           </c:choose>
                                                                   </tr>
                                                               </c:otherwise>
                                                           </c:choose>
                                                       </c:when>
                                                       <c:otherwise>
                                                           <c:set var="count" value="${count+1}"/>
                                                           <c:set var="counter" value="1"/>
                                                           <c:set var="BDCount" value="0"/>
                                                           <c:choose>
                                                               <c:when test="${not empty lstTenderBidDtls}">
                                                                   <c:forEach items="${lstTenderBidDtls}" var="data" varStatus="stats">
                                                                       <c:choose>
                                                                           <c:when test="${tndrFormData[0] eq data[2]}">
                                                                               <c:set var="BDCount" value="${BDCount+1}"/>
                                                                               <tr>
                                                                                   <c:choose>
                                                                                       <c:when test="${tndrFormData[9] eq 1}">
                                                                                           <c:choose>
                                                                                               <c:when test="${counter eq 1}">
                                                                                                   <td class="a-left">
                                                                                                       ${tndrFormData[1]}
                                                                                                       <c:if test="${tndrFormData[5] eq 1}"><span class="red">*</span></c:if>
                                                                                                       <c:if test="${allowFinalSubmission eq 'msg_tender_fs_fillall_draft_forms' and data[3] eq 1}"><br/>[<spring:message code="lbl_form_save_as_draft" />]</c:if>
                                                                                                           <br/><br/>
                                                                                                           <div class="a-right">
                                                                                                               (<spring:message code="lbl_bid" /> - ${counter})
                                                                                                       </div>
                                                                                                   </td>
                                                                                                   <td class="a-left">
                                                                                                     <spring:url value="/eBid/Bid/viewForm/${tenderId}/${tndrFormData[0]}/${data[0]}/true" var="urlView"/>
					                                                            						<a href="${urlView}">${var_view}</a>
							
                                                                                                   </td>
                                                                                                   <td class="a-left">-</td>
                                                                                               </c:when>
                                                                                               <c:otherwise>
                                                                                                   <td class="a-right">
                                                                                                       <c:if test="${allowFinalSubmission eq 'msg_tender_fs_fillall_draft_forms' and data[3] eq 1}"><br/>[<spring:message code="lbl_form_save_as_draft" />]</c:if>
                                                                                                       (<spring:message code="lbl_bid" /> - ${counter})
                                                                                                   </td>
                                                                                                   <td class="a-left">
                                                                                                     <spring:url value="/etender/bidder/viewbidform/${tenderId}/${envData[0]}/${tndrFormData[0]}/${data[0]}/true" var="urlView"/>
					                                                            					<a href="${urlView}">${var_view}</a>
                                                                                                   </td>
                                                                                                   <td class="a-left">-</td>
                                                                                               </c:otherwise>
                                                                                           </c:choose>
                                                                                           <c:choose>
                                                                                               <c:when test="${isDocUploaded}">
                                                                                                   <td class="a-left">
                                                                                                       <c:choose>
                                                                                                           <c:when test="${tndrFormData[11] eq 0}">
                                                                                                               <c:set var="token" value="0"/>
                                                                                                               <c:forEach items="${lstTenderBidderDocs}" var="docData" varStatus="status">
                                                                                                                   <c:choose>
                                                                                                                       <c:when test="${docData[0] eq data[0]}">
                                                                                                                       <spring:url value="/ajax/downloadbriefcasefile/${docData[3]}/${data[0]}" var="urlDownloadFile"/>
					                                                            											<a href="${urlDownloadFile}">${docData[5]}</a>
                                                                                                                           <c:set var="token" value="${token+1}"/>
                                                                                                                       </c:when>
                                                                                                                       <c:otherwise>
                                                                                                                           <c:if test="${(fn:length(lstTenderBidderDocs) eq status.count) and token eq 0}">
                                                                                                                               <div class="a-left">-</div>
                                                                                                                           </c:if>
                                                                                                                       </c:otherwise>
                                                                                                                   </c:choose>
                                                                                                               </c:forEach>
                                                                                                           </c:when>
                                                                                                           <c:otherwise>
                                                                                                                   <c:set var="token" value="0"/>
                                                                                                                   <div class="cleafix">
                                                                                                                       <table class="table">
                                                                                                                           <c:set var="docCnt" value="1"/>
                                                                                                                           <c:set var="oldDocId" value="0" />
                                                                                                                           <c:forEach items="${lstTenderBidderDocs}" var="docData" varStatus="status">
                                                                                                                                   <c:if test="${docData[0] eq data[0]}">
                                                                                                                                       <c:if test="${docCnt eq 1}">
                                                                                                                                           <tr class="gradi">
                                                                                                                                               <th>${mandatoryDoc}</th>
                                                                                                                                               <th>${mappedDoc}</th>
                                                                                                                                           </tr>
                                                                                                                                       </c:if>
                                                                                                                                       <c:if test="${oldDocId ne docData[6]}">
                                                                                                                                           <tr>
                                                                                                                                               <td>${not empty docData[7] ? docData[7] : '-'}</td>
                                                                                                                                               <td>
                                                                                                                                                   <c:set value="${docData[6]}_${data[0]}" var="documentBidId"/>
                                                                                                                                                   <c:set value="${fn:split(MandatoryFormDoc[documentBidId], ',')}" var="gDocRemark"/>
                                                                                                                                                   <c:set value="${fn:length(gDocRemark)}" var="gDocRemarkLength"/>
                                                                                                                                                   <c:forEach items="${gDocRemark}" var="docDetails" varStatus="gDocsrno">
                                                                                                                                                       <c:set value="${fn:split(docDetails,'#')[0]}" var="varRemarks"/>
                                                                                                                                                       <c:set value="${fn:split(docDetails,'#')[1]}" var="varId"/>
                                                                                                                                                       <c:set value="${fn:split(docDetails,'#')[2]}" var="docBidId"/>
                                                                                                                                                           <spring:url value="/ajax/downloadbriefcasefile/${varId}/${docBidId}" var="urlDownloadRemarks"/>
					                                                            																			<a href="${urlDownloadRemarks}">${varRemarks}</a>
                                                                                                                                                       ${gDocsrno.count eq  gDocRemarkLength ? ' ' : ' <br /><br />'}
                                                                                                                                                       <c:set var="token" value="${token+1}"/>
                                                                                                                                                   </c:forEach>
                                                                                                                                               </td>
                                                                                                                                           </tr>
                                                                                                                                           <c:set var="oldDocId" value="${docData[6]}" />
                                                                                                                                       </c:if>
                                                                                                                                       <c:set var="docCnt" value="${docCnt+1}"/>
                                                                                                                                   </c:if>
                                                                                                                                   <c:if test="${(fn:length(lstTenderBidderDocs) eq status.count) and token eq 0}">
                                                                                                                                       <div class="a-left">-</div>
                                                                                                                                   </c:if>
                                                                                                                           </c:forEach>                                                                                                                                                    
                                                                                                                       </table>
                                                                                                               </div>
                                                                                                           </c:otherwise>
                                                                                                       </c:choose>
                                                                                                   </td>
                                                                                               </c:when>
                                                                                               <c:otherwise>
                                                                                               <c:if test="${tblTenderForm.isItemWiseDocAllowed eq 1}">
                                                                                                   <td class="a-left">-</td>
                                                                                                   </c:if>
                                                                                               </c:otherwise>
                                                                                           </c:choose>
                                                                                           <c:set var="counter" value="${counter+1}"/>
                                                                                       </c:when>
                                                                                       <c:otherwise>
                                                                                           <td>
                                                                                               ${tndrFormData[1]}
                                                                                               <c:if test="${tndrFormData[5] eq 1}"><span class="red">*</span></c:if>
                                                                                               <c:if test="${allowFinalSubmission eq 'msg_tender_fs_fillall_draft_forms' and data[3] eq 1}"><br/>[<spring:message code="lbl_form_save_as_draft" />]</c:if>
                                                                                               </td>
                                                                                               <td class="a-left">
                                                                                              <spring:url value="/etender/bidder/viewbidform/${tenderId}/${envData[0]}/${tndrFormData[0]}/${data[0]}/true" var="urlView"/>
					                                                            				<a href="${urlView}">${var_view}</a>
                                                                                           </td>
                                                                                           <c:choose>
                                                                                               <c:when test="${isDocUploaded}">
                                                                                                   <td class="a-left">
                                                                                                       <c:choose>
                                                                                                           <c:when test="${tndrFormData[11] eq 0}">
                                                                                                               <c:set var="token" value="0"/>
                                                                                                               <c:forEach items="${lstTenderBidderDocs}" var="docData" varStatus="status">
                                                                                                                   <c:choose>
                                                                                                                       <c:when test="${docData[0] eq data[0]}">
                                                                                                                           <spring:url value="/ajax/downloadbriefcasefile/${docData[3]}/${data[0]}" var="urlDownloadFile"/>
					                                                            											<a href="${urlDownloadFile}">${docData[5]}</a>
                                                                                                                           <c:set var="token" value="${token+1}"/>
                                                                                                                       </c:when>
                                                                                                                       <c:otherwise>
                                                                                                                           <c:if test="${(fn:length(lstTenderBidderDocs) eq status.count) and token eq 0}">
                                                                                                                               <div class="a-left">-</div>
                                                                                                                           </c:if>
                                                                                                                       </c:otherwise>
                                                                                                                   </c:choose>
                                                                                                               </c:forEach>
                                                                                                           </c:when>
                                                                                                           <c:otherwise>
                                                                                                               <c:set var="token" value="0"/>
                                                                                                               <div class="cleafix">
                                                                                                                   <table class="table">
                                                                                                                       <c:set var="docCnt" value="1"/>
                                                                                                                       <c:set var="oldDocId" value="0" />
                                                                                                                       <c:forEach items="${lstTenderBidderDocs}" var="docData" varStatus="status">
                                                                                                                               <c:if test="${docData[0] eq data[0]}">
                                                                                                                                   <c:if test="${docCnt eq 1}">
                                                                                                                                           <tr class="gradi">
                                                                                                                                               <th>${mandatoryDoc}</th>
                                                                                                                                               <th>${mappedDoc}</th>
                                                                                                                                           </tr>
                                                                                                                                   </c:if>
                                                                                                                                   <c:if test="${oldDocId ne docData[6]}">
                                                                                                                                           <tr>
                                                                                                                                               <td>${not empty docData[7] ? docData[7] : '-'}</td>
                                                                                                                                               <td>
                                                                                                                                                   <c:set value="${docData[6]}_${data[0]}" var="documentBidId"/>
                                                                                                                                                   <c:set value="${fn:split(MandatoryFormDoc[documentBidId], ',')}" var="gDocRemark"/>
                                                                                                                                                   <c:set value="${fn:length(gDocRemark)}" var="gDocRemarkLength"/>
                                                                                                                                                   <c:forEach items="${gDocRemark}" var="docDetails" varStatus="gDocsrno">
                                                                                                                                                       <c:set value="${fn:split(docDetails,'#')[0]}" var="varRemarks"/>
                                                                                                                                                       <c:set value="${fn:split(docDetails,'#')[1]}" var="varId"/>
                                                                                                                                                       <c:set value="${fn:split(docDetails,'#')[2]}" var="docBidId"/>
                                                                                                                                                       <spring:url value="/ajax/downloadbriefcasefile/${varId}/${docBidId}" var="urlDownloadRemarks"/>
					                                                            																		<a href="${urlDownloadRemarks}">${varRemarks}</a>
                                                                                                                                                       ${gDocsrno.count eq  gDocRemarkLength ? ' ' : ' <br /><br />'}
                                                                                                                                                       <c:set var="token" value="${token+1}"/>
                                                                                                                                                   </c:forEach>
                                                                                                                                               </td>
                                                                                                                                           </tr>
                                                                                                                                           <c:set var="docCnt" value="${docCnt+1}"/>
                                                                                                                                   </c:if>
                                                                                                                                   <c:set var="oldDocId" value="${docData[6]}" />
                                                                                                                               </c:if>
                                                                                                                               <c:if test="${(fn:length(lstTenderBidderDocs) eq status.count) and token eq 0}">
                                                                                                                                   <div class="a-left">-</div>
                                                                                                                               </c:if>
                                                                                                                           </c:forEach>
                                                                                                                       </table>
                                                                                                               </div>
                                                                                                           </c:otherwise>
                                                                                                       </c:choose>
                                                                                                   </td>
                                                                                               </c:when>
                                                                                               <c:otherwise>
                                                                                                   <td class="a-left">-</td>
                                                                                               </c:otherwise>
                                                                                           </c:choose>
																						<c:choose>
                                                                                       	<c:when test="${envData[2] eq 4 || envData[2] eq 5}">
                                                                                         <c:if test="${tblTenderForm.isItemWiseDocAllowed eq 1}">	
                                                                                         		<td class="a-left">
                                                                                         			<c:choose>  
                                                                                           		<c:when test="${tndrFormData[12] eq 1}">	
                                                                                           			<spring:url value="/etender/bidder/viewbidform/${tenderId}/${envData[0]}/${tndrFormData[0]}/${data[0]}/true" var="urlView"/>
					                                                            					<a href="${urlView}">${var_view}</a>
                                                                                                </c:when>
                                                                                                <c:otherwise>
                                                                                                	-
                                                                                                </c:otherwise>
                                                                                              	</c:choose>
                                                                                         		</td>
                                                                                         </c:if>
                                                                                       	</c:when>
                                                                                       </c:choose>
                                                                                       </c:otherwise>
                                                                                   </c:choose>
                                                                               </tr>          
                                                                           </c:when>
                                                                           <c:otherwise>
                                                                               <c:if test="${fn:length(lstTenderBidDtls) eq stats.count and BDCount eq 0}">
                                                                                   <tr>
                                                                                       <c:set var="count" value="${count+1}"/>
                                                                                       <td>
                                                                                           ${tndrFormData[1]}
                                                                                           <c:if test="${tndrFormData[5] eq 1}"><span class="red">*</span></c:if>
                                                                                           <c:if test="${allowFinalSubmission eq 'msg_tender_fs_fillall_draft_forms' and data[3] eq 1}"><br/>[<spring:message code="lbl_form_save_as_draft" />]</c:if>
                                                                                           </td>
                                                                                           <td class="a-left"> - </td>
                                                                                           <td class="a-left"> - </td>
																						<c:choose>
	                                                                                       	<c:when test="${envData[2] eq 4 || envData[2] eq 5}">
	                                                                                       	 <c:if test="${tblTenderForm.isItemWiseDocAllowed eq 1}">
	                                                                                       	  		<%-- <td class="a-left"><abc:href href="etender/bidder/itemWiseDocUpload/${tenderId}/${envData[0]}/${tndrFormData[0]}/${data[0]}" label="${linkUploadDocs}"/></td> --%>
	                                                                                       	  		<td class="a-left"> - </td>
	                                                                                       	</c:if>
	                                                                                       	</c:when>
                                                                                       </c:choose>
                                                                                       </tr>
                                                                               </c:if>
                                                                           </c:otherwise>
                                                                       </c:choose>
                                                                   </c:forEach>
                                                               </c:when>
                                                               <c:otherwise>
                                                                   <tr>
                                                                       <c:set var="count" value="${count+1}"/>
                                                                       <td>
                                                                           ${tndrFormData[1]}
                                                                           <c:if test="${tndrFormData[5] eq 1}"><span class="red">*</span></c:if>
                                                                       </td>
                                                                       <td class="a-left"> - </td>
                                                                       <td class="a-left"> - </td>
                                                                       <c:if test="${tblTenderForm.isItemWiseDocAllowed eq 1 and (envData[2] eq 4 || envData[2] eq 5)}">
                                                                       		<td class="a-left"> - </td>
                                                                       </c:if>
                                                                       </tr>
                                                               </c:otherwise>
                                                           </c:choose>
                                                       </c:otherwise>
                                                   </c:choose>
                                               </c:otherwise>
                                           </c:choose>
                                       </c:if>
                                   </c:forEach>
                                   <c:if test="${count eq 0}">
                                       <tr>
                                           <td colspan="3">
                                               <spring:message code="msg_emptylist_tenderform"/>
                                           </td>
                                       </tr>
                                   </c:if>
                               </c:when>
                               <c:otherwise>
                                   <tr>
                                       <td>
                                           <spring:message code="msg_emptylist_tenderform"/>
                                       </td>
                                   </tr>
                               </c:otherwise>
                           </c:choose>
                            </table>
                    					</div>
                    <c:set var="count" value="0"/>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                        <c:if test="${isCompanyMapped}">
                            <div class="page-title prefix_1 o-hidden border-left border-right border-top"<spring:message code="msg_tender_biddingforms_notpublished"/></div>
                        </c:if>

            </c:otherwise>
        </c:choose>
        <c:if test="${(!submissionEndDtLapse and !isFinalSubmission) and tblTender.isRebateApplicable eq 1 and not empty tblRebateGTBidded}">
        <div class="cleafix">
               <table class="table">
               <tr class="gradi">
               	<td>Rebate</td>
               	<c:choose>
               		<c:when test="${tblTenderRebateDtls ne null }">
               			<td>
               				<spring:url value="/etender/bidder/crteditrebate/${tenderId}/${tblBidder.tblCompany.companyid}/2" var="urlEditRebate"/>
								<a href="${urlEditRebate}">${var_edit}</a>
								| 
							<spring:url value="/etender/bidder/crteditrebate/${tenderId}/${tblBidder.tblCompany.companyid}/3" var="urlViewRebate"/>
								<a href="${urlViewRebate}">${var_view}</a>	
               			</td>
               		</c:when>
               		<c:otherwise>
               			<td>
               				<spring:url value="/etender/bidder/crteditrebate/${tenderId}/${tblBidder.tblCompany.companyid}/1" var="urlAddRebate"/>
								<a href="${urlAddRebate}">${varAdd}</a>
               			</td>
               		</c:otherwise>
               	</c:choose>
               	
               </tr>
               </table>
		</div>
        </c:if>
                                                    	
        <c:if test="${not empty rebateList}"> 
            <c:choose>
                <c:when test="${isRebateForm eq 1}">
                    <div class="page-title prefix_1 o-hidden border-left border-right border-top m-top1 form-hd-ft-clr"><h2><spring:message code="lbl_rebate_form"/></h2></div>
                    <table class="table">
                            <tr class="gradi">
                                <th width="35%" class="a-left"><spring:message code="lbl_form_name"/></th>
                                <th class="a-left" width="35%"><spring:message code="col_action"/></th>
                                <th class="a-left" width="30%"></th>
                            </tr>
                            <c:forEach items="${rebateList}" var="rebateList">
                                <tr>
                                    <td>${rebateList[1]} <b class="red">*</b></td>
                                    <td class="a-left">
                                        <c:choose>
                                            <c:when test="${showRebateAction}">
                                                <c:choose>
                                                    <c:when test="${(!submissionEndDtLapse and !isFinalSubmission) and rebateList[2] eq '1' and rebateList[3] eq '0'}">
                                                    	<spring:url value="/etender/bidder/crteditrebate/${tenderId}/${rebateList[0]}/${companyId}/1/0" var="urlAddRebate"/>
                                                    	<a href="${urlAddRebate}">${varAdd}</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:choose>
                                                            <c:when test="${rebateList[2] eq '1' and rebateList[3] ne '0'}">
                                                                <c:if test="${!submissionEndDtLapse and !isFinalSubmission}">
                                                                	<spring:url value="/etender/bidder/crteditrebate/${tenderId}/${rebateList[0]}/${companyId}/2/0" var="urlEditRebate"/>
                                                    				<a href="${urlEditRebate}">${varEdit}</a> |
                                                                </c:if>
                                                                <spring:url value="/etender/bidder/crteditrebate/${tenderId}/${rebateList[0]}/${companyId}/3/0" var="urlViewRebate"/>
                                                    			<a href="${urlViewRebate}">${var_view}</a>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <c:choose>
                                                                    <c:when test="${rebateList[2] eq '0'}">
                                                                      <spring:url value="/etender/bidder/crteditrebate/${tenderId}/${rebateList[0]}/${companyId}/3/0" var="urlViewRebate"/>
                                                    					<a href="${urlViewRebate}">${var_view}</a>
                                                                    </c:when>
                                                                    <c:otherwise>-</c:otherwise>
                                                                </c:choose>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:otherwise>                                                                                
                                                </c:choose>
                                            </c:when>
                                            <c:otherwise>
                                                <spring:message code="msg_tender_err_rebateconfig"/>
                                                </c:otherwise>
                                            </c:choose>
                                    </td>
                                    <td></td>
                                </tr>
                            </c:forEach>
                        </table>
                </c:when>
                <c:otherwise>
                <div class="noprint">
                    <div class="page-title prefix_1 o-hidden border-left border-right border-top m-top1 form-hd-ft-clr"><h2><spring:message code="lbl_price_bid_form"/></h2></div>
                    <table class="table">
                        <tr class="gradi">
                            <th width="35%" class="a-left"><spring:message code="lbl_form_name"/></th>
                            <th class="a-left"  width="35%"><spring:message code="col_action"/></th>
                            <th class="a-left" width="30%"></th>
                        </tr>
                        <c:forEach items="${rebateList}" var="rebateList">
                            <tr>
                                <td class="a-left">${rebateList[1]}</td>
                                <td class="a-left">
                                    <c:choose>
                                        <c:when test="${showRebateAction}">
                                              <spring:url value="/etender/bidder/crteditrebate/${tenderId}/${rebateList[0]}/${companyId}/4/0" var="urlViewRebate"/>
                                              <a href="${urlViewRebate}">${var_view}</a>
                                        </c:when>
                                        <c:otherwise>
                                            <spring:message code="msg_tender_err_price_summary_config"/>
                                            </c:otherwise>
                                        </c:choose>
                                </td>
                                <td></td>
                            </tr>
                        </c:forEach>
                    </table>
                  </div>
                </c:otherwise>
            </c:choose> 
        </c:if> 
        
 
 
<c:if test="${allowFinalSubmission eq 'Success'}">
	<c:choose>
    	<c:when test="${isDocUploaded}">
          <c:set value="true" var="isFinalSubmissionDocChk"/>                                    
          <c:if test="${isDocAvail.containsValue('n')}">
          	<c:set value="false" var="isFinalSubmissionDocChk"/>	
          </c:if>
<%--             <c:if test="${isEmdOfflinePaid and (!isEmdPaidByExemption and (empty isEMDDocAvail or isEMDDocAvail.containsValue('n')) or !isEMDBidderDocCount)}"> --%>
<%--           	<c:set value="false" var="isFinalSubmissionDocChk"/>                                    	 --%>
<%--           </c:if> --%>
<%--           <c:if test="${isDocFeeOfflinePaid and (!isDocFeesPaidByExemption and (empty isDocFeeDocAvail or isDocFeeDocAvail.containsValue('n')) or !isDocFeesBidderDocCount)}"> --%>
<%--           	<c:set value="false" var="isFinalSubmissionDocChk"/> --%>
<%--           </c:if> --%>
<%--           <c:if test="${isParticipationOfflinePaid and (!isParticipationPaidByExemption and (empty isParticipationDocAvail or isParticipationDocAvail.containsValue('n')) or !isParticipationBidderDocCount) }"> --%>
<%--           	<c:set value="false" var="isFinalSubmissionDocChk"/>                                    	 --%>
<%--           </c:if> --%>
          <c:if test="${isFinalSubmissionDocChk}">
                  <div class="m-top1 a-center padding1 m-bottom1">
                      <c:choose>
                          <c:when test="${not empty bidIds}">
                          	<spring:url value="/etender/bidder/verifybidform/${tenderId}/0/0/0/${bidIds}_0" var="urlVerify"/>
                          	<a  cssclass="btn btn-submit" href="${urlVerify}">${varFinalSubmission}</a>
                          </c:when>
                          <c:otherwise>
                          		<form:form id="finalFormId" action="${pageContext.servletContext.contextPath}/etender/bidder/finalsubmission" method="POST">
                              		<input type="hidden" value="${tenderId}" name="hdTenderId"/>
                                    <input type="hidden" value="${eventType}" name="hdEventType"/>
                                    <input type="hidden" value="${tblBidder.bidderId}" name="hdBidderId"/>
                                    <input type="hidden" value="${tblBidder.tblCompany.companyid}" name="hdComapnyId"/>
                                  	<button type="button" class="btn btn-submit" id='btnFinalSubmission' onclick='confirmFinalsubmission()'>${varFinalSubmission}</button>
                              </form:form>
                          </c:otherwise>
                      </c:choose>
                  </div>
              </c:if>
          </c:when>
          <c:otherwise>
              <div class="m-top1 a-center padding1 m-bottom1">
                   <c:choose>
                       <c:when test="${not empty bidIds}">
                       	<spring:url value="/etender/bidder/verifybidform/${tenderId}/0/0/0/${bidIds}_0" var="urlVerify"/>
                          	<a  cssclass="btn btn-submit" href="${urlVerify}">${varFinalSubmission}</a>
						</c:when>
                       <c:otherwise>
                          <form:form id="finalFormId" action="${pageContext.servletContext.contextPath}/etender/bidder/finalsubmission" method="POST">
                              		<input type="hidden" value="${tenderId}" name="hdTenderId"/>
                                    <input type="hidden" value="${eventType}" name="hdEventType"/>
                                    <input type="hidden" value="${tblBidder.bidderId}" name="hdBidderId"/>
                                    <input type="hidden" value="${tblBidder.tblCompany.companyid}" name="hdComapnyId"/>
                                  	<button type="button" class="btn btn-submit" id='btnFinalSubmission' onclick='confirmFinalsubmission()'>${varFinalSubmission}</button>
                              </form:form>
                      </c:otherwise>
                  </c:choose>
              </div>
          </c:otherwise>
      </c:choose>
</c:if>


			</div>
		</div>
	</div>
</div>
		</div>
		</div>
	</section>

</div>

</div>

</body>

</html>
