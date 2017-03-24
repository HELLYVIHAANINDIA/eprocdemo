/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function ValidateInput(datatype,ctl){
    //Short Text (300 Max)
   
    if(datatype=="1")
    {
        var Length = $(ctl).val().length;
           var maxLen=300;
                
            if(Length >= maxLen){
                if (event.which != 8) {
                    alert("Maximum length of content is 300 chars");
                    return false;
                }
            }
    }
    //Long Text
    else if(datatype=="2"){
        return true;
    }
    //Number With Dot
    else if(datatype=="3"){
        if($(ctl).val().indexOf('.') == -1)
        {
             alert("Please enter decimal No. (eg. 10.00");
                   
            return false;
        }
    }
    //Whole Number
    else if(datatype=="4"){
         if($(ctl).val().indexOf('.') == -1)
        {
            return true;
        }
        else
        {
            alert("Decimal No is not allow.");
            return false;
        }
    }
    
    
    
}

$("#btnSubmitForm").click(function(){
    var ArrTableJson={};
    
    var cnt = 0;
    var count=0;
    var colNo=0;
   
    $('[id^="tbl_"]').each(function () {
        debugger;
        var TableJson={};
        TableJson['FormId']= $('#hdnFormId').val();
         TableJson['TableId']=$(this).attr("tableId");
         
          var ArrColumnJson={}
          count=0;
        $("#tbl_"+ cnt).find("tbody tr").each(function () {
            colNo=0;
            $(this).find("td").each(function () { 
                
                
         
            var ColumnJson={};
            var val;
                 //Table ID
                 //console.log($(this).attr("tableid"));
                // Row ID
                // console.log($(this).attr("trid"));
                //Column ID
                 //console.log($(this).attr("colKey"));
                
                if($(this).find("input[type=text]").length){
                    console.log("Row: " + $(this).attr("trid") + " ,Key: " + $(this).attr("colKey") +  " , val: " + $(this).find("input[type=text]").val());
                    val="Row: " + $(this).attr("trid") + " ,Key: " + $(this).attr("colKey") +  " , val: " + $(this).find("input[type=text]").val();
                    ColumnJson['row']=$(this).attr("trid");
                    ColumnJson['key']=$(this).attr("colKey");
                    ColumnJson['val']=$(this).find("input[type=text]").val();
                    
            }
                else if($(this).find("label").length){
                         console.log("Row: " + $(this).attr("trid") + " ,Key: " + $(this).attr("colKey") +  " , val: " + $(this).find("label").text());
                        val="Row: " + $(this).attr("trid") + " ,Key: " + $(this).attr("colKey") +  " , val: " + $(this).find("label").text();
                        ColumnJson['row']=$(this).attr("trid");
                    ColumnJson['key']=$(this).attr("colKey");
                    ColumnJson['val']=$(this).find("label").text();
                    
            }
                else if($(this).find("select").length){
                         console.log("Row: " + $(this).attr("trid") + " ,Key: " + $(this).attr("colKey") +  " , val: " + $(this).find("select").val());
               val="Row: " + $(this).attr("trid") + " ,Key: " + $(this).attr("colKey") +  " , val: " + $(this).find("select").val();
               ColumnJson['row']=$(this).attr("trid");
                    ColumnJson['key']=$(this).attr("colKey");
                    ColumnJson['val']=$(this).find("select").val();
                    
            }
                else if($(this).find("input[type=number]").length){
                         console.log("Row: " + $(this).attr("trid") + " ,Key: " + $(this).attr("colKey") +  " , val: " + $(this).find("input[type=number]").val());
               val="Row: " + $(this).attr("trid") + " ,Key: " + $(this).attr("colKey") +  " , val: " + $(this).find("input[type=number]").val();
                ColumnJson['row']=$(this).attr("trid");
                    ColumnJson['key']=$(this).attr("colKey");
                    ColumnJson['val']=$(this).find("input[type=number]").val();
                    
            }
                else if($(this).find("input[type=file]").length){
                        console.log("Row: " + $(this).attr("trid") + " ,Key: " + $(this).attr("colKey") +  " , val: " + $(this).find("input[type=file]").val());
                val="Row: " + $(this).attr("trid") + " ,Key: " + $(this).attr("colKey") +  " , val: " + $(this).find("input[type=file]").val();
                ColumnJson['row']=$(this).attr("trid");
                    ColumnJson['key']=$(this).attr("colKey");
                    ColumnJson['val']=$(this).find("input[type=file]").val();
                    
            }
                else if($(this).find("input[type=date]").length){
                        console.log("Row: " + $(this).attr("trid") + " ,Key: " + $(this).attr("colKey") +  " , val: " + $(this).find("input[type=date]").val());
                 val="Row: " + $(this).attr("trid") + " ,Key: " + $(this).attr("colKey") +  " , val: " + $(this).find("input[type=date]").val();
               
                ColumnJson['row']=$(this).attr("trid");
                    ColumnJson['key']=$(this).attr("colKey");
                    ColumnJson['val']=$(this).find("input[type=date]").val();
                    
            }
            else if($(this).find("textarea").length){
                 val="Row: " + $(this).attr("trid") + " ,Key: " + $(this).attr("colKey") +  " , val: " + $(this).find("textarea").val();
               
                ColumnJson['row']=$(this).attr("trid");
                    ColumnJson['key']=$(this).attr("colKey");
                    ColumnJson['val']=$(this).find("textarea").val();
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
       
    
    return true;
});