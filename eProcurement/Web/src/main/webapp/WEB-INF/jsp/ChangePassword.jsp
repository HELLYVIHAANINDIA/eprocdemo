<%@include file="./includes/head.jsp"%>
<%@include file="./includes/masterheader.jsp"%>
 <spring:message code="lbl_important_message" var="lbl_important_message"/>

	<div class="content-wrapper">
	
	<section class="content-header">
			<h1>
				Change Password
			</h1>	
	</section>
	
	<section class="content">
		<div class="row">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			<div class="box">				
					<div class="box-body">
							
							<div class="row">
							<div class="col-lg-12 col-md-12 col-sm-12">
							
							<div class="row">
							
							<div class="col-md-12">							
							<c:if test="${not empty successMsg}">
                    			<div class="alert alert-success"><spring:message code="${successMsg}"/></div>
                    		</c:if>
                    		</div>
                    		
                    		<div class="col-md-12">
                    		<c:if test="${not empty errorMsg}">
                    			<div class="alert alert-danger"><spring:message code="${errorMsg}"/></div>
                     		</c:if>
                     		</div>
                     		
                     		</div>
					
							<form action="${pageContext.servletContext.contextPath}/user/postchangepassword" method="POST" onsubmit="return changePasswordValidate();">
							<input type="hidden" name="hdUserId" value="${userId}" />
							<input type="hidden" name="hdUserType" value="${usertype}" />
																														
										<div class="row">
										<div class="col-md-6">
										
										<div class="fr-grp">
										<label class="lblfr-fields">Old Password<span style="color: red">*</span></label>
										<input id="txtOldPassword" class="form-control fr-cntrl" name="txtOldPassword" validarr="required@@password@@checkloginidpwd:EmailId" tovalid="true" onblur="validateTextComponent(this)" title="Old password" type="password">										
										</div>
										
										<div class="fr-grp">
										<label class="lblfr-fields">New Password<span style="color: red">*</span></label>
										<input id="txtPassword" class="form-control fr-cntrl" name="txtPassword" validarr="required@@password@@checkloginidpwd:EmailId" tovalid="true" onblur="validateTextComponent(this)" title="Password" " type="password">
										</div>
										
										<div class="fr-grp">
										<label class="lblfr-fields">Confirm password<span style="color: red">*</span></label>
										<input id="txtConfirmPassword" class="form-control fr-cntrl" name="txtConfirmPassword" validarr="required@@confirmpwd:Password" tovalid="true" onblur="validateTextComponent(this)" title="Confirm password"  type="password">
										</div>
										
										<div class="fr-grp">
										<div class="nowrap" style="color:red;">(<spring:message code="password_validation_msg" />)</div>
										</div>
										
										<div class="fr-grp">
										<button type="submit"  class="btn btn-submit">Submit</button>
										</div>
										
										</div>
										</div>
																																																																																									
							</form>
							
							</div>										
							</div>
							
							</div>
					</div>
					</div>	
					</div>	
			</section>
	
	</div>
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
 var lbl_pass_should_not_as_old = '<spring:message code="lbl_pass_should_not_as_old"/>';
 
 function changePasswordValidate(){
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
<%@include file="./includes/footer.jsp"%>