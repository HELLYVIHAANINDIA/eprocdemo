<!DOCTYPE html>
<html>
<%@page import="com.eprocurement.etender.model.TblTenderFormula"%>
<%@page import="com.lowagie.text.pdf.hyphenation.TernaryTree.Iterator"%>
<%@page import="com.eprocurement.etender.enumeration.UserEnum"%>
<%@page import="com.eprocurement.etender.enumeration.ColumnTypeEnum"%>
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

<script src="${pageContext.servletContext.contextPath}/resources/js/jquery-ui.min.js"></script>
<script src="${pageContext.servletContext.contextPath}/resources/PageJS/ViewBiddingForm.js" type="text/javascript"></script>

        <%
           int userType=1;
            try{
                userType=Integer.parseInt(request.getAttribute("sessionUserTypeId")!=null?request.getAttribute("sessionUserTypeId").toString():"1");
                
            }catch(Exception e){
                userType=1;
            }
            List<TblTenderFormula> lstColumnFormula=null;
            if(request.getAttribute("formulaMap")!=null)
            {
            Map formulaMap = (Map) request.getAttribute("formulaMap");
            lstColumnFormula=(List)formulaMap.get("FormulaGrid");
            }
            System.out.println("@@@@ lstColumnFormula: "+lstColumnFormula);
            Map formStructure=null;
            if(request.getAttribute("formStructure")!=null)
            {
            formStructure = (Map) request.getAttribute("formStructure");
            }
            TblTenderForm tblTenderForm=(TblTenderForm)formStructure.get("form");
            List <TblTenderTable>lstTable=(List)formStructure.get("table");
            Map column=(Map)formStructure.get("column");
            Map formFormulaWithColumn=(Map)request.getAttribute("formFormulaWithColumn");
            String opt="";
            //below parameter and condition for test biddder form from officer 
            if(request.getAttribute("opt")!=null)
            {
                opt=request.getAttribute("opt").toString().trim();
            }
            String Back="";
            if(request.getAttribute("Back")!=null)
            {
                Back=request.getAttribute("Back").toString().trim();
            }
           if(opt.equals("0"))
            {
                userType=2;
            }
           Map cell=(Map)formStructure.get("cell");
           
            Set table=column.keySet();
            String tenderId=(String)formStructure.get("tender");
            List Col=(List)request.getAttribute("getLastFormulaColumn");
            
            int columnCount=0;
            String value="";
            int cellId=0;
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

<div id="error" style="display: none">
<div class="alert alert-danger" id="err_msg">
 Bidding Time over
</div>
</div>
                
                    <c:choose>
                        <c:when test="${sessionUserTypeId eq 2}">
                            <h1 style="margin:0px; float:left;">Fill Form</h1>
                        </c:when>  
                        <c:when test="${sessionUserTypeId eq 1}">
                            <h1 style="margin:0px; float:left;">View Bidding Form </h1>
                        </c:when>
                    </c:choose> 
                
                
                
                    <spring:message code="lbl_back_dashboard" var='backDashboard'/>
             
                            <c:choose>
                        <c:when test="${sessionUserTypeId eq 2}">
                            
                            <a href="${pageContext.servletContext.contextPath}/etender/bidder/biddingtenderdashboardcontent/${tenderId}/5" class="btn btn-submit pull-right" style="margin-top:0px; margin-bottom:10px;">
                                <c:if test="${isAuction eq 1}"><< Go To Auction DashBoard</c:if>
                                 <c:if test="${isAuction eq 0}"><< ${backDashboard}</c:if>
                                </a>
                        </c:when>
                        <c:otherwise>
                            <c:if test="${isAuction eq 1}">
                        
                    <div><a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}" class="btn btn-submit pull-right" style="margin-top:0px; margin-bottom:10px;"><< Go Back To Auction DashBoard</a></div>                                                
                        
                    </c:if>
                    <c:if test="${isAuction eq 0}">
                        
                            <div><a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}" class="btn btn-submit pull-right" style="margin-top:0px; margin-bottom:10px;"><< ${backDashboard}</a></div>                                                
                         </c:if>
                        </c:otherwise>
                    </c:choose>
                       
                    
                
                
            </section>
 
<section class="content">
<div class="row">            
<c:if test="${isAuction eq 1 and sessionUserTypeId eq 2}">
 
<div class="col-lg-12 col-md-12">
<div class="box">

<div class="box-header with-border"></div>

<div class="box-body">
<div class="row">
                                    <div class="col-md-12">
                                    <div class="row">
                                        <div class="col-sm-3 col-md-3">
                                            <div class="form_filed text-black text-right">Auction Start Date :</div>
                                        </div>
                                        <div class="col-sm-3 col-md-3">
                                            <fmt:formatDate value="${tblTender.auctionStartDate}" var="formattedDate" type="date" pattern="dd/MM/yyyy HH:mm:ss" />
                                            <div class="form_filed text-black text-right">${formattedDate}</div>
                                        </div>
                                        <div class="col-sm-3 col-md-3">
                                            <fmt:formatDate value="${tblTender.auctionEndDate}" var="formattedDate" type="date" pattern="dd/MM/yyyy HH:mm:ss" />
                                            <div class="form_filed text-black text-right">Auction End Date :</div>
                                        </div>
                                        <div class="col-sm-3 col-md-3">
                                            <div class="form_filed text-black text-right">${formattedDate}</div>
                                        </div>
                                    </div>
                                    </div>
                                    
                                    <div class="col-md-12">
                                    <div class="row">
                                        <div class="col-sm-3 col-md-3">
                                            <div class="form_filed text-black text-right">Current Time :</div>
                                        </div>
                                        <div class="col-sm-3 col-md-3">
                                            <jsp:useBean id="today" class="java.util.Date" scope="page" />
                                            <fmt:formatDate value="${today}" var="formattedDate" type="date" pattern="dd/MM/yyyy HH:mm:ss" />
                                            <div class="form_filed text-black text-right">${formattedDate}</div>
                                        </div>
                                        <div class="col-sm-3 col-md-3">
                                            <div class="form_filed text-black text-right">Remaining Time :</div>
                                        </div>
                                        <div class="col-sm-3 col-md-3">
                                            

                                             <div class="form_filed text-black text-right">${formattedDate}</div>
                                        </div>
                                    </div>
                                    </div>
</div>
                                   
</div>
</div>
</div>
</c:if>
</div>
 
<div class="row">
                    <div class="col-lg-12 col-md-12">
                        <div class="box">
                            <div class="box-header with-border">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="col-sm-2 col-md-2">
                                            <div class="form_filed text-black text-right">Form Id :</div>
                                        </div>
                                        <div class="col-sm-2 col-md-2">
                                            <div class="form_filed pull-left">${formId}</div>
                                        </div>
                                        <div class="col-sm-2 col-md-2">
                                            <div class="form_filed text-black text-right" >Form Name :</div>
                                        </div>
                                        <div class="col-sm-2 col-md-2">
                                            <div class="form_filed pull-left">${FormBean.FormName}</div>
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

                                        <div class="col-sm-2 col-md-2">
                                            <div class="form_filed text-right text-black">Envelope:</div>
                                        </div>
                                        <div class="col-sm-2 col-md-2">
                                            <div class="form_filed  pull-left">${FormBean.envelopeName}</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
</div>
 
<c:if test="${operation eq 'edit'}">
<form id="tenderDtBean" name="tenderDtBean" action="/eProcurement/eBid/Bid/updateBiddingFormValueForEdit" method="get"   onsubmit="if(valOnSubmit()){return createJson();} else {return false ;}" novalidate >

<div class="row">

<div class="col-lg-12 col-md-12">
<div class="box">

<div class="box-header with-border">
<h3 class="box-title"><%=tblTenderForm.getFormName()%></h3>
</div>

<div class="box-body">
<div class="row">

<div class="col-md-12">
<h3 style="padding-top:0px; margin-top:0px;"><%=tblTenderForm.getFormHeader()%></h3>
</div>
                                    <%
                                        int count1 = 0;
                                        for (TblTenderTable tblTenderTable : lstTable) {
                                            List<TblTenderColumn> lstCol = (List) column.get(tblTenderTable.getTableId());
                                    %>
                                     
<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                          
<c:if test="${isAuction eq 0}">
                                               
<h3 class="box-title"><b><%=tblTenderTable.getTableName()%></b></h3>
                                                        <%
                                                            String val = "";
                                                            if (tblTenderTable.getIsMandatory() == 0) {
                                                                val = "No";
                                                            } else {
                                                                val = "Yes";
                                                            }
                                                        %>
                                                Is Table Mandatory:<%=val%>
                                                                                                                                                                           
<h3 class="box-title"><%=tblTenderTable.getTableHeader()%>
</c:if>
</div>

<c:if test="${sessionUserTypeId eq 2 and listOfCurrency ne null and not empty listOfCurrency and isRepeated}">
<div class="col-lg-12 col-md-12 col-xs-12">
<b><spring:message code="lab_bid_curr" /> while submitting Bid ${selectedCurrency}</b><br/><br/>
</div>
</c:if>

<div class="col-lg-12 col-md-12 col-xs-12">
<table class="table table-striped table-responsive" id="tbl_<%=count1++%>" tableId="<%=tblTenderTable.getTableId()%>">
										<thead>
											<tr>
                                                                                            <%for(TblTenderColumn obj:lstCol)
                                                                                            {
                                                                                                %>
                                                                                                <th>Column Name: <%=obj.getColumnHeader()%><br>Filled By: <%=UserEnum.getNameById(obj.getFilledBy()).replaceAll("_", " ")%>
                                                                                                        <br> Data Type: <%=DataTypeEnum.getNameById(obj.getDataType()).replaceAll("_", " ")%>
                                                                                                            
                                                                                                            </th>
                                                                                                <%}
                                                                                                    %>
											</tr>
										</thead>
										<tbody>
                                                                                    <%
                                                                                        String ColId="";
                                                                                        String formula="";
                                                                                        for(int i=0;i<tblTenderTable.getNoOfRows();i++)
                                                                                        {
                                                                                            columnCount=0;
                                                                                                 %>
                                                                                            <tr id="tr<%=i%>">
                                                                                                  <%
                                                                                                    for(TblTenderColumn  TblTenderColumn:  lstCol)
                                                                                                    {
                                                                                                        String key=tblTenderTable.getTableId()+"_"+TblTenderColumn.getColumnId()+"_"+i+"_"+columnCount;
                                                                                                        //tableId+"_"+tblTenderColumn.getColumnId()+"_"+tblTenderCell.getRowId()+"_"+tblTenderCell.getCellNo()
                                                                                                              value="";
                                                                                                              cellId=0;
                                                                                                        if(cell.containsKey(key))
                                                                                                        {   
                                                                                                            TblTenderCell TblTenderCell=new TblTenderCell();
                                                                                                            TblTenderCell=(TblTenderCell)cell.get(key);
                                                                                                            value=(String)TblTenderCell.getCellValue();
                                                                                                            cellId=(int)TblTenderCell.getCellId();
                                                                                                        }
                                                                                                   %>
                                                                                                     <td  trid="<%=i%>" colKey="<%=TblTenderColumn.getColumnId()%>" cellID="<%=cellId%>" filledBy="<%=TblTenderColumn.getFilledBy()%>">
                                                                                                     <%
                                                                                                        if(formFormulaWithColumn!=null && formFormulaWithColumn.containsKey(TblTenderColumn.getColumnId()+"") )
                                                                                                        {
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
                                                                                                                         if(isTextBox && isShown)
                                                                                                                        {
                                                                                                                        %>
                                                                                                                        <input type="text" 
                                                                                                                               validarr="required@@length:0,300" tovalid="true" onblur="validateTxtComp(this)" 
                                                                                                                               tableid="<%=tblTenderTable.getTableId()%>"  
                                                                                                                               title="<%=TblTenderColumn.getColumnHeader()%>"
                                                                                                                               placeholder="<%=DataTypeMessage.get(TblTenderColumn.getDataType()-1)%>" colKey="<%=TblTenderColumn.getColumnId()%>" value="<%=value%>" class="clstxtcell_<%=Col.contains(TblTenderColumn.getColumnId())%>" rowid="<%=i%>"
                                                                                                                               id=<%=ColId%>>
                                                                                                                        <%}
                                                                                                                         else if(!isTextBox && isShown)
                                                                                                                        {%>
                                                                                                                        <input type="text" onblur="ValidateInput(<%=dataType%>,this);" disabled="true" value="<%=value%>" id=<%=ColId%>>
                                                                                                                        <%}
                                                                                                                        
                                                                                                                        break;
                                                                                                                    case 2:
                                                                                                                         if(isTextBox && isShown)
                                                                                                                        {
                                                                                                                        %>
                                                                                                                        <input type="text" 
                                                                                                                               validarr="required@@length:0,1000" tovalid="true" onblur="validateTxtComp(this)" 
                                                                                                                               tableid="<%=tblTenderTable.getTableId()%>"  
                                                                                                                               title="<%=TblTenderColumn.getColumnHeader()%>"
                                                                                                                               placeholder="<%=DataTypeMessage.get(TblTenderColumn.getDataType()-1)%>" colKey="<%=TblTenderColumn.getColumnId()%>" value="<%=value%>" class="clstxtcell_<%=Col.contains(TblTenderColumn.getColumnId())%>" rowid="<%=i%>"
                                                                                                                               id=<%=ColId%>>
                                                                                                                        <%}
                                                                                                                         else if(!isTextBox && isShown)
                                                                                                                        {%>
                                                                                                                        <input type="text" onblur="ValidateInput(<%=dataType%>,this);" disabled="true" value="<%=value%>" id=<%=ColId%>>
                                                                                                                        <%}
                                                                                                                        
                                                                                                                        break;
                                                                                                                     case 3:
                                                                                                                           if(isTextBox && isShown)
                                                                                                                        {
                                                                                                                        %>
                                                                                                                        <input type="number"  
                                                                                                                               validarr="required@@numwithdecimal:2" tovalid="true" onblur="validateTxtComp(this)" 
                                                                                                                               title="<%=TblTenderColumn.getColumnHeader()%>" 
                                                                                                                               onblur="ValidateInput(<%=dataType%>,this);"  
                                                                                                                               tableid="<%=tblTenderTable.getTableId()%>" placeholder="<%=DataTypeMessage.get(TblTenderColumn.getDataType()-1)%>" 
                                                                                                                               colKey="<%=TblTenderColumn.getColumnId()%>" value="<%=value%>"  
                                                                                                                               class="clstxtcell_<%=Col.contains(TblTenderColumn.getColumnId())%>"  rowid="<%=i%>" 
                                                                                                                               id=<%=ColId%>>
                                                                                                                        <%}
                                                                                                                         else if(!isTextBox && isShown)
                                                                                                                        {%>
                                                                                                                        <input type="text" disabled="true" value="<%=value%>" id=<%=ColId%>>
                                                                                                                        <%}
                                                                                                                        break;
                                                                                                                    case 4:
                                                                                                                         if(isTextBox && isShown)
                                                                                                                        {
                                                                                                                        %>
                                                                                                                        <input type="number"  
                                                                                                                               validarr="required@@numeric" tovalid="true" onblur="validateTxtComp(this)" 
                                                                                                                               title="<%=TblTenderColumn.getColumnHeader()%>" 
                                                                                                                               onblur="ValidateInput(<%=dataType%>,this);"  
                                                                                                                               tableid="<%=tblTenderTable.getTableId()%>" placeholder="<%=DataTypeMessage.get(TblTenderColumn.getDataType()-1)%>" 
                                                                                                                               colKey="<%=TblTenderColumn.getColumnId()%>" value="<%=value%>"  
                                                                                                                               class="clstxtcell_<%=Col.contains(TblTenderColumn.getColumnId())%>"  rowid="<%=i%>" 
                                                                                                                               id=<%=ColId%>>
                                                                                                                        <%}
                                                                                                                         else if(!isTextBox && isShown)
                                                                                                                        {%>
                                                                                                                        <input type="text" disabled="true" value="<%=value%>" id=<%=ColId%>>
                                                                                                                        <%}
                                                                                                                            break;
                                                                                                                    case 5:
                                                                                                                        if(isTextBox && isShown)
                                                                                                                        {
                                                                                                                        %>
                                                                                                                        <input type="number"  
                                                                                                                               validarr="required@@numanduptodecimal:2" tovalid="true" onblur="validateTxtComp(this)" 
                                                                                                                               title="<%=TblTenderColumn.getColumnHeader()%>" 
                                                                                                                               onblur="ValidateInput(<%=dataType%>,this);"  
                                                                                                                               tableid="<%=tblTenderTable.getTableId()%>" placeholder="<%=DataTypeMessage.get(TblTenderColumn.getDataType()-1)%>" 
                                                                                                                               colKey="<%=TblTenderColumn.getColumnId()%>" value="<%=value%>"  
                                                                                                                               class="clstxtcell_<%=Col.contains(TblTenderColumn.getColumnId())%>"  rowid="<%=i%>" 
                                                                                                                               id=<%=ColId%>>
                                                                                                                        <%}
                                                                                                                         else if(!isTextBox && isShown)
                                                                                                                        {%>
                                                                                                                        <input type="text" disabled="true" value="<%=value%>" id=<%=ColId%>>
                                                                                                                        <%}
                                                                                                                            break;
                                                                                                                    case 6:
                                                                                                                       if(isTextBox && isShown)
                                                                                                                        {
                                                                                                                       %>
                                                                                                                       <label ><%=i+1%></label>
                                                                                                                       <%
                                                                                                                           }
                                                                                                                        else if(!isTextBox && isShown)
                                                                                                                        {%>
                                                                                                                        <label ><%=i+1%></label>
                                                                                                                        <%}
                                                                                                                        break;
                                                                                                                    case 7:
                                                                                                                   if(isTextBox && isShown)
                                                                                                                        {
                                                                                                                        %>
                                                                                                                        <input type="date" onblur="ValidateInput(<%=dataType%>,this);" colKey="<%=TblTenderColumn.getColumnId()%>" value="<%=value%>">
                                                                                                                        <%}
                                                                                                                         else if(!isTextBox && isShown)
                                                                                                                        {%>
                                                                                                                        <input type="date" onblur="ValidateInput(<%=dataType%>,this);" readonly="true" value="<%=value%>" id=<%=ColId%>>
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
                                                                                                                        <input type="text" colKey="<%=TblTenderColumn.getColumnId()%>"  class="clstxtcell_<%=Col.contains(TblTenderColumn.getColumnId())%>" rowid="<%=i%>" id=<%=ColId%> >
                                                                                                                        <%
                                                                                                                        break;   
                                                                                                                }
                                                                                                   
%>
</td>
<%
    columnCount++;
}
                                                                                                    %>
                                                                                            
                                                                                                <input type="hidden" id="hdnFormula" value="<%=formula%>">
                                                                                            </tr>
                                                                                        <%}
                                                                                        %>
                                                                                         <!-- logic for gt row -->
                                                                                            <tr id="trGT_<%=tblTenderTable.getTableId()%>" tableId="<%=tblTenderTable.getTableId()%>" >
                                                                                                <%
                                                                                                    for(TblTenderColumn  TblTenderColumn:  lstCol)
                                                                                                    {
                                                                                                      
                                                                                                        
                                                                                                        %>
                                                                                                          <td   >
                                                                                                              <%
                                                                                                                  if(TblTenderColumn.getisGTColumn()==1)
                                                                                                                  {
                                                                                                                      if(TblTenderColumn.getColumnHeader().toLowerCase().contains("total"))
                                                                                                                        out.println(TblTenderColumn.getColumnHeader());
                                                                                                                      else
                                                                                                                        out.println("Total "+TblTenderColumn.getColumnHeader());
                                                                                                                              %>
                                                                                                                              = <label id="lblGT_<%=TblTenderColumn.getColumnId()%>" colId="<%=TblTenderColumn.getColumnId()%>" TableId="<%=TblTenderColumn.getTblTenderTable().getTableId()%>"></label>
                                                                                                                              <%}
                                                                                                                  %>
                                                                                                              
                                                                                                          </td>
                                                                                                   
                                                                                                        <%
                                                                                                    }   
                                                                                                
                                                                                                %>
                                                                                                
                                                                                            </tr>
                                                                                </tbody>
									</table>
</div>
							
<c:if test="${isAuction eq 0}">
<div class="col-lg-12 col-md-12 col-xs-12">
<%=tblTenderTable.getTableFooter()%>
</div>
</c:if>
                                                                                       					
                                           <% }
                                            %>
                                            
<div class="col-lg-12">
<h3><%=tblTenderForm.getFormFooter()%></h3>
</div>
                                              <%
                                                  if( lstColumnFormula!=null && lstColumnFormula.size() > 0)
                                                  {
                                              %>
                                                

<div class="col-lg-12 ">
                                                       
                                                        
                                                            <div class="table-responsive  box-body " >
                                                                <table id="example1" class="table table-bordered table-striped">
                                                                    <thead>
                                                                        <tr>
                                                                            <th>Formula</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>                                         
                                                                        <%
                                                                            for (TblTenderFormula tblTenderFormulla : lstColumnFormula) {%>
                                                                        <tr>
                                                                            <td><label id=""><%=tblTenderFormulla.getDisplayFormula()%></label></td>
                                                                        </tr>
                                                                        <% }
                                                                        %>

                                                                    </tbody>

                                                                </table>
                                                            </div>
                                                      
</div>
                                                
                                             <%}%>
                                                <%
                                                    if(!opt.equals("0"))
                                                    {
            
                                                    %>
                                    <div class="col-md-12 text-center">
                                    <c:if test="${sessionUserTypeId eq 2}">
                                    	<input type="hidden" id="hdFormActionS" name="hdFormActionS" value="2">
                                    	<spring:message code="lbl_form_save_as_draft" var="varSaveAsDraft"/>
                                    	<button type="submit" class="btn btn-submit" id="btndraftForm">${varSaveAsDraft}</button>
                                    	<button type="submit" class="btn btn-submit" id="btnSubmitForm">Save</button>
                                    	<button type="button" class="btn btn-submit">Reset</button>
                                    </c:if>
                                    <c:if test="${sessionUserTypeId eq 1}">
                                        <button type="submit" class="btn btn-submit" id="btnSubmitForm">Submit</button>
                                        <button type="button" class="btn btn-submit">Reset</button>
                                    </c:if>
                                    </div>
                                     <%}%>
                                     
</div>
</div>
</div>
</div>
</div>

<input type="hidden" id="hdnFormId" name="hdnFormId" value="<%=tblTenderForm.getFormId()%>">
<input type="hidden" id="txtJson" name="txtJson">
<input type="hidden" id="hdnGTColumnValue" name="hdnGTColumnValue">
<input type="hidden" value="<%=tenderId%>" name="hdntenderId">
                         
</form>

</c:if>

<c:if test="${empty operation}">
                 
<div class="row">

<div class="col-lg-12 col-md-12">

<div class="box">

<div class="box-header with-border">
<h3 class="box-title"> <%=tblTenderForm.getFormName()%> </h3>
</div>

<div class="box-body">
<div class="row">

<div class="col-md-12">
<h3 style="padding-top:0px;margin-top:0px; font-size:16px; font-weight:bold;"><%=tblTenderForm.getFormHeader()%></h3>
</div>
                                        <%
                                            int count=0;
                                            for(TblTenderTable tblTenderTable:lstTable)
                                            {
                                                List <TblTenderColumn>lstCol=(List)column.get(tblTenderTable.getTableId());
                                        %>
                                     
<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">

<c:if test="${isAuction eq 0}">

<h3 style="padding-top:0px;margin-top:0px; font-size:16px; font-weight:bold; float:left;"><%=tblTenderTable.getTableName()%></h3>
                                                         <%
                                                        String val="";
                                                        if(tblTenderTable.getIsMandatory()==0)
                                                        {
                                                            val="No";
                                                        }
                                                        else
                                                        {
                                                            val="Yes";
                                                        }
                                                        %>

<h3 style="padding-top:0px;margin-top:0px; font-size:16px; font-weight:bold; float:right;"> Is Table Mandatory:</b>&nbsp;<%=val%></h3>

<h3 style="padding-top:0px;margin-top:0px; font-size:16px; font-weight:bold;">
<%=tblTenderTable.getTableHeader()%>
</h3>

</c:if>

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
                                                                                        String ColId="";
                                                                                        String formula="";
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
                                                                                                <a href="BiddingFormDocument.jsp"></a>
                                                                                                     <td  trid="<%=i%>" colKey="<%=TblTenderColumn.getColumnId()%>">
                                                                                                    <%
                                                                                                        if(formFormulaWithColumn!=null && formFormulaWithColumn.containsKey(TblTenderColumn.getColumnId()+"") )
                                                                                                        {
                                                                                                            formula=(String)formFormulaWithColumn.get(TblTenderColumn.getColumnId()+"");
                                                                                                            ColId="result_"+i;
                                                                                                        }
                                                                                                        else
                                                                                                        {
                                                                                                          ColId="txtcell_0_"+TblTenderColumn.getColumnId()+"_"+i;  
                                                                                                        }
                                                                                                                
                                                                                                        int dataType=TblTenderColumn.getDataType();
                                                                                                                
                                                                                                                switch(dataType)
                                                                                                                {
                                                                                                                    case 1:
                                                                                                                        
                                                                                                                    case 2:
                                                                                                                       %>
                                                                                                                       <input type="text" disabled="true" colKey="<%=TblTenderColumn.getColumnId()%>" value="<%=value%>" 
                                                                                                                              class="clstxtcell_<%=Col.contains(TblTenderColumn.getColumnId())%>" 
                                                                                                                              rowid="<%=i%>"
                                                                                                                               id=<%=ColId%>>
                                                                                                                        
                                                                                                                        <%
                                                                                                                        
                                                                                                                        break;
                                                                                                                    case 3:
                                                                                                                        
                                                                                                                    case 4:
                                                                                                                        
                                                                                                                    case 5:
                                                                                                                          
                                                                                                                        %>
                                                                                                                         <input type="text" disabled="true" colKey="<%=TblTenderColumn.getColumnId()%>" value="<%=value%>" 
                                                                                                                              class="clstxtcell_<%=Col.contains(TblTenderColumn.getColumnId())%>" 
                                                                                                                              rowid="<%=i%>"
                                                                                                                               id=<%=ColId%>>
                                                                                                                        
                                                                                                                        <%
                                                                                                                            break;
                                                                                                                    case 6:
                                                                                                                      %>
                                                                                                                       <label ><%=i+1%></label>
                                                                                                                       
                                                                                                                        <%
                                                                                                                        break;
                                                                                                                    case 7:
                                                                                                                     %>
                                                                                                                        <input type="date" onblur="ValidateInput(<%=dataType%>,this);" readonly="true" value="<%=value%>">
                                                                                                                        <%
                                                                                                                        break;
                                                                                                                    case 8:
                                                                                                                    %>
                                                                                                                    <select colKey="<%=TblTenderColumn.getColumnId()%>" ><option>--Select--</option></select>
                                                                                                                    <%
                                                                                                                        break;
                                                                                                                    case 9:
                                                                                                                       %>
                                                                                                                        <input type="file"  readonly="true" >
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
                                                                                          <tr id="trGT_<%=tblTenderTable.getTableId()%>" tableId="<%=tblTenderTable.getTableId()%>" >
                                                                                                <%
                                                                                                    for(TblTenderColumn  TblTenderColumn:  lstCol)
                                                                                                    {
                                                                                                      
                                                                                                        
                                                                                                        %>
                                                                                                          <td   >
                                                                                                              <%
                                                                                                                  if(TblTenderColumn.getisGTColumn()==1)
                                                                                                                  {
                                                                                                                      if(TblTenderColumn.getColumnHeader().toLowerCase().contains("total"))
                                                                                                                        out.println(TblTenderColumn.getColumnHeader());
                                                                                                                      else
                                                                                                                        out.println("Total "+TblTenderColumn.getColumnHeader());
                                                                                                                              %>
                                                                                                                              = <label id="lblGT_<%=TblTenderColumn.getColumnId()%>" colId="<%=TblTenderColumn.getColumnId()%>"></label>
                                                                                                                              <%}
                                                                                                                  %>
                                                                                                              
                                                                                                          </td>
                                                                                                   
                                                                                                        <%
                                                                                                    }   
                                                                                                
                                                                                                %>
                                                                                                
                                                                                            </tr>
                                                                                       
                                                                                </tbody>
									</table>

							
                                                
                                                <c:if test="${isAuction eq 0}">
                                                <div class="box-header with-border">
							<h3 class="box-title"><%=tblTenderTable.getTableFooter()%></h3>
						</div>  
                                                </c:if>
                                                                                                



                                        </div>
                                           <% }
                                            %>
                                            
<div class="col-lg-12">
<h3 style="padding-top:0px;margin-top:0px; font-size:16px; font-weight:bold;"><%=tblTenderForm.getFormFooter()%></h3>
</div>
                                            <%
                                                         if( lstColumnFormula!=null && lstColumnFormula.size() > 0)
                                                         {
                                                         %>
                                                <div class="row">
                                                    <div class="col-lg-12 ">
                                                       
                                                        
                                                            <div class="table-responsive  box-body " >
                                                                <table id="example1" class="table table-bordered table-striped">
                                                                    <thead>
                                                                        <tr>
                                                                            <th>Formula</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>                                         
                                                                        <%
                                                                            for (TblTenderFormula tblTenderFormulla : lstColumnFormula) {%>
                                                                        <tr>
                                                                            <td><label id=""><%=tblTenderFormulla.getDisplayFormula()%></label></td>
                                                                        </tr>
                                                                        <% }
                                                                        %>

                                                                    </tbody>

                                                                </table>
                                                            </div>
                                                      
                                                    </div>
                                                </div>
                                             <%}%>
                                              
                                            
<div class="col-lg-12">
<button type="button" onclick="location.href = '${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}';" class="btn btn-submit  pull-right" id="btnSubmitForm">Back</button>
</div>
                   
                             
                                     
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                                            
                                                
                                            <input type="hidden" id="hdnFormId" name="hdnFormId" value="<%=tblTenderForm.getFormId()%>">
                                            <input type="hidden" id="txtJson" name="txtJson">
                                                <input type="hidden" value="<%=tenderId%>" name="hdntenderId">
                         
</c:if>
 
</section>
                  
</div>
                                               
<%@include file="../../includes/footer.jsp"%>
</div>

<script src="${pageContext.servletContext.contextPath}/resources/js/commonValidate.js" type="text/javascript"></script> 
<script>
    var isAuction='${isAuction}';
$('#btndraftForm').click(function(){
	$('#hdFormActionS').val('1');
});

    $(document ).ready(function() {
      GTCalculationOnLoad();
                                                                                                                                                                                                        
    $(".clstxtcell_true").blur(function() {
         var formula = $(this).closest("tr").find("#hdnFormula").val();
         var rowid = "_" + $(this).attr("rowid");
         var tableId=$(this).attr("tableId");
         calculateFormula(formula,rowid,this,tableId);
    });
});

  function GTCalculationOnLoad(){
        $('[id^="trGT_"]').each(function () {
            $(this).find('[id^="lblGT_"]').each(function () {
            var sum = 0;        
            var colid1 = $(this).attr("colId");
                $('[id^="txtcell_0_' + $(this).attr("colId") + '"]').each(function () {
                    var intval = 0;
                    if ($(this).val().length != 0) {
                        intval = parseInt($(this).val())
                    }
                    sum += intval;
                    $("#lblGT_" + colid1).text(Math.round(eval(eval(sum) * 1000)) / 1000);
                });
                var sum2 = 0;
                $('[id^="tbl_').each(function () {
                        $(this).find('[id^="result"]').each(function () {
                            if ($(this).parent().attr("colkey") == colid1) {
                                var intval = 0;
                                if ($(this).val().length != 0) {
                                    intval = parseInt($(this).val())
                                }
                                sum2 += intval;
                                $("#lblGT_" + colid1).text(Math.round(eval(eval(sum2) * 1000)) / 1000);
                            }
                        });
                    });
                });
            });
        }

function calculateFormula(formula,rowid,cmd,tableId)
{
     var regex = /([\+\-\*\(\)\/])/;
     var arrIds= formula.split(regex);
     var ResultStr="";
     
     for(var i=0;i<arrIds.length;i++)
        {
            if((arrIds[i]).match("_"))
            {
                if(document.getElementById(arrIds[i] + rowid)!=null)
                {
                   if(parseFloat(trim(document.getElementById(arrIds[i] + rowid).value)) != 0){
                   ResultStr += trim(document.getElementById(arrIds[i] + rowid).value); //.replace(/^[0]+/g,""));
                   }else
                   {
                        ResultStr += '0';
                   }
                }
                else
                {
                  
                }
            }
            else
            {
                ResultStr += arrIds[i];
            }
        }
        $(cmd).closest("tr").find("#result"+rowid).val(Math.round(eval(eval(ResultStr)*1000))/1000);
        
        $('#trGT_'+tableId).each(function(){
            $(this).find('[id^="lblGT_"]').each(function () {
               
                var sum=0;
                var colid1 =  $(this).attr("colId");
                $('[id^="txtcell_0_'+$(this).attr("colId")+'"]').each(function () {
                    debugger;
                    var intval = 0;
                    if($(this).val().length != 0){
                        intval = parseInt($(this).val())                
                    } 
                     sum += intval;
                      $("#lblGT_"+colid1).text(Math.round(eval(eval(sum)*1000))/1000);
                });
                 
                var sum2=0;
                 $('[id^="tbl_').each(function () {
                     if($(this).attr("tableid")==tableId){
                    $(this).find('[id^="result"]').each(function () {
                        if($(this).parent().attr("colkey") == colid1){
                        debugger;
                        var intval = 0;
                        if($(this).val().length != 0){
                            intval = parseInt($(this).val())                
                        } 
                        sum2 += intval;
                        $("#lblGT_"+colid1).text(Math.round(eval(eval(sum2)*1000))/1000);     
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
    
    
    
    function validationForConfirmation()
            {
               // alert('in fum');
                $.ajax({
                   url:'${pageContext.servletContext.contextPath}/eBid/Bid/validateBiddingTime/${tblTender.tenderId}',
                   async:false,
                   success:function(result){
                      // alert(result);
                       if(result === 'false')
                       {
                        $('#error').show();
                        return false;
                       }
                       else
                       {
                           $('#error').hide();
                           return true;
                       }
                       
                   },
                   error:function(result){
                    return false;
                   }
                });       
                 
               
            }
    function createJson()
    {
        if(parseInt(isAuction)===1)
        {
         
         return  validationForConfirmation();
        }
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
                if($(this).attr("cellID")!==undefined){
             
   
            var ColumnJson={};
            var val;
                 //Table ID
                 //console.log($(this).attr("tableid"));
                // Row ID
                // console.log($(this).attr("trid"));
                //Column ID
                 //console.log($(this).attr("colKey"));
                
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
       console.log(jstr);
       
        var ArrGTColumnJson={};
      
       $('[id^="trGT_"]').each(function () {
            $(this).find('[id^="lblGT_"]').each(function () {
               var GTSubJson={};
                    GTSubJson['colId'] = $(this).attr("colId");
                    GTSubJson['tableId'] =  $(this).attr("TableId");
                    GTSubJson['FormId'] =  $('#hdnFormId').val();
                    GTSubJson['GTValue'] = $(this).text();
                    var jsonV = "GTColumn_"+ $(this).attr("colId");
                    ArrGTColumnJson[jsonV] = GTSubJson;
                });
            });
    
        var jstrGT=JSON.stringify(ArrGTColumnJson);
        $('#hdnGTColumnValue').val(jstrGT);
    return true;
    }
    
</script>
</body>
</html>