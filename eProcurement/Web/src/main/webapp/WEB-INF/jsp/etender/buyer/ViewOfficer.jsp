<%@include file="../../includes/head.jsp"%>
        <%@include file="../../includes/masterheader.jsp"%>
       
    <spring:message code="label_select" var="label_select"/>
    <spring:message code="label_timezone" var="label_timezone"/>
<div class="content-wrapper">
<section class="content-header">
</section>

<section class="content">
<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="box">
						<div class="box-header with-border">
	               						<h3 class="box-title"><spring:message code="lbl_officer_profile"/> </h3>											
						</div>
						<div class="box-body">
							<div class="row">	
		               					<spring:url value="/common/user/adduser" var="submitUser"/>
								<div class="col-lg-12 col-md-12 col-xs-12">
									<form:form action="${submitUser}" onsubmit="return validate();" name="frmUser" method="post"  >
									<input type="hidden" name="hdOptType" value="${optType}"/>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Organization</div>
										</div>
										<div class="col-lg-5">
												${grandParentDeptName}
										</div>
										</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Location/Department:</div>
										</div>
										<div class="col-lg-5">
											${parentDeptName}
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
												<div class="form_filed">Sub department:</div>
										</div>
										<div class="col-lg-5">
										${subDeptName}
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Designation</div>
										</div>
										<div class="col-lg-5">
											${designation}	
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Email ID</div>
										</div>
										<div class="col-lg-5">
											${officerDtl[3]}
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Person name</div>
										</div>
										<div class="col-lg-5">
											${officerDtl[0]}
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Address<span style="color: red"></span></div>
										</div>
										<div class="col-lg-5">
											${officerDtl[12]}
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Country</div>
										</div>
										<div class="col-lg-5">
											${country}	
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">State</div>
										</div>
										<div class="col-lg-5">
											${state}	
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">City.</div>
											
										</div>
										<div class="col-lg-5">
											${officerDtl[11]}
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Phone No.</div>
										</div>
										<div class="col-lg-5">
											${officerDtl[2]}
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Mobile No.</div>
										</div>
										<div class="col-lg-5">
											${officerDtl[1]}
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">${label_timezone}</div>
										</div>
										<div class="col-lg-5">
											${timeZone}
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
  
<%@include file="../../includes/footer.jsp"%>