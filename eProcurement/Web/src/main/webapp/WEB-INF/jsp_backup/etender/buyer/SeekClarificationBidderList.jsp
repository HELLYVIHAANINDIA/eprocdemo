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
					<h3 class="box-title">Seek clarification</h3>
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
							<c:set value="${envelopeData[11]}" var="isEvaluationDone"/>
							<c:set value="${envelopeData[12]}" var="isEnvelopeOpened"/>
							<c:set value="${envelopeData[13]}" var="isNextEnvEvalDone"/>
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
                                <c:if test="${envelopeid eq seekEnvelopeId}">                
								<thead>
								<tr>
									<th>${envelopename}</th>
								</tr>
								</thead>
													<%--Start: Bidder Listing --%>
												<c:if test="${isevaluated eq 0}">
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
                                                    				
																			<tr>
																				<th>${bidderName}</th>
                                                                                <th>${vAction}</th>
																			</tr>
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
																				<tr>
																				<th>${bidderCompanyName}</th>
                                                                                <th>
                                                                                <c:set var="key" value="${tenderId}_${envelopeid}_${bidderBidderId}"/>
                                                                                <c:if test="${bidderClarificationDtl[key] eq 0}">	
                                                                                <a href="${pageContext.servletContext.contextPath}/etender/buyer/configuredate/${tenderId}/${envelopeid}/${bidderBidderId}/${sessionObject.officerId}/0">Configure Date</a> |
                                                                                </c:if>
                                                                                <c:if test="${bidderClarificationDtl[key] gt 0}">
<%-- 																					<a href="${pageContext.servletContext.contextPath}/etender/buyer/reconfiguredate/1/1/9/133/1">Re-Configure Date</a> |  --%>
																					<a href="${pageContext.servletContext.contextPath}/etender/buyer/createSeekClarificationQueryView/${tenderId}/${envelopeid}/${bidderBidderId}/0/0/${bidderClarificationDtl[key]}">Post Query</a> |
																					<a href="${pageContext.servletContext.contextPath}/etender/buyer/viewClarificationQueries/${tenderId}/${envelopeid}/${bidderBidderId}/0">View Clarification/Response</a>
																				</c:if>	
																				</th>	
																			</tr>
																			</c:if>
																			
																</c:forEach>
															</table>
														</td>
													</tr>
												</c:if>
								<c:set value="${envelopeData}" var="oldEnvelopeData"/>
								</c:if>
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