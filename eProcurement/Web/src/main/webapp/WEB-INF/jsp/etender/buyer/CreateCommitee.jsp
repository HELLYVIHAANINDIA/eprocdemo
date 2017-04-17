<%@include file="../../includes/head.jsp"%>
       <%@include file="../../includes/masterheader.jsp"%>
                
        <spring:message code="title_tender_createcomitee" var="titlecommittee"/>
        <spring:message code="lbl_create_prebid_committee" var="lblcreateprebidcommittee"/>
        <spring:message code="lbl_edit_prebid_committee" var="lbleditprebidcommittee"/>
        <spring:message code="lbl_view_prebid_committee" var="lblviewprebidcommittee"/>
        
     <div class="content-wrapper">   
       
    
<c:set var="var_total_member" value="0" />

<section class="content-header">
<h1 class="inline">RFX</h1>
<a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}" class="g g-back"><< Go To Tender Dashboard</a>
</section>

<section class="content">
	<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				
					<div class="box">
						<div class="box-header with-border">
									<c:choose>
										<c:when test="${operType eq 'Edit'}">
											<h3 class="box-title">${lbleditprebidcommittee}</h3>	
										</c:when>
										<c:otherwise>
											<h3 class="box-title">${lblcreateprebidcommittee}</h3>	
										</c:otherwise>
									</c:choose>
						</div>
						<div class="box-body">
							<div class="row">
								<div class="col-lg-12 col-md-12 col-xs-12">
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Search By</div>
										</div>
										<div class="col-lg-5">
											<select class="form-control" id="selSearch" onchange="javascript:showHideDiv();">
												<option value="email">Email</option>
  												<option value="name">Name</option>
  												<option value="Hirarchy">Hirarchy</option>
											</select>
										</div>
									</div>	
									<div class="row" id="nonHirarchy">
										<div class="col-lg-2">
											<div class="form_filed">Search</div>
										</div>
										<div class="col-lg-5">
											<input type="text" class="form-control"  id="searchValue" title="Search value"  validarr="required@@length:0,100" tovalid="true" onblur="javascript:{validateTextComponent(this)}"  >
										</div>
										<div>
											<button type="button" class="btn btn-submit" onclick="searchAjax();">Search</button>
										</div>
									</div>
									<div id="Hirarchy" style="display: none">
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Organization</div>
										</div>
										<div class="col-lg-5">
													<div id="grandParentDeptIdDiv">
														<input type="hidden" id="grandParentDeptId" value="${grandParentDeptId}" />	
													</div>	
<!-- 													<select class="form-control" id="grandParentDeptId" name="grandParentDeptId" onblur="javascript:{if(validateCombo(this)){getParentDepartmentsByGrandparentDept();getSubDepartments();getDesignations()}}" title="organization"> -->
<!-- 														<option value="-1">Please Select</option> -->
<!-- 													</select> -->
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Location/Department</div>
										</div>
										<div class="col-lg-5">
											<select class="form-control" id="selDepartment" name="selDepartment" onblur="javascript:{if(true){getSubDepartments();getDesignations()}}" title="department">
														<option value="-1">Please Select</option>
													</select>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Sub Department</div>
										</div>
										<div class="col-lg-5">
											<select class="form-control" name="subDeptId"  id="subDept"  onblur="javascript:{getDesignations()}" title="Sub department name" >
															<option value="-1">Please select</option>
											</select>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Designation</div>
										</div>
										<div class="col-lg-5">
											<select class="form-control" id="selDesignation" name="selDesignation" onblur="validateCombo(this)" title="designation">
															<option value="-1">Please Select</option>
													</select>
										</div>
										<div>
											<button type="button" class="btn btn-submit" onclick="searchAjax();">Search</button>
										</div>
									</div>
									<div class="row" id="noRecordFound"></div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed">Officer Name</div>
										</div>
										<div class="col-lg-5">
											<select class="form-control" id="selName">
												<option value="">Please Select</option>
											</select>
										</div>
										<div>
											<button type="button" id="addOfficer" class="btn btn-submit">Add</button>
										</div>
									</div>
									
					<div class="box-body">
							<div class="row">
								<div class="col-lg-12 col-md-12 col-xs-12">
								<spring:url value="/etender/buyer/submitprebidcomittee" var="submitcommittee"/> 
                                    <form:form action="${submitcommittee}" name="frmprebidcomittee" method="post" onsubmit="return validate();" >
									<table class="table table-striped table-responsive">
										<thead>
											<tr>
												<th>Name</th>
												<th>EmailId</th>
												<th>Department</th>
												<th>Designaiton</th>
												<th>Action</th>
											</tr>
										</thead>
										<tbody id="officerLstTbl">
											<c:if test="${operType eq 'Edit'}">
											<input type="hidden" name="operType" value="Edit"/>	
											<c:forEach items="${committeeDetails}" var="officerDtl">
    										<tr id="${officerDtl[2]}">
    												<c:set value="${var_total_member+1}" var="var_total_member" />	
        											<td><c:out value="${officerDtl[0]}"/></td>
        											<td><c:out value="${officerDtl[1]}"/></td>
        											<td>${officerDtl[3]}</td>
        											<td>${officerDtl[4]}</td>
        											<td><a href="#" onclick="removeRow(${officerDtl[2]})">remove</a><input type="hidden" name="hdofficerId" value="${officerDtl[2]}" /></td>  
    										</tr>
											</c:forEach>
											</c:if>
										</tbody>
									</table>
										<div>
											<input type="hidden" name="hdTenderId" value="${tenderId}"/>
											<input type="hidden" name="hdCommitteId" value="${committeeId}"/>
											
											<button type="submit"  class="btn btn-submit">Submit</button>
										</div>
										<input type="hidden" id="memberCount" name="memberCount" value="${var_total_member}" />
									</form:form>
								</div>
							</div>
						</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
</section>
</div>
 <script type="text/javascript">
        var VALIDATE_MSG_REQUIRED = 'Please enter';
        var VALIDATE_MSG_SELECT = 'Please select';
        var grandParentDeptJson = '${grandParentDeptJson}';
        var grandParentDeptJsonObj = jQuery.parseJSON(grandParentDeptJson);
        var grandParentDeptId = '${grandParentDeptId}';
        $(function() {	     	
	     	//fill organization combo on load
        	$('#grandParentDeptIdDiv').html('');
	     	$.each(grandParentDeptJsonObj, function (key, value) {
	     	var granPId = value.value; 
	     	if(granPId==grandParentDeptId){
	     		$('#grandParentDeptIdDiv').html(value.label);
	     	}	
// 	    	$('#grandParentDeptId').append($('<option>',
// 	    		 {
// 	    		    value: value.value,
// 	    		    text : value.label
// 	    		}));
	    	 });
        	});
        
        getDesignations();
     	getParentDepartmentsByGrandparentDept();
            
            function validate(){
            	var vbool = valOnSubmit();
            	if($('#searchValue').val()=="" || $('#searchValue').val()=='undefind'){
            		vbool=true;
            	}
            	if(vbool){
                	var addedMember = $("#memberCount").val();
            		if(addedMember <= parseInt(0)){
            			alert('<spring:message code="add_mim_one_committee_member"/>');
                		return false;
                	}
            	}
            	return disableBtn(vbool);
            }
            
            function showHideDiv(){
            	var keyword = $("#selSearch").val();
            	if(keyword =='name' || keyword =='email'){
            		$('#Hirarchy').hide();
            		$('#nonHirarchy').show();
            	}else{
            		$('#nonHirarchy').hide();
            		$('#Hirarchy').show();
            	}
            }
            
            
            function searchAjax() {
            	var data = {};
            	var keyword = $("#selSearch").val();
            	var searchValue = "";
            	if(keyword =='name' || keyword =='email'){
            		searchValue = $("#searchValue").val();
            	}else{
            		var grandParentDept = '${grandParentDeptId}';
            		var parentDept = $('#selDepartment').val();
            		var subDept = $('#subDept').val();
            		var designation = $('#selDesignation').val();
            		if(parentDept=='-1' && subDept=='-1' && designation=='-1' && grandParentDept=='-1'){
            			alert('Please select hirarchy');
            		}else if(parentDept>0 && subDept=='-1' && designation=='-1' && grandParentDept>0 ){
            			searchValue = parentDept;
            			keyword="deptId";	
            		}else if(parentDept>0 && subDept=='-1' && designation>0 && grandParentDept>0){
            			searchValue = designation;
            			keyword="designationId";
            		}else if(parentDept>0 && subDept>0 && designation>0 && grandParentDept>0){
            			searchValue = designation;
            			keyword="designationId";
            		}else if(parentDept>0 && subDept>0 && designation=='-1' && grandParentDept>0 ){
            			searchValue = subDept;
            			keyword="deptId";	
            		}else if(parentDept=='-1' && subDept=='-1' && designation=='-1' && grandParentDept>0 ){
            			searchValue = grandParentDept;
            			keyword="deptId";	
            		}else if(parentDept=='-1' && subDept=='-1' && designation>0 && grandParentDept>0 ){
            			searchValue = designation;
            			keyword="designationId";	
            		}
            	}
            	
            	$.ajax({
            		type : "POST",
            		contentType : "application/json",
            		url : "${pageContext.servletContext.contextPath}/etender/buyer/officers/"+searchValue+"/"+keyword,
            		data : data,
            		timeout : 100000,
            		success : function(data) {
            			console.log("SUCCESS: ", data);
            			var obj = jQuery.parseJSON(data);
            			$('#selName').html('');
            		     $.each(obj, function (key, value) {
            		    $('#selName').append($('<option>',
            		    		 {
            		    		    value: value.value,
            		    		    text : value.label,
            		    		}));
            		     });
            		},
            		error : function(e) {
            			console.log("ERROR: ", e);
            		},
            		done : function(e) {
            			console.log("DONE");
            		}
            	});
            }
            
            function getParentDepartmentsByGrandparentDept() {
            			blockUI();
            			var data = {};
                    	var searchValue = '${grandParentDeptId}'+"@@0";
                    	
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
                    	return true;
           		 }
            
            
           	 function getSubDepartments() {
           				blockUI();
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
                    	return true;
            }
            
            
            function getDesignations() {
            	blockUI();
            	var data = {};
            	var subDeptId = $("#subDept").val();
            	var parentDeptId = $("#selDepartment").val();
//             	var grandParentDeptId = $('#grandParentDeptId').val();
            	var grandParentDeptId = '${grandParentDeptId}';
            	var searchValue = "";
//             	if(parentDeptId>0 && subDeptId>0 && grandParentDeptId>0){
//             		searchValue = subDeptId;	
//             	}else if (parentDeptId>0 && subDeptId=='-1' && grandParentDeptId>0){
//             		searchValue = parentDeptId;
//             	}else if (parentDeptId=='-1' && subDeptId=='-1' && grandParentDeptId>0){
            	searchValue = grandParentDeptId;
//             	}else{
//             		alert("please select organization");
//             	}
            	
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
            
            
            
            function removeRow(id)
            {
                $('#'+id).remove();
                var totalMemberCount = parseInt($("#memberCount").val()) - 1;
        		$("#memberCount").val(totalMemberCount);
            }
            $(document).on('click', '#addOfficer', function(){
            	var selNameVal = $('#selName').val();
            	var name = selNameVal.split('@@')[0];
            	var email = selNameVal.split('@@')[1];
            	var designation = selNameVal.split('@@')[2];
            	var department = selNameVal.split('@@')[3];
            	var id = selNameVal.split('@@')[4];
            	var data = '<tr id="'+id+'"><td>'+name+'</td><td>'+email+'</td><td>'+designation+'</td><td>'+department+'</td><td><a href="#" onclick="removeRow('+id+')">remove</a><input type="hidden" name="hdofficerId" value="'+id+'" /></td></tr>';
            	if($("#" + id).length == 0) {
            		$( "#officerLstTbl" ).append(data);
            		var totalMemberCount = parseInt($("#memberCount").val()) + 1;
            		$("#memberCount").val(totalMemberCount);
            	} else {
            		alert('this record already exists');
            	}
            });
            
           </script>
           <%@include file="../../includes/footer.jsp"%>