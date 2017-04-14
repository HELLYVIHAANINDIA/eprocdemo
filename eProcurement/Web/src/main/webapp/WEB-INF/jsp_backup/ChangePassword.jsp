<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<%@include file="./includes/header.jsp"%>
<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
<script src="${pageContext.servletContext.contextPath}/resources/js/commonValidate.js" type="text/javascript"></script>
 <script src="${pageContext.servletContext.contextPath}/resources/js/jQuery/jquery.datetimepicker.js"></script>
 <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/resources/css/jquery.datetimepicker.css">
 <script src="${pageContext.request.contextPath}/resources/js/commonListing.js"></script>
 <spring:message code="lbl_important_message" var="lbl_important_message"/>
 <script type="text/javascript">
 var VALIDATE_MSG_REQUIRED = 'Please enter';
 var VALIDATE_MSG_SELECT = 'Please select';
 var VALIDATE_MSG_ALLOW_MAX='Allows Max. ';
 var VALIDATE_MSG_TENDERBRIEF='characters';
 var VALIDATE_MSG_EMAIL_INVALID = 'Allows Min. 6 Max. 50 alphanumeric and Special Characters(@,.,-,_)';
 var VALIDATE_MSG_INVALID_EMAIL = 'Please enter valid email ID';
 var VALIDATE_MSG_INVALID_PASSWORD = 'Allows min 8 and max. 50 alphanumeric and special characters (!,@,#,$,_,.,(,))';
 var VALIDATE_MSG_INVALID_PASSWORD_SPECIAL_CHAR = 'Password must comprise of at least one alphanumeric and special character (!,@,#,$,_,.,(,))';
 var VALIDATE_MSG_INVALID_FULL_NAME = 'Invalid fullname';
 var VALIDATE_MSG_SAME_PASSWORD_AS_LOGINID = 'Password cannot be same as email ID';
 var VALIDATE_MSG_INVALID_CONF_PASSWORD = 'Confirm password does not match with';
 var lbl_pass_should_not_as_old = '<spring:message code="lbl_pass_should_not_as_old"/>';
 
 function validate(){
 	var vbool = valOnSubmit();
 	if(vbool){
 		if($("#txtOldPassword").val() == $("#txtPassword").val()){
 			$(".alert-danger").html(lbl_pass_should_not_as_old);
 		}else{
 			$(".alert-danger").html("");
 		}
 	}
 	return disableBtn(vbool);
 }
 </script>
</head>

<body>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="./includes/leftaccordionWithOutLogin.jsp"%>

	<div class="content-wrapper" style="height: auto;">

		<section class="content-header">
		<h1>Change Password</h1>
		</section>

		<section class="content">
		<div class="row">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="box">
					<div class="box-header with-border">
						<h3 class="box-title"></h3>
					</div>
					<div class="box-body">
						<div class="row">
							<div class="col-lg-12">
								<c:if test="${not empty successMsg}">
									<div class="alert alert-success">
										<spring:message code="${successMsg}" />
									</div>
								</c:if>
								<c:if test="${not empty errorMsg}">
									<div class="alert alert-danger">
										<spring:message code="${errorMsg}" />
									</div>
								</c:if>
							</div>
						</div>

						<form action="${pageContext.servletContext.contextPath}/user/postchangepassword"
							method="POST" onsubmit="return validate();">
							<input type="hidden" name="hdUserId" value="${userId}" /> <input
								type="hidden" name="hdUserType" value="${usertype}" />

							<div class="row">
								<div class="col-lg-2">
									<div class="form_filed">
										Old Password<span style="color: red">*</span>
									</div>

								</div>
								<div class="col-lg-5">
									<input id="txtOldPassword" class="form-control"
										name="txtOldPassword"
										validarr="required@@password@@checkloginidpwd:EmailId"
										tovalid="true" onblur="validateTxtComp(this)"
										title="Old password" type="password">
								</div>
							</div>
							<div class="col-lg-2">
								<div class="form_filed">
									New Password<span style="color: red">*</span>
								</div>

							</div>
							<div class="col-lg-5">
								<input id="txtPassword" class="form-control" name="txtPassword"
									validarr="required@@password@@checkloginidpwd:EmailId"
									tovalid="true" onblur="validateTxtComp(this)" title="Password"
									" type="password">
							</div>
					</div>
					<div class="row">
						<div class="col-lg-2">
							<div class="form_filed">
								Confirm password<span style="color: red">*</span>
							</div>

						</div>
						<div class="col-lg-5">
							<input id="txtConfirmPassword" class="form-control"
								name="txtConfirmPassword"
								validarr="required@@confirmpwd:Password" tovalid="true"
								onblur="validateTxtComp(this)" title="Confirm password"
								type="password">
						</div>
					</div>
					<div class="row">
						<div class="col-lg-12 col-md-12 col-xs-12">
							<div class="row">
								<div class="col-lg-2">
									<div class="form_filed"></div>
								</div>
								<div class="col-lg-5">
									<button type="submit" class="btn btn-submit">Submit</button>
								</div>
							</div>
						</div
					</div>
				
				</form>

			</div>
		</div>
	</div>
	</div>
	</section>

	</div>
	<!--Body Part End-->
</body>
</html>
