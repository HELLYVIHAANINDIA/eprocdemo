<%@include file="../../includes/head.jsp"%>
<%@include file="../../includes/masterheader.jsp"%>


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
      

<div class="content-wrapper">	
	<section class="content-header">

		<h1>
                    <c:if test="${tblTender.isAuction eq 1}">Bidding Auction Dashboard</c:if>
                    <c:if test="${tblTender.isAuction eq 0}">Bidding Tender Dashboard</c:if>
                    </h1>
		 	 <c:if test="${tblTender.isAuction eq 1}"><a href="${pageContext.servletContext.contextPath}/etender/bidder/bidderTenderListing/1" class="pull-right">
                        << Go To Auction Listing</a></c:if>
                    <c:if test="${tblTender.isAuction eq 0}"><a href="${pageContext.servletContext.contextPath}/etender/bidder/bidderTenderListing/0" class="pull-right">
                        << <spring:message code="lbl_go_to_tender_listing" /></a></c:if>
                        
                        
                        <br/>
      <c:if test="${not empty successMsg}">
			<div><span class="alert alert-success"><spring:message code="${successMsg}"/></span></div>
		</c:if>
		<c:if test="${not empty errorMsg}">
			<div><span class="alert alert-danger"><spring:message code="${errorMsg}"/></span></div>
		</c:if>
	</section>
	
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
<!-- 					<div class="box-header with-border"> -->
<%-- 						<h3 class="box-title" href="#c"><spring:message code="lbl_view_summary" /></h3> --%>
<!-- 					</div> -->
					
					<div class="box-body">
						<div class="row">
							<div class="col-md-12">
										<div class="row"></div>
  		<div class="panel-heading" href="#c" style="background:lightgreen;border:1px solid #374850;">
			<spring:message code="lbl_view_summary" />
		</div>
		<div class="row" style="border-bottom: 1px solid #f4f4f4; line-height:40px;">
			<div class="col-md-2">
                            <c:if test="${tblTender.isAuction eq 0}">
								<spring:message code="fields_tenderid"/>
                            </c:if>
				 			<c:if test="${tblTender.isAuction eq 1}">
                              <spring:message code="lbl_auction_id" />
                            </c:if>
				
			</div>
			<div class="col-md-2">${tblTender.tenderId}</div>
			<div class="col-md-2">
                            <c:if test="${tblTender.isAuction eq 0}">
			<spring:message code="fields_refenceno"/>
                            </c:if>
				 <c:if test="${tblTender.isAuction eq 1}">
                                <spring:message code="lbl_auction_ref_no" />
                            </c:if>
			
			</div>
			<div class="col-md-2">
				${tblTender.tenderNo}
			</div>
		</div>
		<div class="row" style="border-bottom: 1px solid #f4f4f4; line-height:40px;">
			<div class="col-md-2">
                             <c:if test="${tblTender.isAuction eq 0}">
				<spring:message code="field_brief"/>
                            </c:if>
				 <c:if test="${tblTender.isAuction eq 1}">
                                Auction brief
                            </c:if>
				
			</div>
			<div class="col-md-10">${tblTender.tenderBrief}</div>
		</div>
		<div class="row" style="border-bottom: 1px solid #f4f4f4; line-height:40px;">
			<div class="col-md-2">
                            <c:if test="${tblTender.isAuction eq 0}">
				<spring:message code="field_tender_detail"/>
                            </c:if>
				 <c:if test="${tblTender.isAuction eq 1}">
                            <spring:message code="lbl_auction_description" />
                            </c:if>
				
			</div>
			<div class="col-md-10">${tblTender.tenderDetail}</div>
		</div>
		<div class="row">
		
                    <c:if test="${tblTender.isAuction eq 0}">
			<div class="col-md-3 pullright" style="float: right;"><a href="${pageContext.servletContext.contextPath}/etender/bidder/viewtender/${tblTender.tenderId}/0"><spring:message code="label_tender_view"/></a></div>
                            </c:if>
				 <c:if test="${tblTender.isAuction eq 1}">
                 <div class="col-md-3 pullright red" style="float: right;"><a href="${pageContext.servletContext.contextPath}/eBid/Bid/viewAuction/${tblTender.tenderId}/0"><spring:message	code="label_auction_view" /></a></div>
                            </c:if>
			
		</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="row" >
			<div class="col-md-12">
				<div class="box">
					<div class="box-header with-border">
						<div id="countdown" class="col-md-6 pullleft red"></div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="row"  style="display: none;">
			<div class="col-md-12">
				<div class="box">
					<div class="box-header with-border importantMsgDiv" data-toggle="collapse" href="#collapse9">
						<h3 class="box-title"><a><spring:message code="lbl_important_message"/></a></h3>
					</div>
					<div class="box-body">
						<div class="row">
							<div class="col-md-12">
								 <div id="collapse9" class="panel-collapse collapse importantMsg">
		
								 </div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="row">
		<div class="col-md-12">
			<div class="box">
		  		<div class="box-header with-border">
			  		<div class="col-md-3">
						<h3 class="box-title"><a><spring:message code="lbl_declaration/Consent" /></a></h3>
					</div>
					<div class="col-md-9">
						
						<c:choose>
						<c:when test="${!isRepeated}">
							<a href="${pageContext.servletContext.contextPath}/etender/bidder/biddingtenderdashboardcontent/${tblTender.tenderId}/2"><spring:message code="lbl_acc_rej"/></a>
						</c:when>
						<c:when test="${isRepeated}">
							<spring:message code="lbl_agreed" />
						</c:when>
						</c:choose>
						
					</div>
				</div>
			</div>
		</div>
		</div>
		<c:if test="${isRepeated}">
		<c:if test="${tblTender.isPreBidMeeting eq 1}">
		<div class="row">
		<div class="col-md-12">
			<div class="box">
		  		<div class="box-header with-border">
			  		<div class="col-md-3">
						<h3 class="box-title"><a><spring:message code="tab_tender_prebid" /></a></h3>
					</div>
					<div class="col-md-9">
						<a href="${pageContext.servletContext.contextPath}/etender/bidder/biddingtenderdashboardcontent/${tblTender.tenderId}/8"><spring:message code="lbl_view_minutes_of_meetings" /></a>
					</div>
				</div>
			</div>
		</div>
		</div>
		</c:if>
		
		<div class="row">
		<div class="col-md-12">
			<div class="box">
		  		<div class="box-header with-border">
			  		<div class="col-md-3"><h3 class="box-title"><a><spring:message code="lbl_prepare_bid" /></a></h3></div>
					<div class="col-md-9">
						<c:if test='${tblTender.isAuction eq 0}'>
	                       	<a href="${pageContext.servletContext.contextPath}/etender/bidder/biddingtenderdashboardcontent/${tblTender.tenderId}/5"><spring:message code="lbl_fill_form" /></a>
	    				</c:if>
                         <c:if test='${tblTender.isAuction eq 1}'>
                             <c:if test="${isRepeated}">
                                 <c:if test="${bid eq 0}">
                                     <a href="${pageContext.servletContext.contextPath}/eBid/Bid/viewFormForEdit/${tblTender.tenderId}/${formId}"><spring:message code="lbl_bidding_hall" /></a>
                                 </c:if>
                                 <c:if test="${bid ne 0}">
                                      <a href="${pageContext.servletContext.contextPath}/eBid/Bid/viewForm/${tblTender.tenderId}/${formId}/${bid}/false"><spring:message code="lbl_bidding_hall" /></a>
                                 </c:if>
                             </c:if>
                                 <c:if test="${!isRepeated}">
                                    <spring:message code="lbl_not_agreed_terms_and_conditions" />
                                 </c:if>
                         </c:if>
					</div>
				</div>
			</div>
		</div>
		</div>
	
	<c:if test='${tblTender.isAuction eq 0}'>
	<div class="row">
		<div class="col-md-12">
			<div class="box">
		  		<div class="box-header with-border">
		        	<div class="col-md-3"><h3 class="box-title"><a><spring:message code="lbl_final_submission" /></a></h3></div>
					<div class="col-md-9">
						<a href="${pageContext.servletContext.contextPath}/etender/bidder/biddingtenderdashboardcontent/${tblTender.tenderId}/6"><spring:message code="lbl_final_submission" /></a>
					</div>
				</div>
			</div>
		</div>
	</div>
	</c:if>
		
	<div class="row">
		<div class="col-md-12">
			<div class="box">
		  		<div class="box-header with-border">
					<div class="col-md-3"><h3 class="box-title"><a>Result</a></h3></div>
					<div class="col-md-9">
						<a href="${pageContext.servletContext.contextPath}/etender/bidder/biddingtenderdashboardcontent/${tblTender.tenderId}/7">View</a>
					</div>
				</div>
			</div>
		</div>
	  </div>
	 </c:if>
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
var endDate;
       endDate = '${submissionEndDate}';
       
    var find = '-';
   	var re = new RegExp(find, 'g');
   	endDate = endDate.replace(re, '/');
   	endDate = new Date(endDate);
	var timeOverMsg = 'Bidding time is over.';
	var msgAppended = 'Remaining bidding time :';
	var submissionDateOver = '${submissionDateOver}';
        
	if(submissionDateOver == 'true'){
           
		showRemaining(endDate,msgAppended,timeOverMsg);
	}else{
           
		timer = setInterval(function(){
		showRemaining(endDate,msgAppended,timeOverMsg)}, 1000);
	}
});

</script>
<style type="text/css">
.pullright{
	float: right;
}
.pullleft{
	float: left;
}
</style>
 <style>
       .customCls{
       	background:gainsboro;border:1px solid #374850;
       	width:94%
       }
       
       </style>
<%@include file="../../includes/footer.jsp"%>
