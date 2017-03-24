<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <%@include file="./../../includes/header.jsp"%>
        <%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
        <script src="${pageContext.servletContext.contextPath}/resources/js/commonValidate.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/resources/js/commonListing.js"></script>        
        <spring:message code="lbl_manage_user" var="lbl_manage_user"/>
        <title>${lbl_manage_user}</title>
        <script type="text/javascript">
            $(document).ready(function() {
            
        	});
        </script>
</head>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="./../../includes/leftaccordion.jsp"%>

<div class="content-wrapper" style="height: auto; ">
<section class="content-header">
<h1>Administration</h1>
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
	               						<h3 class="box-title">${lbl_manage_user}</h3>											
						</div>
					<div class="box-body">
							<div class="row">
								<div class="col-lg-12 col-md-12 col-xs-12">
									<div id="listingDiv">
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<form id="tenderListForm" style="display: none;">
				<c:if test="${sessionObject.isOrgenizationUser eq 0}">
					<input type="hidden" value="${tblGrandParentDept.deptId}" class="searchEqual" columnName="b.grandParentDeptId" name="b.grandParentDeptId">
					<input type="hidden"  id="jsonSearchCriteria" name="jsonSearchCriteria">
					</c:if>
				</form>
</div>				
</section>

</div>  

</div>

<script type="text/javascript">
loadListPage('listingDiv',7,'tenderListForm');
function callActionItem(cthis){
	var actionname = $(cthis).attr("actionname");
	console.log(actionname);
	if(actionname.toLowerCase() == "edit"){
		var officerId = $(cthis).closest("tr").find('td:nth-child(5)').html()
		window.location = "${pageContext.servletContext.contextPath}/common/user/geteditofficer/"+officerId;
	}
	
}
</script>
  <script type="text/javascript">
  
</script>

</body>

</html>