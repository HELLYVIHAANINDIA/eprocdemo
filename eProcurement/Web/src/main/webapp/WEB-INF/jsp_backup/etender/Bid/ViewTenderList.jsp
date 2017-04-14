<!DOCTYPE html>
<html>
<%@page import="com.eprocurement.etender.model.TblTender"%>
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
            
            List<TblTender> lstTable = (List) request.getAttribute("tenderList");
            
            
           
        %>
</head>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="../../includes/leftaccordion.jsp"%>

        <div class="content-wrapper">
            <section class="content-header">
                <h1>Tender List
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
                                                                                        <th>Tender N0</th>
                                                                                        <th>Description</th>
                                                                                        <th>Operation</th>
                                                                                    </tr>
										</thead>
                                                                                <tbody>
                                                                                     
                                                                                         <%
                                                                                            for(TblTender tblTender:lstTable)
                                                                                            {%>
                                                                                                <tr> 
                                                                                                <td><%=tblTender.getTenderNo()%></td>
                                                                                                 <td><%=tblTender.getTenderBrief()%></td>
                                                                                                 <td><a href="${pageContext.servletContext.contextPath}/eBid/Bid/createForm?tenderId=<%=tblTender.getTenderId()
                                                                                                        %>">Create Bidding form</a></td>
                                                                                                 
                                                                                                     
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