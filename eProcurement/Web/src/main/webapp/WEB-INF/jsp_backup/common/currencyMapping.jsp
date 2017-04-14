<%@include file="./../includes/head.jsp"%>
<%@include file="./../includes/masterheader.jsp"%>
        
<spring:message code="lbl_currency_mapping" var="lbl_currency_mapping"/>

<div class="content-wrapper">

	<section class="content-header">
		<h1>
			<spring:message code="lbl_currency_mapping" />
			: ${departmentMap[departmentId]}
		</h1>
	</section>

	<section class="content">
		<div class="row">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="box">

					<c:if test="${not empty successMsg}">
						<div class="alert alert-success">
							<spring:message code="${successMsg}" />
						</div>
					</c:if>
					<c:if test="${not empty errorMsg}">
						<div class="alert alert-danger">
							<spring:message code="${errorMsg}" />
						</div>
					</c:if>


					<spring:url value="/common/user/updateCurrencyMapping" var="submitDept" />

						<form:form action="${submitDept}" onsubmit="return validate();" name="frmdepartment" method="post" modelAttribute="tblDepartment">

							<div class="box-header with-border">
								<h3 class="box-title"> <spring:message code="label_bidding_currency" />:</h3>
							</div>


							<div class="box-body">

								<div class="row">
									<c:forEach items="${currencyList}" var="currency" varStatus="indx">
										<c:set var="selected" value="" />
										<c:if test="${not empty tblCurrencyMapList && tblCurrencyMapList[currency[0]] eq currency[0]}">
											<c:set var="selected" value="checked='checked'" />
										</c:if>
										<div class="col-lg-3">
											<input type="checkbox" name="selCurrencyId" id="selCurrencyId_${indx.index}" ${selected} value="${currency[0]}" class="cr-box">
											<label class="cr-lbl" for="selCurrencyId_${indx.index}">${currency[1]}</label>
										</div>
									</c:forEach>
									<input type="hidden" name="departmentId" value="${departmentId}">
								</div>

								<div class="row">									
									<div class="col-lg-5">
										<button type="submit" id="addDept" class="btn btn-submit">Submit</button>
									</div>
								</div>

							</div>

						</form:form>					

				</div>
			</div>

		</div>

	</section>

</div>

<script type="text/javascript">
	$(document).ready(function() {
		$("#selCurrencyId").select2();
	});

	function validate() {
		if ($("[name='selCurrencyId']:checked").size() > 0) {
			vbool = true;
		} else {
			vbool = false;
			alert("Please select atleast one currency");
		}
		return disableBtn(vbool);
	}
</Script>
<%@include file="./../includes/footer.jsp"%>
