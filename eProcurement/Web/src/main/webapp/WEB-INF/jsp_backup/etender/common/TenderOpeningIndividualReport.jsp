<!DOCTYPE html>
<html>
<%@include file="../../includes/header.jsp"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script type="text/javascript" src="${pageContext.servletContext.contextPath}/resources/js/tender/ConvertToWord.js"></script>
    <c:if test="${operation eq 1 or operation eq 2}">
            <script type="text/javascript" src="${pageContext.servletContext.contextPath}/resources/js/print/jquery.txt"></script>
            <spring:message code="title_tender_opening_individual_report" var="var_title"/>
         <spring:message code="lbl_view_consortium_detail" var="viewConsortDetail"/>
</head>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="../../includes/leftaccordion.jsp"%>

<div class="content-wrapper">

		<section class="content-header"> <spring:message
			code="lbl_back_dashboard" var='backDashboard' /> <span
			class="noprint"> <c:choose>
				<c:when test="${userTypeId eq 2}">
					<a
						href="${pageContext.servletContext.contextPath}/etender/bidder/biddingtenderdashboardcontent/${tenderId}/7"
						class="btn btn-submit"><< ${backDashboard}</a>
				</c:when>
				<c:otherwise>
					<div>
						<a
							href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}"
							class="btn btn-submit"><< ${backDashboard}</a> <a
							href="${pageContext.servletContext.contextPath}/etender/buyer/gettabcontent/${tenderId}/${commiteeType}"
							class="btn btn-submit"><< Go back</a>
					</div>
				</c:otherwise>
			</c:choose> </span> 
		</section>

		<section class="content">
		<div class="row">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			<div class="box">
                
                
                 <!--***************Right Part Starts Form Here**********-->
				<div class="box-header with-border">
					<h2 class="box-title">${var_title}</h2>
				</div>
<div class="box-body">
		<div class="row">
			<div class="col-lg-12 col-md-12 col-xs-12">
				<div class="box-body pad">

                    <c:forEach items="${lstFormDtl}" var="obForm">
                       
                        <div class="page-title prefix_1 o-hidden border-top">
                            <h2 class="pull-left" style="font-size: 18px;">${obForm.formName}</h2>
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
                                        <div class='a-left <c:if test="${srno.count eq 1}">border-top-none</c:if><c:if test="${srno.count ne 1}">m-top1</c:if>'>  
                                            <table class="table">
                                                <tr>
                                                    <td class="a-right">
                                                        <!--<h2 class="pull-left">-->
                                                        <span class="black"><spring:message code="lbl_bidder_name"/>:</span>
                                                         <c:choose>
                                                                <c:when test="${tblTender.isEncodedName eq 0 && userTypeId ne 2}">
                                                                    <spring:message code="lbl_bidder_profile" var="viewProfile" />
                                                                    <spring:url value="/common/admin/viewbidderprofile/${obCompany[1]}" var="urlView"/>
                                                                    <a href="${urlView}">${obCompany[5]}</a>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    ${obCompany[5]}
                                                                </c:otherwise>
                                                            </c:choose>
                                                            <c:if test="${userTypeId ne 2 && tblTender.isConsortiumAllowed eq 1 && obForm.isPriceBid ne 1  && obCompany[6] ne 1}">
                                                                |
                                                                <spring:url value="/etender/common/viewconsortium/${tenderId}/${obCompany[4]}" var="urlConsortDetail"/>
                                                                 <a href="${urlConsortDetailv}">${viewConsortDetail}</a>
                                                            </c:if>
                                                                
                                                        <!--</h2>-->
                                                    </td>
                                                </tr>
                                            </table>
                                            
                                        </div>
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
																	<%-- Bug #19634 Start--%>
<%--                                                                     <c:if test="${obForm.isMultipleFilling ne 0}"> --%>
<!--                                                                     	<td width="25%" class="border-left-none a-right"> -->
<%--                                                                        	<span class="black v-a-middle"><spring:message code="lbl_tender_bidsubcount"/>:</span>${bidCnt} --%>
                                                                    	
<!--                                                                     	</td> -->
<%--                                                                    	</c:if> --%>
                                                                   	<%-- Bug #19634 End--%>
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
                                                                            <c:if test="${false and obForm.isPriceBid ne 1}">
                                                                          
                                                                            	<th  class="a-left" >
                                                                            	 <div id="lbl_downloadth" >
                                                                            	  <div id="lbl_downloadth_1" >
                                                                            	  	<spring:message code="lbl_download"/>
                                                                            	   </div>
                                                                            	   </div>
                                                                            	  </th>
                                                                          
                                                                            </c:if>
                                                                        </tr>
                                                                         <%-- Set JS Variable to Not remove lbl_download th --%>
<!--                                                                         <script type="text/javascript"> -->
<!--                                                                				lbl_download = 1; -->
<!--                                                               			</script> -->
                                                                        <c:forEach begin="0" end="${totalRows-1}" var="rowId">
                                                                            <c:set var="isItemMaped" value="true"/>
<%--                                                                             <c:if test="${tenderMode eq '2' && tenderResult eq 2 && obForm.isPriceBid eq 1}"> --%>
<%--                                                                                 <c:set var="isItemMaped" value="false"/> --%>
<%--                                                                                 <c:forEach items="${lstItemWiseBidderMapDtl}" var="obItemMap"> --%>
<%--                                                                                 	<c:if test="${obItemMap[2] eq obTable.tableId && obItemMap[0] eq obCompany[0]}"> --%>
<%--                                                                                           <c:set var="isItemMaped" value="true"/> --%>
<%--                                                                                     </c:if> --%>
<%--                                                                                 </c:forEach> --%>
<%--                                                                             </c:if> --%>
                                                                            
                                                                            <c:if test="${isItemMaped}">
                                                                                <c:forEach items="${lstTableBid}" var="obTableBid" >
                                                                                <c:if test="${obTableBid[2] eq obTable.tableId && obFormCompBid[0] eq obTableBid[0]}">
                                                                                <tr>
                                                                                <c:forEach items="${lstColumnDtl}" var="obColumn">
                                                                                <c:if test="${obColumn.tableid eq obTable.tableId}">
                                                                                
                                                                                		<c:if test="${obColumn.isShown ne 0}">
                                                                                		
                                                                                            <c:choose>
                                                                                            <c:when test="${false and obColumn.filledBy eq 1}">
                                                                                            
                                                                                                <td class="a-left">
                                                                                                <c:forEach items="${lstCellDtl}" var="obCellDtl" varStatus="obTableBidCounter">
                                                                                                <c:set var="rownum" value="${obTableBidCounter.index}"/>
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
<%--                                                                                                 ${obBidDtl.columnId} eq ${ obColumn.columnId} --%>
                                                                                                    <c:if test="${obBidDtl.tableId eq obTable.tableId && obBidDtl.columnId eq obColumn.columnId && obBidDtl.bidId eq obFormCompBid[0] and obTableBid[1] eq obBidDtl.bidTableId and obBidDtl.filledby eq obColumn.filledBy and obBidDtl.rowId eq rowId}">
                                                                                                            <c:set value="${obBidDtl.cellValue}" var="obBidDtlAfterReverseReplace"></c:set>
                                                                                                     		<c:choose>
	                                                                                                     		<c:when test="${fn:contains(obBidDtlAfterReverseReplace, '###')}">
																											        <c:set var="subStringAfterSpeChar" value="${fn:substringAfter(obBidDtlAfterReverseReplace,'###')}"/>
																											        <c:set var="nextIndexSubStringAfterSpeChar" value="${fn:indexOf(subStringAfterSpeChar,'###')}"/>
																											        <c:set var="comboValue" value="${fn:substring(subStringAfterSpeChar,0,nextIndexSubStringAfterSpeChar)}"/>
																											        <c:set var="commentValue" value="${fn:substringAfter(subStringAfterSpeChar,'-')}"/>
																											        <!-- Start: Bug Id :25775 -->
		                                                                           										 ${comboValue} <c:if test="${commentValue ne null and commentValue ne ''}"> | ${commentValue}</c:if>
		                                                                           									<!-- End: Bug Id :25775 -->
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
<%--                                                                                     <c:if test="${obForm.isPriceBid ne 1}"> --%>
	                                                                                     <%--start Bug #20982 Document download link in Abstract report --%>
<!--                                                               <td> -->
<!--                                                                <div id="lbl_downloadtd" > -->
<!--                                                                             	  <div id="lbl_downloadtd_1" > -->
                                                             		<%-- <c:forEach items="${lstBidDtl}" var="obBidDtl"> --%>
<%--                                                              		<c:set var="totalDocs"  value="1"/> --%>
<%--                                                              		<c:forEach items="${listItemWiseBidderDocDtl}" var="listItemWiseBidderDoc" varStatus="cnt"> --%>
                                                             			<%-- ${obTable.tableId}--${listItemWiseBidderDoc.tableId}*****  ${listItemWiseBidderDoc.rowId}---${obBidDtl.rowId}--%>
<%--                                                              			<c:if test="${obTable.tableId eq listItemWiseBidderDoc[0] and listItemWiseBidderDoc[1] eq rowId and obCompany[0] eq listItemWiseBidderDoc[8] and listItemWiseBidderDoc[9] eq obTableBid.bidTableId}"> --%>
<%--                                                                                   <c:if test="${totalDocs ne 1}">,</c:if><c:set var="totalDocs"  value="${totalDocs+1}"/> --%>
<%--                                                                                   <spring:url value="/ajax/downloadbriefcasefile/${listItemWiseBidderDoc[2]}/${listItemWiseBidderDoc[9]}" var="urlItemWiseDoc"/> --%>
<%--                                                                                   <a href="${urlItemWiseDoc}">${listItemWiseBidderDoc[5]}</a> --%>
                                                             			<%-- Set JS Variable to remove lbl_download th --%>
                                                             			
<!--                                                              			<script type="text/javascript"> -->
<!-- //                                                              			lbl_download = 0; -->
<!--                                                              			</script> -->
<%--                                                              			</c:if> --%>
<%--                                                              		</c:forEach> --%>
<%--                                                              		<c:if test="${totalDocs eq 1 }"> --%>
<!--                                                              			- -->
<%--                                                              		</c:if> --%>
                                                             		
                                                              	<%-- </c:forEach> --%>
<!--                                                               	</div> -->
<!--                                                              		</div> -->
<!--                                                               </td> -->
                                                              <%--end Bug #20982 Document download link in Abstract report --%>
<%--                                                                                     </c:if> --%>
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
																								<label id="lblGT_${obColumn.columnId}" colId="${obColumn.columnId}" TableId="${obColumn.tableid}">${TenderCellGrandTotal.GTValue}</label>
																								<c:if test="${obColumn.filledBy eq 3}"><br/><div style="word-wrap: break-word; width:100px;" id="lblGT_ToalAmTWords_${obColumn.columnId}_${obCompany[1]}_${obTable.tableId}">${TenderCellGrandTotal.GTValue}</div></c:if>
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
                                                    <c:if test="${obForm.showDocuments eq 1  || userTypeId ne 2 }">
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
<%--                                                         <c:forEach items="${lstDocumentDtl}" var="obDoc"> --%>
<%--                                                             <c:if test="${obDoc.formId eq obFormCompBid.formId && obDoc.bidderId eq obFormCompBid.bidderId && obFormCompBid.bidId eq obDoc.bidId}"> --%>
<%--                                                                 <c:set var="isDocExist" value="1"/> --%>
<!--                                                                 <tr> -->
<!--                                                                     <td class="a-left"> -->
<%--                                                                         ${obDoc.docName} --%>
<!--                                                                     </td> -->
<!--                                                                     <td class="a-left"> -->
<%--                                                                         ${obDoc.description} --%>
<!--                                                                     </td> -->
<!--                                                                     <td class="a-left removedata"> -->
<%--                                                                     	<spring:url value="/ajax/downloadbidderfile/${obDoc.bidderDocMappingId}/${tenderId}" var="urlDownload"/> --%>
<%--                                                                     	<a href="${urlDownload}">Download</a> --%>
<!--                                                                     </td> -->
<!--                                                                 </tr> -->
<%--                                                             </c:if> --%>
<%--                                                         </c:forEach> --%>
                                                        <c:if test="${isDocExist eq 0}">
                                                            <tr>
                                                                <td colspan="3" class="a-center">
                                                                    <spring:message code="lable_tender_nofilefound"/>
                                                                </td>
                                                            </tr>
                                                        </c:if>
                                                    </table>
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
                    <spring:message code="link_saveasexcel" var="lnksaveasexcel"/>
                    <spring:message code="link_saveasword" var="lnksaveasword"/>
                    <spring:message code="link_saveashtml" var="lnksaveashtml"/>
                    <div class="col-md-12">
                    <tr class="border-bottom-none">
                        <td class="a-left no-padding">
                            <a title="${lnksaveashtml}" class="prefix1_1 html-icn" href="javascript:void(0);" onclick="exportToHTML('dataDiv','TenderIndividualReport_${tenderId}')"></a>
                            <a title="${lnksaveasword}" class="prefix1_1 word-icn" href="javascript:void(0);" onclick="exportToWord('dataDiv','TenderIndividualReport_${tenderId}')">
                            <a title="${lnksaveasexcel}" class="prefix1_1 exel-icn" href="javascript:void(0);" onclick="exportToExcel('dataDiv','TenderIndividualReport_${tenderId}')">
                            <a class="pdf-icn prefix1_1" title="${saveAsPDF}" href="javascript:void(0);" onclick="exportToPDF('dataDiv','TenderIndividualReport_${tenderId}','scrolldata')"></a>
                            <a class="print-icn prefix1_1" title="${print}" href="javascript:void(0);" onclick="printData();"></a>
                            <c:choose>
		                        <c:when test="${userTypeId eq 2}">
		                             <a href="${pageContext.servletContext.contextPath}/etender/bidder/biddingtenderdashboardcontent/${tenderId}/7" class="btn btn-submit"><< ${backDashboard}</a>
		                        </c:when>
		                        <c:otherwise>
		                            <div><a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}" class="btn btn-submit"><< ${backDashboard}</a></div>                                                
		                        </c:otherwise>
	                        </c:choose>
                            
                        </td>
                    </tr>
                     </div>
                     </div>
</div>
</div>
</div>
</div>
                </section>   
                <!--***********Right Part Ends here***********-->
            </div>
    </c:if>
</div>
<script type="text/javascript">
if('${tenderResult}' == 1){
	$(document).ready(function(){
		$('td[id*=grandTotal]').each(function(i){
			$(this).prev().html('<b><spring:message code="label_grandtotal"/></b>');
		});
	});
	$('[id^="lblGT_ToalAmTWords_"]').each(function () {
		this.innerHTML = DoIt(this.innerHTML);
	});
}
/* if(lbl_download){
	$(document).ready(function(){
		$('div[id*=lbl_downloadth]').each(function(i){
			$(this).parent().remove();
		});
	});  
	$(document).ready(function(){
		$('div[id*=lbl_downloadtd]').each(function(i){
			$(this).parent().remove();
		});
	});
} */         
</script>

</body>

</html>