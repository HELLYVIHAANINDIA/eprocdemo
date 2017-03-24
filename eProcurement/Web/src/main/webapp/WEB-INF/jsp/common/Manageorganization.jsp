<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <%@include file="./../includes/header.jsp"%>
        <%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
        <script src="${pageContext.servletContext.contextPath}/resources/js/commonValidate.js" type="text/javascript"></script>
		<script src="${pageContext.servletContext.contextPath}/resources/js/blockUI.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/resources/js/commonListing.js"></script>        
        <spring:message code="lbl_tender_authority" var="createdepartment"/>
        <title>${createdepartment}</title>
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
    </head>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="./../includes/leftaccordion.jsp"%>

<div class="content-wrapper" style="height: auto; ">

<section class="content-header">
</section>

<section class="content">
<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="box">
						<c:if test="${not empty successMsg}">
                                        			<div class="alert alert-success"><spring:message code="${successMsg}"/></div>
                                    		</c:if>
                                    		<c:if test="${not empty errorMsg}">
                                        			<div class="alert alert-danger"><spring:message code="${errorMsg}"/></div>
                                    		</c:if>
						<div class="box-header with-border">
							<c:choose>
	               					<c:when test="${optType eq 'edit'}">
	               					<spring:message code="lbl_edit_org" var="editdepartment"/>
	               						<h3 class="box-title">${editdepartment}</h3>											
	               					</c:when>
	               					<c:otherwise>
	               					<spring:message code="lbl_create_org" var="lbl_create_org"/>
	               						<h3 class="box-title">${lbl_create_org}</h3>
								</c:otherwise>
								</c:choose>
						</div>
						
						<div class="box-body">
							<div class="row">
								<div class="col-lg-12 col-md-12 col-xs-12">
									<section class="">
										<ul class="nav nav-tabs">
										  <li class="active listingTab" tabindex="21"><a href="#">Pending</a></li>
										  <li class="listingTab" tabindex="40"><a href="#">Approved</a></li>
										</ul>
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

</div>

<script type="text/javascript">
$(".listingTab").click(function(){
	var tabIndex = $(this).attr("tabindex");
	loadListPage('listingDiv',tabIndex);
	$(".listingTab").removeClass("active");
	$(this).addClass("active");
})
loadListPage('listingDiv',21);
function callActionItem(cthis){
	var actionname = $(cthis).attr("actionname");
	var colIndx = getColumnIndex('deptId');
	if(actionname.toLowerCase() == "view"){
		var deptId  = getColumnIndex('deptId');
		deptId = $(cthis).closest("tr").find('td:nth-child('+(deptId+1)+')').html();
		window.location = "${pageContext.servletContext.contextPath}/common/user/geteditorganization/"+deptId;
	}
}
</script>
  <script type="text/javascript">
  
</script>
</body>
</html>