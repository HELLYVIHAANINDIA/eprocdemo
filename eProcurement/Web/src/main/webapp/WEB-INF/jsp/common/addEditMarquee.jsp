<%@include file="../includes/head.jsp"%>
<%@include file="../includes/masterheader.jsp"%>
		<spring:message code="lbl_add_edit_marquee" var="lbl_add_edit_marquee"></spring:message>
		<spring:message code="lbl_add_edit_biddermsg"
			var="lbl_add_edit_biddermsg"></spring:message>
		<spring:message code="client_dateformate_hhmm"
			var="client_dateformate_hhmm" />

		<div class="content-wrapper" style="height: auto;">
			<c:if test="${not empty successMsg}">
				<div class="alert alert-success">${successMsg}</div>
			</c:if>
			<c:if test="${not empty errorMsg}">
				<div class="alert alert-error">${errorMsg}</div>
			</c:if>

			<section class="content-header">
				<h1>Administration</h1>
			</section>

			<section class="content">
				<div class="row">
					<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">									                          	
								<div class="box">
									<div class="box-header with-border">
										<h3 class="box-title">
											<c:choose>
												<c:when test="${tenderId eq 0}">
													${lbl_add_edit_marquee}
												</c:when>
												<c:otherwise>
													${lbl_add_edit_biddermsg}	
													<a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}"
														class="goBack">
														<< <spring:message code="lbl_back_dashboard" />
														</a>
												</c:otherwise>
											</c:choose>
										</h3>
									</div>
									<div class="box-body">											
										<input type="hidden" name="clientDateFormate" id="clientDateFormate" value='<spring:message code="client_dateformate_hhmm" />'>
										<spring:url value="/common/submitMarquee" var="submitMarquee" />
										<form:form action="${submitMarquee}" onsubmit="return validate();" name="frmdepartment" method="post">
											<input type="hidden" name="tenderId" id="tenderId" value='${tenderId}'>												
											<div class="row">
												<div class="col-md-6">
												
                                                          <div class="fr-grp">
                                                              <label class="lblfr-fields"><spring:message code="label_start_date" /></label>
														<input type="text" class="form-control fr-cntrl dateBox"
															name="startDate" datepicker="yes" id="txtstartDate"
															datevalidate="lt:txtendDate"
															placeholder="${client_dateformate_hhmm}" dtrequired="true"
															title="<spring:message code="label_start_date"/>"
															onblur="validateEmptyDt(this)" value="${startDate}">
														  </div>
														  
														  <div class="fr-grp">
                                                              <label class="lblfr-fields"><spring:message code="label_end_date" /></label>															
														<input type="text" class="form-control fr-cntrl dateBox"
															name="endDate" datepicker="yes" id="txtendDate"
															datevalidate="gt:txtstartDate"
															placeholder="${client_dateformate_hhmm}" dtrequired="true"
															title="<spring:message code="label_end_date"/>"
															onblur="validateEmptyDt(this)" value="${endDate}">
														</div>
														
														<div class="fr-grp">
                                                        <label class="lblfr-fields"><spring:message code="label_marquee_detail" /></label>														
														<textarea class="form-control fr-cntrl" name="txtaMarquee"
														tovalid="true" validarr="required@@length:0,1000"
														title="<spring:message code="label_marquee_detail"/>"
														cols="20" rows="10" id="rtfMarquee">${tblMarquee.marqueeText}</textarea>
														</div>
														
														<div class="fr-grp">
														<input type="hidden" name="marqueeId" id="marqueeId" value="${empty tblMarquee.marqueeId ? 0 : tblMarquee.marqueeId }">
														<input type="submit" class="btn  btn-submit" value="Save"> 
														<input type="button" class="btn  btn-cancel" value="Clear"  onclick="clearDetail()"> 
														<input type="button" class="btn  btn-cancel" value="Delete" onclick="deleteDetail()">
														</div>
													
												</div>	
												
												
												
											</div>											
																				
																						
										</form:form>
										
										<div class="row">
										<div class="col-lg-12 col-md-12 col-xs-12">
													<div id="listingDiv"></div>
												</div>
											</div>
										
									</div>
								</div>
														
					</div>
				</div>	
			</section>
		</div>
	<script>
		function validate() {
			var vbool = valOnSubmit();
			return disableBtn(vbool);
		}
		$(".dateBox").each(function() {
			$(this).datetimepicker({
				format : 'd-M-Y H:i',
			});
		});
		function clearDetail() {
			$("#txtstartDate").val("");
			$("#txtendDate").val("");
			$("#rtfMarquee").html("");
			$('iframe').contents().find('.wysihtml5-editor').html("");
			$("#marqueeId").val(0);
		}
		function deleteDetail() {
			if (confirm("Are you sure you want to delete this ?")) {
				$
						.ajax({
							type : "GET",
							url : "${pageContext.servletContext.contextPath}/common/removeMarquee/"
									+ $("#marqueeId").val(),
							success : function(data) {
								clearDetail()
							},
							error : function(e) {
								console.log("ERROR: ", e);
							},
						});
			}
		}
		/* if($("#txtstartDate").val() != ""){
		 $("#txtstartDate").val(convertDateToClientFormat1($("#txtstartDate").val(),$("#clientDateFormate").val()))
		 $("#txtendDate").val(convertDateToClientFormat1($("#txtendDate").val(),$("#clientDateFormate").val()));
		 }
		 function convertDateToClientFormat1(tdVal,toDateFormate){
		 if(tdVal != undefined && tdVal != "" && toDateFormate == "dd-MMM-yyyy HH:mm"){
		 var dateTd = new Date(tdVal);
		 var hour = ('0'+dateTd.getHours()).slice(-2);
		 var mins = ('0'+dateTd.getMinutes()).slice(-2);
		 return  dateTd.getDate()+ '-' + (dateTd.getMonth() + 1) + '-' +  dateTd.getFullYear()+' '+hour+':'+mins;
		 }
		 } */
		$("#rtfMarquee").wysihtml5();
	</script>
<%@include file="../includes/footer.jsp"%>