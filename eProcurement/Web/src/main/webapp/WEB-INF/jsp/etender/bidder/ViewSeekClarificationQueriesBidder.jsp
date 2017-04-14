<%@include file="../../includes/head.jsp"%>
        <%@include file="../../includes/masterheader.jsp"%>
      
        <spring:message code="lbl_create_dept" var="createdepartment"/>
       
<div class="content-wrapper">
<section class="content-header">
</section>

<section class="content">
	<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					
					<div class="box">
						<div class="box-header with-border">
	               						<h3 class="box-title"><spring:message code="respond_query_bidder"/></h3>
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
    												<c:set var="queDate" value="queId_${tblQuestionAnswers.questionId}" />
        											<c:set var="ansDate" value="ansId_${tblQuestionAnswers.questionId}" />
        											<td><c:out value="${tblQuestionAnswers.question}"/></td>
        											<td><c:out value="${questionDates[queDate]}"/></td>
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
		
</section>
</div>
<%@include file="../../includes/footer.jsp"%>