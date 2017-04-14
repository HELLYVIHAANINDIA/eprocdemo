<%@include file="../../includes/head.jsp"%>
<%@include file="../../includes/masterheader.jsp"%>
<spring:message code="lbl_back_dashboard" var='backDashboard'/>


<div class="content-wrapper">
	<section class="content">
		<div class="row">
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
						Tender Award
					</h3>
				</div>
				<div class="box-body">
					<div class="row">
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
	                                  		<th>Select Bidder</th>
	                             		 </tr>
	                             		 <c:set value="" var="OldAmt"/>
	                             		 <c:set value="0" var="counter"/>
	                             		 <c:forEach items="${lstBidderFormDtl}" var="dtls" varStatus="cnt">
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
	                                  		<td><input type="radio" name="genpurchaseorder" id="genpurchaseorder" value="${dtls[2]}_-1_-1" /> </td>
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
			                                  		<th>Select Bidder</th>
			                             		 </tr>
			                             		 <c:set value="0" var="ItemCounter"/>
			                             		<c:forEach items="${lstBidderTotalDtl}" var="officerValue">
			                             			<c:if test="${officerValue[2] eq  tableDtls[0]}">
			                             				<tr>
															<th colspan="3">${officerValue[0]}</th>
														</tr>
														<c:set value="0" var="counter"/>
														
														<c:set value="${ItemCounter+1}" var="ItemCounter"/>
														<c:set value="" var="OldAmt"/>
														    <c:forEach items="${lstBidderBidDtl}" var="bidValue" varStatus="cnt">
			                             					<c:if test="${bidValue[2] eq officerValue[1] }">
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
			                             						<td>
			                             						<c:set var="poKey" value="${officerValue[2]}_${officerValue[1]}" />
			                             						<c:choose>
				                             						 <c:when test="${not empty poList[poKey]}">
				                             							Purchase order has been generated for this item
			                             							</c:when>
			                             							<c:otherwise>
			                             								<input type="radio" name="genpurchaseorder_${bidValue[2]}" id="genpurchaseorder" value="${bidValue[3]}_${officerValue[2]}_${officerValue[1]}" />
			                             								<div id="divItemWisePO${bidValue[3]}_${officerValue[2]}_${officerValue[1]}"></div> 
			                             							</c:otherwise>
			                             						</c:choose>	
			                             						</td>
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
							<div id="divPO">
								
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		</div>
	</section>
	</div>
<script type="text/javascript">

$(document).ready(function(){
    $("input[name*=genpurchaseorder]:radio").change(function () {
        var content = '<a href="${pageContext.servletContext.contextPath}/etender/buyer/getcreatepurchaseorder/'+${tenderId}+'/'+$(this).val()+'">Generate purchase order</a>';
        $('#divPO').html(content);
        $('[id^=divItemWisePO]').html('');
        $('#'+'divItemWisePO'+$(this).val()).html(content);
    });
});

</script>
<%@include file="../../includes/footer.jsp"%>