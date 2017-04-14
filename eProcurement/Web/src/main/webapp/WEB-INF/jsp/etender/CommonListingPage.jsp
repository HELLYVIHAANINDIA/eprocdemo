<!DOCTYPE HTML>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
    <head>
        <script src="${pageContext.servletContext.contextPath}/resources/js/datatable/jquery.dataTables.min.js"></script>
		<script src="${pageContext.servletContext.contextPath}/resources/js/datatable/dataTables.buttons.min.js"></script>
		<script src="${pageContext.servletContext.contextPath}/resources/js/datatable/buttons.flash.min.js"></script>
		<script src="${pageContext.servletContext.contextPath}/resources/js/datatable/jszip.min.js "></script>
		<script src="${pageContext.servletContext.contextPath}/resources/js/datatable/vfs_fonts.js"></script>
		<script src="${pageContext.servletContext.contextPath}/resources/js/datatable/buttons.html5.min.js"></script>
		<script src="${pageContext.servletContext.contextPath}/resources/js/datatable/buttons.print.min.js"></script>
		<script src="${pageContext.servletContext.contextPath}/resources/js/datatable/fnReloadAjax.js"></script>  
		<link href="${pageContext.servletContext.contextPath}/resources/js/datatable/css/buttons.dataTables.min.css" rel="stylesheet" />		
		<link type="text/css" rel="stylesheet" media="all" href="${pageContext.servletContext.contextPath}/resources/js/datatable/css/demo_table_jui.css">
		<link type="text/css" rel="stylesheet" media="all" href="${pageContext.servletContext.contextPath}/resources/js/datatable/css/jquery-ui-1.8.11.custom.css">
    </head>
<body>
      
		
<div class="content_section" >
	<!--***************Right Part Starts Form Here**********-->
    <section class="dashboard-right-bar">
<!--                    <form name="form2">
-->     <input type="hidden" name="actionItem" id="actionItem" value="${listingDemo.actionItem}">  
    	<input type="hidden" name="commonAction" id="commonAction" value="${listingDemo.commonAction}"> 
    	<input type="hidden" name="fromClause" id="fromClause" value="${listingDemo.fromClause}"> 
    	<input type="hidden" name="srnoCol" id="srnoCol" value="${listingDemo.srnoCol}"> 
    	
    	<c:set var="dateParts" value="${fn:split(listingDemo.columnName, '~')}" />
    	
    	<input type="hidden" id="fileNameForExport" value="${fn:replace(listingDemo.discription,' ','')}">
    	<c:set var="column" value="" />
    	<table class="table table-striped table-responsive" id="listingTable" style="width: 100%">
			<thead>
				<tr>
					<c:if test="${not empty listingDemo.commonAction}">
						<c:set var="column" value="checkbox" />
						<th><input type="checkbox" class="commonCHK noExport"></th>
					</c:if>
					<c:if test="${not empty listingDemo.srnoCol && listingDemo.srnoCol eq 1}">
						<th coldisplayname="srno">Sr. No.</th>
					</c:if>
					<c:forEach items="${dateParts}" var="headerCol">                             
					<c:set var="col" value="${fn:split(headerCol, ':')}" />
					<c:set var="column" value="${column},${col[0]}" />
					<c:set var="displayCls" value=""></c:set>                                 
					<c:if test="${col[2] eq 0}">
					<c:set var="displayCls" value="hideColumn"></c:set>
					</c:if>
						<th class="${displayCls}" coldisplayname="${col[1]}">${col[1]}</th>
					</c:forEach> 
					<c:if test="${not empty listingDemo.actionItem}">
					   <c:set var="column" value="${column},actionitem" />					
						<th class="actionCol noExport">Action</th>
					</c:if>
				</tr>
			</thead>          	
       	</table>
      <input type="hidden" name="columnName" id="columnName" value="${column}">  
    </section>
    <!--***********Right Part Ends here***********-->
    <div style="clear:both;"></div>
 </div>	
	
</body>
</html>
