<!DOCTYPE html>
<html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../../includes/header.jsp"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script type="text/javascript" src="${pageContext.servletContext.contextPath}/resources/js/print/jquery.txt"></script>
<script type="text/javascript">
function isEnvelopeOpened(){
                jAlert('<spring:message code="msg_env_not_open"/>');
                return false;
            }
</script>
<spring:message code="lbl_back_dashboard" var='backDashboard'/>
<spring:message code="col_action" var='vAction'/> 
<spring:message code="msg_env_not_open" var="vEnvNotOpen"/>
<spring:message code="col_open_pending" var="pending"/>
<c:set var="isItemWiseLinkShow" value="0"/>

<c:if test="${isPriceBidForm eq '1' and isEncNotRequire eq '1'}">
	<c:set var="isItemWiseLinkShow" value="1"/>
</c:if>		
<c:choose>
	<c:when test="${biddingVariant eq 1}"><spring:message code="link_Itemwisebreak_report_lowest" var="linkItemwiseBreakupReport"/></c:when>
    <c:otherwise><spring:message code="link_Itemwisebreak_report_heighest" var="linkItemwiseBreakupReport"/></c:otherwise>
</c:choose>
</head>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="../../includes/leftaccordion.jsp"%>

<div class="content-wrapper">
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
				<div><a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}"><< ${backDashboard}</a></div>
				<div class="box-header with-border">
					<h3 class="box-title">Evaluate Bid</h3>
				</div>

                        
	<div class="box-body">
		<div class="row">
			<div class="col-lg-12 col-md-12 col-xs-12">
				<div class="box-body pad">
					<table  class="table table-striped table-responsive">
						<c:set value="${sessionObject.userId}" var="currentUserId"/>
						<c:forEach items="${envList}" var="envelopeData" varStatus="srno">
							<c:set var="bidderCounter" value="${srno.index}"/>
							<c:set value="${envelopeData[0]}" var="envelopeid"/>
							<c:set value="${envelopeData[1]}" var="envelopename"/>
							<c:set value="${envelopeData[2]}" var="openingdate"/>
							<c:set value="${envelopeData[3]}" var="envId"/>
							<c:set value="${envelopeData[4]}" var="evnCstatus"/>
							<c:set value="${envelopeData[5]}" var="openingdatestatus"/>
							<c:set value="${envelopeData[6]}" var="timelapsed"/>
							<c:set value="${envelopeData[7]}" var="sortorder"/>
							<c:set value="${envelopeData[8]}" var="minmember"/>
							<c:set value="${envelopeData[9]}" var="isopened"/>
							<c:set value="${envelopeData[10]}" var="isevaluated"/>
							<c:set value="${envelopeData[11]}" var="isEvaluationDoneBidder"/>
							<c:set value="${envelopeData[12]}" var="isEnvelopeOpened"/>
							<c:set value="${envelopeData[13]}" var="isNextEnvEvalDone"/>
							
							<c:set value="0" var="mandatoryFormVerifiedCount"/><%-- This variable set count of all mandatory forms which are verified by committee member --%>
							<c:set value="0" var="mandatoryFormsCount"/>
							<c:set value="N" var="isEnbleBidderwiseReport"/>
							<c:set value="0" var="committeeMember"/>
                            <c:set value="Invalid" var="isShowEncodedName"/>
                                                
                                                
                            <c:forEach items="${bidderFormList}" var="verifyData"><%-- VerifyData Loop --%>
                            	<c:set var="verifyEnvelopeId" value="${verifyData[0]}"/>
								<c:set var="verifyFormId" value="${verifyData[1]}"/>
								<c:set var="verifyFormName" value="${verifyData[2]}"/>
								<c:set var="verifyIsPriceBid" value="${verifyData[3]}"/>
								<c:set var="verifyIsEncryptionReq" value="${verifyData[4]}"/>
								<c:set var="verifyFinalCount" value="${verifyData[5]}"/>
								<c:set var="verifyOpenCount" value="${verifyData[6]}"/>
								<c:set var="verifyCstatus" value="${verifyData[7]}"/>
								<c:set var="verifyIsMandatory" value="${verifyData[8]}"/>
                            	<c:if test="${verifyEnvelopeId eq envelopeid and verifyIsMandatory eq 1 and verifyFinalCount ne 0 and verifyCstatus eq 1}"><%-- Condition used to get mandatory forms count --%>
									<c:set value="${mandatoryFormsCount+1}" var="mandatoryFormsCount"/>
										<c:if test="${verifyOpenCount ge verifyFinalCount}"><%-- Current Envelope have all Mandatory form is verified/decrypted  or not--%>
											<c:set value="${mandatoryFormVerifiedCount+1}" var="mandatoryFormVerifiedCount"/>
										</c:if>
								</c:if>
								<c:if test="${verifyEnvelopeId eq envelopeid and verifyOpenCount gt 0}"><%-- If atleast one form verified then show bidder wise report --%>
									<c:set value="Y" var="isEnbleBidderwiseReport"/>
								</c:if>
                                <c:if test="${isEncodedName eq 1 and verifyEnvelopeId eq envelopeid and (envId eq 4 or envId eq 5)}">
                                    <c:set value="Y" var="isShowEncodedName"/>
                                </c:if>
							</c:forEach>
                                                
								<thead>
								<tr>
									<th>${envelopename}</th>
									
								</tr>
								</thead>
								<tr><td>
									<table  class="table">
										<tr>
											<td><spring:message code="lable_min_consent_require"/></td>
											<td>${minmember}</td>
										</tr>
										<tr>
											<td>Bid Opening Status</td>
											<td>
												<c:choose>
													<c:when test="${srno.index ne 0 and envelopeType eq 2 and openingdatestatus ne 1}"><spring:message code="label_date_not_specified"/></c:when>
													<c:when test="${timelapsed eq 0 and openingdatestatus eq 1}"><spring:message code="label_date_not_arrive"/></c:when>
													<c:when test="${timelapsed eq 0}">${pending}</c:when>
													<c:when test="${isopened eq 1}">Opened</c:when>
<%-- 													<c:when test="${isevaluated eq 1}"> --%>
<%-- 														<c:choose> --%>
<%-- 															<c:when test="${evaluationStatusMap[envelopeid] ne 'Pending' and evaluationStatusMap[envelopeid] ne ''}"> --%>
<%-- 																<c:set value="${evaluationStatusMap[envelopeid]}" var="evaluatedOn"/> --%>
<%-- 																	Evaluated on ${evaluatedOn} --%>
<%-- 															</c:when> --%>
<%-- 															<c:otherwise>${evaluationStatusMap[envelopeid]}</c:otherwise>															 --%>
<%-- 														</c:choose> --%>
<%-- 													</c:when> --%>
													<c:otherwise>${pending}</c:otherwise>
												</c:choose>												
											</td>
										</tr>
										<tr>
											<td>Bid Opening Date & time</td>
											<td>
												<c:choose>
													<c:when test="${srno.index ne 0 and envelopeType eq 2 and openingdatestatus ne 1}">---</c:when> 
													<c:when test="${openingdatestatus eq 1}"><fmt:formatDate pattern="${clientDateFormate}" value="${openingdate}" /></c:when> 
												</c:choose>
											</td>
										</tr>
										<tr>
										<td>
										<table  class="table table-striped table-responsive">
											<c:set value="0" var="VerifiedFormsCount"/>
											<c:set value="0" var="totalFormsCount"/>
                                            <c:set value="0" var="AllformsCount"/>
                                            <c:set value="0" var="AllVerifiedFormsCount"/> 
											<c:forEach items="${bidderFormList}" var="verifyData"><%-- VerifyData Loop --%>
												<c:set var="verifyEnvelopeId" value="${verifyData[0]}"/>
												<c:set var="verifyFinalCount" value="${verifyData[5]}"/>
												<c:set var="verifyCstatus" value="${verifyData[7]}"/>
												<c:set var="verifyOpenCount" value="${verifyData[6]}"/>
												<c:if test="${verifyEnvelopeId eq envelopeid and verifyFinalCount ne 0 and verifyCstatus eq 1}"><%-- Condition used to get mandatory forms count --%>
													<c:set value="${mandatoryFormsCount+1}" var="totalFormsCount"/>
													<c:set value="${AllformsCount+1}" var="AllformsCount"/>
													<c:if test="${verifyOpenCount ge verifyFinalCount}"><%-- Current Envelope have all Mandatory form is verified/decrypted  or not--%>
														<c:set value="${mandatoryFormVerifiedCount+1}" var="VerifiedFormsCount"/>
                                                        <c:set value="${AllVerifiedFormsCount+1}" var="AllVerifiedFormsCount"/>
													</c:if>
												</c:if>
											</c:forEach>
											<c:set value="0" var="isConsentGivenByCurrentCommitteeMember"/>
											<c:set value="0" var="consentMemberCount"/>
											<c:set value="${minmember}" var="envelopeMinConsentMemberCount"/>
											
										<c:forEach items="${commMemList}" var="committeeData" varStatus="commCount">
										<c:set value="${committeeData[0]}" var="officername"/>
										<c:set value="${committeeData[1]}" var="loginid"/>
										<c:set value="${committeeData[2]}" var="officerid"/>
										<c:set value="${committeeData[3]}" var="childid"/>
										<c:set value="${committeeData[4]}" var="approvedon"/>
										<c:set value="${committeeData[5]}" var="committeeuserid"/>
										<c:set value="${committeeData[6]}" var="committeemember"/>
										<c:set value="${committeeData[7]}" var="committeeid"/>
										<c:set value="${committeeData[8]}" var="isapproved"/>
										<c:set value="${committeeData[9]}" var="isdecryptor"/>
											<c:if test="${envelopeid eq  childid}">
												<tr>
                                                    <c:if test="${isapproved eq 1}">
                                                            <c:set value="${consentMemberCount+1}" var="consentMemberCount"/>
                                                    </c:if>
                                                    <c:if test="${currentUserId eq committeemember}">
														<c:set value="${isapproved}" var="isConsentGivenByCurrentCommitteeMember"/>
													</c:if>
													<spring:url var="urlConsent" value="/etender/buyer/getcommitteeuserremark/${tenderId}/${childid}/${committeeuserid}/${committeeid}/${minmember}/2"></spring:url>
													<c:choose>
														<c:when test="${totalFormsCount eq VerifiedFormsCount and committeemember eq currentUserId and timelapsed eq 1 and isapproved ne 1}"><%-- Comittee Member link enable after envelope open time lapsed --%>
	                                                        <c:choose>
	                                                            <c:when test="${isEnvelopeOpened eq 1}"><td width="50%"><a href="${urlConsent}">${officername}</</a></td></c:when><%--consent given by tender opening committee member--%>
	                                                            <c:otherwise><td width="50%"><a href="${urlConsent}" onclick="isEnvelopeOpened();">${officername}</</a></td></c:otherwise>
	                                                        </c:choose>
														</c:when>
														<c:when test="${srno.index ne 0 and isAllFormsVerified eq 'Y' and oldEnvelopeData[10] eq 1 and envelopeType eq 2 and currentUserId eq committeemember and timelapsed eq 1 and isapproved ne 1}"><%-- If tender is Multi Envelope then second envelope's Comittee Member link enable after previous envelope is evaluated from evaluation tab--%>
	                                                        <c:choose>
	                                                            <c:when test="${isEnvelopeOpened eq 1}"><td width="50%"><a href="${urlConsent}">${officername}</</a></td></c:when><%--consent given by tender opening committee member--%>
	                                                            <c:otherwise><td width="50%"><a href="${urlConsent}" onclick="isEnvelopeOpened();">${officername}</</a></td></c:otherwise>
	                                                        </c:choose>
														</c:when>
														<c:when test="${srno.index ne 0 and isAllFormsVerified eq 'Y' and envelopeType eq 2 and currentUserId eq committeemember and timelapsed eq 1  and isapproved ne 1}"><%-- If tender is Single Envelope then all envelope's Comittee Member link enable there is no dependancy of evaluation tab--%>
                                                        	<c:choose>
	                                                            <c:when test="${isEnvelopeOpened eq 1}"><td width="50%"><a href="${urlConsent}">${officername}</</a></td></c:when><%--consent given by tender opening committee member--%>
	                                                            <c:otherwise><td width="50%"><a href="${urlConsent}" onclick="isEnvelopeOpened();">${officername}</</a></td></c:otherwise>
	                                                        </c:choose>
														</c:when>
														<c:when test="${currentUserId eq committeemember and isapproved eq 1}"><%-- If Comittee Member Give consent then after link disable--%>
															<td width="50%">${officername}</td>
														</c:when>
														<c:otherwise><td width="50%">${officername}</td></c:otherwise>
													</c:choose> 
													
													<c:choose>
														<c:when test="${isapproved eq 1}">
															<td>Consent given on <fmt:formatDate pattern="${clientDateFormate}" value="${approvedon}" /></td>
														</c:when>
														<c:otherwise>
															<td>${pending}</td>
														</c:otherwise>
													</c:choose>
												</tr>
											</c:if>
										</c:forEach>
									</table>
								</td>
							</tr>
							<tr>
								<td>Seek Clarification</td>
								<td><a href="${pageContext.servletContext.contextPath}/etender/buyer/bidderwiseclaficationlist/${tenderId}/${envelopeid}/0">Seek Clarification</a></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<table class="table">
												<!-- 										New loop Form Listing -->
											<c:choose>
												<c:when test="${isevaluated eq 1}">
													<c:if test="${empty bidderFormList}">
														<div><spring:message code="msg_no_forms_mapped"/></div>
													</c:if>
													<c:if test="${not empty bidderFormList}">
                                                        <tr>
															<th><spring:message code="field_formName"/></th>
															<th><spring:message code="tab_tender_reports"/></th>
														</tr>
													</c:if>
													<c:forEach items="${bidderFormList}" var="verifyFormData" varStatus="verifyCnt">
														<c:set var="verifyEnvelopeId" value="${verifyFormData[0]}"/>
															<c:set var="verifyFormId" value="${verifyFormData[1]}"/>
															<c:set var="verifyFormName" value="${verifyFormData[2]}"/>
															<c:set var="verifyIsPriceBid" value="${verifyFormData[3]}"/>
															<c:set var="verifyIsEncryptionReq" value="${verifyFormData[4]}"/>
															<c:set var="verifyFinalCount" value="${verifyFormData[5]}"/>
															<c:set var="verifyOpenCount" value="${verifyFormData[6]}"/>
															<c:set var="verifyCstatus" value="${verifyFormData[7]}"/>
															<c:set var="verifyIsMandatory" value="${verifyFormData[8]}"/>
														<c:if test="${envelopeid eq verifyEnvelopeId}">
															<spring:message code="msg_form_no_bid"         var="vFormNoBidded"/>
															<spring:message code="msg_form_cancel"         var="vFormCancelled"/>
															<spring:message code="link_comparative_report" var="linkCompare"/>
															<spring:message code="link_customize_report" var="linkCustomize"/>
															<spring:message code="link_individual_report"  var="linkIndiv"/>
															<spring:message code="link_l1_report"     var="l1Report"/>
															<spring:url value="etender/buyer/itemwiseevaluationreport/${tenderId}/${verifyFormId}/2/2" var="urlItemWiseBreakUpReport" />
															<spring:url value="etender/buyer/customizedreport/${tenderId}/${verifyFormId}/1/2" var="urlCustomize"/>
															<spring:url var="urlIndividual" value="/etender/buyer/tenderindividualreport/${tenderId}/${verifyEnvelopeId}/${verifyFormId}/1/1"/>
															<spring:url value="/etender/buyer/tendercomparativereport/${tenderId}/${verifyEnvelopeId}/${verifyFormId}/1/2" var="urlCompare"/>
															<tr>
																<td >${verifyFormName}<c:if test="${verifyIsMandatory eq 1}"><span class="red"> *</span></c:if></td>
															<c:choose>
																<c:when test="${verifyCstatus eq 2}"><td><span class="red">${vFormCancelled}</span></td></c:when>
																<c:when test="${verifyFinalCount eq 0}">
																	<td><span class="red" >${vFormNoBidded}</span></td>
																	</c:when>
																<c:otherwise>
																	<td class="a-left">
		                                                            	<c:set var="decryptionDone" value="true"/>
																		<c:choose>
																			<c:when test="${verifyOpenCount eq 0}">
		                                                                    	<c:set var="decryptionDone" value="false"/>
																				${linkIndiv} | ${linkCompare} 
<%-- 																				| ${linkCustomize} --%>
		                                                                        <c:if test='${eventTypeId eq 5 and verifyIsPriceBid eq 1}'><%-- This link display only in case of Seal bid --%>
		                                                                                ${linkItemwiseBreakupReport}
		                                                                        </c:if>
																			</c:when>
																			<c:otherwise>
		                                                                    	<c:if test="${AllformsCount ne AllVerifiedFormsCount}">
		                                                                        	<c:set var="decryptionDone" value="false"/>
		                                                                        </c:if>
		                                                                        <a href="${urlIndividual}">${linkIndiv}</</a> |
		                                                                        <a href="${urlCompare}">${linkCompare}</</a> |
<%-- 		                                                                        <a href="${urlCustomize}">${linkCustomize}</</a> --%>
																				<c:if test='${eventTypeId eq 5 and verifyIsPriceBid eq 1 and not empty multFillingCountMap[verifyFormId] and multFillingCountMap[verifyFormId] eq 0}'>
																					| <a href="${urlItemWiseBreakUpReport}">${linkItemwiseBreakupReport}</</a>
																				</c:if>
																			</c:otherwise>
																		</c:choose>
																	</td>
																</c:otherwise> 
															</c:choose>
															</tr>
														</c:if>
														<c:if test="${verifyCnt.count eq fn:length(verifyData) and isRebateForm eq 1 and mandatoryFormsCount ne 0 and mandatoryFormsCount eq mandatoryFormVerifiedCount and not empty rebateId and (envId eq 4 or envId eq 5)}"><%-- isRebateForm =1 , all forms are verified, and pricebid or technocommercial envelope  --%>
															<tr>
																<td class="border-right">${tenderData.reportName}</td>
																<td class="a-left">
																	<c:choose>
																		<c:when test="${tenderData.rebateCount eq 0}"><spring:url var="urlL1" value="etender/buyer/l1h1report/${tenderId}/1/2"/>
																			<a href="${urlL1}">${l1Report}</a></c:when>
																		<c:otherwise>${l1Report}</c:otherwise>
																	</c:choose>	
																</td>
															</tr>
														</c:if>
													</c:forEach>
											</c:when>
												<c:otherwise>
													<c:choose>
														<c:when test="${isopened eq 0}"> 
															<tr><td class="black">${vEnvNotOpen}</td></tr>
														</c:when>
														<c:otherwise>
<%-- 															<tr><td><spring:message code="msg_date_eva_lapsed"/></td></tr> --%>
														</c:otherwise>
													</c:choose>
												</c:otherwise>
											</c:choose>
						</table>
					</td>						
				</tr>
													<%--Start: Bidder Listing --%>
												<c:if test="${isevaluated eq 1}">
													<tr>
														<td>
															<table  class="table">
																<c:if test="${not empty bidderList}">
																	<spring:message code="lbl_evaluated" var="evaluated" />
																	<spring:message code="lbl_itemSelection" var="itemSelection" />
                                                    				<spring:message code="lbl_eval" var="evaluate" />
                                                    				<spring:message code="lbl_bidder_name" var="bidderName"/>
                                                    				<spring:message code="lbl_bid_eval_sts" var="status"/>
                                                    				<spring:message code="label_bidder_eligible" var="vEligible"/>
                                                    				<spring:message code="label_bidder_not_eligible" var="vNotEligible"/>
                                                    				
																	<c:choose>
																		<c:when test="${isEvaluationRequired eq 1}">
																			<tr>
																				<th>${bidderName}</th>
																				<th>${status}</th>
																				<c:if test="${envelopeType eq 2 and envId eq 3 and isItemWiseLinkShow eq 1}">
                                                                                	<th>${evaluate}</th>
                                                                                </c:if>
<!--                                                                                 cstatus = tender status -->
                                                                                <c:if test="${cstatus ne 2 and isevaluated eq 1 and isConsentGivenByCurrentCommitteeMember eq 1 and isEvaluationDone eq 0}">
                                                                                		<th>${vAction}</th>
                                                                                </c:if>
																			</tr>
																		</c:when>
																		<c:otherwise>
																			<tr>
																				<th>${bidderName}</th>
																			</tr>
																		</c:otherwise>
																	</c:choose>
																</c:if>
																
																<c:forEach items="${bidderList}" varStatus="dataCnt" var="bidderData">
																	<c:set var="bidderBidderId" value="${bidderData[0]}"/>
																	<c:set var="bidderCompanyId" value="${bidderData[1]}"/>
																	<c:set var="bidderEnvelopeId" value="${bidderData[2]}"/>
																	<c:set var="bidderConsortiumId" value="${bidderData[3]}"/>
																	<c:set var="bidderIsApproved" value="${bidderData[4]}"/>
																	<c:set var="bidderEncodedName" value="${bidderData[5]}"/>
																	<c:set var="bidderPartnerType" value="${bidderData[6]}"/>
																	<c:set var="bidderRemarks" value="${bidderData[7]}"/>
																	<c:set var="bidderPreviousApprovedBidder" value="${bidderData[8]}"/>
																	<c:set var="bidderCompanyName" value="${bidderData[9]}"/>
																			<c:if test="${envelopeid eq bidderEnvelopeId}">
																				
																				<c:set value="${fn:replace(bidderCompanyName,'label_consort_with',conrtiumWith)}" var="companyNames"/>
<%-- 																				<c:set value="${fn:substring(companyNames,0,fn:length(companyNames)-1)}" var="companyNames"/> --%>
																				<c:if test="${isShowEncodedName eq 'Y'}"><%-- For Multi Envelope Tender encoded is yes and price bid envelope Then show encoded name--%>
																					<c:set value="${bidderEncodedName}" var="companyNames"/>
																				</c:if>
																				
																				<c:choose>
																					<c:when test="${empty bidderIsApproved}"> 
<!-- 																					not evaluted any bidder -->
<!-- 																					srno.index eq 0 replace condition -->
																						<tr>
																							<td <c:if test="${isEvaluationRequired eq 0}">colspan="2"</c:if>>
																								<c:choose>
																									<c:when test="${isEnbleBidderwiseReport eq 'N' or isShowEncodedName eq 'Y'}">${companyNames}</c:when>
																									<c:when test="${isConsortiumAllowed eq 1}">
<%-- 																										<abc:encdec isenc="true" value="${bidderConsortiumId}" var="encConsortiumId"/>Here pass encrypted consortiumId cause of security --%>
																										<a href="etender/buyer/bidderwisereport/${tenderId}/${bidderEnvelopeId}/1/1/${bidderConsortiumId}/2">${companyNames}</a>
																									</c:when>
																									<c:otherwise>
<%-- 																										<abc:encdec isenc="true" value="${bidderBidderId}" var="encBidderId"/>Here pass encrypted bidderId cause of security --%>
																										<a href="etender/buyer/bidderwisereport/${tenderId}/${bidderEnvelopeId}/0/1/${bidderBidderId}/2">${companyNames}</a>
																									</c:otherwise>
																								</c:choose> 
																							</td>
																							<c:if test="${isEvaluationRequired eq 1}">
																								<td>
																									<c:choose>
			                                                                                    		<c:when test="${srno.index eq 0}">
			                                                                                    			${pending}
			                                                                                    		</c:when>
			                                                                                            <c:otherwise>
			                                                                                            	<c:choose>
			                                                                                                	<c:when test="${not empty rejectedBidderMap and rejectedBidderMap[bidderBidderId]}">
			                                                                                                	<div data-toggle="tooltip" data-placement="left" title="" data-original-title="${bidderRemarks}">
			                                                                                                		${vNotEligible}
			                                                                                                	</div>
			                                                                                                	</c:when>
			                                                                                                    <c:otherwise>${pending}</c:otherwise>
			                                                                                                </c:choose>
			                                                                                            </c:otherwise>
			                                                                                    	</c:choose>
																								</td>
																							</c:if>
																							<c:choose>
																								<c:when test="${(envId eq 1 or envId eq 2 or envId eq 3)}" >
																									<c:if test="${isEvaluationDoneBidder eq 0}">
																										<c:choose>
																											<c:when test="${srno.index eq 0}">
																												<spring:url value="/etender/buyer/evaluatebidders/${tenderId}/${envelopeid}/1/${envelopeType}/${sortorder}/0/false" var="evaluateUrl"/>
																											</c:when>
																											<c:otherwise>
																												<spring:url value="/etender/buyer/evaluatebidders/${tenderId}/${envelopeid}/1/${envelopeType}/${sortorder}/${oldEnvelopeData[0]}/false" var="evaluateUrl"/>
																											</c:otherwise>
																										</c:choose>
			                                                                                    	<c:if test="${bidderCounter eq srno.index }">
			                                                                                    		<td rowspan="${fn:length(bidderList)}"><a href="${evaluateUrl}">${evaluate}</a></td>
			                                                                                    		<c:set var="bidderCounter" value="-1"/>
			                                                                                    	</c:if>
			                                                                                    	</c:if>
																								</c:when>
																								<c:otherwise>
																									<c:if test="${isItemwiseWinner eq 1}">
																									<c:forEach var="rejectedBidder" items="${rejectedBidder}">
																										<c:choose>
																										<c:when test="${rejectedBidder eq bidderBidderId}">
																											<c:set var="isRejectedDone" value="true"/>
																											<td class="v-a-middle a-center border-bottom">
																												<spring:url value="/etender/buyer/bidderWiseevaluation/${tenderId}/${envelopeid}/${bidderBidderId}/${bidderCompanyId}/2/false/${isItemwiseWinner}/y" var="evaluateUrl"/>
																												<a href="${evaluateUrl}">${evaluate}</</a>
																											</td>
																											</c:when>
																										<c:otherwise>
																										<td class="v-a-middle a-center border-bottom">
																												<spring:url value="/etender/buyer/bidderWiseevaluation/${tenderId}/${envelopeid}/${bidderBidderId}/${bidderCompanyId}/2/false/${isItemwiseWinner}/n" var="evaluateUrl"/>
																												<a href="${evaluateUrl}">${evaluate}</</a>
																											</td>
																										</c:otherwise>
																										</c:choose>
																									</c:forEach>
			                                                                                         </c:if>  
			                                                                                         <c:if test="${isItemwiseWinner eq 0 and bidderCounter eq srno.index }">
			                                                                                         	<c:choose>
																											<c:when test="${srno.index eq 0}">
																												<spring:url value="/etender/buyer/evaluatebidders/${tenderId}/${envelopeid}/1/${envelopeType}/${sortorder}/0/false" var="evaluateUrl"/>
																											</c:when>
																											<c:otherwise>
																												<spring:url value="/etender/buyer/evaluatebidders/${tenderId}/${envelopeid}/1/${envelopeType}/${sortorder}/${oldEnvelopeData[0]}/false" var="evaluateUrl"/>
																											</c:otherwise>
																										</c:choose>
			                                                                                         <td rowspan="${fn:length(bidderList)}"><a href="${evaluateUrl}">${evaluate}</a></td>
			                                                                                         <c:set var="bidderCounter" value="-1"/>
			                                                                                         </c:if> 
																								</c:otherwise>
																							</c:choose>																							
	                                                                                    	
																						</tr>
																					</c:when>
																					
																					<c:otherwise>
																						<tr>
																							<td <c:if test="${isEvaluationRequired eq 0}">colspan="2"</c:if>>
																								<c:choose>
																									<c:when test="${isEnbleBidderwiseReport eq 'N' or isShowEncodedName eq 'Y'}">${companyNames}</c:when>
																									<c:when test="${isConsortiumAllowed eq 1}">
<%-- 																											<abc:encdec isenc="true" value="${bidderData.consortiumId}" var="encConsortiumId"/> --%>
																										<a href="etender/buyer/bidderwisereport/${tenderId}/${bidderEnvelopeId}/1/1/${bidderConsortiumId}/2">${companyNames}</a>
																									</c:when>
																									<c:otherwise>
<%-- 																											<abc:encdec isenc="true" value="${bidderData.bidderId}" var="encBidderId"/> --%>
																										<a href="etender/buyer/bidderwisereport/${tenderId}/${bidderEnvelopeId}/0/1/${bidderBidderId}/2">${companyNames}</a>
																									</c:otherwise>
																								</c:choose>
																							</td>
																							<c:if test="${isEvaluationRequired eq 1}">
																								<c:choose>
																									<c:when test="${bidderIsApproved eq 1}">
																										<td><div data-toggle="tooltip" data-placement="left" title="" data-original-title="${bidderRemarks}">${vEligible}</div></td>
																									</c:when>
																									<c:when test="${bidderIsApproved eq 0}"><td><div data-toggle="tooltip" data-placement="left" title="" data-original-title="${bidderRemarks}">${vNotEligible} </div></td></c:when>
																								</c:choose>
																							</c:if>
                                                                                            <c:if test="${(envId eq 4 or envId eq 5) and isItemwiseWinner eq 1}">
	                                                                                            <spring:url value="/etender/buyer/bidderWiseevaluation/${tenderId}/${envelopeid}/${bidderBidderId}/${bidderCompanyId}/2/true/${isItemwiseWinner}" var="evaluateurl"/>
																								<td>Evaluted</td>
                                                                                            </c:if>
																						</tr>
																					</c:otherwise>
																				</c:choose>
																			</c:if>
																</c:forEach>
															</table>
														</td>
													</tr>
												</c:if>
								<c:set value="${envelopeData}" var="oldEnvelopeData"/>
							</c:forEach>
						</table>
						</div>
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
