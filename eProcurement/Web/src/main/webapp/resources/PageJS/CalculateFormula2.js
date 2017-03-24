
function AddBidTable(theform,tableId,button1){
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
        if(isColTotalforTable[SelectedTable] == 0)
        {
            if(chkEdit == true)
            {
                if(arrBidCount[SelectedTable] > 1)
                {
                    //alert("  in bid " + arrBidCount[SelectedTable] + " row " + arrRow[SelectedTable] + " no " + NoofTables);
                    //alert('SelectedTable : '+SelectedTable);
                    //alert('addRow : '+addRow);
                    //alert('arrRow[SelectedTable] : '+arrRow[SelectedTable]);
                    //alert('NoofTables : '+NoofTables);
                    //alert('actRow : '+parseInt(addRow+(parseInt(arrRow[SelectedTable])*parseInt(NoofTables))));
                    tr.setAttribute("id","row"+tableId+"_"+parseInt(addRow+(parseInt(arrRow[SelectedTable])*parseInt(NoofTables))));
                    if(addRow==1){
                        checkBoxCell.innerHTML="<input type='checkbox' id='"+"chk"+tableId+"_"+parseInt(addRow+(parseInt(arrRow[SelectedTable])*parseInt(NoofTables)))+"' />";
                    }
                }
                else
                {
                    //alert(" bid " + arrBidCount[SelectedTable] + " row " + arrRow[SelectedTable] + " no " + NoofTables);
                    tr.setAttribute("id","row"+tableId+"_"+parseInt(addRow+(parseInt(arrRow[SelectedTable])*parseInt(NoofTables-1))));
                    if(addRow==1){
                        checkBoxCell.innerHTML="<input type='checkbox' id='"+"chk"+tableId+"_"+parseInt(addRow+(parseInt(arrRow[SelectedTable])*parseInt(NoofTables-1)))+"' />";
                    }
                }
            //alert(" tr id " + tr.id);
            //alert(" no " + NoofTables + " rows " + arrRow[SelectedTable] + " id " + tr.id);
            }
            else
            {
                //alert(parseInt(addRow+(parseInt(arrRow[SelectedTable])*parseInt(NoofTables-1))));
                tr.setAttribute("id","row"+tableId+"_"+parseInt(addRow+(parseInt(arrRow[SelectedTable])*parseInt(NoofTables-1))));
                if(addRow==1){
                    checkBoxCell.innerHTML="<input type='checkbox' id='"+"chk"+tableId+"_"+parseInt(addRow+(parseInt(arrRow[SelectedTable])*parseInt(NoofTables-1)))+"' />";
                }
            //alert(" no " + NoofTables + " rows " + arrRow[SelectedTable] + " id " + tr.id);
            }
        }

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
                        checkBoxCell.innerHTML="<input type='checkbox' id='"+"chk"+tableId+"_"+parseInt(addRow+(parseInt(arrRow[SelectedTable])*parseInt(arrBidCount[SelectedTable]) - parseInt(arrBidCount[SelectedTable])))+"' />";
                    }
                }
                else
                {
                    //alert(" bid " + arrBidCount[SelectedTable] + " row " + arrRow[SelectedTable] + " no " + NoofTables + " : " +addRow);
                    tr.setAttribute("id","row"+tableId+"_"+parseInt(addRow+(parseInt(arrRow[SelectedTable]) - parseInt(NoofTables-1))));
                    if(addRow==1){
                        checkBoxCell.innerHTML="<input type='checkbox' id='"+"chk"+tableId+"_"+parseInt(addRow+(parseInt(arrRow[SelectedTable]) - parseInt(NoofTables-1)))+"' />";
                    }
                }
            //alert(" no 1 " + NoofTables + " rows " + arrRow[SelectedTable] + " id " + tr.id);
            }
            else
            {
                //alert('row : '+parseInt(addRow+(parseInt(arrRow[SelectedTable])*parseInt(NoofTables-1))));
                tr.setAttribute("id","row"+tableId+"_"+parseInt(addRow+(  parseInt(parseInt(arrRow[SelectedTable])*parseInt(NoofTables-1) - parseInt(NoofTables-1)))));
                if(addRow==1){
                    checkBoxCell.innerHTML="<input type='checkbox' id='"+"chk"+tableId+"_"+parseInt(addRow+(  parseInt(parseInt(arrRow[SelectedTable])*parseInt(NoofTables-1) - parseInt(NoofTables-1))))+"' />";
                }
            //alert(" no 2 " + NoofTables + " rows " + arrRow[SelectedTable] + " id " + tr.id);
            }
        }
        tr.appendChild(checkBoxCell);
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
                        //alert("total in words col...hiravhirav");

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
}

function applyRowFunction(IdList,tabIndex,tableId,storeIn,Rowid)
{
    //alert("In Row");
    var str = 0.0;
    if(IdList[0].toUpperCase()=='WORD')
    {
        var tBox = document.getElementById("row"+tableId+"_"+Rowid+"_"+IdList[IdList.length-2]);
        LoopCounter++;
        if(tBox!=null)
        {
            //      str += ((tBox.value=="")?0:parseInt(tBox.value));
            // Changed - Ravi. 8.5.06 : 11.07 am
            str += ((tBox.value=="")?0:tBox.value);
            document.getElementById("row"+tableId+"_"+Rowid+"_"+IdList[IdList.length-2]).readOnly=true;
            document.getElementById("row"+tableId+"_"+Rowid+"_"+IdList[IdList.length-2]).tabIndex=-1;
        }
    }
    else
        for(var j=0;j<arrCol[tabIndex];j++)
        {
            str = "";
            for(var i=0;i<IdList.length;i++)
            {
                var tBox ="";
                if(IdList[i] != 'p')
                {
                    tBox = document.getElementById("row"+tableId+"_"+Rowid+"_"+IdList[i]);
                    if(tBox!=null)
                    {
                        if(tBox.value=="")
                            str += 0;
                        else
                            str += tBox.value;
                    }
                    else if(isNaN(IdList[i]))
                    {
                        str += IdList[i];
                    }
                    else
                    {
                        if(document.getElementById("lbl@"+tableId+"_"+Rowid+"_"+IdList[i]) !=null)
                            str += document.getElementById("lbl@"+tableId+"_"+Rowid+"_"+IdList[i]).innerHTML;
                    }
                }
                else
                {
                    str += '100';
                }
                LoopCounter++;
            }
        }

    var resultTbox = document.getElementById("row"+tableId+"_"+Rowid+"_"+storeIn);

    if(resultTbox!=null)
    {
        if(IdList[0].toUpperCase() != 'WORD')
        {
            try
            {
                resultTbox.value = eval(Math.round(eval(eval(str)*100000))/100000);
            }
            catch(e)
            {
                resultTbox.value = "";
                resultTbox.style.color = "red";
            }
        }
        else
        {

            var res=DoIt(eval(parseFloat(str)));
            resultTbox.value=res;
        }
        resultTbox.readOnly=true;
        resultTbox.tabIndex=-1;
        countFormula(tableId,resultTbox);
    }
    str=0.0;
}


function applyColumnFunction(IdList,tabIndex,tableId,storeIn,Rowid,funcType)
{

    //alert('applyColumnFunction');
    var NoofTables = parseInt(arrTableAdded[tabIndex]);
    var str=0;
    var NoofRows=0;

    if(chkEdit != true)
    {
        NoofRows = parseInt(arrRow[tabIndex]*NoofTables)-parseInt(NoofTables);
    }
    else
    {
        //alert(" :: " + arrBidCount[tabIndex] + " :: " + arrRow[tabIndex] + " :: " + NoofTables);
        //NoofRows = parseInt(((parseInt(arrBidCount[tabIndex])-1)*arrRow[tabIndex])*NoofTables)-parseInt(NoofTables);
        NoofRows = parseInt((arrBidCount[tabIndex]*arrRow[tabIndex])-parseInt(arrBidCount[tabIndex]));
    }
    //alert(" N " + NoofRows);
    if(funcType.toUpperCase()=="TOTAL")
        for(var j=1;j<=NoofRows;j++)
        {
            var tBox = document.getElementById("row"+tableId+"_"+(j-1)+"_"+IdList[IdList.length-2]);
            //alert("document.getElementById(row"+tableId+"_"+(j-1)+"_"+IdList[IdList.length-2]);
            if(tBox!=null)
            {
                str += ((tBox.value=="")?0.0:parseFloat(tBox.value));
                try
                {
                    str=Math.round(eval(eval(str)*100000))/100000;
                }
                catch(e)
                {
                    str="987";
                }
            }
            LoopCounter++;

            if((j%(parseInt(NoofRows))) ==0)
            {
                document.getElementById("row"+tableId+"_"+(j)+"_"+IdList[IdList.length-2]).value = eval(str);
                document.getElementById("row"+tableId+"_"+(j)+"_"+IdList[IdList.length-2]).readOnly=true;
                document.getElementById("row"+tableId+"_"+(j)+"_"+IdList[IdList.length-2]).tabIndex=-1;
                str=0;
                continue;
            }

        }
/*//if((j%(arrRow[tabIndex]*NoofTables))==0)

    //{
        document.getElementById("row"+tableId+"_"+(arrRow[tabIndex]*NoofTables)-1+"_"+IdList[IdList.length-2]).value = eval(str);
        str=0;
	//continue;
      //}
    */
}

function countFormula(tableId,tBox)
{
    //alert(" in countformula : " + tBox.id);
    var Colid = tBox.id.substring(tBox.id.lastIndexOf("_")+1,tBox.id.length);
    var Rowid = tBox.id.substring(tBox.id.indexOf("_")+1,tBox.id.lastIndexOf("_"));
    var SelectedTable;

    //alert('Rowid : '+Rowid);
    //alert('Colid : '+Colid);

    //alert(signClick);
    //if(signClick == false)
    //{
    for(var i=0;i<arr.length;i++)
    {
        if(arr[i]==tableId)
        {
            SelectedTable = i;
            LoopCounter++;
            break;
        }
    }

    if(arrTableFormula[SelectedTable] != undefined)
    {
        for(var i=0;i<arrTableFormula[SelectedTable].length;i++)
        {
            for(var j=0;j<arrIds[SelectedTable][i].length;j++)
            {
                if(arrIds[SelectedTable][i][j]==Colid) // Improve Place 1
                {
                    LoopCounter++;
                    var temp = arrIds[SelectedTable][i][0];
                    var  storeIn = arrFormulaFor[SelectedTable][i];

                    if(temp.toUpperCase()=='TOTAL'||temp.toUpperCase()=='AVG')
                    {
                        applyColumnFunction(arrIds[SelectedTable][i],SelectedTable,tableId,storeIn,Colid,temp.toUpperCase());
                        break;
                    }
                    else
                    {
                        applyRowFunction(arrIds[SelectedTable][i],SelectedTable,tableId,storeIn,Rowid);
                        //alert(" after " + Rowid);
                        break;
                    }
                }
            }
        }
    }
//}
}

function TestCalculate()
{
    var d1=new Date();
    for(var ii=0;ii<document.all.length;ii++)
    {
        try
        {
            var element=document.all[ii];
            var elementName=element.name;
            if(element.type !="hidden" && elementName.substring(0,3)=="row")
            {
                var tableId = elementName.substring(3,elementName.indexOf("_"));
                countFormula(tableId, element);
            }
        }
        catch(e)
        {
        //alert(document.all[ii].name);
        }
    }
}

function numerictestforfloat(textbox)
{
    var string=textbox.value;
    var re5digit=/^([0-9])+$/

    if (!re5digit.test(string))
    {
        return false;
    }
    return true;

}

function CheckSmallText(tableid, tBox){
    var val= trim(tBox.value);
    if(val.length > 1000){
        jAlert(MSG_AUC_CHARSIZE,MSG_AUC_FORMULALERT, function(retVal) {});
        tBox.value = val.substring(0, 1000);
        tBox.focus();
        return false;
    }
}

function CheckLongText(tableid, tBox){
    var val= trim(tBox.value);
    if(val.length > 10000){
        alert(MSG_AUC_CHARSIZE);
        tBox.value = val.substring(0, 10000);
        tBox.focus();
        return false;
    }
}

function ChangeAllinnerHtml(theform)
{
    //alert("in fuction");
    var inputtag = document.getElementsByTagName("input");
    var textareatag = document.getElementsByTagName("textarea");
    var listtag = document.getElementsByTagName("select");
    var imglist = document.getElementsByTagName("img");
    var fillbycomp = 0;
    var tagid="";
    var datatypecomp=0;
    var celltableid = 0;
    var td;
    var func;
    var tindex;
    var inpvalue;
    var inptype;
    var ronly="";
    var rowid = "";
    var colid="";
    var arrrowcolid = new Array();


    for(var inputcount=0;inputcount<inputtag.length;inputcount++)
    {

        tagid = inputtag[inputcount].id;


        if(tagid.indexOf("_") != -1 && inputtag[inputcount].type=="text")
        {
            fillbycomp = parseInt(tagid.substring(tagid.lastIndexOf("_")+1,tagid.length));
            tagid = tagid.substring(0,tagid.lastIndexOf("_"));

            inpvalue = inputtag[inputcount].value;
            inptype = trim(inputtag[inputcount].type);

            datatypecomp = tagid.substring(tagid.lastIndexOf("_")+1,tagid.length);
            tagid = tagid.substring(0,tagid.lastIndexOf("_"));

            tindex = inputtag[inputcount].tabIndex;

            inputtag[inputcount].setAttribute("id",tagid);
            celltableid = tagid.substring(3,tagid.indexOf("_"));
            arrrowcolid = tagid.split("_");
            //alert(" arrowcolid " + arrrowcolid[0]);

            td = "td"+tagid.substring(3,tagid.length);

            // alert(td + " : " + inpvalue + " : " + datatypecomp + " : " + inputcount);
            // td = inputtag[inputcount].id;
            //alert( "Td " + tagid.substring(3,tagid.length));
            // alert(td);

            document.getElementById(td).innerHTML="";
            document.getElementById(td).setAttribute("class","normaltext");

            if(parseInt(datatypecomp) == 3 )
            {
                if(fillbycomp == 3)
                {
                    func = "countFormula_New(" + celltableid + ","+arrrowcolid[1]+","+arrrowcolid[2]+")";
                    ronly = "readonly";
                }
                else
                {
                    func = "CheckFloat1(" + celltableid + ",this)";
                    ronly="";
                }
            }

            if(parseInt(datatypecomp) == 1 )
            {
                //alert(" in " + tagid );
                //func = "validate(this,2)";
                func="";
                if(fillbycomp == 3)
                    ronly="readonly";
                else
                    ronly = "";

            }

            if(parseInt(datatypecomp) == 8 )
            {
                if(fillbycomp == 3)
                {
                    func = "countFormula_New(" + celltableid +  ","+arrrowcolid[1]+","+arrrowcolid[2]+")";
                    ronly = "readonly";
                }
                else
                {
                    func = "moneywithminus1(this);countFormula_New("+celltableid+","+arrrowcolid[1]+","+arrrowcolid[2]+")";
                    ronly="";

                }
            }

            if(parseInt(datatypecomp) == 4 )
            {
                if(fillbycomp == 3)
                {
                    func = "countFormula_New(" + celltableid + ","+arrrowcolid[1]+","+arrrowcolid[2]+")";
                    ronly = "readonly";
                }
                else
                {
                    func = "numeric(this);countFormula_New("+celltableid+","+arrrowcolid[1]+","+arrrowcolid[2]+")";
                    ronly="";
                }
            }

            if(parseInt(datatypecomp) == 7)
            {
                //alert(" in if " + inputtag[inputcount].value + " : " + inputcount);
                var row = document.getElementById(td).parentNode;
                addDate(theform,tagid,row,inpvalue,td);

            }
            else
            {

                //alert(" in else " + tagid + " :: " + datatypecomp);
                addInputWithEventInTdwithValue(theform,inptype,tagid,"onBlur",func,td,inpvalue,tindex,ronly);
            }

            document.getElementById(tagid).setAttribute("class","text-box");
        }


    }//for loop of input



    for(var textareacount=0;textareacount<textareatag.length;textareacount++)
    {

        tagid = textareatag[textareacount].id;

        if(tagid.indexOf("_") != -1)
        {
            fillbycomp = parseInt(tagid.substring(tagid.lastIndexOf("_")+1,tagid.length));
            tagid = tagid.substring(0,tagid.lastIndexOf("_"));

            textareatag[textareacount].setAttribute("id",tagid);

            if(parseInt(fillbycomp) == 3 )
            {
                textareatag[textareacount].readOnly = true;
            //alert(" in if");
            }
            else
            {
                textareatag[textareacount].readOnly = false;
            }
        }

    }//for loop of input


    for(var listcount=0;listcount<listtag.length;listcount++)
    {
        listtag[listcount].disabled = false;
        listtag[listcount].attachEvent("onChange",xyz);
    }

    return true;
}


function Setup() 
{ 
    // set Globals
    Affix = new Array('Units', 'Thousand', 'Lakh', 'Crore')
    for(i=1;i<5;i++)
    {
        Affix[3+i] = Affix[0+i]
    }
    Name = new Array
    ('Zero', 'One', 'Two', 'Three', 'Four', 'Five', 'Six',
        'Seven', 'Eight', 'Nine', 'Ten', 'Eleven', 'Twelve',
        'Thirteen', 'Fourteen', 'Fifteen',  'Sixteen', 'Seventeen',
        'Eighteen', 'Nineteen')
    Namety = new Array('Twenty', 'Thirty', 'Forty',
        'Fifty', 'Sixty', 'Seventy', 'Eighty', 'Ninety')
    PointName = new Array
    ('Zero', 'One', 'Two', 'Three', 'Four', 'Five', 'Six',
        'Seven', 'Eight', 'Nine')
}

function DoIt(Numeric){ 
    Setup();
    Q = Numeric;
    if (isNaN(parseFloat(Q))){
        Word = '';
    }else{
        //-----------Code by umesh ------------------
        Word=''
        var tempStr1=new String();
        var tempStr3=new String();
        tempStr1=Q;
        tempStr1=tempStr1.toString();
        var tempstr2=tempStr1.search('-');
        if (tempstr2==0){
            Word = 'Minus ';
        //tempStr3='Minus ';
        //tempStr3.fontcolor("red");
        //Word=tempStr3;
        }
        Q=tempStr1.replace('-','')
		
        //---------------------comment old---------------------
        /*P = Math.round(((Q - Math.floor(Q))*100)*Math.pow(10,5))/Math.pow(10,5);
		//P = Math.round((Q - Math.floor(Q))*100)
		Q = Math.floor(Q)
	  	if (P<=9){
	  		P='0'+P;
	  	}

		if (P==0){	
			//Word = 'Rupee' + (Q==1?'':'s') + ' ' + TextCash(Q, 0) + 'Only'
			Word = Word + '' + (Q==1?'':'') + '' + TextCash(Q, 0) + '';
		}else{
    			//Word = 'Rupee' + (Q==1?'':'s') + ' ' + TextCash(Q, 0) + 'and Paisa' + ' ' + TextCash1(P, 0) + 'Only'
    			Word = Word + '' + (Q==1?'':'') + '' + TextCash(Q, 0) + 'point' + ' ' + TextCash2(P, 0) + '';
		}*/
        //----------------------comment old---------------------
		
        //-------------------yrj change-------------------------
        var P, pointStr3;
        qStr = Q.toString();
        if(qStr.indexOf(".") != -1){
            qStrAfterPoint = qStr.substring(qStr.indexOf(".")+1, qStr.length);
            P = eval(qStrAfterPoint);
            if(P == 0){
                pointStr3 = '';
            }else{
                var pointStr1= new String();
                var pointlen1,pointStr2;
                pointStr2="";
                pointStr3="";
                pointStr1=qStrAfterPoint;
                pointlen1= pointStr1.length;
	
                for(pointi=0;pointi<pointlen1;pointi++){
                    pointStr2=pointStr1.substr(pointi,1);
                    if(PointName[pointStr2] != undefined){
                        pointStr3=pointStr3+PointName[pointStr2]+' ';
                    }
                }
            }
        }else{
            P = 0;
        }
		
        Q = Math.floor(Q)
        if (P<=9){
            P='0'+P;
        }

        R = Q%10000000000;
        if (P==0){
            if(Q < 10000000000){
                Word = Word + '' + (Q==1?'':'') + '' + TextCash(Q, 0) + '';
            }else{
                Word = Word + '' + (Q==1?'':'') + '' + TextCash(Q, 0) + '';
                if(R == 0){
                    Word = Word + 'Crore';
                }
				
                X = Math.floor(Q/10000000);
                if(R!=0 && (X%10) == 0){
                    Word = '';
                    Word = Word + '' + (X==1?'':'') + '' + TextCash(X, 0) + 'Crore and ';
                    Word = Word + '' + (R==1?'':'') + '' + TextCash(R, 0) + '';
                }
            }
        }else{
            //TextCash2(P, 0)
            if(Q < 10000000000){
                Word = Word + '' + (Q==1?'':'') + '' + TextCash(Q, 0) + 'point' + ' ' + pointStr3 + '';
            }else{
                Word = Word + '' + (Q==1?'':'') + '' + TextCash(Q, 0);
                if(R == 0){
                    Word = Word + 'Crore ';
                }
                Word = Word + 'point' + ' ' + pointStr3 + '';
				
                X = Math.floor(Q/10000000);
                if(R!=0 && (X%10) == 0){
                    Word = '';
                    Word = Word + '' + (X==1?'':'') + '' + TextCash(X, 0) + 'Crore and ';
                    Word = Word + '' + (R==1?'':'') + '' + TextCash(R, 0) + 'point' + ' ' + pointStr3 + '';
                }
            }
        }
    //-------------------yrj change-------------------------
    }
    return Word
}

function WORD(no)
{
    //alert(no);
    return DoIt(eval(no));
}

function Small(TC, J, K)
{
    if (J==0) return TC
    if (J>999) return ' Internal ERROR: J = ' + J + ' (>999)'
    var S = TC
    if (J>99)
    {
        S += Name[Math.floor(J/100)] + ' Hundred ' ;
        J %= 100
        if (J>0) S += 'and '
    }
    else if ((S>'') && (J>0) && (K==0)) S += 'AND '
    if (J>19)
    {
        S += Namety[Math.floor(J/10)-2] ;
        J %= 10 ;
        S += ( J>0 ? '-' : ' ')
    }
    if (J>0) S += Name[J] + ' '
    if (K>0) S += Affix[K] + ' '
    return S
}

function TextCash(L, K)
{
    if (L==0) return (K>0 ? '' : 'Zero ')
    if (K==0 || K==3)
    {
        return Small(TextCash(Math.floor(L/1000), K+1), L%1000, K)
    }
    else
    {
        return Small(TextCash(Math.floor(L/100), K+1), L%100, K)
    }
}

function TextCash1(L, K)
{
    if (L==0) return (K>0 ? '' : 'NIL ')
    return Small(TextCash1(Math.floor(L/100), K+1), L%100, K)
}

function TextCash2(L, K)
{
    if (L==0) return (K>0 ? '' : 'NIL ')
    {
        var pointStr1= new String();
        var pointlen1,pointStr2,pointStr3;
        pointStr2="";
        pointStr3="";
        pointStr1=L;
        pointStr1=pointStr1.toString();
        pointlen1= pointStr1.length;
        //alert(pointStr1);
        for(pointi=0;pointi<pointlen1;pointi++)
        {
            pointStr2=pointStr1.substr(pointi,1);
            pointStr3=pointStr3+PointName[pointStr2]+' ';
        //alert(pointStr3);
        }
        return pointStr3;
    }
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

function CheckFloat1(tableid,tBox,tableIndex)
{

    var val= tBox.value;
    //alert(val);
    var Colid = tBox.id.substring(tBox.id.lastIndexOf("_")+1,tBox.id.length);
    var Rowid = tBox.id.substring(tBox.id.indexOf("_")+1,tBox.id.lastIndexOf("_"));
    var re5digit="^[0-9]+[\.][0-9]{1,"+decimalValueUpto+"}$";
    
    re5digit = new RegExp(re5digit);
    if(!verified)
        return false;
    
    if(val=="")
        return false;

    if(val.indexOf('0') == 0 && val.indexOf('.') != 1 && eval('val') != 0)
    {
        jAlert(MSG_AUC_REMOVELEADZERO,MSG_AUC_FORMULALERT, function(retVal) {
            tBox.value = "";
            tBox.focus();
        });
        
        return false;
    }

    
    if(!re5digit.test(val) )
    {
        
        if(tBox.getAttribute('btype')!=null && tBox.getAttribute('btype')=='5m5'){
            return chkFloatMinus5Plus5(tableid, tBox, tableIndex);
        }else{
            if(numerictestforfloat(tBox))
            {
                countFormula_New(tableid,Rowid,Colid,tableIndex);
                return true;
            }
            else
            {
                jAlert(MSG_AUC_ALLOWPOSITIVENUM,MSG_AUC_FORMULALERT, function(retVal) {
                    tBox.value="";
                    tBox.focus();
                });
                return false;;
            }
        }
    }
    else
    {
        countFormula_New(tableid,Rowid,Colid,tableIndex);
        return true;
    }
}

function CheckFloat2(tableid,tBox,tableIndex)
{

    var val= tBox.value;
    //alert(val);
    var Colid = tBox.id.substring(tBox.id.lastIndexOf("_")+1,tBox.id.length);
    var Rowid = tBox.id.substring(tBox.id.indexOf("_")+1,tBox.id.lastIndexOf("_"));
   var re5digit="^[0-9]+[\.][0-9]{1,"+decimalValueUpto+"}$";
    
    re5digit = new RegExp(re5digit);
    if(!verified)
        return false;
    
    if(val=="")
        return false;

    if(val.indexOf('0') == 0 && val.indexOf('.') != 1 && eval('val') != 0)
    {
        jAlert(MSG_AUC_REMOVELEADZERO,MSG_AUC_FORMULALERT, function(retVal) {
            tBox.value = "";
            tBox.focus();
        });
        
        return false;
    }

    
    if(!re5digit.test(val) )
    {        
        if(numerictestforfloat(tBox))
        {
            countFormula_New(tableid,Rowid,Colid,tableIndex);
            return true;
        }
        else
        {
            jAlert(MSG_AUC_ALLOWPOSITIVENUM,MSG_AUC_FORMULALERT, function(retVal) {
                tBox.value="";
                tBox.focus();
            });
            return false;;
        }
    }
    else
    {
        countFormula_New(tableid,Rowid,Colid,tableIndex);
        return true;
    }
}



function chkFloatMinus5Plus5(tableid,tBox,tableIndex)
{
    var val= tBox.value;
    //alert(val);
    var Colid = tBox.id.substring(tBox.id.lastIndexOf("_")+1,tBox.id.length);
    var Rowid = tBox.id.substring(tBox.id.indexOf("_")+1,tBox.id.lastIndexOf("_"));
    var re5digit=/^[-+]?[0-9]+[.]?[0-9]*$/
    
    if(!re5digit.test(val)){
        jAlert("Allows -5 to +5 numerals and maximum 3 digits after decimal (.) point.","", function(retVal) {
            tBox.value="";
            tBox.focus();
        });
        return false;
    }
    
    if(!verified || val=="")
    {
        return false;
    }

    var tmpArray = val.split('.');
    //alert('length '+tmpArray.length);
    //    alert(Math.round(parseFloat(tmpArray[0])));
    if( tmpArray.length > 2 ||
        (tmpArray.length == 2 && tmpArray[1].length > 3) ||
        (parseInt(tmpArray[0]) > 5 || parseInt(tmpArray[0]) < -5) ||
        ((parseInt(tmpArray[0]) >= 5 || parseInt(tmpArray[0]) <= -5) && parseInt(tmpArray[1]) > 0)
        )
        {
        jAlert("Allows -5 to +5 numerals and maximum 3 digits after decimal (.) point.","", function(retVal) {
            tBox.value="";
            tBox.focus();
        });
        return false;
    }

    if(val.indexOf('0') == 0 && val.indexOf('.') != 1 && eval('val') != 0)
    {
        jAlert(MSG_AUC_REMOVELEADZERO,MSG_AUC_FORMULALERT, function(retVal) {
            //tBox.value = "";
            tBox.focus();
        });
        return false;
    }

    countFormula_New(tableid,Rowid,Colid,tableIndex);
    return true;
/*if(!re5digit.test(val) )
    {
        if(numerictestforfloat(tBox))
        {
            countFormula_New(tableid,Rowid,Colid);
            return true;
        }
        else
        {
            jAlert("Allows -5 to +5 numerals & 3 digits after decimal (.) point.","", function(retVal) {
                tBox.value="";
                tBox.focus();
            });
            return false;
        }
    }
    else
    {
        countFormula_New(tableid,Rowid,Colid);
        return true;
    }*/
}

function chkSizeTextBox(tableId,tBox){
    if(tBox.value.length > 1000){
        jAlert("Please enter maximum 1000 characters.","Characters Allowed", function(retVal) {
            tBox.value="";
            tBox.focus();
        });
        return false;
    }
}
function chkSizeTextArea(tableId,tBox){
    if(tBox.value > 5000){
        jAlert("Please enter maximum 5000 characters.","Characters Allowed", function(retVal) {
            tBox.value="";
            tBox.focus();
        });
        return false;
    }
}
function CheckNumeric(tableId,tBox,tableIndex)
{
    var Colid = tBox.id.substring(tBox.id.lastIndexOf("_")+1,tBox.id.length);
    var Rowid = tBox.id.substring(tBox.id.indexOf("_")+1,tBox.id.lastIndexOf("_"));

    var string=trim(tBox.value);
    var re5digit=/^([0-9])+$/

    if(!verified)
        return false;
    
    if(string.indexOf('0') == 0 && string.indexOf('.') != 1 && string != 0)
    {
        jAlert(MSG_AUC_REMOVELEADZERO,MSG_AUC_FORMULALERT, function(retVal) {
            tBox.value="";
            tBox.focus();
        });
        
        return false;
    }


    if(string.length > 0){
        if (!re5digit.test(string)){
            jAlert("Please enter numeric value (0 to 9) only.","Title", function(retVal) {
                tBox.value="";
                tBox.focus();
            });
            
            return false;
        }
    }
    
    countFormula_New(tableId,Rowid,Colid,tableIndex);
    return true;
}

function CheckNumeric3Decimal(tableId,tBox,tableIndex)
{
    var Colid = tBox.id.substring(tBox.id.lastIndexOf("_")+1,tBox.id.length);
    var Rowid = tBox.id.substring(tBox.id.indexOf("_")+1,tBox.id.lastIndexOf("_"));

    var string=trim(tBox.value);

    if(!verified)
        return false;
    
    if(string.indexOf('0') == 0 && string.indexOf('.') != 1 && string != 0)
    {
        jAlert(MSG_AUC_REMOVELEADZERO,MSG_AUC_FORMULALERT, function(retVal) {
            tBox.value="";
            tBox.focus();
        });
        return false;
    }

    if(string.length > 0){
        
        var re = new RegExp("^-?\\d+\\.\\d{3}?$");

        if(!re.test(string)){
            jAlert("- Please enter Positive Numbers (0-9) only.<br /> - 3 Numbers after decimal (.) are required.<br /> - 3rd Digit after Decimal (.) must not be Zero.<br /> - For example 1001.123","Report Alert", function(retVal) {
                tBox.value = "";
                tBox.focus();
            });
            return false;
        }

        if(string.substring(string.length - 1,string.length) == 0){
            jAlert("- Please enter Positive Numbers (0-9) only.<br /> - 3 Numbers after decimal (.) are required.<br /> - 3rd Digit after Decimal (.) must not be Zero.<br /> - For example 1001.123","Report Alert", function(retVal) {
                tBox.value = "";
                tBox.focus();
            });
            return false;
        }
    }
    
    countFormula_New(tableId,Rowid,Colid,tableIndex);
    return true;
}

function CheckDate(tableId,tBox,txtname,controlname,tableIndex)
{
    //alert("CheckDate tableId : "+tableId+"tBox : "+tBox+"txtName : "+txtname+"controlName : "+controlname+"tableIndex"+tableIndex);
    var Colid = tBox.id.substring(tBox.id.lastIndexOf("_")+1,tBox.id.length);
    var Rowid = tBox.id.substring(tBox.id.indexOf("_")+1,tBox.id.lastIndexOf("_"));

    countFormula_New(tableId,Rowid,Colid,tableIndex);
    return true;
}


function moneywithminus(tableId,tBox,tableIndex)
{
    var Colid = tBox.id.substring(tBox.id.lastIndexOf("_")+1,tBox.id.length);
    var Rowid = tBox.id.substring(tBox.id.indexOf("_")+1,tBox.id.lastIndexOf("_"));
    var val=tBox.value;
    
    var re5digit=/^([0-9])+$/
    var v2;

    if(!verified)
        return false;
    
    if(val == "")
        return false;
    ;

    var val1;
    if(val.indexOf('0') == 0 && val.indexOf('.') != 1 && val != 0)
    {
        jAlert("Please remove all leading zeros.","Title", function(retVal) {
            tBox.value="";
            tBox.focus();
        });
        return false;
    }
    if(val.indexOf('-') == 0 )
    {
        if(val.indexOf('.') != 1)
        {
            if(val.indexOf('0') == 1 && val.indexOf('.') != 2)
            {
                jAlert("Please remove all leading zeros.","Title", function(retVal) {
                    tBox.value="";
                    tBox.focus();
                });
                return false;
            }
        }
        val1 = val.substring(val.indexOf('-')+1,val.length);
        if(val1.indexOf('-') > -1)
        {
            jAlert("Invalid Number Format","Title", function(retVal) {
                tBox.value="";
                tBox.focus();
            });
            return false;
        }
    }
    if(val.indexOf('.') > -1)
    {
        val1 = val.substring(val.indexOf('.')+1,val.length);
        var val2;
        if(val1.indexOf('.') > -1)
        {
            jAlert("Please remove additional decimal (.)","Title", function(retVal) {
                tBox.value="";
                tBox.focus();
            });
            return false;
        }
    }

    if(val.indexOf('-') != 0)
    {
        if(val.indexOf('.') != -1)
            v2 = val.substring(0,val.indexOf('.'));
        else
            v2 = val.substring(0,val.length);

        if(val.length > 0)
        {
            if (!re5digit.test(v2))
            {
                jAlert("Please enter a  proper value !","Title", function(retVal) {
                    tBox.value="";
                    tBox.focus();
                });
                return false;
            }
        }
    }
    if(val.indexOf('-') == 0)
    {
        if(val.indexOf('.') == -1)
        {
            v2 = val.substring(1,val.length);
        }
        else
        {
            v2 = val.substring(1,val.indexOf('.'));
        }

        if(val.length > 0)
        {
            if (!re5digit.test(v2))
            {
                jAlert("Please enter a  proper value !","Title", function(retVal) {
                    tBox.value="";
                    tBox.focus();
                });
                return false;
            }
        }
    }

    re5digit=/^[-][0-9]*$/

    if(!re5digit.test(val))
    {
        if(CheckFloat2(tableId, tBox,tableIndex))
        {
            return true;
        }
        else
        {
            tBox.value="";
            tBox.focus();
            return false;
        }
    }
    countFormula_New(tableId,Rowid,Colid,tableIndex);
    return true;
}

function changeTextVal(combo,tableid,tableIndex){
    var textId=combo.id;
    textId = textId.replace("idcombodetail","row");
    
    var Colid = textId.substring(textId.lastIndexOf("_")+1,textId.length);
    var Rowid = textId.substring(textId.indexOf("_")+1,textId.lastIndexOf("_"));
    document.getElementById(textId).value=combo.value;
    countFormula_New(tableid,Rowid,Colid,tableIndex);
}

function changeCurrencyValue(textId,value,tableid){

    var Colid = textId.substring(textId.lastIndexOf("_")+1,textId.length);
    var Rowid = textId.substring(textId.indexOf("_")+1,textId.lastIndexOf("_"));

    document.getElementById(textId).value=value;
    countFormula_New(tableid,Rowid,Colid);
}
/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


