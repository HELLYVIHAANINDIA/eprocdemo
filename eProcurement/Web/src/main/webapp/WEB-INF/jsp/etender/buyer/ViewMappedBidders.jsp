<!DOCTYPE html>
<html>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <%@include file="../../includes/header.jsp"%>
        <%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
        <script src="${pageContext.servletContext.contextPath}/resources/js/commonValidate.js" type="text/javascript"></script>
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
                
                
                <title><spring:message code="title_heading_tender_viewmappedbidder" var="var_title"/>${var_title}</title>
    </head>
    <spring:message code="msg_sendbidder_mail" var="msgMail"/>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="../../includes/leftaccordion.jsp"%>

<div class="content-wrapper" style="height: auto; ">

<section class="content-header">

					<a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}" class="btn btn-submit">
                                            
                                             <c:if test="${isAuction eq 1}">
                                                        << Go To Auction Dashboard
                                                    </c:if>
                                                    <c:if test="${isAuction ne 1}">
                                                        << Go To Tender Dashboard
                                                    </c:if></a>

<h1 style="margin:0px; margin-top:10px;"><spring:message code="title_heading_tender_viewmappedbidder"/></h1>

</section>

<section class="content">
<div class="row">
<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
<div class="box">

<div class="box-header with-border">
<h3 class="box-title"><spring:message code="title_heading_tender_viewmappedbidder"/></h3>											
</div>

<div class="box-body">
<div class="row">

<div class="col-lg-12 col-md-12 col-xs-12">
									<div class="row">
										<div class="col-md-12">
											<div class="table-border">
                					            <table width="100%" cellpadding="0" cellspacing="0" class="table table-striped table-responsive" id="MappedBidder">
						                                <spring:message code="lbl_tender_view_companyprofile" var="var_lbl_coprofile"/>
						                                <thead>
						                                <tr>
						                                    <th width="9%"><label><spring:message code="col_srno"/></label></th>
						                                    <th><label>Bidder Details</label></th>
						                                </tr>
						                                </thead>
						                                <tbody>
						                                <c:choose>
						                                    <c:when test="${not empty lstMappedBidders}">
						                                        <c:forEach items="${lstMappedBidders}" var="data" varStatus="cnt">
						                                            <tr>
						                                                <td class="a-center">${cnt.count}</td>
						                                                <td class="line-height">
						                                                ${data[2]}
                                    									<br/>${data[3]}
                                    									<br/>${data[4]}
                                    									<br/>${data[6]}-${data[5]}
						                                            </tr>
						                                        </c:forEach>
						                                    </c:when>
						                                    <c:otherwise>
						                                        <tr>
						                                            <td colspan="5"><spring:message code="msg_tender_biddermap_empty"/></td>
						                                        </tr>
						                                    </c:otherwise>
						                                </c:choose>
						                                </tbody>
						                            </table>
					                            </div>
                    				        </div>
                            			</div>
                            		</div>
                            	</div>
                            </div>
                            
</div>                        
</div>
</div>
</section>

</div>
</div>


<script>
    var isAuction='${isAuction}';
    $(function(){
     if(isAuction==1 || isAuction=='1')
     {
        $('#MappedBidder').DataTable({
        
     "bProcessing" : true,
     "searching": true,
        "dom": 'Blfrtip',
        "language": {
           "emptyTable": "No record found."
         },
        "buttons": [{
                      extend: 'pdf',
                      footer: true,
                      exportOptions: {
                            columns: "thead th:not(.noExport)"
                      }
                   },
                  {
                      extend: 'print',
                      footer: true,
                      exportOptions: {
                          columns: "thead th:not(.noExport)"
                      }
                  }],
              aoColumnDefs: [
           {
            bSortable: false,  // no sorting in last column
            aTargets: [ -1 ]
           },
           {
            bSortable: false,  // no sorting for first column
            aTargets: [ 0 ]
           }
          ]
        });
        setClickFunctionToDataGrid();
    }
    });
    function setClickFunctionToDataGrid(){
 setTimeout(function(){
  if($(".dt-button.buttons-pdf.buttons-html5").html() != undefined){
   $(".dt-button.buttons-pdf.buttons-html5").attr("onclick",'exportContent("MappedBidder","MappedBidder",0)');
   $(".dt-button.buttons-excel.buttons-html5").attr("onclick",'exportContent("MappedBidder","MappedBidder",4)');
  }
 },1000);
}

</script>
</body>
</html>
