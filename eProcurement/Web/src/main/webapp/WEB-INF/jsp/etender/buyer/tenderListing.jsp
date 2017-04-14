<%@include file="../../includes/head.jsp"%>
<%@include file="../../includes/masterheader.jsp"%>
<script src="${pageContext.servletContext.contextPath}/resources/js/jQuery/jquery.datetimepicker.js"></script>
<div class="content-wrapper">
	<section class="content-header">
		<div style="cursor:pointer;"><a onclick="showHideSearch()"><h1><spring:message code="lbl_advance_tender_search"/> </h1></a></div>
	</section>
<spring:message code="client_dateformate_hhmm" var="client_dateformate_hhmm" />
<section class="content">
	<div class="row">
		<div class="col-md-12">
			<div class="box">
				<div class="box-body"  style="overflow: auto;width: 100%;">
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
								</div>
								<div class="col-md-12">
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
								<div class="row"><div class="col-md-3">Search by</div></div>
								<div class="row">
									<input type="hidden" class="searchEqual form-control" columnname="isAuction" value="0">
									<div class="col-md-3">
										<label class="lbl-fields"><spring:message code="fields_tenderid" /></label>
									</div>
									<div class="col-md-3">
										<input type="text" class="searchEqual form-control"
											columnname="tenderId">
									</div>
									<div class="col-md-3">
										<label class="lbl-fields"><spring:message code="fields_refenceno" /></label>
									</div>
									<div class="col-md-3">
										<input type="text" class="searchLike form-control"
											columnname="tenderNo">
									</div>
								</div>
								<div class="row">
									<div class="col-md-3">
										<label class="lbl-fields"><spring:message code="field_brief" /></label>
									</div>
									<div class="col-md-3">
										<input type="text" class="searchLike form-control"
											columnname="tenderBrief">
									</div>
									<div class="col-md-3">
										<label class="lbl-fields"><spring:message code="fields_tender_keywords" /></label>
									</div>
									<div class="col-md-3">
										<input type="text" class="searchLike form-control"
											columnname="keywordText">
									</div>
								</div>
								<div class="row">
									<div class="col-md-3">
										<label class="lbl-fields"><spring:message code="lbl_due_date" /></label>
									</div>
									<div class="col-md-3">
										<select name="dateFrom1" class="dateFrom1 form-control" id="dateFrom1"
											onchange="checkBetween1(this);">
											<option value="searchEqual">equal</option>
											<option value="searchNotEqual">not equal</option>
											<option value="searchLessThen">less</option>
											<option value="searchLessThenEqual">less or equal</option>
											<option value="searchGreaterThen">greater</option>
											<option value="searchGreaterEqual">greater or equal</option>
											<option value="searchBetweenDate">between</option>
										</select>
									</div>
									<div class="col-md-3">
										<input id="submissionEndDate" columnname="submissionEndDate"
											name="submissionEndDate" type="text" datepicker="yes"
											placeholder="${client_dateformate_hhmm}" title="Date"
											dateBox="true" class="form-control">
									</div>
									<div class="col-md-3" id="div_submissionEndDate_to"
										style="display: none;">
										<input id="submissionEndDate_to" name="submissionEndDate_to"
											columnname="submissionEndDate" type="text" datepicker="yes"
											placeholder="${client_dateformate_hhmm}" title="Date"
											dateBox="true" class="form-control">
									</div>
								</div>
									 	<div class="row">
                                             	 		<div class="col-xs-3"><label class="lbl-fields"><spring:message code="lbl_Organization"/></label></div>
                                             	 		<div class="col-xs-9"><div id="organization" class="lbl-fields"></div>
                                             	 		<input type="hidden" name="organization" value="${grandParentDeptId}" /> </div>
                                             	 	</div>
                                             	 	
                                             	 	<div class="row">
                                             	 		<div class="col-xs-3"><label class="lbl-fields"><spring:message code="lbl_department"/></label></div>
                                             	 		<div class="col-xs-3">
                                             	 		<c:choose>
	                                             	 		<c:when test="${parentDeptId gt 0}">
	                                             	 			<div id="parentDeptName" class="lbl-fields"></div>
	                                             	 		</c:when>
    	                                         	 		<c:otherwise>
    	                                         	 		<div><select class="form-control" id="selDepartment" name="selDepartment"  onblur="javascript:{if(true){getSubDepartments();}}" title="department">
																	<option value="-1">${label_select}</option>
																</select></div>
    	                                         	 				
    	                                         	 		</c:otherwise>
                                             	 		</c:choose>
                                             	 		
														</div>
                                             	 	</div>
                                             	 	                       	 
                                                 <div class="row">
                                             	 		<div class="col-xs-3"><label class="lbl-fields"><spring:message code="lbl_subdepartment"/></label></div>
                                             	 		<div class="col-xs-3">
                                             	 		<c:choose>
	                                             	 		<c:when test="${subDeptId gt 0}">
	                                             	 			<div id="subDeptName" class="lbl-fields"></div>
	                                             	 		</c:when>
    	                                         	 		<c:otherwise>
    	                                         	 			<div><select class="form-control" id="subDept" name="subDept"  title="sub department">
															<option value="-1">${label_select}</option>
															</select></div>
    	                                         	 		</c:otherwise>
                                             	 		</c:choose>
                                             	 		
														</div>
                                             	 	</div> 
								<div class="row">
									<div class="col-md-3">
										<label class="lbl-fields"><spring:message code="field_bidopeningstartdate" /></label>
									</div>
									<div class="col-md-3">
										<select name="dateFrom" class="dateFrom form-control" id="dateFrom"
											onchange="checkBetween(this);">
											<option value="searchEqual">equal</option>
											<option value="searchNotEqual">not equal</option>
											<option value="searchLessThen">less</option>
											<option value="searchLessThenEqual">less or equal</option>
											<option value="searchGreaterThen">greater</option>
											<option value="searchGreaterEqual">greater or equal</option>
											<option value="searchBetweenDate">between</option>
										</select>
									</div>
									<div class="col-md-3">
										<input id="bidOpeningDate" columnname="openingDate"
											name="bidOpeningDate" type="text" datepicker="yes"
											placeholder="${client_dateformate_hhmm}" title="Date"
											dateBox="true" class="form-control">
									</div>
									<div class="col-md-3" id="div_bidOpeningDate_to"
										style="display: none;">
										<input id="bidOpeningDate_to" name="bidOpeningDate_to"
											columnname="openingDate" type="text" datepicker="yes"
											placeholder="${client_dateformate_hhmm}" title="Date"
											dateBox="true" class="form-control">
									</div>
								</div>
								<div class="row">
									<div class="col-md-3"><label class="lbl-fields"><spring:message code="field_search_for" /></label></div>
									<div class="col-md-3">
										<select name="searchToTab" id="searchToTab"
											class="form-control">
											<option value="">Select</option>
											<option selected="selected" value="18">All</option>
											<option value="1">Pending</option>
											<option value="6">Live</option>
											<option value="4">Future</option>
											<option value="5">Archive</option>
											<option value="17">Canceled</option>
										</select>
									</div>
								</div>
								
								<div class="row">
									<div class="col-md-3"></div>
									<div class="col-md-3">
										<input type="hidden" name="jsonSearchCriteria"
											id="jsonSearchCriteria"> <input type="button"
											onclick="javascript:{searchAjax();searchForList()}" class="search-button"
											value="Search"> <input type="hidden"
											name="defaultOrder" id="defaultOrder" value="1:desc">
										<c:if test="${not empty deptIdStr}">
											<input type="hidden" class="searchIn" id="departmentId"
												columnName="departmentId" value="${deptIdStr}">
										</c:if>
										<input type="reset" class="clear-button" value="Clear"
											onclick="location.reload();">
									</div>
									
								</div>
								
							</form>

							<section class="">
							<div class="nav-tabs-custom">
								<ul class="nav nav-tabs">
									<li class="active listingTab" tabindex="1"><a href="#">Pending
											 <span class="pull-right-container">
                                                <small class="label pull-right bg-light-white txt-light-blue mar-left-5 pendingCount recordCount">${tenderCount.pending}
                                                </small>
                                                </span>
                                                </a>
									</li>
									<li class="listingTab" tabindex="6"><a href="#">Live
											 <span class="pull-right-container">
                                                <small class="label pull-right bg-light-white txt-light-blue mar-left-5 liveCount recordCount">${tenderCount.live}
                                                </small>
                                                </span>
                                                </a>
									</li>
									<li class="listingTab" tabindex="4"><a href="#">Future
									 <span class="pull-right-container">
                                                <small class="label pull-right bg-light-white txt-light-blue mar-left-5 futureCount recordCount">
											${tenderCount.future}
											</small>
											</span>
											</a>
									</li>
									<li class="listingTab" tabindex="5"><a href="#">Archived
											 <span class="pull-right-container">
                                                <small class="label pull-right bg-light-white txt-light-blue mar-left-5 recordCount archiveCount">${tenderCount.archive}</small>
                                                </span>
                                                </a>
									</li>
									<li class="listingTab" tabindex="17"><a href="#">Cancelled
									 <span class="pull-right-container">
                                                <small class="label pull-right bg-light-white txt-light-blue mar-left-5 recordCount cancelCount">
											${tenderCount.cancel}</small>
											</span>
											</a>
									</li>
									<li class="listingTab" tabindex="18"><a href="#">All
											 <span class="pull-right-container">
                                                <small class="label pull-right bg-light-white txt-light-blue mar-left-5 recordCount allCount">
                                                ${tenderCount.total}
                                                </small>
                                                </span>
                                                </a>
									</li>
								</ul>
							</div>
							
							<div id="listingDiv" style="width: 100%; overflow-y: auto;">
							</div>
							
							</section>

						</div>
			</div>
		</div>
	</div>
</section>
</div>

<script type="text/javascript">
var grandParentDeptId = '${grandParentDeptId}';
var parentDeptId = '${parentDeptId}';
var subDeptId = '${subDeptId}';
var sessionUserDeptIds='${deptIdStr}';
$(document).ready(function(){
	
	// department hirarchy code start 
				 $('#organization').html('${organization}');
			     $('#parentDeptName').html('${parentDeptName}');
			     $('#subDeptName').html('${subDeptName}');
		         getParentDepartmentsByGrandparentDept();
	
	CLIENT_DATE_FORMATE = '${client_dateformate_hhmm}';
	$("[dateBox='true']").each(function(){
		$(this).datetimepicker({
		  format:'d-M-Y H:i'
		});
	});
	loadListPage('listingDiv',1,'tenderListForm');
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
	loadListPage('listingDiv',tabIndex,'tenderListForm');
	$(".listingTab").removeClass("active");
	$(this).addClass("active");
	reSetCountIfNowMatch(1);
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
function getParentDepartmentsByGrandparentDept() {
		blockUI();
		var data = {};
 	var searchValue = grandParentDeptId+"@@0";
 	$.ajax({
 		type : "POST",
 		contentType : "application/json",
 		url : "${pageContext.servletContext.contextPath}/common/user/getsubdepartments/"+searchValue,
 		data : data,
 		timeout : 100000,
 		success : function(data) {
 			var obj = jQuery.parseJSON(data);
 			$('#selDepartment').html('');
 		     $.each(obj, function (key, value) {
 		    $('#selDepartment').append($('<option>',
 		    		 {
 		    		    value: value.value,
 		    		    text : value.label
 		    		}));
 		     });
 			console.log("SUCCESS: ", data);
 			unBlockUI()
 		},
 		error : function(e) {
 			console.log("ERROR: ", e);
 			unBlockUI()
 		},
 		done : function(e) {
 			console.log("DONE");
 			unBlockUI()
 		}
 	});
 	return true;
 }


function getSubDepartments() {
blockUI();
		var data = {};
 	var searchValue = $("#selDepartment").val()+"@@1";
 	$.ajax({
 		type : "POST",
 		contentType : "application/json",
 		url : "${pageContext.servletContext.contextPath}/common/user/getsubdepartments/"+searchValue,
 		data : data,
 		timeout : 100000,
 		success : function(data) {
 			var obj = jQuery.parseJSON(data);
 			$('#subDept').html('');
 		     $.each(obj, function (key, value) {
 		    $('#subDept').append($('<option>',
 		    		 {
 		    		    value: value.value,
 		    		    text : value.label
 		    		}));
 		     });
 			console.log("SUCCESS: ", data);
 			unBlockUI()
 		},
 		error : function(e) {
 			console.log("ERROR: ", e);
 			unBlockUI()
 		},
 		done : function(e) {
 			console.log("DONE");
 			unBlockUI()
 		}
 	});
 	return true;
}


function searchAjax() {
	var data = {};
// 		var grandParentDept = $('#grandParentDeptId').val();
		var grandParentDept = grandParentDeptId;
		var parentDept = $('#selDepartment').val();
		var subDept = $('#subDept').val();
		if(parentDept>0){
			$.ajax({
				async:false,
				type : "POST",
				contentType : "application/json",
				url : "${pageContext.servletContext.contextPath}/ajax/departments/"+grandParentDept+"/"+parentDept+"/"+subDept,
				data : data,
				timeout : 100000,
				success : function(data) {
					$('#departmentId').val(data);
				},
				error : function(e) {
					console.log("ERROR: ", e);
				},
				done : function(e) {
					console.log("DONE");
				}
			});
		}else{
			$('#departmentId').val(sessionUserDeptIds);
		}
		
	
}
</script>
<script src="${pageContext.request.contextPath}/resources/js/commonListing.js"></script>
<%@include file="../../includes/footer.jsp"%>