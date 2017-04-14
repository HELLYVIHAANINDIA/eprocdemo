<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <%@include file="./../includes/header.jsp"%>
        <%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
        <script src="${pageContext.servletContext.contextPath}/resources/js/commonValidate.js" type="text/javascript"></script>
        <spring:message code="lbl_add_link" var="lbl_add_link"/>
        <title>${lbl_add_link}</title>
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
            function searchAjax() {
            	var link = $("#link").val();
            	var hdLink = $("#hdLink").val();
            	var data ={'link':link};
            	if(hdLink!=link){
            		$("#linkError").html("");	
            	$.ajax({
            		type : "POST",
            		contentType : "application/json",
            		url : "${pageContext.servletContext.contextPath}/common/user/islinkexists",
            		data : data,
            		timeout : 100000,
            		success : function(data) {
            			if(data=='true'){
            				$("#linkError").html("Link already Exists");	
            			}
            			console.log("SUCCESS: ", data);
            		},
            		error : function(e) {
            			console.log("ERROR: ", e);
            		},
            		done : function(e) {
            			console.log("DONE");
            		}
            	});
              }
            }
           </script>
</head>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="./../includes/leftaccordion.jsp"%>

<div class="content-wrapper" style="height: auto; ">
<section class="content-header">
<h1>
				${lbl_add_link}
</h1>
</section>

<section class="content">
<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="box">
						<div class="box-header with-border">
							<c:choose>
	               					<c:when test="${optType eq 'edit'}">
	               					<spring:message code="lbl_edit_link" var="lbl_edit_link"/>
	               						<h3 class="box-title">${lbl_edit_link}</h3>											
	               					</c:when>
	               					<c:otherwise>
	               						<h3 class="box-title">${lbl_add_link}</h3>
								</c:otherwise>
								</c:choose>
						</div>
						<div class="box-body">
							<div class="row">
	               							<spring:url value="/common/user/addlink" var="submitLink"/>											
								<div class="col-lg-12 col-md-12 col-xs-12">
									<form:form action="${submitLink}" onsubmit="return validate();" name="frmLink" method="post" modelAttribute="tblLink" >
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed"><spring:message code="lbl_link_name"/> :</div>
										</div>
										<div class="col-lg-5">
											<form:input class="form-control" id="linkName" path="linkName" validarr="required@@tenderbrief:50" tovalid="true" onblur="validateTxtComp(this)" title="Link name" ></form:input>
											<form:hidden  id="hdLinkId" path="linkId" ></form:hidden>
											
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed"><spring:message code="lbl_link"/>:</div>
										</div>
										<div class="col-lg-5">
											<form:input class="form-control" id="link" path="link" validarr="required@@tenderbrief:50" tovalid="true" onblur="javascript:{if(validateCombo(this)){searchAjax();}}" title="Link" ></form:input>
											<div style="color: red;display: block;" id="linkError"></div>
											<input type="hidden"  id="hdLink" value="${tblLink.link}" />
											<input type="hidden"  id="optType" name="optType" value="${optType}" />
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed"><spring:message code="lbl_link_module"/> :</div>
										</div>
										<div class="col-lg-5">
											<form:input class="form-control" id="module" path="module" validarr="required@@tenderbrief:10" tovalid="true" onblur="validateTxtComp(this)" title="Module" ></form:input>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed"><spring:message code="lbl_link_desc"/> :</div>
										</div>
										<div class="col-lg-5">
											<form:textarea class="form-control" id="description" path="description" validarr="required@@length:0,500" tovalid="true" onblur="validateTxtComp(this)" validationmsg="Allows Max. 500 alphabets, numbers and special characters" title="description"></form:textarea>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<br>
										</div>
										<div class="col-lg-5">
											<button type="submit" id="addLink"  class="btn btn-submit">Submit</button>
										</div>
									</div>
									</form:form>
								</div>
							</div>
						</div>
					<div class="box-body">
							<div class="row">
								<div class="col-lg-12 col-md-12 col-xs-12">
												<div id="listingDiv">
												</div>
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
loadListPage('listingDiv',3);
function callActionItem(cthis){
	var actionname = $(cthis).attr("actionname");
	console.log(actionname);
	if(actionname.toLowerCase() == "edit"){
		var deptId = $(cthis).closest("tr").find('td:nth-child(4)').html()
		window.location = "${pageContext.servletContext.contextPath}/common/user/geteditdesignation/"+deptId;
	}
	
}
</script>
    </body>
</html>