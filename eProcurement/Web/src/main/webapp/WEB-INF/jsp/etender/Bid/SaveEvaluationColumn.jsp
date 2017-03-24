<%-- 
    Document   : SaveEvaluationColumn
    Created on : Dec 14, 2016, 12:26:23 PM
    Author     : BigGoal
--%>
<!DOCTYPE html>
<html>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.Map"%>
<%@page import="com.eprocurement.etender.model.TblTenderEnvelope"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

    <%
    Map evaluationColumnMap=(Map)request.getAttribute("EvaluationColumnMap");
    JSONObject jsonObject=new JSONObject(evaluationColumnMap);
    String jsonString=jsonObject.toString();
   // pageContext.setAttribute("EvaluationColumn", jsonObject);
    %>  
<%@include file="../../includes/header.jsp"%>
</head>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="../../includes/leftaccordion.jsp"%>

        <div class="content-wrapper">
            <section class="content-header">
                <h1>
                    Create / Edit Evaluation Column Form <small></small>
                </h1>
               
       
            </section>
            <section class="content">
                <form id="DocumentFormBean" name="DocumentFormBean" action="/eProcurement/eBid/Bid/saveEvaluationColumn"  method="get"  onsubmit="return createJSON();">
                    <div class="row">
                    <div class="col-lg-12 col-md-12">
                        <div class="box">
                            <div class="box-header with-border">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="col-md-6 pull-left">
                                           Create Document Form
                                        </div>
                                        <div class="col-md-6 text-right">
                                           <a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}" ><< Go Back To DashBord
                                            </a>
                                         </div>
                                    </div>
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
                                                            <div class="form_filed pull-left">${tblTenderForm.FormName}</div>
                                                        </div>
                                                        <div class="col-sm-2 col-md-2">
                                                            <div class="form_filed text-black text-right">Created On :</div>
                                                        </div>
                                                        <div class="col-sm-2 col-md-2">
                                                            <div class="form_filed pull-left">${tblTenderForm.CreatedOn}</div>
                                                        </div>
                                    </div>
                                                         <c:if test="${tblTenderForm.IsDocReq eq 0}">
                                                                <c:set var="DocReqVal" value="No"/>
                                                            </c:if>
                                                            <c:if test="${tblTenderForm.IsDocReq eq 1}">
                                                                <c:set var="DocReqVal" value="Yes"/>
                                                            </c:if>
                                                            
                                     <div class="col-md-12">
                                                        <div class="col-sm-2 col-md-2">
                                                            <div class="form_filed text-right text-black">Is Document Require :</div>
                                                        </div>
                                                        <div class="col-sm-2 col-md-2">
                                                            <div class="form_filed  pull-left">${DocReqVal}</div>
                                                        </div>
                                                            <c:if test="${tblTenderForm.IsMandatory eq 0}">
                                                                <c:set var="IsMandatory" value="No"/>
                                                            </c:if>
                                                            <c:if test="${tblTenderForm.IsMandatory eq 1}">
                                                                <c:set var="IsMandatory" value="Yes"/>
                                                            </c:if>               
                                         
                                                        <div class="col-sm-2 col-md-2">
                                                            <div class="form_filed  text-right text-black">Is Mandatory :</div>
                                                        </div>
                                                        <div class="col-sm-2 col-md-2">
                                                            
                                                            <div class="form_filed  pull-left">${IsMandatory}</div>
                                                        </div>
                                                         <c:if test="${tblTenderForm.IsPriceBid eq 0}">
                                                                <c:set var="IsPriceBid" value="No"/>
                                                            </c:if>
                                                            <c:if test="${tblTenderForm.IsPriceBid eq 1}">
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

						<div class="box-body">
							<div class="row">

								<div class="col-lg-12 col-md-12 col-xs-12">
									<table class="table table-striped table-responsive">
										<thead>
											<tr>
                                                                                            <th class="text-center">No.</th>
												<th  class="text-center">Table Name</th>
												<th  class="text-center">Evaluation Column</th>
												
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
                                                                                             
                                                                                            
                                                                                                <button type="submit" class="btn btn-submit" id="btnSubmitForm">Submit</button>
                                                                                             <button type="button" class="btn btn-submit">Reset</button>
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
                                    <th>No</th>
                                    <th>Table Name</th>
                                    <th>Evaluation Column</th>
                                    <th>Edit</th>
                                    <th>Delete</th>
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
                                                <td><a href="${pageContext.servletContext.contextPath}/eBid/Bid/EditEvaluationColumn/${tenderId}/${formId}/${element.govColumnId}"><i class="fa fa-pencil tb"></i></a></td>
                                                <td><a href="${pageContext.servletContext.contextPath}/eBid/Bid/deleteEvaluationColumn/${tenderId}/${formId}/${element.govColumnId}/${element.cellId}/${element.columnNo}/${element.ipAddress}" ><i class="fa fa-trash tb"></i></a></td>
                                        </tr>
                                    <c:set var="i" value="${i + 1}" scope="page"/>
                                    </c:forEach>
                                </c:if>
                                <c:if test="${not empty govColumnId}">
                                    <c:set var="i" value="1"/>
                                    <c:forEach items="${GridData}" var="element">
                                        <c:if test="${govColumnId eq element.govColumnId}">
                                            <form action="/eProcurement/eBid/Bid/UpdateEvaluationColumn"  method="get"  onsubmit="">
                                            <tr>
                                                <td>${i}</td>
                                                <td>${element.tblTenderTable.tableName} 
                                                  
                                                </td>
                                                <td><select id="optEvaluationCol" name="optEvaluationCol">
                                                    <c:forEach items="${EvaluationColumnMap}" var="entry" >
                                                            
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
                                                    <button type="submit" class="btn btn-submit" id="btnSubmitForm">Update</button>
                                                    <button type="button" class="btn btn-submit">Reset</button>
                                                </td>
                                            </form> 
                                                <td><a href="${pageContext.servletContext.contextPath}/eBid/Bid/deleteEvaluationColumn/${tenderId}/${formId}/${element.govColumnId}/${element.cellId}/${element.columnNo}/${element.ipAddress}" >Delete</a></td>
                                            </tr>
                                        </c:if>
                                        <c:if test="${govColumnId != element.govColumnId}">
                                        <tr>
                                            <td>${i}</td>
                                                <td>${element.tblTenderTable.tableName}</td>
                                                <td>${element.tblTenderColumn.columnHeader}</td>
                                                <td><a href="${pageContext.servletContext.contextPath}/eBid/Bid/EditEvaluationColumn/${tenderId}/${formId}/${element.govColumnId}" >Edit</a></td>
                                                <td><a href="${pageContext.servletContext.contextPath}/eBid/Bid/deleteEvaluationColumn/${tenderId}/${formId}/${element.govColumnId}/${element.cellId}/${element.columnNo}/${element.ipAddress}" >Delete</a></td>
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

</div>

</body>

</html>
