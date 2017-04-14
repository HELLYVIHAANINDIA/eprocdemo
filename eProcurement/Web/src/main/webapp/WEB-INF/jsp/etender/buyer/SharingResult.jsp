<%@include file="../../includes/head.jsp"%>
<%@include file="../../includes/masterheader.jsp"%>

    
<div class="content-wrapper">
	<section class="content">
		<div class="row">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			<div class="box">
				<div class="box-header with-border">
				<spring:message code="lbl_back_dashboard" var='backDashboard'/>
				<div><a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}"><< ${backDashboard}</a></div>
					<h3 class="box-title">Result Sharing</h3>
				</div>
				<div class="box-body">
					<div class="row">
						<div class="col-lg-12 col-md-12 col-xs-12">
							<spring:url value="/etender/buyer/addtenderresultconfig" var="actionUrl"/>
							<form:form  name="frmRsltShare" onsubmit="return validate();" action="${actionUrl}" method="post">
								<c:choose>
									<c:when test="${opType eq 'update'}">
										<c:set value="${shareReportsData[0]}" var="shareReport"/>
										<c:set value="${shareReportsData[1]}" var="showResultBeforeLogin"/>
										<c:set value="${shareReportsData[2]}" var="showL1Report"/>
										<c:set value="${shareReportsData[3]}" var="showAbstractReport"/>
										<c:set value="${shareReportsData[4]}" var="shareBidderStatus"/>
										<c:set value="${shareReportsData[5]}" var="shareClarificationReport"/>
										<c:set value="${shareReportsData[6]}" var="shareEvaluationReport"/>
									</c:when>
									<c:when test="${opType ne 'view'}"><%-- For Configure case --%>
										<c:set value="2" var="shareReport"/>
										<c:set value="0" var="showResultBeforeLogin"/>
										<c:set value="0" var="showL1Report"/>
										<c:set value="0" var="showAbstractReport"/>
										<c:set value="4" var="shareBidderStatus"/>
										<c:set value="4" var="shareClarificationReport"/>
										<c:set value="4" var="shareEvaluationReport"/>
									</c:when>
								</c:choose>
									 <spring:message code="field_formName"          var="vformName"/>
					                    <spring:message code="lbl_envelopname"         var="vEnvName"/>
					                    <spring:message code="label_shre_rprt"         var="vShareReports"/>
	                    
                            <table  class="table table-striped table-responsive">
<!--                                 <tr> -->
<%-- 								                                        <th class="a-left"><label><spring:message code="field_view_rslt"/></label></th> --%>
<!-- 								                                        <td> -->
<%-- 								                                                <c:choose> --%>
<%-- 								                                                        <c:when test="${opType eq 'view'}">${showResultBeforeLogin}</c:when> --%>
<%-- 								                                                        <c:otherwise> --%>
<!-- 								                                                        	<select name="shareResult" id="shareResult"> -->
<!-- 										                                                     	<option value="">Select</option> -->
<!-- 											                                                    <option value="1">Yes</option> -->
<!-- 											                                                    <option value="0">No</option> -->
<!-- 										                                                 	</select> -->
<%-- 								                                                        </c:otherwise> --%>
<%-- 								                                                </c:choose> --%>
<!-- 								                                        </td> -->
<!-- 								                                	</tr> -->
								                                    <tr>
								                                        <th><label>Share L1 Report</label></th>
								                                        <td>
								                                                <c:choose>
								                                                        <c:when test="${opType eq 'view'}">${showL1Report}</c:when>
								                                                        <c:otherwise>
								                                                        	<select name="l1Reports" id="l1Reports">
										                                                     	<option value="">Select</option>
											                                                    <option value="1">Yes</option>
											                                                    <option value="0">No</option>
										                                                 	</select>
								                                                        </c:otherwise>
								                                                </c:choose>
								                                        </td>
								                                	</tr>
								                                	<tr>
								                                	<th >Share Reports with</th>
								                                	 <td>
                                                                        	<c:choose>
                                                                                    <c:when test="${opType eq 'view'}">${shareReport}
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                    	<c:forEach items="${chartListWith}" var="reportsWith" varStatus="counter">
                                                                                    		<input type="radio" value="${reportsWith}" name="rptwith">${reportsWith}
                                                                                    	</c:forEach>
                                                                                    </c:otherwise>
                                                                                 </c:choose>
                                                                        	
                                                                        </td>
                                                                      </tr>
                                    <c:set value="," var="formIds"/>
                                    <tr>
                                        <td colspan="2">
                                                <c:forEach items="${envelopeList}" var="envData" varStatus="srno">
                                                    <c:choose>
                                                        <c:when test="${not empty formDetalisList}">
                                                            <c:set value="0" var="tableEnd"/>
                                                            <c:forEach items="${formDetalisList}" var="tndrFormData" varStatus="cnt">
	                                             			<c:if test="${envData[0] eq tndrFormData[2]}">
                                                                 <div class="page-title prefix_1 o-hidden m-top1 border-left border-top border-right border-bottom-none">
                                                                     <h3>${envData[1]}</h3>
                                                                 </div>
                                                                 <table class="table">
                                                                 <tr class="table">
                                                                     <th >${vformName}</th>
                                                                     <th >${vShareReports}</th>
                                                                 </tr>
                                                                 
                                                                        <tr rowspan="2">
                                                                            <c:set value="1" var="tableEnd"/>
                                                                            <td>
                                                                                <c:set value="${formIds},${tndrFormData[0]}" var="formIds"/>
                                                                                ${tndrFormData[1]}
                                                                            </td>
                                                                            <td>
                                                                                <c:choose>
                                                                                    <c:when test="${opType eq 'update'}">
                                                                                            <c:forEach items="${formReportsData}" var="formReport" varStatus="no">
                                                                                                    <c:if test="${formReport[4] eq tndrFormData[0]}">
<%--                                                                                                     	<c:forEach items="${chartList}" var="chart"> --%>
                                                                                                    		<c:forEach items="${formChartList}" var="selectedChart">
<%--                                                                                                     			<c:if test="${fn:contains(selectedChart, '@@@')}"> --%>
<%--                                                                                                     				<c:forEach items="${fn:split(selectedChart, '@@@')}" var="rptName"> --%>
                                                                                                    				<c:choose>
                                                                                                    				<c:when test="${selectedChart eq 1}">
                                                                                                    				<input type="checkbox" checked="checked" value="Individual" name="reports_${tndrFormData[0]}">Individual
                                                                                                    				</c:when>
                                                                                                    					<c:when test="${selectedChart eq 2}">
                                                                                                    				<input type="checkbox" checked="checked" value="Comparative" name="reports_${tndrFormData[0]}">Comparative
                                                                                                    				</c:when>
                                                                                                    				<c:when test="${selectedChart eq 11}">
                                                                                                    				<input type="checkbox" value="Individual" name="reports_${tndrFormData[0]}">Individual
                                                                                                    				</c:when>
                                                                                                    					<c:when test="${selectedChart eq 22}">
                                                                                                    				<input type="checkbox" value="Comparative" name="reports_${tndrFormData[0]}">Comparative
                                                                                                    				</c:when>
                                                                                                    				<c:otherwise>
                                                                                                    					<input type="checkbox" value="${chart}" id="chk_${counter.index+1}">${chart}
                                                                                                    				</c:otherwise>
                                                                                                    				</c:choose>
<%--                                                                                                     				</c:forEach> --%>
<%--                                                                                                     			</c:if> --%>
                                                                                                    		</c:forEach>
<%--                                                                                                     	</c:forEach> --%>
                                                                                                    </c:if>
                                                                                            </c:forEach>
                                                                                    </c:when>
                                                                                    <c:when test="${opType eq 'view'}">
                                                                                            <c:forEach items="${formReportsData}" var="formReport" varStatus="no">
                                                                                                    <c:if test="${formReport[4] eq tndrFormData[0]}">
                                                                                                    	<c:if test="${formReport[0] eq 1 }">
                                                                                                    			Individual
                                                                                                    	</c:if>
                                                                                                    	<c:if test="${formReport[1] eq 1 }">
                                                                                                    			Comparative
                                                                                                    	</c:if>                                                                                                    </c:if>
                                                                                            </c:forEach>
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                    	<c:forEach items="${chartList}" var="reports" varStatus="counter">
                                                                                    			<input type="checkbox" value="${reports}" name="reports_${tndrFormData[0]}_${counter.index}">${reports}
                                                                                    			<c:set value="${counter.index}" var="shareReportCount"/>
                                                                                    	</c:forEach>
                                                                                    	<input type="hidden" name="hdShareReportCount" value="${shareReportCount}"/>
                                                                                    </c:otherwise>
                                                                            </c:choose>	
                                                                        </td>
                                                                    </tr>
                                                                    </table>
                                                                   </c:if>
	                                                 </c:forEach>
                                                        </c:when>
                                                </c:choose>
		                             </c:forEach>
                                    </tr>
                                    	
		                             <tr>
										<td class="a-center p-bottom-none" colspan="2">
                                        <input type="hidden" name="hdFormIds" value="${formIds}"/>
                                    	<input type="hidden" name="hdIsForOpening" value="1"/>
										<c:if test="${flag eq 1}"><%-- Only For Configure and Update Link not for View link --%>
														<input type="hidden" name="hdTenderId" value="${tenderId}"/>
														<c:choose>
															<c:when test="${opType eq 'update' }">
																<spring:message var="btnUpdate" code="btn_update" />
																<button class="btn btn-submit" type="submit" id="btnSubmit" name="Submit" >${btnUpdate}</button>
															</c:when>
															<c:otherwise>
																<spring:message var="btnSubmit" code="btn_submit" />
																<button class="btn btn-submit" type="submit" id="btnSubmit" name="Submit" >${btnSubmit}</button>	
															</c:otherwise>
														</c:choose>                                                              
										</c:if>	
										</td>                                
									</tr>
								</table>
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
	
	function validate(){
         	var vbool = valOnSubmit();
         	return disableBtn(vbool);
	return true;
    }
   </script>
   <script src="${pageContext.servletContext.contextPath}/resources/js/jquery-ui.min.js"></script>
   <%@include file="../../includes/footer.jsp"%>