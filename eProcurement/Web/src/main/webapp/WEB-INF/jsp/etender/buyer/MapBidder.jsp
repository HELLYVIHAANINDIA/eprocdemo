<!DOCTYPE HTML>
<html>   
       <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	   <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
	   	<%@include file="../../includes/header.jsp"%>
        <%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
        <script src="${pageContext.servletContext.contextPath}/resources/js/commonValidate.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/resources/js/commonListing.js"></script>
        <title><spring:message code="title_tender_biddermapping" var="var_title"/>${var_title}</title>
        <spring:message code="msg_tender_entersearchval" var="var_entersearchval"/>
        <spring:message code="msg_tender_selectatleastonebidder" var="var_selectatleastonebidder"/>
        <spring:message code="msg_tender_maponlyonebidder" var="var_onlyonebidder"/>
        <script type="text/javascript">
            function specialTrim(str) {
                return str.replace(/>\s+</g, '><');
            }
            function validateSearch() {
                $('.err').remove();
                var vbool = true;
                if ($.trim($("#txtSearchString").val()) == '') {
                    $('#txtSearchString').parent().append("<div class='err' style='color:red;'>${var_entersearchval}</div>");
                    vbool = false;
                }
                return vbool;
            }
            function getUnMappedBidders() {
            	var SearchString = '';
            	 $("#mapBidderRaw").html("<th width='1%'><label></label></th><th width='9%'><label><spring:message code='col_srno'/></label></th><th width='90%'><label><spring:message code='lbl_company_details'/></label></th>");
            	if($("#txtSearchString").val().indexOf("&")!="-1"){
             		SearchString = $("#txtSearchString").val().replace(/\&/g,"%26");
             	}else{
             		SearchString = $("#txtSearchString").val();
             	}
            	//var SearchString = $("#txtSearchString").val();
                var SearchOpt = $("#selSearchOpt option:selected").val();
                var TenderId = '${tenderId}';
                var MappingType = '${mappingType}';
                var chkCategoryUser = $("#chkCategoryUser:checked").val();
                if(chkCategoryUser == undefined ||  chkCategoryUser == ""){
                	chkCategoryUser = 0;
                }
                var searchResult;
            	//var data = { 'txtSearchString' : SearchString, 'txtSearchOpt' : SearchOpt ,'hdTenderId' : TenderId ,'txtMappingType':MappingType,'chkCategoryUser':chkCategoryUser};
            	$.ajax({
            		type : "POST",
            		url : "${pageContext.servletContext.contextPath}/etender/buyer/searchunmappedbidder",
            		data : { txtSearchString : SearchString, txtSearchOpt : SearchOpt ,hdTenderId : TenderId ,txtMappingType:MappingType,chkCategoryUser:chkCategoryUser},
            		timeout : 100000,
            		success : function(data) {
            			console.log("SUCCESS: ", data);
            			searchResult=data;
            			searchResult = $.trim(specialTrim(searchResult));
                        if (searchResult == 'sessionexpired') {
                            window.location = "${pageContext.servletContext.contextPath}/" + searchResult;
                        } else {
                            $("#searchResult").html(searchResult);
                            removeDuplicate();
                            <c:if test="${tenderMode eq 3 or tenderMode eq 4}">
                                singleSelect();
                            </c:if>
                        }
            		},
            		error : function(e) {
            			console.log("ERROR: ", e);
            		},
            	});
                
//                 <abc:ajax ajaxurl="etender/buyer/searchunmappedbidder" aysnc="false" method="post" jsvars="txtSearchString=SearchString,txtSearchOpt=SearchOpt,hdTenderId=TenderId,txtRowId=rowId,txtMappingType=MappingType,txtTableId=tableId" isdirectoutput="true" jsvartosetval="searchResult"/>
                
            }

            function resetSearch() {
            	$("#mapBidderRaw").html("");
            	$("#norecord").html("");
                $(':input', '#searchResult')
                        .not(':button, :submit, :reset, :hidden')
                        .val('')
                        .removeAttr('checked');

                $(':input', '#tblSearch')
                        .not(':button, :submit, :reset, :hidden')
                        .val('')
                        .removeAttr('checked');

                $("#searchResult").html("<tr><td colspan=\"5\"><spring:message code="msg_tender_searchbidder"/></td></tr>");
                $("#selSearchOpt").get(0).selectedIndex = 0;
            }
            
            function validateAddBidder(){
                var vbool = valOnSubmit();
                var rbool = AddBidderChkBxValid();
                var mbool = tenderModeValidate();
                var fbool = false;
                if(vbool && rbool && mbool){
                    fbool = true;
                    mapBidderDelUncheckedCheckBx();
                }
                return disableBtn(fbool);
            }
            
            function tenderModeValidate(){
            	<c:if test="${tenderMode eq 3 or tenderMode eq 4}">
	            	var chkBxLength = $('input[name*=chkMapBidderId]').length;
	            	if(chkBxLength == 1){
	            		alert('<spring:message code="msg_tender_maponlyonebidder"/>');
	                    return false;
	            	}
	            	return true;
            	</c:if>
            	return true;
            }
            
            function AddBidderChkBxValid(){
                var chkBxLength = $('input[name*=chkBidderId]:checked').length;
                if(chkBxLength == 0){
                	alert('<spring:message code="msg_tender_selectatleastonebidder"/>');
                    return false;
                }else{
                    return true;
                }
            }
                
            function mapBidderDelUncheckedCheckBx(){
                $('input[name=chkBidderId]').each(function(){
                    if($(this).attr("checked") == false){
                        $(this).remove();
                    }
                });
            }
            
            function validateRemoveBidder(){
                var vbool = valOnSubmit();
                var rbool = RemoveBidderChkbxValid();
                var fbool = false;
                if(vbool && rbool){
                    fbool = true;
                    unMapBidderDelUncheckedCheckBx();
                }
                return disableBtn(fbool);
            }
            
            function RemoveBidderChkbxValid(){
                var chkBxLength = $('input[name*=chkMapBidderId]:checked').length;
                if(chkBxLength == 0){
                	alert('<spring:message code="msg_tender_selectatleastonebidder"/>');
                    return false;
                }else{
                	if (confirm('Are you sure want to remove bidder')) {
                		return true;
                	} else {
                		return false;
                	}
                }
            }
            
            function unMapBidderDelUncheckedCheckBx(){
                $('input[name=chkMapBidderId]').each(function(){
                    if($(this).attr("checked") == false){
                        $(this).remove();
                    }
                });
                if($('#checkBxAll').attr("checked") == false){
                    $('#checkBxAll').remove(); 
                }
            }
            
            function checkAll(ckbAll){
                if(ckbAll.checked == true){
                    $('input[name*=chkMapBidderId]').each(function(){
                        $(this).attr('checked','checked');
                    });
                }else{
                    $('input[name*=chkMapBidderId]').each(function(){
                        $(this).removeAttr('checked');
                    });
                }
            }
            <c:if test="${tenderMode eq 3 or tenderMode eq 4}">
                $(document).ready(function() {
                        singleSelect();
                });
            </c:if>
                
            function singleSelect(){
            	var $unique = $('input.unique');
                $unique.click(function() {
                $unique.removeAttr('checked');
                  $(this).attr('checked', true);
                });
            }
            function removeDuplicate(){
                $('input[type=hidden][name=UnMappedCoId]').each(function() {
                    var userId = $(this).val().split("_")[0];
                    var coId = $(this).val().split("_")[1];
                    var count = 0;
                    $('input[type=hidden][name=UnMappedCoId]').each(function() {
                        var chUserId = $(this).val().split("_")[0];
                        var chCoId = $(this).val().split("_")[1];
                        
                        if(coId == chCoId){
                            count++;
                            if(count > 1){
                                $(this).closest('tr').remove();
                            }
                        }
                    });
                });
            }
        </script>
    </head>
    
<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="../../includes/leftaccordion.jsp"%>

<div class="content-wrapper" style="height: auto; ">

<section class="content-header">

<a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}" class="btn btn-submit">
                                                    <c:if test="${isAuction eq 1}">
                                                        << Go To Auction Dashboard
                                                    </c:if>
                                                    <c:if test="${isAuction ne 1}">
                                                        << Go To Tender Dashboard
                                                    </c:if>
                                                    </a>

</br>
<h1 style="margin:0px; margin-top:10px;"><spring:message code="lbl_mapbidder"/></h1>
</section>

<section class="content">
<div class="row">
<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">

<div class="box">
						
<div class="box-header with-border">
<h3 class="box-title"><spring:message code="lbl_mapbidder"/></h3>											
</div>

<div class="box-body">

<div class="row">

<div class="col-lg-12 col-md-12 col-xs-12">

<div class="row">
<div class="col-lg-12">
<c:if test="${not empty successMsg}">
<div class="alert alert-success"><spring:message code="${successMsg}"/></div>
</c:if>
<c:if test="${not empty errorMsg}">
<div class="alert alert-danger"><spring:message code="${errorMsg}"/></div>
</c:if>	
</div>
</div>

<div class="row">
<div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
<div class="form_filed">Search :</div>
</div>

<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
<select class="form-control" id="selSearchOpt">
<option value="0">All</option>
<option value="1">Email</option>
<option value="3">Company Name</option>
</select>
<br/>
<spring:message code="lbl_within_keyword"/>: <input type="checkbox" id="chkCategoryUser" name="chkCategoryUser" checked="checked" value="1" >
</div>

<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">						                                    
<input type="text" class="form-control" id="txtSearchString" name="txtSearchString" placeholder="Search Value" title="search criteria">
</div>

<div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">						                                    
<button type="submit" class="btn btn-submit" value="Search" onclick="if(validateSearch()){getUnMappedBidders();}">Search</button>
<button VALUE="CLEAR" class="btn btn-submit" onclick="resetSearch();">Clear</button></td>
</div>
</div>	

<div class="row">

<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">					                                
 												 <form:form action="${pageContext.servletContext.contextPath}/etender/buyer/mapbidder" modelAttribute="tenderMapBidderDataBean" method="POST" onsubmit="return validateAddBidder();" >
					                                <div class="clearfix">
					                                <table width="100%" cellpadding="0" cellspacing="0" class="table table-striped table-responsive" id="mapbidder">
					                                    <input type="hidden" name="hdTenderId" id="hdTenderId"  value="${tenderId}"/>
					                                    <input type="hidden" name="hdMappingType" id="hdMappingType" value="${mappingType}"/>
					                                    <thead>
					                                    <tr class="gradi" id="mapBidderRaw">
					                                    </tr>
					                                    </thead>
					                                    <tbody id="searchResult">
					                                        <tr id="norecord">
					                                            <td colspan="5" id="tdNoRecord"><%-- <spring:message code="msg_tender_searchbidder"/> --%></td>
					                                        </tr>
					                                    </tbody>
					                                </table>
					                                </div>
                            					</form:form>
</div>
</div>

<div class="row">

<div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
<div class="page-title prefix_1 o-hidden border-bottom-none border-top"> <div class="formHeader m-top_4"><spring:message code="link_tender_mappedbidder"/>
</div>
</div>
</div>

<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
<form:form action="${pageContext.servletContext.contextPath}/etender/buyer/removemappedbidder" modelAttribute="tenderMapBidderDataBean" method="POST" onsubmit="return validateRemoveBidder();" class="table-border">
                                <table width="100%" cellpadding="0" cellspacing="0" class="table table-striped table-responsive" id="MappedBidder">
                                    <input type="hidden" name="hdTenderId" id="hdTenderId"  value="${tenderId}"/>
                                    <input type="hidden" name="hdMappingType" id="hdMappingType" value="${mappingType}"/>
                                    <thead>
                                    <tr class="gradi">
                                        <th width="1%"><label> <input type="checkbox" name="checkBxAll" id="checkBxAll" onchange="checkAll(this)"/></label></th>
                                        <th width="9%"><label>Sr No.</label></th>
                                        <th width="90%"><label>Bidder Details</label></th>
                                        <%-- <th><label><spring:message code="col_tender_company"/></label></th> --%>
                                    </tr>
                                    </thead>
                                    <c:choose>
                                        <c:when test="${not empty lstMappedBidders}">
                                            <c:forEach items="${lstMappedBidders}" var="data" varStatus="cnt">
                                                <tr>
                                                    <td>
                                                         <input type="checkbox" id="chkMapBidderId" name="chkMapBidderId" value="${data[1]}_${data[7]}_${data[0]}" />	
                                                    </td>
                                                    <td class="a-center">${cnt.count}</td>
                                                    		<td width="25%" class="line-height">
                                    						<br/>${data[2]}
                                    						<br/>${data[3]}
                                    						<br/>${data[4]}
                                    						<br/>${data[6]}-${data[5]}
		                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            <tr>
                                                <td colspan="4" class="a-center m-top_1 no-border">
                                                    <spring:message code="lbl_removebidder" var="lblremovebidder"/>
                                                    <button type="submit" class="btn btn-submit">${lblremovebidder}</button>
                                                </td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="4"><spring:message code="msg_tender_biddermap_empty"/></td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </table>
                            </form:form>
</div>
</div>

</div>
</div>
</div>
</div>
</div>
</div>
</div>
</section>

</div>
                
</body>

</html>
