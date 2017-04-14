<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div class="row">
  <div class="col-md-12">
	<div class="box">
		<div class="box-header with-border">
			<h3 class="box-title"><spring:message code="lbl_view_summary" /></h3>
		</div>
		<div class="box-body">
			<div class="row">
				<div class="col-md-3">
					<spring:message code="fields_tenderid" />
				</div>
				<div class="col-md-3">${tblTender.tenderId}</div>
				<div class="col-md-3">
					<spring:message code="fields_refenceno" />
				</div>
				<div class="col-md-3">${tblTender.tenderNo}</div>
			</div>
			<div class="row">
				<div class="col-md-3">
					<spring:message code="field_brief" />
				</div>
				<div class="col-md-9">${tblTender.tenderBrief}</div>
			</div>
			<c:if test="${empty sessionUserTypeId and  sessionUserTypeId ne 2}">
			<div class="row">
				<div class="col-md-3 pullright nowrap" style="float: right;">
					<a href="${pageContext.servletContext.contextPath}/etender/buyer/viewtender/${tblTender.tenderId}/0">
					<spring:message code="label_tender_view" /></a>
					<c:if test="${tblTender.cstatus ne 2 }">
						| 
						<a href="#" onclick="copyTender();">Copy tender</a>
					</c:if>
					<c:if test="${tblTender.cstatus eq 0}">
			 		|&nbsp;
			 		<a href="${pageContext.servletContext.contextPath}/etender/buyer/deleteTender/${tenderId}" onclick="return confirm('<spring:message code="msg_tender_delete_confirm"/>')"><spring:message
								code="link_tender_delete" />
					</a>
					</c:if>
				</div>
			</div>
			</c:if>
		</div>
	</div>
  </div>
</div>

<script>
function copyTender(){
	 var tenderId='${tblTender.tenderId}';
    if(confirm('<spring:message code="msg_tender_cnfrm_copytender" />')){
   	 $(".successMsg").hide();
   	 window.location = "${pageContext.servletContext.contextPath}/etender/buyer/copytender/"+tenderId;
   }
}
</script>