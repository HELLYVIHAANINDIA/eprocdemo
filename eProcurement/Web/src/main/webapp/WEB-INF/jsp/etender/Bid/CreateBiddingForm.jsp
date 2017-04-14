<%@include file="../../includes/head.jsp"%>
<jsp:useBean id="now" class="java.util.Date" />
<%@include file="../../includes/masterheader.jsp"%>

 
       <c:if test="${not empty successMsg}">
      		<div class="alert alert-success">  ${successMsg}</div>
		</c:if>
	<div class="content-wrapper">
		<section class="content-header">
				<div id="listingDiv">
				</div>
     	</section>
    </div>
	
	


<script type="text/javascript">
loadListPage('listingDiv',1);
function callActionItem(cthis){
	var actionname = $(cthis).attr("actionname");
	if(actionname.toLowerCase() == "edit"){
		var tenderId = $(cthis).closest("tr").find('td:nth-child(4)').html()
		window.location = "${pageContext.servletContext.contextPath}/etender/buyer/createevent/"+tenderId
	}else if(actionname.toLowerCase() == "view"){
		var tenderId = $(cthis).closest("tr").find('td:nth-child(4)').html()
		window.location = "${pageContext.servletContext.contextPath}/etender/buyer/viewtender/"+tenderId+"/0"
	}else if(actionname.toLowerCase() == "dashboard"){
		var tenderId = $(cthis).closest("tr").find('td:nth-child(4)').html()
		window.location = "${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/"+tenderId
	}
	
}
</script>
<%@include file="../../includes/footer.jsp"%>