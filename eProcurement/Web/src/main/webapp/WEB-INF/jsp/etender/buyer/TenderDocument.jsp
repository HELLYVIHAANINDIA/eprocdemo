<%@include file="../../includes/head.jsp"%>
<%@include file="../../includes/masterheader.jsp"%>
      
        <spring:message code="title_tender_createcomitee" var="titlecommittee"/>
        <spring:message code="lbl_view_prebid_committee" var="lblviewprebidcommittee"/>
        <spring:message code="lbl_view_opening_committee" var="lblviewopeningcommittee"/>
        <spring:message code="lbl_view_evaluation_committee" var="lblviewevaluationcommittee"/>
        
<div class="content-wrapper">

<section class="content-header">
<h1 class="inline">RFX</h1>
<a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}" class="g g-back">
                                                    <c:if test="${isAuction eq 1}">
                                                         << Go To Auction Dashboard
                                                    </c:if>
                                                   <c:if test="${isAuction ne 1}">
                                                         << Go To Tender Dashboard
                                                    </c:if>
                                                </a>
</section>

<section class="content">
<div class="row">
<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">

<div class="box">
						
<div class="box-header with-border">
<h3 class="box-title">
    <c:if test="${isAuction eq 1}">
        Auction Documents
    </c:if>
        <c:if test="${isAuction eq 0}">
        Tender Documents
    </c:if>
    </h3>
</div>

<div class="box-body">
<div class="row">

<div class="col-lg-12 col-md-12 col-xs-12">
                        <c:if test="${not empty successMsg}">
				<c:choose>
					<c:when test="${fn:contains(successMsg, '_')}">
						<div class="alert alert-success">
							<spring:message code="${successMsg}" />
						</div>
					</c:when>
					<c:otherwise>
						<div class="alert alert-success">${successMsg}</div>
					</c:otherwise>
				</c:choose>
			</c:if>

			<c:if test="${not empty errorMsg}">
				<c:choose>
					<c:when test="${fn:contains(errorMsg, '_')}">
						<div class="alert alert-danger">
							<spring:message code="${errorMsg}" />
						</div>
					</c:when>
					<c:otherwise>
						<div class="alert alert-danger">${errorMsg}</div>
					</c:otherwise>
				</c:choose>
			</c:if>
<%@include file="./UploadDocuments.jsp"%>
</div>
							
</div>
</div>

</div>
						
</div>
</div>
</section>
</div>
<%@include file="../../includes/footer.jsp"%>