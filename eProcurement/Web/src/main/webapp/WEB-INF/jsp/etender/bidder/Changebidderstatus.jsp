<%@include file="../../includes/head.jsp"%>
			<%@include file="../../includes/masterheader.jsp"%>											
        <spring:message code="lbl_create_user" var="createuser"/>
        
   
<div class="content-wrapper" style="height: auto;">
<c:if test="${tabId ne 0}">
<section class="content-header">
<a href="${pageContext.servletContext.contextPath}/common/user/getmanagebidder" class="btn btn-submit"><< Go To Bidder Listing</a>
</section>
</c:if>
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
									<input type="hidden" name="tabId" id="tabId" value="${tabId}"/>
									<input type="hidden" name="bidderId" value="${bidderId}"/>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Origin of the Company</div>
										</div>
										<div class="col-lg-5">
				               						<div class="abrs">${origincountry}</div>
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
											<div class="form_filed">Commercial Registration No.</div>
										</div>
										<div class="col-lg-5">
				               						<div class="abrs">${bidderDtls[21]}</div>
										</div>
									</div>
									
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Date of Establishment</div>
										</div>
										<div class="col-lg-5">
				               						<div class="abrs">${fn:split(establishDate, ' ')[0]}</div>
										</div>
									</div>
									
									<div class="row" style="display: none">
										<div class="col-lg-2">
											<div class="form_filed">Last name</div>
										</div>
										<div class="col-lg-5">
												<div class="abrs">${bidderDtls[16]}</div>
										</div>
									</div>
									<div class="row" style="display: none">
										<div class="col-lg-2">
											<div class="form_filed">Middle name</div>
										</div>
										<div class="col-lg-5">
												<div class="abrs">${bidderDtls[17]}</div>
										</div>
									</div>
									
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Office address line 1</div>
										</div>
										<div class="col-lg-5">
												<div class="abrs">${bidderDtls[3]}</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Office address line 2</div>
										</div>
										<div class="col-lg-5">
												<div class="abrs">${bidderDtls[19]}</div>
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
											<div class="form_filed">Postal address line 1</div>
										</div>
										<div class="col-lg-5">
												<div class="abrs">${bidderDtls[23]}</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Postal address line 2</div>
										</div>
										<div class="col-lg-5">
												<div class="abrs">${bidderDtls[24]}</div>
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
												<div class="abrs">${bidderDtls[26]}</div>
										</div>
									</div>
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
											<div class="form_filed">Contact Person Name</div>
										</div>
										<div class="col-lg-5">
												<div class="abrs">${bidderDtls[1]}</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Designation</div>
										</div>
										<div class="col-lg-5">
												<div class="abrs">${bidderDtls[27]}</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Phone no.</div>
											
										</div>
										<div class="col-lg-5">
												<div class="abrs">${bidderDtls[29]}</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Mobile no.</div>
											
										</div>
										<div class="col-lg-5">
												<div class="abrs">${bidderDtls[28]}</div>
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
									<c:if test="${tabId ne 0}">
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Uploaded documents</div>
										</div>
										<div class="col-lg-5">
										<div class="abrs"><a href="${pageContext.servletContext.contextPath}/etender/buyer/getDocumentList/${bidderDtls[18]}/${objectId}/${bidderDtls[18]}/0/0" data-target="#myModal" class="myModel" data-toggle="modal">View uploaded documents</a></div>
										</div>
										<div id="targetDiv"></div>
 				
									</div>
									</c:if>
									<c:if test="${tabId eq 8}">
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Status</div>
										</div>
										<div class="col-lg-5">
										<div class="chkbx">
												<input type="radio" name="rduserstatus" checked="checked" id="rduserstatus" value="1" /> Approve 
												<input type="radio" name="rduserstatus" id="rduserstatus" value="2"/> Reject
										</div>
										</div>
										
									</div>
									</c:if>
									<div class="row">
									<div class="chkbx">
										<div class="col-lg-2">
											<div class="form_filed">Remarks</div>
										</div>
										<div class="col-lg-5">
											<c:choose>
												<c:when test="${isview eq 0}">
													<textarea id="remarks" class="form-control" name="remarks" validarr="required@@length:0,500" tovalid="true" onblur="validateTextComponent(this)" title="remarks" validationmsg="Allows max. 500 characters and special character (',- , .,space)" ></textarea>
												</c:when>
												<c:otherwise>
													${remarks}
												</c:otherwise>
											</c:choose>
										</div>
										</div>
									</div>
									<c:if test="${tabId ne 0 and tabId ne 28}">
									<div class="row">
										<div class="col-lg-2">
											<br>
										</div>
										<div class="col-lg-5">
											<button type="submit" id="addUser"  class="btn btn-submit">Submit</button>
										</div>
									</div>
									</c:if>
									</form:form>
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
        var userstatus = '${userstatus}';
        var tabId = '${tabId}';
            function validate(){
            	vbool = valOnSubmit()
            	if(userstatus==1 && tabId==8){
            		$('#userstatus').val($('input[name=rduserstatus]:checked').val());
            	}
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
<%@include file="../../includes/footer.jsp"%>