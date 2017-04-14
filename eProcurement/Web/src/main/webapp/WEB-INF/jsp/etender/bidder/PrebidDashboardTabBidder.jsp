<%@include file="../../includes/head.jsp"%>
<%@include file="../../includes/masterheader.jsp"%>
<spring:message code="lbl_live" var="meetingLive" />
<spring:message code="lbl_not_started" var="meetingNotStart"/>
<spring:message code="lbl_close" var="meetingOver"/>
<spring:message code="lbl_online" var="onlineMode"/>
<spring:message code="lbl_offline" var="offlineMode"/>
<c:choose>
    <c:when test="${preBidObj[0][6] eq 0}">
        <c:set var="meetingStatus">
            <spring:message code="col_open_pending" />
        </c:set>
    </c:when>
    <c:otherwise>
            <c:set var="meetingStatus" value="${meetingNotStart}" />
            <c:choose>
                <c:when test="${currentDate ge prebidDtls[2] and currentDate le prebidDtls[3]}">
                    <c:set var="meetingStatus" value="${meetingLive}"/>
                </c:when>
                <c:when test="${prebidDtls[3] lt currentDate}">
                    <c:set var="meetingStatus" value="${meetingOver}"/>
                </c:when>
            </c:choose>
    </c:otherwise>
</c:choose>
<c:set var="meetingMode" value="${prebidDtls[1] eq 1 ? onlineMode : offlineMode}" />
<div class="content-wrapper">
<section class="content">
<div class="row">
<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">

					<div class="box">

						<div class="box-header with-border">
							<h3 class="box-title"><spring:message code="lbl_view_upload_mom" /></h3>
							<a href="${pageContext.servletContext.contextPath}/etender/bidder/biddingTenderDashboard/${tenderId}"  class="goBack pull-right"><< <spring:message code="lbl_back_dashboard"/></a>
						</div>
					
						<div class="box-body">
							<div class="row">

								<div class="col-lg-12 col-md-12 col-xs-12">
									<div class="box-body pad" id="prebid">
									<br><br>
						            <%-- Display prebid block only if committee is created --%>
						            <c:if test="${isCommitteeCreated}">
						                <table class="table table-striped table-responsive">
						                    <thead>
												<tr>
						                        <th width="18%"> <spring:message code="lbl_prebidmeeting_mode" /> </th>
						                        <th width="19%"> <spring:message code="lbl_prebidstartdate" /> </th>
						                        <th width="18%"> <spring:message code="lbl_prebidenddate" /> </th>
						                        <th width="5%"> <spring:message code="lbl_status" /> </th>
						                    </tr>
						                    </thead>
						                    <tbody>
						                    <tr>
						                        <td class="a-center"><spring:message  text="${meetingMode}" /></td>
						                        <td class="a-center">${prebidstartdate}</td>
						                        <td class="a-center">${prebidenddate}</td>
						                        <td class="a-center"><spring:message text="${meetingStatus}" /></td>
						                    </tr>
						                    </tbody>
						                </table>
						            </c:if> 
						                <%-- Display uploaded doc details only once meeting is over --%>
					                
            </div>
            </div>
            </div>
            			<c:if test="${prebidDtls[3] lt currentDate}">
					       <div class="row">
								<div class="col-lg-12 col-md-12 col-xs-12" id="docList">
									
								</div>
							</div>
						            </c:if>
            </div>
            </div>
</div>
</div>
</section>
</div>

<script type="text/javascript">

function getDocuments() {
    var tenderId = '${tenderId}';
    var objectId = '${objectId}';
    var childId = '${childId}';
    var subChildId = '${subChildId}';
    var otherSubChildId = '${otherSubChildId}';
    var searchResult;
	$.ajax({
		type : "GET",
		url : "${pageContext.servletContext.contextPath}/etender/buyer/getDocumentList/"+tenderId+"/"+objectId+"/"+childId+"/"+subChildId+"/"+otherSubChildId,
		timeout : 100000,
		success : function(data) {
			console.log("SUCCESS: ", data);
			searchResult=data;
            if (searchResult == 'sessionexpired') {
                window.location = "${pageContext.servletContext.contextPath}/" + searchResult;
            } else {
                $("#docList").html(searchResult);
            }
		},
		error : function(e) {
			console.log("ERROR: ", e);
		},
	});
}
</script>
<script type="text/javascript">
getDocuments();
</script>
<%@include file="../../includes/footer.jsp"%>