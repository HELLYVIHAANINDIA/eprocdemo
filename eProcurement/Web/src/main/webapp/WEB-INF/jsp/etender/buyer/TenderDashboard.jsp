<%@include file="../../includes/head.jsp"%>

<%@include file="../../includes/masterheader.jsp"%>
<%@page import="java.util.TimeZone"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.eprocurement.etender.model.TblTender"%>
<%@ taglib uri="http://www.ctpl.com/functions" prefix="util" %>
<jsp:useBean id="now" class="java.util.Date" />

<spring:message code="link_create" var="createlink" />
<spring:message code="link_tender_edit" var="editlink" />
<spring:message code="workflow_pending" var="workflow_pending" />
<spring:message code="label_view" var="viewlink" />
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
<spring:message  code="title_upload_documents" var="title_upload_documents"/>
<spring:message code="msg_alert_delete_formula" var="msg_alert_delete_formula"/>

	<div class="content-wrapper">
	<section class="content-header">
<c:choose>
	<c:when test="${isAuction eq 1}">
		<h1 class="inline"><spring:message code="lbl_auction_dashboard" /></h1>
		<a href="${pageContext.servletContext.contextPath}/eBid/Bid/auctionListing" class="g g-back"><< <spring:message code="lbl_go_to_auction_list" /></a>
	</c:when>
	<c:when test="${isAuction eq 0}">
		<h1 class="inline">Tender Dashboard</h1>
		<a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderListing" class="g g-back"> << <spring:message code="lbl_back_tenderlist"/></a>
	</c:when>
</c:choose>
		
	</section>
	
	<div class="clearfix"></div>
	<c:if test="${isAuction eq 0}">    
		<section class="content">
		
			<c:if test="${not empty successMsg}">
				<c:choose>
					<c:when test="${fn:contains(successMsg, '_')}">
						<div class="alert alert-success">
							<spring:message code="${successMsg}" />
						</div>
					</c:when>
					<c:otherwise>
						<div class="alert alert-success">${successMsg}</div>
					</c:otherwise>
				</c:choose>
			</c:if>

			<c:if test="${not empty errorMsg}">
				<c:choose>
					<c:when test="${fn:contains(errorMsg, '_')}">
						<div class="alert alert-danger">
							<spring:message code="${errorMsg}" />
						</div>
					</c:when>
					<c:otherwise>
						<div class="alert alert-danger">${errorMsg}</div>
					</c:otherwise>
				</c:choose>
			</c:if>
			
        
	
			<%@include file="TenderSummary.jsp"%>
			
<div class="row">
  <div class="col-md-12">
	<div class="box">
		<div class="box-header with-border" data-toggle="collapse" href="#collapse1">
		<h3 class="box-title"><a>Tender notice</a></h3>
		</div>
		<div class="box-body">
			<div class="row">
				<div class="col-md-12">      
      <div id="collapse1" class="panel-collapse">
				<div class="row">
					<div class="col-md-3"><spring:message code="field_notice"/></div>
					<div class="col-md-9">
						<c:choose>
							<c:when test="${tblTender.cstatus eq '0'}">
								<c:if test="${((empty corrigendumWorkflowList && isTenderWorkflowStarted ne true) or (workflowToInitiator eq true)) && workflowDone ne true}">
								<c:set var="encParamCreateEvent" value="${pageContext.servletContext.contextPath}/etender/buyer/biddermapping/${tblTender.tenderId}" />
								<a href="${pageContext.servletContext.contextPath}/etender/buyer/createevent/${tblTender.tenderId}"><spring:message	code="label_edit" /> </a>
								</c:if> 
								<c:choose>
									<c:when test="${tblTender.isWorkflowRequired eq 1 && workflowDone eq true && workflowToInitiator eq true}">
										|&nbsp;<a href="${pageContext.servletContext.contextPath}/etender/buyer/publishtender/${tblTender.tenderId}" onclick="return validatePublishTender(${tblTender.tenderId})">${label_publish}</a>
									</c:when>
									<c:when test="${tblTender.isWorkflowRequired eq 0}">
										|&nbsp;<a href="${pageContext.servletContext.contextPath}/etender/buyer/publishtender/${tblTender.tenderId}" onclick="return validatePublishTender(${tblTender.tenderId})">${label_publish}</a>
									</c:when>
								</c:choose>
							  |&nbsp;<a href="${pageContext.servletContext.contextPath}/etender/buyer/viewtender/${tblTender.tenderId}/0">${viewlink}</a>
							  <%-- |&nbsp;<a href="${pageContext.servletContext.contextPath}/etender/buyer/deleteTender/${tenderId}" onclick="return confirm('<spring:message code="msg_tender_delete_confirm"/>')"><spring:message code="link_tender_delete"/></a> --%>
							</c:when>
							<c:otherwise>
								<a	href="${pageContext.servletContext.contextPath}/etender/buyer/viewtender/${tblTender.tenderId}/0">${viewlink}</a>
								|&nbsp;<a href="${pageContext.servletContext.contextPath}/common/addEditMarquee/${tenderId}" ><spring:message code="lbl_add_edit_biddermsg"/></a>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				
				<div class="row">
					<div class="col-md-3"><spring:message code="field_documents"/>
					</div>
					<div class="col-md-9">
					<c:choose>
					<c:when test="${(empty corrigendumWorkflowList && isTenderWorkflowStarted ne true  && tblTender.cstatus eq 0) or (workflowToInitiator eq true and tblTender.cstatus eq 0)}">
						<a href="${pageContext.servletContext.contextPath}/etender/buyer/tendernitdocument/${tblTender.tenderId}/0">${title_upload_documents}</a>
						| <a href="${pageContext.servletContext.contextPath}/etender/buyer/getDocumentList/${tblTender.tenderId}/${tenderNITObjectId}/${tblTender.tenderId}/0/0" data-target="#myModal" class="myModel" data-toggle="modal">${lbl_view_doc}</a>
					</c:when>
					<c:when test="${documentEndDateOver ne true}">
						<a href="${pageContext.servletContext.contextPath}/etender/buyer/getDocumentList/${tblTender.tenderId}/${tenderNITObjectId}/${tblTender.tenderId}/0/0" data-target="#myModal" class="myModel" data-toggle="modal">${lbl_view_doc}</a>
					</c:when>
					</c:choose>
					</div>
				</div>
				<c:if test="${tblTender.cstatus eq 0 && empty corrigendumWorkflowList && isTenderWorkflowStarted ne true  or (workflowToInitiator eq true and tblTender.cstatus eq 0)}">
				<div class="row">
					<div class="col-md-3">Terms & Condition
					</div>
					<div class="col-md-9">
					<a href="${pageContext.servletContext.contextPath}/etender/buyer/getcreatetermandconditions/${tblTender.tenderId}"><spring:message code="lbl_update_term_condition"/> </a>
					</div>
				</div>
				</c:if>
				<c:if test="${tblTender.cstatus eq 1}">
				<div class="row">
					<div class="col-md-3">Cancel tender
					</div>
					<div class="col-md-9">
					<a href="${pageContext.servletContext.contextPath}/etender/buyer/getcanceltender/${tblTender.tenderId}">Cancel tender</a>
					</div>
				</div>
				</c:if>
			</div>
				</div>
			</div>
		</div>
	</div>
  </div>
</div>

<!--  Corrigendum Start -->
<c:if test="${tblTender.cstatus eq 1}">
<div class="row">
  <div class="col-md-12">
	<div class="box">
		<div class="box-header with-border" data-toggle="collapse" href="#corrigendum">
			<h3 class="box-title"><a><spring:message code="label_corrigendum"/></a></h3>
		</div>
		<div class="box-body">
			<div class="row">
				      <div id="corrigendum" class="panel-collapse">
     		<c:choose>
     		<c:when test="${not empty currentCorrigendum}">
					<div class="row">
					<div class="col-md-3"><spring:message code="label_corrigendum"/></div>
					<div class="col-md-9">
						<c:if test="${isAnyConsentReceived ne true && isCurrentWorkflowStart ne true}">
							<a href="${pageContext.servletContext.contextPath}/etender/buyer/createcorrigendum/${tblTender.tenderId}"><spring:message code="label_edit"/></a>
							| <a href="${pageContext.servletContext.contextPath}/etender/buyer/tendercorrigendum/${tenderId}/${currentCorrigendum.corrigendumId}"><spring:message code="label_edit_notice"/></a>
							| <a href="${pageContext.servletContext.contextPath}/etender/buyer/deletecorrigendum/${tenderId}/${currentCorrigendum.corrigendumId}" onclick="return confirmCorrigenudmDelete()">${deletelink}</a>
							| <a href="${pageContext.servletContext.contextPath}/etender/buyer/tendernitdocument/${tblTender.tenderId}/${currentCorrigendum.corrigendumId}">${title_upload_documents}</a> |
						</c:if>
						<a href="${pageContext.servletContext.contextPath}/etender/buyer/getDocumentList/${tblTender.tenderId}/${tenderNITObjectId}/${tblTender.tenderId}/${currentCorrigendum.corrigendumId}/0" data-target="#myModal" class="myModel" data-toggle="modal">${lbl_view_doc}</a> |
						<a href="${pageContext.servletContext.contextPath}/etender/buyer/viewcorrigendum/${tenderId}/0">${viewlink}</a>
						<!-- hideCorrigendumPublish : if workflow enable then only this will be true-->
						<c:choose>
						<c:when test="${hideCorrigendumPublish ne true && isCorrigendumWorkflowStarted ne true && isAnyConsentReceived ne true && ((tblTender.isWorkflowRequired eq 0) or (tblTender.isWorkflowRequired eq 1 && corrigendumWorkflowDone eq true && corrigendumWorkflowToInitiator eq true))}">
								| <a href="${pageContext.servletContext.contextPath}/etender/buyer/showpublishcorrigendum/${tblTender.tenderId}/${currentCorrigendum.corrigendumId}" onclick="return validatePublishTender(${tblTender.tenderId})"><spring:message code="label_publish"/></a>	
						</c:when>
						
						</c:choose>
						
					</div>
				</div>
			</c:when>
			<c:when test="${empty currentCorrigendum}">
			<div class="row">
					<div class="col-md-3"><spring:message code="label_corrigendum"/></div>
					<div class="col-md-9">
					<c:if test="${isAnyConsentReceived ne true }">
						<a href="${pageContext.servletContext.contextPath}/etender/buyer/createcorrigendum/${tblTender.tenderId}"><spring:message code="label_create"/></a> |
					</c:if>	
					<c:if test="${not empty tblCorrigendum}">
					  <a href="${pageContext.servletContext.contextPath}/etender/buyer/viewcorrigendum/${tenderId}/0">${viewlink}</a>
					</c:if>
					</div>
				</div>
			</c:when>
			</c:choose>
			<br/>
			<c:if test="${not empty tblCorrigendum }">
				<c:forEach items="${tblCorrigendum}" var="items" varStatus="indx">
					<c:if test="${items.cstatus ne '0'}">
						<div class="row border">
							<div class="col-md-3">
								<spring:message code="lbl_create_corrigendum_text"/> ${indx.count}
							</div>
							<div class="col-md-3">${items.corrigendumText}</div>
						</div>
						<c:if test="${documentEndDateOver ne true}">
						<div class="row border">
							<div class="col-md-3">
								<spring:message code="corrigendum_view_doc"/>
							</div>
							<div class="col-md-3">
					  			<a href="${pageContext.servletContext.contextPath}/etender/buyer/getDocumentList/${tblTender.tenderId}/${tenderNITObjectId}/${tblTender.tenderId}/${items.corrigendumId}/0" data-target="#myModal" class="myModel" data-toggle="modal">${lbl_view_doc}</a>
							</div>
						</div>
						</c:if>
					</c:if>
				</c:forEach>
			</c:if>
			</div>
			</div>
		</div>
	</div>
  </div>
</div>
</c:if>
<!-- Corrigendum End  -->

<div class="row">
  <div class="col-md-12">
	<div class="box">
		<div class="box-header with-border" data-toggle="collapse" href="#Bid">
			<h3 class="box-title"><a><spring:message code="var_page_title_biddingForm" /></a></h3>
		</div>
		<div class="box-body">
			<div class="row">
			<div class="col-md-12">
				                <%int envId=0;
                int cnt=0;
                    %>
      	<div id="Bid" class="panel-collapse">
	    	<div class="row border">
	    	<%-- <c:if test="${(tblTender.cstatus ne 1 && tblTender.cstatus ne 2 && empty corrigendumWorkflowList && isTenderWorkflowStarted ne true  or (workflowToInitiator eq true and tblTender.cstatus eq 0)) && workflowDone ne true}"> --%>
	    	<!-- tender not published or if published then corrigendum should started -->
	    	<c:if test="${(tblTender.cstatus eq 1 && not empty currentCorrigendum or tblTender.cstatus eq 0) &&  (empty corrigendumWorkflowList && isTenderWorkflowStarted ne true  or (workflowToInitiator eq true and tblTender.cstatus eq 0)) && workflowDone ne true}">
	    		<div class="col-md-3"><spring:message code="var_page_title_biddingForm" /></div>
	            <div class="col-md-9">
                       	<a href="${pageContext.servletContext.contextPath}/eBid/Bid/createForm/${tenderId}">${createlink}</a>
                       | <a href="${pageContext.servletContext.contextPath}/eBid/Bid/getFormLibrary/${tenderId}"><spring:message code="lbl_library" /></a>
                       <c:if test="${tblTender.isItemwiseWinner eq 0 && tblTender.isWeightageEvaluationRequired eq 1 && not empty biddingForm && not empty FormStatusLst}">
                       | <a href="${pageContext.servletContext.contextPath}/eBid/Bid/assignWeightToForm/${tenderId}"><spring:message code="lbl_assign_weight_to_forms" /></a>
                       </c:if>
     			</div>
			</c:if>
                                        <div class="">       
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

                                                               <%--  <div class="col-lg-12">
                                                                <div class="text-bold text-primary">
                                                                <h5>${items.tblTenderEnvelope.envelopeName } <spring:message code="lbl_envelop" /></h5>
                                                                </div>
                                                                </div> --%>


                                                           	<c:set var="isFormModificationAllow" value="${((tblTender.cstatus eq 1 and items.cstatus eq 0) or tblTender.cstatus eq 0)}"/>
                                                            <div class="">
                                                            	
                                                            	<div class="col-lg-12">
                                                                <div class="text-bold text-primary">
                                                                <h5>${items.tblTenderEnvelope.envelopeName } <spring:message code="lbl_envelop" /></h5>
                                                                </div>
                                                                

                                                           
                                                                 <c:if test="${items.formId  ne -1}">

                                                                     <div class="col-md-3">
                                                                 
                                                                     &nbsp;&nbsp;
                                                                     <%=cnt++%> )&nbsp; <a href="${pageContext.servletContext.contextPath}/eBid/Bid/viewForm/${tblTender.tenderId}/${items.formId}/0/false">${items.formName } 
                                                                     <font color="red"> ${items.isCanceled eq 1 ? 'Cancelled' :''}</font></a>

																		</div>
                                                                     <div class="col-md-3">

                                                                    <c:if test="${items.isMandatory eq 1}">*</c:if>
                                                                    
                                                                    <br><h6>${fromStatus}</h6></div>
                                                                <div class="col-md-9">
                                                                     <c:if test="${isFormModificationAllow and (tblTender.cstatus eq 0 and empty corrigendumWorkflowList and isTenderWorkflowStarted ne true  or (workflowToInitiator eq true and tblTender.cstatus eq 0)) && workflowDone ne true}">
	                                                                    <c:choose>
					                                                		<c:when test="${items.isEncryptionReq ne 0  and items.isPriceBid eq 1}">
					                                                			<a href="javascript:"  onclick="alert('${msg_alert_delete_formula}')"><spring:message code="label_edit"/></a> |
					                                                		</c:when>
					                                                		<c:otherwise>
					                                                			<a href="${pageContext.servletContext.contextPath}/eBid/Bid/GetFormInfo/${tblTender.tenderId}/${items.formId}"><spring:message code="label_edit"/></a> |
					                                                		</c:otherwise>
					                                                	</c:choose>
                                                                     </c:if>
                                                                     <a href="${pageContext.servletContext.contextPath}/eBid/Bid/viewForm/${tblTender.tenderId}/${items.formId}/0/false">${viewlink}</a>

                                                                   
                                                                         <c:if test="${items.isPriceBid eq 1 && items.loadNoOfItems ne 0 && tblTender.cstatus eq 0}">

                                                                         |
                                                                            <c:if test ="${ items.isEncryptionReq eq 0}">
                                                                                <a href="${pageContext.servletContext.contextPath}/eBid/Bid/GetFormulaColumns/${tblTender.tenderId}/${items.formId}" > <spring:message code="label_Formula"/></a>   
                                                                            </c:if>

                                                                            <c:if test ="${ items.isEncryptionReq ne 0}">  
                                                                                  <a href="${pageContext.servletContext.contextPath}/eBid/Bid/GetFormulaColumns/${tblTender.tenderId}/${items.formId}" > <spring:message code="lbl_edit_formula" /></a>
                                                                             </c:if>

                                                                         </c:if>
                                                                      
                                                                         <c:if test="${items.isPriceBid eq 1 && tblTender.isItemwiseWinner eq 1 &&  empty openingDateOver}"> <!-- form should be mand one more cond-->
                                                                            |
                                                                            
                                                                                <a href="${pageContext.servletContext.contextPath}/eBid/Bid/getEvaluationColumn/${tblTender.tenderId}/${items.formId}" > 
                                                                                    <c:set var="evaluationColumnCount" value="0"/>
                                                                                    <c:forEach items="${evaluationMap}" var="entry">
                                                                                      
                                                                                        <c:if test="${entry.key eq items.formId}">
                                                                                            <c:if test="${entry.value gt 0}">
                                                                                                <c:set var="evaluationColumnCount" value="${evaluationColumnCount+1}"/>
                                                                                            </c:if>
                                                                                        </c:if>
                                                                                    </c:forEach>
                                                                                   
                                                                                    <c:if test="${evaluationColumnCount eq 0}">
                                                                                     <spring:message code="label_Evaluation"/>
                                                                                 </c:if>
                                                                                 <c:if test="${evaluationColumnCount gt 0}">
                                                                                     Edit Evaluation Column
                                                                                 </c:if>
                                                                                   
                                                                                </a> 
                                                                         </c:if>   
                                                                         
                                                                         <c:if test="${items.isPriceBid eq 1 && tblTender.isItemwiseWinner ne 1 && items.isMandatory eq 1  &&  empty openingDateOver }"> <!-- form should be mand one more cond-->      
                                                                              | <a href="${pageContext.servletContext.contextPath}/eBid/Bid/getPriceSumaryColumn/${tblTender.tenderId}/${items.formId}" >
                                                                                 
                                                                                 <c:set var="priceSummaryCount" value="0"/>
                                                                                 <c:forEach items="${priceSummaryMap}" var="entry">
                                                                                     <c:if test="${entry.key eq items.formId}">
                                                                                         <c:if test="${entry.value gt 0}">
                                                                                             <c:set var="priceSummaryCount" value="${priceSummaryCount+1}"/>
                                                                                         </c:if>
                                                                                     </c:if>
                                                                                 </c:forEach>
                                                                                 <c:if test="${priceSummaryCount eq 0}">
                                                                                     <spring:message code="lbl_create_price_summary" />
                                                                                 </c:if>
                                                                                 <c:if test="${priceSummaryCount gt 0}">
                                                                                    <spring:message code="lbl_edit_price_summary" />
                                                                                 </c:if>
                                                                                    </a>
                                                                         </c:if>
                                                                        <c:if test="${items.isDocumentReq eq 1 && items.isPriceBid eq 0 && tblTender.cstatus eq 0}">
                                                                         |

                                                                        <a href="${pageContext.servletContext.contextPath}/eBid/Bid/createFormDocument/${tblTender.tenderId}/${items.formId}" > <spring:message code="label_Document_upload"/></a>   
                                                                         </c:if>
                                                                                |  <a href="${pageContext.servletContext.contextPath}/eBid/Bid/GetFormInfoForTest/${tblTender.tenderId}/${items.formId}/0" ><spring:message code="lbl_test" /></a>   
                                                                           <c:if test="${tblTender.cstatus eq 0 && empty corrigendumWorkflowList && isTenderWorkflowStarted ne true  or (workflowToInitiator eq true and tblTender.cstatus eq 0)}">                                               
                                                                                | <a href="${pageContext.servletContext.contextPath}/eBid/Bid/DeleteForm/${tblTender.tenderId}/${items.formId}" onclick="return confirm('Are you sure you want to delete form?')" ><spring:message code="link_delete_corrigendum" /></a>
                                                                           </c:if>
                                                                           <!-- if form is published and not cancel then cancel link will not occure again, if tender is published and form is new created then delete link will occure -->
                                                                           <c:if test="${tblTender.cstatus eq 1 && not empty currentCorrigendum}">
                                                                            <c:choose>
	                                                                            <c:when test="${items.isCanceled ne 1 && items.cstatus eq 1 && ((tblTender.cstatus eq 1 && empty corrigendumWorkflowList && isTenderWorkflowStarted ne true)  or (workflowToInitiator eq true and tblTender.cstatus eq 1)) && workflowDone ne true}">
	                                                                            |   <a href="${pageContext.servletContext.contextPath}/eBid/Bid/CancelForm/${tblTender.tenderId}/${items.formId}"onclick="return confirm('Are you sure you want to cancel ?')" ><spring:message code="lbl_form_cancel" /></a>
	                                                                            </c:when> 
	                                                                            <c:when test="${items.isCanceled ne 1 && tblTender.cstatus eq 1}">
	                                                                            | <a href="${pageContext.servletContext.contextPath}/eBid/Bid/DeleteForm/${tblTender.tenderId}/${items.formId}"onclick="return confirm('Are you sure you want to delete ?')" ><spring:message code="link_delete_corrigendum" /></a>
	                                                                            </c:when>
                                                                            </c:choose> 
                                                                            </c:if>
                                                       
                                                                </div>
                                                              </c:if>
                                                              </div>
                                                                 <c:if test="${items.formId  eq -1}">
                                                                     <div class="col-md-9"><spring:message code="lbl_no_forms_mapped_wih_this_envelop" /> </div>
                                                                 </c:if>  
                                                            </div>

                                                                        
                                                                      <c:set value="${items.tblTenderEnvelope.envelopeId}" var="envId"/>
                                                         
                                                                 

                                                        </c:when>
							<c:otherwise>
                                                            <c:if test="${items.formId  ne -1}">
                                                         <div class="row border">
                                                            <c:set var="isFormModificationAllow" value="${((tblTender.cstatus eq 1 and items.cstatus eq 0) or tblTender.cstatus eq 0)}"/>
                                                            <div class="col-md-12 border">

                                                                <div class="col-md-3"><%=cnt++%>)&nbsp;
                                                                <a href="${pageContext.servletContext.contextPath}/eBid/Bid/viewForm/${tblTender.tenderId}/${items.formId}/0/false">${items.formName } <font color="red"> ${items.isCanceled eq 1 ? 'Cancelled' :''}</font></a>
                                                                 <c:if test="${items.isMandatory eq 1}">*</c:if>
                                                                   
                                                                <br><h6>${fromStatus}</h6></div>
                                                                <div class="col-md-9">
                                                                       <c:if test="${isFormModificationAllow and (empty corrigendumWorkflowList && isTenderWorkflowStarted ne true  or (workflowToInitiator eq true)) && workflowDone ne true}">
                                                                       
                                                                  	<c:choose>
                                                                  		<c:when test="${items.isEncryptionReq ne 0  and items.isPriceBid eq 1}">
                                                                  			<a href="javascript:"  onclick="alert('${msg_alert_delete_formula}')"><spring:message code="label_edit"/></a> |
                                                                  		</c:when>
                                                                  		<c:otherwise>
                                                                  			<a href="${pageContext.servletContext.contextPath}/eBid/Bid/GetFormInfo/${tblTender.tenderId}/${items.formId}"><spring:message code="label_edit"/></a> |
                                                                  		</c:otherwise>
                                                                  	</c:choose>
                                                                        

                                                                    </c:if>
                                                                     <a href="${pageContext.servletContext.contextPath}/eBid/Bid/viewForm/${tblTender.tenderId}/${items.formId}/0/false">${viewlink}</a>

                                                                    
                                                                        <c:if test="${items.isPriceBid eq 1 && items.loadNoOfItems ne 0 && isFormModificationAllow}">

                                                                         |
                                                                         <c:if test ="${ items.isEncryptionReq eq 0}">
                                                                            <a href="${pageContext.servletContext.contextPath}/eBid/Bid/GetFormulaColumns/${tblTender.tenderId}/${items.formId}" > <spring:message code="label_Formula"/></a>   
                                                                        </c:if>
                                                                                                                                                
                                                                          <c:if test ="${items.isEncryptionReq ne 0}">  
                                                                              <a href="${pageContext.servletContext.contextPath}/eBid/Bid/GetFormulaColumns/${tblTender.tenderId}/${items.formId}" > <spring:message code="lbl_edit_formula" /></a>  
                                                                         </c:if>
                                                                        </c:if>

                                                                       <c:if test="${items.isPriceBid eq 1 && tblTender.isItemwiseWinner eq 1 && empty openingDateOver}"> <!-- form should be mand one more cond-->
                                                                            |
                                                                            
                                                                                <a href="${pageContext.servletContext.contextPath}/eBid/Bid/getEvaluationColumn/${tblTender.tenderId}/${items.formId}" > 
                                                                                    <c:set var="evaluationColumnCount" value="0"/>
                                                                                    <c:forEach items="${evaluationMap}" var="entry">
                                                                                        <c:if test="${entry.key eq items.formId}">
                                                                                            <c:if test="${entry.value gt 0}">
                                                                                                <c:set var="evaluationColumnCount" value="${evaluationColumnCount+1}"/>
                                                                                            </c:if>
                                                                                        </c:if>
                                                                                    </c:forEach>
                                                                                    <c:if test="${evaluationColumnCount eq 0}">
                                                                                     <spring:message code="label_Evaluation"/>
                                                                                 </c:if>
                                                                                 <c:if test="${evaluationColumnCount gt 0}">
                                                                                    <spring:message code="lbl_edit_evaluation_column" />
                                                                                 </c:if>
                                                                                </a> 
                                                                         </c:if>   
                                                                           

                                                                         <c:if test="${items.isPriceBid eq 1 && tblTender.isItemwiseWinner ne 1 && items.isMandatory eq 1}"> <!-- form should be mand one more cond-->      

                                                                      
                                                                              | <a href="${pageContext.servletContext.contextPath}/eBid/Bid/getPriceSumaryColumn/${tblTender.tenderId}/${items.formId}" >
                                                                                 <c:set var="priceSummaryCount" value="0"/>
                                                                                 <c:forEach items="${priceSummaryMap}" var="entry">
                                                                                     <c:if test="${entry.key eq items.formId}">
                                                                                        <c:if test="${entry.value gt 0}">
                                                                                            <c:set var="priceSummaryCount" value="${priceSummaryCount+1}"/>
                                                                                        </c:if>
                                                                                     </c:if>
                                                                                 </c:forEach>
                                                                                 <c:if test="${priceSummaryCount eq 0}">
                                                                                    <spring:message code="lbl_create_price_summary" />
                                                                                 </c:if>
                                                                                 <c:if test="${priceSummaryCount gt 0}">
                                                                                    <spring:message code="lbl_edit_price_summary" />
                                                                                 </c:if>
                                                                                </a>
                                                                         </c:if>
                                                                          <c:if test="${items.isDocumentReq eq 1 && items.isPriceBid eq 0 && tblTender.cstatus ne 1}">
                                                                        |

                                                                        <a href="${pageContext.servletContext.contextPath}/eBid/Bid/createFormDocument/${tblTender.tenderId}/${items.formId}" > <spring:message code="label_Document_upload"/></a>   
                                                                        </c:if>
                                                                            |  <a href="${pageContext.servletContext.contextPath}/eBid/Bid/GetFormInfoForTest/${tblTender.tenderId}/${items.formId}/0"  ><spring:message code="lbl_test" /></a> 
                                                                             <c:if test="${(tblTender.cstatus ne 1 && empty corrigendumWorkflowList && isTenderWorkflowStarted ne true  or (workflowToInitiator eq true and tblTender.cstatus eq 0)) && workflowDone ne true}">                                               
                                                                            | <a href="${pageContext.servletContext.contextPath}/eBid/Bid/DeleteForm/${tblTender.tenderId}/${items.formId}"onclick="return2 confirm('Are you sure you want to delete ?')" ><spring:message code="link_delete_corrigendum" /></a>
                                                                            </c:if>
                                                                            <!-- if form is published and not cancel then cancel link will not occure again, if tender is published and form is new created then delete link will occure -->
                                                                            <c:if test="${tblTender.cstatus eq 1 && not empty currentCorrigendum}"> 
                                                                            <c:choose>
	                                                                            <c:when test="${items.isCanceled ne 1 && items.cstatus eq 1 && ((tblTender.cstatus eq 1 && empty corrigendumWorkflowList && isTenderWorkflowStarted ne true)  or (workflowToInitiator eq true and tblTender.cstatus eq 1)) && workflowDone ne true}">
	                                                                            |   <a href="${pageContext.servletContext.contextPath}/eBid/Bid/CancelForm/${tblTender.tenderId}/${items.formId}"onclick="return confirm('Are you sure you want to cancel ?')" ><spring:message code="lbl_form_cancel" /></a>
	                                                                            </c:when>
	                                                                            <c:when test="${items.isCanceled ne 1}">
	                                                                            | <a href="${pageContext.servletContext.contextPath}/eBid/Bid/DeleteForm/${tblTender.tenderId}/${items.formId}"onclick="return confirm('Are you sure you want to delete ?')" ><spring:message code="link_delete_corrigendum" /></a>
	                                                                            </c:when>
                                                                            </c:choose>
                                                                            </c:if> 
                                                                </div>
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
		</div>
		</div>
			</div>
		</div>
	</div>
  </div>
</div>
	
<c:if test="${tblTender.tenderMode eq 2 or tblTender.tenderMode eq 3}">
<div class="row">
  <div class="col-md-12">
	<div class="box">
		<div class="box-header with-border">
			<div class="col-md-3"><h3 class="box-title"><a><spring:message code="field_bidder"/></a></h3>
		</div>
		<div class="col-md-9">
			<c:if test="${isSingleEnvelopeOpened eq false}">
				<c:set var="encParamBidderMap" value="${pageContext.servletContext.contextPath}/etender/buyer/biddermapping/${tblTender.tenderId}" />
            	<a href="${pageContext.servletContext.contextPath}/etender/buyer/biddermapping/${tblTender.tenderId}?enc=${util:encryptParam(encParamBidderMap)}"><spring:message code="lbl_mapbidder"/> </a>
				|
            </c:if>	
            <a href="${pageContext.servletContext.contextPath}/etender/buyer/viewmappedbidders/${tblTender.tenderId}"><spring:message code="title_heading_tender_viewmappedbidder"/> </a>
        </div>
		</div>
	</div>
  </div>
</div>
</c:if>
<c:if test="${tblTender.isPreBidMeeting eq 1}">
<div class="row">
	<div class="col-md-12">
		<div class="box">
			<div class="box-header with-border" data-toggle="collapse" href="#preBid">
				<h3 class="box-title"><a>Prebid Committee</a></h3>
			</div>
			<div class="box-body">
				<div class="row">
					<div id="preBid" class="panel-collapse">
				    	<div class="row border">
				    		<div class="col-md-3"><spring:message code="var_page_title" /></div>
				            <div class="col-md-9">
				            	<c:choose>
				            		<c:when test="${tblTender.cstatus eq 0}">
						            		<c:if test="${prebidCommitteeId eq 0}">
								            	<a href="${pageContext.servletContext.contextPath}/etender/buyer/getcreatecommitee/${tenderId}">${createlink}</a> 
								            </c:if>
								            <c:if test="${prebidCommitteeId ne 0}">
								            	<a href="${pageContext.servletContext.contextPath}/etender/buyer/geteditcommitee/${tenderId}/${prebidCommitteeId}">${editlink}</a> |
												<a href="${pageContext.servletContext.contextPath}/etender/buyer/getviewcommitee/${tenderId}/${prebidCommitteeId}/3">${viewlink}</a> 
											</c:if>
						            </c:when>
						            <c:otherwise>
						            	<c:choose>
							            	<c:when test="${prebidEndDateOver ne true}">
							            		<c:if test="${prebidCommitteeId eq 0}">
									            	<a href="${pageContext.servletContext.contextPath}/etender/buyer/getcreatecommitee/${tenderId}">${createlink}</a> 
									            </c:if>
									            <c:if test="${prebidCommitteeId ne 0}">
									            	<a href="${pageContext.servletContext.contextPath}/etender/buyer/geteditcommitee/${tenderId}/${prebidCommitteeId}">${editlink}</a> |
													<a href="${pageContext.servletContext.contextPath}/etender/buyer/getviewcommitee/${tenderId}/${prebidCommitteeId}/3">${viewlink}</a> 
												</c:if>
							            	</c:when>
							            	<c:otherwise>
							            		<a href="${pageContext.servletContext.contextPath}/etender/buyer/getviewcommitee/${tenderId}/${prebidCommitteeId}/3">${viewlink}</a> 
							            	</c:otherwise>
						            	</c:choose>
						            </c:otherwise>
				            	</c:choose>
				            </div>
							<c:if test="${prebidCommitteeId ne 0 and prebidlive eq true}">	 
							<form class="form" action="${pageContext.servletContext.contextPath}/etender/buyer/publishprebidmom" method="post" id="publishPrebidMOM">
								<input type="hidden" name="hdTenderId" value="${tenderId}" />
								<input type="hidden" name="hdPrebidCommitteeId" value="${prebidCommitteeId}" />
							</form>	            
				             <div class="col-md-3"><spring:message code="lbl_prebid_publish_meeting"/></div>
				             <div class="col-md-9"><a href="${pageContext.servletContext.contextPath}/etender/buyer/gettendertabcontent/${tenderId}/3">Upload </a> |
				             <a href="#" onclick="javascript:{return publishMOM();}" id="publishPrebidMOMLnk"><spring:message code="label_publish"/></a></div>
				             </c:if>
						</div>
					</div>
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
				<h3 class="box-title">Tender Opening Committee</h3>
			</div>
			<div class="box-body">
				<div class="row">
					<div class="col-md-12">
						<div class="row">
							<div class="col-md-3">Tender Opening Committee</div>
				<div class="col-md-9">
					<c:choose>
		            	<c:when test="${isSingleEnvelopeOpened eq false}">
		            		<c:if test="${openingCommitteeId eq 0}">
								<a href="${pageContext.servletContext.contextPath}/etender/buyer/createcommittee/${tenderId}/1">${createlink}</a> |
							</c:if>
							<c:if test="${openingCommitteeId ne 0 and isSingleEnvelopeOpened eq false}">
				            	<a href="${pageContext.servletContext.contextPath}/etender/buyer/editcommittee/${tenderId}/1/1">${editlink}</a> |
								<a href="${pageContext.servletContext.contextPath}/etender/buyer/getviewcommitee/${tenderId}/${openingCommitteeId}/1">${viewlink}</a> 
							</c:if>
		            	</c:when>
		            	<c:otherwise>
		            		<a href="${pageContext.servletContext.contextPath}/etender/buyer/getviewcommitee/${tenderId}/${openingCommitteeId}/1">${viewlink}</a> |
		            	</c:otherwise>
	            	</c:choose>
					<c:choose>
						<c:when test="${tblTender.cstatus eq '1' and submissionDateOver eq true}">
							<a href="${pageContext.servletContext.contextPath}/etender/buyer/gettabcontent/${tenderId}/1">Opening Consent</a>
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

<div class="row">
	<div class="col-md-12">
		<div class="box">
			<div class="box-header with-border">
				<h3 class="box-title"><a><spring:message code="tab_tender_evaluatebid"/> Committee</a></h3>
			</div>
			<div class="box-body">
				<div class="row">
				<div class="col-md-12">
					<div class="row">
						<div class="col-md-3"><spring:message code="tab_tender_evaluatebid"/> Committee</div>
				<div class="col-md-9">
		            <c:choose>
		            	<c:when test="${isSingleEnvelopeIsEvaluated eq false}">
			            	<c:if test="${evaluationCommitteeId eq 0}">
			            		<a href="${pageContext.servletContext.contextPath}/etender/buyer/createcommittee/${tenderId}/2">${createlink}</a> |
			            	</c:if>
			            	<c:if test="${evaluationCommitteeId ne 0}">
				            	<a href="${pageContext.servletContext.contextPath}/etender/buyer/editcommittee/${tenderId}/2/1">${editlink}</a> |
								<a href="${pageContext.servletContext.contextPath}/etender/buyer/getviewcommitee/${tenderId}/${evaluationCommitteeId}/2">${viewlink}</a>
							</c:if>    
						</c:when>
						<c:otherwise>
							<a href="${pageContext.servletContext.contextPath}/etender/buyer/getviewcommitee/${tenderId}/${evaluationCommitteeId}/2">${viewlink}</a> 
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${tblTender.cstatus eq '1' and tblTender.isEvaluationDone eq 0 and submissionDateOver eq true}">
							| <a href="${pageContext.servletContext.contextPath}/etender/buyer/gettabcontent/${tenderId}/2">Evaluation Consent</a>
						</c:when>
						<c:when test="${tblTender.cstatus eq '1' and tblTender.isEvaluationDone eq 1 and submissionDateOver eq true}">
							| <a href="${pageContext.servletContext.contextPath}/etender/buyer/gettabcontent/${tenderId}/2">Evaluated</a>
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
<!-- work flow start -->	

<c:if test="${tblTender.isWorkflowRequired eq 1 }">	
<div class="row">
	<div class="col-md-12">
		<div class="box">
			<div class="box-header with-border" data-toggle="collapse" href="#workFlow">
				<h3 class="box-title"><a><spring:message code="label_workflow" /></a></h3>
			</div>
			<div class="box-body">
				<div class="row">
							<div id="workFlow" class="panel-collapse">
			<div class="row border">
				<div class="col-md-3"><spring:message code="label_notice_workflow" /></div>
				<div class="col-md-9">
				<c:choose>
				<c:when test="${allowToCreateWorkflow && tblTender.cstatus eq 0}"><!-- if workflow is not stated or approval is done -->
	            	<a href="${pageContext.servletContext.contextPath}/etender/buyer/viewtenderworkflow/${tenderId}/0" onclick="return validatePublishTender(${tblTender.tenderId})">${createlink}</a>
	            </c:when>
            	<c:when test="${not empty workflowToMe && tblTender.cstatus eq 0}">
					<a href="${pageContext.servletContext.contextPath}/etender/buyer/viewtenderworkflow/${tenderId}/0">${workflow_pending}</a>
				</c:when>
        		<c:when test="${isTenderWorkflowStarted}">
	        		<a href="${pageContext.servletContext.contextPath}/etender/buyer/viewtenderworkflow/${tenderId}/0">${viewlink}</a>
        		</c:when>
	            </c:choose>
	          	</div>
			</div>
			<c:if test="${tblTender.cstatus eq 1 && not empty tblCorrigendum && not empty corrigendumWorkflowList}">
			<c:forEach items="${corrigendumWorkflowList}" var="corrigendumWorkflow" varStatus="indx">
			<div class="row border">
				<div class="col-md-3">Workflow Corrigendum  ${indx.count}</div>
				<div class="col-md-9">
				<c:choose>
					<c:when test="${corrigendumWorkflow.corrigendumAllowToCreateWorkflow}"><!-- if workflow is not stated or approval is done -->
		            	<a href="${pageContext.servletContext.contextPath}/etender/buyer/viewtenderworkflow/${tenderId}/${corrigendumWorkflow.corrigendumId}">${createlink}</a>
		            </c:when>
	            	<c:when test="${corrigendumWorkflow.corrigendumWorkflowToMe}">
						<a href="${pageContext.servletContext.contextPath}/etender/buyer/viewtenderworkflow/${tenderId}/${corrigendumWorkflow.corrigendumId}">${workflow_pending}</a>
					</c:when>
	        		<c:when test="${corrigendumWorkflow.isCorrigendumWorkflowStarted}">
	        		<a href="${pageContext.servletContext.contextPath}/etender/buyer/viewtenderworkflow/${tenderId}/${corrigendumWorkflow.corrigendumId}">${viewlink}</a>
	        		</c:when>    	
	            </c:choose>
	          	</div>
			</div>
			</c:forEach>
			</c:if>
		</div>
				</div>
			</div>
		</div>
	</div>
</div>
</c:if>
<!-- work flow end -->
<c:if test="${tblTender.isBidConverted eq 0 and tblTender.biddingType eq 2 and tblTender.cstatus ne 2 and isdecryptionlevelStarted }">
<div class="row">
	<div class="col-md-12">
		<div class="box">
	        <div class="box-header with-border">
				<div class="col-md-3"><h3 class="box-title"><a><spring:message code="lbl_currency_conversion" /></a></h3></div>
				<div class="col-md-9">
					<c:if test="${tblTender.cstatus eq '1' and  submissionDateOver eq true}">
	                   <a href="${pageContext.servletContext.contextPath}/eBid/Bid/convertBidderBid/${tenderId}"><spring:message code="lbl_bid_conversion" /></a>
	                </c:if>
	            </div>
	        </div>
		</div>
	</div>
</div>
</c:if>
<!-- Tender Result -->
<c:if test="${tblTender.cstatus eq '1' and tblTender.isEvaluationDone eq 1 and ((tblTender.isBidConverted ne 0 && tblTender.biddingType eq 2) or (tblTender.isBidConverted eq 0 && tblTender.biddingType eq 1))}">
<div class="row">
	<div class="col-md-12">
		<div class="box">
  		<div class="box-header with-border">
        	<div class="col-md-3"><h3 class="box-title"><a>Tender Result</a></h3></div>
        	<div class="col-md-9">
        	<c:set value="${isResultShareDone}" var="isResultShareConfigured"/>
        		<c:if test="${tblTender.autoResultSharing eq '1' and !isResultShareConfigured}">
        			<spring:url value="/etender/buyer/getresultsharing/${tenderId}/1" var="urlConfigure"/>
					<a href="${urlConfigure}">Configure</a>
        		</c:if>
        		<c:if test="${tblTender.autoResultSharing eq '1' and isResultShareConfigured}">
        			<a href="${pageContext.servletContext.contextPath}/etender/buyer/getresultsharing/${tblTender.tenderId}/2">View Result Sharing</a> |
        			<a href="${pageContext.servletContext.contextPath}/etender/buyer/getresult/${tblTender.tenderId}">Result</a>
        		</c:if>
        		<c:if test="${tblTender.autoResultSharing eq '0'}">
        			<a href="${pageContext.servletContext.contextPath}/etender/buyer/getresult/${tblTender.tenderId}">Result</a>
        		</c:if>
        	</div>
      	</div>
	  </div>
	</div>
</div>
</c:if>
<c:if test="${poId gt 0}">
<div class="row">
	<div class="col-md-12">
		<div class="box">
			<div class="box-header with-border" data-toggle="collapse" href="#purchaseOrder">
				<h3 class="box-title"><a>Purchase order</a></h3>
			</div>
			<div class="box-body">
				<div class="row">
							<div id="purchaseOrder" class="panel-collapse">
			<div class="row border">
				<div class="col-md-3">Purchase order</div>
				<div class="col-md-9">
					<c:choose>
							<c:when test="${tblTender.cstatus eq '1'}">
								<a href="${pageContext.servletContext.contextPath}/etender/buyer/getpurchaseorderdashboard/${tenderId}/${poId}">Dashboard</a>
							</c:when>
							<c:otherwise>
								
							</c:otherwise>
					</c:choose>
				</div>
	          	</div>
			</div>
				</div>
			</div>
		</div>
	</div>
</div>
</c:if>
</c:if>
</section>


 
 <c:if test="${isAuction eq 1}">
 
<%--      <a href="${pageContext.servletContext.contextPath}/eBid/Bid/auctionListing" class="pull-right"><< Go To Auction List</a> --%>
	<%@include file="AuctionSummary.jsp"%>

	<div class="row">
		<div class="col-md-12">
			<div class="box">
				<div class="box-header with-border" data-toggle="collapse" href="#collapse1">
					<h3 class="box-title">
						<a><spring:message code="label_notice_document" /></a>
					</h3>
				</div>
				<div class="box-body">
					<div class="row">
						<div class="col-md-12">
							      <div id="collapse1" class="panel-collapse">
				<div class="row">
					<div class="col-md-3"><spring:message code="lbl_auction_notice" /></div>
					<div class="col-md-9">
						<c:choose>
							<c:when test="${tblTender.cstatus eq '0'}">
								<c:if test="${tblTender.isWorkflowRequired eq 0 or isTenderWorkflowStarted ne true or (workflowToInitiator eq true and workflowDone ne true)}">
								<a href="${pageContext.servletContext.contextPath}/eBid/Bid/createAuction/${tblTender.tenderId}"><spring:message code="label_edit" /> </a> | 
								</c:if> 
								<c:choose>
									<c:when test="${tblTender.isWorkflowRequired eq 0 or (tblTender.isWorkflowRequired eq 1 && workflowDone eq true && workflowToInitiator eq true)}">
										&nbsp;<a href="${pageContext.servletContext.contextPath}/etender/buyer/publishtender/${tblTender.tenderId}" onclick="return validatePublishTender(${tblTender.tenderId})"><spring:message code="label_workflow_approve" /></a> |
									</c:when>
								</c:choose>								
                                                                &nbsp;<a href="${pageContext.servletContext.contextPath}/eBid/Bid/viewAuction/${tblTender.tenderId}/0">${viewlink}</a>&nbsp;|
                                                                 
                                                        </c:when>
							<c:otherwise>
								<a href="${pageContext.servletContext.contextPath}/eBid/Bid/viewAuction/${tblTender.tenderId}/0">${viewlink}</a>&nbsp;
                                                                <c:if test="${tblTender.cstatus eq '1'}">
                                                                  |
                                                                &nbsp;<a href="${pageContext.servletContext.contextPath}/etender/Bid/loginReport/${tblTender.tenderId}">Login Report</a>
                                            
                                                                </c:if>             </c:otherwise>
						</c:choose>
					</div>
				</div>
                                <c:if test="${tblTender.cstatus ne 2}">
				<div class="row">
					<div class="col-md-3"><spring:message code="lbl_auction_document" />
					</div>
					<div class="col-md-9">
					<a href="${pageContext.servletContext.contextPath}/etender/buyer/tendernitdocument/${tblTender.tenderId}/0"><spring:message code="title_upload_documents" /></a>
					</div>
				</div>
                                </c:if>
<%
     TblTender tblTender=(TblTender)request.getAttribute("tblTender");
     SimpleDateFormat dateFormatGmt = new SimpleDateFormat("yyyy-MMM-dd HH:mm:ss");
     dateFormatGmt.setTimeZone(TimeZone.getTimeZone("GMT"));
     SimpleDateFormat dateFormatLocal = new SimpleDateFormat("yyyy-MMM-dd HH:mm:ss");
     %>				
     <%
     
      if(tblTender.getAuctionEndDate().after(dateFormatLocal.parse( dateFormatGmt.format(new Date()))))
      {
      %>
       <c:if test="${tblTender.cstatus eq 1}">
				<div class="row">
					<div class="col-md-3"><spring:message code="lbl_cancel_auction" />
					</div>
					<div class="col-md-9">
                        <a href="${pageContext.servletContext.contextPath}/etender/buyer/getcanceltender/${tblTender.tenderId}" onclick="return confirm('Are You Sure You Want Cancel the Auction')"><spring:message code="lbl_cancel_auction" /></a>
					</div>
				</div>
			</c:if>
      <%
      }
     %>
				
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
				<div class="box-header with-border" data-toggle="collapse" href="#Bid">
					<h3 class="box-title">
						<a><spring:message code="var_page_title_biddingForm" /></a>
					</h3>
				</div>
				<div class="box-body">
					<div class="row">
						<div class="col-md-12">
							      	<div id="Bid" class="panel-collapse">
	    	<div class="row border">
	    		<div class="col-md-3"><spring:message code="var_page_title_biddingForm" /></div>
	            <div class="col-md-9">
                        <c:set var="formcount" value="0"/>
                        <c:if test="${not empty biddingForm }">
                            <c:forEach items="${biddingForm}" var="item">
                                 <c:if test="${item.formId != -1}">
                                     <c:set var="formcount" value="${formcount+1}"/>
                                 </c:if>
                                 
                            </c:forEach>
                        </c:if>
                        <c:if test="${formcount eq 0}">
                        <c:set var="count" value="0"/>
                        <c:if test="${not empty biddingForm }">
                            <c:forEach items="${biddingForm}" var="item">
                                <c:if test="${count eq 0}" >
                                   <c:if test="${item.formId eq -1}">
                                       
                                    <a href="${pageContext.servletContext.contextPath}/eBid/Bid/createForm/${tenderId}" >${createlink}</a>
                                      | <a href="${pageContext.servletContext.contextPath}/eBid/Bid/getFormLibrary/${tenderId}"><spring:message code="title_tender_formlibrary" /></a>
                                      <c:set var="count" value="${count+1}"/>
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
                                            <c:if test="${((tblTender.cstatus eq 1 and items.cstatus eq 0) or tblTender.cstatus eq 0) and (tblTender.isWorkflowRequired eq 0 or isTenderWorkflowStarted ne true or (workflowToInitiator eq true and workflowDone ne true))}">
                                        		<c:choose>
                                                		<c:when test="${items.isEncryptionReq ne 0  and items.isPriceBid eq 1}">
                                                			<a href="javascript:"  onclick="alert('${msg_alert_delete_formula}')">33333333<spring:message code="label_edit"/></a> |
                                                		</c:when>
                                                		<c:otherwise>
                                                			<a href="${pageContext.servletContext.contextPath}/eBid/Bid/GetFormInfo/${tblTender.tenderId}/${item.formId}"><spring:message code="label_edit"/></a> |   
                                                		</c:otherwise>
                                                	</c:choose>
                                            </c:if>
                                        <a href="${pageContext.servletContext.contextPath}/eBid/Bid/viewForm/${tblTender.tenderId}/${item.formId}/0/false">${viewlink}</a>
                                        
                                        |<a href="${pageContext.servletContext.contextPath}/eBid/Bid/GetFormInfoForTest/${tblTender.tenderId}/${item.formId}/0"><spring:message code="lbl_test" /></a>
                                        <c:if test="${tblTender.isWorkflowRequired eq 0 or isTenderWorkflowStarted ne true or (workflowToInitiator eq true and workflowDone ne true)}">
                                         <c:if test="${tblTender.cstatus eq 0}">
                                                   <c:if test ="${ item.isEncryptionReq eq 0}">
                                                       |<a href="${pageContext.servletContext.contextPath}/eBid/Bid/GetFormulaColumns/${tblTender.tenderId}/${item.formId}" > <spring:message code="label_Formula"/></a>   
                                                   </c:if>

                                                   <c:if test ="${  item.isEncryptionReq ne 0}">  
                                                        | <a href="${pageContext.servletContext.contextPath}/eBid/Bid/GetFormulaColumns/${tblTender.tenderId}/${item.formId}" > Edit Formula</a>  
                                                   </c:if>
                                         </c:if>
                                        
                                        <c:if test="${item.cstatus ne 2 && workflowDone ne true && (tblTender.cstatus eq 0 && empty corrigendumWorkflowList && isTenderWorkflowStarted ne true  or (workflowToInitiator eq true and tblTender.cstatus eq 0))}">
                                            |	<a href="${pageContext.servletContext.contextPath}/eBid/Bid/DeleteForm/${tblTender.tenderId}/${item.formId}" onclick="return confirm('Are you sure you want to delete form?')"><spring:message code="link_delete_corrigendum" /></a>
                                        </c:if>
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
					</div>
				</div>
			</div>
		</div>
   </div>

<c:if test="${tblTender.biddingAccess eq 0}"> 
   <div class="row">
		<div class="col-md-12">
			<div class="box">
				<div class="box-header with-border" data-toggle="collapse" href="#bidOpening">
					<h3 class="box-title">
						<h4 class="panel-title"><a><spring:message code="lbl_map_bidders" /></a></h4>
					</h3>
				</div>
				<div class="box-body">
					<div class="row">
						<div class="col-md-12">
									<div id="bidOpening" class="panel-collapse">
			
				<div class="row border">
					<div class="col-md-3"><spring:message code="field_bidder"/>
					</div>
					<div class="col-md-9">
                                            <c:if test="${tblTender.cstatus ne 1 && tblTender.cstatus ne 2}">
                                                    <a href="${pageContext.servletContext.contextPath}/etender/buyer/biddermapping/${tblTender.tenderId}"><spring:message code="lbl_bidder_mapping" />	</a>|
        					
						</c:if>
						 <a href="${pageContext.servletContext.contextPath}/etender/buyer/viewmappedbidders/${tblTender.tenderId}"><spring:message code="lbl_mapped_bidders" /></a>
						
						
					</div>
				</div>
			
		</div>
						</div>
					</div>
				</div>
			</div>
		</div>
   </div>
</c:if>           
<!-- work flow start -->
<c:if test="${tblTender.isWorkflowRequired eq 1}">	
<div class="row">
	<div class="col-md-12">
		<div class="box">
			<div class="box-header with-border" data-toggle="collapse" href="#workFlow">
				<h3 class="box-title"><a><spring:message code="label_workflow" /></a></h3>
			</div>
			<div class="box-body">
				<div class="row">
							<div id="workFlow" class="panel-collapse">
			<div class="col-lg-12">
			<div class="row">
				<div class="col-md-3"><spring:message code="label_notice_workflow" /></div>
				<div class="col-md-9">
				<c:choose>
				<c:when test="${allowToCreateWorkflow}"><!-- if workflow is not stated or approval is done -->
	            	<a href="${pageContext.servletContext.contextPath}/etender/buyer/viewtenderworkflow/${tenderId}/0" onclick="return validatePublishTender(${tblTender.tenderId})">${createlink}</a>
	            </c:when>
            	<c:when test="${not empty workflowToMe}">
					<a href="${pageContext.servletContext.contextPath}/etender/buyer/viewtenderworkflow/${tenderId}/0">${workflow_pending}</a>
				</c:when>
        		<c:when test="${isTenderWorkflowStarted}">
	        		<a href="${pageContext.servletContext.contextPath}/etender/buyer/viewtenderworkflow/${tenderId}/0">${viewlink}</a>
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
</c:if>
<!-- Workflow end -->
     
   
       
     <c:if test="${tblTender.cstatus eq 1}">
     
     <div class="row">
		<div class="col-md-12">
			<div class="box">
				<div class="box-header with-border" data-toggle="collapse" href="#bidOpening">
					<h3 class="box-title"><a><spring:message code="field_view_rslt" />	</a></h3>
				</div>
				<div class="box-body">
					<div class="row">
						<div class="col-md-12">
									<div id="bidOpening" class="panel-collapse">
			
				<div class="row border">
					<div class="col-md-3"><spring:message code="tab_tender_reports" />	
					</div>
					<div class="col-md-9">
                                           <%
                                               if((tblTender.getAuctionStartDate().equals(dateFormatLocal.parse( dateFormatGmt.format(new Date())))  ||  tblTender.getAuctionStartDate().before(dateFormatLocal.parse( dateFormatGmt.format(new Date())))) && tblTender.getAuctionEndDate().after(dateFormatLocal.parse(dateFormatGmt.format(new Date()))))
                                           {
                                               %>
						<a href="${pageContext.servletContext.contextPath}/eBid/Bid/viewAuctionResult/${tblTender.tenderId}">
                                                    <c:if test="${tblTender.isAuctionStop eq 1}"><spring:message code="lbl_resume_auction" />	</c:if>
                                                    <c:if test="${tblTender.isAuctionStop eq 0}"><spring:message code="lbl_stop_auction" /></c:if>
                                                   
                                                </a>
                                            <%
                                           }
                                           if(tblTender.getAuctionEndDate().before(dateFormatLocal.parse( dateFormatGmt.format(new Date()))))
                                           {
                                           %>
                                          
                                           <a href="${pageContext.servletContext.contextPath}/eBid/Bid/viewResult/${tblTender.tenderId}">
                                                    
                                                    <c:if test="${tblTender.isAuctionStop eq 0}"><spring:message code="lbl_view_result" /></c:if>
                                                   
                                                </a>
                                           <%
                                           }
                                           %>
						
						
					</div>
				</div>
			
		</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	 </div>

     </c:if>
      
 </c:if>
 
 <div id="targetDiv"></div>
</div>
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
	//create dialog, but keep it closed
		$("#targetDiv").dialog({  
		   autoOpen: false,
		   height: 300,
		   width: 700,
		   modal: true
		});

		function showDialog(url){  //load content and open dialog
		    $("#targetDiv").load(url);
		    $("#targetDiv").dialog("open");         
		}
		
// 		    $('#publishPrebidMOMLnk').click(function(e) {
// 		        e.preventDefault();
		        
// 		    });
 });
 
 function publishMOM(){
	 $('#publishPrebidMOM').submit();
 }
 
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