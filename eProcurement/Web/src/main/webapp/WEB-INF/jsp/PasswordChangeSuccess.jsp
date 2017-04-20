<%@include file=".../../includes/head.jsp"%>
<%@include file="./includes/masterheader.jsp"%>
<%-- <%@include file="./includes/headerWithoutLogin.jsp"%> --%>
<jsp:useBean id="now" class="java.util.Date" />
 <spring:message code="lbl_important_message" var="lbl_important_message"/>
 
 <div class="content-wrapper">
 
	<section class="content-header">
		<h1>Change password</h1>
	</section>
	
	<section class="content">
		<div class="row">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="box">						
					<div class="box-body">
							<div class="row">
							
								<div class="col-lg-12 col-md-12 col-xs-12">
							
							<c:if test="${not empty message}">
								<div class="alert alert-success">${message}</div>
							</c:if>
							<c:if test="${not empty param.successMsg}">
								<div class="alert alert-success">
											<spring:message code="${param.successMsg}" />
										</div>
							</c:if>
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
								</div>
								
								<div class="col-lg-12 col-md-12 col-xs-12">
									<div class="row">
										<div class="col-lg-12">
												<div class="lbl-2">Your password has been changed.To continue with
												 the application <a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderListing" >Click here</a> 
												 or   <a href="${pageContext.servletContext.contextPath}/submitlogout" >Logout</a></div>
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
	<script type="text/javascript">
 function validate(){
 	var vbool = valOnSubmit();
 	return disableBtn(vbool);
 }
 </script>
<%@include file=".../../includes/footer.jsp"%>