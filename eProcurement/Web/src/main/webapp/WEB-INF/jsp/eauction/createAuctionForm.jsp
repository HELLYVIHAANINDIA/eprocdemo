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
	 <script src="${pageContext.servletContext.contextPath}/resources/js/jquery-ui.min.js"></script>
</head>
	 
<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="../includes/leftaccordion.jsp"%>
	 
	<div class="content-wrapper">
            <section class="content-header">
               <h1>Create / Edit Auction Form <small></small></h1>
            </section>
            <section class="content">
               
                <c:if test="${empty Operation}">
                    <form id="tenderDtBean" name="tenderDtBean" action="/eProcurement/eBid/Bid/addAuction" onsubmit="return validateAuction()">
                    <div class="row">
                        <div class="col-lg-12 col-md-12">
                            <div class="box">
                                <div class="box-header with-border">
                                    <div class="col-md-6" >
                                        <h3 class="box-title">Create Auction Form</h3>
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
                                               <div class="col-lg-2">
                                                   <div class="form_filed">Department:</div>
                                               </div>
                                               <div class="col-lg-2">
                                                <c:choose>
	                                            <c:when test="${parentDeptId gt 0}">
	                                             	<div class="form_filed" id="parentDeptName"></div>
                                                        <input type="hidden" name="departmentId" value="${parentDeptId}">
	                                            </c:when>
    	                                            <c:otherwise>
    	                                         	<select class="form-control" id="selDepartment" name="selDepartment"  onblur="javascript:{if(true){getSubDepartments();getOfficerList();}}" title="department">
							    <option value="-1">${label_select}</option>
							</select>	
    	                                            </c:otherwise>
                                             	</c:choose>
                                               </div>
                                               <div class="col-lg-2">
                                                   <div class="form_filed">Sub Department:</div>
                                               </div>
                                               <div class="col-lg-2">
                                                    <select class="form-control" id="subDept" name="subDept"  onblur="javascript:{if(true){getOfficerList();}}" title="sub department">
							<option value="-1">${label_select}</option>
						    </select>
                                               </div>
                                               <div class="col-lg-2">
                                                    <div class="form_filed">Department Officer:</div>
                                               </div>
                                                            <div class="col-lg-2">
                                                                <select class="form-control" id="selName" name="selDeptOfficial"  onblur="javascript:{if(true){}}" title="Department Officer">
															<option value="">${label_select}</option>
															</select></div>
                                                            
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Auction No:</div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <input type="text" name="txtAuctionNo" class="form-control"/>
                                                            </div>
                                                            
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Brief Scope Of Work:</div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <textArea rows="10" cols="50" class="form-control" name="txtBriefScope" ></textArea>
                                                            </div>
                                                            
                                                        </div>
                                                         <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Auction Details:</div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <br>
                                                                    <textArea rows="10" cols="50" class="form-control rtfTenderDetail" id="auctiondetails" name="auctiondetails" ></textArea>
                                                            </div>
                                                            
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Document Fees:</div>
                                                            </div>
                                                            <div class="col-lg-4">
                                                                <select class="form-control" id="optDocFees" name="optDocFees" onchange="IsDocumentFeesRequire(this.value)">
                                                                    <option value="1">Allow</option>
                                                                    <option value="0" selected>Dont'Allow</option>
								</select>                                                            
                                                            </div>
                                                            <div id="DocumentFees">
                                                                <div class="col-lg-2">
                                                                <div class="form_filed">Enter Document Fees:</div>
                                                            </div>
                                                            <div class="col-lg-4">
                                                                <input type="text" name="txtDocFees" class="form-control">                                                           
                                                            </div>
                                                            </div>
                                                            
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Participation Fees:</div>
                                                            </div>
                                                            <div class="col-lg-4">
                                                                <select class="form-control" id="optPartFees" name="optPartFees" onchange="IsParticipationFeesRequire(this.value)">
                                                                    <option value="1">Allow</option>
                                                                    <option value="0" selected>Dont'Allow</option>
								</select>                                                            
                                                            </div>
                                                            <div id="ParticipatonFees">
                                                                <div class="col-lg-2">
                                                                <div class="form_filed">Enter Participaton Fees:</div>
                                                            </div>
                                                            <div class="col-lg-4">
                                                                <input type="text" class="form-control" name="txtPartFees">                                                           
                                                            </div>
                                                            </div>
                                                            
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Product Location:</div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <input type="text" name="txtProductLoc" class="form-control"/>
                                                            </div>
                                                            
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Types of contract :</div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <select class="form-control" id="optTypeOfContract" name="optTypeOfContract" >
                                                                    
                                                                    
								</select>                                                            
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Bidding Access :</div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <br>
                                                                    <input type="radio" name="rdoBiddingAccess" value="1" checked >Open
                                                                <input type="radio" name="rdoBiddingAccess" value="0" >Limited    
                                                                                                                           
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Auction Method :</div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <br>
                                                                    <input type="radio" name="rdoAuctionMethod" value="1" id="rdoAuctionMethodF" checked >Forward
                                                                        <input type="radio" name="rdoAuctionMethod" id="rdoAuctionMethodR" value="0" >Reverse    
                                                                                                                                                     
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Auction Variant :</div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <br>
                                                                    <input type="radio" name="rdoAuctionVariant" value="1" checked >Standard
                                                                <input type="radio" name="rdoAuctionVariant" value="0" >Rank    
                                                                                                                                                     
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Bid Submission for :</div>
                                                            </div>
                                                            <div class="col-lg-2">
                                                               <!-- <br>
                                                                    <input type="radio" name="rdoBidSubmissionFor" value="1" checked >Item Wise
                                                                <input type="radio" name="rdoBidSubmissionFor" value="0" >Grand Total  -->  
                                                                 <div class="form_filed">Grand Total</div>                                                                                    
                                                            </div>
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Bidding Type :</div>
                                                            </div>
                                                            <div class="col-lg-4">
                                                                <br>
                                                                    <input type="radio" id="rdoBiddingTypeGlobal" name="rdobiddingType" value="1" checked >Global
                                                                <input type="radio" id="rdoBiddingTypeDomestic" name="rdobiddingType" value="2" >Domestic  
                                                                                                                                                  
                                                            </div>
                                                           
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">  
                                                                <div class="form_filed">Start Price:</div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <input type="text" name="txtStartPrice" id="txtStartPrice" class="form-control"/>
                                                            </div>
                                                            
                                                        </div>
                                                        
                                                            <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Auction Reverse Price:</div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <input type="text" name="txtAuctionRevPrice" id="txtAuctionRevPrice" class="form-control"/>
                                                            </div>
                                                            
                                                        </div>
                                                            <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Increment / Decrement Values:</div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <input type="text" name="txtIncrementDecrementVal" class="form-control"/>
                                                            </div>
                                                            
                                                        
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Bidding Form :</div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <br>
                                                                    <input type="radio" name="rdoBiddingForm" value="1" checked >Create New Form
                                                                <input type="radio" name="rdoBiddingForm" value="0" >Add Standard Form    
                                                                                                                                                     
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Auction Start Date :</div>
                                                            </div>
                                                            <div class="col-lg-4">
                                                               <input id="txtAuctionStartDate" name="txtAuctionStartDate"   type="text"  
                                                                 datepicker="yes" dtrequired="false" 
                                                                 placeholder="DD/MM/YYYY HH:MM" 
                                                                 class="dateBox pull-left form-control">
                                                                                                                         
                                                            </div>
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Auction End Date :</div>
                                                            </div>
                                                            <div class="col-lg-4">
                                                               <input id="txtDocumentEndDate" name="txtDocumentEndDate"   type="text"  
                                                                 datepicker="yes" dtrequired="false" 
                                                                 placeholder="DD/MM/YYYY HH:MM" 
                                                                 class="dateBox pull-left form-control">
                                                                                                                         
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Auto Extension :</div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <br>
                                                                    <input type="radio" name="rdoAutoExtension" id="rdoAutoExtensionYes" value="1" onchange="changeAutoExtension()" checked >Yes
                                                                <input type="radio" name="rdoAutoExtension" id="rdoAutoExtensionNo" onchange="changeAutoExtension()" value="0" >No    
                                                                                                                                                     
                                                            </div>
                                                        </div>
                                                        <div id="AutoExtension">
                                                            
                                                            <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Extend Time When Bid Received in Last(In Minutes):</div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <input type="text" name="txtExtendedTime" class="form-control"/>
                                                            </div>
                                                                 </div>
                                                                <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Extend Time By:</div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <input type="text" name="txtExtendedTimeBy" class="form-control"/>
                                                            </div>
                                                            <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Auto Extension Mode :</div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <br>
                                                                    <input type="radio" name="rdoAutoExtensionMode" id="rdoAutoExtensionModeYes" value="1" onchange="changeAutoExtensionMode()" checked >Limited
                                                                        <input type="radio" name="rdoAutoExtensionMode" id="rdoAutoExtensionModeNo" value="0" onchange="changeAutoExtensionMode()" >Unlimited    
                                                                                                                                                     
                                                            </div>
                                                                </div>
                                                        
                                                        </div> 
                                                       
                                                        </div>
                                                        <div id="AutoExtensionMode">
                                                           <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">No. Of Extension:</div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <input type="text" name="txtNoOfExtension" class="form-control"/>
                                                            </div>
                                                            
                                                        
                                                        </div> 
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Accept Decimal Value Upto:</div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <select class="form-control" id="optDecimalVal" name="optDecimalVal" >
                                                                    
								</select> 
                                                            </div>
                                                            
                                                        
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Display IP Address:</div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <select class="form-control" id="optDecimalVal" name="optIPAddress" name="optDecimalVal" >
                                                                    <option value="-1">Please Select</option>
                                                                    <option value="1">Yes</option>
                                                                    <option value="0">No</option>
								</select> 
                                                            </div>
                                                            
                                                        
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Estimated Value:</div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <input type="text" name="txtEstimatedValue" class="form-control"/>
                                                            </div>
                                                            
                                                        
                                                        </div> 
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">EMD Required:</div>
                                                            </div>
                                                            <div class="col-lg-4">
                                                                <select class="form-control" id="optEMDReq" name="optEMDReq" onchange="IsEMDRequire(this.value)" >
                                                                    <option value="-1">Please Select</option>
                                                                    <option value="1">Allow</option>
                                                                    <option value="0" selected>Don't Allow</option>
								</select> 
                                                            </div>
                                                            <div id='EMDfees'>
                                                                <div class="col-lg-2">
                                                                <div class="form_filed">Enter EMD Fees:</div>
                                                            </div>
                                                            <div class="col-lg-4">
                                                                <input type="text" name="txtEMDFees" class="form-control">                                                           
                                                            </div>
                                                            </div>
                                                        
                                                        </div>
                                                        <div class="row">
                                                            <br>
                                                            <div class="col-lg-12 text-center">
                                        <button type="submit" class="btn btn-submit" id="btnSubmitForm">Submit</button>
                                        <button type="button" class="btn btn-submit">Reset</button>
                                    </div>
                                                                    
                                                            
                                                        </div>
                                                </div>
                                                
                                            </div>
                                            
                                
                            </div>
                        </div>
                    </div>
                </form>
                                                                                                                 
                </c:if>
               
                <c:if test="${not empty Operation}">
                  
                    <form id="tenderDtBean" name="tenderDtBean" action="/eProcurement/eBid/Bid/addAuction" onsubmit="return validateAuction()">
                    <div class="row">
                        <div class="col-lg-12 col-md-12">
                            <div class="box">
                                <div class="box-header with-border">
                                    <div class="col-md-6" >
                                        <h3 class="box-title">Edit Auction Form</h3>
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
                                               <div class="col-lg-2">
                                                   <div class="form_filed">Department:</div>
                                               </div>
                                               <div class="col-lg-2">
                                                <div class="form_filed">${DepartmentName}</div>
                                               </div>
                                               
                                               <div class="col-lg-2">
                                                    <div class="form_filed">Department Officer:</div>
                                               </div>
                                                <div class="col-lg-2">
                                                    <div class="form_filed">${OfficerName}</div>
                                                </div>
                                            </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Auction No:</div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <input type="text" name="txtAuctionNo" class="form-control" value="${tblTender.tenderNo}"/>
                                                            </div>
                                                            
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Brief Scope Of Work:</div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <textArea rows="10" cols="50" class="form-control" name="txtBriefScope" value="" >${tblTender.tenderBrief}</textArea>
                                                            </div>
                                                            
                                                        </div>
                                                         <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Auction Details:</div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <br>
                                                                    <textArea rows="10" cols="50" class="form-control rtfTenderDetail" id="auctiondetails" name="auctiondetails" >${tblTender.tenderDetail}</textArea>
                                                            </div>
                                                            
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Document Fees:</div>
                                                            </div>
                                                            <div class="col-lg-4">
                                                                <select class="form-control" id="optDocFees" name="optDocFees" onchange="IsDocumentFeesRequire(this.value)">
                                                                
                                                                <c:if test="${tblTender.isDocfeesApplicable eq 1}">
                                                                     <option value="1" selected>Allow</option>
                                                                      <option value="0" >Dont'Allow</option>
                                                                </c:if>
                                                                <c:if test="${tblTender.isDocfeesApplicable eq 0}">
                                                                    <option value="0" selected>Dont'Allow</option>
                                                                     <option value="1" >Allow</option>
                                                                </c:if>
                                                                  
                                                                    
								</select>                                                            
                                                            </div>
                                                            <c:if test="${tblTender.isDocfeesApplicable eq 1}">
                                                            <div id="DocumentFees">
                                                                <div class="col-lg-2">
                                                                <div class="form_filed">Enter Document Fees:</div>
                                                            </div>
                                                            <div class="col-lg-4">
                                                                <c:if test="${tblTender.isDocfeesApplicable eq 1}">
                                                                    <input type="text" name="txtDocFees" class="form-control" value="${tblTender.documentFee}">    
                                                                </c:if>
                                                                <c:if test="${tblTender.isDocfeesApplicable eq 0}">
                                                                   <input type="text" name="txtDocFees" class="form-control">    
                                                                </c:if>
                                                                                                                       
                                                            </div>
                                                            </div>
                                                            </c:if>
                                                            
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Participation Fees:</div>
                                                            </div>
                                                            <div class="col-lg-4">
                                                                <select class="form-control" id="optPartFees" name="optPartFees" onchange="IsParticipationFeesRequire(this.value)">
                                                                    <c:if test="${tblTender.isParticipationFeesBy eq 1}">
                                                                     <option value="1" selected>Allow</option>
                                                                      <option value="0" >Dont'Allow</option>
                                                                </c:if>
                                                                <c:if test="${tblTender.isParticipationFeesBy eq 0}">
                                                                    <option value="0" selected>Dont'Allow</option>
                                                                     <option value="1" >Allow</option>
                                                                </c:if>
								</select>                                                            
                                                            </div>
                                                            <c:if test="${tblTender.isParticipationFeesBy eq 1}">
                                                            <div id="ParticipatonFees">
                                                                <div class="col-lg-2">
                                                                <div class="form_filed">Enter Participaton Fees:</div>
                                                            </div>
                                                            <div class="col-lg-4">
                                                                <c:if test="${tblTender.isParticipationFeesBy eq 1}">
                                                                    <input type="text" class="form-control" name="txtPartFees" value="${tblTender.participationFees}">     
                                                                </c:if>
                                                                <c:if test="${tblTender.isParticipationFeesBy eq 0}">
                                                                    <input type="text" class="form-control" name="txtPartFees">     
                                                                </c:if>
                                                                                                                      
                                                            </div>
                                                            </div>
                                                            </c:if>
                                                            
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Product Location:</div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <input type="text" name="txtProductLoc" class="form-control" value="${tblTender.productLocation}"/>
                                                            </div>
                                                            
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Types of contract :</div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                 <c:set var="Type_of_contract" value="${['Goods','Service','Works','Turnkey Project','Others']}"/>
                                                                <select class="form-control" id="optTypeOfContract" name="optTypeOfContract" >
                                                                    
                                                                    
								</select>                                                            
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Bidding Access :</div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <br>
                                                                    <c:if test="${tblTender.biddingAccess eq 1}">
                                                                        <input type="radio" name="rdoBiddingAccess" value="1" checked >Open
                                                                        <input type="radio" name="rdoBiddingAccess" value="0" >Limited    
                                                                    </c:if>
                                                                            <c:if test="${tblTender.biddingAccess eq 0}">
                                                                                <input type="radio" name="rdoBiddingAccess" value="1"  >Open
                                                                        <input type="radio" name="rdoBiddingAccess" value="0" checked >Limited  
                                                                            </c:if>
                                                                    
                                                                                                                           
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Auction Method :</div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <br>
                                                                    <c:if test="${tblTender.auctionMethod eq 1}">
                                                                     <input type="radio" name="rdoAuctionMethod" value="1" id="rdoAuctionMethodF" checked >Forward
                                                                     <input type="radio" name="rdoAuctionMethod" id="rdoAuctionMethodR" value="0" >Reverse       
                                                                    </c:if>
                                                                     <c:if test="${tblTender.auctionMethod eq 0}">
                                                                     <input type="radio" name="rdoAuctionMethod" value="1" id="rdoAuctionMethodF"  >Forward
                                                                     <input type="radio" name="rdoAuctionMethod" id="rdoAuctionMethodR" value="0" checked>Reverse       
                                                                    </c:if>
                                                                    
                                                                                                                                                     
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Auction Variant :</div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <br>
                                                                    <c:if test="${tblTender.biddingVariant eq 1}">
                                                                        <input type="radio" name="rdoAuctionVariant" value="1" checked >Standard
                                                                <input type="radio" name="rdoAuctionVariant" value="0" >Rank    
                                                                    </c:if>
                                                                    <c:if test="${tblTender.biddingVariant eq 0}">
                                                                        <input type="radio" name="rdoAuctionVariant" value="1"  >Standard
                                                                <input type="radio" name="rdoAuctionVariant" value="0" checked >Rank 
                                                                    </c:if>
                                                                                                                                                     
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Bid Submission for :</div>
                                                            </div>
                                                            <div class="col-lg-2">
                                                               <!-- <br>
                                                                    <input type="radio" name="rdoBidSubmissionFor" value="1" checked >Item Wise
                                                                <input type="radio" name="rdoBidSubmissionFor" value="0" >Grand Total  -->  
                                                                 <div class="form_filed">Grand Total</div>                                                                                    
                                                            </div>
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Bidding Type :</div>
                                                            </div>
                                                            <div class="col-lg-4">
                                                                <br>
                                                                    <c:if test="${tblTender.biddingType eq 1}">
                                                                        <input type="radio" id="rdoBiddingTypeGlobal" name="rdobiddingType" value="1" checked >Global
                                                                <input type="radio" id="rdoBiddingTypeDomestic" name="rdobiddingType" value="2" >Domestic  
                                                                    </c:if>
                                                                    <c:if test="${tblTender.biddingType eq 0}">
                                                                        <input type="radio" id="rdoBiddingTypeGlobal" name="rdobiddingType" value="1"  >Global
                                                                <input type="radio" id="rdoBiddingTypeDomestic" name="rdobiddingType" value="2" checked >Domestic  
                                                                    </c:if>
                                                                                                                                                  
                                                            </div>
                                                           
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">  
                                                                <div class="form_filed">Start Price:</div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <input type="text" name="txtStartPrice" id="txtStartPrice" class="form-control" value="${tblTender.startPrice}"/>
                                                            </div>
                                                            
                                                        </div>
                                                        
                                                            <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Auction Reverse Price:</div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <input type="text" name="txtAuctionRevPrice" id="txtAuctionRevPrice" class="form-control" value="${tblTender.auctionReservePrice}"/>
                                                            </div>
                                                            
                                                        </div>
                                                            <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Increment / Decrement Values:</div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <input type="text" name="txtIncrementDecrementVal" class="form-control" value="${tblTender.incrementDecrementValues}"/>
                                                            </div>
                                                            
                                                        
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Bidding Form :</div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <br>
                                                                    <input type="radio" name="rdoBiddingForm" value="1" checked >Create New Form
                                                                <input type="radio" name="rdoBiddingForm" value="0" >Add Standard Form    
                                                                                                                                                     
                                                            </div>
                                                        </div>
                                                            <%
                                                            TblTender tblTender=(TblTender)request.getAttribute("tblTender");
                                                            %>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Auction Start Date :</div>
                                                            </div>
                                                            <div class="col-lg-4">
                                                                
                                                                <%
                                                                String str=tblTender.getAuctionStartDate()+"";
                                                                String[] arr=str.split("\\.");
                                                                String[] arr2=arr[0].split(":");
                                                                %>
                                                                
                                                                   <input id="txtAuctionStartDate" name="txtAuctionStartDate"   type="text"  
                                                                 datepicker="yes" dtrequired="false" 
                                                                 placeholder="DD/MM/YYYY HH:MM" 
                                                                 class="dateBox pull-left form-control" value="<%=arr2[0]+":"+arr2[1]%>">
                                                                                                                         
                                                            </div>
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Auction End Date :</div>
                                                            </div>
                                                                 <%
                                                                 str=tblTender.getAuctionEndDate()+"";
                                                                arr=str.split("\\.");
                                                                arr2=arr[0].split(":");
                                                                 %>
                                                            <div class="col-lg-4">
                                                               <input id="txtDocumentEndDate" name="txtDocumentEndDate"   type="text"  
                                                                 datepicker="yes" dtrequired="false" 
                                                                 placeholder="DD/MM/YYYY HH:MM" 
                                                                 class="dateBox pull-left form-control" value="<%=arr2[0]+":"+arr2[1]%>">
                                                                                                                         
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Auto Extension :</div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <br>
                                                                    <c:if test="${tblTender.allowsAutoExtension eq 1}">
                                                                        <input type="radio" name="rdoAutoExtension" id="rdoAutoExtensionYes" value="1" onchange="changeAutoExtension()" checked >Yes
                                                                <input type="radio" name="rdoAutoExtension" id="rdoAutoExtensionNo" onchange="changeAutoExtension()" value="0" >No    
                                                                    </c:if>
                                                                    <c:if test="${tblTender.allowsAutoExtension eq 0}">
                                                                        <input type="radio" name="rdoAutoExtension" id="rdoAutoExtensionYes" value="1" onchange="changeAutoExtension()"  >Yes
                                                                <input type="radio" name="rdoAutoExtension" id="rdoAutoExtensionNo" onchange="changeAutoExtension()" value="0" checked>No    
                                                                    </c:if>
                                                                    
                                                                                                                                                     
                                                            </div>
                                                        </div>
                                                                  <c:if test="${tblTender.allowsAutoExtension eq 1}">
                                                        <div id="AutoExtension">
                                                            
                                                            <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Extend Time When Bid Received in Last(In Minutes):</div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <input type="text" name="txtExtendedTime" class="form-control" value="${tblTender.extendTimeWhen}"/>
                                                            </div>
                                                                 </div>
                                                                <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Extend Time By:</div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <input type="text" name="txtExtendedTimeBy" class="form-control" value="${tblTender.extendTimeBy}"/>
                                                            </div>
                                                            <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Auto Extension Mode :</div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <br>
                                                                    <c:if test="${tblTender.autoExtensionMode eq 1}">
                                                                        <input type="radio" name="rdoAutoExtensionMode" id="rdoAutoExtensionModeYes" value="1" onchange="changeAutoExtensionMode()" checked >Limited
                                                                        <input type="radio" name="rdoAutoExtensionMode" id="rdoAutoExtensionModeNo" value="0" onchange="changeAutoExtensionMode()" >Unlimited    
                                                                           
                                                                    </c:if>
                                                                            <c:if test="${tblTender.autoExtensionMode eq 0}">
                                                                        <input type="radio" name="rdoAutoExtensionMode" id="rdoAutoExtensionModeYes" value="1" onchange="changeAutoExtensionMode()"  >Limited
                                                                        <input type="radio" name="rdoAutoExtensionMode" id="rdoAutoExtensionModeNo" value="0" onchange="changeAutoExtensionMode()"checked >Unlimited    
                                                                           
                                                                    </c:if>
                                                                                                                                              
                                                            </div>
                                                                </div>
                                                        
                                                        </div> 
                                                       
                                                        </div>
                                                                  </c:if>
                                                                 <c:if test="${tblTender.autoExtensionMode eq 1}">
                                                        <div id="AutoExtensionMode">
                                                           <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">No. Of Extension:</div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <input type="text" name="txtNoOfExtension" class="form-control" value="<%=tblTender.getNoOfExtension()%>"/>
                                                            </div>
                                                            
                                                        
                                                        </div> 
                                                        </div>
                                                                 </c:if>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Accept Decimal Value Upto:</div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <select class="form-control" id="optDecimalVal" name="optDecimalVal" >
                                                                    
								</select> 
                                                            </div>
                                                            
                                                        
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Display IP Address:</div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <select class="form-control" id="optDecimalVal" name="optIPAddress" name="optDecimalVal" >
                                                                    <option value="-1">Please Select</option>
                                                                    <c:if test="${tblTender.displayIPAddress eq 1}">
                                                                       <option value="1" selected>Yes</option>
                                                                    <option value="0">No</option> 
                                                                    </c:if>
                                                                    <c:if test="${tblTender.displayIPAddress eq 0}">
                                                                       <option value="1" >Yes</option>
                                                                    <option value="0" selected>No</option> 
                                                                    </c:if>
                                                                    
								</select> 
                                                            </div>
                                                            
                                                        
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Estimated Value:</div>
                                                            </div>
                                                            <div class="col-lg-10">
                                                                <input type="text" name="txtEstimatedValue" class="form-control" value="${tblTender.estimatedValue}"/>
                                                            </div>
                                                            
                                                        
                                                        </div> 
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">EMD Required:</div>
                                                            </div>
                                                            <div class="col-lg-4">
                                                                <select class="form-control" id="optEMDReq" name="optEMDReq" onchange="IsEMDRequire(this.value)" >
                                                                    <option value="-1">Please Select</option>
                                                                    <c:if test="${tblTender.EMDRequired eq 1}">
                                                                        <option value="1" selected>Allow</option>
                                                                    <option value="0" >Don't Allow</option>
                                                                    
                                                                    </c:if>
                                                                    <c:if test="${tblTender.EMDRequired eq 0}">
                                                                        <option value="1" >Allow</option>
                                                                    <option value="0" selected>Don't Allow</option>
                                                                    
                                                                    </c:if>
                                                                    
								</select> 
                                                            </div>
                                                            <c:if test="${tblTender.EMDRequired eq 1}">
                                                                       <div id='EMDfees'>
                                                                <div class="col-lg-2">
                                                                <div class="form_filed">Enter EMD Fees:</div>
                                                            </div>
                                                            <div class="col-lg-4">
                                                                <input type="text" name="txtEMDFees" class="form-control" value="${tblTender.EMDFees}">                                                           
                                                            </div>
                                                            
                                                            </c:if>
                                                     </div>
                                                            <input type="hidden" name="departmentId" value="<%=tblTender.getDepartmentId()%>">
                                                                <input type="hidden" name="selDeptOfficial" value="<%=tblTender.getOfficerId()%>">
                                                        
                                                        </div>
                                                        <div class="row">
                                                            <br>
                                                                <input type="hidden" name="opration" value="Edit">
                                                                    <input type="hidden" name="tenderId" value="<%=tblTender.getTenderId()%>"
                                                            <div class="col-lg-12 text-center">
                                        <button type="submit" class="btn btn-submit" id="btnSubmitForm">Submit</button>
                                        <button type="button" class="btn btn-submit">Reset</button>
                                    </div>
                                                                    
                                                            
                                                        </div>
                                                </div>
                                                
                                            </div>
                                            
                                
                            </div>
                        </div>
                    </div>
                </form>
                </c:if>

            </section>
            

                       	</div>
	<%@include file="../includes/footer.jsp"%>
	</div>

<script>
            var sel="";
            var wysihtml5Editor = "";
            var nodedata="";
            var map=new Array();
            var hideMap=new Array();
            var contextPath="/eProcuremenet";
            var wordConversionFormat='0';
            
            var baseCurrency="0"; 
            var deptValidate='Please select parent department';
            var varformvalidate='Price Bid envelope and Techno Commercial envelope cannot be selected together, please select any one of them';
            var varformvalidatewithtechnicalenv = 'Technical Envelope and Techno-Commercial envelope cannot be selected together, please select any one of them';
            var varmultiformvalidate='Multiple envelope selection is mandatory in multi part event';
            var isCategoryAllow='0';
            var brdMode='0';
            var isDRT='false';
            var isBank='false';            
            var isSarfaesi='false';
            var varFormType;
            var varConfirmRmvEnvelop="On removing envelop, bidding form(s) and committee member(s) mapped in selected envelop will be removed. Are you sure you want to proceed further?";
            var msg_mode_of_payment_for_document = "If download document is configured after payment, its mandatory to configure document fees as allow and set mode of payment as Online"; 
            var msg_consortium_nt_applicable_for_price_bid_env = "Consortium cannot be applicable for Price bid envelope";
            var zero = '';
            var one = '1';
            var cstatus = 0;
            var parentDeptId = '${parentDeptId}';
            var parentDeptJson = '${parentDeptJson}';
            var subDeptId = '${subDeptId}';
            var subDeptJson = '${subDeptJson}';
            var organization= '${organization}';
            var parentDeptName = '${parentDeptName}';
            var tenderDeptId='${tenderDeptId}';
            var tenderOfficerId='${tenderOfficerId}';
            var tenderOfficer='${tenderOfficer}';
            var TypeOfContract=['Goods','Service','Works','Turnkey Project','Others'];
         
            var DecimalValue=[1,2,3,4,5];
     var operation='${Operation}';        
    function getSubDepartments() {
            	$.blockUI({message: '<h4><img src="http://s13.postimg.org/80vkv0coz/image.gif" /> Please Wait...</h4>'});
            			var data = {};
            			var searchValue;
            			if(parentDeptId!=0){
            				searchValue = parentDeptId+"@@1";
            			}else{
            				searchValue = $("#selDepartment").val()+"@@1";	
            			}
                    	
                    	$.ajax({
                    		type : "POST",
                    		contentType : "application/json",
                    		url : "${pageContext.servletContext.contextPath}/common/user/getsubdepartments/"+searchValue,
                    		data : data,
                    		timeout : 100000,
                    		success : function(data) {
                    			var obj = jQuery.parseJSON(data);
                    			$('#subDept').html('');
                    		     $.each(obj, function (key, value) {
                    		    $('#subDept').append($('<option>',
                    		    		 {
                    		    		    value: value.value,
                    		    		    text : value.label
                    		    		}));
                    		     });
                    		     $('select[id="subDept"] option:selected').attr("selected",null);
                 	   	     	 $('select[id="subDept"] option[value="-1"]').attr("selected","selected");
                    		     if(subDeptId==0){
                    		    	 $("#subDept").val("-1");	 
                    		     }else{
                    		    	 $("#subDept").val(subDeptId);
                    		     }
                    		     
                    			console.log("SUCCESS: ", data);
                    			$.unblockUI({});
                    		},
                    		error : function(e) {
                    			console.log("ERROR: ", e);
                    			$.unblockUI({});
                    		},
                    		done : function(e) {
                    			console.log("DONE");
                    			$.unblockUI({});
                    		}
                    	});
                    	return true;
            }
            
            function getOfficerList() {
            	var data = {};
            	var keyword = $("#selSearch").val();
            	var grandParentDept = '${grandParentDeptId}';
            	var searchValue = "";
            		var parentDept;
            		var subDept;
            			parentDept=$('#selDepartment').val();
            			subDept=$('#subDept').val();
            			if(parentDept==undefined){
            				parentDept="-1";
            			}
            			if(subDept==undefined){
            				subDept="-1";
            			}
            				
            		if(parentDept>0 && subDept=='-1'){
            			searchValue = parentDept;
            			keyword="deptId";	
            		}else if(parentDept>0 && subDept>0){
            			searchValue = subDept;
            			keyword="deptId";	
            		}else if(parentDept=='-1' && subDept=='-1'){
            			searchValue = grandParentDept;
            			keyword="deptId";	
            		}else if(parentDept=='-1' && subDept>0){
            			searchValue = subDept;
            			keyword="deptId";	
            		}
            	
            	$.ajax({
            		type : "POST",
            		contentType : "application/json",
            		url : "${pageContext.servletContext.contextPath}/etender/buyer/officers/"+searchValue+"/"+keyword,
            		data : data,
            		timeout : 100000,
            		success : function(data) {
            			console.log("SUCCESS: ", data);
            			var obj = jQuery.parseJSON(data);
            			$('#selName').html('');
            		     $.each(obj, function (key, value) {
            		    var c = value.value.split('@@')[4];
            		    $('#selName').append($('<option>',
            		    		 {
            		    		    value: c,
            		    		    text : value.label
            		    		}));
            		     });
            		     
            		     if(tenderOfficer>0){
            		    	 $('select[id="selName"] option:selected').attr("selected",null);
             	     		$('select[id="selName"] option[value="'+tenderOfficer+'"]').attr("selected","selected");	 
            		     }
            		},
            		error : function(e) {
            			console.log("ERROR: ", e);
            		},
            		done : function(e) {
            			console.log("DONE");
            		}
            	});
            }
            $(function(){
               // alert('on load'+parentDeptId);
                var wysihtml5Editor = "";
                wysihtml5Editor = $("#auctiondetails").wysihtml5();
                if($('#optDocFees option:selected').val()===1)
                {
                    $('#DocumentFees').show();
                }
                else
                {
                    $('#DocumentFees').hide();
                }
                if($('#optEMDReq option:selected').val()===1)
                {
                    $('#EMDfees').show();
                }
                else
                {
                    $('#EMDfees').hide();
                }
                if($('#optPartFees option:selected').val()===1)
                {
                    $('#ParticipatonFees').show();
                }
                else
                {
                    $('#ParticipatonFees').hide();
                }
               
                if(operation==='edit')
                {
                  //  alert('in if');
                $('<option/>').attr('value',-1).text('Please Select').appendTo('#optTypeOfContract');
                for(var i=1;i<=TypeOfContract.length;i++)
                {
                            // alert(i+'${tblTender.contractTypeId}');
                    if(''+i+''==='${tblTender.contractTypeId}')
                    {
                     //   alert('in if');
                        $('<option/>').attr('value',i).text(TypeOfContract[i-1]).appendTo('#optTypeOfContract').prop('selected','selected');
                    }
                    else
                    {
                        $('<option/>').attr('value',i).text(TypeOfContract[i-1]).appendTo('#optTypeOfContract');
                    }
                }
                for(var i=1;i<DecimalValue.length;i++)
                {
                    if(''+i+''==='${tblTender.decimalValueUpto}')
                    {
                        $('<option/>').attr('values',i).prop('selected','selected').text(DecimalValue[i-1]).appendTo('#optDecimalVal');
                    }
                    else
                    {
                       $('<option/>').attr('values',i).text(DecimalValue[i-1]).appendTo('#optDecimalVal'); 
                    }
                }
            }
            else
            {
                $('<option/>').attr('value',-1).text('Please Select').appendTo('#optTypeOfContract');
                for(var i=1;i<=TypeOfContract.length;i++)
                {
                    $('<option/>').attr('value',i).text(TypeOfContract[i-1]).appendTo('#optTypeOfContract');
                }
                $('<option/>').attr('values',-1).text('Please Select').appendTo('#optDecimalVal');
                for(var i=1;i<DecimalValue.length;i++)
                {
                    if(i==2)
                    {
                        $('<option/>').attr('values',i).prop('selected','selected').text(DecimalValue[i-1]).appendTo('#optDecimalVal');
                    }
                    else
                    {
                       $('<option/>').attr('values',i).text(DecimalValue[i-1]).appendTo('#optDecimalVal'); 
                    }
                }
            }
                
                $(".dateBox").each(function(){
		    $(this).datetimepicker({
		       format:'d/m/Y H:i'
		    });
		});
             //   alert(parentDeptJson);
            
     $('#parentDeptName').html(parentDeptName);
     if(parentDeptJson!=''){
     		var obj = jQuery.parseJSON(parentDeptJson);
	     	$('#selDepartment').html('');
	     	$.each(obj, function (key, value) {
	    	$('#selDepartment').append($('<option>',
	    		 {
	    		    value: value.value,
	    		    text : value.label
	    		}));
	    	 });
	     	
	     	if(parentDeptId==0){
	    		$('select[id="selDepartment"] option:selected').attr("selected",null);
	   	     	$('select[id="selDepartment"] option[value="-1"]').attr("selected","selected");
	    	 }else{
	    		$('select[id="selDepartment"] option:selected').attr("selected",null);
	   	     	$('select[id="selDepartment"] option[value="'+parentDeptId+'"]').attr("selected","selected");
	     	}
	     	getSubDepartments();
	     	$.blockUI({message: '<h4><img src="http://s13.postimg.org/80vkv0coz/image.gif" /> Please Wait...</h4>'});
   	     	setTimeout(function() {
   	     	getOfficerList();
   	    	}, 3000);
   	     	$.unblockUI({});
  		}else{
  			var subDeptObj = jQuery.parseJSON(subDeptJson);
	   	     	$('#subDept').html('');
		     	$.each(subDeptObj, function (key, value) {
		    	$('#subDept').append($('<option>',
		    		 {
		    		    value: value.value,
		    		    text : value.label
		    		}));
		    	 });
		     	if(subDeptId==0){
		    		$('select[id="subDept"] option:selected').attr("selected",null);
		   	     	$('select[id="subDept"] option[value="-1"]').attr("selected","selected");
		    	 }else{
		    		$('select[id="subDept"] option:selected').attr("selected",null);
		   	     	$('select[id="subDept"] option[value="'+subDeptId+'"]').attr("selected","selected");
		     	}
		     	getOfficerList();
  			}
              //   alert('hello');
             //    alert(parentDeptId);
                 
                        
                        if($('#rdoAutoExtensionYes').prop('checked')===true)
                        {
                            $('#AutoExtension').show();
                        }
                        if($('#rdoAutoExtensionNo').prop('checked')===true)
                        {
                            $('#AutoExtension').hide();
                        }
                        if($('#rdoAutoExtensionModeYes').prop('checked')===true)
                        {
                            $('#AutoExtensionMode').show();
                        }
                        if($('#rdoAutoExtensionModeNo').prop('checked')===true)
                        {
                            $('#AutoExtensionMode').hide();
                        }
            });
            function changeAutoExtension()
            {
                        if($('#rdoAutoExtensionYes').prop('checked')===true)
                        {
                            $('#AutoExtension').show();
                        }
                        if($('#rdoAutoExtensionNo').prop('checked')===true)
                        {
                            $('#AutoExtension').hide();
                        }
            }
            function changeAutoExtensionMode()
            {
                        if($('#rdoAutoExtensionModeYes').prop('checked')===true)
                        {
                            $('#AutoExtensionMode').show();
                        }
                        if($('#rdoAutoExtensionModeNo').prop('checked')===true)
                        {
                            $('#AutoExtensionMode').hide();
                        }
            }
            function IsDocumentFeesRequire(eId)
            {
                if(eId==='1')
                {
                    $('#DocumentFees').show();
                }
                else
                {
                    $('#DocumentFees').hide();
                }
            }
            function IsParticipationFeesRequire(eId)
            {
                if(eId==='1')
                {
                    $('#ParticipatonFees').show();
                }
                else
                {
                    $('#ParticipatonFees').hide();
                }
            }
            function IsEMDRequire(eId)
            {
                if(eId==='1')
                {
                    $('#EMDfees').show();
                }
                else
                {
                    $('#EMDfees').hide();
                }
            }
            function validateAuction()
            {
                var count=0;
                if($('#rdoAuctionMethodR').prop('checked')===true)
                {
                    //alert('in if');
                    if($('#txtAuctionRevPrice').val() > $('#txtStartPrice').val())
                    {
                        alert('Reserve price should be less than the start price');
                        count++;
                    }
                }
                var startPrice=$('#txtStartPrice').val();
                var reversePrice=$('#txtAuctionRevPrice').val();
                if($('#rdoAuctionMethodF').prop('checked')===true)
                {
                   // alert($('#txtStartPrice').val()+"-"+$('#txtAuctionRevPrice').val());
                   if($('#txtAuctionRevPrice').val() < $('#txtStartPrice').val())
                    {
                        alert('start price should be less than the Reverse price');
                        count++;
                    }
                }
                if($('#txtIncrementDecrementVal').val()===0)
                {
                    alert('Zero value is not allowed');
                    count++;
                }
                if(count>0)
                {
                    return false;
                }
                
                return true;
            }
</script>

</body>
</html>      