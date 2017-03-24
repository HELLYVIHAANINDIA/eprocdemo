<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <%@include file="../../includes/header.jsp"%>
        <%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
        <script src="${pageContext.servletContext.contextPath}/resources/js/commonValidate.js" type="text/javascript"></script>
        <script src="${pageContext.servletContext.contextPath}/resources/js/jquery-ui.custom.js" type="text/javascript"></script>
		<script src="${pageContext.servletContext.contextPath}/resources/js/jquery.cookie.js" type="text/javascript"></script>
		<script src="${pageContext.servletContext.contextPath}/resources/js/blockUI.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/resources/js/commonListing.js"></script>
        <script src="${pageContext.servletContext.contextPath}/resources/js/jQuery/jquery.datetimepicker.js"></script>
		<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/resources/css/jquery.datetimepicker.css">        
        <spring:message code="lbl_create_dept" var="createdepartment"/>
        <title>${createdepartment}</title>
        <script type="text/javascript">
           </script>
</head>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="../../includes/leftaccordion.jsp"%>

<div class="content-wrapper" style="height: auto; ">

<section class="content-header">
</section>

<section class="content">
	<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					
					<div class="box">
						<div class="box-header with-border">
	               						<h3 class="box-title">Respond to query</h3>
						</div>
						<div class="box-header with-border">
								<a href="${pageContext.servletContext.contextPath}/etender/bidder/biddingTenderDashboard/${tenderId}"><< Back to tenderdashboard</a>
								</div>
						<div class="box-body">
							<div class="row">
							<spring:url value="/etender/buyer/postQuery" var="configureDateUrl"/>
								<div class="col-lg-12 col-md-12 col-xs-12">
									<div class="row">
										<div class="row">
										<div class="col-lg-2">
											<div class="form_filed"><label>Response end date : </label></div>
										</div>
										<div class="col-lg-5">
												<div class="form_filed"><label>${configureDateList[1]}</label></div>
<%-- 											<input type="text" class="form-control dateBox" name="txtResponseEndDate" datepicker="yes" id="txtResponseEndDate"   dtrequired="true" title="Opening date" value="${clarificationList[1]}" onblur="validateEmptyDt(this)" > --%>
										</div>
									</div>
									</div>
							<div class="row">
								<div class="col-lg-12 col-md-12 col-xs-12">
								<spring:url value="/etender/buyer/submitprebidcomittee" var="submitcommittee"/> 
                                    <form:form action="${submitcommittee}" name="frmprebidcomittee" method="post" onsubmit="return validate();" >
									<table class="table table-striped table-responsive">
										<thead>
											<tr>
												<th>Sr No.</th>
												<th>Question</th>
												<th>Question posted date</th>
												<th>Action</th>
											</tr>
										</thead>
										<tbody>
											<input type="hidden" name="operType" value="Edit"/>	
											<c:forEach items="${tblQuestionAnswersLst}" var="tblQuestionAnswers" varStatus="cnt">
    										<tr>
    												<td>${cnt.index+1}</td>
        											<td><c:out value="${tblQuestionAnswers.question}"/></td>
        											<td><c:out value="${tblQuestionAnswers.questionDate}"/></td>
        											<c:choose>
        												<c:when test="${tblQuestionAnswers.answerBy eq 0}">
        													<td><a href="${pageContext.servletContext.contextPath}/etender/bidder/responseQueryView/${tenderId}/${envelopeId}/${sessionObject.bidderId}/${tblQuestionAnswers.questionId}" title="">Reply</a></td>		
        												</c:when>
        												<c:otherwise>
        													<td><a href="${pageContext.servletContext.contextPath}/etender/bidder/viewQuestionAnswer/${tenderId}/${envelopeId}/${sessionObject.bidderId}/${tblQuestionAnswers.questionId}" title="">View</a></td>
        												</c:otherwise>
        											</c:choose>
    										</tr>
											</c:forEach>
										</tbody>
									</table>
									</form:form>
								</div>
							</div>
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