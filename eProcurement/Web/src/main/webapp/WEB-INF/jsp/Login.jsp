<!DOCTYPE html>
<html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<%@include file="./includes/headerWithoutLogin.jsp"%>
 <script src="${pageContext.servletContext.contextPath}/resources/js/jQuery/jquery.datetimepicker.js"></script>
 <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/resources/css/jquery.datetimepicker.css">
 <script src="${pageContext.request.contextPath}/resources/js/commonListing.js"></script>
<style>
.sectionDiv{
	display: none;
}
</style>
</head>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="./includes/leftaccordionWithOutLogin.jsp"%>

<div class="content-wrapper">

<section class="content-header">
	<a onclick="showHideSearch()" style="text-decoration:none;">
	<h1><spring:message code="lbl_search_more"/></h1></a><%-- hide listing because it is not require here  --%>
</section>

<section class="content">

	<div class="row">
		<div class="col-md-12">
			<div class="box">
				<div class="box-body">
				
					<div class="row">
						<div class="col-md-12">
							<c:if test="${not empty message}">
								<div class="alert alert-success">${message}</div>
							</c:if>
						</div>
						<div class="col-md-12">
							<div id="infoHading" class="alert alert-info">${lbl_important_message}</div>
							<div id="info"></div>
						</div>					
					</div>
					
					<form id="tenderListForm" style="display: none;">
					
					<div class="row">
						<div class="col-md-2">
							<div class="form_filed"><spring:message code="fields_tenderid" /></div>
						</div> 
						<div class="col-md-4">
							<input type="text" class="searchLike form-control" columnname="tenderId">
						</div>
						<div class="col-md-2">
							<div class="form_filed"><spring:message code="fields_refenceno" /></div>
						</div>
						<div class="col-md-4">
							<input type="text" class="searchLike form-control" columnname="tenderNo">
						</div>
					</div>
			
					<div class="row">
						<div class="col-md-2">
							<div class="form_filed"><spring:message code="field_brief" /></div>
						</div>
						<div class="col-md-4">
							<input type="text" class="searchLike form-control" columnname="tenderBrief">
						</div>
						<div class="col-md-2">
							<div class="form_filed"><spring:message code="fields_tender_keywords" /></div>
						</div>
						<div class="col-md-4">
							<input type="text" class="searchLike form-control" columnname="keywordText">
						</div>
					</div>
			
					<div class="row">
						<div class="col-md-2">
							<div class="form_filed"><spring:message code="lbl_due_date" /></div>
						</div> 
                		<div class="col-md-4">
                     		<select name="dateFrom1" class="dateFrom1 form-control" id="dateFrom1" onchange="checkBetween1(this);">
                     			<option value="searchEqual">equal</option>
                     			<option value="searchNotEqual">not equal</option>
                     			<option value="searchLessThen">less</option>
                     			<option value="searchLessThenEqual">less or equal</option>
                     			<option value="searchGreaterThen">greater</option>
                     			<option value="searchGreaterEqual">greater or equal</option>
                     			<option value="searchBetweenDate">between</option>
                     		</select>
                 		</div>
                 		<div class="col-md-2">
                 			<input id="submissionEndDate" columnname="submissionEndDate" name="submissionEndDate" type="text" datepicker="yes" placeholder="DD/MM/YYYY HH:MM" title="Date" dateBox="true" class="form-control">
                 		</div>
           				<div class="col-md-4" id="div_submissionEndDate_to" style="display: none;">
	               			<input id="submissionEndDate_to" name="submissionEndDate_to" columnname="submissionEndDate"  type="text" datepicker="yes" placeholder="DD/MM/YYYY HH:MM" title="Date" dateBox="true" class="form-control">
	            		</div>
	            	</div>
			
					<div class="row">
						<div class="col-md-2">
							<div class="form_filed"><spring:message code="field_bidopeningstartdate" /></div>
						</div> 
                 		<div class="col-md-4">
                     		<select name="dateFrom" class="dateFrom form-control" id="dateFrom" onchange="checkBetween(this);">
                     			<option value="searchEqual">equal</option>
                     			<option value="searchNotEqual">not equal</option>
                     			<option value="searchLessThen">less</option>
                     			<option value="searchLessThenEqual">less or equal</option>
                     			<option value="searchGreaterThen">greater</option>
                     			<option value="searchGreaterEqual">greater or equal</option>
                     			<option value="searchBetweenDate">between</option>
                     		</select>
                		 </div>
                 		<div class="col-md-2">
                 			<input id="bidOpeningDate" columnname="openingDate" name="bidOpeningDate" type="text" datepicker="yes" placeholder="DD/MM/YYYY HH:MM" title="Date" dateBox="true" class="form-control">
                 		</div>
           				<div class="col-md-4" id="div_bidOpeningDate_to" style="display: none;">
	               			<input id="bidOpeningDate_to" name="bidOpeningDate_to" columnname="openingDate"  type="text" datepicker="yes" placeholder="DD/MM/YYYY HH:MM" title="Date" dateBox="true" class="form-control">
	            		</div>
	            	</div>
					
					<div class="row">
						<div class="col-md-2">
							<div class="form_filed">Search In</div>
						</div>
						<div class="col-md-4">
							<select name="searchToTab" id="searchToTab" class="form-control">
                     			<option value="">Select</option>
                     			<option selected="selected" value="19">Tender</option>
                    		</select>
						</div>
					</div>
			
					<div class="row">
						<div class="col-md-2">
							
						</div>
						<div class="col-md-4">
							<input type="hidden" name="jsonSearchCriteria" id="jsonSearchCriteria"> 
							<input type="button" onclick="searchForList()" class="btn btn-submit" value="Search">
							<input type="hidden" name="defaultOrder" id="defaultOrder" value="1:desc">
							<input type="reset" class="btn btn-submit" value="Clear" onclick="location.reload();">		 
						</div>	
					</div>		
					</form>
					
					<div class="row">
						<div class="col-md-12">
							<ul class="nav nav-tabs"><%-- hide listing because it is not require here  --%>
		  						<li class="listingTab active" tabindex="19"><a href="#" >Tender</a></li>
		  						<li class="listingTab" tabindex="20"><a href="#" >Auction</a></li>
							</ul>
							<input type="hidden" id="fileNameForExport" value="tenderlist"/>
							<div id="listingDiv" class="listingDiv" style="width: 100%;overflow-y: auto;">
							</div>
						</div>
					</div>
					
					<div class="row">
					
						<div class="col-md-12">
							<div id="section1" class="sectionDiv">
								<div class=" alert alert-warning">${lbl_aboutus}</div>
									We are tender masters...
							</div>	
						</div>
						
						<div class="col-md-12">
							<div id="section2" class="sectionDiv">
								<div class=" alert alert-warning">${lbl_fq}</div>
									Here is your FAQ detail...
							</div>
						</div>
						
						<div class="col-md-12">
							<div id="section3" class="sectionDiv">
								<div class=" alert alert-warning">${lbl_privacy_police}</div>
									Here is your Privacy policy detail...
							</div>
						</div>
						
						<div class="col-md-12">
							<div id="section4" class="sectionDiv">
								<div class=" alert alert-warning">${lbl_disclaimer}</div>
									Here is your Disclaimer detail...
							</div>
						</div>
						
						<div class="col-md-12">
							<div id="section5" class="sectionDiv">
								<div class=" alert alert-warning">${lbl_download_software}</div>
									Here is your Download software supports detail...
									<ul>
										<li><a href="http://www.adobe.com/products/acrobat/readstep2.html" target="_blank">PDF reader</a></li>
										<li><a href="http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html" target="_blank">Java</a></li>
									</ul>
							</div>
						</div>
						
						<div class="col-md-12">
							<div id="section6" class="sectionDiv">
								<div class=" alert alert-warning">${lbl_browsersupport}</div>
									Here is your Browser support detail...
							</div>
						</div>
										
					</div>
					
				</div>
			</div>
		</div>		
	</div>
	
</section>

</div>
	
<%@include file="./includes/footer.jsp"%>	
	<!--Body Part End-->
	</div>

<script>
$(document).ready(function(){

	toDateFormate = '<spring:message code="client_dateformate_hhmm" />';
	$("[dateBox='true']").each(function(){
		$(this).datetimepicker({
		  format:'d/m/Y H:i'
		});
	});
	loadListPage('listingDiv',19,'tenderListForm');
	checkBetween($("#dateFrom"));
	checkBetween1($("#dateFrom1"));
	setTimeout(function(){
		$(".dt-button.buttons-pdf.buttons-html5").attr("onclick",'exportContent("listingTable","'+$("#fileNameForExport").val()+'",0)');
		$(".dt-button.buttons-excel.buttons-html5").attr("onclick",'exportContent("listingTable","'+$("#fileNameForExport").val()+'",4)');
	},1000);
	$(".sectionDiv").hide();
	$(".leftMenuSection").click(function(){
		$(".sectionDiv").hide();
		var sectionId = $(this).attr("section");
		$("#section"+sectionId).show();
	});
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
	var colIndx = getColumnIndex('Event Id.');
	colIndx++;
	if(actionname.toLowerCase() == "view"){
		var tenderId = $(cthis).closest("tr").find('td:nth-child('+colIndx+')').html()
		var viewCorrigendum = false;
		colIndx = getColumnIndex('Corrigendum');
		colIndx++;
		var corrigendumCount = $(cthis).closest("tr").find('td:nth-child('+colIndx+')').html();
		if($.trim(corrigendumCount) != '0'){
			viewCorrigendum = true;
		}
		window.location = "${pageContext.servletContext.contextPath}/etender/buyer/viewtender/"+tenderId+"/2?viewCorrigendum="+viewCorrigendum+"&viewDoclument=true"
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
$.ajax({
	type : "GET",
	url : "${pageContext.servletContext.contextPath}/common/viewMarquee/0",
	success : function(data) {
		if(data != ""){
			$("#info").html(data);
		}else{
			$("#infoHading").hide();
		}
	},
	error : function(e) {
		$("#infoHading").hide();
	},
});
//exportContent("listingDiv",2);
function exportContent(className,fileName,txtGenerateType){
	var createPdfForm = document.createElement("form");
    createPdfForm.method="POST";
    createPdfForm.action="${pageContext.servletContext.contextPath}/exportDataFromPage";
    var htmlData = $("<div/>").html($("#"+className).clone());
    $(htmlData).find(".noExport").remove();
    var exportData= $("<input>",{type:'hidden',name:'pdfBuffer',value:$(htmlData).html()});
    var filename= $("<input>",{type:'hidden',name:'fileName',value:fileName});
    var gType= $("<input>",{type:'hidden',name:'txtGenerateType',value:txtGenerateType});
    $(createPdfForm).append(exportData,filename,gType);
    document.body.appendChild(createPdfForm);
    createPdfForm.submit();
}
</script>

</body>
</html>