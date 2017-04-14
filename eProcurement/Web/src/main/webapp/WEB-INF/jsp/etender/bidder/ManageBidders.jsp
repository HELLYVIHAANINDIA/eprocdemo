      <%@include file="../../includes/head.jsp"%>
      <%@include file="../../includes/masterheader.jsp"%>
        <spring:message code="lbl_manage_bidder" var="lbl_manage_bidder"/>
    <div class="content-wrapper">
<section class="content-header">
<h1>Administration</h1>
</section>

<section class="content">
<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="box">
						<div class="box-header with-border">
						<c:if test="${not empty successMsg}">
                                        			<div class="alert alert-success"><spring:message code="${successMsg}"/></div>
                                    		</c:if>
                                    		<c:if test="${not empty errorMsg}">
                                        			<div class="alert alert-danger"><spring:message code="${errorMsg}"/></div>
                                    		</c:if>
	               						<h3 class="box-title">${lbl_manage_bidder}</h3>											
						</div>
					<div class="box-body">
							<div class="row">
								<div class="col-lg-12 col-md-12 col-xs-12">
									<section class="">
									<div class="nav-tabs-custom">
										<ul class="nav nav-tabs">
										  <li class="active listingTab" tabindex="8"><a href="#">Pending</a></li>
										  <li class="listingTab" tabindex="24"><a href="#">Approved</a></li>
										  <li class="listingTab" tabindex="28"><a href="#">Rejected</a></li>
										  <li class="listingTab" tabindex="25"><a href="#" >Deactivated</a></li>
										</ul>
										</div>
										<div id="listingDiv">
										</div>
								     </section>
								</div>
								<form id="tenderListForm" style="display: none;">
									<input type="hidden"  name="defaultOrder" id="defaultOrder" value="6:Desc">
								</form>
							</div>
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
loadListPage('listingDiv',8);
function callActionItem(cthis){
	var actionname = $(cthis).attr("actionname");
	var tabId = $(".listingTab.active").attr("tabindex");
	console.log(actionname);
	if(actionname.toLowerCase() == "edit"){
		var officerId  = getColumnIndex('bidderId');
		officerId = $(cthis).closest("tr").find('td:nth-child('+(officerId+1)+')').html();
		window.location = "${pageContext.servletContext.contextPath}/common/user/geteditbidder/"+officerId+"/0/0";
	}
	if(actionname.toLowerCase() == "deactivate"){
		var officerId  = getColumnIndex('bidderId');
		officerId = $(cthis).closest("tr").find('td:nth-child('+(officerId+1)+')').html();
		window.location = "${pageContext.servletContext.contextPath}/common/user/getuserstatus/"+officerId+"/3/"+tabId+"/0";
	}
	if(actionname.toLowerCase() == "activate"){
		var officerId  = getColumnIndex('bidderId');
		officerId = $(cthis).closest("tr").find('td:nth-child('+(officerId+1)+')').html();
		window.location = "${pageContext.servletContext.contextPath}/common/user/getuserstatus/"+officerId+"/1/"+tabId+"/0";
	}
	if(actionname.toLowerCase() == "reject"){
		var officerId  = getColumnIndex('bidderId');
		officerId = $(cthis).closest("tr").find('td:nth-child('+(officerId+1)+')').html();
		window.location = "${pageContext.servletContext.contextPath}/common/user/getuserstatus/"+officerId+"/2/"+tabId+"/0";
	}
	if(actionname.toLowerCase() == "view"){
		var officerId  = getColumnIndex('bidderId');
		officerId = $(cthis).closest("tr").find('td:nth-child('+(officerId+1)+')').html();
		window.location = "${pageContext.servletContext.contextPath}/common/user/getuserstatus/"+officerId+"/1/"+tabId+"/1";
	}
	if(actionname.toLowerCase() == "approve/reject"){
		var officerId  = getColumnIndex('bidderId');
		officerId = $(cthis).closest("tr").find('td:nth-child('+(officerId+1)+')').html();
		window.location = "${pageContext.servletContext.contextPath}/common/user/getuserstatus/"+officerId+"/1/"+tabId+"/0";
	}
}
</script>
  <%@include file="./../../includes/footer.jsp"%>