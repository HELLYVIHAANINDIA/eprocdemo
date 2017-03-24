<!DOCTYPE html>
<html>
<%@page import="com.eprocurement.etender.model.TblTender"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<%@include file="../includes/header.jsp"%>
<script src="${pageContext.request.contextPath}/resources/js/tender/tendercreate.js"></script>
<script src="${pageContext.servletContext.contextPath}/resources/js/jQuery/jquery.datetimepicker.js"></script>
<script src="${pageContext.servletContext.contextPath}/resources/js/blockUI.js" type="text/javascript"></script>
<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/resources/css/jquery.datetimepicker.css">
<%
                                                              TblTender tblTender=new TblTender();
                                                              tblTender=(TblTender)request.getAttribute("tblTender");
                                                              %>	
<script src="${pageContext.servletContext.contextPath}/resources/js/jquery-ui.min.js"></script>
</head>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="../includes/leftaccordion.jsp"%>
	 
	<div class="content-wrapper">
	
            <section class="content-header">
               <h1>View Auction <small></small></h1>
            </section>
            
            <section class="content">
               
                    <div class="row">
                        <div class="col-lg-12 col-md-12">
                            <div class="box">
                                <div class="box-header with-border">
                                    <div class="col-md-6" >
                                        
                                    </div>
                                    <div class="col-md-6 text-right" >
                                        <a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}" ><< Go Back To DashBord
                                        </a>
                                     </div>
                                </div>
                                <div class="box-body">
                                    <div class="row">
                                        <div class="col-lg-12 col-md-12 col-xs-12">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <div class="well"><h3>View Auction Detail</h3></div>
                                                </div>
                                            </div>
                                            <div class="row">
                                               <div class="col-lg-2">
                                                   <div class="form_filed">Department:</div>
                                               </div>
                                               <div class="col-lg-2">
                                                <div class="form_filed">${DepartmentName}</div>
                                               </div>
                                               <div class="col-lg-2"></div>
                                               
                                               <div class="col-lg-2">
                                                    <div class="form_filed">Department Officer:</div>
                                               </div>
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">${OfficerName}</div></div>
                                                            
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Auction No:</div>
                                                            </div>
                                                            <div class="col-lg-2">
                                                               <div class="form_filed">${tblTender.tenderNo}</div>
                                                            </div>
                                                            <div class="col-lg-2"></div>
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Types of contract :</div>
                                                            </div>
                                                            <c:set var="Type_of_contract" value="${['Goods','Service','Works','Turnkey Project','Others']}"/>
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">${Type_of_contract[tblTender.contractTypeId-1]}</div>                                                           
                                                            </div>
                                                             <div class="col-lg-2"></div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Brief Scope Of Work:</div>
                                                            </div>
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">${tblTender.tenderBrief}</div>
                                                            </div>
                                                            <div class="col-lg-8"></div>
                                                        </div>
                                                         <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Auction Details:</div>
                                                            </div>
                                                            <div class="col-lg-2">
                                                                
                                                                    <div class="form_filed">${tblTender.tenderDetail}</div>
                                                                        
                                                            </div>
                                                             <div class="col-lg-8"></div>
                                                            
                                                        </div>
                                                                    <div class="row">
                                                <div class="col-lg-12">
                                                    <div class="well"><h3>Document/EMD/Participation Fees Detail </h3></div>
                                                </div>
                                            </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Document Fees:</div>
                                                            </div>
                                                            <div class="col-lg-2">
                                                                <c:set var="optDocFees" value="Dont' Allow"/>
                                                                <c:if test="${tblTender.isDocfeesApplicable eq 1}">
                                                                    <c:set var="optDocFees" value="Allow"/>
                                                                </c:if>
                                                                <c:if test="${tblTender.isDocfeesApplicable eq 0}">
                                                                    <c:set var="optDocFees" value="Dont' Allow"/>
                                                                </c:if>
                                                                <div class="form_filed">${optDocFees}</div>
                                                                                                                           
                                                            </div>
                                                                <div class="col-lg-2"></div>
                                                            <div id="DocumentFees">
                                                                <div class="col-lg-2">
                                                                <div class="form_filed">Document Fees:</div>
                                                            </div>
                                                            <div class="col-lg-2">
                                                               <div class="form_filed">${tblTender.documentFee}</div>                                                          
                                                            </div>
                                                                <div class="col-lg-2"></div>
                                                                
                                                            </div>
                                                            
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Participation Fees:</div>
                                                            </div>
                                                            <div class="col-lg-2">
                                                            <c:set var="optPartFees" value="Dont' Allow"/>
                                                                <c:if test="${tblTender.isParticipationFeesBy eq 1}">
                                                                    <c:set var="optPartFees" value="Allow"/>
                                                                </c:if>
                                                                <c:if test="${tblTender.isParticipationFeesBy eq 0}">
                                                                    <c:set var="optPartFees" value="Dont' Allow"/>
                                                                </c:if>
                                                                <div class="form_filed">${optPartFees}</div>

                                                            
                                                                                                                         
                                                            </div>
                                                                <div class="col-lg-2"></div>
                                                            <div id="ParticipatonFees">
                                                                <div class="col-lg-2">
                                                                <div class="form_filed">Participaton Fees:</div>
                                                            </div>
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">${tblTender.participationFees}</div>                                                       
                                                            </div>
                                                                <div class="col-lg-2"></div>
                                                            </div>
                                                             <c:set var="optEMDFees" value="Dont' Allow"/>
                                                                <c:if test="${tblTender.EMDRequired eq 1}">
                                                                    <c:set var="optEMDFees" value="Allow"/>
                                                                </c:if>
                                                                <c:if test="${tblTender.EMDRequired eq 0}">
                                                                    <c:set var="optEMDFees" value="Dont' Allow"/>
                                                                </c:if>
                                                       
                                                        </div>
                                                             <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">EMD Required:</div>
                                                            </div>
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">${optEMDFees}</div>
                                                            </div>
                                                            <div class="col-lg-2"></div>
                                                            <div id='EMDfees'>
                                                                <div class="col-lg-2">
                                                                <div class="form_filed">EMD Fees:</div>
                                                            </div>
                                                            <div class="col-lg-2">
                                                                <div class="form_filed"><%=tblTender.getEMDFees() %></div>                                                    
                                                            </div>
                                                            <div class="col-lg-2"></div>
                                                            </div>
                                                        
                                                        </div>
                                                            
                                                                    <div class="row">
                                                <div class="col-lg-12">
                                                    <div class="well"><h3>Bid Submission Configuration </h3></div>
                                                </div>
                                            </div>
                                                       <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Bid Submission for :</div>
                                                            </div>
                                                            <div class="col-lg-2">
                                                               <div class="form_filed">Grand Total</div>                                                                                    
                                                            </div>
                                                            <div class="col-lg-2"></div>
                                                            <c:set var="rdobiddingType" value="Global"/>
                                                                <c:if test="${tblTender.auctionMethod eq 1}">
                                                                    <c:set var="rdobiddingType" value="Global"/>
                                                                </c:if>
                                                                <c:if test="${tblTender.auctionMethod eq 0}">
                                                                    <c:set var="rdobiddingType" value="Domestic"/>
                                                                </c:if>
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Bidding Type :</div>
                                                            </div>
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">${rdobiddingType}</div>
                                                                                                                                                  
                                                            </div>
                                                            <div class="col-lg-2"></div>
                                                        </div>
                                                        
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Bidding Access :</div>
                                                            </div>
                                                            <c:set var="rdoBiddingAccess" value="Open"/>
                                                                <c:if test="${tblTender.biddingAccess eq 1}">
                                                                    <c:set var="rdoBiddingAccess" value="Open"/>
                                                                </c:if>
                                                                <c:if test="${tblTender.biddingAccess eq 0}">
                                                                    <c:set var="rdoBiddingAccess" value="Limited"/>
                                                                </c:if>
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">${rdoBiddingAccess}</div>
                                                                                                                           
                                                            </div>
                                                                 <div class="col-lg-8"></div>
                                                        </div>
                                                          <div class="row">
                                                <div class="col-lg-12">
                                                    <div class="well"><h3>Key Configuration</h3></div>
                                                </div>
                                            </div>       
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Auction Method :</div>
                                                            </div>
                                                             <c:set var="rdoAuctionMethod" value="Forward"/>
                                                                <c:if test="${tblTender.biddingAccess eq 1}">
                                                                    <c:set var="rdoAuctionMethod" value="Forward"/>
                                                                </c:if>
                                                                <c:if test="${tblTender.biddingAccess eq 0}">
                                                                    <c:set var="rdoAuctionMethod" value="Reverse"/>
                                                                </c:if>
                                                            <div class="col-lg-2">
                                                              <div class="form_filed">${rdoAuctionMethod}</div>  
                                                                                                                                                     
                                                            </div>
                                                              <div class="col-lg-2"></div>
                                                              <c:set var="rdoAuctionVariant" value="Standard"/>
                                                                <c:if test="${tblTender.auctionMethod eq 1}">
                                                                    <c:set var="rdoAuctionVariant" value="Standard"/>
                                                                </c:if>
                                                                <c:if test="${tblTender.auctionMethod eq 0}">
                                                                    <c:set var="rdoAuctionVariant" value="Rank"/>
                                                                </c:if>
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Auction Variant :</div>
                                                            </div>
                                                            <div class="col-lg-2">
                                                               <div class="form_filed">${rdoAuctionVariant}</div>
                                                                                                                                                     
                                                            </div>
                                                               <div class="col-lg-2"></div>
                                                        </div>
                                                        
                                                        
                                                        <div class="row">
                                                            <div class="col-lg-2">  
                                                                <div class="form_filed">Start Price:</div>
                                                            </div>
                                                            <div class="col-lg-2">
                                                                 <div class="form_filed">${tblTender.startPrice}</div>
                                                            </div>
                                                            <div class="col-lg-2"></div>
                                                             <div class="col-lg-2">
                                                                <div class="form_filed">Product Location:</div>
                                                            </div>
                                                            <div class="col-lg-2">
                                                               <div class="form_filed">${tblTender.productLocation}</div>
                                                            </div>
                                                            <div class="col-lg-2"></div>
                                                        </div>
                                                        
                                                            <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Auction Reverse Price:</div>
                                                            </div>
                                                            <div class="col-lg-2">
                                                                 <div class="form_filed">${tblTender.auctionReservePrice}</div>
                                                            </div>
                                                            <div class="col-lg-2"></div>
                                                           <div class="col-lg-2">
                                                                <div class="form_filed">Increment / Decrement Values:</div>
                                                            </div>
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">${tblTender.incrementDecrementValues}</div>
                                                            </div>
                                                             <div class="col-lg-2"></div>
                                                        </div>
                                                            
                                                       
                                                        
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Auto Extension :</div>
                                                            </div>
                                                            <c:set var="rdoAutoExtension" value="No"/>
                                                                <c:if test="${tblTender.allowsAutoExtension eq 1}">
                                                                    <c:set var="rdoAutoExtension" value="Yes"/>
                                                                </c:if>
                                                                <c:if test="${tblTender.allowsAutoExtension eq 0}">
                                                                    <c:set var="rdoAutoExtension" value="No"/>
                                                                </c:if>
                                                            <div class="col-lg-2">
                                                               <div class="form_filed">${rdoAutoExtension}</div>                                                                                   
                                                            </div>
                                                                <div class="col-lg-8"></div>
                                                        </div>
                                                            
                                                               <c:if test="${tblTender.allowsAutoExtension eq 1}">
                                                                   <div id="AutoExtension">
                                                            
                                                            <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Extend Time When Bid Received in Last(In Minutes):</div>
                                                            </div>
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">${tblTender.extendTimeWhen}</div>
                                                            </div>
                                                                 <div class="col-lg-2"></div>
                                                                 <div class="col-lg-2">
                                                                <div class="form_filed">Extend Time By:</div>
                                                            </div>
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">${tblTender.extendTimeBy}</div>
                                                            </div>
                                                            <div class="col-lg-2"></div>
                                                                 </div>
                                                                
                                                            <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Auto Extension Mode :</div>
                                                            </div>
                                                                 <c:set var="rdoAutoExtensionMode" value="Unlimited"/>
                                                                <c:if test="${tblTender.autoExtensionMode eq 1}">
                                                                    <c:set var="rdoAutoExtensionMode" value="Limited"/>
                                                                </c:if>
                                                                <c:if test="${tblTender.autoExtensionMode eq 0}">
                                                                    <c:set var="rdoAutoExtensionMode" value="Unlimited"/>
                                                                </c:if>
                                                            <div class="col-lg-2">
                                                                   <div class="form_filed">${rdoAutoExtensionMode}</div>                                                                    
                                                            </div>
                                                                
                                                        <div class="col-lg-8"></div>
                                                        </div> 
                                                       
                                                        </div>
                                                               </c:if>
                                                               <c:if test="${tblTender.autoExtensionMode eq 1}">
                                                                   <div id="AutoExtensionMode">
                                                           <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">No. Of Extension:</div>
                                                            </div>
                                                            <div class="col-lg-2">
                                                               <div class="form_filed"><%=tblTender.getNoOfExtension()%></div>
                                                            </div>
                                                             </c:if>
                                                             <div class="col-lg-2"></div>
                                                        
                                                         <c:set var="DecimalValue" value="${[1,2,3,4,5]}"/>
                                                        <div class="col-lg-2">
                                                                <div class="form_filed">Accept Decimal Value Upto:</div>
                                                            </div>
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">${DecimalValue[tblTender.decimalValueUpto]-1}</div>
                                                            </div>
                                                             <div class="col-lg-2"></div>
                                                        </div> 
                                                           
                                                        </div>
                                                              
                                                              
                                                       
                                                            <c:set var="optIPAddress" value="No"/>
                                                                <c:if test="${tblTender.displayIPAddress eq 1}">
                                                                    <c:set var="optIPAddress" value="Yes"/>
                                                                </c:if>
                                                                <c:if test="${tblTender.displayIPAddress eq 0}">
                                                                    <c:set var="optIPAddress" value="No"/>
                                                                </c:if>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Display IP Address:</div>
                                                            </div>
                                                            <div class="col-lg-2">
                                                               <div class="form_filed">${optIPAddress}</div>
                                                            </div>
                                                               <div class="col-lg-2"></div>
                                                               <div class="col-lg-2">
                                                                <div class="form_filed">Estimated Value:</div>
                                                            </div>
                                                            <div class="col-lg-2">
                                                                 <div class="form_filed"><%=tblTender.getestimatedValue()%></div>
                                                            </div>
                                                        <div class="col-lg-2"></div>
                                                        </div>
                                                       <div class="row">
                                                <div class="col-lg-12">
                                                    <div class="well"><h3>Dates Configuration</h3></div>
                                                </div>
                                            </div>       
                                                           <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Auction Start Date :</div>
                                                            </div>
                                                            <div class="col-lg-2">
                                                              <%
                                                              String dt=tblTender.getAuctionStartDate().toString();
                                                              String arr[]=dt.split(" ");
                                                              
                                                              %>
                                                             <div class="form_filed"><%=arr[0]%></div>
                                                                                                                         
                                                            </div><div class="col-lg-2"></div>
                                                            <%
                                                            dt=tblTender.getAuctionEndDate().toString();
                                                            arr=dt.split(" ");
                                                            %>
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Auction End Date :</div>
                                                            </div>
                                                            <div class="col-lg-2">
                                                               <div class="form_filed"><%=arr[0]%></div>
                                                                                                                         
                                                            </div>
                                                        </div>
                                                        
                                                </div>
                                                
                                            </div>
                                            
                                
                            </div>
                        </div>
                    
                
            </section>
            

                       	</div>
	<%@include file="../includes/footer.jsp"%>
	</div>

</body>
</html>