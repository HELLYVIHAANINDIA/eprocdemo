<%@include file="../../includes/head.jsp"%>
<%@include file="../../includes/masterheader.jsp"%>
<spring:message code="lbl_live" var="meetingLive" />
<spring:message code="lbl_not_started" var="meetingNotStart"/>
<spring:message code="lbl_close" var="meetingOver"/>
<spring:message code="lbl_online" var="onlineMode"/>
<spring:message code="lbl_offline" var="offlineMode"/>
<spring:message code="title_tender_createcomitee" var="prebidcommittee"/>


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
							<h3 class="box-title"><spring:message code="lbl_upload_mom" /></h3>
							<div><a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}"><< go back to dashboard</a></div>
							
						</div>
						<c:if test="${not empty successMsg}">
						<div class="alert alert-success"><spring:message code="${successMsg}" /></div>
						</c:if>

			<c:if test="${not empty errorMsg}">
						<div class="alert alert-danger">
							<spring:message code="${errorMsg}" />
						</div>
			</c:if>
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
            			<c:if test="${prebidstartdate lt currentDate}">
					       <div class="row">
								<div class="col-lg-12 col-md-12 col-xs-12">
									<%@include file="./UploadDocuments.jsp"%>
								</div>
							</div>
						            </c:if>
            </div>
            </div>
</div>
</div>
</section>
</div>
<%@include file="../../includes/footer.jsp"%>