<%@include file="../../includes/head.jsp"%>
<%@include file="../../includes/masterheader.jsp"%>

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
                            <div><a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}"><< ${backDashboard}</a> |
                            <a href="${pageContext.servletContext.contextPath}/etender/buyer/gettabcontent/${tenderId}/2"><< <spring:message code="link_goback_tenderdashbord"/></a></div>                                                
                        </c:otherwise>
                        </c:choose>
                </span>
                	<h2 class="box-title"><spring:message code="lbl_weightage_combine_l1h1"/> </h2>
				</div>
<div class="box-body">
		<div class="row">
			<div class="col-lg-12 col-md-12 col-xs-12">
				<div class="box-body pad">
                       <div class="clearfix border-bottom-none o-auto" id="scrolldata">
                         <table class="table">
                            <tr>
                                <td class="no-padding">
									<table class="table table-bordered">
								<thead>
									<tr class="firstTr">
										<th>Bidder</th>
										<th>Weightage Status</th>
										<th>L1H1 Status</th>
	                                </tr>
                                  </thead>
                                  <tbody>
                                  <c:forEach items="${companyL1H1}" var="companyL1H1" varStatus="indx">
                                  	<tr>
                                  		<td>${companyL1H1.key}</td>
                                  		<td>${companyWeightage[companyL1H1.key]}</td>
                                  		<td>${companyL1H1.value}</td>
                                  	</tr>  
                                  	</c:forEach>
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
<%@include file="../../includes/footer.jsp"%>