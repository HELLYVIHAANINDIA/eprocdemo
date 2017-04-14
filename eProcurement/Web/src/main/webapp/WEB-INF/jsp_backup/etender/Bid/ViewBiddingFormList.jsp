<!DOCTYPE html>
<html>
<%@page import="com.eprocurement.etender.model.TblTenderCell"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.eprocurement.etender.model.TblTenderColumn"%>
<%@page import="com.eprocurement.etender.model.TblTenderTable"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.List"%>
<%@page import="com.eprocurement.etender.model.TblTenderForm"%>
<%@page import="java.util.Map"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../../includes/header.jsp"%>
        <%
             int userType=1; //This value will come from the session
            
            List<TblTenderForm> lstTable = (List) request.getAttribute("formList");
            
            
           
        %>
</head>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="../../includes/leftaccordion.jsp"%>

        <div class="content-wrapper">
        
            <section class="content-header">
                <h1>Bidding Form List
                </h1>
            </section>
            <section class="content">             
                <div class="row">
                    <div class="col-lg-12 col-md-12">
                        <div class="box">
                            <div class="box-header with-border">
                                <h3 class="box-title"> Form List </h3>
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
                                                                                        <th>Form Name</th>
                                                                                       <th>View</th>
                                                                                        <th>Edit</th>
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
                                                                                                        %>">Edit</a></td>
                                                                                                     
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
</div>
      
<script src="${pageContext.servletContext.contextPath}/resources/PageJS/ViewBiddingForm.js" type="text/javascript"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

</body>

</html>