<%@include file="../../includes/head.jsp"%>
<c:if test="${1 ne fromPublishTender && 2 ne fromPublishTender}">
	<%@include file="../../includes/masterheader.jsp"%>
</c:if>



<spring:message code="label_allow" var="allow"/>
<spring:message code="label_dontallow"  var="notallow"/>
<spring:message code="label_online" var="online"/>
<spring:message code="label_offline" var="offline"/>
<div class="content-wrapper">
	<section class="content-header">
			<c:if test="${1 ne fromPublishTender && 2 ne fromPublishTender}">
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
					<div class="alert alert-danger">${errorMsg}</div>
				</c:if>
			</c:if>
			
				<c:choose>
	
			<c:when test="${1 ne fromPublishTender && 2 ne fromPublishTender}">
         		<h1 class="pull-left"><spring:message code="label_tender_view"/></h1>
         		<a href="${pageContext.servletContext.contextPath}/etender/bidder/bidderTenderListing/0" class="pull-right"><< Go To Tender Listing</a>
			</c:when>
	
	<c:otherwise>
         <h1 class="pull-left"><spring:message code="link_tender_view"/></h1>
         <c:choose>
			<c:when test="${2 ne fromPublishTender}">
			 <a href="${pageContext.servletContext.contextPath}/etender/bidder/biddingTenderDashboard/${tenderId}"  class="goBack pull-right"><< <spring:message code="lbl_back_dashboard"/></a>
			</c:when>
			<c:when test="${2 eq fromPublishTender}">
			 <a href="${pageContext.servletContext.contextPath}/login" class="goBack pull-right"><< Go Back To Login</a>
			</c:when>
		</c:choose>
	</c:otherwise>
	
	</c:choose>
			
	</section>

		<section class="content">
		
		<div class="row">
			<div class="col-md-12">
			<div class="box">
				<div class="box-body">
					<div class="row">
						<div class="col-md-12">
	<table width="100%" cellpadding="0" cellspacing="0">
    <tr>
        <td width="29%" class="black"><spring:message code="label_tender_department"/>
        </td>
        <td width="1%" class="bold">:</td>
        <td  width="20%">${departmentName}</td>
        <td width="29%" class="black"><spring:message code="fields_tender_departmentofficial"/></td>
         <td width="1%" class="bold">:</td>
        <td  width="20%">${officerName}</td>    
    </tr>
    <tr>
        <td  width="29%" class="black"><spring:message code="fields_tenderid"/></td>
        <td width="1%" class="bold">:</td>
        <td width="20%">${tblTender.tenderId}</td>
        <td width="29%" class="black"><spring:message code="fields_refenceno"/></td>
        <td width="1%" class="bold">:</td>
        <td  width="20%">${tblTender.tenderNo}</td>
    </tr>
    <tr>
        <td width="29%" class="black"><spring:message code="field_eventtype"/></td>
        <td width="1%" class="bold">:</td>
        <td  colspan="4" class="event-dtl"><p>${eventTypeName}</p></td>
    </tr>
    <tr>
        <td width="29%" class="black"><spring:message code="field_brief"/></td>
        <td width="1%" class="bold">:</td>
        <td  colspan="4" class="event-dtl"><p>${tblTender.tenderBrief}</p></td>
    </tr>
     <tr>
     <td width="29%" class="black border-top-none border-bottom-none v-a-top" ><spring:message code="field_tender_detail"/> </td>
      		<td width="1%" class=""><b>:</b></td>
      		 <td colspan="4" width="70%" class="v-a-top table-border table-border-right border-top-none border-bottom-none" id="tenderDetailDivTd">
        <div class="event-dtl word-break">
        	${tblTender.tenderDetail}
        </div>
       </td>
	</tr>
    <c:if test="${eventTypeId ne null && isCategoryAllow ne null && isCategoryAllow eq 1}" >
    <tr>
        <td width="29%" class="black"><spring:message code="lbl_auction_category"/> </td>
        <td width="1%" class="bold">:</td>
        <td colspan="4">${categoryNameList}</td>
    </tr>
    </c:if>
    <%-- <c:if test="${isCategoryAllow eq 0 or (isCategoryAllow eq 1 && tblTender.brdMode eq 1)}" > --%>
	    <tr>
	        <td width="29%" style="word-break:break-word" class="black"><spring:message code="fields_tender_keywords"/></td>
	        <td width="1%" class="bold">:</td>
	        <td colspan="4"  width="29%" class="word-break line-height">${tblTender.keywordText}</td> <%-- Changes Bug Id:#26911 --%>
	    </tr>   
    <%-- </c:if> --%>
    <c:set var="cntTd" value="0"/>
    <tr>
    <c:set var="allowBidEvaluation" value="0"/>
        <c:set var="cntTd" value="${cntTd+1}"/>
        <td width="29%" class="black"><spring:message code="lbl_envelope"/></td>
        <td width="1%" class="bold">:</td>
        <td width="20%">
         ${envolopeName}
        </td>
            <c:if test="${cntTd eq 2}">
            </tr>
            <tr>
                <c:set var="cntTd" value="0"/>  
            </c:if>
            <c:set var="cntTd" value="${cntTd+1}"/>
            <td width="29%" class="black"><spring:message code="lbl_emvelope_type"/></td>
            <td width="1%" class="bold">:</td>
            <td width="20%">
                <c:choose>
                	<c:when test="${tblTender.envelopeType eq 1}">
                	<spring:message code="lbl_evaluation_singlestage"/>
                	</c:when>
                	<c:when test="${tblTender.envelopeType eq 2}">
                	<spring:message code="lbl_evaluation_multiestage"/>
                	</c:when>
                </c:choose> 
            </td>
<%--         <c:if test="${configParam.validityPeriod ne null}">
            <c:if test="${cntTd eq 2}">
            </tr>
            <tr>
                <c:set var="cntTd" value="0"/>  
            </c:if>
            <c:set var="cntTd" value="${cntTd+1}"/>
            <td width="29%" class="black"><spring:message code="lbl_bid_validity_period"/></td>
            <td width="1%" class="bold">:</td>
            <td width="20%">
                ${tblTender.validityPeriod}
            </td>
        </c:if> --%>
        <c:if test="${cntTd eq 2}">
            </tr>
            <tr>
                <c:set var="cntTd" value="0"/>  
        </c:if>
            <c:set var="cntTd" value="${cntTd+1}"/>
            <td width="29%" class="black"><spring:message code="lbl_type_of_contract"/></td>
            <td width="1%" class="bold">:</td>
            <td width="20%">${procurementNature}</td>

            <c:if test="${cntTd eq 2}">
            </tr>
            <tr>
                <c:set var="cntTd" value="0"/>  
            </c:if>
            <c:set var="cntTd" value="${cntTd+1}"/>
            <td width="29%" class="black"><spring:message code="lbl_projectduration"/></td>
            <td width="1%" class="bold">:</td>
            <td width="20%" class="word-break">
                ${tblTender.projectDuration}
            </td>
         <c:if test="${not empty sessionObject and sessionObject ne null and ( sessionObject.userTypeId eq 1 or sessionObject.userTypeId eq 3)}">
            <c:if test="${cntTd eq 2}">
            </tr>
            <tr>
                <c:set var="cntTd" value="0"/>  
            </c:if>
            <c:set var="cntTd" value="${cntTd+1}"/>
            <td width="29%" class="black"><spring:message code="lbl_tender_value"/></td>
			<td width="1%" class="bold">:</td>            
            <td width="20%">
            ${tblTender.tenderValue} 
            </td>
         </c:if> 
			<spring:message code="label_yes" var="yes"/>
			<spring:message code="label_no" var="no"/>
        
        <c:if test="${isPkiEventSpecific eq true}">
            <c:if test="${cntTd eq 2}">
            </tr>
            <tr>
                <c:set var="cntTd" value="0"/>  
            </c:if>
            <c:set var="cntTd" value="${cntTd+1}"/>
            <td width="29%" class="black">
	            <spring:message code="fields_tenderdigital_certrequired"/>
            </td>
			<td width="1%"><b>:</b></td>            
            <td width="20%">
            <c:choose>
				<c:when test="${tblTender.isCertRequired eq 1}">
					${yes}
				</c:when>
				<c:otherwise>
					${no}
				</c:otherwise>
			</c:choose>
            </td>
        </c:if>
<c:if test="${cntTd eq 1}">
    <td width="29%" class="black">&nbsp;</td> 
    <td width="1%"></td>
    <td width="20%">&nbsp;</td>
    <c:set var="cntTd" value="0"/>  
</tr>
</c:if>

</table>
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
								<h3 class="box-title"><spring:message code="title_bid_submission_conf"/></h3>
							</div>
							<div class="box-body">
								<div class="row">
									<div class="col-md-12">
										<table width="100%" cellpadding="0" cellspacing="0" class="formField1"  >
    <tr> 
        <c:if test="${checkpricebid}">  
            <c:if test="${cntTd eq 2}">
            </tr>
            <tr>
                <c:set var="cntTd" value="0"/>  
            </c:if>
            <c:set var="cntTd" value="${cntTd+1}"/>
            <td width="29%" class="black"><spring:message code="lbl_itemwise_lh"/>
            </td>
            <td width="1%" class="bold">:</td>
            <td width="20%">
                <c:choose>
                <c:when test="${tblTender.isItemwiseWinner eq 1}">
                <spring:message code="label_itemwise"/>
                </c:when>
                <c:when test="${tblTender.isItemwiseWinner eq 0}">
                <spring:message code="label_eventwise"/>
                </c:when>
                </c:choose>
            </td>
       <c:if test="${tblTender.isItemwiseWinner eq 0}">
		<c:if test="${cntTd eq 2}">
            </tr>
            <tr>
                <c:set var="cntTd" value="0"/>  
            </c:if>
            <c:set var="cntTd" value="${cntTd+1}"/>
            <td width="29%" class="black"><spring:message code="field_rebate"/>
            </td>
            <td width="1%" class="bold">:</td>
            <td width="20%">
               <c:choose>
                <c:when test="${tblTender.isRebateApplicable eq 1}">
                	${allow}
                </c:when>
                <c:when test="${tblTender.isRebateApplicable eq 0}">
                	${notallow}
                </c:when>
                </c:choose>
            </td>
           </c:if>
           <c:if test="${cntTd eq 2}">
            </tr>
            <tr>
                <c:set var="cntTd" value="0"/>  
            </c:if>
            <c:set var="cntTd" value="${cntTd+1}"/>
            <td width="29%" class="black"><spring:message code="lbl_weight_evaluation_require"/>
            </td>
            <td width="1%" class="bold">:</td>
            <td width="20%">
               <c:choose>
                <c:when test="${tblTender.isWeightageEvaluationRequired eq 1}">
                	${allow}
                </c:when>
                <c:when test="${tblTender.isWeightageEvaluationRequired eq 0}">
                	${notallow}
                </c:when>
                </c:choose>
            </td>
            </c:if>
            <c:if test="${cntTd eq 2}">
            </tr>
            <tr>
                <c:set var="cntTd" value="0"/>  
            </c:if>
            <c:set var="cntTd" value="${cntTd+1}"/>
            <td width="29%" class="black"><spring:message code="lbl_bidding_access"/>
             </td>
            <td width="1%" class="bold">:</td>
            <td width="20%">
               <c:choose>
                <c:when test="${tblTender.tenderMode eq 1}">
                <spring:message code="label_open"/>
                </c:when>
                <c:when test="${tblTender.tenderMode eq 2}">
                <spring:message code="label_limited"/>
                </c:when>
                <c:when test="${tblTender.tenderMode eq 3}">
                <spring:message code="label_single"/>
                </c:when>
                <c:when test="${tblTender.tenderMode eq 4}">
                <spring:message code="label_nomination"/>
                </c:when>
                </c:choose>
            </td>
        <c:if test="${cntTd eq 2}">
        </tr>
        <tr>
            <c:set var="cntTd" value="0"/>  
        </c:if>
        <c:set var="cntTd" value="${cntTd+1}"/>
        <td width="29%" class="black"><spring:message code="fields_basecurrency"/></td>
        <td width="1%" class="bold">:</td>
        <td width="20%">
            ${currencyName}
        </td>
            <c:if test="${cntTd eq 2}">
            </tr>
            <tr>
                <c:set var="cntTd" value="0"/>  
            </c:if>
            <c:set var="cntTd" value="${cntTd+1}"/>  
            <td width="29%" class="black"><spring:message code="lbl_biddingType"/></td>
            <td width="1%" class="bold">:</td>
            <td width="20%">
                <c:if test="${tblTender.biddingType eq 1}">
                <spring:message code="lbl_national_competitive_bidding"/>
                </c:if>
                <c:if test="${tblTender.biddingType eq 2}">
                <c:set var="curVal" value="( ${internationalCurrency} )"/>
                <spring:message code="lbl_international_competitive_bidding"/> ${not empty internationalCurrency ? curVal :'' }
                </c:if>
            </td>
        <c:choose>
            <c:when test="${tblTender.biddingType eq 2}">
                <c:if test="${cntId eq 0}">
                    <td  colspan="4" class="black">&nbsp;</td> 
                    <c:set var="cntTd" value="0"/>  
                </tr>
            </c:if>
            <c:if test="${cntTd eq 2}">
            </tr>
            <c:set var="cntTd" value="0"/>  
        </c:if>
        <c:if test="${cntTd eq 1}">
            <td width="29%" class="black">&nbsp;</td>
            <td width="1%"></td> 
            <td width="20%">&nbsp;</td>
        </tr>
        <c:set var="cntTd" value="0"/>  
    </c:if>
<tr>
</c:when>
</c:choose>

        <c:if test="${cntTd eq 2}">
        </tr>
        <tr>
            <c:set var="cntTd" value="0"/>  
        </c:if>
        <c:set var="cntTd" value="${cntTd+1}"/>
        <td width="29%" class="black"><spring:message code="lbl_consortium"/>
        </td>
        <td width="1%" class="bold">:</td>
        <td width="20%">
            <c:set var="isFormBasedConsortium" value="${valueMap.isFormBasedConsortium}"/>
            <c:choose>
                <c:when test="${tblTender.isFormBasedConsortium eq 0}">
                    ${notallow}
                </c:when>
                <c:when test="${tblTender.isFormBasedConsortium eq 1}">
                    ${allow}
                </c:when>
            </c:choose>
        </td>

        <c:if test="${cntTd eq 2}">
        </tr>
        <tr>
            <c:set var="cntTd" value="0"/>  
        </c:if>
        <c:set var="cntTd" value="${cntTd+1}"/>
        <td width="29%" class="black"><spring:message code="lbl_bidwithdrawal"/></td>
        <td width="1%" class="bold">:</td>
        <td width="20%">
            <c:choose>
                <c:when test="${tblTender.isBidWithdrawal eq 0}">
                    ${notallow}
                </c:when>
                <c:when test="${tblTender.isBidWithdrawal eq 1}">
                    ${allow}
                </c:when>
            </c:choose>
        </td>
    <c:if test="${cntTd eq 0}">
        <td colspan="4">&nbsp;</td>
        <c:set var="cntTd" value="0"/>  
    </tr>
</c:if>
<c:if test="${cntTd eq 2}">
</tr>
<c:set var="cntTd" value="0"/>  
</c:if>
<c:if test="${cntTd eq 1}">
    <td width="29%" class="black">&nbsp;</td>
    <td width="1%"></td> 
    <td width="20%">&nbsp;</td>
    <c:set var="cntTd" value="0"/>  
</tr>
</c:if>
</table>
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
					<h3 class="box-title"><spring:message code="title_key_conf"/></h3>
				</div>
				<div class="box-body">
					<div class="row">
						<div class="col-md-12">
							<c:set value="0" var="keyConf"/>

<table width="100%" cellpadding="0" cellspacing="0" class="formField1"  id="tldKeyConfDtl">
    <tr>
            <c:set value="${keyConf+1}" var="keyConf"/>
            <c:if test="${cntTd eq 2}">
            </tr>
            <tr>
                <c:set var="cntTd" value="0"/>  
            </c:if>
            <c:set var="cntTd" value="${cntTd+1}"/>
            <td width="29%" class="black"><spring:message code="lbl_bidding_variant"/></td>
            <td width="1%" class="bold">:</td>
            <td width="20%">
                <c:choose>
                <c:when test="${tblTender.biddingVariant eq 1}">
                    <spring:message code="label_buy"/>
                </c:when>
                <c:when test="${tblTender.biddingVariant eq 2}">
                    <spring:message code="label_sell"/>
                </c:when>
            </c:choose>
            </td>
                <c:set value="${keyConf+1}" var="keyConf"/>
                <c:if test="${cntTd eq 2}">
                </tr>
                <tr>
                    <c:set var="cntTd" value="0"/>  
                </c:if>
                <c:set var="cntTd" value="${cntTd+1}"/>
                <td width="29%" class="black"><spring:message code="lbl_prebid_meeting"/></td>
                <td width="1%" class="bold">:</td>
                <td width="20%">
                    <c:choose>
		                <c:when test="${tblTender.isPreBidMeeting eq 1}">
		                    ${allow}
		                </c:when>
		                <c:when test="${tblTender.isPreBidMeeting eq 0}">
		                    ${notallow}
		                </c:when>
		            </c:choose>
                </td>
        <c:if test="${tblTender.isPreBidMeeting eq 1}">

               <c:set value="${keyConf+1}" var="keyConf"/>
                 <c:if test="${tblTender.preBidMode eq 2}">
                	<c:if test="${cntTd eq 2}">
                    </tr>
                    <tr>
                        <c:set var="cntTd" value="0"/>  
                    </c:if>
                    <c:set var="cntTd" value="${cntTd+1}"/>
                    <td width="29%" class="black"><spring:message code="lbl_prebid_address"/></td>
                    <td width="1%" class="bold">:</td>
                    <td width="20%">
                        ${tblTender.preBidAddress}
                    </td>
                    </c:if>
        </c:if>
         <c:if test="${cntTd eq 2}">
              </tr>
              <tr>
                  <c:set var="cntTd" value="0"/>  
              </c:if>
              <c:set var="cntTd" value="${cntTd+1}"/>
              <td width="29%" class="black"><spring:message code="lbl_auto_result_sharing"/></td>
              <td width="1%" class="bold">:</td>
              <td width="20%">
                  <c:choose>
                <c:when test="${tblTender.autoResultSharing eq 1}">
                    <spring:message code="lbl_manual"/>
                </c:when>
                <c:when test="${tblTender.autoResultSharing eq 0}">
                    <spring:message code="lbl_auto"/>
                </c:when>
            </c:choose>
             </td>
            <c:set value="${keyConf+1}" var="keyConf"/>
            <c:if test="${cntTd eq 2}">
            </tr>
            <tr>
                <c:set var="cntTd" value="0"/>  
            </c:if>
            <c:set var="cntTd" value="${cntTd+1}"/>
            <td width="29%" class="black"><spring:message code="lbl_workflow_requires"/></td>
            <td width="1%" class="bold">:</td>
            <td width="20%">
              <c:choose>
		                <c:when test="${tblTender.isWorkflowRequired eq 1}">
		                    <c:set  var="isWorkflowReq" value="${true}" />
		                    ${yes}
		                </c:when>
		                <c:when test="${tblTender.isWorkflowRequired eq 0}">
		                    ${no}
		                </c:when>
		            </c:choose>
                    
            </td>
    <c:if test="${cntTd eq 2}">
    </tr>
    <c:set var="cntTd" value="0"/>  
</c:if>
<c:if test="${cntTd eq 1}">
    <td width="29%" class="black">&nbsp;</td>
    <td width="1%"></td> 
    <td width="20%">&nbsp;</td>
    <c:set var="cntTd" value="0"/>  
</tr>
</c:if> 

</table>
						</div>
					</div>
				</div>
			</div>
		         </div>
		</div>
		
		
<c:if test="${2 eq fromPublishTender or 0 eq fromPublishTender or empty fromPublishTender}">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
				<div class="box-header with-border">
					<h3 class="box-title"><spring:message code="title_dates_conf"/></h3>
				</div>
				<div class="box-body">
					<div class="row">
						<div class="col-md-12">
						<table width="100%" cellpadding="0" cellspacing="0" class="formField1"  > 
<c:set var="endDate" value="${documentEndDate}"/> 
<c:set var="startDate" value="${documentStartDate}"/>
    <tr >
            <c:if test="${cntTd eq 2}">
            </tr>
            <tr>
                <c:set var="cntTd" value="0"/>  
            </c:if>
            <c:set var="cntTd" value="${cntTd+1}"/>
            <td width="29%" class="black"><spring:message code="lbl_document_start_date" /></td>
            <td width="1%" class="bold">:</td>
            <td width="20%">
                ${documentStartDate}
            </td>
            <c:if test="${cntTd eq 2}">
            </tr>
            <tr>
                <c:set var="cntTd" value="0"/>  
            </c:if>
            <c:set var="cntTd" value="${cntTd+1}"/>
            <td width="29%" class="black"><spring:message code="lbl_document_end_date" /></td>
            <td width="1%" class="bold">:</td>
            <td width="20%">
                ${documentEndDate}
            </td>
            <c:if test="${cntTd eq 2}">
            </tr>
            <tr>
                <c:set var="cntTd" value="0"/>  
            </c:if>
            <c:set var="cntTd" value="${cntTd+1}"/>
            <td width="29%" class="black"><spring:message code="lbl_bid_submission_start_date" /></td>
            <td width="1%" class="bold">:</td>
            <td width="20%">
                ${submissionStartDate}
            </td>

        <c:if test="${cntTd eq 2}">
        </tr>
        <tr>
            <c:set var="cntTd" value="0"/>  
        </c:if>
        <c:set var="cntTd" value="${cntTd+1}"/>
        <td width="29%" class="black"><spring:message code="lbl_bid_submission_end_date" /></td>
        <td width="1%" class="bold">:</td>
        <td width="20%">
            ${submissionEndDate}
        </td>

        <c:if test="${cntTd eq 2}">
        </tr>
        <tr>
            <c:set var="cntTd" value="0"/>  
        </c:if>
        <c:set var="cntTd" value="${cntTd+1}"/>
        <td width="29%" class="black"><spring:message code="field_bidopeningstartdate" /></td>
        <td width="1%" class="bold">:</td>
        <td width="20%">
            ${openingDate}
        </td>
        <c:if test="${tblTender.isPreBidMeeting eq 1}">
            <c:if test="${cntTd eq 2}">
            </tr>
            <tr>
                <c:set var="cntTd" value="0"/>  
            </c:if>
            <c:set var="cntTd" value="${cntTd+1}"/>
            <td width="29%" class="black"><spring:message code="fields_prebidmeet_startdate" /></td>
            <td width="1%" class="bold">:</td>
            <td width="20%">
                ${preBidStartDate}
            </td>
        </c:if>
        <c:if test="${tblTender.isPreBidMeeting eq 1}">
            <c:if test="${cntTd eq 2}">
            </tr>
            <tr>
                <c:set var="cntTd" value="0"/>  
            </c:if>
            <c:set var="cntTd" value="${cntTd+1}"/>
            <td width="29%" class="black"><spring:message code="fields_prebidmeet_enddate" /></td>
            <td width="1%" class="bold">:</td>
            <td width="20%">
                ${preBidEndDate}
            </td>
        </c:if>
<c:if test="${cntTd eq 0}">
    <td colspan="4"></td>
    <c:set var="cntTd" value="0"/>  
</tr>
</c:if>
<c:if test="${cntTd eq 2}">
</tr>
<c:set var="cntTd" value="0"/>  
</c:if>
<c:if test="${cntTd eq 1}">
    <td width="29%" class="black"></td>
    <td width="1%"></td> 
    <td width="20%"></td>
    <c:set var="cntTd" value="0"/>  
</tr>
</c:if>
</table>
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
					<h3 class="box-title"><spring:message code="title_doc_emd_secfees"/></h3>
				</div>
				<div class="box-body">
					<div class="row">
						<div class="col-md-12">
							<c:set value="0" var="varFeesDtlCnt"/>

<table width="100%" cellpadding="0" cellspacing="0" class="formField1" id="tldFeesDtl">
    <tr>
                <c:set value="${varFeesDtlCnt+1}" var="varFeesDtlCnt"/>
                <c:if test="${cntTd eq 2}">
                </tr>
                <tr>
                    <c:set var="cntTd" value="0"/>  
                </c:if>
                <c:set var="cntTd" value="${cntTd+1}"/>
                <td width="29%" class="black"><spring:message code="lbl_document_fees"/></td>
                <td width="1%" class="bold">:</td>
                <td width="20%">
                    <c:choose>
                        <c:when test="${tblTender.isDocfeesApplicable eq 0}">
                            ${notallow}
                        </c:when>
                        <c:otherwise>
							${allow}
                        </c:otherwise>
                    </c:choose>
                </td>
         <c:if test="${tblTender.isDocfeesApplicable eq 1}">
            <c:set value="${varFeesDtlCnt+1}" var="varFeesDtlCnt"/>
            <c:if test="${cntTd eq 2}">
            </tr>
            <tr>
                <c:set var="cntTd" value="0"/>  
            </c:if>
            <c:set var="cntTd" value="${cntTd+1}"/>
            <td width="29%" class="black"><spring:message code="fields_fees_amt"/></td>
            <td width="1%" class="bold">:</td>
            <td width="20%">
                <fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${tblTender.documentFee}" var="documentFees"/> 
                ${documentFees}
            </td>
        </c:if>   
        <c:if test="${(tblTender.isDocfeesApplicable eq 1 or tblTender.isDocfeesApplicable eq 2) and tblTender.docFeePaymentMode eq 2}">
            <c:set value="${varFeesDtlCnt+1}" var="varFeesDtlCnt"/>
            <c:if test="${cntTd eq 2}">
            </tr>
            <tr>
                <c:set var="cntTd" value="0"/>  
            </c:if>
            <c:set var="cntTd" value="${cntTd+1}"/>
            <td width="29%" class="black"><spring:message code="field_docfees_payableat"/></td>
            <td width="1%" class="bold">:</td>
            <td width="20%">
                ${tblTender.docFeePaymentAddress}
            </td>
        </c:if>   
                <c:set value="${varFeesDtlCnt+1}" var="varFeesDtlCnt"/>
                <c:if test="${cntTd eq 2}">
                </tr>
                <tr>
                    <c:set var="cntTd" value="0"/>  
                </c:if>
                <c:set var="cntTd" value="${cntTd+1}"/>
                <td width="29%" class="black"><spring:message code="lbl_security_fee"/></td>
                <td width="1%" class="bold">:</td>
                <td width="20%">
                    <c:choose>
                        <c:when test="${tblTender.isSecurityfeesApplicable eq 0}">
                            ${notallow}
                        </c:when>
                        <c:otherwise>
                            ${allow}
                        </c:otherwise>
                    </c:choose>

                </td>
        <c:if test="${tblTender.isSecurityfeesApplicable eq 1}">
            <c:set value="${varFeesDtlCnt+1}" var="varFeesDtlCnt"/>
            <c:if test="${cntTd eq 2}">
            </tr>
            <tr>
                <c:set var="cntTd" value="0"/>  
            </c:if>
            <c:set var="cntTd" value="${cntTd+1}"/>
            <td width="29%" class="black"><spring:message code="field_tendersec_fees_amt"/></td>
            <td width="1%" class="bold">:</td>
            <td width="20%">
                <fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${tblTender.securityFee}" var="securityFees"/> 
                ${securityFees}
            </td>
        </c:if>   
        <c:if test="${tblTender.isSecurityfeesApplicable eq 1 and tblTender.secFeePaymentMode eq 2}">
            <c:set value="${varFeesDtlCnt+1}" var="varFeesDtlCnt"/>
            <c:if test="${cntTd eq 2}">
            </tr>
            <tr>
                <c:set var="cntTd" value="0"/>  
            </c:if>
            <c:set var="cntTd" value="${cntTd+1}"/>
            <td width="29%" class="black"><spring:message code="field_tendersec_fee_payment_at"/></td>
            <td width="1%" class="bold">:</td>
            <td width="20%">
                ${tblTender.secFeePaymentAddress}
            </td>
        </c:if>   
                <c:set value="${varFeesDtlCnt+1}" var="varFeesDtlCnt"/>
                <c:if test="${cntTd eq 2}">
                </tr>
                <tr>
                    <c:set var="cntTd" value="0"/>  
                </c:if>
                <c:set var="cntTd" value="${cntTd+1}"/>
                <td width="29%" class="black"><spring:message code="lbl_emd_fee"/></td>
                <td width="1%" class="bold">:</td>
                <td width="20%">
                    <c:choose>
                        <c:when test="${tblTender.isEMDApplicable eq 0}">
                            ${notallow}
                        </c:when>
                        <c:otherwise>
                            ${allow}
                        </c:otherwise>
                    </c:choose>
                </td>
        <c:if test="${tblTender.isEMDApplicable eq 1}">
            <c:set value="${varFeesDtlCnt+1}" var="varFeesDtlCnt"/>
            <c:if test="${cntTd eq 2}">
            </tr>
            <tr>
                <c:set var="cntTd" value="0"/>  
            </c:if>
            <c:set var="cntTd" value="${cntTd+1}"/>
            <td width="29%" class="black"><spring:message code="field_emdamt"/></td>
            <td width="1%" class="bold">:</td>
            <td width="20%">
                <fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${tblTender.emdAmount}" var="emdAmounts"/> 
                ${emdAmounts}
            </td>
        </c:if>   
        <c:if test="${(tblTender.isEMDApplicable eq 1 or tblTender.isEMDApplicable eq 2) and tblTender.emdPaymentMode eq 2}">
            <c:set value="${varFeesDtlCnt+1}" var="varFeesDtlCnt"/>
            <c:if test="${cntTd eq 2}">
            </tr>
            <tr>
                <c:set var="cntTd" value="0"/>  
            </c:if>
            <c:set var="cntTd" value="${cntTd+1}"/>
            <td width="29%" class="black"><spring:message code="field_emdpaymentat"/></td>
            <td width="1%" class="bold">:</td>
            <td width="20%">
                ${tblTender.emdPaymentAddress}
            </td>
        </c:if>
        <c:if test="${cntTd eq 0}">
            <td colspan="4"></td>
            <c:set var="cntTd" value="0"/>  
        </tr>
    </c:if>
    <c:if test="${cntTd eq 2}">
    </tr>
    <c:set var="cntTd" value="0"/>  
</c:if>
<c:if test="${cntTd eq 1}">
    <td width="29%" class="black"></td>
    <td width="1%"></td> 
    <td width="20%"></td>
    <c:set var="cntTd" value="0"/>  
</tr>
</c:if>
</table>
						</div>
					</div>
				</div>
			</div>
		         </div>
		</div>
		<c:if test="${tblTender.cstatus eq 1}">
		<div class="row corrigendumDtl">
			<div class="col-md-12">
				<div class="box">
				<div class="box-header with-border">
					<h3 class="box-title"><spring:message code="title_tender_th_viewcorrigendum"/></h3>
				</div>
				<div class="box-body">
					<div class="row">
						<div class="col-md-12">
							<div id="corrigendumDiv"></div>
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
					<h3 class="box-title">Document Detail</h3>
				</div>
				<div class="box-body">
					<div class="row">
						<div class="col-md-12">
							<div id="documentList"></div>
						</div>
					</div>
				</div>
			</div>
		         </div>
		</div>

 <c:if test="${1 ne fromPublishTender && 2 ne fromPublishTender}">
	<div class="">
			<input type="button" class="btn noExport" onclick="exportContent('viewTenderId','ViewTender',0)" value="PDF">
			<input type="button" class="btn noExport" onclick="exportContent('viewTenderId','PendingTender',5)" value="Print">
	</div>
</c:if>
</section></div>
<script type="text/javascript">
	$(document).ready(function(){
	<c:if test="${tblTender.cstatus eq 1}"> /*  because now we always show document and corrigendum */
		$.ajax({
			url : "${pageContext.servletContext.contextPath}/etender/buyer/viewcorrigendum/${tblTender.tenderId}/1",
			success : function(data) {
				$("#corrigendumDiv").html(data);
				$("#corrigendumDiv").find(".content-wrapper").css('min-height','');
				$("#corrigendumDiv").find(".content-wrapper").removeClass("content-wrapper");
				$("#corrigendumDiv").find(".content-header").removeClass("content-header");
			}
		});	
	</c:if>
	$.ajax({
		url : "${pageContext.servletContext.contextPath}/etender/buyer/getDocumentList/${tblTender.tenderId}/${tenderNITObjectId}/${tblTender.tenderId}/0/0",
		success : function(data) {
			$("#documentDiv").show();
			$("#documentList").html(data);
		}
	});	
   }); 
</script>

<c:if test="${1 ne fromPublishTender && 2 ne fromPublishTender}">
	<%@include file="../../includes/footer.jsp"%>
	</c:if>