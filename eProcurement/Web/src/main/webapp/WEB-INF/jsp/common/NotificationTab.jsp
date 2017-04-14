<%@include file="./../includes/head.jsp"%>

<%@include file="./../includes/masterheader.jsp"%>

<script src="${pageContext.request.contextPath}/resources/js/select2.full.min.js"></script>

<div class="content-wrapper">

	<section class="content-header">
		<h1>Notification</h1>
	</section>	
	
	<section class="content">
		<div class="row">
			<div class="col-xs-12">	
						
				<div class="row">
				
					<div class="col-xs-12">
						<c:if test="${not empty successMsg}">
							<c:choose>
								<c:when test="${fn:contains(successMsg, '_')}">
									<div class="alert alert-success">
										<spring:message code="${successMsg}" />
									</div>
								</c:when>
								<c:otherwise>
									<div class="alert alert-success">${successMsg}</div>
								</c:otherwise>
							</c:choose>
						</c:if>
					</div>
					
					<div class="col-xs-12">
						<c:if test="${not empty errorMsg}">
							<c:choose>
								<c:when test="${fn:contains(errorMsg, '_')}">
									<div class="alert alert-danger">
										<spring:message code="${errorMsg}" />
									</div>
								</c:when>
								<c:otherwise>
									<div class="alert alert-danger">${errorMsg}</div>
								</c:otherwise>
							</c:choose>
						</c:if>
					</div>
					
					<div class="col-xs-12">
						<form id="notiListForm" style="display: none;">
							<input type="hidden" columnname="marqueeTo"
								value="${sessionObject.userId}" class="searchEqual">
							<input type="hidden" columnname="m.isActive"
								id="activeCondition" value="1" class="searchEqual"> <input
								type="hidden" name="defaultOrder" id="defaultOrder"
								value="1:desc">
						</form>
					</div>
				
				</div>							
				
				<div class="box">
				<div class="box-body">
				<div class="nav-tabs-custom">
					<ul class="nav nav-tabs">
						<li class="active listingTab" tabindex="0"><a href="#">Current
								Notification</a>
						</li>
						<li class="listingTab" tabindex="1"><a href="#">All
								Notification</a>
						</li>
					</ul>				
					<div class="tab-content" id="listingDiv" style="width: 100%; overflow-y: auto;"></div>
				</div>
			</div>
			</div>
			</div>		
		</div>	
	</section>	
</div>
<script type="text/javascript">
loadListPage('listingDiv',39,'notiListForm');
$(".listingTab").click(function(){
	var tabIndex = $(this).attr("tabindex");
	if(tabIndex == 0){
		$("#activeCondition").val(1);
	}else{
		$("#activeCondition").val("");
	}
	loadListPage('listingDiv',39,'notiListForm');
	$(".listingTab").removeClass("active");
	$(this).addClass("active");
});
$(document).ready(function(){
	setTimeout(updateNotificationStatus,5000);
});
function updateNotificationStatus(){
	$.ajax({
		type : "GET",
		url : "${pageContext.servletContext.contextPath}/common/user/updateNotificationStatus/${sessionScope.userId}/0",
		success : function(data) {
			console.log(data);
		},
		error : function(e) {
			console.log(e);	
		},
	});		
}

$("select").select2({
    minimumResultsForSearch: Infinity,
    width:50
});
</script>
<%@include file="./../includes/footer.jsp"%>
