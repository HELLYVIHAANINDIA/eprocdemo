<%@include file="../../includes/head.jsp"%>
<%@include file="../../includes/masterheader.jsp"%>

<%@page import="java.util.ArrayList"%>
<%@page import="com.eprocurement.etender.model.TblTenderFormula"%>
<%@page import="com.eprocurement.etender.model.TblTenderColumn"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Map"%>
<%@page import="com.eprocurement.etender.model.TblTenderEnvelope"%>
<%@page import="java.util.List"%>

    <%
         Map formulaMap = (Map) request.getAttribute("formulaMap");
         Map AutoColumn=(Map)formulaMap.get("AutoColumn");
        // out.println(AutoColumn.toString());
         Set AutoColumnSet=AutoColumn.keySet();
         Iterator itr=null;
         
         if(AutoColumnSet.size()>0)
            itr=AutoColumnSet.iterator();
         Map Columns=(Map)formulaMap.get("columnList");
         
        
         
         
         String formId=(String)formulaMap.get("formId");
         List<TblTenderFormula> lstColumnFormula=(List)formulaMap.get("FormulaGrid");
         String formulaCreated="0";
         String formulaDeleted="0";
         if(request.getAttribute("formulaCreated")!=null)
            formulaCreated=(String)request.getAttribute("formulaCreated");
         if(request.getAttribute("formulaDeleted")!=null)
            formulaDeleted=(String)request.getAttribute("formulaDeleted");
         ArrayList lstGrandTotal=(ArrayList)request.getAttribute("GrandTotalColumn");
            
    %>

<div class="content-wrapper">
            <section class="content-header">
                <h1>
                    Set Formula <small></small>
                </h1>
                
            </section>
            <section class="content">
                <div id="error" style="display: none">
    <div class="alert alert-danger" id="err_msg">
<spring:message code="lbl_formula_already_created" />
</div>
</div>

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
                                                        </div>   </div>
                                                            <c:if test="${isAuction eq 0}">
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
                                                        <div class="col-sm-2 col-md-2">
                                                            <div class="form_filed text-right text-black">Envelope:</div>
                                                        </div>
                                                        <div class="col-sm-2 col-md-2">
                                                            <div class="form_filed  pull-left">${FormBean.envelopeName}</div>
                                                        </div>
                                                    </div>
                                                            </c:if>
                                
                                                    </div>
						</div>
					</div>
				</div>
                            </div>
                <form id="frmFormulaCreation" action="${pageContext.servletContext.contextPath}/eBid/Bid/SaveFormula" method="post"  onsubmit="return FormulaSave();">

                <div class="row">
                    
                    <div class="col-lg-12 col-md-12">
                        <div class="box">
                            
                            <div class="col-md-6 text-right">
                                           
                                         </div>
                           
                            <%--    <%
                                    if(formulaCreated.equals("1"))
                                    {%>
                                     <div style="margin:10px;">
                                    <div class="text-success text-bold">Formula created successfully</div>
                                    </div>
                                    <%

                                    if(formulaDeleted.equals("1"))
                                    {%>
                                    <div  style="margin:10px;">
                                    <div class="text-success text-bold">Formula deleted successfully</div>
                                    </div>
                                    <%}
                                    %>--%>
                            
                            <div class="box-body">
                                <div class="row">
                                     <div class="col-lg-12 col-md-12 col-xs-12" id="FormTable">
                                          <div class="row">
                                              <div class="col-lg-2"><spring:message code="lbl_formula_for" /></div>
                                            <div class="col-lg-5" id="dvFormulacombo">
                                                <select class="form-control" id="formulaColumn" name="formulaColumn" onchange="validateFormulaColumn(this);">
                                                    <option value="-1"><spring:message code="lbl_select_formula_column" /></option>
                                                    <%
                                                     while(itr!=null && itr.hasNext())
                                                    {
                                                     String id=(String)itr.next();
                                                     TblTenderColumn tblTenderColumn=(TblTenderColumn)AutoColumn.get(id);
                                                    %>   
                                                    
                                                    <option value="<%=tblTenderColumn.getColumnId()%>"><%=tblTenderColumn.getColumnHeader()%></option>  
                                                        <%}
                                                        %>
                                                </select>
                                            </div>
                                               
                                                <div class="col-lg-5">
                                                </div>
                                        </div>
                                                <br>
                                          <div class="row">
                                             
								<div class="col-lg-12 col-md-12 col-xs-12">
									
                                    <%
                                        itr=AutoColumnSet.iterator();
                                        while(itr!=null && itr.hasNext())
                                        {
                                            String id=(String)itr.next();
                                            String arr[]=new String[id.split("_").length];
                                            arr=id.split("_");
                                            List <TblTenderColumn>lstCol=(List)Columns.get(arr[0]);
                                            %>
                                            <table class="table table-border table-responsive" id="tbl_<%=((TblTenderColumn)AutoColumn.get(id)).getColumnId()%>" border="1" style="display:none">
						<tbody>
                                               <tr>
                                            <%
                                            if(lstCol!=null && lstCol.size()>0){    
                                            for(TblTenderColumn TblTenderColumnObj:lstCol)
                                            { 
                                            %>
                                            
                                            <th><label><%=TblTenderColumnObj.getColumnHeader()%></label>
                                             
                                            <%}}
                                            %>
                                            <th><label><%=((TblTenderColumn)AutoColumn.get(id)).getColumnHeader()%> (Formula Column)</label></td>
                                               </tr> 
                                               <tr>
                                            <%
                                            int count=0;
                                             if(lstCol!=null && lstCol.size()>0){    
                                           
                                            for(TblTenderColumn TblTenderColumnObj:lstCol)
                                            { count++;
                                            %>
                                            <td><input type="text" value="" nametodisplay="<%=TblTenderColumnObj.getColumnHeader()%>" onclick="BuildFormula(this);" autocolumnid="<%=((TblTenderColumn)AutoColumn.get(id)).getColumnId()%>" id="txtcell_0_<%=TblTenderColumnObj.getColumnId()%>"></td>
                                             
                                            <%}}
                                            %>
                                            <td><input type="text" value="" id="txtCell_Result_<%=((TblTenderColumn)AutoColumn.get(id)).getColumnId()%>"  ></td>
                                               </tr> 
                                               
                                            
                                            </tbody>
                                            </table>
                                            <%
                                            
                                        }
                                        %>
                                                                </div>
                                                                
                                                        </div>
                                                              
                                                                <div class="row" style="display: none;" id="dvFormulaCal">
                                                                      <hr>
                                                                            <div class="col-lg-2 col-md-2 col-xs-12">
                                                                                <input type="button" class="btn btn-default" value="+" id="btnPlus" onclick="addExpression(this);">
                                                                                <input type="button" class="btn btn-default" value="-" id="btnMinus" onclick="addExpression(this);">
                                                                                <input type="button" class="btn btn-default" value="*" id="btnmultiply" onclick="addExpression(this);">
                                                                                <input type="button" class="btn btn-default" value="/" id="btndivide" onclick="addExpression(this);">
                                                                                <input type="button" class="btn btn-default" value=")" id="btnstart" onclick="addExpression(this);">
                                                                                
                                                                                 <input type="button" class="btn btn-default" value="(" id="btnEnd" onclick="addExpression(this);">
                                                                                 <input type="button" class="btn btn-default" value="Number" id="btnNumber" onclick="addExpression(this);">
                                                                                 
                                                                                 <button name="undo" class="btn btn-default" type="button" onclick="return UndoChange();" > <spring:message code="lbl_undo" /></button>
                                                                                <button name="clear" class="btn btn-default" type="button" onclick="return clearAll();" ><spring:message code="lbl_clear" /></button>
                                         
                                                                            </div>
                                                                  <div class="col-lg-5 col-md-5">
                                                                    <textArea id="txtaFormFormula" readonly="true" name="txtaFormFormula" class="form-control" rows="4" ></textArea>
                                                                    <input type="hidden" id="txtFormFormula" name="frmFormFormula"/>
                                                                    <input type="hidden" id="txtFormFormula2" name="frmFormFormula2"/>
                                                                    <input type="hidden" name="hdnFormId" value="<%=formId%>">
                                                                          <input type="hidden" id= "hdnFormulaId" name="hdnFormulaId" >
                                                                             
                                                                  </div>
                                                                  <div class="col-lg-5 col-md-5"></div>
                                                                </div>
                                                                <hr>
                                                                <div class="col-md-12">
                                                                      <div class="col-md-2 col-lg-2">
                                                                          
                                                                        <spring:message code="lbl_test_formula" />

                                                                      </div>
                                                                      <div class="col-lg-10 col-md-10 pull-left">
                                                                         <button id="TestFormula" name="TestFormula" type="button" class="btn btn-info"  onclick="testformula()"> <spring:message code="lbl_test_formula" /></button>
                                                                      </div>
                                                                </div>
                                                                 <hr>
                                                                 <div class="col-md-12 text-center">
                                                                    <button type="submit" class="btn btn-submit" id="btnSubmitForm"><spring:message code="label_submit" /></button>
                                                                 </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                                                                           <input type="hidden" id= "hdnTenderId" name="tenderId"  value="${tenderId}">    
                                                                  
                </form>   
                                                                              
                        <div class="table-responsive  box-body " >
                        <table id="example1" class="table table-bordered table-striped">
                            <thead>
                                <tr>
                                    
                                    
                                   
                                    <th><spring:message code="lbl_formula" /></th>
                                    <th><spring:message code="link_tender_edit" /></th>
                                    <th><spring:message code="link_delete_corrigendum" /></th>
                                    
                                </tr>
                            </thead>
                            <tbody>                                         
                  <%
                      
                        for(TblTenderFormula tblTenderFormulla:lstColumnFormula)
                        {%>
                        <tr>
                            
                                <td><label id=""><%=tblTenderFormulla.getDisplayFormula()%></label></td>
                            <td><a href="#" onclick="editFormula(this);" data_colId="<%=tblTenderFormulla.getTblTenderColumn().getColumnId()%>" data_colName="<%=tblTenderFormulla.getTblTenderColumn().getColumnHeader()%>" data_formulaId="<%=tblTenderFormulla.getFormulaId()%>" data_colFormula="<%=tblTenderFormulla.getFormula()%>" data_colFormulaToDisplay="<%=tblTenderFormulla.getDisplayFormula()%>"><i class="fa fa-pencil tb"></i></a></td>
                           
                                <td><a href="${pageContext.servletContext.contextPath}/eBid/Bid/RemoveFormula/${tenderId}/<%=tblTenderFormulla.getFormulaId()%>/<%=formId%>" onclick="return callForDeleteFormula();"><i class="fa fa-trash tb"></i></a></td>
                            
                        </tr>
                       <% } 
                      %>
                  
                   </tbody>
                            
                        </table>
                    </div>
                      <c:if test="${ItemWiseWinner eq 0}"  >                                          
                     <form id="frmFormulaCreation" action="${pageContext.servletContext.contextPath}/eBid/Bid/SaveGrandTotal" method="post"  onsubmit="">

                <div class="row">
                    
                    <div class="col-lg-12 col-md-12">
                        <div class="box">
                            
                           
                            
                            <div class="box-body">
                                <div class="row">
                                     <div class="col-lg-12 col-md-12 col-xs-12" id="FormTable">
                                          <div class="row">
                                              <div class="col-lg-2"><spring:message code="lbl_select_column_for_grand_total" /></div>
                                            <div class="col-lg-5" id="dvGTColumns">
                                                <%
                                                for(int i=0;i<lstGrandTotal.size();i++)
                                                {
                                                    String checked="";
                                                    TblTenderColumn tblTenderColumn=new TblTenderColumn();
                                                    tblTenderColumn=(TblTenderColumn)lstGrandTotal.get(i);
                                                    
                                                    if(tblTenderColumn.getisGTColumn()==1)
                                                        checked="checked";
                                                    %>
                                                    <br>
                                                  
                                                    <c:choose>
                                                        
                                                        <c:when test = "${tblTender.isAuction eq 1 && tblTender.bidSubmissionfor eq 1}">
                                                            
                                                            <%
                                                                if(tblTenderColumn.getTblColumnType().getColumnTypeId()==4)
                                                                {
                                                                    %>
                                                                    <input type="checkbox" <%=checked%> disabled value="<%=tblTenderColumn.getColumnId()%>" name="GrandTotalColumns"><%=tblTenderColumn.getColumnHeader()%>
                                                                    <%
                                                                }
                                                                else
                                                                {
                                                                    %>  
                                                                    <input type="checkbox" <%=checked%> value="<%=tblTenderColumn.getColumnId()%>" name="GrandTotalColumns"><%=tblTenderColumn.getColumnHeader()%>
                                                                    <%
                                                                }
                                                            %>
                                                            
                                                        </c:when>
                                                        <c:otherwise>
                                                            <input type="checkbox" <%=checked%> value="<%=tblTenderColumn.getColumnId()%>" name="GrandTotalColumns"><%=tblTenderColumn.getColumnHeader()%>
                                                        </c:otherwise>
                                                    </c:choose>
                                                   
                                                    
                                                        
                                                    <%
                                                }
                                                %>
                                                
                                            </div>
                                                
                                        </div>
                                                <br>
                                                    <input type="hidden" name="hdn_FormId" value="<%=formId%>">
                                                        <input type="hidden" id= "hdn_TenderId" name="tenderId"  value="${tenderId}">
                                                                 <div class="col-md-12 text-center">
                                                                    <button type="submit" id="btnSubmitfomula" class="btn btn-submit"><spring:message code="label_submit" /></button>
                                                                 </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                                                                 <input type="hidden" name="hdnColId" id="hdnColId"  >                                                      
                                                                  
                </form>                                           
                     </c:if>
            </section>
     
        </div>     



    <script src="${pageContext.servletContext.contextPath}/resources/PageJS/BiddingFormula.js" type="text/javascript"></script>
    <script src="${pageContext.servletContext.contextPath}/resources/PageJS/CalculateFormula1.js" type="text/javascript"></script>
    <script src="${pageContext.servletContext.contextPath}/resources/PageJS/CalculateFormula2.js" type="text/javascript"></script>

    <script src="${pageContext.servletContext.contextPath}/resources/js/jquery.alerts.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jquery.alerts.css">
        <script type="text/javascript">
            var selected = [];
            $("#btnSubmitfomula").on("click",function(){
                 $('#dvGTColumns input:checked').each(function () {
                selected.push($(this).val());
            });
           
                //alert(selected);
            
                 if(selected.length==0){
                     alert("Please select atleast one column as GT Column.")
                     return false;
                 } 
                 else
                 {
                     $('#hdnColId').val(selected);
                     return true;
                 }
                
            });
           function validateFormulaColumn(e){
               $.ajax({
                   url:'${pageContext.servletContext.contextPath}/eBid/Bid/validateFormulaColumn/'+$(e).val(),
                   async:false,
                   type: "POST",
                   success:function(result){
       // alert(result);
                       if(result === 'false')
                       {
                      // alert('in false');
                      $('[id^="tbl_"]').hide();
                      $("#dvFormulaCal").hide();
                           $('#error').show();
                           status=false;
                       }
                       else
                       {
                           setFormulaTo(e);
                           $('#error').hide();
                           status=true;
                       }
                       
                   },
                   error:function(result){
                     //  alert('in error');
                       status=false;
                   }
                });
               
           }
        </script>
<%@include file="../../includes/footer.jsp"%>
   