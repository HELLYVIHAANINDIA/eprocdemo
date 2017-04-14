<!DOCTYPE html>
<html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<c:if test="${param.pageFrom ne 'viewTender'}">
	<%@include file="../../includes/header.jsp"%>
</c:if>
  <style>
  .black{
  	color: black;
  	font-style: oblique;
  }
  </style>
  <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/resources/css/jquery-ui.min.css">
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
</head>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="../../includes/leftaccordion.jsp"%>

 <div class="content-wrapper">

		<section class="content-header">		
				<c:if test="${param.pageFrom ne 'viewTender'}">
					<a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}" class="btn btn-submit"><<
						Go To Tender Dashboard</a>
				</c:if>
				
					<h1>Corrigendum Detail</h1>		
		</section>
		
		
				<div class="col-md-12">
					<div class="box">
						<div class="box-header with-border">
							<h3 class="box-title">${title_tender_th_viewcorrigendum_no} ${counter} (Published)</h3>
						</div>
						<div class="box-body">
							<div class="row">
								<div class="col-md-12">
									<div class="borderRadius t_space o-x panel-container table-border"  id="pdfReportDiv">   
                                <table class="tableView m-bottom" width="100%" cellspacing="0" cellpadding="0" border="0">
                                <c:set var="counter" value="${fn:length(resultList)}"/>
                                <c:choose>
                                    <c:when test="${fn:length(resultList) gt 0}">
                                        <c:forEach items="${resultList}" var="cList">
                                            <c:choose>
                                                <c:when test="${cList.cstatus eq 1}">
                                                    
<!--                                                     <tr  class="gradi" style="height: 40px;"> -->
<%--                                                         <td  width="28%" class="f-bold">${title_tender_th_viewcorrigendum} : </td> --%>
<%--                                                         <td colspan="6">${cList.id} </td> --%>

<!--                                                     </tr> -->
                                                    <tr>
                                                        <td  width="28%"  class="f-bold v-a-top" <spring:message code="lbl_create_corrigendum_text"/> : </td>
                                                        <td colspan="6">
                                                        	<div class="o-auto fancybox-lock-test display table-border border-for-table pull-left" style="width:650px;">
                                                        		${cList.ctext}
                                                        	</div>
                                                        </td>
                                                    </tr>
                                                    <c:if test="${fn:length(cList.details) gt 0}">
                                                        <tr class="gradi black">
                                                            <td>${thtenderfieldname}</td>
                                                            <td>${thtenderoldvalue}</td>
                                                            <td>${thtendernewvalue}</td>
                                                        </tr>
                                                    </c:if>
                                                    <c:forEach items="${cList.details}" var="cDetailList">
                                                        <tr>
                                                            <td>
                                                                 <spring:message code="${cDetailList.fieldName}"/>
                                                            </td>
                                                            <td>
                                                            	<div class="o-auto fancybox-lock-test display table-border border-for-table pull-left" style="width:315px;">
                                                                	${cDetailList.oldValue}
                                                                </div>
                                                            </td>
                                                            <td>
                                                            	<div class="o-auto fancybox-lock-test display table-border border-for-table pull-left" style="width:315px;">
                                                                	${cDetailList.newValue}
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                    <c:if test="${fn:length(cList.currencies) gt 0}">
                                                        <tr class="gradi">
                                                            <td colspan="2">${th_tender_currency}</td>
                                                            <td>${th_tender_action}</td>
                                                        </tr>
                                                    </c:if>
                                                    <c:forEach items="${cList.currencies}" var="currList">
                                                        <tr>
                                                            <td colspan="2">
                                                                ${currList.currencyName}
                                                            </td>      
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${currList.action eq 'New'}">
                                                                        <span style="color: green"> ${currList.action}</span>
                                                                    </c:when>                                                                           
                                                                    <c:otherwise>
                                                                         <span style="color: red"> ${currList.action}</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                    <c:if test="${fn:length(cList.forms) gt 0}">
                                                        <tr class="gradi">
                                                            <td colspan="2">${title_tenderform}</td>
                                                            <td>${th_tender_action}</td>
                                                        </tr>
                                                    </c:if>
                                                    <c:forEach items="${cList.forms}" var="frmList">
                                                        <tr>
                                                            <td colspan="2">
                                                                ${frmList.formName}
                                                            </td>      
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${frmList.action eq 'New'}">
                                                                        <span style="color: green">${frmList.action}</span>
                                                                    </c:when>                                                                          
                                                                    <c:otherwise>
                                                                        <span style="color: red"> ${frmList.action}</span>
                                                                    </c:otherwise>
                                                                </c:choose>       
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                    <c:if test="${fn:length(cList.envelopes) gt 0}">
                                                        <tr class="gradi">
                                                            <td colspan="2">${title_envelopeform}</td>
                                                            <td>${th_tender_action}</td>
                                                        </tr>
                                                    </c:if>
                                                    <c:forEach items="${cList.envelopes}" var="envList">
                                                        <tr>
                                                            <td colspan="2">
                                                                ${envList.envelopeName}
                                                            </td>      
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${envList.action eq 'New'}">
                                                                        <span style="color: green">${envList.action}</span>
                                                                    </c:when>                                                                          
                                                                    <c:otherwise>
                                                                        <span style="color: red"> ${envList.action}</span>
                                                                    </c:otherwise>
                                                                </c:choose>       
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                    <c:if test="${fn:length(cList.documents) gt 0}">
                                                        <tr  class="no-border">
                                                            <th colspan="6">${lbl_tender_document}</th>  
                                                        </tr>
                                                        <tr  class="no-border">
                                                            <td colspan="6">                                                                         
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
                                                            </td>
                                                        </tr>
                                                    </c:if>
                                                </c:when>
                                            <c:otherwise>
                                            <c:if test="${param.pageFrom ne 'viewTender' && sessionObject.userTypeId ne 2 && userType ne 0}"><!-- without login  -->
                                                <tr class="gradi" style="height: 40px;font-weight: bold" >
                                                     <td colspan="3"><h2>${title_tender_th_viewcorrigendum_no} ${counter} (Not yet published)</h2>                                                           
                                                     </td>
                                                 </tr>
<!--                                                  <tr> -->
<%--                                                      <td  width="28%"  class="f-bold"> ${title_tender_th_viewcorrigendum} :  </td> --%>
<%--                                                      <td colspan="2">${cList.id} </td> --%>

<!--                                                  </tr> -->
                                                 <tr>
                                                     <td  width="28%" class="f-bold v-a-top"><spring:message code="lbl_create_corrigendum_text"/> :  </td>
                                                     <td colspan="2" class="no-padding">
                                                     	<div class="o-auto fancybox-lock-test display table-border border-for-table pull-left" style="width:650px;">
                                                     		${cList.ctext}
                                                     	</div>
                                                     </td>
                                                 </tr>
                                                 <c:if test="${fn:length(cList.details) gt 0 && not empty thtenderfieldname}">
                                                     <tr class="gradi black">
                                                         <td width="28%">${thtenderfieldname}</td>
                                                         <td>${thtenderoldvalue}</td>
                                                         <td>${thtendernewvalue}</td>
                                                     </tr>
                                                 </c:if>
                                                 <c:forEach items="${cList.details}" var="cDetailList">
                                                     <tr>
                                                         <td  width="28%" class="v-a-top border-top-none">
                                                             <spring:message code="${cDetailList.fieldName}"/> 
                                                         </td>
                                                         <td class="v-a-top">
	                                                         <div class="o-auto fancybox-lock-test display table-border border-for-table pull-left" style="width:315px;">
	                                                             	${cDetailList.oldValue}
	                                                         </div>
                                                         </td>
                                                         <td class="v-a-top">
	                                                         <div class="o-auto fancybox-lock-test  display table-border border-for-table pull-left" style="width:315px;">
	                                                             ${cDetailList.newValue}
	                                                         </div>
                                                         </td>
                                                     </tr>
                                                 </c:forEach>
                                                 <c:if test="${fn:length(cList.currencies) gt 0}">
                                                     <tr class="gradi">
                                                         <td colspan="2">${th_tender_currency}</td>
                                                         <td>${th_tender_action}</td>
                                                     </tr>
                                                 </c:if>
                                                 <c:forEach items="${cList.currencies}" var="currList">
                                                     <tr>
                                                         <td colspan="2">
                                                             ${currList.currencyName}
                                                         </td>      
                                                         <td>
                                                             <c:choose>
                                                                 <c:when test="${currList.action eq 'New'}">
                                                                     <span style="color: green">${currList.action}</span>
                                                                 </c:when>                                                                                  
                                                                 <c:otherwise>
                                                                     <span style="color: red"> ${currList.action}</span>
                                                                 </c:otherwise>
                                                             </c:choose>
                                                         </td>
                                                     </tr>
                                                 </c:forEach>
                                                 <c:if test="${fn:length(cList.forms) gt 0}">
                                                     <tr class="gradi">
                                                         <td colspan="2">Tender Form</td>
                                                         <td>${th_tender_action}</td>
                                                     </tr>
                                                 </c:if>
                                                 <c:forEach items="${cList.forms}" var="frmList">
                                                     <tr>
                                                         <td colspan="2">
                                                             ${frmList.formName}
                                                         </td>      
                                                         <td>                                                                           
                                                             <c:choose>  
                                                                 <c:when test="${frmList.action eq 'New'}">
                                                                     <span style="color: green">${frmList.action}</span>
                                                                 </c:when>                                                                           
                                                                 <c:otherwise>
                                                                     <span style="color: red"> ${frmList.action}</span>
                                                                 </c:otherwise>
                                                             </c:choose>       
                                                         </td>
                                                     </tr>
                                                 </c:forEach>
                                                 <c:if test="${fn:length(cList.envelopes) gt 0}">
                                                     <tr class="gradi">
                                                         <td colspan="2">${title_envelopeform}</td>
                                                         <td>${th_tender_action}</td>
                                                     </tr>
                                                 </c:if>
                                                 <c:forEach items="${cList.envelopes}" var="envList">
                                                     <tr>
                                                         <td colspan="2">
                                                             ${envList.envelopeName}
                                                         </td>      
                                                         <td>
                                                             <c:choose>
                                                                 <c:when test="${envList.action eq 'New'}">
                                                                     <span style="color: green">${envList.action}</span>
                                                                 </c:when>                                                                          
                                                                 <c:otherwise>
                                                                     <span style="color: red"> ${envList.action}</span>
                                                                 </c:otherwise>
                                                             </c:choose>       
                                                         </td>
                                                     </tr>
                                                 </c:forEach>
                                                 <c:if test="${fn:length(cList.documents) gt 0}">
                                                     <tr  class="no-border" class="gradi">
                                                         <td colspan="3">${lbl_tender_document}</td>  
                                                     </tr>
                                                     <tr  class="no-border">
                                                         <td colspan="6">                                                                         
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
                                                         </td>
                                                     </tr>

                                                 </c:if>                   
                                             </c:if>
                                            </c:otherwise>
                                         </c:choose>
                                         <c:set var="counter" value="${counter-1}"/>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="3">
                                                <spring:message code='msg_tender_biddermap_empty' />
                                            </td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>                                        
                            </table>
                        </div>
								</div>
							</div>
						</div>
					</div>
				</div>
			
		
		
</div>

	<c:if test="${param.pageFrom ne 'viewTender'}">
		<%@include file="../../includes/footer.jsp"%>
	</c:if>

	</div>

<div id="targetDiv"></div>

	<script type="text/javascript">
		$(document).ready(function() {

			$('a.myModel').click(function() { //bind handlers
				var url = $(this).attr('href');
				showDialog(url);
				return false;
			});

			$("#targetDiv").dialog({ //create dialog, but keep it closed
				autoOpen : false,
				height : 300,
				width : 700,
				modal : true
			});

			function showDialog(url) { //load content and open dialog
				$("#targetDiv").load(url);
				$("#targetDiv").dialog("open");
			}
		});
	</script>
	
</body>
</html>