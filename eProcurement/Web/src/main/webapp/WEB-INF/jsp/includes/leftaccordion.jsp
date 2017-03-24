<header class="main-header" >
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
    <nav class="navbar navbar-static-top">
      <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
        <span class="sr-only">Toggle navigation</span>
      </a>
      <div class="navbar-custom-menu">
        <ul class="nav navbar-nav">
            <c:choose>
            	<c:when test="${sessionScope.userId gt 0}">
            	
            	
            	<c:if test="${sessionObject.userTypeId eq 2}">
            	
            	<li class="messages-menu">
            	<a href=""><spring:message code="lbl_last_login"/> : ${sessionObject.lastLoginDateTime}</a>
            	</li>
            	
            	<li class="messages-menu">
            	<a href="${pageContext.servletContext.contextPath}/common/user/geteditbidder/${sessionObject.bidderId}/1" style="color: white;" ><span>Welcome,</span>${sessionObject.fullName}</a>
            	</li>
            	
            	<li class="messages-menu">
            	<a href="${pageContext.servletContext.contextPath}/user/getpasswordchange/${sessionScope.userId}/${sessionObject.userTypeId}" style="color: white" >Change password</a>
            	</li>
            	
            	<li class="dropdown user user-menu">
            	<a href="${pageContext.servletContext.contextPath}/submitlogout" style="color: white"><i class="fa fa-sign-in"></i> Logout</a>
            	</li>
            	</c:if>
            	
            	<li class="messages-menu">
            	<a href="">Last login : ${sessionObject.lastLoginDateTime}</a>
            	</li>
            	
            	<li class="messages-menu">
            	<c:if test="${sessionObject.userTypeId eq 1}">
            	<a href="${pageContext.servletContext.contextPath}/common/user/viewuser/${sessionObject.officerId}/1" style="color: white"><span>Welcome</span> ${sessionObject.fullName} ,</a>
            	</c:if>
            	</li>
            	           	
            	<li class="dropdown user user-menu">
            	<a href="${pageContext.servletContext.contextPath}/submitlogout" style="color: white"><i class="fa fa-sign-in"></i>Logout</a>         	
				</li>
				
				<form name="formLogout" id="formLogout" action="" method="POST" >
				</form>
				          		
            	</c:when>
            	<c:otherwise>
            		<li class="messages-menu"><a href="${pageContext.servletContext.contextPath}/common/user/getbidderregistration"><i class="fa fa-book"></i> &nbsp;New Bidder Registration</a></li>
          			<li class="dropdown user user-menu">
          				<input type="hidden" id="currentTime"/>
            			<a href="#"  class="dropdown-toggle" data-toggle="dropdown">
              			<i class="fa fa-sign-in"></i>&nbsp; Login
            		</a>
            		<ul class="dropdown-menu">
			              <!-- User image -->
			              <li class="user-header">
			              	<form name="formLogin" action="submitLogin" onsubmit="javascript:{loginValidate()}" method="POST">
			              	<input type='text' name='j_username'  validarr="required@@email" tovalid="true" onblur="javascript:{validateTxtComp(this)}" title="Email id"  class="form-control" placeholder="Email ID :"/>
			              	<input type='password' name='j_password' class="form-control" placeholder="Password :" />
			                <div class="pull-left">
			                <input name="submit" value="Login" type="submit" />
			                </div>
			                <div class="pull-right"><a href="${pageContext.servletContext.contextPath}/getforgotpassword" style="color: white;" >Fogot Password ? </a></div>
			                </form>
			              </li>
			              <!-- Menu Body -->
			              <!-- Menu Footer-->
            		</ul>
            	</c:otherwise>
            </c:choose>
            
          	
        </ul>
      </div>
    </nav>
  </header>
<script type="text/javascript">
	//$.noConflict();
    var pageContext = '${pageContext.servletContext.contextPath}';
</script>
<script type="text/javascript">
        /* function disableBtn(status){
            if(status){
                $("button[type='submit']").each(function(){               
                    $(this).attr('disabled',true);
                });
            }
            return status;
        }
    function validate(){
        var vbool = valOnSubmit();
        return disableBtn(vbool);
    } */
    
    function loginValidate(){
        var vbool = valOnSubmit();
        return disableBtn(vbool);
    }
</script>
        <aside class="main-sidebar">
			<section class="sidebar">				
				<ul class="sidebar-menu" style="height: 800px">
					<li class="header">OUR PRODUCTS</li>
					<c:if test="${sessionObject.userTypeId eq 1}">
					<li class="treeview"><a href="#"><i
							class="fa fa-user"></i> <span>Administration</span><span
							class="pull-right-container"><i
								class="fa fa-angle-left pull-right"></i></span></a>
						<ul class="treeview-menu">
							<c:if test="${sessionObject.isOrgenizationUser eq 1}">
								<li class="active"><a href="${pageContext.servletContext.contextPath}/common/user/getorganization"><i class="fa fa-circle-o"></i><spring:message code="lbl_create_org"/></a></li>
								<li class="active"><a href="${pageContext.servletContext.contextPath}/common/user/getlocationdepartment"><i class="fa fa-circle-o"></i><spring:message code="lbl_create_locationdept"/></a></li>
								<li class="active"><a href="${pageContext.servletContext.contextPath}/common/user/getdepartments"><i class="fa fa-circle-o"></i><spring:message code="lbl_create_subdept"/></a></li>	
							</c:if>
							<c:if test="${sessionObject.isOrgenizationUser eq 0}">
							<li class="active"><a href="${pageContext.servletContext.contextPath}/common/user/getlocationdepartment"><i class="fa fa-circle-o"></i><spring:message code="lbl_create_locationdept"/></a></li>
								<li class="active"><a href="${pageContext.servletContext.contextPath}/common/user/getdepartments"><i class="fa fa-circle-o"></i><spring:message code="lbl_create_subdept"/></a></li>
							</c:if>
							<li class="active"><a href="${pageContext.servletContext.contextPath}/common/user/getdesignation"><i class="fa fa-circle-o"></i><spring:message code="lbl_create_designation"/></a></li>
							<li class="active"><a href="${pageContext.servletContext.contextPath}/common/user/getcreateofficer"><i class="fa fa-circle-o"></i><spring:message code="lbl_create_user"/></a></li>
							<li class="active"><a href="${pageContext.servletContext.contextPath}/common/user/getmanageuser"><i class="fa fa-circle-o"></i><spring:message code="lbl_manage_user"/></a></li>
							<li class="active"><a href="${pageContext.servletContext.contextPath}/common/user/getmanagebidder"><i class="fa fa-circle-o"></i><spring:message code="lbl_manage_bidder"/></a></li>
							
							<c:if test="${sessionObject.isCTPLUser eq 1}">
							<li><a href="${pageContext.servletContext.contextPath}/common/user/getaddlink"><i class="fa fa-circle-o"></i><spring:message code="lbl_add_link"/></a></li>
							<li><a href="${pageContext.servletContext.contextPath}/common/user/managelinks"><i class="fa fa-circle-o"></i><spring:message code="lbl_manage_link"/></a></li>
							<li><a href="${pageContext.servletContext.contextPath}/common/user/getroleslink"><i class="fa fa-circle-o"></i><spring:message code="lbl_add_link_to_role"/></a></li>
							</c:if>
							<c:if test="${true || sessionObject.isOrgenizationUser eq 1 or sessionObject.isCTPLUser eq 1}" >
								<li class="active"><a href="${pageContext.servletContext.contextPath}/common/addEditMarquee/0"><i class="fa fa-circle-o"></i><spring:message code="lbl_add_edit_marquee"/></a></li>
							</c:if>
						</ul></li>
					</c:if>
					<c:if test="${sessionObject.userTypeId eq 2}">		
					<li class="treeview"><a href="#"><i
							class="fa fa-dashboard"></i> <span>Bidder</span><span
							class="pull-right-container"><i
								class="fa fa-angle-left pull-right"></i></span></a>
						<ul class="treeview-menu">
							<li><a href="${pageContext.servletContext.contextPath}/etender/bidder/bidderTenderListing"><i class="fa fa-circle-o"></i><spring:message code="lbl_tender_list"/></a></li>
						</ul>
					</li>
					</c:if>
					
					<c:if test="${sessionObject.userTypeId eq 1}">	
					<li class="treeview"><a href="#"><i
							class="fa fa-dashboard"></i> <span>RFX</span><span
							class="pull-right-container"><i
								class="fa fa-angle-left pull-right"></i></span></a>
                                            <ul class="treeview-menu">
                                                <li><a href="${pageContext.servletContext.contextPath}/etender/buyer/createevent/0"><i class="fa fa-circle-o"></i>Create Tender</a></li>
                                                <li><a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderListing"><i class="fa fa-circle-o"></i>Tender List</a></li>
                                                <li><a href="${pageContext.servletContext.contextPath}/etender/buyer/getpendingevaluation"><i class="fa fa-circle-o"></i>Pending Evaluation</a></li>
						<li><a href="${pageContext.servletContext.contextPath}/eBid/Bid/createAuction/0"><i class="fa fa-circle-o"></i>Create Auction</a></li>
                                                <li><a href="${pageContext.servletContext.contextPath}/eBid/Bid/auctionListing"><i class="fa fa-circle-o"></i>Auction Listing</a></li> 			
						</ul></li>
						</c:if>
						<c:if test="${sessionObject.userTypeId eq 1}">
						<li class="treeview">
							<a href="#">
								<i class="fa fa-dashboard"></i> 
								<span>WorkFlow</span>
								<span class="pull-right-container">
								<i class="fa fa-angle-left pull-right"></i>
								</span>
							</a>
							<ul class="treeview-menu">
								<li><a href="${pageContext.servletContext.contextPath}/etender/buyer/workflowlist/${sessionScope.userId}/0"><i class="fa fa-circle-o"></i><spring:message code="lbl_workflow_pending"/></a></li>
								<li><a href="${pageContext.servletContext.contextPath}/etender/buyer/workflowlist/${sessionScope.userId}/1"><i class="fa fa-circle-o"></i><spring:message code="lbl_workflow_processed"/></a></li>
							</ul>
						</li>
						<li class="treeview">
							<a href="#">
								<i class="fa fa-dashboard"></i> 
								<span>Reports</span>
								<span class="pull-right-container">
								<i class="fa fa-angle-left pull-right"></i>
								</span>
							</a>
							<ul class="treeview-menu">
								<li><a href="${pageContext.servletContext.contextPath}/common/audittrial"><i class="fa fa-circle-o"></i>Audit trial report</a></li>
							</ul>
						</li>
						</c:if>

				</ul>

			</section>

		</aside>