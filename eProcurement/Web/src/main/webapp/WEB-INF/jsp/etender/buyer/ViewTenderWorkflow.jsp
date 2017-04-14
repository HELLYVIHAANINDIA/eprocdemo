
<%@include file="../../includes/head.jsp"%>
 <%@include file="../../includes/masterheader.jsp"%>



<spring:message code="link_create" var="createlink" />
<spring:message code="link_tender_edit" var="editlink" />
<spring:message code="link_tender_view" var="viewlink" />
<spring:message code="link_tender_publish" var="publishlink" />   
<spring:message code="link_tender_processinwf" var="processworkflowlink"/>
<spring:message code="link_tender_configurewf_for_bid_opening" var="link_tender_configurewf_for_bid_opening"/>
<spring:message code="link_tender_viewapprhist_for_bid_opening" var="link_tender_viewapprhist_for_bid_opening"/>
<spring:message code="link_tender_callbackwf" var="processworkflowcallbacklink"/>
<spring:message code="var_prepare" var="preparelink"/>
<!-- corrigendum  -->
<spring:message code="link_delete_corrigendum" var="deletelink"/>
<spring:message code="lbl_tender_upload" var="uploadlink"/>
<spring:message code="link_edit_corrigendum" var="editcorrigendumlink"/>
<!-- Bidding Form -->
<spring:message code = "link_orginizeform"      var = "link_orginizeform" />
<spring:message code = "link_view"              var = "link_view" />
<spring:message code = "th_srno"              var = "th_srno" />
<spring:message code = "th_approval_for"              var = "th_approval_for" />
<spring:message code = "th_forwarded_by"              var = "th_forwarded_by" />
<spring:message code = "th_forwarded_to"              var = "th_forwarded_to" />
<spring:message code = "th_action_taken"              var = "th_action_taken" />
<spring:message code = "th_dateandtime"              var = "th_dateandtime" />
<spring:message code = "col_action"              var = "col_action" />
<spring:message code="label_workflow_approve" var="labelworkflowapprove" />
<spring:message code="label_approved" var="label_approved" />
<spring:message code="label_ask_for_approve" var="label_ask_for_approve" />
<spring:message code="label_rejected" var="label_rejected" />
<spring:message code="label_workflow_forward" var="labelworkflowforward" />
<spring:message code="label_workflow_reject" var="labelworkflowreject" />
<spring:message code="label_workflow_return" var="labelworkflowreturn" />

<spring:message code="label_workflow" var="labelworkflow" />
<spring:message code="th_tender_action" var="action" />
<spring:message code="label_select_user" var="labelselectuser" />
<spring:message code="lbl_remark" var="lbl_remark" />
<spring:message code="btn_submit" var="btn_submit" />
           
     
       

       <c:if test="${not empty successMsg}">
      <div class="alert alert-success">  ${successMsg}</div>
      </c:if>

	
	<div class="content-wrapper">
	<section class="content-header">
	<c:choose>
	<c:when test="${tblTender.isAuction eq 0}">
	<h1 class="pull-left">View Tender Workflow</h1>
	</c:when>
	<c:when test="${tblTender.isAuction eq 1}">
	<h1 class="pull-left">View Auction Workflow</h1>
	</c:when></c:choose>
	
		<a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}" class="pull-right"><< <spring:message code="lbl_back_dashboard"/></a>
		<a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderListing" class="pull-right"><< <spring:message code="lbl_back_tenderlist"/></a> 
	</section>
	
	<section class="content">
	<c:choose>
	<c:when test="${tblTender.isAuction eq 1}">
		<%@include file="AuctionSummary.jsp"%>
	</c:when>
	<c:when test="${tblTender.isAuction eq 0}">
		<%@include file="TenderSummary.jsp"%>
	</c:when>
	
	</c:choose>
		<c:if test="${not empty tblWorkflowForUser}">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<div class="box-header with-border">
						<h3 class="box-title"></h3>
					</div>
					<div class="box-body">
						<div class="row">
							<div class="col-md-12">
								<c:if test="${not empty tblWorkflowForUser}">
		<table class="table hover"> 
			<tr style="background-color: #3c8dbc">
				<th>${th_srno}</th>
<%-- 				<th>${th_approval_for}</th> --%>
				<th>${th_forwarded_by}</th>
				<th>${th_forwarded_to}</th>
				<th>${th_action_taken}</th>
				<th>${lbl_remark}</th>
				<th>${th_dateandtime}</th>
				<th>${col_action}</th>
			</tr>
			
			<c:forEach items="${tblWorkflowForUser}" var="items" varStatus="indx">
			<tr><td>${indx.count}</td>
			<c:set var="fTo">${items.forwardedTo}</c:set>
			<c:set var="fBy">${items.forwardedBy}</c:set>
			<td>${officerNameMap[fBy]}</td>
			<td>${officerNameMap[fTo]}</td>
			<td>
			<c:choose>
				<c:when test="${items.action eq 1}">
<%-- 					${label_ask_for_approve} --%>
					${labelworkflowforward}
				</c:when>
				<c:when test="${items.action eq 2}">
<%-- 				${label_approved} --%>
					${labelworkflowapprove}
				</c:when>
				<c:when test="${items.action eq 3}">
<%-- 				${label_rejected} --%>
					${labelworkflowreject}
				</c:when>
				<c:when test="${items.action eq 4}">
					${labelworkflowreturn}
				</c:when>
			</c:choose>
			</td>
 			<td>${items.remarks}</td>
			<td>${items.createdDate}</td>														
			<td><a href="${pageContext.servletContext.contextPath}/etender/buyer/getDocumentList/${tenderId}/${objectId}/${childId}/${items.workflowId}/0" data-target="#myModal" class="myModel" data-toggle="modal">View Document</a></td>
			</tr>
			</c:forEach>
			
		</table>
</c:if>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		</c:if>
<c:if test="${allowCreateWF}">	
	<div class="row">
			<div class="col-md-12">
				<div class="box">
					<div class="box-header with-border">
						<h3 class="box-title">Create ${labelworkflow}</h3>
					</div>
					<div class="box-body">
						<div class="row">
							<form id="tenderDtBean" name="tenderDtBean" onsubmit="return validation();" action="${pageContext.request.contextPath}/etender/buyer/addworkflow" method="post" >
	<input type="hidden" name="isAuction" value="${tblTender.isAuction}">
	<div class="form-group">
  	
		<div class="col-md-12">
			<div class="col-md-3">
				${action}
			</div>
			<div class="col-md-9">
			<select name="actionId" id="actionId" class="form-control">
				<option value="1">${labelworkflowforward}</option>
				<c:if test="${not empty tblWorkflowForUser && workFlowIniatior ne sessionObject.userId}">
				<option value="2">${labelworkflowapprove}</option>
				<option value="3">${labelworkflowreject}</option>
				<option value="4">${labelworkflowreturn}</option>
				</c:if>
			</select>
			</div>
		</div>
		<div class="col-md-12">	
			<div class="col-md-3">
			<spring:message code="lbl_comment"/>
			</div>
			<div class="col-md-9">
				<textarea name="remarks" id="rtfRemarks" validarr="required@@remarks:500" tovalid="true" title="remarks" class="form-control"></textarea>
				
			</div>
		</div>
<div class="officerSelection">
			<div class="col-md-12">
										<div class="col-md-3">
											<div class="form_filed">Search By</div>
										</div>
										<div class="col-md-9">
											<select class="form-control" id="selSearch" onchange="javascript:showHideDiv();">
												<option value="email">Email</option>
  												<option value="name">Name</option>
  												<option value="Hirarchy">Hirarchy</option>
											</select>
										</div>
									</div>	
									<div class="col-md-12" id="nonHirarchy">
										<div class="col-md-3">
											<div class="form_filed">Search</div>
										</div>
										<div class="col-md-9">
											<input type="text" class="form-control" id="searchValue" placeholder="Type Your Name">
										</div>
									</div>
									<div id="Hirarchy" style="display: none">
									<div class="col-md-12">
										<div class="col-md-3">
											<div class="form_filed">Department</div>
										</div>
										<div class="col-md-9">
											<select class="form-control" id="selDepartment" name="selDepartment" onblur="javascript:{if(validateCombo(this)){getSubDepartments();getDesignations()}}" title="department">
														<option value="0">--Please Select--</option>
													</select>
										</div>
									</div>
									<div class="col-md-12">
										<div class="col-md-3">
											<div class="form_filed">Sub department</div>
										</div>
										<div class="col-md-9">
											<select class="form-control" name="subDeptId"  id="subDept"  onblur="javascript:{getDesignations()}" title="Sub department name" >
															<option value="">Please select</option>
											</select>
										</div>
									</div>
									<div class="col-md-12">
										<div class="col-md-3">
											<div class="form_filed">Designation</div>
										</div>
										<div class="col-md-9">
											<select class="form-control" id="selDesignation" name="selDesignation" onblur="validateCombo(this)" title="designation">
															<option value="">--Please Select--</option>
													</select>
										</div>
									</div>
								</div>
									<div class="col-md-12">
										<div class="col-md-3">
										</div>
										<div class="col-md-9 pull-right">
											<button type="button" class="btn btn-submit" onclick="searchAjax();">Search</button>
										</div>
									</div>
									
			<div class="col-md-12">
				<div class="col-md-3">
					<div class="form_filed">Officer name</div>
				</div>
				<div class="col-md-9">
					<select class="form-control" name="officerId" id="selName" isrequired="true" title="user" onchange="javascript:validateCombo(this)" >
						<option value="">--Please Select--</option>
					</select>
<%-- 								<button type="button" id="addOfficer" class="btn btn-submit">Add</button>--%>
				</div>
			</div></div>
		<div class="col-md-12">
			<div class="col-md-3"></div>
			<div class="col-md-9 pull-left">
			<%@include file="./UploadDocuments.jsp"%>
			</div>
		</div>
		<div class="col-md-12">
			<div class="col-md-3"></div>
			<div class="col-md-3 pull-left">
			<input type="hidden" name="workflowId" id="workflowId" value="${workflowId}">
			<input type="hidden" name="tenderId" id="tenderId" value="${tenderId}">
			<input type="hidden" name="corrigendumId" id="corrigendumId" value="${corrigendumId}">
			<input type="hidden" name="uploadedDocumentId" id="uploadedDocumentId" value="">
				<input type="submit" class="form-control" value="${btn_submit}">
			</div>
		</div>
	</div>
	<div class="clearfix"></div>
			</form>
			</div>
		</div>
	</div>
 </div>
</div>
</c:if>	
	</section>
	<div id="targetDiv"></div>
</div>
		
<script type="text/javascript">

 $(document).ready(function(){

	 $('a.myModel').click(function(){   //bind handlers
		   var url = $(this).attr('href');
		   showDialog(url);
		   return false;
		});

		$("#targetDiv").dialog({  //create dialog, but keep it closed
		   autoOpen: false,
		   height: 300,
		   width: 700,
		   modal: true
		});

		function showDialog(url){  //load content and open dialog
		    $("#targetDiv").load(url);
		    $("#targetDiv").dialog("open");         
		}
	 
     var deptLst = '${deptLst}';
     var obj = jQuery.parseJSON(deptLst);
     
     $(function() {
     	$('#selDepartment').html('');
	     	$.each(obj, function (key, value) {
	    	$('#selDepartment').append($('<option>',
	    		 {
	    		    value: value.value,
	    		    text : value.label
	    		}));
	    	 });
     });
	 
	 
 	 $("#actionId").change(function(){
 			var val = $(this).val();
 			if(val != 1){
 				$(".officerSelection").hide();
 				$("#selName").attr("isrequired","false");
 			}else{
 				$(".officerSelection").show();
 				$("#selName").attr("isrequired","true");
 			}
 	 });
	 $("#rtfRemarks").wysihtml5();	 
 });
 var processedOfficer = ${processedOfficer};
 function validation(){
	    var vbool=true;
	    try{
	    vbool=valOnSubmit();
		    if(!vbool){
		    	return false;
		    }
			var officerid = $("#selName").val();
			if(officerid != ""){
			    if($.inArray(parseInt(officerid),processedOfficer) != -1){
					$("#selName").parent().append("<div class='errselName validationMsg clearfix'> Please select another officer </div>");
				    return false;
			    }
			}
			var officerDocId = $("[officerDocId]").map(function () {
		        return $(this).attr("officerDocId");
		    }).get().join(',');
		    $("#uploadedDocumentId").val(officerDocId);
	    }catch(e){
	    	console.log(e);
	    	return false;
	    }
	    return true;
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
 		var parentDept = $('#selDepartment').val();
 		var subDept = $('#subDept').val();
 		var designation = $('#selDesignation').val();
 		if(parentDept=='0' && subDept=='0' && designation=='0'){
 			alert('Please select hirarchy');
 		}else if(parentDept!='0' && subDept=='' && designation=='' ){
 			searchValue = parentDept;
 			keyword="deptId";	
 		}else if(parentDept!='0' && subDept=='' && designation!='' ){
 			searchValue = designation;
 			keyword="designationId";
 		}else if(parentDept!='0' && subDept!='' && designation!='' ){
 			searchValue = designation;
 			keyword="designationId";
 		}else if(parentDept!='0' && subDept!='' && designation=='' ){
 			searchValue = subDept;
 			keyword="deptId";	
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
				var val = (value.value).split("@@");
 		    	var officerId = val[val.length-1];
 		    	$('#selName').append($('<option>',
 		    		 {
 		    		    value: officerId,
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
 
 
 function getSubDepartments() {
	 blockUI();
 			var data = {};
         	var searchValue = $("#selDepartment").val();
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
 	var searchValue = "";
 	if(parentDeptId!=0 && subDeptId!=0){
 		searchValue = subDeptId;	
 	}else if (parentDeptId!=0 && subDeptId==''){
 		searchValue = parentDeptId;
 	}else{
 		alert("please select departments");
 	}
 	
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
 
 
 </script>
   <style>
       .customCls{
       	background:gainsboro;border:1px solid #374850;
       	width:94%
       }
       
       </style>
 <style type="text/css">
.pullright{
	float: right;
}
.pullleft{
	float: left;
}
</style>
 
	<%@include file="../../includes/footer.jsp"%>
