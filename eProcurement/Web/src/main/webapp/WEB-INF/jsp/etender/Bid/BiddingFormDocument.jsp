<%@include file="../../includes/head.jsp"%>
<%@include file="../../includes/masterheader.jsp"%>
<div class="content-wrapper">
            <section class="content-header">
                <h1>
                    <spring:message code="lbl_create_edit_bidding_form" /> <small></small>
                </h1>
            </section>
            <section class="content">
                <c:if test="${not empty successMsg}">
                    <div class="alert alert-success">${successMsg}</div>
                </c:if>
                <c:if test="${not empty errorMsg}">
                    <div class="alert alert-danger">${errorMsg}</div>
                </c:if>
                <form id="DocumentFormBean" name="DocumentFormBean" action="${pageContext.servletContext.contextPath}/eBid/Bid/saveFormDocument"  method="post"  onsubmit="if(valOnSubmit()){return createJSON();} else {return false ;}" novalidate>

                <div class="row"> 
                    <div class="col-lg-12 col-md-12">
                        <div class="box">
                            <div class="box-header with-border">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="col-md-6 pull-left">
                                          
                                        </div>
                                        <div class="col-md-6 text-right">
                                           <a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}" ><< <spring:message code="lbl_go_back_to_dashboard" /></a>
                                            
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
                                                            <div class="form_filed pull-left">${FormBean.FormName}</div>
                                                        </div>
                                                        <div class="col-sm-2 col-md-2">
                                                            <div class="form_filed text-black text-right"><spring:message code="lbl_createdon" /></div>
                                                        </div>
                                                        <div class="col-sm-2 col-md-2">
                                                            <div class="form_filed pull-left">${FormBean.CreatedOn}</div>
                                                        </div>
                                    </div>                          <c:set var="DocReqVal1" value="No"/>
                              
                                                            <c:if test="${FormBean.IsDocReq eq 0}">
                                                                <c:set var="DocReqVal1" value="No"/>
                                                            </c:if>
                                                            <c:if test="${FormBean.IsDocReq eq 1}">
                                                                <c:set var="DocReqVal1" value="Yes"/>
                                                            </c:if>
                                                        
                                                           
                                     <div class="col-md-12">
                                                        <div class="col-sm-2 col-md-2">
                                                            <div class="form_filed text-right text-black"><spring:message code="lbl_is_document_require" /></div>
                                                        </div>
                                                        <div class="col-sm-2 col-md-2">
                                                            <div class="form_filed  pull-left">${DocReqVal1}</div>
                                                        </div>
                                                           <c:set var="IsMandatory" value="No"/>
                                                        <c:if test="${FormBean.IsMandatory eq 0}">
                                                                <c:set var="IsMandatory" value="No"/>
                                                            </c:if>
                                                            <c:if test="${FormBean.IsMandatory eq 1}">
                                                                <c:set var="IsMandatory" value="Yes"/>
                                                            </c:if>
                                                       
                                                        <div class="col-sm-2 col-md-2">
                                                            <div class="form_filed  text-right text-black"><spring:message code="lbl_is_mandatory" /></div>
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
                                                            <div class="form_filed text-right text-black"><spring:message code="lbl_is_price_bid_form" /></div>
                                                        </div>
                                                        <div class="col-sm-2 col-md-2">
                                                            <div class="form_filed  pull-left">${IsPriceBid}</div>
                                                        </div>
                                                    </div>
                                                    </div>
                              
                                                    
                                                   
						</div>

						<div class="box-body">
							<div class="row">
                                                            <div class="col-md-12 text-right" style="padding: 20px;"><button type="button" class="btn btn-info" id="btnAddNewDocument"><i class="fa fa-add"></i>&nbsp;<spring:message code="lbl_add_new" /></button></div>
								<div class="col-lg-12 col-md-12 col-xs-12">
                                                                    
                                                                     
									<table class="table table-striped table-responsive">
										<thead>
											<tr>
                                                                                            <th class="text-center"><spring:message code="lbl_No." /></th>
												<th  class="text-center"><spring:message code="fields_tender_docname" /></th>
												<th  class="text-center"><spring:message code="lbl_is_mandatory" /></th>
												<th  class="text-center"><spring:message code="col_action" /></th>
											</tr>
										</thead>
										<tbody id="dvMainDocumentForm">
                                                                                   
                                                                                    
										</tbody>
                                                                            <tfoot>
                                                                              
                                                                                <tr>
                                                                                        <td colspan="4" align="center">
                                                                                             <input type="hidden" id="DocumentJson" name="DocumentJson">
                                                                                             <input type="hidden" id="formId" value="${formId}" name="formId">
                                                                                             <input type="hidden" id="tenderId" value="${tenderId}" name="tenderId">
                                                                                            
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
                                    
                                    
                                   
                                    <th><spring:message code="lbl_No." /></th>
                                    <th><spring:message code="fields_tender_docname" /></th>
                                    <th><spring:message code="lbl_is_mandatory" /></th>
                                    <th><spring:message code="link_tender_edit" /></th>
                                    <th><spring:message code="link_delete_corrigendum" /></th>
                                    
                                </tr>
                            </thead>
                            <tbody>
                                <c:if test="${documentId eq 0}">
                                     <c:set var="i" value="1"/>
                                 <c:forEach items="${DocumentGrid}" var="element">
                                     <tr>
                                     <td>${i}</td>
                                     <td>${element.documentName}</td>
                                     <c:if test="${element.isMandatory eq 1}">
                                         <td>${'Yes'}</td>   
                                     </c:if>
                                         <c:if test="${element.isMandatory eq 0}">
                                             
                                         <td>${'No'}</td>   
                                     </c:if>
                                     <td><a href="${pageContext.servletContext.contextPath}/eBid/Bid/EditDocumentForm/${tenderId}/${formId}/${element.documentId}"><i class="fa fa-pencil tb"></i></a></td>
                                    <td><a href="${pageContext.servletContext.contextPath}/eBid/Bid/deleteFormDocument/${tenderId}/${formId}/${element.documentId}"><i class="fa fa-trash tb"></i></a></td>
                                   
                                     </tr>
                                    <c:set var="i" value="${i + 1}" scope="page"/>
                                    </c:forEach>
                                </c:if>
                                <c:if test="${documentId != 0}">
                                    <c:set var="i" value="1"/>
                                 <c:forEach items="${DocumentGrid}" var="element">
                                     <c:if test="${documentId eq element.documentId}">
                                         <form action="${pageContext.servletContext.contextPath}/eBid/Bid/UpdateDocumentform"  method="post"  onsubmit="">
                                             <tr>
                                     <td>${i}</td>
                                     <td><input type="text" name="documentName" value="${element.documentName}"></td>
                                     <c:if test="${element.isMandatory eq 1}">
                                         <td><input type="checkbox" name="isMandatory" value="1" checked></td>   
                                     </c:if>
                                         <c:if test="${element.isMandatory eq 0}">
                                             
                                         <td><input type="checkbox" name="isMandatory" value="1"  ></td>   
                                     </c:if>
                                         <td>
                                              <input type="hidden" id="formId" value="${formId}" name="formId">
                                              <input type="hidden" id="tenderId" value="${tenderId}" name="tenderId">
                                              <input type="hidden" id="documentId" value="${documentId}" name="documentId">
                                             <button type="submit" class="btn btn-submit" id="btnSubmitForm"><spring:message code="btn_update" /></button>
                                             <button type="button" class="btn btn-submit"><spring:message code="lbl_reset" /></button>
                                         </td>
                                         <td><a href="${pageContext.servletContext.contextPath}/eBid/Bid/deleteFormDocument/${tenderId}/${formId}/${element.documentId}"><i class="fa fa-trash tb"></i></a></td>
                                   
                                     </tr>
                                         </form>  
                                         
                                     </c:if>
                                     <c:if test="${documentId != element.documentId}">
                                         <tr>
                                     <td>${i}</td>
                                     <td>${element.documentName}</td>
                                     <c:if test="${element.isMandatory eq 1}">
                                         <td>${'Yes'}</td>   
                                     </c:if>
                                         <c:if test="${element.isMandatory eq 0}">
                                             
                                         <td>${'No'}</td>   
                                     </c:if>
                                     <td><a href="${pageContext.servletContext.contextPath}/eBid/Bid/EditDocumentForm/${tenderId}/${formId}/${element.documentId}"><i class="fa fa-pencil tb"></i></a></td>
                                    <td><a href="${pageContext.servletContext.contextPath}/eBid/Bid/deleteFormDocument/${tenderId}/${formId}/${element.documentId}"><i class="fa fa-trash tb"></i></a></td>
                                   
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
                <script src="${pageContext.servletContext.contextPath}/resources/PageJS/FormDocument.js" type="text/javascript"></script>
<%@include file="../../includes/footer.jsp"%>

</body>
</html>
