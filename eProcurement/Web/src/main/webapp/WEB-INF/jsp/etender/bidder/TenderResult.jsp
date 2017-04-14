<%@include file="../../includes/head.jsp"%>
  <%@include file="../../includes/masterheader.jsp"%>

<spring:message code="tooltip_bidderwise_abstract_report"  var="toolTipBidderAbstReport"/>
<spring:message code="link_l1_report"     var="l1Report"/>
<c:if test="${biddingVariant eq 2}"><spring:message code="link_h1_report" var="l1Report"/></c:if>
<spring:message code="col_action"         var='vAction'/>
<spring:message code="label_consort_with" var="conrtiumWith"/>
<c:set value="${sessionObject.userId}" var="currentUserId"/>
<spring:message code="msg_env_not_open" var="vEnvNotOpen"/>
<spring:message code="lbl_back_dashboard" var='backDashboard'/>
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
				<div>
					<c:choose>
						<c:when test="${sessionUserTypeId eq 2 }">
							<a  href="${pageContext.servletContext.contextPath}/etender/bidder/biddingTenderDashboard/${tenderId}"><< 
                                            <c:if test="${tblTender.isAuction eq 0}">
                                               ${backDashboard} 
                                            </c:if>
                                            <c:if test="${tblTender.isAuction eq 1}">
                                                Go To Auction DashBoard
                                            </c:if>
                                            
                                            </a>
						</c:when>
						<c:otherwise>
								<a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}"><< ${backDashboard}</a>
						</c:otherwise>
					</c:choose>
					
				</div>
				<div class="box-header with-border">
					<h2 class="box-title">Result</h2>
				</div>
                                       
                <div class="box-body">
		<div class="row">
			<div class="col-lg-12 col-md-12 col-xs-12">
				<div class="box-body pad">                           
                                        <c:if test="${tblTender.isAuction eq 0}">
                                         
<table  class="table table-striped table-responsive">	
	<tr>
		<td>
			<%--<table width="100%" class="table-border border-right">--%>
			 	<c:set value="${tenderDetailList}" var="tenderData"/> 
			 	<c:if test="${tenderData.autoResultSharing eq '1'}">
			 		<c:set value="${tblShareReport}" var="tenderShareReportDataMap"/>
		 		</c:if>                                    
                                    <%--<c:when test="${true or tenderData.autoResultSharing eq '1' or (tenderData.autoResultSharing eq '1' and isResultShareDone)}">--%>
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
					<c:if test="${tenderData.autoResultSharing eq '1'}"><%-- tenderShareReportDataMap.shareReport=2 Means only Qualified Bidders --%>
						<c:forEach items="${bidderList}" var="bidderData">
						
							<c:set var="bidderBidderId" value="${bidderData[0]}"/>
							<c:set var="bidderEnvelopeId" value="${bidderData[2]}"/>
							<c:set var="bidderUserId" value="${bidderData[10]}"/>
							<c:set var="bidderIsApproved" value="${not empty bidderData[4] ? bidderData[4] : 0}"/>
							<c:if test="${envelopeid eq bidderEnvelopeId and bidderIsApproved eq 1}">
								<c:set value="${qualifiedBidders}${bidderUserId}," var="qualifiedBidders"/>
							</c:if>
							
							<c:if test="${envelopeid eq bidderEnvelopeId}">
								<c:set value="${participatedBidders}${bidderUserId}," var="participatedBidders"/>
							</c:if>
						</c:forEach>
					</c:if>
                                    <div class="m-bottom3 box-shadow o-hidden">
                                        <div class="page-title prefix_1 o-hidden border-left border-top border-right border-bottom-none">
                                        	<span class="${timelapsed eq 1 and isopened ne 0 ? 'open-envelope-icn m-top2' : 'close-envelope-icn'} pull-left "></span>
                                        	<h3 style="float:left;">${envelopename}</h3>
                                        	<c:if test="${!fromOfficer}">
											<h3 style="float:right;" class="pull-right prefix1_20">
											<spring:message code="lbl_bid_time"/>:
												<c:choose>
													<c:when test="${srno.index ne 0 and tenderData.envelopeType eq 2 and openingdatestatus ne 1}">---</c:when> 
													<c:when test="${openingdatestatus eq 1}">
														<fmt:formatDate pattern="${clientDateFormate}" value="${openingdate}" />
													</c:when> 
												</c:choose>
											</h3>
											</c:if>
                                        </div>
                                        <table class="table">
                                                <c:choose>
                                                <c:when test="${tenderData.autoResultSharing eq '0' or (tenderData.autoResultSharing eq '1' and isResultShareDone)}">
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
                                                                                                                                           ${approvedon} 	
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
											<c:set var="bidderIsApproved" value="${not empty bidderData[4] ? bidderData[4] : 0}"/>
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
															<c:set value="${fn:substring(companyNames,0,fn:length(companyNames))}" var="companyNames"/>
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
                                                                                                                                                                ${companyNames}
																			</c:when>
																			<c:otherwise>
                                                                                                                                                                ${companyNames}
																			</c:otherwise>
																		</c:choose> 
																	</td>
                                                                    <c:if test="${tblTender.isEvaluationRequired eq 1}">
                                                                     <td width="50%">
																		<c:choose>
																			<c:when test="${tenderData.autoResultSharing eq '1'}"><%-- For Manual Result Sharing --%>
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
																			<c:when test="${tenderData.autoResultSharing eq '0'}"><%-- For Auto Result Sharing --%>
																				<c:choose>
																				<c:when test="${empty bidderIsApproved }">
																							${vPending}
																							</c:when>
																					<c:when test="${bidderIsApproved eq 1}">
																					<div data-toggle="tooltip" data-placement="left" title="" data-original-title="${bidderRemarks}">
																							${vEligible}
																							</div>
																					</c:when>
																					<c:when test="${ bidderIsApproved eq 0}">
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
                                                                                                                                                                ${companyNames}
																			</c:when>
																			<c:otherwise>
                                                                                                                                                                ${companyNames}
																			</c:otherwise>
																		</c:choose> 
																	</td>	
                                                                                                                                        <c:if test="${tblTender.isEvaluationRequired eq 1}">
                                                                                                                                            <td width="50%">
																		<c:choose>
																			<c:when test="${tenderData.autoResultSharing eq '1' and (tenderShareReportDataMap.shareReport eq '1' or (tenderShareReportDataMap.shareReport eq '2' and fn:contains(qualifiedBidders,currentUserId)) or (tenderShareReportDataMap.shareReport eq '3' and fn:contains(participatedBidders,currentUserId)))}"><%--For All Bidders , For Qualified Bidders and Participated Bidders --%>
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
																			<c:when test="${tenderData.autoResultSharing eq '0'}">
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
														<c:set value="${fn:substring(companyNames,0,fn:length(companyNames))}" var="companyNames"/>
														<c:if test="${tenderData.isEncodedName eq 1 and (envId eq 4 or envId eq 5)}"><%-- For Multi Envelope Tender encoded is yes and price bid/Techno-commercial envelope Then show encoded name--%>
															<c:set value="${bidderEncodedName}" var="companyNames"/>
														</c:if>	
														<c:if test="${envelopeid eq bidderEnvelopeId}"><%--Bidder Envelope Id match with current Envelope then display data --%>
															<td <c:if test="${tblTender.isEvaluationRequired eq 0}">colspan="2"</c:if>>
																<c:choose>
																	<c:when test="${isEnbleBidderwiseReport eq 'N'}">${companyNames}</c:when>
																	<c:when test="${tenderData.isConsortiumAllowed eq 1}"><%-- If it's a consortium case then pass consortiumId other wise pass bidderId --%>
                                                                                                                                                ${companyNames}
																	</c:when>
																	<c:otherwise><%-- If it's a consortium case then pass consortiumId other wise pass bidderId --%>
                                                                                                                                                ${companyNames}
																	</c:otherwise>
																</c:choose> 
															</td>	
                                                                                                                        <c:if test="${tblTender.isEvaluationRequired eq 1}">
                                                                                                                            <td width="50%">
																<c:choose>
																	<c:when test="${tenderData.autoResultSharing eq '1'}"><%-- For Manual Result Sharing --%>
																		<c:choose>
																			<c:when test="${sessionUserTypeId eq 1 or tenderShareReportDataMap.shareReport eq '1' or (tenderShareReportDataMap.shareReport eq '2' and fn:contains(qualifiedBidders,currentUserId)) or (tenderShareReportDataMap.shareReport eq '3' and fn:contains(participatedBidders,currentUserId))}"><%--For All Bidders , For Qualified Bidders and Participated Bidders --%>
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
																	<c:when test="${sessionUserTypeId eq 1 or tenderData.autoResultSharing eq '0'}"><%-- For Auto Result Sharing --%>
																		<c:choose>
																		<c:when test="${empty bidderIsApproved}">
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
														<c:when test="${!fromOfficer}">
															<spring:url var="urlIndividual" value="/etender/bidder/tenderindividualreport/${tenderId}/${verifyEnvelopeId}/${verifyFormId}/1/1"/>
															<spring:url var="urlComparative" value="/etender/bidder/tendercomparativereport/${tenderId}/${verifyEnvelopeId}/${verifyFormId}/1/2"/>
														</c:when>
														<c:otherwise>
														<spring:url var="urlIndividual" value="/etender/buyer/tenderindividualreport/${tenderId}/${verifyEnvelopeId}/${verifyFormId}/1/1"/>
														<spring:url var="urlComparative" value="/etender/buyer/tendercomparativereport/${tenderId}/${verifyEnvelopeId}/${verifyFormId}/1/2"/>
														</c:otherwise>
													</c:choose>
													
													
														<c:choose>
														<c:when test="${tenderData.autoResultSharing eq '1'}"><%-- Result sharing Manual case Logic --%>
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
																					<c:when test="${sessionUserTypeId eq 1 or (tenderShareReportDataMap.shareReport eq '2' and fn:contains(qualifiedBidders,currentUserId)) or (tenderShareReportDataMap.shareReport eq '3' and fn:contains(participatedBidders,currentUserId))}"><%-- For Qualified Bidders And Participated Bidders --%>
																						<c:choose>
																							<c:when test="${verifyShareIndividualReport eq '1' and verifyShareComparativeReport eq '1'}">
																								
																								<a href="${urlIndividual}">${linkIndiv}</a> 
																								<a href="${urlComparative}">${linkCompare}</a>
																							</c:when>
																							<c:when test="${verifyShareIndividualReport eq '0' and verifyShareComparativeReport eq '0'}">---</c:when>
																							<c:otherwise>
																								<c:if test="${verifyShareIndividualReport  eq '1'}">
																									<a href="${urlIndividual}">${linkIndiv}</a> 
																								</c:if>
																								<c:if test="${verifyShareComparativeReport eq '1'}">
																								<a href="${urlComparative}">${linkCompare}</a>
																								</c:if>
																							</c:otherwise>
																						</c:choose>
																					</c:when>
																					<c:when test="${sessionUserTypeId eq 1 or tenderShareReportDataMap.shareReport eq '1'}"> <%-- For All Bidders --%>
																						<c:choose>
																							<c:when test="${verifyShareIndividualReport eq '1' and verifyShareComparativeReport eq '1'}">
																								<a href="${urlIndividual}">${linkIndiv}</a> 
																								<a href="${urlComparative}">${linkCompare}</a>
																							</c:when>
																							<c:when test="${verifyShareIndividualReport eq '0' and verifyShareComparativeReport eq '0'}">---</c:when>
																							<c:otherwise>
																								<c:if test="${verifyShareIndividualReport  eq '1'}">
																									<a href="${urlIndividual}">${linkIndiv}</a> 
																								</c:if>
																								<c:if test="${verifyShareComparativeReport eq '1'}">
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
																					<a href="${urlIndividual}">${linkIndiv}</a> 
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
											<c:if test="${((tenderData.autoResultSharing eq '1' and tenderShareReportDataMap.showL1Report eq 1) or tenderData.autoResultSharing eq '0') and verifyCnt.count eq fn:length(bidderFormList) and mandatoryFormsCount ne 0 and mandatoryFormsCount eq mandatoryFormVerifiedCount and (envId eq 4 or envId eq 5)}"><%-- isRebateForm =1 , all forms are verified, and pricebid or technocommercial envelope  --%>
												<tr>
													<td>Report</td>
													<td class="a-left">
															<c:choose>
																<c:when test="${!fromOfficer}">
																	<spring:url var="urlL1" value="/etender/bidder/l1h1report/${tenderId}/1/1/${verifyFormId}"/>
																</c:when>
																<c:otherwise>
																	<spring:url var="urlL1" value="/etender/buyer/l1h1report/${tenderId}/1/1/${verifyFormId}"/>
																</c:otherwise>
															</c:choose>
															
															<a href="${urlL1}">${l1Report}</a>
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
													<label class="black"> <spring:message code="msg_env_not_open"/></label>
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
					<c:if test="${isopened eq 1 and !fromOfficer}">
					<tr>
						<td>Seek clarification
                        	<a href="${pageContext.servletContext.contextPath}/etender/bidder/viewQueries/${tenderId}/${envelopeid}/${sessionObject.bidderId}">Response</a>
                        </td>
					</tr>
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
<c:if test="${!fromOfficer}">
<div>
	<table width="100%">
		<tr>
            		<td>	
                                            		View purchase order
                                            	</td>
                                            	<td>
                                            		<c:choose>
                                            			<c:when test="${poId ne 0}">
                                            				<a href="${pageContext.servletContext.contextPath}/etender/bidder/getpurchaseorderdashboardbidder/${tenderId}">Dashboard</a>
                                            			</c:when>
                                            			<c:otherwise>
                                            				Purchase order not generated yet.
                                            			</c:otherwise>
                                            		</c:choose>
                                            		
                                            	</td>
                                            </tr>
                                            </table>
</div>
</c:if>

                              </c:if>  
                                    <c:if test="${tblTender.isAuction eq 1}">
                                        <div class="box-body">
							<div class="row">

								<div class="col-lg-12 col-md-12 col-xs-12">
									<table class="table table-striped table-responsive text-center">
										<thead>
											<tr>
                                                                                            <th class="text-center">No.</th>
												<th  class="text-center">Bid Value</th>
												<th  class="text-center">Bid Time</th>
                                                                                                <th class="text-center">Is Valid Or Not?</th>
												
											</tr>
										</thead>
										<tbody class="row" id="dvMainDocumentForm">
                                                                                    <c:set var="i" value="0"/>
                                                                                    <c:forEach var="entry" items="${bidHistory}">
                                                                                        <c:set var="i" value="${i+1}"/>
                                                                                        
                                                                                        <tr>
                                                                                             <td class="control-label">${i}</td>
                                                                                            <td class="control-label">
                                                                                                <c:if test="${tblTender.biddingType eq 2}">
                                                                                                    ${entry.bidValue / ExchangeRate}
                                                                                                </c:if>
                                                                                                <c:if test="${tblTender.biddingType ne 2}">
                                                                                                    ${entry.bidValue}
                                                                                                </c:if>
                                                                                                
                                                                                            </td>
                                                                                            <fmt:formatDate value="${entry.bidDateTime}" var="formattedDate"  type="date" pattern="dd-MMM-yyyy HH:mm:ss" />
                                                                                            <td class="control-label">${formattedDate}</td>
                                                                                            <td class="control-label">
                                                                                                <c:if test="${entry.isValid eq 1}">
                                                                                                    Valid
                                                                                                </c:if>
                                                                                                <c:if test="${entry.isValid eq 0}">
                                                                                                    InValid
                                                                                                </c:if>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </c:forEach>
                                                                                    </tbody>
                                                                            <tfoot>
                                                                                <tr>
                                                                                        <td colspan="3" align="center">
                                                                                            <input type="hidden" id="PriceSummryColumn" name="PriceSummryColumn">
                                                                                                <input type="hidden" id="formId" value="${formId}" name="formId">
                                                                                             <input type="hidden" id="tenderId" value="${tenderId}" name="tenderId">
                                                                                                
                                                                                                 <c:if test="${not empty PriceSummaryColumn}">
                                                                                            
                                                                                                <button type="submit" class="btn btn-submit" id="btnSubmitForm" onclick="return callForEvaluationColumn();">Submit</button>
                                                                                             <button type="button" class="btn btn-submit">Reset</button></c:if>
                                                                                        </td>
                                                                                    </tr>
                                                                            </tfoot>
									</table>
								</div>

							</div>
						</div>
                                    </c:if>

            </div>
</div>
</div>
</div>
                             
                                        
</div>
</div>
</div>
</section>
</div>
<%@include file="../../includes/footer.jsp"%>