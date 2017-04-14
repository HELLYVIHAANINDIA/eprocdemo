        <script src="${pageContext.servletContext.contextPath}/resources/js/commonValidate.js" type="text/javascript"></script>
        <script src="${pageContext.servletContext.contextPath}/resources/js/ajaxfileupload.js" type="text/javascript"></script>
        <script type="text/javascript">
        	var tenderId= '${tenderId}';
   	 		var objectId= '${objectId}';
        	getBriefcaseContent(1, objectId, tenderId);
	        getDocDetails();
	         function specialTrim(str) {
	            return str.replace(/>\s+</g, '><');
	        } 
	        function getBriefcaseContent(tabId, objectId,tenderId) {
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
	                }else if(!BRIEF.test($("#txtDocDesc").val())){
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
	    	        $.ajaxFileUpload({
	    	            url:'${pageContext.servletContext.contextPath}/ajax/submitbriefcasefileupload?txtDocDesc='+$("#txtDocDesc").val()+'&txtobjectId=${objectId}&txtChildId=${childId}&txtSubChildId=${subChildId}&txtTenderId=${tenderId}&txtOtherSubChildId=${otherSubChildId}',
	    	            fileElementId:'fileToUpload',
	    	            dataType: "text",
	    	            secureuri:true,
	    	            success: function (data){
	    	            	//alert("ddddeeeee"+data);
	    	                var index=data.toString().indexOf("Error:");
	    	                 if( index < 0){
	    	                    var strRemove="&nbsp;&nbsp;<a href='#' onclick=\"removeFile('"+$.trim(data.toString())+"');\">Remove</a>";
	    	                    if($('#txtHidDocIds').val() != '')
	    	                        $('#txtHidDocIds').val($('#txtHidDocIds').val()+",");
	    	                    //$('#uploadFile').val('');
                                $('#fileToUpload').val('');
	    	                    $("#txtDocDesc").val('');
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
	        		//document.getElementById("uploadFile").value = $(obj).val();
	        	}
	        } 
	        
	        function getDocDetails(){
	        	 var tabId=$("#txtTabId").val() != undefined ? $("#txtTabId").val() : 0;
	        	 var objectId = '${objectId}';
	              $.post("${pageContext.servletContext.contextPath}/ajax/getbriefcaseuploadeddocs", {
	            	 tenderId: '${tenderId}',
	            	 objectId : '${objectId}',
	            	 childId : '${childId}',
	            	 subChildId : '${subChildId}',
	            	 otherSubChildId : '${otherSubChildId}'
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
		                	    	var strRemove="&nbsp;&nbsp;<a href='#' onclick=\"removeFile('"+obj[i]["officerDocId"]+"','"+obj[i]["cStatus"]+"');\">Remove</a>";
		                	    	var strCancel="&nbsp;&nbsp;<a href='#' onclick=\"cancelFile('"+obj[i]["officerDocId"]+"','"+obj[i]["cStatus"]+"');\"> Cancel </a>";
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
		                	    	var strDownload="&nbsp;&nbsp;<a href='${pageContext.servletContext.contextPath}/ajax/downloadbriefcasefile/"+docId+"'\" \">Download</a>";
		                	        var tr="<tr>";
		                	        var td0="<td>"+obj[i]["Sr.No"]+"</td>";
		                	        var td1="<td>"+obj[i]["fileName"]+"</td>";
		                	        var td2="<td>"+obj[i]["description"]+"</td>";
		                	        var td3="<td>"+obj[i]["fileSize"]+"</td>";
		                	        var td4="<td>"+obj[i]["createdOn"]+"</td>";
		                	        var td5="<td>"+status+"<input type='hidden' class='officerDocId' value='"+obj[i]["officerDocId"]+"'></td>"
		                	        if(cStatus==1){
		                	        	var td6="<td>";
		                	        	if(objectId==1){
		                	        		td6=td6+strCancel+"|";	
		                	        	}
		                	        	td6=td6+strDownload+"</td></tr>";
		                	    	}else if(cStatus==0){
		                	    		var td6="<td>"+strRemove+"|"+strDownload+"</td></tr>";
		                	    	}else{
		                	    		var td6="<td>"+strDownload+"</td></tr>";
		                	    	}
		                	       $("#DocLst").append(tr+td0+td1+td2+td3+td4+td5+td6); 
		                	    }
	                	    }else{
	                	    	$("#DocLst").append("<tr><td colspan=\"7\">No documents found</td></tr>");
	                	    }  
	                }
	            }); 
	        }
	        
	        
	        function removeFile(obj,cStatusDoc){
	        	var tenderId= '${tenderId}';
           	 	var objectId= '${objectId}';
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
    </head>
				
<div class="successMsg alert alert-success" id="successDiv" style="display: none;"></div>
                            <div>
                                    <form enctype="multipart/form-data">
                                            <div id="briefCaseContent">

                                             </div>                                 
                                    </form>
                            </div>

<div id="viewUploadedFile">
<table class="table table-striped table-responsive" style="margin-top:15px;">
										<thead>
												<tr>
													<th>Sr.No.</th>
													<th>Document Name</th>
													<th>Document Brief</th>
													<th>Size</th>
													<th>Date</th>
													<th>Status</th>
													<th>Action</th>
												</tr>
										</thead>
										<tbody id="DocLst">
											
										</tbody>	
									</table>
</div>
