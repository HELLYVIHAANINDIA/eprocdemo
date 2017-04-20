<%@include file=".../../includes/head.jsp"%>
<jsp:useBean id="now" class="java.util.Date" />
<%@include file="./includes/headerWithoutLogin.jsp"%>
<%-- <%@include file="./includes/masterheader.jsp"%> --%>

 <spring:message code="lbl_important_message" var="lbl_important_message"/>
 


	
	<section class="content-header">
			<h1>
				Password reset
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
							<form action="${pageContext.servletContext.contextPath}/postforgotpassword" method="POST" onsubmit="return validate();" >
							<div class="row">
								<div class="col-lg-12 col-md-12 col-xs-12">
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Email Id :</div>
										</div>
										<div class="col-lg-5">
										<input class="form-control" id="emailId" name="emailId" validarr="required@@email" tovalid="true" onblur="javascript:validateTextComponent(this)" title="Email ID"  type="text">
											<div id="emailIdError" style="color: red"></div>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-lg-12 col-md-12 col-xs-12">
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed"></div>
										</div>
										<div class="col-lg-5"><button type="submit"  class="btn btn-submit">Send</button></div>
										</div>
									</div>
								</div>
							
							</form>
					</div>
			</div>	
			</div>
			</div>	
			</section>
	<script type="text/javascript">
 
 var VALIDATE_MSG_REQUIRED = 'Please enter';
 var VALIDATE_MSG_SELECT = 'Please select';
 var VALIDATE_MSG_ALLOW_MAX='Allows Max. ';
 var VALIDATE_MSG_TENDERBRIEF='characters';
 var VALIDATE_MSG_EMAIL_INVALID = 'Allows Min. 6 Max. 50 alphanumeric and Special Characters(@,.,-,_)';
 var VALIDATE_MSG_INVALID_EMAIL = 'Please enter valid email ID';
 var VALIDATE_MSG_INVALID_PASSWORD = "<spring:message code="password_validation_msg" />"
 var VALIDATE_MSG_INVALID_PASSWORD_SPECIAL_CHAR = 'Password must comprise of at least one alphanumeric and special character (!,@,#,$,_,.,(,))';
 var VALIDATE_MSG_INVALID_FULL_NAME = 'Invalid fullname';
 var VALIDATE_MSG_SAME_PASSWORD_AS_LOGINID = 'Password cannot be same as email ID';
 var VALIDATE_MSG_INVALID_CONF_PASSWORD = 'Confirm password does not match with';
 
 function validate(){
 	var vbool = valOnSubmit();
 	return disableBtn(vbool);
 }
 </script>
 <%@include file=".../../includes/footer.jsp"%>

