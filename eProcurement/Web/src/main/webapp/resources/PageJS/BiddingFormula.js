//Variable Declaration  
  var isLoadingFactorDisabled = false;
  var theform =$("#frmFormulaCreation");
  var selAutoCol="";
  var arrIds = new Array();
  var txtaFormFormula = "";
  var ReportFormulaToSave="";
  var OpenedBrace = 0;
  var ClosedBrace = 0;
  var TestReportFormula ="";
  var ResultStr = "";
  var decimalValueUpto = 2;
  var verified=true;
  var MSG_AUC_FORMULALERT = "Please Select Formula";
  var MSG_AUC_CREATEFORMULA = "Please Create Formula";
  var MSG_AUC_PREPARETEST = "Please Test Formula Before Submit";
  var MSG_AUC_SOMEBRAC = "Please check Brackets.You might have missed brackets in formula";
  var MSG_AUC_FILLVALTEST = "Please Select Value For Testing";
  var MSG_AUC_PROPERFORMULA = "Please Enter Proper Formula";
  var MSG_LOADING_WITH_ZERO = "Zero is not allowed";
  var MSG_AUC_TESTFORMULA = "Please test Formula";
  var MSG_AUC_CHARSIZE = "Character Size is Invalid"       ;                                           
  var MSG_AUC_REMOVELEADZERO = "Please Remove leading Zero from Inputs"  ;
  var MSG_AUC_ALLOWPOSITIVENUM = "Allows Only Possitive Numbers.Please Enter Proper value.";
  var arrDataTypesforCell = new Array();            
               

function setFormulaTo(cmb){
// debugger;
    
    $('[id^="tbl_"]').hide();

    $("#tbl_" + cmb.value).show();
    $("#dvFormulaCal").show();
    if(cmb.value!=-1){
        selAutoCol = cmb.options[cmb.selectedIndex].text  + " = ";
    }
    else{
          $("#dvFormulaCal").hide();
        selAutoCol = "";
    }
    
    /*if(cmb.value.indexOf('_true', 0)!=-1){
        $('#calbtns').hide();
        $('#wordchk').show();
        $('#chkWord').attr('checked', true);
    }else if(cmb.value.indexOf('_false', 0)!=-1){
        $('#calbtns').show();
        $('#wordchk').hide();
        $('#chkWord').removeAttr('checked');
    }*/
    clearAll(theform);
}

function clearAll(theform){
    $("#txtaFormFormula").val(selAutoCol);
  //  theform.txtaFormFormula.value=selAutoCol;
    txtaFormFormula = "";
    ReportFormulaToSave="";
    $("#txtFormFormula2").val("");
    $("#txtFormFormula").val("");
    ResultStr = "";
    OpenedBrace = 0;
    ClosedBrace	= 0;
    arrIds = null;
    arrIds = new Array();   
}

function BuildFormula( tBox)
{
    debugger;
    //When a textBox is Clicked
    //alert(tBox.value);
    //alert("k" + tBox.location);
   /* var govColId = parseInt($('#selAutoCol').val().split('_')[1]);
    if(tBox.id != "txtcell_0_"+govColId && (tBox.getAttribute('datatype')=='3' || tBox.getAttribute('datatype')=='4' || tBox.getAttribute('datatype')=='5' || tBox.getAttribute('datatype')=='6')){        
        if(theform.txtaFormFormula.value!=0){
            if(arrIds.length==0){
                setValues(theform,tBox.getAttribute('nametodisplay'),tBox.id,tBox.id);
                return;
            }
            else if(arrIds[arrIds.length-1]=="+"||arrIds[arrIds.length-1]=="*"||arrIds[arrIds.length-1]=="/"||arrIds[arrIds.length-1]=="-"||arrIds[arrIds.length-1]=="("){
                //setValues(theform,document.getElementById("td"+tableId+"_"+cnt).title,tBox.id,tBox.id.substring(tBox.id.indexOf("Col")+3,tBox.id.length));
                setValues(theform,tBox.getAttribute('nametodisplay'),tBox.id,tBox.id);
                return;
            }
        }
    }*/
    if($("#txtaFormFormula").val() != "0")
    {
        var nametodisplay = $(tBox).attr("nametodisplay");
    
         if(arrIds.length==0){
            
                setValues(theform,nametodisplay,tBox.id,tBox.id);
                return;
            }
            else if(arrIds[arrIds.length-1]=="+"||arrIds[arrIds.length-1]=="*"||arrIds[arrIds.length-1]=="/"||arrIds[arrIds.length-1]=="-"||arrIds[arrIds.length-1]=="("){
                //setValues(theform,document.getElementById("td"+tableId+"_"+cnt).title,tBox.id,tBox.id.substring(tBox.id.indexOf("Col")+3,tBox.id.length));
                setValues(theform,tBox.getAttribute('nametodisplay'),tBox.id,tBox.id);
                return;
            }
    }
}

function setValues(theform,value1,value2,value3){
   $("#txtaFormFormula").val($("#txtaFormFormula").val() + value1);
    $("#txtFormFormula").val($("#txtFormFormula").val() + value2);
    txtaFormFormula += value2;
    arrIds.push(value2);
//    alert("value2::"+value2);
//    alert("arrIds::"+arrIds);
    ReportFormulaToSave += value3;
    
}

function addExpression(btn) //When a Expression is Selected
{
    if($("#txtaFormFormula").val()!=0)
    {
        if(btn.value=="(")
        {
            if(txtaFormFormula=="")
            {
                OpenedBrace++;
                setValues(theform,btn.value,btn.value,btn.value);
                return;
            }
            else if(arrIds[arrIds.length-1]=="+"||arrIds[arrIds.length-1]=="*"||arrIds[arrIds.length-1]=="/"||arrIds[arrIds.length-1]=="-")
            {
                OpenedBrace++;
                setValues(theform,btn.value,btn.value,btn.value);
                return;
            }
        }
        else if(btn.value==")")
        {
            if(arrIds[arrIds.length-1]!="+"||arrIds[arrIds.length-1]!="*"||arrIds[arrIds.length-1]!="/"||arrIds[arrIds.length-1]!="-"||arrIds[arrIds.length-1]!="("||arrIds[arrIds.length-1]!=")")
            {
                if(ClosedBrace<OpenedBrace)
                {
                    ClosedBrace++;
                    setValues(theform,btn.value,btn.value,btn.value);
                }
                return;
            }
        }
        else if(btn.value=="Number")
        {
            //alert("number"+btn.value);
            if(arrIds[arrIds.length-1]==undefined||arrIds[arrIds.length-1]=="+"||arrIds[arrIds.length-1]=="*"||arrIds[arrIds.length-1]=="/"||arrIds[arrIds.length-1]=="-")
            {
                var answer = prompt("Enter Number","");
                if(answer!=undefined && !isNaN(answer)){
                    setValues(theform,answer,answer,"N_"+answer);
                }
            }
        }
        else if(arrIds[arrIds.length-1]!="+"&&arrIds[arrIds.length-1]!="*"&&arrIds[arrIds.length-1]!="/"&&arrIds[arrIds.length-1]!="-"&&arrIds[arrIds.length-1]!="Number"&&arrIds[arrIds.length-1]!="("&&arrIds.length>0)
        {
            setValues(theform,btn.value,btn.value,btn.value);
            return;
        }
        else if(btn.value=="%")
        {
            setValues(theform,'p','p','p');
            return;
        }
    }
}


function testformula()
{
    debugger;
    if(document.getElementById("txtaFormFormula").value=="")
    {
        jAlert(MSG_AUC_CREATEFORMULA,MSG_AUC_FORMULALERT, function(RetVal) {
            });
        return false;
    }

    var	cmb = document.getElementById("selAutoCol");
    ResultStr = "";

    if($("#txtaFormFormula").val()=="")
    {
        jAlert(MSG_AUC_PREPARETEST,MSG_AUC_FORMULALERT, function(RetVal) {
            });
        return false;
    }
    else if(OpenedBrace!=ClosedBrace)
    {
        jAlert(MSG_AUC_SOMEBRAC,MSG_AUC_FORMULALERT, function(RetVal) {
            });
        return false;
    }
    else
    {
        for(var i=0;i<arrIds.length;i++)
        {
            if((arrIds[i]).match("_"))
            {
                if(document.getElementById(arrIds[i])!=null)
                {
                     $('[id^="' +  arrIds[i] +'"]').each(function () {
                        if($(this).attr("autocolumnid") == $("#formulaColumn").val()){
                             if($(this).val() != "") 
                             {
                                    if(parseFloat($(this).val()) != 0){
                                        ResultStr += trim($(this).val().replace(/^[0]+/g,""));
                                    }else{  
                                        ResultStr += '0';
                                    }
                             }
                             else
                             {
                                    jAlert(MSG_AUC_FILLVALTEST ,MSG_AUC_FORMULALERT, function(RetVal) {});
                                    ResultStr = "";
                                    return false;
                             }
                        }
                     });
                }
                else
                {
                    ResultStr += trim(arrIds[i]);
                    ResultStr = ResultStr.replace('p','100');
                }
            }
            else
            {
                ResultStr += arrIds[i];
            }
        }
        if(isNaN(eval(ResultStr)))
        {
//            alert('hieghsgh');
            //alert(ResultStr);
            jAlert(MSG_AUC_PROPERFORMULA ,MSG_AUC_FORMULALERT, function(RetVal) {
                });
            return false;
        }
        else
        {
           /* if(theform.chkWord.checked)
            {
                var govColId = parseInt($('#selAutoCol').val().split('_')[1]);
                document.getElementById("txtcell_0_"+govColId).value = DoIt(Math.round(eval(eval(ResultStr)*1000))/1000);
                ReportFormulaToSave = 'WORD('+txtaFormFormula+')';
                TestReportFormula="OK";
            }
            else
            {*/
		var govColId = parseInt($('#formulaColumn').val()); 
				 document.getElementById("txtCell_Result_" + govColId).value = Math.round(eval(eval(ResultStr)*1000))/1000;
		         if(isLoadingFactorDisabled){
		             if(document.getElementById("txtCell_Result_" + govColId).value == '0' || document.getElementById("txtCell_Result_" + govColId).value == 'Infinity'){
		                 jAlert(MSG_LOADING_WITH_ZERO,MSG_AUC_FORMULALERT, function(RetVal) {});                        
		             }else{
		                 TestReportFormula="OK";
		             }
		         }else{
		             TestReportFormula="OK";
		         }
            //}
            TestReportFormula="OK";
        }

    }  // end of for
}


function FormulaSave()
{
    if($('#formulaColumn').val()==-1)
    {
        jAlert("Please select Auto Column", "Error");
        return false;
    }
    else if($('#txtFormFormula').val()=="")
    {
        
        jAlert(MSG_AUC_PREPARETEST, MSG_AUC_FORMULALERT);
        return false;
    }

    if(TestReportFormula=="OK")
    {
        return true;
    }
    else
    {
       
        jAlert(MSG_AUC_TESTFORMULA, MSG_AUC_FORMULALERT);
        return false;
    }
   // return false;
//theform.txtFormFormula2.value += ReportFormulaToSave;
//theform.SaveTo.value = theform.selAutoCol.value;
}


function UndoChange()
{
    var len = $("#txtaFormFormula").val().length;
    var str = new String($("#txtaFormFormula").val());
    var lastChar = str.charAt(len-1);
    
    if(arrIds.length>0)
    {
if(lastChar=="+"||lastChar=="*"||lastChar=="-"||lastChar=="/")
        {
            txtaFormFormula = txtaFormFormula.substring(0,txtaFormFormula.length-1);
            str = str.substring(0,len-1);
            arrIds.pop(arrIds.length-1);
            ReportFormulaToSave = ReportFormulaToSave.substring(0,ReportFormulaToSave.length-1);
        }
        else if(lastChar=="(")
        {
            txtaFormFormula = txtaFormFormula.substring(0,txtaFormFormula.length-1);
            str = str.substring(0,len-1);
            OpenedBrace--;
            arrIds.pop(arrIds.length-1);
            ReportFormulaToSave = ReportFormulaToSave.substring(0,ReportFormulaToSave.length-1);
        }
        else if(lastChar==")")
        {
            txtaFormFormula = txtaFormFormula.substring(0,txtaFormFormula.length-1);
            str = str.substring(0,len-1);
            ClosedBrace--;
            arrIds.pop(arrIds.length-1);
            ReportFormulaToSave = ReportFormulaToSave.substring(0,ReportFormulaToSave.length-1);
        }
        else
        {
           // debugger;
            var a = arrIds[arrIds.length-1];
            txtaFormFormula = '';
            for(var formc=0;formc<(arrIds.length-1);formc++){
//                  txtaFormFormula = txtaFormFormula + arrIds[formc];
                txtaFormFormula = txtaFormFormula + (isNaN(arrIds[formc]) ? arrIds[formc] : 'N_'+arrIds[formc]);
            }
            ReportFormulaToSave = txtaFormFormula;
            arrIds.pop(arrIds.length-1);
            if(isNaN(a)){
                str = str.substring(0,str.length-$('#'+a).attr('nametodisplay').length);
            }else{
                str = str.substring(0,str.length-a.length);
            }
        }
        TestReportFormula = "";
        $("#txtaFormFormula").val(str);
        $("#txtFormFormula").val(ReportFormulaToSave);
    }
}



function editFormula(FormulaList)
{
    
    $('[id^="tbl_"]').hide();
     var cmb=document.getElementById("formulaColumn");
    var colId=$(FormulaList).attr("data_colId");
    var colName=$(FormulaList).attr("data_colName");
   // var colId=$("#data_colId").val();
     var formula=$(FormulaList).attr("data_colFormula");
     var formulaToDisplay=$(FormulaList).attr("data_colFormulaToDisplay");
     var formulaId=$(FormulaList).attr("data_formulaId");
     
    // alert("colId= "+colId);
    $('#formulaColumn option[value='+colId+']').prop('selected', true);
    
    $("#tbl_" + colId).show();
    $("#dvFormulaCal").show();
    if( cmb.value!=-1){
        selAutoCol = cmb.options[cmb.selectedIndex].text  + " = ";
    }
    else{
          $("#dvFormulaCal").hide();
        selAutoCol = "";
    }
     $("#txtaFormFormula").val(formulaToDisplay);
     
     var regex = /([\+\-\*\(\)\/])/;
     arrIds= formula.split(regex);
     //console.log(a);
     $("#txtFormFormula").val(formula);
       $("#hdnFormulaId").val(formulaId);
     
     

}

function callForDeleteFormula(){
	/* $.ajax({
		url:"/etender/buyer/publishtender/"+tenderId,
		success: function(result){
		console.log(result);
			location.reload();;
    }}); */
    if(confirm("Are you sure you want to delete formula ?"))
    {
    	return true;
    }	
    return false;
 }
             


