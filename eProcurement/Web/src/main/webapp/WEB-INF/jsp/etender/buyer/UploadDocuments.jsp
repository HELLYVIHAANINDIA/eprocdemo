
<script src="${pageContext.servletContext.contextPath}/resources/js/ajaxfileupload.js" type="text/javascript"></script>
<script type="text/javascript">
        var registerDocObjId = 0;
        	var tenderId= '${tenderId}';
        	var objectId= '${objectId}';
        	if(registerDocObjId=='7' || registerDocObjId=='6'){
        		objectId=registerDocObjId;
        	}else{
        		objectId= '${objectId}';
        	}
   	 		
        	getBriefcaseContent(1, objectId, tenderId);
	        getDocDetails();
	         function specialTrim(str) {
	            return str.replace(/>\s+</g, '><');
	        } 
	        function getBriefcaseContent(tabId, objectId,tenderId) {
	        	if(registerDocObjId=='7' || registerDocObjId=='6'){
	        		objectId=registerDocObjId;
	        	}else{
	        		objectId='${objectId}';
	        	}
                var linkId='${linkId}';
                var briefCaseContent;
                var TenderId = '${tenderId}';
                var searchResult;
            	var data = { 'hdObjectId' : objectId, 'txtTabId' : tabId ,'hdTenderId' : TenderId ,'txtLinkId': linkId};
            	$.ajax({
            		type : "POST",
            		url : "${pageContext.servletContext.contextPath}/etender/bidder/briefcasecontent",
            		data : data,
            		timeout : 100000,
            		success : function(data) {
            			briefCaseContent=data;
            			if (briefCaseContent == 'sessionexpired') {
                            window.location = "${pageContext.servletContext.contextPath}/" + briefCaseContent;
                        } else {
                            $("#briefCaseContent").html(briefCaseContent);
                        }
            		},
            		error : function(e) {
            			console.log("ERROR: ", e);
            		},
            	});
                return false;
            }
	        function fileValidate(){
	       	 $(".successMsg").hide();
	            $('.err').remove();
	            $('#docDescError').html('');
	   	     	$('#fileError').html("");
	   	     	$('#docCheckListError').html("");
	            var valid = false;
	            var doValidate = true;
	            var count = 0;
	            var maxSize = parseInt('${allowedSize}')*1024;
	            var validExt = '${allowedExt}'.replace(/\*./g,'');
	            var browserName="";
	            var fileName = "";
	            var actSize = 0;
	            jQuery.each(jQuery.browser, function(i, val) {
	                browserName+=i;
	            });
	            
	            $(":input[type='file']").each(function(){
	                if(this.value == ''){
	                    $('#fileError').parent().append("<div class='err validationMsg' style='color:red; '><span style='display:inline-block;'><spring:message code='msg_tender_filetoupload_empty' /></span></div>");
	                    count++;
	                }if($("#txtDocDesc").val()==''){
	               	 $('.errtxtDocDesc').remove();
	               	 $("#docDescError").html("<div class='errtxtDocDesc validationMsg' style='color:red;'><spring:message code='msg_tender_docbrief_empty' /></div>");
	               	 count++;
	                }else if(!rgx_brief.test($("#txtDocDesc").val())){
	               	 $('.errtxtDocDesc').remove();
	               	 $("#docDescError").html("<div class='errtxtDocDesc' style='color:red;'><spring:message code='msg_tender_invalidDocBrief' /></div>");
	               	 count++;
	                }
                	var fileNameArr=this.value.split('\\');
                	$("#txtDocDtls").val(fileNameArr[fileNameArr.length -1]+""+$("#txtDocDesc").val()+""+$("#currentTime").val());
                	//alert($("#txtDocDtls").val());
	                
	            });
	            
	            if(count > 0){
	                valid = false;
	            }else{
	                valid = true;
	                /* if($("#txtDocDesc").val()==''){
	               	 valid=false;
	               	 $('#docDescError').val("");
	                } */
	                //valid=valOnSubmit();
	            }
	            return valid;
	        }
	        
	        function ajaxFileUpload(){
	            var fileName=$('input[type=file]').val().split('\\').pop();
	            var fbool = fileValidate();
	            if(fbool){
	    	        $('#docDescError').html('');
	    	        $('#fileError').html("");
	    	        var url = "";
	    	        if(registerDocObjId=='7' || registerDocObjId=='6'){
	    	           url = '${pageContext.servletContext.contextPath}/ajax/submitbriefcasefileupload?txtDocDesc='+$("#txtDocDesc").val()+'&txtobjectId='+registerDocObjId+'&txtChildId=${childId}&txtSubChildId=${subChildId}&txtTenderId=${tenderId}&txtOtherSubChildId=${otherSubChildId}&selDocCheckList='+$("#selDocCheckList").val();	
	    	        }else{
	    	          url = '${pageContext.servletContext.contextPath}/ajax/submitbriefcasefileupload?txtDocDesc='+$("#txtDocDesc").val()+'&txtobjectId=${objectId}&txtChildId=${childId}&txtSubChildId=${subChildId}&txtTenderId=${tenderId}&txtOtherSubChildId=${otherSubChildId}&selDocCheckList='+$("#selDocCheckList").val();	
	    	        }
	    	        $.ajaxFileUpload({
	    	            url:url,
	    	            fileElementId:'fileToUpload',
	    	            dataType: "text",
	    	            secureuri:true,
	    	            success: function (data){
	    	            	//alert("ddddeeeee"+data);
	    	                var index=data.toString().indexOf("Error:");
	    	                 if( index < 0){
	    	                    var strRemove="&nbsp;&nbsp;<a href='javascript:' onclick=\"removeFile('"+$.trim(data.toString())+"');\">Remove</a>";
	    	                    if($('#txtHidDocIds').val() != '')
	    	                        $('#txtHidDocIds').val($('#txtHidDocIds').val()+",");
	    	                    //$('#uploadFile').val('');
                                $('#fileToUpload').val('');
	    	                    $("#txtDocDesc").val('');
	    	                    $("#fileToUploadName").val('');
	    	                    $("#fileCount").val(parseInt($("#fileCount").val(),10) + 1);
	    	                    
	    	                    $("#successDiv").show();
	    	                    $('#successDiv').html('<spring:message code="msg_tender_docuploadsuccessfully" />');
	    	                    getDocDetails();
	    	                    <c:if test="${objectId ne null and objectId ne 0}">
// 	    	                    	getMapDocDetails();
	    	                    </c:if>
	    	                }else{
	    	                	 if(data.toString().indexOf("sessionexpired") < 0){
                                   	//$('#errorMsgDiv').show();
                                   	//$('#uploadFile').val('');
                                   	$('#fileToUpload').val('');
                                    $("#txtDocDesc").val('');
	    	                    	$('#fileError').html('<span style="display:inline-block;" class="validationMsg">'+data.toString().substr(index+6,data.toString().length)+'</span>');
	    	                	 }else{
	    	                		 window.location.replace("${pageContext.servletContext.contextPath}/sessionexpired");
	    	                	 }
	    	                }
	    	            },
	    	            error: function (data, status, e){
	    	               // $('#errorMsgDiv').show();
                                $('#fileError').html(e.toString());
	    	            }
	    	        });
	    	      }else{
	            	return false;
	    	     }
	        }
	        function checkFile(obj){
	        	if($(obj).val()!=""){
	        		$(".err").remove();	
	        		$("#fileError").html("");
	        		$("#fileToUploadName").val($(obj).val());
	        	}
	        } 
	        
	        function getDocDetails(){
	        	 var tabId=$("#txtTabId").val() != undefined ? $("#txtTabId").val() : 0;
	        	 var objectId="";
	        	 if(registerDocObjId=='7' || registerDocObjId=='6'){
	         		objectId=registerDocObjId;
	         	}else{
	         		objectId= '${objectId}';
	         	}
	              $.post("${pageContext.servletContext.contextPath}/ajax/getbriefcaseuploadeddocs", {
	            	 tenderId: '${tenderId}',
	            	 objectId : objectId,
	            	 childId : '${childId}',
	            	 subChildId : '${subChildId}',
	            	 otherSubChildId : '${otherSubChildId}',
	            	 bidderId : '${bidderId}'
	            },
	            function(j)
	            {
	            	if (j == 'sessionexpired') {
	                    window.location = "${pageContext.servletContext.contextPath}/" + j;
	                } else {
	                	$("#DocLst").html("");
	                	var obj = jQuery.parseJSON(j.toString());
	                		if(obj.length>0){
		                	    for(var i=0;i<obj.length;i++)
		                	    {
		                	    	var strRemove="&nbsp;&nbsp;<a href='javascript:' onclick=\"removeFile('"+obj[i]["officerDocId"]+"','"+obj[i]["cStatus"]+"');\">Remove</a>";
		                	    	var strCancel="&nbsp;&nbsp;<a href='javascript:' onclick=\"cancelFile('"+obj[i]["officerDocId"]+"','"+obj[i]["cStatus"]+"');\"> Cancel </a>";
		                	    	var docId = obj[i]["officerDocId"];
		                	    	var cStatus=obj[i]["cStatus"];
		                	    	var status='';
		                	    	if(cStatus==1){
		                	    		status='Approved';
		                	    	}else if(cStatus==0){
		                	    		status='Pending';
		                	    	}else{
		                	    		status='Cancelled';
		                	    	}
		                	    	var strDownload="&nbsp;&nbsp;<a href='${pageContext.servletContext.contextPath}/ajax/downloadbriefcasefile/"+docId+"'>Download</a>";
		                	        var tr="<tr id='doclstId' officerDocId='"+docId+"'>";
		                	        var td0="<td>"+obj[i]["Sr.No"]+"</td>";
		                	        if(objectId==10){
		                	        	var mandatoryDocName = "-";
		                	        	if(obj[i]["mandatoryDocName"]!=null){
		                	        		mandatoryDocName=obj[i]["mandatoryDocName"];
		                	        	}
		                	        	var td1="<td>"+mandatoryDocName+"</td>";
		                	        }else{
		                	        	var td1="";		                	        		
		                	        }
		                	        var td2="<td>"+obj[i]["fileName"]+"</td>";
		                	        var td3="<td>"+obj[i]["description"]+"</td>";
		                	        var td4="<td>"+obj[i]["fileSize"]+"</td>";
		                	        var td5="<td>"+obj[i]["createdOn"]+"</td>";
		                	        if(objectId==1){//bidder registration and tenderauthority dont need status column
		                	        	var td6="<td>"+status+"</td>"
		                	        }else{
		                	        	var td6="";		                	        		
		                	        }
		                	        if(cStatus==1){
		                	        	var td7="<td>";
		                	        	if(objectId==1){
		                	        		td7=td7+strCancel+"|";	
		                	        	}
		                	        	td7=td7+strDownload+"</td></tr>";
		                	    	}else if(cStatus==0){
		                	    		var td7="<td>"+strRemove+"|"+strDownload+"</td></tr>";
		                	    	}else{
		                	    		var td7="<td>"+strDownload+"</td></tr>";
		                	    	}
		                	       $("#DocLst").append(tr+td0+td1+td2+td3+td4+td5+td6+td7);
		                	    }
	                	    }else{
	                	    	$("#DocLst").append("<tr><td colspan=\"7\">No documents found</td></tr>");
	                	    }  
	                }
	            }); 
	        }
	        
	        
	        function removeFile(obj,cStatusDoc){
	        	var tenderId= '${tenderId}';
	        	var objectId="";
	        	 if(registerDocObjId=='7' || registerDocObjId=='6'){
	         		objectId=registerDocObjId;
	         	}else{
	         		objectId= '${objectId}';
	         	}
	            if(confirm('<spring:message code="msg_tender_cnfrm_deletedoc" />')){
	   	    	 $(".successMsg").hide();
	   	          $.post("${pageContext.servletContext.contextPath}/ajax/deletebriefcasefile", {
	   	            docId : obj,
	   	            objectId : objectId,
 	   	            cStatusDoc : cStatusDoc
	   	        },
	   	        function(j)
	   	        {
	   	            if (j == 'sessionexpired') {
	                    window.location = "${pageContext.servletContext.contextPath}/" + j;
	                } else {
		   	            if($.trim(j.toString()) == 'true')
		   	            {
		   	                $("#successDiv").show();
		   	                $('#successDiv').html('<spring:message code="msg_tender_docrejectsuccessfully" />');
		   	            }
		   	         	getDocDetails();
	                }
	   	        }); 
	             }
	       }
	        
	        
	        function cancelFile(obj,cStatusDoc){
	        	var tenderId= '${tenderId}';
           	 	var objectId= '${objectId}';
// 	            if(confirm('<spring:message code="msg_tender_cnfrm_deletedoc" />')){
	   	    	 $(".successMsg").hide();
	   	          $.post("${pageContext.servletContext.contextPath}/ajax/canceldocument", {
	   	            docId : obj,
	   	            objectId : objectId,
	   	            cStatusDoc : cStatusDoc
	   	        },
	   	        function(j)
	   	        {
	   	            if (j == 'sessionexpired') {
	                    window.location = "${pageContext.servletContext.contextPath}/" + j;
	                } else {
		   	            if($.trim(j.toString()) == 'true')
		   	            {
		   	                $("#successDiv").show();
		   	                $('#successDiv').html('<spring:message code="msg_tender_cancel_successfully" />');
		   	            }
		   	         	getDocDetails();
	                }
	   	        }); 
// 	             }
	       }
	        
	        function downloadFile(obj){
	        	var tenderId= '${tenderId}';
           	 	var objectId = '${objectId}';
	   	    	 $(".successMsg").hide();
	   	    	  $.ajax({
	   	    	 	url : "${pageContext.servletContext.contextPath}/ajax/downloadbriefcasefile/"+obj+"/"+objectId,
	   	    	    type : "GET",
	   	    	    success : function(data) {
	   	    	      if (data == "success") {
	   	    	        alert('request sent!');
	   	    	      }
	   	    	    }
	   	    	  });
	       }
        </script>

<div class="successMsg alert alert-success" id="successDiv"
	style="display: none;"></div>


<div>
	<form enctype="multipart/form-data">
		<div id="briefCaseContent"></div>
	</form>
</div>

<div id="viewUploadedFile">
	<table class="table table-striped table-responsive"
		style="margin-top: 10px;">
		<thead>
			<tr>
				<th>Sr.No.</th>
				<c:if test="${objectId eq 10}">
					<th>Mandatory document name</th>
				</c:if>
				<th>Document Name</th>
				<th>Document Brief</th>
				<th>Size</th>
				<th>Date</th>
				<c:if test="${objectId eq 1}">
					<th>Status</th>
				</c:if>
				<th>Action</th>
			</tr>
		</thead>
		<tbody id="DocLst">

		</tbody>
	</table>
</div>
