<%@include file="./../includes/head.jsp"%>
	<c:if test="${1 ne fromPublishTender && 2 ne fromPublishTender}">

<%@include file="./../includes/masterheader.jsp"%>
</c:if>
<c:if test="${fromPublishTender eq 2}">
	<%@include file="../includes/headerWithoutLogin.jsp"%>
</c:if>
	
	<spring:message code="client_dateformate_hhmm" var="client_dateformate_hhmm"/>
<%@page import="com.eprocurement.etender.model.TblTender"%>
<%
    TblTender tblTender=new TblTender();
    tblTender=(TblTender)request.getAttribute("tblTender");
   
%>	
	<%-- <script src="${pageContext.request.contextPath}/resources/js/ckeditor.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/config.js"></script>
	 --%>
	
	<div class="content-wrapper">
	
            <section class="content-header">
               <h1 class="inline"><spring:message code="lbl_view_auction"/> <small></small></h1>
               <c:if test="${fromPublishTender ne 2}">
                   <c:if test="${sessionUserTypeId eq 2}">
                  <a href="${pageContext.servletContext.contextPath}/etender/bidder/bidderTenderListing/1" class="g g-back"><< <spring:message code="lbl_go_to_auction_listing" /></a>
               </c:if>
               </c:if>
               
               <c:if test="${sessionUserTypeId ne 2}">
                  <a onclick="window.history.back();" style="cursor: pointer" class="g g-back"><< <spring:message code="lbl_go_back_to_auction_dashboard" /></a>
               </c:if>
                  <c:if test="${fromPublishTender eq 2}">
         		
				<a href="${pageContext.servletContext.contextPath}/login" class="g g-back"><< <spring:message code="lbl_go_to_login" /></a>
			</c:if>
            </section>
            
            <section class="content">
            
            	<div class="row">
                        <div class="col-lg-12 col-md-12">
                            <div class="box">
                                <div class="box-header with-border">
                                	<h3 class="box-title"><spring:message code="lbl_view_auction_detail" /></h3>
                                </div>
                                <div class="box-body">
                                    <div class="row">
                                    	<div class="col-xs-2"><label class="lbl-1"><spring:message code="lbl_department" /></label></div>
                                    	<div class="col-xs-2"><label class="lbl-2">${DepartmentName}</label></div>
                                    	<div class="col-xs-2"><label class="lbl-1"><spring:message code="lbl_department_officer" /></label></div>
                                    	<div class="col-xs-2"><label class="lbl-2">${OfficerName}</label></div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-2"><label class="lbl-1"><spring:message code="lbl_auction_id" /></label></div>
                                    	<div class="col-xs-2"><label class="lbl-2">${tblTender.tenderId}</label></div>
                                    	<div class="col-xs-2"><label class="lbl-1"><spring:message code="lbl_auction_no" /></label></div>
                                    	<div class="col-xs-2"><label class="lbl-2">${tblTender.tenderNo}</label></div>
                                    	<div class="col-xs-2"><label class="lbl-1"><spring:message code="lbl_types_of_contract" /></label></div>
                                    	<div class="col-xs-2"><label class="lbl-2">${procurementNature}</label></div>
                                    </div>
                                    <div class="row">
                                    	<div class="col-xs-2"><label class="lbl-1"><spring:message code="lbl_brief_scope_of_work" /></label></div>
                                    	<div class="col-xs-10"><label class="lbl-2">${tblTender.tenderBrief}</label></div>
                                    	<div class="col-xs-2"><label class="lbl-1"><spring:message code="lbl_auction_details" /></label></div>
                                    	<div class="col-xs-10"><label class="lbl-2">${tblTender.tenderDetail}</label></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                </div>
                
                <div class="row">
                        <div class="col-lg-12 col-md-12">
                            <div class="box">
                                <div class="box-header with-border">
                                	<h3 class="box-title"><spring:message code="lbl_documnet_fees_detail" /></h3>
                                </div>
                                <div class="box-body">
                                	<div class="row">
                                    	<div class="col-xs-2"><label class="lbl-1"><spring:message code="lbl_document_details" /></label></div>
                                    	<div class="col-xs-2"><label class="lbl-2">
                                    	<c:set var="optDocFees" value="Dont' Allow"/>
                                                                <c:if test="${tblTender.isDocfeesApplicable eq 1}">
                                                                    <c:set var="optDocFees" value="Allow"/>
                                                                </c:if>
                                                                <c:if test="${tblTender.isDocfeesApplicable eq 0}">
                                                                    <c:set var="optDocFees" value="Dont' Allow"/>
                                                                </c:if>
                                                                ${optDocFees}
                                    	</label></div>
                                    	<div id="DocumentFees">
                                    	<div class="col-xs-2"><label class="lbl-1"><spring:message code="lbl_document_details" /></label></div>
                                    	</div>
                                    	<div class="col-xs-2"><label class="lbl-2">
                                    	<c:set var="DocFees" value="N.A."/>
                                                                   <c:if test="${tblTender.isDocfeesApplicable eq 1}">
                                                                        <c:set var="DocFees" value="${tblTender.documentFee}"/>
                                                                    </c:if>
                                                                    <c:if test="${tblTender.isDocfeesApplicable eq 0}">
                                                                        <c:set var="DocFees" value="N.A."/>
                                                                    </c:if>
                                                                   ${DocFees}
                                    	</label></div>
                                    	<div class="col-xs-2"><label class="lbl-1"><spring:message code="lbl_document_fees_payable" /></label></div>
                                    	<div class="col-xs-2"><label class="lbl-2">
                                    		<c:if test="${tblTender.docFeePaymentAddress eq ' '}">
                                                                            -
                                                                        </c:if>
                                                                        <c:if test="${tblTender.docFeePaymentAddress ne ' '}">
                                                                           ${tblTender.docFeePaymentAddress} 
                                                                        </c:if>
                                    	</label></div>
                                    </div>
                                    
                                    <div class="row">
                                    	<div class="col-xs-2"><label class="lbl-1"><spring:message code="lbl_pariticipation_fees" /></label></div>
                                    	<div class="col-xs-2"><label class="lbl-2">
                                    	<c:set var="optPartFees" value="Dont' Allow"/>
                                                                <c:if test="${tblTender.isParticipationFeesBy eq 1}">
                                                                    <c:set var="optPartFees" value="Allow"/>
                                                                </c:if>
                                                                <c:if test="${tblTender.isParticipationFeesBy eq 0}">
                                                                    <c:set var="optPartFees" value="Dont' Allow"/>
                                                                </c:if>
                                                                ${optPartFees}
                                    	</label></div>
                                    	<div id="ParticipatonFees">
                                    	<div class="col-xs-2"><label class="lbl-1"><spring:message code="lbl_pariticipation_fees" /></label></div>
                                    	</div>
                                    	<div class="col-xs-2"><label class="lbl-2">
                                    	<c:set var="partFees" value="N.A."/>
                                                                   <c:if test="${tblTender.isParticipationFeesBy eq 1}">
                                                                        <c:set var="partFees" value="${tblTender.participationFees}"/>
                                                                    </c:if>
                                                                    <c:if test="${tblTender.isParticipationFeesBy eq 0}">
                                                                        <c:set var="partFees" value="N.A."/>
                                                                    </c:if>
                                                                   ${partFees}
                                    	</label></div>
                                    	<div class="col-xs-2"><label class="lbl-1"><spring:message code="lbl_participation_fees_payable" /></label></div>
                                    	<div class="col-xs-2"><label class="lbl-2">
                                    	<c:if test="${tblTender.participationFeesPaymentAddress eq ' '}">
                                                                            -
                                                                        </c:if>
                                                                        <c:if test="${tblTender.participationFeesPaymentAddress ne ' '}">
                                                                           ${tblTender.participationFeesPaymentAddress} 
                                                                        </c:if>
                                    	</label></div>
                                    </div>
                                    <div class="row">
                                    	<c:set var="optEMDFees" value="Dont' Allow"/>
                                                                <c:if test="${tblTender.EMDRequired eq 1}">
                                                                    <c:set var="optEMDFees" value="Allow"/>
                                                                </c:if>
                                                                <c:if test="${tblTender.EMDRequired eq 0}">
                                                                    <c:set var="optEMDFees" value="Dont' Allow"/>
                                                                </c:if>
                                    	<div class="col-xs-2"><label class="lbl-1"><spring:message code="lbl_emd_required" /></label></div>
                                    	<div class="col-xs-2"><label class="lbl-2">${optEMDFees}</label></div>
                                    	<div id='EMDfees'>
                                    	<div class="col-xs-2"><label class="lbl-1"><spring:message code="lbl_emd_fees" /></label></div>
                                    	</div>
                                    	<div class="col-xs-2"><label class="lbl-2">
                                    	<c:set var="EMDFees" value="N.A."/>
                                                                   <c:if test="${tblTender.EMDRequired eq 1}">
                                                                        <%=tblTender.getEMDFees() %>
                                                                    </c:if>
                                                                    <c:if test="${tblTender.EMDRequired eq 0}">
                                                                        <c:set var="EMDFees" value="N.A."/>
                                                                         ${EMDFees}
                                                                    </c:if>
                                    	</label></div>
										<div class="col-xs-2"><label class="lbl-1"><spring:message code="lbl_emd_fees_payable" /></label></div>
                                    	<div class="col-xs-2"><label class="lbl-2">
                                    	<c:if test="${tblTender.emdPaymentAddress eq ' '}">
                                                                            -
                                                                        </c:if>
                                                                        <c:if test="${tblTender.emdPaymentAddress ne ' '}">
                                                                           ${tblTender.emdPaymentAddress} 
                                                                        </c:if>
                                    	</label></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                </div>
                
                <div class="row">
                        <div class="col-lg-12 col-md-12">
                            <div class="box">
                                <div class="box-header with-border">
                                	<h3 class="box-title"><spring:message code="lbl_bid_submission_config" /></h3>
                                </div>
                                <div class="box-body">
                                	<div class="row">
                                    	<div class="col-xs-2"><label class="lbl-1"><spring:message code="lbl_bid_submission" /></label></div>
                                    	<div class="col-xs-2"><label class="lbl-2"><spring:message code="lbl_grand_total" /></label></div>
                                    	<c:set var="rdobiddingType" value="Global"/>
                                                                <c:if test="${tblTender.biddingType eq 2}">
                                                                    <c:set var="rdobiddingType" value="Global"/>
                                                                </c:if>
                                                                <c:if test="${tblTender.biddingType eq 1}">
                                                                    <c:set var="rdobiddingType" value="Domestic"/>
                                                                </c:if>
                                    	<div class="col-xs-2"><label class="lbl-1"><spring:message code="lbl_bidding_type" /></label></div>
                                    	<div class="col-xs-2"><label class="lbl-2">${rdobiddingType}</label></div>
                                    </div>
                                    <div class="row">
                                    	<div class="col-xs-2"><label class="lbl-1"><spring:message code="lbl_bidding_access" /></label></div>
                                    	<c:set var="rdoBiddingAccess" value="Open"/>
                                                                <c:if test="${tblTender.biddingAccess eq 1}">
                                                                    <c:set var="rdoBiddingAccess" value="Open"/>
                                                                </c:if>
                                                                <c:if test="${tblTender.biddingAccess eq 0}">
                                                                    <c:set var="rdoBiddingAccess" value="Limited"/>
                                                                </c:if>
                                    	<div class="col-xs-2"><label class="lbl-2">${rdoBiddingAccess}</label></div>
                                    	<div class="col-xs-2"><label class="lbl-1"><spring:message code="lbl_base_currency" /></label></div>
                                    	<div class="col-xs-2"><label class="lbl-2">${BaseCurrency}</label></div>
                                    	<c:if test="${tblTender.biddingType eq 2}">
                                    	<div class="col-xs-2"><label class="lbl-1"><spring:message code="lbl_bid_currency" /></label></div>
                                    	<div class="col-xs-2"><label class="lbl-2">${BaseCurrency}${BidCurrency}</label></div>
                                    	</c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                </div>
                
                <div class="row">
                        <div class="col-lg-12 col-md-12">
                            <div class="box">
                                <div class="box-header with-border">
                                	<h3 class="box-title"><spring:message code="title_key_conf" /></h3>
                                </div>
                                <div class="box-body">
                                	<div class="row">
                                    	<div class="col-xs-2"><label class="lbl-1"><spring:message code="lbl_auction_method" /></label></div>
                                    	<c:set var="rdoAuctionMethod" value="Forward"/>
                                                                <c:if test="${tblTender.auctionMethod eq 1}">
                                                                    <c:set var="rdoAuctionMethod" value="Forward"/>
                                                                </c:if>
                                                                <c:if test="${tblTender.auctionMethod eq 0}">
                                                                    <c:set var="rdoAuctionMethod" value="Reverse"/>
                                                                </c:if>
                                    	<div class="col-xs-2"><label class="lbl-2">${rdoAuctionMethod}</label></div>
                                    	<c:set var="rdoAuctionVariant" value="Standard"/>
                                                                <c:if test="${tblTender.biddingVariant eq 1}">
                                                                    <c:set var="rdoAuctionVariant" value="Standard"/>
                                                                </c:if>
                                                                <c:if test="${tblTender.biddingVariant eq 0}">
                                                                    <c:set var="rdoAuctionVariant" value="Rank"/>
                                                                </c:if>
                                    	<div class="col-xs-2"><label class="lbl-1"><spring:message code="lbl_auction_variant" /></label></div>
                                    	<div class="col-xs-2"><label class="lbl-2">${rdoAuctionVariant}</label></div>
                                    </div>
                                    <div class="row">
                                    	<div class="col-xs-2"><label class="lbl-1"><spring:message code="lbl_start_price" /></label></div>
                                    	<div class="col-xs-2"><label class="lbl-2">${tblTender.startPrice}</label></div>
                                    	<div class="col-xs-2"><label class="lbl-1"><spring:message code="lbl_product_location" /></label></div>
                                    	<div class="col-xs-2"><label class="lbl-2">${tblTender.productLocation}</label></div>
                                    </div>
                                    <div class="row">
                                    	<div class="col-xs-2"><label class="lbl-1"><spring:message code="lbl_auction_reverse_price" /></label></div>
                                    	<div class="col-xs-2"><label class="lbl-2">
                                    	<c:if test="${tblTender.isReservePriceConfigure eq 0}">
                                                                         <spring:message code="lbl_na" />
                                                                     </c:if>
                                                                     <c:if test="${tblTender.isReservePriceConfigure eq 1}">
                                                                         ${tblTender.auctionReservePrice}
                                                                     </c:if>
                                    	</label></div>
                                    	<div class="col-xs-2"><label class="lbl-1">
                                    	<c:if test="${tblTender.auctionMethod eq 1}">
                                                                  <spring:message code="lbl_increment_value" />
                                                                </c:if>
                                                                <c:if test="${tblTender.auctionMethod eq 0}">
                                                                     <spring:message code="lbl_decrement_vallue" />
                                                                </c:if>
                                    	</label></div>
                                    	<div class="col-xs-2"><label class="lbl-2">${tblTender.incrementDecrementValues}</label></div>
                                    </div>
                                    <div class="row">
                                    	<div class="col-xs-2"><label class="lbl-1"><spring:message code="lbl_auto_extension" /></label></div>
                                    	<c:set var="rdoAutoExtension" value="No"/>
                                                                <c:if test="${tblTender.allowsAutoExtension eq 1}">
                                                                    <c:set var="rdoAutoExtension" value="Yes"/>
                                                                </c:if>
                                                                <c:if test="${tblTender.allowsAutoExtension eq 0}">
                                                                    <c:set var="rdoAutoExtension" value="No"/>
                                                                </c:if>
                                    	<div class="col-xs-2"><label class="lbl-2">${rdoAutoExtension}</label></div>
                                    	<div class="col-xs-2"><label class="lbl-1"></label></div>
                                    	<div class="col-xs-2"><label class="lbl-2"></label></div>
                                    </div>
                                    
                                    <c:if test="${tblTender.allowsAutoExtension eq 1}">
                                    
                                    <div id="AutoExtension">
                                    
                                    <div class="row">
                                    	<div class="col-xs-2"><label class="lbl-1"><spring:message code="lbl_extend_time_when_bid_received" /></label></div>
                                    	<div class="col-xs-2"><label class="lbl-2">${tblTender.extendTimeWhen}</label></div>
                                    	<div class="col-xs-2"><label class="lbl-1"><spring:message code="lbl_extend_time" /></label></div>
                                    	<div class="col-xs-2"><label class="lbl-2">${tblTender.extendTimeBy}</label></div>
                                    </div>
                                    
                                    <div class="row">
                                    	<div class="col-xs-2"><label class="lbl-1"><spring:message code="lbl_auto_extension_mode" /></label></div>
                                    	<c:set var="rdoAutoExtensionMode" value="Unlimited"/>
                                                                <c:if test="${tblTender.autoExtensionMode eq 1}">
                                                                    <c:set var="rdoAutoExtensionMode" value="Limited"/>
                                                                </c:if>
                                                                <c:if test="${tblTender.autoExtensionMode eq 0}">
                                                                    <c:set var="rdoAutoExtensionMode" value="Unlimited"/>
                                                                </c:if>
                                    	<div class="col-xs-2"><label class="lbl-2">${rdoAutoExtensionMode}</label></div>
                                    </div>
                                    
                                    </div>
                                    
                                    </c:if>
                                    
                                    <c:if test="${tblTender.autoExtensionMode eq 1}">
                                    <div id="AutoExtensionMode">
                                    <div class="row">
                                    	<div class="col-xs-2"><label class="lbl-1"><spring:message code="lbl_no_of_extension" /></label></div>
                                    	<div class="col-xs-2"><label class="lbl-2"><%=tblTender.getNoOfExtension()%></label></div>
                                    </div>
                                    </div> 
                                    </c:if>
                                    
                                    <div class="row">
                                    	<div class="col-xs-2"><label class="lbl-1"><spring:message code="lbl_accept_decimal_value_upto" /></label></div>
                                    	<div class="col-xs-2"><label class="lbl-2">${tblTender.decimalValueUpto}</label></div>
                                    	<div class="col-xs-2"><label class="lbl-1"></label></div>
                                    	<div class="col-xs-2"><label class="lbl-2"></label></div>
                                    </div>
                                    
                                    <c:set var="optIPAddress" value="No"/>
                                                                <c:if test="${tblTender.displayIPAddress eq 1}">
                                                                    <c:set var="optIPAddress" value="Yes"/>
                                                                </c:if>
                                                                <c:if test="${tblTender.displayIPAddress eq 0}">
                                                                    <c:set var="optIPAddress" value="No"/>
                                    </c:if>
                                    
                                    <div class="row">
                                    	<div class="col-xs-2"><label class="lbl-1"><spring:message code="lbl_display_ip_address" /></label></div>
                                    	<div class="col-xs-2"><label class="lbl-2">${optIPAddress}</label></div>
                                    	<div class="col-xs-2"><label class="lbl-1"><spring:message code="lbl_estimated_value" /></label></div>
                                    	<div class="col-xs-2"><label class="lbl-2">
                                    	 <%
                                                        
                                                        int num=(int)tblTender.getestimatedValue();
                                                        float remain=tblTender.getestimatedValue()-num;
                                                       //out.println("remain::"+remain);
                                                        if(remain==0)
                                                        {
                                                        %>
                                                            <%=num%>
                                                        <%
                                                        }
                                                        else
                                                        {
                                                        %>
                                                            ${tblTender.estimatedValue}
                                                        <%
                                                        }
                                                        %>
                                    	</label></div>
                                    </div>
                                    
                                </div>
                            </div>
                        </div>
                </div>
                
                <c:if test="${fromPublishTender ne 1}">
                 <div class="row">
                        <div class="col-lg-12 col-md-12">
                            <div class="box">
                                <div class="box-header with-border">
                                	<h3 class="box-title"><spring:message code="lbl_dates_config" /></h3>
                                </div>
                                <div class="box-body">
                                	<div class="row">
                                    	<div class="col-xs-2"><label class="lbl-1"><spring:message code="lbl_auction_start_date" /></label></div>
                                    	<div class="col-xs-2"><label class="lbl-2">
                                    	<fmt:parseDate value="${auctionStartDate}" pattern="${client_dateformate_hhmm}" var="myDate"/>                                                        
                                        <fmt:formatDate value="${myDate}" var="formattedDate"  type="date" pattern="${client_dateformate_hhmm}" />
                                    	${formattedDate}
                                    	</label></div>
                                    	<fmt:parseDate value="${auctionEndDate}" pattern="${client_dateformate_hhmm}" var="myDate"/>
                                        <fmt:formatDate value="${myDate}" var="formattedDate" type="date" pattern="${client_dateformate_hhmm}" />
                                    	<div class="col-xs-2"><label class="lbl-1"><spring:message code="lbl_auction_end_date" /></label></div>
                                    	<div class="col-xs-2"><label class="lbl-2">${formattedDate}</label></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                 </div>
                </c:if>                                                                                                             	
</section>

</div>
<c:if test="${2 eq fromPublishTender}"><%-- for before login --%>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/_all-skins.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/template1/css/style.css">
</c:if>

<jsp:useBean id="now" class="java.util.Date" />
<script src="${pageContext.servletContext.contextPath}/resources/js/jquery-ui.min.js"></script>
<c:if test="${1 ne fromPublishTender && 2 ne fromPublishTender}">
<%@include file="../includes/footer.jsp"%>
</c:if>
