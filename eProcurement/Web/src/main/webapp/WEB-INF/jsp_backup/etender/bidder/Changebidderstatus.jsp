<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
				<%@include file="./../../includes/header.jsp"%>												
        <%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
        <script src="${pageContext.servletContext.contextPath}/resources/js/commonValidate.js" type="text/javascript"></script>
		<script src="${pageContext.servletContext.contextPath}/resources/js/blockUI.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/resources/js/commonListing.js"></script>        
        <spring:message code="lbl_create_user" var="createuser"/>
        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/resources/css/jquery-ui.min.css">
        <title>${createuser}</title>
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
            	vbool = valOnSubmit()
            	$('#userstatus').val($('input[name=rduserstatus]:checked').val());
            	return disableBtn(vbool);
            }
            
            
            $(document).ready(function(){
            	
                $('a.myModel').click(function(){   //bind handlers
         		   var url = $(this).attr('href');
         		   showDialog(url);
         		   return false;
         		});

         		$("#targetDiv").dialog({  //create dialog, but keep it closed
         		   autoOpen: false,
         		   height: 300,
         		   width: 700,
         		   modal: true
         		});

         		function showDialog(url){  //load content and open dialog
         		    $("#targetDiv").load(url);
         		    $("#targetDiv").dialog("open");         
         		}
                });
           </script>
</head>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="./../../includes/leftaccordion.jsp"%>

<div class="content-wrapper" style="height: auto; ">

<section class="content-header">
<h1 class="pull-left">Administration</h1>
<a href="${pageContext.servletContext.contextPath}/common/user/getmanagebidder" class="btn btn-submit pull-right" style="margin-top:0px; margin-bottom:0px;"><< Go bidder</a>
</section>

<section class="content">
<div class="row">
<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">

<div class="box">

<div class="box-header with-border">
<h3 class="box-title">${userStatusLabel}</h3>
</div>

<div class="box-body">
<div class="row">	
		               					<spring:url value="/common/user/addbidderstatus" var="submitUser"/>
								<div class="col-lg-12 col-md-12 col-xs-12">
									<form:form action="${submitUser}" onsubmit="return validate();" name="frmUser" method="post"  >
									<input type="hidden" name="userstatus" id="userstatus" value="${userstatus}"/>
									<input type="hidden" name="bidderId" value="${bidderId}"/>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Email id</div>
										</div>
										<div class="col-lg-5">
				               						<div class="abrs">${bidderDtls[0]}</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">First name</div>
										</div>
										<div class="col-lg-5">
												<div class="abrs">${bidderDtls[1]}</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Last name</div>
										</div>
										<div class="col-lg-5">
												<div class="abrs">${bidderDtls[16]}</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Middle name</div>
										</div>
										<div class="col-lg-5">
												<div class="abrs">${bidderDtls[17]}</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed" data-toggle="tooltip" data-placement="top"  data-original-title="Tooltip on Top" >Company/Individual name</div>
										</div>
										<div class="col-lg-5">
												<div class="abrs">${bidderDtls[2]}</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Address</div>
										</div>
										<div class="col-lg-5">
												<div class="abrs">${bidderDtls[3]}</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Country</div>
										</div>
										<div class="col-lg-5">
											<div class="abrs">${country}</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">State</div>
										</div>
										<div class="col-lg-5">
												<div class="abrs">${state}</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">City.</div>
											
										</div>
										<div class="col-lg-5">
												<div class="abrs">${bidderDtls[4]}</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Phone no.</div>
											
										</div>
										<div class="col-lg-5">
												<div class="abrs">${bidderDtls[5]}</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Mobile no.</div>
											
										</div>
										<div class="col-lg-5">
												<div class="abrs">${bidderDtls[6]}</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Web site</div>
											
										</div>
										<div class="col-lg-5">
												<div class="abrs">${bidderDtls[7]}</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Keywords</div>
											
										</div>
										<div class="col-lg-5">
												<div class="abrs">${bidderDtls[10]}</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
										<spring:message code="label_timezone" var="label_timezone"/>
											<div class="form_filed">${label_timezone}</div>
										</div>
										<div class="col-lg-5">
											<div class="abrs">${timeZone}</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Uploaded documents</div>
										</div>
										<div class="col-lg-5">
										<div class="abrs"><a href="${pageContext.servletContext.contextPath}/etender/buyer/getDocumentList/${objectId}/${bidderDtls[18]}/${bidderDtls[18]}/0/0" data-target="#myModal" class="myModel" data-toggle="modal">View uploaded documents</a></div>
										</div>
										<div id="targetDiv"></div>
 				
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">status</div>
										</div>
										<div class="col-lg-5">
										<div class="chkbx">
												<input type="radio" name="rduserstatus" id="rduserstatus" value="1" /> Approve 
												<input type="radio" name="rduserstatus" id="rduserstatus" value="2"/> Reject
										</div>
										</div>
										
									</div>
									<div class="row">
									<div class="chkbx">
										<div class="col-lg-2">
											<div class="form_filed">Remarks</div>
										</div>
										<div class="col-lg-5">
													<textarea id="remarks" class="form-control" name="remarks" validarr="required@@length:0,500" tovalid="true" onblur="validateTxtComp(this)" title="address" validationmsg="Allows max. 500 characters and special character (',- , .,space)" ></textarea>
										</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<br>
										</div>
										<div class="col-lg-5">
											<button type="submit" id="addUser"  class="btn btn-submit">Submit</button>
										</div>
									</div>
									</form:form>
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