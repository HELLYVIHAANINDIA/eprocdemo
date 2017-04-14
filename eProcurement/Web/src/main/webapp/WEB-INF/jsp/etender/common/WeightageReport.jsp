<%@include file="../../includes/head.jsp"%>
<%@include file="../../includes/masterheader.jsp"%>
<spring:message code="lbl_weightage_report" var="var_title"/>

<div class="content-wrapper">
	<section class="content">
		<div class="row">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			<div class="box" id="weightageRptId">
                <spring:message code="lbl_back_dashboard" var='backDashboard'/>
				<div class="box-header with-border">
				<span class="noExport pull-right">
                        <c:choose>
                        <c:when test="${userTypeId eq 2}">
                             <a href="${pageContext.servletContext.contextPath}/etender/bidder/biddingtenderdashboardcontent/${tenderId}/7/2"><< ${backDashboard}</a>
                        </c:when>
                        <c:otherwise>
                            <div>
                            <a href="${pageContext.servletContext.contextPath}/etender/buyer/gettabcontent/${tenderId}/2"><< <spring:message code="link_goback_tenderdashbord"/></a>
                            <a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}"><< ${backDashboard}</a></div>
                        </c:otherwise>
                        </c:choose>
                </span>
                <c:choose>
	                <c:when test="${envelopeId eq 0}">
	                	<h2 class="box-title"><spring:message code="lbl_all_env_weightage"/> </h2>
	                </c:when>
	                <c:otherwise>
	                	<h2 class="box-title">${var_title} For ${envelopeName}</h2>
	                </c:otherwise>
                </c:choose>
				</div>
<div class="box-body">
		<div class="row">
			<div class="col-lg-12 col-md-12 col-xs-12">
				<div class="box-body pad">
				
		             <c:if test="${envelopeId ne 0}">
		              	<label>Remarks:</label>
		              	<div>${weightageRemarks}</div>
		             </c:if>
                       <div class="clearfix border-bottom-none o-auto" id="scrolldata">
                         <table class="table">
                            <tr>
                                <td class="no-padding">
									<table class="table table-bordered">
								<thead>
									<tr class="firstTr">
										<th>Criteria</th>
										<th>Weight</th>
									<c:forEach items="${formNameMap}" var="form" varStatus="indx">
										<c:if test="${indx.count eq 1}">
										<c:set value="0" var="bidderCount"></c:set>
										 <c:forEach items="${bidderResultMap[form.key]}" var="obCompany" varStatus="srno">
										 <input type="hidden" name="companyId" class="companyId" value="${obCompany[4]}">
										 <c:set value="${bidderCount +1}" var="bidderCount"></c:set> 
										 <c:choose>
										 <c:when test="${isBidderRejected[obCompany[5]] eq true}">
										 	<th class="red">${obCompany[6]} score ${isBidderRejected[obCompany[5]] eq true ? '(Not Eligible)' : '' }</th>
											<th class="red">${obCompany[6]} calculated</th>
										 </c:when>
										 <c:otherwise>
										 <th>${obCompany[6]} score</th>
											<th>${obCompany[6]} calculated</th>
										 </c:otherwise>
										 </c:choose>
	                                    </c:forEach>
	                                    </c:if>
	                                 </c:forEach>
                                    </tr>
                                  </thead>
                                  <tbody>
<%--                                     DISTINCT TB.bidId,TB.tenderId,TB.envelopeId,TB.formId,TB.companyid, : 5
                                    TB.bidderId,UD.companyname,TB.formBidWeight,TF.formName,TF.formWeight : 10 --%>
                                    <c:set value="0" var="formCount"></c:set>
                                    <c:forEach items="${formNameMap}" var="form">
                                    <c:set value="${formCount+1}" var="formCount"></c:set>
                                    <tr class="mainRow">
                                    	<td>${form.value[0]}</td>
                                    	<td class="tdWeight">${form.value[1]}</td>
                                    	<c:set value="0" var="trcount"></c:set>
										 <c:forEach items="${bidderResultMap[form.key]}" var="obCompany" varStatus="srno">
										 <c:set value="${trcount +1}" var="trcount"></c:set>
											<td class="bidderCol${srno.count}">${obCompany[7] eq -1 ? 0 : obCompany[7]} <!-- -1 use for rejected bidder  -->
											</td>
											<td class="calulatedCol${srno.count}"><fmt:parseNumber var="weight" type="number" value="${form.value[1]}" />
											<fmt:parseNumber var="score" type="number" value="${obCompany[7] eq -1 ? 0 : obCompany[7]}" />
											<c:set var="calculatedVal" value="${(weight * score)/100}"/>
											<fmt:formatNumber type="number" value="${calculatedVal}"  maxFractionDigits="2" />
											</td>
	                                    </c:forEach>
                                    </tr>
                                    </c:forEach>
                                    <tr class="sumRow table border">
                                    	<td>Sum</td><td class="weightTotal"></td>
                                    </tr>
                                    <tr class="normalisedRow table border">
                                    	<td>Normalised</td><td>&nbsp;</td>
                                    </tr>
                                    <tr class="sumWeightedRow table border">
                                    	<td>Weighted</td><td>&nbsp;</td>
                                    </tr>
                                    </tbody>
                                    </table>
                                </td>
                            </tr>
                        </table>
                       </div>
                    </div>   
                 </div>
                </div>
                <div>
					<input type="button" class="btn noExport" onclick="exportContent('weightageRptId','Weightage Report',0)" value="PDF">
					<input type="button" class="btn noExport" onclick="exportContent('weightageRptId','Weightage Report',5)" value="Print">
				</div>
</div>
</div>
</div>
</div>
                </section>   
            </div>

<script>
$(document).ready(function(){
	var tdCount = $(".mainRow:first").find("td").size();
	for(var i = 2; i < tdCount; i++){
		$(".sumRow").append("<td class='sumTotal'></td>");
		$(".normalisedRow").append("<td class='normalisedTotal'></td>");
		$(".sumWeightedRow").append("<td class='sumWeightedTotal'></td>");
	}
	
	calculateWeightSum();
	<c:if test="${isWeightageDataSaveReq eq true}">
		saveWeightageReport();
	</c:if>
});
function calculateWeightSum(){
	var weightSum = 0; // calculate sum.
	$(".tdWeight").each(function(){
		if($(this).html() != ""){
			weightSum +=parseFloat($(this).html());
		}
	});
	$(".sumRow:first").find(".weightTotal").html(weightSum);
	var calCol = new Object();
	var heights = 0;
	for(var i = 0; i < ${bidderCount}; i++){
		var colIndex = 0;
		weightSum = 0;
		$(".bidderCol"+(i+1)).each(function(){
			if($(this).html() != ""){
				weightSum +=parseFloat($(this).html());
				colIndex = $(this).parent().children().index($(this));
			}
			$(".sumRow:first").find("td").eq(colIndex).html(weightSum.toFixed(2));
		});
		weightSum = 0;
		$(".calulatedCol"+(i+1)).each(function(){
			if($(this).html() != ""){
				weightSum +=parseFloat($(this).html());
				colIndex = $(this).parent().children().index($(this));
			}
			if(weightSum )
			$(".sumRow:first").find("td").eq(colIndex).html(weightSum.toFixed(2));
			if(heights < weightSum){
				heights = weightSum;
			}
			calCol[colIndex] = weightSum;
		});
		
	}
	var newCol = new Object();
	for (data in calCol){
		var weight = (calCol[data]*10/heights).toFixed(2);
		$(".normalisedRow:first").find("td").eq(data).html(weight);
		console.log(data,"normalisedRow",weight);
		var weightTotal = parseFloat($(".weightTotal").html());
		var weightedSum = ((weightTotal * weight)/100);
		$(".sumWeightedRow:first").find("td").eq(data).html(weightedSum.toFixed(2));
		var hidden = $("<input>",{type:'hidden',name:'weightage','class':"weightage" ,value:weightedSum.toFixed(2)});
		$(".sumWeightedRow:first").find("td").eq(data).append(hidden);
	}
}
<c:if test="${isWeightageDataSaveReq eq true}">

function saveWeightageReport(){
	var companyId="";
	var weightage="";
	$(".weightage").each(function(indx){
		if($(this).val() != undefined){
			weightage += $(this).val()+",";
		}
	});
	$(".companyId").each(function(indx){
		if($(this).val() != undefined){
			companyId += $(this).val() +",";
		}
	});
	$.ajax({
		type : "POST",
		url : "${pageContext.servletContext.contextPath}/etender/buyer/saveWeightageData/${tenderId}",
		data :{
				weightage : weightage,
				companyId : companyId
			},
		success : function(data) {
		},
		error : function(e) {
			$("#infoHading").hide();
		},
	});
}
</c:if>
</script>
<%@include file="../../includes/footer.jsp"%>