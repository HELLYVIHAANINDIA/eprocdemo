/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(function(){
    var cntTable = 0;
        $('[id^="dvDocForm_"]').each(function() {
            cntTable++;
        });
        cntTable++;
   fnCreateDocumentForm(cntTable); 
});

function fnCreateDocumentForm(cntTable)
{
    var trDiv=$('<tr id=dvDocForm_'+cntTable+'></tr>').appendTo('#dvMainDocumentForm');
    
    var td=$('<td class="text-center"></td>').text(cntTable).appendTo(trDiv);
    
    var tdDiv=$('<td class="text-center"></td>').appendTo(trDiv);
    var inputDocName=$('<input></input>').attr({type:'text',id:'txtDocName_'+cntTable ,onblur: 'validateTextComponent(this)', validarr: "required@@length:0,100", tovalid: "true", title: "Document Name"}).appendTo(tdDiv);
    
    var tdDiv2=$('<td class="text-center"></td>').appendTo(trDiv);
    var checkMan=$('<input></input>').attr({type:'checkbox',id:'chkIsMandatory_'+cntTable}).appendTo(tdDiv2);
    checkMan.css('text-align','center');
    
    var tdDiv3=$('<td class="text-center"></td>').appendTo(trDiv);
    var checkMan1=$('<a></a>').attr({onclick:'fnRemoveDocForm('+cntTable+')'}).appendTo(tdDiv3);
    checkMan1.css({cursor:'pointer'});
    var tdInnerDiv3=$('<i class="fa fa-trash tb"></i>').appendTo(checkMan1);
   
}

$('#btnAddNewDocument').click(function(){
   var cntTable = 0;
        $('[id^="dvDocForm_"]').each(function() {
            cntTable++;
        });
        cntTable++;
   fnCreateDocumentForm(cntTable); 
});

function fnRemoveDocForm(cntTable)
{
    $('#dvDocForm_'+cntTable).remove();
}
    
function createJSON()
{
    var cntTable = 0;
        $('[id^="dvDocForm_"]').each(function() {
            cntTable++;
        });
        var DocumentJson={}
        var ArrJsonObj={}
        
      for(var i=1;i<=cntTable;i++)
      {
          var JsonObj={}
         // alert('hello'+i);
          JsonObj['DocumentName']=$('#txtDocName_'+i).val();
          if($('#chkIsMandatory_'+i).prop('checked')===true)
          {
            JsonObj['IsMandatory']=1;
          }
          else
          {
              JsonObj['IsMandatory']=0;
          }
        ArrJsonObj['DocumentJson'+i]=JsonObj;
      }
      DocumentJson['DocumentJsonObj']=ArrJsonObj;
      $('#DocumentJson').val(JSON.stringify(DocumentJson));
      return true;
}

