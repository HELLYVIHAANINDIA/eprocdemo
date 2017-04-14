<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
 <%@include file="../../includes/header.jsp"%>
        <%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
        <script src="${pageContext.servletContext.contextPath}/resources/js/commonValidate.js" type="text/javascript"></script>        
        <spring:message code="title_tender_createcomitee" var="titlecommittee"/>
        <spring:message code="lbl_view_prebid_committee" var="lblviewprebidcommittee"/>
        <spring:message code="lbl_view_opening_committee" var="lblviewopeningcommittee"/>
        <spring:message code="lbl_view_evaluation_committee" var="lblviewevaluationcommittee"/>
        <title>Tender Document</title>    
</head>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="../../includes/leftaccordion.jsp"%>

<div class="content-wrapper">

<section class="content-header">
<a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}" class="btn btn-submit">
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
<h3 class="box-title">Tender Documents</h3>
</div>

<div class="box-body">
<div class="row">

<div class="col-lg-12 col-md-12 col-xs-12">
<%@include file="./UploadDocuments.jsp"%>
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