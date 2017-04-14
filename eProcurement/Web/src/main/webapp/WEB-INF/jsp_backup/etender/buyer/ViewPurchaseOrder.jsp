<%@include file="../../includes/head.jsp"%>
				<%@include file="../../includes/masterheader.jsp"%>
											
              
        <spring:message code="lbl_create_org" var="createdepartment"/>
       
  <div class="content-wrapper">      


<section class="content-header">
</section>

<section class="content">

	<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="box" id="viewPO">
						<c:if test="${not empty successMsg}">
                                        			<div class="alert alert-success"><spring:message code="${successMsg}"/></div>
                                    		</c:if>
                                    		<c:if test="${not empty errorMsg}">
                                        			<div class="alert alert-danger"><spring:message code="${errorMsg}"/></div>
                                    		</c:if>
						<div class="box-header with-border">
							<c:if test="${sessionObject.userTypeId eq 2}">
      							<div><a href="${pageContext.servletContext.contextPath}/etender/bidder/biddingTenderDashboard/${tenderId}"><< GO to tender dashboard </a></div>
      						</c:if>
						    <c:if test="${sessionObject.userTypeId eq 1}">
						    	<div><a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}"><< GO to tender dashboard </a></div>
						     </c:if>
							<c:choose>
	               					<c:when test="${optType eq 'edit'}">
	               					<spring:message code="lbl_purchase_oreder" var="lbl_purchase_oreder"/>
	               						<h3 class="box-title">${lbl_purchase_oreder}</h3>											
	               					</c:when>
	               					<c:otherwise>
	               					<spring:message code="lbl_purchase_oreder" var="lbl_purchase_oreder"/>
	               						<h3 class="box-title">${lbl_purchase_oreder}</h3>
								</c:otherwise>
								</c:choose>
						</div>
						<div class="box-body">
							<div class="row">
								<c:choose>
	               					<c:when test="${optType eq 'edit'}">
		               					<spring:url value="/etender/bidder/acknowledgepurchaseorder" var="submitDept"/>
	               					</c:when>
	               					<c:otherwise>
										<spring:url value="/etender/bidder/acknowledgepurchaseorder" var="submitDept"/>               						
									</c:otherwise>
								</c:choose>
								<div class="col-lg-12 col-md-12 col-xs-12">
									<form action="${submitDept}" onsubmit="return validate();" name="frmdepartment" method="post" >
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Purchase order No.<span style="color: red">*</span>:</div>
										</div>
										<div class="col-lg-5">
											<label>${purchaseorder.ponumber}</label>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Department:</div>
										</div>
										<div class="col-lg-5">
										<label>${department}</label>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Bidder name:</div>
										</div>
										<div class="col-lg-5">
											<label>${bidderName}</label>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Purchaser reference:</div>
										</div>
										<div class="col-lg-5">
											<label>${purchaseorder.bidderref}</label>
										</div>
									</div>
									
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Brief detail of purchase order<span style="color: red">*</span>:</div>
										</div>
										<div class="col-lg-5">
											<label>${purchaseorder.brifdetail}</label>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Particulars of project:</div>
										</div>
										<div class="col-lg-5">
											<label>${purchaseorder.projectdetail}</label>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Consignee Details<span style="color: red">*</span>:</div>
										</div>
										<div class="col-lg-5">
										<label>${purchaseorder.consigneedetails}</label>
										</div>
									</div>
									
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Delivery Schedule<span style="color: red">*</span>:</div>
										</div>
										<div class="col-lg-5">
											<label>${purchaseorder.deliveryschedule}</label>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Mode of transport:</div>
										</div>
										<div class="col-lg-5">
										<label>${purchaseorder.modeoftransport}</label>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Inspection<span style="color: red">*</span>:</div>
										</div>
										<div class="col-lg-5">
											<label>${purchaseorder.inspection}</label>
										</div>
									</div>
									
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Contract value <span style="color: red">*</span>:</div>
										</div>
										<div class="col-lg-5">
											<label>${purchaseorder.contractvalue}</label>
										</div>
									</div>
									
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Performance bank:</div>
										</div>
										<div class="col-lg-5">
										<label>${purchaseorder.performancebank}</label>
										</div>
									</div>
									
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Payment detail <span style="color: red">*</span>:</div>
										</div>
										<div class="col-lg-5">
											<label>${purchaseorder.paymentdetail}</label>
										</div>
									</div>
									
									
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Paying authority <span style="color: red">*</span>:</div>
										</div>
										<div class="col-lg-5">
												<label>${purchaseorder.payingauthority}</label>
										</div>
									</div>
									
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Technical specification:</div>
										</div>
										<div class="col-lg-5">
											<label>${purchaseorder.technicalspecification}</label>
										</div>
									</div>
									
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Purchase order terms and condition:</div>
										</div>
										<div class="col-lg-5">
											<label>${purchaseorder.potermsandcond}</label>
										</div>
									</div>
									<c:if test="${optType eq 'acknowledge' and purchaseorder.isAcknowledge eq 0}">
										<div class="col-lg-2">
											<div class="form_filed">status</div>
										</div>
										<div class="col-lg-5">
										<div class="chkbx">
												<input type="radio" name="rdackstatus" id="rdackstatus" value="1" /> Accept 
												<input type="radio" name="rdackstatus" id="rdackstatus" value="2"/> Decline
										</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Remarks:</div>
										</div>
										<div class="col-lg-5">
											<textarea class="form-control" name="remarks" id="remarks" validarr="length:0,500" tovalid="true"  onblur="validateTextComponent(this)" validationmsg="Allows Max. 500 alphabets, numbers and special characters" title="remarks"></textarea>
										</div>
									</div>	
									
									<div class="row">
										<div class="col-lg-2">
											<br>
										</div>
										<div class="col-lg-5">
											<button type="submit" id="addDept"  class="btn btn-submit">Submit</button>
											<input type="hidden" name="childId" id="childId" value="${childId}">
											<input type="hidden" name="tenderId" id="tenderId" value="${tenderId}">
											<input type="hidden" name="optType" id="optType" value="${optType}">
											<input type="hidden" name="hdCompanyName" id="companyName" value="${companyName}">
											<input type="hidden" name="hdPoId" id="hdPoId" value="${purchaseorder.poid}">
											<input type="hidden" name="ackstatus" id="ackstatus" value="0"/>
											<input type="hidden" name="bidderId" id="bidderId" value="${bidderId}"/>
											
										</div>
									</div>
									</c:if>
									</form>
								</div>
							</div>
						</div>
									<div class="">
											<input type="button" class="btn noExport" onclick="exportContent('viewPO','view purchase order',0)" value="PDF">
											<input type="button" class="btn noExport" onclick="exportContent('viewPO','view purchase order',5)" value="Print">
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
        var isDepartmentExists=false;
		var optType = '${optType}';
		
		function validate(){
			vbool = valOnSubmit()
        	$('#ackstatus').val($('input[name=rdackstatus]:checked').val());
        	return disableBtn(vbool);	
		}

		
  			$(document).ready(function(){
                $('a.myModel').click(function(){   //bind handlers
         		   var url = $(this).attr('href');
         		   showDialog(url);
         		   return false;
         		});

         		$("#targetDiv").dialog({  //create dialog, but keep it closed
         		   autoOpen: false,
         		   height: 300,
         		   width: 700,
         		   modal: true
         		});

         		function showDialog(url){  //load content and open dialog
         		    $("#targetDiv").load(url);
         		    $("#targetDiv").dialog("open");         
         		}
                });
  			
           </script>
           <style>
           .displaynone{
           	display: none;
           }
           </style>
           <script src='https://www.google.com/recaptcha/api.js'></script>	
           <%@include file="../../includes/footer.jsp"%>