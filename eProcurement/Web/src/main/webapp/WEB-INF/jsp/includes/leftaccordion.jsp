<header class="main-header">

	<nav class="navbar navbar-static-top" role="navigation">

		<!-- Sidebar toggle button-->
		<a href="#" class="sidebar-toggle" data-toggle="offcanvas"
			role="button"> <span class="sr-only">Toggle navigation</span>
		</a> <a onclick="window.location.href='${logourl}'" class="logo"> <img
			src="${pageContext.servletContext.contextPath}/resources/images/bgi_logo.png"
			alt="Businessgateways International" />
		</a>

		<c:if test="${sessionObject.userTypeId eq 2}">
			<c:set var="logourl"
				value="${pageContext.servletContext.contextPath}/etender/bidder/bidderTenderListing"></c:set>
		</c:if>

		<c:if test="${sessionObject.userTypeId eq 1}">
			<c:set var="logourl"
				value="${pageContext.servletContext.contextPath}/etender/buyer/tenderListing"></c:set>
		</c:if>

		<!-- Navbar Right Menu -->
		<div class="navbar-custom-menu">

			<c:choose>
				<c:when test="${sessionObject.userTypeId eq 1}">
					<c:set var="className" value="nav navbar-nav" />
				</c:when>
				<c:when test="${sessionObject.userTypeId eq 1}">
					<c:set var="className" value="navbar-nav" />
				</c:when>
			</c:choose>

			<ul class="nav navbar-nav">
				<li><spring:message code="lbl_date_time" /><div id="dispalyDateTime"></div> ${sessionObject.timeZoneOffset}</li>	
				<c:choose>

					<c:when test="${sessionScope.userId gt 0}">

						<c:if test="${sessionObject.userTypeId eq 2}">
							<li><a href="#"><spring:message code="lbl_last_login" />
									: ${sessionObject.lastLoginDateTime}</a></li>

							<li><a
								href="${pageContext.servletContext.contextPath}/user/getpasswordchange/${sessionScope.userId}/${sessionObject.userTypeId}">Change
									password</a></li>

							<li><span class="default-profile"> <i
									class="fa fa-fw fa-user"></i>
							</span></li>

							<li><span class="welcome">Welcome </span> <span
								class="company-name"><a
									href="${pageContext.servletContext.contextPath}/common/user/geteditbidder/${sessionObject.bidderId}/1">${sessionObject.fullName}</a>
							</span></li>

							<li><a
								href="${pageContext.servletContext.contextPath}/submitlogout"
								class="logout"> <span class="glyphicon glyphicon-log-out"></span>
									Logout
							</a></li>

						</c:if>

						<c:if test="${sessionObject.userTypeId eq 1}">

							<li><a href="">Last login :
									${sessionObject.lastLoginDateTime}</a></li>

							<li><span class="default-profile"> <i
									class="fa fa-fw fa-user"></i>
							</span></li>

							<li><span class="welcome">Welcome </span> <span
								class="company-name"> <a
									href="${pageContext.servletContext.contextPath}/common/user/geteditofficer/${sessionObject.officerId}/buyer">${sessionObject.fullName}</a>
							</span></li>

							<li><a
								href="${pageContext.servletContext.contextPath}/submitlogout"
								class="logout"> <span class="glyphicon glyphicon-log-out"></span>
									Logout
							</a></li>

						</c:if>
					</c:when>
				</c:choose>
			</ul>

		</div>

	</nav>

</header>

<aside class="main-sidebar">

	<section class="sidebar">

		<form action="#" method="get" class="sidebar-form">
			<div class="input-group">
				<input type="text" name="q" class="sdf"
					placeholder="Type Keyword..."> <span
					class="input-group-btn">
					<button type="submit" name="search" id="search-btn"
						class="btn btn-flat">
						<i class="fa fa-search"></i>
					</button>
				</span>
			</div>
		</form>

		<ul class="sidebar-menu" style="height: 800px">
			<li class="active"><a href="#"> <i class="fa fa-envelope"></i>
					<span>Message Box</span> <span class="pull-right-container">
						<small class="label pull-right bg-red">15+</small>
				</span>
			</a></li>
			<li><a href="#"> <i class="epro icon-tender"> </i> <span>Tender</span>
					<span class="pull-right-container"> <small
						class="label pull-right bg-green">10</small>
				</span>
			</a></li>
			<li><a href="#"> <i class="epro icon-create-tender"> </i> <span>Create
						Tender</span>
			</a></li>
			<li class="menu-title">OUR PRODUCTS</li>

			<c:if test="${sessionObject.userTypeId eq 1}">
				<li class="treeview"><a
					href="${pageContext.servletContext.contextPath}/common/user/notificationTab/${sessionObject.userId}/0">
						<i class="fa fa-envelope"></i><span> Notification <i
							class="fa fa-bell"></i> (<span id="notificationCount"></span>)
					</span>
				</a></li>

				<li class="treeview"><a href="#"> <i
						class="epro icon-admin"></i> <span>Administration</span> <span
						class="pull-right-container"><i
							class="fa fa-fw pull-right fa-plus"></i></span>
				</a>
					<ul class="treeview-menu">
						<c:if test="${sessionObject.isCTPLUser eq 1}">
							<li class="active"><a
								href="${pageContext.servletContext.contextPath}/common/user/manageorganization"><i
									class="fa fa-circle-o"></i>
								<spring:message code="lbl_tender_authority" /></a></li>
						</c:if>
						<c:if test="${sessionObject.isOrgenizationUser eq 1}">
							<c:if test="${sessionObject.deptId ne 0}">
								<li class="active"><a
									href="${pageContext.servletContext.contextPath}/common/user/currencyMapping/${sessionObject.deptId}"><i
										class="fa fa-circle-o"></i>
									<spring:message code="lbl_currency_mapping" /></a></li>
							</c:if>
							<li class="active"><a
								href="${pageContext.servletContext.contextPath}/common/user/getlocationdepartment"><i
									class="fa fa-circle-o"></i>
								<spring:message code="lbl_create_locationdept" /></a></li>
							<li class="active"><a
								href="${pageContext.servletContext.contextPath}/common/user/getdepartments"><i
									class="fa fa-circle-o"></i>
								<spring:message code="lbl_create_subdept" /></a></li>
						</c:if>

						<c:if test="${sessionObject.isOrgenizationUser eq 0}">
							<li class="active"><a
								href="${pageContext.servletContext.contextPath}/common/user/getlocationdepartment"><i
									class="fa fa-circle-o"></i>
								<spring:message code="lbl_create_locationdept" /></a></li>
							<li class="active"><a
								href="${pageContext.servletContext.contextPath}/common/user/getdepartments"><i
									class="fa fa-circle-o"></i>
								<spring:message code="lbl_create_subdept" /></a></li>
						</c:if>

						<li class="active"><a
							href="${pageContext.servletContext.contextPath}/common/user/getdesignation"><i
								class="fa fa-circle-o"></i>
							<spring:message code="lbl_create_designation" /></a></li>
						<li class="active"><a
							href="${pageContext.servletContext.contextPath}/common/user/getcreateofficer"><i
								class="fa fa-circle-o"></i>
							<spring:message code="lbl_create_user" /></a></li>
						<li class="active"><a
							href="${pageContext.servletContext.contextPath}/common/user/getmanageuser"><i
								class="fa fa-circle-o"></i>
							<spring:message code="lbl_manage_user" /></a></li>
													

						<c:if test="${sessionObject.isCTPLUser eq 1}">
							<li class="active"><a
							href="${pageContext.servletContext.contextPath}/common/user/getmanagebidder"><i
								class="fa fa-circle-o"></i>
							<spring:message code="lbl_manage_bidder" /></a></li>
							
							<li><a
								href="${pageContext.servletContext.contextPath}/common/user/getaddlink"><i
									class="fa fa-circle-o"></i>
								<spring:message code="lbl_add_link" /></a></li>
							<li><a
								href="${pageContext.servletContext.contextPath}/common/user/managelinks"><i
									class="fa fa-circle-o"></i>
								<spring:message code="lbl_manage_link" /></a></li>
							<li><a
								href="${pageContext.servletContext.contextPath}/common/user/getroleslink"><i
									class="fa fa-circle-o"></i>
								<spring:message code="lbl_add_link_to_role" /></a></li>
						</c:if>

						<c:if
							test="${sessionObject.isOrgenizationUser eq 1 or sessionObject.isCTPLUser eq 1}">
							<li class="active"><a
								href="${pageContext.servletContext.contextPath}/common/addEditMarquee/0"><i
									class="fa fa-circle-o"></i>
								<spring:message code="lbl_add_edit_marquee" /></a></li>
						</c:if>

					</ul></li>
			</c:if>

			<c:if test="${sessionObject.userTypeId eq 2}">
				<li class="treeview"><a
					href="${pageContext.servletContext.contextPath}/common/user/notificationTab/${sessionObject.userId}/0">
						<i class="fa fa-envelope"></i><span> Notification <i
							class="fa fa-bell"></i> (<span id="notificationCount"></span>)
					</span>
				</a></li>
				<li class="treeview"><a href="#"> <i
						class="epro icon-bidder"></i> <span>Bidder</span> <span
						class="pull-right-container"><i
							class="fa fa-fw pull-right fa-plus"></i></span>
				</a>
					<ul class="treeview-menu">
						<li><a
							href="${pageContext.servletContext.contextPath}/etender/bidder/bidderTenderListing/0"><i
								class="fa fa-circle-o"></i>
							<spring:message code="lbl_tender_list" /></a></li>
						<li><a
							href="${pageContext.servletContext.contextPath}/etender/bidder/bidderTenderListing/1"><i
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
							href="${pageContext.servletContext.contextPath}/etender/buyer/createevent/0"><i
								class="epro icon-create-tender"></i> Create Tender</a></li>
						<li><a
							href="${pageContext.servletContext.contextPath}/etender/buyer/tenderListing"><i
								class="epro icon-tender"></i> Tender List</a></li>
						<li><a
							href="${pageContext.servletContext.contextPath}/etender/buyer/getEvaluationList/1"><i
								class="fa fa-circle-o"></i>
							<spring:message code="lbl_tender_opening" /></a></li>
						<li><a
							href="${pageContext.servletContext.contextPath}/etender/buyer/getEvaluationList/2"><i
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
							<a href="${pageContext.servletContext.contextPath}/eBid/Bid/createAuction/0">
							<i class="fa fa-circle-o"></i>Create Auction</a>
						</li>
						<li>
							<a href="${pageContext.servletContext.contextPath}/eBid/Bid/auctionListing">
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
							href="${pageContext.servletContext.contextPath}/etender/buyer/workflowlist/${sessionScope.userId}/0"><i
								class="fa fa-circle-o"></i>
							<spring:message code="lbl_workflow_pending" /></a></li>
						<li><a
							href="${pageContext.servletContext.contextPath}/etender/buyer/workflowlist/${sessionScope.userId}/1"><i
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
							href="${pageContext.servletContext.contextPath}/common/audittrial"><i
								class="fa fa-circle-o"></i>Audit Trail Report</a></li>
					</ul></li>
			</c:if>

		</ul>

	</section>

</aside>