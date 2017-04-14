<%@include file="../../includes/head.jsp"%>
<%@include file="../../includes/masterheader.jsp"%>
<div class="content-wrapper">
		<section class="content-header">
<!-- 		onsubmit="return validation();" -->
<form id="tenderDtBean" name="tenderDtBean" onsubmit="return validation();" action="${pageContext.servletContext.contextPath}/etender/buyer/submittendercorrigendum" method="post" >
<div class="main_container o-hidden" id="temp">
<c:forEach items="${tblCorrigendum}" var="items">
	<c:if test="${items.cstatus eq '0'}">
		<c:set value="${items.corrigendumId}" var="corrigendumId"/>
	</c:if>
</c:forEach>
          <div class="panel-container">
               <div class="page-title prefix_1 o-hidden">
                  <h1 class="pull-left grid_12">
                      <spring:message code="link_create_corrigendum"/></h1>
                      <c:if test="${opType ne 'edit'}">
                      Create
                      </c:if>
                      <c:if test="${opType eq 'edit'}">
                      Edit
                      </c:if>
                      <a href="${pageContext.servletContext.contextPath}/etender/buyer/createcorrigendum/${tenderId}">Edit Corrigendum Text</a>
                      <a href="${pageContext.servletContext.contextPath}/etender/buyer/tendercorrigendum/${tenderId}/${corrigendumId}">Edit Notice Corrigendum</a>
                      <a href="${pageContext.servletContext.contextPath}/etender/buyer/viewcorrigendum/${tenderId}">View Corrigendum</a>
                  </div>
				<c:if test="${not empty tblCorrigendum }">
					<c:forEach items="${tblCorrigendum}" var="items">
						<c:if test="${items.cstatus eq '0'}">
							<div class="col-md-12 border">
								<div class="col-md-3">
									<spring:message code="lbl_create_corrigendum_text"></spring:message>
								</div>
								<div class="col-md-3">${items.corrigendumText}</div>
								<div class="col-md-3"></div>
							</div>
						</c:if>
					</c:forEach>
				</c:if>
					</div></div></form>
         	</section></div>
<script type="text/javascript">
$("#corrigendumText").wysihtml5();
</script>
<%@include file="../../includes/footer.jsp"%>