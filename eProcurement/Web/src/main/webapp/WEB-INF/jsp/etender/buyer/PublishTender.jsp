<%@include file="../../includes/head.jsp"%>
<%@include file="../../includes/masterheader.jsp"%>
<script src="${pageContext.servletContext.contextPath}/resources/js/jQuery/jquery.datetimepicker.js"></script>
<jsp:useBean id="now" class="java.util.Date" />
	<script src="${pageContext.servletContext.contextPath}/resources/js/jquery-ui.min.js"></script>
	
<script src="${pageContext.servletContext.contextPath}/resources/js/bootstrap3-wysihtml5.all.min.js"></script>
<spring:message code="client_dateformate_hhmm" var="client_dateformate_hhmm"/>

<div id="viewTenderId"></div>

		<div class="row">
			<div class="col-xs-12">
				<div class="box">
					<div class="box-header with-border">
						<h3 class="box-title"><spring:message code="title_dates_conf"/></h3>
					</div>
					<div class="box-body">
						<div class="row">
						<div class="col-lg-12">
<c:if test="${not empty successMsg}">
    <div class="alert alert-success">${successMsg}</div>
</c:if>
<c:if test="${not empty errorMsg}">
    <div class="alert alert-danger">${errorMsg}</div>
</c:if>
</div>
							<c:set var="posturl" value="${pageContext.servletContext.contextPath}/etender/buyer/submitPublishtender" ></c:set>
<form id="tenderDtBean" name="tenderDtBean" onsubmit="return validation();" action="${posturl}" method="post" >
<div class="formfield">
    <table width="100%" cellpadding="0" cellspacing="0" border="0" class="formField">
        <tbody><tr>
            <td>
            
                <table width="100%" cellpadding="0" cellspacing="0" border="0" class="no-border">
                    <tbody>
                    <c:choose>
                    	<c:when test="${tblTender.isAuction ne 1}">
                    <tr>
                            <td width="50%" style="position:relative;"> 
                             <label><spring:message code="lbl_document_start_date" /><!-- <span> *</span> --></label>
                             <input id="txtDocumentStartDate" name="txtDocumentStartDate"  type="text"  
                              onblur="doChangeForDateValidation(this)" datepicker="yes" dtrequired="false" value="${documentStartDate}"
                              placeholder="${client_dateformate_hhmm}"  title="<spring:message code="lbl_document_start_date" />" 
                              class="dateBox pull-left form-control" datevalidate='gt:c,lt:txtSubmissionEndDate'>&nbsp;
                              </td>
                     <td width="50%" style="position:relative;"> 
                             <label><spring:message code="lbl_document_end_date" /><!-- <span> *</span> --></label>
                             <input id="txtDocumentEndDate" name="txtDocumentEndDate"  type="text"  
                             onblur="doChangeForDateValidation(this)" datepicker="yes" datevalidate='gt:c,gt:txtDocumentStartDate' dtrequired="true" placeholder="${client_dateformate_hhmm}" value="${documentEndDate}"
                             title="<spring:message code="lbl_document_end_date" />" class="dateBox pull-left form-control">&nbsp;
                             </td>
                     </tr>
             		 <tr>
                     <td width="50%" style="position:relative;"> 
                                 <label><spring:message code="lbl_bid_submission_start_date" /><!-- <span> *</span> --></label>
                                 <input id="txtSubmissionStartDate" name="txtSubmissionStartDate"  type="text"
                                  onblur="doChangeForDateValidation(this)" datepicker="yes" datevalidate='gt:c,lt:txtSubmissionEndDate' dtrequired="true"  placeholder="${client_dateformate_hhmm}" 
                                  title="<spring:message code="lbl_bid_submission_start_date" />" class="dateBox pull-left form-control" value="${submissionStartDate}">&nbsp;
                                  </td>
                         </tr>
                 <tr>
                     <td width="50%" style="position:relative;"> 
                         <label><spring:message code="lbl_bid_submission_end_date" /><!-- <span> *</span> --></label>
                         <input id="txtSubmissionEndDate" name="txtSubmissionEndDate" datepicker="yes" datevalidate='gt:c,lt:txtBidOpenDate' dtrequired="true" value="${submissionEndDate}" type="text"  
                         onblur="doChangeForDateValidation(this)" 
                         placeholder="${client_dateformate_hhmm}" title="<spring:message code="lbl_bid_submission_end_date" />" class="dateBox pull-left form-control"></td>
                     <td width="50%" style="position:relative;"> 
                         <label><spring:message code="field_bidopeningstartdate" /><!-- <span> *</span> --></label>
                         <input id="txtBidOpenDate" name="txtBidOpenDate"  type="text"  value="${openingDate}" onblur="doChangeForDateValidation(this)" datepicker="yes" datevalidate='gt:c,gt:txtSubmissionEndDate'  dtrequired="true"
                          placeholder="${client_dateformate_hhmm}" title="<spring:message code="field_bidopeningstartdate" />" class="dateBox pull-left form-control">
                          </td>
                 </tr>
				<c:if test="${tblTender.isPreBidMeeting eq 1}">
                 <tr id="trPreBidMeetingDate">
                     <td width="50%" style="position:relative;"> 
                         <label><spring:message code="fields_prebidmeet_startdate" /><!-- <span> *</span> --></label>
                         <input id="txtPreBidStartDate" name="txtPreBidStartDate" datepicker="yes" datevalidate='gt:c,lt:txtSubmissionEndDate,lt:txtPreBidEndDate' dtrequired="true"  type="text" onblur="validateEmptyDt(this)" value="${preBidStartDate}" datepicker="yes" placeholder="${client_dateformate_hhmm}" title="<spring:message code="fields_prebidmeet_startdate" />" 
                         class="form-control dateBox pull-left"></td>   
                     <td width="50%" style="position:relative;"> 
                         <label><spring:message code="fields_prebidmeet_enddate" /><!-- <span> *</span> --></label>
                         <input id="txtPreBidEndDate" name="txtPreBidEndDate"  
                         type="text" onblur="validateEmptyDt(this)" datepicker="yes" datevalidate="gt:txtPreBidStartDate,lt:txtSubmissionEndDate" dtrequired="true" placeholder="${client_dateformate_hhmm}" value="${preBidEndDate}"
                         title="<spring:message code="fields_prebidmeet_enddate" />" class="dateBox pull-left form-control">
                         </td>   
                 </tr>
                 </c:if>
                 </c:when>
                 <c:otherwise>
                 <tr>
                    <td width="50%" style="position:relative;"> 
                                 <label>Auction Start Date</label>
                                 <input id="txtAuctionStartDate" name="txtAuctionStartDate"  type="text"
                                  onblur="validateEmptyDt(this)" datepicker="yes" datevalidate='gt:c,lt:txtAuctionEndDate' dtrequired="true"  placeholder="${client_dateformate_hhmm}" 
                                  title="Auction Start Date and Time" class="dateBox pull-left form-control" value="${auctionStartDate}">&nbsp;
                     </td>
                     <td width="50%" style="position:relative;"> 
                         <label>Auction End Date</label>
                         <input id="txtAuctionEndDate" name="txtAuctionEndDate" datepicker="yes" datevalidate='gt:c,gt:txtAuctionStartDate' dtrequired="true" value="${auctionEndDate}" type="text"  
                         onblur="validateEmptyDt(this)" 
                         placeholder="${client_dateformate_hhmm}" title="Auction End Date and Time" class="dateBox pull-left form-control"></td>
				</tr>                         
                 </c:otherwise>
              </c:choose>
               <tr>
                 <td colspan="2">
               	   <textarea class="form-control" name="txtaRemarks" tovalid="true"  validarr="required@@length:0,1000" title="Remarks" cols="20" rows="10" id="rtfRemarks"></textarea>
               	 </td>
               	</tr>
               <tr><td>
               	<input type="hidden" name="tenderId" value="${tblTender.tenderId}">
                <c:if test="${tblTender.isAuction eq 1}">
                    <input type="submit" class="form-control" value="Approve">
                </c:if>
                <c:if test="${tblTender.isAuction eq 0}">
                    <input type="submit" class="form-control" value="Publish">
                </c:if>
               </td></tr>
                         </tbody></table>
                         </td>
                     </tr>
             </tbody></table>
	</div></form>
						</div>
					</div>
				</div>
			</div>
		</div>
		
<script type="text/javascript">
var isAuction = '${tblTender.isAuction}';
function loadViewTender(){
	$.ajax({
		url : "${pageContext.servletContext.contextPath}/etender/buyer/viewtender/${tblTender.tenderId}/1",
		success : function(data) {
			$("#viewTenderId").html(data);
		}
	});	
}

function loadViewAuction(){
	$.ajax({
		url : "${pageContext.servletContext.contextPath}/eBid/Bid/viewAuction/${tblTender.tenderId}/1",
		success : function(data) {
			$("#viewTenderId").html(data);
		}
	});	
}
$(document).ready(function(){
	$("#rtfRemarks").wysihtml5();
    if(parseInt(isAuction)==0)
    {
      loadViewTender();  
    }
	else{
      loadViewAuction();
    }
	var tenderDates = CLIENT_DATETIME;
	var tenderDates = convertDateStringFormate(tenderDates,"yyyy-mm-dd HH:mm",CLIENT_DATE_FORMATE);
	$(".dateBox").each(function(){
   		$(this).datetimepicker({
   		  format:'d-M-Y H:i',
   		  minDate:tenderDates,
   		  formatDate:'d-M-Y H:i',
   		  step: 15
   		});
   	});
	$(".content-wrapper").css("min-height","");
	
});
var dateFieldObject = new Object();
function doChangeForDateValidation(comp)
{
	var havingVal='';
	var size = 0;
	for(val in dateFieldObject)
		{
			size++;
		}
	
	$(".dateBox").each(function(){
		var attr = $(this).attr("dtrequired");
		if(attr != null && attr != undefined && attr != '')
		{
			if(dateFieldObject[$(this).attr("id")] == undefined)
			{
					dateFieldObject[$(this).attr("id")] = $(this).attr("datevalidate");	
			}
			$(this).attr("onblur","doChangeForDateValidation(this)"); // Change data validation function.
			if($(this).val() != '' && havingVal == '')
				{
					havingVal = true;
				}
		}
	  });
	
	if(havingVal != true){							// If valud not found for any date, remove all date validation.
		for(obj in dateFieldObject){
			var compId = obj;
			$(".err"+compId).remove();	
			$("#"+compId).attr("dtrequired","false");
			$("#"+compId).removeAttr("datevalidate");
		}
	}
	if((comp != undefined && $(comp).val() != '') || havingVal == true){		// If function call using onblur or date box having value then do validation.
		for(obj in dateFieldObject)
		{
			if(obj == 'txtPreBidStartDate')
			{
				<c:if test="${tblTender.isPreBidMeeting eq 1}">
					$("#"+obj).attr("datevalidate",dateFieldObject[obj]);		
					$("#"+obj).attr("dtrequired","true");
				</c:if>
			}else if(obj == 'txtPreBidEndDate')
			{
				<c:if test="${tblTender.isPreBidMeeting eq 1}">
					$("#"+obj).attr("datevalidate",dateFieldObject[obj]);
					$("#"+obj).attr("dtrequired","true");
				</c:if>
			} else if(obj == 'txtQuestionAnswerStartDate')
			{
				<c:if test="${tblTender.isQuestionAnswer eq 1}">
					$("#"+obj).attr("datevalidate",dateFieldObject[obj]);
					$("#"+obj).attr("dtrequired",true);
				</c:if>
			} else if(obj == 'txtQuestionAnswerEndDate')
			{
				<c:if test="${tblTender.isQuestionAnswer eq 1}">
					$("#"+obj).attr("datevalidate",dateFieldObject[obj]);
					$("#"+obj).attr("dtrequired","true");
				</c:if>
			} else
			{
				$("#"+obj).attr("datevalidate",dateFieldObject[obj]);
				$("#"+obj).attr("dtrequired","true");
			}
		}
		if(comp != undefined && comp != ''){
			validateEmptyDt($(comp));
		}
	} else{																		// Else remove error message
		for(obj in dateFieldObject){
			var compId = obj;
			$(".err"+compId).remove();	
		}
	}
}
function validation(){
	var vbool = valOnSubmit();
	return disableBtn(vbool);
}
</script>
 <style>
  .black{
  	color: black;
  	font-style: oblique;
  }
  
  </style>
  <%@include file="../../includes/footer.jsp"%>