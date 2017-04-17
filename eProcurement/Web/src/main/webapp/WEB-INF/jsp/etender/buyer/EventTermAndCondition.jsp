<%@include file="../../includes/head.jsp"%>
      <%@include file="../../includes/masterheader.jsp"%>
         
        <spring:message code="lbl_create_dept" var="createdepartment"/>
   
<div class="content-wrapper">

<section class="content-header">
<h1 class="inline">Terms and conditions</h1>
<a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}" class="g g-back"> << Go To Tender Dashboard </a> 
</section>

<section class="content">
<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="box">
						<div class="box-header with-border">
	               						<h3 class="box-title">Terms and conditions</h3>											
						</div>
						<div class="box-body">
						
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
           <%@include file="../../includes/footer.jsp"%>