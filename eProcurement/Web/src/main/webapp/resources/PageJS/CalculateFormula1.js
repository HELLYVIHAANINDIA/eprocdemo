

var arr=new Array(); //Stores the Array of the TableIds
var first = false;
var LoopCounter = 0;
var rst = 0.0 ;
var newArr = new Array();
var chkEdit = false;
var chkBidTableId = new Array();
var arrBidCount = new Array();
//var addRowAfterEdit = new Array();
var signClick = false;
var verifyClick = 1;

var formulaArr=new Array();
var resultArr = new Array();
var templateFormulaArr = new Array();
var templateColIdArr = new Array();
var templateResultArr = new Array();

var isDataCorrupted = false;
var ifShowAlert = true;


function checkForAnySpaceOrNull()
{
    var inputtag = document.getElementsByTagName("input");
    var textareatag = document.getElementsByTagName("textarea");

    for(var inputcount=0;inputcount<inputtag.length;inputcount++)
    {
        if(inputtag[inputcount].value != null)
        {
            if(inputtag[inputcount].id == "signedData")
                continue;

            if(trim(inputtag[inputcount].type) == 'text' && trim(inputtag[inputcount].value) =="")
            {
                inputtag[inputcount].focus();
                return false;
            }
            else
            {
                if(trim(inputtag[inputcount].type) == 'text')
                {
                /*if(trim(inputtag[inputcount].value).indexOf(' ') > -1)
					{
						inputtag[inputcount].focus();
						//alert(" in " + inputtag[inputcount].id);
						return false;
					}*/
                }
            }//else of trim
        }
    }//for loop of input

    for(var textareacount=0;textareacount<textareatag.length;textareacount++)
    {
        if(textareatag[textareacount].value != null)
        {
            if(trim(textareatag[textareacount].value) =="")
            {
                textareatag[textareacount].focus();
                return false;
            }
        /*else
			{
				if(trim(textareatag[textareacount].value).indexOf(' ') > -1)
				{
					textareatag[textareacount].focus();
					return false;
				}
			}//else of trim*/
        }
    }//for loop of textarea.
    return true;
}

function checkForAnyNull()
{
    var inputtag = document.getElementsByTagName("input");
    var textareatag = document.getElementsByTagName("textarea");

    for(var inputcount=0;inputcount<inputtag.length;inputcount++)
    {
        if(trim(inputtag[inputcount].type) == 'text' && trim(inputtag[inputcount].value) =="")
        {
            inputtag[inputcount].focus();
            return false;
        }
    }//for loop of input

    for(var textareacount=0;textareacount<textareatag.length;textareacount++)
    {
        if(trim(textareatag[textareacount].value) =="")
        {
            textareatag[textareacount].focus();
            return false;
        }
    }//for loop of textarea.
    return true;
}

function getDate(date)
{
    var splitedDate = date.split("-");
    return Date.parse(splitedDate[1]+" "+splitedDate[0]+", "+splitedDate[2]);
}

function days_between(date1, date2) {

    // The number of milliseconds in one day
    var ONE_DAY = 1000 * 60 * 60 * 24

    // Convert both dates to milliseconds
    var date1_ms = date1.getTime()
    var date2_ms = date2.getTime()

    // Calculate the difference in milliseconds
    var difference_ms = Math.abs(date1_ms - date2_ms)

    // Convert back to days and return
    return Math.round(difference_ms/ONE_DAY)

}

function countFormula_New(tableId,rowId,colId,tableIndex) // Implemented with new logic - Ravi.
{
    
    //alert("countFormula_New  tableIndex : "+tableIndex);
    //alert("arrDataTypesforCell : "+arrDataTypesforCell);
    //alert("arrDataTypesforCell with tableIndex : "+arrDataTypesforCell[tableIndex]);
    var arrayDataType = ""+arrDataTypesforCell[tableIndex]+"";
    var operand1DataType;
    var operand2DataType;
    var dataTypeFatched = false;
    var isDateField = false; // Added by Ketan Prajapati for new data type -  Date
    if(arrayDataType.indexOf(12) != -1) // Data Type = 12 ---> Date
    {
        isDateField = true;
        var splitedDataType = arrayDataType.split(",");
        for(var i=0;i<splitedDataType.length;i++)
        {
            if(splitedDataType[i] != "" && splitedDataType[i] !='' && splitedDataType[i] != null)
            {
                operand1DataType = splitedDataType[i];
                operand2DataType = splitedDataType[i+1];
                dataTypeFatched = true;
            }
            if(dataTypeFatched)
            {
                break;
            }
        }
    }
    //alert("isDateField : "+isDateField);
    //alert("operand1DataType : "+operand1DataType);
    //alert("operand2DataType : "+operand2DataType);
    var firstIndex;
    var secondIndex;
    var thirdIndex;
    var isFirst = true;
    var strValue;
    var component;
    var putOperator;
    var lastOperator;
    var finalOperator;
    var tempString;
    var operator;

    if(templateFormulaArr[tableId+"_"+colId])
    {
        for(var i=0;i<templateFormulaArr[tableId+"_"+colId].length;i++)
        {
            lastOperaotr = "";
            isFirst = true;
            LoopCounter++;
            //var otherOperandDataType = arrDataTypesforCell[tableIndex][rowId][templateColIdArr[tableId+"_"+colId][i]];
            if(templateFormulaArr[tableId+"_"+colId][i].indexOf("TOTAL")<0)
            {
                var str1 =  templateFormulaArr[tableId+"_"+colId][i];
                var resultComp = templateResultArr[tableId+"_"+colId][i];
                var strResult = resultComp;
                while(str1.indexOf("^ROWID^")>0)
                {
                    str1 = str1.replace("^ROWID^",rowId);
                }
                if(str1.search("/p") != -1)
                {
                    str1 = str1.replace("p",100);
                }
                if(!isDateField){
                    str1 = eval(str1);
                    strResult = strResult.replace("^ROWID^",rowId);
                    if(document.getElementById(strResult) != null)
                    {
                        document.getElementById(strResult).readOnly = true;
                        if(isNaN(str1))
                        {
                            var flag="false";
                            for(var k=0;k<=i;k++)
                            {
                                //if(arrForLabelDisp[k] != null)
                                //{
                                //    flag="true";
                                //    break;
                                //}
                                }
                            if(flag == "true")
                            {
                                document.getElementById(strResult).value=str1;
                                document.getElementById(strResult+"_"+tableId).innerText=str1;
                            }
                            else
                            {
                                document.getElementById(strResult).value=str1;
                            }
                        }
                        else
                        {
                            if(eval(str1) != 'undefined' && eval(str1) != '' && eval(str1) != "" && eval(str1) != null &&  eval(str1) != 'NaN' && eval(str1) != "NaN")
                            {
                                document.getElementById(strResult).value=Math.round(eval(eval(str1)*10000))/10000;
                            }
                        }
                        document.getElementById(strResult).tabIndex=-1;
                    //alert("str  " + str1);
                    }
                    //alert('mast '+resultComp);
                    var id = resultComp.replace("_^ROWID^","");
                    id = id.replace("row","");
                    var newColId = id.substring(id.indexOf("_")+1,id.length);
                    //alert('newColId : '+newColId);
                    if(templateResultArr[id])
                    {
                        for(var j=0;j<templateResultArr[id].length;j++)
                        {
                            LoopCounter++;
                            try{
                                countFormula_New(tableId,rowId,newColId,tableIndex);
                            }catch(err){
                            //alert("err @ countFormula_New::" + err);
                            }
                        }
                    }
                }
                else
                {
                    var finalResult;
                    if(str1.indexOf("+") != -1)
                    {
                        operator = "+";
                    }
                    else
                    {
                        operator = "-";
                    }
                    
                    var formulaArray = str1.split(operator);
                    var operand1 = formulaArray[0];
                    var operand2 = formulaArray[1];
                    //alert("formulaArray : "+formulaArray+"operand1 : "+operand1+" operand2 : "+operand2);
                    //var otherOperandDataType = arrDataTypesforCell[tableIndex][rowId][templateColIdArr[tableId+"_"+colId][i]];
                    strResult = strResult.replace("^ROWID^",rowId);
                    if(document.getElementById(strResult) != null)
                    {
                        document.getElementById(strResult).readOnly = true;

                        if(operand2DataType == 12) // (Formla =  Date - Date)
                        {
                            var firstDate = getDate(eval(operand1));
                            var secondDate = getDate(eval(operand2));
                            if(operator == "-")
                            {
                                finalResult =  days_between(new Date(firstDate),new Date(secondDate));
                            }
                            if(!isNaN(finalResult)){
                                document.getElementById(strResult).value=finalResult;
                            }
                        }
                        else // (Formula = Date +  Days) OR (Formula = Date -  Days)
                        {
                            var millisecondsToAdd = eval(operand2)  * 86400000;
                            var endDt;
                            if(operator == "+")
                                endDt = new Date(getDate(eval(operand1)) + millisecondsToAdd);
                            else
                                endDt = new Date(getDate(eval(operand1)) - millisecondsToAdd);
                            var monthname = new Array("Jan","Feb","Mar","Apr","May","Jun", "Jul","Aug","Sep","Oct","Nov","Dec");
                            finalResult = endDt.getDate() + "-" + monthname[endDt.getMonth()] + "-" + endDt.getFullYear();
                            //alert("finalResult " +finalResult);
                            if(finalResult != 'undefined' && finalResult != '' && finalResult != "" && finalResult != null &&  finalResult != 'NaN' && finalResult != "NaN" && finalResult.search("NaN")){
                                document.getElementById(strResult).value=finalResult;
                            }
                        }
                        
                        document.getElementById(strResult).tabIndex=-1;
                    }
                    var id = resultComp.replace("_^ROWID^","");
                    id = id.replace("row","");
                    var newColId = id.substring(id.indexOf("_")+1,id.length);
                    if(templateResultArr[id])
                    {
                        for(var j=0;j<templateResultArr[id].length;j++)
                        {
                            LoopCounter++;
                            try{
                                countFormula_New(tableId,rowId,newColId,tableIndex);
                            }catch(err){
                            }
                        }
                    }
                }
            }
            else
            {
                try{
                    //alert('colId : '+colId)
                    //alert('applyColumnFunctions ');
                    applyColumnFunctions(tableId,colId,"TOTAL");
                }catch(err){
                //alert("err @ applyColumnFunctions::" + err + ", colId:" + colId);
                }
            }
        }
    }
}


function applyColumnFunctions(tableid,colId,funcType)
{
    //alert(" :: " + arrRowsKey[tableid] + " :: " + arrTableAddedKey[tableid]+ " toe");
    var cmpTotal="",Total=0,noOfRows =0;
    var SelectedTable;

    
    for(var j=0;j<arr.length;j++)
        if(arr[j]==tableid)
        {
            SelectedTable = j;
            LoopCounter++;
            break;
        }

    //alert(" sdkf "  + arrBidCount[SelectedTable]);

    if(chkEdit != true){
        //alert('bf noOfRows : '+noOfRows);
        noOfRows = (parseInt(arrRowsKey[tableid]*arrTableAddedKey[tableid])-parseInt(arrTableAddedKey[tableid]));
    //alert('af noOfRows : '+noOfRows);
    }
    else
    {
        if(arrTableAddedKey[tableid] > 2)
        {
            if(arrTableAddedKey[tableid] == (arrRowsKey[tableid]-1))
            {
                noOfRows = (parseInt(arrRowsKey[tableid]*arrTableAddedKey[tableid]));
            }
            else if(arrTableAddedKey[tableid] == (arrRowsKey[tableid]))
            {
                if(totalInWordAt > -1){ // condition set by hirav ==> to undo just remove if ..
                    noOfRows = (parseInt(arrRowsKey[tableid]*(arrTableAddedKey[tableid] - 1)));
                }else{
                    noOfRows = (parseInt(arrRowsKey[tableid]*arrTableAddedKey[tableid]) - 1);
                }
            }
            else if(arrTableAddedKey[tableid] > (arrRowsKey[tableid]))
            {
                noOfRows = (parseInt(arrRowsKey[tableid]*arrTableAddedKey[tableid]) - parseInt((arrTableAddedKey[tableid] - parseInt(arrRowsKey[tableid]))+1));
            }
            else
            {
                noOfRows = (parseInt(arrRowsKey[tableid]*arrTableAddedKey[tableid]) + parseInt(arrTableAddedKey[tableid]- parseInt(arrTableAddedKey[tableid]-1)));
            }
        }
        else //if(arrTableAddedKey[tableid] == 1)
        {
            noOfRows = (parseInt(arrRowsKey[tableid]*arrBidCount[SelectedTable]) - parseInt(arrBidCount[SelectedTable]));

        //alert(SelectedTable + " arrRowsKey "  + arrRowsKey[tableid] + " arrBidCount " + arrBidCount[SelectedTable]);
        }
    }

    //alert(funcType);
    if(funcType=="TOTAL") // logic for TOTAL of all fields (in case of other functions do it in if else)
    {
        for(var i=1;i<=noOfRows;i++)
        {
            cmpTotal = "row"+tableid+"_"+i+"_"+colId;
            //alert("cmp " + cmpTotal);
            //alert(document.getElementById(cmpTotal).value);
            if(trim(document.getElementById(cmpTotal).value)!="")
            {
                //alert('bf Total : '+Total);
                Total = parseFloat(Total) + parseFloat(document.getElementById(cmpTotal).value);
            //alert("out if " + i)
            //alert('af Total : '+Total);
            }

        }

        document.getElementById("row"+tableid+"_"+(noOfRows+1)+"_"+colId).value = Math.round(eval(eval(Total)*10000))/10000;
        document.getElementById("row"+tableid+"_"+(noOfRows+1)+"_"+colId).readOnly = true;
        document.getElementById("row"+tableid+"_"+(noOfRows+1)+"_"+colId).tabIndex=-1;

        //alert(colId);
        //if(colId == 8){
        //alert("isColTotalforTable::==>" + isColTotalforTable);
        //alert("arrColTotalIds::==>" + arrColTotalIds);
        //alert("arrColTotalWordsIds::==>" + arrColTotalWordsIds);
        //}
        for(i=1;i<=isColTotalforTable.length;i++){
            for(j=1;j<=arrColTotalIds[i-1].length;j++){
                //alert("1: colId" + colId + ",arrColTotalIds["+(i-1)+"]["+(j-1)+"] -> " + arrColTotalIds[i-1][j-1]);
                if(colId == arrColTotalIds[i-1][j-1] && arrColTotalWordsIds[i-1][j-1] != 0){
                    //alert("2: ID:" + "row"+tableid+"_"+(noOfRows+1)+"_"+eval(arrColTotalWordsIds[i-1][j-1]));
                    //alert(document.getElementById("row"+tableid+"_"+(noOfRows+1)+"_"+eval(arrColTotalWordsIds[i-1][j-1])));
                    //alert(WORD(Math.round(eval(eval(Total)*100000))/100000));

                    /*
                            try catch below set by
                            Hirav...
                    */

                    try{
                        document.getElementById("row"+tableid+"_"+(noOfRows+1)+"_"+eval(arrColTotalWordsIds[i-1][j-1])).innerHTML = WORD(Math.round(eval(eval(Total)*10000))/10000);
                    //if(document.getElementById("row"+tableid+"_"+(noOfRows)+"_"+eval(arrColTotalWordsIds[i-1][j-1])+"_"+tableid) != null)
                    //{
                    //alert("==> element::row"+tableid+"_"+(noOfRows)+"_"+eval(arrColTotalWordsIds[i-1][j-1])+"_"+tableid);
                    //  document.getElementById("row"+tableid+"_"+(noOfRows)+"_"+eval(arrColTotalWordsIds[i-1][j-1])+"_"+tableid).innerText=document.getElementById("row"+tableid+"_"+(noOfRows)+"_"+eval(arrColTotalWordsIds[i-1][j-1])).innerText;
                    //}
                    }catch(err){
                    //alert("!@#$%..err:" + err);
                    //document.getElementById("row"+tableid+"_"+(noOfRows)+"_"+eval(arrColTotalWordsIds[i-1][j-1])).value = WORD(Math.round(eval(eval(Total)*100000))/100000);
                    }
                }
            }
        }
    }
}

function prepareTemplateFormula(formula,arrId,tableId,storeIn,cnt,arrDataType)
{
    //str1,arrIds[k][i],arr[k],arrFormulaFor[k][i],k+i
    
    var vDataType = ""+arrDataType+"";
    //alert("vdATATYPE : "+vDataType);
    var isDatePresent = false; // Added by Ketan Prajapati for new data type -  Date
    if(vDataType.indexOf(12) != -1)
    {
        isDatePresent = true;
    }
    //alert("isDatePresents : "+isDatePresent);
    //alert('formula : '+formula);
    var newFormula="",SelectedTable="";
    var newFormulaColId = "";
    storeIn = "row"+tableId+"_^ROWID^_"+storeIn;

    for(var j=0;j<arr.length;j++)
        if(arr[j]==tableId)
        {
            SelectedTable = j;
            LoopCounter++;
            break;
        }

    var tempStr = arrStaticColIds[SelectedTable]+"";

    for(var i=0;i<arrId.length;i++)
    {
        var rowOrLbl = ((tempStr.indexOf(arrId[i])!=-1)?"lbl@":"row"); // decides whether the column has labels or other components.
        var valueOrInnerHMTL = ((tempStr.indexOf(arrId[i])!=-1)?"innerHTML":"value"); // if it is label then .innerHTML otherwise .value
        //newFormula+= ((!isNaN(arrId[i]))?"document.getElementById('"+rowOrLbl+tableId+"_^ROWID^_"+arrId[i]+"')."+valueOrInnerHMTL:arrId[i]);
        //alert(newFormula);
        if(tempStr.indexOf(arrId[i])!=-1)
        {
            var newTempStr = tempStr.split(",");
            for(var abc=0;abc<newTempStr.length;abc++)
            {
                if(arrId[i] == newTempStr[abc])
                {
                    rowOrLbl = "lbl@";
                    valueOrInnerHMTL = "innerHTML";
                    break;
                }
                else
                {
                    rowOrLbl = "row";
                    valueOrInnerHMTL = "value";
                }

            }
        }

        if(!isNaN(arrId[i]))
        {
            if(i>0)
            {
                if(!isDatePresent){
                    if((arrId[i+1]=="/") || (arrId[i-1] == "/")){
                        newFormula+="(isNaN(eval(document.getElementById('"+rowOrLbl+tableId+"_^ROWID^_"+arrId[i]+"')."+valueOrInnerHMTL+"))?1:eval(document.getElementById('"+rowOrLbl+tableId+"_^ROWID^_"+arrId[i]+"')."+valueOrInnerHMTL+"))";
                    }else if((arrId[i+1]=="+") || (arrId[i-1] == "+")){
                        newFormula+="(isNaN(eval(document.getElementById('"+rowOrLbl+tableId+"_^ROWID^_"+arrId[i]+"')."+valueOrInnerHMTL+"))?0:eval(document.getElementById('"+rowOrLbl+tableId+"_^ROWID^_"+arrId[i]+"')."+valueOrInnerHMTL+"))";
                    }else{
                        newFormula+="(isNaN(eval(document.getElementById('"+rowOrLbl+tableId+"_^ROWID^_"+arrId[i]+"')."+valueOrInnerHMTL+"))?0:eval(document.getElementById('"+rowOrLbl+tableId+"_^ROWID^_"+arrId[i]+"')."+valueOrInnerHMTL+"))";
                    }
                }
                else
                {
                    if((arrId[i+1]=="/") || (arrId[i-1] == "/")){
                        newFormula+="document.getElementById('"+rowOrLbl+tableId+"_^ROWID^_"+arrId[i]+"')."+valueOrInnerHMTL;
                        newFormulaColId+=arrId[i];
                    }else if((arrId[i+1]=="+") || (arrId[i-1] == "+")){
                        newFormula+="document.getElementById('"+rowOrLbl+tableId+"_^ROWID^_"+arrId[i]+"')."+valueOrInnerHMTL;
                        newFormulaColId+=arrId[i];
                    }else{
                        newFormula+="document.getElementById('"+rowOrLbl+tableId+"_^ROWID^_"+arrId[i]+"')."+valueOrInnerHMTL;
                        newFormulaColId+=arrId[i];
                    }
                }
            }
            else
            {
                if(!isDatePresent){
                    newFormula+="(isNaN(eval(document.getElementById('"+rowOrLbl+tableId+"_^ROWID^_"+arrId[i]+"')."+valueOrInnerHMTL+"))?0:eval(document.getElementById('"+rowOrLbl+tableId+"_^ROWID^_"+arrId[i]+"')."+valueOrInnerHMTL+"))";
                    newFormulaColId+=arrId[i];
                }
                else
                {
                    newFormula+="document.getElementById('"+rowOrLbl+tableId+"_^ROWID^_"+arrId[i]+"')."+valueOrInnerHMTL;
                }
            }
        }
        else if(arrId[i].indexOf("N_")==0)
        {
            //alert("before : " + newFormula);
            newFormula+=arrId[i].replace("N_","");
        //alert("after : " + newFormula);
        }
        else
        {
            newFormula+=arrId[i];
        }
    }

    //alert('len : '+arrId.length);
    for(var j=0;j<arrId.length;j++)
    {
        //alert(arrId[j]);
        if(isNaN(arrId[j])){}
        else
        {
            var chktemformula = tableId+"_"+arrId[j];
            if(templateFormulaArr[chktemformula] == null)
                templateFormulaArr[chktemformula] = new Array();
            if(templateResultArr[chktemformula] == null)
                templateResultArr[chktemformula] = new Array();
            if(templateColIdArr[chktemformula] == null)
                templateColIdArr[chktemformula] = new Array();

            templateFormulaArr[chktemformula].push(newFormula);
            templateColIdArr[chktemformula].push(newFormulaColId);
            templateResultArr[chktemformula].push(storeIn);
        }
    }
}

function breakFormulas(arrDataTypesforCell){
    //alert("in bREAKformulas L  : arr.length"+arr.length);
    for(var k=0;k<arr.length;k++){
        for(var i=0;i<arrTableFormula[k].length;i++){
            var str = arrTableFormula[k][i];
                        
            var str1 = str;
            var index=0;
            var char1="";
            var ch="";

            arrIds[k][i] = new Array();
            //alert("---->"+str+"<----" + " :: " + "---->"+trim(str)+"<----");
            for(;str.length>0;){
                if(index==0){
                    char1 = str.charAt(index);
                    ch = char1;
                }else{
                    char1 = str.substring(0,index);
                }

                ch = char1.charAt(char1.length-1);
                if(ch=="+" || ch=="*" || ch=="-" || ch=="/" || ch== "(" || ch==")" || ch=="p"  || ch=="N"){
                    if(ch=="N"){
                        while(true){
                            var ch = str.charAt(index);
                            if(ch=="+" || ch=="*" || ch=="-" || ch=="/" || ch== "(" || ch==")" || ch=="p"){
                                arrIds[k][i].push(str.substring(0,index));
                                str = str.substring(index,str.length);
                                index=0;
                                break;
                            }else if(index == str.length){
                                arrIds[k][i].push(str.substring(0,index));
                                str = str.substring(index,str.length);
                                index=0;
                                break;
                            }
                            index++;
                        }
                    }else{
                        if(index>0){
                            arrIds[k][i].push(str.substring(0,index-1));
                            str = str.substring(index-1,str.length);
                            index=0;
                        }
                    }
                    //alert("4--->" + ch + "<---");
                    if(ch != ""){
                        arrIds[k][i].push(ch);
                    }
                    str = str.substring(1,str.length);
                }else if(isNaN(char1)){
                    index++;
                }else{
                    char1 += str.charAt(1);
                    if(isNaN(char1)){
                        arrIds[k][i].push(char1.charAt(0));
                        str = str.substring(1,str.length);
                    }else{
                        arrIds[k][i].push(char1);
                        str = str.substring(2,str.length);
                    }
                }
                LoopCounter++;
            }
            prepareTemplateFormula(str1,arrIds[k][i],arr[k],arrFormulaFor[k][i],k+i,arrDataTypesforCell[k]);
        }
    }
}


function checkForFunctions()
{
    var ColId = 0;
    var tableId = 0;
    var SelectedTable=0;

    for(var k=0;k<arr.length;k++)
        for(var i=0;i<arrTableFormula[k].length;i++)
            for(var j=0;j<arrIds[k][i].length;j++)
                if(arrIds[k][i][j].toUpperCase()=="TOTAL")
                    newArr.push(arrIds[k][i][j+2]);

    for(var k=0;k<arr.length;k++)
        for(var i=0;i<arrTableFormula[k].length;i++)
            for(var j=0;j<arrIds[k][i].length;j++)
            {
                var r=0;
                for(r=0;r<arr.length;r++)
                    if(r==k)
                    {
                        SelectedTable = r;
                        tableId = arr[r];
                        break;
                    }

                var NoofTables = parseInt(arrTableAdded[SelectedTable]);
                var row = (arrRow[SelectedTable]*NoofTables)-1;

                if(newArr.length > 0)
                    for(var m=1;m<=arrCol[SelectedTable];m++)
                    {
                        var bool = true;

                        for(var z=0;z<newArr.length;z++)
                            if(m==newArr[z])
                            {
                                LoopCounter++;
                                bool = false; // if m found in newArr[] , it has column total formula , so no need to delete it.
                                break;
                            }

                        if(bool)
                        {
                            var comp = document.getElementById("row"+tableId+"_"+row+"_"+arrColIds[m]);
                            var lastRow = document.getElementById("td"+tableId+"_"+row+"_"+m);
                            if(comp != null && lastRow != null)
                            {
                                //alert("com " + comp + " L " + lastRow + " :: " +"td"+tableId+"_"+row+"_"+m + " :: " + "row"+tableId+"_"+row+"_"+arrColIds[m]);
                                lastRow.removeChild(comp);
                            }
                        }
                    }
                LoopCounter++;
            }

//breakFormulas();
}


function DelTable(theform,tableId,button1){

    var SelectedTable; //for getting the id of table selected
    var NoofTables; //number of tables added
    var tdId; //id of the td being created
    var CompId; //id of the component being created
    var RowIndex; //id of row being created
    var tr; //row created
    var SortOrder; //for Bidder Side Components
    var StaticIndex; //for Vendor Side Components
    var ColIndex;
    var readOnly;
    var tableCnt = 0;

    for(var i=0;i<arr.length;i++)
    {
        if(arr[i]==tableId)
        {
            SelectedTable = i;
            if(chkEdit)
                tableCnt = parseInt(parseInt(totalBidTable[i])+1);
            LoopCounter++;
            break;
        }
    }
    var selAllFlag = true;
    
    $(':checkbox[id^=chk'+tableId+']').each(function(){
        if(!$(this).attr("checked")){
            selAllFlag = false;
        }
    });
    
    if(selAllFlag==true)
    {
        jAlert("Atleast one record required","Tender / Proposal Preparation", function(retVal) {});
        return false;
    }
    else
    {
        var delRowCnt = 0;
        var noRecSelected = true; // Added by to solve issue id :  3336
        $(':checkbox[id^=chk'+tableId+']').each(function()
        {
            if($(this).attr("checked"))
            {
                noRecSelected = false;
                var curRow = $(this).closest('tr');
                var rowId = $(this).closest('tr').attr("id");

                for(var x=1;x<=arrRow[SelectedTable];x++)
                {
                    var curRowIndex = rowId.substring(rowId.indexOf("_")+1, rowId.length);

                    document.getElementById("MainTable"+tableId).deleteRow(curRowIndex);
                    var totalRows =  eval(arrRow[SelectedTable]) * eval(document.getElementById("tableCount"+tableId).value);

                    for(var i=curRowIndex;i<totalRows;i++)
                    {
                        for(var j=1;j<=arrCol[SelectedTable];j++)
                        {
                            $('#row'+tableId+'_'+(eval(i)+eval(1))).attr("name",'row'+tableId+'_'+i);

                            if(document.getElementById("idcombodetail"+tableId+'_'+(eval(i)+eval(1))+"_"+j)!=null){
                                $('#idcombodetail'+tableId+'_'+(eval(i)+eval(1))+'_'+j).attr("name",'namecombodetail'+tableId+'_'+i+'_'+j);
                                $('#idcombodetail'+tableId+'_'+(eval(i)+eval(1))+'_'+j).attr("id",'idcombodetail'+tableId+'_'+i+'_'+j);
                            }

                            $('#row'+tableId+'_'+(eval(i)+eval(1))).attr("id",'row'+tableId+'_'+i);

                            $('#row'+tableId+'_'+(eval(i)+eval(1))+'_'+j).attr("name",'row'+tableId+'_'+i+'_'+j);
                            $('#row'+tableId+'_'+(eval(i)+eval(1))+'_'+j).attr("id",'row'+tableId+'_'+i+'_'+j);

                            $('#td'+tableId+'_'+(eval(i)+eval(1))+'_'+j).attr("id",'td'+tableId+'_'+i+'_'+j);
                        }
                    }
                }
                arrTableAdded[SelectedTable]--;
                delRowCnt++;
            }
        });

        if(noRecSelected)
        {
            jAlert("Please select a record to delete","Tender / Proposal Preparation", function(retVal) {});
            return false;
        }
        else
        {
            document.getElementById("tableCount"+tableId).value = parseInt(document.getElementById("tableCount"+tableId).value) - parseInt(delRowCnt);
        }
    }
    
}
/*
 old commented AddTable
 function removed from here...
*/



function AddTable(theform,tableId,button1)
{
    //alert('theForm : '+theform);
    //alert('tableId : '+tableId);
    //alert('button1 : '+button1);
    //alert('AddTable');
    var SelectedTable; //for getting the id of table selected
    var NoofTables; //number of tables added
    var tdId; //id of the td being created
    var CompId; //id of the component being created
    var RowIndex; //id of row being created
    var tr; //row created
    var SortOrder; //for Bidder Side Components
    var StaticIndex; //for Vendor Side Components
    var ColIndex;
    var readOnly;
    var tableCnt = 0;

    arrTableAddedKey[tableId]++;

    //alert(arr.length);
    for(var i=0;i<arr.length;i++)
    {
        //alert('arr : '+arr[i]);
        if(arr[i]==tableId)
        {
            SelectedTable = i;
            arrTableAdded[i]++;
            if(chkEdit)
                tableCnt = parseInt(parseInt(totalBidTable[i])+1);
            //alert('tableCnt : '+tableCnt);
            LoopCounter++;
            break;
        }
    }
    //alert('SelectedTable : '+SelectedTable);
        
    document.getElementById("tableCount"+tableId).value = parseInt(document.getElementById("tableCount"+tableId).value) + 1;

    NoofTables = parseInt(arrTableAdded[i]);
    //alert('NoofTables : '+NoofTables);

    var tempBody = document.getElementById("MainTable"+tableId);
    //alert(tempBody);


    //for removing the column of total
    //alert(isColTotalforTable[SelectedTable]);
    if(isColTotalforTable[SelectedTable] != 0)
    {
        var removeColId;
        var retr;
        var removetr;

        if(chkEdit != true)
        {
            removeColId = ((arrRow[SelectedTable] *(NoofTables-1))-(NoofTables-1));
            retr = "row"+tableId+"_"+(removeColId+1);
            //alert(retr);
            removetr = document.getElementById(retr);
        //alert(removetr);
        }
        else if(chkEdit == true)
        {
            if(arrBidCount[SelectedTable] > 1)
            {
                removeColId = parseInt(parseInt(arrRow[SelectedTable])*parseInt(arrBidCount[SelectedTable]))-(parseInt(arrBidCount[SelectedTable]));
                retr = "row"+tableId+"_"+removeColId;
                removetr = document.getElementById(retr);
            }
            else
            {
                removeColId = ((arrRow[SelectedTable] *(NoofTables-1))-(NoofTables-1));
                retr = "row"+tableId+"_"+removeColId;
                removetr = document.getElementById(retr);
            }
        }
        //alert(" re " + removeColId + " : rert "  + retr + " : : removetr  "+ removetr + " :: " + arrRow[SelectedTable] + " : no " + NoofTables);
        if(removetr != null){
            tempBody.removeChild(removetr);
        }


    }

    //alert('Row : '+arrRow[SelectedTable]);
    for(var addRow=1;addRow<=arrRow[SelectedTable];addRow++)
    {
        //alert('addRow : '+addRow);
        tr = document.createElement("TR");
        SortOrder = 0;
        StaticIndex = 0;
        tr.setAttribute("align","center");
                
        checkBoxCell = document.createElement("TD");
        checkBoxCell.setAttribute("class","t-align-center");
                
        //for setting rowids where there is no column total
        //alert(isColTotalforTable[SelectedTable]);
        //        if(isColTotalforTable[SelectedTable] == 0)
        //        {
        //            if(chkEdit == true)
        //            {
        //                if(arrBidCount[SelectedTable] > 1)
        //                {
        //                    //alert("  in bid " + arrBidCount[SelectedTable] + " row " + arrRow[SelectedTable] + " no " + NoofTables);
        //                    //alert('SelectedTable : '+SelectedTable);
        //                    //alert('addRow : '+addRow);
        //                    //alert('arrRow[SelectedTable] : '+arrRow[SelectedTable]);
        //                    //alert('NoofTables : '+NoofTables);
        //                    //alert('actRow : '+parseInt(addRow+(parseInt(arrRow[SelectedTable])*parseInt(NoofTables))));
        //                    tr.setAttribute("id","row"+tableId+"_"+parseInt(addRow+(parseInt(arrRow[SelectedTable])*parseInt(NoofTables))));
        //                    if(addRow==1){
        //                        checkBoxCell.innerHTML="<input type='checkbox' id='"+"chk"+tableId+"_"+parseInt(addRow+(parseInt(arrRow[SelectedTable])*parseInt(NoofTables)))+"' />";
        //                    }
        //                }
        //                else
        //                {
        //                    //alert(" bid " + arrBidCount[SelectedTable] + " row " + arrRow[SelectedTable] + " no " + NoofTables);
        //                    tr.setAttribute("id","row"+tableId+"_"+parseInt(addRow+(parseInt(arrRow[SelectedTable])*parseInt(NoofTables-1))));
        //                    if(addRow==1){
        //                        checkBoxCell.innerHTML="<input type='checkbox' id='"+"chk"+tableId+"_"+parseInt(addRow+(parseInt(arrRow[SelectedTable])*parseInt(NoofTables-1)))+"' />";
        //                    }
        //                }
        //            //alert(" tr id " + tr.id);
        //            //alert(" no " + NoofTables + " rows " + arrRow[SelectedTable] + " id " + tr.id);
        //            }
        //            else
        //            {
        //                //alert(parseInt(addRow+(parseInt(arrRow[SelectedTable])*parseInt(NoofTables-1))));
        //                tr.setAttribute("id","row"+tableId+"_"+parseInt(addRow+(parseInt(arrRow[SelectedTable])*parseInt(NoofTables-1))));
        //                if(addRow==1){
        //                    checkBoxCell.innerHTML="<input type='checkbox' id='"+"chk"+tableId+"_"+parseInt(addRow+(parseInt(arrRow[SelectedTable])*parseInt(NoofTables-1)))+"' />";
        //                }
        //            //alert(" no " + NoofTables + " rows " + arrRow[SelectedTable] + " id " + tr.id);
        //            }
        //        }

        //for setting rowids where there is column total
        if(isColTotalforTable[SelectedTable] != 0)
        {
            if(chkEdit == true)
            {
                if(arrBidCount[SelectedTable] > 1)
                {
                    //alert("  in bid " + arrBidCount[SelectedTable] + " row " + arrRow[SelectedTable] + " no " + NoofTables);
                    tr.setAttribute("id","row"+tableId+"_"+parseInt(addRow+(parseInt(arrRow[SelectedTable])*parseInt(arrBidCount[SelectedTable]) - parseInt(arrBidCount[SelectedTable]))));
                    if(addRow==1){
                    //checkBoxCell.innerHTML="<input type='checkbox' id='"+"chk"+tableId+"_"+parseInt(addRow+(parseInt(arrRow[SelectedTable])*parseInt(arrBidCount[SelectedTable]) - parseInt(arrBidCount[SelectedTable])))+"' />";
                    }
                }
                else
                {
                    //alert(" bid " + arrBidCount[SelectedTable] + " row " + arrRow[SelectedTable] + " no " + NoofTables + " : " +addRow);
                    tr.setAttribute("id","row"+tableId+"_"+parseInt(addRow+(parseInt(arrRow[SelectedTable]) - parseInt(NoofTables-1))));
                    if(addRow==1){
                    //checkBoxCell.innerHTML="<input type='checkbox' id='"+"chk"+tableId+"_"+parseInt(addRow+(parseInt(arrRow[SelectedTable]) - parseInt(NoofTables-1)))+"' />";
                    }
                }
            //alert(" no 1 " + NoofTables + " rows " + arrRow[SelectedTable] + " id " + tr.id);
            }
            else
            {
                //alert('row : '+parseInt(addRow+(parseInt(arrRow[SelectedTable])*parseInt(NoofTables-1))));
                tr.setAttribute("id","row"+tableId+"_"+parseInt(addRow+(  parseInt(parseInt(arrRow[SelectedTable])*parseInt(NoofTables-1) - parseInt(NoofTables-1)))));
                if(addRow==1){
                // checkBoxCell.innerHTML="<input type='checkbox' id='"+"chk"+tableId+"_"+parseInt(addRow+(  parseInt(parseInt(arrRow[SelectedTable])*parseInt(NoofTables-1) - parseInt(NoofTables-1))))+"' />";
                }
            //alert(" no 2 " + NoofTables + " rows " + arrRow[SelectedTable] + " id " + tr.id);
            }
        }
        //tr.appendChild(checkBoxCell);
        //for generating columns and cells

        //alert('Col : '+arrCol[SelectedTable]);
        for(var addCol=1;addCol<=arrCol[SelectedTable];addCol++)
        {
            readOnly="";
            for(var itext=0;itext<arrFormulaFor[SelectedTable].length;itext++)
            {
                if(arrFormulaFor[SelectedTable][itext] == (parseInt(addCol)))
                {
                    readOnly = "readOnly";
                    break;
                }
            }
			
            //alert('col : '+parseInt(addCol));
            //alert('row : '+parseInt(addRow));
            //alert('last row : '+parseInt(arrRow[SelectedTable] ));
            if(parseInt(addRow) == parseInt(arrRow[SelectedTable])) //if last row
            {
                //alert("addRow:" + parseInt(addRow) + ", arrRow[SelectedTable] :" + parseInt(arrRow[SelectedTable]));
                //alert('colTotal : '+isColTotalforTable[SelectedTable]);
                if(isColTotalforTable[SelectedTable] != 0) //if that table has column total
                {
                    //alert("b4 checking if that col has total...");
                    //alert("arrColTotalIds==>:" + arrColTotalIds);
                    //alert("==>arrColTotalIds[SelectedTable][addCol-1]:" + arrColTotalIds[SelectedTable][addCol-1]);
                    //alert("==>parseInt(addCol)" + parseInt(addCol));
                    if(arrColTotalIds[SelectedTable][addCol-1] == parseInt(addCol)) // if that column has column total
                    {
                        if(arrColIds[SelectedTable][SortOrder] != addCol )
                        {

                            var inBreak = false;
                            var count = 0;
                            while(arrColIds[SelectedTable][SortOrder] != addCol)
                            {
                                SortOrder++;
                                count++;
                                if((count > 30) && (arrColIds[SelectedTable][SortOrder] == null))
                                {
                                    inBreak = true;
                                    break;
                                }

                            }
                        }

                        var ColIndex ;
                        if(inBreak)
                            ColIndex = addCol;
                        else
                            ColIndex = arrColIds[SelectedTable][SortOrder];

                        if(chkEdit == true)
                        {
                            if(arrBidCount[SelectedTable] > 1) //if in edit table added more than once
                            {
                                if(inBreak)
                                {
                                    CompId = "row"+tableId+"_"+parseInt(addRow+(parseInt(arrRow[SelectedTable])*parseInt(arrBidCount[SelectedTable])-parseInt(arrBidCount[SelectedTable])))+"_"+addCol;
                                    RowIndex = parseInt(addRow+(parseInt(arrRow[SelectedTable])*parseInt(arrBidCount[SelectedTable])-parseInt(arrBidCount[SelectedTable])));
                                    tdId = "td"+tableId+"_"+parseInt(addRow+(parseInt(arrRow[SelectedTable])*parseInt(arrBidCount[SelectedTable])-parseInt(arrBidCount[SelectedTable])))+"_"+addCol;
                                }
                                else
                                {
                                    CompId = "row"+tableId+"_"+parseInt(addRow+(parseInt(arrRow[SelectedTable])*parseInt(arrBidCount[SelectedTable])-parseInt(arrBidCount[SelectedTable])))+"_"+arrColIds[SelectedTable][SortOrder];
                                    RowIndex = parseInt(addRow+(parseInt(arrRow[SelectedTable])*parseInt(arrBidCount[SelectedTable])-parseInt(arrBidCount[SelectedTable])));
                                    tdId = "td"+tableId+"_"+parseInt(addRow+(parseInt(arrRow[SelectedTable])*parseInt(arrBidCount[SelectedTable])-parseInt(arrBidCount[SelectedTable])))+"_"+arrColIds[SelectedTable][SortOrder];
                                }
                            }
                            else
                            {
                                if(inBreak)
                                {
                                    CompId = "row"+tableId+"_"+(addRow+(parseInt(arrRow[SelectedTable]*parseInt(arrBidCount[SelectedTable])) - parseInt(NoofTables - arrBidCount[SelectedTable])))+"_"+addCol;
                                    RowIndex = addRow+(parseInt(arrRow[SelectedTable]*parseInt(arrBidCount[SelectedTable])) - parseInt(NoofTables - arrBidCount[SelectedTable]));
                                    //RowIndex = addRow+(parseInt(arrRow[SelectedTable]*parseInt(arrBidCount[SelectedTable]))- parseInt(NoofTables - arrBidCount[SelectedTable])));
                                    tdId = "td"+tableId+"_"+(addRow+(parseInt(arrRow[SelectedTable]*parseInt(arrBidCount[SelectedTable])) - parseInt(NoofTables - arrBidCount[SelectedTable])))+"_"+addCol;
                                }
                                else
                                {
                                    CompId = "row"+tableId+"_"+(addRow+(parseInt(arrRow[SelectedTable]*parseInt(arrBidCount[SelectedTable])) - parseInt(NoofTables - arrBidCount[SelectedTable])))+"_"+arrColIds[SelectedTable][SortOrder];
                                    RowIndex = addRow+(parseInt(arrRow[SelectedTable]*parseInt(arrBidCount[SelectedTable])) - parseInt(NoofTables - arrBidCount[SelectedTable]));
                                    //RowIndex = addRow+(parseInt(arrRow[SelectedTable]*parseInt(arrBidCount[SelectedTable]))- parseInt(NoofTables - arrBidCount[SelectedTable])));
                                    tdId = "td"+tableId+"_"+(addRow+(parseInt(arrRow[SelectedTable]*parseInt(arrBidCount[SelectedTable])) - parseInt(NoofTables - arrBidCount[SelectedTable])))+"_"+arrColIds[SelectedTable][SortOrder];
                                }
                            }
                        }
                        else
                        {
                            if(inBreak)
                            {
                                CompId = "row"+tableId+"_"+(addRow+(parseInt(arrRow[SelectedTable]*(NoofTables-1))-(parseInt(NoofTables-1))))+"_"+addCol;
                                RowIndex = (addRow+(parseInt(arrRow[SelectedTable]*(NoofTables-1))-(parseInt(NoofTables-1))));
                                tdId = "td"+tableId+"_"+(addRow+parseInt(parseInt(parseInt(arrRow[SelectedTable])*parseInt(parseInt(NoofTables) - 1) - parseInt(parseInt(NoofTables) - 1))))+"_"+addCol;
                            }
                            else
                            {
                                CompId = "row"+tableId+"_"+(addRow+(parseInt(arrRow[SelectedTable]*(NoofTables-1))-(parseInt(NoofTables-1))))+"_"+arrColIds[SelectedTable][SortOrder];
                                RowIndex = (addRow+(parseInt(arrRow[SelectedTable]*(NoofTables-1))-(parseInt(NoofTables-1))));
                                tdId = "td"+tableId+"_"+(addRow+parseInt(parseInt(parseInt(arrRow[SelectedTable])*parseInt(parseInt(NoofTables) - 1) - parseInt(parseInt(NoofTables) - 1))))+"_"+arrColIds[SelectedTable][SortOrder];
                            }
                        }
                        
                        if(arrDataTypesforCell[SelectedTable][addRow][addCol] == "3")
                        {
                            /*alert("CompId" + CompId);
							alert("tr==>" + tr.innerHTML);
							alert("arrCompType[SelectedTable][addRow][addCol]==>" + arrCompType[SelectedTable][addRow][addCol]);*/
                            addInputWithEvent(theform,arrCompType[SelectedTable][addRow][addCol],CompId,tr,"onBlur","CheckFloat1('"+tableId+"',this);",tdId);
                        }
                        else if(arrDataTypesforCell[SelectedTable][addRow][addCol] == "4")
                        {
                            addInputWithEvent(theform,arrCompType[SelectedTable][addRow][addCol],CompId,tr,"onBlur","CheckNumeric('"+tableId+"',this);",tdId)
                        }
                        else if(arrDataTypesforCell[SelectedTable][addRow][addCol] == "8")
                        {
                            addInputWithEvent(theform,arrCompType[SelectedTable][addRow][addCol],CompId,tr,"onBlur","moneywithminus('"+tableId+"',this);",tdId);
                        }
                        else if(arrDataTypesforCell[SelectedTable][addRow][addCol] == "9")
                        {
                            var originalCmb = document.getElementById("idcombodetail"+tableId+"_"+addRow+"_"+addCol);
                            addHiddenInputWithEvent(theform,arrCompType[SelectedTable][addRow][addCol],CompId,tr,"onBlur","moneywithminus("+tableId+",this)",tdId,originalCmb,tableId);
                        }
                        else if(arrDataTypesforCell[SelectedTable][addRow][addCol] == "10")
                        {
                            var originalCmb = document.getElementById("idcombodetail"+tableId+"_"+addRow+"_"+addCol);
                            addHiddenInputWithEvent(theform,arrCompType[SelectedTable][addRow][addCol],CompId,tr,"onBlur","moneywithminus("+tableId+",this)",tdId,originalCmb,tableId);
                        }
                        else if(arrDataTypesforCell[SelectedTable][addRow][addCol] == "12")
                        {
                            addInputDateWithEvent(theform,arrCompType[SelectedTable][addRow][addCol],CompId,tr,"onclick","GetCal('"+CompId+"','"+CompId+"','"+tableId+"',this,'"+SelectedTable+"')",tdId,tableId);
                        }
                    //alert("tr==>" + tr.innerHTML);

                    }

                    else if(totalInWordAt == parseInt(addCol)) // else if ==> table has total in words column
                    {
                        //alert("total in words col...");

                        SortOrder++;

                        CompId = "row"+tableId+"_"+parseInt(addRow+(parseInt(arrRow[SelectedTable])*parseInt(arrBidCount[SelectedTable])-parseInt(arrBidCount[SelectedTable])))+"_"+arrColIds[SelectedTable][SortOrder];
                        RowIndex = parseInt(addRow+(parseInt(arrRow[SelectedTable])*parseInt(arrBidCount[SelectedTable])-parseInt(arrBidCount[SelectedTable])));
                        tdId = "td"+tableId+"_"+parseInt(addRow+(parseInt(arrRow[SelectedTable])*parseInt(arrBidCount[SelectedTable])-parseInt(arrBidCount[SelectedTable])))+"_"+arrColIds[SelectedTable][SortOrder];


                        /*CompId = "row"+tableId+"_"+(addRow+(parseInt(arrRow[SelectedTable]*(NoofTables-1))-(parseInt(NoofTables-1))))
								+"_"+arrColIds[SelectedTable][SortOrder];*/
                        //alert("CompId:" + CompId);
                        /*tdId = "td"+tableId+"_"+
						(addRow+parseInt(parseInt(parseInt(arrRow[SelectedTable])*parseInt(parseInt(NoofTables) - 1) - parseInt(parseInt(NoofTables) - 1))))
						+"_"+arrColIds[SelectedTable][SortOrder];*/
                        //alert("CompId:" + CompId);
                        addTextArea(theform, CompId, tr, tdId);
                    }
                    //else if not col total for that column
                    else
                    {
                        var q = 0;
                        for(var p = 0;p<totalWordArr.length;p++){
                            if(totalWordArr[p] == parseInt(addCol)){
                                SortOrder++;
                                q++;
                                CompId = "row"+tableId+"_"+parseInt(addRow+(parseInt(arrRow[SelectedTable])*parseInt(arrBidCount[SelectedTable])-parseInt(arrBidCount[SelectedTable])))+"_"+arrColIds[SelectedTable][SortOrder];
                                RowIndex = parseInt(addRow+(parseInt(arrRow[SelectedTable])*parseInt(arrBidCount[SelectedTable])-parseInt(arrBidCount[SelectedTable])));
                                tdId = "td"+tableId+"_"+parseInt(addRow+(parseInt(arrRow[SelectedTable])*parseInt(arrBidCount[SelectedTable])-parseInt(arrBidCount[SelectedTable])))+"_"+arrColIds[SelectedTable][SortOrder];
                                addTextArea(theform, CompId, tr, tdId);
                            }
                        }
                        if(q == 0){
                            if(chkEdit == true)
                            {
                                if(arrBidCount[SelectedTable] > 1)
                                {
                                    tdId = "td"+tableId+"_"+(addRow+(parseInt(arrRow[SelectedTable]*parseInt(arrBidCount[SelectedTable])) - parseInt(arrBidCount[SelectedTable])))+"_"+addCol;
                                }
                                else
                                {
                                    tdId = "td"+tableId+"_"+((parseInt(arrRow[SelectedTable]) * parseInt(NoofTables)) - parseInt(NoofTables))+"_"+addCol;
                                //alert(" in " + tdId);
                                }
                            }
                            else
                            {
                                //tdId = "td"+tableId+"_"+(addRow+parseInt(parseInt(parseInt(arrRow[SelectedTable])*parseInt(parseInt(NoofTables) - 1) - parseInt(parseInt(NoofTables) - 1))))+"_"+arrStaticColIds[SelectedTable][StaticIndex];
                                tdId = "td"+tableId+"_"+(addRow+parseInt(parseInt(parseInt(arrRow[SelectedTable])*parseInt(parseInt(NoofTables) - 1) - parseInt(parseInt(NoofTables) - 1))))+"_"+addCol;
                            }
                            addTD(" ",tr,1,tdId,false);
                        }

                    //alert(" in else " + tdId);
                    }//end of else if not col total for that column
                //alert("123 .. tr==>" + tr.innerHTML);
                }//if col table
                else
                {
                    //for creating GovSide cells
                    //alert('else 1');
                    //alert('SelectedTable: '+SelectedTable);
                    //alert('addRow: '+addRow);
                    //alert('addCol: '+addCol);
                    //alert(arrCellData[SelectedTable][parseInt(addRow-1)][addCol]);
                    //alert('else 2');
                    if(arrCellData[SelectedTable][addRow][addCol] != null && arrCellData[SelectedTable][addRow][addCol] != "" && arrCellData[SelectedTable][addRow][addCol] != "null")
                    {
                        if(isColTotalforTable[SelectedTable] != 0)
                        {
                            if(chkEdit == true)
                            {
                                if(arrBidCount[SelectedTable] > 1)
                                {
                                    tdId = "td"+tableId+"_"+(addRow+(parseInt(arrRow[SelectedTable]*parseInt(arrBidCount[SelectedTable])) - parseInt(NoofTables - arrBidCount[SelectedTable])))+"_"+arrStaticColIds[SelectedTable][StaticIndex];
                                }
                                else
                                {
                                    tdId = "td"+tableId+"_"+(addRow+(parseInt(arrRow[SelectedTable]*parseInt(arrBidCount[SelectedTable])) - parseInt(NoofTables - arrBidCount[SelectedTable])))+"_"+arrStaticColIds[SelectedTable][StaticIndex];
                                }

                            }
                            else
                            {
                                tdId = "td"+tableId+"_"+(addRow+parseInt(parseInt(parseInt(arrRow[SelectedTable])*parseInt(parseInt(NoofTables) - 1) - parseInt(parseInt(NoofTables) - 1))))+"_"+arrStaticColIds[SelectedTable][StaticIndex];
                            }
                        //alert(" in " + tdId);
                        }

                        if(isColTotalforTable[SelectedTable] == 0)
                        {
                            if(chkEdit == true)
                            {
                                if(arrBidCount[SelectedTable] > 1)
                                {
                                    tdId = "td"+tableId+"_"+(addRow+(parseInt(arrRow[SelectedTable]*(parseInt(arrBidCount[SelectedTable])))))+"_"+arrStaticColIds[SelectedTable][StaticIndex];
                                }
                                else
                                {
                                    tdId = "td"+tableId+"_"+(addRow+(parseInt(arrRow[SelectedTable]*(NoofTables-1))))+"_"+arrStaticColIds[SelectedTable][StaticIndex];
                                }
                            }
                            else
                            {
                                tdId = "td"+tableId+"_"+(addRow+(parseInt(arrRow[SelectedTable]*(NoofTables-1))))+"_"+arrStaticColIds[SelectedTable][StaticIndex];
                            }
                        }
                        //alert(" in " + tdId + " : " + arrBidCount[SelectedTable]);
                        //alert(" td " + tdId +" row " + arrRow[SelectedTable] + " Nof " + NoofTables + " " + arrStaticColIds[SelectedTable][StaticIndex]);

                        addTD(new String(arrCellData[SelectedTable][addRow][addCol]),tr,1,tdId,true);
                        lbl_ids[lbl_ids.length] = "lbl@"+tdId.substring(2,tdId.length);

                        StaticIndex++;

                    }//end of if govdata
                    //for All Other Cells
                    else
                    {
                        if(isColTotalforTable[SelectedTable] != 0)
                        {

                            if(chkEdit == true)
                            {

                                if(arrBidCount[SelectedTable] > 1) //if in edit table added more than once
                                {
                                    CompId = "row"+tableId+"_"+parseInt(addRow+(parseInt(arrRow[SelectedTable])*parseInt(arrBidCount[SelectedTable])-parseInt(arrBidCount[SelectedTable])))+"_"+arrColIds[SelectedTable][SortOrder];
                                    RowIndex = parseInt(addRow+(parseInt(arrRow[SelectedTable])*parseInt(arrBidCount[SelectedTable])-parseInt(arrBidCount[SelectedTable])));
                                    tdId = "td"+tableId+"_"+parseInt(addRow+(parseInt(arrRow[SelectedTable])*parseInt(arrBidCount[SelectedTable])-parseInt(arrBidCount[SelectedTable])))+"_"+arrColIds[SelectedTable][SortOrder];

                                }
                                else
                                {
                                    CompId = "row"+tableId+"_"+(addRow+(parseInt(arrRow[SelectedTable]*parseInt(arrBidCount[SelectedTable])) - parseInt(NoofTables - arrBidCount[SelectedTable])))+"_"+arrColIds[SelectedTable][SortOrder];
                                    RowIndex = addRow+(parseInt(arrRow[SelectedTable]*parseInt(arrBidCount[SelectedTable])));
                                    tdId = "td"+tableId+"_"+(addRow+(parseInt(arrRow[SelectedTable]*parseInt(arrBidCount[SelectedTable])) - parseInt(NoofTables - arrBidCount[SelectedTable])))+"_"+arrColIds[SelectedTable][SortOrder];

                                }

                            }
                            else
                            {
                                CompId = "row"+tableId+"_"+(addRow+parseInt(parseInt(parseInt(arrRow[SelectedTable])*parseInt(parseInt(NoofTables) - 1) - parseInt(parseInt(NoofTables) - 1))))+"_"+arrColIds[SelectedTable][SortOrder];
                                RowIndex = (addRow+parseInt(parseInt(parseInt(arrRow[SelectedTable])*parseInt(parseInt(NoofTables) - 1) - parseInt(parseInt(NoofTables) - 1))));
                                tdId = "td"+tableId+"_"+(addRow+parseInt(parseInt(parseInt(arrRow[SelectedTable])*parseInt(parseInt(NoofTables) - 1) - parseInt(parseInt(NoofTables) - 1))))+"_"+arrColIds[SelectedTable][SortOrder];
                            }
                        //alert(" in if com " + CompId + " : row " + RowIndex + " : tdId " + tdId);
                        }


                        if(isColTotalforTable[SelectedTable] == 0)
                        {
                            if(chkEdit == true) // if edit
                            {
                                //alert('else else else ');
                                if(arrBidCount[SelectedTable] > 1) //if in edit table added more than once
                                {
                                    //alert('row : '+(addRow+(parseInt(arrRow[SelectedTable]*(parseInt(arrBidCount[SelectedTable]))))));
                                    CompId = "row"+tableId+"_"+(addRow+(parseInt(arrRow[SelectedTable]*(parseInt(arrBidCount[SelectedTable])))))+"_"+addCol;
                                    //alert('CompId : '+CompId);
                                    RowIndex = (addRow+(parseInt(arrRow[SelectedTable]*(parseInt(arrBidCount[SelectedTable])))));
                                    tdId  = "td"+tableId+"_"+(addRow+(parseInt(arrRow[SelectedTable]*(parseInt(arrBidCount[SelectedTable])))))+"_"+addCol;
                                }
                                else
                                {
                                    //alert('else 4');
                                    CompId = "row"+tableId+"_"+(addRow+(parseInt(arrRow[SelectedTable]*(parseInt(NoofTables)-1))))+"_"+arrColIds[SelectedTable][SortOrder];
                                    //alert('CompId : '+CompId);
                                    RowIndex = (addRow+(parseInt(arrRow[SelectedTable]*(parseInt(NoofTables)-1))));
                                    tdId  = "td"+tableId+"_"+(addRow+(parseInt(arrRow[SelectedTable]*(parseInt(NoofTables)-1))))+"_"+arrColIds[SelectedTable][SortOrder];
                                }
                            }
                            else
                            {
                                CompId = "row"+tableId+"_"+(addRow+(parseInt(arrRow[SelectedTable]*(NoofTables-1))))+"_"+arrColIds[SelectedTable][SortOrder];
                                RowIndex = (addRow+(parseInt(arrRow[SelectedTable]*(NoofTables-1))));
                                tdId  = "td"+tableId+"_"+(addRow+(parseInt(arrRow[SelectedTable]*(NoofTables-1))))+"_"+arrColIds[SelectedTable][SortOrder];
                            }
                        }

                        ColIndex = arrColIds[SelectedTable][SortOrder];
                        //alert("dd " + arrCompType[SelectedTable][addRow][addCol]);
                        //alert(arrDataTypesforCell[SelectedTable][addRow][addCol]);
                        if(arrCompType[SelectedTable][addRow][addCol]=="TEXT")
                        {
                            if(arrDataTypesforCell[SelectedTable][addRow][addCol] == "3")
                            {
                                addInputWithEvent(theform,arrCompType[SelectedTable][addRow][addCol],CompId,tr,"onBlur","CheckFloat1("+tableId+",this,"+SelectedTable+")",tdId);
                            }
                            else if(arrDataTypesforCell[SelectedTable][addRow][addCol] == "4")
                            {
                                addInputWithEvent(theform,arrCompType[SelectedTable][addRow][addCol],CompId,tr,"onChange","CheckNumeric("+tableId+",this,"+SelectedTable+")",tdId);
                            }
                            else if(arrDataTypesforCell[SelectedTable][addRow][addCol] == "8")
                            {
                                addInputWithEvent(theform,arrCompType[SelectedTable][addRow][addCol],CompId,tr,"onBlur","moneywithminus("+tableId+",this,"+SelectedTable+")",tdId);
                            }
                            else if(arrDataTypesforCell[SelectedTable][addRow][addCol] == "1")
                            {
                                addInputWithEvent(theform,arrCompType[SelectedTable][addRow][addCol],CompId,tr,"onBlur1","validateNonUsed(this,2)",tdId);
                            }
                            else if(arrDataTypesforCell[SelectedTable][addRow][addCol] == "9")
                            {
                                var originalCmb = document.getElementById("idcombodetail"+tableId+"_"+addRow+"_"+addCol);
                                var cmbdefaultVal = document.getElementById("idcombodetail"+tableId+"_"+addRow+"_"+addCol).value;
                                addHiddenInputWithEvent(theform,arrCompType[SelectedTable][addRow][addCol],CompId,tr,"onBlur","moneywithminus("+tableId+",this,"+SelectedTable+")",tdId,originalCmb,tableId,cmbdefaultVal);
                            }
                            else if(arrDataTypesforCell[SelectedTable][addRow][addCol] == "10")
                            {
                                var originalCmb = document.getElementById("idcombodetail"+tableId+"_"+addRow+"_"+addCol);
                                var cmbdefaultVal = document.getElementById("idcombodetail"+tableId+"_"+addRow+"_"+addCol).value;
                                addHiddenInputWithEvent(theform,arrCompType[SelectedTable][addRow][addCol],CompId,tr,"onBlur","moneywithminus("+tableId+",this,"+SelectedTable+")",tdId,originalCmb,tableId,cmbdefaultVal);
                            }
                            else if(arrDataTypesforCell[SelectedTable][addRow][addCol] == "12")
                            {
                                addInputDateWithEvent(theform,arrCompType[SelectedTable][addRow][addCol],CompId,tr,"onclick","GetCal('"+CompId+"','"+CompId+"','"+tableId+"',this,'"+SelectedTable+"')",tdId,tableId);
                            }
                        }
                        else if(arrCompType[SelectedTable][addRow][addCol]=="SELECT")
                        {
                            var originalCmb = document.getElementById("row"+tableId+"_"+addRow+"_"+addCol);
                            addSelect(theform,CompId,originalCmb,tr,tdId);
                        }
                        else if(arrCompType[SelectedTable][addRow][addCol]=="TEXTAREA")
                        {
                            //alert(" co " + CompId + " : " + RowIndex + " : " + tdId);
                            if(readOnly == "readOnly")
                            {
                                addTextAreawithReadOnly(theform,CompId,tr,tdId,true);
                            }
                            else
                            {
                                addTextArea(theform,CompId,tr,tdId);
                            }

                        }
						

                        SortOrder++;

                    //alert("Com " + CompId + " :: row " + arrRow[SelectedTable] + " no " + NoofTables );
                    //alert("Row " + RowIndex);



                    }//end of else other cells
                }//end of else maitrak


            }
            //if not last row
            else
            {

                //alert("text area td  " + tdId + " :: " + CompId+ " :: " + tr.id);

                //alert('SelectedTable : '+SelectedTable);
                //alert('addRow : '+addRow);
                //alert('addCol : '+addCol);
                                
                //alert('arrCellData['+SelectedTable+']['+addRow+']['+addCol+'] : '+arrCellData[SelectedTable][addRow][addCol]);
                                
                //for creating GovSide cells
                if(arrCellData[SelectedTable][addRow][addCol] != null && arrCellData[SelectedTable][addRow][addCol] != "" && arrCellData[SelectedTable][addRow][addCol] != "null")
                {
                    if(isColTotalforTable[SelectedTable] != 0)
                    {
                        if(chkEdit == true)
                        {
                            //alert(" bi " + arrBidCount[SelectedTable] + " : row " + arrRow[SelectedTable] + " : no " + NoofTables);
                            if(arrBidCount[SelectedTable] > 1)
                            {
                                tdId = "td"+tableId+"_"+parseInt(addRow+(parseInt(arrRow[SelectedTable])*parseInt(arrBidCount[SelectedTable])-parseInt(arrBidCount[SelectedTable])))+"_"+arrStaticColIds[SelectedTable][StaticIndex];
                            }
                            else
                            {
                                tdId = "td"+tableId+"_"+(addRow+(parseInt(arrRow[SelectedTable]*parseInt(arrBidCount[SelectedTable])) - parseInt(NoofTables - arrBidCount[SelectedTable])))+"_"+arrStaticColIds[SelectedTable][StaticIndex];

                            }
                        //alert(" td " +tdId);
                        }
                        else
                        {
                            tdId = "td"+tableId+"_"+(addRow+parseInt(parseInt(parseInt(arrRow[SelectedTable])*parseInt(parseInt(NoofTables) - 1) - parseInt(parseInt(NoofTables) - 1))))+"_"+arrStaticColIds[SelectedTable][StaticIndex];
                        }
                    }

                    if(isColTotalforTable[SelectedTable] == 0)
                    {
                        if(chkEdit == true)
                        {
                            if(arrBidCount[SelectedTable] > 1)
                            {
                                tdId = "td"+tableId+"_"+(addRow+(parseInt(arrRow[SelectedTable]*(NoofTables))))+"_"+arrStaticColIds[SelectedTable][StaticIndex];
                            }
                            else
                            {
                                tdId = "td"+tableId+"_"+(addRow+(parseInt(arrRow[SelectedTable]*(NoofTables-1))))+"_"+arrStaticColIds[SelectedTable][StaticIndex];
                            }
                        }
                        else
                        {
                            tdId = "td"+tableId+"_"+(addRow+(parseInt(arrRow[SelectedTable]*(NoofTables-1))))+"_"+arrStaticColIds[SelectedTable][StaticIndex];
                        }
                    }

                    //alert(" td  in edit " + tdId +" row " + arrRow[SelectedTable] + " Nof " + NoofTables + " " + arrStaticColIds[SelectedTable][StaticIndex]);
                    addTD(new String(arrCellData[SelectedTable][addRow][addCol]),tr,1,tdId,true);
                    lbl_ids[lbl_ids.length] = "lbl@"+tdId.substring(2,tdId.length);
                    StaticIndex++;
                }//end of if govdata
                //for All Other Cells
                else
                {
                                    
                    if(isColTotalforTable[SelectedTable] != 0)
                    {

                        if(chkEdit == true)
                        {

                            if(arrBidCount[SelectedTable] > 1) //if in edit table added more than once
                            {
                                /*CompId = "row"+tableId+"_"+parseInt(addRow+(parseInt(arrRow[SelectedTable])*parseInt(arrBidCount[SelectedTable])-parseInt(arrBidCount[SelectedTable])))+"_"+arrColIds[SelectedTable][SortOrder];
								RowIndex = parseInt(addRow+(parseInt(arrRow[SelectedTable])*parseInt(arrBidCount[SelectedTable])-parseInt(arrBidCount[SelectedTable])));
								tdId = "td"+tableId+"_"+parseInt(addRow+(parseInt(arrRow[SelectedTable])*parseInt(arrBidCount[SelectedTable])-parseInt(arrBidCount[SelectedTable])))+"_"+arrColIds[SelectedTable][SortOrder];*/


                                CompId = "row"+tableId+"_"+parseInt(addRow+(parseInt(arrRow[SelectedTable])*parseInt(arrBidCount[SelectedTable])-parseInt(arrBidCount[SelectedTable])))+"_"+addCol;
                                RowIndex = parseInt(addRow+(parseInt(arrRow[SelectedTable])*parseInt(arrBidCount[SelectedTable])-parseInt(arrBidCount[SelectedTable])));
                                tdId = "td"+tableId+"_"+parseInt(addRow+(parseInt(arrRow[SelectedTable])*parseInt(arrBidCount[SelectedTable])-parseInt(arrBidCount[SelectedTable])))+"_"+addCol;

                            }
                            else
                            {
                                //alert(" ro " + addRow + " : arr " + arrRow[SelectedTable] + " : bid " + arrBidCount[SelectedTable] + " :: nof "  + NoofTables + " :dd " +  arrColIds[SelectedTable][SortOrder] + " :ss " + SortOrder + " : " +addCol);
                                CompId = "row"+tableId+"_"+(addRow+(parseInt(arrRow[SelectedTable]*parseInt(arrBidCount[SelectedTable])) - parseInt(NoofTables - arrBidCount[SelectedTable])))+"_"+addCol;
                                RowIndex = addRow+(parseInt(arrRow[SelectedTable]*parseInt(arrBidCount[SelectedTable])) - parseInt(NoofTables - arrBidCount[SelectedTable]));
                                tdId = "td"+tableId+"_"+(addRow+(parseInt(arrRow[SelectedTable]*parseInt(arrBidCount[SelectedTable])) - parseInt(NoofTables - arrBidCount[SelectedTable])))+"_"+addCol;

                            }
                        //alert(" co " + CompId + " : R " + RowIndex + " : td " + tdId);

                        }
                        else
                        {
                            CompId = "row"+tableId+"_"+(addRow+parseInt(parseInt(parseInt(arrRow[SelectedTable])*parseInt(parseInt(NoofTables) - 1) - parseInt(parseInt(NoofTables) - 1))))+"_"+arrColIds[SelectedTable][SortOrder];
                            RowIndex = (addRow+parseInt(parseInt(parseInt(arrRow[SelectedTable])*parseInt(parseInt(NoofTables) - 1) - parseInt(parseInt(NoofTables) - 1))));
                            tdId = "td"+tableId+"_"+(addRow+parseInt(parseInt(parseInt(arrRow[SelectedTable])*parseInt(parseInt(NoofTables) - 1) - parseInt(parseInt(NoofTables) - 1))))+"_"+arrColIds[SelectedTable][SortOrder];
                        }
                    //alert(" before com " + CompId + " : row " + RowIndex + " : tdId " + tdId);
                    }


                    if(isColTotalforTable[SelectedTable] == 0)
                    {
                        //alert(chkEdit);
                        if(chkEdit == true) // if edit
                        {
                            //alert('NoofTables : '+NoofTables);
                            //alert('arrRow[SelectedTable] : '+arrRow[SelectedTable]);
                            //alert('addRow : '+addRow);
                            //alert('totalBidTable : '+totalBidTable[SelectedTable]);
                            if(arrBidCount[SelectedTable] > 1) //if in edit table added more than once
                            {
                                //alert(totalBidTable[SelectedTable] + " ---- " + addRow+(parseInt(arrRow[SelectedTable]*(parseInt(totalBidTable[SelectedTable])))));
                                CompId = "row"+tableId+"_"+(addRow+(parseInt(arrRow[SelectedTable]*(parseInt(totalBidTable[SelectedTable])))))+"_"+arrColIds[SelectedTable][SortOrder];
                                //alert('CompId if : '+CompId);
                                RowIndex = (addRow+(parseInt(arrRow[SelectedTable]*(parseInt(NoofTables)))));
                                tdId  = "td"+tableId+"_"+(addRow+(parseInt(arrRow[SelectedTable]*(parseInt(NoofTables)))))+"_"+arrColIds[SelectedTable][SortOrder];
                            }
                            else
                            {
                                //alert(addRow+(parseInt(arrRow[SelectedTable]*(parseInt(totalBidTable[SelectedTable])))));
                                CompId = "row"+tableId+"_"+(addRow+(parseInt(arrRow[SelectedTable]*(parseInt(totalBidTable[SelectedTable])))))+"_"+arrColIds[SelectedTable][SortOrder];
                                //alert('CompId else : '+CompId);
                                RowIndex = (addRow+(parseInt(arrRow[SelectedTable]*(parseInt(NoofTables)-1))));
                                tdId  = "td"+tableId+"_"+(addRow+(parseInt(arrRow[SelectedTable]*(parseInt(NoofTables)-1))))+"_"+arrColIds[SelectedTable][SortOrder];
                            }
                        //totalBidTable[SelectedTable] = parseInt(parseInt(totalBidTable[SelectedTable])+ 1);

                        }
                        else
                        {
                            CompId = "row"+tableId+"_"+(addRow+(parseInt(arrRow[SelectedTable]*(NoofTables-1))))+"_"+arrColIds[SelectedTable][SortOrder];
                                                        
                            RowIndex = (addRow+(parseInt(arrRow[SelectedTable]*(NoofTables-1))));
                                                        
                            tdId  = "td"+tableId+"_"+(addRow+(parseInt(arrRow[SelectedTable]*(NoofTables-1))))+"_"+arrColIds[SelectedTable][SortOrder];
                                                        
                        }
                    }
                    //alert(" co " + CompId + " : " + RowIndex + " : " + tdId);

                    //ColIndex = arrColIds[SelectedTable][SortOrder];
                    ColIndex = addCol;

                    //alert(arrCompType[SelectedTable][addRow][addCol]);
                    if(arrCompType[SelectedTable][addRow][addCol]=="TEXT")
                    {
                        //alert(arrDataTypesforCell[SelectedTable][addRow][addCol]);
                        if(arrDataTypesforCell[SelectedTable][addRow][addCol] == "3")
                        {
                            addInputWithEvent(theform,arrCompType[SelectedTable][addRow][addCol],CompId,tr,"onBlur","CheckFloat1("+tableId+",this,"+SelectedTable+")",tdId);
                        }
                        else if(arrDataTypesforCell[SelectedTable][addRow][addCol] == "4")
                        {
                            addInputWithEvent(theform,arrCompType[SelectedTable][addRow][addCol],CompId,tr,"onChange","CheckNumeric("+tableId+",this,"+SelectedTable+")",tdId);
                        }
                        else if(arrDataTypesforCell[SelectedTable][addRow][addCol] == "8")
                        {
                            addInputWithEvent(theform,arrCompType[SelectedTable][addRow][addCol],CompId,tr,"onBlur","moneywithminus("+tableId+",this,"+SelectedTable+")",tdId);
                        }
                        else if(arrDataTypesforCell[SelectedTable][addRow][addCol] == "1")
                        {
                            addInputWithEvent(theform,arrCompType[SelectedTable][addRow][addCol],CompId,tr,"onBlur1","validateNonUsed(this,2)",tdId);
                        }
                        else if(arrDataTypesforCell[SelectedTable][addRow][addCol] == "9")
                        {
                            var originalCmb = document.getElementById("idcombodetail"+tableId+"_"+addRow+"_"+addCol);
                            addHiddenInputWithEvent(theform,arrCompType[SelectedTable][addRow][addCol],CompId,tr,"onBlur","moneywithminus("+tableId+",this,"+SelectedTable+")",tdId,originalCmb,tableId);
                        }
                        else if(arrDataTypesforCell[SelectedTable][addRow][addCol] == "10")
                        {
                            var originalCmb = document.getElementById("idcombodetail"+tableId+"_"+addRow+"_"+addCol);
                            addHiddenInputWithEvent(theform,arrCompType[SelectedTable][addRow][addCol],CompId,tr,"onBlur","moneywithminus("+tableId+",this,"+SelectedTable+")",tdId,originalCmb,tableId);
                        }
                        else if(arrDataTypesforCell[SelectedTable][addRow][addCol] == "12")
                        {
                            addInputDateWithEvent(theform,arrCompType[SelectedTable][addRow][addCol],CompId,tr,"onclick","GetCal('"+CompId+"','"+CompId+"','"+tableId+"',this,'"+SelectedTable+"')",tdId,tableId);
                        }
                    }
                    else if(arrCompType[SelectedTable][addRow][addCol]=="SELECT")
                    {
                        var originalCmb = document.getElementById("row"+tableId+"_"+addRow+"_"+addCol);
                        addSelect(theform,CompId,originalCmb,tr,tdId);
                    }
                    else if(arrCompType[SelectedTable][addRow][addCol]=="TEXTAREA")
                    {
                        //alert(" co " + CompId + " : " + RowIndex + " : " + tdId);

                        if(readOnly == "readOnly")
                        {
                            addTextAreawithReadOnly(theform,CompId,tr,tdId,true);
                        }
                        else
                        {
                            addTextArea(theform,CompId,tr,tdId);
                        }

                    }
					
                    SortOrder++;

                //alert("Com " + CompId + " :: row " + arrRow[SelectedTable] + " no " + NoofTables );
                //alert("Row " + RowIndex);
                }//end of else other cells
            }//else for if not last row
        //alert(" before com " + CompId + " : row " + RowIndex + " : tdId " + tdId + " : arrco " + addCol);
        }//end of for arrCol
        //alert("tr.innerHTML:==>" + tr.innerHTML);
        tempBody.appendChild(tr);

    }//end of for arrRow

    //alert("chkEdit --->"+chkEdit+"<---------");
    if(chkEdit){
        totalBidTable[SelectedTable] = tableCnt;
    //alert(" aT the end " + totalBidTable[SelectedTable]);
    }
    if(arrBidCount[SelectedTable] != 0 )
        arrBidCount[SelectedTable] = parseInt(arrBidCount[SelectedTable]) + parseInt(1);

    checkForFunctions();
    for(var z=0;z<lbl_ids.length;z++)
    {
        var first_delim=lbl_ids[z].indexOf('@');
        var tblid=lbl_ids[z].substring(first_delim+1,lbl_ids[z].length);
        var second_delim=tblid.indexOf('_');
        var tableid=tblid.substring(0,second_delim);
        countFormula(tableid,document.getElementById(lbl_ids[z]));
    }

}//end of function


