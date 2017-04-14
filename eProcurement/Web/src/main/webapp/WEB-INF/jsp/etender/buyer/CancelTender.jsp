<%@include file="../../includes/head.jsp"%>
        <%@include file="../../includes/masterheader.jsp"%>
     
<div class="content-wrapper">
		<section class="content-header">
			<h1>
                            <c:if test="${isAuction eq 0}">
				<spring:message code="link_tender_cancel" />
                            </c:if>
                            <c:if test="${isAuction eq 1}">
                                <spring:message code="lbl_cancel_auction" />
                            </c:if>
			</h1>
                     <c:if test="${isAuction eq 1}">
                    <div class="col-md-6 text-right" >
                                          <a onclick="window.history.back();" style="cursor: pointer" class="goBack"><< <spring:message code="lbl_go_back_to_auction_dashboard" /></a>
                                     </div> </c:if>
		</section>
<section class="content">
		<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="box">
						<div class="box-header with-border">
	               						<h3 class="box-title"><c:if test="${isAuction eq 0}">
                               <spring:message code="link_tender_cancel" />
                            </c:if>
                            <c:if test="${isAuction eq 1}">
                               <spring:message code="lbl_cancel_auction" />
                            </c:if></h3>											
						</div>
						<div class="box-body">
							<div class="row">
		               					<spring:url value="/etender/buyer/canceltender" var="submitTandC"/>
								<div class="col-lg-12 col-md-12 col-xs-12">
									<form:form action="${submitTandC}" onsubmit="return validate();" >
									
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed"><spring:message code="lbl_remark" /></div>
										</div>
										<div class="col-lg-5">
											<textarea  id="rtfRemarks" validarr="required@@remarks:1000" tovalid="true" title="Remarks"  name="remarks" class="form-control"></textarea>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<br>
										</div>
										<div class="col-lg-5">
											<input type="hidden" name="hdTenderId" value="${tenderId}">
											<button type="submit" id="addDept"  class="btn btn-submit"><spring:message code="btn_submit" /></button>
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