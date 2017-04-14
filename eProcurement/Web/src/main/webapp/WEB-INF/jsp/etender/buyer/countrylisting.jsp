<%@include file="../../includes/head.jsp"%>
<%@include file="../../includes/masterheader.jsp"%>

<div class="content-wrapper">
<div class="box-body">
<div class="row">
	<form id="countryForm">
		<table class="table table-striped table-responsive">
			<tr>
				<td>Country</td>
				<td>
					<select id="countries" name="countryId" onchange="getStates()">
						<option id="0" value="0">Select Country</option>
						<c:forEach var="country" items="${dataContry}">
							<c:if test="${param.countryId==country.value.pk}">
								<option id="${country.key}" value="${country.value.pk}" selected="selected">${country.value.countryName}</option>
							</c:if>	
							<c:if test="${param.countryId!=country.value.pk}">
								<option id="${country.key}" value="${country.value.pk}">${country.value.countryName}</option>
							</c:if>			
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td>State</td>
				<td>
					<select id="states" name="stateId" onchange="getCities()">
						<option id="0" value="0">Select State</option>
						<c:forEach var="state" items="${states}">
							<c:if test="${param.stateId==state.value.pk}">
								<option id="${state.key}" value="${state.value.pk}" selected="slected">${state.value.stateName}</option>
							</c:if>
							<c:if test="${param.stateId!=state.value.pk}">
								<option id="${state.key}" value="${state.value.pk}">${state.value.stateName}</option>
							</c:if>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td>City </td>
				<td>
					<select id="cities">
						<option id="0" value="0">Select City</option>
						<c:forEach var="city" items="${cities}">
							<option id="${city.key}" value="${city.value.pk}">${city.value.cityName}</option>
						</c:forEach>
					</select>	
				</td>
			</tr>
		</table>
	</form>
	</div>
	</div>
	</div>
<script type="text/javascript">
	function getStates() {
 		$('#countryForm').attr('action', '${pageContext.servletContext.contextPath}/etender/buyer/getState');
		$( "#countryForm" ).submit();
	}
	function getCities() {
		$('#countryForm').attr('action', '${pageContext.servletContext.contextPath}/etender/buyer/getCity');
		$( "#countryForm" ).submit();
	}
</script>
<%@include file="../../includes/footer.jsp"%>