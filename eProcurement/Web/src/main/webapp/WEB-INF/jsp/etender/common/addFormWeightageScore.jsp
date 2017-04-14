<%@include file="../../includes/head.jsp"%>
<%@include file="../../includes/masterheader.jsp"%>
    <c:if test="${operation eq 1 or operation eq 2 or operation eq 5}">
            <script type="text/javascript" src="${pageContext.servletContext.contextPath}/resources/js/print/jquery.txt"></script>
            <spring:message code="lbl_add_weightage" var="var_title"/>

<div class="content-wrapper">
<section class="content"  id="weightageScoreId">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			<div class="box">
                <spring:message code="lbl_back_dashboard" var='backDashboard'/>
				<div class="box-header with-border">
					<div class="noExport pull-right">
                        <c:choose>
                        <c:when test="${userTypeId eq 2}">
                             <a href="${pageContext.servletContext.contextPath}/etender/bidder/biddingtenderdashboardcontent/${tenderId}/7"><< ${backDashboard}</a>
                        </c:when>
                        <c:otherwise>
                            <div>
                            <a href="${pageContext.servletContext.contextPath}/etender/buyer/gettabcontent/${tenderId}/${commiteeType}"><< <spring:message code="link_goback_tenderdashbord"/></a>
                            <a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}"><< ${backDashboard}</a>
							</div>                                                
                        </c:otherwise>
                        </c:choose>
                </div>
					<h3 class="box-title">${var_title}</h3>
				</div>
<div class="box-body">
		<div class="row">
			<div class="col-lg-12 col-md-12 col-xs-12">
				<div class="box-body pad">

                    <c:forEach items="${lstFormDtl}" var="obForm">
                        <c:set value="${obForm.isPriceBid}" var="isPriceBid"></c:set>
                        <div class="page-title prefix_1 o-hidden border-top">
                            <h2 class="pull-left">${obForm.formName}</h2>
                            <c:if test="${tblTender.isWeightageEvaluationRequired eq 1}">
                            	<h3 class="pull-right">Weight : ${obForm.formWeight}</h3>
                            </c:if>
                         </div>
                          
                       <div class="clearfix border-bottom-none o-auto" id="scrolldata">
                             <table  class="table table-striped table-responsive">
	                            <c:if test="${obForm.formHeader ne '' && obForm.formHeader ne null}">
	                            <tr class="border-top-none border-bottom-none">
	                                <td class="form-hd-ft-clr table-header">
	                                    ${obForm.formHeader}
	                                    <c:if test="${obForm.isPriceBid eq 1}">
					                         <h4 class="pull-right">Base Currency : ${currncyName}</h4>
				                         </c:if>
	                                </td>
	                            </tr>
	                            </c:if>
                            <tr>
                                <td class="no-padding">
                                    <c:forEach items="${lstCompanyDtl}" var="obCompany" varStatus="srno">   
                                        <div class='a-left <c:if test="${srno.count eq 1}">border-top-none</c:if><c:if test="${srno.count ne 1}">m-top1</c:if>'>  
                                            <table class="table">
                                                <tr>
                                                    <td class="nowrap">
                                                        <div class="a-right">
                                                        <h3>
                                                        	<label><spring:message code="lbl_bidder_name"/>:</label>
                                                         <c:choose>
                                                                <c:when test="${userTypeId ne 2}">
                                                                    <spring:message code="lbl_bidder_profile" var="viewProfile" />
                                                                    <spring:url value="/common/user/getuserstatus/${obCompany[1]}/1/0/1" var="urlView"/>
                                                                    <c:choose>
			                                                        <c:when test="${isBidderRejected[obCompany[1]] eq true}">
			                                                        	<a target="_blank" class="red" href="${urlView}">${obCompany[5]}</a> <c:if test="${isBidderRejected[obCompany[1]] eq true}">(Not Eligible)</c:if>
			                                                        </c:when>
			                                                        <c:otherwise>
			                                                        	<a target="_blank" href="${urlView}">${obCompany[5]}</a> <c:if test="${isBidderRejected[obCompany[1]] eq true}">(Not Eligible)</c:if>
			                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    ${obCompany[5]} <c:if test="${isBidderRejected[obCompany[1]] eq true}">(Not Eligible)</c:if>
                                                                </c:otherwise>
                                                            </c:choose>
                                                         <!--</h2>-->
                                                        <c:if test="${tblTender.isWeightageEvaluationRequired eq 1}">
 	                                                        <div class="pull-right">Score(Out off 10) <input type="text" isBidderRejected="${isBidderRejected[obCompany[1]]}" bidderId="${obCompany[1]}" name="formBidWeight" id="formBidWeight${srno.count}" maxlength="4" class="formBidWeight form-control"  validarr="required@@length:0,5" tovalid="true" onblur="if(validateTextComponent(this)){maxWeightValue(this)}" title="Bidder bid weightage"> </div>
                                                        </c:if>
														</h3></div>
                                                    </td>
                                                </tr>
                                            </table>
                                            
                                        </div>
                                        <c:set var="bidCnt" value="0"/>
                                            <c:forEach items="${lstFormBid}" var="obFormCompBid">
                                            <c:if test="${tblTender.isWeightageEvaluationRequired eq 1}">
                                            	<input type="hidden" id="bidder_${obFormCompBid[5]}" value="${obFormCompBid[7]}">
                                            </c:if>
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
                                                                            <c:if test="${obForm.isPriceBid ne 1}">
                                                                          
                                                                            	<th  class="a-left" >
                                                                            	 <div id="lbl_downloadth" >
                                                                            	  <div id="lbl_downloadth_1" >
                                                                            	  	<spring:message code="lbl_download"/>
                                                                            	   </div>
                                                                            	   </div>
                                                                            	  </th>
                                                                          
                                                                            </c:if>
                                                                        </tr>
                                                                        <c:forEach begin="0" end="${totalRows-1}" var="rowId">
                                                                            <c:set var="isItemMaped" value="true"/>
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
																								<label id="lblGT_${obColumn.columnId}" gTFormId="${obForm.formId}" isPriceSummary="${obColumn.isPriceSummary}"  gTbidderId="${obCompany[1]}"  colId="${obColumn.columnId}" TableId="${obColumn.tableid}">${TenderCellGrandTotal.GTValue}<c:if test="${obColumn.isPriceSummary eq 1}"> (PS col.)</c:if></label>
																								<c:if test="${obColumn.filledBy eq 3}"><br/>
																									<div style="word-wrap: break-word; width:100px;" id="lblGT_ToalAmTWords_${obColumn.columnId}_${obCompany[1]}_${obTable.tableId}">${TenderCellGrandTotal.GTValue}</div>
																								</c:if>
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
                <hr/>
                <div class="col-md-12">
                <div class="col-md-3">Remarks</div>
                <div class="col-md-9"><textarea class="form-control" name="txtaWeightageRemarks" id="rtftxtaWeightageRemarks" maxlength="1000">${weightageRemarks}</textarea></div>
                </div>
               	<input type="button" class="form-control" value="Save" onclick="return validation();">
</div>
</div>
</div>
                </section>   
            </div>
    </c:if>
<spring:url value="/etender/buyer/submitFormBidWeight/${tenderId}/${formId}" var="submitMarquee" />
<div style="display: none;">
	<form action="${submitMarquee}" method="post" name="formWeight" id="formWeight"></form>
</div>
<script src="${pageContext.request.contextPath}/resources/js/tender/ConvertToWord.js"></script>
<script type="text/javascript">
function validation(){
	var res =  valOnSubmit();
	$("#formWeight").html("");
	if(res){
		$(".formBidWeight").each(function(){
			var bidderId = $(this).attr("bidderId");
			var weightVal = $(this).val();
			var id = $(this).attr("id");
			res = maxWeightValue(this);
			if(!res){
				return;
			}
			var bidder = $("<input>",{name:"bidderId",value:bidderId});
			var weight = $("<input>",{name:"weightVal",value:weightVal});
			var weightageRemarks = $("<textarea>",{name:"weightageRemarks"});
			var envelopeId = $("<input>",{name:"envelopeId",value:'${envelopeId}'});
			$(weightageRemarks).val($("#rtftxtaWeightageRemarks").val());
			$("#formWeight").append($(bidder),$(weight),$(weightageRemarks),$(envelopeId));
		});
		$("#formWeight").submit();
	}
	return res;
}
$(document).ready(function(){
	if('${tenderResult}' == 1){
		$('td[id*=grandTotal]').each(function(i){
			$(this).prev().html('<b><spring:message code="label_grandtotal"/></b>');
		});
		$('[id^="lblGT_ToalAmTWords_"]').each(function () {
			this.innerHTML = DoIt(this.innerHTML);
		});
	}   
	$("#rtftxtaWeightageRemarks").wysihtml5();
	$(".formBidWeight").each(function(){
		var bidder = $(this).attr("bidderId");
		$(this).val($("#bidder_"+bidder).val());
	});
	if('${isPriceBid}' == '1'){
	//1 buy , 2 : sell" ;
	var forLowest ='${tblTender.biddingVariant}';
		var lowest = 0;
		var heighest = 0;
		var bidderMap = new Object();
		var lbl = $("[ispricesummary='1']")
		$(lbl).each(function(){
			var total = parseFloat($.trim($(this).html()));
			var bidderId = $(this).attr("gTbidderId");
			if(bidderMap[bidderId] != "" && bidderMap[bidderId] != undefined){
				bidderMap[bidderId] = bidderMap[bidderId] + total;
			}else{
				bidderMap[bidderId] = total;
			}
		});
		for(key in bidderMap){
			if(forLowest == "1"){
				if(lowest == 0){
					lowest = bidderMap[key]; 
				}
				if(bidderMap[key] < lowest){
					lowest = bidderMap[key];
				}
			}else{
				if(heighest == 0){
					heighest = bidderMap[key]; 
				}
				if(bidderMap[key] > heighest){
					heighest = bidderMap[key];
				}
			}
		}
		$("[name='formBidWeight']").each(function(){
			var bidderId = $(this).attr("bidderId");
			var isBidderRejected = $(this).attr("isBidderRejected");
			var val = bidderMap[bidderId];
			
			if(forLowest == "1"){
				if(val == lowest){
					$(this).val(10);
				}else{
					var score = (val * 10)/lowest;
					score = score - 10;
					score = 10 - score;
					score = score.toFixed(2);
					if(score < 0){
						score = 0;
					}
					$(this).val(score);
				}
			}else{
				if(val == heighest){
					$(this).val(10);
				}else{
					var score = (val * 10)/heighest;
					score = score.toFixed(2);
					if(score < 0){
						score = 0;
					}
					$(this).val(score);
				}
			}
			if(isBidderRejected == true){
				$(this).prop("readonly",true);
				$(this).val(-1);
			}
		});
	}
});

function maxWeightValue(cThis){
	var res = true;
	var bidderId = $(cThis).attr("bidderId");
	var weightVal = $(cThis).val();
	var id = $(cThis).attr("id");
	$(".err"+id).remove();
	if(weightVal > 10){
		var errDiv = $('<div class="red err'+id+'" validationMsg clearfix">Please enter Bidder bid weightage score can be max 10</div>');
		$(cThis).parent().append(errDiv);
		$(cThis).focus();
		res = false;
	}
	return res;
}
    
</script>

<%@include file="../../includes/footer.jsp"%>
