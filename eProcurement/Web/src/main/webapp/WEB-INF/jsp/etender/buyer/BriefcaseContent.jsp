<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<spring:url value="/etender/bidder/mapdocuments" var="postUrl" />
<spring:message code="fields_docbrief" var="docBrief" />
<spring:message code="header_searchdocument" var="searchDocument" />
<script type="text/javascript">
var documentCheckListObj = (${documentCheckList});
$('#selDocCheckList').html('');
$('#selDocCheckList').append($('<option>',
{
		    value: "0",
		    text : "please select"
		}));
$.each(documentCheckListObj, function (key, value) {
$('#selDocCheckList').append($('<option>',
	{
	    value: value.value,
	    text : value.label
	}));
 });
</script>
<input type="hidden" id="txtChildId" name="txtChildId"
	value="${childId}" />
<input type="hidden" id="txtSubChildId" name="txtSubChildId"
	value="${subChildId}" />
<%--Upload documents tab starts--%>
<!--<div class="successMsg t_space b_space clearfix" id="successDiv" style="display: none;"> </div>-->
<div id="uploadBriefcaseDoc">
	<spring:message code="fields_selfiletoupload" var="selFileToUpload" />
	<spring:message code="fields_docbrief" var="docBrief" />
	<spring:message code="msg_tender_invalidDocBrief" var="docBriefInValid" />
	
	<div class="clearfix mini-formfield display-block <c:if test="${(objectId ne null and objectId ne 0)}">border-top</c:if> m-top0" id="tab1Div">
	
		<spring:message code="label_pleaseselect" var="var_pleaseSelect" />
		
		<div class="row">
<!-- 			<div class="col-lg-2 col-md-2 col-sm-12 col-xs-12"> -->
<!-- 				<div class="form_filed"> -->
<%-- 							${docBrief} --%>
<!-- 					<span style="color: red">*</span> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 			<div class="col-lg-5 col-md-5 col-sm-12 col-xs-12"> -->
			<div class="col-lg-6">
				<div class="form-group">
					<div class="input-group">
						<div class="input-group-addon">
							<i class="epro icon-country font-20 txt-gray-c"></i>
						</div>
						<input class="form-control" type="text" id="txtDocDesc"
							isrequired="true" title="${docBrief}" validation="length,brief" placeholder="${docBrief}"
							maxlength="1000" validationmsg="${docBriefInValid}" /> <span
							id="docDescError"></span>
					</div>
				</div>
			</div>		
		

			<div class="col-lg-6">
<!-- 				<div class="form_filed"> -->
<%-- 					${selFileToUpload} <span style="color: red">*</span> --%>
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 			<div class="col-lg-5 col-md-5 col-sm-12 col-xs-12"> -->
				<div class="one">
					<div class="input-group">
						<label class="input-group-btn"> <span class="btn btn-primary"> <i class="fa fa-folder-open"></i>
														&nbsp;&nbsp;Find File<input id="fileToUpload" type="file" onchange="checkFile(this)" name="fileToUpload" class="upload" style="display: none;" /> 
														</span> 
						</label> 
						<input type="text" id="fileToUploadName" name="fileToUploadName" class="form-control" value="" readonly style="margin-top:10px;">
						<div id="fileError"></div>
					</div>					
				</div>
			</div>			
		</div>
		
		<div class="row">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="margin-top:-25px;">
				<div class="display word-break a-justify doc_mssg form_filed_red" style="float:right;">
					<spring:message code="instruction_fileUpload_3" />
					<c:choose>
					<c:when test="${objectId eq 6 or objectId eq 7 or objectId eq 0}">
						&nbsp;(<spring:message code="lbl_allowedExt_custmize1" />)
					</c:when>
					<c:otherwise>
						&nbsp;(<spring:message code="lbl_allowedExt" />)
					</c:otherwise>
					</c:choose>
				</div>
				&nbsp;
				<div class="form_filed_ins" style="float:right;">
					<spring:message code="lbl_instruction" /> :
				</div>
			</div>
		</div>
		
		<div class="row">
			<div class="col-lg-12">
				<div class="">
					<button type="button" onclick="return ajaxFileUpload();" class="btn btn-submit" style="float:right;">
						<spring:message code="lbl_upload"/>
					</button>
				</div>
			</div>	
		</div>
		
		
		<c:choose>
			<c:when test="${objectId eq 10}">
				<div class="row">
			<div class="col-lg-2 col-md-2 col-sm-12 col-xs-12">
				Reference documents
			</div>
			<div class="col-lg-5 col-md-5 col-sm-12 col-xs-12">
				<select class="form-control" id="selDocCheckList" name="selDocCheckList"  onchange="if(validateCombo(this)){getState()}" title="">
				</select>
			</div>
				</div>
			</c:when>
			<c:otherwise>
				<input type="hidden" name="selDocCheckList" id="selDocCheckList" value="0" />
			</c:otherwise>
		</c:choose>
		
	</div>
</div>
