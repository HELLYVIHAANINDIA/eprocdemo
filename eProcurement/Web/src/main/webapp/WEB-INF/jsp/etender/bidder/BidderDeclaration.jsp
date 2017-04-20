<%@include file="../../includes/head.jsp"%>
        <%@include file="../../includes/masterheader.jsp"%>

<%@page import="java.util.Calendar"%>
<%@page import="java.util.TimeZone"%>
<%@page import="com.eprocurement.etender.model.TblTender"%>

<spring:message code="msg_iagreed" var="iagreedMsg"/>         	
<spring:message code="lbl_back_dashboard" var='backDashboard'/>
<spring:message code="lbl_declaration" var='lblDeclaration'/>

<div class="content-wrapper">

<section class="content-header">
<h1 class="inline"></h1>
					<a href="${pageContext.servletContext.contextPath}/etender/bidder/biddingTenderDashboard/${tenderId}" class="g g-back">
                                            <c:if test="${tblTender.isAuction eq 0}">
                                                << ${backDashboard}
                                            </c:if>
                                             <c:if test="${tblTender.isAuction eq 1}">
                                                << <spring:message code="lbl_go_back_to_auction_dashboard" />
                                            </c:if>
                    </a>
</section>

<div id="error" style="display: none">
    <div class="alert alert-danger" id="err_msg">
 <spring:message code="lbl_time_over_terms_and_conditions" />
</div>
</div>

	<section class="content">
	
	<div class="row">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			<div class="">
                                    <c:if test="${tblTender.isAuction eq 0}">
                                        <%@include file="../buyer/TenderSummary.jsp"%>
                                    </c:if>
                                    <c:if test="${tblTender.isAuction eq 1}">
                                        <%@include file="../buyer/AuctionSummary.jsp"%>
                                    </c:if>				
				<c:if test="${not empty successMsg}">
					<div><span class="alert alert-success"><spring:message code="${successMsg}"/></span></div>
				</c:if>
				<c:if test="${not empty errorMsg}">
					<div><span class="alert alert-danger"><spring:message code="${errorMsg}"/></span></div>
				</c:if>
			</div>
		</div>
	</div>
	
	<div class="row">
	<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
	<div class="box">
	
	<div class="box-header with-border">
		<h3 class="box-title"><label class="black">${lblDeclaration}</label></h3>
	</div>
	
	<div class="box-body">
	
		<div class="row">
	
		<spring:url value="/etender/bidder/bidderIagree" var="postUrl"/>						
        <form:form method="post" action="${postUrl}" onsubmit="return validationForConfirmation()">
        
        					<div class="col-lg-12 col-md-12 col-xs-12">
                            <input type="hidden" name="hdIsConsortiumAllowed" value="${isConsortiumAllowed}"/>
                            <input type="hidden" name="hdClientBidTermId" value="${clientBidTermId}"/>
                            <input type="hidden" name="hdTenderId" value="${tenderId}"/>
                            
                            <c:if test="${isRepeated}">
								<div class="successMsg">${iagreedMsg}</div>
                            </c:if>
							<c:if test="${!isRepeated}">
                                <input type="checkbox" name="chkTerms" value="1" class="checkbox" style="float: left; margin-right: 10px; margin-top: 8px;">
                            </c:if>
                            <div style="line-height: 30px;">${conditionForBidder}</div>								
							</div>
								
                                <c:if test="${listOfCurrency ne null and not empty listOfCurrency}">
                                  
                                            <c:choose>
                                            
                                                <c:when test="${!isRepeated}">                                               
                                                 <div class="col-lg-1 col-md-1 col-xs-1" style="margin-top:20px;">
                                                    <spring:message code="lab_bid_curr" />
                                                 </div>
                                                 
                                                 <div class="col-lg-1 col-md-1 col-xs-1" style="margin-top:20px;">
                                        				<c:forEach items="${listOfCurrency}" var="item" varStatus="counter">
                                        					<c:choose>
                                        					<c:when test="${counter.index eq 0}">
                                        						<input type="radio" name="rdCurrency" value="${item[0]}" checked="checked" style="float: left; margin-right: 5px;"/><span style="float: left; margin-top:2px;">${item[1]}</span>
                                        					</c:when> 
                                        					<c:otherwise>
                                        						<input type="radio" name="rdCurrency" value="${item[0]}" style="float: left; margin-right: 5px;"/><span style="float: left; margin-top:2px;">${item[1]}</span>
                                        					</c:otherwise>
                                        					</c:choose>
                                        					
                                        				</c:forEach>
                                        		 </div>                                        		 
                                                </c:when>
                                                
                                                <c:otherwise>
                                                   <div class="col-lg-12 col-md-12 col-xs-12"> <b><spring:message code="lab_bid_curr" />:</b> ${selectedCurrency}  </div>
                                                </c:otherwise>
                                                
                                            </c:choose>
                                     
                                </c:if>
                                
                                <c:if test="${!isRepeated and isAtleastOneFormApproved}"><%-- at least one form should be approved --%>
									<div class="col-lg-12 col-md-12 col-xs-12">
                                        	<c:choose>
                                            	<c:when test="${err_iagree_config_pending ne null}">
                                                	<div style="border:1px solid #b0c1c9; margin-top:10px; padding: 10px; color: red; font-size: 16px;"><spring:message code="${err_iagree_config_pending}"/></div>
                                              	</c:when>
                                              	<c:otherwise>
                                                <c:if test="${tblTender.isAuction eq 0}">
                                                	<c:choose>
                                                            
                                                    	<c:when test="${err_bidsub_dt ne null}">
                                                        	<div style="border:1px solid #b0c1c9; margin-top:10px; padding: 10px; color: red; font-size: 16px;"><spring:message code="${err_bidsub_dt}"/></div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div><button type="submit" class="btn btn-submit" disabled="disabled" id="btnIAgree" ><spring:message code='btn_iagree'/></button></div>
                                                        </c:otherwise>
													</c:choose>
                                                </c:if>
                                                <c:if test="${tblTender.isAuction eq 1}">
                                                <%
                                                TblTender tblTender=(TblTender)request.getAttribute("tblTender");
                                                Calendar cal=Calendar.getInstance(TimeZone.getTimeZone("UTC"));
                                                
                                              //  if(tblTender.getAuctionStartDate().before(cal.getTime())){
                                                %>
                                               <%--<div style="border:1px solid #374850;font-style:italic;"><font color="green">Bid Submission Date Is Not Arrived</font></div>
                                               <%
                                                }
                                                else
                                                {
                                                %>--%>
                                                 <div><button type="submit" class="btn btn-submit" disabled="disabled" id="btnIAgree" ><spring:message code='btn_iagree'/></button></div>
                                          <%--<%
                                                }
                                                %>--%>
                                                
                                                          
                                               
                                                       
                                                       
                                                </c:if>
												</c:otherwise>
                                          	</c:choose>
                                       </div>
                                </c:if>
                           
         </form:form>
                    	
</div>
</div>
</div>
</div>
</div>
	
</section>
	
</div>
<fmt:formatDate value="${tblTender.auctionEndDate}" var="formattedDate" type="date" pattern="dd/MM/yyyy HH:mm:ss" />
<script type="text/javascript">
		$(function() {
	        $('.checkbox').click(function() {
	            if ($(this).is(':checked')) {
	                $('#btnIAgree').removeAttr('disabled');
	            } else {
	                $('#btnIAgree').attr('disabled', 'disabled');
	            }
	        });
	    });
            function validationForConfirmation(){
               var isAuction = '${tblTender.isAuction}';
               // alert('in fum');
               var status=false;
               if(isAuction=='1'){
                $.ajax({
                   url:'${pageContext.servletContext.contextPath}/eBid/Bid/validateBiddingTime/${tblTender.tenderId}',
                   async:false,
                   success:function(result){
       // alert(result);
                       if(result === 'false')
                       {
                          // alert('in false');
                           $('#error').show();
                           status=false;
                       }
                       else
                       {
                           $('#error').hide();
                           status=true;
                       }
                       
                   },
                   error:function(result){
                     //  alert('in error');
                       status=false;
                   }
                });       
               }else{
            	   status=true;
               } 
              return status; 
            }
            
</script>
<script src="${pageContext.servletContext.contextPath}/resources/js/jquery-ui.min.js"></script>
<%@include file="../../includes/footer.jsp"%>
