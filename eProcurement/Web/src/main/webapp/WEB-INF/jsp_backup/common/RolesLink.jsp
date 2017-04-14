<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <%@include file="./../includes/header.jsp"%>
        <%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
        <script src="${pageContext.servletContext.contextPath}/resources/js/commonValidate.js" type="text/javascript"></script>
        <script src="${pageContext.servletContext.contextPath}/resources/js/blockUI.js" type="text/javascript"></script>
        <spring:message code="lbl_add_link_to_role" var="lbl_add_link_to_role" />
        <title>${lbl_add_link_to_role}</title>
        <script type="text/javascript">
        var VALIDATE_MSG_REQUIRED = 'Please enter';
        var VALIDATE_MSG_SELECT = 'Please select';
        var VALIDATE_MSG_ALLOW_MAX='Allows Max. ';
        var VALIDATE_MSG_TENDERBRIEF='characters';
            $(document).ready(function() {
            	 
        	});
            function validate(){
            	var vbool = valOnSubmit();
            	if($("#linkError").html()!=""){
            		vbool=false;
            	}
            	return disableBtn(vbool);
            }
            function getallLinks() {
            	$.blockUI({message: '<h4><img src="http://s13.postimg.org/80vkv0coz/image.gif" /> Please Wait...</h4>'});
                var SearchOpt = $("#selSearchOpt option:selected").val();
                $("#hdRoleId").val(SearchOpt);
                var searchResult;
            	var data = { 'txtSearchOpt' : SearchOpt};
            	$.ajax({
            		type : "POST",
            		url : "${pageContext.servletContext.contextPath}/common/user/searchlinksbyrole",
            		data : data,
            		timeout : 100000,
            		success : function(data) {
            			searchResult=data;
                        if (searchResult == 'sessionexpired') {
                            window.location = "${pageContext.servletContext.contextPath}/" + searchResult;
                        } else {
                            $("#searchResult").html(searchResult);
                        }
                        var dynheight = $("#searchResult").height()+350;
                        $('#content-wrapper').css("min-height",dynheight+"px");
                        $.unblockUI({});
            		},
            		error : function(e) {
            			console.log("ERROR: ", e);
            			$.unblockUI({});
            		},
            	});
            }
           </script>
</head>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="./../includes/leftaccordion.jsp"%>

<div class="content-wrapper">

<section class="content-header">
			<h1>
				${lbl_add_link_to_role}
			</h1>
</section>

<section class="content">
<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="box">
						<div class="box-header with-border">
						</div>
						<div class="box-body">
							<div class="row">
							<div class="col-lg-2">
												<div class="form_filed">Select Role :</span></div>
							</div>
							<div class="col-lg-5">
								<select class="form-control" id="selSearchOpt">
													<option value="1">Creator</option>
	  												<option value="2">Approver</option>
	  												<option value="3">Opener</option>
	  												<option value="4">Evalutor</option>
									</select>								
							</div>
							</div>
							<div class="row">
							<div class="col-lg-2">
							</div>
							<div class="col-lg-5">
								<button class="btn btn-submit" type="button" onclick="{javascript:getallLinks();}" >Submit</button>								
							</div>
							</div>
						</div>
							</div>
						</div>
					<div class="box-body">
							<form:form action="${pageContext.servletContext.contextPath}/common/user/addlinkstorole" modelAttribute="tblLinksRolesDataBean" method="POST" >
							<div class="row">
								<div id="searchResult">
								</div>
							</div>
							<input type="hidden" name="hdRoleId" value="0" id="hdRoleId"/>
							</form:form>
						</div>
					</div>
</section>

</div>

</div>  

</body>

</html>