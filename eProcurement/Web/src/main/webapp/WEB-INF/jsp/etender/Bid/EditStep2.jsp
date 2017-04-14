<%@include file="../../includes/head.jsp"%>
<%@include file="../../includes/masterheader.jsp"%>
<%@page import="com.eprocurement.etender.model.TblTenderCell"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.eprocurement.etender.model.TblTenderColumn"%>
<%@page import="com.eprocurement.etender.model.TblTenderTable"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.List"%>
<%@page import="com.eprocurement.etender.model.TblTenderForm"%>
<%@page import="java.util.Map"%>

<%
             int userType=1; //This value will come from the session
            
            Map formStructure = (Map) request.getAttribute("formStructure");
            TblTenderForm tblTenderForm=(TblTenderForm)formStructure.get("form");
            List <TblTenderTable>lstTable=(List)formStructure.get("table");
            Map column=(Map)formStructure.get("column");
            Map formFormulaWithColumn=(Map)request.getAttribute("formFormulaWithColumn");
            Map cell=(Map)formStructure.get("cell");;
            Set table=column.keySet();
            String tenderId=(String)formStructure.get("tender");
            System.out.println("@@@ "+formFormulaWithColumn);
            int columnCount=0;
            String value="";
            List Col=(List)request.getAttribute("getLastFormulaColumn");
            //formFormulaWithColumn.values();
            //Col.add(38);
           // Col.add(39);
            //Col.add(41);
            //Col.add(43);
            System.out.println("col= "+Col);
            ArrayList DataTypeMessage=new ArrayList();
            DataTypeMessage.add("Enter value in Small Text (Max. 300 characters)");
            DataTypeMessage.add("Enter value in Long text");
            DataTypeMessage.add("Number(with .)");
            DataTypeMessage.add(" Number (without .)");
            DataTypeMessage.add("All Numbers");
            DataTypeMessage.add("Auto number");
            DataTypeMessage.add("");
            DataTypeMessage.add("");
            DataTypeMessage.add("");
        %>
<div class="content-wrapper">
<section class="content-header">
	<h1>
		<spring:message code="link_tender_edit" />
	</h1>
</section>
<section class="content">
	<form id="tenderDtBean" name="tenderDtBean"
		action="${pageContext.servletContext.contextPath}/eBid/Bid/updateBiddingFormValue"
		method="post" onsubmit="return createJSON();">

		<div class="row">
			<div class="col-lg-12 col-md-12">
				<div class="box">
					<div class="box-header with-border">
						<h3 class="box-title">
							<%=tblTenderForm.getFormName()%>
						</h3>
					</div>
					<div class="box-body">
						<div class="row">
							<div class="col-md-12">
								<h3 style="padding-top: 0px; margin-top: 0px;"><%=tblTenderForm.getFormHeader()%></h3>
							</div>
							<%
                                            int count=0;
                                            for(TblTenderTable tblTenderTable:lstTable)
                                            {
                                                List <TblTenderColumn>lstCol=(List)column.get(tblTenderTable.getTableId());
                                        %>

							<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">

								<div class="box">

									<div class="box-header with-border">
										<h3 class="box-title">
											<b><%=tblTenderTable.getTableName()%></b>
										</h3>
									</div>
									<div class="box-header with-border">
										<h3 class="box-title"><%=tblTenderTable.getTableHeader()%></h3>
									</div>

									<div class="box-body">
										<div class="row">
											<div class="col-lg-12 col-md-12 col-xs-12">
												<table class="table table-striped table-responsive"
													id="tbl_<%=count++%>"
													tableId="<%=tblTenderTable.getTableId()%>">
													<thead>
														<tr>
															<%for(TblTenderColumn obj:lstCol)
                                                                                            {
                                                                                                %>
															<th><%=obj.getColumnHeader()%></th>
															<%}
                                                                                                    %>
														</tr>
													</thead>
													<tbody>
														<%
                                                                                        String ColId="";
                                                                                        for(int i=0;i<tblTenderTable.getNoOfRows();i++)
                                                                                        {String formula="no data";
                                                                                            columnCount=0;
                                                                                                 %>
														<tr id="tr<%=i%>">
															<%
                                                                                                    for(TblTenderColumn  TblTenderColumn:  lstCol)
                                                                                                    {
                                                                                                        String key=tblTenderTable.getTableId()+"_"+TblTenderColumn.getColumnId()+"_"+i+"_"+columnCount;
                                                                                                        if(cell.containsKey(key))
                                                                                                        {   
                                                                                                            TblTenderCell TblTenderCell=new TblTenderCell();
                                                                                                            TblTenderCell=(TblTenderCell)cell.get(key);
                                                                                                            value=(String)TblTenderCell.getCellValue();
                                                                                                        }
                                                                                                
                                                                                                %>
															<td tableid="1" trid="<%=i%>"
																colKey="<%=TblTenderColumn.getColumnId()%>">
																<%
//                                                                                                         out.println("col id= "+TblTenderColumn.getColumnId()+" contains: "+formFormulaWithColumn.containsKey(TblTenderColumn.getColumnId()+""));
                                                                                                        if(formFormulaWithColumn!=null && formFormulaWithColumn.containsKey(TblTenderColumn.getColumnId()+"") )
                                                                                                        {
                                                                                                            System.out.println("in if");
                                                                                                            formula=(String)formFormulaWithColumn.get(TblTenderColumn.getColumnId()+"");
                                                                                                            ColId="result_"+i;
                                                                                                        }
                                                                                                        else
                                                                                                        {
                                                                                                          ColId="txtcell_0_"+TblTenderColumn.getColumnId()+"_"+i;  
                                                                                                        }
                                                                                                       
                                                                                                        boolean isTextBox=false;
                                                                                                        boolean isTextBoxDisable;
                                                                                                        boolean isShown=true;
                                                                                                        if(userType==1 && TblTenderColumn.getFilledBy()==userType)
                                                                                                            isTextBox=true;
                                                                                                        else
                                                                                                        {
                                                                                                            if(userType==1)
                                                                                                            {
                                                                                                               // isTextBoxDisable=true;
                                                                                                                isTextBox=false;
                                                                                                            }
                                                                                                            else
                                                                                                            {
                                                                                                                if(TblTenderColumn.getFilledBy()==userType)
                                                                                                                    isTextBox=true;
                                                                                                                else if(TblTenderColumn.getIsShown()==1)
                                                                                                                {
                                                                                                                    //isTextBoxDisable=true;
                                                                                                                     isShown=true;
                                                                                                                    isTextBox=false;
                                                                                                                }
                                                                                                                else
                                                                                                                    isShown=false;
                                                                                                            }
                                                                                                        }
                                                                                                       
                                                                                                               int dataType=TblTenderColumn.getDataType();
                                                                                                                
                                                                                                                switch(dataType)
                                                                                                                {
                                                                                                                    case 1:
                                                                                                                        
                                                                                                                        
                                                                                                                    case 2:
                                                                                                                        if(isTextBox && isShown)
                                                                                                                        {
                                                                                                                        %>
																<!--                                                                                                                         <label>123</label> -->
																<input type="text"
																onblur="ValidateInput(<%=dataType%>,this);" att="1"
																placeholder="<%=DataTypeMessage.get(TblTenderColumn.getDataType())
                                                                                                                               %>"
																colKey="<%=TblTenderColumn.getColumnId()%>"
																value="<%=value%>"
																class="clstxtcell_<%=Col.contains(TblTenderColumn.getColumnId())%>"
																rowid="<%=i%>" id=<%=ColId%>> <%}
                                                                                                                         else if(!isTextBox && isShown)
                                                                                                                        {%>
																<input type="text"
																onblur="ValidateInput(<%=dataType%>,this);"
																disabled="true" value="<%=value%>" id=<%=ColId%>>
																<%}
                                                                                                                        
                                                                                                                        break;
                                                                                                                    case 3:
                                                                                                                        
                                                                                                                    case 4:
                                                                                                                        
                                                                                                                    case 5:
                                                                                                                           if(isTextBox && isShown)
                                                                                                                        {
                                                                                                                        %>
																<label>321</label> <input type="text"
																onblur="ValidateInput(<%=dataType%>,this);" att="2"
																placeholder="<%=DataTypeMessage.get(TblTenderColumn.getDataType())
                                                                                                                               %>"
																colKey="<%=TblTenderColumn.getColumnId()%>"
																value="<%=value%>"
																class="clstxtcell_<%=Col.contains(TblTenderColumn.getColumnId())%>"
																rowid="<%=i%>" id=<%=ColId%>> <%}
                                                                                                                         else if(!isTextBox && isShown)
                                                                                                                        {%>
																<input type="text"
																onblur="ValidateInput(<%=dataType%>,this);"
																disabled="true" value="<%=value%>" id=<%=ColId%>>
																<%}
                                                                                                                            break;
                                                                                                                    case 6:
                                                                                                                       if(isTextBox && isShown)
                                                                                                                        {
                                                                                                                       %>
																<label><%=i+1%></label> <%
                                                                                                                           }
                                                                                                                        else if(!isTextBox && isShown)
                                                                                                                        {%>
																<label><%=i+1%></label> <%}
                                                                                                                        break;
                                                                                                                    case 7:
                                                                                                                   if(isTextBox && isShown)
                                                                                                                        {
                                                                                                                        %>
																<input type="date"
																onblur="ValidateInput(<%=dataType%>,this);"
																colKey="<%=TblTenderColumn.getColumnId()%>"
																value="<%=value%>"> <%}
                                                                                                                         else if(!isTextBox && isShown)
                                                                                                                        {%>
																<input type="date"
																onblur="ValidateInput(<%=dataType%>,this);"
																readonly="true" value="<%=value%>" id=<%=ColId%>>
																<%}
                                                                                                                        break;
                                                                                                                    case 8:
                                                                                                                    %>
																<select colKey="<%=TblTenderColumn.getColumnId()%>"><option><spring:message
																			code="lbl_select" /></option></select> <%
                                                                                                                        break;
                                                                                                                    case 9:
                                                                                                                       if(isTextBox && isShown)
                                                                                                                        {
                                                                                                                        %>
																<input type="file"> <%}
                                                                                                                         else if(!isTextBox && isShown)
                                                                                                                        {%>
																<input type="file" readonly="true"> <%}
                                                                                                                        break;
                                                                                                                    default:
                                                                                                                        %>
																<input type="text"
																colKey="<%=TblTenderColumn.getColumnId()%>"
																class="clstxtcell_<%=Col.contains(TblTenderColumn.getColumnId())%>"
																rowid="<%=i%>" id=<%=ColId%>> <%
                                                                                                                        break;   
                                                                                                                }
                                                                                                   
%>
															</td>
															<%
    columnCount++;
}
                                                                                                    %>
															<td><input type="hidden" id="hdnFormula"
																value="<%=formula%>"><INPUT type="hidden"
																ID="hdn"></td>
														</tr>
														<%}
                                                                                        %>
													</tbody>
												</table>
											</div>
										</div>
									</div>
									<div class="box-header with-border">
										<h3 class="box-title"><%=tblTenderTable.getTableFooter()%></h3>
									</div>

								</div>

							</div>
							<% }
                                            %>

							<div class="col-lg-12">
								<h3><%=tblTenderForm.getFormFooter()%></h3>
							</div>

							<div class="col-md-12 text-center">
								<button type="submit" class="btn btn-submit" id="btnSubmitForm">
									<spring:message code="label_submit" />
								</button>
								<button type="button" class="btn btn-submit">
									<spring:message code="lbl_reset" />
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<input type="hidden" id="hdnFormId" name="hdnFormId"
			value="<%=tblTenderForm.getFormId()%>"> <input type="hidden"
			id="txtJson" name="txtJson"> <input type="hidden"
			value="<%=tenderId%>" name="tenderId">
	</form>
</section>
</div>


<script>
$( document ).ready(function() {
   
    $(".clstxtcell_true").blur(function() {
         var formula = $(this).closest("tr").find('td:last-child').find("#hdnFormula").val();
         var rowid = "_" + $(this).attr("rowid");
         calculateFormula(formula,rowid,this);
    });
});

function calculateFormula(formula,rowid,cmd)
{
    debugger;
     var regex = /([\+\-\*\(\)\/])/;
     var arrIds= formula.split(regex);
     var ResultStr=0;
     for(var i=0;i<arrIds.length;i++)
        {
            if((arrIds[i]).match("_"))
            {
                if(document.getElementById(arrIds[i] + rowid)!=null)
                {
                   if(parseFloat(trim(document.getElementById(arrIds[i] + rowid).value)) != 0){
                   ResultStr += trim(document.getElementById(arrIds[i] + rowid).value.replace(/^[0]+/g,""));
                   }else
                   {
                        ResultStr += '0';
                   }
                }
                else
                {
                    alert("In Else");
                }
            }
            else
            {
                ResultStr += arrIds[i];
            }
        }
        $(cmd).closest("tr").find("#result"+rowid).val(Math.round(eval(eval(ResultStr)*1000))/1000);
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
       
                                                </script>
<%@include file="../../includes/footer.jsp"%>



