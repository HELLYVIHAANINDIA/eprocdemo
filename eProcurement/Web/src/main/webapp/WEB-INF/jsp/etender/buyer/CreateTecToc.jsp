<%@include file="../../includes/head.jsp"%>
<%@include file="../../includes/masterheader.jsp"%>

        <spring:message code="title_tender_createcomitee" var="titlecommittee"/>
       
   <div class="content-wrapper">     
  
<c:set var="var_total_member" value="0" />

<section class="content-header">
<a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}" class="g g-back"><< Go To Tender Dashboard</a>
</section>

<section class="content">
<div class="row">
<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
<div class="box">
					
						<div class="box-header with-border">												
							<c:choose>
								<c:when test="${committeeType eq 1}">
									<c:choose>
										<c:when test="${operType eq 'Edit'}">
											<h3 class="box-title">Edit bid opening committee</h3>	
										</c:when>
										<c:otherwise>
											<h3 class="box-title">Create bid opening committee</h3>	
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
								<c:choose>
										<c:when test="${operType eq 'Edit'}">
											<h3 class="box-title">Edit bid evaluation committee</h3>	
										</c:when>
										<c:otherwise>
											<h3 class="box-title">Create bid evaluation committee</h3>
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>							
						</div>
						                              
						<div class="box-body">
							<div class="row">
								<div class="col-lg-12 col-md-12 col-xs-12">
								
									<div class="row">
										
										<div class="col-lg-12">
											<c:if test="${not empty successMsg}">
                                        		<span class="label label-success"><spring:message code="${successMsg}"/></span>
                                    		</c:if>
                                    		<c:if test="${not empty errorMsg}">
                                        		<span class="label label-danger"><spring:message code="${errorMsg}"/></span>
                                    		</c:if>
										</div>
										
										<div class="col-md-6">
										
										<div class="fr-grp">
										<label class="lblfr-fields">Search By</label>
										<select class="form-control fr-cntrl" id="selSearch" onchange="javascript:showHideDiv();">
											<option value="email">Email</option>
  											<option value="name">Name</option>
  											<option value="Hirarchy">Hirarchy</option>
										</select>
										</div>
										
										<div class="fr-grp" id="nonHirarchy">
										<label class="lblfr-fields">Search</label>
										<input type="text" class="form-control fr-cntrl" id="searchValue"  title="Search value"  validarr="required@@length:0,100" tovalid="true" onblur="javascript:{validateTextComponent(this)}">
										<button type="button" class="btn btn-submit" onclick="searchAjax();">Search</button>
										</div>
										
										<div class="fr-grp" id="Hirarchy" style="display: none">
										<label class="lblfr-fields">Organization</label>
										<div id="grandParentDeptIdDiv">
											<input type="hidden" id="grandParentDeptId" value="${grandParentDeptId}" />	
										</div>
										</div>
										
										<div class="fr-grp">
										<label class="lblfr-fields">Location/Department</label>
										<select class="form-control fr-cntrl" id="selDepartment" name="selDepartment" onblur="javascript:{if(true){getSubDepartments();getDesignations()}}" title="department">
											<option value="-1">Please Select</option>
										</select>
										</div>
										
										<div class="fr-grp">
										<label class="lblfr-fields">Sub Department</label>
										<select class="form-control fr-cntrl" name="subDeptId"  id="subDept"  onblur="javascript:{getDesignations()}" title="Sub department name" >
											<option value="-1">Please select</option>
										</select>
										</div>
										
										<div class="fr-grp">
										<label class="lblfr-fields">Designation</label>
										<select class="form-control fr-cntrl" id="selDesignation" name="selDesignation" onblur="validateCombo(this)" title="designation">
											<option value="-1">Please Select</option>
										</select>
										<button type="button" class="btn btn-submit" onclick="searchAjax();">Search</button>
										</div>
										
										<div class="fr-grp">
										<label class="lblfr-fields">Officer name</label>
										<select class="form-control fr-cntrl" id="selName">
											<option value="--please select--">--Please Select--</option>
										</select>
										<button type="button" id="addOfficer" class="btn btn-submit">Add</button>
										</div>
										
										</div>
										
																		<div class="col-lg-12 col-md-12 col-xs-12">
								<c:choose>
	               					<c:when test="${operType eq 'Edit'}">
	               						<spring:url value="/etender/buyer/posteditcommittee" var="submitcommittee"/>											
	               					</c:when>
	               					<c:otherwise>
	               						<spring:url value="/etender/buyer/addcommittee" var="submitcommittee"/>
								</c:otherwise>
								</c:choose>
                                    <form:form action="${submitcommittee}" onsubmit="return validate();" name="frmprebidcomittee" method="post" >
									<table class="table table-striped table-responsive">
										<thead>
											<tr>
												<th>Officer</th>
												<c:forEach items="${envList}" var="envList">	
													<th>${envList[1]} <input type="hidden" name="hdEnvelopeId" value="${envList[2]}"/></th>	
												</c:forEach>
												<th>Action</th>
											</tr>
										</thead>
										<tbody id="officerLstTbl">
											<c:if test="${operType eq 'Edit'}">
											<input type="hidden" name="operType" value="Edit"/>	
											
											<c:forEach items="${committeeUserDetails}" var="committeeUserData" varStatus="index">
	               							<c:set var="var_total_member" value="${var_total_member + 1}" />
	               							<c:set var="var_officer_name" value="${committeeUserData.officername}"  />
	               							<c:set var="var_desg_name" value="SE" />
	               							<c:set var="var_dept_name" value="ITA" />
	               							<c:set var="var_officer_id" value="${committeeUserData.id}" />
	               							<c:set var="var_tempofficer_id" value="${var_officer_id}" />
	               							<c:set var="var_enc_officer_id" value="${var_officer_id}" />
	               							<tr id="${committeeUserData.id}">
	               								<td class="v-a-middle">${var_officer_name}<br />${var_desg_name}, ${var_dept_name}<br/>${var_user_loginId}<input type="hidden" name="hdOfficerId" value="${var_officer_id}" />
	               								<input type="hidden" name="tempOfficerId" value="${var_officer_id}" /></td>
	               								<c:set var="tempEnvIds" value="" />
	               								<c:forEach items="${envList}" var="envList" varStatus="envListStatus">
	               									<c:set var="temp1" value="0|0|${envList[3]}|${envList[4]}" />
               										<c:forEach items="${userEnvelopeDetails}" var="commUserEnv">
               											<c:if test="${var_officer_id eq commUserEnv[0]}">
               												<c:if test="${envList[2] eq commUserEnv[1]}">
               													<c:set var="temp1" value="${commUserEnv[1]}|${commUserEnv[2]}|${envList[3]}|${envList[4]}" />
               												</c:if>
               											</c:if>
               										</c:forEach>
	               									<c:set var="tempEnvIds" value="${tempEnvIds},${temp1}" />
	               								</c:forEach>
	               								<c:set var="envIdsStrSplit" value="${fn:split(fn:substringAfter(tempEnvIds,','),',')}" />
	               								<c:set var="var_approval_given" value="false" />
	               								<c:if test="${not empty envList}">
	               								<c:forEach var="i" items="${envIdsStrSplit}" varStatus="iStatus">
	               									<td class="a-center v-a-middle" id="envtd_${iStatus.count}">
	               										<c:set var="tempStrSplit" value="${fn:split(i,'|')}" />
	               										<c:choose>
	               											<c:when test="${tempStrSplit[0] gt 0}">
	               														<c:choose>
	               															<c:when test="${tempStrSplit[1] eq 1}">
	               																<c:set var="var_approval_given" value="true" />
	               																<input type="checkbox" disabled="disabled" checked="checked" />
	               																<input style="display: none;" type="checkbox" class="isOpening" value="${var_enc_officer_id}" id="envOpenMember_${var_tempofficer_id}_${iStatus.count}" name="envOpenMember_${var_tempofficer_id}_${iStatus.count}" checked="checked" />
	               																<input style="display: none;" type="checkbox" class="isOpenApproved" value="${var_enc_officer_id}" id="envOpenApproved_${var_tempofficer_id}_${iStatus.count}" name="envOpenApproved_${var_tempofficer_id}_${iStatus.count}" checked="checked" />
	               															</c:when>
	               															<c:otherwise>
	               																<c:choose>
	               																	<c:when test="${(committeeType eq 1 and tempStrSplit[2] eq 1)}">
	               																		<input type="checkbox" disabled="disabled" checked="checked" />
	               																		<input style="display: none;" type="checkbox" class="isOpening" onclick="onClickChkbox('${var_enc_officer_id}_${iStatus.count}')" value="${var_enc_officer_id}" id="envOpenMember_${var_tempofficer_id}_${iStatus.count}" name="envOpenMember_${var_tempofficer_id}_${iStatus.count}" checked="checked" />
	               																	</c:when>
																					<c:when test="${(committeeType eq 2 and tempStrSplit[3] eq 1)}">
	               																		<input type="checkbox" class="isOpening" value="${var_enc_officer_id}" onclick="onClickChkbox('${var_enc_officer_id}_${iStatus.count}')" id="envOpenMember_${var_tempofficer_id}_${iStatus.count}" name="envOpenMember_${var_tempofficer_id}_${iStatus.count}" checked="checked" />
	               																	</c:when>
	               																	<c:otherwise>
	               																		<input type="checkbox" class="isOpening" value="${var_enc_officer_id}" id="envOpenMember_${var_tempofficer_id}_${iStatus.count}" onclick="onClickChkbox('${var_enc_officer_id}_${iStatus.count}')" name="envOpenMember_${var_tempofficer_id}_${iStatus.count}" checked="checked" />
	               																	</c:otherwise>
	                															</c:choose>
	                														</c:otherwise>
	                													</c:choose>
	                										</c:when>
	                										<c:otherwise>
	                											<c:choose>
	                												<c:when test="${(committeeType eq 1 and tempStrSplit[2] eq 1)}">
	                													<input type="checkbox" disabled="disabled" />
	                													<input style="display: none;" type="checkbox" class="isOpening" value="${var_enc_officer_id}" id="envOpenMember_${var_tempofficer_id}_${iStatus.count}" name="envOpenMember_${var_tempofficer_id}_${iStatus.count}" onclick="onClickChkbox('${var_enc_officer_id}_${iStatus.count}')" />		
	                												</c:when>
                                                                                                                        <c:when test="${(committeeType eq 2 and tempStrSplit[3] eq 1)}">
	                													<input type="checkbox" class="isOpening" value="${var_enc_officer_id}" id="envOpenMember_${var_tempofficer_id}_${iStatus.count}" name="envOpenMember_${var_tempofficer_id}_${iStatus.count}" onclick="onClickChkbox('${var_enc_officer_id}_${iStatus.count}')" />
	                												</c:when>
	                												<c:otherwise>
	                													<input type="checkbox" class="isOpening" value="${var_enc_officer_id}" id="envOpenMember_${var_tempofficer_id}_${iStatus.count}" name="envOpenMember_${var_tempofficer_id}_${iStatus.count}" onclick="onClickChkbox('${var_enc_officer_id}_${iStatus.count}')" />
	                												</c:otherwise>
	                											</c:choose>
	                										</c:otherwise>
	                									</c:choose>
	               									</td>
	               								</c:forEach>
	               								</c:if>
	               								<td class="a-center v-a-middle">
	               										<a href="#" onclick="removeRow(${committeeUserData.id})">remove</a><input type="hidden" name="hdofficerId" value="${officerDtl.id}" />
	               								</td>
	               							</tr>
	               						</c:forEach>
											
<%-- 											<c:forEach items="${committeeUserDetails}" var="officerDtl"> --%>
<%--     										<tr id="${officerDtl.id}"> --%>
<%--         											<td><c:out value="${officerDtl.officername}"/><br><c:out value="${officerDtl.emailid}"/><br>SE,IT</td> --%>
<%--         											<c:forEach items="${envList}" var="envList">	 --%>
<%-- 														<td><input type="checkbox" value="${envList[1]}_${officerDtl.id}"></td>	 --%>
<%-- 													</c:forEach>		 --%>
<%--         											<td><a href="#" onclick="removeRow(${officerDtl.id})">remove</a><input type="hidden" name="hdofficerId" value="${officerDtl.id}" /></td>   --%>
<!--     										</tr> -->
    										
<%-- 											</c:forEach> --%>
											</c:if>
										</tbody>
										<tbody>
										<tr id="trMinApprovalReq">  <%--min approval edit evaluation committee --%>
	               						<th class="a-left">Minimum approval require</th>
	               						<c:set var="var_env_opened_evaluated" value="" />
	               						<input type="hidden" id="minCommMembersReq" name="minCommMembersReq" value="${minMember}" />
	               						<c:forEach items="${envList}" var="envList" varStatus="envListStatus">
	               							<c:choose>
	               								<c:when test="${committeeType eq 1}"><c:set var="var_env_opened_evaluated" value="${var_env_opened_evaluated}|${envList[2]},${envList[3]}" /></c:when>
	               								<c:when test="${committeeType eq 2}"><c:set var="var_env_opened_evaluated" value="${var_env_opened_evaluated}|${envList[2]},${envList[4]}" /></c:when>
	               							</c:choose>
	               							<th>
	               								<c:set var="temp_count" value="0" />
	               								<c:forEach items="${userMinApproval}" var="envAppList" varStatus="envAppListStatus">
	               									<c:if test="${envList[2] eq envAppList[0]}">
	               									<c:set var="temp_count" value="${temp_count+1}" />
	               									<c:set var="var_total_approval" value="${envAppList[1]}" />
	               									<c:set var="var_min_approval" value="${envAppList[2]}" />
	               									<c:set var="var_min_approval_given" value="" />
	               										<c:if test="${(committeeType eq 1 and envAppList[3] eq 1)}">
	               											<c:set var="var_min_approval_given" value="style=\"display: none;\"" />${var_min_approval} of 
	               										</c:if>
	               										
	               										<select ${var_min_approval_given} name="minApprovalReq_${envListStatus.count}" id="minApprovalReq_${envListStatus.count}" style="width: 50px;">
	               										<c:forEach begin="${committeeType eq 1 ? 1 : 0}" end="${var_total_approval}" var="totalAppStatus">
	               										<c:set var="var_sel_min_approval" value="" />
	               											<c:if test="${totalAppStatus eq var_min_approval}">
	               												<c:set var="var_sel_min_approval" value="selected=\"selected\"" />
	               											</c:if>
	               											<option value="${totalAppStatus}" ${var_sel_min_approval}>${totalAppStatus}</option>
	               										</c:forEach>
	               										</select>
<%-- 	               										<label name="lblMinApproval" id="lblMinApproval_${envListStatus.count}">${var_total_approval}</label> --%>
	               										<input name="minApprovalReqHidd" id="minApprovalReqHidd_${envListStatus.count}" type="hidden" style="width: 30px;" type="text" value="${var_total_approval}" />
	               									</c:if>
	               								</c:forEach>
	               								<c:if test="${temp_count eq 0}">
	               									<select name="minApprovalReq_${envListStatus.count}" id="minApprovalReq_${envListStatus.count}" style="width: 50px;"><option value="0" selected="selected">0</option></select>
<%-- 	               									<label name="lblMinApproval" id="lblMinApproval_${envListStatus.count}">0</label> --%>
	               									<input name="minApprovalReqHidd" id="minApprovalReqHidd_${envListStatus.count}" type="hidden" style="width: 30px;" type="text" value="0" />
	               								</c:if>
	               							</th>
	               						</c:forEach>
	               						<th></th>
	               					</tr>
										</tbody>
									</table>
									<div>
										<c:if test="${operType ne 'Edit'}">
										<input type="checkbox" name="isTECTOCSame" id="isTECTOCSame" value="1" />TOC & TEC are same
										</c:if>
									</div>
										<div>
											<input type="hidden" name="hdTenderId" value="${tenderId}"/>
											<input type="hidden" name="hdCommitteId" value="${committeeId}"/>
											<input type="hidden" name="hdEnvCount" value="${envCount}"/>
											<input type="hidden" name="hdIsApproved" value="${isApproved}"/>
											<input type="hidden" name="hdCommitteeTypeId" value="${committeeType}"/>
											<input type="hidden" id="memberCount" name="memberCount" value="${var_total_member}" />
											<button type="submit"  class="btn btn-submit">Submit</button>
										</div>
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
</div>
</div>
</section>
</div>
<script type="text/javascript">
        var VALIDATE_MSG_REQUIRED = 'Please enter';
        var VALIDATE_MSG_SELECT = 'Please select';
        var committeeType = '${committeeType}';
        var deptLst = '${deptLst}';
        var grandParentDeptJson = '${grandParentDeptJson}';
        var grandParentDeptJsonObj = jQuery.parseJSON(grandParentDeptJson);
        var obj = jQuery.parseJSON(deptLst);
        var grandParentDeptId = '${grandParentDeptId}';
        
        $(function() {
//         	$('#selDepartment').html('');
// 	     	$.each(obj, function (key, value) {
// 	    	$('#selDepartment').append($('<option>',
// 	    		 {
// 	    		    value: value.value,
// 	    		    text : value.label
// 	    		}));
// 	    	 });
	     	
	     	//fill organization combo on load
        	$('#grandParentDeptId').html('');
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
        
            $(document).ready(function() {
// 				if(totalMemberCount == 0){
// 					$("#trNoMemberAdded").show();
// 	        		$("#trMinApprovalReq").hide();
// 				}
        	});
            
            function onClickChkbox(id){
        		var envelopeId = id.split('_')[1];
				var chkId = "envOpenMember_"+id;
				var element = $('#'+chkId);
        		if($(element).is(':checked')){  //check box checked
        			updateMinApproval(envelopeId, 1);
        		}
        		else {
        			updateMinApproval(envelopeId, 2);	
        		}
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
//             		var grandParentDept = $('#grandParentDeptId').val();
            		var grandParentDept = grandParentDeptId;
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
            		    		    text : value.label
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
                    	var searchValue = grandParentDeptId+"@@0";
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
                    			unBlockUI()
                    		},
                    		error : function(e) {
                    			console.log("ERROR: ", e);
                    			unBlockUI()
                    		},
                    		done : function(e) {
                    			console.log("DONE");
                    			unBlockUI()
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
                    			unBlockUI()
                    		},
                    		error : function(e) {
                    			console.log("ERROR: ", e);
                    			unBlockUI()
                    		},
                    		done : function(e) {
                    			console.log("DONE");
                    			unBlockUI()
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
            			unBlockUI()
            		},
            		error : function(e) {
            			console.log("ERROR: ", e);
            			unBlockUI()
            		},
            		done : function(e) {
            			console.log("DONE");
            			unBlockUI()
            		}
            	});
            }
            
            
            
            function removeRow(id)
            {
    				var envCount =  '${envCount}';
    				for(var i=1;i<=envCount;i++){
            			if($("#envOpenMember_"+id+"_"+i+"").is(':checked')){
            				updateMinApproval(i, 2);
            			}
            		}
    				
    				var totalMemberCount = parseInt($("#memberCount").val()) - 1;
	        		$("#memberCount").val(totalMemberCount);
    				$('#'+id).remove();
            }
            
            
            $(document).on('click', '#addOfficer', function(){
            	var envCount =  '${envCount}';
            	var selNameVal = $('#selName').val();
            	var name = selNameVal.split('@@')[0];
            	var email = selNameVal.split('@@')[1];
            	var designation = selNameVal.split('@@')[2];
            	var department = selNameVal.split('@@')[3];
            	var id = selNameVal.split('@@')[4];
            	var data = '<tr id="'+id+'"><td>'+name+',<br>'+email+'<br>'+designation+','+department+'<input type=\"hidden\" name=\"hdOfficerId\" value="'+id+'"/> </td> ';
            	var newRow = "<tr>";
        		<c:forEach items="${envList}" var="envList" varStatus="envListStatus">
        			<c:choose>
        				<c:when test="${(committeeType eq 1)}">
        					data += "<td><input type=\"checkbox\"  value=\""+id+"_"+${envListStatus.count}+"\" onclick=\"onClickChkbox('"+id+"_"+${envListStatus.count}+"');\" class=\"isOpening\" id=\"envOpenMember_"+id+"_${envListStatus.count}\" name=\"envOpenMember_"+id+"_${envListStatus.count}\" /> <input type=\"hidden\" name=\"tempOfficerId\" value=\""+id+"\" /></td>";
        				</c:when>
						<c:when test="${(committeeType eq 2 and envList[4] eq 1)}">
							 data += "<td class=\"a-center v-a-middle\" id=\"envtd_${envListStatus.count}\"><input type=\"checkbox\" onclick=\"onClickChkbox('"+id+"_"+${envListStatus.count}+"');\" class=\"isOpening\" value=\""+id+"\" id=\"envOpenMember_"+id+"_${envListStatus.count}\" name=\"envOpenMember_"+id+"_${envListStatus.count}\"  /><input type=\"hidden\" name=\"tempOfficerId\" value=\""+id+"\" /></td>";
        				</c:when>
        				<c:otherwise>
        					data += "<td class=\"a-center v-a-middle\" id=\"envtd_${envListStatus.count}\"><input type=\"checkbox\" onclick=\"onClickChkbox('"+id+"_"+${envListStatus.count}+"');\" class=\"isOpening\" value=\""+id+"\" id=\"envOpenMember_"+id+"_${envListStatus.count}\" name=\"envOpenMember_"+id+"_${envListStatus.count}\" /><input type=\"hidden\" name=\"tempOfficerId\" value=\""+id+"\" /></td>";
        				</c:otherwise>
        			</c:choose>
    			</c:forEach>
    			data +='<td><a href="#" onclick="removeRow('+id+')">remove</a></td></tr>';
            	if($("#" + id).length == 0) {
            		$( "#officerLstTbl" ).append(data);
            		var totalMemberCount = parseInt($("#memberCount").val()) + 1;
            		for(var i=1;i<=envCount;i++){
            			if($("#envOpenMember_"+id+"_"+i+"").is(':checked')){
            				updateMinApproval(i, 2);
            			}
            		}
	        		$("#memberCount").val(totalMemberCount);
	        		$("#trNoMemberAdded").hide();
	        		$("#trMinApprovalReq").show();
	        		
            	} else {
            		alert('this record already exists');
            	}
            });
            
            
            
            function updateMinApproval(envelopeId, action){            
            	var totalAppCount = parseInt($("#minApprovalReqHidd_"+envelopeId+"").val());
                if(action == 1){
                	totalAppCount++;
                }
                else if (action == 2){
                	totalAppCount--;
                }
                $("#minApprovalReqHidd_"+envelopeId+"").val(totalAppCount);
//                 $("#lblMinApproval_"+envelopeId+"").html(totalAppCount);
                var selMinApproval = "#minApprovalReq_"+envelopeId+"";
                var tempSelVal = $(selMinApproval).val();
                $(selMinApproval).empty();
                var minConsentReq = 1;
    			if(totalAppCount > 0){
    				for(var i=minConsentReq;i<=totalAppCount;i++) {
    					var tempSelAtt = "";
    					if(0 == i){
    						tempSelAtt = "selected=\"selected\"";
    					}
    					$(selMinApproval).append("<option value=\""+i+"\" "+tempSelAtt+">"+i+"</option>");	
    				}	
                }
    			else {
    				$(selMinApproval).append("<option value=\""+minConsentReq+"\" selected=\"selected\">"+minConsentReq+"</option>");
    			}
            }	
            
            function validate(){
            	var vbool = valOnSubmit();
            	if($('#searchValue').val()=="" || $('#searchValue').val()=='undefind'){
            		vbool=true;
            	}
            	if(vbool){
            		var minMember = $("#minCommMembersReq").val();
                	var addedMember = $("#memberCount").val();
            		if(addedMember < minMember){
            			alert('<spring:message code="add_mim_one_committee_member"/>');
                		return false;
                	}
                	var isValidDecSel = 0;
                	var isValidEncLevel = 0;            	
                	var arrEncLevel = new Array();
                	
                	if(!checkOfficerMapped()){
                		
                		if(committeeType==1){
                			alert('<spring:message code="select_mandatory_committee_member"/>');	
                		}else{
                			alert('<spring:message code="select_mandatory_evalution_committee_member"/>');
                		}
                		vbool = false;
            			return false;
                	}
                	
                	if(!isEnvelopeMappedWithOfficer()){
                		if(committeeType==1){
                			alert('<spring:message code="select_mandatory_committee_member"/>');	
                		}else{
                			alert('<spring:message code="select_mandatory_evalution_committee_member"/>');
                		}
                		vbool = false;
            			return false;
                	}
            	}
            	return disableBtn(vbool);
            }
            	function checkOfficerMapped(){
                	var count = 0;
                	var envCount =  '${envCount}';
                	$('input[name=tempOfficerId]').each(function() {
                		var officerId = $(this).val();
                		var isMapped = false;
                		for(var i=1;i<=envCount;i++){
        	        		if($("#envOpenMember_"+officerId+"_"+i+"").is(":checked")){
        	        			isMapped = true;
        	        			break;
        	        		}
                		}
                		if(!isMapped){
                			count++;
                		}
                	});
                	
                	if(count > 0){
                		return false;
                	}
                	else {
                		return true;	
                	}
                }
            
            	
            	function isEnvelopeMappedWithOfficer(){
            		var envCount =  '${envCount}';
                	var count = 0;
                	for(var i=1;i<=envCount;i++){
                		//var isMapped = false;
                		var checkedCount=0;
                		$('input[name=tempOfficerId]').each(function() {
                			var officerId = $(this).val();
                			if($("#envOpenMember_"+officerId+"_"+i+"").is(":checked")){
                				checkedCount++;
                			}
                		});
                		
                		if(checkedCount<'${minMember}'){
            				count++;
            			}
                	}
                	if(count > 0){
                		return false;
                	}
                	else {
                		return true;	
                	}
                }	
            	
           </script>
           
<%@include file="../../includes/footer.jsp"%>