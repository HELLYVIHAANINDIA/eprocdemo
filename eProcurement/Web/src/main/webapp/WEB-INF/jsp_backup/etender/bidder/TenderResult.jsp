<!DOCTYPE html>
<html>
<%@include file="../../includes/header.jsp"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<spring:message code="tooltip_bidderwise_abstract_report"  var="toolTipBidderAbstReport"/>
<spring:message code="link_l1_report"     var="l1Report"/>
<c:if test="${biddingVariant eq 2}"><spring:message code="link_h1_report" var="l1Report"/></c:if>
<spring:message code="col_action"         var='vAction'/>
<spring:message code="label_consort_with" var="conrtiumWith"/>
<c:set value="${sessionObject.userId}" var="currentUserId"/>
<spring:message code="msg_env_not_open" var="vEnvNotOpen"/>
<spring:message code="lbl_back_dashboard" var='backDashboard'/>
</head>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="../../includes/leftaccordion.jsp"%>

<div class="content-wrapper">

	<section class="content-header"> <c:if
		test="${not empty successMsg}">
		<div>
			<span class="alert alert-success"><spring:message
					code="${successMsg}" />
			</span>
		</div>
	</c:if> <c:if test="${not empty errorMsg}">
		<div>
			<span class="alert alert-danger"><spring:message
					code="${errorMsg}" />
			</span>
		</div>
	</c:if>
	<div>
		<a href="${pageContext.servletContext.contextPath}/etender/bidder/biddingTenderDashboard/${tenderId}"
		class="btn btn-submit"><< ${backDashboard}</a>
	</div>
	</section>

	<section class="content">
	  <div class="row">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			<div class="box">	
				<div class="box-header with-border">
					<h2 class="box-title">Result</h2>
				</div>
<div class="box-body">
		<div class="row">
			<div class="col-lg-12 col-md-12 col-xs-12">
				<div class="box-body pad">
<table  class="table table-striped table-responsive">	
	<tr>
		<td>
			<%--<table width="100%" class="table-border border-right">--%>
			 	<c:set value="${tenderDetailList}" var="tenderData"/> 
			 	<c:if test="${tenderData.resultSharing eq '2'}">
			 		<c:set value="${tblShareReport}" var="tenderShareReportDataMap"/>
		 		</c:if>                                    
                                    <%--<c:when test="${true or tenderData.resultSharing eq '1' or (tenderData.resultSharing eq '2' and isResultShareDone)}">--%>
				<c:forEach items="${envList}"  varStatus="srno" var="envelopeData"><%-- First Envelopes whole loop In which all links and data show/hide by condition wise--%>
					<c:set value="${envelopeData[0]}" var="envelopeid"/>
							<c:set value="${envelopeData[1]}" var="envelopename"/>
							<c:set value="${envelopeData[2]}" var="openingdate"/>
							<c:set value="${envelopeData[3]}" var="envId"/>
							<c:set value="${envelopeData[4]}" var="cstatus"/>
							<c:set value="${envelopeData[5]}" var="openingdatestatus"/>
							<c:set value="${envelopeData[6]}" var="timelapsed"/>
							<c:set value="${envelopeData[7]}" var="sortorder"/>
							<c:set value="${envelopeData[8]}" var="minmember"/>
							<c:set value="${envelopeData[9]}" var="isopened"/>
							<c:set value="${envelopeData[10]}" var="isevaluated"/>
							<c:set value="${envelopeData[11]}" var="isEvaluationDone"/>
							<c:set value="${envelopeData[12]}" var="isEnvelopeOpened"/>
							<c:set value="${envelopeData[13]}" var="isNextEnvEvalDone"/>
                                        	<c:set var="flag" value="true"></c:set>
                                            <c:set value="0" var="mandatoryFormVerifiedCount"/><%-- This variable set count of all mandatory forms which are verified by committee member --%>
                                            <c:set value="0" var="mandatoryFormsCount"/>
                                            <c:set value="N" var="isEnbleBidderwiseReport"/>
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
						<c:set var="verifyShareIndividualReport" value="${verifyData[9]}"/>
						<c:set var="verifyShareComparativeReport" value="${verifyData[10]}"/>
						<c:set var="verifyShareDocument" value="${verifyData[11]}"/>
						<c:if test="${verifyEnvelopeId eq envelopeid and verifyIsMandatory eq 1 and verifyFinalCount ne 0}"><%-- Condition used to get mandatory forms count --%>
							<c:set value="${mandatoryFormsCount+1}" var="mandatoryFormsCount"/>
							<c:if test="${verifyOpenCount ge verifyFinalCount}"><%-- Current Envelope have all Mandatory form is verified/decrypted  or not--%>
								<c:set value="${mandatoryFormVerifiedCount+1}" var="mandatoryFormVerifiedCount"/>
							</c:if>
						</c:if>
						<c:if test="${verifyEnvelopeId eq envelopeid and verifyOpenCount gt 0}"><%-- If atleast one form verified then show bidder wise report --%>
							<c:set value="Y" var="isEnbleBidderwiseReport"/>
						</c:if>
					</c:forEach>
					<c:set value="," var="qualifiedBidders"/>
					<c:set value="," var="participatedBidders"/>
					<c:if test="${tenderData.resultSharing eq '2'}"><%-- tenderShareReportDataMap.shareReport=2 Means only Qualified Bidders --%>
						<c:forEach items="${bidderList}" var="bidderData">
							<c:set var="bidderBidderId" value="${bidderData[0]}"/>
							<c:set var="bidderEnvelopeId" value="${bidderData[2]}"/>
							<c:set var="bidderIsApproved" value="${bidderData[4]}"/>
							<c:if test="${envelopeid eq bidderEnvelopeId and bidderIsApproved eq '1'}">
								<c:set value="${qualifiedBidders}${bidderBidderId}," var="qualifiedBidders"/>
							</c:if>
							
							<c:if test="${envelopeid eq bidderEnvelopeId}">
								<c:set value="${participatedBidders}${bidderBidderId}," var="participatedBidders"/>
							</c:if>
						</c:forEach>
					</c:if>
                                    <div class="m-bottom3 box-shadow o-hidden">
                                        <div class="page-title prefix_1 o-hidden border-left border-top border-right border-bottom-none">
                                        	<span class="${timelapsed eq 1 and isopened ne 0 ? 'open-envelope-icn m-top2' : 'close-envelope-icn'} pull-left "></span>
                                        	<h3 style="float:left; font-size:18px;">${envelopename}</h3>
											<h3 style="float:right; font-size:18px;" class="pull-right prefix1_20">
											<spring:message code="lbl_bid_time"/>:
												<c:choose>
													<c:when test="${srno.index ne 0 and tenderData.envelopeType eq 2 and openingdatestatus ne 1}">---</c:when> 
													<c:when test="${openingdatestatus eq 1}">
														${openingdate}
													</c:when> 
												</c:choose>
											</h3>
                                        </div>
                                        <table class="table">
<!--                                             <tr> -->
<!--                                                 <td colspan="3" class="no-padding"> -->
<!--                                                     <table class="table"> -->
<!--                                                         <tr> -->
<%--                                                             <spring:url value="etender/bidder/viewQueries/${tenderId}/${envelopeid}/${currentUserId}" var="responseUrl"/> --%>
<%--                                                                 <c:choose> --%>
<%--                                                                         <c:when test='${isEvaluationDone eq 0 or isNextEnvEvalDone eq 0 }'> --%>
<%--                                                                             <spring:message var="linkRespond" code="linkRespond"/> --%>
<!--                                                                             <td> -->
<%--                                                                             	<a href="${responseUrl}">${linkRespond}</a> --%>
<!--                                                                             </td> -->
<%--                                                                         </c:when>    --%>
<%--                                                                         <c:otherwise> --%>
<!--                                                                             <td> -->
<%--                                                                                 <c:choose> --%>
<%--                                                                                     <c:when test="${isEvaluationDone eq 0}">-</c:when> --%>
<%--                                                                                     <c:otherwise> --%>
<%--                                                                                         <spring:message code="lbl_view_response" var="linkViewResponse" /> --%>
<%--                                                                                         <a href="${responseUrl}">${linkViewResponse}</a> --%>
<%--                                                                                     </c:otherwise> --%>
<%--                                                                                 </c:choose> --%>
<!--                                                                                 </td> -->
<%--                                                                         </c:otherwise> --%>
<%--                                                                     </c:choose> --%>
<!--                                                             </tr> -->
<!--                                                         </table> -->
<!--                                                     </td> -->
<!--                                                 </tr> -->
                                                <c:choose>
                                                <c:when test="${tenderData.resultSharing eq '1' or (tenderData.resultSharing eq '2' and isResultShareDone)}">
                                            <tr>
                                                <%--<div class="page-title prefix_1 o-hidden m-top1 border-left border-top border-right border-bottom-none">${envelopename}</div>--%>
                                                    <td>
                                                            <table class="table">
                                                                    <c:if test="${minmember ne 0}">
                                                                        <tr class="border-top-none">
                                                                                <td class="black a-left" width="50%" colspan="2"><spring:message code="col_min_member"/></td>
                                                                                <td width="50%" colspan="2">${minmember}</td>
                                                                        </tr>
                                                                    </c:if>
                                                                    <tr>
                                                                            <td class="a-left black" width="50%" colspan="2"><spring:message code="lbl_bid_status"/></td>
                                                                            <td width="50%" colspan="2">
                                                                                    <c:choose>									
                                                                                            <c:when test="${srno.index ne 0 and tenderData.envelopeType eq 2 and openingdatestatus ne 1}"><spring:message code="label_date_not_specified"/></c:when>
                                                                                            <c:when test="${timelapsed eq 0 and openingdatestatus eq 1}"><spring:message code="label_date_not_arrive"/></c:when>
                                                                                            <c:when test="${timelapsed eq 0}"><spring:message code="col_open_pending"/></c:when>
                                                                                            <c:when test="${timelapsed eq 1 and isopened eq 0}"><spring:message code="msg_min_approval"/></c:when>
                                                                                            <c:when test="${isopened eq 1}"><spring:message code="col_sts_open"/></c:when>
                                                                                    </c:choose>
                                                                            </td>
                                                                    </tr>
                                                                    <tr>
                                                                            <td colspan="4" class="no-padding">
                                                                                    <table class="table">
                                                                                            <%-- Committee Member Loop to display Committee member --%>
                                                                                            <c:forEach items="${commMemList}" var="committeeData">
                                                                                            	<c:set value="${committeeData[0]}" var="officername"/>
																								<c:set value="${committeeData[3]}" var="childid"/>
																								<c:set value="${committeeData[4]}" var="approvedon"/>
																								<c:set value="${committeeData[8]}" var="isapproved"/>
                                                                                                    <c:if test="${envelopeid eq childid}"><%-- If first loop envelopeId match with committee Member's childId then. childId is also envelopeId --%>
                                                                                                            <tr class="border-top-none">
                                                                                                                    <td width="50%">${officername}</td>
                                                                                                                    <td width="50%">
                                                                                                                        <c:choose>
                                                                                                                            <c:when test="${minmember eq 0}">-</c:when>
                                                                                                                            <c:otherwise>
                                                                                                                                <c:choose>
                                                                                                                                    <c:when test="${isapproved eq 1}">
                                                                                                                                            <spring:message code="col_sts_opened"/>
                                                                                                                                            <c:set value="${approvedon}" var="approvedOn"/>
<%--                                                                                                                                             Remove Seconds from date time --%>
                                                                                                                                            ${approvedOn}	
                                                                                                                                    </c:when>
                                                                                                                                    <c:otherwise><spring:message code="col_status_ope_pending"/></c:otherwise>
                                                                                                                                </c:choose>
                                                                                                                             </c:otherwise>
                                                                                                                        </c:choose>
                                                                                                                    </td>
                                                                                                            </tr>
                                                                                                    </c:if>
                                                                                            </c:forEach>	
                                                                                    </table>
                                                                            </td>
                                                                    </tr>
                                                            </table>
                                                    </td>
                                            </tr>
                                                
							<%--Start: Bidder Listing --%>
							<c:choose>
								<c:when test="${isopened eq 1}"><%-- Bidded bidder listing shown after tender envelope open --%>
									<tr>
                                		<td class="${isopened eq 1?'':'a-center v-a-middle'}">
											<spring:message code="col_status_ope_pending" var="vPending"/>
											<spring:message code="label_bidder_eligible" var="vEligible"/>
											<spring:message code="label_bidder_not_eligible" var="vNotEligible"/>
									<table class="table">
										<c:if test="${not empty bidderList}">
                                                                             <tr class="gradi">
                                                                                <c:choose>
                                                                                    <c:when test="${tblTender.isEvaluationRequired eq 1}">
                                                                                        <th width="50%"><spring:message code="lbl_bidder_name"/></th>
                                                                                        <th width="50%" ><spring:message code="lbl_bid_eval_sts"/></th>
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <th width="100%" colspan="2" class="a-left"><spring:message code="lbl_bidder_name"/></th>
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                            </tr>
                                           </c:if>
										<c:forEach items="${bidderList}" var="bidderData">
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
											<c:choose>
												<c:when test="${tenderData.envelopeType eq 2}"><%-- Multi Envelope Case --%>
													<c:if test="${envelopeid eq bidderEnvelopeId}">
														<tr class="border-top-none">
															<c:set value="${fn:replace(bidderCompanyName,'label_consort_with',conrtiumWith)}" var="companyNames"/>
															<c:set value="${fn:substring(companyNames,0,fn:length(companyNames)-1)}" var="companyNames"/>
															<%--Start: Consortium Logic to display bidder's company name Encoded --%>
															<c:if test="${tenderData.isEncodedName eq 1 and (envId eq 4 or envId eq 5)}"><%-- For Multi Envelope Tender encoded is yes and price bid/Techno-commercial envelope Then show encoded name--%>
																<c:set value="${bidderEncodedName}" var="companyNames"/>
															</c:if>
															<%--End: Consortium Logic to display bidder's company name Encoded --%>
															<c:choose>
																<c:when test="${srno.index eq 0}">
																	<td <c:if test="${tblTender.isEvaluationRequired eq 0}">colspan="2"</c:if>>
																		<c:choose>	
																			<c:when test="${isEnbleBidderwiseReport eq 'N'}">${companyNames}</c:when>
																			<c:when test="${tenderData.isConsortiumAllowed eq 1}">
																				<%--<abc:href href="etender/bidder/bidderwisereport/${tenderId}/${bidderEnvelopeId}/1/1/${encConsortiumId}/1" title="${toolTipBidderAbstReport}" label="${companyNames}"/>--%>
                                                                                                                                                                ${companyNames}
																			</c:when>
																			<c:otherwise>
																				<%--<abc:href href="etender/bidder/bidderwisereport/${tenderId}/${bidderEnvelopeId}/0/1/${encBidderId}/1" title="${toolTipBidderAbstReport}"  label="${companyNames}"/>--%>
                                                                                                                                                                ${companyNames}
																			</c:otherwise>
																		</c:choose> 
																	</td>
                                                                    <c:if test="${tblTender.isEvaluationRequired eq 1}">
                                                                     <td width="50%">
																		<c:choose>
																			<c:when test="${tenderData.resultSharing eq '2'}"><%-- For Manual Result Sharing --%>
																				<c:choose>
																					<c:when test="${tenderShareReportDataMap.shareReport eq '1' or (tenderShareReportDataMap.shareReport eq '2' and fn:contains(qualifiedBidders,currentUserId)) or (tenderShareReportDataMap.shareReport eq '3' and fn:contains(participatedBidders,currentUserId))}"><%--For All Bidders , For Qualified Bidders and Participated Bidders --%>
																						<c:choose>
																							<c:when test="${empty bidderIsApproved }">
																							${vPending}
																							</c:when>
																							<c:when test="${bidderIsApproved eq 1}">
																							<div data-toggle="tooltip" data-placement="left" title="" data-original-title="${bidderRemarks}">
																							${vEligible}
																							</div>
																							</c:when>
																							<c:when test="${bidderIsApproved eq 0}">
																							<div data-toggle="tooltip" data-placement="left" title="" data-original-title="${bidderRemarks}">
																							${vNotEligible}
																							</div> 
																							</c:when>
																							<c:otherwise>${vPending}</c:otherwise>
																						</c:choose>
																					</c:when>
																					<c:otherwise>---</c:otherwise>
																				</c:choose>
																			</c:when>
																			<c:when test="${tenderData.resultSharing eq '1'}"><%-- For Auto Result Sharing --%>
																				<c:choose>
																				<c:when test="${empty bidderIsApproved }">
																							${vPending}
																							</c:when>
																					<c:when test="${bidderIsApproved eq 1}">
																					<div data-toggle="tooltip" data-placement="left" title="" data-original-title="${bidderRemarks}">
																							${vEligible}
																							</div>
																					</c:when>
																					<c:when test="${bidderIsApproved eq 0}">
																							<div data-toggle="tooltip" data-placement="left" title="" data-original-title="${bidderRemarks}">
																							${vNotEligible}
																							</div> 
																					</c:when>
																					<c:otherwise>${vPending}</c:otherwise>
																				</c:choose>
																			</c:when>
																		</c:choose>
                                                                     </td>
                                                                 </c:if>
																</c:when>
																<c:otherwise>
																	<td <c:if test="${tblTender.isEvaluationRequired eq 0}">colspan="2"</c:if>>
																		<c:choose>
																			<c:when test="${isEnbleBidderwiseReport eq 'N'}">${companyNames}</c:when>
																			<c:when test="${tenderData.isConsortiumAllowed eq 1}">
																				<%--<abc:href href="etender/bidder/bidderwisereport/${tenderId}/${bidderEnvelopeId}/1/1/${encConsortiumId}/1" title="${toolTipBidderAbstReport}" label="${companyNames}"/>--%>
                                                                                                                                                                ${companyNames}
																			</c:when>
																			<c:otherwise>
																				<%--<abc:href href="etender/bidder/bidderwisereport/${tenderId}/${bidderEnvelopeId}/0/1/${encBidderId}/1" title="${toolTipBidderAbstReport}" label="${companyNames}"/>--%>
                                                                                                                                                                ${companyNames}
																			</c:otherwise>
																		</c:choose> 
																	</td>	
                                                                                                                                        <c:if test="${tblTender.isEvaluationRequired eq 1}">
                                                                                                                                            <td width="50%">
																		<c:choose>
																			<c:when test="${tenderData.resultSharing eq '2' and (tenderShareReportDataMap.shareReport eq '1' or (tenderShareReportDataMap.shareReport eq '2' and fn:contains(qualifiedBidders,currentUserId)) or (tenderShareReportDataMap.shareReport eq '3' and fn:contains(participatedBidders,currentUserId)))}"><%--For All Bidders , For Qualified Bidders and Participated Bidders --%>
																					<c:choose>
																					<c:when test="${empty bidderIsApproved}">
																						${vPending}
																					</c:when>
																					<c:when test="${bidderIsApproved eq 1}">
																						<div data-toggle="tooltip" data-placement="left" title="" data-original-title="${bidderRemarks}">${vEligible}</div>
																					</c:when>
																					<c:when test="${bidderIsApproved eq 0}">
																						<div data-toggle="tooltip" data-placement="left" title="" data-original-title="${bidderRemarks}">${vNotEligible}</div>
																					</c:when>
																					</c:choose>
																							
																			</c:when>
																			<c:when test="${tenderData.resultSharing eq '1'}">
																			<div data-toggle="tooltip" data-placement="left" title="" data-original-title="${bidderRemarks}">
																							<c:choose>
																					<c:when test="${empty bidderIsApproved}">
																						${vPending}
																					</c:when>
																					<c:when test="${bidderIsApproved eq 1}">
																						<div data-toggle="tooltip" data-placement="left" title="" data-original-title="${bidderRemarks}">${vEligible}</div>
																					</c:when>
																					<c:when test="${bidderIsApproved eq 0}">
																						<div data-toggle="tooltip" data-placement="left" title="" data-original-title="${bidderRemarks}">${vNotEligible}</div>
																					</c:when>
																					</c:choose>
																							</div>
																			</c:when>
																			<c:otherwise>---</c:otherwise>
																		</c:choose>
                                                                                                                                            </td>
                                                                                                                                        </c:if>
																</c:otherwise>
																
															</c:choose>
														</tr>
													</c:if>
												</c:when>
												<c:otherwise><%-- Single Envelope Case --%>
													<tr class="border-top-none">
														<c:set value="${fn:replace(bidderCompanyName,'label_consort_with',conrtiumWith)}" var="companyNames"/>
														<c:set value="${fn:substring(companyNames,0,fn:length(companyNames)-1)}" var="companyNames"/>
														<c:if test="${tenderData.isEncodedName eq 1 and (envId eq 4 or envId eq 5)}"><%-- For Multi Envelope Tender encoded is yes and price bid/Techno-commercial envelope Then show encoded name--%>
															<c:set value="${bidderEncodedName}" var="companyNames"/>
														</c:if>	
														<c:if test="${envelopeid eq bidderEnvelopeId}"><%--Bidder Envelope Id match with current Envelope then display data --%>
															<td <c:if test="${tblTender.isEvaluationRequired eq 0}">colspan="2"</c:if>>
																<c:choose>
																	<c:when test="${isEnbleBidderwiseReport eq 'N'}">${companyNames}</c:when>
																	<c:when test="${tenderData.isConsortiumAllowed eq 1}"><%-- If it's a consortium case then pass consortiumId other wise pass bidderId --%>
																		<%--<abc:href href="etender/bidder/bidderwisereport/${tenderId}/${envelopeid}/1/1/${encConsortiumId}/1" title="${toolTipBidderAbstReport}" label="${companyNames}"/>--%>
                                                                                                                                                ${companyNames}
																	</c:when>
																	<c:otherwise><%-- If it's a consortium case then pass consortiumId other wise pass bidderId --%>
																		<%--<abc:href href="etender/bidder/bidderwisereport/${tenderId}/${envelopeid}/0/1/${encBidderId}/1" title="${toolTipBidderAbstReport}" label="${companyNames}"/>--%>
                                                                                                                                                ${companyNames}
																	</c:otherwise>
																</c:choose> 
															</td>	
                                                                                                                        <c:if test="${tblTender.isEvaluationRequired eq 1}">
                                                                                                                            <td width="50%">
																<c:choose>
																	<c:when test="${tenderData.resultSharing eq '2'}"><%-- For Manual Result Sharing --%>
																		<c:choose>
																			<c:when test="${tenderShareReportDataMap.shareReport eq '1' or (tenderShareReportDataMap.shareReport eq '2' and fn:contains(qualifiedBidders,currentUserId)) or (tenderShareReportDataMap.shareReport eq '3' and fn:contains(participatedBidders,currentUserId))}"><%--For All Bidders , For Qualified Bidders and Participated Bidders --%>
																				<c:choose>
																				<c:when test="${empty bidderIsApproved }">
																							${vPending}
																							</c:when>
																					<c:when test="${bidderIsApproved eq 1}">
																					<div data-toggle="tooltip" data-placement="left" title="" data-original-title="${bidderRemarks}">
																							${vEligible}
																							</div>
																					</c:when>
																					<c:when test="${bidderIsApproved eq 0}">
																					<div data-toggle="tooltip" data-placement="left" title="" data-original-title="${bidderRemarks}">
																							${vNotEligible}
																							</div> 
																					</c:when>
																					<c:otherwise>${vPending}</c:otherwise>
																				</c:choose>
																			</c:when>
																			<c:otherwise>---</c:otherwise>
																		</c:choose>
																	</c:when>
																	<c:when test="${tenderData.resultSharing eq '1'}"><%-- For Auto Result Sharing --%>
																		<c:choose>
																		<c:when test="${empty bidderIsApproved }">
																							${vPending}
																							</c:when>
																			<c:when test="${bidderIsApproved eq 1}">
																			<div data-toggle="tooltip" data-placement="left" title="" data-original-title="${bidderRemarks}">
																							${vEligible}
																							</div>
																			</c:when>
																			<c:when test="${bidderIsApproved eq 0}">
																			<div data-toggle="tooltip" data-placement="left" title="" data-original-title="${bidderRemarks}">
																							${vNotEligible}
																							</div> 
																			</c:when>
																			<c:otherwise>${vPending}</c:otherwise>
																		</c:choose>
																	</c:when>
																</c:choose>
                                                                                                                            </td>	
                                                                                                                        </c:if>
														</c:if>
													</tr>	
												</c:otherwise>
											</c:choose>
										</c:forEach>
										<c:if test="${empty bidderList}">
											<div class="m-top1 noticeMsg a-left"><spring:message code="msg_no_bidsubmit"/></div>
											<c:set var="flag" value="false"></c:set>
										</c:if>
									</table>
									</td>
									</tr>
								</c:when>
								<c:otherwise>
<%--                                                                     <table width="100%" class="border-right border-left"> --%>
<%--                                                                             <tr class="border-right a-center gradi"> --%>
<%--                                                                                 <c:choose> --%>
<%--                                                                                     <c:when test="${tblTender.isEvaluationRequired eq 1}"> --%>
<%--                                                                                         <th width="50%"><spring:message code="lbl_bidder_name"/></th> --%>
<%--                                                                                         <th width="50%" ><spring:message code="lbl_bid_eval_sts"/></th> --%>
<%--                                                                                     </c:when> --%>
<%--                                                                                     <c:otherwise> --%>
<%--                                                                                         <th width="100%" colspan="2" class="a-left"><spring:message code="lbl_bidder_name"/></th> --%>
<%--                                                                                     </c:otherwise> --%>
<%--                                                                                 </c:choose> --%>
<%--                                                                             </tr> --%>
<%--                                                                             <tr> --%>
<%--                                                                                 <td ${tblTender.isEvaluationRequired eq 1 ? "colspan='2'" : "colspan='1'"}>${vEnvNotOpen}</td> --%>
<%--                                                                             </tr> --%>
<%--                                                                     </table> --%>
                                                                </c:otherwise>
							</c:choose>
							<%--End: Bidder Listing --%>
						<%--Start: Forms Listing --%>
						<%-- once opening date & time is lapsed  and check if "No bidder has participated in tender" then not displayed "msg_form_no_bid" --%>
					<c:if test="${not empty bidderList}">
						<c:choose>
							<c:when test="${isopened eq 1}">
							<tr>
							<td>
							<table class="table">
							<tr class="gradi">
								<th width="50%" class="a-center"><spring:message code="field_formName"/></th>
								<th width="50%" class="a-center" colspan="2"><spring:message code="tab_tender_reports"/></th>
							</tr>
										<c:forEach items="${bidderFormList}"  varStatus="verifyCnt" var="verifyData">
											<c:set var="verifyEnvelopeId" value="${verifyData[0]}"/>
											<c:set var="verifyFormId" value="${verifyData[1]}"/>
											<c:set var="verifyFormName" value="${verifyData[2]}"/>
											<c:set var="verifyIsPriceBid" value="${verifyData[3]}"/>
											<c:set var="verifyIsEncryptionReq" value="${verifyData[4]}"/>
											<c:set var="verifyFinalCount" value="${verifyData[5]}"/>
											<c:set var="verifyOpenCount" value="${verifyData[6]}"/>
											<c:set var="verifyCstatus" value="${verifyData[7]}"/>
											<c:set var="verifyIsMandatory" value="${verifyData[8]}"/>
											<c:set var="verifyShareIndividualReport" value="${verifyData[9]}"/>
											<c:set var="verifyShareComparativeReport" value="${verifyData[10]}"/>
											<c:set var="verifyShareDocument" value="${verifyData[11]}"/>
						
											<c:if test="${envelopeid eq verifyEnvelopeId}">
												<spring:message code="msg_form_no_bid"         var="vFormNoBidded"/>
												<spring:message code="msg_form_cancel"         var="vFormCancelled"/>
												<spring:message code="link_comparative_report" var="linkCompare"/>
												<spring:message code="link_individual_report"  var="linkIndiv"/>
												<tr>
													<%--
														verifyOpenCount = How many bidded-forms are verified by committee member
														verifyFinalCount= How many bidded-forms required to disable verify link
														After all bidded forms are verified then verify link disable.
														verifyCstatus=1 Approved form
														verifyCstatus=2 Cancelled form 
														committeeMember=It has user Id who are committe member and logged in system
													--%>
														<c:choose>
														<c:when test="${tenderData.resultSharing eq '2'}"><%-- Result sharing Manual case Logic --%>
															<c:choose>
																<c:when test="${false and verifyOpenCount eq 0}"><%-- If openCount=0 Means no bidded form verify  --%>
																	<td>${verifyFormName}<c:if test="${verifyIsMandatory eq 1}"><span class="red"> *</span></c:if></td>
																	<c:choose>
																		<c:when test="${verifyCstatus eq 2}"><td colspan="3" class="a-left"><span class="black">${vFormCancelled}</span></td></c:when>
																		<c:when test="${verifyFinalCount eq 0}"><td colspan="3" class="a-left"><span class="black">${vFormNoBidded}</span></td>
																		</c:when>
																		<c:otherwise><td class="a-center">---</td></c:otherwise>
																	</c:choose>
																</c:when>
																<c:otherwise><%-- Both count match then link verified disable and reports are enable--%>
																	<td>${verifyFormName}<c:if test="${verifyIsMandatory eq 1}"><span class="red"> *</span></c:if></td>
																	<c:choose>
																		<c:when test="${verifyCstatus eq 2}"><td colspan="3" class="a-left"><span class="black">${vFormCancelled}</span></td></c:when>
																		<c:when test="${verifyFinalCount eq 0}"><td colspan="3" class="a-left"><span class="black">${vFormNoBidded}</span></td></c:when>
																		<c:otherwise>
																			<td class="a-left">
																				<c:choose>
																					<c:when test="${(tenderShareReportDataMap.shareReport eq '2' and fn:contains(qualifiedBidders,currentUserId)) or (tenderShareReportDataMap.shareReport eq '3' and fn:contains(participatedBidders,currentUserId))}"><%-- For Qualified Bidders And Participated Bidders --%>
																						<c:choose>
																							<c:when test="${verifyShareIndividualReport eq '1' and verifyShareComparativeReport eq '1'}">
																								<spring:url var="urlIndividual" value="/etender/bidder/tenderindividualreport/${tenderId}/${verifyEnvelopeId}/${verifyFormId}/1/1"/>
																								<a href="${urlIndividual}">${linkIndiv}</a> |
																								<spring:url var="urlComparative" value="/etender/bidder/tendercomparativereport/${tenderId}/${verifyEnvelopeId}/${verifyFormId}/1/2"/>
																								<a href="${urlComparative}">${linkCompare}</a>
																							</c:when>
																							<c:when test="${verifyShareIndividualReport eq '0' and verifyShareComparativeReport eq '0'}">---</c:when>
																							<c:otherwise>
																								<c:if test="${verifyShareIndividualReport  eq '1'}">
																									<spring:url var="urlIndividual" value="/etender/bidder/tenderindividualreport/${tenderId}/${verifyEnvelopeId}/${verifyFormId}/1/1"/>
																									<a href="${urlIndividual}">${linkIndiv}</a> |
																								</c:if>
																								<c:if test="${verifyShareComparativeReport eq '1'}">
																									<spring:url var="urlComparative" value="/etender/bidder/tendercomparativereport/${tenderId}/${verifyEnvelopeId}/${verifyFormId}/1/2"/>
																								<a href="${urlComparative}">${linkCompare}</a>
																								</c:if>
																							</c:otherwise>
																						</c:choose>
																					</c:when>
																					<c:when test="${tenderShareReportDataMap.shareReport eq '1'}"> <%-- For All Bidders --%>
																						<c:choose>
																							<c:when test="${verifyShareIndividualReport eq '1' and verifyShareComparativeReport eq '1'}">
																								<spring:url var="urlIndividual" value="/etender/bidder/tenderindividualreport/${tenderId}/${verifyEnvelopeId}/${verifyFormId}/1/1"/>
																								<a href="${urlIndividual}">${linkIndiv}</a> |
																								<spring:url var="urlComparative" value="/etender/bidder/tendercomparativereport/${tenderId}/${verifyEnvelopeId}/${verifyFormId}/1/2"/>
																								<a href="${urlComparative}">${linkCompare}</a>
																							</c:when>
																							<c:when test="${verifyShareIndividualReport eq '0' and verifyShareComparativeReport eq '0'}">---</c:when>
																							<c:otherwise>
																								<c:if test="${verifyShareIndividualReport  eq '1'}">
																									<spring:url var="urlIndividual" value="/etender/bidder/tenderindividualreport/${tenderId}/${verifyEnvelopeId}/${verifyFormId}/1/1"/>
																									<a href="${urlIndividual}">${linkIndiv}</a> |
																								</c:if>
																								<c:if test="${verifyShareComparativeReport eq '1'}">
																									<spring:url var="urlComparative" value="/etender/bidder/tendercomparativereport/${tenderId}/${verifyEnvelopeId}/${verifyFormId}/1/2"/>
																									<a href="${urlComparative}">${linkCompare}</a>
																								</c:if>
																							</c:otherwise>
																						</c:choose>
																					</c:when>
																					<c:otherwise>---</c:otherwise>
																				</c:choose>
																			</td>
																		</c:otherwise>
																	</c:choose>	
																</c:otherwise>
															</c:choose>
														</c:when>
														<c:otherwise><%--Auto Result sharing  --%>
															<c:choose>
																<c:when test="${verifyOpenCount eq 0}"><%-- If openCount=0 Means no bidded form verify  --%>
																	<td>${verifyFormName}<c:if test="${verifyIsMandatory eq 1}"><span class="red"> *</span></c:if></td>																	
																	<c:choose>
																		<c:when test="${verifyCstatus eq 2}"><td colspan="3" class="a-left"><span class="black">${vFormCancelled}</span></td></c:when>
 																		<c:when test="${verifyFinalCount eq 0}"><td colspan="3" class="a-left"><span class="black">${vFormNoBidded}</span></td></c:when> 
																		<c:otherwise><td class="a-left">---</td></c:otherwise>
																	</c:choose>
																</c:when>
																<c:otherwise><%-- Both count match then link verified disable and reports are enable--%>
																	<td>${verifyFormName}<c:if test="${verifyIsMandatory eq 1}"><span class="red"> *</span></c:if></td>																	
																	<c:choose>
																		<c:when test="${verifyCstatus eq 2}"><td colspan="3" class="a-left"><span class="black">${vFormCancelled}</span></td></c:when>
 																		<c:when test="${verifyFinalCount eq 0}"><td colspan="3" class="a-left"><span class="m-top1 noticeMsg a-left">${vFormNoBidded}</span></td></c:when> 
																		<c:otherwise>
																			<td class="a-left">
																				<spring:url var="urlIndividual" value="/etender/bidder/tenderindividualreport/${tenderId}/${verifyEnvelopeId}/${verifyFormId}/1/1"/>
																					<a href="${urlIndividual}">${linkIndiv}</a> |
																				<spring:url var="urlComparative" value="/etender/bidder/tendercomparativereport/${tenderId}/${verifyEnvelopeId}/${verifyFormId}/1/2"/>
																					<a href="${urlComparative}">${linkCompare}</a>
																			</td>
																		</c:otherwise>
																	</c:choose>		
																</c:otherwise>
															</c:choose>
														</c:otherwise>
														</c:choose>	
												</tr>
											</c:if>
											<c:if test="${((tenderData.resultSharing eq '2' and tenderShareReportDataMap.showL1Report eq 1) or tenderData.resultSharing eq '1') and verifyCnt.count eq fn:length(bidderFormList) and mandatoryFormsCount ne 0 and mandatoryFormsCount eq mandatoryFormVerifiedCount and (envId eq 4 or envId eq 5)}"><%-- isRebateForm =1 , all forms are verified, and pricebid or technocommercial envelope  --%>
												<tr>
													<td class="a-left">
														<c:choose>
															<c:when test="${tenderResult eq 1}"><spring:url var="urlL1" value="etender/bidder/l1h1report/${tenderId}/1/1"/>
																<a href="${urlL1}">${l1Report}</a>
															</c:when>
															<c:otherwise>${l1Report}</c:otherwise>
														</c:choose>	
													</td>
												</tr>
											</c:if>												
										</c:forEach>
										<c:if test="${empty bidderFormList and flag}">
											<div class="m-top1 noticeMsg a-left"><spring:message code="msg_no_forms_mapped"/></div>
											<c:set var="flag" value="false"></c:set>
										</c:if>
									</table>
									</td>
										</tr>
							</c:when>
						<c:otherwise>
									<tr>
										<td>
											<div class="m-top1 noticeMsg a-left">
													<spring:message code="msg_env_not_open"/>
											</div>
	                                       </td>
	                                   </tr>
								
<%--                                                                     <table width="100%" class="border-right border-left"> --%>
<%-- 										<tr class="gradi"> --%>
<%-- 											<th width="50%" class="a-center"><spring:message code="field_formName"/></th> --%>
<%-- 											<th width="50%" class="a-center" colspan="2"><spring:message code="tab_tender_reports"/></th> --%>
<%-- 										</tr> --%>
<%--                                                                                 <tr> --%>
<%--                                                                                     <td colspan="2">${vEnvNotOpen}</td> --%>
<%--                                                                                 </tr> --%>
<%--                                                                     </table> --%>
									
									
                                 </c:otherwise>
							</c:choose>
					</c:if>							
							<%--End: Forms Listing --%>
                                                   
                                        <%--</table>--%>
                                        
					
					<c:set value="${envelopeData}" var="oldEnvelopeData"/>
                                        </c:when>
                                                <c:otherwise>
                                                    <tr>
                                                        <td class="noticeMsg m-top1"><spring:message code="msg_result_not_share" /></td>
                                                    </tr>
                                                </c:otherwise>
                                            </c:choose>
                                           </table>
                                        </div>
				</c:forEach>
                                    
                                   
		</td>
	</tr>
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
