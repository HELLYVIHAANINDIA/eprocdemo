<%@include file="../../includes/head.jsp"%>
<c:choose>
	<c:when test="${optType eq 'Edit'}">
				<%@include file="../../includes/masterheader.jsp"%>	
	</c:when>
	<c:otherwise>
		<%@include file="./../../includes/headerWithoutLogin.jsp"%>
	</c:otherwise>
</c:choose>

<spring:message code="lbl_create_user" var="createuser" />
<spring:message code="default_country" var="default_country" />
<spring:message code="default_tinezone" var="default_tinezone" />
<spring:message code="default_offsettime" var="default_offsettime" />

<!-- <div class="content-wrapper"> -->
		<c:choose>
			<c:when test="${optType eq 'Edit'}">
				<c:set var="divClassName" value="content-wrapper"/>
			</c:when>
			<c:otherwise>
				<c:set var="divClassName" value="content-wrapper"/>
			</c:otherwise>
		</c:choose>


		<spring:message code="label_select" var="label_select" />
		<div class="${divClassName}">

			<!-- <section class="content-header"> -->
			<!-- </section> -->

			<section class="content">
			<div class="row">
				<div class="col-xs-12">
							<c:if test="${not empty param.message}">
								<div class="alert alert-success">${param.message}</div>
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
						</div>
				<div class="row">
				
					<div class="col-xs-12">
						<div class="bg-white">
							<!-- 							<div class="box-header with-border"> -->
							<%-- 								<c:choose> --%>
							<%-- 									<c:when test="${optType eq 'Edit'}"> --%>
							<%-- 										<spring:message code="lbl_edit_user" var="edituser" /> --%>
							<%-- 										<a href="${pageContext.servletContext.contextPath}/etender/bidder/bidderTenderListing"><< Go bidder</a><br> --%>
							<!-- 										<h3 class="box-title">Edit bidder</h3> -->
							<%-- 									</c:when> --%>
							<%-- 									<c:otherwise> --%>
							<%-- 										<spring:message code="lbl_create_user" var="createuser" /> --%>
							<!-- 										<h3 class="box-title"> -->
							<%-- 											<spring:message code="lbl_bidder_regestration" /> --%>
							<!-- 										</h3> -->
							<%-- 									</c:otherwise> --%>
							<%-- 								</c:choose> --%>
							<%-- <%-- 								<a href="${pageContext.servletContext.contextPath}/login" --%>
							<!-- <!-- 									class="goBack pull-right noExport"><< Go Back To Login</a> -->
							<!-- 							</div> -->
							<div class="col-xs-12 col-md-12  col-lg-12 padd-center pull-left register-layout-left">
								<!-- <c:if test="${empty sessionScope}">
									<spring:message code="lbl_date_time" /><div id="dispalyDateTime"></div> ${default_offsettime} GMT
								</c:if>-->
								<c:choose>	
										<c:when test="${optType ne 'Edit'}">
												<h1 class="ch-heading"><spring:message code="lbl_eTender_registration"/></h1>
												<h2 class="ch-heading-small"><spring:message code="lbl_company_information"/> </h2>
										</c:when>
									    <c:otherwise>
												<h1 class="font-30 txt-bgi-blue">Edit Profile</h1>
										</c:otherwise>
								</c:choose>
								
								<spring:url value="/common/user/addbidder" var="submitUser" />
								<form action="${submitUser}" name="frmUser" id="registerFrm" method="post">
									<div class="nav-tabs-custom">
									
										<!--<ul class="nav nav-tabs">
											<li class="active"><a href="#tab_1" data-toggle="tab" id="tab1">1</a></li>
											<li><a href="#tab_2" data-toggle="tab" id="tab2">2</a></li>
										</ul>-->
										
										<div class="tab-content pull-left">
											<div class="tab-pane active pull-left" id="tab_1">
												<c:if test="${optType ne 'Edit'}">
												<h3 class="ch-heading-small"><spring:message code="lbl_register_as"/></h3>
												</c:if>
												<div class="form-group">
														<c:choose>
															<c:when test="${optType ne 'Edit'}">
																	<label class="font-18 txt-gray-3 mar-right-30">
																		<input type="radio" name="r3" id="tOfficer" value="1"  class="flat-blue" checked>
																		<spring:message code="lbl_tender_authority"/>
																	</label>
																	<label class="font-18 txt-gray-3">
																		<input type="radio" name="r3" id="tBidder" value="2"  class="flat-blue">
																		<spring:message code="lbl_bidder"/>
																	</label>
															</c:when>
															<c:otherwise>
																	
															</c:otherwise>
														</c:choose>
												</div>
												<!-- 												<div class="row">														 -->
												<!-- 													<div class="col-lg-5 col-md-5 col-sm-6 col-xs-12"> -->
												<!-- 														<font size="1" class="pull-right mandatory m-top2" -->
												<%-- 															style="font-size: 15px; line-height: 40px;"> <spring:message --%>
												<%-- 																code="msg_mandatoryFields" /></font> --%>
												 <input type="hidden" 	name="hdOptType" value="${optType}" /> 
												<input	type="hidden" name="bidderDocId" value="${childId}" /> 
												<!-- 													</div> -->
												<!-- 												</div> -->
												<div id="companyInfo">
													<div class="row">
														
														
														
														<div class="col-lg-6">
															<div class="form-group">
																<div class="input-group">
																	<div class="input-group-addon">
																		<i class="epro icon-country font-20 txt-gray-c"></i>
																	</div>
																	
																	<c:choose>
																		<c:when test="${optType eq 'Edit'}">
									               						<input type="hidden"
																				name="selOriginCountryId" value="${bidderDtls[20]}" />
																		<select class="form-control" id="selOriginCountryId" disabled="disabled"
																				name="selOriginCountryIdDisabled" isrequired="true"
																				onchange="if(validateCombo(this)){getState()}"
																				title="${lbl_origin_company}">
																			</select>
																		</c:when>
																		<c:otherwise>
																			<select class="form-control" id="selOriginCountryId"
																				name="selOriginCountryId" isrequired="true"
																				onchange="if(validateCombo(this)){getState()}"
																				title="${lbl_origin_company}">
																			</select>
																		</c:otherwise>
																	</c:choose>
																</div>
															</div>
														</div>
													</div>
													<div class="row">
														<!-- 															<div class="col-lg-2"> -->
														<!-- 																<div class="form_filed" data-toggle="tooltip" -->
														<!-- 																	data-placement="top" data-original-title=""> -->
														<!-- 																	${col_tender_company}<span style="color: red">*</span> -->
														<!-- 																</div> -->
														<!-- 															</div> -->
														<div class="col-lg-12">
															<div class="form-group">
																<div class="input-group">
																	<div class="input-group-addon">
																		<i class="epro icon-company font-20 txt-gray-c"></i>
																	</div>
																	<spring:message code="col_tender_company" var="col_tender_company"/>
																	<c:choose>
																		<c:when test="${optType eq 'Edit'}">
																				<input type="hidden" name="txtCompanyName"
																				value="${bidderDtls[2]}" />
																				<input id="txtCompanyNameDisabled" value="${bidderDtls[2]}" disabled="disabled"
																				onblur="javascript:{if(validateTextComponent(this)){checkDuplicateCompany();}}"
																				class="form-control" name="txtCompanyName"
																				validarr="required@@alphanumspecial@@length:3,200"
																				tovalid="true" onblur="validateTextComponent(this)"
																				title="${col_tender_company}"
																				validationmsg="Allows min 3 and max. 200 characters and special character (',- , .,space)"
																				onfocus="javascript:{$('#verifyCompany').html('');}"
																				type="text" placeholder="${col_tender_company}">
																		</c:when>
																		<c:otherwise>
																			<input id="txtCompanyName"
																				onblur="javascript:{if(validateTextComponent(this)){checkDuplicateCompany();}}"
																				class="form-control" name="txtCompanyName"
																				validarr="required@@alphanumspecial@@length:3,200"
																				tovalid="true" onblur="validateTextComponent(this)"
																				title="${col_tender_company}"
																				validationmsg="Allows min 3 and max. 200 characters and special character (',- , .,space)"
																				onfocus="javascript:{$('#verifyCompany').html('');}"
																				type="text" placeholder="${col_tender_company}">
																		</c:otherwise>
																	</c:choose>
																</div>
																<span id="verifyCompany"
																	style="display: block; color: red"></span>
															</div>
														</div>
													</div>
													<div class="row">
														<div class="col-lg-6">
															<div class="form-group">
																<div class="input-group">
																	<div class="input-group-addon">
																		<i class="epro icon-guide-01 font-20 txt-gray-c"></i>
																	</div>
																	<spring:message code="lbl_commercial_registration" var="lbl_commercial_registration"/>
																	<c:choose>
																		<c:when test="${optType eq 'Edit'}">
																			<input type="hidden" name="txtCommercialRegNo"
																				value="${bidderDtls[21]}" />
																			<input id="txtCommercialRegNo" value="${bidderDtls[21]}" disabled="disabled"
																				onblur="javascript:{if(validateTextComponent(this)){checkCommercialRegNo();}}"
																				class="form-control"
																				onfocus="javascript:{$('#verifyCommercialRegNo').html('');}"
																				name="txtCommercialRegNoDisabled"
																				validarr="required@@alphanumspecial@@length:3,200"
																				tovalid="true" onblur="validateTextComponent(this)"
																				title="${lbl_commercial_registration}"
																				validationmsg="Allows min 3 and max. 200 characters"
																				type="text"
																				placeholder="${lbl_commercial_registration}">
																		</c:when>
																		<c:otherwise>
																			<input id="txtCommercialRegNo"
																				onblur="javascript:{if(validateTextComponent(this)){checkCommercialRegNo();}}"
																				class="form-control"
																				onfocus="javascript:{$('#verifyCommercialRegNo').html('');}"
																				name="txtCommercialRegNo"
																				validarr="required@@alphanumspecial@@length:3,200"
																				tovalid="true" onblur="validateTextComponent(this)"
																				title="${lbl_commercial_registration}"
																				validationmsg="Allows min 3 and max. 200 characters"
																				type="text"
																				placeholder="${lbl_commercial_registration}">
																			<span id="verifyCommercialRegNo"
																				style="display: block; color: red"></span>
																		</c:otherwise>
																	</c:choose>
																</div>
															</div>
														</div>
														<div class="col-lg-6">
															<div class="form-group">
																<div class="input-group">
																	<div class="input-group-addon">
																		<i class="fa fa-fw fa-calendar font-20 txt-gray-c"></i>
																	</div>
																	<spring:message code="lbl_date_establishment" var="lbl_date_establishment"/>
																	<c:choose>
																		<c:when test="${optType eq 'Edit'}">
																			<%-- 													${fn:split(establishDate, ' ')[0]} --%>
																			<input type="text" class="form-control dateBox"
																				disabled="disabled"
																				value="${fn:split(establishDate, ' ')[0]}"
																				name="txtEstablishDate" datepicker="yes"
																				id="txtEstablishDate"
																				placeholder="${client_dateformate_hhmm}"
																				dtrequired="true" title="${lbl_date_establishment}"
																				onblur="validateEmptyDt(this)">

																		</c:when>
																		<c:otherwise>
																			<input type="text" class="form-control dateBox"
																				name="txtEstablishDate" datepicker="yes"
																				id="txtEstablishDate" readonly="readonly"
																				placeholder="${lbl_date_establishment}"
																				dtrequired="true" title="${lbl_date_establishment}"
																				onblur="validateEmptyDt(this)">
																		</c:otherwise>
																	</c:choose>
																</div>
															</div>
														</div>
													</div>
													<div class="row">
														<div class="col-lg-12">
															<div class="form-group">
																<div class="input-group">
																	<div class="input-group-addon">
																		<i class="fa fa-briefcase font-20 txt-gray-c"
																			aria-hidden="true"></i>
																	</div>
																	<c:choose>
																		<c:when test="${optType eq 'Edit'}">
																			<select class="form-control" id="selBidderSector"
																				name="selBidderSector" isrequired="true"
																				onblur="validateCombo(this)"
																				title="Sector" validationmsg="Please select atleast 1 Sector"
																				multiple="multiple">
																			</select>
																		</c:when>
																		<c:otherwise>
																			<select class="form-control" id="selBidderSector"
																				name="selBidderSector" isrequired="true"
																				onblur="validateCombo(this)"
																				placeholder="Sector" validationmsg="Please select atleast 1 Sector"
																				title="Sector"
																				multiple="multiple">
																			</select>
																		</c:otherwise>
																	</c:choose>
																</div>
															</div>
														</div>
													</div>
													<div class="row">
														<div class="col-lg-6">
															<div class="form-group">
																<div class="input-group">
																	<div class="input-group-addon">
																		<i class="epro icon-address font-20 txt-gray-c"></i>
																	</div>
																	<c:choose>
																		<c:when test="${optType eq 'Edit'}">
																			<textarea id="txtaAddress" class="form-control"
																					name="txtaAddress" validarr="required@@length:0,500"
																					tovalid="true" onblur="if(validateTextComponent(this)){validatePostalAdd()}"
																					title="Office Address Line 1"
																					validationmsg="Allows max. 500 characters and special character (',- , .,space)">${bidderDtls[3]}</textarea>
																		</c:when>
																		<c:otherwise>
																			<textarea id="txtaAddress" class="form-control"
																					name="txtaAddress" validarr="required@@length:0,500"
																					tovalid="true" onblur="if(validateTextComponent(this)){validatePostalAdd()}"
																					title="Office Address Line 1"
																					placeholder="Office Address Line 1"
																					validationmsg="Allows max. 500 characters and special character (',- , .,space)"></textarea>
																		</c:otherwise>
																	</c:choose>
																</div>
															</div>
														</div>
														<div class="col-lg-6">
															<div class="form-group">
																<div class="input-group">
																	<div class="input-group-addon">
																		<i class="epro icon-address font-20 txt-gray-c"></i>
																	</div>
																	<c:choose>
																		<c:when test="${optType eq 'Edit'}">
																			<textarea id="txtaAddressLine2" class="form-control"
																					name="txtaAddressLine2" validarr="required@@length:0,500"
																					tovalid="true" onblur="if(validateTextComponent(this)){validatePostalAdd()}"
																					title="Office Address Line 2"
																					placeholder="Office Address Line 2"
																					validationmsg="Allows max. 500 characters and special character (',- , .,space)">${bidderDtls[19]}</textarea>
																		</c:when>
																		<c:otherwise>
																			<textarea id="txtaAddressLine2" class="form-control"
																					name="txtaAddressLine2" validarr="required@@length:0,500"
																					tovalid="true" onblur="if(validateTextComponent(this)){validatePostalAdd()}"
																					title="Office Address Line 2"
																					placeholder="Office Address Line 2"
																					validationmsg="Allows max. 500 characters and special character (',- , .,space)"></textarea>
																		</c:otherwise>
																	</c:choose>
																</div>
															</div>
														</div>
													</div>
													<%-- <div class="row" style="display: none">
														<div class="col-lg-6">
															<div class="form-group">
																<div class="input-group">
																	<div class="input-group-addon">
																		<i class="epro icon-country font-20 txt-gray-c"></i>
																	</div>
																	<c:choose>
																		<c:when test="${optType eq 'Edit'}">
																			<select class="form-control" id="selCountry"
																				value="${bidderDtls[9]}" name="selCountry"
																				isrequired="true"
																				onchange="if(validateCombo(this)){getState()}"
																				title="Country">
																			</select>
																		</c:when>
																		<c:otherwise>
																			<select class="form-control" id="selCountry"
																				name="selCountry" isrequired="true"
																				onchange="if(validateCombo(this)){getState()}"
																				title="Country">
																			</select>
																		</c:otherwise>
																	</c:choose>
																</div>
															</div>
														</div>
													</div> --%>
													<div class="row">
														<div class="col-lg-6">
															<div class="form-group">
																<div class="input-group">
																	<div class="input-group-addon">
																		<i class="epro icon-country font-20 txt-gray-c"></i>
																	</div>
																	<spring:message code="lbl_state" var="lbl_state"/>
																	<c:choose>
																		<c:when test="${optType eq 'Edit'}">
																			<select class="form-control" id="selState"
																					name="selState" selected="${bidderDtls[8]}"
																					isrequired="true" onchange="if(validateCombo(this)){validatePostalAdd()}"
																					placeholder="State"
																					title="State">
																					<option value="">Select</option>
																			</select>
																		</c:when>
																		<c:otherwise>
																			<select class="form-control" id="selState"
																					name="selState" isrequired="true"
																					placeholder="State"
																					onchange="if(validateCombo(this)){validatePostalAdd()}" title="State">
																					<option value="">Select</option>
																				</select>
																		</c:otherwise>
																	</c:choose>
																</div>
															</div>
														</div>

														<div class="col-lg-6">
															<div class="form-group">
																<div class="input-group">
																	<div class="input-group-addon">
																		<i class="epro icon-country font-20 txt-gray-c"></i>
																	</div>
																	<c:choose>
																		<c:when test="${optType eq 'Edit'}">
																			<input id="txtCity" value="${bidderDtls[4]}"
																					class="form-control" name="txtCity"
																					validarr="required@@alphabet@@length:0,20" tovalid="true"
																					placeholder="City"
																					onblur="if(validateTextComponent(this)){validatePostalAdd()}" title="City"
																					type="text">
																		</c:when>
																		<c:otherwise>
																			<input id="txtCity" class="form-control" name="txtCity"
																					validarr="required@@alphabet@@length:0,20" tovalid="true"
																					placeholder="City" 
																					onblur="if(validateTextComponent(this)){validatePostalAdd()}" title="City"
																					type="text">
																		</c:otherwise>
																	</c:choose>
																</div>
															</div>
														</div>
													</div>
													<div class="row">
														<div class="col-lg-12">
															<div class="form-group">
																<div class="checkbox">
																	<label class="font-18 txt-dark-blue"> <input
																		type="checkbox" id="addresssame" onclick="validatePostalAdd()" class="flat-blue" />
																		Check this if Postal Address is same as Office Address
																	</label>
																</div>
															</div>
														</div>
													</div>

													<div id="postalDetail">
														<div class="row">
															<div class="col-lg-6">
																<div class="form-group">
																	<div class="input-group">
																		<div class="input-group-addon">
																			<i class="epro icon-address font-20 txt-gray-c"></i>
																		</div>
																		<c:choose>
																			<c:when test="${optType eq 'Edit'}">
																				<textarea id="txtPostalAddressLine1"
																						class="form-control" name="txtPostalAddressLine1"
 																						validarr="required@@length:0,500" tovalid="true" 
																						onblur="validateTextComponent(this)"
																						title="Postal address line 1"
																						placeholder="Postal address line 1"
																						validationmsg="Allows max. 500 characters and special character (',- , .,space)">${bidderDtls[23]}</textarea>
																			</c:when>
																			<c:otherwise>
																				<textarea id="txtPostalAddressLine1"
																						class="form-control" name="txtPostalAddressLine1"
																						validarr="required@@length:0,500" tovalid="true"
																						onblur="validateTextComponent(this)"
																						title="Postal address line 1"
																						placeholder="Postal address line 1"
																						validationmsg="Allows max. 500 characters and special character (',- , .,space)"></textarea>
																			</c:otherwise>
																		</c:choose>
																	</div>
																</div>
															</div>

															<div class="col-lg-6">
																<div class="form-group">
																	<div class="input-group">
																		<div class="input-group-addon">
																			<i class="epro icon-address font-20 txt-gray-c"></i>
																		</div>
																		<spring:message code="lbl_postal_address_line2" var="lbl_postal_address_line2"/>
																		<c:choose>
																			<c:when test="${optType eq 'Edit'}">
																				<textarea id="txtPostalAddressLine2"
																						class="form-control" name="txtPostalAddressLine2"
																						validarr="length:0,500" tovalid="true"
																						onblur="validateTextComponent(this)"
																						title="${lbl_postal_address_line2}"
																						placeholder="${lbl_postal_address_line2}"
																						validationmsg="Allows max. 500 characters and special character (',- , .,space)">${bidderDtls[24]}</textarea>
																			</c:when>
																			<c:otherwise>
																				<textarea id="txtPostalAddressLine2"
																						class="form-control" name="txtPostalAddressLine2"
																						validarr="length:0,500" tovalid="true"
																						onblur="validateTextComponent(this)"
																						title="${lbl_postal_address_line2}"
																						placeholder="${lbl_postal_address_line2}"
																						validationmsg="Allows max. 500 characters and special character (',- , .,space)"></textarea>
																			</c:otherwise>
																		</c:choose>
																	</div>
																</div>
															</div>
														</div>

														<div class="row">
															<div class="col-lg-6">
																<div class="form-group">
																	<div class="input-group">
																		<div class="input-group-addon">
																			<i class="epro icon-country font-20 txt-gray-c"></i>
																		</div>
																		<c:choose>
																			<c:when test="${optType eq 'Edit'}">
																				<select class="form-control" id="selPostalStateId"
																					selected="${bidderDtls[31]}"
																					name="selPostalStateId" isrequired="true"
																					onchange="validateCombo(this)" placeholder="State"
																					title="State">
																					<option value="">Select</option>
																				</select>
																			</c:when>
																			<c:otherwise>
																				<select class="form-control" id="selPostalStateId"
																					name="selPostalStateId" isrequired="true"
																					placeholder="State" onchange="validateCombo(this)"
																					title="State">
																					<option value="">Select</option>
																				</select>
																			</c:otherwise>
																		</c:choose>
																	</div>
																</div>
															</div>
															<div class="col-lg-6">
																<div class="form-group">
																	<div class="input-group">
																		<div class="input-group-addon">
																			<i class="epro icon-country font-20 txt-gray-c"></i>
																		</div>
																		<c:choose>
																			<c:when test="${optType eq 'Edit'}">
																				<input id="txtPostalCity" value="${bidderDtls[4]}"
																					class="form-control" name="txtPostalCity"
																					validarr="alphabet@@length:0,20" tovalid="false"
																					onblur="validateTextComponent(this)" title="City"
																					placeholder="City" type="text">
																			</c:when>
																			<c:otherwise>
																				<input id="txtPostalCity" class="form-control"
																					name="txtPostalCity" validarr="alphabet@@length:0,20"
																					placeholder="City" tovalid="false"
																					onblur="validateTextComponent(this)" title="City"
																					type="text">
																			</c:otherwise>
																		</c:choose>
																	</div>
																</div>
															</div>
														</div>
													</div>

													<div class="row">
														<div class="col-lg-6">
															<div class="form-group">
																<div class="input-group">
																	<c:choose>
																		<c:when test="${optType eq 'Edit'}">
																			<c:if test="${fn:contains(bidderDtls[5], '-')}">
																				<c:set var="tmpPhone"
																					value="${fn:split(bidderDtls[5], '-')}" />

																				<input id="txtPhoneNo1" value="${tmpPhone[0]}"
																					class="form-control code" placeholder="Code"
																					name="txtPhoneNo1"
																					validarr="required@@length:0,4@@phoneno"
																					tovalid="true" onblur="validateTextComponent(this)"
																					title="Country Code" maxlength="4"
																					validationmsg="Allows max. 4 numbers and special characters (-,+)"
																					type="text">
																			
																				<input id="txtPhoneNo2" value="${tmpPhone[1]}"
																					class="form-control land" placeholder="Landline."
																					name="txtPhoneNo2"
																					validarr="required@@length:0,20@@phoneno"
																					tovalid="true" onblur="validateTextComponent(this)"
																					title="Phone No." maxlength="20"
																					validationmsg="Allows max. 20 numbers (0 to 9)" type="text">
																				
																				<input id="txtPhoneNo"
																					value="${tmpPhone[2]}" placeholder="Ext."
																					class="form-control ext"
																					name="txtPhoneNo" validarr="length:0,5@@phoneno"
																					tovalid="false" onblur="validateTextComponent(this)"
																					title="Ext." maxlength="4"
																					validationmsg="Allows max. 4 numbers" type="text">																					
																			</c:if>
																		</c:when>
																		<c:otherwise>
																			<input id="txtPhoneNo1" class="form-control code"
																				placeholder="Code" 
																				name="txtPhoneNo1"
																				validarr="required@@length:0,4@@phoneno" maxlength="4"
																				tovalid="true" onblur="validateTextComponent(this)"
																				title="Country Code"
																				validationmsg="Allows max. 4 numbers and special characters (-,+)"
																				type="text">

																			<input id="txtPhoneNo2" class="form-control land"
																				placeholder="Landline No."
																				name="txtPhoneNo2"
																				validarr="required@@length:0,20@@phoneno"
																				maxlength="20" tovalid="true"
																				onblur="validateTextComponent(this)" title="Landline No."
																				validationmsg="Allows max. 20 numbers (0 to 9)" type="text">

																			<input id="txtPhoneNo" class="form-control ext"
																				placeholder="Ext." maxlength="4"
																				name="txtPhoneNo"
																				validarr="length:0,5@@phoneno" tovalid="false"
																				onblur="validateTextComponent(this)"
																				title="Ext."
																				validationmsg="Allows max. 5 numbers and special characters (-,+)"
																				type="text">
																		</c:otherwise>
																	</c:choose>
																</div>
															</div>
														</div>
														<div class="col-lg-6">
															<div class="form-group">
																<div class="input-group">
																	<div class="input-group-addon">
																		<i class="epro icon-web font-20 txt-gray-c"></i>
																	</div>
																	<c:choose>
																		<c:when test="${optType eq 'Edit'}">
																			<input id="txtWebsite" value="${bidderDtls[7]}"
																				class="form-control" name="txtWebsite"
																				validarr="website" tovalid="true"
																				onblur="validateTextComponent(this)" maxlength="50" title="Website"
																				type="text">
																		</c:when>
																		<c:otherwise>
																			<input id="txtWebsite" class="form-control"
																				name="txtWebsite" validarr="website" tovalid="true"
																				placeholder="Website"
																				onblur="validateTextComponent(this)"  maxlength="50" title="Website"
																				type="text">
																		</c:otherwise>
																	</c:choose>
																</div>
															</div>
														</div>
													</div>

													<div class="row" style="display: none">
														<div class="col-lg-2">
															<div class="form_filed">
																Mobile no.<span style="color: red">*</span>
															</div>

														</div>
														<div class="col-lg-5">
															<c:choose>
																<c:when test="${optType eq 'Edit'}">
																	<input id="txtMobileNo" value="${bidderDtls[6]}"
																		class="form-control" name="txtMobileNo" maxlength="20"
																		validarr="length:0,20@@phoneno" tovalid="true" placeholder="Mobile No."
																		onblur="validateTextComponent(this)" title="Mobile No."
																		validationmsg="Allows max 20 number (0 to 9)"
																		type="text">
																</c:when>
																<c:otherwise>
																	<input id="txtMobileNo" maxlength="20"
																		class="form-control" name="txtMobileNo"
																		validarr="length:0,20@@phoneno" tovalid="true"
																		onblur="validateTextComponent(this)" title="Mobile No."
																		placeholder="Mobile No."
																		validationmsg="Allows max 20 number (0 to 9)"
																		type="text">
																</c:otherwise>
															</c:choose>
														</div>
													</div>
													<div class="row">
														<div class="col-lg-12">
															<a href="#tab_2" data-toggle="tab" title="Next" class="pull-right nxt">Next</a>
														</div>
													</div>
												</div>
											</div>
											<div class="tab-pane pull-left" id="tab_2">
												<div id="PersonalInfo">
													<div class="row mar-top-20">
													
														<div class="col-sm-12 col-xs-12">
														<a href="#tab_1" data-toggle="tab" class="pull-right nxt">Back</a>
														</div>
													
														<div class="col-lg-6">
															<div class="form-group">
																<div class="input-group">
																	<div class="input-group-addon">
																		<i class="epro icon-person font-20 txt-gray-c"></i>
																	</div>
																	<c:choose>
																		<c:when test="${optType eq 'Edit'}">
																			<input id="txtFullName" value="${bidderDtls[1]}"
																				class="form-control" name="txtFullName"
																				validarr="required@@fullname@@length:0,100"
																				tovalid="true" onblur="validateTextComponent(this)"
																				title="Contact Person Name"
																				placeholder="Contact Person Name"
																				validationmsg="Allows max. 100 characters and special character (',- , .,space)"
																				type="text">
																		</c:when>
																		<c:otherwise>
																			<input id="txtFullName" class="form-control"
																				name="txtFullName"
																				validarr="required@@fullname@@length:0,100"
																				tovalid="true" onblur="validateTextComponent(this)"
																				title="Contact Person Name"
																				placeholder="Contact Person Name"
																				validationmsg="Allows max. 100 characters and special character (',- , .,space)"
																				type="text">
																		</c:otherwise>
																	</c:choose>
																</div>
															</div>
														</div>
														<div class="col-lg-6">
															<div class="form-group">
																<div class="input-group">
																	<div class="input-group-addon">
																		<i class="epro icon-country font-20 txt-gray-c"></i>
																	</div>
																	<c:choose>
																		<c:when test="${optType eq 'Edit'}">
																			<input id="txtDesignationName"
																				value="${bidderDtls[27]}" class="form-control"
																				name="txtDesignationName"
																				validarr="required@@fullname@@length:0,100"
																				tovalid="true" onblur="validateTextComponent(this)"
																				title="Designation"
																				placeholder="Designation"
																				validationmsg="Allows max. 100 characters and special character (',- , .,space)"
																				type="text">
																		</c:when>
																		<c:otherwise>
																			<input id="txtDesignationName" class="form-control"
																				name="txtDesignationName"
																				validarr="required@@alphabet@@length:0,100" tovalid="true"
																				onblur="validateTextComponent(this)"
																				title="Designation" placeholder="Designation"
																				validationmsg="Allows max. 100 characters and special character (',- , .,space)"
																				type="text">
																		</c:otherwise>
																	</c:choose>
																</div>
															</div>
														</div>
													</div>

													<div class="row">
														<div class="col-lg-6">
															<div class="form-group">
																<div class="input-group">
																	<c:choose>
																		<c:when test="${optType eq 'Edit'}">
																			<c:if test="${fn:contains(bidderDtls[29], '-')}">
																				<c:set var="tmpPhone"
																					value="${fn:split(bidderDtls[29], '-')}" />
																				<div>
																					<input id="txtPersonalPhoneNo1"
																						name="txtPersonalPhoneNo1" value="${tmpPhone[0]}"
																						class="form-control code" placeholder="Code"
																						 name="txtPhoneNo1"
																						validarr="required@@length:0,4@@phoneno"
																						tovalid="true" onblur="validateTextComponent(this)"
																						title="Country Code" maxlength="4"
																						validationmsg="Allows max. 4 numbers and special characters (-,+)"
																						type="text">
																					<input id="txtPersonalPhoneNo2"
																						name="txtPersonalPhoneNo2" value="${tmpPhone[1]}"
																						class="form-control land" placeholder="Landline No."
																						name="txtPhoneNo2"
																						validarr="required@@length:0,20@@phoneno"
																						tovalid="true" onblur="validateTextComponent(this)"
																						title="Landline No." maxlength="20"
																						validationmsg="Allows max. 20 numbers (0 to 9)" type="text">
																						
																					<input
																						id="txtPersonalPhoneNo" name="txtPersonalPhoneNo"
																						value="${tmpPhone[2]}" placeholder="Ext."
																						class="form-control ext"
																						name="txtPhoneNo"
																						validarr="length:0,5@@phoneno" tovalid="false"
																						onblur="validateTextComponent(this)"
																						title="Ext." maxlength="4"
																						validationmsg="Allows max. 4 numbers" type="text">
																				</div>
																			</c:if>
																		</c:when>
																		<c:otherwise>
																			<div>
																			<input id="txtPersonalPhoneNo1" maxlength="4"
																					placeholder="Code" class="form-control code"																						
																					name="txtPersonalPhoneNo1"
																					validarr="required@@length:0,4@@phoneno"
																					tovalid="true" onblur="validateTextComponent(this)"
																					title="Country Code"
																					validationmsg="Allows max. 4 numbers and special characters (-,+)"
																					type="text">
																				<input id="txtPersonalPhoneNo2" maxlength="20"
																					placeholder="Landline No." class="form-control land"
																					name="txtPersonalPhoneNo2"
																					validarr="required@@length:0,20@@phoneno"
																					tovalid="true" onblur="validateTextComponent(this)"
																					title="Landline No."
																					validationmsg="Allows max. 20 numbers (0 to 9)" type="text">
																				<input id="txtPersonalPhoneNo" maxlength="4"
																					placeholder="Ext." class="form-control ext"
																					name="txtPersonalPhoneNo"
																					validarr="length:0,4@@phoneno" tovalid="false"
																					onblur="validateTextComponent(this)"
																					title="Ext."
																					validationmsg="Allows max. 4 numbers " type="text">
																			</div>
																		</c:otherwise>
																	</c:choose>
																</div>
															</div>
														</div>
														<div class="col-lg-6">
															<div class="form-group">
																<div class="input-group">
																	<c:choose>
																		<c:when test="${optType eq 'Edit'}">
																			<c:if test="${fn:contains(bidderDtls[28], '-')}">
																				<c:set var="tmpMob"
																					value="${fn:split(bidderDtls[28], '-')}" />
																			<input id="txtPersonalMobileNo1" class="form-control code"
																					value="${tmpMob[0]}"
																					name="txtPersonalMobileNo1"
																					validarr="required@@length:0,4@@phoneno"
																					maxlength="4" tovalid="true"
																					onblur="validateTextComponent(this)"
																					title="Country Code"
																					validationmsg="Allows max 4 Number" type="text">
																				<input id="txtPersonalMobileNo" class="form-control land"
																					value="${tmpMob[1]}"																						
																					name="txtPersonalMobileNo" maxlength="20"
																					validarr="required@@length:0,20@@phoneno"
																					tovalid="true" onblur="validateTextComponent(this)"
																					title="Mobile No." placeholder="Mobile No."
																					validationmsg="Allows max 20 number (0 to 9)"
																					type="text">
																			</c:if>
																		</c:when>
																		<c:otherwise>
																		<input id="txtPersonalMobileNo1" class="form-control code"
																			name="txtPersonalMobileNo1"
																			validarr="required@@length:0,4@@phoneno" maxlength="4"
																			tovalid="true" onblur="validateTextComponent(this)"
																			title="Country Code"
																			placeholder="Code" 
																			validationmsg="Allows max 4 Number" type="text">
																		<input id="txtPersonalMobileNo" class="form-control land"
																			style="width: 80%; float: left;margin-right: 0px;"
																			name="txtPersonalMobileNo" maxlength="20"
																			validarr="required@@length:0,20@@phoneno"
																			tovalid="true" onblur="validateTextComponent(this)"
																			title="Mobile No."
																			placeholder="Mobile No." 
																			validationmsg="Allows max 20 number (0 to 9)"
																			type="text">
																		</c:otherwise>
																	</c:choose>
																</div>
															</div>
														</div>
													</div>

													<div class="row">
														<div class="col-lg-6">
															<div class="form-group">
																<div class="input-group">
																	<div class="input-group-addon">
																		<i class="epro icon-mail font-20 txt-gray-c"></i>
																	</div>
																	<spring:message code="lbl_emailId" var="lbl_emailId"/>
																	<c:choose>
																		<c:when test="${optType eq 'Edit'}">
							               						${bidderDtls[0]}
																<input type="hidden" name="hdUserId"
																				value="${bidderDtls[12]}" />
																			<input type="hidden" name="txtEmailId"
																				value="${bidderDtls[0]}" />
																			<input type="hidden" name="hdBidderId"
																				value="${bidderId}" />
																		</c:when>
																		<c:otherwise>
																			<input class="form-control" id="txtEmailId"
																				name="txtEmailId" validarr="required@@email"
																				tovalid="true"
																				onblur="javascript:{if(validateTextComponent(this)){checkDuplicateEmail();}}"
																				title="${lbl_emailId}" placeholder="${lbl_emailId}"
																				onfocus="javascript:{$('#verifyMail').html('');}"
																				type="text">
																			<span id="verifyMail" style="display: block"></span>
																		</c:otherwise>
																	</c:choose>
																</div>
															</div>
														</div>
														<c:if test="${optType ne 'Edit'}">
															<div class="col-lg-6">
																<div class="form-group">
																	<div class="input-group">
																		<div class="input-group-addon">
																			<i class="epro icon-mail font-20 txt-gray-c"></i>
																		</div>
																		<spring:message code="msg_reenter_emailid" var="msg_reenter_emailid"/>
																		<spring:message code="lbl_confirm_emailid" var="lbl_confirm_emailid"/>
																		
																		<c:choose>
																			<c:when test="${optType eq 'Edit'}">
																				<input class="form-control" id="txtConfirmEmailId"
																					value="${bidderDtls[0]}" name="txtConfirmEmailId"
																					validarr="required@@email@@confirmemail:EmailId"
																					tovalid="true"
																					onblur="javascript:{if(validateTextComponent(this)){checkDuplicateEmail();}}"
																					title="${lbl_confirm_emailid}" validationmsg="${msg_reenter_emailid}"
																					placeholder="${lbl_confirm_emailid}"
																					onfocus="javascript:{$('#verifyMail').html('');}"
																					type="text">
																				<span id="verifyMail"
																					style="display: block; color: red"></span>
																			</c:when>
																			<c:otherwise>
																				<input class="form-control" id="txtConfirmEmailId"
																					name="txtConfirmEmailId"
																					validarr="required@@email@@confirmemail:EmailId"
																					tovalid="true"
																					onblur="javascript:{if(validateTextComponent(this)){checkDuplicateEmail();}}"
																					title="${lbl_confirm_emailid}" validationmsg="${msg_reenter_emailid}"
																					placeholder="${lbl_confirm_emailid}"
																					onfocus="javascript:{$('#verifyMail').html('');}"
																					type="text">
																				<span id="verifyMail" style="display: block"></span>
																			</c:otherwise>
																		</c:choose>
																	</div>
																</div>
															</div>
														</c:if>
													</div>

													<c:if test="${optType ne 'Edit' and false}">
														<div class="row">
															<div class="col-lg-2">
																<div class="form_filed">
																	Password<span style="color: red">*</span>
																</div>
															</div>
															<div class="col-lg-5">
																<div>

																	<c:choose>
																		<c:when test="${optType eq 'Edit'}">
																			<input id="txtPassword" value="${bidderDtls[13]}"
																				class="form-control" name="txtPassword"
																				validarr="required@@password@@checkloginidpwd:EmailId@@length:8,15"
																				tovalid="true" onblur="validateTextComponent(this)"
																				title="Password" " type="password">
																		</c:when>
																		<c:otherwise>
																			<input id="txtPassword" class="form-control"
																				name="txtPassword"
																				validarr="required@@password@@checkloginidpwd:EmailId@@length:8,15"
																				tovalid="true" onblur="validateTextComponent(this)"
																				title="Password" type="password">
																		</c:otherwise>
																	</c:choose>
																	<div class="nowrap">
																		(
																		<spring:message code="password_validation_msg" />
																		)
																	</div>
																</div>
															</div>
														</div>
														<div class="row">
															<div class="col-lg-2">
																<div class="form_filed">
																	Confirm password<span style="color: red">*</span>
																</div>

															</div>
															<div class="col-lg-5">
																<c:choose>
																	<c:when test="${optType eq 'Edit'}">
																		<input id="txtConfirmPassword"
																			value="${bidderDtls[13]}" class="form-control"
																			name="txtConfirmPassword"
																			validarr="required@@confirmpwd:Password"
																			tovalid="true" onblur="validateTextComponent(this)"
																			title="Confirm password" type="password">
																	</c:when>
																	<c:otherwise>
																		<input id="txtConfirmPassword" class="form-control"
																			name="txtConfirmPassword"
																			validarr="required@@confirmpwd:Password"
																			tovalid="true" onblur="validateTextComponent(this)"
																			title="Confirm password" type="password">
																	</c:otherwise>
																</c:choose>
															</div>
														</div>
													</c:if>

													<div class="row" style="display: none">
														<div class="col-lg-2">
															<div class="form_filed">
																Last name<span style="color: red">*</span>
															</div>
														</div>
														<div class="col-lg-5">
															<c:choose>
																<c:when test="${optType eq 'Edit'}">
																	<input id="txtLastName" value="${bidderDtls[1]}"
																		class="form-control" name="txtLastName"
																		validarr="fullname@@length:0,100" tovalid="true"
																		onblur="validateTextComponent(this)"
																		title="Person name" maxlength="100"
																		validationmsg="Allows max. 100 characters and special character (',- , .,space)"
																		type="text">
																</c:when>
																<c:otherwise>
																	<input id="txtLastName" class="form-control"
																		name="txtLastName" validarr="fullname@@length:0,100"
																		tovalid="true" onblur="validateTextComponent(this)"
																		title="Person name" maxlength="100"
																		validationmsg="Allows max. 100 characters and special character (',- , .,space)"
																		type="text">
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
																	<input id="txtMiddleName" value="${bidderDtls[1]}"
																		class="form-control" name="txtMiddleName"
																		validarr="fullname@@length:0,100" tovalid="true"
																		onblur="validateTextComponent(this)"
																		title="Person name" maxlength="100"
																		validationmsg="Allows max. 100 characters and special character (',- , .,space)"
																		type="text">
																</c:when>
																<c:otherwise>
																	<input id="txtMiddleName" class="form-control"
																		name="txtMiddleName" validarr="fullname@@length:0,100"
																		tovalid="true" onblur="validateTextComponent(this)"
																		title="Person name" maxlength="100"
																		validationmsg="Allows max. 100 characters and special character (',- , .,space)"
																		type="text">
																</c:otherwise>
															</c:choose>
														</div>
													</div>
													<div class="row">
														<div class="col-lg-6 keywordDiv">
															<div class="form-group">
																<div class="input-group">
																	<div class="input-group-addon">
																		<i class="epro icon-country font-20 txt-gray-c"></i>
																	</div>
																	<c:choose>
																		<c:when test="${optType eq 'Edit'}">
																			<!-- <select id="selKeywords" multiple="multiple" class="form-control" name="selKeywords"  tovalid="true" onchange="validateCombo(this)" title="Keywords" ></select> -->
																			<select id="selKeywords" class="form-control"
																				multiple="multiple" name="selKeywords"
																				title="keyword" placeholder="keyword"
																				onchange="validateCombo(this)">
																				<c:forEach items="${categoryList}" var="category">
																					<option selected="selected" value="${category[0]}">${category[1]}</option>
																				</c:forEach>

																			</select>
																		</c:when>
																		<c:otherwise>
																			<!-- <input id="txtKeywords" class="form-control" name="txtKeywords" validarr="length:3,300" tovalid="true" onblur="validateTextComponent(this)" title="Keywords"  type="text"> -->
																			<select id="selKeywords" class="form-control"
																				multiple="multiple" name="selKeywords"
																				title="keyword" placeholder="keyword"
																				onchange="validateCombo(this)"></select>
																		</c:otherwise>
																	</c:choose>
																</div>
																<input type="hidden" name="categoryText"
																	id="categoryText">
															</div>
														</div>

														<div class="col-lg-6">
															<div class="form-group">
																<div class="input-group">
																	<div class="input-group-addon">
																		<i class="epro icon-country font-20 txt-gray-c"></i>
																	</div>
																	<c:choose>
																		<c:when test="${optType eq 'Edit'}">
																			<select name="selTimezoneId" id="selTimezoneId"
																				isrequired="true" onchange="validateCombo(this)"
																				class="form-control" title="${label_timezone}">
																				<option value="">${label_select}</option>
																				<c:forEach items="${timezonelist}" var="timezone">
																					<c:set var="selected" value="" />
																					<c:if
																						test="${default_tinezone eq timezone.timezoneId or bidderDtls[15] eq timezone.timezoneId}">
																						<c:set var="selected" value="selected='selected'" />
																					</c:if>
																					<option value="${timezone.timezoneId}" ${selected}>${timezone.countryName}
																						(${timezone.utcOffset})</option>
																				</c:forEach>
																			</select>
																		</c:when>
																		<c:otherwise>
																			<select name="selTimezoneId" id="selTimezoneId"
																				isrequired="true" onchange="validateCombo(this)"
																				class="form-control" title="${label_timezone}">
																				<option value="">${label_select}</option>
																				<c:forEach items="${timezonelist}" var="timezone">
																					<c:set var="selected" value="" />
																					<c:if
																						test="${default_tinezone eq (timezone.timezoneId+'') }">
																						<c:set var="selected" value="selected='selected'" />
																					</c:if>
																					<option value="${timezone.timezoneId}" ${selected}>${timezone.countryName}
																						(${timezone.utcOffset})</option>
																				</c:forEach>
																			</select>
																		</c:otherwise>
																	</c:choose>
																</div>
															</div>
														</div>
													</div>
													<c:if test="${optType ne 'Edit'}">
														<h4 style="color: #006cb7;">
															Upload
															<spring:message code="fields_docName" />
														</h4>
														<%@include file="../buyer/UploadDocuments.jsp"%>
														<div class="row">															
															<div class="col-lg-12">
																<input type="checkbox" name="igree" id="iagree"
																	style="margin-right: 5px; float: left; margin-top: 5px;" />
																I agree to the terms & conditions and privacy policy of
																this website. <a href="javascript:" id="viewPrivacy"
																	onclick="javascript:showTargetDiv();">View privacy
																	policy</a>
																<div id="targetDiv" style="display: none">Here by
																	you agree all privacy policies and terms and conditions
																	of Cahoot technologies LTD</div>
																<div id="iAgreeError" style="color: red"></div>
															</div>
														</div>
														<div class="row">															
															<div class="col-lg-12">
																<div class="g-recaptcha"
																	data-sitekey="6Ld1eBIUAAAAAAH43IoWk1nmD-MMvcWaDYEQIO9o"
																	style="margin-top: 10px;"></div>
															</div>
														</div>	
														<div class="row">		
															<div class="col-lg-12">
															<!-- Dont use 'next' as class here, else after validation it will always redirect to second page -->
																<input type="submit" class="pull-right rgtr" value="Register" onclick="return bidderValidate();">
																
															</div>
														</div>
													</c:if>

													<div class="row">
													<c:if test="${optType eq 'Edit'}">
													<div class="row">		
															<div class="col-lg-12">
															<!-- Dont use 'next' as class here, else after validation it will always redirect to second page -->
																<input type="submit" class="pull-right btn btn-primary" value="Edit" onclick="return bidderValidate();">
																<a href="" data-toggle="tab" class="pull-right nxt">Back</a>
															</div>
														</div>
													</c:if>
													</div>
													</div>

												</div>

											</div>
										</div>
									</form>
									</div>
							</div>
							
							
								
								
							</div>
						</div></section>
					</div>
<!-- 				</div> -->
	<script
		src="${pageContext.servletContext.contextPath}/resources/iCheck/icheck.min.js"></script>
	<!-- AdminLTE App -->
	<script
		src="${pageContext.servletContext.contextPath}/resources/js/app.min.js"></script>

	<!-- Optionally, you can add Slimscroll and FastClick plugins.
             Both of these plugins are recommended to enhance the
             user experience. Slimscroll is required when using the
             fixed layout. -->
	<script>
			function validatePostalAdd(){
		    	if($("#addresssame").is(":checked")){
		    		$("#txtPostalAddressLine1").val($("#txtaAddress").val());
		    		$("#txtPostalAddressLine2").val($("#txtaAddressLine2").val());
		    		$("#txtPostalCity").val($("#txtCity").val());
		    		$("#selPostalStateId").val($("#selState").val());
		    		
		    	}
		    }
		
		    $('#addresssame').on('ifChecked', function (event){
		    	validatePostalAdd();
		    });
            $(function () {
                 //Flat red color scheme for iCheck
                $('input[type="checkbox"].flat-blue, input[type="radio"].flat-blue').iCheck({
                  checkboxClass: 'icheckbox_flat-blue',
                  radioClass: 'iradio_flat-blue'
                });
              });
              
            $( ".next" ).click(function() {
                $( "#tab2" ).click();
              });
           
            $( ".back" ).click(function() {
                $( "#tab1" ).click();
              });
        </script>
        <script type="text/javascript">
        var isDepartmentExists=false;
        var optType = '${optType}';
        var countryId ="";
        var stateId="";
        var postalStateId="";
        var selOriginCountryId="";
        var registerDocObjId=7;
        var registerType=1;
        var bidderSectorJson = '${bidderSector}';
        var bidderSectorJsonObj = jQuery.parseJSON(bidderSectorJson);
//         	var countryJson = '${countryJson}';
       		function  showTargetDiv(){
       			$("#targetDiv").show();
        	}
        	var obj = (${countryJson});
            $(document).ready(function() {
            	
	            	if(optType=='Edit'){
	    		       	countryId = '${bidderDtls[9]}';
	    	        	stateId = '${bidderDtls[8]}';
	    	        	postalStateId = '${bidderDtls[31]}'
	    	        	registerDocObjId=6;
	    	            registerType=2;
	    	        }else{
	    	        	tinezone = ${default_tinezone}
	    	        	countryId = ${default_country};
	    	        	selOriginCountryId = ${default_country};
	    	        }
            	
	            	$('#tOfficer').on('ifChanged', function (event){
	            		if(event.target.checked){
	            		registerType=1;
	            		registerDocObjId=7;
	            		}
	    	        });
	    	        $('#tBidder').on('ifChanged', function (event) {
	    	        	if(event.target.checked){
	    	        		registerType=2;
		    	        	registerDocObjId=6;	
	    	        	}
	    	        });
	            	
            	
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
    	    
				$('#selOriginCountryId').append(
    	     	$('<option>',
       	    		 {
       	    		    value: "",
       	    		    text : "Select"
       	    		}));
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
    	     	$("#selBidderSector").select2({
            		maximumSelectionLength: 5
            	}); 
    	     	if(optType=='Edit'){
	    	     	$('select[id="selCountry"] option:selected').attr("selected",null);
		   	     	$('select[id="selCountry"] option[value="'+countryId+'"]').attr("selected","selected");
		   	     	$('select[id="selOriginCountryId"] option:selected').prop("selected",false);
		   	     	$('select[id="selOriginCountryId"] option[value="'+selOriginCountryId+'"]').attr("selected","selected");
	    	     	getState();
	    	     	$('select[id="selState"] option:selected').attr("selected",null);
		   	     	$('select[id="selState"] option[value="'+stateId+'"]').attr("selected","selected");
		   	     	
		   	     	$('select[id="selPostalStateId"] option:selected').attr("selected",null);
		   	     	$('select[id="selPostalStateId"] option[value="'+postalStateId+'"]').attr("selected","selected");
		   	     	
		   	     	var tblBidderSector = ${bidderSector};
			     	$('select[id="selBidderSector"] option:selected').attr("selected",null);
			     	$.each(tblBidderSector, function( index, value ) {
						$('select[id="selBidderSector"] option[value="'+value+'"]').attr("selected","selected");
						});
		   	     	
    	     	}else{
    	     		$('select[id="selCountry"] option[value="'+countryId+'"]').attr("selected","selected");
    	     		//$('select[id="selOriginCountryId"] option[value="'+selOriginCountryId+'"]').attr("selected","selected");
    	     		getState();
    	     	}
    	     	registerDocObjId=7;
        	});
            function bidderValidate(){
            try{
            	if(registerType==2){
            		$('#registerFrm').attr('action','${pageContext.servletContext.contextPath}/common/user/addbidder');
            	}else{
            		$('#registerFrm').attr('action','${pageContext.servletContext.contextPath}/common/user/addOrganization');
            	}
            	
            	var vbool = true;
            	vbool = valOnSubmit();
            	vbool = true;
            	$('#iAgreeError').html('');
            	var keyword = $("#selKeywords").select2("data");
            	/*if(keyword.length <= 0){
            		var div = $('<div class="errselKeywords validationMsg clearfix">Please select keyword</div>')
        			$("#keywordDiv").append(div);
        			$("#selKeywords").focus();
            		vbool=false;
            	}else{
            		$(".errselKeywords").remove();
            	}*/
			
           	var doccount =	$("#doclstId").find("td").length;
			if(vbool && optType != 'Edit' && doccount <= 0){
           		vbool=false;
           		alert("Upload commercial registration certificate");
           	}
		
           	if(!$('#iagree').is(':checked')){
               	vbool=false;
               	$('#iAgreeError').html("Please agree terms & conditions");
               }
            	
            if(vbool){	
				if(vbool && keyword.length > 0){
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
        		}
            	
            		if(optType=='Edit'){
            			$("#txtEstablishDate").removeAttr("disabled");
            		}
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

            	}else{
            		try{
            		var idname = "";
            		var obj  ="";
	            		if($("#tab_1 .validationMsg").size() > 0){
	            			$("#tab1").click();
	            			$("#tab_1").addClass("active");
	            			obj = $("#tab_1 .validationMsg:first");
	            		}else if($("#tab_1 .validationMsg").size() > 0){
	            			$("#tab2").click();
	            			obj = $("#tab_2 .validationMsg:first");
	            			$("#tab_2").addClass("active");
	            		}
            			var className = $(obj).attr("class");
            			className = className.replace("validationMsg clearfix","");
            			className = className.replace("err","");
            			$("#"+className).focus();
            			return false;
            		}catch(e){console.log(e);}
            	}
           	}catch(e){ console.log(e);}
            	return false;
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
            						$("#verifyMail").html("<span style=\"color:red\">${lbl_emailId} is already registered<\span>");
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
            	var keyword = "department";
            	if(registerType==2){
            		keyword="bidder";
            	}
            	$.ajax({
            		type : "POST",
            		contentType : "application/json",
            		url : "${pageContext.servletContext.contextPath}/ajaxhit/common/user/iscompanyregnoexists/"+searchValue+"/"+keyword,
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
            	var keyword = "department";
            	if(registerType==2){
            		keyword="bidder";
            	}
            	$.ajax({
            		type : "POST",
            		contentType : "application/json",
            		url : "${pageContext.servletContext.contextPath}/ajaxhit/common/user/iscompanyexists/"+searchValue+"/"+keyword,
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
<script src="${pageContext.servletContext.contextPath}/resources/js/jQuery/jquery.datetimepicker.js"></script>
 <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/resources/css/jquery.datetimepicker.css">
<script src='https://www.google.com/recaptcha/api.js'></script>
<c:if test="${optType eq 'Edit'}">
<%@include file="../../includes/footer.jsp"%>
</c:if>
