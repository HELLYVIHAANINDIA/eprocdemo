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
							<h3 class="box-title">Manage Purchase order</h3>
						</div>
						<div class="box-body">
							<div class="row">
								<div class="col-lg-12 col-md-12 col-xs-12">
									<div class="box-body pad" id="prebid">
										<div id="listingDiv">
										</div>				               
				            		</div>
			            		</div>
          					</div>
     				</div>
 		</div>
</div>
</div>
</section>
</div>
<script type="text/javascript">
loadListPage('listingDiv',41);
function callActionItem(cthis){
	var actionname = $(cthis).attr("actionname");
	console.log(actionname);
	if(actionname.toLowerCase() == "dashboard"){
		var poid  = getColumnIndex('poId');
		var tenderId  = getColumnIndex('tenderId');
		poid = $(cthis).closest("tr").find('td:nth-child('+(poid+1)+')').html();
		tenderId = $(cthis).closest("tr").find('td:nth-child('+(tenderId+1)+')').html();
		window.location = "${pageContext.servletContext.contextPath}/etender/buyer/getpurchaseorderdashboard/"+tenderId+"/"+poid;
	}
}
</script>
<%@include file="../../includes/footer.jsp"%>