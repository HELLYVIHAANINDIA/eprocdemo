/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(function(){
    createEvaluationColumnForm();
});
function createEvaluationColumnForm()
{
      $('#dvMainDocumentForm').empty();
 //   alert(document.getElementById('jsonString').innerHTML);
  var responce=document.getElementById('jsonString').innerHTML;
  var json=JSON.parse(responce);
 // alert(json.length);
 var i=1;
 $.each(json,function(key,value){
     console.log(key, value);
   //alert(key);
        
    
         var divRow=$('<tr></tr>').attr({id:'trEvaluation_'+i}).appendTo('#dvMainDocumentForm');
         var td=$('<td class="text-center"></td>').text(i).appendTo(divRow);
         var arrKey=key.split('$');
         var divtd=$('<td class="text-center"></td>').text(arrKey[0]+" :").appendTo(divRow);
         //alert(arrKey[1]);
         var hdntbl=$('<input type="hidden">').attr({id:"hdntblId_"+i,value:arrKey[1]}).appendTo(divtd);
         
         
         var divselect=$('<td class="text-center"></td>').appendTo(divRow);
         var select=$('<select></select>').attr({id:'optForColumn_'+i}).appendTo(divselect);
        $('<option/>').attr('value','-1').text('Please Select').appendTo('#optForColumn_'+i);
        $.each(value,function(key2,value2){
             $('<option/>').attr('value',value2['columnId']).text(value2['columnHeader']).appendTo('#optForColumn_'+i);
           
        });
        i++;
    
 });
 
}

function createJSON()
{
     var columselection = true;
     $('[id^="optForColumn_"]').each(function() {
       if($(this).val() == -1){
            alert("Please select atleast one columnn for evalution");
            columselection = false;
       }
     });
     
     if(columselection == false){
         return false;
     }
    
    
    //alert("@@@");
    var cntTable = 0;
        $('[id^="trEvaluation_"]').each(function() {
            cntTable++;
        });
        var MainJson={}
        var DocumentJson={}
        var ArrJsonObj={}
        
      for(var i=1;i<=cntTable;i++)
      {
          var JsonObj={}
         // alert('hello'+i);
          JsonObj['tableId']=$('#hdntblId_'+i).val();
          JsonObj['columnId']=$('#optForColumn_'+i).val();
          if(JsonObj['columnId']!=='-1')
          {
            ArrJsonObj['EvaluationColumn'+i]=JsonObj;
          }
      }
      DocumentJson['EavluationColumnObj']=ArrJsonObj;
      DocumentJson['formId']=$('#formId').val();
      DocumentJson['tenderId']=$('#tenderId').val();
      MainJson['EvaluationColumnJsonObj']=DocumentJson;
      $('#EvaluationColumnJson').val(JSON.stringify(MainJson));
      return true;
}
function callForEvaluationColumn(){
	/* $.ajax({
		url:"/etender/buyer/publishtender/"+tenderId,
		success: function(result){
		console.log(result);
			location.reload();;
    }}); */
    if(confirm("Column is selected as Evaluation Column."))
    {
    	return true;
    }	
    return false;
 }

