<%@include file="../../includes/head.jsp"%>
<%@include file="../../includes/masterheader.jsp"%>
     	

<spring:message code="lbl_back_dashboard" var='backDashboard'/>
<spring:message code="link_goback_tenderdashbord" var='goBack'/>

<div class="content-wrapper">

	<section class="content">
		<div class="row">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			<div class="box">
				<div class="box-header with-border">
					<div class="pull-right">
						<a href="${pageContext.servletContext.contextPath}/etender/buyer/gettabcontent/${tenderId}/${committeeType}"><< ${goBack}</a>
						<a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}"><< ${backDashboard}</a>
					</div>
					<h3 class="box-title">
						<c:choose>
							<c:when test="${committeeType eq 1}">
								<spring:message code="lable_opening_consent"/> for ${envelopeName}
							</c:when>
							<c:otherwise>
								<spring:message code="lable_evaluation_consent"/> for ${envelopeName}
							</c:otherwise>
						</c:choose>
					</h3>
				</div>
				<div class="box-body">
					<div class="row">
						<div class="col-lg-12 col-md-12 col-xs-12">
						<spring:url value="/etender/buyer/addusercommitteeremarks" var="postUrl"/>
						<form:form action="${postUrl}" onsubmit="return validate();" name="frmConsent" method="post">
							<div class="box-body pad">
							
								<table  class="table table-striped table-responsive">
									
									<spring:message var="remarks" code="lbl_remark"/>
									<tr>
                                  		<td>
                                      		<label>${remarks}<span class="red"> *</span> </label>
                                      		<textarea  class="form-control"  id="txtaRemarks" name="txtaRemarks" validarr="required@@length:0,10000" tovalid="true" onblur="validateTextComponent(this)" validationmsg="Allows Max. 10000 alphabets, numbers and special characters" title="Remarks" class="line-height" cols="20" rows="10"></textarea>
                                      	</td>
                             		 </tr>
								</table>
							</div>
							<div>
								<input type="hidden" name="hdTenderId" value="${tenderId}"/>
								<input type="hidden" name="hdEnvelopeId" value="${envelopeId}"/>
								<input type="hidden" name="hdCommitteeId" value="${committeeId}"/>
								<input type="hidden" name="hdCommitteeUserId" value="${committeeUserId}"/>
								<input type="hidden" name="hdMinOpeningMember" value="${minOpeningMember}"/>
								<input type="hidden" name="hdCommitteeType" value="${committeeType}"/>
								<button type="submit"  class="btn btn-submit">Submit</button>
							</div>
							</form:form>
						</div>
					</div>
				</div>
			</div>
		</div>
		</div>
	</section>
	</div>
<script type="text/javascript">
	function validate(){
         	var vbool = valOnSubmit();
         	return disableBtn(vbool);
	return true;
    }
   </script>    
   <%@include file="../../includes/footer.jsp"%>
