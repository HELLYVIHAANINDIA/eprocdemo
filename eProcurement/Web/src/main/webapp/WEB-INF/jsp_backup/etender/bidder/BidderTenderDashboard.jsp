<!DOCTYPE html>
<html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../../includes/header.jsp"%>
<style type="text/css">
.pullright{
	float: right;
}
.pullleft{
	float: left;
}
</style>
<spring:message code="link_create" var="createlink" />
<spring:message code="link_tender_edit" var="editlink" />
<spring:message code="link_tender_view" var="viewlink" />
<spring:message code="link_tender_publish" var="publishlink" />   
<spring:message code="link_tender_processinwf" var="processworkflowlink"/>
<spring:message code="link_tender_configurewf_for_bid_opening" var="link_tender_configurewf_for_bid_opening"/>
<spring:message code="link_tender_viewapprhist_for_bid_opening" var="link_tender_viewapprhist_for_bid_opening"/>
<spring:message code="link_tender_callbackwf" var="processworkflowcallbacklink"/>
<spring:message code="var_prepare" var="preparelink"/>
<!-- corrigendum  -->
<spring:message code="link_delete_corrigendum" var="deletelink"/>
<spring:message code="lbl_tender_upload" var="uploadlink"/>
<spring:message code="link_edit_corrigendum" var="editcorrigendumlink"/>
<!-- Bidding Form -->
<spring:message code = "link_tender_prepnewform"               var = "var_link_prepnewform"/>
<spring:message code = "title_heading_tender_envelope_publish" var = "var_link_publishform"/>
<spring:message code = "title_tender_formlibrary"              var = "var_link_formlibrary"/>
<spring:message code = "title_tender_master_formlibrary"       var = "var_link_master_formlibrary"/>
<spring:message code = "link_add_gov_column"                   var = "var_link_addgovcolumn"/>
<spring:message code = "link_edit_gov_column"                  var = "var_link_editgovcolumn"/>
<spring:message code = "title_view_gov_col"                    var = "var_link_viewgovcolumn"/>
<spring:message code = "title_upload_documents"                var = "var_link_uploaddoc"/>
<spring:message code = "link_tender_createrebate_report"        var = "var_link_createrebate"/>
<spring:message code = "link_tender_editrebate_report"          var = "var_link_editrebate"/>
<spring:message code = "link_tender_viewrebate_report"          var = "var_viewrebate"/>
<spring:message code = "link_tender_deleterebate_report"        var = "var_deleterebate"/>
<spring:message code = "link_tender_create_pricesummary_report" var = "var_link_createPriceSummary"/>
<spring:message code = "link_tender_editpricesummary_report"    var = "var_link_editPriceSummary"/>
<spring:message code = "link_tender_viewpricesummary_report"    var = "var_viewPriceSummary"/>
<spring:message code = "link_tender_deletepricesummary_report"  var = "var_deletePriceSummary"/>
<spring:message code = "link_orginizeform"      var = "link_orginizeform" />
<spring:message code = "link_view"              var = "link_view" />                        
       <style>
       .customCls {
    background: #f0f0f0;
    border: 1px solid #b1c2ca;
    width: 100%;
}
       
</style>
</head>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="../../includes/leftaccordion.jsp"%>
      
	<div class="content-wrapper">
	
	<section class="content-header">

			<c:if test="${not empty successMsg}">				
				<span class="alert alert-success">
					<spring:message code="${successMsg}" />
				</span>			
			</c:if>
			
			<c:if test="${not empty errorMsg}">
				<span class="alert alert-danger">
					<spring:message code="${errorMsg}"/>
				</span>
			</c:if>

  			<h1 href="#c">
				View summary
			</h1>
	</section>
	
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<div class="box-body">
						<div class="row">
							<div class="col-md-3">
								<div class="vt"><spring:message code="fields_tenderid"/></div>
							</div>
							<div class="col-md-3"><div class="vt">${tblTender.tenderId}</div></div>
							<div class="col-md-3">
								<div class="vt"><spring:message code="fields_refenceno"/></div>
							</div>
							<div class="col-md-3">
								<div class="vt">${tblTender.tenderNo}</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-3">
								<div class="vt"><spring:message code="field_brief"/></div>
							</div>
							<div class="col-md-9"><div class="vt">${tblTender.tenderBrief}</div></div>
						</div>
						<div class="row">
							<div class="col-md-3">
								<div class="vt"><spring:message code="field_tender_detail"/></div>
							</div>
							<div class="col-md-6">
							<div class="vt">${tblTender.tenderDetail}</div>
							</div>
							<div class="col-md-3">
								<a href="${pageContext.servletContext.contextPath}/etender/bidder/viewtender/${tblTender.tenderId}">
									<spring:message code="label_view"/>
								</a>
							</div>
						</div>
						
						<div class="row">
						
								<div class="col-md-12 pn">
									<div class="panel-heading customCls importantMsgDiv"
										data-toggle="collapse" href="#collapse9"
										style="display: none;">
										<h4 class="panel-title">
											<a><spring:message code="lbl_important_message" /> </a>
										</h4>
									</div>
									<div id="collapse9" class="panel-collapse collapse importantMsg pnl">
									</div>
								</div>

								<div class="col-md-12 pn">
									<div class="panel-heading customCls" data-toggle="collapse"
										href="#collapse1">
										<h4 class="panel-title">
											<a>Declaration</a>
										</h4>
									</div>
									<div id="collapse1" class="panel-collapse pnl">
										<div class="row">
											<div class="col-md-3">Tems & Condition</div>
											<div class="col-md-9">
												<a href="${pageContext.servletContext.contextPath}/etender/bidder/biddingtenderdashboardcontent/${tblTender.tenderId}/2">
													<c:choose>
														<c:when test="${!isRepeated}">
															<spring:message code="lbl_acc_rej" />
														</c:when>
														<c:when test="${isRepeated}">
															View
														</c:when>
													</c:choose>
												</a>
											</div>
										</div>
									</div>
								</div>

								<c:if test="${tblTender.isPreBidMeeting eq 1}">
									<div class="col-md-12 pn">
										<div class="panel-heading customCls" data-toggle="collapse"
											href="#collapse1">
											<h4 class="panel-title">
												<a>Prebid</a>
											</h4>
										</div>
										<div id="collapse1" class="panel-collapse pnl">
											<div class="row">
												<div class="col-md-3">Prebid</div>
												<div class="col-md-9">
													<a href="${pageContext.servletContext.contextPath}/etender/bidder/biddingtenderdashboardcontent/${tblTender.tenderId}/8">View
														minutes of meetings</a>
												</div>
											</div>
										</div>
									</div>
								</c:if>

								<div class="col-md-12 pn">
									<div class="panel-heading customCls" data-toggle="collapse"
										href="#collapse3">
										<h4 class="panel-title">
											<a>Prepare Bid</a>
										</h4>
									</div>
									<div id="collapse3" class="panel-collapse pnl">
										<div class="row">
											<div class="col-md-3">
												<spring:message code="field_notice" />
											</div>
											<div class="col-md-9">
												<c:if test='${tblTender.isAuction eq 0}'>
													<a
														href="${pageContext.servletContext.contextPath}/etender/bidder/biddingtenderdashboardcontent/${tblTender.tenderId}/5">Fill
														Form</a>
												</c:if>
												<c:if test='${tblTender.isAuction eq 1}'>
													<a
														href="${pageContext.servletContext.contextPath}/etender/bidder/biddingtenderdashboardcontent/${tblTender.tenderId}/5">Bidding
														Hall</a>


												</c:if>
											</div>
										</div>
									</div>
								</div>

								<div class="col-md-12 pn">
									<div class="panel-heading customCls" data-toggle="collapse"
										href="#collapse4">
										<h4 class="panel-title">
											<a>Final Submission</a>
										</h4>
									</div>
									<div id="collapse4" class="panel-collapse pnl">
										<div class="row">
											<div class="col-md-3">
												<spring:message code="field_notice" />
											</div>
											<div class="col-md-9">
												<a href="${pageContext.servletContext.contextPath}/etender/bidder/biddingtenderdashboardcontent/${tblTender.tenderId}/6">Final
													Submission</a>
											</div>
										</div>
									</div>
								</div>

								<div class="col-md-12 pn">
									<div class="panel-heading customCls" data-toggle="collapse"
										href="#collapse5">
										<h4 class="panel-title">
											<a>Result</a>
										</h4>
									</div>
									<div id="collapse5" class="panel-collapse pnl">
										<div class="row">
											<div class="col-md-3">
												<spring:message code="field_notice" />
											</div>
											<div class="col-md-9">
												<a href="${pageContext.servletContext.contextPath}/etender/bidder/biddingtenderdashboardcontent/${tblTender.tenderId}/7">Result</a>
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

<script type="text/javascript">
$(document).ready(function(){
	$.ajax({
		type : "GET",
		url : "${pageContext.servletContext.contextPath}/common/viewMarquee/${tblTender.tenderId}",
		success : function(data) {
			if(data != ""){
				$(".importantMsg").html(data);
				$("#importantMsgDiv").show();
			}else{
				$("#importantMsgDiv").hide();
			}
		},
		error : function(e) {
			$("#importantMsgDiv").hide();
		},
	});
});
</script>

<%@include file="../../includes/footer.jsp"%>
</div>
</body>
</html>