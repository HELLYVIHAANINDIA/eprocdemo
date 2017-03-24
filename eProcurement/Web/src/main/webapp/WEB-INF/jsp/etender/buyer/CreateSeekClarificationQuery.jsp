<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <%@include file="../../includes/header.jsp"%>
        <%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
        <script src="${pageContext.servletContext.contextPath}/resources/js/commonValidate.js" type="text/javascript"></script>
		<script src="${pageContext.servletContext.contextPath}/resources/js/blockUI.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/resources/js/commonListing.js"></script>
        <script src="${pageContext.servletContext.contextPath}/resources/js/jQuery/jquery.datetimepicker.js"></script>
		<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/resources/css/jquery.datetimepicker.css">        
        <spring:message code="lbl_create_dept" var="createdepartment"/>
        <title>${createdepartment}</title>
        <script type="text/javascript">
        
        function validate(){
            $(".err").remove();
            var vbool = true;
            // Set this value to avoid validation of file upload
//             $("#txtDocDesc").val('tempvalue');
            if(!valOnSubmit()) {
                vbool = false;
            }
         	return disableBtn(vbool);

        }
        function setQuestionStatus(action){
                $("#txtQueryStatus").val(action);
                //alert($("#txtQueryStatus").val());
        }
        
        var VALIDATE_MSG_REQUIRED = 'Please enter';
        var VALIDATE_MSG_SELECT = 'Please select';
        var VALIDATE_MSG_ALLOW_MAX='Allows Max. ';
        var VALIDATE_MSG_TENDERBRIEF='characters';
        var isDepartmentExists=false;
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
	               						<h3 class="box-title">Post Query</h3>
						</div>
						<div class="box-body">
						<a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}"><< Go To Tender Dashboard</a>
							<div class="row">
							<spring:url value="/etender/buyer/postQuery" var="configureDateUrl"/>
								<div class="col-lg-12 col-md-12 col-xs-12">
									<form:form action="${configureDateUrl}" onsubmit="return validate();" name="frmdepartment" method="post">
									<div class="row">
										<div class="row">
										<div class="col-lg-2">
											<div class="form_filed"><label>Response end date : <span> *</span></label></div>
										</div>
										<div class="col-lg-5">
											${responseEndDate}
										</div>
									</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed"><label>Query<span> *</span><label></div>
										</div>
										<div class="col-lg-5">
											<div class="form_filed">
												<textarea name="txtaQuery" title="Post Question" isrequired="true" maxlength="1000" validation="length,alphanumwithnewchar"> </textarea>
											</div>
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
                                                    <input type="hidden" name="CompanyId" jsrequired="false" value="${bidderId}"/>
                                                    <input type="hidden" name="IsEvalDone" jsrequired="false" value="${isEvalDone}"/>
                                                        <input type="hidden" name="hdClarificationId" jsrequired="false" value="${configureDateList[0]}"/>
                                                        <input type="hidden" name="DateConfig" jsrequired="false" value="${operType}"/>
										</div>
									</div>
									</form:form>
									<div class="row">
										<div class="col-lg-12 col-md-12 col-xs-12">
											<%@include file="./UploadDocuments.jsp"%>
										</div>
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