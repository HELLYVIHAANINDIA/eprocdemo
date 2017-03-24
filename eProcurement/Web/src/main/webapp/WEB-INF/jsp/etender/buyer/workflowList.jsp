<!DOCTYPE html>
<html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<%@include file="../../includes/header.jsp"%>
<script src="${pageContext.request.contextPath}/resources/js/commonListing.js"></script>
</head>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="../../includes/leftaccordion.jsp"%>

	<div class="content-wrapper">
	
	<section class="content-header"></section>
	
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
	
	<%@include file="../../includes/footer.jsp"%>
	
	</div>
	<script type="text/javascript">
		//loadListPage('listingDiv',1,'tenderListForm');
		function callActionItem(cthis) {
			var actionname = $(cthis).attr("actionname").toLowerCase();
			var tenderIdIndx = getColumnIndex('Event No.');
			var corrigendumIdIndx = getColumnIndex('corrigendumId');
			var tenderId = $(cthis).closest("tr").find(
					'td:nth-child(' + (tenderIdIndx + 1) + ')').html();
			var corrigendumId = $(cthis).closest("tr").find(
					'td:nth-child(' + (corrigendumIdIndx + 1) + ')').html();
			window.location = "${pageContext.servletContext.contextPath}/etender/buyer/viewtenderworkflow/"
					+ tenderId + "/" + corrigendumId
		}
		<c:if test="${processstatus eq 0}">
		loadListPage('listingDiv', 11, 'tenderListForm');
		</c:if>
		<c:if test="${processstatus eq 1}">
		loadListPage('listingDiv', 12, 'tenderListForm');
		</c:if>
		toDateFormate = $("#clientDateFormate").val();
		/* $(".listingTab").click(function(){
		 var tabIndex = $(this).attr("tabIndex");
		 loadListPage('listingDiv',tabIndex,'tenderListForm');
		 $(".listingTab").removeClass("active");
		 $(this).addClass("active");
		 }) */
	</script>
</body>
</html>