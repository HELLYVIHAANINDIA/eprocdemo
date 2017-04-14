<!DOCTYPE html>
<html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@include file="../../includes/header.jsp"%>
<script src="${pageContext.servletContext.contextPath}/resources/js/jquery-ui.min.js"></script>
<script src="${pageContext.servletContext.contextPath}/resources/PageJS/ViewBiddingForm.js" type="text/javascript"></script>
<script type="text/javascript" src="${pageContext.servletContext.contextPath}/resources/js/tender/ConvertToWord.js"></script>
    
<script type="text/javascript">
    $(document).ready(function() {
    	GTCalculationOnLoad();
	    $(".clstxtcell_true").blur(function() {
	         var formula = $(this).closest("tr").find("#hdnFormula").val();
	         var rowid = "_" + $(this).attr("rowid");
	         var tableId=$(this).attr("tableId");
	         calculateFormula(formula,rowid,this,tableId);
	    });
	    $('[id^="lblGT_ToalAmTWords_"]').each(function () {
			this.innerHTML = DoIt(this.innerHTML);
		});
});
    function GTCalculationOnLoad(){
        $('[id^="trGT_"]').each(function () {
            $(this).find('[id^="lblGT_"]').each(function () {
            var sum = 0;        
            var colid1 = $(this).attr("colId");
                $('[id^="txtcell_0_' + $(this).attr("colId") + '"]').each(function () {
                    var intval = 0;
                    if ($(this).val().length != 0) {
                        intval = parseInt($(this).val())
                    }
                    sum += intval;
                    $("#lblGT_" + colid1).text(Math.round(eval(eval(sum) * 1000)) / 1000);
                });
                var sum2 = 0;
                $('[id^="tbl_').each(function () {
                        $(this).find('[id^="result"]').each(function () {
                            if ($(this).parent().attr("colkey") == colid1) {
                                var intval = 0;
                                if ($(this).val().length != 0) {
                                    intval = parseInt($(this).val())
                                }
                                sum2 += intval;
                                $("#lblGT_" + colid1).text(Math.round(eval(eval(sum2) * 1000)) / 1000);
                            }
                        });
                    });
                });
            });
        }
    function calculateFormula(formula,rowid,cmd,tableId)
{
    debugger;
     var regex = /([\+\-\*\(\)\/])/;
     var arrIds= formula.split(regex);
     var ResultStr="";
     for(var i=0;i<arrIds.length;i++)
        {
            if((arrIds[i]).match("_"))
            {
                if(document.getElementById(arrIds[i] + rowid)!=null)
                {
                   if(parseFloat(trim(document.getElementById(arrIds[i] + rowid).value)) != 0 && document.getElementById(arrIds[i] + rowid).value != ''){
                   		ResultStr += trim(document.getElementById(arrIds[i] + rowid).value); //.replace(/^[0]+/g,""));
                   }else
                   {
                        ResultStr += '0';
                   }
                }
            }
            else
            {
                ResultStr += arrIds[i];
            }
        }
        $(cmd).closest("tr").find("#result"+rowid).val(Math.round(eval(eval(ResultStr)*1000))/1000);
        $('#trGT_'+tableId).each(function(){
            $(this).find('[id^="lblGT_"]').each(function () {
                var sum=0;
                var colid1 =  $(this).attr("colId");
                $('[id^="txtcell_0_'+$(this).attr("colId")+'"]').each(function () {
//                     debugger;
                    var intval = 0;
                    if($(this).val().length != 0){
                        intval = parseInt($(this).val())                
                    } 
                     sum += intval;
                      $("#lblGT_"+colid1).text(Math.round(eval(eval(sum)*1000))/1000);
                });
                 
                var sum2=0;
                 $('[id^="tbl_').each(function () {
                     if($(this).attr("tableid")==tableId){
                    $(this).find('[id^="result"]').each(function () {
                        if($(this).parent().attr("colkey") == colid1){
                        debugger;
                        var intval = 0;
                        if($(this).val().length != 0){
                            intval = parseInt($(this).val())                
                        } 
                        sum2 += intval;
                        $("#lblGT_"+colid1).text(Math.round(eval(eval(sum2)*1000))/1000);     
                      }
                    });
                    }
                 });
            });
        });
    }
        
    function trim(s)
    {
        while (s.substring(0,1) == ' ')
        {
            s = s.substring(1,s.length);
        }
        while (s.substring(s.length-1,s.length) == ' ')
        {
            s = s.substring(0,s.length-1);
        }
      
        return s;
    } 
    function setDraftSaveValue(value){
    	$('#hdFormActionS').val(value);
    	createJson();
		$( "#bidForm" ).submit();
	}
    
    function createJson(){
   	var vbool =true;
   	$('[id^="txtcell"]').each(function () {
		if($(this).val() == ''){
			vbool = false;
			alert('Please fill form');
			return vbool;
		}
	});
	if(vbool){
    var ArrTableJson={};
    
    var cnt = 0;
    var count=0;
    var colNo=0;
   
    $('[id^="tbl_"]').each(function () {
//         debugger;
        var TableJson={};
        TableJson['FormId']= $('#hdnFormId').val();
         TableJson['TableId']=$(this).attr("tableId");
         
          var ArrColumnJson={}
          count=0;
        $("#tbl_"+ cnt).find("tbody tr").each(function () {
            colNo=0;
            $(this).find("td").each(function () { 
            	if($(this).attr("cellID")!=undefined){
             //  alert($(this).attr().val());
   
            var ColumnJson={};
            var val;
                 //Table ID
                 //console.log($(this).attr("tableid"));
                // Row ID
                // console.log($(this).attr("trid"));
                //Column ID
                 //console.log($(this).attr("colKey"));
                
                if($(this).find("input[type=text]").length){
                    console.log("Row: " + $(this).attr("trid") + " ,Key: " + $(this).attr("colKey") +  " , val: " + $(this).find("input[type=text]").val()+", Cell Id:"+$(this).attr("cellID"));
                    val="Row: " + $(this).attr("trid") + " ,Key: " + $(this).attr("colKey") +  " , val: " + $(this).find("input[type=text]").val();
                    ColumnJson['row']=$(this).attr("trid");
                    ColumnJson['key']=$(this).attr("colKey");
                    ColumnJson['val']=$(this).find("input[type=text]").val();
                    ColumnJson['cellId']=$(this).attr("cellID");
                    ColumnJson['filledBy']=$(this).attr("filledBy");
//                   alert($(this).attr("cellID"));
                    
            }
                else if($(this).find("label").length){
                         console.log("Row: " + $(this).attr("trid") + " ,Key: " + $(this).attr("colKey") +  " , val: " + $(this).find("label").text()+", Cell Id:"+$(this).attr("cellID"));
                        val="Row: " + $(this).attr("trid") + " ,Key: " + $(this).attr("colKey") +  " , val: " + $(this).find("label").text();
                        ColumnJson['row']=$(this).attr("trid");
                    ColumnJson['key']=$(this).attr("colKey");
                    ColumnJson['val']=$(this).find("label").text();
                    ColumnJson['cellId']=$(this).attr("cellID");
                    ColumnJson['filledBy']=$(this).attr("filledBy");
                    
            }
                else if($(this).find("select").length){
                         console.log("Row: " + $(this).attr("trid") + " ,Key: " + $(this).attr("colKey") +  " , val: " + $(this).find("select").val()+", Cell Id:"+$(this).attr("cellID"));
               val="Row: " + $(this).attr("trid") + " ,Key: " + $(this).attr("colKey") +  " , val: " + $(this).find("select").val();
               ColumnJson['row']=$(this).attr("trid");
                    ColumnJson['key']=$(this).attr("colKey");
                    ColumnJson['val']=$(this).find("select").val();
                    ColumnJson['cellId']=$(this).attr("cellID");
                    ColumnJson['filledBy']=$(this).attr("filledBy");
                    
            }
                else if($(this).find("input[type=number]").length){
                         console.log("Row: " + $(this).attr("trid") + " ,Key: " + $(this).attr("colKey") +  " , val: " + $(this).find("input[type=number]").val()+", Cell Id:"+$(this).attr("cellID"));
               val="Row: " + $(this).attr("trid") + " ,Key: " + $(this).attr("colKey") +  " , val: " + $(this).find("input[type=number]").val();
                ColumnJson['row']=$(this).attr("trid");
                    ColumnJson['key']=$(this).attr("colKey");
                    ColumnJson['val']=$(this).find("input[type=number]").val();
                    ColumnJson['cellId']=$(this).attr("cellID");
                    ColumnJson['filledBy']=$(this).attr("filledBy");
                    
            }
                else if($(this).find("input[type=file]").length){
                        console.log("Row: " + $(this).attr("trid") + " ,Key: " + $(this).attr("colKey") +  " , val: " + $(this).find("input[type=file]").val()+", Cell Id:"+$(this).attr("cellID"));
                val="Row: " + $(this).attr("trid") + " ,Key: " + $(this).attr("colKey") +  " , val: " + $(this).find("input[type=file]").val();
                ColumnJson['row']=$(this).attr("trid");
                    ColumnJson['key']=$(this).attr("colKey");
                    ColumnJson['val']=$(this).find("input[type=file]").val();
                    ColumnJson['cellId']=$(this).attr("cellID");
                    ColumnJson['filledBy']=$(this).attr("filledBy");
                    
            }
                else if($(this).find("input[type=date]").length){
                        console.log("Row: " + $(this).attr("trid") + " ,Key: " + $(this).attr("colKey") +  " , val: " + $(this).find("input[type=date]").val()+", Cell Id:"+$(this).attr("cellID"));
                 val="Row: " + $(this).attr("trid") + " ,Key: " + $(this).attr("colKey") +  " , val: " + $(this).find("input[type=date]").val();
               
                ColumnJson['row']=$(this).attr("trid");
                    ColumnJson['key']=$(this).attr("colKey");
                    ColumnJson['val']=$(this).find("input[type=date]").val();
                    ColumnJson['cellId']=$(this).attr("cellID");
                    ColumnJson['filledBy']=$(this).attr("filledBy");
                    
            }
                ColumnJson['colNo']=colNo++;
               
                  ArrColumnJson['column'+count]=ColumnJson;
                  count++;
              // if($(this).is('input:file')){alert(1);};
               //console.log($(this).find("label").text());
                //console.log($(this).find("input[type=text]").length);
                //console.log($(this).find("input[type=file]").length);
               // console.log($(this).find("select").length);
               //alert($(this).attr("colkey").val());
            	}
        });
        
        });
         TableJson['ColumnJsonval']=ArrColumnJson;
          ArrTableJson['TableJson'+cnt]=TableJson;
        
        cnt++;
          
    });
    
    var jsonObj={};
    jsonObj['TableJson']=ArrTableJson;
      var jstr=JSON.stringify(ArrTableJson);
     // alert(jstr);
      $('#txtJson').val(jstr);
//        console.log(jstr);
   // alert(jstr);
   
           var ArrGTColumnJson={};
      
       $('[id^="trGT_"]').each(function () {
            $(this).find('[id^="lblGT_"]').each(function () {
               var GTSubJson={};
                    GTSubJson['colId'] = $(this).attr("colId");
                    GTSubJson['tableId'] =  $(this).attr("TableId");
                    GTSubJson['FormId'] =  $('#hdnFormId').val();
                    GTSubJson['GTValue'] = $(this).text();
                    var jsonV = "GTColumn_"+ $(this).attr("colId");
                    ArrGTColumnJson[jsonV] = GTSubJson;
                });
            });
    
        var jstrGT=JSON.stringify(ArrGTColumnJson);
        $('#hdnGTColumnValue').val(jstrGT);
//         alert($('#hdnGTColumnValue').val());
    return true;
 		}else{
 			return false;			
 		}
    }
</script>
<spring:message code="lbl_back_dashboard" var='backDashboard'/>
<spring:message code="lbl_form_save_as_draft" var="varSaveAsDraft"/>
<spring:message code="lbl_view_bidding_form" var="varViewForm"/>
<spring:message code="lbl_edit_bidding_form" var="varEditForm"/>

<spring:message code="lbl_form_Id" var="varFormId"/>
<spring:message code="lbl_form_name" var="varFormName"/>
<spring:message code="lbl_created_on" var="varCreatedOn"/>
<spring:message code="lbl_doc_req" var="varDocReq"/>
<spring:message code="lbl_Id_Mand" var="varMandatory"/>
<spring:message code="lbl_price_bid" var="varIsPriceBid"/>
</head>

<body class="skin-blue sidebar-mini">  
<div class="wrapper">
<%@include file="../../includes/leftaccordion.jsp"%>

        <div class="content-wrapper">
            <section class="content-header">
				<div class="col-md-6 pull-left">
					<h4>
						<c:choose>
							<c:when test="${!fromView}">
								${varEditForm}
							</c:when>
							<c:otherwise>
								${varViewForm}
							</c:otherwise>
						</c:choose>
					</h4>
				</div>
				<div class="col-md-6 text-right">
				
 					<c:choose>
                        <c:when test="${sessionUserTypeId eq 2}">
                             <a href="${pageContext.servletContext.contextPath}/etender/bidder/biddingtenderdashboardcontent/${tenderId}/5" class="btn btn-submit"><< ${backDashboard}</a>
                        </c:when>
                        <c:otherwise>
                            <div><a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}" class="btn btn-submit"><< ${backDashboard}</a></div>                                                
                        </c:otherwise>
                    </c:choose>
				</div>
            </section>
            <section class="content">
                <div class="row">
                    <div class="col-lg-12 col-md-12">
                        <div class="box">
                            <div class="box-header with-border">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="col-sm-2 col-md-2">
                                            <div class="form_filed text-black text-right">${varFormId} :</div>
                                        </div>
                                        <div class="col-sm-2 col-md-2">
                                            <div class="form_filed pull-left">${formId}</div>
                                        </div>
                                        <div class="col-sm-2 col-md-2">
                                            <div class="form_filed text-black text-right" >${varFormName} :</div>
                                        </div>
                                        <div class="col-sm-2 col-md-2">
                                            <div class="form_filed pull-left">${FormBean.FormName}</div>
                                        </div>
                                        <div class="col-sm-2 col-md-2">
                                            <div class="form_filed text-black text-right">${varCreatedOn} :</div>
                                        </div>
                                        <div class="col-sm-2 col-md-2">
                                            <div class="form_filed pull-left">${FormBean.CreatedOn}</div>
                                        </div>
                                    </div>
                                       <c:if test="${FormBean.IsDocReq eq 0}">
                                           <c:set var="DocReqVal" value="No"/>
                                       </c:if>
                                       <c:if test="${FormBean.IsDocReq eq 1}">
                                           <c:set var="DocReqVal" value="Yes"/>
                                       </c:if>
                                                        
                                                           
                                     <div class="col-md-12">
                                                        <div class="col-sm-2 col-md-2">
                                                            <div class="form_filed text-right text-black">${varDocReq} :</div>
                                                        </div>
                                                        <div class="col-sm-2 col-md-2">
                                                            <div class="form_filed  pull-left">${DocReqVal}</div>
                                                        </div>
                                                        <c:if test="${FormBean.IsMandatory eq 0}">
                                                                <c:set var="IsMandatory" value="No"/>
                                                            </c:if>
                                                            <c:if test="${FormBean.IsMandatory eq 1}">
                                                                <c:set var="IsMandatory" value="Yes"/>
                                                            </c:if>
                                                       
                                                        <div class="col-sm-2 col-md-2">
                                                            <div class="form_filed  text-right text-black">${varMandatory} :</div>
                                                        </div>
                                                        <div class="col-sm-2 col-md-2">
                                                            
                                                            <div class="form_filed  pull-left">${IsMandatory}</div>
                                                        </div>
                                                        <c:if test="${FormBean.IsPriceBid eq 0}">
                                                                <c:set var="IsPriceBid" value="No"/>
                                                            </c:if>
                                                            <c:if test="${FormBean.IsPriceBid eq 1}">
                                                                <c:set var="IsPriceBid" value="Yes"/>
                                                            </c:if>
                                                        
                                                        <div class="col-sm-2 col-md-2">
                                                            <div class="form_filed text-right text-black">${varIsPriceBid} :</div>
                                                        </div>
                                                        <div class="col-sm-2 col-md-2">
                                                            <div class="form_filed  pull-left">${IsPriceBid}</div>
                                                        </div>
                                                    </div>
                                                    </div>
                              
                                                    
                                                   
						</div>

						

					</div>

				</div>
                <div class="row">
                    <div class="col-lg-12 col-md-12">
                    	<form:form id="bidForm" action="${pageContext.servletContext.contextPath}/eBid/Bid/updateBiddingFormValueForEdit" method="POST">
                        <div class="box">
                            <div class="col-md-6">
                                <h3 class="box-title"> ${formStructure['form'].formName} </h3>
                            </div>
							<div class="box-body">
                                <div class="row">
                                        <div class="col-md-12">
                                            <h3 style="padding-top:0px;margin-top:0px;">${formStructure['form'].formHeader}</h3>
                                        </div>
                                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                        	<div class="box">
												<c:forEach var="tableData" items="${formStructure['table']}" varStatus="tableCount">
													<div class="box-header with-border">
												        <h3 class="box-title"><b>${tableData.tableName}</b></h3>
												        <h4 class="box-title pull-right" ><b> Mandatory:</b>&nbsp;
												        	<c:choose>
												        		<c:when test="${tableData.isMandatory eq 1}"> Yes</c:when>
												        		<c:when test="${tableData.isMandatory eq 0}"> No</c:when>
												        	</c:choose>
														</h4>
													</div>
													<div class="box-header with-border">
														<h3 class="box-title">${tableData.tableHeader}</h3>
													</div>
													<div class="box-body">
													<div class="row">
														<div class="col-lg-12 col-md-12 col-xs-12">
															<table class="table table-striped table-responsive" id="tbl_${tableCount.index}" tableId="${tableData.tableId}">
																<thead>
																	<tr>
																		<c:forEach var="columnData" items="${formStructure['column']}">
																			<c:if test="${columnData.key eq tableData.tableId}">
																			<c:forEach var="columnDataValue" items="${columnData.value}">
																				<th>Column Name: ${columnDataValue.columnHeader}<br/>
																				Filled By:
																					<c:forEach items="${UserEnum}" var="userEnumData">
																						<c:if test="${userEnumData.userType eq columnDataValue.filledBy}">
																							${userEnumData}
																						</c:if>
																					</c:forEach> 
																					
																				<br> Data Type:
																					<c:forEach items="${DataTypeEnum}" var="datatype">
																						<c:if test="${datatype.status eq columnDataValue.dataType}">
																							${datatype}
																						</c:if>
																					</c:forEach>																				
																				</th>
																			</c:forEach>
																			</c:if>
																		</c:forEach>
																	</tr>
																</thead>
																<tbody>
																<c:if test="${sessionUserTypeId eq 2 and listOfCurrency ne null and not empty listOfCurrency and isRepeated}">
																<div class="col-lg-12 col-md-12 col-xs-12">
																 <label class="pull-right"><b><spring:message code="lab_bid_curr" /> while submitting Bid ${selectedCurrency}</b><br/><br/></label>
																</div>
																</c:if>
																<c:forEach var="rowCount" begin="0" end="${tableData.noOfRows-1}">
																	<tr id="tr${rowCount}">	
																	<c:forEach var="columnData" items="${formStructure['column']}">
																	<c:if test="${columnData.key eq tableData.tableId}">
																			<c:forEach var="columnDataValue" items="${columnData.value}">
																		<c:forEach var="cellData" items="${formStructure['cell']}">
																			<c:if test="${cellData.tblTenderTable.tableId eq tableData.tableId and  cellData.tblTenderColumn.columnId eq columnDataValue.columnId and cellData.rowId eq rowCount}">
																			<td tableid="1" trid="${rowCount}" colKey="${columnDataValue.columnId}" cellID="${cellData.cellId}" filledBy="${columnDataValue.filledBy}">
																			<c:if test="${columnDataValue.isShown eq 1}">
																			<c:set value="${rowCount}" var="inputId"/>
																			<c:forEach var="entry" items="${formFormulaWithColumn}">
																						<c:if test="${entry.key eq columnDataValue.columnId}">
																							<c:set value="result_${rowCount}" var="inputId"/>
																						</c:if>
																						<c:if test="${entry.key ne columnDataValue.columnId}">
																							<c:set value="txtcell_0_${columnDataValue.columnId}_${rowCount}" var="inputId"/>
																						</c:if>
																			</c:forEach>
																			<c:choose>
																				<c:when test="${!fromView && columnDataValue.filledBy eq 2 and  not empty getLastFormulaColumn}">
																					<c:choose>
																						<c:when test="${columnDataValue.dataType eq 2 || columnDataValue.dataType eq 1 || columnDataValue.dataType eq 5 || columnDataValue.dataType eq 3 || columnDataValue.dataType eq 4 || columnDataValue.dataType eq 6}">
<%-- 																						<c:forEach items="${getLastFormulaColumn}" var="formulaColumn"> --%>
																							<c:choose>
																								<c:when test="${columnDataValue.isGTColumn eq 1}">
																									<c:choose>
																										<c:when test="${columnDataValue.dataType eq 1}">
																											<input validarr="required@@length:0,300" tovalid="true" id="${inputId}" type="text" onblur="ValidateInput('${columnDataValue.dataType}',this);" att="1" colKey="${columnDataValue.columnId}" tableid="${tableData.tableId}"   class="clstxtcell_true" value="${cellData.cellValue}" rowid="${rowCount}">
																										</c:when>
																										<c:when test="${columnDataValue.dataType eq 2}">
																											<input validarr="required@@length:0,1000" id="${inputId}" type="text" onblur="ValidateInput('${columnDataValue.dataType}',this);" att="1" colKey="${columnDataValue.columnId}" tableid="${tableData.tableId}"   class="clstxtcell_true" value="${cellData.cellValue}" rowid="${rowCount}">
																										</c:when>
																										<c:when test="${columnDataValue.dataType eq 3}">
																											<input id="${inputId}" type="number" validarr="required@@numwithdecimal:2" tovalid="true" onblur="ValidateInput('${columnDataValue.dataType}',this);" att="1" colKey="${columnDataValue.columnId}" tableid="${tableData.tableId}"   class="clstxtcell_true" value="${cellData.cellValue}" rowid="${rowCount}">
																										</c:when>
																										<c:when test="${columnDataValue.dataType eq 4}">
																											<input id="${inputId}" type="number" validarr="required@@numeric" tovalid="true" onblur="ValidateInput('${columnDataValue.dataType}',this);" att="1" colKey="${columnDataValue.columnId}" tableid="${tableData.tableId}"   class="clstxtcell_true" value="${cellData.cellValue}" rowid="${rowCount}">
																										</c:when>
																										<c:when test="${columnDataValue.dataType eq 5}">
																											<input id="${inputId}" type="number" validarr="required@@numanduptodecimal:2" tovalid="true" onblur="ValidateInput('${columnDataValue.dataType}',this);" att="1" colKey="${columnDataValue.columnId}" tableid="${tableData.tableId}"   class="clstxtcell_true" value="${cellData.cellValue}" rowid="${rowCount}">
																										</c:when>
																										<c:when test="${columnDataValue.dataType eq 6}">
																											<label>${rowCount}</label>
																										</c:when>
																										<c:when test="${columnDataValue.dataType eq 7}">
																											<input id="${inputId}" type="date" onblur="ValidateInput('${columnDataValue.dataType}',this);" att="1" colKey="${columnDataValue.columnId}" tableid="${tableData.tableId}"   class="clstxtcell_true" value="${cellData.cellValue}" rowid="${rowCount}">
																										</c:when>
<%-- 																										<c:when test="${columnDataValue.dataType eq 8}"> --%>
<%-- 																											<input id="${inputId}" type="text" onblur="ValidateInput('${columnDataValue.dataType}',this);" att="1" colKey="${columnDataValue.columnId}" tableid="${tableData.tableId}"   class="clstxtcell_true" value="${cellData.cellValue}" rowid="${rowCount}"> --%>
<%-- 																										</c:when> --%>
<%-- 																										<c:when test="${columnDataValue.dataType eq 9}"> --%>
<%-- 																											<input id="${inputId}" type="text" onblur="ValidateInput('${columnDataValue.dataType}',this);" att="1" colKey="${columnDataValue.columnId}" tableid="${tableData.tableId}"   class="clstxtcell_true" value="${cellData.cellValue}" rowid="${rowCount}"> --%>
<%-- 																										</c:when> --%>
																										<c:otherwise>
																											<input id="${inputId}" type="text" onblur="ValidateInput('${columnDataValue.dataType}',this);" att="1" colKey="${columnDataValue.columnId}" tableid="${tableData.tableId}"   class="clstxtcell_true" value="${cellData.cellValue}" rowid="${rowCount}">
																										</c:otherwise>
																									</c:choose>
																									
																								</c:when>
																								<c:otherwise>
																									<input  id="${inputId}" type="text" onblur="ValidateInput('${columnDataValue.dataType}',this);" att="1" colKey="${columnDataValue.columnId}" tableid="${tableData.tableId}" class="clstxtcell_false" value="${cellData.cellValue}" rowid="${rowCount}">
																								</c:otherwise>
																							</c:choose>
<%-- 																						</c:forEach> --%>
																						</c:when>																				
																					</c:choose>
																				</c:when>
																				<c:when test="${!fromView && columnDataValue.filledBy eq 2 and  empty getLastFormulaColumn}">
																					<c:choose>
																						<c:when test="${columnDataValue.dataType eq 2 || columnDataValue.dataType eq 1 || columnDataValue.dataType eq 5 || columnDataValue.dataType eq 3 || columnDataValue.dataType eq 4 || columnDataValue.dataType eq 6}">
																							<input  id="${inputId}" type="text" onblur="ValidateInput('${columnDataValue.dataType}',this);" att="1" colKey="${columnDataValue.columnId}" tableid="${tableData.tableId}" class="clstxtcell_false" value="${cellData.cellValue}" rowid="${rowCount}">
																						</c:when>
																					</c:choose>
																				</c:when>
																				<c:when test="${!fromView}">
																					<input id="${inputId}" type="text" value="${cellData.cellValue}" disabled="disabled">
																				</c:when>
																				<c:otherwise>
																					${cellData.cellValue}
																				</c:otherwise>
																			</c:choose>
																			</c:if>
																			</td>
																			</c:if>
																		</c:forEach>
																		
																		
																		<c:forEach var="entry" items="${formFormulaWithColumn}">
																			<c:if test="${entry.key eq columnDataValue.columnId}">
																				<input type="hidden" id="hdnFormula" value="${entry.value}">		
																			</c:if>
																		</c:forEach>
																		<c:set value="${formula}" var="formula"/>
																		</c:forEach>
																		</c:if>
																	</c:forEach>
																	</tr>
																	</c:forEach>
																	<tr id="trGT_${tableData.tableId}" tableId="${tableData.tableId}" >
																		<c:forEach var="columnData" items="${formStructure['column']}">
																			<c:forEach var="columnDataValue" items="${columnData.value}">
																				<c:if test="${columnData.key eq tableData.tableId}">
																					<td>
																						<c:if test="${columnDataValue.isGTColumn eq 1}">
																							<c:forEach items="${formStructure['TenderCellGrandTotalList']}" var="TenderCellGrandTotal" varStatus="counter">
																								<c:if test="${TenderCellGrandTotal.tblTenderColumn.columnId eq columnDataValue.columnId}">
																									<label id="lblGT_${columnDataValue.columnId}" colId="${columnDataValue.columnId}" TableId="${columnData.key}">
																									${TenderCellGrandTotal.GTValue}
																									<c:if test="${columnDataValue.filledBy eq 3}"><br/><div style="word-wrap: break-word; width:100px;" id="lblGT_ToalAmTWords_${columnDataValue.columnId}_${tableData.tableId}">${TenderCellGrandTotal.GTValue}</div></c:if>
																									</label>
																								</c:if>
																								
																							</c:forEach>
																						</c:if>
																					</td>
																				</c:if>
																		</c:forEach>
																		</c:forEach>
																	</tr>
																</tbody>
															</table>
														</div>
													</div>
													</div>
													<div class="box-header with-border">
														<h3 class="box-title">${tableData.tableFooter}</h3>
													</div>
												 </c:forEach>
												
											</div>
                                       
                                        </div>
                                        <div class="col-lg-12">
                                        <h3 style="padding-top:0px;margin-top:0px;">${formStructure['form'].formFooter}</h3>
                                        </div>
                                </div>
                            </div>                                         
                        </div>
                        <c:if test="${!fromView}">
	                        <div class="col-md-12 text-center">
	                        	<button type="button" class="btn btn-submit" id="btndraftForm" onclick='setDraftSaveValue(1)'>${varSaveAsDraft}</button>
	                            <button type="button" class="btn btn-submit" id="btnSubmitForm" onclick='setDraftSaveValue(2)'>Save</button>
	                            <button type="button" class="btn btn-submit">Reset</button>
	                        </div>
                        </c:if>
                        <input type="hidden" id="hdFormActionS" name="hdFormActionS" value="2">
                        <input type="hidden" id="hdnFormId" name="hdnFormId" value="${formId}">
                        <input type="hidden" id="hdnGTColumnValue" name="hdnGTColumnValue">
						<input type="hidden" id="txtJson" name="txtJson">
                        <input type="hidden" value="${tenderId}" name="hdntenderId">
                        <input type="hidden" value="${bidId}" name="hdBidId">
                        </form:form>
                    </div>
                </div>
                                            
            </section>
        </div>
    </div>
    
   </body>
   
   </html>
