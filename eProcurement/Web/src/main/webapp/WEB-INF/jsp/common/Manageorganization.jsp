<%@include file="./../includes/head.jsp"%>
    <%@include file="./../includes/masterheader.jsp"%>
   
        <spring:message code="lbl_tender_authority" var="createdepartment"/>
        
     
   <div class="content-wrapper">
	
		<section class="content-header">
			<h1>Administration</h1>
		</section>

		<section class="content">
		<div class="row">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			<div class="box">
				<c:if test="${not empty successMsg}">
					<div class="alert alert-success">
						<spring:message code="${successMsg}" />
					</div>
				</c:if>
				<c:if test="${not empty errorMsg}">
					<div class="alert alert-danger">
						<spring:message code="${errorMsg}" />
					</div>
				</c:if>
				<div class="box-header with-border">
					<c:choose>
						<c:when test="${optType eq 'edit'}">
							<spring:message code="lbl_edit_org" var="editdepartment" />
							<h3 class="box-title">${editdepartment}</h3>
						</c:when>
						<c:otherwise>
							<spring:message code="lbl_create_org" var="lbl_create_org" />
							<h3 class="box-title">${lbl_create_org}</h3>
						</c:otherwise>
					</c:choose>
				</div>

				<div class="box-body">
					<div class="row">
						<div class="col-lg-12 col-md-12 col-xs-12">
							<section class="">
							<div class="nav-tabs-custom">
							<ul class="nav nav-tabs">
								<li class="active listingTab" tabindex="21"><a href="#">Pending</a>
								</li>
								<li class="listingTab" tabindex="40"><a href="#">Approved</a>
								</li>
								<li class="listingTab" tabindex="42"><a href="#">Rejected</a>
								</li>
								<li class="listingTab" tabindex="43"><a href="#">Deactivated</a>
								</li>
							</ul>
							</div>
							<div id="listingDiv"></div>
							<form id="tenderListForm" style="display: none;">
								<input type="hidden"  name="defaultOrder" id="defaultOrder" value="5:Desc">
								</form>
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
$(".listingTab").click(function(){
	var tabIndex = $(this).attr("tabindex");
	loadListPage('listingDiv',tabIndex);
	$(".listingTab").removeClass("active");
	$(this).addClass("active");
})
// loadListPage('listingDiv',21);
loadListPage('listingDiv',21,'tenderListForm');
function callActionItem(cthis){
	var actionname = $(cthis).attr("actionname");
	var colIndx = getColumnIndex('deptId');
	if(actionname.toLowerCase() == "view"){
		var deptId  = getColumnIndex('deptId');
		var tabId = $(".listingTab.active").attr("tabindex");
		deptId = $(cthis).closest("tr").find('td:nth-child('+(deptId+1)+')').html();
		window.location = "${pageContext.servletContext.contextPath}/common/user/geteditorganization/"+deptId+"/2/"+tabId+"/1";
	}
	if(actionname.toLowerCase() == "approve/reject"){
		var deptId  = getColumnIndex('deptId');
		var tabId = $(".listingTab.active").attr("tabindex");
		deptId = $(cthis).closest("tr").find('td:nth-child('+(deptId+1)+')').html();
		window.location = "${pageContext.servletContext.contextPath}/common/user/geteditorganization/"+deptId+"/0/"+tabId+"/0";
	}
	if(actionname.toLowerCase() == "deactivate"){
		var deptId  = getColumnIndex('deptId');
		var tabId = $(".listingTab.active").attr("tabindex");
		deptId = $(cthis).closest("tr").find('td:nth-child('+(deptId+1)+')').html();
		window.location = "${pageContext.servletContext.contextPath}/common/user/geteditorganization/"+deptId+"/3/"+tabId+"/0";
	}
	if(actionname.toLowerCase() == "activate"){
		var deptId  = getColumnIndex('deptId');
		var tabId = $(".listingTab.active").attr("tabindex");
		deptId = $(cthis).closest("tr").find('td:nth-child('+(deptId+1)+')').html();
		window.location = "${pageContext.servletContext.contextPath}/common/user/geteditorganization/"+deptId+"/1/"+tabId+"/0";
	}
}
</script>
   <script type="text/javascript">
        var VALIDATE_MSG_REQUIRED = 'Please enter';
        var VALIDATE_MSG_SELECT = 'Please select';
        var VALIDATE_MSG_ALLOW_MAX='Allows Max. ';
        var VALIDATE_MSG_TENDERBRIEF='characters';
        var isDepartmentExists=false;
        	$(document).ready(function() {
       		});
            function validate(){
            	var vbool = valOnSubmit();
            	return disableBtn(vbool);
            }
           </script>
           <style>
           .displaynone{
           	display: none;
           }
           </style>
           <%@include file="./../includes/footer.jsp"%>

