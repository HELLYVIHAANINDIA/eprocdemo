<%@include file="../../includes/head.jsp"%>
<jsp:useBean id="now" class="java.util.Date" />
<%@include file="../../includes/masterheader.jsp"%>
<div class="content-wrapper">
<section class="content-header">
<h1><spring:message code="link_create_corrigendum"/></h1>
<a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}" class="pull-right"><< Go To Tender Dashboard</a>
<spring:message code="link_goback_tenderdashbord" var="goBack"/>
</section>



<form id="tenderDtBean" name="tenderDtBean" onsubmit="return validation();" action="${pageContext.servletContext.contextPath}/etender/buyer/submittendercorrigendum" method="post" >
<div id="temp">
 <c:if test="${not empty tblCorrigendum}">
                       <c:forEach items="${tblCorrigendum}" var="items"> 
                       	<c:if test="${items.cstatus eq 0}">
                        	<input type="hidden" name="corrigendumId" id="corrigendumId" value="${items.corrigendumId}">
                        	<c:set value="${items.corrigendumText}" var="corrigendumText"></c:set>
                       	</c:if>
                       </c:forEach>
                       </c:if>
<section class="content">
	<div class="row">
		<div class="col-xs-12">
			<div class="box">
				<div class="box-header with-border">
					<h3 class="box-title"></h3>
					<font size="1" class="pull-right mandatory"><spring:message code="msg_mandatoryFields"/></font>
				</div>
				<div class="box-body">
					<div class="row">
						<div class="col-xs-2">
						<spring:message code="lbl_create_corrigendum_text"/><span id='errSpanCorrigendumTextMsg' class='mandatory red'>*</span>
						</div>
						<div class="col-xs-10">
						<textarea  class="form-control corrigendumText"  id="corrigendumText" tovalid="true"  validarr="required@@length:0,1000" name="corrigendumText" title="Details" cols="20" rows="10" >${corrigendumText}</textarea>
						</div>
						<div class="col-xs-2"></div>
						<div class="col-xs-10">
						<input type="hidden" name="tenderId" id="tenderId" value="${tenderId}">
                                    <spring:message code="label_submit" var="submitBtn"/>
                                        <button type="submit" class="btn btn-submit">${submitBtn}</button> 
                                        <span class="pull-right go-back"><spring:message code="link_goback_tenderdashbord" var="goBack"/>
                                        </span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
                   
</div>

</form>
</div>


<script type="text/javascript">
$("#corrigendumText").wysihtml5();
function validation(){
	var vbool = valOnSubmit();
	return disableBtn(vbool);
}
</script>
<%@include file="../../includes/footer.jsp"%>