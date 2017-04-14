<%@include file="../../includes/head.jsp"%>
<%@include file="../../includes/masterheader.jsp"%>

<spring:message code="lbl_back_dashboard" var='backDashboard'/>

<div class="content-wrapper">
	<section class="content">
		<div class="row">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			<div class="box">
				<div class="box-header with-border">
				<div class="pull-right">
					<div><a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}"><< ${backDashboard}</a></div>
				</div>
					<h3 class="box-title"><spring:message code="tender_evaluation_title"></spring:message></h3>
				</div>
				<div class="box-body">
					<div class="row">
						<div class="col-lg-12 col-md-12 col-xs-12">
						<c:choose>
                            <c:when test="${createEditFlage eq '1'}">
								<spring:url value="/etender/buyer/saveevlutbiderstatus" var="postUrl" />
							</c:when>
							<c:otherwise>
								<spring:url value="/etender/buyer/updateevlutbiderstatus" var="postUrl" />
							</c:otherwise>
						</c:choose>
						<form:form action="${postUrl}" onsubmit="return validateChng();"  method="post">
							<div class="box-body pad">
								<table  class="table table-striped table-responsive">
									<tr>
                                    	<th colspan="3">
                                    		<input type="hidden" name="hdTenderId" value="${tenderId}"/>
                                    		<input type="hidden" name="hdEnvelopeId" value="${envelopeId}"/>
											<input type="hidden" name="hdCommitteeType" value="2"/>
										
			                                <input type="hidden" name="hdEnvelopeEnvId" value="${tblTenderEnvelope.tblEnvelope.envId}"/>
			                                <input type="hidden" name="hdIsTwoStageEvaluation" value="${isTwoStageEvaluation}"/>
			                                <input type="hidden" name="hdFormIds" value="${formIds ne '' ? formIds : 0}"/>
			                                <input type="hidden" name="hdEnvlopTypFlg" value="${envlopTypFlg}"/>
			                                <input type="hidden" name="hdIsCertRequired" value="${isCertRequired}"/>
			                                <input type="hidden" name="hdEnvlopTypFlg" value="${envelopeType}"/>
			                                <input type="hidden" name="hdPrevFormIds" value="${formIds ne '' ? formIds : 0}"/>
			                                <input type="hidden" name="hdRowCount" value="${fn:length(evaluateBiddersMap)}"/>
											<spring:message var="remarks" code="lbl_remark"/>
                                    		${tblTenderEnvelope.envelopeName}
                                    	</th>
                             		</tr>
                             		<tr>
                             			<th width="20%"><spring:message code='lbl_bidder_name'/></th>
                                        <th width="28%"><spring:message code='lbl_remark'/> <font size="1"><span class="mandatory red">*</span></font></th>
                                        <th width="28%"><spring:message code='col_action'/></th>
                             		</tr>
                         			<c:forEach items="${evaluateBiddersMap}" var="evaluateMap" varStatus="count">
                         			<c:choose>
                         				<c:when test="${evaluateMap.isApproved eq 0}">
                         					<tr>
		                                    	<td>
		                                        	<input type="hidden" name="hdAllValues_${count.index}" value="${evaluateMap.bidderIds}"/>
		                                            ${evaluateMap.companyName}
		                                        </td>
		                                        <td>
		                                        	<textarea class="form-control" disabled="disabled" id="txtaRemarks_${count.index}" name="txtaRemarks_${count.index}" tovalid="true" title="Remarks" class="line-height" cols="10" rows="2">Not Eligible</textarea></td>
		                                        <td>
		                                        	<input type="radio" name="rdBidderAprvYesNo_${count.index}" value="1" id="BidderAprv_${count.index}"  />Approve
		                                        	<input type="radio" name="rdBidderAprvYesNo_${count.index}" value="0" id="BidderRej_${count.index}" checked="checked" disabled="disabled"/>Reject
		                                        </td>
											</tr>
                         				</c:when>
                         				<c:otherwise>
											<tr>
		                                    	<td>
		                                        	<input type="hidden" name="hdAllValues_${count.index}" value="${evaluateMap.bidderIds}"/>
		                                            ${evaluateMap.companyName}
		                                        </td>
		                                        <td>
		                                        	<textarea class="form-control"  id="txtaRemarks_${count.index}" name="txtaRemarks_${count.index}" validarr="required@@length:0,10000" tovalid="true" onblur="validateTextComponent(this)" validationmsg="Allows Max. 10000 alphabets, numbers and special characters" value="${evaluateMap.remarks}"    title="${evaluateMap.companyName}'s <spring:message code='lbl_remark'/>" class="line-height" cols="10" rows="2"></textarea></td>
		                                        <td>
		                                        	<input type="radio" name="rdBidderAprvYesNo_${count.index}" value="1" id="BidderAprv_${count.index}"  checked="checked"/>Approve
		                                        	<input type="radio" name="rdBidderAprvYesNo_${count.index}" value="0" id="BidderRej_${count.index}" />Reject
		                                        </td>
											</tr>                         				
                         				</c:otherwise>
                         			</c:choose>
                         			</c:forEach>
                             		<tr>
                             			<td colspan="3"><button type="submit"  class="btn btn-submit">Submit</button></td>
                             		</tr>
								</table>
							</div>
							</form:form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</section>
	</div>
<script type="text/javascript">
	function validateChng(){
         	var vbool = valOnSubmit();
         	if(vbool){
           	 	$(":radio").attr('disabled',false);
           	 $("input[name^='txtaRemarks_']").removeAttr("disabled");
	        }
         	return disableBtn(vbool);
    }
   </script>     
   <%@include file="../../includes/footer.jsp"%>