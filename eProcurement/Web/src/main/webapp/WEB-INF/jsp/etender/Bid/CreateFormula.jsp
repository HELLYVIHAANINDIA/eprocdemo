
<!DOCTYPE HTML>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <%@include file="../../includes/head.jsp"%>
        <title><spring:message code="fields_tender_createformulatitle"/></title>
        <c:set value="${etenderProperties.datatype_smalltext}" var="dtsmalltext"/>
        <c:set value="${etenderProperties.datatype_longtext}" var="dtlongtext"/>
        <c:set value="${etenderProperties.datatype_numeric}" var="dtnumeric"/>
        <c:set value="${etenderProperties.datatype_money}" var="dtmoney"/>
        <c:set value="${etenderProperties.datatype_money_all}" var="dtmoneyall"/>
        <c:set value="${etenderProperties.datatype_combo}" var="dtcombo"/>
        <script src="${pageContext.servletContext.contextPath}/resources/js/commonValidate.js" type="text/javascript"></script>                
        <link href="${pageContext.servletContext.contextPath}/resources/js/jQuery/jquery.alerts.css" rel="stylesheet" type="text/css" />        
        <script type="text/javascript" src="${pageContext.servletContext.contextPath}/resources/js/jQuery/jquery.alerts.js"></script>
        <c:if test="${noautocol ne true}">            
            <script type="text/javascript">
                var MSG_AUC_FORMULALERT = '<spring:message code="msg_auc_formulalert"/>';
                var MSG_AUC_CREATEFORMULA = '<spring:message code="msg_auc_createformula"/>';
                var MSG_AUC_PREPARETEST = '<spring:message code="msg_auc_preparetest"/>';
                var MSG_AUC_SOMEBRAC = '<spring:message code="msg_auc_somebrac"/>';
                var MSG_AUC_FILLVALTEST = '<spring:message code="msg_auc_fillvaltest"/>';
                var MSG_AUC_PROPERFORMULA = '<spring:message code="msg_auc_properformula"/>';
                var MSG_LOADING_WITH_ZERO = "<spring:message code="msg_loading_with_zero"/>";
                var MSG_AUC_TESTFORMULA = '<spring:message code="msg_auc_testformula"/>';
                var MSG_AUC_CHARSIZE = '<spring:message code="msg_auc_charsize"/>';                                                  
                var MSG_AUC_REMOVELEADZERO = '<spring:message code="msg_auc_removeleadzero"/>';  
                var MSG_AUC_ALLOWPOSITIVENUM = '<spring:message code="msg_auc_allowpositivenum" arguments="${decimalValueUpto}"/>';
                var decimalValueUpto = '${decimalValueUpto}';
            </script>
            <script type="text/javascript" src="${pageContext.servletContext.contextPath}/resources/js/form/FormFormula.js"></script>
            <script type="text/javascript" src="${pageContext.servletContext.contextPath}/resources/js/form/FormulaCalculation.js"></script>
            <style type="text/css">
                .tdalignclass{
                 display: block;
                 width: 50px;
                }
            </style>
        </c:if>
        <c:set value="0" var="gtw"/>
        <c:if test="${tenderResult ne 2}">
            <c:set value="1" var="gtw"/>
        </c:if>    
        <script  type="text/javascript">
            <c:if test="${noautocol ne true}">            
                var txtaFormFormula = "";
                var ReportFormulaToSave="";
                var arrIds = new Array();
                var ResultStr = "";            
                var OpenedBrace = 0;
                var ClosedBrace = 0;
                var arrColIds = new Array();
                var arrDataTypesforCell = new Array();            
                var selAutoCol = "";
                var TestReportFormula ="";
                var verified=true;
                var vfrmFormulaCreation = "";
                $(document).ready(function() {
                    formulaTable();
                    vfrmFormulaCreation = document.getElementById('frmFormulaCreation');                                        
                    formatFormula();
                });
            </c:if>
                function formulaTable(){
                    if ($('#formulaTable tr').length == 2) {
                            $('#formulaTable').remove();
                    }
                }
                function formatFormula(){
                    $("td[formula='glow']").each(function(){                        
                        var tdformula = $.trim($(this).html());
                        var tfont = '<font color="#F27C6D" style="font-weight: bold">';
                        var tefont = '</font>';
                        tdformula = tdformula.replace(/\//g,' / ').replace(/-/g,' - ').replace(/\+/g,tfont+' + '+tefont).replace(/ - /g,tfont+' - '+tefont).replace(/\*/g,tfont+' * '+tefont).replace(/\(/g,tfont+' ( '+tefont).replace(/\)/g,tfont+' ) '+tefont).replace(/ \/ /g,tfont+' / '+tefont);
                        $(this).html(tdformula);
                    });                     
                }
                function validateFormula(){
                    var vbool = true;
            <c:if test="${(noautocol ne true) and (fn:length(autoCols) ne 0)}">
                    vbool = FormulaSave(vfrmFormulaCreation);
                    $('#txtFormFormula2').val(ReportFormulaToSave);
            </c:if>
                    vbool = vbool ? valOnSubmit() : false;                    
                    if(vbool && $('#chktotalFormula').val()!=undefined){
                        if(ReportFormulaToSave==''){
                            var cntGTChecked = 0;                       
                            $(":checkbox[id='chktotalFormula']").each(function(){
                                if($(this).attr('checked')){
                                    cntGTChecked++;
                                }
                            });
                            if(cntGTChecked==0){                                
                                jAlert('No grandtotal formula selected',MSG_AUC_FORMULALERT, function(RetVal) {
                                });
                                vbool = false;
                            }
                        }
                    
            <%--<c:if test="${seletedGovCol eq null}">
                        var gtcount = 0;
                        var prprcount = 0;
                        $(":checkbox[id='chktotalFormula']").each(function(){
                            if($(this).attr('checked')){
                                if($(this).val() == $('#selGovCol').val()){
                                    prprcount++;
                                }
                                gtcount++;
                            }
                        });                        
                        if($('#selGovCol').val()!='' && prprcount==0){
                            vbool= false;
                            jAlert("<spring:message code="msg_tender_valid_formula_gov"/>","<spring:message code="msg_tender_formulalert"/>", function(RetVal) {
                            });  
                        }
                        if(gtcount==0){
                            vbool= false;                            
                            jAlert("<spring:message code="msg_tender_valid_formula_gtcol"/>","<spring:message code="msg_tender_formulalert"/>", function(RetVal) {
                            });   
                        }
            </c:if>            //remgovcol--%>
                    }
                    return disableBtn(vbool);
                }
                function deleteFormula(rebateCheck){
                    var isDel = true;
                    if(parseInt(rebateCheck) > 0){
                        isDel = confirm('${rebateAvail}' == '0' ? '<spring:message code="msg_delformula_summary"/>' : '<spring:message code="msg_delformula_rebate"/>');
                    }                    
                    <%--if('${gtw}'=='1'){                    
                        if('${seletedGovCol}'!='' && '${seletedGovCol}' == $.trim($('#sp_'+colName).html())){
                            isDel = false;
                            jAlert("<spring:message code="msg_tender_valid_formula_govremadd"/>","<spring:message code="msg_tender_formulalert"/>", function(RetVal) {});                        
                        }
                        if($('#chktotalFormula').val()==undefined && $('#selGovCol').val() != undefined){
                            isDel = false;
                            jAlert("<spring:message code="msg_tender_valid_formula_govadd"/>","<spring:message code="msg_tender_formulalert"/>", function(RetVal) {});
                        }
                    }//remgovcol--%>               
                    return isDel ? confirm('<spring:message code="msg_tender_valid_formula_delform"/>') : false;
                }
                function validateDelFormula(){
                    var counter=0;
                    var rebateCheck=0
                    $('input[type="checkbox"][id="chkFormulaId"]').each(function(){
                       if($(this).is(':checked')){
                           if($(this).attr('cellId')!='0'){
                               rebateCheck = $(this).attr('cellId');
                           }
                           counter++;
                       }
                    });
                    if(counter!=0){
                        var isDel = true;
                        if(parseInt(rebateCheck) > 0){
                            isDel = confirm('${rebateAvail}' == '0' ? '<spring:message code="msg_delformula_summary"/>' : '<spring:message code="msg_delformula_rebate"/>');
                        }
                        return isDel ? confirm('<spring:message code="msg_tender_valid_formula_delform"/>') : false;
                    }else{
                        return false;
                    }
                }
                function selectAll(){
                    $('input[type="checkbox"][id="chkFormulaId"]').each(function(){                        
                        if($('#checkAll').is(':checked')){
                                $(this).attr('checked',true);
                        }else{
                            $(this).removeAttr('checked');
                        }
                     });
                        
                }
        </script>
    </head>
    <body>          
        <spring:message code="fields_tender_step1" var="step1"/>
        <spring:message code="fields_tender_step2" var="step2"/>
        <spring:message code="fields_tender_step3" var="step3"/>
        <spring:message code="fields_tender_step4" var="step4"/>
        <spring:message code="fields_tender_step5" var="step5"/>
        <spring:message code="btn_tender_saveformula" var="saveformula"/>
        <%--<spring:message code="btn_tender_savegovcol" var="savegovcol"/>//remgovcol--%>
        <spring:message code="fields_tender_createformula" var="createformula"/>
        <spring:message code="fields_tender_autocol" var="autocol"/>
        <%--<spring:message code="fields_tender_govcol" var="govcol"/>//remgovcol--%>
        <spring:message code="col_srno" var="thsrno"/>  
        <spring:message code="th_tender_formulafor" var="thformulafor"/>  
        <spring:message code="th_tender_formula" var="thformula"/>  
        <spring:message code="th_tender_action" var="thaction"/>  
        <%--<spring:message code="link_tender_remgov" var="remgov"/>//remgovcol--%>
        <%--<spring:message code="msg_tender_valid_formula_delgovcol" var="delgovcol"/>//remgovcol--%>
        <spring:message code="lbl_tender_createdformula" var="createdformula"/>
        <spring:message code="tender_next_step" var="formulanextstep"/>
            <%@include file="../../includes/AfterLoginTop.jsp"%>            
        <div class="main_container o-hidden" id="temp">
				<div class="container_25">
    				<div class="content_section" > 
		            	          <!--***************Right Part Starts Form Here**********-->  
                        <section class="inner-right-bar pull-left">                            
                            <c:if test="${not empty successMsg}"><div class="alert alert-success"><spring:message code="${successMsg}"/></div></c:if>
                            <c:if test="${not empty errorMsg}"><div class="alert alert-danger"><spring:message code="${errorMsg}"/></div></c:if>
                            <!--Write Content here-->                            
                            <div class="page-title prefix_1 o-hidden"><h1 class="pull-left grid_6">${createformula}</h1>
                                    <span class="pull-right go-back"><spring:message code="goback_formdash" var="goBack"/>
                                        <abc:href href="etender/buyer/formdashboard/${tenderId}/${formId}" label="${goBack}"/>
                                    </span>
                                </div>   
                                <form method="post" action="<spring:url value='/etender/buyer/addformformula'/>" onsubmit="return validateFormula();" id="frmFormulaCreation" name="frmFormulaCreation">                                
                                    <abc:hidden tagid="TenderId" jsrequired="false" value="${tenderId}"/>
                                    <abc:hidden tagid="FormId" jsrequired="false" value="${formId}"/>
                                    <abc:hidden tagid="TableId" jsrequired="false" value="${tableId}"/>
                                    <abc:hidden tagid="ColCount" jsrequired="false" value="${colcount}"/>
                                    <abc:hidden tagid="RowCount" jsrequired="false" value="${rowcount}"/>
                                    <abc:hidden tagid="FromDash" jsrequired="false" value="${fromDash}"/>
                                    <abc:hidden tagid="HasGTRow" jsrequired="false" value="${hasGTRow}"/>
                                    <%--tenderResult[1-GTW,2-IW,3-Both]--%>
                                    <div class="mini-formfield m-top0">                                    
                                        <c:choose>
                                            <c:when test="${noautocol ne true}">
                                                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                                <tr height="50px">
                                                    <td width="8%" class="v-a-middle">${step1} </td>
                                                    <td width="92%" class="v-a-middle">
                                                        <abc:select cssclass="grid_6" title="${autocol}" tagid="AutoCol" jsrequired="true"  defvalue="-Select-" items="${autoCols}"
                                                                    onchange="setFormulaTo(vfrmFormulaCreation, this);" isrequired="${fn:length(autoCols) ne 0}"/>
                                                    </td>
                                                </tr>
                                                </table>
                                                   
                                                        <span class="pull-left" style="padding:10px 31px 10px 10px;">${step2} </span>
                                                        <%--
                                                            Filled By - Tenderer:1, Bidder:2, Auto:3, Proxy Bid Column:4
                                                            Data Type - SmallText:1, LongText:2, +No. with (.):3, +No. without (.):4, All Numbers:8            
                                                        --%>
                                                        <c:set value="" var="colIds"/>
                                                        <c:set value="" var="colSorts"/>
                                                        <c:set value="" var="colHeads"/>
                                                        <c:set value="0" var="totalFormulaCnt"/>
                                                        <span class="o-auto-relative display">
                                                            <table class="matrix-table border-left border-right table-right-border" width="100%" cellspacing="0" cellpadding="0" border="0">
                                                                <tr class="gray border-top border-bottom">
                                                                    <c:forEach var="column" items="${columns}" varStatus="cnt">
                                                                        <td class="a-center" valign="top" id="tddata_${cnt.index}">
                                                                            ${column.columnHeader}
                                                                            <c:if test="${tenderResult ne 2}">
                                                                                <c:if test="${(column.filledBy eq 3 and (column.dataType eq dtnumeric or column.dataType eq dtmoney or column.dataType eq dtmoneyall)) or (column.filledBy eq 2 and (column.dataType eq dtnumeric or column.dataType eq dtmoney or column.dataType eq dtmoneyall))}">
                                                                                    <c:set var="showTotalFormula" value="true"/>
                                                                                    <c:forEach var="formula" varStatus="cnt" items="${formulas}">                                                                                    
                                                                                        <c:if test="${column.columnId eq formula.tblTenderColumn.columnId and fn:indexOf(formula.displayFormula,'TOTAL(') ne -1}">
                                                                                            <c:set var="showTotalFormula" value="false"/>                                                                                        
                                                                                        </c:if>
                                                                                    </c:forEach>
                                                                                    <c:if test="${showTotalFormula eq 'true'}">                                                                                    
                                                                                        <abc:checkbox jsrequired="false" tagid="totalFormula" item="${column.columnId}_${column.sortOrder}_${column.columnNo}"/>
                                                                                        <c:set value="${totalFormulaCnt1+1}" var="totalFormulaCnt"/>
                                                                                    </c:if>                                                                                
                                                                                </c:if>
                                                                                <c:set value="${colIds}${column.columnId}," var="colIds"/>
                                                                                <c:set value="${colSorts}${column.sortOrder}," var="colSorts"/>
                                                                                <c:set value="${colHeads}${column.columnHeader}," var="colHeads"/>
                                                                            </c:if>
                                                                        </td>   
                                                                    </c:forEach>
                                                                </tr>                                                      
                                                                <tr id="rowtr_0">                                                                            
                                                                    <c:forEach var="column" items="${columns}" varStatus="cntcol">                                                                                
                                                                        <td class="a-center" valign="top" id="tdrow_0_${cntcol.index}">
                                                                            <c:choose>
                                                                                <c:when test="${column.filledBy eq 3 or column.dataType eq dtnumeric or column.dataType eq dtmoney or column.dataType eq dtmoneyall}">
                                                                                     <c:if test="${column.filledBy eq 4 and column.tblColumnType.columnTypeId eq 23 and (column.dataType eq dtnumeric or column.dataType eq dtmoney or column.dataType eq dtmoneyall)}">
                                                                                            <script type="text/javascript">
                                                                                                var isLoadingFactorDisabled = true;
                                                                                            </script>
                                                                                    </c:if>
                                                                                    <input class="grid_20" type="text" id="txtcell_0_${column.columnNo}" name="txtcell_0_${column.columnNo}" title="${cellvalue}"  nametodisplay="${column.columnHeader}"  onclick="return BuildFormula(vfrmFormulaCreation,this,this);" datatype="${column.dataType}"/>
                                                                                </c:when>
                                                                                <c:when test="${column.dataType eq dtcombo}">
                                                                                    <select class="grid_20" id="txtcell_0_${column.columnNo}" name="txtcell_0_${column.columnNo}" title="${cellvalue}"  nametodisplay="${column.columnHeader}" onclick="return BuildFormula(vfrmFormulaCreation,this,this);" datatype="${cells[cntcol.index].dataType}">
                                                                                    <c:forEach items="${combos}" var="combo">                                                                                            
                                                                                        <c:if test="${cells[cntcol.index].objectId eq combo.tblCombo.comboId}">
                                                                                                <option value="${combo.optionValue}">${combo.optionName}</option>
                                                                                        </c:if>
                                                                                    </c:forEach>
                                                                                         </select>
                                                                                    <script type="text/javascript">if($('#txtcell_0_${cntcol.count}').val()==null){$('#txtcell_0_${cntcol.count}').remove();}</script>                                                                                            
                                                                                </c:when>    
                                                                                <c:otherwise>${cells[cntcol.index].cellValue}</c:otherwise>
                                                                            </c:choose>
                                                                        </td>
                                                                    </c:forEach>
                                                                </tr>
                                                            </table>
                                                        </span>
                                                        <table width="100%" cellpadding="0" cellspacing="0" border="0" class="mini-formfield border-left border-right border-top">
                                                            <tr>
                                                                <td class="v-a-top" width="28%">                                                                    
                                                                    <div id="calbtns" class="m-top">
                                                                        <button id="mul" type="button" onclick="return addExpression(vfrmFormulaCreation,this);" value="*">*</button>
                                                                        <button id="add" type="button"  onclick="return addExpression(vfrmFormulaCreation,this);" value="+">+</button>
                                                                        <button id="minus" type="button"  onclick="return addExpression(vfrmFormulaCreation,this);" value="-">-</button>
                                                                        <button id="divide" type="button" onclick="return addExpression(vfrmFormulaCreation,this);" value="/">/</button><br/>
                                                                        <button id="startBrace" type="button" onclick="return addExpression(vfrmFormulaCreation,this);" value="(">(</button>
                                                                        <button id="endBrace" type="button" onclick="return addExpression(vfrmFormulaCreation,this);" value=")">)</button>
                                                                        <button id="CustomeNumber" type="button"  onclick="return addExpression(vfrmFormulaCreation,this);" value="Number">Number</button>
                                                                    </div>
                                                                    <div id="wordchk">
                                                                        <abc:checkbox jsrequired="false" tagid="Word" item="1" onclick="return false;"/><spring:message code="label_tender_inwords"/>                                                                        
                                                                    </div>
                                                                </td>
                                                                <td rowspan="2" class="a-center">
                                                                    <textarea class="m-top1 grid_24"  rows="8" readonly="true" onblur="validateTxtComp(this)" name="frmaFormFormula" id="txtaFormFormula"></textarea>                                                            
                                                                    <input type="hidden" id="txtFormFormula" name="frmFormFormula"/>
                                                                    <input type="hidden" id="txtFormFormula2" name="frmFormFormula2"/>
                                                                </td>                                                                
                                                            </tr>
                                                            <tr>
                                                                <td align="left" valign="middle" class="v-a-middle">
                                                                    <button name="undo" type="button" onclick="UndoChange(vfrmFormulaCreation);"><spring:message code="auc_formula_lblundo"/></button> <button name="clear" type="button" onclick="return clearAll(vfrmFormulaCreation);"><spring:message code="auc_formula_lblclear"/></button></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                                <tr>
                                                    <td  valign="top" width="8%" >${step3} </td>
                                                    <td width="92%">                                                
                                                        <button id="TestFormula" name="TestFormula" type="button" class="m-top"  onclick="testformula(vfrmFormulaCreation)"><spring:message code="auc_formula_lbltestformula"/></button>
                                                        <input type="hidden" id="testedornot" value="n" />
                                                    </td>
                                                </tr>                                                
                                                <c:set var="btnCap" value="${saveformula}"/>
                                            </c:when>
                                            <c:otherwise>
                                                <c:set var="step4" value="${step1}"/>
                                                <c:set var="step5" value="${step2}"/>
                                                <%--<c:set var="btnCap" value="${savegovcol}"/>//remgovcol--%>
                                                <c:if test="${tenderResult ne 2}">
                                                    <c:set var="step4" value="${step2}"/>
                                                    <c:set var="step5" value="${step3}"/>
                                                    <c:set var="btnCap" value="${saveformula}"/>
                                                    <span class="pull-left" style="padding:10px 31px 10px 10px;">${step1} </span>
                                                            <%--
                                                                Filled By - Tenderer:1, Bidder:2, Auto:3, Proxy Bid Column:4
                                                                Data Type - SmallText:1, LongText:2, +No. with (.):3, +No. without (.):4, All Numbers:8            
                                                            --%>
                                                            <c:set value="" var="colIds"/>
                                                            <c:set value="" var="colSorts"/>
                                                            <span class="o-auto-relative display">
                                                                <table class="matrix-table border-left border-right table-right-border" width="100%" cellspacing="0" cellpadding="0" border="0">
                                                                    <tr class="gray border-top border-bottom">
                                                                        <c:forEach var="column" items="${columns}" varStatus="cnt">
                                                                            <th valign="top" id="tddata_${cnt.index}">
                                                                                ${column.columnHeader}
                                                                                <c:if test="${(column.filledBy eq 3 and (column.dataType eq dtnumeric or column.dataType eq dtmoney or column.dataType eq dtmoneyall)) or (column.filledBy eq 2 and (column.dataType eq dtnumeric or column.dataType eq dtmoney or column.dataType eq dtmoneyall))}">
                                                                                    <c:set var="showTotalFormula" value="true"/>
                                                                                    <c:forEach var="formula" varStatus="cnt" items="${formulas}">                                                                                    
                                                                                        <c:if test="${column.columnId eq formula.tblTenderColumn.columnId and fn:indexOf(formula.displayFormula,'TOTAL(') ne -1}">
                                                                                            <c:set var="showTotalFormula" value="false"/>                                                                                        
                                                                                        </c:if>
                                                                                    </c:forEach>
                                                                                    <c:if test="${showTotalFormula eq 'true'}">                                                                                    
                                                                                        <abc:checkbox jsrequired="false" tagid="totalFormula" item="${column.columnId}_${column.sortOrder}_${column.columnNo}"/>
                                                                                    </c:if>
                                                                                </c:if>
                                                                                <c:set value="${colIds}${column.columnId}," var="colIds"/>
                                                                                <c:set value="${colSorts}${column.sortOrder}," var="colSorts"/>
                                                                                <c:set value="${colHeads}${column.columnHeader}," var="colHeads"/>
                                                                            </th>   
                                                                        </c:forEach>
                                                                    </tr>                                                      
                                                                    <tr id="rowtr_0">                                                                            
                                                                        <c:forEach var="column" items="${columns}" varStatus="cntcol">                                                                                
                                                                            <td class="t-align-center" valign="top" id="tdrow_0_${cntcol.index}">                                                                                
                                                                                <c:choose>
                                                                                    <c:when test="${column.filledBy eq 3 or column.dataType eq dtnumeric or column.dataType eq dtmoney or column.dataType eq dtmoneyall}">
                                                                                        <input type="text" id="txtcell_0_${column.columnNo}" name="txtcell_0_${column.columnNo}" title="${cellvalue}"  nametodisplay="${column.columnHeader}"  onclick="return BuildFormula(vfrmFormulaCreation,this,this);" datatype="${column.dataType}"/>
                                                                                    </c:when>
                                                                                    <c:when test="${column.dataType eq dtcombo}">
                                                                                        <select id="txtcell_0_${column.columnNo}" name="txtcell_0_${column.columnNo}" title="${cellvalue}"  nametodisplay="${column.columnHeader}" onselect="return BuildFormula(vfrmFormulaCreation,this,this);" datatype="${cells[cntcol.index].dataType}">
                                                                                        <c:forEach items="${combos}" var="combo">                                                                                            
                                                                                            <c:if test="${cells[cntcol.index].objectId eq combo.tblCombo.comboId}">
                                                                                                    <option value="${combo.optionValue}">${combo.optionName}</option>
                                                                                            </c:if>
                                                                                        </c:forEach>
                                                                                             </select>
                                                                                    </c:when>    
                                                                                    <c:otherwise>${cells[cntcol.index].cellValue}</c:otherwise>
                                                                                </c:choose>
                                                                            </td>
                                                                        </c:forEach>
                                                                    </tr>
                                                                </table>  
                                                            </span>
                                                            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                                </c:if>                                                
                                            </c:otherwise>
                                        </c:choose>
                                        <%--<tr>
                                            <td  valign="top" class="f-big f-bold">${step4} </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${seletedGovCol eq null}">
                                                        <abc:select title="${govcol}" isrequired="true" defvalue="-- ${govcol} --" items="${govCols}" jsrequired="false" tagid="GovCol"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span style="color: green;font-weight: bold;">"${seletedGovCol}" <spring:message code="auc_formula_isgovcol"/></span>
                                                        <abc:href href="etender/buyer/changegovcol/${tenderId}/${formId}/${tableId}/${seletedGovColId}/${rowcount}/${gtw}/${fromDash}" label="${remgov}" onclick="return confirm('${delgovcol}');"/>
                                                    </c:otherwise>
                                                </c:choose>                                                            

                                            </td>
                                        </tr>//remgovcol--%>                                        
                                        <tr>
                                             <td  valign="top" width="8%" >${step4} </td>
                                                    <td width="92%">                                           
                                                <button type="submit" class="blue-button-small" name="SaveFormula" id="SaveFormula" <c:if test="${(conditionBtn eq true and totalFormulaCnt eq 0)}"> disabled="true" </c:if> >${btnCap}</button><%--<c:if test="${(noautocol eq true and seletedGovCol ne null)}">disabled="true"</c:if>--%>
                                                </td>
                                            </tr>
                                        </table> 
                                                </div>           
                                    <c:if test="${fn:length(colIds) ne 0}">                                        
                                        <abc:hidden jsrequired="false" tagid="ColIds" value="${colIds}"/>
                                    </c:if>
                                    <c:if test="${true or fn:length(colSorts) ne 0}">                                        
                                        <abc:hidden jsrequired="false" tagid="ColSorts" value="${colSorts}"/>
                                    </c:if>            
                                    <c:if test="${fn:length(colHeads) ne 0}">
                                        <abc:hidden jsrequired="false" tagid="ColHeads" value="${colHeads}"/>
                                    </c:if>
                                </form>
                                <c:if test="${fn:length(formulas) ne 0}">                                                                            
                                    <c:set var="formulaCnt" value="0"/>
                                    <form method="post" action="<spring:url value='/etender/buyer/deleteformula'/>" onsubmit="return validateDelFormula();">
                                        <abc:hidden tagid="TenderId" jsrequired="false" value="${tenderId}"/>
                                        <abc:hidden tagid="FormId" jsrequired="false" value="${formId}"/>
                                        <abc:hidden tagid="TableId" jsrequired="false" value="${tableId}"/>                                       
                                        <abc:hidden tagid="RowCount" jsrequired="false" value="${rowcount}"/>
                                        <abc:hidden tagid="FromDash" jsrequired="false" value="${fromDash}"/>
                                        <abc:hidden tagid="HasGTRow" jsrequired="false" value="${hasGTRow}"/>                                                                                   
                                    <table width="100%" cellpadding="0" cellspacing="0" border="0" class="tableView_1 m-top border-top-none" id="formulaTable">
                                        <tr>
                                            <th colspan="4" class="detailHeader" style="text-align: left;">${createdformula}</th>
                                        </tr>
                                        <tr class="gradi">                
                                            <td width="10%" class="border-right a-center"><input type="checkbox" id="checkAll" onclick="selectAll();"></td>
                                            <td width="10%" class="border-right a-center"><label>${thsrno}</label></td>
                                            <td width="15%" class="border-right a-center"><label>${thformulafor}</label></td>
                                            <td width="65%" class="border-right a-center"><label>${thformula}</label></td>
                                            <%--<td width="10%" class="border-right a-center"><label>${thaction}</label></td>--%>
                                        </tr>
                                        <c:forEach var="formula" varStatus="cnt" items="${formulas}">
                                            <c:if test="${(fn:startsWith(formula.formula, 'VCF_') or fn:startsWith(formula.formula, 'SPF_') or fn:startsWith(formula.formula, 'VF_')) eq false}">
                                            <c:set var="formulaCnt" value="${formulaCnt + 1}"/>
                                            <tr>
                                                <td class="border-right a-center">
                                                    <c:set var="cellId" value="${rebateAvail ne -1 and fn:indexOf(formula.displayFormula, 'TOTAL') ne -1 ? gtCols[formula.tblTenderColumn.columnId] eq null ? 0 : gtCols[formula.tblTenderColumn.columnId] : 0}"/>
                                                    <%--<abc:checkbox item="${formula.formulaId}_${formula.tblTenderColumn.columnId}_${cellId}" jsrequired="false" tagid="FormulaId"/>--%>
                                                    <input type="checkbox" value="<abc:encdec value="${formula.formulaId}_${formula.tblTenderColumn.columnId}_${cellId}" isenc="true"/>" id="chkFormulaId" name="chkFormulaId" cellId="${cellId}"/>
                                                </td>
                                                <td class="border-right a-center">${formulaCnt}</td> 
                                                <td class="border-right a-center">
                                                    <span id="sp_${formula.formulaId}">
                                                        <c:choose>
                                                            <c:when test="${fn:indexOf(formula.displayFormula,'=') ne -1}">
                                                                ${fn:substringBefore(formula.displayFormula,'=')}
                                                            </c:when>
                                                            <c:otherwise>
                                                            	<c:choose>
                                                            		<c:when test="${fn:indexOf(formula.displayFormula,'TOTAL(') ne -1}">
                                                            			<c:set var="formulaTotalPost" value="${fn:substringAfter(formula.displayFormula,'TOTAL(')}"/>
                                                            			${fn:substring(formulaTotalPost, 0, fn:length(formulaTotalPost)-1)}
                                                            		</c:when>
                                                            		<c:otherwise>
                                                            			  ${fn:replace(fn:replace(formula.displayFormula, "TOTAL(", ""), ")", "")}
                                                            		</c:otherwise>
                                                            	</c:choose>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </td> 
                                                <td class="border-right a-center" formula="glow">
                                                    <c:choose>                                                        
                                                        <c:when test="${fn:indexOf(formula.displayFormula,'=') ne -1}">                                                        
                                                            ${fn:substringAfter(formula.displayFormula,'=')}
                                                        </c:when>
                                                        <c:otherwise>
                                                            ${formula.displayFormula}
                                                        </c:otherwise>
                                                    </c:choose>                                                    
                                                </td>                                                 
                                                <%--<td class="border-right a-center">
                                                    <abc:href href="etender/buyer/deleteformula/${tenderId}/${formId}/${tableId}/${formula.tblTenderColumn.columnId}/${formula.formulaId}/${rowcount}/${gtw}/${fromDash}/${rebateAvail ne -1 and fn:indexOf(formula.displayFormula, 'TOTAL') ne -1 ? gtCols[formula.tblTenderColumn.columnId] eq null ? 0 : gtCols[formula.tblTenderColumn.columnId] : 0}" label="Delete" onclick="return deleteFormula('${rebateAvail ne -1 and fn:indexOf(formula.displayFormula, 'TOTAL') ne -1 ? gtCols[formula.tblTenderColumn.columnId] eq null ? 0 : gtCols[formula.tblTenderColumn.columnId] : 0}');"/>                                                    
                                                    
                                                </td>--%>
                                            </tr>
                                            </c:if>
                                        </c:forEach>
                                    </table>
                                        <div class="a-center">
                                        <button type="submit" class="blue-button-small">Delete Formula</button>
                                            </div>
                                    </form>
                                </c:if>                                 
                        <!--***********Right Part Ends here***********-->   
                        <span class="pull-right go-back"><spring:message code="goback_formdash" var="goBack"/>
                                        <abc:href href="etender/buyer/formdashboard/${tenderId}/${formId}" label="${goBack}"/>
                        </span>
            </section>
                        <!--***********Right Part Ends here***********-->
                     </div>
                  </div>
            </div>
        <%@include file="../../includes/footer.jsp"%>
            <!--Body Part End--> 
         <script type="text/javascript">
            $(".submenu li a.active").each(function(){
               $(this).removeClass('active');
            });
            $(function() {
            	$("#acc3").accordion({initShow: "#H3Industy_5"});                
           });
        </script>  
    </body>
</html>