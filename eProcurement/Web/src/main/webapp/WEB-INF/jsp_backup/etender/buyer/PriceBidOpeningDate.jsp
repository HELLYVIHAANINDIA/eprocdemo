<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <%@include file="../../includes/header.jsp"%>
        <%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
        <script src="${pageContext.servletContext.contextPath}/resources/js/commonValidate.js" type="text/javascript"></script>
        <script src="${pageContext.servletContext.contextPath}/resources/js/jQuery/jquery.datetimepicker.js"></script>
		<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/resources/css/jquery.datetimepicker.css">
</head>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="../../includes/leftaccordion.jsp"%>

<spring:message code="lbl_add_edit_marquee" var="lbl_add_edit_marquee"></spring:message>
<div class="content-wrapper" style="height: auto; ">
<c:if test="${not empty successMsg}">
    <div class="alert alert-success">${successMsg}</div>
</c:if>
<c:if test="${not empty errorMsg}">
    <div class="alert alert-error">${errorMsg}</div>
</c:if>
		<section class="content-header">
			<c:choose>
				<c:when test="${oprType eq 1}">
        			<spring:message code="title_pricebidopeningdateconfiguration" var="priceBidOpeningDateConfiguration"/>
        		</c:when>
        		<c:when test="${oprType eq 2}">
        			<spring:message code="title_pricebidopeningdateconfigurationedit" var="priceBidOpeningDateConfiguration"/>
        		</c:when>
        		 <c:when test="${oprType eq 3}">
        			<spring:message code="title_pricebidopeningdateconfigurationpublish" var="priceBidOpeningDateConfiguration"/>
        		</c:when>
        		<c:when test="${oprType eq 4}">
        			<spring:message code="title_pricebidopeningdateconfigurationview" var="priceBidOpeningDateConfiguration"/>
        		</c:when>
        	</c:choose>
        	<h1>${priceBidOpeningDateConfiguration}</h1>
<spring:message code="lbl_back_dashboard" var='backDashboard'/>
<section class="content">
				<div>
					<div class="box">
						<div class="box-header with-border">
				<div><a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}"><< ${backDashboard}</a></div>
						<div class="box-body">
							<div class="row">
								<div>
									<input type="hidden" name="clientDateFormate" id="clientDateFormate" value='<spring:message code="client_dateformate_hhmm" />'>
								
								   <spring:url value="/etender/buyer/updatepricebidopeningdate" var="postUrl"/>
								   <form:form action="${postUrl}" onsubmit="return validate();" method="post">
										<div class="col-md-12">
											<spring:message code="field_pricebidopeningdate" var="priceBidOpeningDate"/>
											<input type="hidden" name="hdTenderId" value="${tenderId}"/>
											<input type="hidden" name="hdEnvelopeId" value="${envelopeId}"/>
											<input type="hidden" name="hdOprType" value="${oprType}"/>
											<input type="hidden" name="hdPreviousEnvlpId" value="${previousEnvlpId}"/>
											<c:set value="${openingDateStr}" var="openingDatePriceBid"/>
											<table class="table table-striped table-responsive">
												<tr>
													<td>
													${tenderEnvelopeDetailsList[0][2]} ${priceBidOpeningDate}<c:if test="${oprType eq 1 or oprType eq 2}"> <span class="red">*</span></c:if>
														<c:if test="${not empty tenderEnvelopeDetailsList[0][2]}">
																<input type="hidden" name="hdEnvelopeName" value="${tenderEnvelopeDetailsList[0][2]}"/>
															</c:if>
													</td>
												<td>
													<c:choose>
									    				<c:when test="${oprType eq 1 or oprType eq 2}">
									    					<input type="text" class="form-control dateBox" name="txtPriceBidOpeningDate" datepicker="yes" id="txtPriceBidOpeningDate" datevalidate="lt:txtendDate" placeholder="${client_dateformate_hhmm}" dtrequired="true" title="Opening date" onblur="validateEmptyDt(this)" value="${openingDatePriceBid}">
									    				</c:when>
									    				<c:otherwise>
													 		<input type="hidden" name="txtPriceBidOpeningDate" id="txtPriceBidOpeningDate" value="${openingDatePriceBid}"/>
													 		${openingDatePriceBid}
													 	</c:otherwise>
								    				</c:choose>
							    				</td>
							    				</tr>
							    				<tr>
													<td colspan="2">
														<c:choose>
										    				<c:when test="${oprType eq 1 or oprType eq 2}"> 
																<button type="submit" class="btn btn-submit"><spring:message code='btn_submit' /></button> 
															</c:when>
														 	<c:when test="${oprType eq 3}">
														 		<button type="submit" class="btn btn-submit"><spring:message code='link_tender_publish' /></button>
														 	</c:when>
														 </c:choose>
													</td>
												</tr>
											</table>
										</div>
									</form:form>
								</div>
							</div>
						</div>
					</div>
				</div>
				</div>
</section>
</section>
</div>

</div>

<script>
function validate(){
	var vbool = valOnSubmit();
	return disableBtn(vbool);
}
$(".dateBox").each(function(){
		$(this).datetimepicker({
			format:'d-M-Y H:i',
		});
});

/* if($("#txtPriceBidOpeningDate").val() != ""){
	$("#txtPriceBidOpeningDate").val(convertDateToClientFormat1($("#txtPriceBidOpeningDate").val(),$("#clientDateFormate").val()))
}
function convertDateToClientFormat1(tdVal,toDateFormate){
	if(tdVal != undefined && tdVal != "" && toDateFormate == "dd/MM/yyyy HH:mm"){
		var dateTd = new Date(tdVal);
		var hour = ('0'+dateTd.getHours()).slice(-2);
		var mins = ('0'+dateTd.getMinutes()).slice(-2);
		return  dateTd.getDate()+ '/' + (dateTd.getMonth() + 1) + '/' +  dateTd.getFullYear()+' '+hour+':'+mins;
	}
} */
</script>

</body>

</html>