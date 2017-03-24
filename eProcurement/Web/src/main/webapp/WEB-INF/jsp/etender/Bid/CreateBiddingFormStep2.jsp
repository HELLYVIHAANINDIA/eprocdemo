<!DOCTYPE html>
<html>
<%@page import="com.eprocurement.etender.enumeration.UserEnum"%>
<%@page import="com.eprocurement.etender.enumeration.DataTypeEnum"%>
<%@page import="com.eprocurement.etender.model.TblTenderCell"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.eprocurement.etender.model.TblTenderColumn"%>
<%@page import="com.eprocurement.etender.model.TblTenderTable"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.List"%>
<%@page import="com.eprocurement.etender.model.TblTenderForm"%>
<%@page import="java.util.Map"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
        <%@include file="../../includes/header.jsp"%>

        <%
        
           int userType=1;
            try{
                userType=Integer.parseInt(request.getAttribute("sessionUserTypeId")!=null?request.getAttribute("sessionUserTypeId").toString():"1");
                
            }catch(Exception e){
                userType=1;
            }
            Map formStructure = (Map) request.getAttribute("formStructure");
            TblTenderForm tblTenderForm=(TblTenderForm)formStructure.get("form");
            List <TblTenderTable>lstTable=(List)formStructure.get("table");
            Map column=(Map)formStructure.get("column");
             
            Map cell=(Map)formStructure.get("cell");;
            Set table=column.keySet();
            String tenderId=(String)formStructure.get("tender");
            
            int columnCount=0;
            String value="";
            
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
</head>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="../../includes/leftaccordion.jsp"%>

        <div class="content-wrapper">
        
            <section class="content-header">
            	<c:choose>
            	<c:when test="${sessionUserTypeId eq 1}">
                	<h1>Create/Fill Bidding Form</h1>
                </c:when>
                <c:when test="${sessionUserTypeId eq 2}">
                	<h1>Fill Form</h1>
                </c:when>
                </c:choose>
            </section>
            
            <section class="content">
                  <div class="row">
                    <div class="col-lg-12 col-md-12">
                        <div class="box">
                            <div class="box-header with-border">
                                <div class="row">
                                   
                                    <div class="col-md-12">
                                                        
                                                        <div class="col-sm-2 col-md-2">
                                                            <div class="form_filed text-black text-right" >Form Name :</div>
                                                        </div>
                                                        <div class="col-sm-2 col-md-2">
                                                            <div class="form_filed pull-left">${FormBean.FormName}</div>
                                                        </div>
                                                        <div class="col-sm-2 col-md-2">
                                                            <div class="form_filed text-right text-black">Envelope:</div>
                                                        </div>
                                                        <div class="col-sm-2 col-md-2">
                                                            <div class="form_filed  pull-left">${FormBean.envelopeName}</div>
                                                        </div>
                                                        <div class="col-sm-2 col-md-2">
                                                            <div class="form_filed text-black text-right">Created On :</div>
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
                                                            <div class="form_filed text-right text-black">Is Document Require :</div>
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
                                                            <div class="form_filed  text-right text-black">Is Mandatory :</div>
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
                                                            <div class="form_filed text-right text-black">Is Price Bid Form:</div>
                                                        </div>
                                                        <div class="col-sm-2 col-md-2">
                                                            <div class="form_filed  pull-left">${IsPriceBid}</div>
                                                        </div>
                                                        
                                                        
                                                    </div>
                                                    </div>
                              
                                                    
                                                   
						</div>

						

					</div>

				</div>
                            </div>
              
<form id="tenderDtBean" name="tenderDtBean" action="/eProcurement/eBid/Bid/updateBiddingFormValue" method="get"  onsubmit="if(valOnSubmit()){return createJson();} else {return false ;}"  novalidate>

                <div class="row">
                    <div class="col-lg-12 col-md-12">
                        <div class="box">
                            <div class="box-header with-border">
                                <h3 class="box-title">  <%=tblTenderForm.getFormName()%> </h3>
                            </div>
                            <div class="col-md-12 text-right" >
                            <spring:message code="lbl_back_dashboard" var='backDashboard'/>
 <c:choose>
                        <c:when test="${sessionUserTypeId eq 2}">
                             <a href="${pageContext.servletContext.contextPath}/etender/bidder/biddingtenderdashboardcontent/${tenderId}/5" class="btn btn-submit"><< ${backDashboard}</a>
                        </c:when>
                        <c:otherwise>
                            <div><a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}" class="btn btn-submit"><< ${backDashboard}</a></div>                                                
                        </c:otherwise>
                        </c:choose>
                                         </div>
                           
                            <div class="box-body">
                                <div class="row">
                                
                                        <div class="col-md-12">
                                            <h3 style="padding-top:0px;margin-top:0px;"><%=tblTenderForm.getFormHeader()%></h3>
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
							<h3 class="box-title"><b><%=tblTenderTable.getTableName()%></b></h3>
						</div>
                        
                        <div class="box-header with-border">
							<h3 class="box-title"><%=tblTenderTable.getTableHeader()%></h3>
						</div>

						<div class="box-body">
							<div class="row">
								<div class="col-lg-12 col-md-12 col-xs-12">
									<table class="table table-striped table-responsive" id="tbl_<%=count++%>" tableId="<%=tblTenderTable.getTableId()%>">
										<thead>
											<tr>
                                                                                            <%for(TblTenderColumn obj:lstCol)
                                                                                            {
                                                                                                %>
                                                                                                <th>Column Name: <%=obj.getColumnHeader()%><br>Filled By: <%=UserEnum.getNameById(obj.getFilledBy()).replaceAll("_", " ")%><br> Data Type: <%=DataTypeEnum.getNameById(obj.getDataType()).replaceAll("_", " ")%></th>
                                                                                                <%}
                                                                                                    %>
											</tr>
										</thead>
										<tbody>
                                                                                    <%
                                                                                        for(int i=0;i<tblTenderTable.getNoOfRows();i++)
                                                                                        {
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
                                                                                                     <td tableid="1" trid="<%=i%>" colKey="<%=TblTenderColumn.getColumnId()%>">
                                                                                                    <%
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
                                                                                                                        
                                                                                                                        if(isTextBox && isShown)
                                                                                                                        {
                                                                                                                        %>
                                                                                                                        <input type="text" 
                                                                                                                               validarr="required@@length:0,300" tovalid="true" onblur="validateTxtComp(this)" 
                                                                                                                               title="<%=TblTenderColumn.getColumnHeader()%>"
                                                                                                                               placeholder="<%=DataTypeMessage.get(TblTenderColumn.getDataType()-1)%>" 
                                                                                                                               colKey="<%=TblTenderColumn.getColumnId()%>" 
                                                                                                                               value="<%=value%>" id="<%=TblTenderColumn.getColumnId() + "_" + i%>"
                                                                                                                               >

                                                                                                                        <%}
                                                                                                                         else if(!isTextBox && isShown)
                                                                                                                        {%>
                                                                                                                        <input type="text" disabled="true" value="<%=value%>">
                                                                                                                        <%}
                                                                                                                        
                                                                                                                        break;
                                                                                                     
                                                                                                                    case 2:
                                                                                                                        if(isTextBox && isShown)
                                                                                                                        {
                                                                                                                        %>
                                                                                                                        <input type="text" 
                                                                                                                               validarr="required@@length:0,1000" tovalid="true" onblur="validateTxtComp(this)" 
                                                                                                                               title="<%=TblTenderColumn.getColumnHeader()%>"
                                                                                                                               placeholder="<%=DataTypeMessage.get(TblTenderColumn.getDataType()-1)%>" 
                                                                                                                               colKey="<%=TblTenderColumn.getColumnId()%>" 
                                                                                                                               value="<%=value%>" id="<%=TblTenderColumn.getColumnId() + "_" + i%>"
                                                                                                                               >

                                                                                                                        <%}
                                                                                                                         else if(!isTextBox && isShown)
                                                                                                                        {%>
                                                                                                                        <input type="text" disabled="true" value="<%=value%>">
                                                                                                                        <%}
                                                                                                                        
                                                                                                                        break;
                                                                                                                    case 3:
                                                                                                                         if(isTextBox && isShown)
                                                                                                                        {
                                                                                                                        %>
                                                                                                                        <input type="number" 
                                                                                                                               validarr="required@@numwithdecimal:2" tovalid="true" onblur="validateTxtComp(this)" 
                                                                                                                               title="<%=TblTenderColumn.getColumnHeader()%>"
                                                                                                                               placeholder="<%=DataTypeMessage.get(TblTenderColumn.getDataType()-1)%>" 
                                                                                                                               colKey="<%=TblTenderColumn.getColumnId()%>" 
                                                                                                                               value="<%=value%>"  id="<%=TblTenderColumn.getColumnId() + "_" + i%>"
                                                                                                                               >

                                                                                                                        <%}
                                                                                                                         else if(!isTextBox && isShown)
                                                                                                                        {%>
                                                                                                                        <input type="text" disabled="true" value="<%=value%>">
                                                                                                                        <%}
                                                                                                                        
                                                                                                                        break;
                                                                                                                        
                                                                                                                   case 4:
                                                                                                                         if(isTextBox && isShown)
                                                                                                                        {
                                                                                                                        %>
                                                                                                                        <input type="number" 
                                                                                                                               validarr="required@@numeric" tovalid="true" onblur="validateTxtComp(this)" 
                                                                                                                               title="<%=TblTenderColumn.getColumnHeader()%>"
                                                                                                                               placeholder="<%=DataTypeMessage.get(TblTenderColumn.getDataType()-1)%>" 
                                                                                                                               colKey="<%=TblTenderColumn.getColumnId()%>" 
                                                                                                                               value="<%=value%>"  id="<%=TblTenderColumn.getColumnId() + "_" + i%>"
                                                                                                                               >

                                                                                                                        <%}
                                                                                                                         else if(!isTextBox && isShown)
                                                                                                                        {%>
                                                                                                                        <input type="text" disabled="true" value="<%=value%>">
                                                                                                                        <%}
                                                                                                                        
                                                                                                                        break;
                                                                                                                    case 5:
                                                                                                                        if(isTextBox && isShown)
                                                                                                                        {
                                                                                                                        %>
                                                                                                                        <input type="number" 
                                                                                                                               validarr="required@@numanduptodecimal:2" tovalid="true" onblur="validateTxtComp(this)" 
                                                                                                                               title="<%=TblTenderColumn.getColumnHeader()%>"
                                                                                                                               placeholder="<%=DataTypeMessage.get(TblTenderColumn.getDataType()-1)%>" 
                                                                                                                               colKey="<%=TblTenderColumn.getColumnId()%>" 
                                                                                                                               value="<%=value%>"  id="<%=TblTenderColumn.getColumnId() + "_" + i%>"
                                                                                                                               >

                                                                                                                        <%}
                                                                                                                         else if(!isTextBox && isShown)
                                                                                                                        {%>
                                                                                                                        <input type="text" disabled="true" value="<%=value%>">
                                                                                                                        <%}
                                                                                                                        
                                                                                                                        break;
                                                                                                                    case 6:
                                                                                                                       if(isTextBox && isShown)
                                                                                                                        {
                                                                                                                       %>
                                                                                                                       <input type="text" disabled="true">
                                                                                                                       <%
                                                                                                                           }
                                                                                                                        else if(!isTextBox && isShown)
                                                                                                                        {%>
                                                                                                                       <input type="text" disabled="true">
                                                                                                                        <%}
                                                                                                                        break;
                                                                                                                     case 7:
                                                                                                                   if(isTextBox && isShown)
                                                                                                                        {
                                                                                                                        %>
                                                                                                                         <input type="date" 
                                                                                                                               validarr="required@@length:0,15" tovalid="true" onblur="validateTxtComp(this)" 
                                                                                                                               title="<%=TblTenderColumn.getColumnHeader()%>"
                                                                                                                               colKey="<%=TblTenderColumn.getColumnId()%>" 
                                                                                                                               value="<%=value%>" id="<%=TblTenderColumn.getColumnId() + "_" + i%>"
                                                                                                                               >
                                                                                                                        <%}
                                                                                                                         else if(!isTextBox && isShown)
                                                                                                                        {%>
                                                                                                                        <input type="date" disabled="true" value="<%=value%>">
                                                                                                                        <%}
                                                                                                                        break;
                                                                                                                    case 8:
                                                                                                                    %>
                                                                                                                    <select colKey="<%=TblTenderColumn.getColumnId()%>" ><option>--Select--</option></select>
                                                                                                                    <%
                                                                                                                        break;
                                                                                                                    case 9:
                                                                                                                       if(isTextBox && isShown)
                                                                                                                        {
                                                                                                                        %>
                                                                                                                        <input type="file" >
                                                                                                                        <%}
                                                                                                                         else if(!isTextBox && isShown)
                                                                                                                        {%>
                                                                                                                        <input type="file"  readonly="true" >
                                                                                                                        <%}
                                                                                                                        break;
                                                                                                                    default:
                                                                                                                        %>
                                                                                                                        <input type="text" colKey="<%=TblTenderColumn.getColumnId()%>">
                                                                                                                        <%
                                                                                                                        break;   
                                                                                                                        
                                                                                                                        
                                                                                                                }
                                                                                                   
%>
</td>
<%
    columnCount++;
}
                                                                                                    %>
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
		                                    <c:choose>
		                                    	<c:when test="${sessionUserTypeId eq 1}">
		                                    		<button type="submit" class="btn btn-submit" id="btnSubmitForm">Submit</button>
		                                        <button type="button" class="btn btn-submit">Reset</button>
		                                    	</c:when>
		                                    	<c:when test="${sessionUserTypeId eq 2}">
		                                    		<button type="submit" class="btn btn-submit" id="btnSubmitForm">Submit</button>
		                                    	</c:when>
		                                    </c:choose>
                                    	</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                                            <input type="hidden" id="hdnFormId" name="hdnFormId" value="<%=tblTenderForm.getFormId()%>">
                                            <input type="hidden" id="txtJson" name="txtJson">
                                                <input type="hidden" value="<%=tenderId%>" name="hdntenderId">
                    </form>       
            </section>
        </div>
<script src="${pageContext.servletContext.contextPath}/resources/js/commonValidate.js" type="text/javascript"></script>
<script src="${pageContext.servletContext.contextPath}/resources/PageJS/ViewBiddingForm.js" type="text/javascript"></script>
<%@include file="../../includes/footer.jsp"%>
</div>
    </body>
</html>
      

	