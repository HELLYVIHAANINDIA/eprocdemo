<%@include file="../../includes/head.jsp"%>
<%@include file="../../includes/masterheader.jsp"%>
<spring:message code="lbl_back_dashboard" var='backDashboard'/>
<div class="content-wrapper">
	<section class="content">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			<div class="box">
				<div class="box-header with-border">
				<c:choose>
                        <c:when test="${userTypeId eq 2}">
                             <a href="${pageContext.servletContext.contextPath}/etender/bidder/biddingtenderdashboardcontent/${tenderId}/7"><< ${backDashboard}</a>
                        </c:when>
                        <c:otherwise>
							<a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}"><< ${backDashboard}</a> | 
                    		<a href="${pageContext.servletContext.contextPath}/etender/buyer/gettabcontent/${tenderId}/${commiteeType}"><< <spring:message code="link_goback_tenderdashbord"/></a>
                    	</c:otherwise>
                   </c:choose>
				</div>
				<div class="box-header with-border">
					<h3 class="box-title">
						<c:choose>
           		 			<c:when test="${tblTender.biddingVariant eq 1}">L1
           		 			</c:when>
           		 			<c:when test="${tblTender.biddingVariant eq 2}">H1
           		 			</c:when>
           		 		</c:choose> Report
					</h3>
				</div>
				<div class="box-body">
					<div class="row" id="viewL1H1ReportId">
						<div class="col-lg-12 col-md-12 col-xs-12">
							<div class="box-body pad">
							<table  class="table table-striped table-responsive">
								<c:choose>
									<c:when test="${tblTender.isItemwiseWinner eq 0}">
										<tr>
	                                  		<th>Company Name</th>
	                                  		<th>Rank</th>
	                                  		<th>Bid Amount</th>
	                                  		<c:if test="${tblTender.isRebateApplicable eq 1}">
	                                  			<th>Bid Amount after Rebate</th>
	                                  		</c:if>
	                             		 </tr>
	                             		 <c:set value="" var="OldAmt"/>
	                             		 <c:set value="0" var="counter"/>
	                             		 <c:forEach items="${lstBidderFormDtl}" var="dtls">
	                             		 	<tr>
	                             		 	<td>${dtls[3]}</td>
	                             		 	<td>
		                                  		<c:if test="${OldAmt ne dtls[0]}">
				                             		<c:set value="${counter+1}" var="counter"/>	
				                             	</c:if>
				                             	<c:choose>
	                             		 			<c:when test="${tblTender.biddingVariant eq 1}">L${counter}
	                             		 			</c:when>
	                             		 			<c:when test="${tblTender.biddingVariant eq 2}">H${counter}
	                             		 			</c:when>
	                             		 		</c:choose>
	                             		 		<c:set value="${dtls[0]}" var="OldAmt"/>
	                             		 	</td>
	                             		 	<td>${dtls[0]}</td>
	                             		 	<c:if test="${tblTender.isRebateApplicable eq 1}">
	                                  			<td>${dtls[4]}</td>
	                                  		</c:if>
	                                  		</tr>
	                             		 </c:forEach>
	                             		 <c:if test="${empty lstBidderFormDtl}">
	                             		 	<tr>
												<td>No records found</td>
											</tr>
	                             		 </c:if>
									</c:when>
									<c:when test="${tblTender.isItemwiseWinner eq 1}">
										<c:choose>
											<c:when test="${empty lstBidderBidDtl}">
												<tr>
													<td>No records found</td>
												</tr>
											</c:when>
											<c:otherwise>
											
										<c:forEach items="${lstTable}" var="tableDtls">
										<tr>
											<th colspan="3">${tableDtls[1]}</th>
											</tr>
												<tr>
			                                  		<th>Company Name</th>
			                                  		<th>Rank</th>
			                                  		<th>Total Rate Amount</th>
			                             		 </tr>
			                             		<c:forEach items="${lstBidderTotalDtl}" var="officerValue">
			                             			<c:if test="${(officerValue[2]+'') eq  (tableDtls[0]+'')}">
			                             				<tr>
															<th colspan="3">${officerValue[0]}</th>
														</tr>
														<c:set value="0" var="counter"/>
														<c:set value="" var="OldAmt"/>
														    <c:forEach items="${lstBidderBidDtl}" var="bidValue" varStatus="cnt">
			                             					<c:if test="${(bidValue[2]+'') eq (officerValue[1]+'')}">
			                             					<tr>
			                             						<td>${bidValue[1]}</td>
			                             						<td>
				                             						<c:if test="${OldAmt ne bidValue[0]}">
									                             		<c:set value="${counter+1}" var="counter"/>	
									                             	</c:if>
									                             	<c:choose>
						                             		 			<c:when test="${tblTender.biddingVariant eq 1}">L${counter}
						                             		 			</c:when>
						                             		 			<c:when test="${tblTender.biddingVariant eq 2}">H${counter}
						                             		 			</c:when>
						                             		 		</c:choose>
						                             		 		<c:set value="${bidValue[0]}" var="OldAmt"/>
						                             		 	</td>
			                             						<td>${bidValue[0]}</td>
			                             					</tr>
			                             					</c:if>
			                             				</c:forEach>
			                             			</c:if>
			                             		</c:forEach>
										</c:forEach>
										</c:otherwise>
										</c:choose>
									</c:when>
								</c:choose>
								</table>
							</div>
							<div>
							</div>
						</div>
						<input type="button" class="btn noExport" onclick="exportContent('viewL1H1ReportId','L1H1Report${tenderId}',0)" value="PDF">
							<input type="button" class="btn noExport" onclick="exportContent('viewL1H1ReportId','L1H1Reportt${tenderId}',5)" value="Print">
						
					</div>
				</div>
			</div>
		</div>
	</section>
</div>
<%@include file="../../includes/footer.jsp"%>