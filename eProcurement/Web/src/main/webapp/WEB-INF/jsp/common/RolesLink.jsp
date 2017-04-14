<%@include file="./../includes/head.jsp"%>
     <%@include file="./../includes/masterheader.jsp"%>
        <spring:message code="lbl_add_link_to_role" var="lbl_add_link_to_role" />
       
<div class="content-wrapper">      

<section class="content-header">
<h1>Administration</h1>			
</section>

<section class="content">
<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="box">
					
					<div class="box-header with-border">
						<h3 class="box-title">${lbl_add_link_to_role}</h3>
					</div>
					
					<div class="box-body">
					
						<div class="row">
						
							<div class="col-lg-6">
							
								<div class="fr-grp">
									<label class="lblfr-fields">Select Role :</label>
									<select class="form-control fr-cntrl" id="selSearchOpt">
									<option value="1">Creator</option>
									<option value="2">Approver</option>
									<option value="3">Opener</option>
									<option value="4">Evalutor</option>
									<option value="6">Admin</option>
								</select>
								</div>
								
								<div class="fr-grp">
								<button class="btn btn-submit" type="button" onclick="{javascript:getallLinks();}" >Submit</button>
								</div>
								
							</div>
							
							
						</div>
																
						<div class="row">
							<form:form action="${pageContext.servletContext.contextPath}/common/user/addlinkstorole" modelAttribute="tblLinksRolesDataBean" method="POST" >
							<div class="col-md-12">
								<div id="searchResult">
								</div>
							</div>
							<input type="hidden" name="hdRoleId" value="0" id="hdRoleId"/>
							</form:form>
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
        var VALIDATE_MSG_ALLOW_MAX='Allows Max. ';
        var VALIDATE_MSG_TENDERBRIEF='characters';
        function checkSubchild(cThis){
           	if($(cThis).is(":checked")){
           		$(cThis).closest("table").find(":checkbox").prop("checked",true);
           	}else{
           		$(cThis).closest("table").find(":checkbox").prop("checked",false);
           	}
        }
        function validate(){
            	var vbool = valOnSubmit();
            	if($("#linkError").html()!=""){
            		vbool=false;
            	}
            	return disableBtn(vbool);
            }
            function getallLinks() {
            	blockUI();
                var SearchOpt = $("#selSearchOpt option:selected").val();
                $("#hdRoleId").val(SearchOpt);
                var searchResult;
            	var data = { 'txtSearchOpt' : SearchOpt};
            	$.ajax({
            		type : "POST",
            		url : "${pageContext.servletContext.contextPath}/common/user/searchlinksbyrole",
            		data : data,
            		timeout : 100000,
            		success : function(data) {
            			searchResult=data;
                        if (searchResult == 'sessionexpired') {
                            window.location = "${pageContext.servletContext.contextPath}/" + searchResult;
                        } else {
                            $("#searchResult").html(searchResult);
                        }
                        var dynheight = $("#searchResult").height()+350;
                        $('#content-wrapper').css("min-height",dynheight+"px");
                        unBlockUI()
            		},
            		error : function(e) {
            			console.log("ERROR: ", e);
            			unBlockUI()
            		},
            	});
            }
           </script>

<%@include file="./../includes/footer.jsp"%>