<!DOCTYPE html>
<html>
<%@include file="../../includes/header.jsp"%>
<script src="${pageContext.servletContext.contextPath}/resources/js/commonValidate.js" type="text/javascript"></script>
<script type="text/javascript">
            function validateRemarks(){
            	var result = valOnSubmit();
				return disableBtn(result);;
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
					<a href="${pageContext.servletContext.contextPath}/etender/bidder/biddingTenderDashboard/${tenderId}"><< ${backDashboard}</a>
				</div>
				<c:if test="${not empty successMsg}">
					<div><span class="alert alert-success"><spring:message code="${successMsg}"/></span></div>
				</c:if>
				<c:if test="${not empty errorMsg}">
					<div><span class="alert alert-danger"><spring:message code="${errorMsg}"/></span></div>
				</c:if>
				<div class="box-header with-border">
					<h3 class="box-title"><spring:message code="lbl_tender_bidwithdrawal"/></h3>
				</div>
				<div class="box-body">
					<div class="row">
                       	<font size="1" class="pull-right mandatory m-top1">(<b class="red">*</b>) <spring:message code="msg_mandatoryFields"></spring:message></font> 
                        <div class="col-lg-12 col-md-12 col-xs-12">
                        <spring:url value="/etender/bidder/withdrawbid/${tenderId}" var="postUrl"></spring:url>
                            <form:form action="${postUrl}" method="POST" onsubmit="return validateRemarks();" >
                         				<table class="table table-striped table-responsive">
                         					<tr>
                         						<td class="v-a-middle black">
                         							<label><spring:message code="lbl_bidwithdraw_reason_remark" var="var_bidwithdraw_remarks"/>${var_bidwithdraw_remarks}<span class="red"> *</span></label>
                         						</td>
                         						<td>
                         							<textarea  class="form-control"  id="txtaRemarks" name="txtaRemarks" validarr="required@@length:0,10000" tovalid="true" onblur="validateTxtComp(this)" validationmsg="Allows Max. 10000 alphabets, numbers and special characters" title="Remarks" class="line-height" cols="20" rows="10"></textarea>
                         						</td>
                         					</tr>
                         					<tr>
                         						<td colspan="2" class="a-center">
                         							<spring:message code="btn_withdraw" var="var_withdraw"/>
                         							<button id="btnWithdraw" class="btn btn-submit" type="submit">${var_withdraw}</button>
                         						</td>
                         					</tr>
                         				</table>
                            </form:form>
                         </div>
                       </div>
                     </div>  
                     	<div class="box-header with-border">
							<a href="${pageContext.servletContext.contextPath}/etender/bidder/biddingTenderDashboard/${tenderId}"><< ${backDashboard}</a>
						</div>
                    </div>
                   </div>
                   </div>
			</section>
	      </div>
	      
</div>

</body>

</html>