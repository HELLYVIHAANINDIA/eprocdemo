<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <%@include file="./../../includes/header.jsp"%>
        <%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
        <script src="${pageContext.servletContext.contextPath}/resources/js/commonValidate.js" type="text/javascript"></script>
		<script src="${pageContext.servletContext.contextPath}/resources/js/blockUI.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/resources/js/commonListing.js"></script>        
        <spring:message code="lbl_create_user" var="createuser"/>
        
        <title>${createuser}</title>
        <script type="text/javascript">
        var VALIDATE_MSG_REQUIRED = 'Please enter';
        var VALIDATE_MSG_SELECT = 'Please select';
        var VALIDATE_MSG_ALLOW_MAX='Allows Max. ';
        var VALIDATE_MSG_TENDERBRIEF='characters';
        var VALIDATE_MSG_EMAIL_INVALID = 'Allows Min. 6 Max. 50 alphanumeric and Special Characters(@,.,-,_)';
        var VALIDATE_MSG_INVALID_EMAIL = 'Please enter valid email ID';
        var VALIDATE_MSG_INVALID_PASSWORD = "<spring:message code="password_validation_msg" />";
        var VALIDATE_MSG_INVALID_PASSWORD_SPECIAL_CHAR = 'Password must comprise of at least one alphanumeric and special character (!,@,#,$,_,.,(,))';
        var VALIDATE_MSG_INVALID_FULL_NAME = 'Invalid fullname';
        var VALIDATE_MSG_SAME_PASSWORD_AS_LOGINID = 'Password cannot be same as email ID';
        var VALIDATE_MSG_INVALID_CONF_PASSWORD = 'Confirm password does not match with';
        var isDepartmentExists=false;
        var optType = '${optType}';
        var parentDeptId = '${parentDeptId}';
        var parentDeptJson = '${parentDeptJson}';
        var subDeptId = '${subDeptId}';
        var subDeptJson = '${subDeptJson}';
        var designationId = '${designationId}';
        var rolesJson = '${rolesJson}';
        var rolesJsonObj = jQuery.parseJSON(rolesJson);
        var grandParentDeptJson = '${grandParentDeptJson}';
        var grandParentDeptId='${grandParentDeptId}';
        var grandParentDeptJsonObj = jQuery.parseJSON(grandParentDeptJson);
        var countryJson = '${countryJson}';
        var countryObj = jQuery.parseJSON(countryJson);
        $(document).ready(function(){
        	
        	// fill country and state combo in load 
        	$('#selCountry').html('');
	     	$.each(countryObj, function (key, value) {
	    	$('#selCountry').append($('<option>',
	    		 {
	    		    value: value.value,
	    		    text : value.label
	    		}));
	    	 });
			
	     	
	     	if(optType=='Edit'){
		     	var countryId= '${officerDtl[9]}';
		     	var stateId= '${officerDtl[10]}';
		     	$('select[id="selCountry"] option:selected').attr("selected",null);
	   	     	$('select[id="selCountry"] option[value="'+countryId+'"]').attr("selected","selected");
		     	getState();
		     	$('select[id="selState"] option:selected').attr("selected",null);
	   	     	$('select[id="selState"] option[value="'+stateId+'"]').attr("selected","selected");
	     	}
        	
        	//fill organization combo on load
        	$('#grandParentDeptId').html('');
	     	$.each(grandParentDeptJsonObj, function (key, value) {
	    	$('#grandParentDeptId').append($('<option>',
	    		 {
	    		    value: value.value,
	    		    text : value.label
	    		}));
	    	 });
	     	
	     	//fill roles combo on load
	     	$('#selUserRoles').html('');
	     	$.each(rolesJsonObj, function (key, value) {
	    	$('#selUserRoles').append($('<option>',
	    		 {
	    		    value: value.value,
	    		    text : value.label
	    		}));
	    	 });
	     	if(optType == 'Edit'){
	     	$('#grandParentDeptId').val(grandParentDeptId);
	     	}
	     	getParentDepartmentsByGrandparentDept(1);
	     	getDesignations(0);
   	     	if(optType == 'Edit'){
   	     		//put grandParentId in case of edit to organization combo
   	     		$('#grandParentDeptId').val(grandParentDeptId);	
   	     		//fill parent department combo on load : edit case
   	     		if(parentDeptJson!=''){
	   	     		var obj = jQuery.parseJSON(parentDeptJson);
		   	     	$('#selDepartment').html('');
			     	$.each(obj, function (key, value) {
			    	$('#selDepartment').append($('<option>',
			    		 {
			    		    value: value.value,
			    		    text : value.label
			    		}));
			    	 });
			     	if(parentDeptId>0){
	      	   	     	if(parentDeptId>0){
	  			     		$("#selDepartment").val(parentDeptId);	
	  	   		     	}else{
	  		   		     	$("#selDepartment").val("-1");	 
	  	   		    	} 		 
// 	   		   	  		alert($('#selDepartment').val());	     	
	   		     	}else{
	   		     		
	   		     	}
			     	getSubDepartments(1);
		   	        $.blockUI({message: '<h4><img src="http://s13.postimg.org/80vkv0coz/image.gif" /> Please Wait...</h4>'});
		   	     	setTimeout(function() {
		   	    		getDesignations(1);
		   	    	}, 2000);
		   	     	$.unblockUI({});
   	     		}else{
   	    	     	$.blockUI({message: '<h4><img src="http://s13.postimg.org/80vkv0coz/image.gif" /> Please Wait...</h4>'});
   	    	     	setTimeout(function() {
   	    	    		getDesignations(1);
   	    	    	}, 2000);
   	    	     	$.unblockUI({});	
   	     		}
	   	     	
	   	     	//role multiselect fillup
	   	     	var tblUserRoles = ${tblUserRoles};
		     	$('select[id="selUserRoles"] option:selected').attr("selected",null);
		     	$.each(tblUserRoles, function( index, value ) {
				$('select[id="selUserRoles"] option[value="'+value+'"]').attr("selected","selected");
				});
   	     	}	
        });
            function validate(){
            	var vbool = valOnSubmit();
            	var grandParentDeptId = $("#grandParentDeptId").val();
            	if (grandParentDeptId=='-1'){
            		alert("please select organization");
            		vbool=false;
            	}
            	if(vbool){
            		if(optType!='Edit'){
            			vbool = checkDuplicateEmail();
                        }	
            		}
 	           	return disableBtn(vbool);
            }
           
            
            function getSubDepartments(mode) {
            	$.blockUI({message: '<h4><img src="http://s13.postimg.org/80vkv0coz/image.gif" /> Please Wait...</h4>'});
            			var data = {};
                    	var searchValue = $("#selDepartment").val()+"@@1";
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
                    		     $('select[id="subDept"] option:selected').attr("selected",null);
                 	   	     	 $('select[id="subDept"] option[value="-1"]').attr("selected","selected");
                 	   	     	 if(mode==1){
	                 	   	     	if(subDeptId>0){
	             			     		$("#subDept").val(subDeptId);	
	             	   		     	}else{
	             		   		     	$("#subDept").val("-1");	 
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
            
            function getDesignations(mode) {
            	$.blockUI({message: '<h4><img src="http://s13.postimg.org/80vkv0coz/image.gif" /> Please Wait...</h4>'});
            	var data = {};
            	var subDeptId = $("#subDept").val();
            	var parentDeptId = $("#selDepartment").val();
            	if(parentDeptId==null){
            		parentDeptId='-1';
            	}if(subDeptId==null){
            		parentDeptId='-1';
            	}
            	var grandParentDeptId = $("#grandParentDeptId").val();
            	console.log("subDeptId::"+subDeptId+"parentDeptId::"+parentDeptId+"grandParentDeptId::"+grandParentDeptId);
            	var searchValue = "";
//             	if(parentDeptId>0 && subDeptId>0 && grandParentDeptId>0){
//             		searchValue = subDeptId;	
//             	}else if (parentDeptId>0 && subDeptId=='-1' && grandParentDeptId>0){
//             		searchValue = parentDeptId;
//             	}else if (parentDeptId=='-1' && subDeptId=='-1' && grandParentDeptId>0){
//             		searchValue = grandParentDeptId;
//             	}else{
//             		alert("please select organization");
//             	}
            	searchValue = grandParentDeptId;
            	$.ajax({
            		type : "POST",
            		contentType : "application/json",
            		url : "${pageContext.servletContext.contextPath}/common/user/getdesignationbydeptid/"+searchValue,
            		data : data,
            		timeout : 100000,
            		success : function(data) {
            			var obj = jQuery.parseJSON(data);
            			$('#selDesignation').html('');
            		     $.each(obj, function (key, value) {
            		    $('#selDesignation').append($('<option>',
            		    		 {
            		    		    value: value.value,
            		    		    text : value.label
            		    		}));
            		     });
            			console.log("SUCCESS: ", data);
            			$('select[id="selDesignation"] option:selected').attr("selected",null);
        	   	     	 $('select[id="selDesignation"] option[value="-1"]').attr("selected","selected");
            			 
        	   	     	 if(mode==1){
        	   	     		if(designationId>0){
    				     		$("#selDesignation").val(designationId);
    		   		    	 }else{
    		   		    		$("#selDesignation").val("-1");	 
    		   		    	 }
        	   	     	 }
        	   	     	 
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
                    			$('#selDepartment').html('');
                    		     $.each(obj, function (key, value) {
                    		    $('#selDepartment').append($('<option>',
                    		    		 {
                    		    		    value: value.value,
                    		    		    text : value.label
                    		    		}));
                    		     });
                	   	     	 $('select[id="subDept"] option:selected').attr("selected",null);
                	   	     	 $('select[id="subDept"] option[value="-1"]').attr("selected","selected");
                	   	     	 if(mode==1){
                	   	     		if(parentDeptId>0){
//                 	   	     		alert(parentDeptId);	
                		     		$("#selDepartment").val(parentDeptId);		
                			     	}else{
                	   		     	$("#selDepartment").val("-1");
                			   	    }
                	   	     	 }else{
                	   	     			
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
            
            
            function checkDuplicateEmail() {
            	var tbool='';
            	var data = {};
            	var searchValue = $("#txtEmailId").val();
            	$.ajax({
            		type : "POST",
            		contentType : "application/json",
            		url : "${pageContext.servletContext.contextPath}/ajaxhit/common/user/isemailidexists/"+searchValue+"/",
            		data : data,
            		timeout : 100000,
            		async:false,
            		success : function(data) {
            			console.log("SUCCESS: ", data);
            			var obj = jQuery.parseJSON(data);
            			$.each(obj, function (key, value) {
            					if(value.isExists=='true'){
            						$("#verifyMail").html("<span style=\"color:red\">Email ID already registered<\span>");
            						$("#verifyMail").show();
            						return false;
            					}
                		     });
            		},
            		error : function(e) {
            			console.log("ERROR: ", e);
            		},
            	});
            	return true;
            }
            
            function getState(){
                var countryId = $("#selCountry").val();
                if(countryId != ""){
                	$.ajax({
            		contentType : "application/json",
            		url : "${pageContext.servletContext.contextPath}/common/user/getstatebycountry/"+countryId,
            		dataType: "json",
            		async:false,
            		success : function(data) {
            			$("#selState option").not(":first").remove();
            			for(var i = 0; i <data.length;i++){
            				$("#selState").append("<option value='"+data[i][0]+"'>"+data[i][1]+"</option>")
            			}
            		},
            		error : function(e) {
            			console.log("ERROR: ", e);
            		},
            	});
               }
             }
           </script>
<spring:message code="label_select" var="label_select"/>
<spring:message code="label_timezone" var="label_timezone"/>
</head>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="./../../includes/leftaccordion.jsp"%>

<div class="content-wrapper" style="height: auto;">
<section class="content-header">
<h1 class="pull-left">Administration</h1>
<a href="${pageContext.servletContext.contextPath}/common/user/getmanageuser" class="btn btn-submit pull-right" style="margin-top:0px; margin-bottom: 10px;"><< Go users</a>
</section>

<section class="content">
<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				
					<div class="box">
					
						<div class="box-header with-border">
							<c:choose>
	               					<c:when test="${optType eq 'edit'}">
	               					<spring:message code="lbl_edit_user" var="edituser"/>
	               						<h3 class="box-title">${edituser}</h3>											
	               					</c:when>
	               					<c:otherwise>
	               						<spring:message code="lbl_create_user" var="createuser"/>
	               						<h3 class="box-title">${createuser}</h3>
								</c:otherwise>
								</c:choose>
						</div>
						<div class="box-body">
							<div class="row">	
		               					<spring:url value="/common/user/adduser" var="submitUser"/>
								<div class="col-lg-12 col-md-12 col-xs-12">
									<form:form action="${submitUser}" onsubmit="return validate();" name="frmUser" method="post"  >
									<font size="1" class="pull-right mandatory m-top2" style="font-size: 15px;">(<b class="red">*</b>) <spring:message code="msg_mandatoryFields"/></font>
									<input type="hidden" name="hdOptType" value="${optType}"/>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Organization<span style="color: red">*</span></div>
										</div>
										<div class="col-lg-5">
											<c:if test="${sessionObject.isOrgenizationUser eq 1}">
											<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
					               					<select class="form-control" name="grandParentDeptId"  id="grandParentDeptId" isrequired="true" onblur="javascript:{if(validateCombo(this)){getParentDepartmentsByGrandparentDept(0);getDesignations(0)}}" title="Organization" >
															<option value="-1">Please Select</option>
													</select>
				               					</c:when>
				               					<c:otherwise>
													<select class="form-control" name="grandParentDeptId"  id="grandParentDeptId" isrequired="true" onblur="javascript:{if(validateCombo(this)){getParentDepartmentsByGrandparentDept(0);getDesignations(0)}}" title="Organization" >
															<option value="-1">${label_select}</option>
													</select>
												</c:otherwise>
											</c:choose>
											</c:if>
											<c:if test="${sessionObject.isOrgenizationUser eq 0}">
												${tblGrandParentDept.deptName}
												<input type="hidden"  id="grandParentDeptId" name="grandParentDeptId"  value="${tblGrandParentDept.deptId}" />
											</c:if>
											</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Location/Department:</div>
										</div>
										<div class="col-lg-5">
											<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
					               					<select class="form-control" id="selDepartment" name="selDepartment"  onblur="javascript:{if(true){getSubDepartments(0)}}" title="department">
															<option value="-1">Please Select</option>
													</select>
													<input type="hidden" name="hdUserId" value="${officerDtl[4]}"/>
													<input type="hidden" name="hdOfficerId" value="${officerId}"/>
				               					</c:when>
				               					<c:otherwise>
													<select class="form-control" id="selDepartment" name="selDepartment"  onblur="javascript:{if(true){getSubDepartments(0)}}" title="department">
														<option value="-1">${label_select}</option>
													</select>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
												<div class="form_filed">Sub department:</div>
										</div>
										<div class="col-lg-5">
											<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
															<select class="form-control" name="subDeptId"  id="subDept"   title="Sub department name" >
															<option value="-1">${label_select}</option>
															</select>
				               					</c:when>
				               					<c:otherwise>
															<select class="form-control" name="subDeptId"  id="subDept"   title="Sub department name" >
															<option value="-1">${label_select}</option>
															</select>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Designation<span style="color: red">*</span></div>
										</div>
										<div class="col-lg-5">
											<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
					               					<select class="form-control" id="selDesignation" name="selDesignation" isrequired="true" onblur="validateCombo(this)" title="designation">
															<option value="-1">${label_select}</option>
													</select>
													<input type="hidden" name="hdDesignationId" id="hdDesignationId" value="45" />
				               					</c:when>
				               					<c:otherwise>
													<select class="form-control" id="selDesignation" name="selDesignation" isrequired="true" onblur="validateCombo(this)" title="designation">
															<option value="-1">${label_select}</option>
													</select>
													<input type="hidden" name="hdDesignationId" id="hdDesignationId" value="45" />		               						
												</c:otherwise>
											</c:choose>	
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Email ID<span style="color: red">*</span></div>
										</div>
										<div class="col-lg-5">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
													<input class="form-control" id="txtEmailId" value="${officerDtl[3]}" name="txtEmailId" validarr="required@@email@@length:6,50" tovalid="true" onblur="javascript:{if(validateTxtComp(this)){checkDuplicateEmail();}}" title="Email ID" onfocus="javascript:{$('#verifyMail').html('');}" type="text">
													<span id="verifyMail" class="m-top1 display"></span>
				               					</c:when>
				               					<c:otherwise>
													<input class="form-control" id="txtEmailId" name="txtEmailId" validarr="required@@email@@length:6,50" tovalid="true" onblur="javascript:{if(validateTxtComp(this)){checkDuplicateEmail();}}" title="Email ID" onfocus="javascript:{$('#verifyMail').html('');}" type="text">
													<span id="verifyMail" class="m-top1 display"></span>
				               					</c:otherwise>
				               					</c:choose>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Password<span style="color: red">*</span></div>
											
										</div>
										<div class="col-lg-5">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
													<input id="txtPassword" value="${officerDtl[5]}" class="form-control" name="txtPassword" validarr="required@@password@@checkloginidpwd:EmailId" tovalid="true" onblur="validateTxtComp(this)" title="Password" " type="password">
				               					</c:when>
				               					<c:otherwise>
													<input id="txtPassword" class="form-control" name="txtPassword" validarr="required@@password@@checkloginidpwd:EmailId" tovalid="true" onblur="validateTxtComp(this)" title="Password" " type="password">
				               					</c:otherwise>
				               					</c:choose>
				               					<div class="nowrap">(<spring:message code="password_validation_msg" />)</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Confirm password<span style="color: red">*</span></div>
											
										</div>
										<div class="col-lg-5">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
													<input id="txtConfirmPassword" value="${officerDtl[5]}" class="form-control" name="txtConfirmPassword" validarr="required@@confirmpwd:Password" tovalid="true" onblur="validateTxtComp(this)" title="Confirm password"  type="password">
				               					</c:when>
				               					<c:otherwise>
													<input id="txtConfirmPassword" class="form-control" name="txtConfirmPassword" validarr="required@@confirmpwd:Password" tovalid="true" onblur="validateTxtComp(this)" title="Confirm password"  type="password">
				               					</c:otherwise>
				               					</c:choose>	
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Person name<span style="color: red">*</span></div>
										</div>
										<div class="col-lg-5">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
													<input id="txtFullName" value="${officerDtl[0]}" class="form-control" name="txtFullName" validarr="required@@fullname@@length:0,100" tovalid="true" onblur="validateTxtComp(this)" title="Person name" validationmsg="Allows max. 100 characters and special character (',- , .,space)" type="text">
				               					</c:when>
				               					<c:otherwise>
													<input id="txtFullName" class="form-control" name="txtFullName" validarr="required@@fullname@@length:0,100" tovalid="true" onblur="validateTxtComp(this)" title="Person name" validationmsg="Allows max. 100 characters and special character (',- , .,space)" type="text">
				               					</c:otherwise>
				               					</c:choose>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Address<span style="color: red"></span></div>
										</div>
										<div class="col-lg-5">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
													<textarea id="txtaAddress"  class="form-control" name="txtaAddress" validarr="length:0,500" tovalid="true" onblur="validateTxtComp(this)" title="address" validationmsg="Allows max. 500 characters and special character (',- , .,space)" >${officerDtl[12]}</textarea>
				               					</c:when>
				               					<c:otherwise>
													<textarea id="txtaAddress" class="form-control" name="txtaAddress" validarr="length:0,500" tovalid="true" onblur="validateTxtComp(this)" title="address" validationmsg="Allows max. 500 characters and special character (',- , .,space)" ></textarea>
				               					</c:otherwise>
				               					</c:choose>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Country<span style="color: red">*</span></div>
										</div>
										<div class="col-lg-5">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
				               						<select class="form-control" id="selCountry" name="selCountry" isrequired="true" onchange="if(validateCombo(this)){getState()}" title="Country">
													</select>
				               					</c:when>
				               					<c:otherwise>
				               						<select class="form-control" id="selCountry" name="selCountry" isrequired="true" onchange="if(validateCombo(this)){getState()}" title="Country">
													</select>
				               					</c:otherwise>
				               					</c:choose>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">State<span style="color: red">*</span></div>
										</div>
										<div class="col-lg-5">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
				               						<select class="form-control" id="selState" name="selState" isrequired="true" onchange="validateCombo(this)" title="State">
				               							<option value="">Select</option>
													</select>
				               					</c:when>
				               					<c:otherwise>
				               						<select class="form-control" id="selState" name="selState" isrequired="true" onchange="validateCombo(this)" title="State">
				               							<option value="">Select</option>
													</select>
				               					</c:otherwise>
				               					</c:choose>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">City.<span style="color: red">*</span></div>
											
										</div>
										<div class="col-lg-5">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
													<input id="txtCity" value="${officerDtl[11]}" class="form-control" name="txtCity" validarr="required@@length:0,20" tovalid="true" onblur="validateTxtComp(this)" title="City"  type="text">
				               					</c:when>
				               					<c:otherwise>
													<input id="txtCity" class="form-control" name="txtCity" validarr="required@@length:0,20" tovalid="true" onblur="validateTxtComp(this)" title="City"  type="text">
				               					</c:otherwise>
				               					</c:choose>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Phone No.</div>
											
										</div>
										<div class="col-lg-5">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
													<input id="txtPhoneNo" value="${officerDtl[2]}" class="form-control" name="txtPhoneNo" validarr="length:0,20@@phoneno" tovalid="true" onblur="validateTxtComp(this)" title="Phone no." validationmsg="Allows max. 20 numbers and special characters (-,+)" type="text">
				               					</c:when>
				               					<c:otherwise>
													<input id="txtPhoneNo" class="form-control" name="txtPhoneNo" validarr="length:0,20@@phoneno" tovalid="true" onblur="validateTxtComp(this)" title="Phone no." validationmsg="Allows max. 20 numbers and special characters (-,+)" type="text">
				               					</c:otherwise>
				               					</c:choose>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Mobile No.<span style="color: red">*</span></div>
											
										</div>
										<div class="col-lg-5">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
													<input id="txtMobileNo" value="${officerDtl[1]}" class="form-control" name="txtMobileNo" validarr="required@@length:0,15@@phoneno" tovalid="true" onblur="validateTxtComp(this)" title="Mobile no." validationmsg="Allows max 15 number (0 – 9)" type="text">
				               					</c:when>
				               					<c:otherwise>
													<input id="txtMobileNo" class="form-control" name="txtMobileNo" validarr="required@@length:0,15@@phoneno" tovalid="true" onblur="validateTxtComp(this)" title="Mobile no." validationmsg="Allows max 15 number (0 – 9)" type="text">
				               					</c:otherwise>
				               					</c:choose>
										</div>
									</div>
									
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">User roles<span style="color: red">*</span></div>
										</div>
										<div class="col-lg-5">
											<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
					               					<select class="form-control" id="selUserRoles" name="selUserRoles" isrequired="true" onblur="validateCombo(this)" title="atleast 1 role to user" multiple="multiple">
													</select>
				               					</c:when>
				               					<c:otherwise>
													<select class="form-control" id="selUserRoles" name="selUserRoles" isrequired="true" onblur="validateCombo(this)" title="User roles" multiple="multiple">
													</select>
												</c:otherwise>
											</c:choose>	
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">${label_timezone}<span style="color: red">*</span></div>
										</div>
										<div class="col-lg-5">
										
										<select  name="selTimezoneId" id="selTimezoneId" isrequired="true" onchange="validateCombo(this)" title="${label_timezone}" class="form-control">
											<option value="">${label_select}</option>
											<c:forEach items="${timezonelist}" var="timezone">
												<c:set var="selected" value=""/>
												<c:if test="${optType eq 'Edit' and officerDtl[8] eq timezone.timezoneId}">
													<c:set var="selected" value="selected='selected'"/>
												</c:if>
												<option ${selected} value="${timezone.timezoneId}">${timezone.countryName} (${timezone.utcOffset})</option>
											</c:forEach>
										</select>	
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<br>
										</div>
										<div class="col-lg-5">
											<button type="submit" id="addUser"  class="btn btn-submit">Submit</button>
										</div>
									</div>
									</form:form>
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
</script>

</body>

</html>