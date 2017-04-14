<!DOCTYPE html>
<html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<%@include file="../../includes/header.jsp"%>
  <script src="${pageContext.request.contextPath}/resources/js/commonListing.js"></script>
</head>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="../../includes/leftaccordion.jsp"%>

	<div class="content-wrapper">
		<section class="content-header">
			<c:if test="${not empty successMsg}">
      		<div class="alert alert-success">  ${successMsg}</div>
		</c:if>	
     	</section>
     	<section class="content">
     	<div id="listingDiv">
				</div>
    </div>
	<%@include file="../../includes/footer.jsp"%>
	

	</div>
<script type="text/javascript">
loadListPage('listingDiv',1);
function callActionItem(cthis){
	var actionname = $(cthis).attr("actionname");
	if(actionname == "edit"){
		var tenderId = $(cthis).closest("tr").find('td:nth-child(4)').html()
		window.location = "${pageContext.servletContext.contextPath}/etender/buyer/createevent/"+tenderId
	}else if(actionname == "view"){
		var tenderId = $(cthis).closest("tr").find('td:nth-child(4)').html()
		window.location = "${pageContext.servletContext.contextPath}/etender/buyer/viewtender/"+tenderId+"/0"
	}else if(actionname == "dashboard"){
		var tenderId = $(cthis).closest("tr").find('td:nth-child(4)').html()
		window.location = "${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/"+tenderId
	}
	
}
</script>
</body>
</html>