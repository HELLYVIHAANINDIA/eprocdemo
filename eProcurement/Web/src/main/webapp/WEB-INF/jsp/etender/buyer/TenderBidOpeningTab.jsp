<!DOCTYPE html>
<html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../../includes/header.jsp"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:message code="lbl_live" var="meetingLive" />
<spring:message code="lbl_not_started" var="meetingNotStart" />
<spring:message code="lbl_close" var="meetingOver" />
<spring:message code="lbl_online" var="onlineMode" />
<spring:message code="lbl_offline" var="offlineMode" />
<c:set var="meetingMode"
	value="${tblTender.preBidMode eq 1 ? onlineMode : offlineMode}" />
</head>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="../../includes/leftaccordion.jsp"%>

<div class="content-wrapper">
	<section class="content">
		<div class="row">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			<div class="box">
				<div class="box-header with-border">
					<h3 class="box-title">Bid Opening</h3>
				</div>
				<div class="box-body">
					<div class="row">
						<div class="col-lg-12 col-md-12 col-xs-12">
							<div class="box-body pad" id="prebid">
								<table>
									<tr>
										<td width="25%"><spring:message
												code="lbl_bid_opening_committee" /></td>
										<td>
											<%--                             <c:forEach items="${validateLinks}" var="links"> --%>
											<c:choose>
												<c:when
													test="${tenderlinkProperties.pre_bid_meeting_create eq links.linkId and links.remark eq 'Success' or true}">
													<spring:message code="link_create" var="createlink" />
													<spring:message code="link_tender_edit" var="editlink" />
													<spring:message code="link_tender_view" var="viewlink" />
													<a href="${pageContext.servletContext.contextPath}/etender/buyer/createcommittee/1/1">${createlink}</a></li>
													<a href="${pageContext.servletContext.contextPath}/etender/buyer/editcommittee/1/1/1">${editlink}</a></li>
													<a href="${pageContext.servletContext.contextPath}/etender/buyer/getviewcommitee/1/42/1">${viewlink}</a>
												</c:when>
											</c:choose> <%--                             </c:forEach> --%>
										</td>
									</tr>
								</table>
								<%-- Display prebid block only if committee is created --%>
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
