<%@include file="./../includes/head.jsp"%>
 <%@include file="./../includes/masterheader.jsp"%>

 <div class="content-wrapper">

<section class="content-header">
	<h1>
<%-- 		<div class="pull-left" style="cursor:pointer;"><a href="${pageContext.servletContext.contextPath}/eBid/Bid/createAuction/0">Create Auction</a></div>
 --%>		<div class="pull-right" style="cursor:pointer;"><a onclick="showHideSearch()"><spring:message code="lbl_advance_auction_search" /></a></div>
	</h1>
</section>

<section class="content">
	<div class="row">
		<div class="col-md-12">
			<div class="box">
				<div class="box-body">
							<form id="tenderListForm" style="display: none;">
								<div class="row">
									<div class="col-md-3">
										<%-- <spring:message code="fields_tenderid" /> --%>
										<spring:message code="lbl_auction_id" />
									</div>
									<div class="col-md-3">
										<input type="text" class="searchLike form-control"
											columnname="tenderId">
									</div>
									<div class="col-md-3">
										<%-- <spring:message code="fields_refenceno" /> --%>
										<spring:message code="lbl_auction_ref_no" />
									</div>
									<div class="col-md-3">
										<input type="text" class="searchLike form-control"
											columnname="tenderNo">
									</div>
								</div>
								<div class="row">
									<div class="col-md-3">
										<%-- <spring:message code="field_brief" /> --%>
										<spring:message code="lbl_auction_brief" />
									</div>
									<div class="col-md-3">
										<input type="text" class="searchLike form-control"
											columnname="tenderBrief">
									</div>
									<div class="col-md-3">
										<spring:message code="fields_tender_keywords" />
									</div>
									<div class="col-md-3">
										<input type="text" class="searchLike form-control"
											columnname="keywordText">
									</div>
								</div>
								<div class="row">
									<div class="col-md-3">
										<spring:message code="lbl_due_date" />
									</div>
									<div class="col-md-3">
										<select name="dateFrom1" class="dateFrom1" id="dateFrom1"
											onchange="checkBetween1(this);" class="form-control">
											 <option value="searchEqual"><spring:message code="lbl_equal" /></option>
                     <option value="searchNotEqual"><spring:message code="lbl_not_equal" /></option>
                     <option value="searchLessThen"><spring:message code="lbl_less" /></option>
                     <option value="searchLessThenEqual"><spring:message code="lbl_less_or_equal" /></option>
                     <option value="searchGreaterThen"><spring:message code="lbl_greater" /></option>
                     <option value="searchGreaterEqual"><spring:message code="lbl_grater_or_equal" /></option>
                     <option value="searchBetweenDate"><spring:message code="lbl_between" /></option>
										</select>
									</div>
									<div class="col-md-3">
										<input id="submissionEndDate" columnname="submissionEndDate"
											name="submissionEndDate" type="text" datepicker="yes"
											placeholder="${client_dateformate_hhmm}" title="Date" dateBox="true"
											class="form-control">
									</div>
									<div class="col-md-3" id="div_submissionEndDate_to"
										style="display: none;">
										<input id="submissionEndDate_to" name="submissionEndDate_to"
											columnname="submissionEndDate" type="text" datepicker="yes"
											placeholder="${client_dateformate_hhmm}" title="Date" dateBox="true"
											class="form-control">
									</div>
								</div>
								<div class="row">
									<div class="col-md-3">
										<spring:message code="field_bidopeningstartdate" />
									</div>
									<div class="col-md-3">
										<select name="dateFrom" class="dateFrom" id="dateFrom"
											onchange="checkBetween(this);" class="form-control">
											 <option value="searchEqual"><spring:message code="lbl_equal" /></option>
                     <option value="searchNotEqual"><spring:message code="lbl_not_equal" /></option>
                     <option value="searchLessThen"><spring:message code="lbl_less" /></option>
                     <option value="searchLessThenEqual"><spring:message code="lbl_less_or_equal" /></option>
                     <option value="searchGreaterThen"><spring:message code="lbl_greater" /></option>
                     <option value="searchGreaterEqual"><spring:message code="lbl_grater_or_equal" /></option>
                     <option value="searchBetweenDate"><spring:message code="lbl_between" /></option>
										</select>
									</div>
									<div class="col-md-3">
										<input id="bidOpeningDate" columnname="openingDate"
											name="bidOpeningDate" type="text" datepicker="yes"
											placeholder="${client_dateformate_hhmm}" title="Date" dateBox="true"
											class="form-control">
									</div>
									<div class="col-md-3" id="div_bidOpeningDate_to"
										style="display: none;">
										<input id="bidOpeningDate_to" name="bidOpeningDate_to"
											columnname="openingDate" type="text" datepicker="yes"
											placeholder="${client_dateformate_hhmm}" title="Date" dateBox="true"
											class="form-control">
									</div>
								</div>
								<div class="row">
									<div class="col-md-3"><spring:message code="field_search_for" /></div>
									<div class="col-md-3">
										<select name="searchToTab" id="searchToTab"
											class="form-control">
											<option value=""><spring:message code="col_select" /></option>
											 <option selected="selected" value="18"><spring:message code="lbl_all" /></option>
                     <option value="1"><spring:message code="col_open_pending" /></option>
                     <option value="6"><spring:message code="lbl_live" /></option>
                     <option value="4"><spring:message code="lbl_future" /></option>
                     <option value="5"><spring:message code="lbl_archive" /></option>
                     <option value="17"><spring:message code="lbl_cancel" /></option>
										</select>
									</div>
								</div>
								<div class="row">
									<div class="col-md-3">
										<input type="hidden" name="jsonSearchCriteria"
											id="jsonSearchCriteria"> <input type="button"
											onclick="searchForList()" class="btn-sm form-control"
											value="Search"> <input type="hidden"
											name="defaultOrder" id="defaultOrder" value="1:desc">

									</div>
									<div class="col-md-3">
										<input type="reset" class="btn-sm form-control" value="Clear"
											onclick="location.reload();">
									</div>
								</div>
							</form>
							
							<div class="row">
								<div class="col-md-12">
									<section class="">
									<div class="nav-tabs-custom">
										<ul class="nav nav-tabs">
											<li class="active listingTab" tabindex="29">
												<a href="#"><spring:message code="col_open_pending" />
												 	<span class="pull-right-container">
                                                		<small class="label pull-right bg-light-white txt-light-blue mar-left-5 pendingCount">
                                                			${auctionCount.pending}
 														</small>
 													</span>		                                               		
                                            	</a>
											</li>
											<li class="listingTab" tabindex="30">
												<a href="#"><spring:message code="lbl_live" />
													<span class="pull-right-container">
                                                		<small class="label pull-right bg-light-white txt-light-blue mar-left-5 liveCount">
															${auctionCount.live}
														</small>
 													</span>		
												</a>
											</li>
											<li class="listingTab" tabindex="32">
												<a href="#"><spring:message code="lbl_future" />
													<span class="pull-right-container">
		                                           		<small class="label pull-right bg-light-white txt-light-blue mar-left-5 futureCount">
															${auctionCount.future}
														</small>
		 											</span>		
												</a>
											</li>
											<li class="listingTab" tabindex="33">
												<a href="#"><spring:message code="lbl_archive" />
													<span class="pull-right-container">
                                                		<small class="label pull-right bg-light-white txt-light-blue mar-left-5  archiveCount">
															${auctionCount.archive}
														</small>
		 											</span>
												</a>
											</li>
											<li class="listingTab" tabindex="34">
												<a href="#"><spring:message code="lbl_cancel" />
													<span class="pull-right-container">
                                               			<small class="label pull-right bg-light-white txt-light-blue mar-left-5 cancelCount">
															${auctionCount.cancel}
														</small>
		 											</span>	
												</a>
											</li>
											<li class="listingTab" tabindex="35">
												<a href="#"><spring:message code="lbl_all" />
													<span class="pull-right-container">
                                                		<small class="label pull-right bg-light-white txt-light-blue mar-left-5  allCount">
															${auctionCount.total}
														</small>
		 											</span>			
												</a>
											</li>
										</ul>
										</div>
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
$(document).ready(function(){
	toDateFormate = '<spring:message code="client_dateformate_hhmm" />';
	$("[dateBox='true']").each(function(){
		$(this).datetimepicker({
			format:'d-M-Y H:i'
		});
	});
	loadListPage('listingDiv',29,'tenderListForm');
	checkBetween($("#dateFrom"));
	checkBetween1($("#dateFrom1"));
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
        var colIndx = getColumnIndex('Auction Id.');
	colIndx++;
	if(actionname.toLowerCase() == "edit"){
		var tenderId = $(cthis).closest("tr").find('td:nth-child('+colIndx+')').html()
		window.location = "${pageContext.servletContext.contextPath}/eBid/Bid/createAuction/"+tenderId
	}else if(actionname.toLowerCase() == "view"){
		var tenderId = $(cthis).closest("tr").find('td:nth-child('+colIndx+')').html()
		window.location = "${pageContext.servletContext.contextPath}/eBid/Bid/viewAuction/"+tenderId+"/0"
	}else if(actionname.toLowerCase() == "dashboard"){
		var tenderId = $(cthis).closest("tr").find('td:nth-child('+colIndx+')').html()
		window.location = "${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/"+tenderId
	}
        else if(actionname.toLowerCase() == "viewreport")
        {
            var tenderId = $(cthis).closest("tr").find('td:nth-child('+colIndx+')').html()
            window.location = "${pageContext.servletContext.contextPath}/eBid/Bid/viewResult/"+tenderId
            
        }
}
$(".listingTab").click(function(){
	var tabIndex = $(this).attr("tabindex");
	loadListPage('listingDiv',tabIndex,'tenderListForm');
	$(".listingTab").removeClass("active");
	$(this).addClass("active");
	reSetCountIfNowMatch(2);
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
<%@include file="../includes/footer.jsp"%>
