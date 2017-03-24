<!DOCTYPE html>
<html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<%@include file="../../includes/header.jsp"%>

<style type="text/css">
.pullright{
	float: right;
}
.pullleft{
	float: left;
}
</style>

<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/resources/css/jquery-ui.min.css">
<spring:message code="link_create" var="createlink" />
<spring:message code="link_tender_edit" var="editlink" />
<spring:message code="workflow_pending" var="workflow_pending" />
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
<spring:message code = "link_tender_delete"        var = "link_tender_delete"/>
<spring:message code = "link_tender_deleterebate_report"        var = "var_deleterebate"/>
<spring:message code = "link_tender_create_pricesummary_report" var = "var_link_createPriceSummary"/>
<spring:message code = "link_tender_editpricesummary_report"    var = "var_link_editPriceSummary"/>
<spring:message code = "link_tender_viewpricesummary_report"    var = "var_viewPriceSummary"/>
<spring:message code = "link_tender_deletepricesummary_report"  var = "var_deletePriceSummary"/>
<spring:message code = "link_orginizeform"      var = "link_orginizeform" />
<spring:message code = "link_view"              var = "link_view" />
<spring:message code = "lbl_upload_mom"              var = "var_lbl_upload_mom" />
<spring:message code = "lbl_publish_mom"              var = "var_lbl_publish_mom" />
<spring:message code="lbl_view_doc" var="lbl_view_doc"/>
<spring:message	code="label_publish" var="label_publish"/>
 

<style>
.customCls{
background:#f0f0f0;
border:1px solid #b1c2ca;
width:100%
}
       
</style>

<spring:message  code="title_upload_documents" var="title_upload_documents"/>

</head>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="../../includes/leftaccordion.jsp"%>

<div class="content-wrapper" style="min-height: auto;">

    <c:if test="${not empty successMsg}">
    	<c:choose>
    		<c:when test="${fn:contains(successMsg, '_')}">
    			<div class="alert alert-success"><spring:message code="${successMsg}"/></div>
    		</c:when>
    		<c:otherwise>
    			<div class="alert alert-success">${successMsg}</div>
    		</c:otherwise>
    	</c:choose>
	</c:if>
	
	<c:if test="${not empty errorMsg}">
	    <c:choose>
    		<c:when test="${fn:contains(errorMsg, '_')}">
    			<div class="alert alert-danger"><spring:message code="${errorMsg}"/></div>
    		</c:when>
    		<c:otherwise>
    			<div class="alert alert-danger">${errorMsg}</div>
    		</c:otherwise>
    	</c:choose>
	</c:if>
	
<c:if test="${isAuction eq 0}">            

<section class="content-header">
<h1 class="pull-left">RFX</h1>
<a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderListing" class="btn btn-submit pull-right" style="margin-top:0px;"><< <spring:message code="lbl_back_tenderlist"/></a>
</section>

<section class="content">

<div class="row">
	<%@include file="TenderSummary.jsp"%>
</div>

<div class="row">
<div class="col-md-12">
<div class="box">
<div class="box-header with-border">
<h3 class="box-title">Notice & Document</h3>
</div>
<div class="box-body">

<div id="collapse1" class="panel-collapse">
				<div class="row">
					<div class="col-md-3"><div class="vt"><spring:message code="field_notice"/></div></div>
					<div class="col-md-9">
						<c:choose>
							<c:when test="${tblTender.cstatus eq '0'}">
								<c:if test="${(empty corrigendumWorkflowList && isTenderWorkflowStarted ne true) or (workflowToInitiator eq true)}">
								<a href="${pageContext.servletContext.contextPath}/etender/buyer/createevent/${tblTender.tenderId}" class="tnd_bttn"><spring:message	code="label_edit" /> </a>
								</c:if> 
								<c:choose>
									<c:when test="${tblTender.isWorkflowRequired eq 1 && workflowDone eq true}">
										<a href="${pageContext.servletContext.contextPath}/etender/buyer/publishtender/${tblTender.tenderId}" onclick="return validatePublishTender(${tblTender.tenderId})" class="tnd_bttn">${label_publish}</a>
									</c:when>
									<c:when test="${tblTender.isWorkflowRequired eq 0}">
										<a href="${pageContext.servletContext.contextPath}/etender/buyer/publishtender/${tblTender.tenderId}" onclick="return validatePublishTender(${tblTender.tenderId})" class="tnd_bttn">${label_publish}</a>
									</c:when>
								</c:choose>
							  <a href="${pageContext.servletContext.contextPath}/etender/buyer/viewtender/${tblTender.tenderId}/0" class="tnd_bttn"><spring:message	code="label_view" /></a>
							  <a href="${pageContext.servletContext.contextPath}/etender/buyer/deleteTender/${tenderId}" onclick="return confirm('<spring:message code="msg_tender_delete_confirm"/>')" class="tnd_bttn"><spring:message code="link_tender_delete"/></a>
							</c:when>
							<c:otherwise>
								<a	href="${pageContext.servletContext.contextPath}/etender/buyer/viewtender/${tblTender.tenderId}/0" class="tnd_bttn"><spring:message	code="label_view" /></a>
								<a href="${pageContext.servletContext.contextPath}/common/addEditMarquee/${tenderId}" class="tnd_bttn"><spring:message code="lbl_add_edit_biddermsg"/></a>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="row">
					<c:if test="${tblTender.tenderMode eq 2 or tblTender.tenderMode eq 3}">
						<div class="col-md-3"><div class="vt"><spring:message code="field_bidder"/></div>
						</div>
						<div class="col-md-9">
						<a href="${pageContext.servletContext.contextPath}/etender/buyer/biddermapping/${tblTender.tenderId}" class="tnd_bttn"><spring:message code="lbl_mapbidder"/> </a>
						<a href="${pageContext.servletContext.contextPath}/etender/buyer/viewmappedbidders/${tblTender.tenderId}" class="tnd_bttn"><spring:message code="title_heading_tender_viewmappedbidder"/> </a>
					</div>
					</c:if>
				</div>
				<div class="row">
					<div class="col-md-3"><div class="vt"><spring:message code="field_documents"/></div>
					</div>
					<div class="col-md-9">
					<c:choose>
					<c:when test="${(empty corrigendumWorkflowList && isTenderWorkflowStarted ne true) or (workflowToInitiator eq true)}">
						<a href="${pageContext.servletContext.contextPath}/etender/buyer/tendernitdocument/${tblTender.tenderId}/0" class="tnd_bttn">${title_upload_documents}</a>
					</c:when>
					<c:when test="${documentEndDateOver ne true}">
						<a href="${pageContext.servletContext.contextPath}/etender/buyer/getDocumentList/${tenderNITObjectId}/${tblTender.tenderId}/${tblTender.tenderId}/0/0" class="tnd_bttn" data-target="#myModal" class="myModel" data-toggle="modal">${lbl_view_doc}</a>
					</c:when>
					</c:choose>
					</div>
				</div>
				<c:if test="${tblTender.cstatus eq 0 && empty corrigendumWorkflowList && isTenderWorkflowStarted ne true  or (workflowToInitiator eq true)}">
				<div class="row">
					<div class="col-md-3"><div class="vt">Terms & Condition</div>
					</div>
					<div class="col-md-9">
					<a href="${pageContext.servletContext.contextPath}/etender/buyer/getcreatetermandconditions/${tblTender.tenderId}" class="tnd_bttn"><spring:message code="lbl_update_term_condition"/> </a>
					</div>
				</div>
				</c:if>
				<c:if test="${tblTender.cstatus eq 1}">
				<div class="row">
					<div class="col-md-3"><div class="vt">Cancel tender</div>
					</div>
					<div class="col-md-9">
					<a href="${pageContext.servletContext.contextPath}/etender/buyer/getcanceltender/${tblTender.tenderId}" class="tnd_bttn">Cancel tender</a>
					</div>
				</div>
				</c:if>
<%-- 				<c:if test="${copyTenderRequired eq true}"> --%>
				<div class="row">
					<div class="col-md-3"><div class="vt">Copy tender</div>
					</div>
					<div class="col-md-9">
					<a href="#" onclick="copyTender();" class="tnd_bttn">Copy tender</a>
					</div>
				</div>
<%-- 				</c:if> --%>
			</div>

</div>			
			
</div>

</div>

</div>

<div class="row">
<div class="col-md-12">

<div class="box">

<div class="box-header with-border">
<h3 class="box-title">Notice & Document</h3>
</div>

<div class="box-body">

<div class="row">

<!--  Corrigendum Start -->
<c:if test="${tblTender.cstatus eq 1}">

<div class="col-md-12">
    
<div class="panel-heading customCls" data-toggle="collapse" href="#corrigendum" >
        <h4 class="panel-title">
          <a><spring:message code="label_corrigendum"/></a>
        </h4>
      </div>
      
<div id="corrigendum" class="panel-collapse pnl">
      
<c:choose>
     		
<c:when test="${not empty currentCorrigendum}">
<div class="row">
<div class="col-md-3"><div class="vt"><spring:message code="label_corrigendum"/></div></div>
<div class="col-md-9">
<c:if test="${submissionDateOver ne true}">
<a href="${pageContext.servletContext.contextPath}/etender/buyer/createcorrigendum/${tblTender.tenderId}" class="tnd_bttn"><spring:message code="label_edit"/></a>
<a href="${pageContext.servletContext.contextPath}/etender/buyer/tendercorrigendum/${tenderId}/${currentCorrigendum.corrigendumId}" class="tnd_bttn"><spring:message code="label_edit_notice"/></a>
<a href="${pageContext.servletContext.contextPath}/etender/buyer/deletecorrigendum/${tenderId}/${currentCorrigendum.corrigendumId}" class="tnd_bttn" onclick="return confirmCorrigenudmDelete()">${deletelink}</a>
<a href="${pageContext.servletContext.contextPath}/etender/buyer/tendernitdocument/${tblTender.tenderId}/${currentCorrigendum.corrigendumId}" class="tnd_bttn">${title_upload_documents}</a> |
</c:if>
<a href="${pageContext.servletContext.contextPath}/etender/buyer/viewcorrigendum/${tenderId}"><spring:message code="label_view"/></a>
<c:choose>
<c:when test="${tblTender.isWorkflowRequired eq 1 && corrigendumWorkflowDone eq true && submissionDateOver ne true}">
<a href="${pageContext.servletContext.contextPath}/etender/buyer/publishtender/${tblTender.tenderId}" class="tnd_bttn" onclick="return validatePublishTender(${tblTender.tenderId})">${label_publish}</a>
</c:when>
<c:when test="${tblTender.isWorkflowRequired eq 0 && submissionDateOver ne true}">
<a href="${pageContext.servletContext.contextPath}/etender/buyer/publishtender/${tblTender.tenderId}" class="tnd_bttn" onclick="return validatePublishTender(${tblTender.tenderId})">${label_publish}</a>
</c:when>
</c:choose>
<c:if test="${submissionDateOver ne true}">
<a href="${pageContext.servletContext.contextPath}/etender/buyer/showpublishcorrigendum/${tblTender.tenderId}/${currentCorrigendum.corrigendumId}" class="tnd_bttn"><spring:message code="label_publish"/></a>
</c:if>
</div>
</div>
</c:when>
			
<c:when test="${empty currentCorrigendum}">		
<div class="row">
<div class="col-md-3"><div class="vt"><spring:message code="label_corrigendum"/></div></div>
<div class="col-md-9">
<c:if test="${submissionDateOver ne true }">
<a href="${pageContext.servletContext.contextPath}/etender/buyer/createcorrigendum/${tblTender.tenderId}" class="tnd_bttn"><spring:message code="label_create"/></a> |
</c:if>	
<c:if test="${not empty tblCorrigendum}">
<a href="${pageContext.servletContext.contextPath}/etender/buyer/viewcorrigendum/${tenderId}" class="tnd_bttn"><spring:message code="label_view"/></a>
</c:if>
</div>
</div>
</c:when>
			
</c:choose>
			
<c:if test="${not empty tblCorrigendum }">
<c:forEach items="${tblCorrigendum}" var="items" varStatus="indx">
<c:if test="${items.cstatus ne '0'}">
<div class="row">
<div class="col-md-3">
<div class="vt"><spring:message code="lbl_create_corrigendum_text"/> ${indx.count}</div>
</div>
<div class="col-md-3"><div class="vt">${items.corrigendumText}</div></div>
</div>
						
<c:if test="${documentEndDateOver ne true}">						
<div class="row">
<div class="col-md-3">
<div class="vt"><spring:message code="field_documents"/></div>
</div>
<div class="col-md-3">
<a href="${pageContext.servletContext.contextPath}/etender/buyer/getDocumentList/${tenderNITObjectId}/${tblTender.tenderId}/${tblTender.tenderId}/${items.corrigendumId}/0" class="tnd_bttn" data-target="#myModal" class="myModel" data-toggle="modal">${lbl_view_doc}</a>
</div>
</div>
</c:if>
</c:if>
</c:forEach>
</c:if>
			
</div>
			
</div>
    
</c:if>
<!-- Corrigendum End  -->

<div class="col-md-12 pn">
     
<div class="panel-heading customCls" data-toggle="collapse" href="#Bid">
<h4 class="panel-title"><a><spring:message code="var_page_title_biddingForm" /></a></h4>
</div>
                <%int envId=0;
                int cnt=0;
                    %>
<div id="Bid" class="panel-collapse pnl">
	    	
<div class="row">

<div class="col-md-3"><div class="vt"><spring:message code="var_page_title_biddingForm" /></div></div>
<div class="col-md-9">
<c:if test="${tblTender.cstatus ne 1 && tblTender.cstatus ne 2 && empty corrigendumWorkflowList && isTenderWorkflowStarted ne true  or (workflowToInitiator eq true)}">
<a href="${pageContext.servletContext.contextPath}/eBid/Bid/createForm?tenderId=${tenderId}" class="tnd_bttn">${createlink}</a>
<a href="${pageContext.servletContext.contextPath}/eBid/Bid/getFormLibrary/${tenderId}" class="tnd_bttn">Form Library</a>
</c:if> 
</div>

</div>
      
<c:if test="${not empty biddingForm }">
<c:forEach items="${biddingForm}" var="items">
                                    
                                    <c:forEach items="${FormStatusLst}" var="status">
                                        <c:set var="staarr" value="${fn:split(status,'_')}"/>
                                        <c:set var="sta" value="${staarr[0]}"/>
                                        <c:set var="formid" value="${staarr[1]}"/>
                                        <c:if test="${formid eq items.formId}">
                                              <c:if test="${sta eq ' ' }">
                                                <c:set var="fromStatus" value=" "/>
                                            </c:if>
                                            <c:if test="${sta eq 'Formula Pending' && items.isPriceBid eq 1 && items.loadNoOfItems ne 0 }">
                                                <c:set var="fromStatus" value="[${sta}]"/>
                                            </c:if>
                                             <c:if test="${sta eq 'Incomplete' }">
                                                <c:set var="fromStatus" value="[${sta}]"/>
                                            </c:if>
                                             
                                              <c:if test="${sta eq 'Document Not inserted' }">
                                                <c:set var="fromStatus" value="[${sta}]"/>
                                            </c:if>
                                        </c:if>
                                       
                                    </c:forEach>
                                  
<c:choose>
<c:when test="${items.tblTenderEnvelope.envelopeId ne envId}">
<%cnt=1;%>

<div class="row">
<div class="col-md-12">
<h3 class="box-title bd-title">  ${items.tblTenderEnvelope.envelopeName }</h3>
</div>
</div>


<div class="row">                                                         
<c:if test="${items.formId  ne -1}">
                                                                 
<div class="col-md-3">
<div class="vt">
                                                                 <%=cnt++%> )&nbsp; <a href="${pageContext.servletContext.contextPath}/eBid/Bid/viewForm/${tblTender.tenderId}/${items.formId}/0/false">${items.formName }</a>
                                                                    <c:if test="${items.isMandatory eq 1}">*</c:if>
                                                                  </div>  
                                                                 <h3 class="box-title bd-title">${fromStatus}</h3>
</div>
                                                                 
<div class="col-md-9">
                                                                     <c:if test="${tblTender.cstatus ne 1 && empty corrigendumWorkflowList && isTenderWorkflowStarted ne true  or (workflowToInitiator eq true)}">
                                                                    <a href="${pageContext.servletContext.contextPath}/eBid/Bid/GetFormInfo/${items.formId}/${tblTender.tenderId}" class="tnd_bttn"><spring:message code="label_edit"/></a>   
                                                                     </c:if>
                                                                     <a href="${pageContext.servletContext.contextPath}/eBid/Bid/viewForm/${tblTender.tenderId}/${items.formId}/0/false" class="tnd_bttn"><spring:message code="label_view"/></a>

                                                                   
                                                                         <c:if test="${items.isPriceBid eq 1 && items.loadNoOfItems ne 0 && tblTender.cstatus ne 1}">

                                                                         
                                                                            <c:if test ="${ items.isEncryptionReq eq 0}">
                                                                                <a href="${pageContext.servletContext.contextPath}/eBid/Bid/GetFormulaColumns/${tblTender.tenderId}/${items.formId}" class="tnd_bttn"> <spring:message code="label_Formula"/></a>   
                                                                            </c:if>

                                                                            <c:if test ="${ items.isEncryptionReq ne 0}">  
                                                                                  <a href="${pageContext.servletContext.contextPath}/eBid/Bid/GetFormulaColumns/${tblTender.tenderId}/${items.formId}" class="tnd_bttn"> Edit Formula</a>  
                                                                             </c:if>

                                                                         </c:if>
                                                                       
                                                                         <c:if test="${items.isPriceBid eq 1 && tblTender.isItemwiseWinner eq 1}"> <!-- form should be mand one more cond-->
                                                                            
                                                                            
                                                                                <a href="${pageContext.servletContext.contextPath}/eBid/Bid/getEvaluationColumn/${tblTender.tenderId}/${items.formId}" class="tnd_bttn"> 
                                                                                    <spring:message code="label_Evaluation"/>
                                                                                </a> 
                                                                         </c:if>   
                                                                           
                                                                         <c:if test="${items.isPriceBid eq 1 && tblTender.isItemwiseWinner ne 1 && items.isMandatory eq 1   }"> <!-- form should be mand one more cond-->      
                                                                               <a href="${pageContext.servletContext.contextPath}/eBid/Bid/getPriceSumaryColumn/${tblTender.tenderId}/${items.formId}" class="tnd_bttn">
                                                                                    Create Price Summary</a>
                                                                         </c:if>
                                                                        
                                                                        <c:if test="${items.isDocumentReq eq 1 && items.isPriceBid eq 0 && tblTender.cstatus ne 1}">
                                                                         

                                                                        <a href="${pageContext.servletContext.contextPath}/eBid/Bid/createFormDocument/${tblTender.tenderId}/${items.formId}" class="tnd_bttn"> <spring:message code="label_Document_upload"/></a>   
                                                                         </c:if>
                                                                                                                                <a href="${pageContext.servletContext.contextPath}/eBid/Bid/GetFormInfoForTest/${items.formId}/${tblTender.tenderId}/0" class="tnd_bttn">Test Form</a>   
                                                                           
                                                                                                                              
                                                                           <c:if test="${tblTender.cstatus ne 1 && empty corrigendumWorkflowList && isTenderWorkflowStarted ne true  or (workflowToInitiator eq true)}">                                               
                                                                                                                                 <a href="${pageContext.servletContext.contextPath}/eBid/Bid/DeleteForm/${tblTender.tenderId}/${items.formId}" onclick="return confirm('Are you sure you want to delete form?')" class="tnd_bttn">Delete Form</a>
                                                                           </c:if> 
                                                       
</div>
                                                                
</c:if>
                                                              
<c:if test="${items.formId  eq -1}">
<div class="col-md-9"><div class="vt">No forms mapped with this envelope. </div></div>
</c:if>  
                                                                 
</div>

<c:set value="${items.tblTenderEnvelope.envelopeId}" var="envId"/>
                                                         
</c:when>

<c:otherwise>

<c:if test="${items.formId  ne -1}">

<div class="row">

<div class="col-md-3">
<div class="vt">
<%=cnt++%>)&nbsp; <a href="${pageContext.servletContext.contextPath}/eBid/Bid/viewForm/${tblTender.tenderId}/${items.formId}/0/false">${items.formName }</a>
<c:if test="${items.isMandatory eq 1}">*</c:if>  
</div>                                                              
<h3 class="box-title bd-title">${fromStatus}</h3>
</div>

<div class="col-md-9">
                                                                       <c:if test="${tblTender.cstatus ne 1 && empty corrigendumWorkflowList && isTenderWorkflowStarted ne true  or (workflowToInitiator eq true)}">
                                                                  
                                                                        <a href="${pageContext.servletContext.contextPath}/eBid/Bid/GetFormInfo/${items.formId}/${tblTender.tenderId}" class="tnd_bttn"><spring:message code="label_edit"/></a>   
                                                                  
                                                                    </c:if>
                                                                     <a href="${pageContext.servletContext.contextPath}/eBid/Bid/viewForm/${tblTender.tenderId}/${items.formId}/0/false" class="tnd_bttn"><spring:message code="label_view"/></a>

                                                                    
                                                                        <c:if test="${items.isPriceBid eq 1 && items.loadNoOfItems ne 0 && tblTender.cstatus ne 1 }">

                                                                         
                                                                         <c:if test ="${ items.isEncryptionReq eq 0}">
                                                                            <a href="${pageContext.servletContext.contextPath}/eBid/Bid/GetFormulaColumns/${tblTender.tenderId}/${items.formId}" class="tnd_bttn"> <spring:message code="label_Formula"/></a>   
                                                                        </c:if>
                                                                                                                                                
                                                                          <c:if test ="${items.isEncryptionReq ne 0}">  
                                                                              <a href="${pageContext.servletContext.contextPath}/eBid/Bid/GetFormulaColumns/${tblTender.tenderId}/${items.formId}" class="tnd_bttn"> Edit Formula</a>  
                                                                         </c:if>
                                                                        </c:if>

                                                                       <c:if test="${items.isPriceBid eq 1 && tblTender.isItemwiseWinner eq 1}"> <!-- form should be mand one more cond-->
                                                                            
                                                                            
                                                                                <a href="${pageContext.servletContext.contextPath}/eBid/Bid/getEvaluationColumn/${tblTender.tenderId}/${items.formId}" class="tnd_bttn"> 
                                                                                    <spring:message code="label_Evaluation"/>
                                                                                </a> 
                                                                         </c:if>   
                                                                           
                                                                         <c:if test="${items.isPriceBid eq 1 && tblTender.isItemwiseWinner ne 1 && items.isMandatory eq 1}"> <!-- form should be mand one more cond-->      
                                                                               <a href="${pageContext.servletContext.contextPath}/eBid/Bid/getPriceSumaryColumn/${tblTender.tenderId}/${items.formId}" class="tnd_bttn">
                                                                                    Create Price Summary</a>
                                                                         </c:if>
                                                                                                                                                <c:if test="${items.isDocumentReq eq 1 && items.isPriceBid eq 0 && tblTender.cstatus ne 1}">
                                                                        

                                                                        <a href="${pageContext.servletContext.contextPath}/eBid/Bid/createFormDocument/${tblTender.tenderId}/${items.formId}" class="tnd_bttn"> <spring:message code="label_Document_upload"/></a>   
                                                                        </c:if>
                                                                       
                                                                              <a href="${pageContext.servletContext.contextPath}/eBid/Bid/GetFormInfoForTest/${items.formId}/${tblTender.tenderId}/0" class="tnd_bttn">Test Form</a> 
                                                                             <c:if test="${tblTender.cstatus ne 1 && empty corrigendumWorkflowList && isTenderWorkflowStarted ne true  or (workflowToInitiator eq true)}">                                               
                                                                               
                                                                               <a href="${pageContext.servletContext.contextPath}/eBid/Bid/DeleteForm/${tblTender.tenderId}/${items.formId}"onclick="return confirm('Are you sure You Want to delete')" class="tnd_bttn">Delete Form</a>
                                                                            </c:if>
</div>

</div>

</c:if>

<c:set value="${items.tblTenderEnvelope.envelopeId}" var="envId"/>

</c:otherwise>

</c:choose>
                                    
</c:forEach>

</c:if>
			
</div>

</div>

<c:if test="${tblTender.isPreBidMeeting eq 1}">
    <div class="col-md-12 pn">
  		<div class="panel-heading customCls" data-toggle="collapse" href="#preBid" >
        	<h4 class="panel-title"><a>Prebid</a></h4>
      	</div>
      	<div id="preBid" class="panel-collapse pnl">
	    	<div class="row">
	    		<div class="col-md-3"><div class="vt"><spring:message code="var_page_title" /></div></div>
	            <div class="col-md-9">
	            <c:choose>
	            	<c:when test="${prebidEndDateOver ne true}">
	            		<c:if test="${prebidCommitteeId eq 0}">
			            	<a href="${pageContext.servletContext.contextPath}/etender/buyer/getcreatecommitee/${tenderId}" class="tnd_bttn">${createlink}</a> |
			            	</c:if>
			            <c:if test="${prebidCommitteeId ne 0}">
			            	<a href="${pageContext.servletContext.contextPath}/etender/buyer/geteditcommitee/${tenderId}/${prebidCommitteeId}" class="tnd_bttn">${editlink}</a> |
							<a href="${pageContext.servletContext.contextPath}/etender/buyer/getviewcommitee/${tenderId}/${prebidCommitteeId}/3" class="tnd_bttn">${viewlink}</a> 
						</c:if>
	            	</c:when>
	            	<c:otherwise>
	            		<a href="${pageContext.servletContext.contextPath}/etender/buyer/getviewcommitee/${tenderId}/${prebidCommitteeId}/3" class="tnd_bttn">${viewlink}</a> 
	            	</c:otherwise>
	            </c:choose>
	            </div>
				<c:if test="${prebidCommitteeId ne 0}">	             
	             <div class="col-md-3"><div class="vt">Prebid minutes of meeting</div></div>
	             <div class="col-md-9"><a href="${pageContext.servletContext.contextPath}/etender/buyer/gettendertabcontent/${tenderId}/3" class="tnd_bttn">Upload </a>
	             <a href="${pageContext.servletContext.contextPath}/etender/buyer/publishprebidmom/${tenderId}/${prebidCommitteeId}" class="tnd_bttn">Publish </a></div>
	             </c:if>
			</div>
			</div>
		</div>
	</c:if>

<div class="col-md-12 pn">
  		<div class="panel-heading customCls" data-toggle="collapse" href="#bidOpening" >
        	<h4 class="panel-title"><a>Bid Opening</a></h4>
      	</div>
		<div id="bidOpening" class="panel-collapse pnl">
			<div class="row">
				<div class="col-md-3"><div class="vt"><spring:message code="var_page_title" /></div></div>
				<div class="col-md-9">
					<c:choose>
	            	<c:when test="${true}">
	            		<c:if test="${openingCommitteeId eq 0}">
							<a href="${pageContext.servletContext.contextPath}/etender/buyer/createcommittee/${tenderId}/1" class="tnd_bttn">${createlink}</a>
						</c:if>
						<c:if test="${openingCommitteeId ne 0}">
			            	<a href="${pageContext.servletContext.contextPath}/etender/buyer/editcommittee/${tenderId}/1/1" class="tnd_bttn">${editlink}</a> 
							<a href="${pageContext.servletContext.contextPath}/etender/buyer/getviewcommitee/${tenderId}/${openingCommitteeId}/1" class="tnd_bttn">${viewlink}</a>  
						</c:if>
	            	</c:when>
	            	<c:otherwise>
	            		<a href="${pageContext.servletContext.contextPath}/etender/buyer/getviewcommitee/${tenderId}/${openingCommitteeId}/1" class="tnd_bttn">${viewlink}</a>
	            	</c:otherwise>
	            	</c:choose>
<%-- 					<a href="#">${publishlink}</a> | --%>
					<c:choose>
							<c:when test="${tblTender.cstatus eq '1'}">
								<a href="${pageContext.servletContext.contextPath}/etender/buyer/gettabcontent/${tenderId}/1" class="tnd_bttn">Opening Consent</a>
							</c:when>
					</c:choose>
	          	</div>
			</div>
		</div>
     </div>
     
<!-- work flow start -->
<c:if test="${tblTender.isWorkflowRequired eq 1}">
     <div class="col-md-12 pn">
  		<div class="panel-heading customCls" data-toggle="collapse" href="#workFlow" >
        	<h4 class="panel-title"><a><spring:message code="label_workflow" /></a></h4>
      	</div>
		<div id="workFlow" class="panel-collapse pnl">
			<div class="row">
				<div class="col-md-3"><div class="vt"><spring:message code="label_notice_workflow" /></div></div>
				<div class="col-md-9">
				<c:choose>
				<c:when test="${allowToCreateWorkflow}"><!-- if workflow is not stated or approval is done -->
	            	<a href="${pageContext.servletContext.contextPath}/etender/buyer/viewtenderworkflow/${tenderId}/0" onclick="return validatePublishTender(${tblTender.tenderId})" class="tnd_bttn">${createlink}</a>
	            </c:when>
            	<c:when test="${not empty workflowToMe}">
					<a href="${pageContext.servletContext.contextPath}/etender/buyer/viewtenderworkflow/${tenderId}/0" class="tnd_bttn">${workflow_pending}</a>
				</c:when>
        		<c:when test="${isTenderWorkflowStarted}">
	        		<a href="${pageContext.servletContext.contextPath}/etender/buyer/viewtenderworkflow/${tenderId}/0" class="tnd_bttn">${viewlink}</a>
        		</c:when>
	            </c:choose>
	          	</div>
			</div>
			<c:if test="${tblTender.cstatus eq 1 && not empty tblCorrigendum && not empty corrigendumWorkflowList}">
			<c:forEach items="${corrigendumWorkflowList}" var="corrigendumWorkflow" varStatus="indx">
			<div class="row">
				<div class="col-md-3"><div class="vt">Corrigendum <spring:message code="label_workflow" /> ${indx.count}</div></div>
				<div class="col-md-9">
				<c:choose>
					<c:when test="${corrigendumWorkflow.corrigendumAllowToCreateWorkflow}"><!-- if workflow is not stated or approval is done -->
		            	<a href="${pageContext.servletContext.contextPath}/etender/buyer/viewtenderworkflow/${tenderId}/${corrigendumWorkflow.corrigendumId}" class="tnd_bttn">${createlink}</a>
		            </c:when>
	            	<c:when test="${corrigendumWorkflow.corrigendumWorkflowToMe}">
						<a href="${pageContext.servletContext.contextPath}/etender/buyer/viewtenderworkflow/${tenderId}/${corrigendumWorkflow.corrigendumId}" class="tnd_bttn">${workflow_pending}</a>
					</c:when>
	        		<c:when test="${corrigendumWorkflow.isCorrigendumWorkflowStarted}">
	        		<a href="${pageContext.servletContext.contextPath}/etender/buyer/viewtenderworkflow/${tenderId}/${corrigendumWorkflow.corrigendumId}" class="tnd_bttn">${viewlink}</a>
	        		</c:when>    	
	            </c:choose>
	          	</div>
			</div>
			</c:forEach>
			</c:if>
		</div>
     </div>
     </c:if>
<!-- work flow end -->
    
<div class="col-md-12 pn">
  		<div class="panel-heading customCls" data-toggle="collapse" href="#bidEvaluation" >
        	<h4 class="panel-title"><a><spring:message code="tab_tender_evaluatebid"/></a></h4>
      	</div>
      	<div id="bidEvaluation" class="panel-collapse pnl">
	    	<div class="row">
	    		<div class="col-md-3"><div class="vt"><spring:message code="var_page_title" /></div></div>
	            <div class="col-md-9">
	            <c:choose>
	            	<c:when test="${tblTender.isEvaluationDone eq 0}">
	            	<c:if test="${evaluationCommitteeId eq 0}">
	            	<a href="${pageContext.servletContext.contextPath}/etender/buyer/createcommittee/${tenderId}/2" class="tnd_bttn">${createlink}</a>
	            	</c:if>
	            	<c:if test="${evaluationCommitteeId ne 0}">
	            	<a href="${pageContext.servletContext.contextPath}/etender/buyer/editcommittee/${tenderId}/2/1" class="tnd_bttn">${editlink}</a>
					<a href="${pageContext.servletContext.contextPath}/etender/buyer/getviewcommitee/${tenderId}/${evaluationCommitteeId}/2" class="tnd_bttn">${viewlink}</a>
					</c:if>    
					</c:when>
					<c:otherwise>
						<a href="${pageContext.servletContext.contextPath}/etender/buyer/getviewcommitee/${tenderId}/${evaluationCommitteeId}/2" class="tnd_bttn">${viewlink}</a> 
					</c:otherwise>
					</c:choose>
					<c:choose>
							<c:when test="${tblTender.cstatus eq '1' and tblTender.isEvaluationDone eq 0}">
							<a href="${pageContext.servletContext.contextPath}/etender/buyer/gettabcontent/${tenderId}/2" class="tnd_bttn">Evaluation</a>
							</c:when>
							<c:when test="${tblTender.cstatus eq '1' and tblTender.isEvaluationDone eq 1}">
							<a href="${pageContext.servletContext.contextPath}/etender/buyer/gettabcontent/${tenderId}/2" class="tnd_bttn">Evaluted</a>
							</c:when>
					</c:choose>
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

<div id="targetDiv"></div>

</c:if>


<c:if test="${isAuction eq 1}">

	<section class="content-header">
		<a href="${pageContext.servletContext.contextPath}/eBid/Bid/auctionListing" class="btn btn-submit" style="margin-top:0px;"><< Go To Auction List</a>
	</section>
	
	<section class="content">
	
		<%@include file="AuctionSummary.jsp"%>
		
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<div class="box-body">
						<div class="row">

									<div class="col-md-12 pn">
										<div class="panel-heading customCls" data-toggle="collapse"
											href="#collapse1">
											<h4 class="panel-title">
												<a>Notice & Document</a>
											</h4>
										</div>
										<div id="collapse1" class="panel-collapse pnl">
										
											<div class="row">
												<div class="col-md-3">
													<div class="vt"><spring:message code="field_notice" /></div>
												</div>
												<div class="col-md-9">
													<c:choose>
														<c:when test="${tblTender.cstatus eq '0'}">
															<a href="${pageContext.servletContext.contextPath}/eBid/Bid/createAuction/${tblTender.tenderId}" class="tnd_bttn"><spring:message
																	code="label_edit" /> </a> 
							  								<a href="${pageContext.servletContext.contextPath}/etender/buyer/publishtender/${tblTender.tenderId}"
																onclick="return validatePublishTender(${tblTender.tenderId})" class="tnd_bttn">Approve</a>
															<a href="${pageContext.servletContext.contextPath}/eBid/Bid/viewAuction/${tblTender.tenderId}/0" class="tnd_bttn"><spring:message
																	code="label_view" />
															</a>
                                                            <a href="${pageContext.servletContext.contextPath}/eBid/Bid/loginReport/${tblTender.tenderId}" class="tnd_bttn">Login
																Report</a>
														</c:when>
														<c:otherwise>
															<a href="${pageContext.servletContext.contextPath}/eBid/Bid/viewAuction/${tblTender.tenderId}/0" class="tnd_bttn"><spring:message
																	code="label_view" />
															</a>
                                                            <a href="${pageContext.servletContext.contextPath}/eBid/Bid/loginReport/${tblTender.tenderId}" class="tnd_bttn">Login
																Report</a>
														</c:otherwise>
													</c:choose>
												</div>
											</div>

											<div class="row">
												<div class="col-md-3">
													<div class="vt"><spring:message code="field_documents" /></div>
												</div>
												<div class="col-md-9">
													<a href="${pageContext.servletContext.contextPath}/etender/buyer/tendernitdocument/${tblTender.tenderId}/0" class="tnd_bttn">Upload
														document</a>
												</div>
											</div>

											<div class="row">
												<div class="col-md-3"><div class="vt">Copy Auction</div></div>
												<div class="col-md-9">
													<a href="${pageContext.servletContext.contextPath}/etender/buyer/copytender/${tblTender.tenderId}" class="tnd_bttn">Copy
														Auction</a>
												</div>
											</div>

										</div>
										
										</div>
									
									
									
									
									
									<div class="col-md-12 pn">
										<div class="panel-heading customCls" data-toggle="collapse"
											href="#Bid">
											<h4 class="panel-title">
												<a>Bidding Form</a>
											</h4>
										</div>

										<div id="Bid" class="panel-collapse pnl">
											<div class="row">
												<div class="col-md-3">
													<div class="vt"><spring:message code="var_page_title_biddingForm" /></div>
												</div>
												<div class="col-md-9">
													<c:set var="formcount" value="0" />
													<c:if test="${not empty biddingForm }">
														<c:forEach items="${biddingForm}" var="item">
															<c:if test="${item.formId != -1}">
																<c:set var="formcount" value="${formcount+1}" />
															</c:if>

														</c:forEach>
													</c:if>
													<c:if test="${formcount eq 0}">
														<c:set var="count" value="0" />
														<c:if test="${not empty biddingForm }">
															<c:forEach items="${biddingForm}" var="item">
																<c:if test="${count eq 0}">
																	<c:if test="${item.formId eq -1}">
																		<a href="${pageContext.servletContext.contextPath}/eBid/Bid/createForm?tenderId=${tenderId}" class="tnd_bttn">${createlink}</a>
																		<ahref="${pageContext.servletContext.contextPath}/eBid/Bid/getFormLibrary/${tenderId}" class="tnd_bttn">Form
																			Library</a>
																		<c:set var="count" value="${count+1}" />
																	</c:if>
																</c:if>
															</c:forEach>
														</c:if>
													</c:if>

												</div>


												<div class="col-md-12">

													<c:if test="${not empty biddingForm }">

														<c:forEach items="${biddingForm}" var="item">
															<c:if test="${item.formId != -1}">
																<div class="row">
																	<div class="col-md-1">${item.formId}</div>
																	<div class="col-md-2">${item.formName}</div>
																	<div class="col-md-9">
																		<a href="${pageContext.servletContext.contextPath}/eBid/Bid/GetFormInfo/${item.formId}/${tblTender.tenderId}" class="tnd_bttn"><spring:message
																				code="label_edit" /></a> 
																		<a href="${pageContext.servletContext.contextPath}/eBid/Bid/viewForm/${tblTender.tenderId}/${item.formId}/0/false" class="tnd_bttn"><spring:message
																				code="label_view" />
																		</a>
																		<a href="${pageContext.servletContext.contextPath}/eBid/Bid/GetFormInfoForTest/${item.formId}/${tblTender.tenderId}/0" class="tnd_bttn">Test
																			Form</a>


																		<c:if test="${ item.isEncryptionReq eq 0}">
                                                                           <a href="${pageContext.servletContext.contextPath}/eBid/Bid/GetFormulaColumns/${tblTender.tenderId}/${item.formId}" class="tnd_bttn">
																				<spring:message code="label_Formula" />
																			</a>
																		</c:if>

																		<c:if test="${  item.isEncryptionReq ne 0}">  
                                                                            <a href="${pageContext.servletContext.contextPath}/eBid/Bid/GetFormulaColumns/${tblTender.tenderId}/${item.formId}" class="tnd_bttn">
																				Edit Formula</a>
																		</c:if>

																		<c:if
																			test="${item.cstatus ne 1 or tblTender.cstatus ne 1}">
                                            <a
																			<a href="${pageContext.servletContext.contextPath}/eBid/Bid/DeleteForm/${tblTender.tenderId}/${item.formId}" class="tnd_bttn"
																				onclick="return confirm('Are you sure you want to delete form?')">Delete</a>
																		</c:if>
																	</div>

																</div>
															</c:if>



														</c:forEach>
													</c:if>

												</div>
											</div>
										</div>
									</div>


									<c:if test="${tblTender.biddingAccess eq 0}">
										<div class="col-md-12 pn">
											<div class="panel-heading customCls" data-toggle="collapse"
												href="#bidOpening">
												<h4 class="panel-title">
													<a>Map Bidders</a>
												</h4>
											</div>
											<div id="bidOpening" class="panel-collapse pnl">

												<div class="row">
													<div class="col-md-3">
														<div class="vt"><spring:message code="field_bidder" /></div>
													</div>
													<div class="col-md-9">
														<a href="${pageContext.servletContext.contextPath}/etender/buyer/biddermapping/${tblTender.tenderId}" class="tnd_bttn">Bidder
															Mapping</a>
														<c:if test="${tblTender.cstatus ne 1}">
														<a href="${pageContext.servletContext.contextPath}/etender/buyer/viewmappedbidders/${tblTender.tenderId}" class="tnd_bttn">Mapped
																Bidders</a>
														</c:if>

													</div>
												</div>

											</div>
										</div>
									</c:if>


									<!-- work flow start -->
									<c:if test="${tblTender.cstatus eq 1}">
										<div class="col-md-12 pn">
											<div class="panel-heading customCls" data-toggle="collapse"
												href="#bidOpening">
												<h4 class="panel-title">
													<a>Result</a>
												</h4>
											</div>
											<div id="bidOpening" class="panel-collapse pnl">

												<div class="row">
													<div class="col-md-3"><div class="vt">Report</div></div>
													<div class="col-md-9">

														<a href="${pageContext.servletContext.contextPath}/eBid/Bid/viewAuctionResult/${tblTender.tenderId}" class="tnd_bttn">
															<c:if test="${tblTender.isAuctionStop eq 1}">Resume Auction</c:if>
															<c:if test="${tblTender.isAuctionStop eq 0}">Stop Auction</c:if>

														</a>

													</div>
												</div>

											</div>
										</div>
									</c:if>

									<!-- work flow end -->

								</div>
					</div>
				</div>
			</div>
		</div>
		
	</section>
	          
 <div id="targetDiv"></div> 
 </c:if>


</div>

<%@include file="../../includes/footer.jsp"%>

<script type="text/javascript">
function confirmCorrigenudmDelete(){
	return confirm("Are you sure you want to delete corrigendum ?");
}
 /* function callForPublish(tenderId){
	 onclick="return validatePublishtender()"
    if(confirm("Are you sure you want to publish tender ?"))
    {
    	return true;
    }	
    return false;
 }*/
 
 function callForPublishForm(){
	/* $.ajax({
		url:"/etender/buyer/publishtender/"+tenderId,
		success: function(result){
		console.log(result);
			location.reload();;
    }}); */
    if(confirm("Are you sure you want to publish form ?"))
    {
    	return true;
    }	
    return false;
 }
function validatePublishTender(){
	var flag = true;
	$.ajax({
		url:"${pageContext.servletContext.contextPath}/etender/buyer/validatePublishtender/${tblTender.tenderId}",
		async:false,
		success: function(result){
			if(result != ''){
				validatePublishMsg(result);
				flag = false;
			}else{
				flag = true;
			}
    	}
	});
	return flag;
}
function validatePublishMsg(publishTenderError){
	if(publishTenderError != '' && publishTenderError != undefined){
		 var jsonMsg = $.parseJSON(publishTenderError);
		 var errorMsg = "";
		 for(var indx in jsonMsg){
			 errorMsg += jsonMsg[indx]+"\r\n";
		 }
		 alert(errorMsg);
	 }
}
 $(document).ready(function(){
	 var publishTenderError = '${publishTenderError}';
	 validatePublishMsg(publishTenderError);
	 
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
 
 function copyTender(){
	 var tenderId='${tblTender.tenderId}';
     if(confirm('<spring:message code="msg_tender_cnfrm_copytender" />')){
    	 $(".successMsg").hide();
    	 window.location = "${pageContext.servletContext.contextPath}/etender/buyer/copytender/"+tenderId;
    }
}
 
 </script>

</div>

</body>

</html>