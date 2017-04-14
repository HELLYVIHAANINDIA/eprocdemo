<%@include file="../../includes/head.jsp"%>
<jsp:useBean id="now" class="java.util.Date" />
<%@include file="../../includes/masterheader.jsp"%>
<div class="content-wrapper">
<section class="content-header">
<c:choose>
<c:when test="${committeeType eq 1}">
<h1><spring:message code="lbl_tender_opening" /></h1>
</c:when>
<c:when test="${committeeType eq 2}">
<h1><spring:message code="lbl_tender_evaluation" /></h1>
</c:when>
</c:choose>
	
</section>

<section class="content">
	<div class="row">
		<div class="col-md-12">
			<div class="box">
				<div class="box-body" style="overflow: auto;width: 100%;">
					<div class="row">
								<div class="col-md-12">
									<c:if test="${not empty successMsg}">
										<div class="alert alert-success">${successMsg}</div>
									</c:if>
								</div>
							</div>
		<form id="tenderListForm" style="display: none;">
		<c:choose>
			<c:when test="${committeeType eq 1}">
					<input type="hidden" class="searchEqual isEvaluationDone" columnName="t.isEvaluationDone" value="0">
			</c:when>
			<c:when test="${committeeType eq 2}">
					<input type="hidden" class="searchEqual isEvaluationDone" columnName="t.isEvaluationDone" value="0">
			</c:when>
		</c:choose>
			<input type="hidden" class="searchEqual" columnName="c.committeeType" value="${committeeType}">
		</form>
		<div class="row">
	<div class="col-md-12">
		<section class="">
				<div class="nav-tabs-custom">
					<ul class="nav nav-tabs"> 
					  <li class="active listingTab" isEvaluationDone="0" tabindex="26"><a href="#">Pending 
					   <span class="pull-right-container">
                                                <small class="label pull-right bg-light-white txt-light-blue mar-left-5">${tenderEvaluationPendingCount.pending}
                                                </small>
                                                </span></a></li>
					  <li class="listingTab" isEvaluationDone="1"  tabindex="26" ><a href="#">Processed  <span class="pull-right-container">
                                                <small class="label pull-right bg-light-white txt-light-blue mar-left-5"> ${tenderEvaluationProcessCount.pending}</small>
                                                </span></a></li>
					</ul>
				</div> 
				<div id="listingDiv">
				</div>
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
$(document).ready(function(){
	loadListPage('listingDiv',26,'tenderListForm');
});
function showHideSearch(){
	if($("#tenderListForm").css("display") == "none"){
		$("#tenderListForm").show();
	}else{
		$("#tenderListForm").hide();
	}
}
function callActionItem(cthis){
	var actionname = $(cthis).attr("actionname").toLowerCase();
	var colIndx = getColumnIndex('Tender Id.');
	colIndx++;
	if(actionname.toLowerCase() == "edit"){
		var tenderId = $(cthis).closest("tr").find('td:nth-child('+colIndx+')').html()
		window.location = "${pageContext.servletContext.contextPath}/etender/buyer/createevent/"+tenderId
	}else if(actionname.toLowerCase() == "view"){
		var tenderId = $(cthis).closest("tr").find('td:nth-child('+colIndx+')').html()
		window.location = "${pageContext.servletContext.contextPath}/etender/buyer/viewtender/"+tenderId+"/0"
	}else if(actionname.toLowerCase() == "dashboard"){
		var tenderId = $(cthis).closest("tr").find('td:nth-child('+colIndx+')').html()
		window.location = "${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/"+tenderId
	}
}
$(".listingTab").click(function(){
	var tabIndex = $(this).attr("tabindex");
	var isEvaluationDone = $(this).attr("isEvaluationDone");
	$(".isEvaluationDone").val(isEvaluationDone);
	loadListPage('listingDiv',tabIndex,'tenderListForm');
	$(".listingTab").removeClass("active");
	$(this).addClass("active");
})
function checkBetween1(obj)
{
	if($(obj).val() == 'searchBetweenDate')
	{
		$("#submissionEndDate").attr("class","dateBox searchBetween1 form-control");
		$("#submissionEndDate_to").attr("class","dateBox searchBetween2 form-control");
		
		$("#div_submissionEndDate_to").show();
		$("#div_submissionEndDate_to").show();

	}
	else
	{
		$("#div_submissionEndDate_to").hide();
		$("#submissionEndDate").removeAttr("class");
		$("#submissionEndDate_to").removeAttr("class");
		$("#submissionEndDate").attr("class",$(obj).val()+" dateBox form-control");
	}
}

function checkBetween(obj)
{
	if($(obj).val() == 'searchBetweenDate')
	{
		$("#bidOpeningDate").attr("class","dateBox searchBetween1 form-control");
		$("#bidOpeningDate_to").attr("class","dateBox searchBetween2 form-control");
		
		$("#div_bidOpeningDate_to").show();
		$("#div_bidOpeningDate_to").show();

	}
	else
	{
		$("#div_bidOpeningDate_to").hide();
		$("#bidOpeningDate").removeAttr("class");
		$("#bidOpeningDate_to").removeAttr("class");
		$("#bidOpeningDate").attr("class",$(obj).val()+" dateBox form-control");
	}
}
function searchForList(){
	if($("#searchToTab").val() == ""){
		var tabIndex = $(".listingTab.active").attr("tabindex");
		loadListPage('listingDiv',tabIndex,'tenderListForm')
	}else{
		loadListPage('listingDiv',$("#searchToTab").val(),'tenderListForm');
		$(".listingTab").removeClass("active");
		$(".listingTab[tabindex='"+$("#searchToTab").val()+"']").addClass("active");
	}
}
</script>
<%@include file="../../includes/footer.jsp"%>