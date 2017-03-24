<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <%@include file="./../../includes/header.jsp"%>
        <%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
        <script src="${pageContext.servletContext.contextPath}/resources/js/commonValidate.js" type="text/javascript"></script>
        <script src="${pageContext.servletContext.contextPath}/resources/js/jquery-ui.custom.js" type="text/javascript"></script>
		<script src="${pageContext.servletContext.contextPath}/resources/js/jquery.cookie.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/resources/js/commonListing.js"></script>        
        <spring:message code="lbl_create_dept" var="createdepartment"/>
        <title>${createdepartment}</title>
        <script type="text/javascript">
            $(document).ready(function() {
            
        	});
</script>
</head>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="../../includes/leftaccordion.jsp"%>

	<div class="content-wrapper" style="height: auto;">
	
		<section class="content-header">
		<h1>Audit trial reports</h1>
		</section>
		
		<section class="content">
			<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="box">
						<div class="box-header with-border">
							<spring:message code="lbl_edit_dept" var="editdepartment" />
							<h3 class="box-title">Audit trial reports</h3>
						</div>
					<div class="box-body">
						<div class="row">
							<div class="col-lg-12 col-md-12 col-xs-12">
								<form id="tenderListForm">
									<div class="row">
										<div class="col-md-2">
											<div class="form_filed">Email Id</div>
										</div>
										<div class="col-md-5">
											<input type="text" class="searchLike form-control" columnname="EMAIL_ID">
										</div>
									</div>
									<div class="row">
										<div class="col-md-2">
											<div class="form_filed">Link</div>
										</div>
										<div class="col-md-5">
											<input type="text" class="searchLike form-control" columnname="PAGE_URL">
										</div>
									</div>
									<div class="row">
										<div class="col-md-2">
											
										</div>
										<div class="col-md-5">
											<input type="hidden" name="jsonSearchCriteria" id="jsonSearchCriteria">
											<input type="button" onclick="searchForList()" class="btn btn-submit" value="Search">
											<input type="hidden" name="defaultOrder" id="defaultOrder" value="1:desc">
											<input type="reset" class="btn btn-submit" value="Clear" onclick="location.reload();">
										</div>
										
									</div>
								</form>
							</div>
							
							<div class="col-lg-12 col-md-12 col-xs-12">
								<div id="listingDiv"></div>
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
		loadListPage('listingDiv', 20);
		function searchForList() {
			loadListPage('listingDiv', 20, 'tenderListForm')
		}
	</script>
	<script type="text/javascript">
  
</script>
</body>
</html>