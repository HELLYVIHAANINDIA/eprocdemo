<%-- 
    Document   : BiddingFormDocument
    Created on : Dec 13, 2016, 3:22:07 PM
    Author     : BigGoal
--%>
<!DOCTYPE html>
<html>
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
<h1>Form Library <small></small></h1>
</section>

<section class="content">
               
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
                                           <a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}" class="btn btn-submit" style="margin-top:0px;"><< Go Back To DashBord
                                            </a>
                                         </div>
                                    </div>
                                  
                                                          
                                                        
                                                   </div>
                              
                                                    
                                                   
						</div>
                                            
						<div class="box-body">
							<div class="row">
                                                            <form action="/eProcurement/eBid/Bid/getFormLibrary/${tenderId}">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Form Type </div>
                                                            </div>
                                                            <div class="col-lg-4">
                                                               
                                                                <select name="FormType" class="form-control">
                                                                    <option value="-1">Select Form Type</option>
                                                                    <c:forEach items="${envelopeList}" var="element">
                                                                        <c:choose>
                                                                            <c:when test="${element.envId eq formType}">
                                                                                <option value="${element.envId}" selected="true">${element.lang1}</option>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                 <option value="${element.envId}">${element.lang1}</option>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                       
                                                                    </c:forEach>
                                                                </select>
                                                                       
                                                            </div>
                                                            
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Event Id </div>
                                                            </div>
                                                            <div class="col-lg-4">
                                                                <input type="text" id="eventId" name="eventId" class="form-control" placeholder="Select Form Name" value="${eventId}">
                                                                       
                                                            </div>
                                                            
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Form ID</div>
                                                            </div>
                                                            <div class="col-lg-4">
                                                                <input type="text" id="formId" name="formId" class="form-control" placeholder="Select Form Name" value="${formId}">
                                                                       
                                                            </div>
                                                            
                                                            
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Reference No </div>
                                                            </div>
                                                            <div class="col-lg-4">
                                                                <input type="text" id="refNo" name="refNo" class="form-control" placeholder="Select Form Name" value="${refNo}">
                                                                       
                                                            </div>
                                                            
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Form Name </div>
                                                            </div>
                                                            <div class="col-lg-4">
                                                                <input type="text" id="formName" name="formName" class="form-control" placeholder="Select Form Name" value="${formName}">
                                                                       
                                                            </div>
                                                            
                                                             
                                                            <div class="col-lg-2">
                                                                <div class="form_filed">Department </div>
                                                            </div>
                                                            <div class="col-lg-4">
                                                                <select name="dept" class="form-control">
                                                                    <option value="-1">Select Department</option>
                                                                    <c:forEach items="${deptList}" var="element">
                                                                        
                                                                        <c:choose>
                                                                            <c:when test="${element.deptId eq dept}">
                                                                                <option value="${element.deptId}" selected="true">${element.deptName}</option>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                  <option value="${element.deptId}">${element.deptName}</option>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                       
                                                                    </c:forEach>
                                                                </select>
                                                                       
                                                            </div>
                                                            
                                                             <div class="col-md-12 text-center" style="padding: 20px;">
                                                                 <button type="submit" class="btn btn-info" id="btnCopyForm" name="btn" value="search" ><i class="fa fa-add"></i>&nbsp;Search</button>
                                                                 <button type="submit" class="btn btn-info" id="btnCopyForm" name="btn" value="clear"><i class="fa fa-add"></i>&nbsp;Clear Search</button>
                                                             </div>
                                                             
							
                                                              </form>
                                                             <form  action="/eProcurement/eBid/Bid/copyForm"  method="get"  onsubmit=" return getSelectedCheckBox();">

                                                            
                                                            <div class="col-md-12 text-right" style="padding: 20px;"><button type="submit" class="btn btn-info" id="btnCopyForm" ><i class="fa fa-add"></i>&nbsp;Copy Form To tender</button></div>
								<div class="col-lg-12 col-md-12 col-xs-12">
                                                                  
                                                                     <c:if test="${isAuction eq 0}">
                                                                    <div class="col-lg-2">
                                                                        <div class="form_filed">Tender Envelope </div>
                                                                    </div>
                                                                    
                                                                    <div class="col-lg-4">
                                                                       
                                                                        <select name="TenderEnv" id= "TenderEnv" class="form-control">
                                                                            <option value="-1">Select Tender Envelope</option>
                                                                            <c:forEach items="${formEnvelope}" var="element">

                                                                             
                                                                                    
                                                                                        <option value="${element.envelopeId}">${element.envelopeName}</option>
                                                 
                                                                            </c:forEach>
                                                                        </select>
                                                                        
                                                                    </div>    
                                                                    </c:if>
                                                                    
                                                                    <div class="clearfix"></div>
                                                                    
                                                                    <table id="tbl_form" class="table table-bordered table-striped" style="margin-top:20px; float:left;">
                                                                        <thead>
                                                                            <tr>


                                                                                <th>Form Id</th>
                                                                                <th>Form</th>
                                                                                <th>Event Id</th>
                                                                                <th>Reference No </th>
                                                                                <th>Department</th>
                                                                                <th>View</th>
                                                                                <th>Select</th>

                                                                            </tr>
                                                                        </thead>
                                                                        <tbody>
                                                                            <c:forEach items="${formList}" var="element">
                                                                                <tr>
                                                                                    <td>${element.getFormId()}</td>    
                                                                                    <td>${element.getFormName()}</td>
                                                                                    <td>${element.getTblTender().getTenderId()}</td>
                                                                                    <td>${element.getTblTender().getTenderNo()}</td>
                                                                                    <td>${element.getTblTender().getDocumentFee()}</td>
                                                                                    <td><a href="${pageContext.servletContext.contextPath}/eBid/Bid/viewForm/${element.getTblTender().getTenderId()}/${element.getFormId()}/0/false">View</a></td>
                                                                                    <td>
                                                                                        <c:if test="${isAuction eq 0}">
                                                                                            <input type="checkbox" formId="${element.getFormId()}" formName="${element.getFormName()}" id="${element.getFormId()}" onchange ="checkEnvValidation(this);">
                                                                                        </c:if>  
                                                                                        <c:if test="${isAuction eq 1}">
                                                                                            <input type="radio" formId="${element.getFormId()}" formName="${element.getFormName()}" id="${element.getFormId()}" onchange ="checkEnvValidation(this);">
                                                                                        </c:if>          
                                                                                    </td>

                                                                                </tr>

                                                                            </c:forEach>





                                                                        </tbody>

                                                                    </table>
                                                                    <input type="text" id="hdnFormId" name="hdnFormId">
                                                                       <input type="hidden" name="hdnTenderId" value="${tenderId}">
									
								</div>

							</div>
						</div>

					</div>

				</div>
                            </div>
                        
                                         
                </form>
                
            </section>
        </div>
                                                                       
         <script src="${pageContext.servletContext.contextPath}/resources/PageJS/FormLibrary.js" type="text/javascript"></script>  
         
         <script>
              function checkEnvValidation(formId)
             {
                 
            if(${isAuction}==1)
                return;
            if($(formId).prop('checked') == true){
   

                    if($('#TenderEnv').val()==-1){
            alert("Please select Tender envelope.");
             $(formId).attr('checked', false);
            return ;
                    }
                    var flag = true;
                 //  alert("formId.val(): "+$(formId).attr('formId'));
                    $.ajax({
                            url:"${pageContext.servletContext.contextPath}/eBid/Bid/checkForEnv/"+$(formId).attr('formId')+"/"+$('#TenderEnv').val(),
                          //  alert("url= "+url);
                            async:false,
                            success: function(result){
                                    //alert("result= "+result);
                             if(result!=1)
                             {
                                 alert("Form envelope and selected envelope is different,You can not select this form for copy ");
                                 $(formId).attr('checked', false);
                                 
                            }
                            else{
                                alert($(formId).attr('formName')+" is selected for copy");
                            }
                             
                    }
                    });
                   // return flag;
            }
            }

             
         </script>
<%@include file="../../includes/footer.jsp"%>
</div>

</body>

</html>
