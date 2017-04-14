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
            	<li class="dropdown user user-menu">
            	<form name="formLogout" action="${pageContext.servletContext.contextPath}/submitlogout" method="POST" >
              			<i class="fa fa-sign-in"></i>&nbsp<input name="submit" value="Log out" type="submit" />
					</form>
					</li>            		
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
			                <input name="submit" value="Login" type="submit" class="loginbutoon"/>
			                </div>
			                <div class="pull-right"><a href="${pageContext.servletContext.contextPath}/getforgotpassword" class="frgp">Forgot Password ? </a></div>
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
  
<aside class="main-sidebar">
        
			<section class="sidebar" style="height:auto;">
			
				<ul class="sidebar-menu">
				
					<li class="mouseHand leftMenuSection" section="1">
						<a><i class="fa fa-question-circle"></i><span>${lbl_aboutus}</span></a>
					</li>
					
					<li class="mouseHand leftMenuSection" section="2">
						<a><i class="fa fa-user"></i><span>${lbl_fq}</span></a>
					</li>
					
					<li class="mouseHand leftMenuSection" section="3">
						<a><i class="fa fa-file-text"></i><span>${lbl_privacy_police}</span></a>
					</li>
					
					<li class="mouseHand leftMenuSection" section="4">
						<a><i class="fa fa-file-text"></i><span>${lbl_disclaimer}</span></a>
					</li>
					
					<li class="mouseHand leftMenuSection" section="5">
						<a><i class="fa fa-download"></i><span>${lbl_download_software}</span></a>
					</li>
					
					<li class="mouseHand leftMenuSection" section="6">
						<a><i class="fa fa-globe"></i><span>${lbl_browsersupport}</span></a>
					</li>
				
				</ul>

			</section>

</aside>