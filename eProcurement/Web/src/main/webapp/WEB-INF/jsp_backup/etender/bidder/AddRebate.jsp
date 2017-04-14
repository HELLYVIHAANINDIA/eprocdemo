<!DOCTYPE html>
<html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../../includes/header.jsp"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script src="${pageContext.servletContext.contextPath}/resources/js/jquery-ui.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	var formListLength= "${fn:length(rebateFormList)}";
	var rtnValue = 0;
	var totalValue=0;
	for (var encVal=0; encVal<formListLength; encVal++){
		rtnValue = $('#encryptValues_'+encVal).html();
		totalValue = parseFloat(totalValue) + parseFloat(rtnValue);
	}
// 	var decimalUpto = 5;
// 	$('#totalValue').html(totalValue.toFixed(decimalUpto));
	$('#totalValue').html(totalValue);
});
     function getRebateAmt(){
    		 var percentage = $('#txtRebatePerc').val();
        	 var totalAmt = $('#totalValue').html();
        	 var rbtAmount =   parseFloat(totalAmt) * parseFloat(percentage)/100;
//         	 var decimalUpto = 5;
//         	 $('#rebateAmt').html(rbtAmount.toFixed(decimalUpto));
        	 $('#rebateAmt').html(rbtAmount);
        	 var finalAmt;
        	 var biddingVariant = '${biddingVariant}';
        	 if(biddingVariant == 1){
        		 finalAmt=parseFloat(totalAmt) - parseFloat(rbtAmount);	 
        	 }else{
        		 finalAmt=parseFloat(totalAmt) + parseFloat(rbtAmount);
        	 }
        	 
        	 $('#finalAmt').html(finalAmt);
//         	 $('#finalAmt').html(finalAmt.toFixed(decimalUpto));
        	 
        	 /*** View time check condition  **/
    		 if("${addEdtFlage}" != 3){
    			 if(!$("#txtRebatePerc").attr("readonly")){
    			 }
    		 }
    		 /*** End View time check condition  **/
     }
     function clearData(){
    	 if(!$("#txtRebatePerc").attr("readonly")){
    		 $('#rebateAmt').html("");
         	 $('#finalAmt').html("");	 
    	 }
     }
     function validateChng(){
   		 $('#perEncVal').val($('#finalAmt').html());
         var vbool = false;
         var divFinalAmt = document.getElementById("finalAmt");
         var divRebateAmt = document.getElementById("rebateAmt");
         
         if(divFinalAmt.textContent == ''){
        	 alert("Please enter rebate details");
        	 vbool = false;
         }else if(divRebateAmt.textContent == '0'){
        	 alert("Zero value is not allowed");
        	 vbool = false;
         }else{
        	 vbool = true;
         }
         return disableBtn(vbool);
     }
</script>
</head>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="../../includes/leftaccordion.jsp"%>

<div class="content-wrapper">

<section class="content">
	<div class="row">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			<div class="box">
				<div class="box-header with-border">
					<spring:message code="lbl_back_dashboard" var='backDashboard'/>
					<a href="${pageContext.servletContext.contextPath}/etender/bidder/biddingTenderDashboard/${tenderId}" class="btn btn-submit"><< ${backDashboard}</a>
				</div>
				<c:if test="${not empty successMsg}">
					<div><span class="label label-success"><spring:message code="${successMsg}"/></span></div>
				</c:if>
				<c:if test="${not empty errorMsg}">
					<div><span class="label label-danger"><spring:message code="${errorMsg}"/></span></div>
				</c:if>
				<div class="box-header with-border">
					<c:choose>     
			                           <c:when test="${addEdtFlage eq '1'}">
			                           	<h3 class="box-title">Create Rebate</h3>
			                           </c:when>
			                           <c:when test="${addEdtFlage eq '2'}">
			                           	<h3 class="box-title">Edit Rebate</h3>
			                           </c:when>
			                           <c:when test="${addEdtFlage eq '3'}">
			                           	<h3 class="box-title">View Rebate</h3>
			                           </c:when>
			                           
			                           
			                           </c:choose>
					
				</div>
				<div class="box-body">
					<div class="row">
						<div class="col-lg-12 col-md-12 col-xs-12">
		                           <c:choose>     
			                           <c:when test="${addEdtFlage eq '1'}">
			                           		<spring:url value="/etender/bidder/addrebate" var="postUrl"/>
			                           </c:when>
			                           <c:otherwise>
			                           		<spring:url value="/etender/bidder/editrebate" var="postUrl"/>
			                           </c:otherwise>
		                           </c:choose>
		                         
								<form:form action="${postUrl}" onsubmit="return validateChng();" method="post">
                                 <div class="clearfix table-border">
                                 	<font size="1" class="pull-right mandatory">(<b class="red">*</b>) <spring:message code="msg_mandatoryFields"></spring:message></font>
                                		<table class="table table-striped table-responsive">
                                			<input type="hidden" name="hdTenderId" value="${tenderId}"/>
                                			<input type="hidden" name="hdCompanyId" value="${companyId}"/>
                                			<input type="hidden" id="perEncVal" value="" name="perEncVal"/>
                                			
                                 			<tr class="gradi">
                                 	 			<th width="10%"><spring:message code="lbl_sr_no"/></th>
                                     			<th width="35%"><spring:message code="lbl_form_name"/></th>
                                     			<th width="20%"><spring:message code="lbl_table_name"/></th>
                                     			<th width="20%">Column Name</th>
                                     			<th width="15%"><spring:message code="lbl_tender_grand_total"/></th>
                                 			</tr>
                                     			<c:set var="srNo" value="1" scope="page"/>
                                     			<c:set var="encryptValues" value=""/>
                                 			<c:forEach items="${rebateFormList}"  var="rebateFormList" varStatus="count" >
                                                <tr>
	                                                <td>${srNo}</td>
                                                	<td>${rebateFormList[0]}</td>
                                                	<td>${rebateFormList[1]}</td>
                                                	<td>${rebateFormList[2]}</td>
                                                	<td class="a-center"><div id="encryptValues_${count.index}">${rebateFormList[3]}</div></td>
                                                	<input type="hidden" id="oldRebateAmt" name="oldRebateAmt" value="${rebateFormList[3]}"/>
                                                	<c:set var="srNo" value="${srNo+1}"/>
                                                </tr>
                                              </c:forEach>
                                      		<tr>
                                      			<td colspan="4">&nbsp;</td>
                                      		</tr>
										</table>
                    				</div>
                                    <div>
                                    		<table class="table table-striped table-responsive">
                                                <tr>
                                            	    <td width="10%">&nbsp;</td>
                                                	<td width="35%">&nbsp;</td>
                                                	<td class="a-center f-bold" width="40%"><spring:message code="lbl_tender_grand_total"/></td>
                                                	<td class="a-center" width="15%"><div id="totalValue"></div></td>
                                                </tr>
                                                <c:if test="${addEdtFlage ne '3'}">
	                                            <tr>
	                                                <td width="10%">&nbsp;</td>
                                                	<td width="35%">&nbsp;</td>
	                                               	<td width="40%" class="a-center f-bold"><spring:message code="lbl_rebate_percentage"/> <font size="1"><span class="mandatory red">*</span></font></td>
	                                               	<td width="15%" class="a-center">
                                                            <c:choose>
                                                                <c:when test="${addEdtFlage eq '3'}">
                                                                	<input type="text" name="txtRebatePerc" id="txtRebatePerc" onblur="getRebateAmt()" disabled="disabled" value="" onfocus="clearData()"/>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <input type="text" name="txtRebatePerc" id="txtRebatePerc" onblur="getRebateAmt()" value="" onfocus="clearData()"/>
                                                                </c:otherwise>
                                                            </c:choose>
                                                            
                                                        </td>
	                                            </tr>
	                                             <tr>
	                                               <td>&nbsp;</td>
                                                	<td>&nbsp;</td>
	                                                <td class="a-center f-bold"><spring:message code="lbl_rebate_amount"/></td>
	                                                <td class="a-center"><div id="rebateAmt"></div></td>
	                                             </tr>
	                                             <tr>
	                                               	<td>&nbsp;</td>
                                                	<td>&nbsp;</td>
	                                               	<td class="a-center f-bold"><spring:message code="lbl_final_amount"/></td>
	                                               	<td class="a-center"><div id="finalAmt"></td>
	                                             </tr>
                                                </c:if>
                                                <c:if test="${addEdtFlage eq '3'}">
                                                <tr>
	                                               	<td>&nbsp;</td>
                                                	<td>&nbsp;</td>
	                                               	<td class="a-center f-bold"><spring:message code="lbl_final_amount"/></td>
	                                               	<td class="a-center"><div id="finalAmt">${tblTenderRebateDtls.rebateValue}</td>
	                                             </tr>
	                                             </c:if>
                                                
                                                 <tr>
                                                	<td colspan="4" class="a-center">
	                                                	<c:if test="${addEdtFlage eq '1' or addEdtFlage eq '2'}">
	                                                	<button type="submit" class="btn btn-submit" id="submitBtn"><spring:message code='btn_save'/></button>
		                                                </c:if>
                                                	</td>
                                                </tr>	
                                            </table>
                                         </div>
                               </form:form>
                               <div class="box-header with-border">
					<a href="${pageContext.servletContext.contextPath}/etender/bidder/biddingTenderDashboard/${tenderId}"><< ${backDashboard}</a>
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