<%@include file="./includes/head.jsp"%>
<%@include file="./includes/headerWithoutLogin.jsp"%>
<div class="content-wrapper">

<section class="content-header">
<a onclick="showHideSearch()" style="text-decoration:none;">
<h1><spring:message code="lbl_search_more"/></h1>
</a><%-- hide listing because it is not require here  --%>
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
							<c:if test="${not empty param.successMsg}">
								<div class="alert alert-success">
											<spring:message code="${param.successMsg}" />
										</div>
							</c:if>
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
						<div class="col-md-12">
							<div id="infoHading" class="alert alert-info">${lbl_important_message}</div>
							<div id="info"></div>
						</div>
					</div>
					
					<div class="row">
						<form id="tenderListForm" style="display: none;">
							<div class="col-md-12">
								<div class="row">
									<div class="col-md-3">
										<label class="lbl-fields"><spring:message code="fields_tenderid" /></label>
									</div>
									<div class="col-md-3">
										<input type="text" class="searchLike form-control"
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
							</div>
							<div class="col-md-12">
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
							</div>
							<div class="col-md-12">
								<div class="row">
									<div class="col-md-3">
										<label class="lbl-fields"><spring:message code="lbl_due_date" /></label>
									</div>
									<div class="col-md-3">
										<select name="dateFrom1" class="dateFrom1 form-control" id="dateFrom1"
											onchange="checkBetween1(this);" class="form-control">
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
											placeholder="DD/MM/YYYY HH:MM" title="Date" dateBox="true"
											class="form-control">
									</div>
									<div class="col-md-3" id="div_submissionEndDate_to"
										style="display: none;">
										<input id="submissionEndDate_to" name="submissionEndDate_to"
											columnname="submissionEndDate" type="text" datepicker="yes"
											placeholder="DD/MM/YYYY HH:MM" title="Date" dateBox="true"
											class="form-control">
									</div>
								</div>
							</div>
							<div class="col-md-12">
								<div class="row">
									<div class="col-md-3">
										<label class="lbl-fields"><spring:message code="field_bidopeningstartdate" /></label>
									</div>
									<div class="col-md-3">
										<select name="dateFrom" class="dateFrom form-control" id="dateFrom"
											onchange="checkBetween(this);" class="form-control">
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
											placeholder="DD/MM/YYYY HH:MM" title="Date" dateBox="true"
											class="form-control">
									</div>
									<div class="col-md-3" id="div_bidOpeningDate_to"
										style="display: none;">
										<input id="bidOpeningDate_to" name="bidOpeningDate_to"
											columnname="openingDate" type="text" datepicker="yes"
											placeholder="DD/MM/YYYY HH:MM" title="Date" dateBox="true" class="form-control">
									</div>
								</div>
							</div>
							<div class="col-md-12">
								<div class="row">
									<div class="col-md-3"><label class="lbl-fields"><spring:message code="field_search_for" /></label></div>
									<div class="col-md-3">
										<select name="searchToTab" id="searchToTab"
											class="form-control">
											<option value="">Select</option>
											<option selected="selected" value="19">Tender</option>
											<option value="48">Auction</option>
										</select>
									</div>
								</div>
							</div>
							
							<div class="col-md-3"></div>
							
							<div class="col-md-3">							
								<input type="hidden" name="jsonSearchCriteria" id="jsonSearchCriteria">
								<input type="button" onclick="searchForList()" class="search-button hvr-overline-from-left" value="Search">
								<input type="hidden" name="defaultOrder" id="defaultOrder" value="1:desc">
								<input type="reset" class="clear-button" value="Clear" onclick="location.reload();">									
							</div>

						</form>
					</div>
					<div class="row">
						<div class="col-md-12">
							<div class="nav-tabs-custom">
								<ul class="nav nav-tabs">
									<%-- hide listing because it is not require here  --%>
									<li class="listingTab active" tabindex="19"><a href="#">Tender</a>
									</li>
									<li class="listingTab" tabindex="48"><a href="#">Auction</a>
									</li>
								</ul>
							</div>
						</div>
						<div class="col-md-12">
							<input type="hidden" id="fileNameForExport" value="tenderlist" />
							<div id="listingDiv" class="listingDiv"
								style="width: 100%; overflow-y: auto;"></div>
						</div>
					</div>
					
					
					<div class="sl-section">
					<div class="row">
						<div class="col-md-12">
							<div id="section1" class="sectionDiv">
								<div class="sl-title-box">${lbl_aboutus}</div>
								<p>We are tender masters...</p>
							</div>
							<div id="section2" class="sectionDiv">
								<div class="sl-title-box">${lbl_fq}</div>
								<p>Here is your FAQ detail...</p>
							</div>
							<div id="section3" class="sectionDiv">
								<div class="sl-title-box">${lbl_privacy_police}</div>
								<p>Here is your Privacy policy detail...</p>
							</div>
							<div id="section4" class="sectionDiv">
								<div class="sl-title-box">${lbl_disclaimer}</div>
								<p>Here is your Disclaimer detail...</p>
							</div>
							<div id="section5" class="sectionDiv">
								<div class="sl-title-box">${lbl_download_software}</div>
								<p>Here is your Download software supports detail...</p>
								<ul>
									<li><a
										href="http://www.adobe.com/products/acrobat/readstep2.html"
										target="_blank">PDF reader</a>
									</li>
									<li><a
										href="http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html"
										target="_blank">Java</a>
									</li>
								</ul>

							</div>
							<div id="section6" class="sectionDiv">
								<div class="sl-title-box">${lbl_browsersupport}</div>
								<p>Here is your Browser support detail...</p>
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
<script src="${pageContext.servletContext.contextPath}/resources/js/jQuery/jquery.datetimepicker.js"></script>
 <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/resources/css/jquery.datetimepicker.css">
 <script src="${pageContext.request.contextPath}/resources/js/commonListing.js"></script>

	
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
	var tabIndex = $(".listingTab.active").attr("tabindex");
	var colIndx;
	if(tabIndex == 48){
		colIndx = getColumnIndex('Auction Id.');
	}else{
		colIndx = getColumnIndex('Tender Id.');
	}
	colIndx++;
	if(actionname.toLowerCase() == "view"){
		var tenderId = $(cthis).closest("tr").find('td:nth-child('+colIndx+')').html()
		var viewCorrigendum = false;
		colIndx = getColumnIndex('Corrigendum');
		colIndx++;
		var corrigendumCount = $(cthis).closest("tr").find('td:nth-child('+colIndx+')').html();
		if($.trim(corrigendumCount) != '0'){
			viewCorrigendum = true;
		}//?viewCorrigendum="+viewCorrigendum+"&viewDoclument=true
                if(tabIndex == 48){
                    <%-- window.location = "${pageContext.servletContext.contextPath}/etender/buyer/viewtender/"+tenderId+"/2"--%>
                    window.location = "${pageContext.servletContext.contextPath}/eBid/Bid/viewAuction/"+tenderId+"/2"
                }
                else
                {
                    window.location = "${pageContext.servletContext.contextPath}/etender/buyer/viewtender/"+tenderId+"/2"
                    
                }
		
	}
}
$(".listingTab").click(function(){
	var tabIndex = $(this).attr("tabindex");
	loadListPage('listingDiv',tabIndex,'tenderListForm');
	$(".listingTab").removeClass("active");
	$("#searchToTab").val(tabIndex);
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
/* function exportContent(className,fileName,txtGenerateType){
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
} */
</script>
<style>
.sectionDiv{
	display: none;
}
</style>
<%@include file="./includes/footer.jsp"%>
	