<%@include file="../../includes/head.jsp"%>
<%@include file="../../includes/masterheader.jsp"%>
<spring:message code="lbl_live" var="meetingLive" />
<spring:message code="lbl_not_started" var="meetingNotStart"/>
<spring:message code="lbl_close" var="meetingOver"/>
<spring:message code="lbl_online" var="onlineMode"/>
<spring:message code="lbl_offline" var="offlineMode"/>
<spring:message code="title_tender_createcomitee" var="prebidcommittee"/>
	   

<div class="content-wrapper">
<section class="content">
	<div class="row">
<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					 
					<div class="box">
						<div class="box-header with-border">
							<h3 class="box-title">PO dashboard</h3>
						</div>
						<div class="box-body">
							<a href="${pageContext.servletContext.contextPath}/etender/bidder/biddingTenderDashboard/${tenderId}"><< GO to tender dashboard </a>
							
          <div class="box-body">
							<div class="row">
								<div class="col-lg-12 col-md-12 col-xs-12">
									<section class="">
									<div class="nav-tabs-custom">
										<ul class="nav nav-tabs">
										  <li class="active listingTab" tabindex="47"><a href="#">PO</a></li>
										</ul>
										</div>
										<div id="listingDiv">
										</div>
								     </section>
								</div>
							</div>
						</div>
						<form id="tenderListForm" style="display: none;">
								<input type="hidden" value="${tenderId}" class="searchEqual" columnName="po.tenderId" name="tenderId">
								<input type="hidden" value="${sessionObject.bidderId}" class="searchEqual" columnName="po.bidderId" name="bidderId">
								<input type="hidden"  id="jsonSearchCriteria" name="jsonSearchCriteria">
						</form>
          
          
     </div>
 </div>
</div>
</div>
</section>
</div>
<script type="text/javascript">
$(".listingTab").click(function(){
	var tabIndex = $(this).attr("tabindex");
	loadListPage('listingDiv',tabIndex);
	$(".listingTab").removeClass("active");
	$(this).addClass("active");
})
loadListPage('listingDiv',47);
function callActionItem(cthis){
	var actionname = $(cthis).attr("actionname");
	var tabId = $(".listingTab.active").attr("tabindex");
	console.log(actionname);
	if(actionname.toLowerCase() == "edit"){
		var poId  = getColumnIndex('poId');
		var bidderId  = getColumnIndex('bidderId');
		bidderId = $(cthis).closest("tr").find('td:nth-child('+(bidderId+1)+')').html();
		poId = $(cthis).closest("tr").find('td:nth-child('+(poId+1)+')').html();
		window.location = "${pageContext.servletContext.contextPath}/etender/buyer/geteditpurchaseorder/"+${tenderId}+"/"+bidderId+"/"+poId;
	}
	if(actionname.toLowerCase() == "upload document"){
		var poId  = getColumnIndex('poId');
		poId = $(cthis).closest("tr").find('td:nth-child('+(poId+1)+')').html();
		window.location = "${pageContext.servletContext.contextPath}/etender/buyer/uploadpurchaseorderdoc/"+${tenderId}+"/"+poId;
	}
	if(actionname.toLowerCase() == "publish"){
		var poId  = getColumnIndex('poId');
		var bidderId  = getColumnIndex('bidderId');
		bidderId = $(cthis).closest("tr").find('td:nth-child('+(bidderId+1)+')').html();
		poId = $(cthis).closest("tr").find('td:nth-child('+(poId+1)+')').html();
		window.location = "${pageContext.servletContext.contextPath}/etender/buyer/publishpurchaseorder/"+${tenderId}+"/"+bidderId+"/"+poId;
	}
	if(actionname.toLowerCase() == "acknowledge"){
		var poId  = getColumnIndex('poId');
		var bidderId  = getColumnIndex('bidderId');
		bidderId = $(cthis).closest("tr").find('td:nth-child('+(bidderId+1)+')').html();
		poId = $(cthis).closest("tr").find('td:nth-child('+(poId+1)+')').html();
		window.location = "${pageContext.servletContext.contextPath}/etender/bidder/getacknowledge/"+${tenderId}+"/"+${sessionObject.bidderId}+"/"+poId;
	}
}
</script>
<%@include file="../../includes/footer.jsp"%>