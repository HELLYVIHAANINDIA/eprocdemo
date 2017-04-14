<%@include file="../../includes/head.jsp"%>
        <%@include file="../../includes/masterheader.jsp"%>

<spring:message code="title_tender_createcomitee" var="titlecommittee" />
<spring:message code="lbl_view_prebid_committee"
	var="lblviewprebidcommittee" />
<spring:message code="lbl_view_opening_committee"
	var="lblviewopeningcommittee" />
<spring:message code="lbl_view_evaluation_committee"
	var="lblviewevaluationcommittee" />

<div class="content-wrapper">
		<section class="content-header">
			<a href="${pageContext.servletContext.contextPath}/etender/bidder/biddingTenderDashboard/${tenderId}"
				class="btn btn-submit"> <c:if test="${isAuction eq 1}">
                                                         << Go To Auction Dashboard
                                                    </c:if> <c:if
					test="${isAuction ne 1}">
                                                         << Go To Tender Dashboard
                                                    </c:if>
			</a>
		</section>

		<section class="content">
			<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">

					<div class="box">

						<div class="box-header with-border">
							<h3 class="box-title">Tender Reference Documents</h3>
						</div>

						<div class="box-body">
							<div class="row">

								<div class="col-lg-12 col-md-12 col-xs-12">
									<%@include file="../buyer/UploadDocuments.jsp"%>
								</div>

							</div>
						</div>

					</div>

				</div>
			</div>
		</section>
</div>
	<%@include file="../../includes/footer.jsp"%>