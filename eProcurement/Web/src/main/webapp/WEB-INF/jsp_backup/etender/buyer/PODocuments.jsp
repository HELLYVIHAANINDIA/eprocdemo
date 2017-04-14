<%@include file="../../includes/head.jsp"%>
<%@include file="../../includes/masterheader.jsp"%>
<spring:message code="lbl_live" var="meetingLive" />
<spring:message code="lbl_not_started" var="meetingNotStart"/>
<spring:message code="lbl_close" var="meetingOver"/>
<spring:message code="lbl_online" var="onlineMode"/>
<spring:message code="lbl_offline" var="offlineMode"/>
<spring:message code="title_tender_createcomitee" var="prebidcommittee"/>

<div class="content-wrapper">
<section class="content">
<div class="row">
<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="box">
						<div class="box-header with-border">
							<h3 class="box-title">Upload purchase document</h3>
						</div>
						<div class="box-body">
						<a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}"><< Go back to dashboard</a>
							<div class="row">
								<div class="col-lg-12 col-md-12 col-xs-12">
									<div class="box-body pad" id="prebid">
										<%@include file="./UploadDocuments.jsp"%>				               
				            		</div>
			            		</div>
          					</div>
     				</div>
 		</div>
</div>
</div>
</section>
</div>
<%@include file="../../includes/footer.jsp"%>