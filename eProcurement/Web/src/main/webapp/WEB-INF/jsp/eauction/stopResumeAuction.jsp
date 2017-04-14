
<%@include file="./../includes/head.jsp"%>
<%@include file="./../includes/masterheader.jsp"%>

	<%@page import="com.eprocurement.etender.model.TblTender"%>
            <section class="content-header">
               <h1><spring:message code="lbl_stop_resume_auction_form" /> <small></small></h1>
            </section>

            
            <section class="content">
        
                                    <a href="${pageContext.servletContext.contextPath}/eBid/Bid/auctionListing"><< <spring:message code="lbl_go_to_auction_list" /></a>
                                    <%@include file="../etender/buyer/AuctionSummary.jsp"%>
                                    <div class="box-header with-border box-primary">
                                        <div class="col-md-12 " >
                                            <h3>
                                                <c:if test="${tblTender.isAuctionStop eq 1}">
                                                   <spring:message code="lbl_resume_auction" />
                                                </c:if>
                                                    <c:if test="${tblTender.isAuctionStop ne 1}">
                                                    <spring:message code="lbl_stop_auction" />
                                                </c:if>
                                                </h3>
                                        </div>
                                    <%--<div class="col-md-6 text-right" >
                                                 <a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}" ><< Go Back To DashBord
                                                 </a>
                                        </div>--%>
                                    </div>
                                        <form action="${pageContext.servletContext.contextPath}/eBid/Bid/stopResumeAuction" method="post">
                                            <div class="box-body">
                                            <div class="row">
                                                    <div class="col-lg-12 col-md-12 col-xs-12">
                                                        <div class="row well" >
                                                            <div class="col-lg-2">
                                                                <div class="form_filed"><spring:message code="lbl_remark" /></div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <textArea rows="10" cols="50" class="form-control" id="auctionstopremark" name="auctionstopremark" ></textArea>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <input type="hidden" name="tendreId" value="${tenderId}">
                                                            <input type="hidden" name="auctionStartDate" value="${auctionStartDate}">
                                                            <input type="hidden" name="auctionEndDate" value="${auctionEndDate}">
                                                            <input type="hidden" name="isAuctionStop" value="${tblTender.isAuctionStop}">
                                                            <div class="col-lg-12 text-center">
                                                            <c:if test="${tblTender.isAuctionStop eq 1}">
                                                                <div class="row well">
                                                                    <div class="col-lg-2">
                                                                        <div class="form_filed"><spring:message code="lbl_new_auction_start_date" /></div>
                                                                    </div>
                                                                    <div class="col-lg-4">
                                                                        <input id="txtAuctionStartDate" name="txtAuctionStartDate" type="text"  
                                                                             datepicker="yes" dtrequired="true" 
                                                                             placeholder="${client_dateformate_hhmm}" 
                                                                             class="dateBox pull-left form-control">
                                                                    </div>
                                                                    <div class="col-lg-2">
                                                                        <div class="form_filed"><spring:message code="lbl_new_auction_end_date" /></div>
                                                                    </div>
                                                                    <div class="col-lg-4">
                                                                        <input id="txtDocumentEndDate" name="txtAuctionEndDate"   type="text"  
                                                                             datepicker="yes" dtrequired="false" 
                                                                             placeholder="${client_dateformate_hhmm}" 
                                                                             class="dateBox pull-left form-control">
                                                                    </div>
                                                                </div>
                                                                <button type="submit" class="btn btn-submit" id="btnSubmitForm"><spring:message code="lbl_resume_auction" /></button>
                                                            </c:if>
                                                            <c:if test="${tblTender.isAuctionStop eq 0}">
                                                                <button type="submit" class="btn btn-submit" id="btnSubmitForm"><spring:message code="lbl_stop_auction" /></button>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div> 
                                    </form>
                                
        
            </section>
            
      
        <script>
            $(function(){
                $(".dateBox").each(function(){
		    $(this).datetimepicker({
		       format:'d-M-Y H:i'
		    });
		});
            });
        </script>
<script src="${pageContext.servletContext.contextPath}/resources/js/jquery-ui.min.js"></script>
        <%@include file="../includes/footer.jsp"%>

        
