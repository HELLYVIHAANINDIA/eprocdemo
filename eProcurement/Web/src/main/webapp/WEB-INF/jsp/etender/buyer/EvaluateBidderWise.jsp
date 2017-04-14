<%@include file="../../includes/head.jsp"%>
<%@include file="../../includes/masterheader.jsp"%>

<spring:message code="lbl_back_dashboard" var='backDashboard'/>        
     

<spring:message code="label_bidder_eligible" var="vEligible"/>
<spring:message code="label_bidder_not_eligible" var="vNotEligible"/>   

<div class="content-wrapper">
	<section class="content">
		<div class="row">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			<div class="box">
				<div class="box-header with-border">
					<div><a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}"><< ${backDashboard}</a></div>
				</div>
				<div class="box-header with-border">
					<h3 class="box-title"><spring:message code="tender_evaluation_title"></spring:message></h3>
				</div>
				<div class="box-body">
					<div class="row">
						<div class="col-lg-12 col-md-12 col-xs-12">
                             <table  class="table table-striped table-responsive">
                                    <tr class="border-top-none">
                                        <td>
                                            <h4 class="pull-left"><span class="black"><spring:message code="col_tender_company"/>:</span>
                                         		<a href="#">${CompanyDetls.companyname}</a>
                                            </h4>
                                        </td>
                                </tr>
                           </table>
                           <spring:url value="/etender/buyer/saveBidderWiseEvaluation" var="postUrl" />

                           <form:form action="${postUrl}" method="post" onsubmit="return validateForm()">
                           <input type="hidden" name="hdTenderId" value="${tenderId}"/>
                           <input type="hidden" name="hdEnvelopeId" value="${envelopeId}"/>
                           <input type="hidden" name="hdBidderId" value="${bidderId}"/>
                           <input type="hidden" name="hdCommitteeType" value="2"/>
                           <input type="hidden" name="hdCompanyId" value="${companyId}"/>

                           <spring:message code='link_download' var="download"/>
                           <c:set var="TotalRow" value="0"/> 
                                <c:choose>
									<c:when test="${not empty formAndTableDetalisList and isItemwiseWinner eq 1}">
										 <c:set var="isFrmIdPrint" value=""/>
										 <c:forEach items="${formAndTableDetalisList}" var="FormLst">
										 	<c:if test="${not fn:contains(isFrmIdPrint,FormLst[0])}">
											 	<c:set var="isFrmIdPrint" value="${isFrmIdPrint}'~'${FormLst[0]}"/>
											 	<div class="page-title prefix_1 o-hidden">
											 		<h3 style="width: 60%;" class="pull-left grid_21">${FormLst[3]}</h3>
										 			<c:if test="${FormLst[6] eq 0}">
										 				<span class="pull-right" style="padding-right: 10px;">
										 					<spring:message code="lbl_title_bid" var="viewBid"/>
                                        						 ${viewBid} : <a href="#">${CompanyDetls.companyName}</a>
										 				</span>
										 			</c:if>
			                                	</div>
			                                </c:if>
			                                	<c:set var="isFirstTableForPriceBidNo" value="false"/>
	                           					<c:forEach items="${formAndTableDetalisList}" var="FormLstForTable" varStatus="j">
	                           						<c:if test="${FormLstForTable[5] ne '' && FormLstForTable[5] ne null}">
	                           							<c:if test="${FormLstForTable[4] eq FormLst[4] && FormLst[0] eq FormLstForTable[0]}">
	                           								<c:if test="${FormLst[6] eq 1}">
	                           								<div class="col-lg-12 col-md-12 col-xs-12">
			                                                    <table  class="table table-striped table-responsive">
			                                                        <tr class="border-top-none">
			                                                            <td class="table-header">${FormLstForTable[5]}</td>
			                                                        </tr>
			                                                    </table>
		                                                	</div>
	                           								</c:if> 
                                                	 		<%-- START : render table data --%>
		                                             		<div class="col-lg-12 col-md-12 col-xs-12">
		                                              			<table  class="table ">
		                                                  			<tr class="gradi">
		                                                  				<c:if test="${FormLst[6] eq 1}">
		                                                  				<c:forEach items="${ListColumDtls}" var="listColumDtls">
				                                                          <c:if test="${listColumDtls[1] eq FormLstForTable[4]}">
				                                                              <th class="gradi a-left border-top-none" width="10%">${listColumDtls[3]}</th>
				                                                          </c:if>
		                                                     			</c:forEach>
		                                                     			<th class="gradi border-top-none" ><spring:message code='th_tender_action'/></th>
		                                                     			</c:if>
		                                                  			</tr>
		                                                  			<c:if test="${FormLst[6] eq 1}">
		                                                  			<c:forEach items="${ListCellDtls}" var="listCellDtls">
														        	<c:if test="${listCellDtls.key eq FormLstForTable[4]}"> 
														        		<c:forEach items="${listCellDtls.value}" var="rowList" varStatus="counter">
														        			
														        			<c:set var="allData" value="${tenderId}_${FormLst[0]}_${FormLstForTable[4]}"/>
														        			<c:set var="rowIdd" value="0"/>
														        			<tr>
														        				<c:set var="string2" value="${fn:substring(tenderId, 0, 2)}" />
														        				<c:set var="flagRemaks" value="0" />
														        				 <c:forEach items="${rowList}" var="rowData">
														        				 	<c:set var="allData" value="${tenderId}_${FormLst[0]}_${FormLstForTable[4]}_${rowData.key}"/>
														        				 	<c:set var="rowIdd" value="${rowData.key}"/>
														        				 	<input type="hidden" name="hdAllValues_${TotalRow}" value="${allData}"/>
														        				 		<c:forEach items="${rowData.value}" var="cellData" varStatus="count">
															        				 	 	<td class="a-left">${cellData}</td>
														        						</c:forEach>
														        				</c:forEach>
														        				<td>
														        					<div class="col-lg-12 col-md-12 col-xs-12">
														        					<table  class="table">
														        						<tr class="gradi">
			                                                  								<th><spring:message code='lbl_remark'/> <font size="1"><span class="mandatory red">*</span></font></th>
			                                                  								<th><spring:message code='col_action'/></th>
		                                                  								</tr>
																							<tr>
																									
																									<c:choose>
																										<c:when test="${ rejectFlag eq 'y'}">
																										<td class="a-left">
																										<textarea class="form-control"  id="txtaRemarks_${allData}" name="txtaRemarks_${allData}" disabled="disabled" validarr="required@@length:0,10000" tovalid="true" onblur="validateTextComponent(this)" validationmsg="Allows Max. 10000 alphabets, numbers and special characters" title="Remarks" class="line-height" cols="10" rows="2">AutoReject</textarea>
																									</td>
																											<td>
															                                        	<input type="radio" name="rdBidderAprvYesNo_${allData}" value="1" id="BidderAprv_${counter.count}"  disabled="disabled" />Approve
															                                        	<input type="radio" name="rdBidderAprvYesNo_${allData}" value="0" id="BidderRej_${counter.count}"  checked="checked"/>Reject
															                                        </td>
																										</c:when>
																										<c:otherwise>
																										<td class="a-left">
																										<textarea class="form-control"  id="txtaRemarks_${allData}" name="txtaRemarks_${allData}" validarr="required@@length:0,10000" tovalid="true" onblur="validateTextComponent(this)" validationmsg="Allows Max. 10000 alphabets, numbers and special characters" value="${evaluateMap.remarks}" title="Remarks" class="line-height" cols="10" rows="2"></textarea>
																									</td>
																											<td>
															                                        	<input type="radio" name="rdBidderAprvYesNo_${allData}" value="1" id="BidderAprv_${counter.count}"   checked="checked"/>Approve
															                                        	<input type="radio" name="rdBidderAprvYesNo_${allData}" value="0" id="BidderRej_${counter.count}"/>Reject
															                                        </td>
																										</c:otherwise>
																									</c:choose>
																									
																							</tr>
 														        					</table>
														        					</div>
														        				</td>
														        				<c:set var="TotalRow" value="${TotalRow+1}"/> 
														        			</tr>
														        		</c:forEach>
																	</c:if>
																	</c:forEach>
																	</c:if>
																	<c:if test="${isView eq false }">
																	<tr>
																	<td colspan="3"><button type="submit"  class="btn btn-submit">Submit</button></td>
																	</tr>
																	</c:if>
		                                                  		</table>
		                                                  	</div>
                                                  	</c:if>
                                                  </c:if>
	                           					</c:forEach> 
                           				</c:forEach>
									</c:when>
								</c:choose>
                         	  <input type="hidden" name="hdRowCount" value="${TotalRow}"/>
                         	  <input type="hidden" name="hdRejectFlag" value="${rejectFlag}"/>
                         	  
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
        function validateForm(){
        	$("#txtDocDesc").removeAttr("tovalid");
            var vbool = valOnSubmit();
            return disableBtn(vbool);
        }
       
        </script>
         <style>
            label.placeholder {
		cursor: text;				
		padding: 4px 4px 4px 0px;   
	}
        </style>
        <%@include file="../../includes/footer.jsp"%>