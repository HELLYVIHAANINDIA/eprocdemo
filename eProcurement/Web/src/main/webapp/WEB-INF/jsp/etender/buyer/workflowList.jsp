<%@include file="../../includes/head.jsp"%>

<%@include file="../../includes/masterheader.jsp"%>
<jsp:useBean id="now" class="java.util.Date" />
<c:if test="${processstatus eq 0}">
<c:set value="workflow-pending" var="idName"></c:set>	
</c:if>
<c:if test="${processstatus eq 1}">
<c:set value="workflow-process" var="idName"></c:set>
</c:if>
<div class="content-wrapper">
	<section class="content-header">
		<h1></h1>
	</section>
	
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<div class="box-body">
							<div class="row">
								<div class="col-md-12">
									<c:if test="${not empty successMsg}">
										<div class="alert alert-success">${successMsg}</div>
									</c:if>
								</div>
								<div class="col-md-12">
									<form id="tenderListForm">
										<input type="hidden" name="clientDateFormate"
											id="clientDateFormate"
											value='<spring:message code="client_dateformate_hhmm" />'>
										<c:if test="${processstatus eq 0}">
											<input type="hidden" class="searchEqual form-control"
												columnname="officerId" value="${officerId}">
										</c:if>
										<c:if test="${processstatus eq 1}">
											<input type="hidden" class="searchEqual form-control"
												columnname="createdById" value="${officerId}">
										</c:if>
										<input type="hidden" name="jsonSearchCriteria"
											id="jsonSearchCriteria">
											<input type="hidden" class="searchEqual form-control isAuction" columnname="isAuction" value="0">
									</form>
								</div>
								<div class="col-md-12">
									<div class="alert alert-info">
										<c:if test="${processstatus eq 0}">
											<spring:message code="lbl_workflow_pending" />
										</c:if>
										<c:if test="${processstatus eq 1}">
											<spring:message code="lbl_workflow_processed" />
										</c:if>
									</div>
								</div>
								<div class="col-md-12">
								<div class="nav-tabs-custom">
								<ul class="nav nav-tabs">
									<li class="active listingTab" isAuction="0"><a href="#">Tender</a>
									</li>
									<li class="listingTab" isAuction="1"><a href="#">Auction</a>
									</li>
								</ul>
							</div>
							</div>
							
								<div class="col-md-12">
									<section class="">
										<div id="listingDiv"></div>
									</section>
								</div>
							</div>
							
						</div>
				</div>
			</div>
		</div>
	</section>

	</div>
<script type="text/javascript">
//loadListPage('listingDiv',1,'tenderListForm');
function callActionItem(cthis){
	var actionname = $(cthis).attr("actionname").toLowerCase();
	var tenderIdIndx = getColumnIndex('Event No.');
	var corrigendumIdIndx = getColumnIndex('corrigendumId');
	var tenderId = $(cthis).closest("tr").find('td:nth-child('+(tenderIdIndx+1)+')').html();
	var corrigendumId = $(cthis).closest("tr").find('td:nth-child('+(corrigendumIdIndx+1)+')').html();
	window.location = "${pageContext.servletContext.contextPath}/etender/buyer/viewtenderworkflow/"+tenderId+"/"+corrigendumId
}
var tabIndex = 0;
<c:if test="${processstatus eq 0}">
	tabIndex = 11;
</c:if>
<c:if test="${processstatus eq 1}">
	tabIndex = 12;
</c:if>


<c:if test="${processstatus eq 0}">
loadListPage('listingDiv',tabIndex,'tenderListForm');
</c:if>
<c:if test="${processstatus eq 1}">
loadListPage('listingDiv',tabIndex,'tenderListForm');
</c:if>
toDateFormate = $("#clientDateFormate").val();
$(".listingTab").click(function(){
	var isAuction = $(this).attr("isAuction");
	$(".isAuction").val(isAuction);
	loadListPage('listingDiv',tabIndex,'tenderListForm');
	$(".listingTab").removeClass("active");
	$(this).addClass("active");
})
</script>
<%@include file="../../includes/footer.jsp"%>