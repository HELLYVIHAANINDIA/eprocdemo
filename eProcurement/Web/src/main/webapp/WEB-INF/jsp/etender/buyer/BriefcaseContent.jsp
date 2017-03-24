<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<spring:url value="/etender/bidder/mapdocuments" var="postUrl" />
<spring:message code="fields_docbrief" var="docBrief" />
<spring:message code="header_searchdocument" var="searchDocument" />
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
	<div
		class="clearfix mini-formfield display-block <c:if test="${(objectId ne null and objectId ne 0)}">border-top</c:if> m-top0"
		id="tab1Div">
		<spring:message code="label_pleaseselect" var="var_pleaseSelect" />
		<div class="row">
			<div class="col-lg-2 col-md-2 col-sm-12 col-xs-12">
				<div class="form_filed">
					${docBrief} <span style="color: red">*</span>
				</div>
			</div>
			<div class="col-lg-5 col-md-5 col-sm-12 col-xs-12">
				<input class="form-control" type="text" id="txtDocDesc"
					isrequired="true" title="${docBrief}" validation="length,brief"
					maxlength="1000" validationmsg="${docBriefInValid}" /> <span
					id="docDescError"></span>
			</div>
			
			<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
			
			</div>
			
		</div>
		<div class="row">

			<div class="col-lg-2 col-md-2 col-sm-12 col-xs-12">
				<div class="form_filed">
					${selFileToUpload} <span style="color: red">*</span>
				</div>
			</div>
			<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
				<div class="one">
					<div class="input-group">
						<label class="input-group-btn"> <span
							class="btn btn-primary"> <i class="fa fa-folder-open"></i>
								&nbsp;&nbsp;Find File<input id="fileToUpload" type="file"
								onchange="checkFile(this)" name="fileToUpload" class="upload"
								style="display: none;" /> </span> </label> <input type="text"
							class="form-control" readonly>
						<div id="fileError"></div>
					</div>
				</div>
			</div>
			<div class="col-lg-1 col-md-1 col-sm-12 col-xs-12">
				<button type="button" onclick="return ajaxFileUpload();"
					class="btn btn-submit">
					<spring:message code="lbl_upload" />
				</button>
			</div>
		</div>
		

		<div class="row">
			<div class="col-lg-2 col-md-2 col-sm-12 col-xs-12">
				<div class="form_filed">
					<spring:message code="lbl_instruction" />
				</div>
			</div>
			<div class="col-lg-10 col-md-10 col-sm-12 col-xs-12">
				<div class="display word-break a-justify doc_mssg">
					<spring:message code="instruction_fileUpload_3" />
					&nbsp;(
					<spring:message code="lbl_allowedExt" />
					)
				</div>
			</div>
		</div>


	</div>

</div>
