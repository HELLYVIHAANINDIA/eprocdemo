<%@include file="../../includes/head.jsp"%>
<%@include file="../../includes/masterheader.jsp"%>


<spring:message code="lbl_back_dashboard" var='backDashboard'/>
<spring:message code="link_goback_tenderdashbord" var='lblGoBack'/>
<spring:message code="lbl_customize_rpt" var='lblCustomizeRpt'/>
<spring:message code="col_srno" var='srno'/>
<spring:message code="col_tender_company" var='lblcompanyName'/>
<spring:message code="lbl_bidder_name" var='lblBidderName'/>
<spring:message code="lbl_select_all" var='selectAll'/>

<div class="content-wrapper">
	<section class="content">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			<div class="box">
				<div class="box-header with-border">
				<div class="noExport pull-right">
							<a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}"><< ${backDashboard}</a> | 
                    		<a href="${pageContext.servletContext.contextPath}/etender/buyer/gettabcontent/${tenderId}/${commiteeType}"><< ${lblGoBack}</a>
				</div>
					<h3 class="box-title">${lblCustomizeRpt}</h3>
				</div>
				<div class="box-body">
					<div class="row" id="viewCustomizeRptId">
						<div class="col-lg-12 col-md-12 col-xs-12">
							<div class="box-body pad">
							<table  class="table table-striped table-responsive">
							<form:form id="frmReportCust" action="${pageContext.servletContext.contextPath}/etender/buyer/generatecustomizedreport" method="post">
								<input type="hidden" value="${tenderId}" name="hdTenderId"/>
                                    <input type="hidden" value="${formId}" name="hdFormId"/>
                                    <input type="hidden" value="${operation}" name="hdOperation"/>
                                    <input type="hidden" value="${commiteeType}" name="hdCommiteeType"/>
								<c:choose>
									<c:when test="${flag eq 1}">
									
		                                <tr class="gradi">
		                                    <th width="20%">${srno}</th>
		                                    <th width="60%">${lblcompanyName}</th>
		                                    <th width="20%">${selectAll}<input type="checkbox" id="allRows" value=""  name="allRows" onclick="checkAll(this,'bidder');" title="Select"/></th>
		                                </tr>
		
		                                <c:forEach items="${lstBidderDtl}" var="obBidder" varStatus="i">
		                                    <tr>
		                                        <td class="a-center">${i.index + 1}</td>
		                                        <td class="a-center">${obBidder[2]}</td>
		                                        <td class="a-center" id="bidder_${obBidder[1]}">
		                                            <input type="checkbox" name="chkbidder" value="${obBidder[1]}" class="checkbox">
		                                        </td>
		                                    </tr>
                                		</c:forEach>
                                		<c:forEach items="${lstFormDtl}" var="obForm">
			                                <div class="page-title prefix_1 o-hidden">
			                                	<h2 class="pull-left">${obForm[1]}</h2>
			                                </div>
			                                <div class="o-auto">
			                                <table class="table">
			                                    <c:if test="${obForm[2] ne '' && obForm[2] ne null}">
			                                        <tr class="border-top-none"><td class="table-header">${obForm[2]}</td></tr>
			                                    </c:if>
			                                    <c:forEach items="${lstTableDtl}" var="obTable">
			                                    <c:if test="${obTable[4] ne '' && obTable[4] ne null}">
			                                    	<tr> 
			                                        	<td class="a-center table-header">${obTable[4]}</td>
			                                        </tr>
			                                    </c:if>
			                                    <tr class="border-bottom-none">
			                                    	<td class="no-padding">
			                                                            <%-- START : render table data --%>
			                                        	<div class="clearfix table-border">
			                                            	<table class="table">
			                                                	<tr class="gradi border-top-none">
			                                                    	<th width="5%;">
			                                                    		<input type="checkbox" id="allColumns" value=""  name="allColumns" onclick="checkAll(this,'column');" title="Select Column"/>
			                                                    	</th>
			                                                        <c:forEach items="${lstColumnDtl}" var="obColumn">
			                                                        	<c:if test="${obColumn[1] eq obTable[0] and obColumn[6] ne 0}">
			                                                            	<th id="col_${obColumn[0]}">
			                                                            		<input type="checkbox" id="chkcolumn" value="${obColumn[0]}"  name="chkcolumn"/>
			                                                            	</th>
			                                                            </c:if>
			                                                        </c:forEach>
                                                                </tr>
                                                                <tr class="gradi border-top-none">
                                                                    <th width="10%">Select Row
                                                                    	<input type="checkbox" id="allRows" value=""  name="allRows" onclick="checkAll(this,'row');" title="${selectRow}"/>
                                                                    </th>
                                                                    <c:forEach items="${lstColumnDtl}" var="obColumn">
                                                                        <c:if test="${obColumn[1] eq obTable[0] and obColumn[6] ne 0}">
                                                                            <th>${obColumn[4]}</th>
                                                                        </c:if>
                                                                    </c:forEach>
                                                                </tr>
                                                                <c:forEach begin="0" end="${obTable[6]-1}" var="rowId">
                                                                    <tr class="border-bottom">
                                                                        <td class="a-center" id="row_${rowId}">
                                                                        	<input type="checkbox" id="chkrow" value="${rowId}"  name="chkrow"/>
                                                                        </td>
                                                                       
                                                                    <c:forEach items="${lstRowDtl}" var="obRow">
                                                                        <c:if test="${obRow[2] eq obTable[0] && obRow[4] eq rowId}">
                                                                            <c:forEach items="${lstColumnDtl}" var="obColumn">
                                                                                <c:if test="${obColumn[1] eq obTable[0] and obRow[3] eq obColumn[0] and obColumn[6] ne 0}">
                                                                                    <td class="a-center">
                                                                                        ${empty obRow[5] ? '-' : obRow[5]}
                                                                                    </td>
                                                                                </c:if>
                                                                            </c:forEach>
                                                                        </c:if>
                                                                    </c:forEach>
                                                                    </tr>
                                                                </c:forEach>
                                                            </table>
														</div>
			                                                            <%-- END : render table data --%>
													</td>
												</tr>
                                                <c:if test="${obTable[5] ne '' && obTable[5] ne null}">
                                                    <tr>
                                                   		<td class="a-center table-header">${obTable[5]}</td>
                                               		</tr>
                                                </c:if>
                                       			</c:forEach>
				                                    <c:if test="${obForm[3] ne '' && obForm[3] ne null}">
				                                        <tr><td class="table-header">${obForm[3]}</td></tr>
				                                    </c:if>
											</table>
			                                </div>
			                                <table class="table">
			                                    <tr class="border-top-none">
			                                        <td class="a-center">
			                                            <button type="button" class="btn btn-submit" id='btnSubmit' onclick='validateForm()'><spring:message code="label_submit"/></button>
			                                        </td>
			                                    </tr>
			                                </table>
										</c:forEach>
									</c:when>
									
									<c:when test="${flag eq 2}">
										<c:forEach items="${lstFormDtl}" var="obForm">
			                                <div class="page-title prefix_1 o-hidden">
			                                	<h2 class="pull-left">${obForm[1]}</h2>
			                                	<c:if test="${obForm[4] eq 1}">
			                                		<h4 class="pull-right"><b>Base Currency : ${currncyName}</b></h4>
			                                	</c:if>
			                                </div>
			                                
			                                <div class="clearfix o-auto">
						                       <table width="100%">
						                           <c:if test="${obForm[2] ne '' && obForm[2] ne null}">
			                                        <tr class="border-top-none"><td class="table-header">${obForm[2]}</td></tr>
			                                    </c:if>
						                           <c:forEach items="${lstTableDtl}" var="obTable">
						                               <c:if test="${obTable[4] ne '' && obTable[4] ne null}">
					                                    	<tr> 
					                                        	<td class="a-center table-header">${obTable[4]}</td>
					                                        </tr>
					                                    </c:if>
					                                    <tr>
                                        					<td class="no-padding">
					                                            <div >
					                                            <table class="table">
					                                                <tr>
					                                                	<c:set var="fillByCountHeader" value="0" />
					                                                	<c:forEach items="${lstColumnDtl}" var="obColumn">
					                                                        <c:if test="${obColumn[1] eq obTable[0]}">
					                                                            <c:if test="${obColumn[5] eq 1}">
					                                                                <th >${obColumn[4]}</th>
					                                                            </c:if>
					                                                            <c:if test="${obColumn[5] ne 1 and fillByCountHeader eq 0}">
					                                                            	<th><c:set var="fillByCountHeader" value="${fillByCountHeader+1}" /></th>
					                                                            </c:if>
					                                                        </c:if>
                                                    					</c:forEach>
					                                                </tr>
					                                                <c:set var="cmpNameCount" value="${fn:length(lstCompanyDtl)}" />
					                                                <c:forEach begin="0" end="${obTable[6]-1}" var="rowId">
					                                                	<c:set var="isGrandTotalDone" value="false" />
					                                                	<c:set var="isLastRow" value="false" />
					                                                    <tr>
					                                                        <c:set var="compPrinted" value="0"/>
					                                                        <c:set var="fillByCount" value="0" />
					                                                        <c:forEach items="${lstColumnDtl}" var="obColumn">
					                                                        	<c:if test="${obColumn[1] eq obTable[0]}">
					                                                        		<c:forEach items="${lstCellDtl}" var="obCellDtl">
					                                                        			<c:if test="${obCellDtl[4] eq rowId and obTable[0] eq obCellDtl[2] and obColumn[0] eq obCellDtl[3]}">
					                                                        				<c:choose>
					                                                                        <c:when test="${obColumn[5] eq 1}">
					                                                                            <td class="a-left">${empty obCellDtl[5] ? '-' : obCellDtl[5]}</td>
					                                                                             <c:if test="${empty obCellDtl[5]}"><c:set var="isLastRow" value="true" /></c:if>
					                                                                        </c:when>
					                                                                        <c:otherwise>
					                                                                            <c:if test="${fillByCount eq 0}">
					                                                                            	<td>
					                                                                            		<table class="table">
					                                                                                        <%-- heading row start --%>
					                                                                                        <tr>
					                                                                                            <spring:message code="lbl_bidder_name" var="companyName"/>
					                                                                                            <c:if test="${obColumn[1] eq obTable[0] and companyName ne ''}">
					                                                                                                    <th class="a-left" width="40%">${lblBidderName}</th>
					                                                                                                    <c:set var="companyName" value=""/>
					                                                                                            </c:if>
					                                                                                            <c:forEach items="${lstColumnDtl}" var="obColumn1">
					                                                                                                <c:if test="${obColumn1[5] ne 1 and obColumn1[1] eq obTable[0]}">
					                                                                                                    <th>${obColumn1[4]}</th>
					                                                                                                </c:if>
					                                                                                            </c:forEach>
					                                                                                        </tr>
					                                                                                        <%-- heading row end --%>
				                                                                                            <%-- start of render td data --%>
	                                                                                                        <c:forEach items="${lstCompanyDtl}" var="obCompany" begin="0" end="${cmpNameCount}">
	                                                                                                            <c:set var="tdCount" value="0"></c:set>
	                                                                                                            <tr class="custRptTR">
	                                                                                                                <td>${obCompany[2]}
	                                                                                                                <c:if test="${obForm[4] eq 1 and biddingType eq 2}">
                                        																				<label><b>(${obCompany[4]}) </b></label>
                                        																			</c:if>
	                                                                                                                </td>
	                                                                                                                <c:forEach items="${lstColumnDtl}" var="obColumn">
	                                                                                                                     <c:if test="${obColumn[1] eq obTable[0] and obColumn[5] ne 1}">
	                                                                                                                    	 <c:if test="${obColumn[6] ne 0}">
	                                                                                                                             <c:set var="fetchCol" value="${obCompany[1]}_${obTable[0]}_${obColumn[0]}_${rowId}" />
	                                                                                                                                 <c:choose>
	                                                                                                                                     <c:when test="${(obTable[9] eq 1 and obTable[6] eq rowId) or not empty mapBidData[fetchCol]}">
	<%--                                                                                                                                      <c:set value="${obForm.isPriceBid eq 1 && mapBidData[fetchCol] eq '0' ? 'zeroTd' : 'noclassreq' }" var="bidVal"></c:set>  --%>
	                                                                                                                                         <td>
	                                                                                                                                         	<c:set var="mapBidDataFetchCol" value="${mapBidData[fetchCol]}" />
	                                                                                                                                         	<c:choose>
										                                                                                                     		<c:when test="${fn:contains(mapBidDataFetchCol, '###')}">
																																				        <c:set var="subStringAfterSpeChar" value="${fn:substringAfter(mapBidDataFetchCol,'###')}"/>
																																				        <c:set var="nextIndexSubStringAfterSpeChar" value="${fn:indexOf(subStringAfterSpeChar,'###')}"/>
																																				        <c:set var="comboValue" value="${fn:substring(subStringAfterSpeChar,0,nextIndexSubStringAfterSpeChar)}"/>
																																				        <c:set var="commentValue" value="${fn:substringAfter(subStringAfterSpeChar,'-')}"/>
																												        									${comboValue} <c:if test="${commentValue ne null}"> | ${commentValue}</c:if>
																																				    </c:when>
																																				    <c:otherwise>
																																				    	${empty mapBidData[fetchCol] ? '-' : mapBidData[fetchCol]}
																																				    </c:otherwise>
																																				</c:choose>
	                                                                                                                                         </td>
	                                                                                                                                         <c:set var="tdCount" value="${tdCount+1}"></c:set> 
	                                                                                                                                     </c:when>
	                                                                                                                                </c:choose>
	                                                                                                                     	</c:if>
	                                                                                                                    </c:if>
	                                                                                                                 </c:forEach>                                                                                                               
		                                                                                                            </tr>
				                                                                                                    </c:forEach>
				                                                                                            <%-- end of render td data --%>
					                                                                                    </table>
					                                                                                    <c:set var="fillByCount" value="${fillByCount+1}" />
					                                                                                 </td>
					                                                                             </c:if>
					                                                                         </c:otherwise>
					                                                                      </c:choose>
					                                                        			</c:if>
					                                                        		</c:forEach>
					                                                        	</c:if>
					                                                        </c:forEach>
					                                                    </tr>
					                                                </c:forEach>
					                                            </table>
					                                            </div>
                                        					</td>
                                        				</tr>
						                            </c:forEach>
						                         </table>
						                      </div>
			                             </c:forEach>
									</c:when>
								</c:choose>
								</form:form>
								</table>
							</div>
							<div>
							</div>
						</div>
						 <spring:message code="label_saveaspdf" var="saveAsPDF"/> 
		                   <spring:message code="link_print" var="print"/>
		                   <table class="table">
		                   <tr class="border-bottom-none">
		                       <td class="a-left no-padding">
		                            <input type="button" class="btn noExport" onclick="exportContent('viewCustomizeRptId','CustomizeReport${tenderId}',0)" value="PDF">
									<input type="button" class="btn noExport" onclick="exportContent('viewCustomizeRptId','CustomizeReport${tenderId}',5)" value="${print}">
		                            <%-- <a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}"><< ${backDashboard}</a> | 
                    				<a href="${pageContext.servletContext.contextPath}/etender/buyer/gettabcontent/${tenderId}/${commiteeType}"><< ${lblGoBack}</a> --%>
		                       </td>
		                   </tr>
		                   </table>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>
<script type="text/javascript">
function checkAll(chkAll,type)
{
    var chk='';
    if(chkAll.checked)
    {
        chk='checked';
    }
    if(type=='row')
    {
        $('input[type=checkbox]').each(function (i)
        {
        	
            if($(this).attr('name').indexOf("chkrow")!= -1)
            {                      
                $(this).attr('checked',chk);
            }
            if(chkAll.checked == false && $(this).attr('name').indexOf("chkrow")!= -1)
            {                            
                 $(this).removeAttr('checked');
            }
        });
    }
    else if(type == 'column')
    {
        $('input[type=checkbox]').each(function (i)
        {
            if($(this).attr('name').indexOf("chkcolumn")!= -1)
            {
                $(this).attr('checked',chk);
            }
            if(chkAll.checked == false && $(this).attr('name').indexOf("chkcolumn")!= -1)
            {                            
                 $(this).removeAttr('checked');
            }
        });
    }
    else
    {
        $('input[type=checkbox]').each(function (i)
        {
            if($(this).attr('name').indexOf("chkbidder") != -1)
            {
                $(this).attr('checked',chk);
            }
            if(chkAll.checked == false && $(this).attr('name').indexOf("chkbidder")!= -1)
            {                            
                 $(this).removeAttr('checked');
            }
        });
    }

}
function validateForm()
{
    $('#errorMsg').removeAttr("class");
    $('#errorMsg').html("");
    var cnt=0;
    $('input[type=checkbox]:checked').each(function (i)
    {
        if($(this).attr('name').indexOf("chkbidder") != -1)
        {
            cnt++;
        }
    });
    if(cnt == 0)
    {
        alert("select atleast on bidder");
        return false;
    }
    cnt=0;
    $('input[type=checkbox]:checked').each(function (i)
    {
        if($(this).attr('name').indexOf("chkrow") != -1)
        {
            cnt++;
        }
    });
    if(cnt == 0)
    {
    	alert("select atleast on row");
        return false;
    }
    cnt=0;
    $('input[type=checkbox]:checked').each(function (i)
    {
        if($(this).attr('name').indexOf("chkcolumn") != -1)
        {
            cnt++;
        }
    });
    if(cnt == 0)
    {
    	alert("select atleast on column");
        return false;
    }
    
    if(cnt != 0){
    	$("#frmReportCust").submit();
    }
}

</script>
<%@include file="../../includes/footer.jsp"%>