<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <%@include file="./../includes/header.jsp"%>
        <%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
        <script src="${pageContext.servletContext.contextPath}/resources/js/commonValidate.js" type="text/javascript"></script>
        <script src="${pageContext.servletContext.contextPath}/resources/js/jQuery/jquery.datetimepicker.js"></script>
		<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/resources/css/jquery.datetimepicker.css">
<spring:message code="lbl_add_edit_marquee" var="lbl_add_edit_marquee"></spring:message>
<spring:message code="lbl_add_edit_biddermsg" var="lbl_add_edit_biddermsg"></spring:message>
<spring:message code="client_dateformate_hhmm" var="client_dateformate_hhmm"/>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="./../includes/leftaccordion.jsp"%>

<div class="content-wrapper" style="height: auto; ">
<c:if test="${not empty successMsg}">
    <div class="alert alert-success">${successMsg}</div>
</c:if>
<c:if test="${not empty errorMsg}">
    <div class="alert alert-error">${errorMsg}</div>
</c:if>

<section class="content-header">
<h1>
				<c:choose>
				<c:when test="${tenderId eq 0}">
				${lbl_add_edit_marquee}
				</c:when>
				<c:otherwise>
				${lbl_add_edit_biddermsg}	<a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}"  class="goBack btn btn-submit pull-right" style="margin-top: 0px;"><< <spring:message code="lbl_back_dashboard"/></a>
				</c:otherwise>
				 </c:choose>
				
			</h1>
</section>

<section class="content">
<div class="row">
<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
						
<div class="box">
<div class="box-body">
<div class="row">
<input type="hidden" name="clientDateFormate" id="clientDateFormate" value='<spring:message code="client_dateformate_hhmm" />'>
								
								    <spring:url value="/common/submitMarquee" var="submitMarquee"/>
									<form:form action="${submitMarquee}" onsubmit="return validate();" name="frmdepartment" method="post" modelAttribute="tblDepartment" >
										<input type="hidden" name="tenderId" id="tenderId" value='${tenderId}'>
										
										<div class="col-md-12">
										<div class="row">
											<div class="col-md-3"><div class="form_filed"><spring:message code="label_start_date"/></div></div>
											<div class="col-md-3">
												<input type="text" class="form-control dateBox" name="startDate" datepicker="yes" id="txtstartDate" datevalidate="lt:txtendDate" placeholder="${client_dateformate_hhmm}" dtrequired="true" title="<spring:message code="label_start_date"/>" onblur="validateEmptyDt(this)" value="${startDate}">
											</div>
											<div class="col-md-3"><div class="form_filed"><spring:message code="label_end_date"/></div></div>
											<div class="col-md-3">
												<input type="text" class="form-control dateBox" name="endDate" datepicker="yes"  id="txtendDate"  datevalidate="gt:txtstartDate"  placeholder="${client_dateformate_hhmm}" dtrequired="true" title="<spring:message code="label_end_date"/>" onblur="validateEmptyDt(this)" value="${endDate}">
											</div>
										</div>
										</div>
										
										<div class="col-md-12">
										<div class="row">
											<div class="col-md-3"><div class="form_filed"><spring:message code="label_marquee_detail"/></div></div>
											<div class="col-md-9">
												<textarea class="form-control" name="txtaMarquee" tovalid="true"  validarr="required@@length:0,1000"  title="<spring:message code="label_marquee_detail"/>" cols="20" rows="10" id="rtfMarquee">${tblMarquee.marqueeText}</textarea>
											</div>
										</div>
										</div>
										
										<div class="col-md-12">
											<input type="hidden" name="marqueeId" id="marqueeId" value="${empty tblMarquee.marqueeId ? 0 : tblMarquee.marqueeId }"> 
											<div class="col-md-3"></div>
											<div class="col-md-9">
											<div style="width:100%; height:auto; float:left; margin-top:10px;">
											<input type="submit" class="" value="Save">
											<input type="button" class="" value="Clear" onclick="clearDetail()">
											<input type="button" class="" value="Delete" onclick="deleteDetail()">
											</div>
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
function clearDetail(){
	$("#txtstartDate").val("");
	$("#txtendDate").val("");
	$("#rtfMarquee").html("");
	$('iframe').contents().find('.wysihtml5-editor').html("");
	$("#marqueeId").val(0);
}
function deleteDetail(){
	if(confirm("Are you sure you want to delete this ?")){
		$.ajax({
			type : "GET",
			url : "${pageContext.servletContext.contextPath}/common/removeMarquee/"+$("#marqueeId").val(),
			success : function(data) {
				clearDetail()
			},
			error : function(e) {
				console.log("ERROR: ", e);
			},
		});
	}
}
/* if($("#txtstartDate").val() != ""){
	$("#txtstartDate").val(convertDateToClientFormat1($("#txtstartDate").val(),$("#clientDateFormate").val()))
	$("#txtendDate").val(convertDateToClientFormat1($("#txtendDate").val(),$("#clientDateFormate").val()));
}
function convertDateToClientFormat1(tdVal,toDateFormate){
	if(tdVal != undefined && tdVal != "" && toDateFormate == "dd-MMM-yyyy HH:mm"){
		var dateTd = new Date(tdVal);
		var hour = ('0'+dateTd.getHours()).slice(-2);
		var mins = ('0'+dateTd.getMinutes()).slice(-2);
		return  dateTd.getDate()+ '-' + (dateTd.getMonth() + 1) + '-' +  dateTd.getFullYear()+' '+hour+':'+mins;
	}
} */
$("#rtfMarquee").wysihtml5();
</script>

</body>
</html>
