<%@include file="../../includes/head.jsp"%>
<%@include file="../../includes/masterheader.jsp"%>
<div class="content-wrapper">
<section class="content-header">
<h1><spring:message code="lbl_add_weightage"/><small></small></h1>
</section>
<section class="content">
                <div class="row">
                    <div class="col-lg-12 col-md-12">
                        <div class="box">
                            <div class="box-header with-border">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="col-md-6 pull-left">
                                           <spring:message code="lbl_add_weightage"/>
                                        </div>
                                        <div class="col-md-6 text-right">
                                           <a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}" class="btn btn-submit" style="margin-top:0px;"><< <spring:message code="lbl_go_back_to_dashboard" />


                                            </a>
                                         </div>
                                    </div>
                             </div>
						</div>
						<spring:message code="lbl_weightage" var="lbl_weightage"/>
						<div class="box-body">
							<div class="row">
									
									<div class="col-xs-12">
										* Total should not greater then 100.
									</div>
																								
                                 <form action="${pageContext.servletContext.contextPath}/eBid/Bid/saveFormWeight/${tenderId}" onsubmit="return validation();">
                                    <c:choose>
                                    
                                    <c:when test="${not empty formList}">
                                    
                                    	<div class="col-xs-12">
                                    	<table class="table table-bordered">
										<thead>
											<tr>
												<th><spring:message code="th_srno"/></th>
												<th><spring:message code="lbl_envelopname"/></th>
												<th><spring:message code="field_formName"/></th>
												<th>${lbl_weightage}</th>
											</tr>
										</thead>
										<tbody>
										<c:forEach items="${formList}" var="forms" varStatus="indx">                                  	
											<tr>
											<td>${(indx.index+1)}</td>
											<td>${forms[4]}</td>
											<td>${forms[1]}</td>
											<td>
											<input type="hidden" name="formId" value="${forms[0]}">
                                    		<input type="text" maxlength="5" class="txtWeightage" size="5" value="${forms[5]}" name="txtWeightage" id="txtWeightage${indx.index}" validarr="required@@length:0,5@@numanduptodecimal:1@@nonzero" tovalid="true" onblur="if(validateTextComponent(this)){doTotalForBox()}" title='${lbl_weightage}' /></td>
											</tr>
										</c:forEach>
											<tr>
											<td colspan="3"></td>
											<td>
											Total
											<div id="totalWeight"></div>
											<div class="divForError"></div>
											</td>
											</tr>
											<tr>
											<td colspan="4">
											<input type="submit" class="form-control" value="Save">
											</td>
											</tr>
										</tbody>
									</table>
                                    </div>
                                    </c:when>
                                    
                                    <c:otherwise>
                                    	<div class="col-xs-12">No Record Found.</div>
                                    </c:otherwise>
                                    
                                    </c:choose>
                                 </form>
                            </div>
						</div>
					</div>
				</div>
            </div>
            </section>
    </div>
<script type="text/javascript">
	doTotalForBox();
	function doTotalForBox(){
		var total = 0;
		$(".txtWeightage").each(function(){
			var val = $(this).val();
			if(val != "" && val > 0){
				total +=parseFloat(val);
			}
		});
		if(total > 100){
			//alert("Total can not be greater then 100.");
			$("#totalWeight").addClass("red");
		}else{
			$("#totalWeight").removeClass("red");
		}
		$("#totalWeight").html(total);	
	}
	function validation(){
		var vbool=true;
	    vbool=valOnSubmit();
	    if(vbool){
	    	var total = $("#totalWeight").html();
	    	$(".errtotalDiv").remove();
	    	if(total != 100){
	    		var div = $('<div class="errtotalDiv validationMsg clearfix">Total should be 100 only.</div>');
	    		$(".divForError").append(div);
	    		vbool = false;
	    	}else{
	    		$(".errtotalDiv").remove();
	    	}
	    }
	    return vbool;
	}
</script>

<style type="text/css">
.red{color: red;}
</style>
<%@include file="../../includes/footer.jsp"%>
