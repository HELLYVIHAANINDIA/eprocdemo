<%@include file="../../includes/head.jsp"%>
<%@include file="../../includes/masterheader.jsp"%>

<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="java.util.TimeZone"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.concurrent.TimeUnit"%>
<%@page import="com.eprocurement.etender.model.TblTender"%>
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
            DataTypeMessage.add("Enter value in Small Text (Max. 2000 characters)");
            DataTypeMessage.add("Enter value in Long text (Max. 10000 characters)");
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
    <div class="col-md-6 pull-left">              
                    <c:choose>
                        <c:when test="${sessionUserTypeId eq 2}">
                            <h1 class="inline">
                                <c:if test="${isAuction eq 1}"><spring:message code="lbl_bidding_hall" /></c:if>
                            <c:if test="${isAuction eq 0}"><spring:message code="lbl_fill_form" /></c:if>
                            </h1>
                        </c:when>  
                        <c:when test="${sessionUserTypeId eq 1}">
                            <h1 class="inline"><spring:message code="lbl_view_bidding_form" /> </h1>
                        </c:when>
                    </c:choose> 
                </div>
                <div class="col-md-6 text-right">
                    <spring:message code="lbl_back_dashboard" var='backDashboard'/>
             
                            <c:choose>
                        <c:when test="${sessionUserTypeId eq 2}">
                            
                            
                                <c:if test="${isAuction eq 1}"><a href="${pageContext.servletContext.contextPath}/etender/bidder/biddingTenderDashboard/${tenderId}" class="g g-back"><< <spring:message code="lbl_go_back_to_auction_dashboard" /></a></c:if>
                                 <c:if test="${isAuction eq 0}"><a href="${pageContext.servletContext.contextPath}/etender/bidder/biddingtenderdashboardcontent/${tenderId}/5" class="g g-back"><< ${backDashboard}</a></c:if>
                                
                        </c:when>
                        <c:otherwise>
                      
                            <c:if test="${isAuction eq 1}">
                  
                                                              
                        <c:if test="${not empty isFormLibrary}">
                                                <a href="${pageContext.servletContext.contextPath}/eBid/Bid/getFormLibrary/${FormLibrarytenderId}" class="g g-back">
                                                << <spring:message code="lbl_go_to_gorm_library" /></a>
                                            </c:if>
                                            <c:if test="${empty isFormLibrary}">
                                                 <a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}" class="g g-back">
                                               << <spring:message code="lbl_go_back_to_auction_dashboard" />
                                               </a>
                                            </c:if>
                    </c:if>
                    <c:if test="${isAuction eq 0}">
                        
                            <a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}" class="g g-back"><< ${backDashboard}</a>                                             
                         </c:if>
                        </c:otherwise>
                    </c:choose>
</section>

                   <div class="row">
                       <div class="col-md-12">
                        <c:if test="${not empty successMsg}">
					<div class="alert alert-success"><spring:message code="${successMsg}"/></div>
				</c:if>
				<c:if test="${not empty errorMsg}">
					<div class="alert alert-danger"><spring:message code="${errorMsg}"/></div>
				</c:if>
                </div>
                   </div>
                    <c:if test="${isAuction eq 1 and sessionUserTypeId eq 2}">
                         <div class="row">
                             <div class="col-md-12">
                    <div class="alert alert-success">
                            -	You are advised not to wait till the last minute or last few seconds to submit your bid to avoid complications related with internet connectivity, network problems, system crash down, power failure, etc. Department would not be responsible for these unforeseen circumstances.
                             </div>
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
                              <%@include file="../buyer/AuctionSummary.jsp" %>
                <div class="row">
                    <div class="col-lg-12 col-md-12">
                        <div class="box">
                            <div class="box-header with-border">
                                <div class="row">
                                    <div class='col-md-12'>
                                        <div class='col-sm-3 col-md-3'>
                                            <div class='lbl-2'><spring:message code="lbl_current_time" /> :</div>
                                        </div>
                                        <div class='col-sm-3 col-md-3'>
                                            <div class='lbl-3' id="divServerCurrentTime">                                              
                                            </div>
                                        </div>
                                        
                                        <div class='col-sm-6 col-md-6'>
                                            <div class='lbl-2' id="countdown">
                                                
                                            </div>
                                        </div>
                                    </div>
                                   
                                    
                                    <div id="divCurrentTime">
                                        
                                    </div>
                                            

                                        <%--<div class="col-md-12">
                                            <div class="col-sm-3 col-md-3">
                                                        <div class="form_filed text-black text-right">Minimum Bid Amount:</div>
                                            </div>
                                            <div class="col-sm-3 col-md-3">
                                                        <div class="form_filed text-black text-right" > 
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
                                            <div class="lbl-3"><spring:message code="lbl_form_id" /></div>
                                        </div>
                                        <div class="col-sm-2 col-md-2">
                                            <div class="lbl-2">${formId}</div>
                                        </div>
                                        <div class="col-sm-2 col-md-2">
                                            <div class="lbl-3"><spring:message code="field_formName" /></div>
                                        </div>
                                        <div class="col-sm-2 col-md-2">
                                            <div class="lbl-2">${FormBean.FormName}</div>
                                        </div>
                                        <div class="col-sm-2 col-md-2">
                                            <div class="lbl-3"><spring:message code="lbl_createdon" /></div>
                                        </div>
                                        <div class="col-sm-2 col-md-2">
                                            <div class="lbl-2">${FormBean.CreatedOn}</div>
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

                                        <div class="col-sm-2 col-md-2">
                                            <div class="form_filed text-right text-black"><spring:message code="lbl_envelop" /></div>
                                        </div>
                                        <div class="col-sm-2 col-md-2">
                                            <div class="form_filed  pull-left">${FormBean.envelopeName}</div>
                                        </div>
                                        <c:if test="${FormBean.IsMandatory eq 1 && tblTender.isWeightageEvaluationRequired eq 1}">
                                         <div class="col-sm-2 col-md-2">
                                            <div class="form_filed text-right text-black"><spring:message code="lbl_weightage"/>:</div>
                                        </div>
                                        <div class="col-sm-2 col-md-2">
                                            <div class="form_filed  pull-left">${FormBean.formWeight}</div>
                                        </div>
                                        </c:if>
                                    </div>
									</c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                                           
                <c:if test="${operation eq 'edit'}">
                          <div class="row">
                              <form id="tenderDtBean" name="tenderDtBean" action="${pageContext.servletContext.contextPath}/eBid/Bid/updateBiddingFormValueForEdit" method="post" onsubmit="if(valOnSubmit()){return createJson();} else {return false ;}" novalidate >
                              <c:if test="${sessionUserTypeId eq 2}">
				                  <div class="col-lg-12 col-md-12" id="divdownloadupload" style="display: none;">
				                        <div class="box">
						                            <div class="col-md-12">
						                                <h3 class="box-title"> 
						                                	<div>
											                  <input class="pull-left" type="file" id="uploadFormData" name="uploadFormData" class="upload" onchange="checkFile(this)"/>
											                  <input type="text" id="fileToUploadName" name="fileToUploadName" class="form-control" value="" readonly>
											                  <button type="button" onclick="$.blockUI({onBlock: function() {fillFormByExcel();$.unblockUI();}});" class="btn btn-submit">
																<spring:message code="lbl_upload" />
															</button>
											                  <a class="pull-right" href="${pageContext.servletContext.contextPath}/etender/bidder/downloadform/${tenderId}/${formId}" >Download <%=tblTenderForm.getFormName()%>  as excel </a>
										                  </div>
										                 </h3>
										                 
										             </div>
										        </div>
								   </div>
							   </c:if>
                    <div class="col-lg-12 col-md-12">
                        <div class="box">
                            <div class="col-md-12">
                                <h4 class="box-title">  <%=tblTenderForm.getFormName()%> </h4>
                            </div>

                            <div class="box-body" style="overflow: scroll;">
                                <div class="row">
                                    <div class="col-md-12">
                                        <h4 style="padding-top:0px;margin-top:0px;"><%=tblTenderForm.getFormHeader()%></h4>
                                    </div>
                                    <%
                                        int count1 = 0;
                                        for (TblTenderTable tblTenderTable : lstTable) {
                                            List<TblTenderColumn> lstCol = (List) column.get(tblTenderTable.getTableId());
                                    %>
                                     
                                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                        <div class="box">
                                           
                                            <c:if test="${isAuction eq 0}">
                                                <div class="box-header with-border">
                                                
                                                <h4 class="box-title"><b><%=tblTenderTable.getTableName()%></b></h4>
                                                        <%
                                                            String val = "";
                                                            if (tblTenderTable.getIsMandatory() == 0) {
                                                                val = "No";
                                                            } else {
                                                                val = "Yes";
                                                            }
                                                        %>
                                                <h4 class="box-title pull-right" ><b><spring:message code="lbl_is_table_mandatory" /></b><%=val%></h4>
                                            </div>
                                          
                                            
                                            <div class="box-header with-border">
                                                <h4 class="box-title"><%=tblTenderTable.getTableHeader()%></h4>
                                            </div>
						  </c:if>
						<div class="box-body">
							<div class="row">
								<c:if test="${sessionUserTypeId eq 2 and listOfCurrency ne null and not empty listOfCurrency and isRepeated and FormBean.IsPriceBid eq 1}">
									<div class="col-lg-12 col-md-12 col-xs-12">
									 <label class="pull-right"><b><spring:message code="lbl_bid_currency" /> 
										 ${selectedCurrency}</b><br/><br/></label>
									</div>
								</c:if>
								<div class="col-lg-12 col-md-12 col-xs-12">
									<table class="table table-striped table-responsive" id="tbl_<%=count1++%>" tableId="<%=tblTenderTable.getTableId()%>">
										<thead>
											<tr>
                                                                                            <%for(TblTenderColumn obj:lstCol)
                                                                                            {
                                                                                                %>
                                                                                                <th>Column Name: <%=obj.getColumnHeader()%>
                                                                                                    <br>Filled By: <%=UserEnum.getNameById(obj.getFilledBy()).replaceAll("_", " ")%>
                                                                                                    <br> Data Type: <%=DataTypeEnum.getNameById(obj.getDataType()).replaceAll("_", " ")%>
                                                                                                 </th>
                                                                                                <%}
                                                                                                    %>
											</tr>
										</thead>
										<tbody>
                                                                                    <%
                                                                                        String ColId="";
                                                                                        String ColIdName = "";
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
                                                                                                            ColId="result_"+i+ "_" + TblTenderColumn.getColumnId();
                                                                                                            ColIdName="txtcell_0_"+TblTenderColumn.getColumnId()+"_"+i;  
                                                                                                        }
                                                                                                        else
                                                                                                        {
                                                                                                          ColId="txtcell_0_"+TblTenderColumn.getColumnId()+"_"+i;  
                                                                                                          ColIdName="txtcell_0_"+TblTenderColumn.getColumnId()+"_"+i;  
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
                                                                                                                        <%	if (tblTenderTable.getIsMandatory() == 0){ %>
                                                                                                                        <input type="text" 
                                                                                                                               validarr="length:0,2000" tovalid="true" onblur="validateTextComponent(this)" 
                                                                                                                               tableid="<%=tblTenderTable.getTableId()%>"  
                                                                                                                               title="<%=TblTenderColumn.getColumnHeader()%>"
                                                                                                                               placeholder="<%=DataTypeMessage.get(TblTenderColumn.getDataType()-1)%>" colKey="<%=TblTenderColumn.getColumnId()%>" 
                                                                                                                               value="<%=value%>" class="clstxtcell <%=ColIdName%>" rowid="<%=i%>"
                                                                                                                               id="<%=ColId%>" cellid="<%=cellId%>">
                                                                                                                        <%}else{ %>
 																														
                                                                                                                        <input type="text" 
                                                                                                                               validarr="required@@length:0,2000" tovalid="true" onblur="validateTextComponent(this)" 
                                                                                                                               tableid="<%=tblTenderTable.getTableId()%>"  
                                                                                                                               title="<%=TblTenderColumn.getColumnHeader()%>"
                                                                                                                               placeholder="<%=DataTypeMessage.get(TblTenderColumn.getDataType()-1)%>" colKey="<%=TblTenderColumn.getColumnId()%>" 
                                                                                                                               value="<%=value%>" class="clstxtcell <%=ColIdName%>" rowid="<%=i%>"
                                                                                                                               id="<%=ColId%>" cellid="<%=cellId%>">
                                                                                                                               <%} %>
                                                                                                                        <%}
                                                                                                                         else if(!isTextBox && isShown)
                                                                                                                        {%>
                                                                                                                        <input type="text" onblur="ValidateInput(<%=dataType%>,this);" class="<%=ColIdName%>" disabled="true" value="<%=value%>" id="<%=ColId%>"  attrformula="<%=formula%>" >
                                                                                                                        <%}
                                                                                                                        
                                                                                                                        break;
                                                                                                                    case 2:
                                                                                                                         if(isTextBox && isShown)
                                                                                                                        {
                                                                                                                        %>
                                                                                                                        <%	if (tblTenderTable.getIsMandatory() == 0){ %>
                                                                                                                        <textarea validarr="length:0,10000" tovalid="true" onblur="validateTextComponent(this)" 
                                                                                                                               tableid="<%=tblTenderTable.getTableId()%>"  
                                                                                                                               title="<%=TblTenderColumn.getColumnHeader()%>"
                                                                                                                               placeholder="<%=DataTypeMessage.get(TblTenderColumn.getDataType()-1)%>" colKey="<%=TblTenderColumn.getColumnId()%>"  
                                                                                                                               class="clstxtcell <%=ColIdName%>" rowid="<%=i%>"
                                                                                                                               id="<%=ColId%>"  cellid="<%=cellId%>" ><%=value%></textarea>
																														 <%}else{ %>
																														 <textarea validarr="required@@length:0,10000" tovalid="true" onblur="validateTextComponent(this)" 
                                                                                                                               tableid="<%=tblTenderTable.getTableId()%>"  
                                                                                                                               title="<%=TblTenderColumn.getColumnHeader()%>"
                                                                                                                               placeholder="<%=DataTypeMessage.get(TblTenderColumn.getDataType()-1)%>" colKey="<%=TblTenderColumn.getColumnId()%>"  
                                                                                                                               class="clstxtcell <%=ColIdName%>" rowid="<%=i%>"
                                                                                                                               id="<%=ColId%>"  cellid="<%=cellId%>" ><%=value%></textarea>
																														 <%} %>
                                                                                                                        
                                                                                                                    
                                                                                                                        <%}
                                                                                                                         else if(!isTextBox && isShown)
                                                                                                                        {%>
                                                                                                                        <textarea onblur="ValidateInput(<%=dataType%>,this);" disabled="true" class="<%=ColIdName%>" id="<%=ColId%>"  attrformula="<%=formula%>"><%=value%></textarea>
                                                                                                                        
                                                                                                                        <%}
                                                                                                                        
                                                                                                                        break;
                                                                                                                     case 3:
                                                                                                                           if(isTextBox && isShown)
                                                                                                                        {
                                                                                                                        %>
                                                                                                                        <c:if test="${tblTender.isAuction eq 1}">
                                                                                                                            <input type="text"  
                                                                                                                               validarr="required@@posnegnumwithdecimal:${tblTender.decimalValueUpto}@@nonzero" tovalid="true" onblur="validateTextComponent(this)" 
                                                                                                                               title="<%=TblTenderColumn.getColumnHeader()%>" 
                                                                                                                               onblur="ValidateInput(<%=dataType%>,this);"  
                                                                                                                               tableid="<%=tblTenderTable.getTableId()%>" placeholder="<%=DataTypeMessage.get(TblTenderColumn.getDataType()-1)%>" 
                                                                                                                               colKey="<%=TblTenderColumn.getColumnId()%>" value="<%=value%>"  
                                                                                                                               class="clstxtcell <%=ColIdName%>"  rowid="<%=i%>" 
                                                                                                                               id="<%=ColId%>"  cellid="<%=cellId%>" 
                                                                                                                               >
                                                                                                                        </c:if>
                                                                                                                        
                                                                                                                        <c:if test="${tblTender.isAuction ne 1}">
	                                                                                                                        <%	if (tblTenderTable.getIsMandatory() == 0){ %>
	                                                                                                                         <input type="number"  
	                                                                                                                               validarr="numwithdecimal:2" tovalid="true" onblur="validateTextComponent(this)" 
	                                                                                                                               title="<%=TblTenderColumn.getColumnHeader()%>" 
	                                                                                                                               onblur="ValidateInput(<%=dataType%>,this);"  
	                                                                                                                               tableid="<%=tblTenderTable.getTableId()%>" placeholder="<%=DataTypeMessage.get(TblTenderColumn.getDataType()-1)%>" 
	                                                                                                                               colKey="<%=TblTenderColumn.getColumnId()%>" value="<%=value%>"  
	                                                                                                                               class="clstxtcell <%=ColIdName%>"  rowid="<%=i%>" 
	                                                                                                                               id="<%=ColId%>"  cellid="<%=cellId%>">
																															 <%}else{ %>
																															  <input type="number"  
	                                                                                                                               validarr="required@@numwithdecimal:2" tovalid="true" onblur="validateTextComponent(this)" 
	                                                                                                                               title="<%=TblTenderColumn.getColumnHeader()%>" 
	                                                                                                                               onblur="ValidateInput(<%=dataType%>,this);"  
	                                                                                                                               tableid="<%=tblTenderTable.getTableId()%>" placeholder="<%=DataTypeMessage.get(TblTenderColumn.getDataType()-1)%>" 
	                                                                                                                               colKey="<%=TblTenderColumn.getColumnId()%>" value="<%=value%>"  
	                                                                                                                               class="clstxtcell <%=ColIdName%>"  rowid="<%=i%>" 
	                                                                                                                               id="<%=ColId%>"  cellid="<%=cellId%>">
																															 <%} %>
                                                                                                                        </c:if>
                                                                                                                        
                                                                                                                        <%}
                                                                                                                         else if(!isTextBox && isShown)
                                                                                                                        {%>
                                                                                                                        <input type="text" disabled="true" value="<%=value%>" id="<%=ColId%>" class="<%=ColIdName%>"  attrformula="<%=formula%>">
                                                                                                                        <%}
                                                                                                                        break;
                                                                                                                    case 4:
                                                                                                                         if(isTextBox && isShown)
                                                                                                                        {
                                                                                                                        %>
                                                                                                                        <c:if test="${tblTender.isAuction eq 1}">
                                                                                                                            <input type="number"  
                                                                                                                               validarr="required@@posnegnumeric@@nonzero" tovalid="true" onblur="validateTextComponent(this)" 
                                                                                                                               title="<%=TblTenderColumn.getColumnHeader()%>" 
                                                                                                                               onblur="ValidateInput(<%=dataType%>,this);"  
                                                                                                                               tableid="<%=tblTenderTable.getTableId()%>" placeholder="<%=DataTypeMessage.get(TblTenderColumn.getDataType()-1)%>" 
                                                                                                                               colKey="<%=TblTenderColumn.getColumnId()%>" value="<%=value%>"  
                                                                                                                               class="clstxtcell <%=ColIdName%>"  rowid="<%=i%>" 
                                                                                                                               id="<%=ColId%>"  cellid="<%=cellId%>"  
                                                                                                                               attrformula="<%=formula%>"
                                                                                                                               >
                                                                                                                        </c:if>
                                                                                                                        <c:if test="${tblTender.isAuction ne 1}">
                                                                                                                        <%	if (tblTenderTable.getIsMandatory() == 0){ %>
                                                                                                                         <input type="number"  
                                                                                                                               validarr="numeric" tovalid="true" onblur="validateTextComponent(this)" 
                                                                                                                               title="<%=TblTenderColumn.getColumnHeader()%>" 
                                                                                                                               onblur="ValidateInput(<%=dataType%>,this);"  
                                                                                                                               tableid="<%=tblTenderTable.getTableId()%>" placeholder="<%=DataTypeMessage.get(TblTenderColumn.getDataType()-1)%>" 
                                                                                                                               colKey="<%=TblTenderColumn.getColumnId()%>" value="<%=value%>"  
                                                                                                                               class="clstxtcell <%=ColIdName%>"  rowid="<%=i%>" 
                                                                                                                               id="<%=ColId%>"  cellid="<%=cellId%>"  
                                                                                                                               attrformula="<%=formula%>">
																														 <%}else{ %>
																														  <input type="number"  
                                                                                                                               validarr="required@@numeric" tovalid="true" onblur="validateTextComponent(this)" 
                                                                                                                               title="<%=TblTenderColumn.getColumnHeader()%>" 
                                                                                                                               onblur="ValidateInput(<%=dataType%>,this);"  
                                                                                                                               tableid="<%=tblTenderTable.getTableId()%>" placeholder="<%=DataTypeMessage.get(TblTenderColumn.getDataType()-1)%>" 
                                                                                                                               colKey="<%=TblTenderColumn.getColumnId()%>" value="<%=value%>"  
                                                                                                                               class="clstxtcell <%=ColIdName%>"  rowid="<%=i%>" 
                                                                                                                               id="<%=ColId%>"  cellid="<%=cellId%>"  
                                                                                                                               attrformula="<%=formula%>">
																														 <%} %>
                                                                                                                           
                                                                                                                        </c:if>
                                                                                                                        
                                                                                                                            
                                                                                                                        
                                                                                                                        
                                                                                                                        <%}
                                                                                                                         else if(!isTextBox && isShown)
                                                                                                                        {%>
                                                                                                                            <input type="text" disabled="true" value="<%=value%>" id="<%=ColId%>" class="<%=ColIdName%>" attrformula="<%=formula%>" >
                                                                                                                        <%}
                                                                                                                            break;
                                                                                                                    case 5:
                                                                                                                        if(isTextBox && isShown)
                                                                                                                        {
                                                                                                                        %>
                                                                                                                        <c:if test="${tblTender.isAuction eq 1}">
                                                                                                                          
                                                                                                                         <input type="number"  
                                                                                                                               validarr="required@@posnegnumwithdecimal:${tblTender.decimalValueUpto}" tovalid="true" onblur="validateTextComponent(this)" 
                                                                                                                               title="<%=TblTenderColumn.getColumnHeader()%>" 
                                                                                                                               onblur="ValidateInput(<%=dataType%>,this);"  
                                                                                                                               tableid="<%=tblTenderTable.getTableId()%>" placeholder="<%=DataTypeMessage.get(TblTenderColumn.getDataType()-1)%>" 
                                                                                                                               colKey="<%=TblTenderColumn.getColumnId()%>" value="<%=value%>"  
                                                                                                                               class="clstxtcell <%=ColIdName%>"  rowid="<%=i%>" 
                                                                                                                               id="<%=ColId%>"  cellid="<%=cellId%>"  
                                                                                                                               attrformula="<%=formula%>"
                                                                                                                               >
                                                                                                                        </c:if>
                                                                                                                        <c:if test="${tblTender.isAuction ne 1}">
                                                                                                                        <%	if (tblTenderTable.getIsMandatory() == 0){ %>
                                                                                                                            <input type="number"  
                                                                                                                               validarr="numanduptodecimal:2" tovalid="true" onblur="validateTextComponent(this)" 
                                                                                                                               title="<%=TblTenderColumn.getColumnHeader()%>" 
                                                                                                                               onblur="ValidateInput(<%=dataType%>,this);"  
                                                                                                                               tableid="<%=tblTenderTable.getTableId()%>" placeholder="<%=DataTypeMessage.get(TblTenderColumn.getDataType()-1)%>" 
                                                                                                                               colKey="<%=TblTenderColumn.getColumnId()%>" value="<%=value%>"  
                                                                                                                               class="clstxtcell <%=ColIdName%>"  rowid="<%=i%>" 
                                                                                                                               id="<%=ColId%>"  cellid="<%=cellId%>"  
                                                                                                                               attrformula="<%=formula%>"
                                                                                                                               >
                                                                                                                               <%}else{ %>
                                                                                                                               <input type="number"  
                                                                                                                               validarr="required@@numanduptodecimal:2" tovalid="true" onblur="validateTextComponent(this)" 
                                                                                                                               title="<%=TblTenderColumn.getColumnHeader()%>" 
                                                                                                                               onblur="ValidateInput(<%=dataType%>,this);"  
                                                                                                                               tableid="<%=tblTenderTable.getTableId()%>" placeholder="<%=DataTypeMessage.get(TblTenderColumn.getDataType()-1)%>" 
                                                                                                                               colKey="<%=TblTenderColumn.getColumnId()%>" value="<%=value%>"  
                                                                                                                               class="clstxtcell <%=ColIdName%>"  rowid="<%=i%>" 
                                                                                                                               id="<%=ColId%>"  cellid="<%=cellId%>"  
                                                                                                                               attrformula="<%=formula%>"
                                                                                                                               >
                                                                                                                          <%} %>
                                                                                                                        </c:if>
                                                                                                                        
                                                                                                                        <%}
                                                                                                                         else if(!isTextBox && isShown)
                                                                                                                        {%>
                                                                                                                        <input type="text" disabled="true" value="<%=value%>" id="<%=ColId%>" attrformula="<%=formula%>" class="<%=ColIdName%>" >
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
                                                                                                                        <input type="date" onblur="ValidateInput(<%=dataType%>,this);" colKey="<%=TblTenderColumn.getColumnId()%>" value="<%=value%>" >
                                                                                                                        <%}
                                                                                                                         else if(!isTextBox && isShown)
                                                                                                                        {%>
                                                                                                                        <input type="date" onblur="ValidateInput(<%=dataType%>,this);" readonly="true" value="<%=value%>" id="<%=ColId%>" class="<%=ColIdName%>">
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
                                                                                                                        <input type="text" colKey="<%=TblTenderColumn.getColumnId()%>"  class="clstxtcell <%=ColIdName%>" rowid="<%=i%>" id="<%=ColId%>" >
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
                                                                                                                   = 
                                                                                                                              
                                                                                                                              
                                                                                                                              <label id="lblGT_<%=TblTenderColumn.getColumnId()%>" colId="<%=TblTenderColumn.getColumnId()%>"  TableId="<%=TblTenderColumn.getTblTenderTable().getTableId()%>"></label>
                                                                                                                              <%}
                                                                                                                  %>
                                                                                                              <c:if test="${isAuction eq 1 && tblTender.biddingType eq 2 && sessionUserTypeId eq 2}">
                                                                                                                      <br>
                                                                                                                     <%
                                                                                                                  if(TblTenderColumn.getisGTColumn()==1)
                                                                                                                  {
                                                                                                                      if(TblTenderColumn.getColumnHeader().toLowerCase().contains("total"))
                                                                                                                        out.println(TblTenderColumn.getColumnHeader());
                                                                                                                      else
                                                                                                                        out.println("Total "+TblTenderColumn.getColumnHeader());
                                                                                                                              %>
                                                                                                                             (In Base Currency (${currncyName})) 
                                                                                                                           = <label id="lblGTBase<%=TblTenderColumn.getColumnId()%>"  colId="<%=TblTenderColumn.getColumnId()%>" TableId="<%=TblTenderColumn.getTblTenderTable().getTableId()%>"></label>
                                                                                                                              <%}
                                                                                                                              
                                                                                                                  %> 
                                                                                                                  </c:if>
                                                                                                          </td>
                                                                                                   
                                                                                                        <%
                                                                                                    }   
                                                                                                
                                                                                                %>
                                                                                                
                                                                                            </tr>
                                                                                </tbody>
									</table>
								</div>
							</div>
						</div>
                                              <c:if test="${isAuction eq 0}">
                                                  <div class="box-header with-border">
							<h4 class="box-title"><%=tblTenderTable.getTableFooter()%></h4>
						</div>

                                              </c:if>
                                                                                        
					</div>

                                        </div>
                                           <% }
                                            %>
                                            
                                            <div class="col-lg-12">
                                                <h4><%=tblTenderForm.getFormFooter()%></h4>
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
                                                <%
                                                    if(!opt.equals("0"))
                                                    {
            
                                                    %>
                                    <div class="col-md-12 text-center">
                                    <c:if test="${sessionUserTypeId eq 2}">
                                    	<input type="hidden" id="hdFormActionS" name="hdFormActionS" value="2">
                                    	<spring:message code="lbl_form_save_as_draft" var="varSaveAsDraft"/>
                                    	<c:if test="${isAuction ne 1}">
                                            
                                    		<button type="submit" class="btn btn-submit" id="btndraftForm">${varSaveAsDraft}</button>
                                               
                                    	</c:if>
                                           <button type="submit" class="btn btn-submit" id="btnSubmitForm"><spring:message code="label_submit" /></button>
                                    	 
                                    	
                                    </c:if>
                                    <c:if test="${sessionUserTypeId eq 1}">
                                        <button type="submit" class="btn btn-submit" id="btnSubmitForm"><spring:message code="label_submit" /></button>
                                     
                                    </c:if>
                                    </div>
                                     <%}%>
                                </div>
                            </div>
                        </div>
                    </div>
                
                                     <input type="hidden" id="hdnFormId" name="hdnFormId" value="<%=tblTenderForm.getFormId()%>">
                                     <input type="hidden" id="txtJson" name="txtJson">
                                     <input type="hidden" id="hdnGTColumnValue" name="hdnGTColumnValue">
                                     <input type="hidden" value="<%=tenderId%>" name="tenderId">
                         
                     </form>
                                     </div>
                </c:if>
                <c:if test="${empty operation}">

                <div class="row">
                    <div class="col-lg-12 col-md-12">
                        <div class="box">
                            <div class="col-md-6">
                                <h4 class="box-title">  <%=tblTenderForm.getFormName()%> </h4>
                            </div>
                            <div class="col-md-6 text-right" >
                                        
                                         </div>
                            <div class="box-body">
                                <div class="row">
                                        <div class="col-md-12">
                                            <h4 style="padding-top:0px;margin-top:0px;"><%=tblTenderForm.getFormHeader()%></h4>
                                        </div>
                                        <%
                                            int count=0;
                                            for(TblTenderTable tblTenderTable:lstTable)
                                            {
                                                List <TblTenderColumn>lstCol=(List)column.get(tblTenderTable.getTableId());
                                        %>
                                     
                                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">

                                        	<div class="box">
                                                    <c:if test="${isAuction eq 0}">
                                                        <div class="box-header with-border">
							<h4 class="box-title"><b><%=tblTenderTable.getTableName()%></b></h4>
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
                                                           <h4 class="box-title pull-right" ><b> Is Table Mandatory:</b>&nbsp;<%=val%></h4>
						</div>
                                                <div class="box-header with-border">
							<h4 class="box-title"><%=tblTenderTable.getTableHeader()%></h4>
						</div>
                                                    </c:if>
						

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
                                                                                        String ColId="";
                                                                                        String ColIdName = "";
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
                                                                                                        cellId=0;
                                                                                                        if(cell.containsKey(key))
                                                                                                        {   
                                                                                                            TblTenderCell TblTenderCell=new TblTenderCell();
                                                                                                            TblTenderCell=(TblTenderCell)cell.get(key);
                                                                                                            value=(String)TblTenderCell.getCellValue();
                                                                                                            cellId=(int)TblTenderCell.getCellId();
                                                                                                        }
                                                                                                
                                                                                                %>
                                                                                                <a href="BiddingFormDocument.jsp"></a>
                                                                                                     <td  trid="<%=i%>" colKey="<%=TblTenderColumn.getColumnId()%>">
                                                                                                    <%
                                                                                                        if(formFormulaWithColumn!=null && formFormulaWithColumn.containsKey(TblTenderColumn.getColumnId()+"") )
                                                                                                        {
                                                                                                            formula=(String)formFormulaWithColumn.get(TblTenderColumn.getColumnId()+"");
                                                                                                            ColId="result_"+i+"_" + TblTenderColumn.getColumnId();
                                                                                                            ColIdName="txtcell_0_"+TblTenderColumn.getColumnId()+"_"+i;  
                                                                                                        }
                                                                                                        else
                                                                                                        {
                                                                                                          ColId="txtcell_0_"+TblTenderColumn.getColumnId()+"_"+i;  
                                                                                                          ColIdName="txtcell_0_"+TblTenderColumn.getColumnId()+"_"+i;  
                                                                                                        }
                                                                                                                
                                                                                                        int dataType=TblTenderColumn.getDataType();
                                                                                                                
                                                                                                                switch(dataType)
                                                                                                                {
                                                                                                                    case 1:
                                                                                                                        %>
                                                                                                                        <input type="text" 
                                                                                                                               disabled="true" colKey="<%=TblTenderColumn.getColumnId()%>"  class="clstxtcell  <%=ColIdName%>" 
                                                                                                                              rowid="<%=i%>" 
                                                                                                                              id="<%=ColId%>" value="<%=value%>">
                                                                                                                        <%
                                                                                                                         break;
                                                                                                                    case 2:
                                                                                                                       %>
                                                                                                                       <textarea disabled="true" colKey="<%=TblTenderColumn.getColumnId()%>"  class="clstxtcell  <%=ColIdName%>" 
                                                                                                                              rowid="<%=i%>" 
                                                                                                                               id="<%=ColId%>"><%=value%></textarea>
                                                                                                                       
                                                                                                                        
                                                                                                                        <%
                                                                                                                        
                                                                                                                        break;
                                                                                                                    case 3:
                                                                                                                        
                                                                                                                    case 4:
                                                                                                                        
                                                                                                                    case 5:
                                                                                                                          
                                                                                                                        %>
                                                                                                                         <input type="text" disabled="true" colKey="<%=TblTenderColumn.getColumnId()%>" value="<%=value%>" 
                                                                                                                              class="clstxtcell <%=ColIdName%>" 
                                                                                                                              rowid="<%=i%>"
                                                                                                                               id="<%=ColId%>" attrformula="<%=formula%>" cellid="<%=cellId%>">
                                                                                                                        
                                                                                                                        <%
                                                                                                                            break;
                                                                                                                    case 6:
                                                                                                                      %>
                                                                                                                       <label ><%=i+1%></label>
                                                                                                                       
                                                                                                                        <%
                                                                                                                        break;
                                                                                                                    case 7:
                                                                                                                     %>
                                                                                                                        <input type="date" onblur="ValidateInput(<%=dataType%>,this);" readonly="true" value="<%=value%>"  cellid="<%=cellId%>">
                                                                                                                        <%
                                                                                                                        break;
                                                                                                                    case 8:
                                                                                                                    %>
                                                                                                                    <select colKey="<%=TblTenderColumn.getColumnId()%>" ><option>--Select--</option></select>
                                                                                                                    <%
                                                                                                                        break;
                                                                                                                    case 9:
                                                                                                                       %>
                                                                                                                        <input type="file"  readonly="true"  cellid="<%=cellId%>">
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
                                                                                                                              
                                                                                                                           = <label id="lblGT_<%=TblTenderColumn.getColumnId()%>"  colId="<%=TblTenderColumn.getColumnId()%>"></label>
                                                                                                                              <%}
                                                                                                                              
                                                                                                                  %>
                                                                                                                  <c:if test="${isAuction eq 1 && tblTender.biddingType eq 2 && sessionUserTypeId eq 2}">
                                                                                                                      <br>
                                                                                                                     <%
                                                                                                                  if(TblTenderColumn.getisGTColumn()==1)
                                                                                                                  {
                                                                                                                      if(TblTenderColumn.getColumnHeader().toLowerCase().contains("total"))
                                                                                                                        out.println(TblTenderColumn.getColumnHeader());
                                                                                                                      else
                                                                                                                        out.println("Total "+TblTenderColumn.getColumnHeader());
                                                                                                                              %>
                                                                                                                             (In Base Currency (${currncyName})) 
                                                                                                                           = <label id="lblGTBase<%=TblTenderColumn.getColumnId()%>"  colId="<%=TblTenderColumn.getColumnId()%>"></label>
                                                                                                                              <%}
                                                                                                                              
                                                                                                                  %> 
                                                                                                                  </c:if>
                                                                                                                  
                                                                                                             
                                                                                                          </td>
                                                                                                   
                                                                                                        <%
                                                                                                    }   
                                                                                                
                                                                                                %>
                                                                                                
                                                                                            </tr>
                                                                                       
                                                                                </tbody>
									</table>
								</div>
							</div>
						</div>
                                                
                                                <c:if test="${isAuction eq 0}">
                                                <div class="box-header with-border">
							<h4 class="box-title"><%=tblTenderTable.getTableFooter()%></h4>
						</div>  
                                                </c:if>
                                                                                                

					</div>

                                        </div>
                                           <% }
                                            %>
                                            
                                            <div class="col-lg-12">
                                                <h4><%=tblTenderForm.getFormFooter()%></h4>
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
                                                                            <th><spring:message code="lbl_formula" /></th>
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
                          <button type="button" onclick="window.history.back();" class="btn btn-submit  pull-right" id="btnSubmitForm"><spring:message code="lbl_back" /></button>
                                        
                      </div>
                   
                             
                                     
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                                            
                                                
                                            <input type="hidden" id="hdnFormId" name="hdnFormId" value="<%=tblTenderForm.getFormId()%>">
                                            <input type="hidden" id="txtJson" name="txtJson">
                                                <input type="hidden" value="<%=tenderId%>" name="tenderId">
                         
                 </c:if>
                     
            </section>
        </div>
<script src="${pageContext.servletContext.contextPath}/resources/js/ajaxfileupload.js" type="text/javascript"></script>
<script>
    var isAuction='${isAuction}';
    var exchangeRate='${ExchangeRate}';
    var global='${tblTender.biddingType}';
    var sessionType='${sessionUserTypeId}';
    var decimal = '${tblTender.decimalValueUpto}';
    
$('#btndraftForm').click(function(){
	$('#hdFormActionS').val('1');
});

   var url = '${pageContext.servletContext.contextPath}/eBid/Bid/CurrentTimeAjax/${tenderId}';
   
  
    $(document ).ready(function() {
        var interval=null;
        var tenderId='${tenderId}';
        if(parseInt(isAuction)===1)
        {
        	$("#divdownloadupload").hide();
            $.ajaxSetup({ cache: false }); 
            interval=setInterval(function() {$("#divCurrentTime").load(url); }, 1000);
            var urlValid='${pageContext.servletContext.contextPath}/eBid/Bid/bidSubmissionValidationForAuction/${tenderId}';
            $.ajaxSetup({ cache: false }); 
            interval1=setInterval(function() 
            {
               
              $("#ValidationMsg").load(urlValid);
                if($('#ValidationMsg').html() != undefined && $('#ValidationMsg').html().trim().length > 0)
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
                           // $('#validationMsgDiv').hide();
                            
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
            }, 2000);
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
		var response = showRemaining(endDate,msgAppended,timeOverMsg);
			if(response  == false){
				clearInterval(timer);
			}
		}, 1000);
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
        GTCalculationOnLoad();
    $(".clstxtcell").blur(function() {
    
         var formula = $(this).closest("tr").find("#hdnFormula").val();
         var rowid = "_" + $(this).attr("rowid");
         var tableId=$(this).attr("tableId");
         calculateFormula(formula,rowid,this,tableId);
    });
      
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
                        $("#lblGT_"+colid1).text(Math.round(eval(eval(sum)*upToDecimal))/upToDecimal);  
                        
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
     $(cmd).closest("tr").find('[id^="result_"]').each(function () {
         
        var ResultStr="";
        var cellID = "";
        var arrIds = "";
        formula = $(this).attr("attrformula");
        arrIds= formula.split(regex);
        cellID =  $(this).parent().attr("colKey");
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
       
        //alert("Value::"+Math.round(eval(eval(ResultStr)*100))/100+"CellId::"+cellID);
        if(parseInt(isAuction)===1)
        {
            var upToDecimal = 1;
            for(var i = 0 ; i < parseInt(decimal) ; i++)
            {
                upToDecimal = upToDecimal * 10 ;
            }
            $("#result"+rowid+"_"+cellID).val(Math.round(eval(eval(ResultStr)*upToDecimal))/upToDecimal);
        }
        else
        {
//         	alert(decimal);
             $("#result"+rowid+"_"+cellID).val(Math.round(eval(eval(ResultStr)*1000000))/1000000);
        }
                        
       
    });
     
 
        $('#trGT_'+tableId).each(function(){
            $(this).find('[id^="lblGT_"]').each(function () {
                      
                var sum=0;
                var colid1 =  $(this).attr("colId");
                $('[id^="txtcell_0_'+$(this).attr("colId")+'"]').each(function () {
                    var intval = 0;
                    if($(this).val().length != 0){
                        intval = parseFloat($(this).val());                
                    } 
                     sum += intval;
                     if(parseInt(isAuction)===1)
                    {
                        var upToDecimal = 1;
                        for(var i = 0 ; i < parseInt(decimal) ; i++)
                        {
                            upToDecimal = upToDecimal * 10 ;
                        }
                        $("#lblGT_"+colid1).text(Math.round(eval(eval(sum)*upToDecimal))/upToDecimal);
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
                            intval = parseFloat($(this).val());                
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
    
    
    
    function validationForConfirmation()
            {
           
               var status=false;
                $.ajax({
                   url:'${pageContext.servletContext.contextPath}/eBid/Bid/validateBiddingTime/${tblTender.tenderId}',
                   async:false,
                   success:function(result){
                       if(result === 'false')
                       {
                        $('#error').show();
                        $('#btnSubmitForm').hide();
                        status=false;
                       }
                       else
                       {
                           $('#error').hide();
                           status=true;
                       }
                       //alert(status);
                   },
                   error:function(result){
                    status=false;
                   }
                });       
                 
               return status;
            }
    function createJson()
    {
        var sta=true;
        
         
       
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
                 else if($(this).find("textarea").length){
                    console.log("Row: " + $(this).attr("trid") + " ,Key: " + $(this).attr("colKey") +  " , val: " + $(this).find("textarea").val()+", Cell Id:"+$(this).attr("cellID"));
                    val="Row: " + $(this).attr("trid") + " ,Key: " + $(this).attr("colKey") +  " , val: " + $(this).find("textarea").val();
                    ColumnJson['row']=$(this).attr("trid");
                    ColumnJson['key']=$(this).attr("colKey");
                    ColumnJson['val']=$(this).find("textarea").val();
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
      // console.log(jstr);
       
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
    return true;
    }
    
  //upload
    function fillFormByExcel() {
    	var fileName=$('input[type=file]').val().split('\\').pop();
    	alert(fileName);
//     	var fbool = fileValidate();
		var flag = true;
	    var excelDataArr = new Array();
        $.ajaxFileUpload({
            url: '${pageContext.servletContext.contextPath}/etender/bidder/uploadform?hdFormId=${formId}&hdTenderId=${tenderId}',
            secureuri: true,
            fileElementId: 'uploadFormData',
            dataType: "text",
            success: function(data) {
                data = data.toString().replace('<pre>', '').replace('</pre>', '');
                if (data.toString().indexOf('ERROR::') == -1) {                                                                
                        excelDataArr = data.split('@@@');
                       	flag =  setJsonData(excelDataArr);
                } else {
                    jAlert(data.toString().replace('ERROR::', ''), "Alert", function(RetVal) {});
                }
            }
        });
    }
    
    function fileValidate(){
      	$(".successMsg").hide();
		$('.err').remove();
  	    $('#fileError').html("");
        var valid = true;
        var count = 0;
        var browserName="";
        jQuery.each(jQuery.browser, function(i, val) {
               browserName+=i;
        });
           
        $(":input[type='file']").each(function(){
        	if(this.value == ''){
            	$('#fileError').parent().append("<div class='err validationMsg' style='color:red; '><span style='display:inline-block;'><spring:message code='msg_tender_filetoupload_empty' /></span></div>");
                count++;
        	}
        });
        if(count > 0){
             valid = false;
        }
        return valid;
	}
    
    function checkFile(obj){
    	if($(obj).val()!=""){
    		$(".err").remove();	
    		$("#fileError").html("");
    		$("#fileToUploadName").val($(obj).val());
    	}
    }
</script>
<script src="${pageContext.servletContext.contextPath}/resources/js/jquery-ui.min.js"></script>
<%@include file="../../includes/footer.jsp"%>
