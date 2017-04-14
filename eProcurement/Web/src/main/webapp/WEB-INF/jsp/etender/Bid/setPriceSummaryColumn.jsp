<%@include file="../../includes/head.jsp"%>
<%@include file="../../includes/masterheader.jsp"%>
<div class="content-wrapper">
            <section class="content-header">
                <h1>
                   <spring:message code="lbl_create_edit_price_summary_column_form" /> <small></small>
                </h1>
               
       
            </section>
            <section class="content">
                <form id="DocumentFormBean" name="DocumentFormBean" action="${pageContext.servletContext.contextPath}/eBid/Bid/savePriceSummaryColumn"  method="post"  onsubmit="return createJSON();">
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
                                                            <div class="form_filed pull-left">${FormBean.FormName}</div>
                                                        </div>
                                                        <div class="col-sm-2 col-md-2">
                                                            <div class="form_filed text-black text-right"><spring:message code="lbl_createdon" /></div>
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
                                                            
                                                     <div class="col-md-12">
                                                        <div class="col-sm-2 col-md-2">
                                                            <div class="form_filed text-right text-black"><spring:message code="lbl_is_document_require" /></div>
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

								<div class="col-lg-12 col-md-12 col-xs-12">
									<table class="table table-striped table-responsive text-center">
										<thead>
											<tr>
                                                                                            <th class="text-center"><spring:message code="lbl_No." /></th>
												<th  class="text-center"><spring:message code="lbl_table_name" /></th>
												<th  class="text-center">
<spring:message code="lbl_price_summary_column" />
</th>
												
											</tr>
										</thead>
										<tbody class="row" id="dvMainDocumentForm">
                                                                                    <c:set var="i" value="0"/>
                                                                                    <c:forEach var="entry" items="${PriceSummaryColumn}">
                                                                                        <c:set var="i" value="${i+1}"/>
                                                                                        <c:set var="Key" value="${entry.key}"/>
                                                                                        <c:set var="Val_arr" value="${fn:split(Key,'_')}"/>
                                                                                        <tr id="trPriceSummary_${i}">
                                                                                             <td class="control-label">${i}</td>
                                                                                            <td class="control-label">${Val_arr[0]}
                                                                                                <input type="hidden" id="Table_${i}" value="${Val_arr[1]}">
                                                                                            </td>
                                                                                            <td><select id="Column_${i}">
                                                                                                    <option value="-1">
<spring:message code="label_select" />
</option>
                                                                                                    <c:forEach items="${entry.value}" var="value" >
                                                                                                       <c:if test="${value.isPriceSummary != 1}">
                                                                                                    <option value="${value.columnId}" >${value.columnHeader}</option>
                                                                                            </c:if>
                                                                                                            
                                                                                                       
                                                                                                    </c:forEach>
                                                                                                </select></td>
                                                                                        </tr>
                                                                                    </c:forEach>
                                                                                    </tbody>
                                                                            <tfoot>
                                                                                <tr>
                                                                                        <td colspan="3" align="center">
                                                                                            <input type="hidden" id="PriceSummryColumn" name="PriceSummryColumn">
                                                                                                <input type="hidden" id="formId" value="${formId}" name="formId">
                                                                                             <input type="hidden" id="tenderId" value="${tenderId}" name="tenderId">
                                                                                                
                                                                                                 <c:if test="${not empty PriceSummaryColumn}">
                                                                                            
                                                                                                <button type="submit" class="btn btn-submit" id="btnSubmitForm" onclick="return callForEvaluationColumn();"><spring:message code="label_submit" /></button>
                                                                                             </c:if>
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
                                                                                             <div class="box-body">
							<div class="row">

								<div class="col-lg-12 col-md-12 col-xs-12">
                                                                    <c:if test="${empty EditColumn}">
                                                                       
                                                                        <table class="table table-striped table-responsive text-center">
										<thead>
											<tr>
                                                                                            <th class="text-center"><spring:message code="lbl_No." /></th>
												<th  class="text-center"><spring:message code="lbl_table_name" /></th>
												<th  class="text-center"><spring:message code="lbl_price_summary_column" /></th>
												<th  class="text-center"><spring:message code="link_tender_edit" /></th>
												<th  class="text-center">Delete</th>
											</tr>
										</thead>
										<tbody class="row" id="dvMainDocumentForm">
                                                                                    <c:set var="i" value="0"/>
                                                                                    <c:forEach var="entry" items="${GridData}">
                                                                                        <c:set var="i" value="${i+1}"/>
                                                                                        <c:set var="Key" value="${entry.key}"/>
                                                                                        <c:set var="Val_arr" value="${fn:split(Key,'_')}"/>
                                                                                        <tr >
                                                                                            <c:forEach items="${entry.value}" var="value" >
                                                                                            <td class="control-label">${i}</td>
                                                                                            <td class="control-label">${Val_arr[0]}</td>
                                                                                            <td>
                                                                                            <c:if test="${value.isPriceSummary eq 1}">
                                                                                                    ${value.columnHeader}
                                                                                            </c:if>
                                                                                           </td>
                                                                                           <td><a href="${pageContext.servletContext.contextPath}/eBid/Bid/EditPriceSummaryColumn/${tenderId}/${formId}/${value.columnId}/${Val_arr[1]}"><i class="fa fa-pencil tb"></i></a></td>
                                                                                           <td><a href="${pageContext.servletContext.contextPath}/eBid/Bid/deletePriceSummaryColumn/${tenderId}/${formId}/${Val_arr[1]}" ><i class="fa fa-trash tb"></i></a></td></td>
                                                                                             </c:forEach>
                                                                                        </tr>
                                                                                    </c:forEach>
                                                                                    </tbody>
                                                                            <tfoot>
                                                                                
                                                                            </tfoot>
									</table>
                                                                    </c:if>
                                                                    <c:if test="${not empty EditColumn}">
                                                                        <table class="table table-striped table-responsive text-center">
										<thead>
											<tr>
                                                                                             <th class="text-center"><spring:message code="lbl_No." /></th>
												<th  class="text-center"><spring:message code="lbl_table_name" /></th>
												<th  class="text-center"><spring:message code="lbl_price_summary_column" /></th>
												<th  class="text-center"><spring:message code="link_tender_edit" /></th>
												<th  class="text-center"><spring:message code="link_delete_corrigendum" /></th>
											</tr>
										</thead>
										<tbody class="row" id="dvMainDocumentForm">
                                                                                    <c:set var="i" value="0"/>
                                                                                    <c:forEach var="entry" items="${PriceSummaryColumn}">
                                                                                        <c:set var="i" value="${i+1}"/>
                                                                                        <c:set var="Key" value="${entry.key}"/>
                                                                                        <c:set var="Val_arr" value="${fn:split(Key,'_')}"/>
                                                                                        <tr >
                                                                                            <td class="control-label">${i}</td>
                                                                                            <td class="control-label">${Val_arr[0]}</td>
                                                                                            <form action="${pageContext.servletContext.contextPath}/eBid/Bid/UpdatePriceSummaryColumn" method="post">
                                                                                                 <input type="hidden" name="PriceSummaryTableId" value="${Val_arr[1]}">
                                                                                                
                                                                                                 <c:if test="${EditTable eq Val_arr[1]}">
                                                                                                    <td>
                                                                                                        <select id="Column_${i}" name="PriceSummaryColumnId">
                                                                                                            <option value="-1">Please Select</option>
                                                                                                            <c:forEach items="${entry.value}" var="value" >
                                                                                                                <c:if test="${EditColumn != value.columnId}">
                                                                                                                    <option value="${value.columnId}" >${value.columnHeader}</option>
                                                                                                                </c:if>
                                                                                                                <c:if test="${EditColumn == value.columnId}">
                                                                                                                    <option value="${value.columnId}" selected >${value.columnHeader}</option>
                                                                                                                </c:if>
                                                                                                            </c:forEach>
                                                                                                        </select>
                                                                                                    </td>
                                                                                                             <input type="hidden" id="formId" value="${formId}" name="formId">
                                                                                                             <input type="hidden" id="tenderId" value="${tenderId}" name="tenderId">
                                                                                                    <td>
                                                                                                        <button type="submit" class="btn btn-submit"><spring:message code="btn_update" /></button>
                                                                                                       
                                                                                                    </td>
                                                                                                </c:if>
                                                                                            </form>
                                                                                       
                                                                                                <c:if test="${EditTable ne Val_arr[1]}">
                                                                                                    
                                                                                                    <c:forEach items="${entry.value}" var="value" >
                                                                                                        <c:if test="${value.isPriceSummary eq 1}">
                                                                                                            <td>
                                                                                                                ${value.columnHeader}
                                                                                                            </td>
                                                                                                        </c:if>
                                                                                                    </c:forEach>
                                                                                                    <td>
                                                                                                         <a href="${pageContext.servletContext.contextPath}/eBid/Bid/EditPriceSummaryColumn/${tenderId}/${formId}/${value.columnId}/${Val_arr[1]}">
                                                                                                             <i class="fa fa-pencil tb"></i>
                                                                                                         </a>
                                                                                                     </td>
                                                                                                </c:if>
                                                                                            
                                                                                                     <td>
                                                                                                         <a href="${pageContext.servletContext.contextPath}/eBid/Bid/deletePriceSummaryColumn/${tenderId}/${formId}/${Val_arr[1]}" >
                                                                                                             <i class="fa fa-trash tb"></i>
                                                                                                         </a>
                                                                                                     </td>
                                                                                           

                                                                                        </tr>
                                                                                    </c:forEach>
                                                                                    </tbody>
                                                                            <tfoot>
                                                                                
                                                                            </tfoot>
									</table>
                                                                    </c:if>
									
								</div>

							</div>
						</div>
               
            </section>
     </div>


<script>
function createJSON()
{
    var columselection = true;
     $('[id^="Column_"]').each(function() {
       if($(this).val() == -1){
            alert("Please select atleast one columnn for Price Summary");
            columselection = false;
       }
     });
     
     if(columselection == false){
         return false;
     }
    
    var cntTable = 0;
        $('[id^="trPriceSummary_"]').each(function() {
            cntTable++;
        });
        var MainJson={}
        var DocumentJson={}
        var ArrJsonObj={}
        
      for(var i=1;i<=cntTable;i++)
      {
          var JsonObj={}
         // alert('hello'+i);
          JsonObj['tableId']=$('#Table_'+i).val();
          JsonObj['columnId']=$('#Column_'+i).val();
          if(JsonObj['columnId']!=='-1')
          {
            ArrJsonObj['PriceSummary'+i]=JsonObj;
          }
      }
      DocumentJson['PriceSummaryColumnObj']=ArrJsonObj;
      DocumentJson['formId']=$('#formId').val();
      DocumentJson['tenderId']=$('#tenderId').val();
      
      $('#PriceSummryColumn').val(JSON.stringify(DocumentJson));
   ////   alert($('#PriceSummryColumn').val());
      return true;
}
</script>
<%@include file="../../includes/footer.jsp"%>

