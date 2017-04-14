<%@include file="../../includes/head.jsp"%>
     <%@include file="../../includes/masterheader.jsp"%>
<%@page import="com.eprocurement.etender.model.TblTenderCell"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.eprocurement.etender.model.TblTenderColumn"%>
<%@page import="com.eprocurement.etender.model.TblTenderTable"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.List"%>
<%@page import="com.eprocurement.etender.model.TblTenderForm"%>
<%@page import="java.util.Map"%>

        <%
             int userType=1; //This value will come from the session
            
            List<TblTenderForm> lstTable = (List) request.getAttribute("formList");
            
            
           
        %>
<div class="content-wrapper">
            <section class="content-header">
                <h1>
<spring:message code="lbl_bidding_form_list" />

                </h1>
            </section>
            <section class="content">
              
                <div class="row">
                    <div class="col-lg-12 col-md-12">
                        <div class="box">
                            <div class="box-header with-border">
                                <h3 class="box-title"> <spring:message code="lbl_form_list" /> </h3>
                            </div>
                            <div class="box-body">
                                <div class="row">
                                       
                                       
                                     
                                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">

                                        	<div class="box">

						<div class="box-header with-border">
							<h3 class="box-title"><b></b></h3>
						</div>
                                                <div class="box-header with-border">
							<h3 class="box-title"></h3>
						</div>

						<div class="box-body">
							<div class="row">
								<div class="col-lg-12 col-md-12 col-xs-12">
									<table class="table table-striped table-responsive" >
										<thead>
                                                                                    <tr>
                                                                                        <th><spring:message code="field_formName" /></th>
                                                                                       <th><spring:message code="label_view" /></th>
                                                                                        <th><spring:message code="label_edit" /></th>
                                                                                    </tr>
										</thead>
                                                                                <tbody>
                                                                                     
                                                                                         <%
                                                                                            for(TblTenderForm tblTenderForm:lstTable)
                                                                                            {%>
                                                                                                <tr> 
                                                                                                <td><%=tblTenderForm.getFormName()%></td>
                                                                                                                                            <td><a href="${pageContext.servletContext.contextPath}/eBid/Bid/viewForm?formId=<%=tblTenderForm.getFormId()
                                                                                                        %>">View</a></td>
                                                                                                 <td><a href="${pageContext.servletContext.contextPath}/eBid/Bid/EditBiddingForm?formId=<%=tblTenderForm.getFormId()
                                                                                                        %>"><spring:message code="label_edit" /></a></td>
                                                                                                     
                                                                                                </tr>
                                                                                    <%}
                                                                                             %>
                                                                                </tbody>
									</table>
								</div>
							</div>
						</div>
                                                                                        <div class="box-header with-border">
							<h3 class="box-title"></h3>
						</div>

					</div>

                                        </div>
                                           
                                            
                                            <div class="col-lg-12">
                                                <h3></h3>
                                            </div>
                                    
                                     
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                                            
            </section>
        </div>
<script src="${pageContext.servletContext.contextPath}/resources/PageJS/ViewBiddingForm.js" type="text/javascript"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<%@include file="../../includes/footer.jsp"%>
   
