<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
		<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <script src="${pageContext.servletContext.contextPath}/resources/js/commonListing.js" type="text/javascript"></script>
        <title><spring:message code="eProcurement_title"/></title>
    </head>
<body>
    <%@include file="../includes/header.jsp" %> 
       <div class="col-sm-9 col-md-10 affix-content">
		<div class="container">
			
<div class="content_section" >
               	<!--***************Right Part Starts Form Here**********-->
                   <section class="dashboard-right-bar">
                   <form id="form2">
     	           </form>
                   <!--***********Right Part Ends here***********-->
                   <div style="clear:both;"></div>
               </div>
		</div>
	</div>
<script>

$(document).ready(function() {
	loadListPage("form2",'${listingId}');
});

</script>
       <!--Body Part End-->
       <%@include file="../includes/footer.jsp"%>
</body>
</html>
