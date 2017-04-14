<%@include file="../../includes/head.jsp"%>
<%@include file="../../includes/masterheader.jsp"%>
    <c:if test="${operation eq 1 or operation eq 2}">
            <script type="text/javascript" src="${pageContext.servletContext.contextPath}/resources/js/print/jquery.txt"></script>
            <spring:message code="title_tender_opening_individual_report" var="var_title"/>
         <spring:message code="lbl_view_consortium_detail" var="viewConsortDetail"/>

<div class="content-wrapper">
	<section class="content">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			<div class="box">
                <spring:message code="lbl_back_dashboard" var='backDashboard'/>
                 <!--***************Right Part Starts Form Here**********-->
                 <div class="box-header with-border">
					<div class="noExport pull-right">
	                        <c:choose>
	                        <c:when test="${userTypeId eq 2}">
	                             <a href="${pageContext.servletContext.contextPath}/etender/bidder/biddingtenderdashboardcontent/${tenderId}/7"><< ${backDashboard}</a>
	                        </c:when>	
	                        <c:otherwise>
	                            <div><a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}"><< ${backDashboard}</a> |
	                            <a href="${pageContext.servletContext.contextPath}/etender/buyer/gettabcontent/${tenderId}/${commiteeType}"><< <spring:message code="link_goback_tenderdashbord"/></a></div>                                                
	                        </c:otherwise>
	                        </c:choose>
	                </div>
					<h3 class="box-title">${var_title}</h3>
				</div>
		<div class="box-body">
		<div class="row" id="viewIndividualRptId">
			<div class="col-lg-12 col-md-12 col-xs-12">
				<div class="box-body pad">

                    <c:forEach items="${lstFormDtl}" var="obForm">
                       
                        <div class="page-title prefix_1 o-hidden border-top">
                            <h2 class="pull-left">${obForm.formName}</h2>
                            <c:if test="${obForm.isPriceBid eq 1}">
                            <h4 class="pull-right"><b>Base Currency : ${currncyName}</b></h4>
                            </c:if>
                         </div>
                       
                       <div class="clearfix border-bottom-none o-auto" id="scrolldata">
                             <table  class="table table-striped table-responsive">
	                            <c:if test="${obForm.formHeader ne '' && obForm.formHeader ne null}">
	                            <tr class="border-top-none border-bottom-none">
	                                <td class="form-hd-ft-clr table-header">
	                                    ${obForm.formHeader}
	                                </td>
	                            </tr>
	                            </c:if>
                            <tr>
                                <td class="no-padding">
                                    <c:forEach items="${lstCompanyDtl}" var="obCompany" varStatus="srno">   
                                        <div>
                                          	<h3><label class="black"><spring:message code="lbl_bidder_name"/>: </label>
                                        	<a target="_blank" href="${pageContext.servletContext.contextPath}/common/user/getuserstatus/${obCompany[1]}/1/0/1">${obCompany[5]}</a></h3>
                                        	<c:if test="${obForm.isPriceBid eq 1 and biddingType eq 2}">
                                        		<label class="pull-right"><b><spring:message code="lbl_bid_currency" /> ${obCompany[7]}</b></label>
                                        	</c:if>
                                        </div>
                                         <c:if test="${obForm.isPriceBid ne 1 and obForm.isDocumentReq eq 1}">
                                           <div><h4>
                                                <label class="black"><spring:message code="lbl_download"/> Document :</label>
                                                <c:set value="" var="docName"/>
												<c:set var="docNameNew" value=""/>
                                                <c:forEach items="${lstTenderBidderDocs}" var="TblBidderdocument" varStatus="counterDocs">
                                                  	<c:choose>
                                                  		<c:when test="${TblBidderdocument.bidderId eq obCompany[1] and obForm.formId eq TblBidderdocument.childId}">
                                                  			<c:set value="<a href='#'>${TblBidderdocument.fileName}</a>" var="docNameURL"/>
                                                  			<c:set value=" ${docName}${docNameURL}," var="docName"/>
                                                  		</c:when>
                                                  	</c:choose>
                                                </c:forEach>
                                                <c:set var="docNameLength" value="${fn:length(docName)}" />
                                                <c:set var="docNameNew" value="${fn:substring(docName, 0, docNameLength-1)}" />
                                                ${docNameNew}</h4>
                                            </div>
                                        </c:if>
                                        <c:set var="bidCnt" value="0"/>
                                            <c:forEach items="${lstFormBid}" var="obFormCompBid">
                                                <c:if test="${obForm.formId eq obFormCompBid[3] && obCompany[0] eq obFormCompBid[4]}">
                                                    <c:set var="bidCnt" value="${bidCnt + 1}"/>
                                                     <div class="clearfix">
                                                    <table class="table">
                                                           <c:forEach items="${lstTableDtl}" var="obTable">
                                                            <c:set var="isTotExist" value="0"/>
                                                            <c:set var="totalRows" value="${obTable.noOfRows}"/>
                                                            <c:if test="${obTable.tableHeader ne '' && obTable.tableHeader ne null}">
                                                                <tr>
                                                                    <td class="table-header" width="75%">
                                                                        ${obTable.tableHeader}
                                                                    </td>
                                                                </tr>
                                                            </c:if>
                                                            <tr>
                                                                <td class="no-padding" colspan="2">
                                                                    <%-- START : render table data --%>
                                                                     <div class="clearfix table-border border-bottom-none">
                                                                    <table class="table">
                                                                        <tr class="gradi border-top-none">
                                                                            <c:forEach items="${lstColumnDtl}" var="obColumn">
                                                                                <c:if test="${obColumn.tableid eq obTable.tableId}">
                                                                                	<c:if test="${obColumn.isShown ne 0}">
                                                                                		<th class="a-left">${obColumn.columnHeader}</th>
	                                                                                    <c:if test="${obColumn.formula ne null && fn:startsWith(obColumn.formula,'TOTAL')}">
	                                                                                        <c:set var="isTotExist" value="1"/>
	                                                                                        <c:set var="totalRows" value="${obTable.noOfRows - 1}"/>
	                                                                                    </c:if>
                                                                                	</c:if>
                                                                                    
                                                                                </c:if>
                                                                            </c:forEach>
                                                                               <%--Uploded Documents--%>
                                                                           
                                                                        </tr>
                                                                        <c:forEach begin="0" end="${totalRows-1}" var="rowId">
                                                                            <c:set var="isItemMaped" value="true"/>
                                                                            <c:if test="${isItemMaped}">
                                                                                <c:forEach items="${lstTableBid}" var="obTableBid" varStatus="obTableBidCounter">
                                                                                <c:if test="${obTableBid[2] eq obTable.tableId && obFormCompBid[0] eq obTableBid[0]}">
                                                                                <tr>
                                                                                <c:forEach items="${lstColumnDtl}" var="obColumn">
                                                                                <c:if test="${obColumn.tableid eq obTable.tableId}">
                                                                                
                                                                                		<c:if test="${obColumn.isShown ne 0}">
                                                                                            <c:choose>
                                                                                            <c:when test="${false and obColumn.filledBy eq 1}">
                                                                                            
                                                                                                <td class="a-left">
                                                                                                <c:forEach items="${lstCellDtl}" var="obCellDtl" varStatus="obCellDtlCounter">
                                                                                                <c:set var="rownum" value="${obCellDtlCounter.index}"/>
                                                                                                        <c:if test="${obCellDtl.tableId eq obTable.tableId && obCellDtl.columnId eq obColumn.columnId || obCellDtl.rowId eq rownum}">
                                                                                                            ${obCellDtl.cellValue} 
                                                                                                        </c:if>
                                                                                                </c:forEach>
                                                                                                </td>
                                                                                            </c:when>
                                                                                            <c:when test="${obColumn.filledBy eq 4}">
                                                                                                <td class="a-left">
                                                                                                <c:forEach items="${lstTenderProxyDtl}" var="obProxyDtl">
                                                                                                        <c:if test="${obProxyDtl[0] eq obTable.tableId && obProxyDtl[1] eq obColumn.columnId && obProxyDtl[3] eq rowId && obProxyDtl[4] eq obCompany[0]}">
                                                                                                            ${obProxyDtl[5]}
                                                                                                        </c:if>
                                                                                                </c:forEach>
                                                                                                    </td>
                                                                                            </c:when>
                                                                                            <c:otherwise>
                                                                                                <td class="a-left">
                                                                                                <c:set value="0" var="isBlank"></c:set>
                                                                                                <c:forEach items="${lstBidDtl}" var="obBidDtl">
                                                                                                    <c:if test="${obBidDtl.tableId eq obTable.tableId && obBidDtl.columnId eq obColumn.columnId && obBidDtl.bidId eq obFormCompBid[0] and obTableBid[1] eq obBidDtl.bidTableId and obBidDtl.filledby eq obColumn.filledBy and obBidDtl.rowId eq rowId}">
                                                                                                            <c:set value="${obBidDtl.cellValue}" var="obBidDtlAfterReverseReplace"></c:set>
                                                                                                     		<c:choose>
	                                                                                                     		<c:when test="${fn:contains(obBidDtlAfterReverseReplace, '###')}">
																											        <c:set var="subStringAfterSpeChar" value="${fn:substringAfter(obBidDtlAfterReverseReplace,'###')}"/>
																											        <c:set var="nextIndexSubStringAfterSpeChar" value="${fn:indexOf(subStringAfterSpeChar,'###')}"/>
																											        <c:set var="comboValue" value="${fn:substring(subStringAfterSpeChar,0,nextIndexSubStringAfterSpeChar)}"/>
																											        <c:set var="commentValue" value="${fn:substringAfter(subStringAfterSpeChar,'-')}"/>
		                                                                           										 ${comboValue} <c:if test="${commentValue ne null and commentValue ne ''}"> | ${commentValue}</c:if>
																											    </c:when>
																											    <c:otherwise>
																											    	${obBidDtlAfterReverseReplace}
																											    </c:otherwise>
																											</c:choose>
                                                                                                           
                                                                                                             <c:set value="1" var="isBlank"></c:set>
                                                                                                    </c:if>
                                                                                                </c:forEach>
                                                                                                <c:if test="${isBlank eq 0}">
                                                                                               		<label id="td_blank_${rowId}"></label>
                                                                                               	</c:if>
                                                                                                </td>
                                                                                            </c:otherwise>
                                                                                            </c:choose>
                                                                                           </c:if>
                                                                                      </c:if>         
                                                                                    </c:forEach>
                                                                                 </tr>
                                                                                    </c:if>
                                                                                </c:forEach>
                                                                            </c:if>
                                                                        </c:forEach>
                                                                        <tr id="trGT_${obTable.tableId}" tableId="${obTable.tableId}" >
                                                                        	<c:forEach items="${lstColumnDtl}" var="obColumn">
																				<c:if test="${obColumn.tableid eq obTable.tableId and obColumn.isGTColumn eq 1}">
																					<td>
																					<c:forEach items="${TenderCellGrandTotalList}" var="TenderCellGrandTotal" varStatus="counter">
																						<c:if test="${TenderCellGrandTotal.tblTenderTable.tableId eq obColumn.tableid}">
																						<c:choose>
																							<c:when test="${TenderCellGrandTotal.tblTenderColumn.columnId eq obColumn.columnId and obCompany[1] eq TenderCellGrandTotal.tblBidder.bidderId}">
																								<label id="lblGT_${obColumn.columnId}" colId="${obColumn.columnId}" TableId="${obColumn.tableid}">${TenderCellGrandTotal.GTValue} (Without rebate)</label>
																								<c:if test="${obColumn.filledBy eq 3}"><br/><div  width:100px;" id="lblGT_ToalAmTWords_${obColumn.columnId}_${obCompany[1]}_${obTable.tableId}">${TenderCellGrandTotal.GTValue}</div></c:if>
																									<c:forEach items="${TblTenderRebateList}" var="TblTenderRebate">
																										<c:if test="${TblTenderRebate.tblCompany.companyid eq obCompany[0]}">
																										<label>${TblTenderRebate.rebateValue} (After rebate)</label>
																										</c:if>
																									</c:forEach>
																							</c:when>
																						</c:choose>
																						</c:if>
																					</c:forEach>
																				</td>
																				</c:if>
																				<c:if test="${obColumn.tableid eq obTable.tableId and obColumn.isGTColumn eq 0}">
																					<td></td>
																				</c:if>
																			</c:forEach>
																		</tr>
                                                                            <c:if test="${isTotExist eq 1}">
                                                                            <tr>
                                                                            	<c:set var="isGrandTotalDone" value="false" />
                                                                                <c:forEach items="${lstColumnDtl}" var="obColumn">
                                                                                    <c:if test="${obColumn.tableid eq obTable.tableId}">
                                                                                    	<c:if test="${obColumn.isShown ne 0}">
	                                                                                        <c:set var="cellDtl" value=""/>
	                                                                                        <c:forEach items="${lstBidDtl}" var="obBidDtl">
	                                                                                            <c:if  test="${obBidDtl.tableId eq obTable.tableId && obBidDtl.bidId eq obFormCompBid[1] && obBidDtl.columnId eq obColumn.columnId && obBidDtl.rowId eq obTable.noOfRows}">
	                                                                                                <c:set var="cellDtl" value="${obBidDtl.cellValue}"/>
	                                                                                            </c:if>
	                                                                                        </c:forEach>
	                                                                                        <c:choose>
	                                                                                            <c:when test="${cellDtl ne ''}">
	                                                                                            	<c:choose>
	                                                                                            		<c:when test="${isGrandTotalDone eq 'false'}">
		                                                                                            		<td id="grandTotal" class="a-left">${cellDtl}</td>
		                                                                                            		<c:set var="isGrandTotalDone" value="true" />
	                                                                                            		</c:when>
	                                                                                            		<c:otherwise>
	                                                                                            			<td class="a-left">${cellDtl}</td>
	                                                                                            		</c:otherwise>
	                                                                                            	</c:choose>
	                                                                                            </c:when>
	                                                                                            <c:otherwise>
	                                                                                                <td>&nbsp;</td>
	                                                                                            </c:otherwise>
	                                                                                        </c:choose>
	                                                                                     </c:if>
                                                                                    </c:if>
                                                                                </c:forEach>
                                                                            </tr>
                                                                        </c:if>
                                                                    </table>
                                                                     </div>
                                                                    <%-- END : render table data --%>
                                                                </td>
                                                            </tr>
                                                             <c:if test="${obTable.tableFooter ne '' && obTable.tableFooter ne null}">
                                                            <tr class="border-bottom-none">
                                                                <td class="a-left table-header" colspan="2">${obTable.tableFooter}</td>
                                                            </tr>
                                                             </c:if>
                                                        </c:forEach>
                                                    </table>
                                                     </div>
                                                    <c:if test="${false && (obForm.showDocuments eq 1  || userTypeId ne 2) }">
                                                     <div class="clearfix table-border">
                                                         <table class="table">
                                                            <tr class="form-hd-ft-clr">
                                                            <th colspan="3" class="a-left black">
                                                                <spring:message code="head_tender_listoffilesuploaded"/>
                                                            </th>
                                                        </tr>
                                                        <tr class="gradi">
                                                            <th width="40%" class="a-left"><spring:message code="col_tender_fileanme"/></th>
                                                            <th width="40%" class="a-left"><spring:message code="lbl_description"/></th>
                                                            <th width="20%" class="a-left removedata"><spring:message code="lbl_download"/></th>
                                                        </tr>
                                                        <c:set var="isDocExist" value="0"/>
                                                        <c:if test="${isDocExist eq 0}">
                                                            <tr>
                                                                <td colspan="3" class="a-center">
                                                                    <spring:message code="lable_tender_nofilefound"/>
                                                                </td>
                                                            </tr>
                                                        </c:if>
                                                    </table>
                                                    </div>
                                                        <div class="border-top"></div>
                                                    </c:if>
                                                </c:if>
                                            </c:forEach>
                                        </c:forEach>
                                </td>
                            </tr>
                             <c:if test="${obForm.formFooter ne '' && obForm.formFooter ne null}">
                            <tr class="border-bottom-none border-top-none">
                                <td class="form-hd-ft-clr table-header">
                                    ${obForm.formFooter}
                                </td>
                            </tr>
                             </c:if>
                        </table>
                       </div>
                    </c:forEach>
                    </div>   
                 </div>
                </div>  
                <div class="row"> 
                    <c:set var="role" value="buyer"/>
                    <c:if test="${userTypeId eq 2}">
                        <c:set var="role" value="bidder"/>
                    </c:if>
                    <spring:message code="label_saveaspdf" var="saveAsPDF"/> 
                    <spring:message code="link_print" var="print"/>
                    <table class="table">
                    <tr class="border-bottom-none">
                        <td class="a-left no-padding">
                            <input type="button" class="btn noExport" onclick="exportContent('viewIndividualRptId','IndividualReport${tenderId}',0)" value="PDF">
							<input type="button" class="btn noExport" onclick="exportContent('viewIndividualRptId','IndividualReport${tenderId}',5)" value="${print}">
<%--                             <c:choose>
		                        <c:when test="${userTypeId eq 2}">
		                             <a href="${pageContext.servletContext.contextPath}/etender/bidder/biddingtenderdashboardcontent/${tenderId}/7"><< ${backDashboard}</a>
		                        </c:when>
		                        <c:otherwise>
		                            <div><a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}"><< ${backDashboard}</a></div>                                                
		                        </c:otherwise>
	                        </c:choose> --%>
                            
                        </td>
                    </tr>
                     </table>
                     </div>
</div>
</div>
</div>
                </section>   
                <!--***********Right Part Ends here***********-->
            </div>
    </c:if>
<script src="${pageContext.request.contextPath}/resources/js/tender/ConvertToWord.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		if('${tenderResult}' == 1){
			$('td[id*=grandTotal]').each(function(i){
				$(this).prev().html('<b><spring:message code="label_grandtotal"/></b>');
			});
			$('[id^="lblGT_ToalAmTWords_"]').each(function () {
				this.innerHTML = DoIt(this.innerHTML);
			});
		}     
	});
	
</script>
<%@include file="../../includes/footer.jsp"%>