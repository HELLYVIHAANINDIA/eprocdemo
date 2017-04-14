<!DOCTYPE html>
<html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../../includes/header.jsp"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<spring:message code="lbl_back_dashboard" var='backDashboard'/>
<spring:message code="col_action" var='vAction'/>
<spring:message code="lbl_bidder_name" var="bidderName"/>
<spring:message code="lbl_bid_eval_sts" var="status"/>
<spring:message code="label_bidder_eligible" var="vEligible"/>
<spring:message code="label_bidder_not_eligible" var="vNotEligible"/>
<spring:message code="col_open_pending" var="pending"/>
<spring:message code="link_individual_report"  var="linkIndiv"/>
<spring:message code="link_comparative_report" var="linkCompare"/>
</head>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="../../includes/leftaccordion.jsp"%>

<div class="content-wrapper">

	<section class="content-header">
		<c:if test="${not empty successMsg}">
			<div>
				<span class="alert alert-success"><spring:message
						code="${successMsg}" />
				</span>
			</div>
		</c:if>
		<c:if test="${not empty errorMsg}">
			<div>
				<span class="alert alert-danger"><spring:message
						code="${errorMsg}" />
				</span>
			</div>
		</c:if>
		<div>
			<a
				href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}"
				class="btn btn-submit"><< ${backDashboard}</a>
		</div>
	</section>

	<section class="content">
		<div class="row">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="box">

					<div class="box-header with-border">
						<h3 class="box-title">Bid Opening</h3>
					</div>
					<div class="box-body">
						<div class="row">
							<div class="col-lg-12 col-md-12 col-xs-12">
								<div class="box-body pad">
									<table class="table table-striped table-responsive">
										<c:set value="${sessionObject.userId}" var="currentUserId" />
										<c:set value="${isEvaluationRequired}"
											var="isEvaluationRequired" />
										<c:forEach items="${envList}" var="envlopeDtls"
											varStatus="srno">
											<c:set value="${envlopeDtls[0]}" var="envelopeid" />
											<c:set value="${envlopeDtls[1]}" var="envelopename" />
											<c:set value="${envlopeDtls[2]}" var="openingdate" />
											<c:set value="${envlopeDtls[3]}" var="envId" />
											<c:set value="${envlopeDtls[4]}" var="cstatus" />
											<c:set value="${envlopeDtls[5]}" var="openingdatestatus" />
											<c:set value="${envlopeDtls[6]}" var="timelapsed" />
											<c:set value="${envlopeDtls[7]}" var="sortorder" />
											<c:set value="${envlopeDtls[8]}" var="minmember" />
											<c:set value="${envlopeDtls[9]}" var="isopened" />
											<c:set value="${envlopeDtls[10]}" var="isevaluated" />
											<c:set value="${envlopeDtls[11]}" var="isEvaluationDone" />


											<thead>
												<tr>
													<th>${envelopename}</th>
													<c:choose>
														<c:when
															test="${srno.index ne 0 and envelopeType eq 2 and openingdatestatus ne 1}">
															<th>---</th>
														</c:when>
														<c:when test="${openingdatestatus eq 1}">
															<th><fmt:formatDate pattern="${clientDateFormate}"
																	value="${openingdate}" />
															</th>
														</c:when>
													</c:choose>
												</tr>
											</thead>
											<c:if
												test="${biddingType eq 2 and (envId eq 4 or envId eq 5) and isopened ne 1}">
												<tr>
													<td>ICB Rate</td>
													<c:choose>
														<c:when test="${not empty ICBDetails}">
															<td><spring:url
																	value="/etender/buyer/pricebidICB/${tenderId}/1"
																	var="urlConfigureICB" /> <a href="${urlConfigureICB}">Configure</a>
															</td>
														</c:when>
														<c:otherwise>
															<td><spring:url
																	value="/etender/buyer/pricebidICB/${tenderId}/2"
																	var="urlViewICB" /> <a href="${urlViewICB}">View</a></td>
														</c:otherwise>
													</c:choose>
												</tr>
											</c:if>
											<tr>
												<td colspan="2">
													<table class="table">
														<tr>
															<td>
																<%-- 											--${envelopeid }--${childid }--${currentUserId }--${committeemember }-------------${oldEnvelopeData[6]}-${oldEnvelopeData[7] }===${oldEnvelopeData[9] }---${envelopeType }-${openingdate } --%>
																<c:forEach items="${commMemList}" var="committeeData">
																	<c:set value="${committeeData[3]}" var="childid" />
																	<c:set value="${committeeData[6]}"
																		var="committeemember" />
																	<c:if
																		test="${envelopeid eq childid and currentUserId eq committeemember}">
																		<c:choose>
																			<c:when
																				test="${srno.index gt 0 and oldEnvelopeData[6] eq 1 and oldEnvelopeData[7] eq 1 and oldEnvelopeData[9] gt 0 and oldEnvelopeData[10] gt 0  and envelopeType eq 2 }">
																				<%-- Configuration Date will come in only one case if first envelope is opened and evaluated and tender is multi envelope --%>
																				<table>
																					<tr>
																						<th>${envelopename} Opening Date</th>
																						<td>
																							<div>
																								<c:choose>
																									<c:when test="${empty openingdate}">
																										<spring:url
																											value="/etender/buyer/pricebidopeningdate/${tenderId}/${envelopeid}/${oldEnvelopeData[0]}/1"
																											var="urlConfigureDate" />
																										<a href="${urlConfigureDate}">Configure
																											Date</a>
																									</c:when>
																									<c:when
																										test="${not empty openingdate and openingdatestatus ne 1}">
																										<spring:url
																											value="/etender/buyer/pricebidopeningdate/${tenderId}/${envelopeid}/${oldEnvelopeData[0]}/2"
																											var="urlEditDate" />
																										<a href="${urlEditDate }">&nbsp;&nbsp;
																											Edit Date </a> &nbsp; |
																					<spring:url
																											value="/etender/buyer/pricebidopeningdate/${tenderId}/${envelopeid}/${oldEnvelopeData[0]}/3"
																											var="urlPublishDate" />
																										<a href="${urlPublishDate }">Publish Date</a>
																									</c:when>
																									<c:when test="${openingdatestatus ne 1}">
																										<spring:url
																											value="/etender/buyer/pricebidopeningdate/${tenderId}/${envelopeid}/${oldEnvelopeData[0]}/4"
																											var="urlViewDate" />
																										<a href="${urlViewDate }">View Date</a>
																									</c:when>
																								</c:choose>
																							</div></td>
																					</tr>
																				</table>
																			</c:when>
																		</c:choose>
																	</c:if>
																</c:forEach></td>
														</tr>
														<tr>
															<td>Min. member's consent requires</td>
															<td>${minmember}</td>
														</tr>
														<tr>
															<td>Opening Status</td>
															<td class="black"><c:choose>
																	<c:when
																		test="${srno.index ne 0 and envelopeType eq 2 and openingdatestatus ne 1}">
																		<spring:message code="label_date_not_specified" />
																	</c:when>
																	<c:when
																		test="${timelapsed eq 0 and openingdatestatus eq 1}">
																		<spring:message code="label_date_not_arrive" />
																	</c:when>
																	<c:when test="${timelapsed eq 0}">${pending}</c:when>
																	<c:when test="${timelapsed eq 1 and isopened eq 0}">Min approval required</c:when>
																	<%-- 													<spring:message code="msg_min_approval"/> --%>
																	<c:when test="${isopened eq 1}">Opened</c:when>
																	<%-- 													<spring:message code="col_sts_open"/> --%>
																</c:choose></td>
														</tr>
														<tr>
															<td colspan="2">
																<table class="table table-striped table-responsive">
																	<tr>
																		<th>Committee Member Name</th>
																		<th>Status</th>
																	</tr>
																	<c:forEach items="${commMemList}" var="committeeDtls"
																		varStatus="commCount">
																		<c:set value="${committeeDtls[0]}" var="officername" />
																		<c:set value="${committeeDtls[1]}" var="loginid" />
																		<c:set value="${committeeDtls[2]}" var="officerid" />
																		<c:set value="${committeeDtls[3]}" var="childid" />
																		<c:set value="${committeeDtls[4]}" var="approvedon" />
																		<c:set value="${committeeDtls[5]}"
																			var="committeeuserid" />
																		<c:set value="${committeeDtls[6]}"
																			var="committeemember" />
																		<c:set value="${committeeDtls[7]}" var="committeeid" />
																		<c:set value="${committeeDtls[8]}" var="isapproved" />
																		<c:set value="${committeeDtls[9]}" var="isdecryptor" />
																		<spring:url var="urlConsent"
																			value="/etender/buyer/getcommitteeuserremark/${tenderId}/${childid}/${committeeuserid}/${committeeid}/${minmember}/1"></spring:url>
																		<c:set value="0" var="committeeMemberIsDecryptor" />
																		<c:set value="0"
																			var="isConsentGivenByCurrentCommitteeMember" />
																		<c:if test="${currentUserId eq committeemember}">
																			<c:set value="${isdecryptor}"
																				var="committeeMemberIsDecryptor" />
																		</c:if>

																		<c:if test="${envelopeid eq  childid}">
																			<tr>
																				<c:choose>
																					<c:when
																						test="${currentUserId eq committeemember and timelapsed eq 1 and openingdatestatus eq 1 and isapproved ne 1}">
																						<td width="50%"><a href="${urlConsent}">${officername}</a>
																						</td>
																					</c:when>
																					<c:otherwise>
																						<td width="50%">${officername}</td>
																					</c:otherwise>
																				</c:choose>

																				<c:choose>
																					<c:when test="${isapproved eq 1}">
																						<c:set
																							var="isConsentGivenByCurrentCommitteeMember"
																							value="1" />
																						<td>Consent given on <fmt:formatDate
																								pattern="${clientDateFormate}"
																								value="${approvedon}" />
																						</td>
																					</c:when>
																					<c:otherwise>
																						<td>${pending}</td>
																					</c:otherwise>
																				</c:choose>
																			</tr>
																		</c:if>
																	</c:forEach>
																</table></td>
														</tr>
													</table></td>
											</tr>
											<!-- 										New loop -->
											<c:choose>
												<c:when test="${isopened eq 1}">
													<c:if test="${empty bidderList}">
														<tr>
															<td><div class="red">No bidder has submitted
																	the bid</div>
															</td>
														</tr>
													</c:if>
													<c:if test="${not empty bidderList}">
														<tr>
															<td colspan="2">
																<table class="table table-striped table-responsive">
																	<c:if test="${empty bidderFormList}">
																		<di>
																		<spring:message code="msg_no_forms_mapped" />
																		</div>
																	</c:if>
																	<c:set value="Invalid" var="isShowEncodedName" />
																	<c:forEach items="${bidderFormList}" var="verifyData"
																		varStatus="verifyCnt">
																		<c:set var="verifyEnvelopeId" value="${verifyData[0]}" />
																		<c:set var="verifyFormId" value="${verifyData[1]}" />
																		<c:set var="verifyFormName" value="${verifyData[2]}" />
																		<c:set var="verifyIsPriceBid" value="${verifyData[3]}" />
																		<c:set var="verifyIsEncryptionReq"
																			value="${verifyData[4]}" />
																		<c:set var="verifyFinalCount" value="${verifyData[5]}" />
																		<c:set var="verifyOpenCount" value="${verifyData[6]}" />
																		<c:set var="verifyCstatus" value="${verifyData[7]}" />
																		<c:set var="verifyIsMandatory"
																			value="${verifyData[8]}" />
																		<c:if test="${verifyCnt.count eq 1}">
																			<tr>
																				<th width="30%"><spring:message
																						code="field_formName" />
																				</th>
																				<th width="30%">${vAction}</th>
																				<th><spring:message code="tab_tender_reports" />
																				</th>


																			</tr>
																		</c:if>
																		<c:if test="${envelopeid eq verifyEnvelopeId}">
																			<c:if
																				test="${isEncodedName eq 1 and verifyEnvelopeId eq envelopeid and (envId eq 4 or envId eq 5)}">
																				<c:set value="Y" var="isShowEncodedName" />
																			</c:if>
																			<tr>
																				<%--
	verifyOpenCount = How many bidded-forms are verified by committee member
	verifyFinalCount= How many bidded-forms required to disable verify link
	After all bidded forms are verified then verify link disable.
	verifyCstatus=1 Approved form
	verifyCstatus=2 Cancelled form 
	committeeMember=It has user Id who are committe member and logged in system
--%>
																				<spring:url
																					value="/etender/buyer/getUserListForVerifyBid/${tenderId}/${verifyEnvelopeId}/${verifyFormId}"
																					var="urlVerify" />
																				<spring:url
																					value="/etender/buyer/getUserListForDecryptBid/${tenderId}/${verifyEnvelopeId}/${verifyFormId}"
																					var="urlDecrypt" />
																				<spring:url
																					value="etender/buyer/itemwiseevaluationreport/${tenderId}/${verifyFormId}/2/1"
																					var="urlItemWiseBreakUpReport" />
																				<spring:url
																					value="etender/buyer/customizedreport/${tenderId}/${verifyFormId}/1/1"
																					var="urlCustomize" />
																				<spring:url
																					value="/etender/buyer/tendercomparativereport/${tenderId}/${verifyEnvelopeId}/${verifyFormId}/1/1"
																					var="urlCompare" />
																				<c:choose>
																					<c:when
																						test="${verifyOpenCount eq 0 or verifyFinalCount gt verifyOpenCount}">
																						<%-- If openCount=0 Means no bidded form verify  --%>
																						<td>${verifyFormName}<c:if
																								test="${verifyIsMandatory eq 1}">
																								<span class="red"> *</span>
																							</c:if>
																						</td>
																						<c:choose>
																							<%-- 																							<c:when test="${verifyCstatus eq 2}"><td><span class="black">Form Cancelled</span></td><td>-</td></c:when> --%>
																							<c:when test="${verifyFinalCount eq 0}">
																								<td><span class="black">No Bidded
																										in form</span>
																								</td>
																							</c:when>
																							<c:otherwise>
																								<c:choose>
																									<c:when
																										test="${committeemember eq currentUserId and verifyIsEncryptionReq eq 1}">
																										<td><c:choose>
																												<c:when
																													test="${isConsentGivenByCurrentCommitteeMember eq 1}">
																													<a href="${urlDecrypt}">Decrypt</a>
																												</c:when>
																												<c:otherwise>Decrypt</c:otherwise>
																											</c:choose></td>
																									</c:when>
																									<c:when
																										test="${committeemember eq currentUserId and verifyIsEncryptionReq eq 0}">
																										<td><a href="${urlVerify}">Verify</a></td>
																									</c:when>
																									<c:otherwise>
																										<td>---</td>
																									</c:otherwise>
																								</c:choose>
																							</c:otherwise>
																						</c:choose>
																						<c:if test="${verifyCstatus ne 2}">
																							<td>${linkIndiv} | ${linkCompare} |Customize
																							</td>
																						</c:if>
																					</c:when>
																					<c:otherwise>
																						<td>${verifyFormName}<c:if
																								test="${verifyIsMandatory eq 1}">
																								<span class="red"> *</span>
																							</c:if>
																						</td>
																						<c:choose>
																							<%-- 																							<c:when test="${verifyCstatus eq 2}"><td><span class="black">Form Cancelled</span></td><td>-</td></c:when> --%>
																							<c:when test="${verifyFinalCount eq 0}">
																								<td><span class="black">No Bidded
																										in form</span>
																								</td>
																								<td>-</td>
																							</c:when>
																							<c:otherwise>
																								<td>Verified</td>
																								<td><spring:url var="urlIndividual"
																										value="/etender/buyer/tenderindividualreport/${tenderId}/${verifyEnvelopeId}/${verifyFormId}/1/1" />
																									<a href="${urlIndividual}">${linkIndiv}</a> | <a
																									href="${urlCompare}">${linkCompare}</</a> | <a
																									href="#">Customize</a>
																							</c:otherwise>
																						</c:choose>
																					</c:otherwise>
																				</c:choose>
																			</tr>
																		</c:if>
																		<c:if
																			test="${verifyCnt.count eq fn:length(bidderFormList) and isRebateForm eq 1 and mandatoryFormsCount ne 0 and mandatoryFormsCount eq mandatoryFormVerifiedCount and (envId eq 4 or envId eq 5)}">
																			<%-- isRebateForm =1 , all forms are verified, and pricebid or technocommercial envelope  and not empty rebateId--%>
																			<tr>
																				<th>Report name</th>
																				<c:choose>
																					<c:when
																						test="${verifyOpenCount eq 0 or verifyFinalCount gt verifyOpenCount}">
																						<td>Rebate| L1 Report</td>
																					</c:when>
																					<c:otherwise>
																						<td><a href="#">Rebate</a> | <a href="#">L1
																								Report</a>
																						</td>
																					</c:otherwise>
																				</c:choose>

																			</tr>
																		</c:if>
																	</c:forEach>
																</table></td>
														</tr>
													</c:if>

													<%--Start: Bidder Listing --%>
													<tr>
														<td colspan="2">
															<table class="table table-striped table-responsive">
																<c:if test="${not empty bidderList}">
																	<c:choose>
																		<c:when test="${isEvaluationRequired eq 1}">
																			<tr>
																				<th>${bidderName}</th>
																				<th>${status}</th>
																			</tr>
																		</c:when>
																		<c:otherwise>
																			<tr>
																				<th>${bidderName}</th>
																			</tr>
																		</c:otherwise>
																	</c:choose>

																</c:if>
																<c:forEach items="${bidderList}" varStatus="dataCnt"
																	var="bidderData">
																	<c:set var="bidderBidderId" value="${bidderData[0]}" />
																	<c:set var="bidderCompanyId" value="${bidderData[1]}" />
																	<c:set var="bidderEnvelopeId" value="${bidderData[2]}" />
																	<c:set var="bidderConsortiumId"
																		value="${bidderData[3]}" />
																	<c:set var="bidderIsApproved" value="${bidderData[4]}" />
																	<c:set var="bidderEncodedName" value="${bidderData[5]}" />
																	<c:set var="bidderPartnerType" value="${bidderData[6]}" />
																	<c:set var="bidderRemarks" value="${bidderData[7]}" />
																	<c:set var="bidderPreviousApprovedBidder"
																		value="${bidderData[8]}" />
																	<c:set var="bidderCompanyName" value="${bidderData[9]}" />

																	<c:choose>
																		<c:when test="${envelopeType eq 2}">
																			<%-- Multi Envelope Case --%>
																			<c:if test="${envelopeid eq bidderEnvelopeId}">
																				<c:set
																					value="${fn:replace(bidderCompanyName,'label_consort_with',conrtiumWith)}"
																					var="companyNames" />
																				<c:if test="${isShowEncodedName eq 'Y'}">
																					<%-- For Multi Envelope Tender encoded is yes and price bid envelope Then show encoded name--%>
																					<c:set value="${bidderEncodedName}"
																						var="companyNames" />
																				</c:if>
																				<c:choose>
																					<c:when test="${empty bidderIsApproved}">
																						<tr>
																							<td
																								<c:if test="${isEvaluationRequired eq 0}">colspan="2"</c:if>>
																								<a href="#">${companyNames} <!-- 																							BidderWiseReport -->
																							</a>
																							</td>

																							<c:if test="${isEvaluationRequired eq 1}">
																								<td><c:choose>
																										<c:when test="${srno.index eq 0}">
			                                                                                    			${pending}
			                                                                                    		</c:when>
																										<c:otherwise>
																											<c:choose>
																												<c:when
																													test="${not empty rejectedBidderMap and rejectedBidderMap[bidderBidderId] eq true}">${vNotEligible}</c:when>
																												<c:otherwise>${pending}</c:otherwise>
																											</c:choose>
																										</c:otherwise>
																									</c:choose></td>
																							</c:if>
																						</tr>
																					</c:when>
																					<c:otherwise>
																						<tr>
																							<td
																								<c:if test="${isEvaluationRequired eq 0}">colspan="2"</c:if>><a
																								href="#">${companyNames} <!-- 																								---BidderWiseReport -->
																							</a>
																							</td>

																							<c:if test="${isEvaluationRequired eq 1}">
																								<c:choose>
																									<c:when test="${bidderIsApproved eq 1}">
																										<td><div data-toggle="tooltip"
																												data-placement="left" title=""
																												data-original-title="${bidderRemarks}">${vEligible}</div>
																										</td>
																									</c:when>
																									<c:when test="${bidderIsApproved eq 0}">
																										<td><div data-toggle="tooltip"
																												data-placement="left" title=""
																												data-original-title="${bidderRemarks}">${vNotEligible}
																											</div>
																										</td>
																									</c:when>
																								</c:choose>
																							</c:if>
																						</tr>
																					</c:otherwise>
																				</c:choose>
																			</c:if>
																		</c:when>
																		<c:otherwise>
																			<%-- Single Envelope Case --%>
																			<c:if test="${envelopeid eq bidderEnvelopeId}">
																				<c:set value="${bidderCompanyName}"
																					var="companyNames" />
																				<c:if test="${isConsortiumAllowed eq 1}">
																					<c:set
																						value="${fn:replace(bidderCompanyName,'label_consort_with',conrtiumWith)}"
																						var="companyNames" />
																					<c:set
																						value="${fn:substring(companyNames,0,fn:length(companyNames)-1)}"
																						var="companyNames" />
																				</c:if>
																				<c:if test="${isShowEncodedName eq 'Y'}">
																					<%-- For Multi Envelope Tender encoded is yes and price bid envelope Then show encoded name--%>
																					<c:set value="${bidderEncodedName}"
																						var="companyNames" />
																				</c:if>
																				<tr>
																					<td><a href="#">${companyNames} <!-- 																					---BidderWiseReport -->
																					</a>
																					</td>
																					<c:if test="${isEvaluationRequired eq 1}">
																						<c:choose>
																							<c:when test="${empty bidderIsApproved}">
																								<td><c:choose>
																										<c:when test="${srno.index eq 0}">
			                                                                                    			${pending}
			                                                                                    		</c:when>
																										<c:otherwise>
																											<c:choose>
																												<c:when
																													test="${not empty rejectedBidderMap and rejectedBidderMap[bidderBidderId] eq true}">${vNotEligible}</c:when>
																												<c:otherwise>${pending}</c:otherwise>
																											</c:choose>
																										</c:otherwise>
																									</c:choose></td>
																							</c:when>
																							<c:otherwise>
																								<c:choose>
																									<c:when test="${bidderIsApproved eq 1}">
																										<td><div data-toggle="tooltip"
																												data-placement="left" title=""
																												data-original-title="${bidderRemarks}">${vEligible}</div>
																										</td>
																									</c:when>
																									<c:when test="${bidderIsApproved eq 0}">
																										<td><div data-toggle="tooltip"
																												data-placement="left" title=""
																												data-original-title="${bidderRemarks}">${vNotEligible}
																											</div>
																										</td>
																									</c:when>
																								</c:choose>
																							</c:otherwise>
																						</c:choose>
																					</c:if>
																				</tr>
																			</c:if>
																		</c:otherwise>
																	</c:choose>
																</c:forEach>
															</table></td>
													</tr>
													<%--End: Bidder Listing --%>
												</c:when>
											</c:choose>
											<%-- 											</c:if> --%>

											<%-- 										</c:forEach> --%>
											<!-- 										</table> -->
											<!-- 										</td> -->
											<!-- 										</tr> -->
											<!-- 									</table></td> -->
											<!-- 								</tr> -->
											<c:set value="${envlopeDtls}" var="oldEnvelopeData" />
										</c:forEach>

										<c:if
											test="${resultSharing eq '2' and committeemember eq currentUserId}">
											<%-- If Manual Result Sharing and Tender Opening Time Lapsed --%>
											<c:set value="${isResultShareDone}" var="reportConfigCount" />
											<%-- Use Only For Manual Result Sharing --%>
											<tr class="border-top-none">
												<td class="no-padding">
													<table class="table">
														<tr class="border-bottom-none">
															<th width="50%" class="a-left"><spring:message
																	code="label_rprt_config" />
															</th>
															<td width="50%"><c:choose>
																	<c:when test="${!reportConfigCount}">
																		<spring:url
																			value="/etender/buyer/getresultsharing/${tenderId}/1"
																			var="urlConfigure" />
																		<a href="${urlConfigure}">Configure</a>
																	</c:when>
																	<c:otherwise>
																		<spring:url
																			value="/etender/buyer/getresultsharing/${tenderId}/2"
																			var="urlView" />
																		<a href="${urlView}">View</a> |
															<spring:url
																			value="/etender/buyer/getresultsharing/${tenderId}/1"
																			var="urlUpdate" />
																		<a href="${urlUpdate}">Update</a>
																	</c:otherwise>
																</c:choose></td>
														</tr>
													</table></td>
											</tr>
										</c:if>

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
