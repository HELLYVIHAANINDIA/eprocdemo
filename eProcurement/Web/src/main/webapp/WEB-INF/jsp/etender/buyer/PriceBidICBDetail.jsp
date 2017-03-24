<!DOCTYPE html>
<html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../../includes/header.jsp"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script src="${pageContext.request.contextPath}/resources/js/tender/tendercreate.js"></script>
<script src="${pageContext.servletContext.contextPath}/resources/js/jQuery/jquery.datetimepicker.js"></script>
<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/resources/css/jquery.datetimepicker.css">
<script src="${pageContext.servletContext.contextPath}/resources/js/jquery-ui.min.js"></script>
<script type="text/javascript">

	function validateChng(){
		var vbool = true;
		$('[id^="txtExchangeRate"]').each(function () {
			if($(this).val() == ''){
				vbool = false;
				alert('Please Enter Currency Exchange Rate');
				return vbool;
			}
		});
        return disableBtn(vbool);
    }
</script>         	
<spring:message code="lbl_back_dashboard" var='backDashboard'/>
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
				<div><a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}"><< ${backDashboard}</a></div>
					<h3 class="box-title">
        	<c:choose>
				<c:when test="${oprType eq 1}">
        			<spring:message code="title_pricebidICBconfiguration" var="priceBidICBConfiguration"/>
        		</c:when>
        		<c:when test="${oprType eq 2}">
        			<spring:message code="title_pricebidICBconfigurationview" var="priceBidICBConfiguration"/>
        		</c:when>
        	</c:choose>
        	${priceBidICBConfiguration}</h3>
				</div>
				<div class="box-body">
					<div class="row">
						<div class="col-lg-12 col-md-12 col-xs-12">
						<spring:url value="/etender/buyer/updatepricebidICB" var="postUrl"/>
						<form:form action="${postUrl}" onsubmit="return validateChng();" method="post">
							<div class="box-body pad">
								<c:if test="${not empty successMsg}">
									<div><span class="alert alert-success"><spring:message code="${successMsg}"/></span></div>
								</c:if>
								<c:if test="${not empty errorMsg}">
									<div><span class="alert alert-danger"><spring:message code="${errorMsg}"/></span></div>
								</c:if>
							</div>
							<div>
								<input type="hidden" name="hdTenderId" value="${tenderId}"/>
								<input type="hidden" name="hdOprType" value="${oprType}"/>
								<input type="hidden" name="hdRowCount" value="${fn:length(ICBDetails)}"/>
								<table class="table table-striped table-responsive">
									
										<c:forEach items="${ICBDetails}" var="ICBDtls" varStatus="count">
											<input type="hidden" name="hdCurrencyId${count.index}" value="${ICBDtls[0]}"/>
											<input type="hidden" name="hdTenderCurrencyId${count.index}" value="${ICBDtls[3]}"/>
											<c:if test="${ICBDtls[2] eq 0}">
													<tr><td>${ICBDtls[1]}</td>
													<c:choose>
														<c:when test="${oprType eq 2}">
															<td>${ICBDtls[4]}</td>
														</c:when>
														<c:otherwise>
															<td><input id="txtExchangeRate${count.index}" name="txtExchangeRate${count.index}" type="text" title="Exchnage Rate"></td>
														</c:otherwise>
													</c:choose>
													</tr>
											</c:if>
										</c:forEach>
									</tr>
									<c:if test="${oprType eq 1}">
									<tr>
										<td colspan="${fn:length(ICBDetails)}">
											<button id="btnSubmit" type="submit" class="btn btn-submit"><spring:message code='btn_submit'/></button> 
										</td>
									</tr>
									</c:if>
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
</div>

</div>

</body>

</html>
