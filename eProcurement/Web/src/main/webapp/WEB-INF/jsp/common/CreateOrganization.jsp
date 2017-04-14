<%@include file="./../includes/head.jsp"%>	
		<%@include file="./../includes/headerWithoutLogin.jsp"%>	
        <spring:message code="lbl_create_user" var="createuser"/>
        <spring:message code="default_country" var="default_country"/>
        <spring:message code="default_tinezone" var="default_tinezone"/>
        
<spring:message code="label_select" var="label_select"/>

<div class="content-wrapper">

<section class="content-header">
</section>

<section class="content">
	<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="box">
					
						<div class="box-header with-border">
						<spring:message code="lbl_create_tender_authority" var="lbl_create_tender_authority"/>
								<c:choose>
	               					<c:when test="${optType eq 'Edit'}">
	               					<spring:message code="lbl_edit_user" var="edituser"/>
	               					<%-- <a href="${pageContext.servletContext.contextPath}/etender/bidder/bidderTenderListing"><< Go bidder</a><br> --%>
	               						<h3 class="box-title">${lbl_create_tender_authority}</h3>
	               					</c:when>
	               					<c:otherwise>
	               						<h3 class="box-title">${lbl_create_tender_authority}</h3>
								</c:otherwise>
								</c:choose>
								<a href="${pageContext.servletContext.contextPath}/login" class="goBack pull-right noExport"><< Go Back To Login</a>
						</div>
						
						<div class="box-body">
							<div class="row">	
		               			<spring:url value="/common/user/addOrganization" var="submitUser"/>
		               			
								<div class="col-lg-12 col-md-12 col-xs-12">
								
									<form action="${submitUser}" name="frmUser" method="post"  >
									
									<div id="companyInfo">
									
									<div class="row">
									<div class="col-lg-2 col-md-2 col-sm-6 col-xs-12">
									<h4 style="color:#006cb7;">Company Information</h4>
									</div>
									<div class="col-lg-5 col-md-5 col-sm-6 col-xs-12">
									<font size="1" class="pull-right mandatory m-top2" style="font-size: 15px; line-height: 40px;"><spring:message code="msg_mandatoryFields"/></font>
									<input type="hidden" name="hdOptType" value="${optType}"/>
									<input type="hidden" name="bidderDocId" value="${childId}"/>
									</div>
									</div>
									
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed" data-toggle="tooltip" data-placement="top"  data-original-title="Tooltip on Top" >Origin of the Company<span style="color: red">*</span></div>
										</div>
										<div class="col-lg-5">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
				               						<select class="form-control" id="selOriginCountryId" name="selOriginCountryId" isrequired="true" onchange="if(validateCombo(this)){getState()}" title="Origin of the company">
													</select>
				               					</c:when>
				               					<c:otherwise>
				               						<select class="form-control" id="selOriginCountryId" name="selOriginCountryId" isrequired="true" onchange="if(validateCombo(this)){getState()}" title="Origin of the company">
													</select>
				               					</c:otherwise>
				               					</c:choose>
										</div>
									</div>
									
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed" data-toggle="tooltip" data-placement="top"  data-original-title="Tooltip on Top" >Company Name<span style="color: red">*</span></div>
										</div>
										<div class="col-lg-5">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
													<input id="txtCompanyName" value="${bidderDtls[2]}" onblur="javascript:{if(validateTextComponent(this)){checkDuplicateCompany();}}" class="form-control" name="txtCompanyName" validarr="required@@alphanumspecial@@length:3,200" tovalid="true" onblur="validateTextComponent(this)" title="Company Name" validationmsg="Allows min 3 and max. 100 characters and special character (',- , .,space)" onfocus="javascript:{$('#verifyCompany').html('');}" type="text">
													<span id="verifyCompany" style="display: block;color: red"></span>
				               					</c:when>
				               					<c:otherwise>
													<input id="txtCompanyName" onblur="javascript:{if(validateTextComponent(this)){checkDuplicateCompany();}}" class="form-control"  name="txtCompanyName" validarr="required@@alphanumspecial@@length:3,200" tovalid="true" onblur="validateTextComponent(this)" title="Company Name" validationmsg="Allows min 3 and max. 200 characters and special character (',- , .,space)" onfocus="javascript:{$('#verifyCompany').html('');}" type="text">
													<span id="verifyCompany" style="display: block;color: red"></span>
				               					</c:otherwise>
				               					</c:choose>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed" data-toggle="tooltip" data-placement="top"  data-original-title="Tooltip on Top" >Commercial Registration No.<span style="color: red">*</span></div>
										</div>
										<div class="col-lg-5">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
													<input id="txtCommercialRegNo" onblur="javascript:{if(validateTextComponent(this)){checkCommercialRegNo();}}" value="${bidderDtls[2]}" onfocus="javascript:{$('#verifyCommercialRegNo').html('');}" class="form-control" name="txtCommercialRegNo" validarr="required@@length:3,200" tovalid="true" onblur="validateTextComponent(this)" title="Commercial Registration Number" validationmsg="Allows min 3 and max. 100 characters)" type="text">
													<span id="verifyCommercialRegNo" style="display: block;color: red"></span>
				               					</c:when>
				               					<c:otherwise>
													<input id="txtCommercialRegNo" onblur="javascript:{if(validateTextComponent(this)){checkCommercialRegNo();}}" class="form-control"  onfocus="javascript:{$('#verifyCommercialRegNo').html('');}" name="txtCommercialRegNo" validarr="required@@length:3,200" tovalid="true" onblur="validateTextComponent(this)" title="Commercial Registration Number" validationmsg="Allows min 3 and max. 200 numeric and characters " type="text">
													<span id="verifyCommercialRegNo" style="display: block;color: red"></span>
				               					</c:otherwise>
				               					</c:choose>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed" data-toggle="tooltip" data-placement="top"  data-original-title="Tooltip on Top" >Date of Establishment<span style="color: red">*</span></div>
										</div>
										<div class="col-lg-5">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
													<input type="text" class="form-control dateBox" name="txtEstablishDate" datepicker="yes" id="txtEstablishDate" placeholder="${client_dateformate_hhmm}"  dtrequired="true" title="Date of Establishment" value="" onblur="validateEmptyDt(this)" >
				               					</c:when>
				               					<c:otherwise>
													<input type="text" class="form-control dateBox" name="txtEstablishDate" datepicker="yes" id="txtEstablishDate" placeholder="${client_dateformate_hhmm}"  dtrequired="true" title="Date of Establishment"  onblur="validateEmptyDt(this)" >
				               					</c:otherwise>
				               					</c:choose>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Sector<span style="color: red">*</span></div>
										</div>
										<div class="col-lg-5">
											<c:choose>
				               					<c:when test="${optType eq 'Edit'}">	
					               						<select class="form-control" id="selBidderSector" name="selBidderSector" isrequired="true" onblur="validateCombo(this)" title="atleast 1 sector" multiple="multiple"> 
														</select>
				               					</c:when>
				               					<c:otherwise>
													<select class="form-control" id="selBidderSector" name="selBidderSector" isrequired="true" onblur="validateCombo(this)" title="atleast 1 sector" multiple="multiple">
													</select>
												</c:otherwise>
											</c:choose>	
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Office Address Line 1<span style="color: red">*</span></div>
										</div>
										<div class="col-lg-5">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
													<textarea id="txtaAddress"  class="form-control" name="txtaAddress" validarr="required@@length:0,1000" tovalid="true" onblur="if(validateTextComponent(this)){validatePostalAdd()}" title="Official Address Line 1" validationmsg="Allows max. 500 characters and special character (',- , .,space)" >${bidderDtls[3]}</textarea>
				               					</c:when>
				               					<c:otherwise>
													<textarea id="txtaAddress" class="form-control" name="txtaAddress" validarr="required@@length:0,1000" tovalid="true" onblur="if(validateTextComponent(this)){validatePostalAdd()}" title="Official Address Line 1" validationmsg="Allows max. 500 characters and special character (',- , .,space)" ></textarea>
				               					</c:otherwise>
				               					</c:choose>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Office Address Line 2</div>
										</div>
										<div class="col-lg-5">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
													<textarea id="txtaAddressLine2"  class="form-control" name="txtaAddressLine2" validarr="length:0,1000" tovalid="true" onblur="if(validateTextComponent(this)){validatePostalAdd()}" title="Official Address Line 2" validationmsg="Allows max. 500 characters and special character (',- , .,space)" >${bidderDtls[3]}</textarea>
				               					</c:when>
				               					<c:otherwise>
													<textarea id="txtaAddressLine2" class="form-control" name="txtaAddressLine2" validarr="length:0,1000" tovalid="true" onblur="if(validateTextComponent(this)){validatePostalAdd()}" title="Official Address Line 2" validationmsg="Allows max. 500 characters and special character (',- , .,space)" ></textarea>
				               					</c:otherwise>
				               					</c:choose>
										</div>
									</div>
									<div class="row" style="display: none">
										<div class="col-lg-2" >
											<div class="form_filed">Country<span style="color: red">*</span></div>
										</div>
										<div class="col-lg-5">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
				               						<select class="form-control" id="selCountry" name="selCountry" isrequired="true" onchange="if(validateCombo(this)){getState()}" title="Country">
													</select>
				               					</c:when>
				               					<c:otherwise>
				               						<select class="form-control" id="selCountry" name="selCountry" isrequired="true" onchange="if(validateCombo(this)){getState()}" title="Country">
													</select>
				               					</c:otherwise>
				               					</c:choose>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">State <span style="color: red">*</span></div>
										</div>
										<div class="col-lg-5">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
				               						<select class="form-control" id="selState" name="selState" isrequired="true" onchange="validatePostalAdd()" title="State">
				               							<option value="">Select</option>
													</select>
				               					</c:when>
				               					<c:otherwise>
				               						<select class="form-control" id="selState" name="selState" isrequired="true" onchange="validatePostalAdd()" title="State">
				               							<option value="">Select</option>
													</select>
				               					</c:otherwise>
				               					</c:choose>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">City</div>
											
										</div>
										<div class="col-lg-5">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
													<input id="txtCity" value="${bidderDtls[4]}" class="form-control" name="txtCity" validarr="length:0,20" tovalid="false" onblur="if(validateTextComponent(this)){validatePostalAdd()}" title="City"  type="text">
				               					</c:when>
				               					<c:otherwise>
													<input id="txtCity" class="form-control" name="txtCity" validarr="length:0,20" tovalid="false" onblur="if(validateTextComponent(this)){validatePostalAdd()}" title="City"  type="text">
				               					</c:otherwise>
				               					</c:choose>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
										</div>
										<div class="col-lg-5">
											<input type="checkbox" id="addresssame"/>Postal address is same as office address
										</div>
									</div>
									
									<div id="postalDetail">
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Postal Address Line 1<span style="color: red">*</span></div>
										</div>
										<div class="col-lg-5">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
													<textarea id="txtPostalAddressLine1"  class="form-control" name="txtPostalAddressLine1" validarr="required@@length:0,1000" tovalid="true" onblur="validateTextComponent(this)" title="Postal Address Line 1" validationmsg="Allows max. 500 characters and special character (',- , .,space)">${bidderDtls[3]}</textarea>
				               					</c:when>
				               					<c:otherwise>
													<textarea id="txtPostalAddressLine1" class="form-control" name="txtPostalAddressLine1" validarr="required@@length:0,1000" tovalid="true" onblur="validateTextComponent(this)" title="Postal Address Line 1" validationmsg="Allows max. 500 characters and special character (',- , .,space)" ></textarea>
				               					</c:otherwise>
				               					</c:choose>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Postal Address Line 2</div>
										</div>
										<div class="col-lg-5">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
													<textarea id="txtPostalAddressLine2"  class="form-control" name="txtPostalAddressLine2" validarr="length:0,1000" tovalid="true" isrequired="true" onblur="validateTextComponent(this)" title="postal address line 2" validationmsg="Allows max. 500 characters and special character (',- , .,space)" >${bidderDtls[3]}</textarea>
				               					</c:when>
				               					<c:otherwise>
													<textarea id="txtPostalAddressLine2" class="form-control" name="txtPostalAddressLine2" validarr="length:0,1000" tovalid="true" isrequired="true" onblur="validateTextComponent(this)" title="postal address line 2" validationmsg="Allows max. 500 characters and special character (',- , .,space)" ></textarea>
				               					</c:otherwise>
				               					</c:choose>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">State<span style="color: red">*</span></div>
										</div>
										<div class="col-lg-5">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
				               						<select class="form-control" id="selPostalStateId" name="selPostalStateId" isrequired="true" onchange="validateCombo(this)" title="State">
				               							<option value="">Select</option>
													</select>
				               					</c:when>
				               					<c:otherwise>
				               						<select class="form-control" id="selPostalStateId" name="selPostalStateId" isrequired="true" onchange="validateCombo(this)" title="State">
				               							<option value="">Select</option>
													</select>
				               					</c:otherwise>
				               					</c:choose>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">City</div>
											
										</div>
										<div class="col-lg-5">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
													<input id="txtPostalCity" value="${bidderDtls[4]}" class="form-control" name="txtPostalCity" validarr="length:0,20" tovalid="false" onblur="validateTextComponent(this)" title="City"  type="text">
				               					</c:when>
				               					<c:otherwise>
													<input id="txtPostalCity" class="form-control" name="txtPostalCity" validarr="length:0,20" tovalid="false" onblur="validateTextComponent(this)" title="City"  type="text">
				               					</c:otherwise>
				               					</c:choose>
										</div>
									</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Phone no.<span style="color: red">*</span></div>
										</div>
										<div class="col-lg-5">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
				               					<c:if  test="${fn:contains(bidderDtls[5], '-')}">
				               						<c:set var="tmpPhone" value="${fn:split(bidderDtls[5], '-')}"/>
				               						<div><input id="txtPhoneNo1" value="${tmpPhone[0]}"  class="form-control" placeholder="CC" style="width: 60px;float: left" name="txtPhoneNo1" validarr="required@@length:0,4@@phoneno" tovalid="true" onblur="validateTextComponent(this)" title="Phone no." maxlength="4" validationmsg="Allows max. 4 numbers and special characters (-,+)" type="text"><label style="float: left">-</label>
													<input id="txtPhoneNo2" value="${tmpPhone[1]}"  class="form-control" placeholder="Phone No." style="width: 200px;float: left" name="txtPhoneNo2" validarr="required@@length:0,15@@phoneno" tovalid="true" onblur="validateTextComponent(this)" title="Phone no." maxlength="15"  validationmsg="Allows max. 15 numbers" type="text"><label style="float: left">-</label>
													<input id="txtPhoneNo" value="${tmpPhone[2]}"  placeholder="Ext." class="form-control" style="width: 60px;float: left" name="txtPhoneNo" validarr="length:0,5@@phoneno" tovalid="false" onblur="validateTextComponent(this)" title="Phone no." maxlength="4"  validationmsg="Allows max. 4 numbers" type="text">
													</div>	
				               					</c:if>
				               					</c:when>
				               					<c:otherwise>
				               						<div><input id="txtPhoneNo1" maxlength="4"  placeholder="CC" class="form-control" style="width: 60px;float: left" name="txtPhoneNo1" validarr="required@@length:0,4@@phoneno" tovalid="true" onblur="validateTextComponent(this)" title="Code." validationmsg="Allows max. 4 numbers and special characters (-,+)" type="text">
				               						<div class="dash">-</div>
													<input id="txtPhoneNo2"  placeholder="Phone No." maxlength="15"  class="form-control" style="width: 200px;float: left" name="txtPhoneNo2" validarr="required@@length:0,15@@phoneno" tovalid="true" onblur="validateTextComponent(this)" title="Phone no." validationmsg="Allows max. 15 numbers" type="text">
													<div class="dash">-</div>
													<input id="txtPhoneNo"  placeholder="Ext."  class="form-control" maxlength="4"  style="width: 60px;float: left" name="txtPhoneNo" validarr="length:0,4@@phoneno" tovalid="false" onblur="validateTextComponent(this)" title="Landline No." validationmsg="Allows max. 4 numbers" type="text">
													</div>
				               					</c:otherwise>
				               					</c:choose>
										</div>
									</div>
									<div class="row" style="display: none">
										<div class="col-lg-2">
											<div class="form_filed">Mobile no.</div>
											
										</div>
										<div class="col-lg-5">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
													<input id="txtMobileNo" value="${bidderDtls[6]}" maxlength="15" class="form-control" name="txtMobileNo" validarr="length:0,15@@phoneno" tovalid="true" onblur="validateTextComponent(this)" title="Mobile no." validationmsg="Allows max 15 number (0 to 9)" type="text">
				               					</c:when>
				               					<c:otherwise>
													<input id="txtMobileNo" class="form-control" name="txtMobileNo" maxlength="15"  validarr="length:0,15@@phoneno" tovalid="true" onblur="validateTextComponent(this)" title="Mobile no." validationmsg="Allows max 15 number (0 to 9)" type="text">
				               					</c:otherwise>
				               					</c:choose>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Web site</div>
										</div>
										<div class="col-lg-5">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
													<input id="txtWebsite" value="${bidderDtls[7]}" class="form-control" name="txtWebsite" validarr="website" tovalid="true" onblur="validateTextComponent(this)" title="correct website URL" type="text">
				               					</c:when>
				               					<c:otherwise>
													<input id="txtWebsite" class="form-control" name="txtWebsite" validarr="website" tovalid="true" onblur="validateTextComponent(this)" title="correct website URL"  type="text">
				               					</c:otherwise>
				               					</c:choose>
										</div>
									</div>
									
									</div>
									
									<div id="PersonalInfo">
									
									<div class="row">
										<div class="col-lg-12" style="color: #006cb7;">
											<h4>Personal Information</h4>
										</div>
									</div>
									
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Contact Person Name<span style="color: red">*</span></div>
										</div>
										<div class="col-lg-5">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
													<input id="txtFullName" value="${bidderDtls[1]}" class="form-control" name="txtFullName" validarr="required@@fullname@@length:0,100" tovalid="true" onblur="validateTextComponent(this)" title="Contact Person Name" validationmsg="Allows max. 100 characters and special character (',- , .,space)" type="text">
				               					</c:when>
				               					<c:otherwise>
													<input id="txtFullName" class="form-control" name="txtFullName" validarr="required@@fullname@@length:0,100" tovalid="true" onblur="validateTextComponent(this)" title="Contact Person Name" validationmsg="Allows max. 100 characters and special character (',- , .,space)" type="text">
				               					</c:otherwise>
				               					</c:choose>
										</div>
									</div>
									
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Designation</div>
										</div>
										<div class="col-lg-5">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
													<input id="txtDesignationName" value="${bidderDtls[1]}" class="form-control" name="txtDesignationName" validarr="required@@fullname@@length:0,100" tovalid="true" onblur="validateTextComponent(this)" title="Contact Person Name" validationmsg="Allows max. 100 characters and special character (',- , .,space)" type="text">
				               					</c:when>
				               					<c:otherwise>
													<input id="txtDesignationName" class="form-control" name="txtDesignationName" validarr="alphabet@@length:0,100" tovalid="true" onblur="validateTextComponent(this)" title="Contact Person Name" validationmsg="Allows max. 100 characters and special character (',- , .,space)" type="text">
				               					</c:otherwise>
				               					</c:choose>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Phone no.<span style="color: red">*</span></div>
										</div>
										<div class="col-lg-5">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
				               						<c:if  test="${fn:contains(bidderDtls[5], '-')}">
				               						<c:set var="tmpPhone" value="${fn:split(bidderDtls[5], '-')}"/>
				               						<div><input id="txtPhoneNo1" value="${tmpPhone[0]}"  class="form-control" placeholder="CC" style="width: 60px;float: left" name="txtPhoneNo1" validarr="required@@length:0,4@@phoneno" tovalid="true" onblur="validateTextComponent(this)" title="Phone no." maxlength="4" validationmsg="Allows max. 4 numbers and special characters (-,+)" type="text"><label style="float: left">-</label>
													<input id="txtPhoneNo2" value="${tmpPhone[1]}"  class="form-control" placeholder="Phone No." style="width: 200px;float: left" name="txtPhoneNo2" validarr="required@@length:0,15@@phoneno" tovalid="true" onblur="validateTextComponent(this)" title="Phone no." maxlength="15"  validationmsg="Allows max. 15 numbers" type="text"><label style="float: left">-</label>
													<input id="txtPhoneNo" value="${tmpPhone[2]}"  placeholder="Ext." class="form-control" style="width: 60px;float: left" name="txtPhoneNo" validarr="length:0,5@@phoneno" tovalid="false" onblur="validateTextComponent(this)" title="Phone no." maxlength="4"  validationmsg="Allows max. 4 numbers" type="text">
													</div>	
				               					</c:if>		
				               					</c:when>
				               					<c:otherwise>
				               						<div><input id="txtPersonalPhoneNo1" placeholder="CC" class="form-control" maxlength="4"  style="width: 60px;float: left" name="txtPersonalPhoneNo1" validarr="required@@length:0,4@@phoneno" tovalid="true" onblur="validateTextComponent(this)" title="Code" validationmsg="Allows max. 4 numbers and special characters (-,+)" type="text">
				               						<div class="dash">-</div>
													<input id="txtPersonalPhoneNo2" placeholder="Phone No." class="form-control" maxlength="15"  style="width: 200px;float: left" name="txtPersonalPhoneNo2" validarr="required@@length:0,20@@phoneno" tovalid="true" onblur="validateTextComponent(this)" title="Phone no." validationmsg="Allows max. 15 numbers" type="text">
													<div class="dash">-</div>
													<input id="txtPersonalPhoneNo" placeholder="Ext." maxlength="4"  class="form-control" style="width: 60px;float: left" name="txtPersonalPhoneNo" validarr="length:0,4@@phoneno" tovalid="false" onblur="validateTextComponent(this)" title="Ext." validationmsg="Allows max. 4 numbers" type="text">
													</div>
				               					</c:otherwise>
				               					</c:choose>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Mobile no.<span style="color: red">*</span></div>
											
										</div>
										<div class="col-lg-5">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
													<input id="txtPersonalMobileNo" value="${bidderDtls[6]}" maxlength="15" class="form-control" name="txtPersonalMobileNo" validarr="length:0,15@@phoneno" tovalid="true" onblur="validateTextComponent(this)" title="Mobile no." validationmsg="Allows max 15 number (0 to 9)" type="text">
				               					</c:when>
				               					<c:otherwise>
													<input id="txtPersonalMobileNo1" class="form-control" maxlength="4"  style="width: 60px;float: left"  name="txtPersonalMobileNo1" validarr="required@@length:0,4@@phoneno" tovalid="true" onblur="validateTextComponent(this)" title="Country Code" validationmsg="Allows max. 4 numbers and special characters (-,+)" type="text">
													<div class="dash">-</div>
													<input id="txtPersonalMobileNo" class="form-control" maxlength="15"  style="width: 200px;float: left"  name="txtPersonalMobileNo" validarr="required@@length:0,15@@phoneno" tovalid="true" onblur="validateTextComponent(this)" title="Mobile No" validationmsg="Allows max 15 number (0 to 9)" type="text">
				               					</c:otherwise>
				               					</c:choose>
										</div>
									</div>
									
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed" >E-mail ID<span style="color: red">*</span></div>
										</div>
										<div class="col-lg-5">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
													<input class="form-control" id="txtEmailId" value="${bidderDtls[0]}" name="txtEmailId" validarr="required@@email" tovalid="true" onblur="javascript:{if(validateTextComponent(this)){checkDuplicateEmail();}}" title="Email ID" onfocus="javascript:{$('#verifyMail').html('');}" type="text">
													<span id="verifyMail" style="display: block;color: red"></span>
													<input type="hidden" name="hdUserId" value="${bidderDtls[12]}"/>
													<input type="hidden" name="hdBidderId" value="${bidderId}"/>
				               					</c:when>
				               					<c:otherwise>
													<input class="form-control" id="txtEmailId" name="txtEmailId" validarr="required@@email" tovalid="true" onblur="javascript:{if(validateTextComponent(this)){checkDuplicateEmail();}}" title="Email ID" onfocus="javascript:{$('#verifyMail').html('');}" type="text">
													<span id="verifyMail" style="display: block"></span>
				               					</c:otherwise>
				               					</c:choose>
										</div>
									</div>
									
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed" >Re-enter Email ID<span style="color: red">*</span></div>
										</div>
										<div class="col-lg-5">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
													<input class="form-control" id="txtConfirmEmailId" value="${bidderDtls[0]}" name="txtConfirmEmailId" validarr="required@@email@@confirmemail:EmailId" tovalid="true" onblur="javascript:{if(validateTextComponent(this)){checkDuplicateEmail();}}" title="Re-enter Email ID" onfocus="javascript:{$('#verifyMail').html('');}" type="text">
													<span id="verifyMail" style="display: block;color: red"></span>
				               					</c:when>
				               					<c:otherwise>
													<input class="form-control" id="txtConfirmEmailId" name="txtConfirmEmailId" validarr="required@@email@@confirmemail:EmailId" tovalid="true" onblur="javascript:{if(validateTextComponent(this)){checkDuplicateEmail();}}" title="Re-enter Email ID" onfocus="javascript:{$('#verifyMail').html('');}" type="text">
													<span id="verifyMail" style="display: block"></span>
				               					</c:otherwise>
				               					</c:choose>
										</div>
									</div>
									
									<c:if test="${optType ne 'Edit' and false}">
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Password<span style="color: red">*</span></div>
										</div>
										<div class="col-lg-5">
										<div>
										
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
													<input id="txtPassword" value="${bidderDtls[13]}" class="form-control" name="txtPassword" validarr="required@@password@@checkloginidpwd:EmailId@@length:8,15" tovalid="true" onblur="validateTextComponent(this)" title="Password" " type="password">
				               					</c:when>
				               					<c:otherwise>
													<input id="txtPassword" class="form-control" name="txtPassword" validarr="required@@password@@checkloginidpwd:EmailId@@length:8,15" tovalid="true" onblur="validateTextComponent(this)" title="Password" type="password">
				               					</c:otherwise>
				               					</c:choose>
				               					<div class="nowrap">(<spring:message code="password_validation_msg" />)</div>
				               				</div>	
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Confirm password<span style="color: red">*</span></div>
											
										</div>
										<div class="col-lg-5">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
													<input id="txtConfirmPassword" value="${bidderDtls[13]}" class="form-control" name="txtConfirmPassword" validarr="required@@confirmpwd:Password" tovalid="true" onblur="validateTextComponent(this)" title="Confirm password"  type="password">
				               					</c:when>
				               					<c:otherwise>
													<input id="txtConfirmPassword" class="form-control" name="txtConfirmPassword" validarr="required@@confirmpwd:Password" tovalid="true" onblur="validateTextComponent(this)" title="Confirm password"  type="password">
				               					</c:otherwise>
				               					</c:choose>	
										</div>
									</div>
									</c:if>
									
									<div class="row" style="display: none">
										<div class="col-lg-2">
											<div class="form_filed">Last name<span style="color: red">*</span></div>
										</div>
										<div class="col-lg-5">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
													<input id="txtLastName" value="${bidderDtls[1]}" class="form-control" name="txtLastName" validarr="fullname@@length:0,100" tovalid="true" onblur="validateTextComponent(this)" title="Person name" validationmsg="Allows max. 100 characters and special character (',- , .,space)" type="text">
				               					</c:when>
				               					<c:otherwise>
													<input id="txtLastName" class="form-control" name="txtLastName" validarr="fullname@@length:0,100" tovalid="true" onblur="validateTextComponent(this)" title="Person name" validationmsg="Allows max. 100 characters and special character (',- , .,space)" type="text">
				               					</c:otherwise>
				               					</c:choose>
										</div>
									</div>
									<div class="row" style="display: none">
										<div class="col-lg-2">
											<div class="form_filed">Middle name</div>
										</div>
										<div class="col-lg-5">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
													<input id="txtMiddleName" value="${bidderDtls[1]}" class="form-control" name="txtMiddleName" validarr="fullname@@length:0,100" tovalid="true" onblur="validateTextComponent(this)" title="Person name" validationmsg="Allows max. 100 characters and special character (',- , .,space)" type="text">
				               					</c:when>
				               					<c:otherwise>
													<input id="txtMiddleName" class="form-control" name="txtMiddleName" validarr="fullname@@length:0,100" tovalid="true" onblur="validateTextComponent(this)" title="Person name" validationmsg="Allows max. 100 characters and special character (',- , .,space)" type="text">
				               					</c:otherwise>
				               					</c:choose>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Keywords (UNSPSC)</div>
											
										</div>
										<div class="col-lg-5 keywordDiv">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
													<!-- <select id="selKeywords" multiple="multiple" class="form-control" name="selKeywords"  tovalid="true" onchange="validateCombo(this)" title="Keywords" ></select> -->
													<select id="selKeywords" class="form-control" multiple="multiple" name="selKeywords" title="keyword" onchange="validateCombo(this)" >
														<c:forEach items="${categoryList}" var="category">
															<option selected="selected" value="${category[0]}">${category[1]}</option>
														</c:forEach>
													
													</select>
				               					</c:when>
				               					<c:otherwise>
													<!-- <input id="txtKeywords" class="form-control" name="txtKeywords" validarr="length:3,300" tovalid="true" onblur="validateTextComponent(this)" title="Keywords"  type="text"> -->
													<select id="selKeywords" class="form-control" multiple="multiple" name="selKeywords" title="keyword" onchange="validateCombo(this)" ></select>
				               					</c:otherwise>
				               					</c:choose>
											<input type="hidden" name="categoryText" id="categoryText">
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
										<spring:message code="label_timezone" var="label_timezone"/>
											<div class="form_filed">${label_timezone}<span style="color: red">*</span></div>
										</div>
										<div class="col-lg-5">
										<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
													<select  name="selTimezoneId" id="selTimezoneId" isrequired="true" onchange="validateCombo(this)" class="form-control" title="${label_timezone}">
														<option value="">${label_select}</option>
														<c:forEach items="${timezonelist}" var="timezone">
														<c:set var="selected" value=""/>
														<c:if test="${default_tinezone eq timezone.timezoneId or bidderDtls[15] eq timezone.timezoneId}">
															<c:set var="selected" value="selected='selected'"/>
														</c:if>
															<option value="${timezone.timezoneId}" ${selected}>${timezone.countryName} (${timezone.utcOffset})</option>
														</c:forEach>
													</select>
				               					</c:when>
				               					<c:otherwise>
												<select  name="selTimezoneId" id="selTimezoneId" isrequired="true" onchange="validateCombo(this)" class="form-control" title="${label_timezone}">
													<option value="">${label_select}</option>
													<c:forEach items="${timezonelist}" var="timezone">
													    <c:set var="selected" value=""/>
													    <c:if test="${default_tinezone eq (timezone.timezoneId+'') }">
															<c:set var="selected" value="selected='selected'"/>
														</c:if>
														<option value="${timezone.timezoneId}" ${selected}>${timezone.countryName} (${timezone.utcOffset})</option>
													</c:forEach>
												</select>
				               					</c:otherwise>
				               					</c:choose>
										</div>
									</div>
									<h4 style="color: #006cb7;">Upload <spring:message code="fields_docName" /></h4>																	
									<%@include file="./../etender/buyer/UploadDocuments.jsp"%>
										
									<c:if test="${optType ne 'Edit'}">
									<div class="row">
										<div class="col-lg-2">
											<br>
										</div>
										<div class="col-lg-5">
											<input type="checkbox" name="igree" id="iagree"  />I agree to the terms & conditions and privacy policy of this website.
											<a href="javascript:" id="viewPrivacy" onclick="javascript:showTargetDiv();">View privacy policy</a>
										<div id="targetDiv"  style="display:none" >Here by you agree all privacy policies and terms and conditions of Cahoot technologies LTD</div> 
 											<div id="iAgreeError" style="color: red"></div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											
										</div>
										<div class="col-lg-5">
											<div class="g-recaptcha" data-sitekey="6Ld1eBIUAAAAAAH43IoWk1nmD-MMvcWaDYEQIO9o" style="margin-top:10px;"></div>
										</div>
									</div>
									</c:if>
										
									<div class="row">
										<div class="col-lg-2">
											<br>
										</div>
										<div class="col-lg-5">
											<input type="submit" class="form-control" value="Submit"  onclick="return bidderValidate();" >
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
        var isDepartmentExists=false;
        var optType = '${optType}';
        var countryId ="";
        var stateId="";
        var selOriginCountryId="";
        var bidderSectorJson = '${bidderSector}';
        var bidderSectorJsonObj = jQuery.parseJSON(bidderSectorJson);
	        if(optType=='Edit'){
		       	countryId = '${bidderDtls[9]}';
	        	stateId = '${bidderDtls[8]}';
	        }else{
	        	tinezone = ${default_tinezone}
	        	countryId = ${default_country};
// 	        	selOriginCountryId = ${default_country};
	        }
        	//var countryJson = '${countryJson}';
        
       		function  showTargetDiv(){
       			$("#targetDiv").show();
        	}
        
       		
        	var obj = (${countryJson});
            $(document).ready(function() {
            	$("input[type=checkbox]").change(function(){
                    var ischecked= $(this).is(':checked');
                    if(!ischecked){
                    	$('#txtPostalAddressLine1').val("");
                    	$('#txtPostalAddressLine2').val("");
                    	$('#txtPostalCity').val("");
                    	$('#selPostalStateId').val("");
                    }else{
                    	$('#selPostalStateId').val($('#selState').val());
                    	$('#txtPostalAddressLine1').val($('#txtaAddress').val());
                    	$('#txtPostalAddressLine2').val($('#txtaAddressLine2').val());
                    	$('#txtPostalCity').val($('#txtCity').val());
                    }
                });
            	$('#selCountry').html('');
    	     	$.each(obj, function (key, value) {
    	    	$('#selCountry').append($('<option>',
    	    		{
    	    		    value: value.value,
    	    		    text : value.label
    	    		}));
    	    	 });
    	     	
    	     	
    	     	$('#selOriginCountryId').html('');
    	     	
    	     	$("#selOriginCountryId").append('<option selected="selected">Select</option>');
    	     	
    	     	$.each(obj, function (key, value) {
    	    	$('#selOriginCountryId').append($('<option>',
    	    		 {
    	    		    value: value.value,
    	    		    text : value.label
    	    		}));
    	    	 }); 
    			
    	     	$('#selBidderSector').html('');
    	     	$.each(bidderSectorJsonObj, function (key, value) {
    	    	$('#selBidderSector').append($('<option>',
    	    		 {
    	    		    value: value.value,
    	    		    text : value.label
    	    		}));
    	    	 });
    	     	
    	     	if(optType=='Edit'){
	    	     	$('select[id="selCountry"] option:selected').attr("selected",null);
		   	     	$('select[id="selCountry"] option[value="'+countryId+'"]').attr("selected","selected");
		   	     	$('select[id="selOriginCountryId"] option:selected').attr("selected",null);
		   	     	$('select[id="selOriginCountryId"] option[value="'+selOriginCountryId+'"]').attr("selected","selected");
	    	     	getState();
	    	     	$('select[id="selState"] option:selected').attr("selected",null);
		   	     	$('select[id="selState"] option[value="'+stateId+'"]').attr("selected","selected");
		   	     	
		   	     	$('select[id="selPostalStateId"] option:selected').attr("selected",null);
		   	     	$('select[id="selPostalStateId"] option[value="'+stateId+'"]').attr("selected","selected");
    	     	}else{
    	     		$('select[id="selCountry"] option[value="'+countryId+'"]').attr("selected","selected");
    	     		
//     	     		$('select[id="selOriginCountryId"] option[value="'+selOriginCountryId+'"]').attr("selected","selected");
    	     		getState();
    	     	}
    	     	
    	     	
    	     	$("#selBidderSector").select2({
            		maximumSelectionLength: 5
            	}); 
        	});
            function bidderValidate(){
            	var vbool = true;
            	vbool = valOnSubmit();
            	$('#iAgreeError').html('');
            	var keyword = $("#selKeywords").select2("data");
            	if(keyword.length <= 0){
            		var div = $('<div class="errselKeywords validationMsg clearfix">Please select keyword</div>')
        			$("#keywordDiv").append(div);
        			$("#selKeywords").focus();
            		vbool=false;
            	}else{
            		$(".errselKeywords").remove();
            	}
            	var doccount =	$("#doclstId").find("td").length;
            	if(doccount>0){
            		vbool=true;	
            	}else{
            		vbool=false;
            		alert("Upload commercial registration certificate");
            	}
				if(vbool){
            		var keywords = "";
            		$.each(keyword,function(i,item){ 
            			keywords+=item.id+"###"+item.text+"#@#"; 
            		});
            		$("#categoryText").val(keywords);
            	}
				if(optType!='Edit'){
        			vbool = checkDuplicateEmail();
        			vbool = checkCommercialRegNo();
        			vbool = checkDuplicateCompany();
                    if(!$('#iagree').is(':checked')){
                    	vbool=false;
                    	$('#iAgreeError').html("Please agree terms & conditions");
                    }	
        		}
        		
            	if(vbool){
            		var txtPhoneNo = $("#txtPhoneNo").val();
            		var txtPersonalPhoneNo = $("#txtPersonalPhoneNo").val();
            		var txtPersonalMobileNo = $("#txtPersonalMobileNo").val();
            		$("#txtPhoneNo").val($("#txtPhoneNo1").val()+"-"+$("#txtPhoneNo2").val());
            		if(txtPhoneNo!=''){
            			$("#txtPhoneNo").val($("#txtPhoneNo").val()+"-"+txtPhoneNo);	
            		}
            		$("#txtPersonalPhoneNo").val($("#txtPersonalPhoneNo1").val()+"-"+$("#txtPersonalPhoneNo2").val());
            		if(txtPersonalPhoneNo!=''){
            			$("#txtPersonalPhoneNo").val($("#txtPersonalPhoneNo").val()+"-"+txtPersonalPhoneNo);	
            		}
            		$("#txtPersonalMobileNo").val($("#txtPersonalMobileNo1").val()+"-"+txtPersonalMobileNo);
            		$('[name="frmUser"]').submit();
                	return disableBtn(vbool);
            	}
            	return vbool;
            }
            
            function checkDuplicateEmail() {
            	var tbool='';
            	var data = {};
            	var searchValue = $("#txtEmailId").val();
            	$.ajax({
            		type : "POST",
            		contentType : "application/json",
            		url : "${pageContext.servletContext.contextPath}/ajaxhit/common/user/isemailidexists/"+searchValue+"/",
            		data : data,
            		timeout : 100000,
            		async:false,
            		success : function(data) {
            			console.log("SUCCESS: ", data);
            			var obj = jQuery.parseJSON(data);
            			$.each(obj, function (key, value) {
            					if(value.isExists=='true'){
            						$("#verifyMail").html("<span style=\"color:red\">Email ID is already registered<\span>");
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
            	var tbool='';
            	var data = {};
            	var searchValue = $("#txtCommercialRegNo").val();
            	$.ajax({
            		type : "POST",
            		contentType : "application/json",
            		url : "${pageContext.servletContext.contextPath}/ajaxhit/common/user/iscompanyregnoexists/"+searchValue+"/department",
            		data : data,
            		timeout : 100000,
            		async:false,
            		success : function(data) {
            			console.log("SUCCESS: ", data);
            			var obj = jQuery.parseJSON(data);
            			$.each(obj, function (key, value) {
            					if(value.isExists=='true'){
            						$("#verifyCommercialRegNo").html("<span style=\"color:red\">Commercial Reg No. is already registered<\span>");
            						$("#verifyCommercialRegNo").show();
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
            	var tbool='';
            	var data = {};
            	var searchValue = $("#txtCompanyName").val();
            	$.ajax({
            		type : "POST",
            		contentType : "application/json",
            		url : "${pageContext.servletContext.contextPath}/ajaxhit/common/user/iscompanyexists/"+searchValue+"/department",
            		data : data,
            		timeout : 100000,
            		async:false,
            		success : function(data) {
            			console.log("SUCCESS: ", data);
            			var obj = jQuery.parseJSON(data);
            			$.each(obj, function (key, value) {
            					if(value.isExists=='true'){
            						$("#verifyCompany").html("<span style=\"color:red\">Company is already registered<\span>");
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
            
            function validatePostalAdd(){
            	if($("#addresssame").is(":checked")){
            		$("#txtPostalAddressLine1").val($("#txtaAddress").val());
            		$("#txtPostalAddressLine2").val($("#txtaAddressLine2").val());
            		$("#txtPostalCity").val($("#txtCity").val());
            		$("#selPostalStateId").val($("#selState").val());
            		
            	}
            }
            
            function getState(){
            var countryId = $("#selOriginCountryId").val();
            if(countryId != ""){
            	$.ajax({
        		contentType : "application/json",
        		url : "${pageContext.servletContext.contextPath}/common/user/getstatebycountry/"+countryId,
        		dataType: "json",
        		async:false,
        		success : function(data) {
        			$("#selState option").not(":first").remove();
        			for(var i = 0; i <data.length;i++){
        				$("#selState").append("<option value='"+data[i][0]+"'>"+data[i][1]+"</option>")
        			}
        			
        			$("#selPostalStateId option").not(":first").remove();
        			for(var i = 0; i <data.length;i++){
        				$("#selPostalStateId").append("<option value='"+data[i][0]+"'>"+data[i][1]+"</option>")
        			}
        		},
        		error : function(e) {
        			console.log("ERROR: ", e);
        		},
        	});
           }
         }
            $(document).ready(function(){
            	$(document).ready(function() {
            		$(".dateBox").each(function(){
    		       		$(this).datetimepicker({
    		       			format:'d-M-Y' ,
    		       			maxDate:'today'
    		       		});
    		       	});
           		});
            	
            	$("#selKeywords").select2({
            	    minimumInputLength: 3,
            	    ajax: {
            	        url: "${pageContext.servletContext.contextPath}/common/user/getCategoryData/3,4",
            	        dataType: 'json',
            	        type: "GET",
            	        quietMillis: 50,
            	        selectOnClose: true,
            	        data: function (term) {
            	            return  {
            	                term: term.term
            	            }
            	        },
            	        processResults: function (data, params) {
            	            return {
            	              results: $.map(data, function (item) {
            	                    return {
            	                        text: item[1], 
            	                        id: item[0],
            	                    }
            	                }),
            	            };
            	          },
            	    }
            	});
            });
            
           </script>
           <script src='https://www.google.com/recaptcha/api.js'></script>	
           <%@include file="./../includes/footer.jsp"%>