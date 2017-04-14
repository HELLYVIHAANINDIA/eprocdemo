<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <%@include file="./../includes/header.jsp"%>
        <%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
        <script src="${pageContext.servletContext.contextPath}/resources/js/commonValidate.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/resources/js/commonListing.js"></script>        
        <spring:message code="lbl_manage_link" var="lbl_manage_link"/>
        <title>${lbl_manage_link}</title>
        <script type="text/javascript">
            $(document).ready(function() {
            
        	});
           </script>
</head>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="./../includes/leftaccordion.jsp"%>

<div class="content-wrapper" style="height: 1000px; ">
<section class="content-header">
			<h1>
				${lbl_manage_link}
			</h1>
</section>

<section class="content">
<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="box">
						<div class="box-header with-border">
	               					<spring:message code="lbl_edit_dept" var="editdepartment"/>
	               						<h3 class="box-title">Mange Links</h3>											
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
	</div>			
</section>


</div>

</div>

<script type="text/javascript">
loadListPage('listingDiv',9);
function callActionItem(cthis){
	var actionname = $(cthis).attr("actionname");
	if(actionname.toLowerCase() == "edit"){
		var linkId = $(cthis).closest("tr").find('td:nth-child(3)').html()
		window.location = "${pageContext.servletContext.contextPath}/common/user/geteditlink/"+linkId;
	}
	
}
</script>
  <script type="text/javascript">
  
</script>
    </body>
</html>