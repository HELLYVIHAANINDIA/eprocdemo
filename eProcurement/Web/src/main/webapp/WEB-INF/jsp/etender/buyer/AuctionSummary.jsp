<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div class="row">

	<div class="col-md-12">

		<div class="box">

			<div class="box-header with border">
				<h3 class="box-title" href="#c"><spring:message code="lbl_visit_summary" /></h3>
			</div>

			<div class="box-body">

				<div class="row">
					<div class="col-md-3"><div class="ct_filed1"><spring:message code="lbl_auction_id" /></div></div>
					<div class="col-md-3">${tblTender.tenderId}</div>
					<div class="col-md-3"><spring:message code="lbl_auction_no" /></div>
					<div class="col-md-3">${tblTender.tenderNo}</div>
				</div>

				<div class="row">
					<div class="col-md-3"><spring:message code="lbl_auction_brief" /></div>
					<div class="col-md-9">${tblTender.tenderBrief}</div>
				</div>

				<div class="row">
					<div class="col-md-3"><spring:message code="lbl_auction_details" /></div>
					<div class="col-md-6">${tblTender.tenderDetail}</div>
					<div class="col-md-3">
                                           
                                                <a href="${pageContext.servletContext.contextPath}/eBid/Bid/viewAuction/${tblTender.tenderId}/0" class="tnd_bttn"><spring:message code="label_view"/></a>
                                          
					
					</div>
				</div>

			</div>	

		</div>

	</div>

</div>