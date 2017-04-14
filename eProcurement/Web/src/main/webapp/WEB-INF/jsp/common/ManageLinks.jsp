<%@include file="./../includes/head.jsp"%>
       <%@include file="./../includes/masterheader.jsp"%>

 <div class="content-wrapper">       
<section class="content-header">
			<h1>
				${lbl_manage_link}
			</h1>
</section>

<section class="content">
<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="box">
						<div class="box-header with-border">
	               					<spring:message code="lbl_edit_dept" var="editdepartment"/>
	               						<h3 class="box-title">Mange Links</h3>											
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
loadListPage('listingDiv',9);
function callActionItem(cthis){
	var actionname = $(cthis).attr("actionname");
	if(actionname.toLowerCase() == "edit"){
		var linkId = $(cthis).closest("tr").find('td:nth-child(3)').html()
		window.location = "${pageContext.servletContext.contextPath}/common/user/geteditlink/"+linkId;
	}
	
}
</script>

        <script type="text/javascript">
            $(document).ready(function() {
            
        	});
           </script>
  <%@include file="./../includes/footer.jsp"%>