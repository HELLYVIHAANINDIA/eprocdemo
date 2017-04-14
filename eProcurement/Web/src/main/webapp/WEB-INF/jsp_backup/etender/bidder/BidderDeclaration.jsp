<!DOCTYPE html>
<html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../../includes/header.jsp"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script src="${pageContext.servletContext.contextPath}/resources/js/jquery-ui.min.js"></script>
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
            function validationForConfirmation()
            {
               // alert('in fum');
                $.ajax({
                   url:'${pageContext.servletContext.contextPath}/eBid/Bid/validateBiddingTime/${tblTender.tenderId}',
                   async:false,
                   success:function(result){
                      // alert(result);
                       if(result === 'false')
                       {
                          // alert('in false');
                           $('#error').show();
                           return false;
                       }
                       else
                       {
                           $('#error').hide();
                           return true;
                       }
                       
                   },
                   error:function(result){
                     //  alert('in error');
                       return false;
                   }
                });       
                 
               
            }
            
</script>
</head>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="../../includes/leftaccordion.jsp"%>

<div class="content-wrapper">

<spring:message code="msg_iagreed" var="iagreedMsg"/>         	
<spring:message code="lbl_back_dashboard" var='backDashboard'/>
<spring:message code="lbl_declaration" var='lblDeclaration'/>
<div id="error" style="display: none">
    <div class="alert alert-danger" id="err_msg">
 		Bidding Time over, you cannot accept Terms and Conditions now
	</div>
</div>

<section class="content-header">
	<a href="${pageContext.servletContext.contextPath}/etender/bidder/biddingTenderDashboard/${tenderId}" class="btn btn-submit">
   		<c:if test="${tblTender.isAuction eq 0}">
      		<< ${backDashboard}
   		</c:if>
   		<c:if test="${tblTender.isAuction eq 1}">
      		<< Go To Auction DashBoard
   		</c:if>
	</a>
</section>

	<section class="content">
	   <div class="row">
		  <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			<div class="box">	
				<c:if test="${not empty successMsg}">
					<div><span class="alert alert-success"><spring:message code="${successMsg}"/></span></div>
				</c:if>
				<c:if test="${not empty errorMsg}">
					<div><span class="alert alert-danger"><spring:message code="${errorMsg}"/></span></div>
				</c:if>
				<div class="box-header with-border">
					<h3 class="box-title">${lblDeclaration}</h3>
				</div>
				<div class="box-body">
					<div class="row">
						<div class="col-lg-12 col-md-12 col-xs-12">
						<spring:url value="/etender/bidder/bidderIagree" var="postUrl"/>						
                                                <form:form   method="post" action="${postUrl}" onsubmit="return validationForConfirmation()" >
                            <input type="hidden" name="hdIsConsortiumAllowed" value="${isConsortiumAllowed}"/>
                            <input type="hidden" name="hdClientBidTermId" value="${clientBidTermId}"/>
                            <input type="hidden" name="hdTenderId" value="${tenderId}"/>
                            
                                <table class="table table-striped table-responsive">
                                <c:if test="${isRepeated}">
                                    <tr>
                                        <td>
                                            <div class="successMsg">${iagreedMsg}</div>
                                        </td>
                                    </tr>
                                </c:if>
                                    <tr>
                                        <td>
                                            <ol>
                                            	<c:if test="${!isRepeated}">
                                            	<input type="checkbox" name="chkTerms" value="1" class="checkbox">
                                            	</c:if>
                                                ${conditionForBidder}
                                            </ol>
                                        </td>
                                    </tr>
                               </table>
                                <c:if test="${listOfCurrency ne null and not empty listOfCurrency}">
                                  
                                            <c:choose>
                                                <c:when test="${!isRepeated}">
                                                 <div class="col-lg-12 col-md-12 col-xs-12">
                                                    <spring:message code="lab_bid_curr" />
                                                    </div>
                                                     <div class="col-lg-12 col-md-12 col-xs-12">
<!--                                                     <select class="form-control"  name="selBidCurrencyId" id="selBidCurrencyId"> -->
                                        				<c:forEach items="${listOfCurrency}" var="item"> 
                                        					<input type="radio" name="rdCurrency" value="${item[0]}"/>${item[1]}
                                        				</c:forEach>
                                        				  </div>
<!--                                         			</select> -->
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
                                                	<div style="border:1px solid #374850;"><font color="green"><spring:message code="${err_iagree_config_pending}"/></font></div>
                                              	</c:when>
                                              	<c:otherwise>
                                                	<c:choose>
                                                    	<c:when test="${err_bidsub_dt ne null}">
                                                        	<div style="border:1px solid #374850;font-style:italic;"><font color="green"><spring:message code="${err_bidsub_dt}"/></font></div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div><button type="submit" class="btn btn-submit" disabled="disabled" id="btnIAgree" ><spring:message code='btn_iagree'/></button></div>
                                                        </c:otherwise>
													</c:choose>
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
	  </div>
	</section>
</div>

</div>

</body>

</html>
