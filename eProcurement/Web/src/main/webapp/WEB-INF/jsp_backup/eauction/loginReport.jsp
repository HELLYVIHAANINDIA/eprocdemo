<!DOCTYPE html>
<html>
<%-- 
    Document   : loginReport
    Created on : Jan 17, 2017, 4:11:25 PM
    Author     : BigGoal
--%>

<%@page import="com.eprocurement.etender.databean.LoginReportBean"%>
<%@page import="java.util.List"%>
<%@page import="com.eprocurement.etender.model.TblTender"%>     
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <%@include file="../includes/header.jsp"%>
        <%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
        <script src="${pageContext.servletContext.contextPath}/resources/js/commonValidate.js" type="text/javascript"></script>
        <script src="${pageContext.servletContext.contextPath}/resources/js/jquery-ui.custom.js" type="text/javascript"></script>
		<script src="${pageContext.servletContext.contextPath}/resources/js/jquery.cookie.js" type="text/javascript"></script>
		<script src="${pageContext.servletContext.contextPath}/resources/js/jquery.dynatree.js" type="text/javascript"></script>
                <!-----data table script -->
                  <script src="${pageContext.servletContext.contextPath}/resources/js/datatable/jquery.dataTables.min.js"></script>
		<script src="${pageContext.servletContext.contextPath}/resources/js/datatable/dataTables.buttons.min.js"></script>
		<script src="${pageContext.servletContext.contextPath}/resources/js/datatable/buttons.flash.min.js"></script>
		<script src="${pageContext.servletContext.contextPath}/resources/js/datatable/jszip.min.js "></script>
		<script src="${pageContext.servletContext.contextPath}/resources/js/datatable/pdfmake.min.js"></script>
		<script src="${pageContext.servletContext.contextPath}/resources/js/datatable/vfs_fonts.js"></script>
		<script src="${pageContext.servletContext.contextPath}/resources/js/datatable/buttons.html5.min.js"></script>
		<script src="${pageContext.servletContext.contextPath}/resources/js/datatable/buttons.print.min.js"></script>
		<script src="${pageContext.servletContext.contextPath}/resources/js/datatable/fnReloadAjax.js"></script>  
		<link href="${pageContext.servletContext.contextPath}/resources/js/datatable/css/buttons.dataTables.min.css" rel="stylesheet" />
                 <!-----data table script -->
		<link href="${pageContext.servletContext.contextPath}/resources/css/ui.dynatree.css" rel="stylesheet" type="text/css" id="skinSheet">
		 <!-----data table css -->
		<link type="text/css" rel="stylesheet" media="all" href="${pageContext.servletContext.contextPath}/resources/js/datatable/css/demo_table_jui.css" >
		<link type="text/css" rel="stylesheet" media="all" href="${pageContext.servletContext.contextPath}/resources/js/datatable/css/jquery-ui-1.8.11.custom.css" >
         <!-----data table css -->
<spring:message code="msg_sendbidder_mail" var="msgMail"/>                    <title><spring:message code="title_heading_tender_viewmappedbidder" var="var_title"/>${var_title}</title>
</head>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="../includes/leftaccordion.jsp"%>

<div class="content-wrapper">
            <section class="content-header">
               <h1>Login Report<small></small></h1>
            </section>
            <section class="content">
               
                <a href="${pageContext.servletContext.contextPath}/eBid/Bid/auctionListing"><< Go To Auction List</a>
            <%@include file="../etender/buyer/AuctionSummary.jsp"%>
            <div class="box-header with-border box-primary">
                <div class="col-md-6" >
                </div>
                <div class="col-md-6 text-right" >
                    <a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}" ><< Go Back To DashBord</a>
                </div>
            </div>
                <div class="box-body">
							<div class="row">
								<div class="col-lg-12 col-md-12 col-xs-12">
									<div class="row">
										<div class="col-lg-10">
											<div class="table-border">
                					            <table width="100%" cellpadding="0" cellspacing="0" class="table table-striped table-responsive" id="LoginReport">
						                                <spring:message code="lbl_tender_view_companyprofile" var="var_lbl_coprofile"/>
						                                <thead>
						                                <tr>
						                                    <th width="9%"><label><spring:message code="col_srno"/></label></th>
						                                    <th><label>Company Name.</label></th>
                                                                                    <th><label>Status</label></th>
                                                                                    <th><label>Date and Time.</label></th>
                                                                                    <th><label>IP Address</label></th>
						                                </tr>
						                                </thead>
						                                <tbody>
                                                                                    <%
                                                                                    List lst=(List)request.getAttribute("lstLoginReportBean");
                                                                                    for(int i=0;i<lst.size();i++)
                                                                                    {
                                                                                         LoginReportBean loginReportBean=new LoginReportBean();
                                                                                         loginReportBean=(LoginReportBean)lst.get(i);
                                                                                    %>
                                                                                    <tr>
						                                    <td width="9%"><label><%=i+1%></label></td>
						                                    <td><label><%=loginReportBean.getCompanyName()%></label></td>
                                                                                    <td><label><%=loginReportBean.getCstatus()%></label></td>
                                                                                    <td><label><%=loginReportBean.getCreatedOn()%></label></td>
                                                                                    <td><label><%=loginReportBean.getIPAddress()%></label></td>
                                                                                    </tr>
                                                                                    <%
                                                                                    }
                                                                                    %>
                                                                                        
                                                                                    
						                                </tbody>
						                            </table>
					                            </div>
                    				        </div>
                            			</div>
                            		</div>
                            	</div>
                            </div>
            </section>
</div>
<%@include file="../includes/footer.jsp"%>
</div>

<script>
   $(function(){
    
        $('#LoginReport').DataTable({
        
    	"bProcessing" : true,
    	"searching": true,
        "dom": 'Blfrtip',
        "language": {
    	      "emptyTable": "No record found."
    	    },
        "buttons": [
                  {
                      extend: 'pdf',
                      footer: true,
                      exportOptions: {
                          //columns: [':visible' ]
                              columns: "thead th:not(.noExport)"
                      }
                  },
                  {
                      extend: 'print',
                      footer: true,
                      exportOptions: {
                          columns: "thead th:not(.noExport)"
                      }
                     
                  },
                  {
                      extend: 'excel',
                      footer: false,
                      exportOptions: {    
                          //columns: [':visible' ]
                              columns: "thead th:not(.noExport)"
                      }
                  }         
               ],
              aoColumnDefs: [
 	       		{
 	       			bSortable: false,		// no sorting in last column
 	       			aTargets: [ -1 ]
 	       		},
 	       		{
 	       			bSortable: false,		// no sorting for first column
 	       			aTargets: [ 0 ]
 	       		}
 	       	]
        });
        setClickFunctionToDataGrid();
    
    });
    function setClickFunctionToDataGrid(){
	setTimeout(function(){
		if($(".dt-button.buttons-pdf.buttons-html5").html() != undefined){
			$(".dt-button.buttons-pdf.buttons-html5").attr("onclick",'exportContent("LoginReport","LoginReport",0)');
			$(".dt-button.buttons-excel.buttons-html5").attr("onclick",'exportContent("LoginReport","LoginReport",4)');
		}
	},1000);
}

</script>

</body>
</html>