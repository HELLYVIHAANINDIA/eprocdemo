<%@include file="../../includes/head.jsp"%>
	<%@include file="../../includes/masterheader.jsp"%>
	<script src="${pageContext.request.contextPath}/resources/js/bootstrap3-wysihtml5.all.min.js"></script>
        <spring:message code="title_publish_corrigendum" var="titlecorrigendum"/>
        <spring:message code="lbl_back_dashboard" var="lbl_back_dashboard"/>
    <div class="content-wrapper">   
    
		<section class="content-header">
			<div class="pull-right"><a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}"><< ${lbl_back_dashboard}</a></div>
			<h1>Show Publish Corrigendum</h1>
        </section>
        
        <section class="content" id="temp">
        	<div class="row">
        		<div class="col-xs-12">
        			<div class="box">
        			<div class="box-body">
        				<div class="row">
        				                                <spring:message code="link_tender_publish" var="btnPublish"/>
                                <spring:message code="link_view_corrigendum" var="linkview"/>
                                
                                <spring:url value="/etender/buyer/publishcorrigendum" var="publishcorrurl"/>
                                
                                    <form:form action="${publishcorrurl}"  method="post" onsubmit="return validateReg();">
                                     <input type="hidden" name="hdTenderId" value="${tenderId}" />
                                     <input type="hidden" name="hdEventType" value="${eventType}" />
                                    	
                                    	<div class="col-xs-12">
                                        <table width="100%" class="table table-striped table-responsive dataTable no-footer">                                                                        
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
                                                              <a href="${pageContext.servletContext.contextPath}/etender/buyer/viewcorrigendum/${tenderId}/0">View Corrigendum</a>
                                                       </td>
                                                   </tr>
                                                  
                                               </c:forEach> 
                                           </table>
                                         	</div>
                                                
                                            <div class="col-xs-2"><label class="lbl-1">Remarks<span class="red"> *</span></label></div>
                                            <div class="col-xs-10"><textarea rows="5" cols="50" name="txtaRemarks" class="form-control" id="rtfRemarks" title="remarks" tovalid="true"  validarr="required@@length:0,1000"  isrequired="true"></textarea></div>                                                                                                                           
                                            <div class="col-xs-2"></div>
                                            <div class="col-xs-10">
                                            	<button type="submit" class="btn btn-submit" name="approval" id="approval">${btnPublish}</button>                                                      
                                            </div>                                   
                                    </form:form>  
        					
        				</div>
        			</div>
        			</div>
        		</div>
        	</div>
        </section>
     </div>          

<script>
$("#rtfRemarks").wysihtml5();
</script>
 <script>
            function validateReg(){
                var vbool = valOnSubmit();
                return disableBtn(vbool);
            }
        </script>

<%@include file="../../includes/footer.jsp"%>