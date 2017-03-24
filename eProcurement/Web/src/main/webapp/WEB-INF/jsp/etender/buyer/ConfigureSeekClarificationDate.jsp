<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <%@include file="../../includes/header.jsp"%>
        <%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
        <script src="${pageContext.servletContext.contextPath}/resources/js/commonValidate.js" type="text/javascript"></script>
		<script src="${pageContext.servletContext.contextPath}/resources/js/jQuery/jquery.datetimepicker.js"></script>
		<script src="${pageContext.servletContext.contextPath}/resources/js/blockUI.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/resources/js/commonListing.js"></script>
        <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/resources/css/jquery.datetimepicker.css">        
        <spring:message code="lbl_create_dept" var="createdepartment"/>
        <title>${createdepartment}</title>
        <script type="text/javascript">
        var VALIDATE_MSG_REQUIRED = 'Please enter';
        var VALIDATE_MSG_SELECT = 'Please select';
        var VALIDATE_MSG_ALLOW_MAX='Allows Max. ';
        var VALIDATE_MSG_TENDERBRIEF='characters';
        var isDepartmentExists=false;
        var grandParentDeptId='${grandParentDeptId}';
        	$(document).ready(function() {
        		$(".dateBox").each(function(){
		       		$(this).datetimepicker({
		       			format:'d-M-Y H:i',
		       		});
		       	});
       		});
            function validate(){
            	var vbool = valOnSubmit();
            	return disableBtn(vbool);
            }
           </script>
</head>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="../../includes/leftaccordion.jsp"%>

<div class="content-wrapper" style="height: auto;">

<section class="content-header">	
</section>

<section class="content">
	<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="box">
						<div class="box-header with-border">
							<c:choose>
	               					<c:when test="${optType eq 'edit'}">
	               					<spring:message code="lbl_edit_dept" var="editdepartment"/>
	               						<h3 class="box-title">${editdepartment}</h3>											
	               					</c:when>
	               					<c:otherwise>
	               						<h3 class="box-title">Configure Date</h3>
								</c:otherwise>
								</c:choose>
						</div>
						<div class="box-body">
						<a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}"><< Go To Tender Dashboard</a>
							<div class="row">
							<spring:url value="/etender/buyer/postConfigureDate" var="configureDateUrl"/>
								<div class="col-lg-12 col-md-12 col-xs-12">
									<form:form action="${configureDateUrl}" onsubmit="return validate();" name="frmdepartment" method="post"  >
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed"><label></label></div>
										</div>
										<div class="col-lg-5">
											
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed"><label>Response end date : <span> *</span></label></div>
										</div>
										<div class="col-lg-5">
											<input type="text" class="form-control dateBox" name="txtResponseEndDate" datepicker="yes" id="txtResponseEndDate"   dtrequired="true" title="Opening date" value="${clarificationList[1]}" onblur="validateEmptyDt(this)" >
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed"></div>
										</div>
										<div class="col-lg-5">
											<button type="submit" id="addDept"  class="btn btn-submit">Submit</button> 
                                                    <input type="hidden" name="TenderId" jsrequired="false" value="${tenderId}"/>
                                                    <input type="hidden" name="EnvelopeId" jsrequired="false" value="${envelopeId}"/>
                                                    <input type="hidden" name="BidderId" jsrequired="false" value="${bidderId}"/>
                                                    <input type="hidden" name="officerId" jsrequired="false" value="${officerId}"/>
                                                    <input type="hidden" name="EnvelopeType" jsrequired="false" value="${envelopeType}"/>
                                                    <input type="hidden" name="IsEvalDone" jsrequired="false" value="${isEvalDone}"/>
                                                    <c:if test="${operType eq 'Edit' or operType eq 'Reconfig'}">
                                                        <input type="hidden" name="ClarificationId" jsrequired="false" value="${clarificationList[0]}"/>
                                                        <input type="hidden" name="DateConfig" jsrequired="false" value="${operType}"/>
                                                    </c:if>
										</div>
									</div>
									</form:form>
								</div>
							</div>
						</div>
					<div class="box-body">
							<div class="row">
								<div class="col-lg-12 col-md-12 col-xs-12">
												<div id="listingDiv">
												</div>
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