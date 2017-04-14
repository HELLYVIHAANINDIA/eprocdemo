<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Cahoot Technologies</title>
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <noscript>
	<meta http-equiv="refresh" content="0; URL=${pageContext.servletContext.contextPath}/jsinstruction">
  </noscript>
<meta http-equiv="x-ua-compatible" content="IE=Edge"/>

<c:set var="userAgent" value="${header['User-Agent']} "/>
<c:if test="${fn:indexOf(userAgent, 'MSIE') ne -1}">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
</c:if>
<meta name="keywords" content="eProcurement">
<spring:message code="lbl_important_message" var="lbl_important_message"/>
<spring:message code="lbl_aboutus" var="lbl_aboutus"/>
<spring:message code="lbl_fq" var="lbl_fq"/>
<spring:message code="lbl_privacy_police" var="lbl_privacy_police"/>
<spring:message code="lbl_disclaimer" var="lbl_disclaimer"/>
<spring:message code="lbl_download_software" var="lbl_download_software"/>
<spring:message code="lbl_browsersupport" var="lbl_browsersupport"/>

  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/font-awesome.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/AdminLTE.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/blue.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/morris.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jquery-jvectormap-1.2.2.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/datepicker3.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/iCheck/all.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/daterangepicker.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap3-wysihtml5.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bgi.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/template1/css/style.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/select2.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/skin-blue.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/epro.css">
  <script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/validationDefault.js"></script>
<script src="${pageContext.servletContext.contextPath}/resources/js/jquery-2.2.3.min.js"></script>
<script src="${pageContext.servletContext.contextPath}/resources/js/jquery-ui.min.js"></script>
<script src="${pageContext.servletContext.contextPath}/resources/js/bootstrap.min.js"></script>
<script src="${pageContext.servletContext.contextPath}/resources/js/select2.full.min.js"></script>
<script src="${pageContext.servletContext.contextPath}/resources/js/bootstrap3-wysihtml5.all.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/app.min.js"></script>
<script>
    var pageContext = '${pageContext.servletContext.contextPath}';
	var contextPath = "${pageContext.servletContext.contextPath}";
    var sessionUserId= 0;
    var CLIENT_DATE_FORMATE='<spring:message code="client_dateformate_hhmm" />';
    var CLIENT_DATE_FORMATE_WHM='<spring:message code="client_dateformate" />';
    var VALIDATE_MSG_INVALID_PASSWORD = "<spring:message code="password_validation_msg" />"
    $(function() {
    	if(window.location.href.split('/')[6] == undefined){
    		$('body').attr('id', window.location.href.split('/')[4]);
    		$('body').attr('class', 'skin-blue sidebar-mini');
    	}else{
    		$('body').attr('id', window.location.href.split('/')[6]);
    		$('body').attr('class', 'skin-blue sidebar-mini');
    	}
    });
 </script>

 <script src="${pageContext.servletContext.contextPath}/resources/js/headerscript.js"></script>
 
 <div class="wrapper">
 
 <header class="main-header">
 
 	<a href="#" class="logo">
      <span class="logo-mini"><b>CTPL</b></span>
      <c:if test="${sessionObject.userTypeId eq 2}">
      <c:set var="logourl" value="${pageContext.servletContext.contextPath}/etender/bidder/bidderTenderListing"></c:set>
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
            		<li class="messages-menu"><a href="${pageContext.servletContext.contextPath}/common/user/register"><i class="fa fa-book"></i> &nbsp;New Bidder Registration</a></li>
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
			              	<input type='password' name='j_password' class="form-control" placeholder="Password :" style="margin-top:10px;"/>
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
