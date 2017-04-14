<footer class="main-footer">
	<div class="copy clearfix">
		<div class="container_25 p-top-none">
			<div class="pull-left "><a href="#">Terms and Conditions</a> | <a href="#">Privacy Policy</a></div>
			<div class="grid_15 pull-right a-right">
				All rights reserved. CTPL © 2017. Designed Develop &amp; Maintained By 
				<a target="_blank" href="http://cahoot-technologies.com/">
					<span style="color:#c42b3e;">Cahoot</span> 
					<span style="color:#175295;">Technologies</span></a>.
			</div>
		</div>
	</div>
</footer>
</div><!-- wrapper -->

<%-- <script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script> --%>

 <script>
  	var contextPath = "${pageContext.request.contextPath}";
  	var sessionUserId= ${sessionScope.userId};
    var CLIENT_DATE_FORMATE='<spring:message code="client_dateformate_hhmm" />';
    var CLIENT_DATE_FORMATE_WHM='<spring:message code="client_dateformate" />';
    var VALIDATE_MSG_INVALID_PASSWORD = "<spring:message code="password_validation_msg" />"
    var pageContext = '${pageContext.request.contextPath}';
    function loginValidate() {
		var vbool = valOnSubmit();
		return disableBtn(vbool);
	}
    $(function() {
	    $('body').attr('id', window.location.href.split('/')[6]);
    });
  </script>
  <script src="${pageContext.request.contextPath}/resources/js/headerscript.js"></script>
</body>
</html>