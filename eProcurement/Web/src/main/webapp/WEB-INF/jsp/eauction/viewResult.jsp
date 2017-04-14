<%@include file="./../includes/head.jsp"%>
<jsp:useBean id="now" class="java.util.Date" />
<%@include file="./../includes/masterheader.jsp"%>
<%@page import="com.eprocurement.etender.model.TblTender"%>
	<spring:message code="client_dateformate_hhmm" var="client_dateformate_hhmm"/>

            <section class="content-header">
               <h1><spring:message code="lbl_auction_result" /><small></small></h1>
            </section>
            <section class="content">
               
                <a href="${pageContext.servletContext.contextPath}/eBid/Bid/auctionListing"><< <spring:message code="lbl_go_to_auction_list" /></a>
            <%@include file="../etender/buyer/AuctionSummary.jsp"%>
                                <div class="box-header with-border box-primary">
                                    <div class="col-md-6" >
                                       
                                    </div>
                                    <div class="col-md-6 text-right" >
                                        <a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}" ><< <spring:message code="lbl_go_back_to_dashboard" />
                                        </a>
                                     </div>
                                </div>
                                        <div class="row">
                                            <div class="box">
                                                <div class="box-header with-border">
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <div class="col-sm-2 col-md-2">
                                                                <div class="form_filed text-black text-right">
                                                                   <spring:message code="lbl_start_price" />
                                                                </div>
                                                            </div>
                                                            <div class="col-sm-2 col-md-2">
                                                                <div class="form_filed text-black text-right">
                                                                    ${tblTender.startPrice}
                                                                </div>
                                                            </div>
                                                             <div class="col-sm-2 col-md-2">
                                                                <div class="form_filed text-black text-right">
                                                                    <c:if test="${tblTender.auctionMethod eq 1}">
                                                                        <spring:message code="lbl_increment_value" />
                                                                    </c:if>
                                                                    <c:if test="${tblTender.auctionMethod eq 0}">
                                                                        <spring:message code="lbl_decrement_vallue" />
                                                                    </c:if>
                                                                </div>
                                                            </div>  
                                                                <div class="col-sm-2 col-md-2">
                                                                <div class="form_filed text-black text-right">
                                                                    ${tblTender.incrementDecrementValues}
                                                                </div>
                                                                </div>
                                                                    <c:if test="${tblTender.isReservePriceConfigure eq 1}">
                                                                        <div class="col-sm-2 col-md-2">
                                                                <div class="form_filed text-black text-right">
                                                                   <spring:message code="lbl_reverse_price" />
                                                                </div>
                                                            </div>
                                                            <div class="col-sm-2 col-md-2">
                                                                <div class="form_filed text-black text-right">
                                                                    ${tblTender.auctionReservePrice}
                                                                </div>
                                                            </div>
                                                                    </c:if>
                                                                
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>    
                                                                
                                                                <div class="box-body">
							<div class="row">
								<div class="col-lg-12 col-md-12 col-xs-12">
									<div class="row">
										<div class="col-lg-10">
											<div class="table-border">
                					            <table width="100%" cellpadding="0" cellspacing="0" class="table table-striped table-responsive" id="bidTable">
						                               
						                                <thead>
						                                <tr>
						                                    
						                                    <th><label><spring:message code="lbl_bidder_name" /></label></th>
                                                                                    <th><label><spring:message code="lbl_bidder_amount" /></label></th>
                                                                                    <th><label><spring:message code="lbl_rank" /></label></th>
                                                                                    <th><label><spring:message code=" lbl_bid_date_time" /></label></th>
						                                </tr>
						                                </thead>
						                                <tbody>
                                                                                    <c:forEach items="${bidLst}" var="bid">
                                                                                        <tr>
						                                  
						                                    <td><label>${bid.bidderName}</label></td>
                                                                                    <td><label>${bid.bidValue}</label></td>
                                                                                    <td><label>${bid.rank}</label></td>
                                                                                    <td><label>
                                                                                            <fmt:formatDate value="${bid.biddingDate}" var="formattedDate" type="date" pattern="${client_dateformate_hhmm}" />
                                                                                     	${formattedDate}
                                                                                    </label></td>
                                                                                    </tr>
                                                                                    
                                                                                    </c:forEach>
                                                                                    
                                                                                        
                                                                                    
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
    
        $('#bidTable').DataTable({
        
    	"bProcessing" : true,
    	"searching": true,
        "dom": 'Blfrtip',
        "language": {
    	      "emptyTable": "No record found."
   	    	  "searchPlaceholder": "Search"
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
			$(".dt-button.buttons-pdf.buttons-html5").attr("onclick",'exportContent("bidTable","AuctionBidReport",0)');
			$(".dt-button.buttons-excel.buttons-html5").attr("onclick",'exportContent("bidTable","AuctionBidReport",4)');
		}
	},1000);
}

</script>
<script src="${pageContext.servletContext.contextPath}/resources/js/jquery-ui.min.js"></script>
<%@include file="../includes/footer.jsp"%>

       
