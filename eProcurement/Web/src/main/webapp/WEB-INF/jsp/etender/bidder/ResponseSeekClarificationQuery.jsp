<%@include file="../../includes/head.jsp"%>
        <%@include file="../../includes/masterheader.jsp"%>
        
        <spring:message code="lbl_create_dept" var="createdepartment"/>
     <div class="content-wrapper">
    
	<section class="content-header">
	</section>
	<section class="content">
		<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="box">
						<div class="box-header with-border">
	               						<h3 class="box-title">Respond to query</h3>
						</div>
						<div class="box-body">
							<div class="row">
							<spring:url value="/etender/bidder/responseQueryPost" var="configureDateUrl"/>
								<div class="col-lg-12 col-md-12 col-xs-12">
									<form:form action="${configureDateUrl}" onsubmit="return validate();" name="frmdepartment" method="post">
									<div class="row">
										<div class="row">
										<div class="col-lg-2">
											<div class="form_filed"><label>Response end date : <span> *</span></label></div>
										</div>
										<div class="col-lg-5">
											<div class="form_filed">
											<label>${responseEndDate}<label>
											</div>
										</div>
									</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed"><label>Query<span> *</span><label></div>
										</div>
										<div class="col-lg-5">
											<div class="form_filed">
											<label>${questionTxt}<label>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed"><label>Answer<span> *</span><label></div>
										</div>
										<div class="col-lg-5">
											<div class="form_filed">
												<textarea name="txtaAnswer" title="Answer" isrequired="true" maxlength="1000" validation="length,rgx_alphanumwithnewchar"> </textarea>
											</div>
										</div>
									</div>
									
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed"></div>
										</div>
										<div class="col-lg-5">
											<button type="submit" id="addDept"  class="btn btn-submit">Submit</button> 
                                                    <input type="hidden" name="hdTenderId" jsrequired="false" value="${tenderId}"/>
                                                    <input type="hidden" name="hdEnvelopeId" jsrequired="false" value="${envelopeId}"/>
                                                    <input type="hidden" name="hdBidderId" jsrequired="false" value="${bidderId}"/>
                                                    <input type="hidden" name="IsEvalDone" jsrequired="false" value="${isEvalDone}"/>
                                                    <input type="hidden" name="ClarificationId" jsrequired="false" value="${clarificationList[0]}"/>
                                                    <input type="hidden" name="hdQuestion" jsrequired="false" value="${questionId}"/>
										</div>
									</div>
									</form:form>
									<div class="row">
										<div class="col-lg-12 col-md-12 col-xs-12">
											<%@include file="../buyer/UploadDocuments.jsp"%>
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
           <%@include file="../../includes/footer.jsp"%>