<%@include file="../../includes/head.jsp"%>
				<%@include file="../../includes/masterheader.jsp"%>										
             
        <spring:message code="lbl_create_org" var="createdepartment"/>
       <div class="content-wrapper">

<section class="content-header">
</section>

<section class="content">
	<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="box">
						<c:if test="${not empty successMsg}">
                                        			<div class="alert alert-success"><spring:message code="${successMsg}"/></div>
                                    		</c:if>
                                    		<c:if test="${not empty errorMsg}">
                                        			<div class="alert alert-danger"><spring:message code="${errorMsg}"/></div>
                                    		</c:if>
						<div class="box-header with-border">
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
							<a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}"><< Go back to dashboard</a>
							<div class="row">
								<c:choose>
	               					<c:when test="${optType eq 'edit'}">
		               					<spring:url value="/etender/buyer/addpurchaseorder" var="submitDept"/>
	               					</c:when>
	               					<c:otherwise>
										<spring:url value="/etender/buyer/addpurchaseorder" var="submitDept"/>               						
									</c:otherwise>
								</c:choose>
								<div class="col-lg-12 col-md-12 col-xs-12">
									<form action="${submitDept}" onsubmit="return validate();" name="frmdepartment" method="post" >
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">PO No.<span style="color: red">*</span>:</div>
										</div>
										<div class="col-lg-5">
											<c:choose>
				               					<c:when test="${optType eq 'edit'}">
				               						<input type="text" class="form-control" name="txtPoNum" value="${purchaseorder.ponumber}" id="txtPoNum" validarr="required@@tenderbrief:100" tovalid="true" onblur="validateTextComponent(this)" title="Purchase order no." />
				               					</c:when>
				               					<c:otherwise>
													<input type="text" class="form-control" name="txtPoNum" id="txtPoNum" validarr="required@@tenderbrief:100" tovalid="true" onblur="validateTextComponent(this)" title="Purchase order no." />
												</c:otherwise>
											</c:choose>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Department:</div>
										</div>
										<div class="col-lg-5">
											<c:choose>
				               					<c:when test="${optType eq 'edit'}">
				               						<label>${department}</label>
													<input type="hidden" class="form-control"  id="hdDeptId" value="${deptId}" />
				               					</c:when>
				               					<c:otherwise>
				               						<label>${department}</label>
													<input type="hidden" class="form-control"  id="hdDeptId" value="${deptId}" />
												</c:otherwise>
											</c:choose>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Bidder name:</div>
										</div>
										<div class="col-lg-5">
											<c:choose>
				               					<c:when test="${optType eq 'edit'}">
				               						<label>${bidderName}</label>
													<input type="hidden" class="form-control" name="hdBidderId" id="hdBidderId" value="${childId}" />
				               					</c:when>
				               					<c:otherwise>
													<label>${bidderName}</label>
													<input type="hidden" class="form-control" name="hdBidderId" id="hdBidderId" value="${childId}" />
												</c:otherwise>
											</c:choose>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Company name:</div>
										</div>
										<div class="col-lg-5">
											<c:choose>
				               					<c:when test="${optType eq 'edit'}">
				               						<label>${companyName}</label>
				               					</c:when>
				               					<c:otherwise>
													<label>${companyName}</label>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
									
									<c:if test="${isItemWise}">
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Item Description</div>
										</div>
										<div class="col-lg-5">
											<c:choose>
				               					<c:when test="${optType eq 'edit'}">
				               						<label>${ItemName}</label>
				               						<input type="hidden" class="form-control" name="hdItemName" id="hdItemName" value="${ItemName}" />
				               					</c:when>
				               					<c:otherwise>
													<label>${ItemName}</label>
													<input type="hidden" class="form-control" name="hdItemName" id="hdItemName" value="${ItemName}" />
												</c:otherwise>
											</c:choose>
										</div>
									</div>
									</c:if>
									
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Purchaser reference:</div>
										</div>
										<div class="col-lg-5">
											<c:choose>
				               					<c:when test="${optType eq 'edit'}">
				               						<input type="text" class="form-control" name="txtBidderRef"  value="${purchaseorder.bidderref}"  id="txtBidderRef" validarr="required@@tenderbrief:100" tovalid="true" onblur="validateTextComponent(this)" title="Purchaser reference." />
				               					</c:when>
				               					<c:otherwise>
													<input type="text" class="form-control" name="txtBidderRef" id="txtBidderRef" validarr="required@@tenderbrief:100" tovalid="true" onblur="validateTextComponent(this)" title="Purchaser reference." />
												</c:otherwise>
											</c:choose>
										</div>
									</div>
									
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Brief detail of PO<span style="color: red">*</span>:</div>
										</div>
										<div class="col-lg-5">
											<c:choose>
				               					<c:when test="${optType eq 'edit'}">
				               						<textarea class="form-control" name="txtaBrifDetail"  id="txtaBrifDetail" validarr="required@@length:0,500" tovalid="true" onblur="validateTextComponent(this)" validationmsg="Allows Max. 500 alphabets, numbers and special characters" title="Brief detail of purchase order">${purchaseorder.brifdetail}</textarea>
				               					</c:when>
				               					<c:otherwise>
													<textarea class="form-control" name="txtaBrifDetail"   id="txtaBrifDetail" validarr="required@@length:0,500" tovalid="true" onblur="validateTextComponent(this)" validationmsg="Allows Max. 500 alphabets, numbers and special characters" title="Brief detail of purchase order"></textarea>               						
												</c:otherwise>
											</c:choose>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Particulars of project:</div>
										</div>
										<div class="col-lg-5">
											<c:choose>
				               					<c:when test="${optType eq 'edit'}">
				               						<textarea class="form-control" name="txtaProjectDetail"  id="txtaProjectDetail" validarr="length:0,500" onblur="validateTextComponent(this)" validationmsg="Allows Max. 500 alphabets, numbers and special characters" title="Particulars of project">${purchaseorder.projectdetail}</textarea>
				               					</c:when>
				               					<c:otherwise>
													<textarea class="form-control" name="txtaProjectDetail"  id="txtaProjectDetail" validarr="length:0,500" onblur="validateTextComponent(this)" validationmsg="Allows Max. 500 alphabets, numbers and special characters" title="Particulars of project"></textarea>               						
												</c:otherwise>
											</c:choose>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Consignee Details<span style="color: red">*</span>:</div>
										</div>
										<div class="col-lg-5">
											<c:choose>
				               					<c:when test="${optType eq 'edit'}">
				               						<textarea class="form-control" name="txtaConsigneeDetails" id="txtaConsigneeDetails"   validarr="required@@length:0,500" tovalid="true" onblur="validateTextComponent(this)" validationmsg="Allows Max. 500 alphabets, numbers and special characters" title="brifDetail">${purchaseorder.consigneedetails}</textarea>
				               					</c:when>
				               					<c:otherwise>
													<textarea class="form-control"   name="txtaConsigneeDetails" id="txtaConsigneeDetails" validarr="required@@length:0,500" tovalid="true" onblur="validateTextComponent(this)" validationmsg="Allows Max. 500 alphabets, numbers and special characters" title="brifDetail"></textarea>               						
												</c:otherwise>
											</c:choose>
										</div>
									</div>
									
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Delivery Schedule<span style="color: red">*</span>:</div>
										</div>
										<div class="col-lg-5">
											<c:choose>
				               					<c:when test="${optType eq 'edit'}">
				               						<input type="text" class="form-control" value="${purchaseorder.deliveryschedule}"  name="txtDeliverySchedule" id="txtDeliverySchedule" validarr="required@@tenderbrief:100" tovalid="true" onblur="validateTextComponent(this)" title="Delivery Schedule" />
				               					</c:when>
				               					<c:otherwise>
													<input type="text" class="form-control" name="txtDeliverySchedule" id="txtDeliverySchedule" validarr="required@@tenderbrief:100" tovalid="true" onblur="validateTextComponent(this)" title="Delivery Schedule" />
												</c:otherwise>
											</c:choose>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Mode of transport:</div>
										</div>
										<div class="col-lg-5">
											<c:choose>
				               					<c:when test="${optType eq 'edit'}">
				               						<textarea class="form-control"    name="txtaModeOfTransport" id="txtaModeOfTransport" validarr="required@@length:0,500" tovalid="true" onblur="validateTextComponent(this)" validationmsg="Allows Max. 500 alphabets, numbers and special characters" title="Mode of transport">${purchaseorder.modeoftransport}</textarea>
				               					</c:when>
				               					<c:otherwise>
													<textarea class="form-control"    name="txtaModeOfTransport" id="txtaModeOfTransport" validarr="required@@length:0,500" tovalid="true" onblur="validateTextComponent(this)" validationmsg="Allows Max. 500 alphabets, numbers and special characters" title="Mode of transport"></textarea>               						
												</c:otherwise>
											</c:choose>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Inspection<span style="color: red">*</span>:</div>
										</div>
										<div class="col-lg-5">
											<c:choose>
				               					<c:when test="${optType eq 'edit'}">
				               						<textarea class="form-control" name="txtaInspection" id="txtaInspection"  validarr="required@@length:0,500" tovalid="true" onblur="validateTextComponent(this)" validationmsg="Allows Max. 500 alphabets, numbers and special characters" title="Inspection">${purchaseorder.inspection}</textarea>
				               					</c:when>
				               					<c:otherwise>
													<textarea class="form-control" name="txtaInspection" id="txtaInspection"  validarr="required@@length:0,500" tovalid="true" onblur="validateTextComponent(this)" validationmsg="Allows Max. 500 alphabets, numbers and special characters" title="Inspection"></textarea>               						
												</c:otherwise>
											</c:choose>
										</div>
									</div>
									
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Contract value <span style="color: red">*</span>:</div>
										</div>
										<div class="col-lg-5">
											<c:choose>
				               					<c:when test="${optType eq 'edit'}">
				               						<input type="text" class="form-control" name="txtContractValue" id="txtContractValue" validarr="required@@numeric:100" tovalid="true" value="${purchaseorder.contractvalue}" onblur="validateTextComponent(this)" title="Contract value" />
				               					</c:when>
				               					<c:otherwise>
													<input type="text" class="form-control" name="txtContractValue" id="txtContractValue" validarr="required@@numeric:100" tovalid="true" onblur="validateTextComponent(this)" title="Contract value" />
												</c:otherwise>
											</c:choose>
										</div>
									</div>
									
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Performance bank:</div>
										</div>
										<div class="col-lg-5">
											<c:choose>
				               					<c:when test="${optType eq 'edit'}">
				               						<input type="text" class="form-control" name="txtPerformanceBank" id="txtPerformanceBank" validarr="required@@tenderbrief:100" value="${purchaseorder.performancebank}" tovalid="true" onblur="validateTextComponent(this)" title="Performance bank" />
				               					</c:when>
				               					<c:otherwise>
													<input type="text" class="form-control" name="txtPerformanceBank" id="txtPerformanceBank" validarr="required@@tenderbrief:100" tovalid="true" onblur="validateTextComponent(this)" title="Performance bank" />
												</c:otherwise>
											</c:choose>
										</div>
									</div>
									
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Payment detail <span style="color: red">*</span>:</div>
										</div>
										<div class="col-lg-5">
											<c:choose>
				               					<c:when test="${optType eq 'edit'}">
				               						<textarea class="form-control" name="txtaPaymentDetail"  id="txtaPaymentDetail" validarr="required@@length:0,500" tovalid="true" onblur="validateTextComponent(this)" validationmsg="Allows Max. 500 alphabets, numbers and special characters" title="Payment Detail">${purchaseorder.paymentdetail}</textarea>
				               					</c:when>
				               					<c:otherwise>
													<textarea class="form-control" name="txtaPaymentDetail"  id="txtaPaymentDetail" validarr="required@@length:0,500" tovalid="true" onblur="validateTextComponent(this)" validationmsg="Allows Max. 500 alphabets, numbers and special characters" title="Payment Detail"></textarea>               						
												</c:otherwise>
											</c:choose>
										</div>
									</div>
									
									
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Paying authority <span style="color: red">*</span>:</div>
										</div>
										<div class="col-lg-5">
											<c:choose>
				               					<c:when test="${optType eq 'edit'}">
				               						<input type="text" class="form-control" value="${purchaseorder.payingauthority}" name="txtPayingAuthority" id="txtPayingAuthority" validarr="required@@tenderbrief:100" tovalid="true" onblur="validateTextComponent(this)" title="Paying Authority" />
				               					</c:when>
				               					<c:otherwise>
													<input type="text" class="form-control" name="txtPayingAuthority" id="txtPayingAuthority" validarr="required@@tenderbrief:100" tovalid="true" onblur="validateTextComponent(this)" title="Paying Authority" />
												</c:otherwise>
											</c:choose>
										</div>
									</div>
									
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Technical specification:</div>
										</div>
										<div class="col-lg-5">
											<c:choose>
				               					<c:when test="${optType eq 'edit'}">
				               						<textarea class="form-control" name="txtaTechnicalSpecification" id="txtaTechnicalSpecification"  validarr="length:0,500" tovalid="true" onblur="validateTextComponent(this)" validationmsg="Allows Max. 500 alphabets, numbers and special characters" title="Payment Detail">${purchaseorder.technicalspecification}</textarea>
				               					</c:when>
				               					<c:otherwise>
													<textarea class="form-control" name="txtaTechnicalSpecification" id="txtaTechnicalSpecification"  validarr="length:0,500" tovalid="true" onblur="validateTextComponent(this)" validationmsg="Allows Max. 500 alphabets, numbers and special characters" title="Payment Detail"></textarea>               						
												</c:otherwise>
											</c:choose>
										</div>
									</div>
									
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">PO terms and condition:</div>
										</div>
										<div class="col-lg-5">
											<c:choose>
				               					<c:when test="${optType eq 'edit'}">
				               						<textarea class="form-control" name="txtaPoTermsAndCond" id="txtaTechnicalSpecification" validarr="length:0,500" tovalid="true"  onblur="validateTextComponent(this)" validationmsg="Allows Max. 500 alphabets, numbers and special characters" title="Purchase order terms and condition">${purchaseorder.potermsandcond}</textarea>
				               					</c:when>
				               					<c:otherwise>
													<textarea class="form-control" name="txtaPoTermsAndCond" id="txtaTechnicalSpecification" validarr="length:0,500" tovalid="true"  onblur="validateTextComponent(this)" validationmsg="Allows Max. 500 alphabets, numbers and special characters" title="Purchase order terms and condition"></textarea>               						
												</c:otherwise>
											</c:choose>
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
											<input type="hidden" name="hdRowId" id="rowId" value="${rowId}">
											<input type="hidden" name="hdTableId" id="tableId" value="${tableId}">
											<c:if test="${optType eq 'edit'}">
												<input type="hidden" name="hdPoId" id="hdPoId" value="${purchaseorder.poid}">
											</c:if>
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
        var isDepartmentExists=false;
		var optType = '${optType}';
        
        
            function validate(){
            	var vbool = valOnSubmit();
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