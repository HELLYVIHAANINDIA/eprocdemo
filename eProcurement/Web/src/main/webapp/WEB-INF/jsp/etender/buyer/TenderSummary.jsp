<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div class="col-md-12">

<div class="box">

<div class="box-header with-border">
<h3 class="box-title">Visit summary</h3>
</div>

<div class="box-body">
  		
		<div class="row">
			<div class="col-md-3">
				<div class="vt"><spring:message code="fields_tenderid"/></div>
			</div>
			<div class="col-md-3"><div class="vt">${tblTender.tenderId}</div></div>
			<div class="col-md-3">
			<div class="vt"><spring:message code="fields_refenceno"/></div>
			</div>
			<div class="col-md-3">
				<div class="vt">${tblTender.tenderNo}</div>
			</div>
		</div>
		
		<div class="row">
			<div class="col-md-3">
				<div class="vt"><spring:message code="field_brief"/></div>
			</div>
			<div class="col-md-9"><div class="vt">${tblTender.tenderBrief}</div></div>
		</div>
		
		<div class="row">
			<div class="col-md-3">
				<div class="vt"><spring:message code="fields_tender_keywords"/></div>
			</div>
			<div class="col-md-9"><div class="vt">${tblTender.keywordText}</div></div>
		</div>
        
        <div class="row">
			<div class="col-md-3 pullright"><a href="${pageContext.servletContext.contextPath}/etender/buyer/viewtender/${tblTender.tenderId}/0" class="btn btn-submit pull-right"><spring:message code="label_tender_view"/></a></div>
		</div>
</div>
	
</div>

</div>