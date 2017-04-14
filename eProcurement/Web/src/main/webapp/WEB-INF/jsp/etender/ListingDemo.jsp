<%@include file="../includes/head.jsp"%>
<%@include file="../includes/masterheader.jsp"%>

		<div class="content-wrapper" style="height: auto;">

			<section class="content-header">
				<h1></h1>
			</section>

			<section class="content">
				<div class="row">
					<div class="col-sm-12 col-md-12 affix-content">
						<div class="box">
							<div class="box-header with-border">
								<h3 class="box-title"></h3>
							</div>
							<div class="box-body">
								<div class="row">
									<div class="col-xs-12">
										<form id="form2"></form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>

		</div>

	<script>
		$(document).ready(function() {
			loadListPage("form2", '${listingId}');
		});
	</script>
<%@include file="../includes/footer.jsp"%>
