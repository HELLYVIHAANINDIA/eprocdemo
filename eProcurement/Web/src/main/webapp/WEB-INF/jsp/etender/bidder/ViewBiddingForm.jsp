<%@include file="../../includes/head.jsp"%>
 <%@include file="../../includes/masterheader.jsp"%>


    

<spring:message code="lbl_back_dashboard" var='backDashboard'/>
<spring:message code="lbl_form_save_as_draft" var="varSaveAsDraft"/>
<spring:message code="lbl_view_bidding_form" var="varViewForm"/>
<spring:message code="lbl_edit_bidding_form" var="varEditForm"/>

<spring:message code="lbl_form_Id" var="varFormId"/>
<spring:message code="lbl_form_name" var="varFormName"/>
<spring:message code="lbl_created_on" var="varCreatedOn"/>
<spring:message code="lbl_doc_req" var="varDocReq"/>
<spring:message code="lbl_Id_Mand" var="varMandatory"/>
<spring:message code="lbl_price_bid" var="varIsPriceBid"/>


<div class="content-wrapper">
	<section class="content-header">

		<h1 class="pull-left">
			<c:choose>
				<c:when test="${!fromView}">
                                    <c:if test="${sessionUserTypeId eq 2}">
                                        <c:if test="${isAuction eq 1}"><spring:message code="lbl_bidding_hall" /></c:if>
                            <c:if test="${isAuction eq 0}">${varEditForm}</c:if>	
                                    </c:if>
                                    <c:if test="${sessionUserTypeId ne 2}">
                                        ${varEditForm}
                                    </c:if>
							
                                    
							</c:when>
				<c:otherwise>
							<c:if test="${sessionUserTypeId eq 2}">
                                        <c:if test="${isAuction eq 1}"><spring:message code="lbl_bidding_hall" /></c:if>
                            <c:if test="${isAuction eq 0}">${varViewForm}</c:if>	
                                    </c:if>
                                    <c:if test="${sessionUserTypeId ne 2}">
                                        ${varViewForm}
                                    </c:if>	
							</c:otherwise>
			</c:choose>
		</h1>

		<c:choose>
			<c:when test="${sessionUserTypeId eq 2}">
                           
				 <c:if test="${isAuction eq 0}"><a href="${pageContext.servletContext.contextPath}/etender/bidder/biddingtenderdashboardcontent/${tenderId}/5"
					class="pull-right"><< ${backDashboard}</a></c:if>
					<c:if test="${isAuction eq 1}"><a href="${pageContext.servletContext.contextPath}/etender/bidder/biddingTenderDashboard/${tenderId}"
					class="pull-right"><< <spring:message code="lbl_go_back_to_auction_dashboard" /></a></c:if> 
			</c:when>
			<c:otherwise>
                           
				<c:if test="${isAuction eq 0}">
                                    <a
					href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}"
					class="pull-right">
                                    << ${backDashboard}
                                    </a>
                                </c:if>
					<c:if test="${isAuction eq 1}">
                                            
                                            <c:if test="${not empty isFormLibrary}">
                                                <a
					href="${pageContext.servletContext.contextPath}/etender/buyer/getFormLibrary/${FormLibrarytenderId}"
					class="pull-right">
                                                << <spring:message code="lbl_go_to_gorm_library" /></a>
                                            </c:if>
                                            <c:if test="${empty isFormLibrary}">
                                                 <a
					href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}"
					class="pull-right">
                                               << <spring:message code="lbl_go_back_to_auction_dashboard" />
                                               </a>
                                            </c:if>
                                        </c:if> 
			</c:otherwise>
		</c:choose>

	</section>

	<div class="row">
		<div class="col-md-12">
			<c:if test="${not empty successMsg}">
				<div class="alert alert-success">
					<spring:message code="${successMsg}" />
				</div>
			</c:if>
			<c:if test="${not empty errorMsg}">
				<div class="alert alert-danger">
					<spring:message code="${errorMsg}" />
				</div>
			</c:if>
		</div>
	</div>

	<c:if test="${isAuction eq 1 and sessionUserTypeId eq 2}">
		<div class="row">
			<div class="col-md-12">
				<div class="alert alert-success">- You are advised not to wait
					till the last minute or last few seconds to submit your bid to
					avoid complications related with internet connectivity, network
					problems, system crash down, power failure, etc. Department would
					not be responsible for these unforeseen circumstances.</div>
			</div>
		</div>
		<div class="row" id="validationMsgDiv" style="display: none;">
                             <div class="col-md-12">
                    <div class="alert alert-danger" id="ValidationMsg">
                       
                        </div>
                             </div>
                         </div>
	</c:if>
	
	<section class="content">
	
		<c:if test="${isAuction eq 1 and sessionUserTypeId eq 2}">
			
			<%@include file="../buyer/AuctionSummary.jsp"%>
			
				<div class="row">
				
					<div class="col-lg-12 col-md-12">
						<div class="box">
							<div class="box-header with-border">
								<div class="row">
									 <div class='col-md-12'>
                                        <div class='col-sm-3 col-md-3'>
                                            <div class='form_filed text-black text-right'><spring:message code="lbl_current_time" /> :</div>
                                        </div>
                                        <div class='col-sm-3 col-md-3'>
                                            <div class='form_filed text-black text-right' id="divServerCurrentTime">
                                                
                                            </div>
                                        </div>
                                        
                                        <div class='col-sm-6 col-md-6'>
                                            <div class='form_filed text-black text-right' id="countdown">
                                                
                                            </div>
                                        </div>
                                    </div>
                                   
									<div id="divCurrentTime"></div>

									

									<%--	<div class="col-md-12">
											<div class="col-sm-3 col-md-3">
												<div class="form_filed text-black text-right">Minimum
													Bid Amount : </div>
											</div>
											<div class="col-sm-3 col-md-3">
												<div class="form_filed text-black text-right">
													<c:if test="${tblTender.isAcceptStartPrice eq 1}">
                                                                <c:if test="${tblTender.biddingType eq 2}">
                                                                    ${tblTender.startPrice /ExchangeRate} 
                                                                </c:if>
                                                                <c:if test="${tblTender.biddingType ne 2}">
                                                                    ${tblTender.startPrice}
                                                                </c:if>
                                                                
                                                            </c:if>
                                                            <c:if test="${tblTender.isAcceptStartPrice eq 0}">
                                                                <c:if test="${tblTender.auctionMethod eq 1}">
                                                                    <c:if test="${tblTender.biddingType eq 2}">
                                                                        ${(tblTender.startPrice + tblTender.incrementDecrementValues)/ExchangeRate} 
                                                                    </c:if>
                                                                    <c:if test="${tblTender.biddingType ne 2}">
                                                                        ${tblTender.startPrice + tblTender.incrementDecrementValues}
                                                                    </c:if>
                                                                    
                                                                </c:if>
                                                                <c:if test="${tblTender.auctionMethod eq 0}">
                                                                    <c:if test="${tblTender.biddingType eq 2}">
                                                                        ${(tblTender.startPrice - tblTender.incrementDecrementValues)/ExchangeRate} 
                                                                    </c:if>
                                                                    <c:if test="${tblTender.biddingType ne 2}">
                                                                        ${tblTender.startPrice - tblTender.incrementDecrementValues}
                                                                    </c:if>
                                                                    
                                                                </c:if>
                                                            </c:if>
												</div>

											</div>
                                                                                    <div class="col-sm-3 col-md-3"></div>
                                                                                    <div class="col-sm-3 col-md-3"></div>
										</div>--%>

									


								</div>

							</div>
						</div>
					</div>
				</div>
		</c:if>
		
		
 <div class="row">
		<div class="col-lg-12 col-md-12">
                        <div class="box">
                            <div class="box-header with-border">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="col-sm-2 col-md-2">
                                            <div class="form_filed text-black text-right">${varFormId} :</div>
                                        </div>
                                        <div class="col-sm-2 col-md-2">
                                            <div class="form_filed pull-left">${formId}</div>
                                        </div>
                                        <div class="col-sm-2 col-md-2">
                                            <div class="form_filed text-black text-right" >${varFormName} :</div>
                                        </div>
                                        <div class="col-sm-2 col-md-2">
                                            <div class="form_filed pull-left">${FormBean.FormName}</div>
                                        </div>
                                        <div class="col-sm-2 col-md-2">
                                            <div class="form_filed text-black text-right">${varCreatedOn} :</div>
                                        </div>
                                        <div class="col-sm-2 col-md-2">
                                            <div class="form_filed pull-left">${FormBean.CreatedOn}</div>
                                        </div>
                                    </div>
                                        <c:set var="DocReqVal" value="No"/>
                                       <c:if test="${FormBean.IsDocReq eq 0}">
                                           <c:set var="DocReqVal" value="No"/>
                                       </c:if>
                                       <c:if test="${FormBean.IsDocReq eq 1}">
                                           <c:set var="DocReqVal" value="Yes"/>
                                       </c:if>
                                                        
                                          <c:if test="${isAuction eq 0}">                 
                                     <div class="col-md-12">
                                                        <div class="col-sm-2 col-md-2">
                                                            <div class="form_filed text-right text-black">${varDocReq} :</div>
                                                        </div>
                                                        <div class="col-sm-2 col-md-2">
                                                            <div class="form_filed  pull-left">${DocReqVal}</div>
                                                        </div>
                                                        <c:set var="IsMandatory" value="No"/>
                                                        <c:if test="${FormBean.IsMandatory eq 0}">
                                                                <c:set var="IsMandatory" value="No"/>
                                                            </c:if>
                                                            <c:if test="${FormBean.IsMandatory eq 1}">
                                                                <c:set var="IsMandatory" value="Yes"/>
                                                            </c:if>
                                                       
                                                        <div class="col-sm-2 col-md-2">
                                                            <div class="form_filed  text-right text-black">${varMandatory} :</div>
                                                        </div>
                                                        <div class="col-sm-2 col-md-2">
                                                            
                                                            <div class="form_filed  pull-left">${IsMandatory}</div>
                                                        </div>
                                                          <c:set var="IsPriceBid" value="No"/>
                                                        <c:if test="${FormBean.IsPriceBid eq 0}">
                                                                <c:set var="IsPriceBid" value="No"/>
                                                            </c:if>
                                                            <c:if test="${FormBean.IsPriceBid eq 1}">
                                                                <c:set var="IsPriceBid" value="Yes"/>
                                                            </c:if>
                                                        
                                                        <div class="col-sm-2 col-md-2">
                                                            <div class="form_filed text-right text-black">${varIsPriceBid} :</div>
                                                        </div>
                                                        <div class="col-sm-2 col-md-2">
                                                            <div class="form_filed  pull-left">${IsPriceBid}</div>
                                                        </div>
                                                    </div>
                                          </c:if>
                                                    </div>
                              
                                                    
                                                   
						</div>

						

					</div>

				</div>
				</div>
                                                          
                <div class="row">
                    <div class="col-lg-12 col-md-12">
                        <form:form id="bidForm" action="${pageContext.servletContext.contextPath}/eBid/Bid/updateBiddingFormValueForEdit" method="POST">
                        <div class="box"  style="overflow: scroll;">
                            <div class="col-md-6">
                                <h3 class="box-title"> ${formStructure['form'].formName} </h3>
                            </div>
							<div class="box-body">
                                <div class="row">
                                        <div class="col-md-12">
                                            <h3 style="padding-top:0px;margin-top:0px;">${formStructure['form'].formHeader}</h3>
                                        </div>
                                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                        	<div class="box">
												<c:forEach var="tableData" items="${formStructure['table']}" varStatus="tableCount">
													
                                                                                                            <c:if test="${isAuction eq 0}">
                                                                                                                <div class="box-header with-border">
                                                                                                                <h3 class="box-title"><b>${tableData.tableName}</b></h3>
												        <h4 class="box-title pull-right" ><b> <spring:message code="lbl_is_mandatory" /></b>&nbsp;
												        	<c:choose>
												        		<c:when test="${tableData.isMandatory eq 1}"> <spring:message code="label_yes" /></c:when>
												        		<c:when test="${tableData.isMandatory eq 0}"> <spring:message code="label_no" /></c:when>
												        	</c:choose>
														</h4>
                                                                                                                </div>
                                                                                                            </c:if>
												        
                                                                                                    <c:if test="${isAuction eq 0}">
                                                                                                        <div class="box-header with-border">
														<h3 class="box-title">${tableData.tableHeader}</h3>
													</div>
                                                                                                    </c:if>
													
													<div class="box-body">
													<div class="row">
														<div class="col-lg-12 col-md-12 col-xs-12">
															<table class="table table-striped table-responsive" id="tbl_${tableCount.index}" tableId="${tableData.tableId}">
																<thead>
																	<tr>
																		<c:forEach var="columnData" items="${formStructure['column']}">
																			<c:if test="${columnData.key eq tableData.tableId}">
																			<c:forEach var="columnDataValue" items="${columnData.value}">
																				<th>Column Name: ${columnDataValue.columnHeader}<br/>
																				<spring:message code="lbl_filled_by" />
																					<c:forEach items="${UserEnum}" var="userEnumData">
																						<c:if test="${userEnumData.userType eq columnDataValue.filledBy}">
																							${userEnumData}
																						</c:if>
																					</c:forEach> 
																					
																				<br> <spring:message code="lbl_data_type" />
																					<c:forEach items="${DataTypeEnum}" var="datatype">
																						<c:if test="${datatype.status eq columnDataValue.dataType}">
																							${datatype}
																						</c:if>
																					</c:forEach>																				
																				</th>
																			</c:forEach>
																			</c:if>
																		</c:forEach>
																	</tr>
																</thead>
																<tbody>
																<c:if test="${sessionUserTypeId eq 2 and listOfCurrency ne null and not empty listOfCurrency and isRepeated and FormBean.IsPriceBid eq 1}">
																<div class="col-lg-12 col-md-12 col-xs-12">
																 <label class="pull-right"><b><spring:message code="lbl_bid_currency" /> ${selectedCurrency}</b><br/><br/></label>
																</div>
																</c:if>
																<c:forEach var="rowCount" begin="0" end="${tableData.noOfRows-1}">
																	<tr id="tr${rowCount}">	
                                                                                                                                            
																<c:forEach var="columnData" items="${formStructure['column']}">
																	<c:if test="${columnData.key eq tableData.tableId}">
                                                                                                                                            
																			<c:forEach var="columnDataValue" items="${columnData.value}">
                                                                                                                                                    
																		        <c:forEach var="cellData" items="${formStructure['cell']}">
                                                                                                                                                     
																			<c:if test="${cellData.tblTenderTable.tableId eq tableData.tableId and  cellData.tblTenderColumn.columnId eq columnDataValue.columnId and cellData.rowId eq rowCount}">
																	
                                                                             <td tableid="1" trid="${rowCount}" colKey="${columnDataValue.columnId}" cellID="${cellData.cellId}" filledBy="${columnDataValue.filledBy}">
																			<c:if test="${columnDataValue.isShown eq 1}">
																			<c:set value="${rowCount}" var="inputId"/>
                                                                                                                                                    
																			<c:forEach var="entry" items="${formFormulaWithColumn}">
                                                                                                                                                           
																					<c:if test="${entry.key eq columnDataValue.columnId}">
                                                                                                                                                                            <c:set value="${entry.value}" var="formula"/>
                                                                                                                                                                            <c:set value="result_${rowCount}_${columnDataValue.columnId}" var="inputId"/>
                                                                                                                                                                            <c:set value="txtcell_0_${columnDataValue.columnId}_${rowCount}" var="inputclass"/>
																					</c:if>
																					<c:if test="${entry.key ne columnDataValue.columnId}">
                                                                                                                                                                            <c:set value="txtcell_0_${columnDataValue.columnId}_${rowCount}" var="inputId"/>
                                                                                                                                                                            <c:set value="txtcell_0_${columnDataValue.columnId}_${rowCount}" var="inputclass"/>
																					</c:if>
																			</c:forEach>
                                                                                                                                                                        <c:if test="${empty formFormulaWithColumn}">
                                                                                                                                                                           <c:set value="txtcell_0_${columnDataValue.columnId}_${rowCount}" var="inputId"/>
                                                                                                                                                                            <c:set value="txtcell_0_${columnDataValue.columnId}_${rowCount}" var="inputclass"/>
                                                                                                                                                                        </c:if>
																			<c:choose>
																				<c:when test="${!fromView && columnDataValue.filledBy eq 2 and  not empty getLastFormulaColumn}">
                                                                                                                                                            
																					<c:choose>
																						<c:when test="${(columnDataValue.dataType eq 2 || columnDataValue.dataType eq 1 || columnDataValue.dataType eq 5 || columnDataValue.dataType eq 3 || columnDataValue.dataType eq 4 || columnDataValue.dataType eq 6)}">
                                                                                                                                                                                       
																							<c:choose>
                                                                                                                                                                                     
																								<c:when test="${columnDataValue.isGTColumn eq 1}">
                                                                                                                                                                                              
																									<c:choose>
																										<c:when test="${columnDataValue.dataType eq 1}">
                                                                                                                                                                                                       
																											<input validarr="required@@length:0,2000" tovalid="true" id="${inputId}" type="text" onblur="ValidateInput('${columnDataValue.dataType}',this);" att="1" colKey="${columnDataValue.columnId}" tableid="${tableData.tableId}" tableMand="${tableData.isMandatory}"  class="clstxtcell ${inputclass}" value="${cellData.cellValue}" rowid="${rowCount}">
																										</c:when>
																										<c:when test="${columnDataValue.dataType eq 2}">
                                                                                                         	<textarea validarr="required@@length:0,10000" id="${inputId}" type="text" onblur="ValidateInput('${columnDataValue.dataType}',this);" att="1" colKey="${columnDataValue.columnId}" tableid="${tableData.tableId}" tableMand="${tableData.isMandatory}"  class="clstxtcell ${inputclass}" value="${cellData.cellValue}" rowid="${rowCount}"></textarea>
																										</c:when>
																										<c:when test="${columnDataValue.dataType eq 3}">
                                                                                                                                                       <c:choose>
                                                                                                                                                           <c:when test="${tblTender.isAuction eq 1}">
                                                                                                                                                           <input id="${inputId}" type="number" title="${columnDataValue.columnHeader}"  validarr="required@@posnegnumwithdecimal:${tblTender.decimalValueUpto}@@nonzero" tovalid="true" onblur="validateTextComponent(this)" att="1" colKey="${columnDataValue.columnId}" tableid="${tableData.tableId}" tableMand="${tableData.isMandatory}"  class="clstxtcell ${inputclass}" value="${cellData.cellValue}" rowid="${rowCount}">
                                                                                                                                                           </c:when>
                                                                                                                                                           <c:otherwise>
                                                                                                                                                           <input id="${inputId}" type="number" validarr="required@@numwithdecimal:2" tovalid="true" onblur="ValidateInput('${columnDataValue.dataType}',this);" att="1" colKey="${columnDataValue.columnId}" tableid="${tableData.tableId}"  tableMand="${tableData.isMandatory}" class="clstxtcell ${inputclass}" value="${cellData.cellValue}" rowid="${rowCount}">
                                                                                                                                                           </c:otherwise>
                                                                                                                                                       </c:choose>
																											
																										</c:when>
                                                                                                                                                                                                        
																										<c:when test="${columnDataValue.dataType eq 4}">
                                                                                                                                                                                                        <c:if test="${tblTender.isAuction eq 1}">
                                                                                                                                                                                                        <input id="${inputId}" type="number" title="${columnDataValue.columnHeader}" validarr="required@@posnegnumeric@@nonzero" tovalid="true" onblur="validateTextComponent(this)" att="1" colKey="${columnDataValue.columnId}" tableid="${tableData.tableId}" tableMand="${tableData.isMandatory}"  class="clstxtcell ${inputclass}" value="${cellData.cellValue}" rowid="${rowCount}">
                                                                                                                                                                                                        </c:if>
                                                                                                                                                                                                        <c:if test="${tblTender.isAuction ne 1}">
                                                                                                                                                                                                        <input id="${inputId}" type="number" validarr="required@@numeric" tovalid="true" onblur="ValidateInput('${columnDataValue.dataType}',this);" att="1" colKey="${columnDataValue.columnId}" tableid="${tableData.tableId}" tableMand="${tableData.isMandatory}"  class="clstxtcell ${inputclass}" value="${cellData.cellValue}" rowid="${rowCount}">
                                                                                                                                                                                                        </c:if>
																											
																										</c:when>
																										<c:when test="${columnDataValue.dataType eq 5}">
                                                                                                                                                                                                                    <c:choose>
                                                                                                                                                                                                                        <c:when test="${tblTender.isAuction eq 1}">
                                                                                                                                                                                                                            <input id="${inputId}" title="${columnDataValue.columnHeader}" type="number" validarr="required@@posnegnumwithdecimal:${tblTender.decimalValueUpto}" tovalid="true" onblur="validateTextComponent(this);" att="1" colKey="${columnDataValue.columnId}" tableid="${tableData.tableId}"  tableMand="${tableData.isMandatory}" class="clstxtcell ${inputclass}" value="${cellData.cellValue}" rowid="${rowCount}">
                                                                                                                                                                                                                        </c:when>
                                                                                                                                                                                                                        <c:otherwise>
                                                                                                                                                                                                                            <input id="${inputId}" type="number" validarr="required@@numanduptodecimal:2" tovalid="true" onblur="ValidateInput('${columnDataValue.dataType}',this);" att="1" colKey="${columnDataValue.columnId}" tableid="${tableData.tableId}" tableMand="${tableData.isMandatory}"  class="clstxtcell ${inputclass}" value="${cellData.cellValue}" rowid="${rowCount}">
                                                                                                                                                                                                                        </c:otherwise>
                                                                                                                                                                                                                    </c:choose>
                                                                                                                                                                                                       
																											
																										</c:when>
																										<c:when test="${columnDataValue.dataType eq 6}">
																											<label>${rowCount}</label>
																										</c:when>
																										<c:when test="${columnDataValue.dataType eq 7}">
																											<input id="${inputId}" type="date" onblur="ValidateInput('${columnDataValue.dataType}',this);" att="1" colKey="${columnDataValue.columnId}" tableid="${tableData.tableId}" tableMand="${tableData.isMandatory}"  class="clstxtcell ${inputclass}" value="${cellData.cellValue}" rowid="${rowCount}">
																										</c:when>
<%-- 																										<c:when test="${columnDataValue.dataType eq 8}"> --%>
<%-- 																											<input id="${inputId}" type="text" onblur="ValidateInput('${columnDataValue.dataType}',this);" att="1" colKey="${columnDataValue.columnId}" tableid="${tableData.tableId}"   class="clstxtcell_true" value="${cellData.cellValue}" rowid="${rowCount}"> --%>
<%-- 																										</c:when> --%>
<%-- 																										<c:when test="${columnDataValue.dataType eq 9}"> --%>
<%-- 																											<input id="${inputId}" type="text" onblur="ValidateInput('${columnDataValue.dataType}',this);" att="1" colKey="${columnDataValue.columnId}" tableid="${tableData.tableId}"   class="clstxtcell_true" value="${cellData.cellValue}" rowid="${rowCount}"> --%>
<%-- 																										</c:when> --%>
																										<c:otherwise>
																											<input id="${inputId}" type="text" onblur="ValidateInput('${columnDataValue.dataType}',this);" att="1" colKey="${columnDataValue.columnId}" tableid="${tableData.tableId}" tableMand="${tableData.isMandatory}"  class="clstxtcell ${inputclass}" value="${cellData.cellValue}" rowid="${rowCount}">
																										</c:otherwise>
																									</c:choose>
																									
																								</c:when>
																								<c:otherwise>
                                                                                                        <c:choose>
																											<c:when test="${columnDataValue.dataType eq 1}">
																												<input validarr="required@@length:0,2000" tovalid="true" id="${inputId}" type="text" onblur="ValidateInput('${columnDataValue.dataType}',this);" att="1" colKey="${columnDataValue.columnId}" tableid="${tableData.tableId}" tableMand="${tableData.isMandatory}"  class="clstxtcell ${inputclass}" value="${cellData.cellValue}" rowid="${rowCount}">
																											</c:when>
																											<c:when test="${columnDataValue.dataType eq 2}">
                                                                                                            	<textarea validarr="required@@length:0,10000" id="${inputId}" type="text" onblur="ValidateInput('${columnDataValue.dataType}',this);" att="1" colKey="${columnDataValue.columnId}" tableid="${tableData.tableId}" tableMand="${tableData.isMandatory}"  class="clstxtcell ${inputclass}" value="${cellData.cellValue}" rowid="${rowCount}"></textarea>
																											</c:when>
																											<c:when test="${columnDataValue.dataType eq 3}">
                                                                                                                   <c:choose>
                                                                                                                       <c:when test="${tblTender.isAuction eq 1}">
                                                                                                                           <input id="${inputId}" type="number" title="${columnDataValue.columnHeader}" validarr="required@@posnegnumwithdecimal:${tblTender.decimalValueUpto}@@nonzero" tovalid="true" onblur="validateTextComponent(this);" att="1" colKey="${columnDataValue.columnId}" tableid="${tableData.tableId}" tableMand="${tableData.isMandatory}"  class="clstxtcell ${inputclass}" value="${cellData.cellValue}" rowid="${rowCount}">
                                                                                                                       </c:when>
                                                                                                                       <c:otherwise>
                                                                                                                           <input id="${inputId}" type="number" validarr="required@@numwithdecimal:2" tovalid="true" onblur="ValidateInput('${columnDataValue.dataType}',this);" att="1" colKey="${columnDataValue.columnId}" tableid="${tableData.tableId}" tableMand="${tableData.isMandatory}"  class="clstxtcell ${inputclass}" value="${cellData.cellValue}" rowid="${rowCount}">
                                                                                                                       </c:otherwise>
                                                                                                                   </c:choose>
																											</c:when>
																											<c:when test="${columnDataValue.dataType eq 4}">
																												<c:choose>
                                                                                                                                  <c:when test="${tblTender.isAuction eq 1}">
                                                                                                                      <input id="${inputId}" type="number" title="${columnDataValue.columnHeader}" validarr="required@@posnegnumeric@@nonzero" tovalid="true" onblur="validateTextComponent(this)" att="1" colKey="${columnDataValue.columnId}" tableid="${tableData.tableId}" tableMand="${tableData.isMandatory}"  class="clstxtcell ${inputclass}" value="${cellData.cellValue}" rowid="${rowCount}">
                                                                                                                                  </c:when>
                                                                                                                      <c:otherwise>
                                                                                                                      <input id="${inputId}" type="number" validarr="required@@numeric" tovalid="true" onblur="ValidateInput('${columnDataValue.dataType}',this);" att="1" colKey="${columnDataValue.columnId}" tableid="${tableData.tableId}"  tableMand="${tableData.isMandatory}" class="clstxtcell ${inputclass}" value="${cellData.cellValue}" rowid="${rowCount}">
                                                                                                                      </c:otherwise>
																												</c:choose>
																											</c:when>
																											<c:when test="${columnDataValue.dataType eq 5}">
                                                                                                                                                                                                                <c:choose>
                                                                                                                                                                                                                    <c:when test="${tblTender.isAuction eq 1}">
                                                                                                                                                                                                                        <input id="${inputId}" type="number" title="${columnDataValue.columnHeader}" validarr="required@@posnegnumwithdecimal:${tblTender.decimalValueUpto}" tovalid="true" onblur="validateTextComponent(this)" att="1" colKey="${columnDataValue.columnId}" tableid="${tableData.tableId}" tableMand="${tableData.isMandatory}"  class="clstxtcell ${inputclass}" value="${cellData.cellValue}" rowid="${rowCount}">
                                                                                                                                                                                                                    </c:when>
                                                                                                                                                                                                                    <c:otherwise>
                                                                                                                                                                                                                        <input id="${inputId}" type="number" validarr="required@@numanduptodecimal:2" tovalid="true" onblur="ValidateInput('${columnDataValue.dataType}',this);" att="1" colKey="${columnDataValue.columnId}" tableid="${tableData.tableId}" tableMand="${tableData.isMandatory}"  class="clstxtcell ${inputclass}" value="${cellData.cellValue}" rowid="${rowCount}">
                                                                                                                                                                                                                    </c:otherwise>
                                                                                                                                                                                                                </c:choose>
																											
																										</c:when>
																										<c:when test="${columnDataValue.dataType eq 6}">
																											<label>${rowCount}</label>
																										</c:when>
																										<c:when test="${columnDataValue.dataType eq 7}">
																											<input id="${inputId}" type="date" onblur="ValidateInput('${columnDataValue.dataType}',this);" att="1" colKey="${columnDataValue.columnId}" tableid="${tableData.tableId}" tableMand="${tableData.isMandatory}"  class="clstxtcell ${inputclass}" value="${cellData.cellValue}" rowid="${rowCount}">
																										</c:when>
																										<c:when test="${columnDataValue.dataType eq 8}">
																												<select id="${inputId}" att="1" colKey="${columnDataValue.columnId}" tableid="${tableData.tableId}" tableMand="${tableData.isMandatory}"  class="clstxtcell ${inputclass}" ><option>--Select--</option></select>
																										</c:when>
<%-- 																										<c:when test="${columnDataValue.dataType eq 9}"> --%>
<%-- 																											<input id="${inputId}" type="text" onblur="ValidateInput('${columnDataValue.dataType}',this);" att="1" colKey="${columnDataValue.columnId}" tableid="${tableData.tableId}"   class="clstxtcell_true" value="${cellData.cellValue}" rowid="${rowCount}"> --%>
<%-- 																										</c:when> --%>
																										<c:otherwise>
																											<input id="${inputId}" type="text" onblur="ValidateInput('${columnDataValue.dataType}',this);" att="1" colKey="${columnDataValue.columnId}" tableid="${tableData.tableId}" tableMand="${tableData.isMandatory}"  class="clstxtcell ${inputclass}" value="${cellData.cellValue}" rowid="${rowCount}">
																										</c:otherwise>
																										</c:choose>                                                                                           
																								</c:otherwise>
																							</c:choose>
																						</c:when>																				
																					</c:choose>
																				</c:when>
																				<c:when test="${!fromView && columnDataValue.filledBy eq 2 and  empty getLastFormulaColumn}">
																					<c:choose>
																						<c:when test="${columnDataValue.dataType eq 2 || columnDataValue.dataType eq 1 || columnDataValue.dataType eq 5 || columnDataValue.dataType eq 3 || columnDataValue.dataType eq 4 || columnDataValue.dataType eq 6}">
                                                                                                                                                                                   <%-- <c:if test="${isAuction ne 1}">--%>
                                                                                                                                                                                        <input  id="${inputId}" type="text" onblur="ValidateInput('${columnDataValue.dataType}',this);" att="1" colKey="${columnDataValue.columnId}" tableid="${tableData.tableId}" class="clstxtcell" value="${cellData.cellValue}" rowid="${rowCount}" attrformula="${formula}">     
                                                                                                                                                                                  <%--
                                                                                                                                                                                    </c:if>
                                                                                                                                                                                    <c:if test="${isAuction eq 1}">
                                                                                                                                                                                        <input  id="${inputId}" type="text" onblur="ValidateInput('${columnDataValue.dataType}',this);" att="1" colKey="${columnDataValue.columnId}" tableid="${tableData.tableId}" class="clstxtcell" value="${cellData.cellValue}" rowid="${rowCount}" attrformula="${formula}">     
                                                                                                                                                                                  
                                                                                                                                                                                    </c:if>--%>
                                                                                                                                                                                   
																						</c:when>
																					</c:choose>
																				</c:when>
																				<c:when test="${!fromView}">
																					<input id="${inputId}" type="text" value="${cellData.cellValue}" disabled="disabled" attrformula="${formula}" tableMand="${tableData.isMandatory}" class="${inputclass}">
																				</c:when>
																				<c:otherwise>
                                                                                                                                                                    ${cellData.cellValue}
																				</c:otherwise>
																			</c:choose>
																			</c:if>
																			</td>
																			</c:if>
																		</c:forEach>
																		
																		
																		<c:forEach var="entry" items="${formFormulaWithColumn}">
																			<c:if test="${entry.key eq columnDataValue.columnId}">
                                                                                                                                                            
																				<input type="hidden" id="hdnFormula" value="${entry.value}">		
																			</c:if>
																		</c:forEach>
																		<c:set value="${formula}" var="formula"/>
																		</c:forEach>
																		</c:if>
																	</c:forEach>	
																	</tr>
																	</c:forEach>
                                                                                                                                   
                                                                                                                                            <tr id="trGT_${tableData.tableId}" tableId="${tableData.tableId}" >
																		<c:forEach var="columnData" items="${formStructure['column']}">
																			<c:forEach var="columnDataValue" items="${columnData.value}">
																				<c:if test="${columnData.key eq tableData.tableId}">
																					<td>
																						<c:if test="${columnDataValue.isGTColumn eq 1}">
																							<c:forEach items="${formStructure['TenderCellGrandTotalList']}" var="TenderCellGrandTotal" varStatus="counter">
																								<c:if test="${TenderCellGrandTotal.tblTenderColumn.columnId eq columnDataValue.columnId}">
                                                                                                                                                                                                        <b><c:if test="${fn:containsIgnoreCase(columnDataValue.columnHeader,'total')}">
                                                                                                                                                                                                        ${columnDataValue.columnHeader} 
                                                                                                                                                                                                          = 
                                                                                                                                                                                                        </c:if> 
                                                                                                                                                                                                        <c:if test="${not fn:containsIgnoreCase(columnDataValue.columnHeader,'total')}">
                                                                                                                                                                                                        Total ${columnDataValue.columnHeader} 
                                                                                                                                                                                                        =
                                                                                                                                                                                                        
                                                                                                                                                                                                        </c:if></b> <label id="lblGT_${columnDataValue.columnId}" TableId="${tableData.tableId}" colId="${columnDataValue.columnId}">${TenderCellGrandTotal.GTValue}</label>
                                                                                                                                                                                                        
                                                                                                                                                                                                  
																								</c:if>
																								
																							</c:forEach>
																						</c:if>
                                                                                                                                                                                                        <c:if test="${tblTender.isAuction eq 1 && tblTender.biddingType eq 2 && sessionUserTypeId eq 2}">
                                                                                                                                                                                                           <c:if test="${columnDataValue.isGTColumn eq 1}">
                                                                                                                                                                                                                <c:forEach items="${formStructure['TenderCellGrandTotalList']}" var="TenderCellGrandTotal" varStatus="counter">
                                                                                                                                                                                                                    <c:if test="${TenderCellGrandTotal.tblTenderColumn.columnId eq columnDataValue.columnId}">
                                                                                                                                                                                                        <br>
                                                                                                                                                                                                                        <b><c:if test="${fn:containsIgnoreCase(columnDataValue.columnHeader,'total')}">
                                                                                                                                                                                                                            ${columnDataValue.columnHeader} 
                                                                                                                                                                                                                            = 
                                                                                                                                                                                                                            </c:if> 
                                                                                                                                                                                                                            <c:if test="${not fn:containsIgnoreCase(columnDataValue.columnHeader,'total')}">
                                                                                                                                                                                                                            Total ${columnDataValue.columnHeader} 
                                                                                                                                                                                                                            =
                                                                                                                                                                                                                            </c:if>
                                                                                                                                                                                                                            (In Base Currency (${currncyName})) 
                                                                                                                                                                                                                            = <label id="lblGTBase${columnDataValue.columnId}" TableId="${tableData.tableId}" colId="${columnDataValue.columnId}">${TenderCellGrandTotal.GTValue}</label>
                                                                                                                                                                                                                    </c:if>
																								
                                                                                                                                                                                                                </c:forEach>
                                                                                                                                                                                                            </c:if>                                                                                                                           
                                                                                                                                                                                                        </c:if>
																					</td>
																				</c:if>
																		</c:forEach>
																		</c:forEach>
																	</tr>
                                                                                                                                     
																	
																</tbody>
															</table>
														</div>
													</div>
													</div>
                                                                                                                                        <c:if test="${isAuction eq 0}">
                                                                                                                                           <div class="box-header with-border">
														<h3 class="box-title">${tableData.tableFooter}</h3>
													</div> 
                                                                                                                                        </c:if>
													
												 </c:forEach>
												
											</div>
                                       
                                        </div>
                                        <div class="col-lg-12">
                                        <h3 style="padding-top:0px;margin-top:0px;">${formStructure['form'].formFooter}</h3>
                                        </div>
                                </div>
                            </div>                                         
                        </div>
                        <c:if test="${!fromView}">
	                        <div class="col-md-12 text-center">
                                    <c:if test="${isAuction ne 1}">
                                        <button type="button" class="btn btn-submit" id="btndraftForm" onclick='setDraftSaveValue(1)'>${varSaveAsDraft}</button>
                                    </c:if>
	                        	
	                            <button type="button" class="btn btn-submit" id="btnSubmitForm" onclick='setDraftSaveValue(2)'>Save</button>
	                        
	                        </div>
                        </c:if>
                        <input type="hidden" id="hdFormActionS" name="hdFormActionS" value="2">
                        <input type="hidden" id="hdnFormId" name="hdnFormId" value="${formId}">
                        <input type="hidden" id="hdnGTColumnValue" name="hdnGTColumnValue">
			<input type="hidden" id="txtJson" name="txtJson">
                        <input type="hidden" value="${tenderId}" name="tenderId">
                        <input type="hidden" value="${bidId}" name="hdBidId">
                        </form:form>
                    </div>
                </div>
                                            
            </section>
            </div>
<script src="${pageContext.request.contextPath}/resources/js/tender/ConvertToWord.js"></script>
<script type="text/javascript">
    
    var url = '${pageContext.servletContext.contextPath}/eBid/Bid/CurrentTimeAjax/${tenderId}';
    var isAuction='${tblTender.isAuction}';
    var LastBid='${LastBid}';
    var auctionMethod='${tblTender.auctionMethod}';
    var exchangeRate='${ExchangeRate}';
    var global='${tblTender.biddingType}';
    var sessionType='${sessionUserTypeId}';
    var decimal = '${tblTender.decimalValueUpto}';
    $(document).ready(function() {
    	GTCalculationOnLoad();
	    $(".clstxtcell").blur(function() {
                 var formula = $(this).closest("tr").find("#hdnFormula").val();
	         var rowid = "_" + $(this).attr("rowid");
	         var tableId=$(this).attr("tableId");
	         calculateFormula(formula,rowid,this,tableId);
	    });
	    $('[id^="lblGT_ToalAmTWords_"]').each(function () {
			this.innerHTML = DoIt(this.innerHTML);
		});
                
             var interval=null;
        var tenderId='${tenderId}';
        if(parseInt(isAuction)===1)
        {
            $.ajaxSetup({ cache: false }); 
            interval=setInterval(function() {$("#divCurrentTime").load(url); }, 1000);
            var urlValid='${pageContext.servletContext.contextPath}/eBid/Bid/bidSubmissionValidationForAuction/${tenderId}';
            $.ajaxSetup({ cache: false }); 
            interval=setInterval(function() 
            {
                $("#ValidationMsg").load(urlValid);
                if($('#ValidationMsg').html().trim().length > 0)
                {
                    if($('#ValidationMsg').html().trim()==="Bidder is Not Mapped.")
                    {
                        window.location.href = '${pageContext.servletContext.contextPath}/notloggedin';
                    }
                    else
                    {
                        if($('#ValidationMsg:contains(Auction has been resumed,)').length > 0)
                        {
                            $('#btnSubmitForm').show();
                        }
                        else
                        {
                            $('#btnSubmitForm').hide();
                            $('#validationMsgDiv').show();    
                        }
                    }
                    
                    
                }
                else
                {
                    $('#ValidationMsg').html('');
                    $('#btnSubmitForm').show();
                    $('#validationMsgDiv').hide();
                }
            }, 1000);
            var endDate;
       endDate = '${auctionEndDate}';
       
    var find = '-';
   	var re = new RegExp(find, 'g');
   	endDate = endDate.replace(re, '/');
   	endDate = new Date(endDate);
	var timeOverMsg = 'Bidding time is over.';
	var msgAppended = 'Remaining bidding time :';
	var submissionDateOver = '${submissionDateOver}';
        
	if(submissionDateOver == 'true'){
           
		showRemaining(endDate,msgAppended,timeOverMsg);
	}else{
           
		timer = setInterval(function(){
		showRemaining(endDate,msgAppended,timeOverMsg)}, 1000);
	}
        
        $.ajax({
		type : "GET",
		async:false,
		url : contextPath+"/common/user/getClientDateTime",
		success : function(data) {
			lastDateTime = new Date(data);
			setInterval(function(){
				startBiddingTime();
			},1000);
		},
		error : function(e) {
			console.log(e);	
		},
	});
        }       
});
function startBiddingTime() {
  var h = getFullNumber(lastDateTime.getHours());
  var m = getFullNumber(lastDateTime.getMinutes());
  lastDateTime.setSeconds(lastDateTime.getSeconds()+1);
  var s = getFullNumber(lastDateTime.getSeconds());
  var dispalyDateTime = lastDateTime.getDate()+ '-' + cal_months_names[lastDateTime.getMonth()] + '-' +  lastDateTime.getFullYear()+' '+h+':'+m+':'+s
  $('#divServerCurrentTime').html(dispalyDateTime);
}
    function GTCalculationOnLoad(){
        $('[id^="trGT_"]').each(function () {
            $(this).find('[id^="lblGT_"]').each(function () {
         
            var sum = 0;        
            var colid1 = $(this).attr("colId");
                $('[id^="txtcell_0_' + $(this).attr("colId") + '"]').each(function () {
                    var intval = 0;
                    if ($(this).val().length != 0) {
                        intval = parseFloat($(this).val())
                    }
                    sum += intval;
                    if(parseInt(isAuction)===1)
                    {
                        var upToDecimal = 1;
                        for(var i = 0 ; i < parseInt(decimal) ; i++)
                        {
                            upToDecimal = upToDecimal * 10 ;
                        }
                        $("#lblGT_" + colid1).text(Math.round(eval(eval(sum) * upToDecimal)) / upToDecimal);
                    }
                    else
                    {
                        $("#lblGT_" + colid1).text(Math.round(eval(eval(sum) * 1000000)) / 1000000);
                    }
                    
                });
                var sum2 = 0;
                $('[id^="tbl_').each(function () {
                        $(this).find('[id^="result"]').each(function () {
                            if ($(this).parent().attr("colkey") == colid1) {
                                var intval = 0;
                                if ($(this).val().length != 0) {
                                    intval = parseFloat($(this).val())
                                }
                                sum2 += intval;
                                
                                if(parseInt(isAuction)===1)
                                {
                                    var upToDecimal = 1;
                                    for(var i = 0 ; i < parseInt(decimal) ; i++)
                                    {
                                        upToDecimal = upToDecimal * 10 ;
                                    }
                                    $("#lblGT_"+colid1).text(Math.round(eval(eval(sum2)*upToDecimal))/upToDecimal);  
                                    if(parseInt(isAuction)===1 && parseInt(global)===2 && parseInt(sessionType)===2)
                                    {
                                        var s1 = Math.round(eval(eval(sum2)*upToDecimal))/upToDecimal;
                                        var e1 = Math.round(eval(eval(exchangeRate)*upToDecimal))/upToDecimal;
                                        $('#lblGTBase'+colid1).text(Math.round(eval(eval(s1) * eval(e1) * upToDecimal)/upToDecimal));
                                    }
                                }
                                else
                                {
                                    $("#lblGT_"+colid1).text(Math.round(eval(eval(sum2)*1000000))/1000000);  
                                }
                                    
                               
                            }
                        });
                    });
                });
            });
        }
       
function calculateFormula(formula,rowid,cmd,tableId)
{
   
    var regex = /([\+\-\*\(\)\/])/;
     $(cmd).closest("tr").find('input:disabled').each(function() {
        var ResultStr="";
        var arrIds = "";
        formula = $(this).attr("attrformula");
        if(formula.length != 0 && $(this).parent().attr("filledby") == "3") {
            arrIds= formula.split(regex);
            cellID =  $(this).parent().attr("cellid");
            
            for(var i=0;i<arrIds.length;i++)
            {
            if((arrIds[i]).match("_"))
            {
                if(document.getElementById(arrIds[i] + rowid)!==null)
                {
                   if(parseFloat(trim(document.getElementById(arrIds[i] + rowid).value)) != 0){
                        ResultStr += trim(document.getElementById(arrIds[i] + rowid).value); //.replace(/^[0]+/g,""));
                   }
                   else
                   {
                      ResultStr += '0';
                   }
                }
                else if (document.getElementsByClassName(arrIds[i] + rowid) != null){
                    
                    var idforresultclm = document.getElementsByClassName(arrIds[i] + rowid)[0].id;
                     if(parseFloat(trim(document.getElementById(idforresultclm).value)) != 0){
                        ResultStr += trim(document.getElementById(idforresultclm).value); //.replace(/^[0]+/g,""));
                     }
                   else
                   {
                      ResultStr += '0';
                   }
                }
                else
                {
                      ResultStr += '0';
                }
            }
            else
            {
                ResultStr += arrIds[i];
            }
        }
        if(parseInt(isAuction)===1)
        {
            var upToDecimal = 1;
            for(var i = 0 ; i < parseInt(decimal) ; i++)
            {
                upToDecimal = upToDecimal * 10 ;
            }
            $("#" + $(this)[0].id).val(Math.round(eval(eval(ResultStr)*upToDecimal))/upToDecimal);
        }
        else
        {
            $("#" + $(this)[0].id).val(Math.round(eval(eval(ResultStr)*1000000))/1000000);
        }
        
    }
    });
        
        $('#trGT_'+tableId).each(function(){
            $(this).find('[id^="lblGT_"]').each(function () {
                var sum=0;
                var colid1 =  $(this).attr("colId");
                $('[id^="txtcell_0_'+$(this).attr("colId")+'"]').each(function () {
                  var intval = 0;
                    if($(this).val().length != 0){
                        intval = parseFloat($(this).val())                
                    } 
                     sum += intval;
                     if(parseInt(isAuction)===1)
                     {
                        var upToDecimal = 1;
                        for(var i = 0 ; i < parseInt(decimal) ; i++)
                        {
                           upToDecimal = upToDecimal * 10 ;
                        }
                        $("#lblGT_"+colid1).text(Math.round(eval(eval(sum)*1000))/1000);
                     }
                     else
                     {
                         $("#lblGT_"+colid1).text(Math.round(eval(eval(sum)*1000000))/1000000);
                     }
                      
                });
                 
                var sum2=0;
                 $('[id^="tbl_').each(function () {
                     if($(this).attr("tableid")==tableId){
                    $(this).find('[id^="result"]').each(function () {
                        if($(this).parent().attr("colkey") == colid1){
                       var intval = 0;
                        if($(this).val().length != 0){
                            intval = parseFloat($(this).val())                
                        } 
                        sum2 += intval;
                        if(parseInt(isAuction)===1)
                        {
                            var upToDecimal = 1;
                            for(var i = 0 ; i < parseInt(decimal) ; i++)
                            {
                                upToDecimal = upToDecimal * 10 ;
                            }
                            $("#lblGT_"+colid1).text(Math.round(eval(eval(sum2)*upToDecimal))/upToDecimal);  
                            if(parseInt(isAuction)===1 && parseInt(global)===2 && parseInt(sessionType)===2)
                            {
                                var s1 = Math.round(eval(eval(sum2)*upToDecimal))/upToDecimal;
                                var e1 = Math.round(eval(eval(exchangeRate)*upToDecimal))/upToDecimal;
                                $('#lblGTBase'+colid1).text(Math.round(eval(eval(s1) * eval(e1) * upToDecimal)/upToDecimal));
                            }
                        }
                        else
                        {
                            $("#lblGT_"+colid1).text(Math.round(eval(eval(sum2)*1000000))/1000000);  
                        }
                            
                        }
                    });
                    }
                 });
            });
        });
    }
        
    function trim(s)
    {
        while (s.substring(0,1) == ' ')
        {
            s = s.substring(1,s.length);
        }
        while (s.substring(s.length-1,s.length) == ' ')
        {
            s = s.substring(0,s.length-1);
        }
      
        return s;
    } 
    function setDraftSaveValue(value){
    
    	$('#hdFormActionS').val(value);
        if(parseInt(value)==2)
        {
            if(parseInt(isAuction)==1)
            {
                
                    var val=0;
                    var per=0;
                    var incr='${tblTender.incrementDecrementValues}';
                    if(parseInt(auctionMethod)==1)
                    {
                         val=parseInt(LastBid)+parseInt(incr);
                         per=((parseInt(val)-parseInt(LastBid))/parseInt(LastBid))*100;
                         
                    }else
                    {
                         val=parseInt(LastBid)-parseInt(incr);
                         per=((parseInt(LastBid)-parseInt(val))/parseInt(LastBid))*100;

                    }
                   //  alert('Bid variation with respect to your last bid amount is <'+per+'>%');
                
            }
        }
    return createJson();
		//$( "#bidForm" ).submit();
	}
    
    function createJson(){
   	var vbool =true;
   	$('[id^="txtcell"]').each(function () {
		if($(this).val() == '' && $(this).attr("tableMand") == 1){
			vbool = false;
			alert('Please fill form');
			return vbool;
		}
	});
	if(vbool){
    var ArrTableJson={};
    
    var cnt = 0;
    var count=0;
    var colNo=0;

    $('[id^="tbl_"]').each(function () {
       var TableJson={};
        TableJson['FormId']= $('#hdnFormId').val();
         TableJson['TableId']=$(this).attr("tableId");
         
          var ArrColumnJson={}
          count=0;
        $("#tbl_"+ cnt).find("tbody tr").each(function () {
            colNo=0;
            $(this).find("td").each(function () { 
            	if($(this).attr("cellID")!=undefined){
          
   
            var ColumnJson={};
            var val;
                if($(this).find("input[type=text]").length){
                    console.log("Row: " + $(this).attr("trid") + " ,Key: " + $(this).attr("colKey") +  " , val: " + $(this).find("input[type=text]").val()+", Cell Id:"+$(this).attr("cellID"));
                    val="Row: " + $(this).attr("trid") + " ,Key: " + $(this).attr("colKey") +  " , val: " + $(this).find("input[type=text]").val();
                    ColumnJson['row']=$(this).attr("trid");
                    ColumnJson['key']=$(this).attr("colKey");
                    ColumnJson['val']=$(this).find("input[type=text]").val();
                    ColumnJson['cellId']=$(this).attr("cellID");
                    ColumnJson['filledBy']=$(this).attr("filledBy");

                    
            }
                else if($(this).find("label").length){
                         console.log("Row: " + $(this).attr("trid") + " ,Key: " + $(this).attr("colKey") +  " , val: " + $(this).find("label").text()+", Cell Id:"+$(this).attr("cellID"));
                        val="Row: " + $(this).attr("trid") + " ,Key: " + $(this).attr("colKey") +  " , val: " + $(this).find("label").text();
                        ColumnJson['row']=$(this).attr("trid");
                    ColumnJson['key']=$(this).attr("colKey");
                    ColumnJson['val']=$(this).find("label").text();
                    ColumnJson['cellId']=$(this).attr("cellID");
                    ColumnJson['filledBy']=$(this).attr("filledBy");
                    
            }
                else if($(this).find("select").length){
                         console.log("Row: " + $(this).attr("trid") + " ,Key: " + $(this).attr("colKey") +  " , val: " + $(this).find("select").val()+", Cell Id:"+$(this).attr("cellID"));
               val="Row: " + $(this).attr("trid") + " ,Key: " + $(this).attr("colKey") +  " , val: " + $(this).find("select").val();
               ColumnJson['row']=$(this).attr("trid");
                    ColumnJson['key']=$(this).attr("colKey");
                    ColumnJson['val']=$(this).find("select").val();
                    ColumnJson['cellId']=$(this).attr("cellID");
                    ColumnJson['filledBy']=$(this).attr("filledBy");
                    
            }
                else if($(this).find("input[type=number]").length){
                         console.log("Row: " + $(this).attr("trid") + " ,Key: " + $(this).attr("colKey") +  " , val: " + $(this).find("input[type=number]").val()+", Cell Id:"+$(this).attr("cellID"));
               val="Row: " + $(this).attr("trid") + " ,Key: " + $(this).attr("colKey") +  " , val: " + $(this).find("input[type=number]").val();
                ColumnJson['row']=$(this).attr("trid");
                    ColumnJson['key']=$(this).attr("colKey");
                    ColumnJson['val']=$(this).find("input[type=number]").val();
                    ColumnJson['cellId']=$(this).attr("cellID");
                    ColumnJson['filledBy']=$(this).attr("filledBy");
                    
            }
                else if($(this).find("input[type=file]").length){
                        console.log("Row: " + $(this).attr("trid") + " ,Key: " + $(this).attr("colKey") +  " , val: " + $(this).find("input[type=file]").val()+", Cell Id:"+$(this).attr("cellID"));
                val="Row: " + $(this).attr("trid") + " ,Key: " + $(this).attr("colKey") +  " , val: " + $(this).find("input[type=file]").val();
                ColumnJson['row']=$(this).attr("trid");
                    ColumnJson['key']=$(this).attr("colKey");
                    ColumnJson['val']=$(this).find("input[type=file]").val();
                    ColumnJson['cellId']=$(this).attr("cellID");
                    ColumnJson['filledBy']=$(this).attr("filledBy");
                    
            }
                else if($(this).find("input[type=date]").length){
                        console.log("Row: " + $(this).attr("trid") + " ,Key: " + $(this).attr("colKey") +  " , val: " + $(this).find("input[type=date]").val()+", Cell Id:"+$(this).attr("cellID"));
                 val="Row: " + $(this).attr("trid") + " ,Key: " + $(this).attr("colKey") +  " , val: " + $(this).find("input[type=date]").val();
               
                ColumnJson['row']=$(this).attr("trid");
                    ColumnJson['key']=$(this).attr("colKey");
                    ColumnJson['val']=$(this).find("input[type=date]").val();
                    ColumnJson['cellId']=$(this).attr("cellID");
                    ColumnJson['filledBy']=$(this).attr("filledBy");
                    
            }
            else if($(this).find("textarea").length){
                         console.log("Row: " + $(this).attr("trid") + " ,Key: " + $(this).attr("colKey") +  " , val: " + $(this).find("label").text()+", Cell Id:"+$(this).attr("cellID"));
                        val="Row: " + $(this).attr("trid") + " ,Key: " + $(this).attr("colKey") +  " , val: " + $(this).find("label").text();
                        ColumnJson['row']=$(this).attr("trid");
                    ColumnJson['key']=$(this).attr("colKey");
                    ColumnJson['val']=$(this).find("label").text();
                    ColumnJson['cellId']=$(this).attr("cellID");
                    ColumnJson['filledBy']=$(this).attr("filledBy");
                    
            }
                ColumnJson['colNo']=colNo++;
               
                  ArrColumnJson['column'+count]=ColumnJson;
                  count++;
             
            	}
        });
        
        });
         TableJson['ColumnJsonval']=ArrColumnJson;
          ArrTableJson['TableJson'+cnt]=TableJson;
        
        cnt++;
          
    });
    
    var jsonObj={};
    jsonObj['TableJson']=ArrTableJson;
      var jstr=JSON.stringify(ArrTableJson);
  
      $('#txtJson').val(jstr);
   
           var ArrGTColumnJson={};
      
       $('[id^="trGT_"]').each(function () {
            $(this).find('[id^="lblGT_"]').each(function () {
               var GTSubJson={};
                    GTSubJson['colId'] = $(this).attr("colId");
                    GTSubJson['TableId'] =  $(this).attr("TableId");
                    GTSubJson['FormId'] =  $('#hdnFormId').val();
                    if(parseInt(isAuction)===1 && parseInt(global)===2 && parseInt(sessionType)===2)
                    {
                        var upToDecimal = 1;
                        for(var i = 0 ; i < parseInt(decimal) ; i++)
                        {
                            upToDecimal = upToDecimal * 10 ;
                        }
                        var Total = $(this).text();
                        var s1 = Math.round(eval(eval(Total)*upToDecimal))/upToDecimal;
                        var e1 = Math.round(eval(eval(exchangeRate)*upToDecimal))/upToDecimal;
                       
                        GTSubJson['GTValue'] = Math.round(eval(eval(s1) * eval(e1) * upToDecimal)/upToDecimal);
                    }
                    else
                    {
                        GTSubJson['GTValue'] = $(this).text();
                    }
                    var jsonV = "GTColumn_"+ $(this).attr("colId");
                    ArrGTColumnJson[jsonV] = GTSubJson;
                });
            });
    
        var jstrGT=JSON.stringify(ArrGTColumnJson);
        $('#hdnGTColumnValue').val(jstrGT);
        $('#btndraftForm').attr('disabled','disabled');
        $('#btnSubmitForm').attr('disabled','disabled');
        $( "#bidForm" ).submit();
    		return true;
 		}else{
 			return false;			
 		}
    }
</script>
 <script src="${pageContext.servletContext.contextPath}/resources/js/jquery-ui.min.js"></script>
<%@include file="../../includes/footer.jsp"%>
