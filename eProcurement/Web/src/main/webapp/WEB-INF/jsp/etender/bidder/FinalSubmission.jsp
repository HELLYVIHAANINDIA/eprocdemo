<%@include file="../../includes/head.jsp"%>
<%@include file="../../includes/masterheader.jsp"%>


<spring:message code="msg_iagreed" var="iagreedMsg"/>         	
<spring:message code="lbl_back_dashboard" var='backDashboard'/>
<spring:message code="lbl_declaration" var='lblDeclaration'/>
<spring:message code="btn_finalsubmission" var="varFinalSubmission"/>
<spring:message code="confirm_msg_final_sub" var="confirmFinalSub" />
<spring:message code='lbl_cmpname' var="varCompanyName"/>
<spring:message code='lbl_email' var="varEmail"/>
<spring:message code='fields_address' var="varAddress"/>

<div class="content-wrapper">

	<section class="content-header">
						<a href="${pageContext.servletContext.contextPath}/etender/bidder/biddingTenderDashboard/${tenderId}" class="g g-back"><< 
                                            <c:if test="${isAuction eq 0}">
                                               ${backDashboard} 
                                            </c:if>
                                            <c:if test="${isAuction eq 1}">
                                                Go To Auction DashBoard
                                            </c:if>
                                            </a>
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
				<div>
					<%@include file="../buyer/TenderSummary.jsp"%>
				</div>
				<div class="box-header with-border">
					<h3 class="box-title"><label class="black">Final Submission</label></h3>
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
                                    		<c:if test="${tblFinalsubmission ne null}">
	                                        	<tr>
			                                       	<th  style="width:150px">Transaction ID :</th>
			                                        <td> ${tblFinalsubmission.transactionId}</td>
		                                        </tr>                                        
	                                      </c:if>          
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
<%--                                                                                     	(${BidCount[0]}) --%>
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
                                                                    <c:set value="" var="docName"/>
                                                                    <td class="a-left">
	                                                                    <c:forEach items="${lstTenderBidderDocs}" var="TblBidderdocument" varStatus="counterDocs">
	                                                                    	<c:choose>
	                                                                    		<c:when test="${TblBidderdocument.bidderId eq tblBidder.bidderId and tndrFormData[0] eq TblBidderdocument.childId}">
	                                                                    			<c:set value="<a href='#'>${TblBidderdocument.fileName}</a>" var="docNameURL"/>
	                                                                    			<c:set value="${docName}${docNameURL}," var="docName"/>
	                                                                    		</c:when>
	                                                                    	</c:choose>
	                                                                    </c:forEach>
	                                                                    <c:set var="docNameLength" value="${fn:length(docName)}" />
	                                                                    <c:set var="docNameNew" value="${fn:substring(docName, 0, docNameLength-1)}" />
	                                                                    ${docNameNew}
                                                                    </td>
                                                                </tr>
                                                            </c:if>
                                                        </c:forEach>
                                                        <c:if test="${count eq 0}">
                                                            <tr>
                                                                <td colspan="3">
                                                                    <spring:message code="msg_emptylist_tenderform"/>
                                                                </td>
                                                                    <td></td>
                                                            </tr>
                                                        </c:if>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <tr>
                                                            <td>
                                                                <spring:message code="msg_emptylist_tenderform"/>
                                                            </td>
                                                                    <td></td>
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
						</div>
						
						<div class="col-md-12 col-sm-12">
							<input type="button" class="pt-pdf" onclick="exportContent('viewFinalSubmissionId','FinalSubmission${tenderId}',0)" value="PDF">
							<input type="button" class="pt-print" onclick="exportContent('viewFinalSubmissionId','FinalSubmission${tenderId}',5)" value="Print">
						</div> 
						
					</div>
					

						 
				</div>
			</div>
		</div>
		</div>
	</section>
</div>
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
			jConfirm("After final submission you will not be allowed to alter anything within this tender.Are you sure want to do final submission ?","Final Submission",function (result) { 
				if(result){
					$( "#finalFormId" ).submit();
				}
            }); 
		} 
</script>
<script src="${pageContext.servletContext.contextPath}/resources/js/jquery-ui.min.js"></script>
<%@include file="../../includes/footer.jsp"%>