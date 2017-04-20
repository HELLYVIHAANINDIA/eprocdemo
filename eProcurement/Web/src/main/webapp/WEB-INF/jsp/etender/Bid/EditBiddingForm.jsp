<%@include file="../../includes/head.jsp"%>
<%@include file="../../includes/masterheader.jsp"%>
<div class="content-wrapper">
            <section class="content-header">
                <h1 class="inline">
                     <spring:message code="lbl_edit_bidding_form" /> <small></small>
                </h1>
            </section>
            <section class="content">
                
                <form id="tenderDtBean" name="tenderDtBean" action="${pageContext.servletContext.contextPath}/eBid/Bid/saveForm" method="post"  onsubmit="return createJSON();">

                <div class="row">
                    <div class="col-lg-12 col-md-12">
                        <div class="box">
                            <div class="box-header with-border">
                                <h3 class="box-title"><spring:message code="lbl_create_bidding_form" /></h3>
                            </div>
                             <div class="row">
                                    <div class="col-lg-2">

                                        <div class="form_bx">
                                            <label> <input type="radio" id="rbEditForm">
                                            </label>
                                        </div>

                                    </div>
                                    <div class="col-lg-2">
                                        <div class="form_filed"><spring:message code="lbl_update_bidding_form" /></div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-2">

                                        <div class="form_bx">
                                            <label> <input type="radio" id="rbEditTableDetails">
                                            </label>
                                        </div>

                                    </div>
                                    <div class="col-lg-2">
                                        <div class="form_filed"><spring:message code="lbl_upadte_bidding_form_table_details" /></div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-2">

                                        <div class="form_bx">
                                            <label> <input type="radio" id="rbEditTableStructure">
                                            </label>
                                        </div>

                                    </div>
                                    <div class="col-lg-2">
                                        <div class="form_filed"><spring:message code="lbl_update_bidding_form_table_structure" /></div>
                                    </div>
                                </div>
                            
                                 <div class="row">
                                    <div class="col-lg-2">

                                        <div class="form_bx">
                                            <label> <input type="radio" id="rbAddColumn">
                                            </label>
                                        </div>

                                    </div>
                                    <div class="col-lg-2">
                                        <div class="form_filed"><spring:message code="lbl_add_column" /></div>
                                    </div>
                                </div>
                            
                                 <div class="row">



                                    <div class="col-lg-2">

                                        <div class="form_bx">
                                            <label> <input type="radio" id="rbDeleteColumn">
                                            </label>
                                        </div>

                                    </div>
                                    <div class="col-lg-2">
                                        <div class="form_filed"><spring:message code="lbl_delete_column" /></div>
                                    </div>
                                </div>
                                <div class="row">



                                    <div class="col-lg-2">

                                        <div class="form_bx">
                                            <label> <input type="radio" id="rbAddDeleteRow">
                                            </label>
                                        </div>

                                    </div>
                                    <div class="col-lg-2">
                                        <div class="form_filed"><spring:message code="lbl_add/delete_table_row" /></div>
                                    </div>
                                </div>

                            <div class="box-body">
                               
                                <div class="row">
                                    <div class="col-lg-12 col-md-12 col-xs-12" id="FormTable">
                                        <div class="row">
                                            <div class="col-lg-2">
                                                <div class="form_filed"><spring:message code="lbl_form_type" /></div>
                                            </div>
                                            <div class="col-lg-10">
                                                <label id="lblFormType"></label>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-2">
                                                <div class="form_filed"><spring:message code="field_formName" /></div>
                                            </div>
                                            <div class="col-lg-10">
                                                <input type="text" id="FormName" name="FormName" class="form-control" placeholder="Select Form Name">
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-2">
                                                <div class="form_filed"><spring:message code="lbl_form_header" /></div>
                                            </div>
                                            <div class="col-lg-10">
                                                <textarea rowa="3" class="form-control" id="FromHeader"  name="FromHeader" placeholder="Select Form Header" ></textarea>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-2">
                                                <div class="form_filed"><spring:message code="lbl_form_footer" /></div>
                                            </div>
                                            <div class="col-lg-10">
                                                <textarea rowa="3" class="form-control" id="FormFooter" name="FormFooter" placeholder="Select Form Footer" ></textarea>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-2">
                                                <div class="form_filed"><spring:message code="lbl_required_bid_supporting_document" /></div>
                                            </div>
                                            <div class="col-lg-10">
                                                <select class="form-control" id="RequiredSupportingDoc" name="RequiredSupportingDoc">
                                                    <option value="1"><spring:message code="label_yes" /></option>
                                                    <option value="0"><spring:message code="label_no" /><spring:message code="label_no" /></option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-2">
                                                <div class="form_filed"><spring:message code="lbl_is_mandatory" /></div>
                                            </div>
                                            <div class="col-lg-10">
                                                <select class="form-control" id="IsMandatory" name="IsMandatory">
                                                    <option value="1"><spring:message code="label_yes" /></option>
                                                    <option value="0"><spring:message code="label_no" /></option>
                                                </select>
                                            </div>
                                        </div>
                                        
                                        <div class="row" style="display:none">
                                            <div class="col-lg-2">
                                                <div class="form_filed"><spring:message code="lbl_is_encrypted_document" /></div>
                                            </div>
                                            <div class="col-lg-10">
                                                <select class="form-control" id="Encrypted" name="Encrypted">
                                                    <option value="1"><spring:message code="label_yes" /></option>
                                                    <option value="0"><spring:message code="label_no" /></option>
                                                </select>
                                            </div>
                                        </div>
                                        
                                        <div class="row" style="display:none">
                                            <div class="col-lg-2">
                                                <div class="form_filed"><spring:message code="lbl_is_encrypted_required" /></div>
                                            </div>
                                            <div class="col-lg-10">
                                                <select class="form-control" id="EncryptionReq" name="EncryptionReq">
                                                    <option value="1"><spring:message code="label_yes" /></option>
                                                    <option value="0"><spring:message code="label_no" /></option>
                                                </select>
                                            </div>
                                        </div>
                                        
                                        <div class="row" style="display:none">
                                            <div class="col-lg-2">
                                                <div class="form_filed"><spring:message code="lbl_is_evaluation_required" /></div>
                                            </div>
                                            <div class="col-lg-10">
                                                <select class="form-control" id="IsEvaluation" name="IsEvaluation">
                                                    <option value="1"><spring:message code="label_yes" /></option>
                                                    <option value="0"><spring:message code="label_no" /></option>
                                                </select>
                                            </div>
                                        </div>
                                        
                                        <div class="row" style="display:none">
                                            <div class="col-lg-2">
                                                <div class="form_filed"><spring:message code="lbl_is_item_wise_document_allowed" /></div>
                                            </div>
                                            <div class="col-lg-10">
                                                    <select class="form-control" id="IsMandatory" name="IsItemWiseDoc">
                                                    <option value="1"><spring:message code="label_yes" /></option>
                                                    <option value="0"><spring:message code="label_no" /></option>
                                                </select>
                                            </div>
                                        </div>
                                        
                                        <div class="row" style="display:none">
                                            <div class="col-lg-2">
                                                <div class="form_filed"><spring:message code="lbl_is_multiple_filling" /></div>
                                            </div>
                                            <div class="col-lg-10">
                                                <select class="form-control" id="IsMandatory" name="IsMultiple">
                                                    <option value="1"><spring:message code="label_yes" /></option>
                                                    <option value="0"><spring:message code="label_no" /></option>
                                                </select>
                                            </div>
                                        </div>
                                        
                                        
                                        
                                        
                                        
                                        <div class="row" id="dvPriceBid" style="display:none">


                                            <div class="col-lg-2" >
                                                <div class="form_filed"><spring:message code="lbl_is_price_bidding_form" /></div>
                                            </div>
                                            <div class="col-lg-10">
                                                <div class="form_bx">
                                                    <label> <input type="radio" name="rdbPriceBidding" id="rdbPriceBiddingY"  value="1"><spring:message code="label_yes" />										</label>
                                                    <label> <input type="radio" name="rdbPriceBidding" id="rdbPriceBiddingN"  value="0" checked="true" ><spring:message code="label_no" />
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row" style="display:none" id="dvConsortium">
                                            <div class="col-lg-2">
                                                <div class="form_filed"><spring:message code="lbl_is_consortium_applicable" /></div>
                                            </div>
                                            <div class="col-lg-10">
                                                <div class="form_bx">
                                                    <label> <input name="rdbConsortium" id="rdbConsortiumY" type="radio" value="1"><spring:message code="label_yes" /></label>
                                                    <label> <input name="rdbConsortium" id="rdbConsortiumN" type="radio" value="0" checked="true"><spring:message code="label_no" /> </label>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row" style="display:none" id="dvSecondaryPartner">
                                            <div class="col-lg-2">
                                                <div class="form_filed"><spring:message code="lbl_is_applicable_for_secondary_partner" /></div>
                                            </div>
                                            <div class="col-lg-10">
                                                <div class="form_bx">
                                                    <label> <input name="rdbsecondaryPartner" id="rdbsecondaryPartnerY" type="radio" value="1"><spring:message code="label_yes" /></label>
                                                    <label> <input name="rdbsecondaryPartner" id="rdbsecondaryPartnerN" type="radio" value="0"><spring:message code="label_no" /></label>
                                                </div>
                                            </div>
                                        </div>
                                        
                                    </div>

                                    <div class="col-md-12 text-center">
                                        <button type="submit" class="btn btn-submit" id="btnSubmitForm"><spring:message code="label_submit" /></button>
                                        <button type="button" class="btn btn-submit"><spring:message code="lbl_reset" /></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                    <input type="text" id="hdnFormId" name="hdnFormId">
                 </form>       
            </section>
  </div>     
<script src="${pageContext.servletContext.contextPath}/resources/PageJS/BiddingForm.js" type="text/javascript"></script>

<script>
     $(document).ready(function () {
        // getFormData();
     });
     
     $("#rbEditForm").click(function(){
         getFormData();
     });
   function getFormData() {
                alert("in fun");
            	var data = {};
            	$.ajax({
            		type : "GET",
            		contentType : "application/json",
            		url : "${pageContext.servletContext.contextPath}/eBid/Bid/GetTableRows/4",
            		data : data,
            		timeout : 100000,
                       
            		success : function(data) {
            			console.log("SUCCESS: ", data);
            			alert(data);
                                var formdata = JSON.parse(data);
                                $('#FormName').val(formdata['formName']);
                                $('#FromHeader').val(formdata['formHeader']);
                                $('#FormFooter').val(formdata['formFooter']);
                                $('#IsMandatory ').val(formdata['isMandatory']);
                                $('#RequiredSupportingDoc').val(formdata['isDocumentReq']);
                                $('#hdnFormId').val(formdata['formId']);
                                alert(formdata['formName']);
            		},
                         error: function(xhr, status, error) {
                                var err = eval("(" + xhr.responseText + ")");
                                alert(err.Message);
                              }
            		,
            		done : function(e) {
            			console.log("DONE");
            		}
            	});
            }
       //edit Table column structure     
     $("#rbEditTableStructure").click(function(){
         getTableStructure();
     });
   function getTableStructure() {
                alert("in fun");
            	var data = {};
            	$.ajax({
            		type : "GET",
            		contentType : "application/json",
            		url : "${pageContext.servletContext.contextPath}/eBid/Bid/GetTableStructure/4",
            		data : data,
            		timeout : 100000,
                       
            		success : function(data) {
            			console.log("SUCCESS: ", data);
            			alert(data);
                               	},
                         error: function(xhr, status, error) {
                                var err = eval("(" + xhr.responseText + ")");
                                alert(err.Message);
                              }
            		,
            		done : function(e) {
            			console.log("DONE");
            		}
            	});
            }


     //Add Table column      
     $("#rbAddColumn").click(function(){
         getTableStructureForAddColumn();
     });
   function getTableStructureForAddColumn() {
                alert("in fun");
            	var data = {};
            	$.ajax({
            		type : "GET",
            		contentType : "application/json",
            		url : "${pageContext.servletContext.contextPath}/eBid/Bid/GetTableStructure/4",
            		data : data,
            		timeout : 100000,
                       
            		success : function(data) {
            			console.log("SUCCESS: ", data);
            			alert(data);
                               	},
                         error: function(xhr, status, error) {
                                var err = eval("(" + xhr.responseText + ")");
                                alert(err.Message);
                              }
            		,
            		done : function(e) {
            			console.log("DONE");
            		}
            	});
            }
        

    //Remove Table column      
     $("#rbDeleteColumn").click(function(){
         getTableStructureForDeleteColumn();
     });
   function getTableStructureForDeleteColumn() {
                alert("in fun");
            	var data = {};
            	$.ajax({
            		type : "GET",
            		contentType : "application/json",
            		url : "${pageContext.servletContext.contextPath}/eBid/Bid/GetTableStructure/4",
            		data : data,
            		timeout : 100000,
                       
            		success : function(data) {
            			console.log("SUCCESS: ", data);
            			alert(data);
                               	},
                         error: function(xhr, status, error) {
                                var err = eval("(" + xhr.responseText + ")");
                                alert(err.Message);
                              }
            		,
            		done : function(e) {
            			console.log("DONE");
            		}
            	});
            }
        
        
// add/delete table row
     $("#rbAddDeleteRow").click(function(){
         getRowData();
     });
   function getRowData() {
                alert("in fun");
            	var data = {};
            	$.ajax({
            		type : "GET",
            		contentType : "application/json",
            		url : "${pageContext.servletContext.contextPath}/eBid/Bid/GetTableRows/4",
            		data : data,
            		timeout : 100000,
                       
            		success : function(data) {
            			console.log("SUCCESS: ", data);
            			alert(data);
                               	},
                         error: function(xhr, status, error) {
                                var err = eval("(" + xhr.responseText + ")");
                                alert(err.Message);
                              }
            		,
            		done : function(e) {
            			console.log("DONE");
            		}
            	});
            }
             
              
</script>
<%@include file="../../includes/footer.jsp"%>

   
