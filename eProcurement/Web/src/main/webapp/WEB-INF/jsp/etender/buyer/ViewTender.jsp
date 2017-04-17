<%@include file="../../includes/head.jsp"%>
<c:if test="${1 ne fromPublishTender && 2 ne fromPublishTender}">
	  <%@include file="../../includes/masterheader.jsp"%>
</c:if>
<c:if test="${fromPublishTender eq 2}">
	<%@include file="../../includes/headerWithoutLogin.jsp"%>
</c:if>
 
<spring:message code="label_allow" var="allow"/>
<spring:message code="label_dontallow"  var="notallow"/>
<spring:message code="label_online" var="online"/>
<spring:message code="label_offline" var="offline"/>
<c:set var="bodyCls" value="skin-blue sidebar-mini"/>
<c:if test="${fromPublishTender eq 2}">
	<c:set var="bodyCls" value=""/>
</c:if>

<div class="content-wrapper">
<div id="viewTenderId">
	<section class="content-header">
		<c:if test="${1 ne fromPublishTender && 2 ne fromPublishTender}">
			<c:if test="${not empty successMsg}">
				<c:choose>
					<c:when test="${fn:contains(successMsg, '_')}">
						<div class="alert alert-success">
							<spring:message code="${successMsg}" />
						</div>
					</c:when>
					<c:otherwise>
						<div class="alert alert-success">${successMsg}</div>
					</c:otherwise>
				</c:choose>
			</c:if>
			<c:if test="${not empty errorMsg}">
				<div class="alert alert-danger">${errorMsg}</div>
			</c:if>
		</c:if>
		<c:choose>
			<c:when test="${1 ne fromPublishTender && 2 ne fromPublishTender}">
         		<h1 class="inline"><spring:message code="label_tender_view"/></h1>
         		<c:choose>
         			<c:when test="${sessionUserTypeId eq 2}">
         				<a href="${pageContext.servletContext.contextPath}/etender/bidder/bidderTenderListing/0" class="g g-back"><< Go To Tender Listing</a>
         			</c:when>
         			<c:otherwise>
         				<a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderListing" class="g g-back"><< Go To Tender Listing</a>
         			</c:otherwise>
         		</c:choose>
			</c:when>
			<c:when test="${2 eq fromPublishTender}">
         		<h1 class="pull-left"><spring:message code="label_tender_view"/></h1>
				<a href="${pageContext.servletContext.contextPath}/login" class="g g-back"><< Go Back To Login</a>
			</c:when>
			<c:otherwise>
		         <h1 class="pull-left"><spring:message code="link_tender_publish"/></h1>
		         <c:choose>
					<c:when test="${2 ne fromPublishTender}">
						<c:choose>
         					<c:when test="${sessionUserTypeId eq 2}">
					 		
					 		</c:when>
					 		<c:otherwise>
					 			<a href="${pageContext.servletContext.contextPath}/etender/buyer/tenderDashboard/${tenderId}"  class="g g-back"><< <spring:message code="lbl_back_dashboard"/></a>
					 		</c:otherwise>
					 	</c:choose>
					</c:when>
					<c:when test="${2 eq fromPublishTender}">
					 <a href="${pageContext.servletContext.contextPath}/login" class="g g-back"><< Go Back To Login</a>
					</c:when>
				</c:choose>
			</c:otherwise>
			</c:choose>
	</section>
	<section class="content">
	
		<div class="row">
			<div class="col-xs-12">
				<div class="box">
					<div class="box-header with-border">
						<h3 class="box-title">Organization Details</h3>
					</div>
					<div class="box-body">
						<div class="row">
							<div class="col-xs-3">Organization :</div>
							<div class="col-xs-3">
								<c:choose>
									<c:when test="${not empty organization}">
										${organization}
									</c:when>
									<c:otherwise>
										-
									</c:otherwise>
								</c:choose>
							</div>
							<div class="col-xs-3"><spring:message code="fields_tender_departmentofficial"/> :</div>
							<div class="col-xs-3">${officerName}</div>
						</div>
						<div class="row">
							<div class="col-xs-3"><spring:message code="label_tender_department"/> :</div>
							<div class="col-xs-3">${departmentName}</div>
							<div class="col-xs-3">Sub Department :</div>
							<div class="col-xs-3">
								<c:choose>
									<c:when test="${not empty subDeptName }">
										${subDeptName}
									</c:when>
									<c:otherwise>
										-
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	<div class="row">
		<div class="col-md-12">
			<div class="box">
				<div class="box-header with-border">
					<h3 class="box-title">Tender Basic Details</h3>
				</div>
				<div class="box-body">
					<div class="row">
						<div class="col-xs-3"><spring:message code="fields_tenderid"/> :</div>
						<div class="col-xs-3">${tblTender.tenderId}</div>
						<div class="col-xs-3"><spring:message code="fields_refenceno"/> :</div>
						<div class="col-xs-3">${tblTender.tenderNo}</div>
					</div>
					
					<div class="row">
						<div class="col-xs-3"><spring:message code="field_eventtype"/> :</div>
						<div class="col-xs-3 event-dtl">${eventTypeName}</div>
						<div class="col-xs-3"></div>
						<div class="col-xs-3"></div>
					</div>
					
					<div class="row">
						<div class="col-xs-3"><spring:message code="field_brief"/> :</div>
						<div class="col-xs-9 event-dtl">${tblTender.tenderBrief}</div>					
					</div>
					
					<div class="row">
						<div class="col-xs-3"><spring:message code="field_tender_detail"/> :</div>
						<div class="col-xs-9" id="tenderDetailDivTd">${tblTender.tenderDetail}</div>
					</div>
					
					<div class="row">
						<c:if test="${eventTypeId ne null && isCategoryAllow ne null && isCategoryAllow eq 1}" >
							<div class="col-xs-3"><spring:message code="lbl_auction_category"/> :</div>
							<div class="col-xs-3">${categoryNameList}</div>
							<div class="col-xs-3"></div>
							<div class="col-xs-3"></div>
						</c:if>
					</div>
					<div class="row">
						<div class="col-xs-3">
		           			<spring:message code="lbl_bidding_variant"/> :
		           		</div>
		            	<div class="col-xs-9">
			            	<c:choose>
				                <c:when test="${tblTender.biddingVariant eq 1}">
				                    <spring:message code="label_buy"/>
				                </c:when>
				                <c:when test="${tblTender.biddingVariant eq 2}">
				                    <spring:message code="label_sell"/>
				                </c:when>
			            	</c:choose>
		            	</div>
						<div class="col-xs-3">
			       			<spring:message code="lbl_type_of_contract"/> :
						</div>		
						<div class="col-xs-3">${procurementNature}</div>
					</div>
					<div class="row">
						<div class="col-xs-3"><spring:message code="fields_tender_keywords"/> :</div>
						<div class="col-xs-3">${tblTender.keywordText}</div>
					
						<div class="col-xs-3">
			           		<spring:message code="lbl_projectduration"/> :
						</div>
						<div class="col-xs-3">${tblTender.projectDuration}</div>
					</div>
					
					<div class="row">
						<c:if test="${not empty sessionObject and sessionObject ne null and ( sessionObject.userTypeId eq 1 or sessionObject.userTypeId eq 3)}">
							<div class="col-xs-3">
								<spring:message code="lbl_tender_value"/> :
							</div>
							<div class="col-xs-3">${tblTender.tenderValue}</div>
							<div class="col-xs-3"></div>
							<div class="col-xs-3"></div>
						</c:if> 
						<spring:message code="label_yes" var="yes"/>
						<spring:message code="label_no" var="no"/>
					</div>
					
					<%-- <div class="row">
						<c:if test="${cntTd eq 1}">
							<div class="col-xs-3"></div>
							<div class="col-xs-3"></div>
							<div class="col-xs-3"></div>
							<div class="col-xs-3"><c:set var="cntTd" value="0"/></div>
						</c:if>
					</div> --%>
				</div>
			</div>
		</div>
</div>
	<div class="row">
		<div class="col-xs-12">
			<div class="box">
				<div class="box-header with-border">
					<h3 class="box-title">Tender Configuration</h3>
				</div>
				<div class="box-body">
					<div class="row">
						<div class="col-xs-12">
				    		<c:if test="${checkpricebid}">
				        	  <div class="row">
									<div class="col-xs-3">
								    	<c:set var="allowBidEvaluation" value="0"/>
								        <spring:message code="lbl_envelope1"/> :
									</div>
									<div class="col-xs-3">${envolopeName}</div>
									<div class="col-xs-3">
					            		<spring:message code="lbl_envelope_process"/> :
									</div>
									<div class="col-xs-3">
										<c:choose>
						                	<c:when test="${tblTender.envelopeType eq 1}">
						                	<spring:message code="lbl_evaluation_singlestage"/>
						                	</c:when>
						                	<c:when test="${tblTender.envelopeType eq 2}">
						                	<spring:message code="lbl_evaluation_multiestage"/>
						                	</c:when>
						                </c:choose>
									</div>
								</div>
					            <div class="row">
					    			<div class="col-xs-3">
					            		<spring:message code="lbl_itemwise_lh"/> :
					    			</div>
					    			<div class="col-xs-3">
						    			 <c:choose>
							                <c:when test="${tblTender.isItemwiseWinner eq 1}">
							                <spring:message code="label_itemwise"/>
							                </c:when>
							                <c:when test="${tblTender.isItemwiseWinner eq 0}">
							                <spring:message code="label_eventwise"/>
							                </c:when>
						                </c:choose>
					    			</div>
					    			<c:if test="${tblTender.isItemwiseWinner eq 0}">
						    			<div class="col-xs-3">
							        		<c:set var="cntTd" value="${cntTd+1}"/>
							            	<spring:message code="lbl_bidding_access"/> :
						        		</div>
						        		<div class="col-xs-3">
							        		<c:choose>
								                <c:when test="${tblTender.tenderMode eq 1}">
								                <spring:message code="label_open"/>
								                </c:when>
								                <c:when test="${tblTender.tenderMode eq 2}">
								                <spring:message code="label_limited"/>
								                </c:when>
								                <c:when test="${tblTender.tenderMode eq 3}">
								                <spring:message code="label_single"/>
								                </c:when>
								                <c:when test="${tblTender.tenderMode eq 4}">
								                <spring:message code="label_nomination"/>
								                </c:when>
							                </c:choose>
						        		</div>
					    			</c:if>
					    		</div>
					        	<div class="row">
					        		<div class="col-xs-3">
						            	<spring:message code="lbl_weight_evaluation_require"/> :
					        		</div>
					        		<div class="col-xs-3">
						        		<c:choose>
							                <c:when test="${tblTender.isWeightageEvaluationRequired eq 1}">
							                	${allow}
							                </c:when>
							                <c:when test="${tblTender.isWeightageEvaluationRequired eq 0}">
							                	${notallow}
							                </c:when>
						                </c:choose>
					        		</div>
					        	</div>
				        	</c:if>
				        	<div class="row">
			        		<div class="col-xs-3">
			        			<spring:message code="field_rebate"/> :
			    			</div>
			    			<div class="col-xs-3">
				    			<c:choose>
				                <c:when test="${tblTender.isRebateApplicable eq 1}">
				                	${allow}
				                </c:when>
				                <c:when test="${tblTender.isRebateApplicable eq 0}">
				                	${notallow}
				                </c:when>
				                </c:choose>
			    			</div></div>
			            <div class="row">
			            	<div class="col-xs-3">
				            	<spring:message code="fields_basecurrency"/> :
			            	</div>
			            	<div class="col-xs-3">${currencyName}</div>
			            	<div class="col-xs-3">
			            	<spring:message code="lbl_biddingType"/> :
			            	</div>
			            	<div class="col-xs-3">
				            	<c:if test="${tblTender.biddingType eq 1}">
				                <spring:message code="lbl_national_competitive_bidding"/>
				                </c:if>
				                <c:if test="${tblTender.biddingType eq 2}">
				                <c:set var="curVal" value="( ${internationalCurrency} )"/>
				                <spring:message code="lbl_international_competitive_bidding"/> ${not empty internationalCurrency ? curVal :'' }
				                </c:if>
			            	</div>
			            </div>   
		       		<%--<div class="row">
		       		 <c:choose>
		            <c:when test="${tblTender.biddingType eq 2}">
		                <c:if test="${cntId eq 0}"> 
		                    <c:set var="cntTd" value="0"/>  
		            	</c:if>
		            	<c:if test="${cntTd eq 2}">          
		            		<c:set var="cntTd" value="0"/>  
		        		</c:if>
		        		<c:if test="${cntTd eq 1}">           
		        			<c:set var="cntTd" value="0"/>  
		    			</c:if>
					</c:when>
					</c:choose> 
		       		</div>--%>
		           <div class="row">
		           	<div class="col-xs-3">
		           		<spring:message code="lbl_consortium"/> :
		           	</div>
		           	<div class="col-xs-3">
		           	        <c:set var="isFormBasedConsortium" value="${valueMap.isFormBasedConsortium}"/>
			            <c:choose>
			                <c:when test="${tblTender.isFormBasedConsortium eq 0}">
			                    ${notallow}
			                </c:when>
			                <c:when test="${tblTender.isFormBasedConsortium eq 1}">
			                    ${allow}
			                </c:when>
			       		 </c:choose>
		           	</div>
		           	<div class="col-xs-3">
			        	<spring:message code="lbl_bidwithdrawal"/> :
		           	</div>
		           	<div class="col-xs-3">
		           	        <c:choose>
		                <c:when test="${tblTender.isBidWithdrawal eq 0}">
		                    ${notallow}
		                </c:when>
		                <c:when test="${tblTender.isBidWithdrawal eq 1}">
		                    ${allow}
		                </c:when>
		        		</c:choose>
		           	</div>
		           </div>
<%-- 	           <div class="row">
	               <c:if test="${cntTd eq 0}">      
					        <c:set var="cntTd" value="0"/>  
					</c:if>
					<c:if test="${cntTd eq 2}">
						<c:set var="cntTd" value="0"/>  
					</c:if>
					<c:if test="${cntTd eq 1}">  
					    <c:set var="cntTd" value="0"/>  
					</c:if>
	           </div> --%>
	           
	           <c:set value="0" var="keyConf"/>
			<div id="tldKeyConfDtl">
	            <div class="row">
		            <c:set value="${keyConf+1}" var="keyConf"/>
	            	<div class="col-xs-3">
	                <spring:message code="lbl_prebid_meeting"/> :
	            	</div>
	            	<div class="col-xs-3">
	            	<c:choose>
			                <c:when test="${tblTender.isPreBidMeeting eq 1}">
			                    ${allow}
			                </c:when>
			                <c:when test="${tblTender.isPreBidMeeting eq 0}">
			                    ${notallow}
			                </c:when>
			            </c:choose>
	            	</div>
	            	<c:set value="${keyConf+1}" var="keyConf"/>
	            	<c:if test="${tblTender.isPreBidMeeting eq 1}">
		           		<div class="col-xs-3">
		                    <spring:message code="lbl_prebid_address"/> :
		           		</div>
		           		<div class="col-xs-3">
		           		${tblTender.preBidAddress}
		           		</div>
		           	</c:if>
	           		<div class="col-xs-3">
		              <spring:message code="lbl_auto_result_sharing"/> :
	           		</div>
	           		<div class="col-xs-3">
		           		<c:choose>
		                <c:when test="${tblTender.autoResultSharing eq 1}">
		                    <spring:message code="lbl_manual"/>
		                </c:when>
		                <c:when test="${tblTender.autoResultSharing eq 0}">
		                    <spring:message code="lbl_auto"/>
		                </c:when>
		              </c:choose>
	           		</div> 
	            <c:set value="${keyConf+1}" var="keyConf"/>
	            <c:if test="${sessionUserTypeId ne 2}">
	            	<div class="col-xs-3">
	            <spring:message code="lbl_workflow_requires"/> :
	            	</div>
	            	<div class="col-xs-3">
	            	<c:choose>
			      <c:when test="${tblTender.isWorkflowRequired eq 1}">
			         <c:set  var="isWorkflowReq" value="${true}" />
			           ${yes}
			         </c:when>
			         <c:when test="${tblTender.isWorkflowRequired eq 0}">
			           ${no}
			         </c:when>
			    </c:choose>
	            	</div>
	            	</c:if>
	            	<div class="col-xs-3"></div>
	            	<div class="col-xs-3"></div>
	            </div>
	            
<%-- 	            <div class="row">
	            	<c:if test="${cntTd eq 2}">
	    <c:set var="cntTd" value="0"/>  
	</c:if>
	<c:if test="${cntTd eq 1}">
	    <c:set var="cntTd" value="0"/>  
	</c:if>
	            </div> --%>
	
	</div>
	</div>
	</div>
	</div>
	</div>
	</div>
	</div>
<div class="row">
	<div class="col-xs-12">
		<div class="box">
		
			<div class="box-header with-border">
				<h3 class="box-title"><spring:message code="title_doc_emd_secfees"/></h3>
			</div>
			
			<div class="box-body">
			
				<div class="row">
					<div class="col-xs-12">
						<c:set value="0" var="varFeesDtlCnt"/>
						<c:set value="${varFeesDtlCnt+1}" var="varFeesDtlCnt"/>
						<div class="row">
							<div class="col-xs-3">
		                		<spring:message code="lbl_document_fees"/> :
							</div>
							<div class="col-xs-3">
							<c:choose>
		                        <c:when test="${tblTender.isDocfeesApplicable eq 0}">
		                            ${notallow}
		                        </c:when>
		                        <c:otherwise>
									${allow}
		                        </c:otherwise>
		                    </c:choose>
							</div>
							<c:if test="${tblTender.isDocfeesApplicable eq 1}">
								<c:set value="${varFeesDtlCnt+1}" var="varFeesDtlCnt"/>
								<div class="col-xs-3">
			            			<spring:message code="fields_fees_amt"/> :
								</div>
								<div class="col-xs-3">
									<fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${tblTender.documentFee}" var="documentFees"/> 
			            			${documentFees}
								</div>
							</c:if>
						</div>
						<div class="row">
							<c:if test="${tblTender.isDocfeesApplicable eq 1}">
								<c:set value="${varFeesDtlCnt+1}" var="varFeesDtlCnt"/>
								<div class="col-xs-3">
				            		<spring:message code="field_docfees_payableat"/> :
								</div>
								<div class="col-xs-3">
									${tblTender.docFeePaymentAddress}
								</div>
							</c:if>
						</div>	
						<div class="row">	
							<c:set value="${varFeesDtlCnt+1}" var="varFeesDtlCnt"/>
							<div class="col-xs-3">
								<c:set var="cntTd" value="${cntTd+1}"/>
		                		<spring:message code="lbl_security_fee"/> :
							</div>
							<div class="col-xs-3">
								<c:choose>
			                        <c:when test="${tblTender.isSecurityfeesApplicable eq 0}">
			                            ${notallow}
			                        </c:when>
			                        <c:otherwise>
			                            ${allow}
			                        </c:otherwise>
			                    </c:choose>
							</div>
							<c:if test="${tblTender.isSecurityfeesApplicable eq 1}">
								<c:set value="${varFeesDtlCnt+1}" var="varFeesDtlCnt"/>
								<div class="col-xs-3">
				            		<spring:message code="field_tendersec_fees_amt"/> :
								</div>
								<div class="col-xs-3">
									<fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${tblTender.securityFee}" var="securityFees"/> 
				                	${securityFees}
								</div>
							</c:if>
						</div>
						<div class="row">
							<c:if test="${tblTender.isSecurityfeesApplicable eq 1 and tblTender.secFeePaymentMode eq 2}">
								<c:set value="${varFeesDtlCnt+1}" var="varFeesDtlCnt"/>
								<div class="col-xs-3">
				            		<spring:message code="field_tendersec_fee_payment_at"/> :
								</div>
								<div class="col-xs-3">
									${tblTender.secFeePaymentAddress}
								</div>
							</c:if>
						</div>
						<div class="row">
							<c:set value="${varFeesDtlCnt+1}" var="varFeesDtlCnt"/>
								<div class="col-xs-3">
			                		<spring:message code="lbl_emd_fee"/> :
								</div>
								<div class="col-xs-3">
									<c:choose>
				                        <c:when test="${tblTender.isEMDApplicable eq 0}">
				                            ${notallow}
				                        </c:when>
				                        <c:otherwise>
				                            ${allow}
				                        </c:otherwise>
				                    </c:choose>
								</div>
						
			        		<c:if test="${tblTender.isEMDApplicable eq 1}">
				        		<c:set value="${varFeesDtlCnt+1}" var="varFeesDtlCnt"/>
				        		<div class="col-xs-3">
				            		<spring:message code="field_emdamt"/> :
				        		</div>
				        		<div class="col-xs-3">
				        			<fmt:formatNumber type="number" groupingUsed="false" minFractionDigits="2" maxFractionDigits="2" value="${tblTender.emdAmount}" var="emdAmounts"/> 
				                	${emdAmounts}
			        			</div>
			        		</c:if>
			        		</div>
		        		<div class="row">
			        		 <c:if test="${(tblTender.isEMDApplicable eq 1 or tblTender.isEMDApplicable eq 2) and tblTender.emdPaymentMode eq 2}">
			        		 	<c:set value="${varFeesDtlCnt+1}" var="varFeesDtlCnt"/>
			        			<div class="col-xs-3">
				            		<spring:message code="field_emdpaymentat"/> :
			        			</div>
			        			<div class="col-xs-3">
			        				${tblTender.emdPaymentAddress}
			        			</div>
			        		</c:if>
		        		</div>
<%-- 		            	<div class="row">
			            	<c:if test="${cntTd eq 0}">       
			            		<c:set var="cntTd" value="0"/>        
			    			</c:if>
					    	<c:if test="${cntTd eq 2}">    
					    		<c:set var="cntTd" value="0"/>  
							</c:if>
							<c:if test="${cntTd eq 1}">   
					    		<c:set var="cntTd" value="0"/>  
							</c:if>
		            	</div> --%>
				</div>
			</div>
		</div> 
	</div>
	</div>
</div>
<c:if test="${2 eq fromPublishTender or 0 eq fromPublishTender or empty fromPublishTender}">
		<div class="row">
			<div class="col-xs-12">
				<div class="box">
				<div class="box-header with-border">
					<h3 class="box-title">Dates Configuration</h3>
				</div>
				<div class="box-body">
					<div class="row">
						<div class="col-xs-12">
						
<c:set var="endDate" value="${documentEndDate}"/> 
<c:set var="startDate" value="${documentStartDate}"/>
	
	<div class="row">
	<div class="col-xs-3">
	        <spring:message code="lbl_document_start_date" /> :
	</div>
    <div class="col-xs-3">
    ${documentStartDate}
    </div>
    <div class="col-xs-3">
        <spring:message code="lbl_document_end_date" /> :
    </div>
    <div class="col-xs-3">
    ${documentEndDate}
    </div>
	</div>
	
    <div class="row">
    
    	<div class="col-xs-3">
            <spring:message code="lbl_bid_submission_start_date" /> :
    	</div>
    	<div class="col-xs-3">${submissionStartDate}</div>
    	<div class="col-xs-3">
        <spring:message code="lbl_bid_submission_end_date" /> :
    	</div>
    	<div class="col-xs-3">
    	${submissionEndDate}
    	</div>
    </div>
    
    <div class="row">
         	<div class="col-xs-3">
        <spring:message code="field_bidopeningstartdate" /> :
    	</div>
    	<div class="col-xs-3">
    	${openingDate}
    	</div>
    	<c:if test="${tblTender.isPreBidMeeting eq 1}">
        	<div class="col-xs-3">
            <spring:message code="fields_prebidmeet_startdate" /> :
    	</div>
    	<div class="col-xs-3">
    	${preBidStartDate}
    	</div>
    	</c:if>
    </div>
    
    <div class="row">
    <c:if test="${tblTender.isPreBidMeeting eq 1}">
    <div class="col-xs-3">
            <spring:message code="fields_prebidmeet_enddate" /> :
    	</div>
    	<div class="col-xs-3">
    	${preBidEndDate}
    	</div>
    	<div class="col-xs-3"></div>
    	<div class="col-xs-3"></div>
    </c:if>
    </div>
            
    <%-- <div class="row">
    <c:if test="${cntTd eq 0}">
    <c:set var="cntTd" value="0"/>  
</c:if>
<c:if test="${cntTd eq 2}">
<c:set var="cntTd" value="0"/>  
</c:if>
<c:if test="${cntTd eq 1}">   
    <c:set var="cntTd" value="0"/>  
</c:if>
    </div>     --%>    
  
						</div>
					</div>
				</div>
			</div>
		         </div>
		</div>
</c:if>
		
<c:if test="${tblTender.cstatus eq 1}">
		<div class="row">
			<div class="col-xs-12">
				<div class="box">
				<div class="box-header with-border">
					<h3 class="box-title"><spring:message code="title_tender_th_viewcorrigendum"/></h3>
				</div>
				<div class="box-body">
					<div class="row">
						<div class="col-xs-12">
							<div id="corrigendumDiv"></div>
						</div>
					</div>
				</div>
			</div>
		   </div>
		</div>
</c:if>
		<div class="row">
			<div class="col-xs-12">
				<div class="box">
				<div class="box-header with-border">
					<h3 class="box-title">Tender Document</h3>
				</div>
				<div class="box-body">
					<div class="row">
						<div class="col-xs-12">
							<div id="documentList"></div>
						</div>
					</div>
				</div>
			</div>
		         </div>
		</div>

 <c:if test="${1 ne fromPublishTender}">
	<div class="">
			<input type="button" class="btn noExport" onclick="exportContent('viewTenderId','ViewTender_${tblTender.tenderId}',0)" value="PDF">
			<input type="button" class="btn noExport" onclick="exportContent('viewTenderId','ViewTender_${tblTender.tenderId}',5)" value="Print">
	</div>
</c:if>
</section></div>
    </div>
<script type="text/javascript">
	$(document).ready(function(){
	<c:if test="${tblTender.cstatus eq 1}"> /*  because now we always show document and corrigendum */
		$.ajax({
			url : "${pageContext.servletContext.contextPath}/etender/buyer/viewcorrigendum/${tblTender.tenderId}/1",
			success : function(data) {
				$("#corrigendumDiv").html(data);
				$("#corrigendumDiv").find(".content-wrapper").css('min-height','');
				$("#corrigendumDiv").find(".content-wrapper").removeClass("content-wrapper");
				$("#corrigendumDiv").find(".content-header").removeClass("content-header");
			}
		});	
	</c:if>
	$.ajax({
		url : "${pageContext.servletContext.contextPath}/etender/buyer/getDocumentList/${tblTender.tenderId}/${tenderNITObjectId}/${tblTender.tenderId}/0/0",
		success : function(data) {
			$("#documentDiv").show();
			$("#documentList").html(data);
		}
	});	
   }); 
</script>

<c:if test="${2 eq fromPublishTender}"><%-- for before login --%>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/_all-skins.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/template1/css/style.css">
</c:if>

<c:if test="${fromPublishTender eq 2}">
 <script>
   var contextPath = "${pageContext.servletContext.contextPath}";
   var sessionUserId= 0;
   var CLIENT_DATE_FORMATE='<spring:message code="client_dateformate_hhmm" />';
   var CLIENT_DATE_FORMATE_WHM='<spring:message code="client_dateformate" />';
   var VALIDATE_MSG_INVALID_PASSWORD = "<spring:message code="password_validation_msg" />"
 </script>
    <script src="${pageContext.servletContext.contextPath}/resources/js/headerscript.js"></script>
	<script src="${pageContext.servletContext.contextPath}/resources/js/jquery-ui.min.js"></script>
</c:if>
 <style>
  .black{
  	color: black;
  	font-style: oblique;
  }
  </style>
  <c:if test="${1 ne fromPublishTender && 2 ne fromPublishTender}">
	<%@include file="../../includes/footer.jsp"%>
	</c:if>