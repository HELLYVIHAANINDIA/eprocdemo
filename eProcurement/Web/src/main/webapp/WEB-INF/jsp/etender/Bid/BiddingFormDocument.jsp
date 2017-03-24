<!DOCTYPE html>
<html>
<%-- 
    Document   : BiddingFormDocument
    Created on : Dec 13, 2016, 3:22:07 PM
    Author     : BigGoal
--%>


<%@page import="java.util.List"%>
<%@page import="com.eprocurement.etender.model.TblTenderDocument"%>
<%@page import="java.util.Map"%>
<%@page import="com.eprocurement.etender.model.TblTenderEnvelope"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../../includes/header.jsp"%>
</head>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="../../includes/leftaccordion.jsp"%>

        <div class="content-wrapper">
            <section class="content-header">
                <h1>
                    Create / Edit Document Form <small></small>
                </h1>
            </section>
            <section class="content">
                <c:if test="${not empty successMsg}">
                    <div class="alert alert-success">${successMsg}</div>
                </c:if>
                <c:if test="${not empty errorMsg}">
                    <div class="alert alert-danger">${errorMsg}</div>
                </c:if>
                <form id="DocumentFormBean" name="DocumentFormBean" action="/eProcurement/eBid/Bid/saveFormDocument"  method="get"  onsubmit="if(valOnSubmit()){return createJSON();} else {return false ;}" novalidate>

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
                                           <a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}" >Go Back To DashBord
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
                                                            <div class="form_filed pull-left">${FormBean.FormName}</div>
                                                        </div>
                                                        <div class="col-sm-2 col-md-2">
                                                            <div class="form_filed text-black text-right">Created On :</div>
                                                        </div>
                                                        <div class="col-sm-2 col-md-2">
                                                            <div class="form_filed pull-left">${FormBean.CreatedOn}</div>
                                                        </div>
                                    </div>
                                                            <c:if test="${FormBean.IsDocReq eq 2}">
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
                                                            <div class="form_filed  pull-left">${DocReqval}</div>
                                                        </div>
                                                        <c:if test="${FormBean.IsMandatory eq 2}">
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
                                                        <c:if test="${FormBean.IsPriceBid eq 2}">
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

						<div class="box-body">
							<div class="row">
                                                            <div class="col-md-12 text-right" style="padding: 20px;"><button type="button" class="btn btn-info" id="btnAddNewDocument"><i class="fa fa-add"></i>&nbsp;Add New</button></div>
								<div class="col-lg-12 col-md-12 col-xs-12">
                                                                    
                                                                     
									<table class="table table-striped table-responsive">
										<thead>
											<tr>
                                                                                            <th class="text-center">No.</th>
												<th  class="text-center">Document Name</th>
												<th  class="text-center">Is Mandatory</th>
												<th  class="text-center">Action</th>
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
                                                                                            
                                                                                              <button type="submit" class="btn btn-submit" id="btnSubmitForm">Submit</button>
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
                                    <th>Document Name</th>
                                    <th>is Mandatory</th>
                                    <th>Edit</th>
                                    <th>Delete</th>
                                    
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
                                     <td><a href="${pageContext.servletContext.contextPath}/eBid/Bid/EditDocumentForm/${tenderId}/${formId}/${element.documentId}">Edit</a></td>
                                    <td><a href="${pageContext.servletContext.contextPath}/eBid/Bid/deleteFormDocument/${tenderId}/${formId}/${element.documentId}">Delete</a></td>
                                   
                                     </tr>
                                    <c:set var="i" value="${i + 1}" scope="page"/>
                                    </c:forEach>
                                </c:if>
                                <c:if test="${documentId != 0}">
                                    <c:set var="i" value="1"/>
                                 <c:forEach items="${DocumentGrid}" var="element">
                                     <c:if test="${documentId eq element.documentId}">
                                         <form action="/eProcurement/eBid/Bid/UpdateDocumentform"  method="get"  onsubmit="">
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
                                             <button type="submit" class="btn btn-submit" id="btnSubmitForm">Update</button>
                                             <button type="button" class="btn btn-submit">Reset</button>
                                         </td>
                                         <td><a href="${pageContext.servletContext.contextPath}/eBid/Bid/deleteFormDocument/${tenderId}/${formId}/${element.documentId}">Delete</a></td>
                                   
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
                                     <td><a href="${pageContext.servletContext.contextPath}/eBid/Bid/EditDocumentForm/${tenderId}/${formId}/${element.documentId}">Edit</a></td>
                                    <td><a href="${pageContext.servletContext.contextPath}/eBid/Bid/deleteFormDocument/${tenderId}/${formId}/${element.documentId}">Delete</a></td>
                                   
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
</div>
</body>
</html>
