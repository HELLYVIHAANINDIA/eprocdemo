<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <%@include file="./../../includes/header.jsp"%>
        <%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
        <script src="${pageContext.servletContext.contextPath}/resources/js/commonValidate.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/resources/js/commonListing.js"></script>        
        <spring:message code="lbl_create_dept" var="createdepartment"/>
        <title>${createdepartment}</title>
        <script type="text/javascript">
        var VALIDATE_MSG_REQUIRED = 'Please enter';
        var VALIDATE_MSG_SELECT = 'Please select';
        var VALIDATE_MSG_ALLOW_MAX='Allows Max. ';
        var VALIDATE_MSG_TENDERBRIEF='characters';
        
            function validate(){
            	var vbool = valOnSubmit();
            	return disableBtn(vbool);
            }
            
            $(document).ready(function(){
            	$("#rtfRemarks").wysihtml5();	
            });
            
           </script>
</head>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="./../../includes/leftaccordion.jsp"%>
    
<div class="content-wrapper" style="height: auto; ">

<section class="content-header">
<h1>Term and condition</h1>
</section>

<section class="content">
<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="box">
						<div class="box-header with-border">
	               						<h3 class="box-title">Term and condition</h3>											
						</div>
						<div class="box-body">
						<a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}"> << Go To Tender Dashboard </a> 
							<div class="row">
		               					<spring:url value="/etender/buyer/addtermandconditions" var="submitTandC"/>
								<div class="col-lg-12 col-md-12 col-xs-12">
									<form:form action="${submitTandC}" onsubmit="return validate();" >
									
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Event term & condition :</div>
										</div>
										<div class="col-lg-10">
											<textarea  id="rtfRemarks" validarr="required@@remarks:1000" tovalid="true" title="Terms and Condition"  name="termAndCondition" class="form-control">${termAndCondition} </textarea>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<br>
										</div>
										<div class="col-lg-10">
											<input type="hidden" name="hdTenderId" value="${tenderId}">
											<button type="submit" id="addDept"  class="btn btn-submit">Submit</button>
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