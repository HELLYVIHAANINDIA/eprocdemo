<%@include file="./includes/head.jsp"%>
<%@include file="./includes/headerWithoutLogin.jsp"%>
 <spring:message code="lbl_important_message" var="lbl_important_message"/>

	<div class="content-wrapper" style="height: 100vh;">
	
	<section class="content-header">
			<h1>
				 Registration Confirmation
			</h1>
			
	</section>
	<section class="content">
			<div class="row">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			<div class="box">
					<c:if test="${not empty successMsg}">
                    		<div class="alert alert-success"><spring:message code="${successMsg}"/></div>
                    </c:if>
                    <c:if test="${not empty errorMsg}">
                    	<div class="alert alert-danger"><spring:message code="${errorMsg}"/></div>
                     </c:if>
					<div class="box-body">
							<div class="row">
								<div class="col-lg-12 col-md-12 col-xs-12">
									<div class="row">
										<div class="col-lg-12">
											<c:if test="${isEmailVerified eq 1}">
												<div class="form_filed">Your email account is already verified.</div>
											</c:if>
											<c:if test="${isEmailVerified eq 0}">
												<div class="form_filed">Your email account is verified successfully.</div>
											</c:if>
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
<%@include file="./includes/footer.jsp"%>