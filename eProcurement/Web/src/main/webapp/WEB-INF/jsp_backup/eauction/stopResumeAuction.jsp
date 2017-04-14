<!DOCTYPE html>
<html>
<%@page import="com.eprocurement.etender.model.TblTender"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<%@include file="../includes/header.jsp"%>
<script src="${pageContext.request.contextPath}/resources/js/tender/tendercreate.js"></script>
<script src="${pageContext.servletContext.contextPath}/resources/js/jQuery/jquery.datetimepicker.js"></script>
<script src="${pageContext.servletContext.contextPath}/resources/js/blockUI.js" type="text/javascript"></script>
<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/resources/css/jquery.datetimepicker.css">
<script src="${pageContext.servletContext.contextPath}/resources/js/jquery-ui.min.js"></script>
</head>

<body class="skin-blue sidebar-mini">
	<div class="wrapper">
		<%@include file="../includes/leftaccordion.jsp"%>

		<div class="content-wrapper">

			<section class="content-header">
				<a
					href="${pageContext.servletContext.contextPath}/eBid/Bid/auctionListing"
					class="btn btn-submit"><< Go To Auction List</a>
				<h1 style="margin-top: 10px;">
					Stop / Resume Auction Form <small></small>
				</h1>
			</section>

			<section class="content">

				<%@include file="../etender/buyer/AuctionSummary.jsp"%>

				<div class="row">
					<div class="col-md-12">
						<div class="box">

							<div class="box-header with-border">
								<h3 class="box-title">Stop Auction</h3>
								<a
									href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}"
									class="btn btn-submit" style="float: right; margin-top: 0px;"><<
									Go Back To DashBord</a>
							</div>

							<form action="/eProcurement/eBid/Bid/stopResumeAuction"
								method="get">
								<div class="box-body">
									<div class="row">
										<div class="col-lg-12 col-md-12 col-xs-12">

											<div class="row">
												<div class="col-lg-2">
													<div class="form_filed">Remark:</div>
												</div>
												<div class="col-lg-10">
													<textArea rows="10" cols="50" class="form-control"
														id="auctionstopremark" name="auctionstopremark"></textArea>
												</div>

											</div>

											<div class="row">
												<input type="hidden" name="tendreId" value="${tenderId}">
												<%
                                                    TblTender tblTender=(TblTender)request.getAttribute("tblTender");
                                                    %>
												<%
                                                                String str=tblTender.getAuctionStartDate()+"";
                                                                String[] arr=str.split("\\.");
                                                                String[] arr2=arr[0].split(":");
                                                                %>
												<input type="hidden" name="auctionStartDate"
													value="<%=arr2[0]+":"+arr2[1]%>">
												<%
                                                                 str=tblTender.getAuctionEndDate()+"";
                                                                arr=str.split("\\.");
                                                                arr2=arr[0].split(":");
                                                                 %>
												<input type="hidden" name="auctionEndDate"
													value="<%=arr2[0]+":"+arr2[1]%>"> <input
													type="hidden" name="isAuctionStop"
													value="${tblTender.isAuctionStop}"> <br>
												<div class="col-lg-12 text-center">
													<c:if test="${tblTender.isAuctionStop eq 1}">
														<div class="row">
															<div class="col-lg-2">
																<div class="form_filed">Auction Start Date :</div>
															</div>
															<div class="col-lg-4">
																<input id="txtAuctionStartDate"
																	name="txtAuctionStartDate" type="text" datepicker="yes"
																	dtrequired="false" placeholder="DD/MM/YYYY HH:MM"
																	class="dateBox pull-left form-control">

															</div>
															<div class="col-lg-2">
																<div class="form_filed">Auction End Date :</div>
															</div>
															<div class="col-lg-4">
																<input id="txtDocumentEndDate" name="txtAuctionEndDate"
																	type="text" datepicker="yes" dtrequired="false"
																	placeholder="DD/MM/YYYY HH:MM"
																	class="dateBox pull-left form-control">

															</div>
														</div>
														<button type="submit" class="btn btn-submit"
															id="btnSubmitForm">Resume Auction</button>
													</c:if>
													<c:if test="${tblTender.isAuctionStop eq 0}">
														<button type="submit" class="btn btn-submit"
															id="btnSubmitForm">Stop Auction</button>
													</c:if>

												</div>


											</div>
										</div>
									</div>
								</div>
							</form>

						</div>
					</div>
				</div>

			</section>

		</div>

		<%@include file="../includes/footer.jsp"%>

	</div>

	<script>
            $(function(){
                $(".dateBox").each(function(){
		    $(this).datetimepicker({
		       format:'d/m/Y H:i'
		    });
		});
            });
        </script>

</body>

</html>