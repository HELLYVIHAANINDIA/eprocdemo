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
	               						<h3 class="box-title">View Response</h3>
						</div>
						<div class="box-body">
						<a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}"><< Go To Tender Dashboard</a>
							<div class="row">
							<spring:url value="/etender/buyer/postQuery" var="configureDateUrl"/>
								<div class="col-lg-12 col-md-12 col-xs-12">
									<div class="row">
										<div class="row">
										<div class="col-lg-2">
											<div class="form_filed"><label>Response end date : </label></div>
										</div>
										<div class="col-lg-5">
												<div class="form_filed"><label>${responseEndDate}</label></div>
<%-- 											<input type="text" class="form-control dateBox" name="txtResponseEndDate" datepicker="yes" id="txtResponseEndDate"   dtrequired="true" title="Opening date" value="${clarificationList[1]}" onblur="validateEmptyDt(this)" > --%>
										</div>
									</div>
									</div>
							<div class="row">
								<div class="col-lg-12 col-md-12 col-xs-12">
								<spring:url value="/etender/buyer/submitprebidcomittee" var="submitcommittee"/> 
                                    <form:form action="${submitcommittee}" name="frmprebidcomittee" method="post" onsubmit="return validate();" >
									<table class="table table-striped table-responsive">
										<thead>
											<tr>
												<th>Sr No.</th>
												<th>Question</th>
												<th>Question posted date</th>
												<th>Question documents</th>
<!--added this th to resolve UI issue -->				<th></th> 
												<th>Answer</th>
												<th>Answer posted date</th>
												<th>Answer documents</th>
											</tr>
										</thead>
										<tbody>
											<input type="hidden" name="operType" value="Edit"/>	
											<c:forEach items="${tblQuestionAnswersLst}" var="tblQuestionAnswers" varStatus="cnt">
    										<tr>
    												<td>${cnt.index+1}</td>
        											<td><c:out value="${tblQuestionAnswers.question}"/></td>
        											<c:set var="queDate" value="queId_${tblQuestionAnswers.questionId}" />
        											<c:set var="ansDate" value="ansId_${tblQuestionAnswers.questionId}" />
        											<td><c:out value="${questionDates[queDate]}"/></td>
        											<td><a href="${pageContext.servletContext.contextPath}/etender/buyer/getDocumentList/${tenderId}/${objectId}/${childId}/${subChildId}/${tblQuestionAnswers.questionId}" data-target="#myModal" class="myModel" data-toggle="modal">View uploaded documents</a><td>
        											<td><c:out value="${tblQuestionAnswers.answer}"/></td>
        											<td><c:out value="${answerDates[ansDate]}"/></td>
        											<td><a href="${pageContext.servletContext.contextPath}/etender/buyer/getDocumentList/${tenderId}/${objectIdBidderSide}/${childId}/${subChildId}/${tblQuestionAnswers.questionId}/2" data-target="#myModal" class="myModel" data-toggle="modal">View uploaded documents</a><td>
    										</tr>
											</c:forEach>
										</tbody>
									</table>
									</form:form>
									<div id="targetDiv"></div>
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