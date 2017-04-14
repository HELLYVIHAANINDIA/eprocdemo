<%@include file="./../includes/head.jsp"%>
<%@include file="./../includes/masterheader.jsp"%>

<spring:message code="lbl_create_user" var="createuser" />
<spring:message code="default_country" var="default_country" />
<spring:message code="default_tinezone" var="default_tinezone" />


<div class="content-wrapper">

<section class="content-header">
	<h1>Administration</h1>
</section>

<section class="content">
	<div class="row">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			<div class="box">
				<div class="box-header with-border">
					<c:choose>
						<c:when test="${optType eq 'Edit'}">

							<c:choose>
								<c:when test="${deptstatus eq 3}">
									<h3 class="box-title">
										<spring:message code="lbl_vie_dact_org_request" />
									</h3>
								</c:when>
								<c:when test="${deptstatus eq 0}">
									<h3 class="box-title">
										<spring:message code="lbl_vie_org_request" />
									</h3>
								</c:when>
								<c:when
									test="${deptstatus eq 2 and isview eq 1 and tabId eq 42}">
									<h3 class="box-title">
										<spring:message code="lbl_vie_rej_org_request" />
									</h3>
								</c:when>
								<c:when test="${deptstatus eq 1 and isview eq 0}">
									<h3 class="box-title">
										<spring:message code="lbl_vie_act_org_request" />
									</h3>
								</c:when>
								<c:otherwise>
									<h3 class="box-title">
										<spring:message code="lbl_vie_org_request" />
									</h3>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<h3 class="box-title">
								<spring:message code="lbl_vie_org_request" />
							</h3>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="box-body">
					<div>
						<a
							href="${pageContext.servletContext.contextPath}/common/user/manageorganization"><<
							Go Back</a>
					</div>
					<div class="row">
						<spring:url value="/common/user/editOrganization" var="submitUser" />
						<div class="col-lg-12 col-md-12 col-xs-12">
							<form action="${submitUser}" name="frmUser" method="post">
								<font size="1" class="pull-right mandatory m-top2"
									style="font-size: 15px;"><spring:message
										code="msg_mandatoryFields" /></font> <input type="hidden"
									name="hdOptType" value="${optType}" /> <input type="hidden"
									name="bidderDocId" value="${childId}" /> <input type="hidden"
									name="deptId" value="${tblDepartment.deptId}" /> <input
									type="hidden" name="tabId" value="${tabId}" />

								<div id="companyInfo">
									Company Information
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed" data-toggle="tooltip"
												data-placement="top" data-original-title="Tooltip on Top">
												Origin of the Company<span style="color: red">*</span>
											</div>
										</div>
										<div class="col-lg-5">${origincountry}</div>
									</div>

									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed" data-toggle="tooltip"
												data-placement="top" data-original-title="Tooltip on Top">
												Company Name<span style="color: red">*</span>
											</div>
										</div>
										<div class="col-lg-5">${tblDepartment.deptName}</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed" data-toggle="tooltip"
												data-placement="top" data-original-title="Tooltip on Top">
												Commercial Registration No.<span style="color: red">*</span>
											</div>
										</div>
										<div class="col-lg-5">${tblDepartment.commercialRegNo}</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed" data-toggle="tooltip"
												data-placement="top" data-original-title="Tooltip on Top">
												Date of Establishment<span style="color: red">*</span>
											</div>
										</div>
										<div class="col-lg-5">
											${fn:split(tblDepartment.establishDate, ' ')[0]}</div>
									</div>

									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">
												Sector<span style="color: red">*</span>
											</div>
										</div>
										<div class="col-lg-5">${sectors}</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">
												Official Address Line 1<span style="color: red">*</span>
											</div>
										</div>
										<div class="col-lg-5">${tblDepartment.addressline1}</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">
												Official Address Line 2<span style="color: red">*</span>
											</div>
										</div>
										<div class="col-lg-5">${tblDepartment.addressline2}</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">
												Country<span style="color: red">*</span>
											</div>
										</div>
										<div class="col-lg-5">${country}</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">
												State<span style="color: red">*</span>
											</div>
										</div>
										<div class="col-lg-5">${state}</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">City.</div>

										</div>
										<div class="col-lg-5">${tblDepartment.city}</div>
									</div>
									<div id="postalDetail">
										<div class="row">
											<div class="col-lg-2">
												<div class="form_filed">
													Postal Address Line 1<span style="color: red">*</span>
												</div>
											</div>
											<div class="col-lg-5">
												${tblDepartment.postalAddressLine1}</div>
										</div>
										<div class="row">
											<div class="col-lg-2">
												<div class="form_filed">
													Postal Address Line 2<span style="color: red">*</span>
												</div>
											</div>
											<div class="col-lg-5">
												${tblDepartment.postalAddressLine2}</div>
										</div>
										<div class="row">
											<div class="col-lg-2">
												<div class="form_filed">
													State<span style="color: red">*</span>
												</div>
											</div>
											<div class="col-lg-5">${postalState}</div>
										</div>
										<div class="row">
											<div class="col-lg-2">
												<div class="form_filed">City.</div>

											</div>
											<div class="col-lg-5">${tblDepartment.postalCity}</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">
												Phone no.<span style="color: red">*</span>
											</div>
										</div>
										<div class="col-lg-5">${tblDepartment.phoneno}</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Mobile no.</div>

										</div>
										<div class="col-lg-5">${tblDepartment.mobileNo}</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Web site</div>
										</div>
										<div class="col-lg-5">${tblDepartment.website}</div>
									</div>
								</div>
								<div id="PersonalInfo">
									Personal Information

									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">
												Contact Person Name<span style="color: red">*</span>
											</div>
										</div>
										<div class="col-lg-5">${tblDepartment.personName}</div>
									</div>

									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">
												Designation<span style="color: red">*</span>
											</div>
										</div>
										<div class="col-lg-5">${tblDepartment.designationName}</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">
												Phone no.<span style="color: red">*</span>
											</div>
										</div>
										<div class="col-lg-5">${tblDepartment.personalPhoneNo}</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Mobile no.</div>

										</div>
										<div class="col-lg-5">${tblDepartment.personalMobileNo}
										</div>
									</div>

									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">
												Email id<span style="color: red">*</span>
											</div>
										</div>
										<div class="col-lg-5">${tblDepartment.emailId}</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Keywords (UNSPSC)</div>

										</div>
										<div class="col-lg-5 keywordDiv"></div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<spring:message code="label_timezone" var="label_timezone" />
											<div class="form_filed">${label_timezone}<span
													style="color: red">*</span>
											</div>
										</div>
										<div class="col-lg-5">${timeZone}</div>
									</div>
								</div>
								<div class="row">
									<div class="col-lg-2">
										<div class="form_filed">Uploaded documents</div>
									</div>
									<div class="col-lg-5">
										<div class="abrs">
											<a
												href="${pageContext.servletContext.contextPath}/etender/buyer/getDocumentList/${childId}/${objectId}/${childId}/0/0"
												data-target="#myModal" class="myModel" data-toggle="modal">View
												uploaded documents</a>
										</div>
									</div>
									<div id="targetDiv"></div>

								</div>
								<c:if test="${tblDepartment.cstatus eq 0}">
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Status</div>
										</div>
										<div class="col-lg-5">
											<div class="chkbx">
												<input type="radio" name="orgstatus" id="orgstatus"
													checked="checked" value="1" /> Approve <input type="radio"
													name="orgstatus" id="orgstatus" value="2" /> Reject
											</div>
										</div>
									</div>
								</c:if>
								<c:if test="${deptstatus eq 3}">
									<input type="hidden" name="orgstatus" value="${deptstatus}" />
								</c:if>
								<c:if test="${deptstatus eq 1}">
									<input type="hidden" name="orgstatus" value="${deptstatus}" />
								</c:if>
								<div class="row">
									<div class="chkbx">
										<div class="col-lg-2">
											<div class="form_filed">Remarks</div>
										</div>
										<div class="col-lg-5">
											<c:choose>
												<c:when
													test="${(tblDepartment.cstatus eq 0 or deptstatus eq 3 or deptstatus eq 1 ) and isview eq 0}">
													<textarea id="txtaremarks" class="form-control"
														name="txtaremarks" validarr="required@@length:0,500"
														tovalid="true" onblur="validateTextComponent(this)"
														title="remarks"
														validationmsg="Allows max. 500 characters and special character (',- , .,space)"></textarea>
												</c:when>
												<c:otherwise>
													${remarks}
											</c:otherwise>
											</c:choose>
										</div>
									</div>
								</div>
								<c:if
									test="${tblDepartment.cstatus eq 0 or deptstatus eq 3 or deptstatus eq 1}">
									<div class="row">
										<div class="col-lg-2">
											<br>
										</div>
										<div class="col-lg-5">
											<input type="submit" class="form-control" value="Submit"
												onclick="return bidderValidate();">
										</div>
									</div>
								</c:if>
								  
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
	var VALIDATE_MSG_ALLOW_MAX = 'Allows Max. ';
	var VALIDATE_MSG_TENDERBRIEF = 'characters';
	var VALIDATE_MSG_EMAIL_INVALID = 'Allows Min. 6 Max. 50 alphanumeric and Special Characters(@,.,-,_)';
	var VALIDATE_MSG_INVALID_EMAIL = 'Please enter valid email ID';
	var VALIDATE_MSG_INVALID_PASSWORD = "<spring:message code="password_validation_msg" />"
	var VALIDATE_MSG_INVALID_PASSWORD_SPECIAL_CHAR = 'Password must comprise of at least one alphanumeric and special character (!,@,#,$,_,.,(,))';
	var VALIDATE_MSG_INVALID_FULL_NAME = 'Invalid fullname';
	var VALIDATE_MSG_SAME_PASSWORD_AS_LOGINID = 'Password cannot be same as email ID';
	var VALIDATE_MSG_INVALID_CONF_PASSWORD = 'Confirm password does not match with';
	var isDepartmentExists = false;
	var optType = '${optType}';

	function showTargetDiv() {
		$("#targetDiv").show();
	}

	$(document).ready(function() {

		$('a.myModel').click(function() { //bind handlers
			var url = $(this).attr('href');
			showDialog(url);
			return false;
		});

		$("#targetDiv").dialog({ //create dialog, but keep it closed
			autoOpen : false,
			height : 300,
			width : 700,
			modal : true
		});

		function showDialog(url) { //load content and open dialog
			$("#targetDiv").load(url);
			$("#targetDiv").dialog("open");
		}
	});

	function bidderValidate() {
		var vbool = true;
		$('#orgstatus').val($('input[name=orgstatus]:checked').val());
		vbool = valOnSubmit();
		return disableBtn(vbool);
	}

	function checkDuplicateEmail() {
		var tbool = '';
		var data = {};
		var searchValue = $("#txtEmailId").val();
		$
				.ajax({
					type : "POST",
					contentType : "application/json",
					url : "${pageContext.servletContext.contextPath}/ajaxhit/common/user/isemailidexists/"
							+ searchValue + "/",
					data : data,
					timeout : 100000,
					async : false,
					success : function(data) {
						console.log("SUCCESS: ", data);
						var obj = jQuery.parseJSON(data);
						$
								.each(
										obj,
										function(key, value) {
											if (value.isExists == 'true') {
												$("#verifyMail")
														.html(
																"<span style=\"color:red\">Email ID is already registered<\span>");
												$("#verifyMail").show();
												return false;
											}
										});
					},
					error : function(e) {
						console.log("ERROR: ", e);
					},
				});
		return true;
	}

	function checkCommercialRegNo() {
		var tbool = '';
		var data = {};
		var searchValue = $("#txtCommercialRegNo").val();
		$
				.ajax({
					type : "POST",
					contentType : "application/json",
					url : "${pageContext.servletContext.contextPath}/ajaxhit/common/user/iscompanyregnoexists/"
							+ searchValue + "/",
					data : data,
					timeout : 100000,
					async : false,
					success : function(data) {
						console.log("SUCCESS: ", data);
						var obj = jQuery.parseJSON(data);
						$
								.each(
										obj,
										function(key, value) {
											if (value.isExists == 'true') {
												$("#verifyCommercialRegNo")
														.html(
																"<span style=\"color:red\">Commercial Reg No. is already registered<\span>");
												$("#verifyCommercialRegNo")
														.show();
												return false;
											}
										});
					},
					error : function(e) {
						console.log("ERROR: ", e);
					},
				});
		return true;
	}

	function checkDuplicateCompany() {
		var tbool = '';
		var data = {};
		var searchValue = $("#txtCompanyName").val();
		$
				.ajax({
					type : "POST",
					contentType : "application/json",
					url : "${pageContext.servletContext.contextPath}/ajaxhit/common/user/iscompanyexists/"
							+ searchValue + "/",
					data : data,
					timeout : 100000,
					async : false,
					success : function(data) {
						console.log("SUCCESS: ", data);
						var obj = jQuery.parseJSON(data);
						$
								.each(
										obj,
										function(key, value) {
											if (value.isExists == 'true') {
												$("#verifyCompany")
														.html(
																"<span style=\"color:red\">Company is already registered<\span>");
												$("#verifyCompany").show();
												return false;
											}
										});
					},
					error : function(e) {
						console.log("ERROR: ", e);
					},
				});
		return true;
	}

	function getState() {
		var countryId = $("#selCountry").val();
		if (countryId != "") {
			$
					.ajax({
						contentType : "application/json",
						url : "${pageContext.servletContext.contextPath}/common/user/getstatebycountry/"
								+ countryId,
						dataType : "json",
						async : false,
						success : function(data) {
							$("#selState option").not(":first").remove();
							for (var i = 0; i < data.length; i++) {
								$("#selState").append(
										"<option value='"+data[i][0]+"'>"
												+ data[i][1] + "</option>")
							}

							$("#selPostalStateId option").not(":first")
									.remove();
							for (var i = 0; i < data.length; i++) {
								$("#selPostalStateId").append(
										"<option value='"+data[i][0]+"'>"
												+ data[i][1] + "</option>")
							}
						},
						error : function(e) {
							console.log("ERROR: ", e);
						},
					});
		}
	}
</script>
<script src='https://www.google.com/recaptcha/api.js'></script>
<%@include file="./../includes/footer.jsp"%>
