<%@include file="./../includes/head.jsp"%>
       <%@include file="./../includes/masterheader.jsp"%>
<%@page import="com.eprocurement.etender.databean.LoginReportBean"%>
<%@page import="java.util.List"%>
<%@page import="com.eprocurement.etender.model.TblTender"%>              
                    <spring:message code="msg_sendbidder_mail" var="msgMail"/>

            <section class="content-header">
               <h1><spring:message code="lbl_login_report" /><small></small></h1>
            </section>
            <section class="content">
               
                <a href="${pageContext.servletContext.contextPath}/eBid/Bid/auctionListing"><< <spring:message code="lbl_go_to_auction_list" /></a>
            <%@include file="../etender/buyer/AuctionSummary.jsp"%>
            <div class="box-header with-border box-primary">
                <div class="col-md-6" >
                </div>
                <div class="col-md-6 text-right" >
                    <a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}" ><< <spring:message code="lbl_go_back_to_dashboard" /></a>
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
						                                    <th><label><spring:message code="lbl_company_name" /></label></th>
                                                                                <%--<th><label>Status</label></th>--%>
                                                                                    <th><label><spring:message code="lbl_date_time" /></label></th>
                                                                                    <th><label><spring:message code="lbl_ip_address" /></label></th>
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
                                                                                   <%--<td><label><%=loginReportBean.getCstatus()%></label></td>--%>
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
<%@include file="../includes/footer.jsp"%>

