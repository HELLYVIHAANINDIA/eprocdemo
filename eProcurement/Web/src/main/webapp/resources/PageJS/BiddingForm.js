/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
var DataType = ['Small Text (Max. 2000 characters)', 'Long Text(Allows Max. 10000 characters)', 'Number  (with decimal)', ' Number (without decimal)', 'All Numbers', 'Auto number', 'Date', 'Combo Box'];
var ColumnType = ['Item Description', 'Quantity', 'Unit Rate', 'Total Rate', 'UOM', 'Others'];
var ShowHide = ['Yes', 'No'];
var filledby = ['Officer', 'Bidder', 'Auto'];
var checkForNumeric=0;
function disabledPricebid()
{
     if ($('#optFormType option:selected').text() === 'TechnoCommercial(Technical & PriceBid)')
    {
       //alert('hello');
        $('#rdbPriceBiddingN').prop('checked', true);
        $('#dvPriceBid').show();
        $('#dvReqDoc').hide();
    } else if ($('#optFormType option:selected').text() === 'Price bid')
    {
        $('#rdbPriceBiddingY').prop('checked', true);
        $('#dvPriceBid').hide();
        $('#dvReqDoc').hide();
    } else
    {
        $('#rdbPriceBiddingN').prop('checked', true);
        $('#dvPriceBid').hide();
        $('#dvReqDoc').show();
    }
}

function createTable(aid)
{
    var opt = $('#operation').val();
    aid = $("#NoOfTable").val();
    if(opt==='1'|| opt === 1)
    {
        if (aid == 0)
        {
            alert("Zero value is not allowed.");
            return;
        }

        var cntTable = 0;
        $('[id^="dvTable_"]').each(function () {
            cntTable++;
        });

        if (cntTable > aid)
        {
            var j = parseInt(aid) + parseInt(1);
            for (; j <= cntTable; j++)
            {
                $('#dvTable_' + j).remove();
            }
        }

        if (aid == cntTable)
            return;

        cntTable++; // for first time on page load

        //('#FormTr').empty();
        for (var i = cntTable - 1; i < aid; i++)
        {
            var lbl = "Table No::" + (i + 1);

            var tr = $('<div id=dvTable_' + i + '></div>').appendTo('#FormTr');
            var maintd = $('<div></div>').attr({class: 'col-md-12', align: 'center'}).appendTo(tr);
            $('<br/><div class="row text-center"></div>').text(lbl).appendTo(maintd);

            var tbl = $('<div class="row"></div>').appendTo(maintd);

            var heddiv = $('<div class="row"></div>').appendTo(tbl);
            var hedtr = $('<div class="col-md-2"></div>').appendTo(heddiv);
            var hedtd = $('<div class="form_filed"></div>').text("Table Header").appendTo(hedtr);
            var hedcol = $('<div class="col-md-9"></div>').appendTo(heddiv);
            var hedtext = $('<textarea></textarea>').attr({class: 'form-control', col: 20, rows: 3, id: 'textAreaTableHeader' + i}).appendTo(hedcol);

            var div = $('<div class="row"></div>').appendTo(tbl);
            var tr1 = $('<div class="col-md-2"></div>').appendTo(div);
            var td = $('<div class="form_filed"></div>').text("Table Name").appendTo(tr1);
            var tblnm = $('<div class="col-md-3"></div>').appendTo(div);
            var txttblnm = $('<input></input>').attr({type: 'text', class: 'form-control', id: 'TableName' + i, onblur: 'validateTextComponent(this)', validarr: "required@@length:0,1000", tovalid: "true", title: "Table Name"}).appendTo(tblnm);

             var mandiv = $('<div class="row"></div>').appendTo(tbl);
            var mantr = $('<div class="col-md-2"></div>').appendTo(mandiv);
            var mantd = $('<div class="form_filed"></div>').text("Is Table Mandatory For Bidder").appendTo(mantr);
            var mancol = $('<div class="col-md-1" style="margin-top:25px;"></div>').appendTo(mandiv);
            var mancheck = $('<input></input>').attr({type: 'checkbox', id: 'Mandatory' + i}).appendTo(mancol);

            var div2 = $('<div class="row"></div>').appendTo(tbl);
            var tr2 = $('<div class="col-md-2"></div>').appendTo(div2);
            var td2 = $('<div class="form_filed"></div>').text("No Of Rows").appendTo(tr2);
            var tdnumrow = $('<div class="col-md-3"></div>').appendTo(div2);
            var txtnumrow = $('<input></input>').attr({type: 'number',value:'1', min:'1',class: 'form-control', id: 'NoOfRows' + i, onblur: 'validateTextComponent(this)', validarr: "required@@positivelength:0,3", tovalid: "true", title: "No of Rows"}).appendTo(tdnumrow);

            //var div3 = $('<div class="row"></div>').appendTo(tbl);
            var tr3 = $('<div class="col-md-2"></div>').appendTo(div2);
            var td3 = $('<div class="form_filed"></div>').text("No Of Columns").appendTo(tr3);
            var tdnumcol = $('<div class="col-md-2"></div>').appendTo(div2);
            var txtnumcol = $('<input></input>').attr({type: 'number', value:'1', min:'1',class: 'form-control', id: 'txtnumcol' + i, onblur: 'validateTextComponent(this)', validarr: "required@@positivelength:0,2", tovalid: "true", title: "No of Columns"}).appendTo(tdnumcol);
            //txtnumcol.attr('onblur', '');
            var dvbtncol = $('<div class="col-md-1"></div>').appendTo(div2);
            var btnCol = $('<input></input>').attr({type: 'button', class: 'btn btn-submit', onclick: 'fncreateColumnTableForEdit(' + i + ')', id: 'btn', value: 'Add Columns', style: 'margin-top:15px;'}).appendTo(dvbtncol);

            var div4 = $('<div class="row"><br/><div class="col-md-2"></div></div>').appendTo(tbl);
            $('<div></div>').attr({id: 'divColumns' + i}).appendTo(div4);

            var fotdiv = $('<div class="row"></div>').appendTo(tbl);
            var fottr = $('<div class="col-md-2"></div>').appendTo(fotdiv);
            var fottd = $('<div class="form_filed"></div>').text("Table Footer").appendTo(fottr);
            var fotcol = $('<div class="col-md-9"></div>').appendTo(fotdiv);
            var fottext = $('<textarea></textarea>').attr({class: 'form-control', col: 20, rows: 3, id: 'TableFooter' + i}).appendTo(fotcol);

                   }
    } 
    else
    {
        if (aid == 0)
        {
            alert("Zero value is not allowed.");
            return;
        }

        var cntTable = 0;
        $('[id^="dvTable_"]').each(function () {
            cntTable++;
        });

        if (cntTable > aid)
        {
            var j = parseInt(aid) + parseInt(1);
            for (; j <= cntTable; j++)
            {
                $('#dvTable_' + j).remove();
            }
        }

        if (aid == cntTable)
            return;

        cntTable++; // for first time on page load

        //('#FormTr').empty();
        for (var i = cntTable; i <= aid; i++)
        {
            var lbl = "Table No::" + (i);

            var tr = $('<div id=dvTable_' + i + '></div>').appendTo('#FormTr');
            var maintd = $('<div></div>').attr({class: 'col-md-12', align: 'center'}).appendTo(tr);
            $('<br/><div class="row text-center"></div>').text(lbl).appendTo(maintd);

            var tbl = $('<div class="row"></div>').appendTo(maintd);

            var heddiv = $('<div class="row"></div>').appendTo(tbl);
            var hedtr = $('<div class="col-md-2"></div>').appendTo(heddiv);
            var hedtd = $('<div class="form_filed"></div>').text("Table Header").appendTo(hedtr);
            var hedcol = $('<div class="col-md-9"></div>').appendTo(heddiv);
            var hedtext = $('<textarea></textarea>').attr({class: 'form-control', col: 20, rows: 3, id: 'textAreaTableHeader' + i}).appendTo(hedcol);

            var div = $('<div class="row"></div>').appendTo(tbl);
            var tr1 = $('<div class="col-md-2"></div>').appendTo(div);
            var td = $('<div class="form_filed"></div>').text("Table Name *").appendTo(tr1);
            var tblnm = $('<div class="col-md-3"></div>').appendTo(div);
            var txttblnm = $('<input></input>').attr({type: 'text', class: 'form-control', id: 'TableName' + i, onblur: 'validateTextComponent(this)', validarr: "required@@length:0,1000", tovalid: "true", title: "Table Name"}).appendTo(tblnm);
            
            var mandiv = $('<div class="row"></div>').appendTo(tbl);
            var mantr = $('<div class="col-md-2"></div>').appendTo(mandiv);
            var mantd = $('<div class="form_filed"></div>').text("Is Table Mandatory For Bidder").appendTo(mantr);
            var mancol = $('<div class="col-md-1" style="margin-top:25px;"></div>').appendTo(mandiv);
            var mancheck = $('<input></input>').attr({type: 'checkbox', id: 'Mandatory' + i}).appendTo(mancol);

            var div2 = $('<div class="row"></div>').appendTo(tbl);
            var tr2 = $('<div class="col-md-2"></div>').appendTo(div2);
            var td2 = $('<div class="form_filed"></div>').text("No Of Rows").appendTo(tr2);
            var tdnumrow = $('<div class="col-md-3"></div>').appendTo(div2);
            var txtnumrow = $('<input></input>').attr({type: 'number', value:'1', min:'1',class: 'form-control', id: 'NoOfRows' + i, onblur: 'validateTextComponent(this)', validarr: "required@@positivelength:0,3", tovalid: "true", title: "No of Rows"}).appendTo(tdnumrow);

            //var div3 = $('<div class="row"></div>').appendTo(tbl);
            var tr3 = $('<div class="col-md-2"></div>').appendTo(div2);
            var td3 = $('<div class="form_filed"></div>').text("No Of Columns").appendTo(tr3);
            var tdnumcol = $('<div class="col-md-2"></div>').appendTo(div2);
            var txtnumcol = $('<input></input>').attr({type: 'number', value:'1', min:'1',class: 'form-control', id: 'txtnumcol' + i, onblur: 'validateTextComponent(this)', validarr: "required@@positivelength:0,2", tovalid: "true", title: "No of Columns"}).appendTo(tdnumcol);
            //txtnumcol.attr('onblur', '');
            var dvbtncol = $('<div class="col-md-1"></div>').appendTo(div2);
            var btnCol = $('<input></input>').attr({type: 'button', class: 'btn btn-submit', onclick: 'fncreateColumnTable(' + i + ')', id: 'btn', value: 'Add Columns', style: 'margin-top:15px;'}).appendTo(dvbtncol);

            var div4 = $('<div class="row"><br/><div class="col-md-2"></div></div>').appendTo(tbl);
            $('<div></div>').attr({id: 'divColumns' + i}).appendTo(div4);

            var fotdiv = $('<div class="row"></div>').appendTo(tbl);
            var fottr = $('<div class="col-md-2"></div>').appendTo(fotdiv);
            var fottd = $('<div class="form_filed"></div>').text("Table Footer").appendTo(fottr);
            var fotcol = $('<div class="col-md-9"></div>').appendTo(fotdiv);
            var fottext = $('<textarea></textarea>').attr({class: 'form-control', col: 20, rows: 3, id: 'TableFooter' + i}).appendTo(fotcol);

      }
    }
}
function fncreateColumnTable(i)
{
    var columns = $('#txtnumcol' + i).val();
    //$('#divColumns_header').remove();
    //debugger;
    
    var coltbl = "";

    var cntColumn = 0;

    $('[id^="dvColumn_' + i + '"]').each(function () {
        cntColumn++;
    });

    if (cntColumn == 0) {
        coltbl = $('<div class="col-md-12"></div>').appendTo('#divColumns' + i);

        var colmaindiv = $('<div class="row" id="divColumns_header"></div>').appendTo(coltbl);

        var coltr1 = $('<div class="col-md-1"></div>').appendTo(colmaindiv);
        var coltd1 = $('<div class=""></div>').text("Column No").appendTo(coltr1);

        var coltr2 = $('<div class="col-md-2"></div>').appendTo(colmaindiv);
        var coltd2 = $('<div class=""></div>').text("Column Header").appendTo(coltr2);

        var coltr3 = $('<div class="col-md-2"></div>').appendTo(colmaindiv);
        var coltd3 = $('<div class=""></div>').text("Filled By").appendTo(coltr3);

        var coltr4 = $('<div class="col-md-1"></div>').appendTo(colmaindiv);
        var coltd4 = $('<div class=""></div>').text("Show").appendTo(coltr4);

        var coltr5 = $('<div class="col-md-2"></div>').appendTo(colmaindiv);
        var coltd5 = $('<div class=""></div>').text("Data Type").appendTo(coltr5);

        var coltr6 = $('<div class="col-md-2"></div>').appendTo(colmaindiv);
        var coltd6 = $('<div class=""></div>').text("Column Type").appendTo(coltr6);

        var coltr8 = $('<div class="col-md-1" id=currency_'+i+'></div>').appendTo(colmaindiv);
        var coltd8 = $('<div class=""></div>').text("Is Currency Convert").appendTo(coltr8);
       $('#currency_'+i).hide();
        var coltr7 = $('<div class="col-md-1"></div>').appendTo(colmaindiv);
        var coltd7 = $('<div class=""></div>').text("Remove").appendTo(coltr7);
       

    }

    if (cntColumn > columns)
    {
        var j = parseInt(columns) + parseInt(1);
        for (; j <= cntColumn; j++)
        {
            $('#dvColumn_' + i + '_' + j).remove();
        }
    }
    cntColumn++;
    for (var j = cntColumn; j <= columns; j++)
    {
        var colmaindiv = "";
        if (coltbl == "") {
            colmaindiv = $('<div class="row" id=dvColumn_' + i + '_' + j + '></div>');
            $('#divColumns' + i).find(".col-md-12").append(colmaindiv);
        } else
        {
            //$('</div>').appendTo('#divColumns' + i);
            colmaindiv = $('<div class="row" id=dvColumn_' + i + '_' + j + '></div>').appendTo(coltbl);
        }

        var coltd = $('<div class="col-md-1"></div>').appendTo(colmaindiv);
        var txtcol = $('<input></input>').attr({type: 'text',  min:'1',class: 'form-control', placeholder: 'Column No', id: 'ComumnName' + i + '_' + j, onblur: 'validateTextComponent(this)', validarr: "required@@integeronly", tovalid: "true", title: "Column No"}).appendTo(coltd);

        var coltd = $('<div class="col-md-2"></div>').appendTo(colmaindiv);
        var txtcol = $('<textarea></textarea>').attr({col: 5, rows: 3, class: 'form-control', id: 'ColumnHeader' + i + '_' + j, onblur: 'validateTextComponent(this)', validarr: "required@@length:0,50", tovalid: "true", title: "Column Header"}).appendTo(coltd);


        var coltd = $('<div class="col-md-2"></div>').appendTo(colmaindiv);
        var selcol = $('<select></select>').attr({class: 'form-control', id: 'FilledBy' + i + '_' + j, onblur: "validateCombo(this);",isrequired:'true', title: "Filled By"}).appendTo(coltd);
        selcol.attr('onchange','fnCheckForNumericForAuto(this.value,' + i + ',' + j + ')');
        $('<option/>').attr('value', '-1').text("Please Select").appendTo(selcol);
        //  var filledby=['Officer','Bidder','Auto'];
        for (var k = 1; k <= filledby.length; k++)
        {
            $('<option/>').attr('value', k).text(filledby[k - 1]).appendTo(selcol);
        }

        var coltd = $('<div class="col-md-1 form_bx"></div>').appendTo(colmaindiv);
        var txtcol = $('<input></input>').attr({type: 'checkbox', checked: 'true', id: 'ShowHide' + i + '_' + j}).appendTo(coltd);
        //var DataType=['Small Text (Max. 300 characters)','Long Text','+ No. with (.)','+ No. without (.)','All Numbers','Auto number','Date','Combo Box','List box','Master Data Sheet'];

        var coltd = $('<div class="col-md-2"></div>').appendTo(colmaindiv);
        var selcol = $('<select></select>').attr({class: 'form-control', id: 'DataType' + i + '_' + j, onblur: "validateCombo(this);",isrequired:'true', title: "Data Type"}).appendTo(coltd);
        selcol.attr('onchange', 'fncheckForNumeric(this.value,' + i + ',' + j + ')');
        $('<option/>').attr('value', '-1').text("Please Select").appendTo(selcol);
        for (var k = 1; k <= DataType.length; k++)
        {
            if(k==6)
                 $('<option style="display:none"/>').attr('value', k).text(DataType[k - 1]).appendTo(selcol);
             else
                $('<option/>').attr('value', k).text(DataType[k - 1]).appendTo(selcol);
        }

        var coltd = $('<div class="col-md-2"></div>').appendTo(colmaindiv);
        var selcol = $('<select></select>').attr({class: 'form-control', id: 'ColumnType' + i + '_' + j, onblur: "validateCombo(this);",isrequired:'true', title: "Column Type"}).appendTo(coltd);
        selcol.attr('onchange', 'fncheckForNumericForQty(this.value,' + i + ',' + j + ')');
        $('<option/>').attr('value', '-1').text("Please Select").appendTo(selcol);
        //var ColumnType=['Item Description','Quantity','Unit Rate','Total Rate','Category','Others'];
        for (var k = 1; k <= ColumnType.length; k++)
        {
            $('<option/>').attr('value', k).text(ColumnType[k - 1]).appendTo(selcol);
        }
        var coltd = $('<div class="col-md-1" style="padding-top:25px;"></div>').attr({id: 'divIsCurrency_' + i + '_' + j}).appendTo(colmaindiv);
       var txtcol = $('<input></input>').attr({type: 'checkbox', id: 'iscurrency_' + i + '_' + j}).appendTo(coltd);
        $('#divIsCurrency_' + i + '_' + j).hide();
        $('#iscurrency_' + i + '_' + j).hide();
        var coltd = $('<div class="col-md-1" style="padding-top:25px;"></div>').appendTo(colmaindiv);
        var lnkdt = $('<a><span class="glyphicon glyphicon-trash"></span></a>').attr({divid: 'dvColumn_' + i + '_' + j, onclick: 'if(confirm("Are Youn Sure You Want To Delete it?")){removethisrow(this,'+i+');}else{return false;}'}).appendTo(coltd);
          var txtcol = $('<input></input>').attr({type: 'hidden', id:'colId'+ i  + '_'+ j,isPriceSummary:0,isGTColumn:0}).appendTo(coltd);

    }
}

function fncreateColumnTableForEdit(i)
{
    var columns = $('#txtnumcol' + i).val();
    //$('#divColumns_header').remove();
//debugger;
    var coltbl = "";

    var cntColumn = 0;

    $('[id^="dvColumn_' + i + '"]').each(function () {
        cntColumn++;
    });
    if (cntColumn == 0) {
        coltbl = $('<div class="col-md-12"></div>').appendTo('#divColumns' + i);

        var colmaindiv = $('<div class="row" id="divColumns_header"></div>').appendTo(coltbl);

        var coltr1 = $('<div class="col-md-1"></div>').appendTo(colmaindiv);
        var coltd1 = $('<div class=""></div>').text("Column No").appendTo(coltr1);

        var coltr2 = $('<div class="col-md-2"></div>').appendTo(colmaindiv);
        var coltd2 = $('<div class=""></div>').text("Column Header").appendTo(coltr2);

        var coltr3 = $('<div class="col-md-2"></div>').appendTo(colmaindiv);
        var coltd3 = $('<div class=""></div>').text("Filled By").appendTo(coltr3);

        var coltr4 = $('<div class="col-md-1"></div>').appendTo(colmaindiv);
        var coltd4 = $('<div class=""></div>').text("Show").appendTo(coltr4);

        var coltr5 = $('<div class="col-md-2"></div>').appendTo(colmaindiv);
        var coltd5 = $('<div class=""></div>').text("Data Type").appendTo(coltr5);

        var coltr6 = $('<div class="col-md-2"></div>').appendTo(colmaindiv);
        var coltd6 = $('<div class=""></div>').text("Column Type").appendTo(coltr6);
        
          var coltr8 = $('<div class="col-md-1" id=currency_'+i+'></div>').appendTo(colmaindiv);
        var coltd8 = $('<div class=""></div>').text("Is Currency Convert").appendTo(coltr8);
       $('#currency_'+i).hide();
        var coltr7 = $('<div class="col-md-1"></div>').appendTo(colmaindiv);
        var coltd7 = $('<div class=""></div>').text("Remove").appendTo(coltr7);

    }

    if (cntColumn > columns)
    {
        var j = parseInt(columns) + parseInt(1);
        for (; j <= cntColumn; j++)
        {
            $('#dvColumn_' + i + '_' + j).remove();
        }
    }
    cntColumn++;
    for (var j = cntColumn - 1; j < columns; j++)
    {
        var colmaindiv = "";
        if (coltbl == "") {
            colmaindiv = $('<div class="row" id=dvColumn_' + i + '_' + j + '></div>').appendTo('#divColumns' + i);
            $('#divColumns' + i).find(".col-md-12").append(colmaindiv);
        } else
        {
            colmaindiv = $('<div class="row" id=dvColumn_' + i + '_' + j + '></div>').appendTo(coltbl);
        }

        var coltd = $('<div class="col-md-1"></div>').appendTo(colmaindiv);
        var txtcol = $('<input></input>').attr({type: 'text',  min:'1', class: 'form-control', placeholder: 'Column No', id: 'ComumnName' + i + '_' + j, onblur: 'validateTextComponent(this)', validarr: "required@@integeronly", tovalid: "true", title: "Column No"}).appendTo(coltd);

        var coltd = $('<div class="col-md-2"></div>').appendTo(colmaindiv);
        var txtcol = $('<textarea></textarea>').attr({col: 5, rows: 3, class: 'form-control', id: 'ColumnHeader' + i + '_' + j, onblur: 'validateTextComponent(this)', validarr: "required@@length:0,50", tovalid: "true", title: "Column Hearder"}).appendTo(coltd);

        var coltd = $('<div class="col-md-2"></div>').appendTo(colmaindiv);
        var selcol = $('<select></select>').attr({class: 'form-control', id: 'FilledBy' + i + '_' + j, onblur: "validateCombo(this);",isrequired:'true', title: "Filled By"}).appendTo(coltd);
        selcol.attr('onchange','fnCheckForNumericForAuto(this.value,' + i + ',' + j + ')');
        $('<option/>').attr('value', '-1').text("Please Select").appendTo(selcol);
        //  var filledby=['Officer','Bidder','Auto'];
        for (var k = 1; k <= filledby.length; k++)
        {
            $('<option/>').attr('value', k).text(filledby[k - 1]).appendTo(selcol);
        }

        var coltd = $('<div class="col-md-1 form_bx"></div>').appendTo(colmaindiv);
        var txtcol = $('<input></input>').attr({type: 'checkbox', checked: 'true', id: 'ShowHide' + i + '_' + j}).appendTo(coltd);
        //var DataType=['Small Text (Max. 300 characters)','Long Text','+ No. with (.)','+ No. without (.)','All Numbers','Auto number','Date','Combo Box','List box','Master Data Sheet'];

        var coltd = $('<div class="col-md-2"></div>').appendTo(colmaindiv);
        var selcol = $('<select></select>').attr({class: 'form-control', id: 'DataType' + i + '_' + j, onblur: "validateCombo(this);",isrequired:'true', title: "Data Type"}).appendTo(coltd);
        selcol.attr('onchange', 'fncheckForNumeric(this.value,' + i + ',' + j + ')');
        $('<option/>').attr('value', '-1').text("Please Select").appendTo(selcol);
        for (var k = 1; k <= DataType.length; k++)
        {
           if(k==6)
                 $('<option style="display:none"/>').attr('value', k).text(DataType[k - 1]).appendTo(selcol);
             else
                 $('<option />').attr('value', k).text(DataType[k - 1]).appendTo(selcol);

            
            
        }

        var coltd = $('<div class="col-md-2"></div>').appendTo(colmaindiv);
        var selcol = $('<select></select>').attr({class: 'form-control', id: 'ColumnType' + i + '_' + j, onblur: "validateCombo(this);",isrequired:'true', title: "Column Type"}).appendTo(coltd);
       selcol.attr('onchange', 'fncheckForNumericForQty(this.value,' + i + ',' + j + ')');
        $('<option/>').attr('value', '-1').text("Please Select").appendTo(selcol);
        
        //var ColumnType=['Item Description','Quantity','Unit Rate','Total Rate','Category','Others'];
        for (var k = 1; k <= ColumnType.length; k++)
        {
            $('<option/>').attr('value', k).text(ColumnType[k - 1]).appendTo(selcol);
        }
        
        var coltd = $('<div class="col-md-1" style="padding-top:25px;"></div>').attr({id: 'divIsCurrency_' + i + '_' + j}).appendTo(colmaindiv);
       var txtcol = $('<input></input>').attr({type: 'checkbox', id: 'iscurrency_' + i + '_' + j}).appendTo(coltd);
       if(checkForNumeric==0)
       {
        $('#divIsCurrency_' + i + '_' + j).hide();
    }
            $('#iscurrency_' + i + '_' + j).hide();
        var coltd = $('<div class="col-md-1" style="padding-top:25px;"></div>').appendTo(colmaindiv);
        var lnkdt = $('<a><span class="glyphicon glyphicon-trash"></span></a>').attr({divid: 'dvColumn_' + i + '_' + j, onclick: 'if(confirm("Are Youn Sure You Want To Delete it?")){removethisrow(this,'+i+');}else{return false;}'}).appendTo(coltd);
          var txtcol = $('<input></input>').attr({type: 'hidden', id:'colId'+ i  + '_'+ j,isPriceSummary:0,isGTColumn:0}).appendTo(coltd);

    }
}

function fnCheckForNumericForAuto(selected,i,j)
{
    fncheckForNumeric($('#DataType'+i+'_'+j).val(), i, j);
}
function fncheckForNumericForQty(selected,i,j)
{
    fncheckForNumeric($('#DataType'+i+'_'+j).val(), i, j);
}
function fncheckForNumeric(selected, i, j)
{
    var checkForNumeric1=0;
    $('[id^="iscurrency_' + i + '"]').each(function (obj) {
    // alert( $(this).css('display'));
                if($(this).css('display') === 'none' || $(this).css('display') === undefined )
                {
                    //  checkForNumeric--;
                }
                else 
                {
                   checkForNumeric1++;
                }
             });
             
                if ($('#biidingType').val() === 2 || $('#biidingType').val()=== '2')
                {
                    var check = ['3', '4', '5'];
                    var cntColumn = 0;
                    $('[id^="currency"]').each(function () {
                        cntColumn++;
                    });
                if (jQuery.inArray(selected, check) !== -1 && (parseInt($('#FilledBy'+i+'_'+j).val())===2||parseInt($('#FilledBy'+i+'_'+j).val())===1) && (parseInt($('#ColumnType'+i+'_'+j).val())!==2))
                {
                    if (cntColumn == 0)
                    {
                        cntColumn++;
                    }
                    checkForNumeric1++;
                    $('#currency_'+i).show();
                    var rowcount = 0;
                    $('[id^="iscurrency_' + i + '_' + j + '"]').each(function () {
                        rowcount++;
                    });
                    if (rowcount == 0)
                    {
                        $('#iscurrency_' + i + '_' + j).show();
                    }
                    $('[id^="divIsCurrency_' + i + '"]').show();
                    $('#iscurrency_' + i + '_' + j).show();
                    $('#iscurrency_'+i+'_'+j).css({'display' : ''}) ;
                }
        if (jQuery.inArray(selected, check) === -1 || (parseInt($('#FilledBy'+i+'_'+j).val())===3) || (parseInt($('#ColumnType'+i+'_'+j).val())===2))
        {
            var rowcount = 0;
            $('[id^="iscurrency_' + i + '_' + j + '"]').each(function () {
                rowcount++;
            });
            if (rowcount === 1)
            {
                $('#iscurrency_' + i + '_' + j).prop('checked',false);
                $('#iscurrency_' + i + '_' + j).hide();
                $('#iscurrency_'+i+'_'+j).css({'display' : 'none'}) ;
               
            }
            var raw = 0;
             checkForNumeric1--;
          $('[id^="iscurrency_' + i + '"]').each(function (obj) {
                    // alert($('#iscurrency_'+i+'_'+obj).css('display'));
               if($(this).css('display')=== 'none' || $(this).css('display') === undefined )
               {
          
                 //  checkForNumeric--;
               }
               else
               {
                   checkForNumeric1++;
               }
            });
            if (checkForNumeric1 <= 0)
            {
                $('[id^="divIsCurrency_' + i + '"]').hide();
                $('#currency_'+i).hide();
            }
        }
    }
}

function removeData(columnId,chkValue,filledBy,cmb)
{
    //alert("in removeData fun: "+chkValue);
     var flag = true;
     var path = window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2));
     var choice = confirm("System will remove column data if you change data type/Filled by. ");
     if (choice)
     {
       $.ajax({
          url:path+"/eBid/Bid/removeCellValue/"+columnId,
          async:false,
          success: function(result){
                //alert("result= "+result);
          }
        });
     }
     else
     {
        $(cmb).val(chkValue);
     }
                    
}
function createTableForEdit()
{
    var text = $('#structureInfo').text();
    var formdata = JSON.parse(text);
    var check = [3, 4, 5];
    aid = formdata['form'].noOfTables;

    $('#FormName').val(formdata['form'].formName);
    $('#FromHeader').val(formdata['form'].formHeader);
    $('#FormFooter').val(formdata['form'].formFooter);

    $('#RequiredSupportingDoc option[value=' + formdata['form'].isDocumentReq + ']').prop('selected', true);

    $('#IsMandatory option[value=' + formdata['form'].isMandatory + ']').prop('selected', true);

    if (formdata['form'].isPriceBid === 1)
    {
        $('#rdbPriceBiddingY').prop('checked', 'checked');
        $('#dvPriceBid').hide();
    } 
    else
    {
        $('#rdbPriceBiddingN').prop('checked', 'checked');
        $('#dvPriceBid').hide();
    }

    $('#NoOfTable').val(formdata['form'].noOfTables);

    if (aid == 0)
    {
        alert("Zero value is not allowed.");
        return;
    }
    if(editIsAuction===1||editIsAuction==='1')
    {
        $('#divtbl').hide();
    }
    //('#FormTr').empty();
    for (var i = 0; i < aid; i++)
    {
        var lbl = "Table No::" + (i + 1);
      
        var tr = $('<div id=dvTable_' + i + '></div>').appendTo('#FormTr');
        var maintd = $('<div></div>').attr({class: 'col-md-12', align: 'center'}).appendTo(tr);
        if(editIsAuction===0||editIsAuction===''||editIsAuction==='0')
        {
            
          $('<br/><div class="row text-center"></div>').text(lbl).appendTo(maintd);
         var path = window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2));
           
        var lnkdt = $('<a></a>').attr({href: path + "/eBid/Bid/deleteTableFromBiddingForm/" + formdata['tender'] + "/" + formdata['form'].formId + "/" + formdata.table[i].tableId , onclick: 'return confirm("Are Youn Sure You Want To Delete it?")'}).appendTo(maintd);
            var spdt = $('<span class="glyphicon glyphicon-trash"></span>').appendTo(lnkdt);
        }
        var tbl = $('<div class="row"></div>').appendTo(maintd);

        var heddiv = $('<div class="row"></div>').appendTo(tbl);
        var hedtr = $('<div class="col-md-2"></div>').appendTo(heddiv);
        var hedtd = $('<div class="form_filed"></div>').text("Table Header").appendTo(hedtr);
        var hedcol = $('<div class="col-md-9"></div>').appendTo(heddiv);
        var hedtext = $('<textarea>' + formdata.table[i].tableHeader + '</textarea>').attr({class: 'form-control', col: 20, rows: 3, id: 'textAreaTableHeader' + i}).appendTo(hedcol);
        if(editIsAuction===1||editIsAuction==='1')
        {
            $(heddiv).hide();
        }
        var div = $('<div class="row"></div>').appendTo(tbl);
        var tr1 = $('<div class="col-md-2"></div>').appendTo(div);
        var td = $('<div class="form_filed"></div>').text("Table Name *").appendTo(tr1);
        var tblnm = $('<div class="col-md-3"></div>').appendTo(div);
        var txttblnm = $('<input></input>').attr({value: formdata.table[i].tableName, type: 'text', class: 'form-control', id: 'TableName' + i, onblur: 'validateTextComponent(this)', validarr: "required@@length:0,1000", tovalid: "true", title: "Table Name"}).appendTo(tblnm);
        ///////////////////
        if(editIsAuction===1||editIsAuction==='1')
        {
            $(div).hide();
        }
        var txttTableId = $('<input></input>').attr({value: formdata.table[i].tableId, type: 'hidden', class: 'form-control', id: 'TableId' + i}).appendTo(tblnm);
        /////////////////////////
         var isFormMandatory = false;
        if (formdata.table[i].isMandatory == 1)
            isFormMandatory = true;

         var mandiv = $('<div class="row"></div>').appendTo(tbl);
        var mantr = $('<div class="col-md-2"></div>').appendTo(mandiv);
        var mantd = $('<div class="form_filed"></div>').text("Is Table Mandatory For Bidder").appendTo(mantr);
        var mancol = $('<div class="col-md-1" style="margin-top:25px;"></div>').appendTo(mandiv);
        var mancheck = $('<input></input>').attr({type: 'checkbox', id: 'Mandatory' + i, checked: isFormMandatory}).appendTo(mancol);
        ///////////////////
         if(editIsAuction===1||editIsAuction==='1')
        {
            $(mandiv).hide();
        }
        var div2 = $('<div class="row"></div>').appendTo(tbl);
        var tr2 = $('<div class="col-md-2"></div>').appendTo(div2);
        var td2 = $('<div class="form_filed"></div>').text("No Of Rows").appendTo(tr2);
        var tdnumrow = $('<div class="col-md-3"></div>').appendTo(div2);
        var txtnumrow = $('<input></input>').attr({value: formdata.table[i].noOfRows, type: 'number', min:'1', class: 'form-control', id: 'NoOfRows' + i, onblur: 'validateTextComponent(this)', validarr: "required@@positivelength:0,3", tovalid: "true", title: "No Of Rows"}).appendTo(tdnumrow);

        //var div3 = $('<div class="row"></div>').appendTo(tbl);
        var tr3 = $('<div class="col-md-2"></div>').appendTo(div2);
        var td3 = $('<div class="form_filed"></div>').text("No Of Columns").appendTo(tr3);
        var tdnumcol = $('<div class="col-md-2"></div>').appendTo(div2);
        var txtnumcol = $('<input></input>').attr({value: formdata.table[i].noOfCols, type: 'number', min:'1', class: 'form-control', id: 'txtnumcol' + i, onblur: 'validateTextComponent(this)', validarr: "required@@positivelength:0,2", tovalid: "true", title: "No Of Column"}).appendTo(tdnumcol);
        //txtnumcol.attr('onblur', '');
        var dvbtncol = $('<div class="col-md-1"></div>').appendTo(div2);
        var btnCol = $('<input></input>').attr({type: 'button', class: 'btn btn-submit', onclick: 'fncreateColumnTableForEdit(' + i + ')', id: 'btn', value: 'Add Columns', style: 'margin-top:15px;'}).appendTo(dvbtncol);

        ////////////////////////////////////////////////////////
        var columns = formdata.table[i].noOfCols;
        //$('#divColumns_header').remove();
        var div4 = $('<div class="row"><br/><div class="col-md-2"></div></div>').appendTo(tbl);
        $('<div></div>').attr({id: 'divColumns' + i}).appendTo(div4);
        var coltbl = "";

        var cntColumn = 0;
        if(columns>0)
        {
        coltbl = $('<div class="col-md-12"></div>').appendTo('#divColumns' + i);

        var colmaindiv = $('<div class="row" id="divColumns_header"></div>').appendTo(coltbl);

        var coltr1 = $('<div class="col-md-1"></div>').appendTo(colmaindiv);
        var coltd1 = $('<div class=""></div>').text("Column No").appendTo(coltr1);

        var coltr2 = $('<div class="col-md-2"></div>').appendTo(colmaindiv);
        var coltd2 = $('<div class=""></div>').text("Column Header").appendTo(coltr2);

        var coltr3 = $('<div class="col-md-2"></div>').appendTo(colmaindiv);
        var coltd3 = $('<div class=""></div>').text("Filled By").appendTo(coltr3);

        var coltr4 = $('<div class="col-md-1"></div>').appendTo(colmaindiv);
        var coltd4 = $('<div class=""></div>').text("Show").appendTo(coltr4);

        var coltr5 = $('<div class="col-md-2"></div>').appendTo(colmaindiv);
        var coltd5 = $('<div class=""></div>').text("Data Type").appendTo(coltr5);

        var coltr6 = $('<div class="col-md-2"></div>').appendTo(colmaindiv);
        var coltd6 = $('<div class=""></div>').text("Column Type").appendTo(coltr6);
        
        var coltr8 = $('<div class="col-md-1" id=currency_'+i+'></div>').appendTo(colmaindiv);
        var coltd8 = $('<div class=""></div>').text("Is Currency Convert").appendTo(coltr8);
        $('#currency_'+i).hide();

        var coltr7 = $('<div class="col-md-1"></div>').appendTo(colmaindiv);
        var coltd7 = $('<div class=""></div>').text("Remove").appendTo(coltr7);
        }
         var path = window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2));
           
        for (var j = 0; j < columns; j++)
        {
            var colmaindiv = "";
            if (coltbl == "") {
                colmaindiv = $('<div class="row" id=dvColumn_' + i + '_' + j + '></div>');
                $('#divColumns' + i).find(".col-md-10").append(colmaindiv);
            } else
            {
                colmaindiv = $('<div class="row" id=dvColumn_' + i + '_' + j + '></div>').appendTo(coltbl);
            }

            var coltd = $('<div class="col-md-1"></div>').appendTo(colmaindiv);
            var txtcol = $('<input></input>').attr({value: formdata.column[formdata.table[i].tableId][j].columnNo, type: 'text',  min:'1',class: 'form-control', placeholder: 'Column No', id: 'ComumnName' + i + '_' + j, onblur: 'validateTextComponent(this)', validarr: "required@@integeronly", tovalid: "true", title: "Column No"}).appendTo(coltd);

            var coltd = $('<div class="col-md-2"></div>').appendTo(colmaindiv);
            var txtcol = $('<textarea>' + formdata.column[formdata.table[i].tableId][j].columnHeader + '</textarea>').attr({col: 5, rows: 3, class: 'form-control', id: 'ColumnHeader' + i + '_' + j, onblur: 'validateTextComponent(this)', validarr: "required@@length:0,300", tovalid: "true", title: "Column Header"}).appendTo(coltd);

            var coltd = $('<div class="col-md-2"></div>').appendTo(colmaindiv);
            var selcol = $('<select></select>').attr({class: 'form-control', id: 'FilledBy' + i + '_' + j, onchange:'removeData('+formdata.column[formdata.table[i].tableId][j].columnId+','+formdata.column[formdata.table[i].tableId][j].filledBy+','+formdata.column[formdata.table[i].tableId][j].filledBy+',this),fnCheckForNumericForAuto(this.value,' + i + ',' + j + ')', onblur: "validateCombo(this);",isrequired:'true', title: "Filled By"}).appendTo(coltd);
            
            $('<option/>').attr('value', '-1').text("Please Select").appendTo(selcol);

            //var filledby=['Officer','Bidder','Auto'];
            for (var k = 1; k <= filledby.length; k++)
            {
                $('<option/>').attr('value', k).text(filledby[k - 1]).appendTo(selcol);
            }
            $('#FilledBy' + i + '_' + j + ' option[value=' + formdata.column[formdata.table[i].tableId][j].filledBy + ']').prop('selected', true);

            var isShown = false;
            if (formdata.column[formdata.table[i].tableId][j].isShown == 1)
                isShown = true;

            var coltd = $('<div class="col-md-1 form_bx"></div>').appendTo(colmaindiv);
            var txtcol = $('<input></input>').attr({type: 'checkbox', checked: isShown, id: 'ShowHide' + i + '_' + j}).appendTo(coltd);
            //var DataType=['Small Text (Max. 300 characters)','Long Text','+ No. with (.)','+ No. without (.)','All Numbers','Auto number','Date','Combo Box','List box','Master Data Sheet'];

            var coltd = $('<div class="col-md-2"></div>').appendTo(colmaindiv);
            var selcol = $('<select></select>').attr({class: 'form-control', id: 'DataType' + i + '_' + j, onblur: "validateCombo(this);",isrequired:'true', title: "Data Type"}).appendTo(coltd);
           
           // var fwdPath=path+'/eBid/Bid/deleteColumnFromBiddingForm/'  + formdata.column[formdata.table[i].tableId][j].columnId;
           
            selcol.attr('onchange', 'removeData('+formdata.column[formdata.table[i].tableId][j].columnId+','+formdata.column[formdata.table[i].tableId][j].dataType+','+formdata.column[formdata.table[i].tableId][j].dataType+',this),fncheckForNumeric(this.value,' + i + ',' + j + ')');
            $('<option/>').attr('value', '-1').text("Please Select").appendTo(selcol);
            for (var k = 1; k <= DataType.length; k++)
            {
                 if(k==6)
                     $('<option style="display:none"/>').attr('value', k).text(DataType[k - 1]).appendTo(selcol);
                 
             else
                 $('<option/>').attr('value', k).text(DataType[k - 1]).appendTo(selcol);

                
                
            }
            $('#DataType' + i + '_' + j + ' option[value=' + formdata.column[formdata.table[i].tableId][j].dataType + ']').prop('selected', true);

            var coltd = $('<div class="col-md-2"></div>').appendTo(colmaindiv);
            var selcol = $('<select></select>').attr({class: 'form-control', id: 'ColumnType' + i + '_' + j, onblur: "validateCombo(this);",isrequired:'true', title: "Column Type"}).appendTo(coltd);
            $('<option/>').attr('value', '-1').text("Please Select").appendTo(selcol);
             selcol.attr('onchange', 'fncheckForNumericForQty(this.value,' + i + ',' + j + ')');
            //var ColumnType=['Item Description','Quantity','Unit Rate','Total Rate','Category','Others'];
            for (var k = 1; k <= ColumnType.length; k++)
            {
                $('<option/>').attr('value', k).text(ColumnType[k - 1]).appendTo(selcol);
            }
            $('#ColumnType' + i + '_' + j + ' option[value=' + formdata.column[formdata.table[i].tableId][j].sortOrder + ']').prop('selected', true);
            
            var coltd = $('<div class="col-md-1" style="padding-top:25px;"></div>').attr({id:'divIsCurrency_'+i+"_"+j}).appendTo(colmaindiv);
            var txtcol = $('<input></input>').attr({type: 'checkbox', id: 'iscurrency_' + i + '_' + j}).appendTo(coltd);
         //   alert($('#biidingType').val());
            if(parseInt($('#biidingType').val())===2)
            {
               
              //  alert('in if'+formdata.column[formdata.table[i].tableId][j].dataType);
                 if(jQuery.inArray(formdata.column[formdata.table[i].tableId][j].dataType, check) !== -1 && ((parseInt(formdata.column[formdata.table[i].tableId][j].filledBy)===2)||(parseInt(formdata.column[formdata.table[i].tableId][j].filledBy)===1)) && (formdata.column[formdata.table[i].tableId][j].sortOrder!==2))
                 {
                  //   alert('in array');
                     $('#currency').show();
                    // $('#divIsCurrency_'+i+"_"+j).show();
                    $('[id^="divIsCurrency_' + i + '"]').show(); 
                    $('#iscurrency_' + i + '_' + j).show();
                     checkForNumeric++;
                     if(formdata.column[formdata.table[i].tableId][j].isCurrConvReq === 1 )
                     {
                        $('#iscurrency_' + i + '_' + j).prop('checked',true);
                     }
                     else
                     {
                         $('#iscurrency_' + i + '_' + j).prop('checked',false);
                     }
                 }
                 else
                 {
                  //   alert(checkForNumeric);
                     if(checkForNumeric===0)
                     {
                        // alert('in else');
                        $('#divIsCurrency_'+i+"_"+j).hide();
                     }
                    //  $('#divIsCurrency_'+i+"_"+j).hide();
                     $('#iscurrency_' + i + '_' + j).hide();
                 }
            }
            else
            {
                $('#divIsCurrency_'+i+"_"+j).hide();
                $('#iscurrency_' + i + '_' + j).hide();
            }
            var coltd = $('<div class="col-md-1" style="padding-top:25px;"></div>').appendTo(colmaindiv);
            var lnkdt = $('<a></a>').attr({href: path + "/eBid/Bid/deleteColumnFromBiddingForm/" + formdata['tender'] + "/" + formdata['form'].formId + "/" + formdata.table[i].tableId + "/" + formdata.column[formdata.table[i].tableId][j].columnId, onclick: 'return confirm("Are Youn Sure You Want To Delete it?")'}).appendTo(coltd);
            var spdt = $('<span class="glyphicon glyphicon-trash"></span>').appendTo(lnkdt);

            //$('#DataType'+ i  + '_'+ j +' option[value='+formdata.column[formdata.table[i].tableId][j].dataType+']').prop('selected', true);
           var txtcol = $('<input></input>').attr({type: 'hidden', value: formdata.column[formdata.table[i].tableId][j].columnId ,id:'colId'+ i  + '_'+ j,isPriceSummary:formdata.column[formdata.table[i].tableId][j].isPriceSummary,isGTColumn:formdata.column[formdata.table[i].tableId][j].isGTColumn}).appendTo(coltd);

        }
        //////////////////////////////////////////////////////
       
        var fotdiv = $('<div class="row"></div>').appendTo(tbl);
        var fottr = $('<div class="col-md-2"></div>').appendTo(fotdiv);
        var fottd = $('<div class="form_filed"></div>').text("Table Footer").appendTo(fottr);
        var fotcol = $('<div class="col-md-9"></div>').appendTo(fotdiv);
        var fottext = $('<textarea>' + formdata.table[i].tableFooter + '</textarea>').attr({class: 'form-control', col: 20, rows: 3, id: 'TableFooter' + i}).appendTo(fotcol);
       
       if(parseInt(editIsAuction)==1)
       {
           $(fotdiv).hide();
           }
    }
}

function validate()
{
     var atLeastOneIsChecked = false;
     $('[id^="Mandatory"]').each(function () {
        if ($(this).is(':checked')) {
            atLeastOneIsChecked = true;
        }
    });
    if(atLeastOneIsChecked == false){
        alert("Please Select atleast one Table as Mandatory.");
        return false;
    }
    if($('#NoOfTable').val() == 0){
        alert("Zero value is not allowed.");
        return false;       
    }
    var opt=$('#operation').val();
    var checkOr=['4'];
    if($('#rdbPriceBiddingY').prop('checked')===true)
    {
        $('#error').empty();
        var error=0;
        var present=[];
        var check=['1','2','3'];
        var checkfor=['1','2'];
        
        var reason=[];
        var table_cnt=$('#NoOfTable').val();
        var error_tab=[];
        var cnt=0;
        if(opt==='1'|| opt === 1)
        {
            for(var i=0;i<table_cnt;i++){
            var column_cnt=$('#txtnumcol'+i).val();
            if(column_cnt<3)
            {
                error_tab[cnt]=i;
                reason[cnt]="Minimum";
                cnt++;
            }
            var arr=[];
            for(var j=0;j<column_cnt;j++)
            {
                arr[j]=$('#ColumnType'+i+'_'+j).val();
            }
            var status=0;
            var check_repeat=[];
            jQuery.grep(arr,function(el){
                if(jQuery.inArray(el,check)!==-1){
                        check_repeat.push(el);
                    }
            });
            check_repeat.some(function(item,index){
                if(check_repeat.indexOf(item)!==index){
                    status++;
                }
            });
            if(status>0)
            {
                error_tab[cnt]=i;
                reason[cnt]="repeat";
                cnt++;
            }
            var notpresent=[];
            jQuery.grep(arr,function(el){
                if(jQuery.inArray(el,check)!==-1){
                    notpresent.push(el);
                }
            });
            present=[];
            jQuery.grep(check,function(el){
                if(jQuery.inArray(el,notpresent)===-1){
                    present.push(el);
                    }
            });
            var pr_cnt=present.length;
            if(pr_cnt>0){
                        if( $('#error').html().length === 0 ){
                            var error_div=$('<div class="alert alert-danger" id="err"></div>').appendTo('#error');
                            var strong=$('<strong></strong>').text('Error!').appendTo(error_div);
                            for(var k=0;k<pr_cnt;k++)
                            {
                                var p=$('<p>It is mandatory to select Column Type as '+ColumnType[present[k]-1]+' in any 1 column in table no '+(i+1)+'</p>').appendTo('#err');
                            }
                            error++;
                        }
                    else{
                            for(var k=0;k<pr_cnt;k++)
                            {
                                //alert('in loop');
                                 var p=$('<p>It is mandatory to select Column Type as '+ColumnType[present[k]-1]+' in any 1 column in table no '+(i+1)+'</p>').appendTo('#err');
                            }
                            error++;
                        }
                    }
                    var arr1=[];
                    for(var j=0;j<column_cnt;j++)
                    {
                        arr1[j]=$('#FilledBy'+i+'_'+j).val();
                    }
                    var notpresent1=[];
                        jQuery.grep(arr1,function(el){
                            if(jQuery.inArray(el,checkfor)!==-1){
                                notpresent1.push(el);
                            }
                        });
                        var present1=[];
                        jQuery.grep(checkfor,function(el){
                        if(jQuery.inArray(el,notpresent1)===-1){
                           present1.push(el);
                        }
                        });
                        var pr_cnt1=present1.length;
                        if(pr_cnt1>0){
                            if( $('#error').html().length === 0 ){
                                var error_div=$('<div class="alert alert-danger" id="err"></div>').appendTo('#error');
                                var strong=$('<strong></strong>').text('Error!').appendTo(error_div);
                                for(var k=0;k<pr_cnt1;k++){
                                    var p=$('<p>It is mandatory to select FilledBy as '+filledby[present1[k]-1]+' in any 1 column in table no '+(i+1)+'</p>').appendTo('#err');
                                }
                                error++;
                            }
                            else{
                                for(var k=0;k<pr_cnt1;k++){
                                    var p=$('<p>It is mandatory to select FilledBy as '+filledby[present1[k]-1]+' in any 1 column in table no '+(i+1)+'</p>').appendTo('#err');
                                }
                                error++;
                            }
                        }
                }//loop for table
        }//if for edit for pricebid form
        else
        {
            for(var i=1;i<=table_cnt;i++){
            var column_cnt=$('#txtnumcol'+i).val();
            if(column_cnt<3)
            {
                error_tab[cnt]=i;
                reason[cnt]="Minimum";
                cnt++;
            }
            var arr=[];
            for(var j=1;j<=column_cnt;j++)
            {
                arr[j-1]=$('#ColumnType'+i+'_'+j).val();
            }
            var status=0;
            var check_repeat=[];
            jQuery.grep(arr,function(el){
            if(jQuery.inArray(el,check)!==-1){
                        check_repeat.push(el);
                    }
            });
            check_repeat.some(function(item,index){
                if(check_repeat.indexOf(item)!==index){
                        status++;
                    }
            });
            if(status>0)
            {
                error_tab[cnt]=i;
                reason[cnt]="repeat";
                cnt++;
            }
            var notpresent=[];
            jQuery.grep(arr,function(el){
                if(jQuery.inArray(el,check)!==-1){
                    notpresent.push(el);
                }
            });
            present=[];
            jQuery.grep(check,function(el){
                if(jQuery.inArray(el,notpresent)===-1){
                    present.push(el);
                }
            });
            var pr_cnt=present.length;
            if(pr_cnt>0){
                        if( $('#error').html().length === 0 ){
                            var error_div=$('<div class="alert alert-danger" id="err"></div>').appendTo('#error');
                            var strong=$('<strong></strong>').text('Error!').appendTo(error_div);
                            for(var k=0;k<pr_cnt;k++)
                            {
                                var p=$('<p>It is mandatory to select Column Type as '+ColumnType[present[k]-1]+' in any 1 column in table no '+i+'</p>').appendTo('#err');
                            }
                            error++;
                        }
                        else{
                            for(var k=0;k<pr_cnt;k++)
                            {
                                //alert('in loop');
                                 var p=$('<p>It is mandatory to select Column Type as '+ColumnType[present[k]-1]+' in any 1 column in table no '+i+'</p>').appendTo('#err');
                            }
                            error++;
                        }
                    }
                 
                        var arr1=[];
                        for(var j=1;j<=column_cnt;j++)
                        {
                           arr1[j-1]=$('#FilledBy'+i+'_'+j).val();
                        }
                        var notpresent1=[];
                        jQuery.grep(arr1,function(el){
                            if(jQuery.inArray(el,checkfor)!==-1){
                                notpresent1.push(el);
                            }
                        });
                        var present1=[];
                        jQuery.grep(checkfor,function(el){
                        if(jQuery.inArray(el,notpresent1)===-1){
                           present1.push(el);
                        }
                        });
                        var pr_cnt1=present1.length;
                        //pr_cnt1 = 0;       
                        if(pr_cnt1>0){
                            if( $('#error').html().length === 0 ){
                                var error_div=$('<div class="alert alert-danger" id="err"></div>').appendTo('#error');
                                var strong=$('<strong></strong>').text('Error!').appendTo(error_div);
                                for(var k=0;k<pr_cnt1;k++){
                                    var p=$('<p>It is mandatory to select FilledBy as '+filledby[present1[k]-1]+' in any 1 column in table no '+i+'</p>').appendTo('#err');
                                }
                                error++;
                            }
                            else{
                                for(var k=0;k<pr_cnt1;k++){
                                    var p=$('<p>It is mandatory to select FilledBy as '+filledby[present1[k]-1]+' in any 1 column in table no '+i+'</p>').appendTo('#err');
                                }
                                error++;
                            }
                        }
                   
               
            
        }//loop for table
        }//at time of create form price bid
        if(cnt>0){
            if( $('#error').html().length === 0 ){
                $('#error').empty();
                var error_div=$('<div class="alert alert-danger" id="err"></div>').appendTo('#error');
                var strong=$('<strong></strong>').text('Error!').appendTo(error_div);   
                for(var k=0;k<cnt;k++){ 
                    if(reason[k]==='Minimum'){
                        if(opt==='1'||opt === 1)
                        {
                            var p=$('<p>Minimum three columns should be present in table no '+(error_tab[k]+1)+' for price bid form</p>').appendTo('#err');
                        }
                        else
                        {
                            var p=$('<p>Minimum three columns should be present in table no '+error_tab[k]+' for price bid form</p>').appendTo('#err');
                        }
                    }
                    else if(reason[k]==='repeat'){
                        if(opt==='1'||opt === 1)
                        {
                        var p=$('<p>Repeat Column Type Present in Table No '+(error_tab[k]+1)+'</p>').appendTo('#err');
                        }
                        else
                        {
                          var p=$('<p>Repeat Column Type Present in Table No '+error_tab[k]+'</p>').appendTo('#err');  
                        }
                    }
                }
            }
            else{
                if(error===0){
                    $('#error').empty();
                    var error_div=$('<div class="alert alert-danger" id="err"></div>').appendTo('#error');
                    var strong=$('<strong></strong>').text('Error!').appendTo(error_div);   
                    }
                    for(var k=0;k<cnt;k++){ 
                        if(reason[k]==='Minimum'){
                            if(opt==='1'||opt === 1)
                        {
                            var p=$('<p>Minimum three columns should be present in table no '+(error_tab[k]+1)+' for price bid form</p>').appendTo('#err');
                        }
                        else
                        {
                            var p=$('<p>Minimum three columns should be present in table no '+error_tab[k]+' for price bid form</p>').appendTo('#err');
                        }
                        }
                        else if(reason[k]==='repeat'){
                        if(opt==='1'||opt === 1)
                        {
                        var p=$('<p>Repeat Column Type Present in Table No '+(error_tab[k]+1)+'</p>').appendTo('#err');
                        }
                        else
                        {
                          var p=$('<p>Repeat Column Type Present in Table No '+error_tab[k]+'</p>').appendTo('#err');  
                        }
                        }
                    }
                }
                return false;
            }
            if((cnt===0)&&(error===0)){
                if(opt===1||opt==='1'){
                    return createJSONForEdit();
                }
                else{
                    return createJSON();
                }
            }
            else{
                return false;
            }
    }//this is for price bid form create and edit
    else
    {
        var table_cnt=$('#NoOfTable').val();
        var error_tab=[];
        var cnt=0;
        var checkfor=['1','2'];
        $('#error').empty();
        var error=0;
        if(opt==='1'|| opt === 1)
        {
            for (var i = 0; i < table_cnt; i++)
            {
                var column_cnt=$('#txtnumcol'+i).val();
                var arr1 = [];
                for (var j = 0; j < column_cnt; j++)
                {
                    arr1[j] = $('#FilledBy' + i + '_' + j).val();
                }
                var notpresent1 = [];
                jQuery.grep(arr1, function (el) {
                    if (jQuery.inArray(el, checkfor) !== -1) {
                        notpresent1.push(el);
                    }
                });
                var present1 = [];
                jQuery.grep(checkfor, function (el) {
                    if (jQuery.inArray(el, notpresent1) === -1) {
                        present1.push(el);
                    }
                });
                var pr_cnt1 = present1.length;
                
                 if (pr_cnt1 > 0) {
                    if ($('#error').html().length === 0) {
                        var error_div = $('<div class="alert alert-danger" id="err"></div>').appendTo('#error');
                        var strong = $('<strong></strong>').text('Error!').appendTo(error_div);
                        for (var k = 0; k < pr_cnt1; k++) {
                            var p = $('<p>It is mandatory to select FilledBy as ' + filledby[present1[k] - 1] + ' in any 1 column in table no ' + (i+1) + '</p>').appendTo('#err');
                        }
                        error++;
                    } else {
                        for (var k = 0; k < pr_cnt1; k++) {
                            
                                var p = $('<p>It is mandatory to select FilledBy as ' + filledby[present1[k] - 1] + ' in any 1 column in table no ' + (i+1) + '</p>').appendTo('#err');
                           
                        }
                        error++;
                    }
                }
            }
        }//for edit without pricebid
        else
        {
           // debugger;
            for (var i = 1; i <= table_cnt; i++)
            {
                var column_cnt=$('#txtnumcol'+i).val();
                var arr1 = [];
                for (var j = 1; j <= column_cnt; j++)
                {
                    arr1[j - 1] = $('#FilledBy' + i + '_' + j).val();
                }
                var notpresent1 = [];
               // alert(checkfor);
                jQuery.grep(arr1, function (el) {
                    if (jQuery.inArray(el, checkfor) !== -1) {
                        notpresent1.push(el);
                    }
                });
                var present1 = [];
                jQuery.grep(checkfor, function (el) {
                    //debugger;
                    if (jQuery.inArray(el, notpresent1) === -1) {
                  //      alert("abc");
                        present1.push(el);
                    }
                });
                //alert(present1);
                
                var pr_cnt1 = present1.length;
                
                if (pr_cnt1 > 0) {
                    if ($('#error').html().length === 0) {
                        var error_div = $('<div class="alert alert-danger" id="err"></div>').appendTo('#error');
                        var strong = $('<strong></strong>').text('Error!').appendTo(error_div);
                        for (var k = 0; k < pr_cnt1; k++) {
                            var p = $('<p>It is mandatory to select FilledBy as ' + filledby[present1[k] - 1] + ' in any 1 column in table no ' + i + '</p>').appendTo('#err');
                        }
                        error++;
                    } else {
                        for (var k = 0; k < pr_cnt1; k++) {
                            var p = $('<p>It is mandatory to select FilledBy as ' + filledby[present1[k] - 1] + ' in any 1 column in table no ' + i + '</p>').appendTo('#err');
                            
                        }
                        error++;
                    }
                }
            }
        }//for create without pricebid
        if(error===0){
            if(opt===1||opt==='1'){
                return createJSONForEdit();
            }
            else{
                return createJSON();
            }
        }
        else{
            //('error'+error);
            return false;
        }
    }
}

function removethisrow(ctl,tableno) {
    var toremovediv = $(ctl).attr("divid");
    $("#" + toremovediv).remove();
    $("#txtnumcol" + tableno).val($("#txtnumcol" + tableno).val() - 1)
}
