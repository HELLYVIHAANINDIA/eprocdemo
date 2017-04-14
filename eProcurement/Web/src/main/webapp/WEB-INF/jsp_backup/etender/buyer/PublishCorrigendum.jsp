<!DOCTYPE html>
<html>
    <head>
	<%@include file="../../includes/header.jsp"%>
        <script src="${pageContext.servletContext.contextPath}/resources/js/commonValidate.js" type="text/javascript"></script>        
        <spring:message code="title_publish_corrigendum" var="titlecorrigendum"/>
        <title>${titlecorrigendum}</title>       
        <script>
            function validateReg(){
                var vbool = valOnSubmit();
                return disableBtn(vbool);
            }
        </script>
</head>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="../../includes/leftaccordion.jsp"%>
    
      <div class="content-wrapper">

		<section class="content-header">
            
            <div class="main_container o-hidden" id="temp">
                <div class="container_25">
                    <div class="content_section" > 
                         <section class="inner-right-bar pull-left">
                            <!--Write Content here-->
                            <div class="panel-container">                                
                                
                                <spring:message code="link_tender_publish" var="btnPublish"/>
                                <spring:message code="link_view_corrigendum" var="linkview"/>
                                
                                <spring:url value="/etender/buyer/publishcorrigendum" var="publishcorrurl"/>
                                
                                    <form:form action="${publishcorrurl}"  method="post" onsubmit="return validateReg();">
                                     <input type="hidden" name="hdTenderId" value="${tenderId}" />
                                     <input type="hidden" name="hdEventType" value="${eventType}" />
                                     <div class="clearfix table-border">
                                        <table width="100%" class="border-top-none">                                                                        
                                               <tr  class="gradi" >
                                                   <th width="10%"><spring:message code="th_tender_srno"/></th>
                                                   <th width="30%"><spring:message code="lbl_corrigendum_id"/></th>
                                                   <th width="20%"><spring:message code="lbl_corrigendum_text"/></th>
                                                   <th width="20%"><spring:message code="lbl_corrigendum_Amendment"/></th>
                                               </tr>    
                                               <c:forEach items="${corrigendumList}" var="corrigendum">
                                                   <tr>
                                                       <td width="10%" class="a-center">1</td>
                                                       <td width="30%" class="a-center">${corrigendum.corrigendumId} </td>
                                                       <td width="30%">
	                                                       <div class="o-auto fancybox-lock-test display table-border border-for-table pull-left" style="width:467px;">
		                                                       ${corrigendum.corrigendumText}
	                                                       </div>
                                                       </td>
                                                        <input type="hidden" name="hdCorrigendumId" id="hdCorrigendumId" jsrequired="false" value="${corrigendum.corrigendumId}" />
                                                       <td width="30%">
                                                              <a href="${pageContext.servletContext.contextPath}/etender/buyer/viewcorrigendum/${tenderId}">View Corrigendum</a>
                                                       </td>
                                                   </tr>
                                                  
                                               </c:forEach> 
                                           </table>
                                          </div>
                                          <div class="clearfix formfield">
                                            <table width="100%">      
                                                 <tr>
                                                     <td style="width: 20%" class="v-a-middle">
                                                           <label>Remarks<span> *</span></label></td>
                                                      <td style="width: 80%">
                                                      <textarea rows="5" cols="50" name="txtaRemarks" class="form-control" id="txtaRemarks" title="remarks" isrequired="true"></textarea>
                                                      </td>
                                                   </tr>

                                                   <tr>
                                                       <td class="v-a-top" colspan="2">
                                                          <button type="submit" class="blue-button-small prefix1_4" name="approval" id="approval">${btnPublish}</button>                                                      
                                                          <span class="pull-right go-back"><spring:message code="link_goback_tenderdashbord" var="goBack"/>
                                                              <abc:href href="etender/buyer/tenderdashboard/${tenderId}/4" label="${goBack}"/>
                                                          </span>
                                                       </td>
                                                   </tr>
                                            </table>
                                          </div>
                                          <%-- <input type="hidden" name="hdTenderId" value="${tenderId}"> --%>
<%--                                           <input type="hidden" name="hdCorrigendumId" value="${corrigendumId}"> --%>
                                    </form:form>   
                                
                            </div>
                            
                         </section>
            <!--Body Part End--> 
                    </div>
                </div>
            </div>
            </section></div>
	<%@include file="../../includes/footer.jsp"%>
</div>

<script>
$("#txtaRemarks").wysihtml5();
</script>

</body>
</html>