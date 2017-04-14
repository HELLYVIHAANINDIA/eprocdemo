<%@include file="../../includes/head.jsp"%>
        <%@include file="../../includes/masterheader.jsp"%>
        
        <spring:message code="lbl_create_dept" var="createdepartment"/>
<div class="content-wrapper">
<section class="content-header">
</section>

<section class="content">
<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="box">
						<div class="box-header with-border">
	               						<h3 class="box-title">Response</h3>
						</div>
						<div class="box-body">
							<div class="box-header with-border">
								<a href="${pageContext.servletContext.contextPath}/etender/bidder/biddingTenderDashboard/${tenderId}"><< Back to tenderdashboard</a>
								</div>
							<div class="row">
							<spring:url value="/etender/bidder/responseQueryPost" var="configureDateUrl"/>
								<div class="col-lg-12 col-md-12 col-xs-12">
									<form:form action="${configureDateUrl}" onsubmit="return validate();" name="frmdepartment" method="post">
									<div class="row">
										<div class="row">
										<div class="col-lg-2">
											<div class="form_filed"><label>Response end date :</label></div>
										</div>
										<div class="col-lg-5">
											<div class="form_filed">
											<label>${responseEndDate}<label>
											</div>
													
<%-- 											<input type="text" class="form-control dateBox" name="txtResponseEndDate" datepicker="yes" id="txtResponseEndDate"   dtrequired="true" title="Opening date" value="${clarificationList[1]}" onblur="validateEmptyDt(this)" > --%>
										</div>
									</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed"><label>Query:<label></div>
										</div>
										<div class="col-lg-5">
											<div class="form_filed">
											<label>${questionAns[0]}<label>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-lg-2">
											<div class="form_filed"><label>Answer:<label></div>
										</div>
										<div class="col-lg-5">
											<div class="form_filed">
												<label>${questionAns[2]}<label>
											</div>
										</div>
									</div>
									</form:form>
									<div class="row">
										<div class="col-lg-12 col-md-12 col-xs-12">
											<a href="${pageContext.servletContext.contextPath}/etender/buyer/getDocumentList/${tenderId}/${objectId}/${childId}/${subChildId}/${otherSubChildId}" data-target="#myModal" class="myModel" data-toggle="modal">View uploaded documents</a>
<%-- 											<%@include file="../buyer/UploadDocuments.jsp"%> --%>
										</div>
										<div id="targetDiv"></div>
 				
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
        });
        
           </script>
<%@include file="../../includes/footer.jsp"%>