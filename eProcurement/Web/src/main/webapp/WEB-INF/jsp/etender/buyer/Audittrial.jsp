<%@include file="../../includes/head.jsp"%>
       <%@include file="../../includes/masterheader.jsp"%>
<div class="content-wrapper">
		<section class="content-header">
			<h1>
				Audit Trail Report
			</h1>
		</section>
			
<section class="content">
<div class="row">
<div class="col-md-12">
	<div class="box">

	<form id="tenderListForm">
			<div class="row">
				<div class="col-md-3">
					Email Id
				</div> 
				<div class="col-md-3">
					<input type="text" class="searchLike form-control" columnname="ENTITY_NAME">
				</div>
				<div class="col-md-3">
					Link
				</div>
				<div class="col-md-3">
					<input type="text" class="searchLike form-control" columnname="PAGE_URL">
				</div>
			</div>
			<div class="row">
				<div class="col-md-3">
					<input type="hidden" name="jsonSearchCriteria" id="jsonSearchCriteria"> <input type="button" onclick="searchForList()" class="btn-sm form-control" value="Search">
					<input type="hidden" name="defaultOrder" id="defaultOrder" value="1:desc">
				</div>
				<div class="col-md-3">
					<input type="reset" class="btn-sm form-control" value="Clear" onclick="location.reload();">
				</div>
			</div>
			<input type="hidden"  name="defaultOrder" id="defaultOrder" value="1:Desc">
		</form>
</div>
</div>
</div>
<div class="row">
				<div class="col-lg-129 col-md-12 col-sm-12 col-xs-12">
					<div class="box">
						<div class="box-header with-border">
	               					<spring:message code="lbl_edit_dept" var="editdepartment"/>
	               						<h3 class="box-title">Audit Trail Report</h3>											
						</div>
					<div class="box-body">
							<div class="row">
								<div class="col-lg-12 col-md-12 col-xs-12">
									<div id="listingDiv">
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
</div>				
</section>
</div>
<script type="text/javascript">
$(document).ready(function(){
	loadListPage('listingDiv',20,'tenderListForm');
})
function searchForList(){
		loadListPage('listingDiv',20,'tenderListForm')
}
</script>

<script type="text/javascript"> 
</script>
<%@include file="../../includes/footer.jsp"%>

</body>
</html>