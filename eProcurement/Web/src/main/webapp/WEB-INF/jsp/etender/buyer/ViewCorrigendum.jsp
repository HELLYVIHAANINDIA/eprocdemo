<jsp:useBean id="now" class="java.util.Date" />
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
	
<c:if test="${pageFrom ne 1}">
<%@include file="../../includes/head.jsp"%>
<%@include file="../../includes/masterheader.jsp"%>
</c:if>
  
 
   <spring:message code="title_tender_th_viewcorrigendum" var="title_tender_th_viewcorrigendum"/>
   <spring:message code="title_tender_th_viewcorrigendum_no" var="title_tender_th_viewcorrigendum_no"/>
   <spring:message code="lbl_create_corrigendum_text" var="create_corrigendum_text"/>
   <spring:message code="th_tender_fieldname" var="thtenderfieldname"/>
   <spring:message code="th_tender_oldvalue" var="thtenderoldvalue"/>
   <spring:message code="th_tender_newvalue" var="thtendernewvalue"/>
   <spring:message code="th_tender_currency" var="th_tender_currency"/>
   <spring:message code="fields_tender_docname" var="fields_tender_docname"/>
   <spring:message code="fields_docbrief" var="fields_doc_brief"/>
   <spring:message code="lbl_doc_size" var="lbl_doc_size"/>
   <spring:message code="col_tender_date" var="col_tender_date"/>
   <spring:message code="lbl_status" var="lbl_status"/>
   <spring:message code="th_tender_action" var="th_tender_action"/>
   <spring:message code="lbl_tender_document" var="lbl_tender_document"/>
   <spring:message code="title_tenderform" var="title_tenderform"/>
   <spring:message code="title_envelopeform" var="title_envelopeform"/>
   <spring:message code="btn_submit" var="submitBtn" />
   <spring:message code="title_tendercorrigendum" var="titleCorrigendum"/>
   <spring:message code="lbl_view_doc" var="lbl_view_doc"/>
   <c:forEach items="${corrigendumList}" var="items">
	<c:if test="${items.cstatus eq '0'}">
		<c:set value="${items.corrigendumId}" var="corrigendumId"/>
	</c:if>
</c:forEach>

<div class="content-wrapper">

<c:if test="${pageFrom ne 1}">
<section class="content-header">
<h1>Corrigendum Detail</h1>   
<a class="pull-right" href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}"><< Go To Tender Dashboard</a>                                
</section>
</c:if>

<c:set var="clsForSec" value="content"/>
<c:if test="${pageFrom eq 1}">
<c:set var="clsForSec" value=""/>
</c:if>

<section class="${clsForSec}">						
   						
	                            <div id="pdfReportDiv">
	                            <spring:message code="lbl_view_doc" var="lbl_view_doc"/>   
	                            
                                <table class="tableView m-bottom" width="100%" cellspacing="0" cellpadding="0" border="0">
                                <c:set var="counter" value="${fn:length(resultList)}"/>
                                <c:choose>
                                    <c:when test="${fn:length(resultList) gt 0}">
                                        <c:forEach items="${resultList}" var="cList">
                                            <c:choose>
                                                <c:when test="${cList.cstatus eq 1}">
                                                
                                                    <div class="row">                                                     
                                                          <div class="col-sm-12">  
                                                          	<h5 class="box-title">${title_tender_th_viewcorrigendum_no} ${counter} : Published view</h5>
                                                          </div>                                                        
                                                    </div>
                                                    
                                                    <div class="row">
                                                    <div class="col-sm-3 col-xs-12"><spring:message code="lbl_create_corrigendum_text"/> : </div>
                                                    <div class="col-sm-3 col-xs-12">${cList.ctext}</div>
                                                    </div>
                                                    
                                                    <c:if test="${not empty cList.id}">
                                                    <div class="row">
                                                        <div class="col-sm-3 col-xs-12"><spring:message code="corrigendum_view_doc"/> : </div>
                                                        <div class="col-sm-3 col-xs-12">
                                                        	<a href="${pageContext.servletContext.contextPath}/etender/buyer/getDocumentList/${tenderId}/${tenderNITObjectId}/${tenderId}/${cList.id}/0" data-target="#myModal" class="myModel" data-toggle="modal">${lbl_view_doc}</a>
                                                        </div>
                                                        
                                                    </div>
                                                    </c:if>
                                                    
                                                    <c:if test="${fn:length(cList.details) gt 0}">
                                                        <div class="row">
                                                            <div class="col-sm-3 col-xs-12"><strong>${thtenderfieldname}</strong></div>
                                                            <div class="col-sm-3 col-xs-12"><strong>${thtenderoldvalue}</strong></div>
                                                            <div class="col-sm-3 col-xs-12"><strong>${thtendernewvalue}</strong></div>
                                                        </div>
                                                    </c:if>
                                                    
                                                    <c:forEach items="${cList.details}" var="cDetailList">
                                                        <div class="row">
                                                            <div class="col-sm-3 col-xs-12">
                                                                 <spring:message code="${cDetailList.fieldName}"/>
                                                            </div>
                                                            <div class="col-sm-3 col-xs-12">                                                            	
                                                                	${cDetailList.oldValue}                                                             
                                                            </div>
                                                            <div class="col-sm-3 col-xs-12">                                                           	
                                                                	${cDetailList.newValue}                                                                
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                    
                                                    <c:if test="${fn:length(cList.currencies) gt 0}">
                                                        <div class="row">
                                                            <div class="col-sm-3 col-xs-12">${th_tender_currency}</div>
                                                            <div class="col-sm-3 col-xs-12">${th_tender_action}</div>
                                                        </div>
                                                    </c:if>
                                                    
                                                    <c:forEach items="${cList.currencies}" var="currList">
                                                        <div class="row">
                                                            <div class="col-sm-3 col-xs-12">
                                                                ${currList.currencyName}
                                                            </div>      
                                                            <div class="col-sm-3 col-xs-12">
                                                                <c:choose>
                                                                    <c:when test="${currList.action eq 'New'}">
                                                                        <span style="color: green"> ${currList.action}</span>
                                                                    </c:when>                                                                           
                                                                    <c:otherwise>
                                                                         <span style="color: red"> ${currList.action}</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                    
                                                    <c:if test="${fn:length(cList.forms) gt 0}">
                                                        <div class="row">
                                                            <div class="col-sm-3 col-xs-12">${title_tenderform}</div>
                                                            <div class="col-sm-3 col-xs-12">${th_tender_action}</div>
                                                        </div>
                                                    </c:if>
                                                    
                                                    <c:forEach items="${cList.forms}" var="frmList">
                                                        <div class="row">
                                                            <div class="col-sm-3 col-xs-12">
                                                                ${frmList.formName}
                                                            </div>      
                                                            <div class="col-sm-3 col-xs-12">
                                                                <c:choose>
                                                                    <c:when test="${frmList.action eq 'New'}">
                                                                        <span style="color: green">${frmList.action}</span>
                                                                    </c:when>                                                                          
                                                                    <c:otherwise>
                                                                        <span style="color: red"> ${frmList.action}</span>
                                                                    </c:otherwise>
                                                                </c:choose>       
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                    
                                                    <c:if test="${fn:length(cList.envelopes) gt 0}">
                                                        <div class="row">
                                                            <div class="col-sm-3 col-xs-12">${title_envelopeform}</div>
                                                            <div class="col-sm-3 col-xs-12">${th_tender_action}</div>
                                                        </div>
                                                    </c:if>
                                                    
                                                    <c:forEach items="${cList.envelopes}" var="envList">
                                                        <div class="row">
                                                            <div class="col-sm-3 col-xs-12">
                                                                ${envList.envelopeName}
                                                            </div>      
                                                            <div class="col-sm-3 col-xs-12">
                                                                <c:choose>
                                                                    <c:when test="${envList.action eq 'New'}">
                                                                        <span style="color: green">${envList.action}</span>
                                                                    </c:when>                                                                          
                                                                    <c:otherwise>
                                                                        <span style="color: red"> ${envList.action}</span>
                                                                    </c:otherwise>
                                                                </c:choose>       
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                    
                                                    <c:if test="${fn:length(cList.documents) gt 0}">
                                                    
                                                        <div class="row">
                                                            <div class="col-sm-3 col-xs-12">${lbl_tender_document}</div>  
                                                        </div>
                                                        
                                                        <div class="row">
                                                            <div class="col-xs-12">                                                                         
                                                                <table width="100%" width="100%" cellpadding="0" cellspacing="0" border="0" class="formField1 m-top border-right">
                                                                    <tr>
                                                                        <th width="25%">${fields_tender_docname}</th>                                                                                        
                                                                        <th width="15%">${fields_doc_brief}</th>
                                                                        <th width="15%">${lbl_doc_size}</th>
                                                                        <th width="15%">${col_tender_date}</th>
                                                                        <th width="15%">${lbl_status}</th>  
                                                                        <th width="15%">${th_tender_action}</th>
                                                                    </tr>
                                                                    <c:forEach items="${cList.documents}" var="doc">
                                                                        <tr>
                                                                            <td width="25%">${doc.docName}</td>
                                                                            <td width="15%">${doc.description}</td>
                                                                            <td width="15%">${doc.fileSize}</td>
                                                                            <td width="15%">${doc.mappedOn}</td>
                                                                            <td width="15%">${doc.cstatus}</td>
                                                                            <td><a href="${doc.downloadUrl}"><spring:message code="lbl_download"/></a></td>
                                                                        </tr>
                                                                </c:forEach>
                                                             </table>
                                                            </div>
                                                        </div>
                                                    </c:if>
                                                </c:when>
                                            <c:otherwise>
                                            <c:if test="${pageFrom ne 1 && sessionObject.userTypeId ne 2 && userType ne 0}"><!-- without login  -->
                                                <div class="row">
                                                     <div class="col-sm-3 col-xs-12"><h2>${title_tender_th_viewcorrigendum_no} ${counter} (Not yet published)</h2>                                                           
                                                     </div>
                                                 </div>

                                                 <div class="row">
                                                     <div class="col-sm-3 col-xs-12"><spring:message code="lbl_create_corrigendum_text"/> :  </div>
                                                     <div class="col-sm-3 col-xs-12">
                                                     	<div class="o-auto fancybox-lock-test display table-border border-for-table pull-left" style="width:650px;">
                                                     		${cList.ctext}
                                                     	</div>
                                                     </div>
                                                 </div>
                                                 
                                                 <c:if test="${fn:length(cList.details) gt 0 && not empty thtenderfieldname}">
                                                     <div class="row">
                                                         <div class="col-sm-3 col-xs-12">${thtenderfieldname}</div>
                                                         <div class="col-sm-3 col-xs-12">${thtenderoldvalue}</div>
                                                         <div class="col-sm-3 col-xs-12">${thtendernewvalue}</div>
                                                     </div>
                                                 </c:if>
                                                 
                                                 <c:forEach items="${cList.details}" var="cDetailList">
                                                     <div class="row">
                                                         <div class="col-sm-3 col-xs-12">
                                                             <spring:message code="${cDetailList.fieldName}"/> 
                                                         </div>
                                                         <div class="col-sm-3 col-xs-12">
	                                                         <div class="o-auto fancybox-lock-test display table-border border-for-table pull-left" style="width:315px;">
	                                                             	${cDetailList.oldValue}
	                                                         </div>
                                                         </div>
                                                         <div class="col-sm-3 col-xs-12">
	                                                         <div class="o-auto fancybox-lock-test  display table-border border-for-table pull-left" style="width:315px;">
	                                                             ${cDetailList.newValue}
	                                                         </div>
                                                         </div>
                                                     </div>
                                                 </c:forEach>
                                                 
                                                 <c:if test="${fn:length(cList.currencies) gt 0}">
                                                     <div class="row">
                                                         <div class="col-sm-3 col-xs-12">${th_tender_currency}</div>
                                                         <div class="col-sm-3 col-xs-12">${th_tender_action}</div>
                                                     </div>
                                                 </c:if>
                                                 
                                                 <c:forEach items="${cList.currencies}" var="currList">
                                                     <div class="row">
                                                         <div class="col-sm-3 col-xs-12">
                                                             ${currList.currencyName}
                                                         </div>      
                                                         <div class="col-sm-3 col-xs-12">
                                                             <c:choose>
                                                                 <c:when test="${currList.action eq 'New'}">
                                                                     <span style="color: green">${currList.action}</span>
                                                                 </c:when>                                                                                  
                                                                 <c:otherwise>
                                                                     <span style="color: red"> ${currList.action}</span>
                                                                 </c:otherwise>
                                                             </c:choose>
                                                         </div>
                                                     </div>
                                                 </c:forEach>
                                                 
                                                 <c:if test="${fn:length(cList.forms) gt 0}">
                                                     <div class="row">
                                                         <div class="col-sm-3 col-xs-12">Tender Form</div>
                                                         <div class="col-sm-3 col-xs-12">${th_tender_action}</div>
                                                     </div>
                                                 </c:if>
                                                 
                                                 <c:forEach items="${cList.forms}" var="frmList">
                                                     <div class="row">
                                                         <div class="col-sm-3 col-xs-12">
                                                             ${frmList.formName}
                                                         </div>      
                                                         <div class="col-sm-3 col-xs-12">                                                                           
                                                             <c:choose>  
                                                                 <c:when test="${frmList.action eq 'New'}">
                                                                     <span style="color: green">${frmList.action}</span>
                                                                 </c:when>                                                                           
                                                                 <c:otherwise>
                                                                     <span style="color: red"> ${frmList.action}</span>
                                                                 </c:otherwise>
                                                             </c:choose>       
                                                         </div>
                                                     </div>
                                                 </c:forEach>
                                                 
                                                 <c:if test="${fn:length(cList.envelopes) gt 0}">
                                                     <div class="row">
                                                         <div class="col-sm-3 col-xs-12">${title_envelopeform}</div>
                                                         <div class="col-sm-3 col-xs-12">${th_tender_action}</div>
                                                     </div>
                                                 </c:if>
                                                 
                                                 <c:forEach items="${cList.envelopes}" var="envList">
                                                     <div class="row">
                                                         <div class="col-sm-3 col-xs-12">
                                                             ${envList.envelopeName}
                                                         </div>      
                                                         <div class="col-sm-3 col-xs-12">
                                                             <c:choose>
                                                                 <c:when test="${envList.action eq 'New'}">
                                                                     <span style="color: green">${envList.action}</span>
                                                                 </c:when>                                                                          
                                                                 <c:otherwise>
                                                                     <span style="color: red"> ${envList.action}</span>
                                                                 </c:otherwise>
                                                             </c:choose>       
                                                         </div>
                                                     </div>
                                                 </c:forEach>
                                                 
                                                 <c:if test="${fn:length(cList.documents) gt 0}">
                                                     <div class="row">
                                                         <div class="col-sm-3 col-xs-12">${lbl_tender_document}</div>  
                                                     </div>
                                                     
                                                     <div class="row">
                                                         <div class="col-xs-12">                                                                         
                                                             <table width="100%" width="100%" cellpadding="0" cellspacing="0" border="0" class="formField1 m-top">
                                                                 <tr class="gradi">
                                                                     <td width="25%">${fields_tender_docname}</td>                                                                                        
                                                                     <td width="15%">${fields_doc_brief}</td>
                                                                     <td width="15%">${lbl_doc_size}</td>
                                                                     <td width="15%">${col_tender_date}</td>
                                                                     <td width="15%">${lbl_status}</td>  
                                                                     <td width="15%">${th_tender_action}</td>
                                                                 </tr>
                                                                 <c:forEach items="${cList.documents}" var="doc">
                                                                     <tr>
                                                                         <td width="25%">${doc.docName}</td>
                                                                         <td width="15%">${doc.description}</td>
                                                                         <td width="15%">${doc.fileSize}</td>
                                                                         <td width="15%">${doc.mappedOn}</td>
                                                                         <td width="15%">${doc.cstatus}</td>
                                                                         <td><a href="${doc.downloadUrl}"><spring:message code="lbl_download"/></a></td>
                                                                     </tr>
                                                                 </c:forEach>
                                                             </table>
                                                         </div>
                                                     </div>

                                                 </c:if>                   
                                             </c:if>
                                            </c:otherwise>
                                         </c:choose>
                                         <c:set var="counter" value="${counter-1}"/>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="row">
                                            <div class="col-sm-3 col-xs-12">
                                                <spring:message code='msg_tender_no_corrigendum_found' />
                                            </div>
                                        </div>
                                    </c:otherwise>
                                </c:choose>                                        
                            </table>
                            
                        </div>
                  		
   </section>
    <div id="targetDiv"></div>
  </div>  
   

<script type="text/javascript">
$(document).ready(function(){

	 $('a.myModel').click(function(){   //bind handlers
		   var url = $(this).attr('href');
		   showDialog(url);
		   return false;
		});

		$("#targetDiv").dialog({  //create dialog, but keep it closed
		   autoOpen: false,
		   height: 300,
		   width: 700,
		   modal: true
		});

		function showDialog(url){  //load content and open dialog
		    $("#targetDiv").load(url);
		    $("#targetDiv").dialog("open");         
		}
});
</script>

   <c:if test="${pageFrom ne 1}">
		<%@include file="../../includes/footer.jsp"%>
	</c:if>