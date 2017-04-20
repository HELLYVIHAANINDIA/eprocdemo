<head>
<noscript>
<meta http-equiv="refresh" content="0; URL=${pageContext.request.contextPath}/jsinstruction">
</noscript>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="keywords" content="eProcurement">
  <title>Cahoot Technologies</title>
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/font-awesome.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/AdminLTE.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/blue.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/morris.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jquery-jvectormap-1.2.2.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/iCheck/all.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap3-wysihtml5.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bgi.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/template1/css/style.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/select2.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/skin-blue.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/epro.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/datepicker3.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jquery.datetimepicker.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jquery-ui.min.css">
<link href="${pageContext.request.contextPath}/resources/js/datatable/css/buttons.dataTables.min.css" rel="stylesheet" />
<link type="text/css" rel="stylesheet" media="all" href="${pageContext.request.contextPath}/resources/js/datatable/css/demo_table_jui.css" >
<link type="text/css" rel="stylesheet" media="all" href="${pageContext.request.contextPath}/resources/js/datatable/css/jquery-ui-1.8.11.custom.css" >
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jquery.alerts.css">

<script src="${pageContext.request.contextPath}/resources/js/jquery-2.2.3.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery-ui.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap3-wysihtml5.all.min.js"></script> 
<script src="${pageContext.request.contextPath}/resources/js/validationDefault.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/app.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/print/jquery.txt"></script>
<script src="${pageContext.request.contextPath}/resources/js/blockUI.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resources/js/select2.full.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jQuery/jquery.datetimepicker.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/commonListing.js"></script>


<script src="${pageContext.request.contextPath}/resources/js/jquery.alerts.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/datatable/pdfmake.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/PageJS/ViewBiddingForm.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resources/js/datatable/jquery.dataTables.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/datatable/dataTables.buttons.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/datatable/buttons.flash.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/datatable/jszip.min.js "></script>
<script src="${pageContext.request.contextPath}/resources/js/datatable/buttons.html5.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/datatable/buttons.print.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/datatable/fnReloadAjax.js"></script>


	<style type="text/css">
		.hideColumn{display:none;}
	</style>
</head>

<body class="skin-blue sidebar-mini">
  
<div class="wrapper">

<header class="main-header">

	<a href="#" class="logo">
      <span class="logo-mini"><b>CTPL</b></span>
      <c:if test="${sessionObject.userTypeId eq 2}">
      <c:set var="logourl" value="${pageContext.servletContext.contextPath}/etender/bidder/bidderTenderListing" ></c:set>
      </c:if>
      <c:if test="${sessionObject.userTypeId eq 1}">
 		<c:set var="logourl" value="${pageContext.servletContext.contextPath}/etender/buyer/tenderListing" ></c:set>
      </c:if>
      <span class="logo-lg" onclick="window.location.href='${logourl}'">Cahoot<b style="color: #175295;">&nbsp;Technologies</b></span>
    </a>

	<nav class="navbar navbar-static-top" role="navigation">

		<a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
        <span class="sr-only">Toggle navigation</span>
      	</a>

		<c:if test="${sessionObject.userTypeId eq 2}">
			<c:set var="logourl"
				value="${pageContext.request.contextPath}/etender/bidder/bidderTenderListing"></c:set>
		</c:if>

		<c:if test="${sessionObject.userTypeId eq 1}">
			<c:set var="logourl"
				value="${pageContext.request.contextPath}/etender/buyer/tenderListing"></c:set>
		</c:if>

<div class="navbar-custom-menu">
        <ul class="nav navbar-nav">
            	<c:if test="${sessionScope.userId gt 0}">
            	<c:choose>
            	<c:when test="${sessionObject.userTypeId eq 2 or sessionObject.userTypeId eq 1}">
            	
	            	<li class="messages-menu">
	            	<a href=""><spring:message code="lbl_last_login"/> : ${sessionObject.lastLoginDateTime}</a>
	            	</li>
	            	
	            	<li class="dropdown notifications-menu">
	            	<a href="#" class="dropdown-toggle" data-toggle="dropdown">
	            	<span>Welcome</span>&nbsp;${sessionObject.fullName}, &nbsp;<i class="fa fa-angle-down" aria-hidden="true"></i>
	            	</a>
	            	
	            	<ul class="dropdown-menu">
	            	<li>
	            	<ul class="menu">
                  	<li><a href="${pageContext.servletContext.contextPath}/common/user/geteditbidder/${sessionObject.bidderId}/1"><i class="fa fa-user" aria-hidden="true"></i> Profile</a></li>
                  	<li><a href="${pageContext.servletContext.contextPath}/user/getpasswordchange/${sessionScope.userId}/${sessionObject.userTypeId}"><i class="fa fa-cog" aria-hidden="true"></i> Change password</a></li>
	            	</ul>         	
	            	</li>
	            	</ul>
	            	</li>
	            	
	            	<li class="dropdown user user-menu">
	            	<a href="${pageContext.servletContext.contextPath}/submitlogout" style="color: white"><i class="fa fa-sign-in"></i> Logout</a>
	            	</li>
				
				<form name="formLogout" id="formLogout" action="" method="POST" >
				</form>
				          		
               </c:when>
            	<c:otherwise>
<%--             		<li class="messages-menu"><a href="${pageContext.servletContext.contextPath}/common/user/register"><i class="fa fa-book"></i> &nbsp;New Bidder Registration</a></li> --%>
<!--           			<li class="dropdown user user-menu"> -->
<!--           				<input type="hidden" id="currentTime"/> -->
<!--             			<a href="#"  class="dropdown-toggle" data-toggle="dropdown"> -->
<!--               			<i class="fa fa-sign-in"></i>&nbsp; Login -->
<!--             		</a> -->
<!--             		<ul class="dropdown-menu"> -->
<!-- 			              User image -->
<!-- 			              <li class="user-header"> -->
<!-- 			              	<form name="formLogin" action="submitLogin" onsubmit="javascript:{loginValidate()}" method="POST"> -->
<!-- 			              	<input type='text' name='j_username'  validarr="required@@email" tovalid="true" onblur="javascript:{validateTxtComp(this)}" title="Email id"  class="form-control" placeholder="Email ID :"/> -->
<!-- 			              	<input type='password' name='j_password' class="form-control" placeholder="Password :" /> -->
<!-- 			                <div class="pull-left"> -->
<!-- 			                <input name="submit" value="Login" type="submit" /> -->
<!-- 			                </div> -->
<%-- 			                <div class="pull-right"><a href="${pageContext.servletContext.contextPath}/getforgotpassword" style="color: white;" >Forgot Password ? </a></div> --%>
<!-- 			                </form> -->
<!-- 			              </li> -->
<!-- 			              Menu Body -->
<!-- 			              Menu Footer -->
<!--             		</ul> -->
            	</c:otherwise>
                </c:choose>
            </c:if>
          	
        </ul>
      </div>

	</nav>

</header>

<aside class="main-sidebar">

	<section class="sidebar">

		<ul class="sidebar-menu" style="height: 800px">
			<li class="treeview">
			<c:if test="${sessionObject.userTypeId eq 1}">
				<li class="treeview"><a
					href="${pageContext.request.contextPath}/common/user/notificationTab/${sessionObject.userId}/0">
						<i class="fa fa-envelope"></i><span> Notification <i
							class="fa fa-bell"></i> (<span id="notificationCount"></span>)
					</span>
				</a></li>
			
			<li class="header">FEATURES</li>

				<li class="treeview"><a href="#"> <i
						class="epro icon-admin"></i> <span>Administration</span> <span
						class="pull-right-container"><i
							class="fa fa-fw pull-right fa-plus"></i></span>
				</a>
					<ul class="treeview-menu">
						<c:if test="${sessionObject.isCTPLUser eq 1}">
							<li class="active"><a
								href="${pageContext.request.contextPath}/common/user/manageorganization"><i
									class="fa fa-circle-o"></i>
								<spring:message code="lbl_create_org" /></a></li>
						</c:if>
						<li class="active"><a
							href="${pageContext.request.contextPath}/common/user/getmanagebidder"><i
								class="fa fa-circle-o"></i>
							<spring:message code="lbl_manage_bidder" /></a></li>
						<c:if test="${sessionObject.isOrgenizationUser eq 1}">
							<c:if test="${sessionObject.deptId ne 0}">
								<li class="active"><a
									href="${pageContext.request.contextPath}/common/user/currencyMapping/${sessionObject.deptId}"><i
										class="fa fa-circle-o"></i>
									<spring:message code="lbl_currency_mapping" /></a></li>
							</c:if>
							<li class="active"><a
								href="${pageContext.request.contextPath}/common/user/getlocationdepartment"><i
									class="fa fa-circle-o"></i>
								<spring:message code="lbl_create_locationdept" /></a></li>
							<li class="active"><a
								href="${pageContext.request.contextPath}/common/user/getdepartments"><i
									class="fa fa-circle-o"></i>
								<spring:message code="lbl_create_subdept" /></a></li>
						</c:if>

						<c:if test="${sessionObject.isOrgenizationUser eq 0}">
							<li class="active"><a
								href="${pageContext.request.contextPath}/common/user/getlocationdepartment"><i
									class="fa fa-circle-o"></i>
								<spring:message code="lbl_create_locationdept" /></a></li>
							<li class="active"><a
								href="${pageContext.request.contextPath}/common/user/getdepartments"><i
									class="fa fa-circle-o"></i>
								<spring:message code="lbl_create_subdept" /></a></li>
						</c:if>

						<li class="active"><a
							href="${pageContext.request.contextPath}/common/user/getdesignation"><i
								class="fa fa-circle-o"></i>
							<spring:message code="lbl_create_designation" /></a></li>
						<li class="active"><a
							href="${pageContext.request.contextPath}/common/user/getcreateofficer"><i
								class="fa fa-circle-o"></i>
							<spring:message code="lbl_create_user" /></a></li>
						<li class="active"><a
							href="${pageContext.request.contextPath}/common/user/getmanageuser"><i
								class="fa fa-circle-o"></i>
							<spring:message code="lbl_manage_user" /></a></li>

						<c:if test="${sessionObject.isCTPLUser eq 1}">
							<li><a
								href="${pageContext.request.contextPath}/common/user/getaddlink"><i
									class="fa fa-circle-o"></i>
								<spring:message code="lbl_add_link" /></a></li>
							<li><a
								href="${pageContext.request.contextPath}/common/user/managelinks"><i
									class="fa fa-circle-o"></i>
								<spring:message code="lbl_manage_link" /></a></li>
							<li><a
								href="${pageContext.request.contextPath}/common/user/getroleslink"><i
									class="fa fa-circle-o"></i>
								<spring:message code="lbl_add_link_to_role" /></a></li>
						</c:if>

						<c:if
							test="${sessionObject.isOrgenizationUser eq 1 or sessionObject.isCTPLUser eq 1}">
							<li class="active"><a
								href="${pageContext.request.contextPath}/common/addEditMarquee/0"><i
									class="fa fa-circle-o"></i>
								<spring:message code="lbl_add_edit_marquee" /></a></li>
						</c:if>

					</ul></li>
			</c:if>

			<c:if test="${sessionObject.userTypeId eq 2}">
			
				<li class="treeview"><a href="#"> <i
						class="epro icon-bidder"></i> <span>Bidder</span> <span
						class="pull-right-container"><i
							class="fa fa-fw pull-right fa-plus"></i></span>
				</a>
					<ul class="treeview-menu">
						<li><a
							href="${pageContext.request.contextPath}/etender/bidder/bidderTenderListing/0"><i
								class="fa fa-circle-o"></i>
							<spring:message code="lbl_tender_list" /></a></li>
						<li><a
							href="${pageContext.request.contextPath}/etender/bidder/bidderTenderListing/1"><i
								class="fa fa-circle-o"></i>
							<spring:message code="lbl_auction_list" /></a></li>
					</ul></li>
			</c:if>

			<c:if test="${sessionObject.userTypeId eq 1}">
				<li class="treeview"><a href="#"> <i class="epro icon-RFX"></i>
						<span>RFX</span> <span class="pull-right-container"><i
							class="fa fa-fw pull-right fa-plus"></i></span>
				</a>
					<ul class="treeview-menu">
						<li><a
							href="${pageContext.request.contextPath}/etender/buyer/createevent/0"><i
								class="epro icon-create-tender"></i> Create Tender</a></li>
						<li><a
							href="${pageContext.request.contextPath}/etender/buyer/tenderListing"><i
								class="epro icon-tender"></i> Tender List</a></li>
						<li><a
							href="${pageContext.request.contextPath}/etender/buyer/getEvaluationList/1"><i
								class="fa fa-circle-o"></i>
							<spring:message code="lbl_tender_opening" /></a></li>
						<li><a
							href="${pageContext.request.contextPath}/etender/buyer/getEvaluationList/2"><i
								class="fa fa-circle-o"></i>
							<spring:message code="lbl_tender_evaluation" /></a></li>
					</ul>
				</li>
				<li class="treeview">
					<a href="#"> <i class="epro icon-RFX"></i>
						<span>Auction</span>
						<span class="pull-right-container">
							<i class="fa fa-fw pull-right fa-plus"></i>
						</span>
					</a>
					<ul class="treeview-menu">
						<li>
							<a href="${pageContext.request.contextPath}/eBid/Bid/createAuction/0">
							<i class="fa fa-circle-o"></i>Create Auction</a>
						</li>
						<li>
							<a href="${pageContext.request.contextPath}/eBid/Bid/auctionListing">
							<i class="fa fa-circle-o"></i>Auction Listing</a>
						</li>
					</ul>
				</li>
			</c:if>

			<c:if test="${sessionObject.userTypeId eq 1}">
				<li class="treeview"><a href="#"> <i
						class="epro icon-workflow"></i> <span>WorkFlow</span> <span
						class="pull-right-container"><i
							class="fa fa-fw pull-right fa-plus"></i></span>
				</a>
					<ul class="treeview-menu">
						<li><a
							href="${pageContext.request.contextPath}/etender/buyer/workflowlist/${sessionScope.userId}/0"><i
								class="fa fa-circle-o"></i>
							<spring:message code="lbl_workflow_pending" /></a></li>
						<li><a
							href="${pageContext.request.contextPath}/etender/buyer/workflowlist/${sessionScope.userId}/1"><i
								class="fa fa-circle-o"></i>
							<spring:message code="lbl_workflow_processed" /></a></li>
					</ul></li>
				<li class="treeview"><a href="#"> <i
						class="epro icon-report"></i> <span>Reports</span> <span
						class="pull-right-container"> <i
							class="fa fa-fw pull-right fa-plus"></i>
					</span>
				</a>
					<ul class="treeview-menu">
						<li><a
							href="${pageContext.request.contextPath}/common/audittrial"><i
								class="fa fa-circle-o"></i>Audit Trail Report</a></li>
					</ul></li>
			</c:if>

		</ul>

	</section>

</aside>
