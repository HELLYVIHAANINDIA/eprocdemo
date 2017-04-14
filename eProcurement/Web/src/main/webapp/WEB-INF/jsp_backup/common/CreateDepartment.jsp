<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <%@include file="./../includes/header.jsp"%>
        <%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
        <script src="${pageContext.servletContext.contextPath}/resources/js/commonValidate.js" type="text/javascript"></script>
        <script src="${pageContext.servletContext.contextPath}/resources/js/blockUI.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/resources/js/commonListing.js"></script>        
        <spring:message code="lbl_create_locationdept" var="createdepartment"/>
        <title>${createdepartment}</title>
        <script type="text/javascript">
        var VALIDATE_MSG_REQUIRED = 'Please enter';
        var VALIDATE_MSG_SELECT = 'Please select';
        var VALIDATE_MSG_ALLOW_MAX='Allows Max. ';
        var VALIDATE_MSG_TENDERBRIEF='characters';
        var isDepartmentExists=false;
        var grandParentDeptId='${grandParentDeptId}';
        var grandParentDeptJson = '${grandParentDeptJson}';
        var grandParentDeptJsonObj = jQuery.parseJSON(grandParentDeptJson);
        var optType = '${optType}';
        	$(document).ready(function() {
        		$('#grandParentDeptId').html('');
             	$.each(grandParentDeptJsonObj, function (key, value) {
            	$('#grandParentDeptId').append($('<option>',
            		 {
            		    value: value.value,
            		    text : value.label
            		}));
            	 });
             	
             	if(optType == 'edit'){
       	     		$('#grandParentDeptId').val(grandParentDeptId);
             	}
       		});
            function validate(){
            	var vbool = valOnSubmit();
            	if(vbool){
            		searchAjax();
            	}
            	return disableBtn(vbool);
            }
            function searchAjax() {
            	var tbool='';
            	var data = {};
            	var searchValue = $("#deptName").val();
            	var keyword = 'deptName';
            	$.ajax({
            		type : "POST",
            		contentType : "application/json",
            		url : "${pageContext.servletContext.contextPath}/common/user/isdepartmentexist/"+searchValue+"/"+keyword,
            		data : data,
            		timeout : 100000,
            		success : function(data) {
            			console.log("SUCCESS: ", data);
            			var obj = jQuery.parseJSON(data);
            			$.each(obj, function (key, value) {
                		    	$("#isDeptExists").val(value.isExists);
                		     });
            		},
            		error : function(e) {
            			console.log("ERROR: ", e);
            		},
            	});
            }
            
            function getSubDepartmentsByGrandDepartment() {
            	$.blockUI({message: '<h4><img src="http://s13.postimg.org/80vkv0coz/image.gif" /> Please Wait...</h4>'});
            	var data = {};
            	var searchValue = $("#grandParentDeptId").val()+"@@0";
            	$.ajax({
            		type : "POST",
            		contentType : "application/json",
            		url : "${pageContext.servletContext.contextPath}/common/user/getsubdepartments/"+searchValue,
            		data : data,
            		timeout : 100000,
            		success : function(data) {
            			var obj = jQuery.parseJSON(data);
            			$('#parentDeptId').html('');
            		     $.each(obj, function (key, value) {
            		    $('#parentDeptId').append($('<option>',
            		    		 {
            		    		    value: value.value,
            		    		    text : value.label
            		    		}));
            		     });
            			console.log("SUCCESS: ", data);
            			$.unblockUI({});
            		},
            		error : function(e) {
            			console.log("ERROR: ", e);
            			$.unblockUI({});
            		},
            		done : function(e) {
            			console.log("DONE");
            			$.unblockUI({});
            		}
            	});
            }
            
            
           </script>
    </head>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="./../includes/leftaccordion.jsp"%>

<div class="content-wrapper" style="height: auto; ">

<section class="content-header">
<h1>Administration</h1>			
</section>

<section class="content">
<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="box">
						<c:if test="${not empty successMsg}">
                                        			<div class="alert alert-success"><spring:message code="${successMsg}"/></div>
                                    		</c:if>
                                    		<c:if test="${not empty errorMsg}">
                                        			<div class="alert alert-danger"><spring:message code="${errorMsg}"/></div>
                                    		</c:if>
						<div class="box-header with-border">
							<c:choose>
	               					<c:when test="${optType eq 'edit'}">
	               					<spring:message code="lbl_create_locationdept" var="editdepartment"/>
	               						<h3 class="box-title">${editdepartment}</h3>											
	               					</c:when>
	               					<c:otherwise>
	               						<h3 class="box-title">${createdepartment}</h3>
								</c:otherwise>
								</c:choose>
						</div>
						<div class="box-body">
							<div class="row">
								<c:choose>
	               					<c:when test="${optType eq 'edit'}">
		               					<spring:url value="/common/user/editlocationdepartment" var="submitDept"/>
	               					</c:when>
	               					<c:otherwise>
										<spring:url value="/common/user/addlocationdepartment" var="submitDept"/>               						
									</c:otherwise>
								</c:choose>
								<div class="col-lg-12 col-md-12 col-xs-12">
									<form:form action="${submitDept}" onsubmit="return validate();" name="frmdepartment" method="post" modelAttribute="tblDepartment" >
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Organization :</div>
										</div>
										<div class="col-lg-5">
										<c:if test="${sessionObject.isOrgenizationUser eq 1}">
												<select class="form-control" name="grandParentDeptId"  id="grandParentDeptId" isrequired="true" onblur="javascript:{if(validateCombo(this)){}}" title="Organization" >
												<option value="-1">Please select</option>
												</select>
										</c:if>	
										<c:if test="${sessionObject.isOrgenizationUser eq 0}">
											${tblParentDepartment.deptName}
											<form:hidden  id="grandParentDeptId" path="grandParentDeptId" ></form:hidden>
										</c:if>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed"><spring:message code="lbl_locaion_dept"/> :</div>
										</div>
										<div class="col-lg-5">
											<form:input class="form-control" id="deptName" path="deptName" validarr="required@@tenderbrief:100" tovalid="true" onblur="validateTxtComp(this)" title="department name" ></form:input>
											<form:hidden  id="deptId" path="deptId" ></form:hidden>
											<input type="hidden"  id="isDeptExists" value="" />
											<div id="deptError" style="color: red"></div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Address :</div>
											
										</div>
										<div class="col-lg-5">
											<form:textarea class="form-control" id="address" path="address" validarr="length:0,200" tovalid="true" onblur="validateTxtComp(this)" validationmsg="Allows Max. 200 alphabets, numbers and special characters" title="address"></form:textarea>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<br>
										</div>
										<div class="col-lg-5">
											<button type="submit" id="addDept"  class="btn btn-submit">Submit</button>
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
				<form id="tenderListForm" style="display: none;">
					<c:if test="${sessionObject.isOrgenizationUser eq 0}">
					<input type="hidden" value="${tblParentDepartment.deptId}" class="searchEqual" columnName="grandParentDeptId" name="grandParentDeptId">
					<input type="hidden"  id="jsonSearchCriteria" name="jsonSearchCriteria">
					</c:if>
				</form>
				
</section>


</div>

</div>

<script type="text/javascript">
loadListPage('listingDiv',22,'tenderListForm');
function callActionItem(cthis){
	var actionname = $(cthis).attr("actionname");
	var colIndx = getColumnIndex('deptId');
	console.log(actionname);
	if(actionname.toLowerCase() == "edit"){
		var deptId = $(cthis).closest("tr").find('td:nth-child('+(colIndx+1)+')').html()
		window.location = "${pageContext.servletContext.contextPath}/common/user/geteditlocationdepartment/"+deptId;
	}
	
}
</script>
  <script type="text/javascript">
  
</script>
    </body>
</html>