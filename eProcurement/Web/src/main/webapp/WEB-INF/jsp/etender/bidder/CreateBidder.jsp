<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<c:choose>
			<c:when test="${optType eq 'Edit'}">
				<%@include file="./../../includes/header.jsp"%>												
			</c:when>
			<c:otherwise>
				<%@include file="./../../includes/headerWithoutLogin.jsp"%>	
			</c:otherwise>
		</c:choose>
        <%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
        <script src="${pageContext.servletContext.contextPath}/resources/js/commonValidate.js" type="text/javascript"></script>
        <script src="${pageContext.servletContext.contextPath}/resources/js/blockUI.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/resources/js/commonListing.js"></script>        
        <spring:message code="lbl_create_user" var="createuser"/>
        <spring:message code="default_country" var="default_country"/>
        <spring:message code="default_tinezone" var="default_tinezone"/>
        <title>${createuser}</title>
        <script type="text/javascript">
        var VALIDATE_MSG_REQUIRED = 'Please enter';
        var VALIDATE_MSG_SELECT = 'Please select';
        var VALIDATE_MSG_ALLOW_MAX='Allows Max. ';
        var VALIDATE_MSG_TENDERBRIEF='characters';
        var VALIDATE_MSG_EMAIL_INVALID = 'Allows Min. 6 Max. 50 alphanumeric and Special Characters(@,.,-,_)';
        var VALIDATE_MSG_INVALID_EMAIL = 'Please enter valid email ID';
        var VALIDATE_MSG_INVALID_PASSWORD = "<spring:message code="password_validation_msg" />"
        var VALIDATE_MSG_INVALID_PASSWORD_SPECIAL_CHAR = 'Password must comprise of at least one alphanumeric and special character (!,@,#,$,_,.,(,))';
        var VALIDATE_MSG_INVALID_FULL_NAME = 'Invalid fullname';
        var VALIDATE_MSG_SAME_PASSWORD_AS_LOGINID = 'Password cannot be same as email ID';
        var VALIDATE_MSG_INVALID_CONF_PASSWORD = 'Confirm password does not match with';
        var isDepartmentExists=false;
        var optType = '${optType}';
        var countryId ="";
        var stateId="";
        if(optType=='Edit'){
	       	countryId = '${bidderDtls[9]}';
        	stateId = '${bidderDtls[8]}';
        }else{
        	tinezone = ${default_tinezone}
        	countryId = ${default_country};
        }
        	//var countryJson = '${countryJson}';
        
       		function  showTargetDiv(){
       			$("#targetDiv").show();
        	}
        
        var obj = (${countryJson});
            $(document).ready(function() {
            	$('#selCountry').html('');
    	     	$.each(obj, function (key, value) {
    	    	$('#selCountry').append($('<option>',
    	    		 {
    	    		    value: value.value,
    	    		    text : value.label
    	    		}));
    	    	 });
    			
    	     	
    	     	if(optType=='Edit'){
    	     	$('select[id="selCountry"] option:selected').attr("selected",null);
	   	     	$('select[id="selCountry"] option[value="'+countryId+'"]').attr("selected","selected");
    	     	getState();
    	     	$('select[id="selState"] option:selected').attr("selected",null);
	   	     	$('select[id="selState"] option[value="'+stateId+'"]').attr("selected","selected");
    	     	}else{
    	     		$('select[id="selCountry"] option[value="'+countryId+'"]').attr("selected","selected");
    	     		getState();
    	     	}
    	     	
        	});
            function bidderValidate(){
            	var vbool = true;
            	vbool = valOnSubmit()
            	$('#iAgreeError').html('');
            	var keyword = $("#selKeywords").select2("data");
            	if(keyword.length <= 0){
            		var div = $('<div class="errselKeywords validationMsg clearfix">Please select keyword</div>')
        			$("#keywordDiv").append(div);
        			$("#selKeywords").focus();
            		vbool=false;
            	}else{
            		$(".errselKeywords").remove();
            	}
				if(vbool){
            		var keywords = "";
            		$.each(keyword,function(i,item){ 
            			keywords+=item.id+"###"+item.text+"#@#"; 
            		});
            		$("#categoryText").val(keywords);
            	}
            	if(vbool){
            		if(optType!='Edit'){
            			vbool = checkDuplicateEmail();
                        if(!$('#iagree').is(':checked')){
                        	vbool=false;
                        	$('#iAgreeError').html("Please agree terms & conditions");
                        }	
            		}
            		$('[name="frmUser"]').submit();
                	return disableBtn(vbool);
            	}
            	return false;
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
            						$("#verifyMail").html("<span style=\"color:red\">Email ID is already registered<\span>");
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
            $(document).ready(function(){
            	$("#selKeywords").select2({
            	    minimumInputLength: 3,
            	    ajax: {
            	        url: "${pageContext.servletContext.contextPath}/common/user/getCategoryData/3,4",
            	        dataType: 'json',
            	        type: "GET",
            	        quietMillis: 50,
            	        selectOnClose: true,
            	        data: function (term) {
            	            return  {
            	                term: term.term
            	            }
            	        },
            	        processResults: function (data, params) {
            	            return {
            	              results: $.map(data, function (item) {
            	                    return {
            	                        text: item[1], 
            	                        id: item[0],
            	                    }
            	                }),
            	            };
            	          },
            	    }
            	});
            });
           </script>
</head>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<c:choose>
    <c:when test="${optType eq 'Edit'}">
        <%@include file="./../../includes/leftaccordion.jsp"%>												
    </c:when>
   <c:otherwise>
        <%@include file="./../../includes/leftaccordionWithOutLogin.jsp"%>	
   </c:otherwise>
</c:choose>
<spring:message code="label_select" var="label_select"/>
<div class="content-wrapper" style="height:1950px;">

<section class="content-header">
<h1>Administration</h1>
</section>

<section class="content">
<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="box">
						<div class="box-header with-border">
								<c:choose>
	               					<c:when test="${optType eq 'Edit'}">
	               					<spring:message code="lbl_edit_user" var="edituser"/>
	               					<%-- <a href="${pageContext.servletContext.contextPath}/etender/bidder/bidderTenderListing"><< Go bidder</a><br> --%>
	               						<h3 class="box-title">Edit bidder</h3>
	               					</c:when>
	               					<c:otherwise>
	               						<spring:message code="lbl_create_user" var="createuser"/>
	               						<h3 class="box-title"><spring:message code="lbl_bidder_regestration"/> </h3>
								</c:otherwise>
								</c:choose>
						</div>
						<div class="box-body">
							<div class="row">	
		               					<spring:url value="/common/user/addbidder" var="submitUser"/>
								<div class="col-lg-12 col-md-12 col-xs-12">
									<form action="${submitUser}" name="frmUser" method="post">
									<font size="1" class="pull-right mandatory m-top2" style="font-size: 15px;">(<b class="red">*</b>) <spring:message code="msg_mandatoryFields"/></font>
									<input type="hidden" name="hdOptType" value="${optType}"/>
									<input type="hidden" name="bidderDocId" value="${childId}"/>
									
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed" >Email id<span style="color: red">*</span></div>
										</div>
										<div class="col-lg-5">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
													<input class="form-control" id="txtEmailId" value="${bidderDtls[0]}" name="txtEmailId" validarr="required@@email" tovalid="true" onblur="javascript:{if(validateTxtComp(this)){checkDuplicateEmail();}}" title="Email ID" onfocus="javascript:{$('#verifyMail').html('');}" type="text">
													<span id="verifyMail" style="display: block;color: red"></span>
													<input type="hidden" name="hdUserId" value="${bidderDtls[12]}"/>
													<input type="hidden" name="hdBidderId" value="${bidderId}"/>
				               					</c:when>
				               					<c:otherwise>
													<input class="form-control" id="txtEmailId" name="txtEmailId" validarr="required@@email" tovalid="true" onblur="javascript:{if(validateTxtComp(this)){checkDuplicateEmail();}}" title="Email ID" onfocus="javascript:{$('#verifyMail').html('');}" type="text">
													<span id="verifyMail" style="display: block"></span>
				               					</c:otherwise>
				               					</c:choose>
										</div>
									</div>
									<c:if test="${optType ne 'Edit'}">
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Password<span style="color: red">*</span></div>
										</div>
										<div class="col-lg-5">
										<div>
										
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
													<input id="txtPassword" value="${bidderDtls[13]}" class="form-control" name="txtPassword" validarr="required@@password@@checkloginidpwd:EmailId@@length:8,15" tovalid="true" onblur="validateTxtComp(this)" type="password">
				               					</c:when>
				               					<c:otherwise>
													<input id="txtPassword" class="form-control" name="txtPassword" validarr="required@@password@@checkloginidpwd:EmailId@@length:8,15" tovalid="true" onblur="validateTxtComp(this)" type="password"
													data-toggle="tooltip" data-placement="right" title="(<spring:message code="password_validation_msg" />)">
				               					</c:otherwise>
				               					</c:choose>
				               					<div class="nowrap"></div>
				               				</div>	
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Confirm password<span style="color: red">*</span></div>
											
										</div>
										<div class="col-lg-5">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
													<input id="txtConfirmPassword" value="${bidderDtls[13]}" class="form-control" name="txtConfirmPassword" validarr="required@@confirmpwd:Password" tovalid="true" onblur="validateTxtComp(this)" title="Confirm password"  type="password">
				               					</c:when>
				               					<c:otherwise>
													<input id="txtConfirmPassword" class="form-control" name="txtConfirmPassword" validarr="required@@confirmpwd:Password" tovalid="true" onblur="validateTxtComp(this)" title="Confirm password"  type="password">
				               					</c:otherwise>
				               					</c:choose>	
										</div>
									</div>
									</c:if>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">First name<span style="color: red">*</span></div>
										</div>
										<div class="col-lg-5">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
													<input id="txtFullName" value="${bidderDtls[1]}" class="form-control" name="txtFullName" validarr="required@@fullname@@length:0,100" tovalid="true" onblur="validateTxtComp(this)" title="Person name" validationmsg="Allows max. 100 characters and special character (',- , .,space)" type="text">
				               					</c:when>
				               					<c:otherwise>
													<input id="txtFullName" class="form-control" name="txtFullName" validarr="required@@fullname@@length:0,100" tovalid="true" onblur="validateTxtComp(this)" title="Person name" validationmsg="Allows max. 100 characters and special character (',- , .,space)" type="text">
				               					</c:otherwise>
				               					</c:choose>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Last name<span style="color: red">*</span></div>
										</div>
										<div class="col-lg-5">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
													<input id="txtLastName" value="${bidderDtls[1]}" class="form-control" name="txtLastName" validarr="required@@fullname@@length:0,100" tovalid="true" onblur="validateTxtComp(this)" title="Person name" validationmsg="Allows max. 100 characters and special character (',- , .,space)" type="text">
				               					</c:when>
				               					<c:otherwise>
													<input id="txtLastName" class="form-control" name="txtLastName" validarr="required@@fullname@@length:0,100" tovalid="true" onblur="validateTxtComp(this)" title="Person name" validationmsg="Allows max. 100 characters and special character (',- , .,space)" type="text">
				               					</c:otherwise>
				               					</c:choose>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Middle name</div>
										</div>
										<div class="col-lg-5">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
													<input id="txtMiddleName" value="${bidderDtls[1]}" class="form-control" name="txtMiddleName" validarr="fullname@@length:0,100" tovalid="true" onblur="validateTxtComp(this)" title="Person name" validationmsg="Allows max. 100 characters and special character (',- , .,space)" type="text">
				               					</c:when>
				               					<c:otherwise>
													<input id="txtMiddleName" class="form-control" name="txtMiddleName" validarr="fullname@@length:0,100" tovalid="true" onblur="validateTxtComp(this)" title="Person name" validationmsg="Allows max. 100 characters and special character (',- , .,space)" type="text">
				               					</c:otherwise>
				               					</c:choose>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed" data-toggle="tooltip" data-placement="top"  data-original-title="Tooltip on Top" >Company name<span style="color: red">*</span></div>
										</div>
										<div class="col-lg-5">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
													<input id="txtCompanyName" value="${bidderDtls[2]}"  class="form-control" name="txtCompanyName" validarr="required@@fullname@@length:3,200" tovalid="true" onblur="validateTxtComp(this)" title="Company/Individual name" validationmsg="Allows min 3 and max. 100 characters and special character (',- , .,space)" type="text">
				               					</c:when>
				               					<c:otherwise>
													<input id="txtCompanyName" class="form-control"  name="txtCompanyName" validarr="required@@fullname@@length:3,200" tovalid="true" onblur="validateTxtComp(this)" title="Company/Individual name" validationmsg="Allows min 3 and max. 200 characters and special character (',- , .,space)" type="text">
				               					</c:otherwise>
				               					</c:choose>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Address<span style="color: red">*</span></div>
										</div>
										<div class="col-lg-5">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
													<textarea id="txtaAddress"  class="form-control" name="txtaAddress" validarr="required@@length:0,1000" tovalid="true" onblur="validateTxtComp(this)" title="address" validationmsg="Allows max. 500 characters and special character (',- , .,space)" >${bidderDtls[3]}</textarea>
				               					</c:when>
				               					<c:otherwise>
													<textarea id="txtaAddress" class="form-control" name="txtaAddress" validarr="required@@length:0,1000" tovalid="true" onblur="validateTxtComp(this)" title="address" validationmsg="Allows max. 500 characters and special character (',- , .,space)" ></textarea>
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
											<div class="form_filed">City.</div>
											
										</div>
										<div class="col-lg-5">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
													<input id="txtCity" value="${bidderDtls[4]}" class="form-control" name="txtCity" validarr="length:0,20" tovalid="false" onblur="validateTxtComp(this)" title="City"  type="text">
				               					</c:when>
				               					<c:otherwise>
													<input id="txtCity" class="form-control" name="txtCity" validarr="length:0,20" tovalid="false" onblur="validateTxtComp(this)" title="City"  type="text">
				               					</c:otherwise>
				               					</c:choose>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Phone no.<span style="color: red">*</span></div>
											
										</div>
										<div class="col-lg-5">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
				               						<div><input id="txtPhoneNo"  class="form-control" style="width: 60px;float: left" name="txtPhoneNo" validarr="required@@length:0,3@@phoneno" tovalid="true" onblur="validateTxtComp(this)" title="Phone no." validationmsg="Allows max. 3 numbers and special characters (-,+)" type="text"><label style="float: left">-</label>
													<input id="txtPhoneNo"  class="form-control" style="width: 60px;float: left" name="txtPhoneNo" validarr="required@@length:0,3@@phoneno" tovalid="true" onblur="validateTxtComp(this)" title="Phone no." validationmsg="Allows max. 3 numbers and special characters (-,+)" type="text"><label style="float: left">-</label>
													<input id="txtPhoneNo" value="${bidderDtls[5]}" class="form-control" style="width: 200px;float: left" name="txtPhoneNo" validarr="required@@length:0,20@@phoneno" tovalid="true" onblur="validateTxtComp(this)" title="Phone no." validationmsg="Allows max. 20 numbers and special characters (-,+)" type="text">
													</div>		
				               					</c:when>
				               					<c:otherwise>
				               						<div><input id="txtPhoneNo"  class="form-control" style="width: 60px;float: left" name="txtPhoneNo" validarr="required@@length:0,3@@phoneno" tovalid="true" onblur="validateTxtComp(this)" title="Phone no." validationmsg="Allows max. 3 numbers and special characters (-,+)" type="text">
				               						<div class="dash">-</div>
													<input id="txtPhoneNo"  class="form-control" style="width: 60px;float: left" name="txtPhoneNo" validarr="required@@length:0,3@@phoneno" tovalid="true" onblur="validateTxtComp(this)" title="Phone no." validationmsg="Allows max. 3 numbers and special characters (-,+)" type="text">
													<div class="dash">-</div>
													<input id="txtPhoneNo" class="form-control" style="width: 200px;float: left" name="txtPhoneNo" validarr="required@@length:0,20@@phoneno" tovalid="true" onblur="validateTxtComp(this)" title="Phone no." validationmsg="Allows max. 20 numbers and special characters (-,+)" type="text">
													</div>
				               					</c:otherwise>
				               					</c:choose>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Mobile no.</div>
											
										</div>
										<div class="col-lg-5">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
													<input id="txtMobileNo" value="${bidderDtls[6]}" class="form-control" name="txtMobileNo" validarr="length:0,15@@phoneno" tovalid="true" onblur="validateTxtComp(this)" title="Mobile no." validationmsg="Allows max 15 number (0 to 9)" type="text">
				               					</c:when>
				               					<c:otherwise>
													<input id="txtMobileNo" class="form-control" name="txtMobileNo" validarr="length:0,15@@phoneno" tovalid="true" onblur="validateTxtComp(this)" title="Mobile no." validationmsg="Allows max 15 number (0 to 9)" type="text">
				               					</c:otherwise>
				               					</c:choose>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Web site</div>
											
										</div>
										<div class="col-lg-5">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
													<input id="txtWebsite" value="${bidderDtls[7]}" class="form-control" name="txtWebsite" validarr="website" tovalid="true" onblur="validateTxtComp(this)" title="Website" type="text">
				               					</c:when>
				               					<c:otherwise>
													<input id="txtWebsite" class="form-control" name="txtWebsite" validarr="website" tovalid="true" onblur="validateTxtComp(this)" title="Website"  type="text">
				               					</c:otherwise>
				               					</c:choose>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Keywords (UNSPSC)</div>
											
										</div>
										<div class="col-lg-5 keywordDiv">
												<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
													<!-- <select id="selKeywords" multiple="multiple" class="form-control" name="selKeywords"  tovalid="true" onchange="validateCombo(this)" title="Keywords" ></select> -->
													<select id="selKeywords" class="form-control" multiple="multiple" name="selKeywords" title="keyword" onchange="validateCombo(this)" >
														<c:forEach items="${categoryList}" var="category">
															<option selected="selected" value="${category[0]}">${category[1]}</option>
														</c:forEach>
													
													</select>
				               					</c:when>
				               					<c:otherwise>
													<!-- <input id="txtKeywords" class="form-control" name="txtKeywords" validarr="length:3,300" tovalid="true" onblur="validateTxtComp(this)" title="Keywords"  type="text"> -->
													<select id="selKeywords" class="form-control" multiple="multiple" name="selKeywords" title="keyword" onchange="validateCombo(this)" ></select>
				               					</c:otherwise>
				               					</c:choose>
											<input type="hidden" name="categoryText" id="categoryText">
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
										<spring:message code="label_timezone" var="label_timezone"/>
											<div class="form_filed">${label_timezone}<span style="color: red">*</span></div>
										</div>
										<div class="col-lg-5">
										<c:choose>
				               					<c:when test="${optType eq 'Edit'}">
													<select  name="selTimezoneId" id="selTimezoneId" isrequired="true" onchange="validateCombo(this)" class="form-control" title="${label_timezone}">
														<option value="">${label_select}</option>
														<c:forEach items="${timezonelist}" var="timezone">
														<c:set var="selected" value=""/>
														<c:if test="${default_tinezone eq timezone.timezoneId or bidderDtls[15] eq timezone.timezoneId}">
															<c:set var="selected" value="selected='selected'"/>
														</c:if>
															<option value="${timezone.timezoneId}" ${selected}>${timezone.countryName} (${timezone.utcOffset})</option>
														</c:forEach>
													</select>
				               					</c:when>
				               					<c:otherwise>
												<select  name="selTimezoneId" id="selTimezoneId" isrequired="true" onchange="validateCombo(this)" class="form-control" title="${label_timezone}">
													<option value="">${label_select}</option>
													<c:forEach items="${timezonelist}" var="timezone">
													    <c:set var="selected" value=""/>
													    <c:if test="${default_tinezone eq (timezone.timezoneId+'') }">
															<c:set var="selected" value="selected='selected'"/>
														</c:if>
														<option value="${timezone.timezoneId}" ${selected}>${timezone.countryName} (${timezone.utcOffset})</option>
													</c:forEach>
												</select>
				               					</c:otherwise>
				               					</c:choose>
										
											
										</div>
									</div>
																	
									<div class="row">										
										<div class="col-md-12">
										<%@include file="../buyer/UploadDocuments.jsp"%>
										</div>
									</div>
									
									<c:if test="${optType ne 'Edit'}">
									<div class="row">
										<div class="col-lg-2">
											<br>
										</div>
										<div class="col-lg-5">
											<input type="checkbox" name="igree" id="iagree"  style="float: left; margin-right:5px;"/>
											I agree to the terms & conditions and privacy policy of this website.
											<a href="javascript:" id="viewPrivacy" onclick="javascript:showTargetDiv();">View privacy policy</a>
										<div id="targetDiv"  style="display:none" >Here by you agree all privacy policies and terms and conditions of Cahoot technologies LTD</div> 
 											<div id="iAgreeError" style="color: red"></div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											
										</div>
										<div class="col-lg-5">
											<div class="g-recaptcha" data-sitekey="6Ld1eBIUAAAAAAH43IoWk1nmD-MMvcWaDYEQIO9o"></div>
										</div>
									</div>
									</c:if>
									
									<div class="row">
										<div class="col-lg-2">
											<br>
										</div>
										<div class="col-lg-5">
											<input type="submit" class="btn btn-submit" value="Submit"  onclick="return bidderValidate();" >
										</div>
									</div>
									</form>
									
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
</section>

</div>
</div>
<script>
$(document).ready(function(){
    $('[data-toggle="tooltip"]').tooltip(); 
});
</script>
</body>
</html>