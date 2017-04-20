<%@include file="../../includes/head.jsp"%>
<%@include file="../../includes/masterheader.jsp"%>
<jsp:useBean id="now" class="java.util.Date" />
<c:if test="${isAuction eq 0}">
	<c:set var="idName" value="bidd-tender"></c:set>
</c:if>
<c:if test="${isAuction eq 1}">
	<c:set var="idName" value="bidd-auction"></c:set>
</c:if>

<spring:message code="client_dateformate_hhmm" var="client_dateformate_hhmm" />

<div class="content-wrapper">

<section class="content-header">
		<c:choose>
			<c:when test="${isAuction eq 0}">
				<h1>
					<a onclick="showHideSearch()">
					<spring:message
							code="lbl_advance_tender_search" /></a>
				</h1>
			</c:when>
			<c:otherwise>
				<h1>
					<a onclick="showHideSearch()"><spring:message
							code="lbl_advance_auction_search" /></a>
				</h1>
			</c:otherwise>
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
							</div>
							
								<form id="tenderListForm" style="display: none;">
								<input type="hidden" class="searchEqual form-control" columnname="isAuction" value="${isAuction}">
								
			<div class="row">
				<div class="col-md-3">
					<label class="lbl-fields"><spring:message code="fields_tenderid" /></label>
				</div> 
				<div class="col-md-3">
					<input type="text" class="searchLike form-control" columnname="tenderId">
				</div>
				<div class="col-md-3">
					<label class="lbl-fields"><spring:message code="fields_refenceno" /></label>
				</div>
				<div class="col-md-3">
					<input type="text" class="searchLike form-control" columnname="tenderNo">
				</div>
			</div>
			<div class="row">
				<div class="col-md-3">
					<label class="lbl-fields"><spring:message code="field_brief" /></label>
				</div>
				<div class="col-md-3">
					<input type="text" class="searchLike form-control" columnname="tenderBrief">
				</div>
					<div class="col-md-3">
					<label class="lbl-fields"><spring:message code="fields_tender_keywords" /></label>
				</div>
				<div class="col-md-3">
					<input type="text" class="searchLike form-control" columnname="keywordText">
				</div>
			</div>
			<div class="row">
				<div class="col-md-3">
					<label class="lbl-fields"><spring:message code="lbl_due_date" /></label>
				</div> 
                 <div class="col-md-3">
                     <select name="dateFrom1" class="dateFrom1 form-control" id="dateFrom1" onchange="checkBetween1(this);">
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
                 	<input id="submissionEndDate" columnname="submissionEndDate" name="submissionEndDate" type="text" datepicker="yes" placeholder="${client_dateformate_hhmm}" title="Date" dateBox="true" class="form-control">
                 </div>
           		<div class="col-md-3" id="div_submissionEndDate_to" style="display: none;">
	               <input id="submissionEndDate_to" name="submissionEndDate_to" columnname="submissionEndDate"  type="text" datepicker="yes" placeholder="${client_dateformate_hhmm}" title="Date" dateBox="true" class="form-control">
	            </div>
			</div>
			<div class="row">
				<div class="col-md-3">
					<label class="lbl-fields"><spring:message code="field_bidopeningstartdate" /></label>
				</div> 
                 <div class="col-md-3">
                     <select name="dateFrom" class="dateFrom form-control" id="dateFrom" onchange="checkBetween(this);">
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
                 	<input id="bidOpeningDate" columnname="openingDate" name="bidOpeningDate" type="text" datepicker="yes" placeholder="${client_dateformate_hhmm}" title="Date" dateBox="true" class="form-control">
                 </div>
           		<div class="col-md-3" id="div_bidOpeningDate_to" style="display: none;">
	               <input id="bidOpeningDate_to" name="bidOpeningDate_to" columnname="openingDate"  type="text" datepicker="yes" placeholder="${client_dateformate_hhmm}" title="Date" dateBox="true" class="form-control">
	            </div>
			</div>
			<div class="row">
				<div class="col-md-3">
					<label class="lbl-fields"><spring:message code="field_search_for" /></label>
				</div>
				<div class="col-md-3">
					<select name="searchToTab" id="searchToTab" class="form-control">
                     <option value=""><spring:message code="label_select" /></option>
                     <option selected="selected" value="18"><spring:message code="lbl_select_all" /></option>
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
					
				</div>
				<div class="col-md-3">
					<input type="hidden" name="jsonSearchCriteria" id="jsonSearchCriteria"> 
					<input type="button" onclick="searchForList()" class="search-button" value="Search">
					<input type="hidden" name="defaultOrder" id="defaultOrder" value="1:desc">
					<c:forEach items="${deptId}" var="deptVar">
						<input type="hidden" class="searchIn" columnName="departmentId" value="${deptVar}">
					</c:forEach>
					<input type="reset" class="clear-button" value="Clear" onclick="location.reload();">
				</div>
				
			</div>
		</form>

							<div class="row">
								<div class="col-md-12">
									<section class="">
									<div class="nav-tabs-custom">
										<ul class="nav nav-tabs">
											<c:if test="${isAuction eq 0}">
												<li class="listingTab active" tabIndex="10">
													<a href="#"><spring:message code="lbl_live" />
												 		<span class="pull-right-container">
                                                			<small class="label pull-right bg-light-white txt-light-blue mar-left-5 liveCount recordCount">
                                                				${tenderCount.live}
                                                			</small>
														</span>                                                				
                                             		</a>
												</li>
												<li class="listingTab" tabIndex="14">
													<a href="#"><spring:message code="lbl_future" />
														 <span class="pull-right-container">
                                                			<small class="label pull-right bg-light-white txt-light-blue mar-left-5 futureCount recordCount">
																${tenderCount.future}
															</small>
														</span>		
													</a>
												</li>
												<li class="listingTab" tabIndex="13"><a href="#"><spring:message code="lbl_archive" />
												 <span class="pull-right-container">
                                                <small class="label pull-right bg-light-white txt-light-blue mar-left-5 recordCount archiveCount">
														${tenderCount.archive}
														</small>
														</span>
														</a>
												</li>
												<li class="listingTab" tabindex="27"><a href="#"><spring:message code="lbl_cancel" />
												 <span class="pull-right-container">
	                                                	<small class="label pull-right bg-light-white txt-light-blue mar-left-5 recordCount cancelCount">
															${tenderCount.cancel}
														</small>
													</span>
														</a>
												</li>
											</c:if>
											<!--Links for Auction -->
											<c:if test="${isAuction eq 1}">
												<li class="listingTab active" tabIndex="31"><a href="#"><spring:message code="lbl_live" />
												 <span class="pull-right-container">
                                                <small class="label pull-right bg-light-white txt-light-blue mar-left-5 recordCount liveCount">
														${tenderCount.live}
														</small>
														</span></a>
												</li>
												<li class="listingTab" tabIndex="37"><a href="#"><spring:message code="lbl_future" />
												 <span class="pull-right-container">
                                                <small class="label pull-right bg-light-white txt-light-blue mar-left-5 recordCount futureCount">
														${tenderCount.future}
														</small>
														</span></a>
												</li>
												<li class="listingTab" tabIndex="36"><a href="#"><spring:message code="lbl_archive" />
												 <span class="pull-right-container">
                                                <small class="label pull-right bg-light-white txt-light-blue mar-left-5 recordCount archiveCount">
														${tenderCount.archive}
														</small>
														</span>
														</a>
												</li>
												<li class="listingTab" tabindex="27"><a href="#"><spring:message code="lbl_cancel" />
												 <span class="pull-right-container">
                                                <small class="label pull-right bg-light-white txt-light-blue mar-left-5 recordCount cancelCount">
														${tenderCount.cancel}
														</small>
														</span></a>
												</li>
											</c:if>
										</ul>
										</div>
										<div id="listingDiv" style="width: 100%; overflow-y: auto;">
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

<input type="hidden" id="isAuction" value="${isAuction}"/>
<input type="hidden" id="userId" value="${userId}"/>

<%@include file="../../includes/footer.jsp"%>

<script type="text/javascript">

$(document).ready(function(){
	toDateFormate = '<spring:message code="client_dateformate_hhmm" />';
	$("[dateBox='true']").each(function(){
		$(this).datetimepicker({
		  format:'d-M-Y H:i'
		});
	});
        if(${isAuction eq 0}){
            loadListPage('listingDiv',10,'tenderListForm');
        }else{
            
            loadListPage('listingDiv',31,'tenderListForm');
        }
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
	var colIndx =-1;
     if(${isAuction eq 0}){
         colIndx=getColumnIndex('Tender Id.');
     }else{
       colIndx=getColumnIndex('Auction Id.');
     }
	colIndx++;
	 if(actionname.toLowerCase() == "view"){
		var tenderId = $(cthis).closest("tr").find('td:nth-child('+colIndx+')').html();
		colIndx = getColumnIndex('Corrigendum');
		colIndx++;
		/* var viewCorrigendum="false";
		var corrigendumCount = $(cthis).closest("tr").find('td:nth-child('+colIndx+')').html();
		if(corrigendumCount != undefined && $.trim(corrigendumCount) != '0'){
			viewCorrigendum = "true";
		} */
                 if(${isAuction eq 0}){
					 window.location = "${pageContext.servletContext.contextPath}/etender/bidder/viewtender/"+tenderId+"/0";
                 }
                 else
                 {
                     window.location = "${pageContext.servletContext.contextPath}/eBid/Bid/viewAuction/"+tenderId+"/0"
                 }
		
	}else if(actionname.toLowerCase() == "dashboard"){
		var tenderId = $(cthis).closest("tr").find('td:nth-child('+colIndx+')').html();
		window.location = "${pageContext.servletContext.contextPath}/etender/bidder/biddingTenderDashboard/"+tenderId;
	}
}
$(".listingTab").click(function(){
	var tabIndex = $(this).attr("tabindex");
	loadListPage('listingDiv',tabIndex,'tenderListForm');
	$(".listingTab").removeClass("active");
	$(this).addClass("active");
	var isAuction= "${isAuction}";
	if(isAuction == 1){
		reSetCountIfNowMatch(4);
	}else{
		reSetCountIfNowMatch(3);
	}
});
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
<script src="${pageContext.servletContext.contextPath}/resources/js/jQuery/jquery.datetimepicker.js"></script>
