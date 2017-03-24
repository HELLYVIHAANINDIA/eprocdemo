/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function getSelectedCheckBox()
{
    var selected = [];
    $('#tbl_form input:checked').each(function () {
        selected.push($(this).attr('formId'));
    });
    $('#hdnFormId').val(selected);
   
    if(selected.length==0){
        alert("Please select atleast one form before copy ");
        return false;
    }
    else
    {
        if($('#TenderEnv').val()==-1){
            alert("Please select Tender envelope.");
            return false;
        }
    
        return true;
    }
    
}

