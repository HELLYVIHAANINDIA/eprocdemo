<%@include file=".../../includes/head.jsp"%>
<%@include file="./includes/masterheader.jsp"%>
<jsp:useBean id="now" class="java.util.Date" />

 <spring:message code="lbl_important_message" var="lbl_important_message"/>


	
	<section class="content-header">
			<h1>Registration</h1>
	</section>
	
				<section class="content">
				<div class="row">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<c:if test="${not empty message}">
                    		<div class="alert alert-success">${message}</div>
                    </c:if>
                    <c:if test="${not empty errorMsg}">
                    	<div class="alert alert-danger"><spring:message code="${errorMsg}"/></div>
                     </c:if>
					<div class="box-body">
							<div class="row">
								<div class="col-lg-12 col-md-12 col-xs-12">
									<div class="row">
										<div class="col-lg-12">
												<div class="form_filed">Thank you for registration.click here to <a href="${pageContext.servletContext.contextPath}/login"  />login</a></div>
										</div>
									</div>
								</div>
							</div>
					</div>
			</div>
			</div>	
			</section>
	
	 <script type="text/javascript">
 function validate(){
 	var vbool = valOnSubmit();
 	return disableBtn(vbool);
 }
 </script>
 <%@include file=".../../includes/footer.jsp"%>