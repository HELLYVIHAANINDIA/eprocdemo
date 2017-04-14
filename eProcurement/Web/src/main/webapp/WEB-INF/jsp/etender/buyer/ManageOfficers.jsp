<%@include file="../../includes/head.jsp"%>
<%@include file="../../includes/masterheader.jsp"%>
<script src="${pageContext.servletContext.contextPath}/resources/js/jquery-ui.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/commonListing.js"></script>
        <spring:message code="lbl_manage_user" var="lbl_manage_user"/>
   <div class="content-wrapper">   
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
				<c:if test="${sessionObject.isCTPLUser eq 0}">
					<input type="hidden" value="${tblGrandParentDept.deptId}" class="searchEqual" columnName="b.grandParentDeptId" name="b.grandParentDeptId">
					<input type="hidden"  id="jsonSearchCriteria" name="jsonSearchCriteria">
					
					</c:if>
					<input type="hidden"  name="defaultOrder" id="defaultOrder" value="4:Desc">
				</form>
</div>				
</section>
</div> 
<script type="text/javascript">
loadListPage('listingDiv',7,'tenderListForm');
function callActionItem(cthis){
	var actionname = $(cthis).attr("actionname");
	var officerId  = getColumnIndex('officerId');
	if(actionname.toLowerCase() == "edit"){
		officerId = $(cthis).closest("tr").find('td:nth-child('+(officerId+1)+')').html();
		window.location = "${pageContext.servletContext.contextPath}/common/user/geteditofficer/"+officerId+"/admin";
	}
	if(actionname.toLowerCase() == "delete"){
		jConfirm("Are you sure you want to delete user ?","Manage User",function (result) { 
			if(result){
				officerId = $(cthis).closest("tr").find('td:nth-child('+(officerId+1)+')').html();
				window.location = "${pageContext.servletContext.contextPath}/common/user/deleteuser/"+officerId;
			}
        }); 
	}
}
</script>
 <%@include file="../../includes/footer.jsp"%>