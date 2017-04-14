<%@include file="../../includes/head.jsp"%>
<%@include file="../../includes/masterheader.jsp"%>
 <%@page import="org.json.JSONObject"%>
<%@page import="java.util.Map"%>
   <%
    Map evaluationColumnMap=(Map)request.getAttribute("EvaluationColumnMap");
    JSONObject jsonObject=new JSONObject(evaluationColumnMap);
    String jsonString=jsonObject.toString();
   // pageContext.setAttribute("EvaluationColumn", jsonObject);
    %>

 <div class="content-wrapper">
            <section class="content-header">
                <h1>
                   <spring:message code="lbl_create/edit_evaluation_column" /> <small></small>
                </h1>
               
       
            </section>
            <section class="content">
                <form id="DocumentFormBean" name="DocumentFormBean" action="${pageContext.servletContext.contextPath}/eBid/Bid/saveEvaluationColumn"  method="post"  onsubmit="return createJSON();">
                    <div class="row">
                    <div class="col-lg-12 col-md-12">
                        <div class="box">
                            <div class="box-header with-border">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="col-md-6 pull-left">
                                           
                                        </div>
                                        <div class="col-md-6 text-right">
                                           <a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}" ><< <spring:message code="lbl_go_back_to_dashboard" />
                                            </a>
                                         </div>
                                    </div>
                                    <div class="col-md-12">
                                                        <div class="col-sm-2 col-md-2">
                                                            <div class="form_filed text-black text-right"><spring:message code="lbl_form_id" /></div>
                                                        </div>
                                                        <div class="col-sm-2 col-md-2">
                                                            <div class="form_filed pull-left">${formId}</div>
                                                        </div>
                                                        <div class="col-sm-2 col-md-2">
                                                            <div class="form_filed text-black text-right" ><spring:message code="field_formName" /></div>
                                                        </div>
                                                        <div class="col-sm-2 col-md-2">
                                                            <div class="form_filed pull-left">${tblTenderForm.FormName}</div>
                                                        </div>
                                                        <div class="col-sm-2 col-md-2">
                                                            <div class="form_filed text-black text-right"><spring:message code="lbl_createdon" /></div>
                                                        </div>
                                                        <div class="col-sm-2 col-md-2">
                                                            <div class="form_filed pull-left">${tblTenderForm.CreatedOn}</div>
                                                        </div>
                                    </div>
                                                        <c:set var="DocReqVal" value="No"/>
                                                         <c:if test="${tblTenderForm.IsDocReq eq 0}">
                                                                <c:set var="DocReqVal" value="No"/>
                                                            </c:if>
                                                            <c:if test="${tblTenderForm.IsDocReq eq 1}">
                                                                <c:set var="DocReqVal" value="Yes"/>
                                                            </c:if>
                                                            
                                     <div class="col-md-12">
                                                        <div class="col-sm-2 col-md-2">
                                                            <div class="form_filed text-right text-black"><spring:message code="lbl_is_document_require" /></div>
                                                        </div>
                                                        <div class="col-sm-2 col-md-2">
                                                            <div class="form_filed  pull-left">${DocReqVal}</div>
                                                        </div>
                                                        <c:set var="IsMandatory" value="No"/>
                                                            <c:if test="${tblTenderForm.IsMandatory eq 0}">
                                                                <c:set var="IsMandatory" value="No"/>
                                                            </c:if>
                                                            <c:if test="${tblTenderForm.IsMandatory eq 1}">
                                                                <c:set var="IsMandatory" value="Yes"/>
                                                            </c:if>               
                                         
                                                        <div class="col-sm-2 col-md-2">
                                                            <div class="form_filed  text-right text-black"><spring:message code="lbl_is_mandatory" /></div>
                                                        </div>
                                                        <div class="col-sm-2 col-md-2">
                                                            
                                                            <div class="form_filed  pull-left">${IsMandatory}</div>
                                                        </div>
                                                        <c:set var="IsPriceBid" value="No"/>
                                                         <c:if test="${tblTenderForm.IsPriceBid eq 0}">
                                                                <c:set var="IsPriceBid" value="No"/>
                                                            </c:if>
                                                            <c:if test="${tblTenderForm.IsPriceBid eq 1}">
                                                                <c:set var="IsPriceBid" value="Yes"/>
                                                            </c:if>
                                                     
                                                        <div class="col-sm-2 col-md-2">
                                                            <div class="form_filed text-right text-black">
<spring:message code="lbl_is_price_bid_form" />
</div>
                                                        </div>
                                                        <div class="col-sm-2 col-md-2">
                                                            <div class="form_filed  pull-left">${IsPriceBid}</div>
                                                        </div>
                                                        <div class="col-sm-2 col-md-2">
                                                            <div class="form_filed text-right text-black"><spring:message code="lbl_envelop" /></div>
                                                        </div>
                                                        <div class="col-sm-2 col-md-2">
                                                            <div class="form_filed  pull-left">${tblTenderForm.envelopeName}</div>
                                                        </div>
                                                    </div>
                                </div>
						</div>

						<div class="box-body">
							<div class="row">

								<div class="col-lg-12 col-md-12 col-xs-12">
									<table class="table table-striped table-responsive">
										<thead>
											<tr>
                                                                                            <th class="text-center"><spring:message code="lbl_No." /></th>
												<th  class="text-center"><spring:message code="lbl_table_name" /></th>
												<th  class="text-center"><spring:message code="lbl_evaluation_column" /></th>
												
											</tr>
										</thead>
										<tbody class="row" id="dvMainDocumentForm">
                                            
                                                                                    </tbody>
                                                                            <tfoot>
                                                                                <tr>
                                                                                        <td colspan="3" align="center">
                                                                                            <input type="hidden" id="EvaluationColumnJson" name="EvaluationColumnJson">
                                                                                                <input type="hidden" id="formId" value="${formId}" name="formId">
                                                                                                <input type="hidden" id="tenderId" value="${tenderId}" name="tenderId">
                                                                                                <div id="jsonString" style="display: none"><%=jsonObject%></div>
                                                                                             
                                                                                                <button type="submit" class="btn btn-submit" id="btnSubmitForm"><spring:message code="label_submit" /></button>
                                                                                               
                                                                                        </td>
                                                                                    </tr>
                                                                            </tfoot>
									</table>
								</div>

							</div>
						</div>

					</div>

				</div>
                            </div>
                
                   
                </form>
               <div class="table-responsive  box-body " >
                        <table id="example1" class="table table-bordered table-striped">
                            <thead>
                                <tr>
                                    <th><spring:message code="label_no" /></th>
                                    <th><spring:message code="lbl_table_name" /></th>
                                    <th><spring:message code="lbl_evaluation_column" /></th>
                                    <th><spring:message code="link_tender_edit" /></th>
                                    <th><spring:message code="link_delete_corrigendum" /></th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:if test="${empty govColumnId}">
                                    <c:set var="i" value="1"/>
                                    <c:forEach items="${GridData}" var="element">
                                        <tr>
                                                <td>${i}</td>
                                                <td>${element.tblTenderTable.tableName}</td>
                                                <td>${element.tblTenderColumn.columnHeader}</td>
                                                <td><a href="${pageContext.servletContext.contextPath}/eBid/Bid/EditEvaluationColumn/${tenderId}/${formId}/${element.govColumnId}/0"><i class="fa fa-pencil tb"></i></a></td>
                                                <td><a href="${pageContext.servletContext.contextPath}/eBid/Bid/deleteEvaluationColumn/${tenderId}/${formId}/${element.govColumnId}/${element.cellId}/${element.columnNo}/${element.ipAddress}" ><i class="fa fa-trash tb"></i></a></td>
                                        </tr>
                                    <c:set var="i" value="${i + 1}" scope="page"/>
                                    </c:forEach>
                                </c:if>
                                <c:if test="${not empty govColumnId}">
                                    <c:set var="i" value="1"/>
                                    <c:forEach items="${GridData}" var="element">
                                        <c:if test="${govColumnId eq element.govColumnId}">
                                            <form action="${pageContext.servletContext.contextPath}/eBid/Bid/UpdateEvaluationColumn"  method="post"  onsubmit="">
                                            <tr>
                                                <td>${i}</td>
                                                <td>${element.tblTenderTable.tableName} 
                                                  
                                                </td>
                                                <td><select id="optEvaluationCol" name="optEvaluationCol">
                                                    <c:forEach items="${EvaluationAllColumn.EvaluationColumn}" var="entry" >
                                                        <c:set var="tablename" value="${fn:split(entry.key,'$')}"/>
                                                        <c:set var="tId" value="${tablename[1]}"/>
                                                       
                                                        
                                                        
                                                            <c:if test="${tId eq element.tblTenderTable.tableId}">
                                                                <c:forEach items="${entry.value}" var="cited">
                                                                <c:if test="${cited.getInt('columnId') eq element.tblTenderColumn.columnId}">
                                                                <option value="${cited.getInt('columnId')}" selected>${cited.getString('columnHeader')}</option> 
                                                                </c:if>
                                                                 <c:if test="${cited.getInt('columnId') != element.tblTenderColumn.columnId}">
                                                                    <option value="${cited.getInt('columnId')}">${cited.getString('columnHeader')}</option> 
                                                                </c:if>
                                                                </c:forEach>
                                                            </c:if>
                                                            
                                                        
    
                                                    </c:forEach>   
                                                    </select></td>
                                               
                                                <td>
                                                    <input type="hidden" id="tableId" name="tableId" value="${element.tblTenderTable.tableId}">
                                                    <input type="hidden" id="cellId" name="cellId" value="${element.cellId}">
                                                    <input type="hidden" id="ColumnNo" name="ColumnNo" value="${element.columnNo}">
                                                     <input type="hidden" id="ipAdd" name="ipAdd" value="${element.ipAddress}">
                                                    <input type="hidden" id="formId" value="${formId}" name="formId">
                                                    <input type="hidden" id="tenderId" value="${tenderId}" name="tenderId">
                                                    <input type="hidden" id="documentId" value="${govColumnId}" name="govColumnId">
                                                    <button type="submit" class="btn btn-submit" id="btnSubmitForm"><spring:message code="btn_update" /></button>
                                                    
                                                </td>
                                            </form> 
                                                <td><a href="${pageContext.servletContext.contextPath}/eBid/Bid/deleteEvaluationColumn/${tenderId}/${formId}/${element.govColumnId}/${element.cellId}/${element.columnNo}/${element.ipAddress}" ><i class="fa fa-trash tb"></i></a></td>
                                            </tr>
                                        </c:if>
                                        <c:if test="${govColumnId != element.govColumnId}">
                                        <tr>
                                            <td>${i}</td>
                                                <td>${element.tblTenderTable.tableName}</td>
                                                <td>${element.tblTenderColumn.columnHeader}</td>
                                                <td><a href="${pageContext.servletContext.contextPath}/eBid/Bid/EditEvaluationColumn/${tenderId}/${formId}/${element.govColumnId}/0" ><i class="fa fa-pencil tb"></i></a></td>
                                                <td><a href="${pageContext.servletContext.contextPath}/eBid/Bid/deleteEvaluationColumn/${tenderId}/${formId}/${element.govColumnId}/${element.cellId}/${element.columnNo}/${element.ipAddress}" ><i class="fa fa-trash tb"></i></a></td>
                                        </tr>
                                        </c:if>
                                        <c:set var="i" value="${i + 1}" scope="page"/>
                                    </c:forEach>
                                </c:if>
                               
                            
                            
                            
                             
                            </tbody>
                            
                        </table>
                    </div>
            </section>
       </div>
                <script src="${pageContext.servletContext.contextPath}/resources/PageJS/EvaluationColumn.js" type="text/javascript"></script>
<%@include file="../../includes/footer.jsp"%>
