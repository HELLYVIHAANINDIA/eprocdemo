<!DOCTYPE html>
<html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../../includes/header.jsp"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script src="${pageContext.servletContext.contextPath}/resources/js/commonValidate.js" type="text/javascript"></script> 
<script src="${pageContext.request.contextPath}/resources/js/tender/tendercreate.js"></script>
<script type="text/javascript">
	function validate(){
         	var vbool = valOnSubmit();
         	return disableBtn(vbool);
	return true;
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
					<a href="${pageContext.servletContext.contextPath}/etender/bidder/biddingTenderDashboard/${tenderId}"><< ${backDashboard}</a>
				</div>
				<div class="box-header with-border">
				
					<h3 class="box-title">
						<c:choose>
							<c:when test="${committeeType eq 1}">
								<spring:message code="lable_opening_consent"/>
							</c:when>
							<c:otherwise>
								<spring:message code="lable_evaluation_consent"/>
							</c:otherwise>
						</c:choose>
					</h3>
				</div>
				<div class="box-body">
					<div class="row">
						<div class="col-lg-12 col-md-12 col-xs-12">
						<spring:url value="/etender/buyer/addusercommitteeremarks" var="postUrl"/>
						<form:form action="${postUrl}" onsubmit="return validate();" name="frmConsent" method="post">
							<div class="box-body pad">
							
								<table  class="table table-striped table-responsive">
									
									<spring:message var="remarks" code="lbl_remark"/>
									<tr>
                                  		<td>
                                      		<label>${remarks}<span class="red"> *</span> </label>
                                      		<textarea  class="form-control"  id="txtaRemarks" name="txtaRemarks" validarr="required@@length:0,10000" tovalid="true" onblur="validateTxtComp(this)" validationmsg="Allows Max. 10000 alphabets, numbers and special characters" title="Remarks" class="line-height" cols="20" rows="10"></textarea>
                                      	</td>
                             		 </tr>
								</table>
							</div>
							<div>
								<input type="hidden" name="hdTenderId" value="${tenderId}"/>
								<input type="hidden" name="hdEnvelopeId" value="${envelopeId}"/>
								<input type="hidden" name="hdCommitteeId" value="${committeeId}"/>
								<input type="hidden" name="hdCommitteeUserId" value="${committeeUserId}"/>
								<input type="hidden" name="hdMinOpeningMember" value="${minOpeningMember}"/>
								<input type="hidden" name="hdCommitteeType" value="${committeeType}"/>
								<button type="submit"  class="btn btn-submit">Submit</button>
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