<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <%@include file="../../includes/header.jsp"%>
        <%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
        <script src="${pageContext.servletContext.contextPath}/resources/js/commonValidate.js" type="text/javascript"></script>        
        <spring:message code="title_tender_createcomitee" var="titlecommittee"/>
        <spring:message code="lbl_view_prebid_committee" var="lblviewprebidcommittee"/>
        <spring:message code="lbl_view_opening_committee" var="lblviewopeningcommittee"/>
        <spring:message code="lbl_view_evaluation_committee" var="lblviewevaluationcommittee"/>
        <title>${titlecommittee}</title>    
        <script type="text/javascript">
//             function validate() {
//                 var vbool = true;
//                 if($("#MultipleUser tr:last").index() == 0) {
//                     jAlert('<spring:message code="msg_committee_add"/>');
//                     vbool = false;
//                 }
//                 return disableBtn(vbool);
//             }
            $(document).ready(function() {
                        var name = $('#userName').val();
                        $.post('${pageContext.servletContext.contextPath}/etender/buyer/officers', {
                        }, function(responseText) {
                                $('#ajaxGetUserServletResponse').text(responseText);
                        });
        	});
            function removeRow(id)
            {
                $('#'+id).remove();
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
            	} else {
            		alert('this record already exists');
            	}
            });
            
           </script>
</head>

<body>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="../../includes/leftaccordion.jsp"%>
                   
<div class="content-wrapper">

<section class="content-header">
			<c:choose>
				<c:when test="${committeeType eq 1}">
					<h1>${lblviewopeningcommittee}</h1>	
				</c:when>
				<c:when test="${committeeType eq 3}">
					<h1>${lblviewprebidcommittee}</h1>	
				</c:when>
				<c:otherwise>
					<h1>${lblviewevaluationcommittee}</h1>
				</c:otherwise>
			</c:choose>
</section>

<section class="content">
<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="box">
						
						<div class="box-header with-border">
							
							<c:choose>
								<c:when test="${committeeType eq 1}">
									<h3 class="box-title">${lblviewopeningcommittee}</h3>
								</c:when>
								<c:when test="${committeeType eq 3}">
									<h3 class="box-title">${lblviewprebidcommittee}</h3>
								</c:when>
								<c:otherwise>
									<h3 class="box-title">${lblviewevaluationcommittee}</h3>
								</c:otherwise>
							</c:choose>
							
							<a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}" class="btn btn-submit pull-right" style="margin-top:0px;"><< Go To Tender Dashboard</a>
							
						</div>
						<div class="box-body">
							<div class="row">
								<div class="col-lg-12 col-md-12 col-xs-12">
					<div class="box-body">
							<div class="row">
								<div class="col-lg-12 col-md-12 col-xs-12">
								<spring:url value="/etender/buyer/submitprebidcomittee" var="submitcommittee"/> 
                                    <form:form action="${submitcommittee}" name="frmprebidcomittee" method="post" >
									<table class="table table-striped table-responsive">
										<thead>
										<c:choose>
											<c:when test="${committeeType eq 3}">
												<tr>
													<th>Name</th>
													<th>EmailId</th>
													<th>Department</th>
													<th>Designation</th>
													
												</tr>
											</c:when>
											<c:otherwise>
												<tr>
												<th>Officer</th>
												<c:forEach items="${envList}" var="envList">	
													<th>${envList[1]}</th>	
												</c:forEach>
											</tr>
											</c:otherwise>
											</c:choose>
										</thead>
										<tbody id="officerLstTbl">
											<input type="hidden" name="operType" value="Edit"/>	
											<c:choose>
												<c:when test="${committeeType eq 3}">
													<c:forEach items="${committeeDetails}" var="officerDtl">
    												<tr>
	        											<td><c:out value="${officerDtl[0]}"/></td>
	        											<td><c:out value="${officerDtl[1]}"/></td>
	        											<td><c:out value="${officerDtl[3]}"/></td>
	        											<td><c:out value="${officerDtl[4]}"/></td>
    												</tr>
													</c:forEach>
												</c:when>
												<c:when test="${committeeType eq 1}">
													<c:forEach items="${committeeDetails}" var="committeeUserData" varStatus="index">
				               							<c:set var="var_officer_name" value="${committeeUserData[0]}"  />
				               							<c:set var="var_desg_name" value="${committeeUserData[4]}" />
				               							<c:set var="var_dept_name" value="${committeeUserData[3]}" />
				               							<c:set var="var_officer_id" value="${committeeUserData[2]}" />
				               							<c:set var="var_tempofficer_id" value="${var_officer_id}" />
				               							<c:set var="var_enc_officer_id" value="${var_officer_id}" />
				               							<c:set var="var_user_loginId" value="${committeeUserData[1]}" />
				               							<tr id="${committeeUserData[2]}">
				               								<td class="v-a-middle">${var_officer_name}<br />${var_desg_name}, ${var_dept_name}<br/>${var_user_loginId}
				               								<c:set var="tempEnvIds" value="" />
				               								<c:forEach items="${envList}" var="envList" varStatus="envListStatus">
				               								<c:set var="key" value="${var_officer_id}_${envList[2]}" />
				               								<td>
																	<c:choose>
				               											<c:when test="${userEnvlopMap[key] eq true}">Yes</c:when>
				               											<c:otherwise>-</c:otherwise>
				               										</c:choose>
				               										</td>								               										
				               								</c:forEach>
				               								
				               								</td>
				               								</tr>
	               									</c:forEach>		
												</c:when>
												<c:otherwise>
													<c:forEach items="${committeeDetails}" var="committeeUserData" varStatus="index">
				               							<c:set var="var_officer_name" value="${committeeUserData[0]}"  />
				               							<c:set var="var_desg_name" value="${committeeUserData[4]}" />
				               							<c:set var="var_dept_name" value="${committeeUserData[3]}" />
				               							<c:set var="var_officer_id" value="${committeeUserData[2]}" />
				               							<c:set var="var_tempofficer_id" value="${var_officer_id}" />
				               							<c:set var="var_enc_officer_id" value="${var_officer_id}" />
				               							<c:set var="var_user_loginId" value="${committeeUserData[1]}" />
				               							<tr id="${committeeUserData[2]}">
				               								<td class="v-a-middle">${var_officer_name}<br />${var_desg_name}, ${var_dept_name}<br/>${var_user_loginId}
				               								<c:set var="tempEnvIds" value="" />
				               								<c:forEach items="${envList}" var="envList" varStatus="envListStatus">
				               									<c:set var="key" value="${var_officer_id}_${envList[2]}" />	
				               									<td>
				               										<c:choose>
				               											<c:when test="${userEnvlopMap[key] eq true}">Yes</c:when>
				               											<c:otherwise>-</c:otherwise>
				               										</c:choose>
				               									</td>
				               								</c:forEach>
				               								</td>
				               								</tr>
	               									</c:forEach>
												</c:otherwise>
											</c:choose>
										</tbody>	
									</table>
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

</div>  

</body>
    
</html>