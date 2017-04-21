<%@include file="./../includes/head.jsp"%>
<%@include file="./../includes/masterheader.jsp"%>
<%@page import="com.eprocurement.etender.model.TblTender"%>	
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<spring:message code="client_dateformate_hhmm" var="client_dateformate_hhmm"/>
	 
<spring:message code="label_select" var="label_select"></spring:message>

<div class="content-wrapper">

    <section class="content-header">
        <h1 class="inline"><c:if test="${empty Operation}"><spring:message code="lbl_create_auction" /></c:if>
        <c:if test="${not empty Operation}"><spring:message code="lbl_edit_auction1"/></c:if><small></small></h1>
        <c:if test="${tenderId ne 0}">
          <a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}" class="g g-back"> <spring:message code="lbl_go_back_to_auction_dashboard" /></a>
        </c:if>
    </section>
    
    <section class="content">
        <form id="tenderDtBean" name="tenderDtBean" action="${pageContext.servletContext.contextPath}/eBid/Bid/addAuction" method="post" onsubmit="if(valOnSubmit()){return validateAuction();}else {return false;}">
            <div class="row">
                <div class="col-lg-12 col-md-12">
                    <div class="box">
                        <div class="box-body">
                            <div class="row">
                                <div class="col-lg-12 col-md-12 col-xs-12">
                                     <div class="row">
                                     
                                         <div class="col-lg-2"><div class="lbl-3"><spring:message code="lbl_Organization" /> </div></div>
                                         <div class="col-lg-2"><div class="lbl-2"><div id="organization" class="lbl-2"></div></div><input type="hidden" name="organization" value="${grandParentDeptId}" /> </div>
                                        <div class="col-lg-2"></div>
                                         <div class="col-lg-2">
                                            <div class="lbl-3"><spring:message code="lbl_department" /></div>
                                        </div>
                                        <div class="col-lg-2">
                                           
                                                <c:choose>
	                                            <c:when test="${parentDeptId gt 0}">
                                                        <div class="lbl-2"><div id="parentDeptName" class="lbl-2"></div></div>
	                                            </c:when>
                                                    <c:otherwise>
                                                        <div><div class="lbl-2">-</div></div>    
                                                        <select style="display: none;" class="form-control" id="selDepartment" name="selDepartment"  onblur="javascript:{if(true){getSubDepartments();getOfficerList();}}" title="department">
                                                            <option value="${parentDeptId}">${label_select}</option>
                                                        </select>	
                                                    </c:otherwise>
                                             	</c:choose>
                                           
                                           
                                            
                                        </div>
                                        </div>
                                    <div class="row">
                                       
                                        
                                        <div class="col-lg-2">
                                            <div class="lbl-3"><spring:message code="lbl_sub_department" /></div>
                                        </div>
                                        <div class="col-lg-2">
                                            <c:choose>
	                                        <c:when test="${subDeptId gt 0}">
                                                    <div class="lbl-2"><div id="subDeptName" class="lbl-2"></div></div>
	                                        </c:when>
    	                                        <c:otherwise>
                                                <div><div class="lbl-2">-</div></div>
    	                                        </c:otherwise>
                                            </c:choose>
                                            <select style="display: none;" class="form-control" id="subDept" name="subDept"  onblur="javascript:{if(true){getOfficerList();}}" title="sub department">
						<option value="${subDeptId}">${label_select}</option>
                                            </select>
                                            
                                        </div>
                                            <div class="col-lg-2"></div>
                                        <div class="col-lg-2">
                                            <div class="lbl-3"><spring:message code="lbl_user_name" /></div>
                                        </div>
                                        <div class="col-lg-2">
                                            <div class="lbl-2"><div id="officerName" class="lbl-2"></div></div>
                                                    <select class="form-control" style="display: none" id="selName" name="selDeptOfficial"  onblur="javascript:{if(true){}}" title="Department Officer">
							<option value="${officerId}">${label_select}</option>
						    </select>
                                        </div>
                                       
                                        
                                        </div>
                                        
                                        <div class="row">
                                            <div class="col-lg-2">
                                                <div class="form_filed"><spring:message code="lbl_auction_no" /><span class="red">*</span></div>
                                            </div>
                                            <div class="col-lg-5">
                                                <c:if test="${empty Operation}">
                                                    <input type="text" name="txtAuctionNo" id="txtAuctionNo" class="form-control" title="Auction No." validarr="required@@length:0,50" tovalid="true"  onblur="validateTextComponent(this)" />
                                                </c:if>
                                                <c:if test="${not empty Operation}">
                                                    <input type="text" name="txtAuctionNo" class="form-control" value="${tblTender.tenderNo}" id="txtAuctionNo" title="Auction No." validarr="required@@length:0,50" tovalid="true"  onblur="validateTextComponent(this)"/>
                                                </c:if>
                                            </div>
                                        </div>
                                                <div class="row">
                                                    <div class="col-lg-2">
                                                        <div class="form_filed"><spring:message code="lbl_brief_scope_of_work" /><span class="red">*</span></div>
                                                    </div>
                                                    <div class="col-lg-5">
                                                        <c:if test="${empty Operation}">
                                                            <textArea rows="10" cols="50" class="form-control" name="txtBriefScope" id="txtBriefScope"  class="form-control" 
                                                                      validarr="required@@tenderbrief:10000" tovalid="true" onblur="validateTextComponent(this)" title="Brief Scope of Work."></textArea>
                                                            </c:if>
                                                            <c:if test="${not empty Operation}">
                                                            <textArea rows="10" cols="50" class="form-control" name="txtBriefScope" id="txtBriefScope"  class="form-control" 
                                                                      validarr="required@@tenderbrief:10000" tovalid="true" onblur="validateTextComponent(this)" title="Brief Scope of Work.">${tblTender.tenderBrief}</textArea>
                                                            </c:if>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-lg-2">
                                                        <div class="form_filed"><spring:message code="lbl_auction_details" /><span class="red">*</span></div>
                                                    </div>
                                                    <div class="col-lg-5">
                                                        <br>
                                                            <c:if test="${empty Operation}">
                                                                <textArea rows="10" cols="50" class="form-control rtfauctiondetails" id="rtfauctiondetails" name="auctiondetails" 
                                                                          title="Auction Details." tovalid="true"  validarr="required@@length:0,10000" ></textArea>
                                                            </c:if>
                                                            <c:if test="${not empty Operation}">
                                                                <textArea rows="10" cols="50" class="form-control rtfauctiondetails" id="rtfauctiondetails" name="auctiondetails" tovalid="true"  validarr="required@@length:0,10000" title="Auction Details.">${tblTender.tenderDetail.trim()}</textArea>
                                                            </c:if>
                                                    </div>
                                                </div>
                                            <div class="row">
                                                <div class="col-lg-2">
                                                    <div class="form_filed"><spring:message code="lbl_document_details" /></div>
                                                </div>
                                                <div class="col-lg-5">
                                                    <select class="form-control" id="optDocFees" name="optDocFees" onchange="IsDocumentFeesRequire(this.value)">
                                                        <c:if test="${empty Operation}">
                                                            <option value="1"><spring:message code="label_allow" /></option>
                                                        <option value="0" selected><spring:message code="label_dontallow" /></option>
                                                        </c:if>
                                                        <c:if test="${not empty Operation}">
                                                             <c:if test="${tblTender.isDocfeesApplicable eq 1}">
                                                            <option value="1" selected><spring:message code="label_allow" /></option>
                                                            <option value="0" ><spring:message code="label_dontallow" /></option>
                                                        </c:if>
                                                        <c:if test="${tblTender.isDocfeesApplicable eq 0}">
                                                            <option value="0" selected><spring:message code="label_dontallow" /></option>
                                                            <option value="1" ><spring:message code="label_allow" /></option>
                                                        </c:if>
                                                        </c:if>
                                                    </select>                                                            
                                                </div>
                                                <div id="DocumentFees">
                                                    <div class="col-lg-2">
                                                        <div class="form_filed"><spring:message code="lbl_enter_document_fees" /><span class="red">*</span></div>
                                                    </div>
                                                    <div class="col-lg-5">
                                                        <c:if test="${empty Operation}">
                                                            <input type="number"  name="txtDocFees" id="txtDocFees" class="form-control" title="Document Fees." onblur="validateDocFees(this)" >   
                                                        </c:if>
                                                        <c:if test="${not empty Operation}">
                                                            <c:if test="${tblTender.isDocfeesApplicable eq 1}">
                                                                <input type="number"  name="txtDocFees" id="txtDocFees" class="form-control" title="Document Fees." onblur="validateDocFees(this)" value="${tblTender.documentFee}">    
                                                            </c:if>
                                                            <c:if test="${tblTender.isDocfeesApplicable eq 0}">
                                                                <input type="number"  name="txtDocFees" id="txtDocFees" class="form-control" title="Document Fees." onblur="validateDocFees(this)">    
                                                            </c:if>
                                                        </c:if>
                                                    </div>

                                                    <div class="col-lg-2 col-md-2">
                                                        <div class="form_filed"><spring:message code="lbl_document_fees_payable" /></div>
                                                    </div>
                                                    <div class="col-lg-5 col-md-5">
                                                        <c:if test="${empty Operation}">
                                                            <textArea rows="10" cols="50" class="form-control" name="txtDocFeesPayableAt" id="txtDocFeesPayableAt" title="Document Fees Payable At." onblur="validateDocFees(this)" ></textArea>
                                                        </c:if>
                                                        <c:if test="${not empty Operation}">
                                                            <textArea rows="10" cols="50" class="form-control" name="txtDocFeesPayableAt" id="txtDocFeesPayableAt" title="Document Fees Payable At." onblur="validateDocFees(this)">${tblTender.docFeePaymentAddress}</textArea>
                                                        </c:if>
</div>                                              </div>
                                                </div>
                                                                                                                        
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed"><spring:message code="lbl_pariticipation_fees" /></div>
                                                            </div>
                                                            <div class="col-lg-5">
                                                                <select class="form-control" id="optPartFees" name="optPartFees" onchange="IsParticipationFeesRequire(this.value)">
                                                                    <c:if test="${empty Operation}">
                                                                        <option value="1"><spring:message code="lbl_allowed" /></option>
                                                                        <option value="0" selected><spring:message code="lbl_notallowed" /></option> 
                                                                    </c:if>
                                                                    <c:if test="${not empty Operation}">
                                                                        <c:if test="${tblTender.isParticipationFeesBy eq 1}">
                                                                            <option value="1" selected><spring:message code="lbl_allowed" /></option>
                                                                            <option value="0" ><spring:message code="lbl_notallowed" /></option>
                                                                        </c:if>
                                                                        <c:if test="${tblTender.isParticipationFeesBy eq 0}">
                                                                            <option value="0" selected><spring:message code="lbl_notallowed" /></option>
                                                                            <option value="1" ><spring:message code="lbl_allowed" /></option>
                                                                        </c:if>
                                                                    </c:if>

                                                                </select>                                                            
                                                            </div>
                                                            <div id="ParticipatonFees">
                                                                <div class="col-lg-2">
                                                                <div class="form_filed"><spring:message code="lbl_enter_participation_fees" /><span class="red">*</span></div>
                                                            </div>
                                                            <div class="col-lg-5">
                                                                <c:if test="${empty Operation}">
                                                                    <input type="number" class="form-control" name="txtPartFees" id="txtPartFees" title="Participation Fees." onblur="validateParticipantFees(this)">                                                           
                                                                </c:if>
                                                                <c:if test="${not empty Operation}">
                                                                    <c:if test="${tblTender.isParticipationFeesBy eq 1}">
                                                                        <input type="number" class="form-control" name="txtPartFees" id="txtPartFees" title="Participation Fees." onblur="validateParticipantFees(this)" value="${tblTender.participationFees}">     
                                                                        </c:if>
                                                                        <c:if test="${tblTender.isParticipationFeesBy eq 0}">
                                                                            <input type="number" class="form-control" name="txtPartFees" id="txtPartFees" title="Participation Fees." onblur="validateParticipantFees(this)">     
                                                                            </c:if>
                                                                </c:if>
                                                            </div>
                                                                 <div class="col-lg-2 col-md-2">
                                                                <div class="form_filed"><spring:message code="lbl_participation_fees_payable" /></div>
                                                                </div>
                                                                <div class="col-lg-5 col-md-5">
                                                                    <c:if test="${empty Operation}">
                                                                       <textArea rows="10" cols="50" class="form-control" name="txtParticipationFeesPayableAt" id="txtParticipationFeesPayableAt" title="Participation Fees Payable At." onblur="validateParticipantFees(this)" ></textArea>
                                                                 
                                                                    </c:if>
                                                                    <c:if test="${not empty Operation}">
                                                                        <textArea rows="10" cols="50" class="form-control" name="txtParticipationFeesPayableAt" id="txtParticipationFeesPayableAt" title="Participation Fees Payable At." onblur="validateParticipantFees(this)">${tblTender.participationFeesPaymentAddress}</textArea>
                                                                    </c:if>
                                                                    </div>
                                                            </div>
                                                           
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed"><spring:message code="lbl_emd_required" /></div>
                                                            </div>
                                                            <div class="col-lg-5">
                                                                <select class="form-control" id="optEMDReq" name="optEMDReq" onchange="IsEMDRequire(this.value)" >
                                                                    <option value="-1"><spring:message code="label_select" /></option>
                                                                    <c:if test="${empty Operation}">
                                                                        <option value="1"><spring:message code="lbl_allowed" /></option>
                                                                    <option value="0" selected><spring:message code="lbl_notallowed" /></option>
                                                                    </c:if>
                                                                    <c:if test="${not empty Operation}">
                                                                        <c:if test="${tblTender.EMDRequired eq 1}">
                                                                            <option value="1" selected><spring:message code="lbl_allowed" /></option>
                                                                            <option value="0" ><spring:message code="lbl_notallowed" /></option>
                                                                        </c:if>
                                                                        <c:if test="${tblTender.EMDRequired eq 0}">
                                                                            <option value="1" ><spring:message code="lbl_allowed" /></option>
                                                                            <option value="0" selected><spring:message code="lbl_notallowed" /></option>
                                                                        </c:if>
                                                                    </c:if>
								</select> 
                                                            </div>
                                                            <div id='EMDfees'>
                                                                <div class="col-lg-2">
                                                                <div class="form_filed"><spring:message code="lbl_enter_emd_fees" /><span class="red">*</span></div>
                                                            </div>
                                                            <div class="col-lg-5">
                                                                <c:if test="${empty Operation}">
                                                                    <input type="text" name="txtEMDFees" id="txtEMDFees" class="form-control"  title="EMD Fees." onblur="validateEmdFees(this)">
                                                                </c:if>
                                                                <c:if test="${not empty Operation}">
                                                                     <input type="number" name="txtEMDFees" id="txtEMDFees" class="form-control"  title="EMD Fees."  onblur="validateEmdFees(this)" value="${tblTender.EMDFees}">
                                                                </c:if>                                                           
                                                            </div>
                                                                <div class="col-lg-2 col-md-2">
                                                                <div class="form_filed"><spring:message code="lbl_emd_fees_payable" /></div>
                                                                </div>
                                                                <div class="col-lg-5 col-md-5">
                                                                    <c:if test="${empty Operation}">
                                                                        <textArea rows="10" cols="50" class="form-control" name="txtEMDFeesPayableAt" id="txtEMDFeesPayableAt" title="EMD Fees Payable At." onblur="validateEmdFees(this)" ></textArea>
                                                                
                                                                    </c:if>
                                                                    <c:if test="${not empty Operation}">
                                                                    <textArea rows="10" cols="50" class="form-control" name="txtEMDFeesPayableAt" id="txtEMDFeesPayableAt" title="EMD Fees Payable At." onblur="validateEmdFees(this)">${tblTender.emdPaymentAddress}</textArea>
                                                                    </c:if>
                                                                    </div>
                                                            </div>
                                                        
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed"><spring:message code="lbl_product_location" /><span class="red">*</span></div>
                                                            </div>
                                                            <div class="col-lg-5">
                                                                <c:if test="${empty Operation}">
                                                                  <input type="text" name="txtProductLoc" id="txtProductLoc" class="form-control" validarr="required@@tenderbrief:50" tovalid="true" onblur="validateTextComponent(this)" title="Product Location."/>
                                                              
                                                                </c:if>
                                                                <c:if test="${not empty Operation}">
                                                                  <input type="text" name="txtProductLoc" id="txtProductLoc" class="form-control" validarr="required@@tenderbrief:50" tovalid="true" onblur="validateTextComponent(this)" title="Product Location." value="${tblTender.productLocation}"/>
                                                             
                                                                </c:if>
                                                                  </div>
                                                            
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed"><spring:message code="lbl_types_contract" /><span class="red">*</span></div>
                                                            </div>
                                                            <div class="col-lg-5">
                                                                <select class="form-control" id="optTypeOfContract" name="optTypeOfContract" title="Contract Type" onblur="validateCombo(this);" isrequired="true">
                                                                    <option value="-1"><spring:message code="label_select" /></option>
                                                                    <c:if test="${empty Operation}">
                                                                        <c:forEach items="${tblProcurementNature}" var="item"> 
                                        			<option value="${item[0]}">${item[1]}</option>
                                                                </c:forEach> 
                                                                    </c:if>
                                                                    <c:if test="${not empty Operation}">
                                                                        <c:forEach items="${tblProcurementNature}" var="item"> 
                                                                                                    <c:if test="${tblTender.contractTypeId eq item[0]}">
                                                                                                        <option value="${item[0]}" selected>${item[1]}</option>
                                                                                                    </c:if>
                                                                                                    <c:if test="${tblTender.contractTypeId ne item[0]}">
                                                                                                        <option value="${item[0]}">${item[1]}</option>
                                                                                                    </c:if>
					                                        			
					                                        		</c:forEach> 
                                                                    </c:if>
                                                                 
                                                                
                                                                 
								</select>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed"><spring:message code="lbl_bidding_access" /><span class="red">*</span></div>
                                                            </div>
                                                            <div class="col-lg-5">
                                                                <c:if test="${empty Operation}">
                                                                     <input type="radio" name="rdoBiddingAccess" value="1" checked >Open
                                                                <input type="radio" name="rdoBiddingAccess" value="0" >Limited   
                                                                </c:if>
                                                                <c:if test="${not empty Operation}">
                                                                     <c:if test="${tblTender.biddingAccess eq 1}">
                                                                        <input type="radio" name="rdoBiddingAccess" value="1" checked >Open
                                                                        <input type="radio" name="rdoBiddingAccess" value="0" >Limited    
                                                                    </c:if>
                                                                    <c:if test="${tblTender.biddingAccess eq 0}">
                                                                        <input type="radio" name="rdoBiddingAccess" value="1"  >Open
                                                                        <input type="radio" name="rdoBiddingAccess" value="0" checked >Limited  
                                                                    </c:if>
                                                                </c:if>
                                                                    
                                                                                                                           
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed"><spring:message code="lbl_auction_access" /><span class="red">*</span></div>
                                                            </div>
                                                            <div class="col-lg-5">
                                                                <c:if test="${empty Operation}">
                                                                    <input type="radio" name="rdoAuctionMethod" value="1" id="rdoAuctionMethodF" checked onchange="changeAuctionMethod()">Forward
                                                                        <input type="radio" name="rdoAuctionMethod" id="rdoAuctionMethodR" value="0" onchange="changeAuctionMethod()">Reverse    
                                                                          
                                                                </c:if>
                                                                <c:if test="${not empty Operation}">
                                                                     <c:if test="${tblTender.auctionMethod eq 1}">
                                                                        <input type="radio" name="rdoAuctionMethod" value="1" id="rdoAuctionMethodF" checked onchange="changeAuctionMethod()" >Forward
                                                                     <input type="radio" name="rdoAuctionMethod" id="rdoAuctionMethodR" value="0" onchange="changeAuctionMethod()" >Reverse       
                                                                    </c:if>
                                                                     <c:if test="${tblTender.auctionMethod eq 0}">
                                                                     <input type="radio" name="rdoAuctionMethod" value="1" id="rdoAuctionMethodF" onchange="changeAuctionMethod()" >Forward
                                                                     <input type="radio" name="rdoAuctionMethod" id="rdoAuctionMethodR" value="0" checked onchange="changeAuctionMethod()">Reverse       
                                                                    </c:if>
                                                                </c:if>
                                                                                                                                               
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed"><spring:message code="lbl_auction_variant" /><span class="red">*</span></div>
                                                            </div>
                                                            <div class="col-lg-5">
                                                                <c:if test="${empty Operation}">
                                                                   <input type="radio" name="rdoAuctionVariant" value="1" checked ><spring:message code="lbl_standard" />
                                                                <input type="radio" name="rdoAuctionVariant" value="0" ><spring:message code="lbl_rank" />  
                                                                </c:if>
                                                                    <c:if test="${not empty Operation}">
                                                                        <c:if test="${tblTender.biddingVariant eq 1}">
                                                                        <input type="radio" name="rdoAuctionVariant" value="1" checked ><spring:message code="lbl_standard" />
                                                                <input type="radio" name="rdoAuctionVariant" value="0" ><spring:message code="lbl_rank" />   
                                                                    </c:if>
                                                                    <c:if test="${tblTender.biddingVariant eq 0}">
                                                                        <input type="radio" name="rdoAuctionVariant" value="1"  ><spring:message code="lbl_standard" />
                                                                <input type="radio" name="rdoAuctionVariant" value="0" checked ><spring:message code="lbl_rank" /> 
                                                                    </c:if>
                                                                    </c:if>  
                                                                                                                                                     
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed"><spring:message code="lbl_bid_submission" /><span class="red">*</span></div>
                                                            </div>
                                                            <div class="col-lg-5">
                                                               <!-- <br>
                                                                    <input type="radio" name="rdoBidSubmissionFor" value="1" checked >Item Wise
                                                                <input type="radio" name="rdoBidSubmissionFor" value="0" >Grand Total  -->  
                                                                 <div class="form_filed"><spring:message code="lbl_grand_total" /></div>                                                                                    
                                                            </div>
                                                           
                                                           
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed"><spring:message code="lbl_base_currency" /><span class="red">*</span></div>
                                                            </div>
                                                            <div class="col-lg-5">
                                                                <select class="form-control"  id="optBaseCurrency" name="optBaseCurrency" title="Base Currency" onblur="return validateCombo(this)"  isrequired="true" >
                                                                    <option value="-1">${label_select}</option>
                                                                    <c:if test="${empty Operation}">
                                                                        <c:forEach var="item" items="${tblCurrencyList}">
                                                                            <c:set var="chk" value="0"/>
                                                                            <c:forEach items="${tblCurrencyMapList}" var="map">
                                                                                <c:if test="${item[0] eq map.value}">
                                                                                    <c:set var="chk" value="1"/>
                                                                                </c:if>
                                                                            </c:forEach>
                                                                            <c:if test="${chk eq 1}">
                                                                                <option value="${item[0]}">${item[1]}</option>
                                                                            </c:if>
                                                                            
                                                                        </c:forEach>
                                                                    </c:if>
                                                                    <c:if test="${not empty Operation}">
                                                                        <c:forEach var="item" items="${tblCurrencyList}">
                                                                            <c:set var="chk" value="0"/>
                                                                            <c:forEach items="${tblCurrencyMapList}" var="map">
                                                                                <c:if test="${item[0] eq map.value}">
                                                                                    <c:set var="chk" value="1"/>
                                                                                </c:if>
                                                                            </c:forEach>
                                                                             <c:if test="${chk eq 1}">
                                                                                <c:if test="${tblTender.currencyId eq item[0]}">
                                                                                    <option value="${item[0]}" selected>${item[1]}</option>
                                                                                </c:if>
                                                                                <c:if test="${tblTender.currencyId ne item[0]}">
                                                                                    <option value="${item[0]}" >${item[1]}</option>
                                                                                </c:if>
                                                                            </c:if>
                                                                        </c:forEach>
                                                                    </c:if>
                                                                    
                                                                </select> 
                                                            </div>
                                                             <div class="col-lg-2">
                                                                <div class="form_filed"><spring:message code="lbl_biddingType" /><span class="red">*</span></div>
                                                            </div>
                                                            <div class="col-lg-5">
                                                                <c:if test="${empty Operation}">
                                                                  <input type="radio" id="rdoBiddingTypeGlobal" name="rdobiddingType" value="2" onchange="getBidCurrency(this)">Global
                                                                <input type="radio" id="rdoBiddingTypeDomestic" name="rdobiddingType" value="1" onchange="getBidCurrency(this)" checked >Domestic  
                                                                   
                                                                </c:if>
                                                                <c:if test="${not empty Operation}">
                                                                    <c:if test="${tblTender.biddingType eq 2}">
                                                                        <input type="radio" id="rdoBiddingTypeGlobal" name="rdobiddingType" value="2" checked onchange="getBidCurrency(this)" >Global
                                                                <input type="radio" id="rdoBiddingTypeDomestic" name="rdobiddingType" value="1" onchange="getBidCurrency(this)" >Domestic  
                                                                    </c:if>
                                                                    <c:if test="${tblTender.biddingType eq 1}">
                                                                        <input type="radio" id="rdoBiddingTypeGlobal" name="rdobiddingType" value="2" onchange="getBidCurrency(this)" >Global
                                                                <input type="radio" id="rdoBiddingTypeDomestic" name="rdobiddingType" value="1" checked  onchange="getBidCurrency(this)">Domestic  
                                                                    </c:if> 
                                                                </c:if>
                                                                                                                                                 
                                                            </div>
                                                        </div>
                                                        <div id="divBidCurrency">
                                                            <div class="row">
                                                                <div class="col-lg-2">
                                                                    <div class="form_filed"><spring:message code="lbl_bid_currency" /><span class="red">*</span></div>
                                                                </div>
                                                                <div class="col-lg-5">
                                                                    <div class="form-group">
                                                                        <c:if test="${empty Operation}">
                                                                            <c:forEach var="item" items="${tblCurrencyList}">
                                                                                <c:set var="chk" value="0"/>
                                                                                <c:forEach items="${tblCurrencyMapList}" var="map">
                                                                                    <c:if test="${item[0] eq map.value}">
                                                                                        <c:set var="chk" value="1"/>
                                                                                    </c:if>
                                                                                </c:forEach>
                                                                                <c:if test="${chk eq 1}">
                                                                                    <div class="row">
                                                                                        <div class="col-lg-4">
                                                                                            <input type="checkbox"  name="chkBidCurrency" id="chk_${item[0]}" value="${item[0]}" onchange="showCurrencyConversionRate(this)">${item[1]}
                                                                                        </div>
                                                                                        <div id="dvCurrencyConversion_${item[0]}">
                                                                                            <div class="col-lg-4">
                                                                                            <div class="form_filed"><spring:message code="lbl_currency_conversion_rate" /><span class="red">*</span></div>
                                                                                            </div>
                                                                                            <div class="col-lg-4">
                                                                                                <div class="form-group">
                                                                                                    <input type="text" name="txtExchangeRate_${item[0]}" id="txtExchangeRate_${item[0]}" class="form-control" onblur="validateCurrencyConversionRate(this)" title="Currency Conversion Rate.">
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                </c:if>
                                                                            </c:forEach>
                                                                            
                                                                        </c:if>
                                                                        <c:if test="${not empty Operation}">
                                                                            <c:forEach var="item" items="${tblCurrencyList}">
                                                                                <c:set var="chk" value="0"/>
                                                                                <c:forEach items="${tblCurrencyMapList}" var="map">
                                                                                    <c:if test="${item[0] eq map.value}">
                                                                                        <c:set var="chk" value="1"/>
                                                                                    </c:if>
                                                                                </c:forEach>
                                                                                <c:forEach var="item1" items="${tenderCurrency}">
                                                                                    <c:if test="${item1[0] eq item[0]}">
                                                                                        <c:set var="exchangeRate" value="${item1[1]}"/>
                                                                                        <c:set var="bidCurrId" value="${item1[0]}"/> 
                                                                                    </c:if>
                                                                                </c:forEach>
                                                                                <c:if test="${chk eq 1}">
                                                                                    <c:if test="${bidCurrId eq item[0]}">
                                                                                        <div class="row">
                                                                                            <div class="col-lg-4">
                                                                                                <input type="checkbox"  name="chkBidCurrency" id="chk_${item[0]}" value="${item[0]}" onchange="showCurrencyConversionRate(this)" checked>${item[1]}
                                                                                            </div>
                                                                                            <div id="dvCurrencyConversion_${item[0]}">
                                                                                            <div class="col-lg-4">
                                                                                                <div class="form_filed"><spring:message code="lbl_currency_conversion_rate" /><span class="red">*</span></div>
                                                                                            </div>
                                                                                            <div class="col-lg-4">
                                                                                                <div class="form-group">
                                                                                                    <input type="text" name="txtExchangeRate_${item[0]}" id="txtExchangeRate_${item[0]}" value="${exchangeRate}" class="form-control"  title="Currency Conversion Rate.">
                                                                                                </div>
                                                                                            </div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </c:if> 
                                                                                    <c:if test="${bidCurrId ne item[0]}">
                                                                                        <div class="row">
                                                                                            <div class="col-lg-4">
                                                                                                <input type="checkbox"  name="chkBidCurrency" id="chk_${item[0]}" value="${item[0]}" onchange="showCurrencyConversionRate(this)">${item[1]}
                                                                                            </div>
                                                                                            <div id="dvCurrencyConversion_${item[0]}">
                                                                                                <div class="col-lg-4">
                                                                                                    <div class="form_filed"><spring:message code="lbl_currency_conversion_rate" /><span class="red">*</span></div>
                                                                                                </div>
                                                                                                <div class="col-lg-4">
                                                                                                    <div class="form-group">
                                                                                                        <input type="text" name="txtExchangeRate_${item[0]}" id="txtExchangeRate_${item[0]}"  class="form-control"  title="Currency Conversion Rate." onblur="validateCurrencyConversionRate(this)">
                                                                                                    </div>
                                                                                                </div>
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
                                                        
                                                                <div class="row" style="display:none">
                                                            <div class="col-lg-2">  
                                                                <div class="form_filed"><spring:message code="lbl_accept_start_price" /></div>
                                                            </div>
                                                            <div class="col-lg-5">
                                                                <c:if test="${empty Operation}">
                                                                       <input type="radio" id="rdoAcceptStartPrice" name="rdoAcceptStartPrice" value="1" checked  >Yes
                                                                <input type="radio" id="rdoAcceptStartPrice" name="rdoAcceptStartPrice" value="0"  >No  
                                                                  
                                                                </c:if>
                                                                <c:if test="${not empty Operation}">
                                                                   
                                                                    <c:if test="${tblTender.isAcceptStartPrice eq 1}">
                                                                         <input type="radio" name="rdoAcceptStartPrice" value="1" checked >Yes
                                                                <input type="radio" name="rdoAcceptStartPrice" value="0" >No
                                                                    </c:if>
                                                                    <c:if test="${tblTender.isAcceptStartPrice eq 0}">
                                                                         <input type="radio" name="rdoAcceptStartPrice" value="1"  >Yes
                                                                <input type="radio" name="rdoAcceptStartPrice" value="0" checked>No
                                                                    </c:if>
                                                                </c:if>
                                                                  
                                                            </div>
                                                            
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">  
                                                                <div class="form_filed"><spring:message code="lbl_start_price" /><span class="red">*</span></div>
                                                            </div>
                                                            <div class="col-lg-5">
                                                                <c:if test="${empty Operation}">
                                                                    <input type="text" name="txtStartPrice" id="txtStartPrice" class="form-control" title="Start Price." validarr="required@@lengthForNum:15@@numericdecimal" tovalid="true"  onblur="validateTextComponent(this)"/>
                                                                </c:if>
                                                                <c:if test="${not empty Operation}">
                                                                     <input type="text" name="txtStartPrice" id="txtStartPrice" class="form-control" value="${tblTender.startPrice}" title="Start Price." validarr="required@@lengthForNum:15@@numericdecimal" tovalid="true"  onblur="validateTextComponent(this)"/>
                                                                </c:if>
                                                            </div>
                                                            
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">  
                                                                <div class="form_filed"><spring:message code="lbl_want_to_add_reverse_price" /></div>
                                                            </div>
                                                            <div class="col-lg-5">
                                                                 <c:if test="${empty Operation}">
                                                                    <input type="radio" name="rdoAddReservePrice" value="1" id="rdoAddReservePriceY"  onchange="changeIsAddReservePrice()">Yes
                                                                        <input type="radio" name="rdoAddReservePrice" id="rdoAddReservePriceN" value="0" checked onchange="changeIsAddReservePrice()">No    
                                                                    </c:if>
                                                                    <c:if test="${not empty Operation}">
                                                                         <c:if test="${tblTender.isReservePriceConfigure eq 1}">
                                                                        <input type="radio" name="rdoAddReservePrice" value="1" id="rdoAddReservePriceY" checked onchange="changeIsAddReservePrice()">Yes
                                                                        <input type="radio" name="rdoAddReservePrice" id="rdoAddReservePriceN" value="0" onchange="changeIsAddReservePrice()">No    
                                                                    </c:if>
                                                                    <c:if test="${tblTender.isReservePriceConfigure eq 0}">
                                                                        <input type="radio" name="rdoAddReservePrice" value="1" id="rdoAddReservePriceY" onchange="changeIsAddReservePrice()">Yes
                                                                        <input type="radio" name="rdoAddReservePrice" id="rdoAddReservePriceN" value="0"  checked onchange="changeIsAddReservePrice()">No    
                                                                    </c:if>
                                                                    </c:if>   
                                                            </div>
                                                            
                                                        </div>
                                                        
                                                            <div class="row" id="divReservePrice">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed"><spring:message code="lbl_auction_reverse_price" /></div>
                                                            </div>
                                                            <div class="col-lg-5">
                                                                <c:if test="${empty Operation}">
                                                                   <input type="text" name="txtAuctionRevPrice" id="txtAuctionRevPrice" title="Reserve Price." onblur="validateAuctionReservePrice(this);" class="form-control"/>
                                                            
                                                                </c:if>
                                                                <c:if test="${not empty Operation}">
                                                                     <input type="text" name="txtAuctionRevPrice" id="txtAuctionRevPrice" class="form-control" value="${tblTender.auctionReservePrice}" title="Reserve Price." onblur="validateAuctionReservePrice(this)"/>
                                                                </c:if>
                                                                 </div>
                                                            
                                                        </div>
                                                            <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">
                                                                <div id="methodLabel">
                                                                    <c:if test="${not empty Operation}">
                                                                        <c:if test="${tblTender.auctionMethod eq 1}"><spring:message code="lbl_increment_value" /><span class="red">*</span></c:if>
                                                                    
                                                                <c:if test="${tblTender.auctionMethod eq 0}"><spring:message code="lbl_decrement_vallue" /><span class="red">*</span></c:if>
                                                                    </c:if>
                                                                    </div><span class="red">*</span>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-5">
                                                                <c:if test="${empty Operation}">
                                                                     <input type="text" name="txtIncrementDecrementVal" title=""  validarr="required@@lengthForNum:10@@numericdecimal" tovalid="true"  onblur="validateTextComponent(this)" class="form-control"/>
                                                                </c:if>
                                                                <c:if test="${not empty Operation}">
                                                                     <input type="text" name="txtIncrementDecrementVal" title="" class="form-control" value="${tblTender.incrementDecrementValues}" validarr="required@@lengthForNum:10@@numericdecimal" tovalid="true"  onblur="validateTextComponent(this)"/>
                                                                </c:if>
                                                               
                                                            </div>
                                                            
                                                        
                                                        </div>
                                                            <div class="row" style="display:none">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed"><spring:message code="lbl_bidding_form" /></div>
                                                            </div>
                                                            <div class="col-lg-5">
                                                                <c:if test="${empty Operation}">
                                                                    <input type="radio" name="rdoBiddingForm" value="1" checked ><spring:message code="lbl_create_new_form" />
                                                                <input type="radio" name="rdoBiddingForm" value="0" ><spring:message code="lbl_add_standard_form" />   
                                                                </c:if>
                                                                <c:if test="${not empty Operation}">
                                                                    
                                                                    <c:if test="${tblTender.isCreateNewForm eq 1}">
                                                                    <input type="radio" name="rdoBiddingForm" value="1" checked ><spring:message code="lbl_create_new_form" />
                                                                    <input type="radio" name="rdoBiddingForm" value="0" ><spring:message code="lbl_add_standard_form" />    
                                                                </c:if>
                                                                <c:if test="${tblTender.isCreateNewForm eq 0}">
                                                                    <input type="radio" name="rdoBiddingForm" value="1" ><spring:message code="lbl_create_new_form" />
                                                                    <input type="radio" name="rdoBiddingForm" value="0" checked  ><spring:message code="lbl_add_standard_form" />     
                                                                </c:if>
                                                                </c:if>
                                                                     
                                                                                                                                                     
                                                            </div>
                                                        </div>
                                                        
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed"><spring:message code="lbl_auction_start_date" /><span class="red">*</span></div>
                                                            </div>
                                                            <div class="col-lg-5">
                                                                <c:if test="${empty Operation}">
                                                                    <input id="txtAuctionStartDate" name="txtAuctionStartDate"   type="text"  
                                                                 datepicker="yes"  
                                                                 placeholder="${client_dateformate_hhmm}" 
                                                                 class="dateBox pull-left form-control"
                                                                 title="Auction Start Date"
                                                                 dtrequired="true"
                                                                 onblur="doChangeForDateValidation(this)"  datevalidate='gt:c,lt:txtAuctionEndDate'  
                                                                 
                                                                 >
                                                                </c:if>
                                                                <c:if test="${not empty Operation}">
                                                                    <fmt:parseDate value="${auctionStartDate}" pattern="${client_dateformate_hhmm}" var="myDate"/>
                                                          
                                                              <fmt:formatDate value="${myDate}" var="formattedDate"  type="date" pattern="${client_dateformate_hhmm}" />
                                                             
                                                                   <input id="txtAuctionStartDate" name="txtAuctionStartDate"   type="text"  
                                                                 datepicker="yes" 
                                                                 placeholder="${client_dateformate_hhmm}" 
                                                                 class="dateBox pull-left form-control" value="${formattedDate}"
                                                                 title="Auction Start Date." onblur="doChangeForDateValidation(this)"  datevalidate='gt:c,lt:txtAuctionEndDate' dtrequired="true"
                                                                 >
                                                                </c:if>
                                                               
                                                                                                                         
                                                            </div>
                                                            </div>
                                                            <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed"><spring:message code="lbl_auction_end_date" /><span class="red">*</span></div>
                                                            </div>
                                                            <div class="col-lg-5">
                                                                <c:if test="${empty Operation}">
                                                                     <input id="txtAuctionEndDate" name="txtAuctionEndDate"   type="text"  
                                                                 datepicker="yes"
                                                                 placeholder="${client_dateformate_hhmm}" 
                                                                 class="dateBox pull-left form-control"
                                                                 title="Auction End Date." 
                                                                 dtrequired="true"
                                                                 onblur="doChangeForDateValidation(this)"  datevalidate='gt:c,gt:txtAuctionStartDate' 
                                                                 >
                                                                </c:if>
                                                                <c:if test="${not empty Operation}">
                                                                      <fmt:parseDate value="${auctionEndDate}" pattern="${client_dateformate_hhmm}" var="myDate"/>
                                                                <fmt:formatDate value="${myDate}" var="formattedDate" type="date" pattern="${client_dateformate_hhmm}" />
                                                            
                                                               <input id="txtAuctionEndDate" name="txtAuctionEndDate"   type="text"  
                                                                 datepicker="yes" 
                                                                 placeholder="${client_dateformate_hhmm}" 
                                                                 class="dateBox pull-left form-control" value="${formattedDate}"
                                                                 title="Auction End Date." onblur="doChangeForDateValidation(this)"  datevalidate='gt:c,gt:txtAuctionStartDate' dtrequired="true"
                                                                 >
                                                                </c:if>
                                                              
                                                                                                         
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed"><spring:message code="lbl_auto_extension" /><span class="red">*</span></div>
                                                            </div>
                                                            <div class="col-lg-5">
                                                                <c:if test="${empty Operation}">
                                                                        <input type="radio" name="rdoAutoExtension" id="rdoAutoExtensionYes" value="1" onchange="changeAutoExtension()" checked >Yes
                                                                <input type="radio" name="rdoAutoExtension" id="rdoAutoExtensionNo" onchange="changeAutoExtension()" value="0" >No    
                                                                   
                                                                </c:if>
                                                                <c:if test="${not empty Operation}">
                                                                    <c:if test="${tblTender.allowsAutoExtension eq 1}">
                                                                        <input type="radio" name="rdoAutoExtension" id="rdoAutoExtensionYes" value="1" onchange="changeAutoExtension()" checked >Yes
                                                                <input type="radio" name="rdoAutoExtension" id="rdoAutoExtensionNo" onchange="changeAutoExtension()" value="0" >No    
                                                                    </c:if>
                                                                    <c:if test="${tblTender.allowsAutoExtension eq 0}">
                                                                        <input type="radio" name="rdoAutoExtension" id="rdoAutoExtensionYes" value="1" onchange="changeAutoExtension()"  >Yes
                                                                <input type="radio" name="rdoAutoExtension" id="rdoAutoExtensionNo" onchange="changeAutoExtension()" value="0" checked>No    
                                                                    </c:if>
                                                                    
                                                                </c:if>
                                                                                                                                                  
                                                            </div>
                                                        </div>
                                                        <div id="AutoExtension">
                                                            
                                                            <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed"><spring:message code="lbl_extend_time_when_bid_received" /><span class="red">*</span></div>
                                                            </div>
                                                            <div class="col-lg-5">
                                                                <c:if test="${empty Operation}">
                                                                    <input type="number" name="txtExtendedTime" id="txtExtendedTime" class="form-control"
                                                                       title="extend time when valid bid received in last(in minutes)." onblur="validateAutoExtension(this)"
                                                                       />
                                                                </c:if>
                                                                <c:if test="${not empty Operation}">
                                                                    <input type="number" name="txtExtendedTime" id="txtExtendedTime" class="form-control" value="${tblTender.extendTimeWhen}"
                                                                       title="extend time when valid bid received in last(in minutes)." onblur="validateAutoExtension(this)"
                                                                       />
                                                                </c:if>
                                                                
                                                            </div>
                                                                 </div>
                                                                <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed"><spring:message code="lbl_extend_time_by" /><span class="red">*</span></div>
                                                            </div>
                                                            <div class="col-lg-5">
                                                                <c:if test="${empty Operation}">
                                                                <input type="number" name="txtExtendedTimeBy" id="txtExtendedTimeBy" class="form-control"
                                                                title="extend time by(in minutes)."  onblur="validateAutoExtension(this)" 
                                                                       />
                                                                </c:if>
                                                                <c:if test="${not empty Operation}">
                                                                <input type="number" name="txtExtendedTimeBy" id="txtExtendedTimeBy" class="form-control" value="${tblTender.extendTimeBy}"
                                                                       title="extend time by(in minutes)." onblur="validateAutoExtension(this)"
                                                                       />
                                                                 </c:if>
                                                            </div>
                                                                        </div> 
                                                            <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed"><spring:message code="lbl_auto_extension_mode" /><span class="red">*</span></div>
                                                            </div>
                                                                <div class="col-lg-5"><c:if test="${empty Operation}">
                                                                        <input type="radio" name="rdoAutoExtensionMode" id="rdoAutoExtensionModeYes" value="1" onchange="changeAutoExtensionMode()" checked >Limited
                                                                <input type="radio" name="rdoAutoExtensionMode" id="rdoAutoExtensionModeNo" value="0" onchange="changeAutoExtensionMode()" >Unlimited    
                                                                    </c:if>
                                                                    <c:if test="${not empty Operation}">
                                                                        <c:if test="${tblTender.autoExtensionMode eq 1}">
                                                                        <input type="radio" name="rdoAutoExtensionMode" id="rdoAutoExtensionModeYes" value="1" onchange="changeAutoExtensionMode()" checked >Limited
                                                                        <input type="radio" name="rdoAutoExtensionMode" id="rdoAutoExtensionModeNo" value="0" onchange="changeAutoExtensionMode()" >Unlimited    
                                                                           
                                                                    </c:if>
                                                                            <c:if test="${tblTender.autoExtensionMode eq 0}">
                                                                        <input type="radio" name="rdoAutoExtensionMode" id="rdoAutoExtensionModeYes" value="1" onchange="changeAutoExtensionMode()"  >Limited
                                                                        <input type="radio" name="rdoAutoExtensionMode" id="rdoAutoExtensionModeNo" value="0" onchange="changeAutoExtensionMode()"checked >Unlimited    
                                                                           
                                                                    </c:if>
                                                                    </c:if>
                                                                
                                                            </div>
                                                            </div>
                                                        
                                                    
                                                       <div id="AutoExtensionMode">
                                                           <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed"><spring:message code="lbl_no_of_extension" /><span class="red">*</span></div>
                                                            </div>
                                                            <div class="col-lg-5">
                                                                <c:if test="${empty Operation}">
                                                                    <input type="number" name="txtNoOfExtension" 
                                                                       title="No. Of Extension." onblur="validateNoOfExtention(this)"
                                                                       class="form-control"/>
                                                                </c:if>
                                                                <c:if test="${not empty Operation}">
                                                                    <input type="number" name="txtNoOfExtension" class="form-control" value="${tblTender.noOfExtension}"
                                                                       title="No. Of Extension." onblur="validateNoOfExtention(this)">
                                                                </c:if>
                                                                
                                                            </div>
                                                            
                                                        
                                                        </div> 
                                                        </div>
                                                        </div>
                                                        
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed"><spring:message code="lbl_accept_decimal_value_upto" /><span class="red">*</span></div>
                                                            </div>
                                                            <div class="col-lg-5">
                                                                <select class="form-control" id="optDecimalVal" name="optDecimalVal" >
                                                                    
								</select> 
                                                            </div>
                                                            
                                                        
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed"><spring:message code="lbl_display_ip_address" /></div>
                                                            </div>
                                                            <div class="col-lg-5">
                                                                <select class="form-control" id="optIPAddress" name="optIPAddress">
                                                                    <option value="-1"><spring:message code="label_select" /></option>
                                                                    <c:if test="${empty Operation}">
                                                                        <option value="1"><spring:message code="label_yes" /></option>
                                                                    <option value="0"><spring:message code="label_no" /></option>
                                                                    </c:if>
                                                                    <c:if test="${not empty Operation}">
                                                                        <c:if test="${tblTender.displayIPAddress eq 1}">
                                                                       <option value="1" selected><spring:message code="label_yes" /></option>
                                                                    <option value="0"><spring:message code="label_no" /></option> 
                                                                    </c:if>
                                                                    <c:if test="${tblTender.displayIPAddress eq 0}">
                                                                       <option value="1" ><spring:message code="label_yes" /></option>
                                                                    <option value="0" selected><spring:message code="label_no" /></option> 
                                                                    </c:if>
                                                                    </c:if>
                                                                    
								</select> 
                                                            </div>
                                                            
                                                        
                                                        </div>
                                                   
                                                        <div class="row">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed"><spring:message code="lbl_approx_event_value" /></div>
                                                            </div>
                                                            <div class="col-lg-5">
                                                                <c:if test="${empty Operation}">
                                                                    <input type="text" name="txtEstimatedValue" id="txtEstimatedValue" title="Event Value." onblur="ValidateEventValue(this)" class="form-control"/>
                                                                
                                                                </c:if>
                                                                <c:if test="${not empty Operation}">
                                                        <%
                                                        TblTender tblTender = (TblTender) request.getAttribute("tblTender");
                                                        int num=(int)tblTender.getestimatedValue();
                                                        float remain=tblTender.getestimatedValue()-num;
                                                       //out.println("remain::"+remain);
                                                        if(remain==0)
                                                        {
                                                        %>
                                                            <input type="text" name="txtEstimatedValue" id="txtEstimatedValue" class="form-control" value="<%=num%>" title="Event Value." onblur="ValidateEventValue(this)"/>
                                                        <%
                                                        }
                                                        else
                                                        {
                                                        %>
                                                            <input type="text" name="txtEstimatedValue" id="txtEstimatedValue" class="form-control" value="${tblTender.estimatedValue}" title="Event Value." onblur="ValidateEventValue(this)"/>
                                                        <%
                                                        }
                                                        %>
                                                                  
                                                                       
                                                                    
                                                                  
                                                           
                                                                </c:if>
                                                                 </div>
                                                        </div> 
                                                    <div class="row"  style="display: none;">
                                                                <div class="col-lg-2">
                                                                    <div class="form_filed"><spring:message code="lbl_auto_result_sharing" /></div>
                                                                </div>
                                                                <div class="col-lg-5">
                                                                    <select id="optAutoResultSharing" name="optAutoResultSharing" class="form-control" title="Auto Result Sharing." onblur="return validateCombo(this)"  isrequired="true">
                                                                        <option value="-1"><spring:message code="label_select" /></option>
                                                                        <c:if test="${empty Operation}">
                                                                            <option value="0" selected><spring:message code="lbl_auto" /></option>
                                                                        <option value="1">
                                                                           Manual
                                                                        </option>
                                                                        </c:if>
                                                                        <c:if test="${not empty Operation}">
                                                                             <c:if test="${tblTender.autoResultSharing eq 0}">
                                                                              <option value="0" selected><spring:message code="lbl_auto" /></option>
                                                                          <option value="1">
                                                                             Manual
                                                                          </option>
                                                                          </c:if>
                                                                           <c:if test="${tblTender.autoResultSharing eq 1}">
                                                                              <option value="0" ><spring:message code="lbl_auto" /></option>
                                                                          <option value="1" selected>
                                                                             <spring:message code="lbl_manual" />
                                                                          </option>
                                                                          </c:if>
                                                                        </c:if>
                                                                        
                                                                    </select>
                                                                </div>
                                                            </div>
															<div class="row">
															<div class="col-lg-2">
                                                                    <div class="form_filed"><spring:message code="lbl_workflow_requires" /></div>
                                                                </div>
                                                                <div class="col-lg-5">
                                                                    <select id="optWorkFlowRequire" name="optWorkFlowRequire" class="form-control">
                                                                        <option value="-1"><spring:message code="label_select" /></option>
                                                                        <c:if test="${empty Operation}">
                                                                            <option value="1"><spring:message code="label_yes" /></option>
                                                                        <option value="0" selected="selected">
                                                                            <spring:message code="label_no" />
                                                                        </option>
                                                                        </c:if>
                                                                        <c:if test="${not empty Operation}">
                                                                            <c:choose>
                                                                        	<c:when test="${tblTender.isWorkflowRequired eq 0}">
	                                                                        	<option value="1"><spring:message code="label_yes" /></option>
	                                                                        	<option value="0" selected="selected"><spring:message code="label_no" /></option>
                                                                        	</c:when>
                                                                        	<c:otherwise>
	                                                                        	<option value="1" selected="selected"><spring:message code="label_yes" /></option>
	                                                                        	<option value="0" ><spring:message code="label_no" /></option>
                                                                        	</c:otherwise>
                                                                        	</c:choose>
                                                                        </c:if>
                                                                    </select>
                                                                </div>
															</div>
                                                        <div class="row">
                                                            <c:if test="${not empty Operation}">
                                                                <input type="hidden" name="departmentId" value="${tblTender.departmentId}">
                                                                <input type="hidden" name="selDeptOfficial" value="${tblTender.officerId}">
                                                                    <input type="hidden" name="opration" value="Edit">
		                                                         <input type="hidden" name="tenderId" value="${tblTender.tenderId}">
                                                            </c:if>
                                                            <div class="col-lg-2"></div>
                                                            <div class="col-lg-5">
                                        <button type="submit" class="btn btn-submit" id="btnSubmitForm">Submit</button>
                                       
                                    </div>
                                                                    
                                                            
                                                        </div>
                                                </div>
                                                
                                            </div>
                                            
                                
                            </div>
                        </div>
                    </div></div>
                </form>
                                                                                                                
              
               
                
                            
                        
            </section>
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
            var subDeptName='${subDeptName}';
         
            var DecimalValue=[1,2,3,4,5];
     var operation='${Operation}';  
     var biddingType='${tblTender.biddingType}';
    function getSubDepartments() {
    	blockUI();
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
                    			unBlockUI()
                    		},
                    		error : function(e) {
                    			console.log("ERROR: ", e);
                    			unBlockUI()
                    		},
                    		done : function(e) {
                    			console.log("DONE");
                    			unBlockUI()
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
                             $('#officerName').html('${officerName}');
            		},
            		error : function(e) {
            			console.log("ERROR: ", e);
            		},
            		done : function(e) {
            			console.log("DONE");
            		}
            	});
            }
            function ValidateEventValue(e){
             var compValEmpty=($(e).val()!='');
             var beforeDot=$(e).val().split(".",1);
            if(compValEmpty && beforeDot[0].length > 10){
                    $(e).parent().append("<div class='err"+$(e).attr('id')+" validationMsg clearfix'> Allow Max.10 positive numbers </div>");
            }
            else
            {
                validateDecimalUpto(e);
            }
            }
            function validateDocFees(e){
               
                $(".err"+$(e).attr('id')).remove();
               
            var compValEmpty=($(e).val()!='');
           // alert($('#optDocFees').val());
            if(parseInt($('#optDocFees option:selected').val())===1){
               // alert($(e).attr('title'));
                if(!compValEmpty){
                    
                        $(e).parent().append("<div class='err"+$(e).attr('id')+" validationMsg clearfix'>Please Enter "+$(e).attr('title')+"</div>");
                    
                }
                else
                {
                    if($(e).attr('id')==='txtDocFees'){
                        var beforeDot=$(e).val().split(".",1);
                        if(compValEmpty && beforeDot[0].length > 10){
                               
                                    $(e).parent().append("<div class='err"+$(e).attr('id')+" validationMsg clearfix'> Allow Max.10 positive numbers </div>");
                               
                            
                        }
                        else
                        {
                            validateDecimalUpto(e);
                        }
                    }
                    else if($(e).attr('id')==='txtDocFeesPayableAt'){
                        if(compValEmpty && $(e).val() > 1000){
                           
                                $(e).parent().append("<div class='err"+$(e).attr('id')+" validationMsg clearfix'> Allows Max. 1000 alphabets, numbers and special characters </div>");
                           
                            
                        }
                        else
                        {
                             $(".err"+$(e).attr('id')).remove();
                        }
                    }
                    
                }
                
            }
             
            }
            function validateCurrencyConversionRate(e){
                $(".err"+$(e).attr('id')).remove();
                if($('#rdoBiddingTypeGlobal').prop('checked')===true){
                if($(e).attr('id')!=='txtExchangeRate_'+$('#optBaseCurrency option:selected').val()){
                    var compValEmpty=($(e).val()!='');
                    if(!compValEmpty){
                        $(e).parent().append("<div class='err"+$(e).attr('id')+" validationMsg clearfix'>Please Enter "+$(e).attr('title')+"</div>");
                    }
                    else
                    {
                        $(".err"+$(e).attr('id')).remove();
                    }
                }
            }
            }
            function validateAuctionReservePrice(e){
                $(".err"+$(e).attr('id')).remove();
                if($('#rdoAddReservePriceY').prop('checked')===true){
                    var compValEmpty=($(e).val()!='');
                    if(!compValEmpty){
                        $(e).parent().append("<div class='err"+$(e).attr('id')+" validationMsg clearfix'>Please Enter "+$(e).attr('title')+"</div>");
                    }
                    else
                    {
                        if(parseInt($(e).val())===0)
                        {
                            $(e).parent().append("<div class='err"+$(e).attr('id')+" validationMsg clearfix'>Zero value is not allowed</div>");
                        }
                        else
                        {
                            var beforeDot=$(e).val().split(".",1);
                            if(compValEmpty && beforeDot[0].length > 15){
                                $(e).parent().append("<div class='err"+$(e).attr('id')+" validationMsg clearfix'> Allows Max. 15 numbers  </div>");
                            }
                            else
                            {
                                $(".err"+$(e).attr('id')).remove();
                            }
                        }
                    }
                }
            }
            function validateParticipantFees(e){
                $(".err"+$(e).attr('id')).remove();
            var compValEmpty=($(e).val()!='');
            if(parseInt($('#optPartFees option:selected').val())===1){
                if(!compValEmpty){
                    $(e).parent().append("<div class='err"+$(e).attr('id')+" validationMsg clearfix'>Please Enter "+$(e).attr('title')+"</div>");
            
                }
                else
                {
                    if($(e).attr('id')==='txtPartFees'){
                        var beforeDot=$(e).val().split(".",1);
                        if(compValEmpty && beforeDot[0].length > 10){
                           
                                $(e).parent().append("<div class='err"+$(e).attr('id')+" validationMsg clearfix'> Allow Max.10 positive numbers </div>");
                           
                            
                        }
                        else
                        {
                            validateDecimalUpto(e);
                        }
                    }
                    else if($(e).attr('id')==='txtParticipationFeesPayableAt'){
                        if(compValEmpty && $(e).val() > 1000){
                           
                                $(e).parent().append("<div class='err"+$(e).attr('id')+" validationMsg clearfix'> Allows Max. 1000 alphabets, numbers and special characters </div>");
                           
                            
                        }
                        else
                        {
                             $(".err"+$(e).attr('id')).remove();
                        }
                    }
                    
                }
                
            }
             
            }
            
            function validateAutoExtension(e){
                 $(".err"+$(e).attr('id')).remove();
                 var compValEmpty=($(e).val()!='');
                if($('#rdoAutoExtensionYes').prop('checked')===true){
                    if(!compValEmpty){
                        $(e).parent().append("<div class='err"+$(e).attr('id')+" validationMsg clearfix'>Please Enter "+$(e).attr('title')+"</div>");
                    }
                    else
                    {
                        if(parseInt($(e).val())===0)
                        {
                            $(e).parent().append("<div class='err"+$(e).attr('id')+" validationMsg clearfix'>Zero value is not allowed</div>");
                        }
                        else
                        {
                            var beforeDot=$(e).val().split(".",1);
                            if(compValEmpty && beforeDot[0].length > 5){
                                $(e).parent().append("<div class='err"+$(e).attr('id')+" validationMsg clearfix'> Allows Max. 5 numbers  </div>");
                            }
                            else
                            {
                                $(".err"+$(e).attr('id')).remove();
                            }
                        }
                    }
                }
            }
            function validateNoOfExtention(e){
                $(".err"+$(e).attr('id')).remove();
                 var compValEmpty=($(e).val()!='');
                if($('#rdoAutoExtensionModeYes').prop('checked')===true){
                    if(!compValEmpty){
                        $(e).parent().append("<div class='err"+$(e).attr('id')+" validationMsg clearfix'>Please Enter "+$(e).attr('title')+"</div>");
                    }
                    else
                    {
                        if(parseInt($(e).val())===0)
                        {
                            $(e).parent().append("<div class='err"+$(e).attr('id')+" validationMsg clearfix'>Zero value is not allowed</div>");
                        }
                        else
                        {
                            var beforeDot=$(e).val().split(".",1);
                            if(compValEmpty && beforeDot[0].length > 5){
                                $(e).parent().append("<div class='err"+$(e).attr('id')+" validationMsg clearfix'> Allows Max. 5 numbers  </div>");
                            }
                            else
                            {
                                $(".err"+$(e).attr('id')).remove();
                            }
                        }
                    }
                }
                
            }
            function validateEmdFees(e){
                $(".err"+$(e).attr('id')).remove();
                var compValEmpty=($(e).val()!='');
                if(parseInt($('#optEMDReq option:selected').val())===1){
                if(!compValEmpty){
                    $(e).parent().append("<div class='err"+$(e).attr('id')+" validationMsg clearfix'>Please Enter "+$(e).attr('title')+"</div>");
                }
            }
            else
            {
                    if($(e).attr('id')==='txtEMDFees'){
                        var beforeDot=$(e).val().split(".",1);
                        if(compValEmpty && beforeDot[0].length > 10){
                            $(e).parent().append("<div class='err"+$(e).attr('id')+" validationMsg clearfix'> Allow Max.10 positive numbers </div>");
                        }
                        else
                        {
                            validateDecimalUpto(e);
                        }
                    }
                    else if($(e).attr('id')==='txtEMDFeesPayableAt'){
                        if(compValEmpty && $(e).val() > 1000){
                            $(e).parent().append("<div class='err"+$(e).attr('id')+" validationMsg clearfix'> Allows Max. 1000 alphabets, numbers and special characters </div>");
                        }
                        else
                        {
                            $(".err"+$(e).attr('id')).remove();
                        }
                    }
            }
            }
          
            
            $(function(){
               // alert('on load'+parentDeptId);
               $('#organization').html('${organization}');
			     $('#parentDeptName').html('${parentDeptName}');
			     $('#subDeptName').html('${subDeptName}');
			     $('#officerName').html('${officerName}');
                var wysihtml5Editor = "";
                wysihtml5Editor = $("#rtfauctiondetails").wysihtml5();
               changeIsAddReservePrice();
                if(parseInt($('#optDocFees option:selected').val())===1)
                {
                   $('#DocumentFees').show();
                }
                else
                {
                     
                    $('#DocumentFees').hide();
                }
                if(parseInt($('#optEMDReq option:selected').val())===1)
                {
                    $('#EMDfees').show();
                }
                else
                {
                    $('#EMDfees').hide();
                }
                if(parseInt($('#optPartFees option:selected').val())===1)
                {
                    $('#ParticipatonFees').show();
                }
                else
                {
                    $('#ParticipatonFees').hide();
                }
               if($('#rdoBiddingTypeDomestic').prop('checked')===true){
                   $('#divBidCurrency').hide();
                   
               }
               else if($('#rdoBiddingTypeGlobal').prop('checked')===true){
                   
                   $('#divBidCurrency').show();
               }
                if(operation==='edit')
                {
                    
                    if(parseInt(biddingType)===2){
                  
                        $('#divBidCurrency').show();
                    }
                    else
                    {
                             $('#divBidCurrency').hide();
                        
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
                        if($('#rdoAuctionMethodF').prop('checked')===true)
                        {
                            $('#methodLabel').html('Increment Value:');
                        }
                        if($('#rdoAuctionMethodR').prop('checked')===true)
                        {
                            $('#methodLabel').html('Decrement Value:');
                        }
                       
                        if($('#rdoAddReservePriceY').prop('checked')===true)
                        {
                           $('#divReservePrice').show();
                        }
                        
                        if($('#rdoAddReservePriceN').prop('checked')===true)
                        {
                          
                            $('#divReservePrice').hide();
                        }
                        $('[id^="chk_"]').each(function(){
                            if($(this).prop('checked')===true){
                                 if(parseInt($(this).val())===parseInt($('#optBaseCurrency option:selected').val())){
                              
                                    var BaseId=$(this).val();
                                    $('#dvCurrencyConversion_'+BaseId).hide();
                                }
                                else
                                {
                                    
                                    var BaseId=$(this).val();
                                    $('#dvCurrencyConversion_'+BaseId).show();
                                }
                            }
                            else
                            {
                                
                                 var BaseId=$(this).val();
                                $('#dvCurrencyConversion_'+BaseId).hide();
                            }
                           
                
                    });
                    
                 
            }//edit if
            else
            {
            $('[id^="dvCurrencyConversion_"]').each(function(){
                    $(this).hide();
               });
            if($('#rdoAuctionMethodF').prop('checked')===true)
                        {
                            $('#methodLabel').html('Increment Value:');
                        }
                        if($('#rdoAuctionMethodR').prop('checked')===true)
                        {
                            $('#methodLabel').html('Decrement Value:');
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
			       format:'d-M-Y H:i',
			       step:15
			    });
			});
             //   alert(parentDeptJson);
            
//     $('#parentDeptName').html(parentDeptName);
//    
//     if(parentDeptJson!=''){
//        
//     		var obj = jQuery.parseJSON(parentDeptJson);
//	     	$('#selDepartment').html('');
//	     	$.each(obj, function (key, value) {
//	    	$('#selDepartment').append($('<option>',
//	    		 {
//	    		    value: value.value,
//	    		    text : value.label
//	    		}));
//	    	 });
//	     	
//	     	if(parentDeptId==0){
//	    		$('select[id="selDepartment"] option:selected').attr("selected",null);
//	   	     	$('select[id="selDepartment"] option[value="-1"]').attr("selected","selected");
//	    	 }else{
//	    		$('select[id="selDepartment"] option:selected').attr("selected",null);
//	   	     	$('select[id="selDepartment"] option[value="'+parentDeptId+'"]').attr("selected","selected");
//	     	}
//	     	getSubDepartments();
//	     	blockUI();
//   	     	setTimeout(function() {
//   	     	getOfficerList();
//   	    	}, 3000);
//   	     unBlockUI()
//  		}else{
//  			if(subDeptJson != undefined && subDeptJson != ''){
//  			var subDeptObj = jQuery.parseJSON(subDeptJson);
//	   	     	$('#subDept').html('');
//		     	$.each(subDeptObj, function (key, value) {
//		    	$('#subDept').append($('<option>',
//		    		 {
//		    		    value: value.value,
//		    		    text : value.label
//		    		}));
//		    	 });
//		     	if(subDeptId==0){
//		    		$('select[id="subDept"] option:selected').attr("selected",null);
//		   	     	$('select[id="subDept"] option[value="-1"]').attr("selected","selected");
//		    	 }else{
//		    		$('select[id="subDept"] option:selected').attr("selected",null);
//		   	     	$('select[id="subDept"] option[value="'+subDeptId+'"]').attr("selected","selected");
//		     	}
//                       
//                         $('#subDeptName').html($('select[id="subDept"] option:selected').text());
//		     	getOfficerList();
//  			}
//  		  }
              //   alert('hello');
             //  alert(parentDeptId);
              
               
               
                   
            });
            function showCurrencyConversionRate(e){
            if($(e).prop('checked')===true){
                if(parseInt($(e).val())!==parseInt($('#optBaseCurrency option:selected').val())){
                     $('#dvCurrencyConversion_'+$(e).val()).show();
                }
                else{
                    $('#dvCurrencyConversion_'+$(e).val()).hide();
                }
                
                
            }
        else{
                $('#dvCurrencyConversion_'+$(e).val()).hide();
            }
            
            }
            
           $('#optBaseCurrency').change(function(){
                $('[id^="chk_"]').each(function(){
                    if(parseInt($(this).val())===parseInt($('#optBaseCurrency option:selected').val())){
                        $(this).prop('checked',true);
                        var BaseId=$(this).val();
                        $('#dvCurrencyConversion_'+BaseId).hide();
                    }
                    else{
                        if($(this).prop('checked')===true)
                        {
                            var BaseId=$(this).val();
                            $('#dvCurrencyConversion_'+BaseId).show();
                        }
                        else
                        {
                            var BaseId=$(this).val();
                            $('#dvCurrencyConversion_'+BaseId).hide();
                        }
                    }
                });
            }); 
           
            function getBidCurrency(e){
            if(parseInt($(e).val())===1){
                
                $('#divBidCurrency').hide();
            }   
            else
            {
                $('#divBidCurrency').show();
            }
            
            
            }
            function changeIsAddReservePrice()
            {
                if($('#rdoAddReservePriceY').prop('checked')===true)
                        {
                           $('#divReservePrice').show();
                        }
                        if($('#rdoAddReservePriceN').prop('checked')===true)
                        {
                           $('#divReservePrice').hide();
                        }
            }
            
            function changeAuctionMethod()
            {
                 if($('#rdoAuctionMethodF').prop('checked')===true)
                        {
                            $('#methodLabel').html('Increment Value:');
                        }
                        if($('#rdoAuctionMethodR').prop('checked')===true)
                        {
                            $('#methodLabel').html('Decrement Value:');
                        }
            }
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
             
                if(parseInt(eId)===1)
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
                if(parseInt(eId)===1)
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
                if(parseInt(eId)===1)
                {
                    $('#EMDfees').show();
                }
                else
                {
                    $('#EMDfees').hide();
                }
            }
            function validateDecimalUpto(e){
               $(".err"+$(e).attr('id')).remove();
                 var NUMWITHDECIMAL = "^\\d.*?\\.\\d{decimalUpto}$";//numwithdecimal  :decimal with specified digits
                 NUMWITHDECIMAL = NUMWITHDECIMAL.replace('decimalUpto',$('#optDecimalVal option:selected').val());
                    var decimalRegex = new RegExp(NUMWITHDECIMAL);
                    if($(e).val() != undefined && $(e).val().indexOf(".") == -1 && $(e).val()!==''){
                    	$(e).val() = $(e).val()+".00";
                    }
                    if (!decimalRegex.test($(e).val())){
                        $(e).parent().append("<div class='err"+$(e).attr('id')+" validationMsg clearfix'>Allows <"+$('#optDecimalVal option:selected').val()+"> digits after decimal</div>");
                           
                    }
                    else
                    {
                       $(".err"+$(e).attr('id')).remove();
                        
                    }
                
            }
            var dateFieldObject = new Object();
function doChangeForDateValidation(comp)
{
    
	var havingVal='';
	var size = 0;
	for(val in dateFieldObject)
		{
			size++;
		}
	
	$(".dateBox").each(function(){
            
		var attr = $(this).attr("dtrequired");
                
		if(attr != null && attr != undefined && attr != '')
		{
			if(dateFieldObject[$(this).attr("id")] == undefined)
			{
                            
					dateFieldObject[$(this).attr("id")] = $(this).attr("datevalidate");	
			}
			$(this).attr("onblur","doChangeForDateValidation(this)"); // Change data validation function.
			if($(this).val() != '' && havingVal == '')
				{
					havingVal = true;
				}
		}
	  });
	
	if(havingVal != true){	
      
        // If valud not found for any date, remove all date validation.
		for(obj in dateFieldObject){
                  
			var compId = obj;
			$(".err"+compId).remove();	
//			$("#"+compId).attr("dtrequired","false");
//			$("#"+compId).removeAttr("datevalidate");
		}
	}
	if((comp != undefined && $(comp).val() != '') || havingVal != true){		// If function call using onblur or date box having value then do validation.
		for(obj in dateFieldObject)
		{
			if(obj == 'txtPreBidStartDate')
			{
				<c:if test="${tblTender.isPreBidMeeting eq 1}">
					$("#"+obj).attr("datevalidate",dateFieldObject[obj]);		
					$("#"+obj).attr("dtrequired","true");
				</c:if>
			}else if(obj == 'txtPreBidEndDate')
			{
				<c:if test="${tblTender.isPreBidMeeting eq 1}">
					$("#"+obj).attr("datevalidate",dateFieldObject[obj]);
					$("#"+obj).attr("dtrequired","true");
				</c:if>
			} else if(obj == 'txtQuestionAnswerStartDate')
			{
				<c:if test="${tblTender.isQuestionAnswer eq 1}">
					$("#"+obj).attr("datevalidate",dateFieldObject[obj]);
					$("#"+obj).attr("dtrequired",true);
				</c:if>
			} else if(obj == 'txtQuestionAnswerEndDate')
			{
				<c:if test="${tblTender.isQuestionAnswer eq 1}">
					$("#"+obj).attr("datevalidate",dateFieldObject[obj]);
					$("#"+obj).attr("dtrequired","true");
				</c:if>
			} else
			{
				$("#"+obj).attr("datevalidate",dateFieldObject[obj]);
				$("#"+obj).attr("dtrequired","true");
			}
		}
		if(comp != undefined && comp != ''){
              //  alert('hello');
			validateEmptyDt($(comp));
		}
	} else{	
     //   alert('in else');// Else remove error message
		for(obj in dateFieldObject){
			var compId = obj;
			$(".err"+compId).remove();	
		}
	}
}
function validation(){
	var vbool = valOnSubmit();
	return disableBtn(vbool);
}
            function validateAuction()
            {
                
                var count=0;
                var validationMsg="";
                if($('#rdoAuctionMethodR').prop('checked')===true)
                {
                    //alert('in if');
                    if($('#rdoAddReservePriceY').prop('checked')===true)
                    {
                    if(parseInt($('#txtAuctionRevPrice').val()) > parseInt($('#txtStartPrice').val()))
                    {
                        //alert('Reserve price should be less than the start price');
                        validationMsg=validationMsg+"Reserve price should be less than the start price";
                        count++;
                    }
                }
                }
                var startPrice=$('#txtStartPrice').val();
                var reversePrice=$('#txtAuctionRevPrice').val();
                if($('#rdoAuctionMethodF').prop('checked')===true)
                {
                   // alert($('#txtStartPrice').val()+"-"+$('#txtAuctionRevPrice').val());
                   if($('#rdoAddReservePriceY').prop('checked')===true)
                    {
                   if(parseInt($('#txtAuctionRevPrice').val()) < parseInt($('#txtStartPrice').val()))
                    {
                        //alert('start price should be less than the Reverse price');
                        validationMsg=validationMsg+"start price should be less than the Reserve price";
                        count++;
                    }
                }
                }
                if($('#rdoAutoExtensionModeNo').prop('checked')===true){
                    if(parseInt($('#txtExtendedTimeBy').val())<parseInt($('#txtExtendedTime').val()))
                    {
                        
                        validationMsg=validationMsg+"Extend by cannot be less than Extend when bid received in "+$('#txtExtendedTime').val()+" mins";
                        count++;
                    }
                }
                    
               
                
                 
                if(count>0)
                {
                    alert(validationMsg);
                    return false;
                }
                validationMsg="";
                return true;
            }
</script>
<script src="${pageContext.servletContext.contextPath}/resources/js/jquery-ui.min.js"></script>
<%@include file="./../includes/footer.jsp"%>
