<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <%@include file="./../includes/header.jsp"%>
        <%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
        <script src="${pageContext.servletContext.contextPath}/resources/js/commonValidate.js" type="text/javascript"></script>
        <script src="${pageContext.servletContext.contextPath}/resources/js/blockUI.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/resources/js/commonListing.js"></script>        
        <spring:message code="lbl_create_designation" var="createdesignation"/>
        <title>${createdesignation}</title>
        <script type="text/javascript">
        var VALIDATE_MSG_REQUIRED = 'Please enter';
        var VALIDATE_MSG_SELECT = 'Please select';
        var VALIDATE_MSG_ALLOW_MAX='Allows Max. ';
        var VALIDATE_MSG_TENDERBRIEF='characters';
        var isDesignationExists=false;
        var subDeptJson = '${subDeptJson}';
        var subDeptId='${subDeptId}';
        var parentDeptJson = '${parentDeptJson}';
        var parentDeptId='${parentDeptId}';
        var optType = '${optType}';
        var grandParentDeptJson = '${grandParentDeptJson}';
        var grandParentDeptId='${grandParentDeptId}';
        var grandParentDeptJsonObj = jQuery.parseJSON(grandParentDeptJson);
            $(document).ready(function() {
				            
          	 //code to fill combo of Organization	
             $('#DeptId').html('');
           	 $.each(grandParentDeptJsonObj, function (key, value) {
           		    $('#DeptId').append($('<option>',
           		    		 {
           		    		    value: value.value,
           		    		    text : value.label
           		    		}));
           		     });
        	if(optType=='edit'){
        		$('#deptId').val(grandParentDeptId);
			}
//            	if(optType=='edit'){
//            	 $('select[id="grandParentDeptId"] option:selected').attr("selected",null);
//            	 $('select[id="grandParentDeptId"] option[value="'+grandParentDeptId+'"]').attr("selected","selected");
//            	 	 //code to fill combo of parent department : edit case
// 				if(parentDeptJson!=''){
// 					var parentDeptJsonObj = jQuery.parseJSON(parentDeptJson);	
// 	           	 	 $('#deptId').html('');
// 	           	 	$('#deptId').append($('<option>',{value: "Please select department",text : ""}));
// 	            	 $.each(parentDeptJsonObj, function (key, value) {
// 	            	 $('#deptId').append($('<option>',
// 	            		    		 {
// 	            		    		    value: value.value,
// 	            		    		    text : value.label
// 	            		    		}));
// 	            		     });
// 	            	 $('select[id="deptId"] option:selected').attr("selected",null);
// 	            	 $('select[id="deptId"] option[value="'+parentDeptId+'"]').attr("selected","selected");
// 				}
//         	 	 //code to fill combo of sub department : edit case           	 
// 				if(subDeptJson!=''){
//            	 	 var obj = jQuery.parseJSON(subDeptJson);
//             	 $('#subDept').html('');
//             	 $.each(obj, function (key, value) {
//             		    $('#subDept').append($('<option>',
//             		    		 {
//             		    		    value: value.value,
//             		    		    text : value.label
//             		    		}));
//             		     });
//             	 $('select[id="subDept"] option:selected').attr("selected",null);
//             	 $('select[id="subDept"] option[value="'+subDeptId+'"]').attr("selected","selected");
// 				}
//            	} 	 
        	});
            function validate(){
            	var vbool = valOnSubmit();
            	if(vbool){
            		var tbool = false;
            		$.blockUI({message: '<h4><img src="http://s13.postimg.org/80vkv0coz/image.gif" /> Please Wait...</h4>'});
            		searchAjax();
            		$.unblockUI({});
            		isDesignationExists = $("#isDesigExists").val();
            		if(isDesignationExists=='true'){
            			vbool=false;
            			$('#desigError').html("Designation already exists").show();
            		}else{
            			vbool=true;	
            		}
            	}
            	
            	return disableBtn(vbool);
            }
            function searchAjax() {
            	var data = {};
            	var searchValue = $("#designationName").val()+'@@'+$("#DeptId").val()+'@@0@@0';
            	var keyword = 'designationName';
            	$.ajax({
            		type : "POST",
            		contentType : "application/json",
            		url : "${pageContext.servletContext.contextPath}/common/user/isdesignationexists/"+searchValue+"/"+keyword,
            		data : data,
            		timeout : 100000,
            		success : function(data) {
            			console.log("SUCCESS: ", data);
            			$("#isDesigExists").val(data);
            		},
            		error : function(e) {
            			console.log("ERROR: ", e);
            		},
            		done : function(e) {
            			console.log("DONE");
            		}
            	});
            }
            
            function getParentDepartmentsByGrandparentDept(mode) {
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
                    			$('#deptId').html('');
                    		     $.each(obj, function (key, value) {
                    		    $('#deptId').append($('<option>',
                    		    		 {
                    		    		    value: value.value,
                    		    		    text : value.label
                    		    		}));
                    		     });
                    		     $('select[id="deptId"] option:selected').attr("selected",null);
                	   	     	 $('select[id="deptId"] option[value="-1"]').attr("selected","selected");
                	   	     	 $('select[id="subDept"] option:selected').attr("selected",null);
                	   	     	 $('select[id="subDept"] option[value="-1"]').attr("selected","selected");
                	   	     	 if(mode==1){
                	   	     		if(parentDeptId>0){
                		     		$("#deptId").val(parentDeptId);		
                			     	}else{
                	   		     	$("#deptId").val("-1");
                			   	    }
                	   	     	 }
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
                    	return true;
            }
            
            
            function getSubDepartments() {
            	$.blockUI({message: '<h4><img src="http://s13.postimg.org/80vkv0coz/image.gif" /> Please Wait...</h4>'});
            	var data = {};
            	if($("#deptId").val()!=''){
            	var searchValue = $("#deptId").val()+"@@1";
            	$("#hdDeptId").val($("#deptId").val());
            	$.ajax({
            		type : "POST",
            		contentType : "application/json",
            		url : "${pageContext.servletContext.contextPath}/common/user/getsubdepartments/"+searchValue,
            		data : data,
            		timeout : 100000,
            		success : function(data) {
            			var obj = jQuery.parseJSON(data);
            			$('#subDept').html('');
            		     $.each(obj, function (key, value) {
            		    $('#subDept').append($('<option>',
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
            	}else{
            		$.unblockUI({});
            	}
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
	               					<spring:message code="lbl_edit_designation" var="editdesignation"/>
	               						<h3 class="box-title">${editdesignation}</h3>											
	               					</c:when>
	               					<c:otherwise>
	               						<h3 class="box-title">${createdesignation}</h3>
								</c:otherwise>
								</c:choose>
						</div>
						<div class="box-body">
							<div class="row">
								<c:choose>
	               					<c:when test="${optType eq 'edit'}">
	               							<spring:url value="/common/user/editDesignation" var="submitDesignation"/>											
	               					</c:when>
	               					<c:otherwise>
	               							<spring:url value="/common/user/addDesignation" var="submitDesignation"/>
								</c:otherwise>
								</c:choose>
								<div class="col-lg-12 col-md-12 col-xs-12">
									<form:form action="${submitDesignation}" onsubmit="return validate();" name="frmdesignation" method="post" modelAttribute="tblDesignation" >
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Organization Name :</div>
										</div>
										<div class="col-lg-5">
										<c:if test="${sessionObject.isOrgenizationUser eq 1}">
											<c:choose>
				               					<c:when test="${optType eq 'edit'}">
														${tblDepartment.deptName}
														<form:hidden  id="DeptId" path="DeptId"  ></form:hidden>	
				               					</c:when>
				               					<c:otherwise>
				               							<select class="form-control" name="DeptId"  id="DeptId" isrequired="true" onblur="javascript:{if(validateCombo(this)){}}" title="Organization" >
															<option value="-1">Please select</option>
															</select>
												</c:otherwise>
										</c:choose>	
										</c:if>
											<c:if test="${sessionObject.isOrgenizationUser eq 0}">
											${tblGrandParentDept.deptName}
											<form:hidden  id="DeptId" path="DeptId"  ></form:hidden>
											</c:if>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Designation name :</div>
										</div>
										<div class="col-lg-5">
											<form:input class="form-control" id="designationName" path="designationName" validarr="required@@tenderbrief:50" tovalid="true" onblur="validateTxtComp(this)" title="designation name" ></form:input>
											<form:hidden  id="designationId" path="designationId" ></form:hidden>
											<div style="color: red;display: none;" id="desigError"></div>
											<input type="hidden"  id="isDesigExists" value="false" />
										</div>
									</div>
<!-- 									<div class="row"> -->
<!-- 										<div class="col-lg-2"> -->
<!-- 											<div class="form_filed">Parent department :</div> -->
<!-- 										</div> -->
<!-- 										<div class="col-lg-5"> -->
<!-- 											<select class="form-control" name="deptId"  id="deptId" onblur="javascript:{if(true){getSubDepartments()}}" title="department name"> -->
<!-- 											<option value="-1">Please select department</option> -->
<!-- 											</select> -->
<%-- 											<form:hidden path="deptId" id="hdDeptId" /> --%>
<!-- 										</div> -->
<!-- 									</div> -->
<!-- 									<div class="row"> -->
<!-- 										<div class="col-lg-2"> -->
<!-- 											<div class="form_filed">Sub department :</div> -->
<!-- 										</div> -->
<!-- 										<div class="col-lg-5"> -->
<!-- 											<select class="form-control" name="subDeptId"  id="subDept"   title="Sub department name" > -->
<!-- 											<option value="-1">Please select</option> -->
<!-- 											</select> -->
<!-- 										</div> -->
<!-- 									</div> -->
									<div class="row">
										<div class="col-lg-2">
											<br>
										</div>
										<div class="col-lg-5">
											<button type="submit" id="addDesignation"  class="btn btn-submit">Submit</button>
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
				<form id="tenderListForm" style="display: none;">
				<c:if test="${sessionObject.isOrgenizationUser eq 0}">
					<input type="hidden" value="${tblGrandParentDept.deptId}" class="searchEqual" columnName="b.deptId" name="b.deptId">
					<input type="hidden"  id="jsonSearchCriteria" name="jsonSearchCriteria">
					</c:if>
				</form>	
</div>	
</section>


</div>

</div>
  
<script type="text/javascript">
loadListPage('listingDiv',3,'tenderListForm');

function callActionItem(cthis){
	var actionname = $(cthis).attr("actionname");
	console.log(actionname);
	if(actionname.toLowerCase() == "edit"){
		var colIndx = getColumnIndex('designationId');
		var deptId = $(cthis).closest("tr").find('td:nth-child('+(colIndx+1)+')').html();
		window.location = "${pageContext.servletContext.contextPath}/common/user/geteditdesignation/"+deptId;
	}
	
}
</script>
    </body>
</html>