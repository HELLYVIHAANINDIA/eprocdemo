<%@include file="./../includes/head.jsp"%>
<%@include file="./../includes/masterheader.jsp"%>    
<spring:message code="lbl_create_locationdept" var="createdepartment"/>
<title>${createdepartment}</title>

<div class="content-wrapper" style="height: auto;">

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
			               						<spring:message code="lbl_edit_locationdept" var="editdepartment"/>
			               						<h3 class="box-title">${editdepartment}</h3>											
			               					</c:when>
			               					<c:otherwise>
			               						<h3 class="box-title">${createdepartment}</h3>
											</c:otherwise>
										</c:choose>
										<font size="1" class="pull-right mandatory m-top2"	style="font-size: 12px; font-weight: 400;">
														(<b class="red">*</b>) <spring:message code="msg_mandatoryFields" /></font>
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
														 <div class="col-md-6">
														 
                                                            <div class="fr-grp">
                                                                <label class="lblfr-fields"><spring:message code="lbl_tenderauthority"/><span style="color: red">*</span></label>	
																<c:if test="${sessionObject.isCTPLUser eq 1}">
																		<select class="form-control fr-cntrl" name="grandParentDeptId"  id="grandParentDeptId" isrequired="true" onblur="javascript:{if(validateCombo(this)){}}" title="Organization" >
																		<option value="-1">Please select</option>
																		</select>
																</c:if>	
																<c:if test="${sessionObject.isCTPLUser eq 0}">
																	${tblParentDepartment.deptName}
																	<form:hidden  id="grandParentDeptId" path="grandParentDeptId" ></form:hidden>
																</c:if>
															</div>
															
															<div class="fr-grp">
																 <label class="lblfr-fields"><spring:message code="lbl_locaion_dept"/><span style="color: red">*</span>:</label>
																<form:input class="form-control fr-cntrl" id="deptName" onkeypress="validateTextComponent(this)" path="deptName" validarr="required@@tenderbrief:100" tovalid="true" onblur="validateTextComponent(this)" title="Location/Department name" ></form:input>
																<form:hidden  id="deptId" path="deptId" ></form:hidden>
																<input type="hidden"  id="isDeptExists" value="" />
																<div id="deptError" style="color: red"></div>
															</div>
															
															<div class="fr-grp">
																 <label class="lblfr-fields">Address</label>	
																 <form:textarea class="form-control fr-cntrl" id="address" path="address" validarr="length:0,200" tovalid="true" onblur="validateTextComponent(this)" validationmsg="Allows Max. 200 alphabets, numbers and special characters" title="address"></form:textarea>
															</div>
															
													 		<div class="fr-grp">
													 		<c:choose>
								               					<c:when test="${optType eq 'edit'}">
									               					<button type="submit" id="addDept"  class="btn btn-submit">Update</button>
								               					</c:when>
								               					<c:otherwise>
																	<button type="submit" id="addDept"  class="btn btn-submit">Submit</button>               						
																</c:otherwise>
															</c:choose>															
															</div>
															
														</div>
													</div>	
												</form:form>
											</div>
									</div>
								</div>
								<div class="box-body">
									<div class="row">
										<div class="col-lg-12 col-md-12 col-xs-12">
											<div id="listingDiv"></div>
										</div>
									</div>
								</div>
							</div>
						
						<form id="tenderListForm" style="display: none;">
							<c:if test="${sessionObject.isCTPLUser eq 0}">
							<input type="hidden" value="${tblParentDepartment.deptId}" class="searchEqual" columnName="grandParentDeptId" name="grandParentDeptId">
							<input type="hidden"  id="jsonSearchCriteria" name="jsonSearchCriteria">
							</c:if>
							<input type="hidden"  name="defaultOrder" id="defaultOrder" value="4:Desc">
						</form>
					</div>
				</div>				
			</section>
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
    	blockUI();
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
    			unBlockUI();
    		},
    		error : function(e) {
    			console.log("ERROR: ", e);
    			unBlockUI();
    		},
    		done : function(e) {
    			console.log("DONE");
    			unBlockUI();
    		}
    	});
    }
    
</script>
  <script src="${pageContext.servletContext.contextPath}/resources/js/blockUI.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/resources/js/commonListing.js"></script>        
    <%@include file="./../includes/footer.jsp"%>