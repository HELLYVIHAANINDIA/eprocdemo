<%@include file="../../includes/head.jsp"%>
<%@include file="../../includes/masterheader.jsp"%>
<div class="content-wrapper">
<section class="content-header">
<h1><spring:message code="title_tender_formlibrary" /> <small></small></h1>
</section>

<section class="content">
               
                <div class="row">
                    <div class="col-lg-12 col-md-12">
                        <div class="box">
                            <div class="box-header with-border">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="col-md-6 pull-left">
                                           <spring:message code="lbl_create_document_form"/>
                                        </div>
                                        <div class="col-md-6 text-right">
                                           <a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}" class="btn btn-submit" style="margin-top:0px;"><< <spring:message code="lbl_go_back_to_dashboard" />
                                            </a>
                                         </div>
                                    </div></div></div>
                                            
						<div class="box-body">
							<div class="row"><div class="box-header with-border"> 
                                                            <form action="${pageContext.servletContext.contextPath}/eBid/Bid/getFormLibrary/${tenderId}" method="post">
                                                            <div class="col-lg-2">
                                                                <div class="form_filed"><spring:message code="lbl_form_type" /></div>
                                                            </div>
                                                            <div class="col-lg-4">
                                                                <select name="FormType" class="form-control">
                                                                    <option value="-1"><spring:message code="lbl_select_form_type" /></option>
                                                                    <c:forEach items="${envelopeList}" var="element">
                                                                        <c:choose>
                                                                            <c:when test="${element.envId eq formType}">
                                                                                <option value="${element.envId}" selected="true">${element.lang1}</option>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                            <c:if test="${(isAuction eq 0 or (isAuction eq 1 && element.envId eq 4))}">
                                                                                 <option value="${element.envId}">${element.lang1}</option>
                                                                            </c:if>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                       
                                                                    </c:forEach>
                                                                </select>
                                                                       
                                                            </div>
                                                            
                                                            <div class="col-lg-2">
                                                                <div class="form_filed"><spring:message code="lbl_event_id" /> </div>
                                                            </div>
                                                            <div class="col-lg-4">
                                                                <input type="text" id="eventId" name="eventId" class="form-control" placeholder="Select Form Name" value="${eventId}">
                                                                       
                                                            </div>
                                                            
                                                            <div class="col-lg-2">
                                                                <div class="form_filed"><spring:message code="lbl_form_id" /></div>
                                                            </div>
                                                            <div class="col-lg-4">
                                                                <input type="text" id="formId" name="formId" class="form-control" placeholder="Select Form Name" value="${formId}">
                                                                       
                                                            </div>
                                                            
                                                            
                                                            <div class="col-lg-2">
                                                                <div class="form_filed"><spring:message code="lbl_reference_no" /> </div>
                                                            </div>
                                                            <div class="col-lg-4">
                                                                <input type="text" id="refNo" name="refNo" class="form-control" placeholder="Select Form Name" value="${refNo}">
                                                                       
                                                            </div>
                                                            
                                                            <div class="col-lg-2">
                                                                <div class="form_filed"><spring:message code="field_formName" /> </div>
                                                            </div>
                                                            <div class="col-lg-4">
                                                                <input type="text" id="formName" name="formName" class="form-control" placeholder="Select Form Name" value="${formName}">
                                                                       
                                                            </div>
                                                            
                                                             
                                                            <div class="col-lg-2">
                                                                <div class="form_filed"><spring:message code="label_tender_department" /> </div>
                                                            </div>
                                                            <div class="col-lg-4">
                                                                <select name="dept" class="form-control">
                                                                    <option value="-1"><spring:message code="lbl_select_department" /></option>
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
                                                                 <button type="submit" class="btn btn-info" id="btnCopyForm" name="btn" value="search" ><i class="fa fa-add"></i>&nbsp;<spring:message code="lbl_search" /></button>
                                                                 <button type="submit" class="btn btn-info" id="btnCopyForm" name="btn" value="clear"><i class="fa fa-add"></i>&nbsp;<spring:message code="lbl_clear_search" /></button>
                                                             </div>
                             </form></div>
							<form  action="${pageContext.servletContext.contextPath}/eBid/Bid/copyForm"  method="post"  onsubmit=" return getSelectedCheckBox();">
                               <div class="col-lg-12 col-md-12 col-xs-12">
                                                                     <c:if test="${isAuction eq 0}">
                                                                    <div class="col-lg-2">
                                                                        <div class="form_filed"><spring:message code="lbl_tender_envelop" /> </div>
                                                                    </div>
                                                                    
                                                                    <div class="col-lg-4">
                                                                       
                                                                        <select name="TenderEnv" id= "TenderEnv" class="form-control">
                                                                            <option value="-1"><spring:message code="lbl_select_tender_envelop" /></option>
                                                                            <c:forEach items="${formEnvelope}" var="element">
                                                                               <option value="${element.envelopeId}">${element.envelopeName}</option>
                                                                            </c:forEach>
                                                                        </select>
                                                                    </div>
                                                                    <div class="col-md-4 text-right"><button type="submit" class="btn btn-info" id="btnCopyForm" ><i class="fa fa-add"></i>&nbsp;<spring:message code="lbl_copy_form_to_tender" /></button></div>   
                                                                    </c:if>
                                                                    <c:if test="${isAuction eq 1}">
                                                                        <div class="col-lg-2" style="display: none">
                                                                            <div class="form_filed"><spring:message code="lbl_tender_envelop" /></div>
                                                                        </div>

                                                                        <div class="col-lg-4" style="display: none">
                                                                            <select name="TenderEnv" id= "TenderEnv" class="form-control">
                                                                                <option value="-1"><spring:message code="lbl_select_tender_envelop" /></option>
                                                                                <c:forEach items="${formEnvelope}" var="element">
                                                                                    <option value="${element.envelopeId}" selected>${element.envelopeName}</option>
                                                                                </c:forEach>
                                                                            </select>
                                                                        </div>
                                                                        <div class="col-md-4 text-right">
                                                                            <button type="submit" class="btn btn-info" id="btnCopyForm" >
                                                                                <i class="fa fa-add"></i>&nbsp;<spring:message code="lbl_copy_from_to_auction" />
                                                                            </button>
                                                                        </div>   
                                                                    
                                                                    </c:if>
                                                                    
                                                                    <div class="clearfix"></div>
                                                                    
                                                                    <table id="tbl_form" class="table table-bordered table-striped" style="margin-top:20px; float:left;">
                                                                        <thead>
                                                                            <tr>
                                                                                <th><spring:message code="lbl_form_id" /></th>
                                                                                <th><spring:message code="lbl_form" /></th>
                                                                                <th><spring:message code="lbl_event_id" /></th>
                                                                                <th><spring:message code="lbl_reference_no" /> </th>
                                                                                <th><spring:message code="lbl_department" /></th>
                                                                                <th><spring:message code="label_view" /></th>
                                                                                <th><spring:message code="col_select" /></th>

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
                                                                                    <td><a href="${pageContext.servletContext.contextPath}/eBid/Bid/viewForm/${element.getTblTender().getTenderId()}/${element.getFormId()}/0/false_isFormLibrery_${tenderId}"><spring:message code="label_view" /></a></td>
                                                                                    <td>
                                                                                        <c:if test="${isAuction eq 0}">
                                                                                            <input type="checkbox" formId="${element.getFormId()}" formName="${element.getFormName()}" id="${element.getFormId()}" onchange ="checkEnvValidation(this);">
                                                                                        </c:if>  
                                                                                        <c:if test="${isAuction eq 1}">
                                                                                            <input type="radio" name="frmRadio" formId="${element.getFormId()}" formName="${element.getFormName()}" id="${element.getFormId()}" onchange ="checkEnvValidation(this);">
                                                                                        </c:if>          
                                                                                    </td>

                                                                                </tr>

                                                                            </c:forEach>
                                                                        </tbody>
                                                                    </table>
                                                                    <input type="hidden" id="hdnFormId" name="hdnFormId">
                                                                       <input type="hidden" name="tenderId" value="${tenderId}">
								</div>
						</form>
							</div>
						</div>

					</div>

				</div>
         </div>
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
                                //alert($(formId).attr('formName')+" is selected for copy");
                            }
                             
                    }
                    });
                   // return flag;
            }
            }

             
         </script>
<%@include file="../../includes/footer.jsp"%>
