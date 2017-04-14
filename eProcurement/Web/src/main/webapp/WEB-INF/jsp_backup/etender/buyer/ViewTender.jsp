<!DOCTYPE html>
<html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<c:if test="${2 eq fromPublishTender}"><%-- for before login --%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/_all-skins.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/template1/css/style.css">
</c:if>
<c:if test="${param.viewCorrigendum eq 'true'}">
<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
</c:if>  

<c:if test="${1 ne fromPublishTender && 2 ne fromPublishTender}">
<%@include file="../../includes/header.jsp"%>
</c:if>

<spring:message code="label_allow" var="allow"/>
<spring:message code="label_dontallow"  var="notallow"/>
<spring:message code="label_online" var="online"/>
<spring:message code="label_offline" var="offline"/>
</head>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="../../includes/leftaccordion.jsp"%>

<div class="content-wrapper">

<c:if test="${1 ne fromPublishTender && 2 ne fromPublishTender}">

<c:if test="${not empty successMsg}">
    	<c:choose>
    		<c:when test="${fn:contains(successMsg, '_')}">
    			<div class="alert alert-success"><spring:message code="${successMsg}"/></div>
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

<section class="content-header">

<c:choose>
<c:when test="${1 ne fromPublishTender && 2 ne fromPublishTender}">
<h1><spring:message code="label_tender_view"/></h1>
<a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}"  class="btn btn-submit"><< <spring:message code="lbl_back_dashboard"/></a>    
</c:when>

<c:otherwise>

<h1><spring:message code="link_tender_view"/></h1>
         <c:choose>
				<c:when test="${2 ne fromPublishTender}">
				<a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}"  class="goBack"><< <spring:message code="lbl_back_dashboard"/></a>
				</c:when>
				<c:when test="${2 eq fromPublishTender}">
					<a href="${pageContext.servletContext.contextPath}/login" class="goBack"><< Go Back To Login</a>
				</c:when>
		</c:choose>
</c:otherwise>
</c:choose>
</section>

<section class="content">
	
<div class="row">

<div class="col-lg-12 cl-md-12 col-sm-12 col-xs-12">

<div class="box">

<div class="box-body">

<div class="row">
<div class="col-lg-2 col-md-2 col-sm-12 col-xs-12"><div class="vt"><spring:message code="label_tender_department"/></div></div>
<div class="col-lg-2 col-md-2 col-sm-12 col-xs-12"><div class="vt">: ${departmentName}</div></div>
<div class="col-lg-2 col-md-2 col-sm-12 col-xs-12"><div class="vt"><spring:message code="fields_tender_departmentofficial"/></div></div>
<div class="col-lg-2 col-md-2 col-sm-12 col-xs-12"><div class="vt">: ${officerName}</div></div>
</div>

<div class="row">
<div class="col-lg-2 col-md-2 col-sm-12 col-xs-12"><div class="vt"><spring:message code="fields_tenderid"/></div></div>
<div class="col-lg-2 col-md-2 col-sm-12 col-xs-12"><div class="vt">: ${tblTender.tenderId}</div></div>
<div class="col-lg-2 col-md-2 col-sm-12 col-xs-12"><div class="vt"><spring:message code="fields_refenceno"/></div></div>
<div class="col-lg-2 col-md-2 col-sm-12 col-xs-12"><div class="vt">: ${tblTender.tenderNo}</div></div>
</div>

<div class="row">
<div class="col-lg-2 col-md-2 col-sm-12 col-xs-12"><div class="vt"><spring:message code="field_eventtype"/></div></div>
<div class="col-lg-2 col-md-2 col-sm-12 col-xs-12"><div class="vt">: ${eventTypeName}</div></div>
</div>

<div class="row">
<div class="col-lg-2 col-md-2 col-sm-12 col-xs-12"><div class="vt"><spring:message code="field_brief"/></div></div>
<div class="col-lg-2 col-md-2 col-sm-12 col-xs-12"><div class="vt">: ${tblTender.tenderBrief}</div></div>
</div>

<div class="row">
<div class="col-lg-2 col-md-2 col-sm-12 col-xs-12"><div class="vt"><spring:message code="field_tender_detail"/></div></div>
<div class="col-lg-2 col-md-2 col-sm-12 col-xs-12"><div class="vt">: ${tblTender.tenderDetail}</div></div>
</div>

<c:if test="${eventTypeId ne null && isCategoryAllow ne null && isCategoryAllow eq 1}" >
<div class="row">
<div class="col-lg-2 col-md-2 col-sm-12 col-xs-12"><div class="vt"><spring:message code="lbl_auction_category"/></div></div>
<div class="col-lg-2 col-md-2 col-sm-12 col-xs-12"><div class="vt">: ${categoryNameList}</div></div>
</div>
</c:if>

<div class="row">
<div class="col-lg-2 col-md-2 col-sm-12 col-xs-12"><div class="vt"><spring:message code="fields_tender_keywords"/></div></div>
<div class="col-lg-2 col-md-2 col-sm-12 col-xs-12"><div class="vt">: ${tblTender.keywordText}</div></div>
</div>

<c:set var="cntTd" value="0"/>

<c:set var="allowBidEvaluation" value="0"/>
<c:set var="cntTd" value="${cntTd+1}"/>
<div class="row">
<div class="col-lg-2 col-md-2 col-sm-12 col-xs-12"><div class="vt"><spring:message code="lbl_envelope"/></div></div>
<div class="col-lg-2 col-md-2 col-sm-12 col-xs-12"><div class="vt">: ${envolopeName}</div></div>
</div>

<c:if test="${cntTd eq 2}">
<c:set var="cntTd" value="0"/>  
</c:if>

<c:set var="cntTd" value="${cntTd+1}"/>

<div class="row">
<div class="col-lg-2 col-md-2 col-sm-12 col-xs-12"><div class="vt"><spring:message code="lbl_emvelope_type"/></div></div>
<div class="col-lg-2 col-md-2 col-sm-12 col-xs-12"><div class="vt">
<c:choose>
                	<c:when test="${tblTender.envelopeType eq 1}">
                	<spring:message code="lbl_evaluation_singlestage"/>
                	</c:when>
                	<c:when test="${tblTender.envelopeType eq 2}">
                	<spring:message code="lbl_evaluation_multiestage"/>
                	</c:when>
                </c:choose> 
</div></div>
</div>
            
<%--         <c:if test="${configParam.validityPeriod ne null}">
            <c:if test="${cntTd eq 2}">
            </tr>
            <tr>
                <c:set var="cntTd" value="0"/>  
            </c:if>
            <c:set var="cntTd" value="${cntTd+1}"/>
            <td width="29%" class="black"><spring:message code="lbl_bid_validity_period"/></td>
            <td width="1%"><b>:<b></td>
            <td width="20%">
                ${tblTender.validityPeriod}
            </td>
        </c:if> --%>

<c:if test="${cntTd eq 2}">         
<c:set var="cntTd" value="0"/>  
</c:if>

<c:set var="cntTd" value="${cntTd+1}"/>

<div class="row">
<div class="col-lg-2 col-md-2 col-sm-12 col-xs-12"><div class="vt"><spring:message code="lbl_type_of_contract"/></div></div>
<div class="col-lg-2 col-md-2 col-sm-12 col-xs-12"><div class="vt">${procurementNature}</div></div>
</div>

<c:if test="${cntTd eq 2}">
<c:set var="cntTd" value="0"/>  
</c:if>

<c:set var="cntTd" value="${cntTd+1}"/>

<div class="row">
<div class="col-lg-2 col-md-2 col-sm-12 col-xs-12"><div class="vt"><spring:message code="lbl_projectduration"/></div></div>
<div class="col-lg-2 col-md-2 col-sm-12 col-xs-12"><div class="vt">${tblTender.projectDuration}</div></div>
</div>
            
<%--
           <c:if test="${cntTd eq 2}">
           </tr>
           <tr>
               <c:set var="cntTd" value="0"/>  
           </c:if>
           <c:set var="cntTd" value="${cntTd+1}"/>
           <td width="29%" class="black"><spring:message code="lbl_downloaddocument"/></td>
           <td width="1%"><b>:<b></td>
           <td width="20%">
               <c:choose>
               <c:when test="${tblTender.downloadDocument eq 1}">
               	<spring:message code="label_beforelogin"/>
               </c:when>
               <c:when test="${tblTender.downloadDocument eq 2}">
               After login
               <spring:message code="label_afterlogin"/>
               </c:when>
               <c:when test="${tblTender.downloadDocument eq 3}">
               After payment
               <spring:message code="label_afterpayment"/>
               </c:when>
               </c:choose>
           </td>
 --%>	
<c:if test="${not empty sessionObject and sessionObject ne null and ( sessionObject.userTypeId eq 1 or sessionObject.userTypeId eq 3)}">

<c:if test="${cntTd eq 2}">           
<c:set var="cntTd" value="0"/>  
</c:if>

<c:set var="cntTd" value="${cntTd+1}"/>
<div class="row">
<div class="col-lg-2 col-md-2 col-sm-12 col-xs-12"><div class="vt"><spring:message code="lbl_tender_value"/></div></div>
<div class="col-lg-2 col-md-2 col-sm-12 col-xs-12"><div class="vt">${tblTender.tenderValue}</div></div>
</div>
            
</c:if> 

<%--PT:20193 --%>
<spring:message code="label_yes" var="yes"/>
<spring:message code="label_no" var="no"/>
        
<c:if test="${isPkiEventSpecific eq true}">

<c:if test="${cntTd eq 2}">
<c:set var="cntTd" value="0"/>  
</c:if>

<c:set var="cntTd" value="${cntTd+1}"/>
<div class="row">
<div class="col-lg-2 col-md-2 col-sm-12 col-xs-12"><div class="vt"><spring:message code="fields_tenderdigital_certrequired"/></div></div>
<div class="col-lg-2 col-md-2 col-sm-12 col-xs-12"><div class="vt">
<c:choose>
<c:when test="${tblTender.isCertRequired eq 1}">
${yes}
</c:when>
<c:otherwise>
${no}
</c:otherwise>
</c:choose>
</div></div>
</div>
          
</c:if>
        
<c:if test="${cntTd eq 1}">
<c:set var="cntTd" value="0"/>  
</c:if>

<div class="clearfix"></div>
</div>

</div>

</div>


<div class="col-lg-12 cl-md-12 col-sm-12 col-xs-12">
<div class="box">

<div class="box-header with-border"><h3 class="box-title"><spring:message code="title_bid_submission_conf"/></h3></div>

<div class="box-body">

<div class="row">

<div class="col-md-12">

<table width="100%" cellpadding="0" cellspacing="0" class="formField1"  >

<c:if test="${not empty  configParam.isSplitPOAllowed}">
<c:if test="${cntTd eq 2}">

            
            <tr>
                <c:set var="cntTd" value="0"/>  
            </c:if>
            <c:set var="cntTd" value="${cntTd+1}"/>
            <td width="29%" class="black">${labelMap.isSplitPOAllowed}</td>
            <td width="1%"><b>:<b></td>
            <td width="20%">
                <c:set var="isSplitPOAllowed" value="${valueMap.isSplitPOAllowed}"/>
                <c:choose>
                    <c:when test="${isSplitPOAllowed[tblTender.isSplitPOAllowed] eq dontAllow}">
                        ${notallow}
                    </c:when>
                    <c:otherwise>
                        <c:choose>
                            <c:when test="${isSplitPOAllowed[tblTender.isSplitPOAllowed] eq allow}">
                                ${allowed}
                            </c:when>
                            <c:otherwise>
                                <c:out value="${isSplitPOAllowed[tblTender.isSplitPOAllowed]}"/>
                            </c:otherwise>
                        </c:choose>
                    </c:otherwise>
                </c:choose>
            </td>
        </c:if>

        <%-- <c:if test="${allowBidEvaluation eq 1 and not empty  configParam.isItemwiseWinner}"> --%>
        <%--  No need to allowBidEvaluation  condition, because not used for notice creation --%>
        <c:if test="${checkpricebid}"> 
            <c:if test="${cntTd eq 2}">
            </tr>
            <tr>
                <c:set var="cntTd" value="0"/>  
            </c:if>
            <c:set var="cntTd" value="${cntTd+1}"/>
            <td width="29%" class="black"><spring:message code="lbl_itemwise_lh"/>
            </td>
            <td width="1%"><b>:<b></td>
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
            <td width="1%"><b>:<b></td>
            <td width="20%">
               <c:choose>
                <c:when test="${tblTender.isRebateApplicable eq 1}">
                	${allow}
                </c:when>
                <c:when test="${tblTender.isRebateApplicable eq 0}">
                	${notallow}
                </c:when>
                </c:choose>
            </td>            </c:if>
        </c:if>

            <c:if test="${cntTd eq 2}">
            </tr>
            <tr>
                <c:set var="cntTd" value="0"/>  
            </c:if>
            <c:set var="cntTd" value="${cntTd+1}"/>
            <td width="29%" class="black"><spring:message code="lbl_mode_of_submission"/>
            </td>
            <td width="1%"><b>:<b></td>
            <td width="20%">
               <c:choose>
                <c:when test="${tblTender.submissionMode eq 1}">
                	${online}
                </c:when>
                <c:when test="${tblTender.submissionMode eq 2}">
                	${offline}
                </c:when>
                </c:choose>
            </td>

            <c:if test="${cntTd eq 2}">
            </tr>
            
            
            
            <tr>
                <c:set var="cntTd" value="0"/>  
            </c:if>
            <c:set var="cntTd" value="${cntTd+1}"/>
            <td width="29%" class="black"><spring:message code="lbl_bidding_access"/>
             </td>
            <td width="1%"><b>:<b></td>
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
        <td width="1%"><b>:<b></td>
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
            <td width="1%"><b>:<b></td>
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
        <td width="1%"><b>:<b></td>
        <td width="20%">
            <c:set var="isConsortiumAllowed" value="${valueMap.isConsortiumAllowed}"/>
            <c:choose>
                <c:when test="${tblTender.isConsortiumAllowed eq 0}">
                    ${notallow}
                </c:when>
                <c:when test="${tblTender.isConsortiumAllowed eq 1}">
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
        <td width="1%"><b>:<b></td>
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
	


<div class="col-lg-12 cl-md-12 col-sm-12 col-xs-12">
<div class="box">

<div class="box-header with-border"><h3 class="box-title"><spring:message code="title_key_conf"/></h3></div>

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
            <td width="1%"><b>:<b></td>
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
                <td width="1%"><b>:<b></td>
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
               <%-- <c:if test="${cntTd eq 2}">
                </tr>
                <tr>
                    <c:set var="cntTd" value="0"/>  
                </c:if>
                <c:set var="cntTd" value="${cntTd+1}"/>
                <td width="29%" class="black"><spring:message code="lbl_prebid_meeting"/></td>
                <td width="1%"><b>:<b></td>
                <td width="20%">
                    <c:choose>
		                <c:when test="${tblTender.preBidMode eq 1}">
		                    ${online}
		                </c:when>
		                <c:when test="${tblTender.preBidMode eq 2}">
		                    ${offline}
		                </c:when>
		            </c:choose>
                    
                </td> --%>
                <%--                     Add prebid Address BY Manoj --%>
                 <c:if test="${tblTender.preBidMode eq 2}">
                	<c:if test="${cntTd eq 2}">
                    </tr>
                    <tr>
                        <c:set var="cntTd" value="0"/>  
                    </c:if>
                    <c:set var="cntTd" value="${cntTd+1}"/>
                    <td width="29%" class="black"><spring:message code="lbl_prebid_address"/></td>
                    <td width="1%"><b>:<b></td>
                    <td width="20%">
                        ${tblTender.preBidAddress}
                    </td>
                    </c:if>
<%--                     End --%>
            <%-- start code comments because of bugId: #29185 --%>
           <%--  <c:if test="${configParam.preBidMode eq 2}">
                <c:if test="${configParam.preBidAddress ne null}">
                    <c:set value="${keyConf+1}" var="keyConf"/>
                    <c:if test="${cntTd eq 2}">
                    </tr>
                    <tr>
                        <c:set var="cntTd" value="0"/>  
                    </c:if>
                    <c:set var="cntTd" value="${cntTd+1}"/>
                    <td width="29%" class="black">${labelMap.preBidAddress}</td>
                    <td width="1%"><b>:<b></td>
                    <td width="20%">
                        ${tblTender.preBidAddress}
                    </td>
                </c:if> 
            </c:if> --%>
        </c:if>
         <c:if test="${cntTd eq 2}">
              </tr>
              <tr>
                  <c:set var="cntTd" value="0"/>  
              </c:if>
              <c:set var="cntTd" value="${cntTd+1}"/>
              <td width="29%" class="black"><spring:message code="lbl_auto_result_sharing"/></td>
              <td width="1%"><b>:<b></td>
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
        <c:if test="${tblTender.submissionMode eq 2}">
            <c:if test="${configParam.documentSubmission ne null}">
                <c:set value="${keyConf+1}" var="keyConf"/>
                <c:if test="${cntTd eq 2}">
                </tr>
                <tr>
                    <c:set var="cntTd" value="0"/>  
                </c:if>
                <c:set var="cntTd" value="${cntTd+1}"/>
                <td width="29%" class="black">${labelMap.documentSubmission}</td>
                <td width="1%"><b>:<b></td>
                <td width="20%">
                    ${tblTender.documentSubmission}
                </td>
            </c:if>
        </c:if>
            <c:set value="${keyConf+1}" var="keyConf"/>
            <c:if test="${cntTd eq 2}">
            </tr>
            <tr>
                <c:set var="cntTd" value="0"/>  
            </c:if>
            <c:set var="cntTd" value="${cntTd+1}"/>
            <td width="29%" class="black"><spring:message code="lbl_workflow_requires"/></td>
            <td width="1%"><b>:<b></td>
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
        <%-- <c:if test="${tblTender.isWorkflowRequired eq 1}">
        <c:if test="${isWorkflowReq eq true }">
            <c:set value="${keyConf+1}" var="keyConf"/>
            <c:if test="${cntTd eq 2}">
            </tr>
            <tr>
                <c:set var="cntTd" value="0"/>  
            </c:if>
            <c:set var="cntTd" value="${cntTd+1}"/>
            <td width="29%" class="black" ><spring:message code="lbl_workflow_type"></spring:message></td>
            <td width="1%"><b>:<b></td>
            <td width="20%">
            <c:forEach var="lstWorkflowList" items="${workflowList}">
	            ${lstWorkflowList.workflowTypeId eq tblTender.workflowTypeId ? lstWorkflowList.lang1 : ''}
	            
            </c:forEach>
            </td>
            </c:if>
        </c:if>
        
            <c:set value="${keyConf+1}" var="keyConf"/>
            <c:if test="${cntTd eq 2}">
            </tr>
            <tr>
                <c:set var="cntTd" value="0"/>  
            </c:if>
            <c:set var="cntTd" value="${cntTd+1}"/>
            <td width="29%" class="black"><spring:message code="lbl_question_answer" /></td>
            <td width="1%"><b>:<b></td>
            <td width="20%">
                <c:out value="${isQuestionAnswer[tblTender.isQuestionAnswer]}"/>
                 <c:choose>
		                <c:when test="${tblTender.isQuestionAnswer eq 1}">
		                    ${yes}
		                </c:when>
		                <c:when test="${tblTender.isQuestionAnswer eq 0}">
		                    ${no}
		                </c:when>
		            </c:choose>
            </td>
        <c:if test="${cntTd eq 0}">
            <td  colspan="4">&nbsp;</td>
            <c:set var="cntTd" value="0"/>  
        </tr>
    </c:if>--%>
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



<div class="col-lg-12 cl-md-12 col-sm-12 col-xs-12">
<div class="box">
<c:if test="${2 eq fromPublishTender or 0 eq fromPublishTender}">
<div class="box-header with-border"><h3 class="box-title"><spring:message code="title_dates_conf"/></h3></div>

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
            <td width="1%"><b>:<b></td>
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
            <td width="1%"><b>:<b></td>
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
            <td width="1%"><b>:<b></td>
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
        <td width="1%"><b>:<b></td>
        <td width="20%">
            ${submissionEndDate}
        </td>

        <c:if test="${tblTender.isPreBidMeeting eq 1}">
            <c:if test="${cntTd eq 2}">
            </tr>
            <tr>
                <c:set var="cntTd" value="0"/>  
            </c:if>
            <c:set var="cntTd" value="${cntTd+1}"/>
            <td width="29%" class="black"><spring:message code="fields_prebidmeet_startdate" /></td>
            <td width="1%"><b>:<b></td>
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
            <td width="1%"><b>:<b></td>
            <td width="20%">
                ${preBidEndDate}
            </td>
        </c:if>
        <c:if test="${cntTd eq 2}">
        </tr>
        <tr>
            <c:set var="cntTd" value="0"/>  
        </c:if>
        <c:set var="cntTd" value="${cntTd+1}"/>
        <td width="29%" class="black"><spring:message code="field_bidopeningstartdate" /></td>
        <td width="1%"><b>:<b></td>
        <td width="20%">
            ${openingDate}
        </td>
        <c:if test="${tblTender.isQuestionAnswer eq 1}">
            <c:if test="${cntTd eq 2}">
            </tr>
            <tr>
                <c:set var="cntTd" value="0"/>  
            </c:if>
            <c:set var="cntTd" value="${cntTd+1}"/>
            <td width="29%" class="black"><spring:message code="field_queans_startdate"/></td>
            <td width="1%"><b>:<b></td>
            <td width="20%">
                ${questionAnswerStartDate}
            </td>
            <c:if test="${cntTd eq 2}">
            </tr>
            <tr>
                <c:set var="cntTd" value="0"/>  
            </c:if>
            <c:set var="cntTd" value="${cntTd+1}"/>
            <td width="29%" class="black"><spring:message code="field_queans_enddate"/></td>
            <td width="1%"><b>:<b></td>
            <td width="20%">
                ${questionAnswerEndDate}
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
</c:if>

</div>

</div>

</div>

</div>
</div>



<div class="col-lg-12 cl-md-12 col-sm-12 col-xs-12">
<div class="box">
<c:set value="0" var="varFeesDtlCnt"/>
<div class="box-header with-border"><h3 class="box-title"><spring:message code="title_doc_emd_secfees"/></h3></div>

<div class="box-body">

<div class="row">

<div class="col-md-12">

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
                <td width="1%"><b>:<b></td>
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
            <td width="1%"><b>:<b></td>
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
            <td width="1%"><b>:<b></td>
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
                <td width="1%"><b>:<b></td>
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
            <td width="1%"><b>:<b></td>
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
            <td width="1%"><b>:<b></td>
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
                <td width="1%"><b>:<b></td>
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
            <td width="1%"><b>:<b></td>
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
            <td width="1%"><b>:<b></td>
            <td width="20%">
                ${tblTender.emdPaymentAddress}
            </td>
        </c:if>
        
        <c:if test="${not empty configParam.isRegistrationCharges}">
            <c:set value="${varFeesDtlCnt+1}" var="varFeesDtlCnt"/>
            <c:if test="${cntTd eq 2}">
            </tr>
            <tr>
                <c:set var="cntTd" value="0"/>  
            </c:if>
            <c:set var="cntTd" value="${cntTd+1}"/>
            <td width="29%" class="black">${labelMap.isRegistrationCharges}</td>
            <td width="1%"><b>:<b></td>
            <td width="20%">
                <c:set var="emdPaymentMode" value="${valueMap.isRegistrationCharges}"/>
                <c:choose>
                        <c:when test="${isEMDApplicable[tblTender.isRegistrationCharges] eq dontAllow}">
                            ${dontAllow}
                        </c:when>
                        <c:otherwise>
                            <c:out value="${isEMDApplicable[tblTender.isRegistrationCharges]}"/>
                        </c:otherwise>
                    </c:choose>
            </td>
        </c:if>
        <c:if test="${not empty configParam.registrationChargesMode && (tblTender.isRegistrationCharges eq 1 or  tblTender.isRegistrationCharges eq 2)}">
            <c:set value="${varFeesDtlCnt+1}" var="varFeesDtlCnt"/>
            <c:if test="${cntTd eq 2}">
            </tr>
            <tr>
                <c:set var="cntTd" value="0"/>  
            </c:if>
            <c:set var="cntTd" value="${cntTd+1}"/>
            <td width="29%" class="black">${labelMap.registrationChargesMode}</td>
            <td width="1%"><b>:<b></td>
            <td width="20%">
                <c:set var="emdPaymentMode" value="${valueMap.registrationChargesMode}"/>
                <c:out value="${emdPaymentMode[tblTender.registrationChargesMode]}"/>
            </td>
        </c:if>
        <c:if test="${tblTender.isRegistrationCharges eq 1}">
            <c:set value="${varFeesDtlCnt+1}" var="varFeesDtlCnt"/>
            <c:if test="${cntTd eq 2}">
            </tr>
            <tr>
                <c:set var="cntTd" value="0"/>  
            </c:if>
            <c:set var="cntTd" value="${cntTd+1}"/>
            <spring:message code="lbl_tender_registration_charges" var="varlblaucregistrationcharges"/>
            <td width="29%" class="black">${varlblaucregistrationcharges}</td>
            <td width="1%"><b>:<b></td>
            <td width="20%">
             <fmt:formatNumber var="regAmounts" groupingUsed="false" type="number" maxFractionDigits="2" minFractionDigits="2" value="${tblTender.registrationCharges}" />
                ${regAmounts}
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



<div class="col-lg-12 cl-md-12 col-sm-12 col-xs-12">
<div class="box">

<div class="box-header with-border"><h3 class="box-title">Document Detail</h3></div>

<div class="box-body">

<div class="row">

<div class="col-md-12">

<div id="corrigendumDiv"></div>
<div id="documentDiv" style="display: none;">
	<h1>
        
    </h1>
    <div id="documentList"></div>
</div>

</div>

</div>

</div>

</div>
</div>


<div class="col-lg-12 cl-md-12 col-sm-12 col-xs-12">
 <c:if test="${1 ne fromPublishTender && 2 ne fromPublishTender}">
	<div class="">
			<input type="button" class="dt-button buttons-pdf buttons-html5" onclick="exportContent('viewTenderId','ViewTender',0)" value="PDF">
			<input type="button" class="dt-button buttons-pdf buttons-html5" onclick="exportContent('viewTenderId','PendingTender',5)" value="Print">
	</div>
</c:if>
</div>

</section>

</div>

<script type="text/javascript">
	$(document).ready(function(){
	<%--c:if test="${tblTender.cstatus eq 1 and param.viewCorrigendum eq 'true'}"--%>
	<c:if test="${tblTender.cstatus eq 1}"> /*  because now we always show document and corrigendum */
		$.ajax({
			url : "${pageContext.servletContext.contextPath}/etender/buyer/viewcorrigendum/${tblTender.tenderId}?pageFrom=viewTender",
			success : function(data) {
				$("#corrigendumDiv").html(data);
				$("#corrigendumDiv").find(".content-wrapper").css('min-height','');
				$("#corrigendumDiv").find(".content-wrapper").removeClass("content-wrapper");
				$("#corrigendumDiv").find(".content-header").removeClass("content-header");
			}
		});	
	</c:if>
	<%--c:if test="${param.viewDoclument eq 'true'}"--%>
	$.ajax({
		url : "${pageContext.servletContext.contextPath}/etender/buyer/getDocumentList/${tenderNITObjectId}/${tblTender.tenderId}/${tblTender.tenderId}/0/0",
		success : function(data) {
			$("#documentDiv").show();
			$("#documentList").html(data);
		}
	});	
		
	var addClass = "";
      if($('#hrefExpCollapse').attr('class')=='expand'){
    	  addClass  = 'width-785WithAuto';
		}else{
			addClass  = 'width-630WithAuto';
		}
      	var element = $(".event-dtl");
		$("table",element).each(function(){
	     	$(this).after("<div id='tenderDetailDiv' class='border-left border-right "+addClass+"'>"+$('<div></div>').append($(this).clone()).html()+"</div>");
	     	$(this).remove();
	    });
     var varFeesDtlCnt="${varFeesDtlCnt}";
    if(varFeesDtlCnt==0){
        $("#divFeesDtl").hide();
        $("#tldFeesDtl").hide();
        $("#tldFeesDtlHeading").hide();
    }else{
        $("#divFeesDtl").show();
        $("#tldFeesDtl").show();
        $("#tldFeesDtlHeading").show();
    }
    var keyConf=${keyConf};
    if(keyConf==0){
        $("#divKeyConfDtl").hide();
        $("#tldKeyConfDtl").hide();
    }else{
        $("#divKeyConfDtl").show();
        $("#tldKeyConfDtl").show();
    }
    if("${userType}" == 0){
    	$('section').addClass('grid_26');	
    }
   }); 
</script>

<c:if test="${1 ne fromPublishTender && 2 ne fromPublishTender}">
<%@include file="../../includes/footer.jsp"%>
</c:if>

</div>

<script type="text/javascript">
</script>
</body>
</html>