<!DOCTYPE html>
<html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<%@include file="../../includes/header.jsp"%>
</head>
	
<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="../../includes/leftaccordion.jsp"%>
	
<div class="content-wrapper">

<section class="content-header">
<!-- 		onsubmit="return validation();" -->
<a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}"><< Go To Tender Dashboard</a>
<form id="tenderDtBean" name="tenderDtBean" onsubmit="return validation();" action="${pageContext.servletContext.contextPath}/etender/buyer/submittendercorrigendum" method="post" >
<div class="main_container o-hidden" id="temp">

          <div class="panel-container">
               <div class="page-title prefix_1 o-hidden">
                  <h1 class="pull-left grid_12">
                      <spring:message code="link_create_corrigendum"/></h1>
                      <c:if test="${not empty tblCorrigendum}">
                       <c:forEach items="${tblCorrigendum}" var="items"> 
                       	<c:if test="${items.cstatus eq 0}">
                        	<input type="hidden" name="corrigendumId" id="corrigendumId" value="${items.corrigendumId}">
                        	<c:set value="${items.corrigendumText}" var="corrigendumText"></c:set>
                       	</c:if>
                       </c:forEach>
                       </c:if>
                  </div>
                        <div class="page-title prefix_1 o-hidden">
                            <span class="pull-right go-back"><spring:message code="link_goback_tenderdashbord" var="goBack"/>
<%--                                 <abc:href href="etender/buyer/tenderdashboard/${tenderId}/4" label="${goBack}"/> --%>
                            </span>
                        </div> 
                        <div class="clearfix mini-formfield p-bottom-none">
                            <font size="1" class="pull-right mandatory">(<b class="red">*</b>) <spring:message code="msg_mandatoryFields"></spring:message></font>
                            <table class="tableView m-bottom" width="100%" cellspacing="0" cellpadding="0" border="0">
                                <tr>
                                    <td width="20%" class="f-bold v-a-middle"><spring:message code="lbl_create_corrigendum_text"/><span id='errSpanCorrigendumTextMsg' class='mandatory'>*</span></td>

	                                   <td>
	                                   	<textarea  class="form-control corrigendumText"  id="corrigendumText" name="corrigendumText" title="Details" cols="20" rows="10" >${corrigendumText}</textarea> 
	                                   </td>
                                </tr>
                                <tr>
                                    <td class="v-a-top" colspan="2">
                                    
                                    <input type="hidden" name="tenderId" id="tenderId" value="${tenderId}">
                                    <spring:message code="label_submit" var="submitBtn"/>
                                        <button type="submit" class="blue-button-small prefix1_4">${submitBtn}</button> 
                                        <span class="pull-right go-back"><spring:message code="link_goback_tenderdashbord" var="goBack"/>
<%--                                             <abc:href href="etender/buyer/tenderdashboard/${tenderId}/4" label="${goBack}"/> --%>
                                        </span>
                                    </td>
                                </tr>
                            </table>                           
                        </div>     
					</div></div></form>
         	</section></div>
	<%@include file="../../includes/footer.jsp"%>
	</div>
<script type="text/javascript">
$("#corrigendumText").wysihtml5();
</script>
</body>
</html>