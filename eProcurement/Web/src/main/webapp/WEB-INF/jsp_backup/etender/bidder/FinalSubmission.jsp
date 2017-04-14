<!DOCTYPE html>
<html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../../includes/header.jsp"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script src="${pageContext.servletContext.contextPath}/resources/js/jquery-ui.min.js"></script>

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
		function confirmFinalsubmission(){
			if(confirm("After final submission you will not be allowed to alter anything within this tender.Are you sure want to do final submission ?")){
				$( "#finalFormId" ).submit();
			}
		}
</script>
<spring:message code="msg_iagreed" var="iagreedMsg"/>         	
<spring:message code="lbl_back_dashboard" var='backDashboard'/>
<spring:message code="lbl_declaration" var='lblDeclaration'/>
<spring:message code="btn_finalsubmission" var="varFinalSubmission"/>
<spring:message code="confirm_msg_final_sub" var="confirmFinalSub" />
<spring:message code='lbl_cmpname' var="varCompanyName"/>
<spring:message code='lbl_email' var="varEmail"/>
<spring:message code='fields_address' var="varAddress"/>
</head>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="../../includes/leftaccordion.jsp"%>

<div class="content-wrapper">

	<section class="content-header">
		<a href="${pageContext.servletContext.contextPath}/etender/bidder/biddingTenderDashboard/${tenderId}" class="btn btn-submit" style="margin-top:0px;"><< ${backDashboard}</a>
	</section>

	<section class="content" id="viewFinalSubmissionId">
	
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
					<h3 class="box-title">Final Submission</h3>
				</div>
				<div class="box-body">
					<div class="row">
						<div class="col-lg-12 col-md-12 col-xs-12">
<%-- 						<%@include file="../buyer/TenderSummary.jsp"%> --%>
						</div>
						<div class="col-lg-12 col-md-12 col-xs-12">
					
                                <c:if test="${allowFinalSubmission ne 'Success' and allowFinalSubmission eq 'msg_tender_fs_finalsubmission_done'}">
                                    <div class="alert alert-success"><spring:message code="${allowFinalSubmission}" arguments="${msgArgumentOne};${msgArgumentTwo}" argumentSeparator=";"/></div>
								<div >
                                    <div >
                                    <span class="pull-left m-top2"></span>
                                        <h3>${varFinalsubmissionReceipt}</h3>
                                    </div>
                                    <table class="table table-striped table-responsive">                                                  
	                                      <tr>
	                                       	<th  style="width:150px">${varCompanyName}</th>
	                                        <td> ${tblBidder.tblCompany.companyname}
		                                        <c:if test="${leadCompanyName ne null and tblBidder.tblCompany.companyname ne leadCompanyName}">                                                                                                          
		                                        <c:set value="   ( In consortium with  ${leadCompanyName} )" var="leadname" ></c:set>
		                                        </c:if>                                                        
	                                        	${isConsortiumAllowed eq 1 ?  leadname : " "}
	                                        </td>
	                                      </tr>
	                                       	<tr>
	                                       		<th>${varEmail} </th>
	                                       		<td>${tblBidder.emailId}</td>
											</tr>
	                                        <tr>
	                                       <th> ${varAddress}  </th>
	                                        <td class="word-break"> ${tblBidder.address} ,  ${tblBidder.city} ,${tblBidder.phoneno} </td>
	                                      </tr>
                                      </table> 
								</div>  
                         	</c:if>
                        <c:choose>
                            <c:when test="${not empty lstTenderBidCount}">
                            <table class="table table-striped table-responsive">
                        	<tr class="border-top-none"><td>
                                <c:set var="count" value="0"/>
                                <c:forEach items="${tenderEnvelopeLst}" var="envData">
                                	<div>
                                    <div>
                                    <span class="pull-left m-top2"></span>
                                        <h3>${envData[1]}</h3>
                                    </div>
                                    <table class="table">
                                                <c:choose>
                                                    <c:when test="${not empty tenderFormLst}">
                                                        <tr class="gradi">
                                                            <th width="45%" class="a-left"><spring:message code="fields_formName"/></th>
                                                            <th width="15%" class="a-left"><spring:message code="col_submitted"/></th>
                                                            <c:if test="${isDocsMandatory}">
                                                                <c:if test="${not empty PendingDocsCount}">                                                                             
                                                                       <c:forEach items="${tenderFormLst}" var="tndrFormData" varStatus="cnt">   
                                                                              <c:if test="${PendingDocsCount.containsKey(tndrFormData[0])}">
                                                                                    <c:if test="${PendingDocsCount.get(tndrFormData[0]) ne 0}">                                                                                                                                                                                  
                                                                                         <th class="a-left noprint" width="15%"><spring:message code="col_pendingmanddoc"/></th>
                                                                                     </c:if>
                                                                              </c:if>
                                                                        </c:forEach> 
                                                                </c:if>       
                                                            </c:if>
                                                            <th width="25%" class="a-left"><spring:message code="col_refDoc"/></th>
                                                        </tr>
                                                        <c:forEach items="${tenderFormLst}" var="tndrFormData" varStatus="cnt">         
                                                            <c:if test="${envData[0] eq tndrFormData[2]}">
                                                                <tr>
                                                                    <c:set var="count" value="${count+1}"/>
                                                                    <td>
                                                                        ${tndrFormData[1]}
                                                                        <c:if test="${tndrFormData[5] eq 1}"><span class="red">*</span></c:if>
                                                                    </td>
                                                                    <td class="a-left">
                                                                        <c:set var="indx" value="0"/>
                                                                        <c:forEach items="${lstTenderBidCount}" var="BidCount" varStatus="counter">
                                                                            <c:choose>
                                                                                <c:when test="${BidCount[1] eq tndrFormData[0]}">
                                                                                    <spring:message code="label_yes"/>
                                                                                    <c:if test="${tndrFormData[9] ne 0}">
                                                                                    	(${BidCount[0]})
                                                                                    </c:if>
                                                                                    <c:set var="indx" value="${count+1}"/>
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <c:if test="${fn:length(lstTenderBidCount) eq counter.count and indx eq 0}">
                                                                                        <spring:message code="label_no"/>
                                                                                    </c:if>
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                        </c:forEach>
                                                                    </td>
                                                                    <c:if test="${isDocsMandatory}">
                                                                                <c:if test="${not empty PendingDocsCount}">      
                                                                                        <c:if test="${PendingDocsCount.containsKey(tndrFormData[0])}">
                                                                                           <c:if test="${PendingDocsCount.get(tndrFormData[0]) ne 0}">                                                                                      
                                                                                             <td class="a-left noprint">  ${PendingDocsCount.get(tndrFormData[0])}</td>
                                                                                           </c:if>
                                                                                        </c:if>                                                                                     
                                                                                </c:if>
                                                                    </c:if>
                                                                    <c:choose>
                                                                        <c:when test="${isDocUploaded}">
                                                                            <td class="a-left">
                                                                                <c:choose>
                                                                                    <c:when test="${tndrFormData[11] eq 0}">
                                                                                        <c:set var="dataIndex" value="0"/>
                                                                                        <c:forEach items="${lstTenderBid}" var="BidData" varStatus="Bidcounter">
                                                                                            <c:choose>
                                                                                                <c:when test="${tndrFormData[0] eq BidData[2]}">
                                                                                                    <c:forEach items="${lstTenderBidderDocs}" var="docsData" varStatus="docsStatus">
                                                                                                        <c:choose>
                                                                                                            <c:when test="${docsData[0] eq BidData[0] and BidData[2] eq tndrFormData[0]}">
                                                                                                                <c:choose>
                                                                                                                    <c:when test="${isDocAvail.containsKey(docsData[3]) and isDocAvail.get(docsData[3]) eq 'y'}">
                                                                                                                    	<spring:url value="/ajax/downloadbriefcasefile/${docsData[3]}/${docsData[0]}" var="urlDoc"/>
					                                            														<a href="${urlDoc}" cssclass="btn btn-submit">${docsData[5]}</a>
                                                                                                                    </c:when>
                                                                                                                    <c:otherwise>
                                                                                                                        ${docsData[5]}&nbsp;<spring:message code="msg_tender_err_docs_not_found"/>
                                                                                                                    </c:otherwise>
                                                                                                                </c:choose><br/><br/>
                                                                                                                <c:set var="dataIndex" value="${dataIndex+1}"/>
                                                                                                            </c:when>
                                                                                                            <c:otherwise>
                                                                                                                <c:if test="${fn:length(lstTenderBidderDocs) eq docsStatus.count and dataIndex eq 0}">
                                                                                                                    <div class="a-left">-</div>
                                                                                                                    <c:set var="dataIndex" value="-1"/>
                                                                                                                </c:if>
                                                                                                            </c:otherwise>
                                                                                                        </c:choose>
                                                                                                    </c:forEach>
                                                                                                </c:when>
                                                                                                <c:otherwise>
                                                                                                    <c:if test="${fn:length(lstTenderBidDtls) eq Bidcounter.count and dataIndex eq 0}">
                                                                                                        <div class="a-left">-</div>
                                                                                                    </c:if>
                                                                                                </c:otherwise>
                                                                                            </c:choose>

                                                                                        </c:forEach>
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <div>
                                                                                            <table class="table">
                                                                                                <c:set var="docCnt" value="1"/>
                                                                                                <c:set var="oldDocId" value="0" />
                                                                                                <c:set var="dataIndex" value="0"/>
                                                                                                <c:forEach items="${lstTenderBidderDocs}" var="docsData" varStatus="docsStatus">
                                                                                                                <c:if test="${oldDocId ne docsData[6]}">
                                                                                                                    <c:forEach items="${lstTenderBid}" var="BidData" varStatus="Bidcounter">
                                                                                                                        <c:choose>
                                                                                                                            <c:when test="${tndrFormData[0] eq BidData[2]}">
                                                                                                                                <c:choose>
                                                                                                                                    <c:when test="${docsData[0] eq BidData[0] and BidData[2] eq tndrFormData[0]}">
                                                                                                                                        <c:if test="${docCnt eq 1}">
                                                                                                                                            <tr class="gradi">
                                                                                                                                                <th>${mandatoryDoc}</th>
                                                                                                                                                <th>${mappedDoc}</th>
                                                                                                                                            </tr>
                                                                                                                                        </c:if>
                                                                                                                                        <tr>
                                                                                                                                            <td>${not empty docsData[7] ? docsData[7] : '-'}</td>
                                                                                                                                            <td>
                                                                                                                                                <c:set value="${fn:split(MandatoryFormDoc1[docsData[6]], ',')}" var="gDocRemark"/>
                                                                                                                                                <c:set value="${fn:length(gDocRemark)}" var="gDocRemarkLength"/>
                                                                                                                                                <c:forEach items="${gDocRemark}" var="docDetails" varStatus="gDocsrno">
                                                                                                                                                    <c:set value="${fn:split(docDetails,'#')[0]}" var="varRemarks"/>
                                                                                                                                                    <c:set value="${fn:split(docDetails,'#')[1]}" var="varId"/>
                                                                                                                                                    <c:set value="${fn:split(docDetails,'#')[2]}" var="docBidId"/>
                                                                                                                                                    <c:set value="${fn:split(docDetails,'#')[3]}" var="isDocAvailable"/>
                                                                                                                                                    <c:choose>
                                                                                                                                                        <c:when test="${isDocAvailable eq 'y'}">
                                                                                                                                                        	<spring:url value="/ajax/downloadbriefcasefile/${varId}/${docBidId}" var="urlRemark"/>
					                                            																							<a href="${urlRemark}" cssclass="btn btn-submit">${varRemarks}</a>
                                                                                                                                                            ${gDocsrno.count eq  gDocRemarkLength ? ' ' : ' <br /><br />'}
                                                                                                                                                        </c:when>
                                                                                                                                                        <c:otherwise>
                                                                                                                                                            ${varRemarks}&nbsp;<spring:message code="msg_tender_err_docs_not_found"/></br></br>
                                                                                                                                                        </c:otherwise>
                                                                                                                                                    </c:choose>
                                                                                                                                                </c:forEach>
                                                                                                                                            </td>
                                                                                                                                        </tr>
                                                                                                                                        <c:set var="dataIndex" value="${dataIndex+1}"/>
                                                                                                                                        <c:set var="docCnt" value="${docCnt+1}"/>    
                                                                                                                                    </c:when>
                                                                                                                                </c:choose>
                                                                                                                            </c:when>
                                                                                                                        </c:choose>
                                                                                                                    </c:forEach>
                                                                                                                </c:if>
                                                                                                                <c:set var="oldDocId" value="${docsData[6]}" />
                                                                                                </c:forEach>
                                                                                            </table>
                                                                                        </div>
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                            </td>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <td class="a-left">-</td>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </tr>
                                                            </c:if>
                                                        </c:forEach>
                                                        <c:if test="${count eq 0}">
                                                            <tr>
                                                                <td colspan="3">
                                                                    <spring:message code="msg_emptylist_tenderform"/>
                                                                </td>
                                                                <c:if test="${isDocsMandatory}">
                                                                    <td></td>
                                                                </c:if>
                                                            </tr>
                                                        </c:if>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <tr>
                                                            <td>
                                                                <spring:message code="msg_emptylist_tenderform"/>
                                                            </td>
                                                            <c:if test="${isDocsMandatory}">
                                                                    <td></td>
                                                            </c:if>
                                                        </tr>
                                                    </c:otherwise>
                                                </c:choose>
                                            </table>
                                            </div>
                                    <c:set var="count" value="0"/>
                                </c:forEach>
                                <c:if test="${not empty rebateList and !isConsortium}">
                                    <c:choose>
                                        <c:when test="${isRebateForm eq 1}">
                                            <div><h2><spring:message code="lbl_rebate_form"/></h2></div>
                                                    <table class="table ">
                                                        <tr class="gradi">
                                                            <th width="35%" class="a-left"><spring:message code="fields_formName"/></th>
                                                            <th class="a-left" width="35%"><spring:message code="col_action"/></th>
                                                            <th class="a-left" width="30%"></th>
                                                        </tr>
                                                        <c:forEach items="${rebateList}" var="rebateList">
                                                            <tr>
                                                                <td width="50%">${rebateList[1]}</td>
                                                                <td class="a-left">
                                                                    <c:choose>
                                                                        <c:when test="${showRebateAction}">
                                                                            <c:if test="${rebateList[2] eq '1' and rebateList[3] ne '0'}">
                                                                            	<spring:url value="/etender/bidder/crteditrebate/${tenderId}/${rebateList[0]}/${companyId}/3/1" var="urlView"/>
					                                            				<a href="${urlView}" >${var_view}</a>
                                                                            </c:if>
                                                                            <c:if test="${rebateList[2] eq '0'}">
                                                                            	<spring:url value="/etender/bidder/crteditrebate/${tenderId}/${rebateList[0]}/${companyId}/4/1" var="urlView"/>
					                                            				<a href="${urlView}">${var_view}</a>
                                                                            </c:if>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <spring:message code="msg_tender_err_rebateconfig"/>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </td>
                                                                <td></td>
                                                            </tr>
                                                        </c:forEach>
                                                    </table>
                                        </c:when>
                                        <c:otherwise>
                                        	<div class="noprint">
                                            <div><h2><spring:message code="lbl_price_bid_form"/></h2></div>
                                                <table class="table">
                                                    <tr class="gradi">
                                                        <th width="35%"><spring:message code="lbl_form_name"/></th>
                                                        <th class="a-left" width="35%"><spring:message code="col_action"/></th>
                                                        <th class="a-left" width="30%"></th>
                                                    </tr>
                                                    <c:forEach items="${rebateList}" var="rebateList">
                                                        <tr>
                                                            <td>${rebateList[1]}</td>
                                                            <td class="a-left">
                                                                <c:choose>
                                                                    <c:when test="${showRebateAction}">
                                                                    <spring:url value="/etender/bidder/crteditrebate/${tenderId}/${rebateList[0]}/${companyId}/4/1" var="urlView"/>
					                                            				<a href="${urlView}">${var_view}</a>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <spring:message code="msg_tender_err_price_summary_config"/>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                            </td>
                                                            <td></td>
                                                        </tr>
                                                    </c:forEach>
                                                </table>
                                               </div>
                                        </c:otherwise>
                                    </c:choose> 
                                </c:if> 
                                <c:choose>
                                    <c:when test="${allowFinalSubmission eq 'Success'}">
                                        <c:choose>
                                            <c:when test="${isDocUploaded}">
			                                    <c:set value="true" var="isFinalSubmissionDocChk"/>                                    
			                                    <c:if test="${isDocAvail.containsValue('n')}">
			                                    	<c:set value="false" var="isFinalSubmissionDocChk"/>	
			                                    </c:if>
                                        		<c:if test="${isFinalSubmissionDocChk}">
                                                <div>
                                                        <c:choose>
                                                            <c:when test="${not empty bidIds}">
                                                            	<spring:url value="/etender/bidder/verifybidform/${tenderId}/0/0/0/${bidIds}_0" var="urlFinalSubmission"/>
					                                            <a href="${urlFinalSubmission}" cssclass="btn btn-submit">${varFinalSubmission}</a>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <form:form id="finalFormId" action="${pageContext.servletContext.contextPath}/etender/bidder/finalsubmission" method="POST">
                                                                	<input type="hidden" value="${tenderId}" name="hdTenderId"/>
                                                                	<input type="hidden" value="${eventType}" name="hdEventType"/>
                                                                	<input type="hidden" value="${tblBidder.bidderId}" name="hdBidderId"/>
                                                                	<input type="hidden" value="${tblBidder.tblCompany.companyid}" name="hdComapnyId"/>
                                                                   <button type="button" class="btn btn-submit" id='btnFinalSubmission' onclick='confirmFinalsubmission()'>${varFinalSubmission}</button>
                                                                </form:form>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </c:if>
                                            </c:when>
                                            <c:otherwise>
                                                <div>
                                                    <c:choose>
                                                        <c:when test="${not empty bidIds}">
                                                        	<spring:url value="/etender/bidder/verifybidform/${tenderId}/0/0/0/${bidIds}_0" var="urlFinalSubmission"/>
					                                            				<a href="${urlFinalSubmission}" cssclass="btn btn-submit">${varFinalSubmission}</a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <form:form id="finalFormId" action="${pageContext.servletContext.contextPath}/etender/bidder/finalsubmission" method="POST">
                                                                <input type="hidden" value="${tenderId}" name="hdTenderId"/>
                                                                	<input type="hidden" value="${eventType}" name="hdEventType"/>
                                                                	<input type="hidden" value="${tblBidder.bidderId}" name="hdBidderId"/>
                                                                	<input type="hidden" value="${tblBidder.tblCompany.companyid}" name="hdComapnyId"/>
                                                                <button type="button" class="btn btn-submit" id='btnFinalSubmission' onclick='confirmFinalsubmission()'>${varFinalSubmission}</button>
                                                            </form:form>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <c:otherwise>
                                                <c:choose>
                                                    <c:when test="${allowFinalSubmission eq 'msg_tender_fs_finalsubmission_done'}">
                                                        <!--<div class="successMsg t_space m-top1 grid_26">< spring:message code="${allowFinalSubmission}" arguments="${msgArgumentOne};${msgArgumentTwo}" argumentSeparator=";"/></div>-->
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="row"><span class="red"><spring:message code="${allowFinalSubmission}"/></span></div>
                                                    </c:otherwise>
                                                </c:choose>
                                        <c:if test="${allowFinalSubmission eq 'msg_tender_fs_finalsubmission_done' and isBidWithdrawal eq 1 and !isConsortium}">
                                            <table class="table">
                                                <tr class="border-top">
                                                <td class="grid_5 noprint"><spring:message code="lbl_tender_bidwithdrawal"/></td>
                                                <td class="noprint">
                                                    <c:if test="${!submissionEndDtLapse}">
                                                        <spring:message code="lbl_tender_bidwithdrawal" var="var_withdraw"/>
                                                        <spring:url value="/etender/bidder/showbidwithdraw/${tenderId}" var="urlWithdraw"/>
					                                    <a href="${urlWithdraw}">${var_withdraw}</a>
                                                    </c:if>
                                                </td>
                                            </tr>
                                            </table>
                                        </c:if>

                                    </c:otherwise>
                                </c:choose>
                                <c:if test="${not empty bidWithdrawalDtls}">
                                    
                                            <table class="table ">
                                                <tr>
                                                    <th><spring:message code="col_srno"/></th>
                                                    <th><spring:message code="col_tender_finalsubmission_dt"/></th>
                                                    <th><spring:message code="col_tender_finalsubmission_ip"/></th>
                                                    <th><spring:message code="col_tender_bidwithdrawal_dt"/></th>
                                                    <th><spring:message code="col_tender_bidwithdrawal_ip"/></th>
                                                    <th><spring:message code="lbl_remark"/></th>
                                                </tr>
                                                <c:forEach items="${bidWithdrawalDtls}" var="data" varStatus="BWStatus">
                                                    <tr>
                                                        <td class="a-center">${BWStatus.count}</td>
                                                        <td class="a-left"><fmt:formatDate pattern="${clientDateFormate}" value="${data[1]}" /></td>
                                                        <td class="a-left">${data[2]}</td>
                                                        <td class="a-left"><fmt:formatDate pattern="${clientDateFormate}" value="${data[4]}" /></td>
                                                        <td class="a-left">${data[3]}</td>
                                                        <td class="a-left word-break">${data[0]}</td>
                                                    </tr>
                                                </c:forEach>
                                            </table>
                                </c:if>
                                 </td></tr></table>
                            </c:when>
                            <c:otherwise>
                                    <div class="errorMsg t_space"><spring:message code="${allowFinalSubmission}"/></div>
                            </c:otherwise>
                        </c:choose>
						<div>
							<input type="button" class="btn noExport pdf-bt" onclick="exportContent('viewFinalSubmissionId','FinalSubmission${tenderId}',0)" value="PDF">
							<input type="button" class="btn noExport print-bt" onclick="exportContent('viewFinalSubmissionId','FinalSubmission${tenderId}',5)" value="Print">
						</div>                       
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
