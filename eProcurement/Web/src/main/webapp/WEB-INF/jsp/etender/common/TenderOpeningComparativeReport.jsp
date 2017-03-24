<!DOCTYPE html>
<html>
<%@include file="../../includes/header.jsp"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script type="text/javascript" src="${pageContext.servletContext.contextPath}/resources/js/tender/ConvertToWord.js"></script>
    <c:if test="${operation eq 1 or operation eq 2}">
            <script type="text/javascript" src="${pageContext.servletContext.contextPath}/resources/js/print/jquery.txt"></script>
            <spring:message code="title_tender_opening_comparative_report" var="var_title"/>
         <spring:message code="lbl_view_consortium_detail" var="viewConsortDetail"/>
</head>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="../../includes/leftaccordion.jsp"%>

<div class="content-wrapper">

		<section class="content-header"> <spring:message
			code="lbl_back_dashboard" var='backDashboard' /> 
			<span class="noprint"> <c:choose>
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
			</c:choose> 
			</span> 
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
										<table class="table table-striped table-responsive">
											<c:if
												test="${obForm.formHeader ne '' && obForm.formHeader ne null}">
												<tr class="border-top-none border-bottom-none">
													<td class="form-hd-ft-clr table-header">
														${obForm.formHeader}</td>
												</tr>
											</c:if>
											<c:forEach items="${lstTableDtl}" var="obTable">
												<c:set var="isTotExist" value="0" />
												<c:if
													test="${obTable.tableHeader ne '' && obTable.tableHeader ne null}">
													<tr>
														<td class="table-header border-top-none">${obTable.tableHeader}</td>
													</tr>
												</c:if>

												<tr>
													<td><c:set var="fillOtherCount" value="0" />
														<div class="clearfix">
															<table class="table">
																<tr>
																	<c:forEach items="${lstColumnDtl}" var="obColumn">
																		<c:if test="${obColumn.tableid eq obTable.tableId}">
																			<c:if
																				test="${obColumn.filledBy ne 1 && companyName ne ''}">
																				<th></th>
																				<c:set var="companyName" value="" />
																			</c:if>
																			<c:if test="${obColumn.filledBy eq 1}">
																				<th class="a-left">${obColumn.columnHeader}</th>
																			</c:if>
																			<c:if
																				test="${obColumn.formula ne null && fn:startsWith(obColumn.formula,'TOTAL')}">
																				<c:set var="isTotExist" value="1" />
																			</c:if>
																			<c:if
																				test="${obColumn.filledBy ne 1 and obColumn.isShown ne 0}">
																				<c:set var="fillOtherCount"
																					value="${fillOtherCount+1}" />
																			</c:if>
																		</c:if>
																	</c:forEach>
																</tr>
																<c:set var="cmpNameCount"
																	value="${fn:length(lstCompanyDtl)}" />
																<c:forEach begin="0" end="${obTable.noOfRows-1}"
																	var="rowId">
																	<c:set var="isGrandTotalDone" value="false" />
																	<c:set var="isLastRow" value="false" />
																	<tr>
																		<c:set var="compPrinted" value="0" />
																		<c:set var="fillByCount" value="0" />
																		<c:forEach items="${lstColumnDtl}" var="obColumn">
																			<c:if test="${obColumn.tableid eq obTable.tableId}">
																				<c:forEach items="${lstCellDtl}" var="obCellDtl">
																					<c:if
																						test="${obCellDtl.rowId eq rowId && obCellDtl.tableId eq obTable.tableId && obColumn.columnId eq obCellDtl.columnId}">
																						<c:choose>
																							<c:when test="${obColumn.filledBy eq 1}">
																								<td class="a-left">${empty
																									obCellDtl.cellValue ? '-' :
																									obCellDtl.cellValue}</td>
																								<c:if test="${empty obCellDtl.cellValue}">
																									<c:set var="isLastRow" value="true" />
																								</c:if>
																							</c:when>
																							<c:otherwise>
																								<c:if test="${fillByCount eq 0}">
																									<c:choose>
																										<c:when
																											test="${isGrandTotalDone eq 'false' && isLastRow eq 'true'}">
																											<c:set var="isGrandTotalDone" value="true" />
																											<td id="grandTotal">
																										</c:when>
																										<c:otherwise>
																											<td>
																										</c:otherwise>
																									</c:choose>
																									<table class="table">
																										<%-- heading row start --%>
																										<tr>
																											<spring:message code="lbl_bidder_name"
																												var="companyName" />
																											<c:if
																												test="${obColumn.tableid eq obTable.tableId and companyName ne ''}">
																												<th class="a-left" width="40%">Bidder's
																													name</th>
																												<c:set var="companyName" value="" />
																											</c:if>
																											<c:forEach items="${lstColumnDtl}"
																												var="obColumn1">
																												<c:if
																													test="${obColumn1.filledBy ne 1 and obColumn1.tableid eq obTable.tableId}">
																													<c:if test="${obColumn1.isShown ne 0}">
																														<th class="a-left"
																															width="${60 / fillOtherCount}%">${obColumn1.columnHeader}</th>
																													</c:if>
																												</c:if>
																												<c:if
																													test="${obColumn1.formula ne null && fn:startsWith(obColumn1.formula,'TOTAL')}">
																													<c:set var="isTotExist" value="1" />
																												</c:if>
																											</c:forEach>
																										</tr>
																										<%-- heading row end --%>

																										<%-- start of render td data --%>
																										<%--                                                                                         <c:choose> --%>
																										<%--                                                                                                 <c:when test="${obTable.isMultipleFilling eq 1 or obForm.isMultipleFilling eq 1}">if multiple fill than tablebid wise loop will be execute --%>
																										<%--                                                                                                     <c:forEach items="${lstCompanyDtl}" var="obCompany" begin="0" end="${cmpNameCount}" varStatus="cmpSrNo"> --%>
																										<%--                                                                                                         <c:forEach items="${lstBidDtl}" var="obBidDtl" varStatus="srno"> --%>
																										<%--                                                                                                             <c:set var="bidderExist" value="0"/> --%>
																										<%--                                                                                                             <c:if test="${obCompany[1] eq obBidDtl.bidderId}"> --%>
																										<%--                                                                                                                 <c:set var="bidderExist" value="1"/> --%>
																										<%--                                                                                                             </c:if> --%>

																										<%--                                                                                                             <c:if test="${obCompany[1] eq obBidDtl.bidderId}"> --%>
																										<%--                                                                                                                 <tr id="generatedTR${srno.count}"> --%>
																										<%--                                                                                                                     <c:if test="${isTotExist eq 0 || (isTotExist eq 1 && rowId ne obTable.noOfRows)}"> --%>
																										<%--                                                                                                                             <c:if test="${obBidDtl.rowId eq rowId && obBidDtl.columnId eq obColumn.columnId && obBidDtl.cellId eq obCellDtl.cellId}"> --%>
																										<%--                                                                                                                                 <c:if test="${obBidDtl.bidderId eq obCompany[1]}"> --%>
																										<%--                                                                                                                                     <td>${obCompany[5]}</td> --%>
																										<%--                                                                                                                                 </c:if> --%>
																										<%--                                                                                                                             </c:if> --%>
																										<%--                                                                                                                     </c:if> --%>

																										<%--                                                                                                                     <c:if test="${bidderExist eq 1 && obBidDtl.rowId eq rowId && obBidDtl.columnId eq obColumn.columnId && obBidDtl.cellId eq obCellDtl.cellId and obCompany[1] eq obBidDtl.bidderId}"> --%>
																										<%--                                                                                                                         <c:set var="indexCount" value="${srno.index}"/> --%>
																										<%--                                                                                                                         <c:forEach begin="1" end="${fillOtherCount}" > --%>
																										<!--                                                                                                                             <td> -->
																										<%--                                                                                                                                   <c:set var="bidDtlCellValue" value="${lstBidDtl[indexCount].cellValue}" /> --%>
																										<%-- 	                                                                                                                                <c:choose> --%>
																										<%-- 			                                                                                                                                  <c:when test="${fn:contains(bidDtlCellValue, '###')}"> --%>
																										<%-- 																																						        <c:set var="subStringAfterSpeChar_Bid" value="${fn:substringAfter(bidDtlCellValue,'###')}"/> --%>
																										<%-- 																																						        <c:set var="nextIndexSubStringAfterSpeChar_Bid" value="${fn:indexOf(subStringAfterSpeChar_Bid,'###')}"/> --%>
																										<%-- 																																						        <c:set var="comboValue_Bid" value="${fn:substring(subStringAfterSpeChar_Bid,0,nextIndexSubStringAfterSpeChar_Bid)}"/> --%>
																										<%-- 																																						        <c:set var="commentValue_Bid" value="${fn:substringAfter(subStringAfterSpeChar_Bid,'-')}"/> --%>
																										<%-- 																														        									${comboValue_Bid} <c:if test="${commentValue_Bid ne null and commentValue_Bid ne ''}"> | ${commentValue_Bid}</c:if> --%>
																										<%-- 																																			</c:when> --%>
																										<%-- 																																			<c:otherwise> --%>
																										<%-- 																																					${bidDtlCellValue} --%>
																										<%-- 																																			</c:otherwise>  --%>
																										<%--                                                                                                                               	  </c:choose> --%>
																										<%--                                                                                                                                 <c:set var="indexCount" value="${indexCount+1}"/> --%>
																										<!--                                                                                                                             </td> -->
																										<%--                                                                                                                         </c:forEach> --%>
																										<%--                                                                                                                     </c:if> --%>

																										<%--                                                                                                                     <c:forEach items="${lstTenderProxyDtl}" var="obProxyDtl"> --%>
																										<%--                                                                                                                         <c:forEach items="${lstCompanyDtl}" var="obCompany1"> --%>
																										<%--                                                                                                                             <c:if test="${obProxyDtl.tableId eq obTable.tableId && obProxyDtl.columnId eq obColumn.columnId && obProxyDtl.rowId eq rowId && obCompany1.companyId eq obProxyDtl.companyId}"> --%>
																										<%--                                                                                                                                 <td>${obProxyDtl.cellValue}</td> --%>
																										<%--                                                                                                                             </c:if>                                                                                            --%>
																										<%--                                                                                                                         </c:forEach> --%>
																										<%--                                                                                                                     </c:forEach> --%>
																										<!--                                                                                                             </tr> -->
																										<%--                                                                                                             </c:if> --%>
																										<%--                                                                                                         </c:forEach> --%>
																										<%--                                                                                                         <tr id="generatedProxyTR${cmpSrNo.count}"> --%>
																										<%--                                                                                                             <c:if test="${isTotExist eq '1' && rowId eq obTable.noOfRows}">          --%>
																										<!--                                                                                                                 <td> -->
																										<%--                                                                                                                     ${obCompany[5]} --%>
																										<!--                                                                                                                 </td> -->
																										<%--                                                                                                                 <c:forEach items="${lstColumnDtl}" var="obColumn"> --%>
																										<%--                                                                                                                     <c:if test="${obColumn.tableid eq obTable.tableId and obColumn.filledBy ne 1 and obColumn.isShown eq 1}"> --%>
																										<%--                                                                                                                         <c:set var="fetchCol" value="${obCompany[1]}_${obTable.tableId}_${obColumn.columnId}_${rowId}" /> --%>
																										<!--                                                                                                                         <td> -->
																										<%--                                                                                                                              ${not empty mapBidData[fetchCol] ? mapBidData[fetchCol] : '-'} --%>
																										<!--                                                                                                                          </td>                   -->
																										<%--                                                                                                                          </c:if> --%>
																										<%--                                                                                                                 </c:forEach> --%>
																										<%--                                                                                                             </c:if> --%>
																										<!--                                                                                                         </tr> -->
																										<%--                                                                                                     </c:forEach> --%>
																										<%--                                                                                                 </c:when> --%>
																										<%--                                                                                                 <c:otherwise> --%>
																										<c:forEach items="${lstCompanyDtl}"
																											var="obCompany" begin="0"
																											end="${cmpNameCount}">
																											<c:set var="tdCount" value="0"></c:set>
																											<tr class="comparativeRptTR">
																												<td>${obCompany[5]}</td>
																												<c:forEach items="${lstColumnDtl}"
																													var="obColumn">
																													<c:if
																														test="${obColumn.tableid eq obTable.tableId and obColumn.filledBy ne 1}">
																														<c:if test="${obColumn.isShown ne 0}">
																															<c:set var="fetchCol"
																																value="${obCompany[1]}_${obTable.tableId}_${obColumn.columnId}_${rowId}" />
																															<c:choose>
																																<c:when
																																	test="${(obTable.noOfRows eq rowId) or not empty mapBidData[fetchCol]}">
																																	<%--                                                                                                                                      <c:set value="${obForm.isPriceBid eq 1 && mapBidData[fetchCol] eq '0' ? 'zeroTd' : 'noclassreq' }" var="bidVal"></c:set>  --%>
																																	<td><c:set
																																			var="mapBidDataFetchCol"
																																			value="${mapBidData[fetchCol]}" /> <c:choose>
																																			<c:when
																																				test="${fn:contains(mapBidDataFetchCol, '###')}">
																																				<c:set var="subStringAfterSpeChar"
																																					value="${fn:substringAfter(mapBidDataFetchCol,'###')}" />
																																				<c:set
																																					var="nextIndexSubStringAfterSpeChar"
																																					value="${fn:indexOf(subStringAfterSpeChar,'###')}" />
																																				<c:set var="comboValue"
																																					value="${fn:substring(subStringAfterSpeChar,0,nextIndexSubStringAfterSpeChar)}" />
																																				<c:set var="commentValue"
																																					value="${fn:substringAfter(subStringAfterSpeChar,'-')}" />
																											        									${comboValue} <c:if
																																					test="${commentValue ne null}"> | ${commentValue}</c:if>
																																			</c:when>
																																			<c:otherwise>
																																			    	${empty mapBidData[fetchCol] ? '-' : mapBidData[fetchCol]}
																																			    </c:otherwise>
																																		</c:choose></td>
																																	<c:set var="tdCount"
																																		value="${tdCount+1}"></c:set>
																																</c:when>
																																<%--                                                                                                                                     <c:otherwise> --%>
																																<%--                                                                                                                                         <c:choose> --%>
																																<%--                                                                                                                                             <c:when test="${empty lstTenderProxyDtl and obColumn.filledBy eq 4}"> --%>
																																<%--                                                                                                                                                <td><label class="red"> col_common_no_bid</label><c:set var="tdCount" value="${tdCount+1}"/></td> --%>
																																<%--                                                                                                                                             </c:when> --%>
																																<%--                                                                                                                                             <c:otherwise> --%>
																																<%--                                                                                                                                               	<c:set var="needTDTemp" value="0"></c:set> --%>
																																<%--                                                                                                                                                 <c:forEach items="${lstTenderProxyDtl}" var="proxyData"> --%>
																																<%--                                                                                                                                                         <c:if test="${rowId eq proxyData.rowId and obCompany.companyId eq proxyData.companyId and obColumn.columnId eq proxyData.columnId and obColumn.isShown eq 1}"> --%>
																																<%--                                                                                                                                                         <c:set value="${obForm.isPriceBid eq 1 && proxyData.cellValue eq '1' ? 'zeroTd' : 'noclassreq'}" var="bidVal"></c:set> --%>
																																<%--                                                                                                                                                         <c:set var="needTDTemp" value="${needTDTemp+1}"></c:set> --%>
																																<%--                                                                                                                                                         <c:set var="tdCount" value="${tdCount+1}"></c:set> --%>
																																<%--                                                                                                                                                                  <td class='${bidVal}'> ${proxyData.cellValue} </td> --%>
																																<%--                                                                                                                                                         </c:if> --%>
																																<%--                                                                                                                                                </c:forEach> --%>
																																<%--                                                                                                                                                <c:if test="${needTDTemp eq 0}"><c:set var="tdCount" value="${tdCount+1}"></c:set> --%>
																																<%--                                                                                                                                                                  <td class='zeroTd'></td></c:if>                                                                                                                                                --%>
																																<%--                                                                                                                                             </c:otherwise> --%>
																																<%--                                                                                                                                         </c:choose> --%>
																																<%--                                                                                                                                     </c:otherwise> --%>
																															</c:choose>
																														</c:if>
																													</c:if>
																												</c:forEach>
																												<%--     <c:set var="tdcolspan" value="<td class='a-center' colspan=${tdCount}>${no_bid}</td>" />
                                                                                                               ${zeroSum eq 0 ? tdcolspan :''} --%>
																											</tr>
																										</c:forEach>
																										<%--                                                                                                 </c:otherwise> --%>
																										<%--                                                                                             </c:choose> --%>
																										<%-- end of render td data --%>
																									</table>
																									<c:set var="fillByCount"
																										value="${fillByCount+1}" />
																									</td>
																								</c:if>
																							</c:otherwise>
																						</c:choose>
																					</c:if>
																				</c:forEach>
																			</c:if>
																		</c:forEach>
																		<%-- end of colum --%>
																	</tr>
																</c:forEach>
															</table>
														</div> <%-- END : render table data --%></td>
												</tr>
												<c:if
													test="${obTable.tableFooter ne '' && obTable.tableFooter ne null}">
													<tr>
														<td class="table-header">${obTable.tableFooter}</td>
													</tr>
												</c:if>
												<script>
                                   $(".comparativeRptTR").each(function(){
//                                 	   console.log("td count ${tdCount} ",$(this).find(".zeroTd").size()+"---"+'${obTable.tableId}');
                                   	if('${tdCount}' == $(this).find(".zeroTd").size())
                                   		{
                                   			$(this).find(".zeroTd").remove();
                                   			$(this).append("<td  class='a-center red' colspan='${tdCount}'>${no_bid}</td>");
                                   		}
                                   	
                                   });
                                   </script>
											</c:forEach>
											<c:if
												test="${obForm.formFooter ne '' && obForm.formFooter ne null}">
												<tr class="border-bottom-none border-top-none">
													<td class="form-hd-ft-clr table-header">
														${obForm.formFooter}</td>
												</tr>
											</c:if>
										</table>
									</div>
								</c:forEach>
							</div>
						</div>
					</div>
					<div class="row">
						<c:set var="role" value="buyer" />
						<c:if test="${userTypeId eq 2}">
							<c:set var="role" value="bidder" />
						</c:if>
						<spring:message code="label_saveaspdf" var="saveAsPDF" />
						<spring:message code="link_print" var="print" />
						<spring:message code="link_saveasexcel" var="lnksaveasexcel" />
						<spring:message code="link_saveasword" var="lnksaveasword" />
						<spring:message code="link_saveashtml" var="lnksaveashtml" />
						<div class="col-md-12">
							<tr class="border-bottom-none">
								<td class="a-left no-padding"><a title="${lnksaveashtml}"
									class="prefix1_1 html-icn" href="javascript:void(0);"
									onclick="exportToHTML('dataDiv','TenderIndividualReport_${tenderId}')"></a>
									<a title="${lnksaveasword}" class="prefix1_1 word-icn"
									href="javascript:void(0);"
									onclick="exportToWord('dataDiv','TenderIndividualReport_${tenderId}')">
										<a title="${lnksaveasexcel}" class="prefix1_1 exel-icn"
										href="javascript:void(0);"
										onclick="exportToExcel('dataDiv','TenderIndividualReport_${tenderId}')">
											<a class="pdf-icn prefix1_1" title="${saveAsPDF}"
											href="javascript:void(0);"
											onclick="exportToPDF('dataDiv','TenderIndividualReport_${tenderId}','scrolldata')"></a>
											<a class="print-icn prefix1_1" title="${print}"
											href="javascript:void(0);" onclick="printData();"></a> <c:choose>
												<c:when test="${userTypeId eq 2}">
													<a href="${pageContext.servletContext.contextPath}/etender/bidder/biddingtenderdashboardcontent/${tenderId}/7" class="btn btn-submit"><<
														${backDashboard}</a>
												</c:when>
												<c:otherwise>
													<div>
														<a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}" class="btn btn-submit"><<
															${backDashboard}</a>
													</div>
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
</duv>
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