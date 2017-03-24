<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div class="row">

<div class="col-md-12">

<div class="box">

<div class="box-header with-border">
<h3 class="box-title" href="#c">Visit summary</h3>
</div>

<div class="box-body">

<div class="row">
<div class="col-md-2"><div class="ct_filed1">Auction Id</div></div>
<div class="col-md-2"><div class="ct_filed2">${tblTender.tenderId}</div></div>
<div class="col-md-2"><div class="ct_filed1">Auction No</div></div>
<div class="col-md-2"><div class="ct_filed2">${tblTender.tenderNo}</div></div>
</div>

<div class="row">
<div class="col-md-2"><div class="ct_filed1">Auction Brief</div></div>
<div class="col-md-10"><div class="ct_filed2">${tblTender.tenderBrief}</div></div>
</div>

<div class="row">
<div class="col-md-2"><div class="ct_filed1">Auction Detail</div></div>
<div class="col-md-4"><div class="ct_filed2">${tblTender.tenderDetail}</div></div>
<div class="col-md-2">
<a href="${pageContext.servletContext.contextPath}/eBid/Bid/viewAuction/${tblTender.tenderId}/0" class="tnd_bttn" style="margin-top:0px;"><spring:message code="label_view"/></a>
</div>
</div>

</div>

		
		
		
		
	
</div>