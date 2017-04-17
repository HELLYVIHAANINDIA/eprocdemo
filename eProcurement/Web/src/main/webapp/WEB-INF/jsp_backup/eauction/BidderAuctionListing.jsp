<!DOCTYPE html>
<html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
	<%@include file="../includes/header.jsp"%>
	  <script src="${pageContext.servletContext.contextPath}/resources/js/jQuery/jquery.datetimepicker.js"></script>
	  <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/resources/css/jquery.datetimepicker.css">
  <script src="${pageContext.request.contextPath}/resources/js/commonListing.js"></script>
  <spring:message code="client_dateformate_hhmm" var="client_dateformate_hhmm" />
</head>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="../includes/leftaccordion.jsp"%>

  <div class="content-wrapper">
  <div class="pull-right" style="cursor:pointer;"><a onclick="showHideSearch()">Search</a></div></br>
	<c:if test="${not empty successMsg}">
    	<c:choose>
    		<c:when test="${fn:contains(successMsg, '_')}">
    			<div class="alert alert-success"><spring:message code="${successMsg}"/></div>
    		</c:when>
    		<c:otherwise>
    			<div class="alert alert-success">${successMsg}</div>
    		</c:otherwise>
    	</c:choose>
	</c:if>
	<c:if test="${not empty errorMsg}">
	    <c:choose>
    		<c:when test="${fn:contains(errorMsg, '_')}">
    			<div class="alert alert-danger"><spring:message code="${errorMsg}"/></div>
    		</c:when>
    		<c:otherwise>
    			<div class="alert alert-danger">${errorMsg}</div>
    		</c:otherwise>
    	</c:choose>
	</c:if>
	<form id="tenderListForm" style="display: none;">
			<div class="col-md-12">
				<div class="col-md-3">
					<spring:message code="fields_tenderid" />
				</div> 
				<div class="col-md-3">
					<input type="text" class="searchLike form-control" columnname="tenderId">
				</div>
				<div class="col-md-3">
					<spring:message code="fields_refenceno" />
				</div>
				<div class="col-md-3">
					<input type="text" class="searchLike form-control" columnname="tenderNo">
				</div>
			</div>
			<div class="col-md-12">
				<div class="col-md-3">
					<spring:message code="field_brief" />
				</div>
				<div class="col-md-3">
					<input type="text" class="searchLike form-control" columnname="tenderBrief">
				</div>
					<div class="col-md-3">
					<spring:message code="fields_tender_keywords" />
				</div>
				<div class="col-md-3">
					<input type="text" class="searchLike form-control" columnname="keywordText">
				</div>
			</div>
			<div class="col-md-12">
				<div class="col-md-3">
					<spring:message code="lbl_due_date" />
				</div> 
                 <div class="col-md-3">
                     <select name="dateFrom1" class="dateFrom1" id="dateFrom1" onchange="checkBetween1(this);" class="form-control">
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
                 	<input id="submissionEndDate" columnname="submissionEndDate" name="submissionEndDate" type="text" datepicker="yes" placeholder="${client_dateformate_hhmm}" title="Date" dateBox="true" class="form-control">
                 </div>
           		<div class="col-md-3" id="div_submissionEndDate_to" style="display: none;">
	               <input id="submissionEndDate_to" name="submissionEndDate_to" columnname="submissionEndDate"  type="text" datepicker="yes" placeholder="${client_dateformate_hhmm}" title="Date" dateBox="true" class="form-control">
	            </div>
			</div>
			<div class="col-md-12">
				<div class="col-md-3">
					<spring:message code="field_bidopeningstartdate" />
				</div> 
                 <div class="col-md-3">
                     <select name="dateFrom" class="dateFrom" id="dateFrom" onchange="checkBetween(this);" class="form-control">
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
                 	<input id="bidOpeningDate" columnname="openingDate" name="bidOpeningDate" type="text" datepicker="yes" placeholder="${client_dateformate_hhmm}" title="Date" dateBox="true" class="form-control">
                 </div>
           		<div class="col-md-3" id="div_bidOpeningDate_to" style="display: none;">
	               <input id="bidOpeningDate_to" name="bidOpeningDate_to" columnname="openingDate"  type="text" datepicker="yes" placeholder="${client_dateformate_hhmm}" title="Date" dateBox="true" class="form-control">
	            </div>
			</div>
			<div class="col-md-12">
				<div class="col-md-3">
					Search In
				</div>
				<div class="col-md-3">
					<select name="searchToTab" id="searchToTab" class="form-control">
                     <option value="">Select</option>
                     <option selected="selected" value="18">All</option>
                     <option value="1">Pending</option>
                     <option value="6">Live</option>
                     <option value="4">Future</option>
                     <option value="5">Archive</option>
                     <option value="17">Cancel</option>
                    </select>
				</div>
			</div>
			<div class="col-md-12">
				<div class="col-md-3">
					<input type="hidden" name="jsonSearchCriteria" id="jsonSearchCriteria"> <input type="button" onclick="searchForList()" class="btn-sm form-control" value="Search">
<%-- 					<input type="hidden" class="searchEqual" columnName="bidderId"  value="${bidderId}"> --%>
					<input type="hidden" name="defaultOrder" id="defaultOrder" value="1:desc">
					<c:forEach items="${deptId}" var="deptVar">
						<input type="hidden" class="searchIn" columnName="departmentId" value="${deptVar}">
					</c:forEach>
				</div>
				<div class="col-md-3">
					<input type="reset" class="btn-sm form-control" value="Clear" onclick="location.reload();">
				</div>
			</div>
		</form>
		<div class="clearfix">
		</div>
		<section class="">
		<ul class="nav nav-tabs">
		  <li class="listingTab" tabIndex="10"><a href="#">Live (${tenderCount.live})</a></li>
		  <li class="listingTab" tabIndex="14"><a href="#" >Future (${tenderCount.future})</a></li>
		  <li class="listingTab" tabIndex="13"><a href="#" >Archive (${tenderCount.archive})</a></li>
		  <li class="listingTab" tabindex="27"><a href="#" >Cancel (${tenderCount.cancel})</a></li>
		</ul>
				<div id="listingDiv">
				</div>
     	</section>
    </div>
	<%@include file="../includes/footer.jsp"%>
	</div>
<script type="text/javascript">

$(document).ready(function(){
	toDateFormate = '<spring:message code="client_dateformate_hhmm" />';
	$("[dateBox='true']").each(function(){
		$(this).datetimepicker({
		  format:'d-M-Y H:i'
		});
	});
        if(${isAuction}==0)
        {    loadListPage('listingDiv',10,'tenderListForm');
            alert("in if");}
	else
        
            loadListPage('listingDiv',31,'tenderListForm');
    
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
	 if(actionname == "view"){
		var tenderId = $(cthis).closest("tr").find('td:nth-child('+colIndx+')').html();
		window.location = "${pageContext.servletContext.contextPath}/etender/bidder/viewtender/"+tenderId;
	}else if(actionname == "dashboard"){
		var tenderId = $(cthis).closest("tr").find('td:nth-child('+colIndx+')').html();
		window.location = "${pageContext.servletContext.contextPath}/etender/bidder/biddingTenderDashboard/"+tenderId;
	}
}
$(".listingTab").click(function(){
	var tabIndex = $(this).attr("tabindex");
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
</body>
</html>