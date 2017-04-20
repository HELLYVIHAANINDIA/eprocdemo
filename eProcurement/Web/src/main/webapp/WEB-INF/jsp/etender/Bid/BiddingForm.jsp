<%@include file="../../includes/head.jsp"%>
<%@include file="../../includes/masterheader.jsp"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.eprocurement.etender.model.TblTenderEnvelope"%>
<%@page import="java.util.List"%>

    <%
        List<TblTenderEnvelope> lstTable=new ArrayList<TblTenderEnvelope>();
        if(request.getAttribute("tenderEnvelope")!=null)
             lstTable = (List) request.getAttribute("tenderEnvelope");
        String tenderId="1";
        String operation="0";
        TblTenderEnvelope tblTenderEnvelope=new TblTenderEnvelope();
        if(request.getAttribute("tenderId")!=null)
            tenderId=(String)request.getAttribute("tenderId");
         
        if(request.getAttribute("operation")!=null)
            operation=(String)request.getAttribute("operation");
        if(request.getAttribute("Envlope")!=null)
            tblTenderEnvelope=(TblTenderEnvelope)request.getAttribute("Envlope");
         
    %>


 <div class="content-wrapper">
 
<section class="content-header">
<h1 class="inline"><spring:message code="lbl_create_edit_bidding_form" /><small></small>
</h1>
<a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}" class="g g-back"><< <spring:message code="lbl_go_back_to_dashboard" /></a>
</section>

   <c:if test="${not empty operation}">
       <c:set var="saveAction" value="${pageContext.servletContext.contextPath}/eBid/Bid/editForm" />               
   </c:if>
                
                <c:if test="${ empty operation}">
                	<c:set var="saveAction" value="${pageContext.servletContext.contextPath}/eBid/Bid/saveForm" />

                </c:if>          
<section class="content">
<form id="tenderDtBean" name="tenderDtBean" action="${saveAction}" method="post"  onsubmit="if(valOnSubmit()){return validate();} else {return false ;}">
               
                
<div class="row">
<div class="col-lg-12 col-md-12">
<div class="box">
<div class="box-header with-border">
<h3 class="box-title"><spring:message code="lbl_create_bidding_form" /></h3>
</div>
                          
<div id="error"></div>
                                               
<div class="box-body">
<div class="row">
<div class="col-lg-12 col-md-12 col-xs-12" id="FormTable">

<c:if test="${not empty errorMsg}">
<div class="alert alert-danger" id="err"><spring:message code="${errorMsg}"/></div>
</c:if>	
                                        <div class="row" id="divFormType">
                                            <div class="col-lg-2 col-md-2 col-sm-12 col-xs-12">
                                                <div class="form_filed"><spring:message code="lbl_eventtype" /><span class="red"> *</span></div>
                                            </div>
                                            <div class="col-lg-5 col-md-5 col-sm-12 col-xs-12">
                                               
                                                <%
                                                    if(operation.equals("1"))
                                                    {%>
                                                    <label><%=tblTenderEnvelope.getEnvelopeName()
                                                        %> </label>
                                                        <input type="hidden" value="<%=tblTenderEnvelope.getEnvelopeId()%>" name="optFormType">
                                                               
                                                   <% }
                                                    else{
                                                    %>
                                                
                                                    <select class="form-control" id="optFormType" name="optFormType" onblur="validateCombo(this);" isrequired="true" onchange="disabledPricebid()" title="Envelope Type">
                                                    <option value="-1">Please Select</option>
                                                    <%
                                                        for(TblTenderEnvelope TblTenderEnvelope:lstTable)
                                                        {
                                                        %>
                                                            <option value="<%=TblTenderEnvelope.getEnvelopeId()%>"><%=TblTenderEnvelope.getEnvelopeName()%></option>
                                                     <%}%>
                                                </select>
                                                <%}%>
                                            </div>
                                        </div>
                                        
                                        <div class="row">
                                            <div class="col-lg-2 col-md-2 col-sm-12 col-xs-12">
                                                <div class="form_filed"><spring:message code="field_formName" /><span class="red"> *</span></div>
                                            </div>
                                            <div class="col-lg-5 col-md-5 col-sm-12 col-xs-12">
                                                <input type="text" id="FormName" name="FormName" class="form-control" placeholder="Select Form Name"
                                                       validarr="required@@length:0,50" tovalid="true" onblur="validateTextComponent(this)" 
                                              title="Form Name">
                                            </div>
                                        </div>
                                        
                                        <div class="row">
                                            <div class="col-lg-2 col-md-2 col-sm-12 col-xs-12">
                                                <div class="form_filed"><spring:message code="lbl_form_header" /><span class="red"> *</span></div>
                                            </div>
                                            <div class="col-lg-5 col-md-5 col-sm-12 col-xs-12">
                                                <textarea rowa="3" class="form-control" id="FromHeader"  name="FromHeader" tovalid="true" onblur="validateTextComponent(this)" 
                                                          validarr="required@@tenderbrief:1000" title="Form Header" placeholder="Select Form Header" ></textarea>
                                            </div>
                                        </div>
                                        
                                        <div class="row">
                                            <div class="col-lg-2 col-md-2 col-sm-12 col-xs-12">
                                                <div class="form_filed"><spring:message code="lbl_form_footer" /></div>
                                            </div>
                                             <div class="col-lg-5 col-md-5 col-sm-12 col-xs-12">
                                                <textarea rowa="3" class="form-control" id="FormFooter" name="FormFooter" placeholder="Select Form Footer" ></textarea>
                                            </div>
                                        </div>
                                        
                                                <%if(operation.equalsIgnoreCase("1") &&  (!tblTenderEnvelope.getEnvelopeName().equalsIgnoreCase("Price bid")) && (!tblTenderEnvelope.getEnvelopeName().equalsIgnoreCase("TechnoCommercial(Technical & PriceBid)"))){
                                                   
%>

                                        <div class="row" id="dvReqDoc">
                                             <div class="col-lg-2 col-md-2 col-sm-12 col-xs-12">
                                                <div class="form_filed"><spring:message code="lbl_required_bid_supporting_document" /><span class="red"> *</span></div>
                                            </div>
                                            <div class="col-lg-5 col-md-5 col-sm-12 col-xs-12">
                                                <select class="form-control" id="RequiredSupportingDoc" name="RequiredSupportingDoc" onchange="validateCombo(this);" title="Required Bid Support Document">
                                                    <option value="1"><spring:message code="label_yes" /></option>
                                                    <option value="0" selected="selected"><spring:message code="label_no" /></option>
                                                </select>
                                            </div>
                                        </div>
                                        
                                        <%}%>
                                        <%if(!operation.equalsIgnoreCase("1") ){
                                                    %>
                                        <div class="row" id="dvReqDoc">
                                            <div class="col-lg-2 col-md-2 col-sm-12 col-xs-12">
                                                <div class="form_filed"><spring:message code="lbl_required_bid_supporting_document" /><span class="red"> *</span></div>
                                            </div>
                                            <div class="col-lg-5 col-md-5 col-sm-12 col-xs-12">
                                                <select class="form-control" id="RequiredSupportingDoc" name="RequiredSupportingDoc" onchange="validateCombo(this);" title="Required Bid Support Document">
                                                    <option value="1"><spring:message code="label_yes" /></option>
                                                    <option value="0" selected="selected"><spring:message code="label_no" /></option>
                                                </select>
                                            </div>
                                        </div>
                                        
                                        <%}%>
                                        <div class="row" id="isFormMandatorydiv">
                                            <div class="col-lg-2 col-md-2 col-sm-12 col-xs-12">
                                                <div class="form_filed"><spring:message code="lbl_is_form_mandatory" /><span class="red"> *</span></div>
                                            </div>
                                            <div class="col-lg-5 col-md-5 col-sm-12 col-xs-12">
                                                <select class="form-control" id="IsMandatory" name="IsMandatory" onchange="validateCombo(this);" title="Is Mandatory">
                                                    <option value="1"><spring:message code="label_yes" /></option>
                                                    <option value="0"><spring:message code="label_no" /></option>
                                                </select>
                                            </div>
                                        </div>
                                        
                                        <div class="row" style="display:none">
                                            <div class="col-lg-2 col-md-2 col-sm-12 col-xs-12">
                                                <div class="form_filed"><spring:message code="lbl_is_encrypted_document" /></div>
                                            </div>
                                             <div class="col-lg-5 col-md-5 col-sm-12 col-xs-12">
                                                <select class="form-control" id="Encrypted" name="Encrypted">
                                                    <option value="1"><spring:message code="label_yes" /></option>
                                                    <option value="0"><spring:message code="label_no" /></option>
                                                </select>
                                            </div>
                                        </div>
                                        
                                        <div class="row" style="display:none">
                                            <div class="col-lg-2 col-md-2 col-sm-12 col-xs-12">
                                                <div class="form_filed"><spring:message code="lbl_is_encrypted_required" /></div>
                                            </div>
                                            <div class="col-lg-5 col-md-5 col-sm-12 col-xs-12">
                                                <select class="form-control" id="EncryptionReq" name="EncryptionReq">
                                                    <option value="1"><spring:message code="label_yes" /></option>
                                                    <option value="0"><spring:message code="label_no" /></option>
                                                </select>
                                            </div>
                                        </div>
                                        
                                        <div class="row" style="display:none">
                                            <div class="col-lg-2 col-md-2 col-sm-12 col-xs-12">
                                                <div class="form_filed"><spring:message code="lbl_is_evaluation_required" /></div>
                                            </div>
                                            <div class="col-lg-5 col-md-5 col-sm-12 col-xs-12">
                                                <select class="form-control" id="IsEvaluation" name="IsEvaluation">
                                                    <option value="1"><spring:message code="label_yes" /></option>
                                                    <option value="0"><spring:message code="label_no" /></option>
                                                </select>
                                            </div>
                                        </div>
                                        
                                        <div class="row" style="display:none">
                                            <div class="col-lg-2 col-md-2 col-sm-12 col-xs-12">
                                                <div class="form_filed"><spring:message code="lbl_is_item_wise_document_allowed" /></div>
                                            </div>
                                             <div class="col-lg-5 col-md-5 col-sm-12 col-xs-12">
                                                    <select class="form-control" id="IsMandatory" name="IsItemWiseDoc">
                                                    <option value="1"><spring:message code="label_yes" /></option>
                                                    <option value="0"><spring:message code="label_no" /></option>
                                                </select>
                                            </div>
                                        </div>
                                        
                                        <div class="row" style="display:none">
                                            <div class="col-lg-2 col-md-2 col-sm-12 col-xs-12">
                                                <div class="form_filed"><spring:message code="lbl_is_multiple_filling" /></div>
                                            </div>
                                            <div class="col-lg-5 col-md-5 col-sm-12 col-xs-12">
                                                <select class="form-control" id="IsMandatory" name="IsMultiple">
                                                    <option value="1"><spring:message code="label_yes" /></option>
                                                    <option value="0"><spring:message code="label_no" /></option>
                                                </select>
                                            </div>
                                        </div>
                                        

                                        <div class="row" id="dvPriceBid" >
                             <div class="col-lg-2 col-md-2 col-sm-12 col-xs-12">
                                                <div class="form_filed"><spring:message code="lbl_is_price_bidding_form" /></div>
                                            </div>
                                            
                                            <div class="col-lg-5 col-md-5 col-sm-12 col-xs-12">
                                                <div class="form_bx">
                                                    
                                                    <label> <input type="radio" name="rdbPriceBidding" id="rdbPriceBiddingY"  value="1"><spring:message code="label_yes" />										</label>
                                                    <label> <input type="radio" name="rdbPriceBidding" id="rdbPriceBiddingN"  value="0" checked="true" ><spring:message code="label_no" />
                                                    </label>
                                                </div>
                                            </div>
                                            
                                        </div>
                                        
                                        <div class="row" style="display:none" id="dvConsortium">
                                        
                                            <div class="col-lg-2 col-md-2 col-sm-12 col-xs-12">
                                                <div class="form_filed"><spring:message code="lbl_is_consortium_applicable" /></div>
                                            </div>
                                            
                                            <div class="col-lg-5 col-md-5 col-sm-12 col-xs-12">
                                                <div class="form_bx">
                                                    <label> <input name="rdbConsortium" id="rdbConsortiumY" type="radio" value="1"><spring:message code="label_yes" /></label>
                                                    <label> <input name="rdbConsortium" id="rdbConsortiumN" type="radio" value="0" checked="true"><spring:message code="label_no" /></label>
                                                </div>
                                            </div>
                                            
                                        </div>

                                        <div class="row" style="display:none" id="dvSecondaryPartner">
                                        
                                            <div class="col-lg-2 col-md-2 col-sm-12 col-xs-12">
                                                <div class="form_filed"><spring:message code="lbl_is_applicable_for_secondary_partner" /></div>
                                            </div>
                                            
                                            <div class="col-lg-5 col-md-5 col-sm-12 col-xs-12">
                                                <div class="form_bx">
                                                    <label> <input name="rdbsecondaryPartner" id="rdbsecondaryPartnerY" type="radio" value="1"><spring:message code="label_yes" /></label>
                                                    <label> <input name="rdbsecondaryPartner" id="rdbsecondaryPartnerN" type="radio" value="0"><spring:message code="label_no" /></label>
                                                </div>
                                            </div>
                                            
                                        </div>
                                        
                                        

                                        <div class="row" id="divtbl">
                                        
                                            <div class="col-lg-2 col-md-2 col-sm-12 col-xs-12">
                                                <div class="form_filed"><spring:message code="lbl_no_of_tables" /><span> *</span></div>
                                            </div>
                                            <div class="col-lg-5 col-md-5 col-sm-12 col-xs-12">
                                                <input type="number" class="form-control" id="NoOfTable" name="NoOfTable" value="1" validarr="required@@positivelength:0,50" tovalid="true" onblur="validateTextComponent(this)" 
                                              title="No Of Tables" min="1" >
                                            </div>
                                            <div class="col-lg-2 col-md-2 col-sm-12 col-xs-12">
                                                <input type="button" value="Add Tables"  onclick="createTable();" class="btn btn-submit">
                                            </div>
                                        </div>
                                        
                                        <div>

                                            <div class="col-md-12" id="FormTr">
                                            </div>                                            
                                        </div>
                                    </div>

                                    <div class="col-md-12 text-center">
                                        <button type="submit" class="btn btn-submit" id="btnSubmitForm"><spring:message code="label_submit" /></button>
                                      
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="structureInfo"  style="display: none">
                    ${StructureInfo}
                </div>
                <input type="hidden" id="biidingType" value="${biddingType}">
                <input type="hidden" id="txtJson" name="txtJson">
                <input type="hidden" name="tenderId" value="<%=tenderId%>">
                <input type="hidden" id="operation" value="${operation}">
                <input type="hidden" value="${StructureInfo}">
                <input type="hidden" id="formWeight" name="formWeight" value="${tblTenderForm.formWeight}">
                <input type="hidden" id="hdnFormId" name="hdnFormId" value="${formId}">
             </form>       
            </section>
       </div>
       
                
                <script src="${pageContext.servletContext.contextPath}/resources/PageJS/BiddingForm.js" type="text/javascript"></script>
                <%-- <script src="${pageContext.servletContext.contextPath}/resources/js/commonValidate.js"></script> --%>


<script type="text/javascript">

function disabledPricebid()
{
     if ($('#optFormType option:selected').text() === 'TechnoCommercial(Technical & PriceBid)')
    {

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

    var isAuction="${isAuction}";
   var editIsAuction="${tblTender.isAuction}";
    var bidSubmissionFor="${tblTender.bidSubmissionfor}";
    $(document).ready(function () {
      if((isAuction==='')||(isAuction==='0'))
       {
       var opt=$('#operation').val();
     
       if(opt==1){
           createTableForEdit();
       }
       else{
            createTable(1);
            fncreateColumnTable(1);
       }                       
        
        $("input[name$='rdbConsortium']").click(function () {
            if ($(this).val() == 0)
                $("#dvSecondaryPartner").hide();
            else
                $("#dvSecondaryPartner").show();
        });
       }
       else if(isAuction==='1' || isAuction===1)
    {
       $('#optFormType option:eq(1)').prop('selected', true);
    $('#divFormType').hide();
       $('#dvReqDoc').hide();
       $('#divIsMandatory').hide();
       $('#requireBidDocument').hide();
    
       $('#isFormMandatorydiv').hide();
       $('#rdbPriceBiddingY').prop('checked','checked');
       $('#dvPriceBid').hide();
       $('#NoOfTable').val(1);
         $('#divtbl').hide();
       var tr = $('<div id=dvTable_'+1+'></div>').appendTo('#FormTr');
        var maintd = $('<div></div>').attr({class: 'col-md-12', align: 'center'}).appendTo(tr);
        $('<br/><div class="row text-center"></div>').appendTo(maintd);

        var tbl = $('<div class="row"></div>').appendTo(maintd);
        
        var heddiv=$('<div class="row"></div>').appendTo(tbl);
        var hedtr=$('<div class="col-md-2"></div>').appendTo(heddiv);
        var hedtd=$('<div class="form_filed"></div>').text("Table Header").appendTo(hedtr);
        var hedcol=$('<div class="col-md-9"></div>').appendTo(heddiv);
        var hedtext=$('<textarea></textarea>').attr({class: 'form-control',col:20,rows:3,id:'textAreaTableHeader'+1}).text('tbl header 1').appendTo(hedcol);
       $(heddiv).hide();
        var div = $('<div class="row"></div>').appendTo(tbl);
        var tr1 = $('<div class="col-md-2"></div>').appendTo(div);
        var td = $('<div class="form_filed"><span class="red">*</span></div>').text("Table Name").appendTo(tr1);
        var tblnm = $('<div class="col-md-3"></div>').appendTo(div);
        var txttblnm = $('<input></input>').attr({type: 'text', class: 'form-control',id:'TableName'+1,value:'Table Name 1',onblur:'validateTextComponent(this)',validarr : "required@@length:0,1000" , tovalid:"true" , title:"Table Name"}).appendTo(tblnm);
$(div).hide();
        var div2 = $('<div class="row"></div>').appendTo(tbl);
        var tr2 = $('<div class="col-md-2"></div>').appendTo(div2);
        var td2 = $('<div class="form_filed"></div>').text("No Of Rows").appendTo(tr2);
        var tdnumrow = $('<div class="col-md-3"></div>').appendTo(div2);
        var txtnumrow = $('<input></input>').attr({type: 'number', class: 'form-control',id:'NoOfRows'+1,onblur:'validateTextComponent(this)',validarr : "required@@length:0,3" , tovalid:"true" , title:"No of Rows"}).appendTo(tdnumrow);

        var tr3 = $('<div class="col-md-2"></div>').appendTo(div2);
        var td3 = $('<div class="form_filed"></div>').text("No Of Columns").appendTo(tr3);
        var tdnumcol = $('<div class="col-md-2"></div>').appendTo(div2);
        var txtnumcol = $('<input></input>').attr({type: 'number', class: 'form-control', id: 'txtnumcol' + 1,onblur:'validateTextComponent(this)',validarr : "required@@length:0,2" , tovalid:"true" , title:"No of Columns"}).appendTo(tdnumcol);
        var dvbtncol = $('<div class="col-md-1"></div>').appendTo(div2);
         var btnCol = $('<input></input>').attr({type: 'button', class: 'btn btn-submit',onclick:'fncreateColumnTable(' + 1 + ')', id : 'btn',value: 'Add Columns', style:'margin-top:15px;'}).appendTo(dvbtncol);
       
       

        var div4 = $('<div class="row"><br/><div class="col-md-2"></div></div>').appendTo(tbl);
        $('<div></div>').attr({id: 'divColumns' + 1}).appendTo(div4);

        var fotdiv=$('<div class="row"></div>').appendTo(tbl);
        var fottr=$('<div class="col-md-2"></div>').appendTo(fotdiv);
        var fottd=$('<div class="form_filed"></div>').text("Table Footer").appendTo(fottr);
        var fotcol=$('<div class="col-md-9"></div>').appendTo(fotdiv);
        var fottext=$('<textarea></textarea>').attr({class: 'form-control',value:'footer',col:20,rows:3,id:'TableFooter'+1}).appendTo(fotcol);
        $(fotdiv).hide();
        var mandiv=$('<div class="row"></div>').appendTo(tbl);
        var mantr=$('<div class="col-md-2"></div>').appendTo(mandiv);
        var mantd=$('<div class="form_filed"></div>').text("Is Mandatory").appendTo(mantr);
        var mancol=$('<div class="col-md-1" style="margin-top:25px;"></div>').appendTo(mandiv);
        var mancheck=$('<input></input>').attr({type: 'checkbox',id:'Mandatory'+1}).appendTo(mancol);
        $(mancheck).attr('checked','checked');
        $(mandiv).hide();
        
    }
if(parseInt(editIsAuction)===1){
    $('#divFormType').hide();
    $('#dvReqDoc').hide();
    $('#isFormMandatorydiv').hide();
}
    });
    
    
    
    function createJSON(){
        var check=['3','4','5'];
        var ArrTableJson={}
      
      for(var i=1;i<=$('#NoOfTable').val();i++)
      {
        var TableJson={}
        TableJson['textAreaTableHeader']=$('#textAreaTableHeader'+i).val();
        TableJson['TableName']=$('#TableName'+i).val();
        TableJson['NoOfRows']=$('#NoOfRows'+i).val();
        TableJson['txtnumcol']=$('#txtnumcol'+i).val();
        TableJson['TableFooter']=$('#TableFooter'+i).val();
        if($('#Mandatory'+i).prop('checked')===true)
        {
           TableJson['IsMandatory']=1;
        }
        else
        {
            TableJson['IsMandatory']=0;
        }
        if ($('#TableId'+i).length)
        {
           
            
        }
        else
        {
           
        }
        var ArrColumnJson={}
        for(var j=1;j<=$('#txtnumcol'+i).val();j++)
        {
            var ColumnJson={}
           // debugger;
            ColumnJson['ComumnNo']= $('#ComumnName'+ i  + '_'+ j).val();
            ColumnJson['ColumnHeader']=$('#ColumnHeader'+ i  + '_'+ j).val();
            ColumnJson['FilledBy']=$('#FilledBy'+ i  + '_'+ j).val();
            ColumnJson['ShowHide']=$('#ShowHide'+ i  + '_'+ j).val();
            ColumnJson['DataType']=$('#DataType'+ i  + '_'+ j).val();
            ColumnJson['ColumnType']=$('#ColumnType'+ i  + '_'+ j).val();
            if(((parseInt(editIsAuction)===1) || (parseInt(isAuction)===1)) && (parseInt(bidSubmissionFor)===1) && (parseInt($('#ColumnType'+i+'_'+j).val())===4))
            {
                ColumnJson['isGTColumn']=1;  
            }
            else
            {
                ColumnJson['isGTColumn']=$('#colId' + i + '_' + j).attr('isGTColumn');
            }
            
            ColumnJson['isPriceSummary']=$('#colId' + i + '_' + j).attr('isPriceSummary');

           
            if(jQuery.inArray(ColumnJson['DataType'],check)!==-1)
            {
                if($('#iscurrency_'+i+'_'+j).prop('checked')===true)
                {
                    ColumnJson['IsCurrencyConvert']=1;
                }
                else
                {
                    ColumnJson['IsCurrencyConvert']=0;
                }
            }
            else
            {
                ColumnJson['IsCurrencyConvert']=0;
            }
           
            ArrColumnJson['ColumnJson'+j]=ColumnJson;
        }
        TableJson['ColumnJson']=ArrColumnJson;
        ArrTableJson['TableJson'+i]=TableJson;
      }
      
      var jstr1=JSON.stringify(TableJson['ColumnJson']);
      
      
        var jsonObj={}
      
        jsonObj['FormType']=$('#optFormType option:selected').val();
        jsonObj['FormName']=$('#FormName').val();
        jsonObj['FromHeader']=$('#FromHeader').val();
        jsonObj['FormFooter']=$('#FormFooter').val();
        jsonObj['RequiredSupportingDoc']=$('#RequiredSupportingDoc option:selected').val();
        jsonObj['IsMandatory']=$('#IsMandatory option:selected').val();
        jsonObj['NoOfTable']=$('#NoOfTable').val();
        jsonObj['IsPriceBiddingForm']=$('#IsPriceBiddingForm').val();
        jsonObj['IsAppSecondary']=$('#IsAppSecondary').val();
        jsonObj['TableJson']=ArrTableJson;
        var jstr=JSON.stringify(jsonObj);
       
        $('#txtJson').val(jstr);
       console.log(jstr);
       $("#btnSubmitForm").attr('disabled','disabled');
    return true;
  } 

    function createJSONForEdit(){
        
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
    
    var check=['3','4','5','6'];
    var ArrTableJson={}
      
      for(var i=0;i<$('#NoOfTable').val();i++)
      {
        var TableJson={}
        TableJson['textAreaTableHeader']=$('#textAreaTableHeader'+i).val();
        TableJson['TableName']=$('#TableName'+i).val();
        TableJson['NoOfRows']=$('#NoOfRows'+i).val();
        TableJson['txtnumcol']=$('#txtnumcol'+i).val();
        TableJson['TableFooter']=$('#TableFooter'+i).val();
        TableJson['TableId']=$('#TableId'+i).val();
       
        if($('#Mandatory'+i).prop('checked')===true)
        {
           
            TableJson['IsMandatory']=1;
        }
        else
        {
            TableJson['IsMandatory']=0;
        }
        if ($('#TableId'+i).length)
        {
          
        }
        else
        {
          
        }
        var ArrColumnJson={}
        for(var j=0;j<$('#txtnumcol'+i).val();j++)
        {
            var ColumnJson={}
            var colId="0";
           
            ColumnJson['ComumnNo']= $('#ComumnName'+ i  + '_'+ j).val();
            ColumnJson['ColumnHeader']=$('#ColumnHeader'+ i  + '_'+ j).val();
            ColumnJson['FilledBy']=$('#FilledBy'+ i  + '_'+ j).val();
            ColumnJson['ShowHide']=$('#ShowHide'+ i  + '_'+ j).val();
            ColumnJson['DataType']=$('#DataType'+ i  + '_'+ j).val();
            ColumnJson['ColumnType']=$('#ColumnType'+ i  + '_'+ j).val();
             if($('#colId'+ i  + '_'+ j).val().trim().length!=0)
                colId=$('#colId'+ i  + '_'+ j).val();
            ColumnJson['ColumnId']=colId;
            ColumnJson['isGTColumn']=$('#colId' + i + '_' + j).attr('isGTColumn');
            ColumnJson['isPriceSummary']=$('#colId' + i + '_' + j).attr('isPriceSummary');
            if(jQuery.inArray(ColumnJson['DataType'],check)!==-1)
            {
                if($('#iscurrency_'+i+'_'+j).prop('checked')===true)
                {
                    ColumnJson['IsCurrencyConvert']=1;
                }
                else
                {
                    ColumnJson['IsCurrencyConvert']=0;
                }
            }
            else
            {
                ColumnJson['IsCurrencyConvert']=0;
            }
           
            ArrColumnJson['ColumnJson'+j]=ColumnJson;
        }
        TableJson['ColumnJson']=ArrColumnJson;
        ArrTableJson['TableJson'+i]=TableJson;
      }
      
        var jstr1=JSON.stringify(TableJson['ColumnJson']);
      
        var jsonObj={}
        jsonObj['FormType']=$('#optFormType option:selected').val();
        jsonObj['FormName']=$('#FormName').val();
        jsonObj['FromHeader']=$('#FromHeader').val();
        jsonObj['FormFooter']=$('#FormFooter').val();
        jsonObj['RequiredSupportingDoc']=$('#RequiredSupportingDoc option:selected').val();
        jsonObj['IsMandatory']=$('#IsMandatory option:selected').val();
        jsonObj['NoOfTable']=$('#NoOfTable').val();
        jsonObj['formId']=$('#hdnFormId').val();
       
        jsonObj['IsPriceBiddingForm']=$('#IsPriceBiddingForm').val();
        jsonObj['IsAppSecondary']=$('#IsAppSecondary').val();
        jsonObj['TableJson']=ArrTableJson;
        var jstr=JSON.stringify(jsonObj);
        $('#txtJson').val(jstr);
     $("#btnSubmitForm").attr('disabled','disabled');
       
    return true;
  } 
 
</script>
<%@include file="../../includes/footer.jsp"%>
  
