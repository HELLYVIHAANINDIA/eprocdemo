package com.eprocurement.etender.model;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;


@Entity
@Table(name="tbl_tender")
public class TblTender  implements java.io.Serializable {

        private   int assignUserId;
        private   int biddingType;
        private   int biddingVariant;
        private   int brdMode;
        private   int corrigendumCount;
        private   int createdBy;
        private   Date createdOn;
        private   int createRfxFromEvent;
        private   int cstatus;
        private   int currencyId;
        private   int decimalValueUpto;
        private   String docFeePaymentAddress;
        private   int docFeePaymentMode=2;//default offline
        private   Date documentEndDate;
        private   String documentFee;
        private   Date documentStartDate;
        private   String documentSubmission;
        private   int downloadDocument=2;
        private   String emdAmount;
        private   String emdPaymentAddress;
        private   int emdPaymentMode=2; // default offline
        private   int encryptionLevel;
        private   int envelopeType;
        private   int evaluationMode;
        private   int forHomePage;
        private   int isBidWithdrawal;
        private   int isCertRequired;
        private   int isConsortiumAllowed=0;
        private   int isFormBasedConsortium=0;
        private   int isCreateAuction;
        private   int isDemoTender;
        private   int isDisplayClarificationDoc;
        private   int isDocfeesApplicable;
        private   int isDocumentFeeByBidder;
        private   int isParticipationFeesBy;
        private   int isEMDApplicable;
        private   int isEMDByBidder;
        private   int isEncDocumentOnly;
        private   int isEncodedName;
        private   int isEvaluationByCommittee;
        private   int isEvaluationRequired;
        private   int isFinalPriceSheetReq;
        private   int isFormConfirmationReq;
        private   int isItemSelectionPageRequired;
        private   int isItemwiseWinner;
        private   int isMandatoryDocument;
        private   int isNegotiationAllowed;
        private   int isOpeningByCommittee;
        private   int isPartialFillingAllowed;
        private   int isPastEvent;
        private   int isPreBidMeeting;
        private   int isProcessingFeeByBidder;
        private   int isProxyBid;
        private   int isQuestionAnswer;
        private   int isRebateForm;
        private   int isRebateApplicable;
        private   int isReEvaluationReq;
        private   int isRegistrationCharges;
        private   int isRevisePriceBid;
        private   int isReworkRequired;
        private   int isSecurityfeesApplicable;
        private   int isSORApplicable;
        private   int isSplitPOAllowed;
        private   int isSystemGeneratedTenderDoc;
        private   int isTwoStageEvaluation;
        private   int isTwoStageOpening;
        private   int isWorkflowRequired;
        private   String keywordText;
        private   int multiLevelEvaluationReq;
        private   int officerId;
        private   Date openingDate;
        private   String otherProcurementNature;
        private   int procurementNatureId;
        private   String preBidAddress;
        private   Date preBidEndDate;
        private   int preBidMode=2;
        private   Date preBidStartDate;
        private   BigDecimal prevEstimatedValue;
        private   String projectDuration;
        private   int publishedBy;
        private   Date publishedOn;
        private   Date questionAnswerEndDate;
        private   Date questionAnswerStartDate;
        private   String registrationCharges;
        private   int registrationChargesMode;
        private   String remark;
        private   String secFeePaymentAddress;
        private   int secFeePaymentMode=2; //default offline
        private   String securityFee;
        private   int showBidderWiseForm;
        private   int showBidDetail;
        private   int showNoOfBidders;
        private   int showResultOnHomePage;
        private   BigDecimal sorVariation;
        private   Date submissionEndDate;
        private   int submissionMode;
        private   Date submissionStartDate;
        private   String tenderBrief;
        private   String tenderDetail;
        private   Integer tenderId;
        private   int tenderMode;
        private   String tenderNo;
        private   int tenderResult;
        private   BigDecimal tenderValue;
        private   int updatedBy;
        private   Date updatedOn;
        private   String validityPeriod;
        private   int winningReportMode;
        private   int workflowTypeId=0;
        private   int isCentralizedTECRequired;
        private   int isCentralizedTOCRequired;
        private   int POType;
        private   String prequalification;
        private   int formContract;
        private   int productId;
        private   int tenderSector;
        private   int isWeightageEvaluationRequired;
        private   int workflowForBidOpening;
        private   int workflowForNegotiation;
        private   int decryptorRequired;
        private   int isEMDdoneByTOC;
        private   int workflowForTEC;
        private   int workflowForTOC;
        private   int isRestOfEventMoney;
        private   int departmentId;
        private int eventTypeId;
        private int autoResultSharing;
        private String cancelRemarks;
        private Date cancelDate;
        private Integer cancelBy;
        private int copyFrom;
        private int isEvaluationDone;
        private int participationFees;
        private String productLocation;
        private int contractTypeId;
        private int biddingAccess;
        private int auctionMethod;
        private int bidSubmissionfor;
        private int startPrice;
        private int auctionReservePrice;
        private int incrementDecrementValues;
        private Date auctionStartDate;
        private Date auctionEndDate;
        private int allowsAutoExtension;
        private int autoExtensionMode;
        private int extendTimeWhen;
        private int extendTimeBy;
        private int noOfExtension;
      
        private int displayIPAddress;
        private float estimatedValue;
        private int EMDRequired;
        private int EMDFees;
        private int isAuction;
        private int isAuctionStop;
        private   String randPass;
        private int isAcceptStartPrice;
        private int isReservePriceConfigure;
        private int isCreateNewForm;
        private int isBidConverted;
        private String participationFeesPaymentAddress;
        
        @Column(name="participationFeesPaymentAddress")
        public String getparticipationFeesPaymentAddress(){
        return this.participationFeesPaymentAddress;
        }
        
        public void setparticipationFeesPaymentAddress(String participationFeesPaymentAddress){
        this.participationFeesPaymentAddress=participationFeesPaymentAddress;
        }
        @Column(name="isBidConverted")
        public int getisBidConverted()
        {
            return this.isBidConverted;
        }
        public void setisBidConverted(int isBidConverted)
        {
            this.isBidConverted=isBidConverted;
        }
        @Column(name="isCreateNewForm",nullable=true)
        public int getisCreateNewForm()
        {
        return this.isCreateNewForm;
        }
        public void setisCreateNewForm(int isCreateNewForm){
        this.isCreateNewForm=isCreateNewForm;
        }
        
        @Column(name="isReservePriceConfigure",nullable=true)
        public int getisReservePriceConfigure()
        {
            return isReservePriceConfigure;
        }
        public void setisReservePriceConfigure(int isReservePriceConfigure)
        {
            this.isReservePriceConfigure=isReservePriceConfigure;
        }
        
        @Column(name="isAcceptStartPrice",nullable=true)
        public int getisAcceptStartPrice()
        {
            return isAcceptStartPrice;
        }
        public void setisAcceptStartPrice(int isAcceptStartPrice)
        {
            this.isAcceptStartPrice=isAcceptStartPrice;
        }
        
        
        
        @Column(name="randPass",nullable=true)
        public String getRandPass() {
			return randPass;
		}
		public void setRandPass(String randPass) {
			this.randPass = randPass;
		}
		@Column(name="isAuctionStop")
        public int getIsAuctionStop()
        {
            return isAuctionStop;
        }
        public void setIsAuctionStop(int isAuctionStop)
        {
            this.isAuctionStop=isAuctionStop;
        }
        @Column(name="participationFees")
        public int getParticipationFees()
        {
           return participationFees; 
        }
        public void setParticipationFees(int participationFees)
        {
            this.participationFees=participationFees;
        }
        @Column(name="productLocation")
        public String getProductLocation()
        {
            return productLocation;
        }
        public void setProductLocation(String productLocation)
        {
            this.productLocation=productLocation;
        }
        @Column(name="isAuction")
        public int getisAuction()
        {
            return isAuction;
        }
        public void setisAuction(int isAuction)
        {
            this.isAuction=isAuction;
        }
        @Column(name="EMDFees")
        public int getEMDFees()
        {
            return EMDFees;
        }
        public void setEMDFees(int EMDFees)
        {
            this.EMDFees=EMDFees;
        }
        @Column(name="EMDRequired")
        public int getEMDRequired()
        {
            return EMDRequired;
        }
        public void setEMDRequired(int EMDRequired)
        {
            this.EMDRequired=EMDRequired;
        }
        @Column(name="estimatedValue")
        public float getestimatedValue()
        {
            return estimatedValue;
        }
        public void setestimatedValue(float estimatedValue)
        {
            this.estimatedValue=estimatedValue;
        }
        @Column(name="displayIPAddress")
        public int getdisplayIPAddress()
        {
            return displayIPAddress;
        }
        public void setdisplayIPAddress(int displayIPAddress)
        {
            this.displayIPAddress=displayIPAddress;
        }
        
        @Column(name="NoOfExtension")
        public int getNoOfExtension()
        {
            return noOfExtension;
        }
        public void setNoOfExtension(int NoOfExtension)
        {
            this.noOfExtension=NoOfExtension;
        }
        @Column(name="extendTimeBy")
        public int getextendTimeBy()
        {
            return extendTimeBy;
        }
        public void setextendTimeBy(int extendTimeBy)
        {
            this.extendTimeBy=extendTimeBy;
        }
        @Column(name="extendTimeWhen")
        public int getextendTimeWhen()
        {
            return extendTimeWhen;
        }
        public void setextendTimeWhen(int extendTimeWhen)
        {
            this.extendTimeWhen=extendTimeWhen;
        }
        @Column(name="autoExtensionMode")
        public int getautoExtensionMode()
        {
            return autoExtensionMode;
        }
        public void setautoExtensionMode(int autoExtensionMode)
        {
            this.autoExtensionMode=autoExtensionMode;
        }
        @Column(name="allowsAutoExtension")
        public int getallowsAutoExtension()
        {
            return allowsAutoExtension;
        }
        public void setallowsAutoExtension(int allowsAutoExtension)
        {
            this.allowsAutoExtension=allowsAutoExtension;
        }
        @Column(name="AuctionStartDate",nullable=true)
        public Date getAuctionStartDate()
        {
            return this.auctionStartDate;
        }
        public void setAuctionStartDate(Date AuctionStartDate)
        {
            this.auctionStartDate=AuctionStartDate;
        }
        @Column(name="AuctionEndDate",nullable=true)
        public Date getAuctionEndDate()
        {
            return this.auctionEndDate;
        }
        public void setAuctionEndDate(Date AuctionEndDate)
        {
            this.auctionEndDate=AuctionEndDate;
        }
        @Column(name="incrementDecrementValues")
        public int getincrementDecrementValues()
        {
            return incrementDecrementValues;
        }
        public void setincrementDecrementValues(int incrementDecrementValues)
        {
            this.incrementDecrementValues=incrementDecrementValues;
        }
        @Column(name="auctionReservePrice")
        public int getauctionReservePrice()
        {
            return auctionReservePrice;
        }
        public void setauctionReservePrice(int auctionReservePrice)
        {
            this.auctionReservePrice=auctionReservePrice;
        }
        @Column(name="startPrice")
        public int getstartPrice()
        {
            return startPrice;
        }
        public void setstartPrice(int startPrice)
        {
            this.startPrice=startPrice;
        }
        @Column(name="bidSubmissionfor")
        public int getbidSubmissionfor()
        {
            return bidSubmissionfor;
        }
        public void setbidSubmissionfor(int bidSubmissionfor)
        {
            this.bidSubmissionfor=bidSubmissionfor;
        }
        @Column(name="auctionMethod")
        public int getauctionMethod()
        {
            return auctionMethod;
        }
        public void setauctionMethod(int auctionMethod)
        {
            this.auctionMethod=auctionMethod;
        }
        @Column(name="biddingAccess")
        public int getbiddingAccess()
        {
            return biddingAccess;
        }
        public void setbiddingAccess(int biddingAccess)
        {
            this.biddingAccess=biddingAccess;
        }
        @Column(name="contractTypeId")
        public int getContractTypeId()
        {
            return contractTypeId;
        }
        public void setContractTypeId(int contractTypeId)
        {
            this.contractTypeId=contractTypeId;
        }
        @Column(name="isEvaluationDone")
        public int getIsEvaluationDone() {
			return isEvaluationDone;
		}

		public void setIsEvaluationDone(int isEvaluationDone) {
			this.isEvaluationDone = isEvaluationDone;
		}

		@Column(name="copyFrom")
        public int getCopyFrom() {
			return copyFrom;
		}

		public void setCopyFrom(int copyFrom) {
			this.copyFrom = copyFrom;
		}

		@Column(name="cancelRemarks")
		public String getCancelRemarks() {
			return cancelRemarks;
		}

		public void setCancelRemarks(String cancelRemarks) {
			this.cancelRemarks = cancelRemarks;
		}

		@Column(name="cancelDate")
		public Date getCancelDate() {
			return cancelDate;
		}

		public void setCancelDate(Date cancelDate) {
			this.cancelDate = cancelDate;
		}
		
		@Column(name="cancelBy")
		public Integer getCancelBy() {
			return cancelBy;
		}

		public void setCancelBy(Integer cancelBy) {
			this.cancelBy = cancelBy;
		}

		@Column(name="autoResultSharing",nullable=false)
		public int getAutoResultSharing() {
			return autoResultSharing;
		}

		public void setAutoResultSharing(int autoResultSharing) {
			this.autoResultSharing = autoResultSharing;
		}

		@Column(name="procurementNatureId",nullable=false)
		public int getProcurementNatureId() {
			return procurementNatureId;
		}

		public void setProcurementNatureId(int procurementNatureId) {
			this.procurementNatureId = procurementNatureId;
		}

		@Column(name="eventTypeId",nullable=false)
        public int getEventTypeId() {
			return eventTypeId;
		}

		public void setEventTypeId(int eventTypeId) {
			this.eventTypeId = eventTypeId;
		}

		@Column(name="departmentId",nullable=false)
		public int getDepartmentId() {
			return departmentId;
		}

		public void setDepartmentId(int departmentId) {
			this.departmentId = departmentId;
		}

		@Column(name="POType",nullable=false)
        public int getPOType() {
            return this.POType;
        }

        public void setPOType(int pOType) {
            this.POType = pOType;
        } 
        
        @Column(name="isRestOfEventMoney")
        public int getIsRestOfEventMoney() {
			return isRestOfEventMoney;
		}

		public void setIsRestOfEventMoney(int isRestOfEventMoney) {
			this.isRestOfEventMoney = isRestOfEventMoney;
		}
        
        @Column(name="isCentralizedTECRequired",nullable=false)
        public int getIsCentralizedTECRequired() {
            return this.isCentralizedTECRequired;
        }

        public void setIsCentralizedTECRequired(int isCentralizedTECRequired) {
            this.isCentralizedTECRequired = isCentralizedTECRequired;
        }
        @Column(name="isCentralizedTOCRequired",nullable=false)
        public int getIsCentralizedTOCRequired() {
            return this.isCentralizedTOCRequired;
        }

        public void setIsCentralizedTOCRequired(int isCentralizedTOCRequired) {
            this.isCentralizedTOCRequired = isCentralizedTOCRequired;
        }

        private Set<TblCommittee> tblCommittee = new HashSet<TblCommittee>();
        @OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="tblTender")
        public Set<TblCommittee> getTblCommittee()
        {
            return tblCommittee;
        }
        public void setTblCommittee(Set<TblCommittee> tblCommittee)
        {
            this.tblCommittee = tblCommittee;
        }
        @Column(name="assignUserId",nullable=false)
        public int getAssignUserId() {
            return this.assignUserId;
        }

        public void setAssignUserId(int assignUserId) {
            this.assignUserId = assignUserId;
        }
        @Column(name="biddingType",nullable=false)
        public int getBiddingType() {
            return this.biddingType;
        }

        public void setBiddingType(int biddingType) {
            this.biddingType = biddingType;
        }
        @Column(name="biddingVariant",nullable=false)
        public int getBiddingVariant() {
            return this.biddingVariant;
        }

        public void setBiddingVariant(int biddingVariant) {
            this.biddingVariant = biddingVariant;
        }
        @Column(name="brdMode",nullable=false)
        public int getBrdMode() {
            return this.brdMode;
        }

        public void setBrdMode(int brdMode) {
            this.brdMode = brdMode;
        }
        @Column(name="corrigendumCount",nullable=false)
        public int getCorrigendumCount() {
            return this.corrigendumCount;
        }

        public void setCorrigendumCount(int corrigendumCount) {
            this.corrigendumCount = corrigendumCount;
        }
        @Column(name="createdBy",nullable=false)
        public int getCreatedBy() {
            return this.createdBy;
        }

        public void setCreatedBy(int createdBy) {
            this.createdBy = createdBy;
        }
        @Column(name="createdOn",nullable=false,updatable=false,insertable=false)
        public Date getCreatedOn() {
            return this.createdOn;
        }

        public void setCreatedOn(Date createdOn) {
            this.createdOn = createdOn;
        }
        @Column(name="createRfxFromEvent",nullable=false)
        public int getCreateRfxFromEvent() {
            return this.createRfxFromEvent;
        }

        public void setCreateRfxFromEvent(int createRfxFromEvent) {
            this.createRfxFromEvent = createRfxFromEvent;
        }
        @Column(name="cstatus",nullable=false)
        public int getCstatus() {
            return this.cstatus;
        }

        public void setCstatus(int cstatus) {
            this.cstatus = cstatus;
        }
        @Column(name="currencyId",nullable=false)
        public int getCurrencyId() {
            return this.currencyId;
        }

        public void setCurrencyId(int currencyId) {
            this.currencyId = currencyId;
        }
        @Column(name="decimalValueUpto",nullable=false)
        public int getDecimalValueUpto() {
            return this.decimalValueUpto;
        }

        public void setDecimalValueUpto(int decimalValueUpto) {
            this.decimalValueUpto = decimalValueUpto;
        }
        @Column(name="docFeePaymentAddress",nullable=true, length=2000)
        public String getDocFeePaymentAddress() {
            return this.docFeePaymentAddress;
        }

        public void setDocFeePaymentAddress(String docFeePaymentAddress) {
            this.docFeePaymentAddress = docFeePaymentAddress;
        }
        @Column(name="docFeePaymentMode",nullable=false)
        public int getDocFeePaymentMode() {
            return this.docFeePaymentMode;
        }

        public void setDocFeePaymentMode(int docFeePaymentMode) {
            this.docFeePaymentMode = docFeePaymentMode;
        }
        @Column(name="documentEndDate",nullable=true)
        public Date getDocumentEndDate() {
            return this.documentEndDate;
        }

        public void setDocumentEndDate(Date documentEndDate) {
            this.documentEndDate = documentEndDate;
        }
        @Column(name="documentFee",nullable=true, length= 50)
        public String getDocumentFee() {
            return this.documentFee;
        }

        public void setDocumentFee(String documentFee) {
            this.documentFee = documentFee;
        }
        @Column(name="documentStartDate",nullable=true)
        public Date getDocumentStartDate() {
            return this.documentStartDate;
        }

        public void setDocumentStartDate(Date documentStartDate) {
            this.documentStartDate = documentStartDate;
        }
        @Column(name="documentSubmission",nullable=true, length=2000)
        public String getDocumentSubmission() {
            return this.documentSubmission;
        }

        public void setDocumentSubmission(String documentSubmission) {
            this.documentSubmission = documentSubmission;
        }
        @Column(name="downloadDocument",nullable=false)
        public int getDownloadDocument() {
            return this.downloadDocument;
        }

        public void setDownloadDocument(int downloadDocument) {
            this.downloadDocument = downloadDocument;
        }
        @Column(name="emdAmount",nullable=true, length= 50)
        public String getEmdAmount() {
            return this.emdAmount;
        }

        public void setEmdAmount(String emdAmount) {
            this.emdAmount = emdAmount;
        }
        @Column(name="emdPaymentAddress",nullable=true, length=2000)
        public String getEmdPaymentAddress() {
            return this.emdPaymentAddress;
        }

        public void setEmdPaymentAddress(String emdPaymentAddress) {
            this.emdPaymentAddress = emdPaymentAddress;
        }
        @Column(name="emdPaymentMode",nullable=false)
        public int getEmdPaymentMode() {
            return this.emdPaymentMode;
        }

        public void setEmdPaymentMode(int emdPaymentMode) {
            this.emdPaymentMode = emdPaymentMode;
        }
        @Column(name="encryptionLevel",nullable=false)
        public int getEncryptionLevel() {
            return this.encryptionLevel;
        }

        public void setEncryptionLevel(int encryptionLevel) {
            this.encryptionLevel = encryptionLevel;
        }
        @Column(name="envelopeType",nullable=false)
        public int getEnvelopeType() {
            return this.envelopeType;
        }

        public void setEnvelopeType(int envelopeType) {
            this.envelopeType = envelopeType;
        }
        @Column(name="evaluationMode",nullable=false)
        public int getEvaluationMode() {
            return this.evaluationMode;
        }

        public void setEvaluationMode(int evaluationMode) {
            this.evaluationMode = evaluationMode;
        }
        @Column(name="forHomePage",nullable=false)
        public int getForHomePage() {
            return this.forHomePage;
        }

        public void setForHomePage(int forHomePage) {
            this.forHomePage = forHomePage;
        }
        @Column(name="isBidWithdrawal",nullable=false)
        public int getIsBidWithdrawal() {
            return this.isBidWithdrawal;
        }

        public void setIsBidWithdrawal(int isBidWithdrawal) {
            this.isBidWithdrawal = isBidWithdrawal;
        }
        @Column(name="isCertRequired",nullable=false)
        public int getIsCertRequired() {
            return this.isCertRequired;
        }

        public void setIsCertRequired(int isCertRequired) {
            this.isCertRequired = isCertRequired;
        }
        @Column(name="isConsortiumAllowed",nullable=false)
        public int getIsConsortiumAllowed() {
            return this.isConsortiumAllowed;
        }

        public void setIsConsortiumAllowed(int isConsortiumAllowed) {
            this.isConsortiumAllowed = isConsortiumAllowed;
        }
        
        @Column(name="isFormBasedConsortium")
        public int getIsFormBasedConsortium() {
			return isFormBasedConsortium;
		}

		public void setIsFormBasedConsortium(int isFormBasedConsortium) {
			this.isFormBasedConsortium = isFormBasedConsortium;
		}

		@Column(name="isCreateAuction",nullable=false)
        public int getIsCreateAuction() {
            return this.isCreateAuction;
        }

        public void setIsCreateAuction(int isCreateAuction) {
            this.isCreateAuction = isCreateAuction;
        }
        @Column(name="isDemoTender",nullable=false)
        public int getIsDemoTender() {
            return this.isDemoTender;
        }

        public void setIsDemoTender(int isDemoTender) {
            this.isDemoTender = isDemoTender;
        }
        @Column(name="isDisplayClarificationDoc",nullable=false)
        public int getIsDisplayClarificationDoc() {
            return this.isDisplayClarificationDoc;
        }

        public void setIsDisplayClarificationDoc(int isDisplayClarificationDoc) {
            this.isDisplayClarificationDoc = isDisplayClarificationDoc;
        }
        @Column(name="isDocfeesApplicable",nullable=false)
        public int getIsDocfeesApplicable() {
            return this.isDocfeesApplicable;
        }

        public void setIsDocfeesApplicable(int isDocfeesApplicable) {
            this.isDocfeesApplicable = isDocfeesApplicable;
        }
        @Column(name="isDocumentFeeByBidder",nullable=false)
        public int getIsDocumentFeeByBidder() {
            return this.isDocumentFeeByBidder;
        }

        public void setIsDocumentFeeByBidder(int isDocumentFeeByBidder) {
            this.isDocumentFeeByBidder = isDocumentFeeByBidder;
        }
        
        @Column(name="isParticipationFeesBy",nullable=false)
        public int getIsParticipationFeesBy() {
            return this.isParticipationFeesBy;
        }

        public void setIsParticipationFeesBy(int isParticipationFeesBy) {
            this.isParticipationFeesBy = isParticipationFeesBy;
        }
              
        @Column(name="isEMDApplicable",nullable=false)
        public int getIsEMDApplicable() {
            return this.isEMDApplicable;
        }

        public void setIsEMDApplicable(int isEMDApplicable) {
            this.isEMDApplicable = isEMDApplicable;
        }
        @Column(name="isEMDByBidder",nullable=false)
        public int getIsEMDByBidder() {
            return this.isEMDByBidder;
        }

        public void setIsEMDByBidder(int isEMDByBidder) {
            this.isEMDByBidder = isEMDByBidder;
        }
        @Column(name="isEncDocumentOnly",nullable=false)
        public int getIsEncDocumentOnly() {
            return this.isEncDocumentOnly;
        }

        public void setIsEncDocumentOnly(int isEncDocumentOnly) {
            this.isEncDocumentOnly = isEncDocumentOnly;
        }
        @Column(name="isEncodedName",nullable=false)
        public int getIsEncodedName() {
            return this.isEncodedName;
        }

        public void setIsEncodedName(int isEncodedName) {
            this.isEncodedName = isEncodedName;
        }
        @Column(name="isEvaluationByCommittee",nullable=false)
        public int getIsEvaluationByCommittee() {
            return this.isEvaluationByCommittee;
        }

        public void setIsEvaluationByCommittee(int isEvaluationByCommittee) {
            this.isEvaluationByCommittee = isEvaluationByCommittee;
        }
        @Column(name="isEvaluationRequired",nullable=false)
        public int getIsEvaluationRequired() {
            return this.isEvaluationRequired;
        }

        public void setIsEvaluationRequired(int isEvaluationRequired) {
            this.isEvaluationRequired = isEvaluationRequired;
        }
        @Column(name="isFinalPriceSheetReq",nullable=false)
        public int getIsFinalPriceSheetReq() {
            return this.isFinalPriceSheetReq;
        }

        public void setIsFinalPriceSheetReq(int isFinalPriceSheetReq) {
            this.isFinalPriceSheetReq = isFinalPriceSheetReq;
        }
        @Column(name="isFormConfirmationReq",nullable=false)
        public int getIsFormConfirmationReq() {
            return this.isFormConfirmationReq;
        }

        public void setIsFormConfirmationReq(int isFormConfirmationReq) {
            this.isFormConfirmationReq = isFormConfirmationReq;
        }
        @Column(name="isItemSelectionPageRequired",nullable=false)
        public int getIsItemSelectionPageRequired() {
            return this.isItemSelectionPageRequired;
        }

        public void setIsItemSelectionPageRequired(int isItemSelectionPageRequired) {
            this.isItemSelectionPageRequired = isItemSelectionPageRequired;
        }
        @Column(name="isItemwiseWinner",nullable=false)
        public int getIsItemwiseWinner() {
            return this.isItemwiseWinner;
        }

        public void setIsItemwiseWinner(int isItemwiseWinner) {
            this.isItemwiseWinner = isItemwiseWinner;
        }
        @Column(name="isMandatoryDocument",nullable=false)
        public int getIsMandatoryDocument() {
            return this.isMandatoryDocument;
        }

        public void setIsMandatoryDocument(int isMandatoryDocument) {
            this.isMandatoryDocument = isMandatoryDocument;
        }
        @Column(name="isNegotiationAllowed",nullable=false)
        public int getIsNegotiationAllowed() {
            return this.isNegotiationAllowed;
        }

        public void setIsNegotiationAllowed(int isNegotiationAllowed) {
            this.isNegotiationAllowed = isNegotiationAllowed;
        }
        @Column(name="isOpeningByCommittee",nullable=false)
        public int getIsOpeningByCommittee() {
            return this.isOpeningByCommittee;
        }

        public void setIsOpeningByCommittee(int isOpeningByCommittee) {
            this.isOpeningByCommittee = isOpeningByCommittee;
        }
        @Column(name="isPartialFillingAllowed",nullable=false)
        public int getIsPartialFillingAllowed() {
            return this.isPartialFillingAllowed;
        }

        public void setIsPartialFillingAllowed(int isPartialFillingAllowed) {
            this.isPartialFillingAllowed = isPartialFillingAllowed;
        }
        @Column(name="isPastEvent",nullable=false)
        public int getIsPastEvent() {
            return this.isPastEvent;
        }

        public void setIsPastEvent(int isPastEvent) {
            this.isPastEvent = isPastEvent;
        }
        @Column(name="isPreBidMeeting",nullable=false)
        public int getIsPreBidMeeting() {
            return this.isPreBidMeeting;
        }

        public void setIsPreBidMeeting(int isPreBidMeeting) {
            this.isPreBidMeeting = isPreBidMeeting;
        }
        @Column(name="isProcessingFeeByBidder",nullable=false)
        public int getIsProcessingFeeByBidder() {
            return this.isProcessingFeeByBidder;
        }

        public void setIsProcessingFeeByBidder(int isProcessingFeeByBidder) {
            this.isProcessingFeeByBidder = isProcessingFeeByBidder;
        }
        @Column(name="isProxyBid",nullable=false)
        public int getIsProxyBid() {
            return this.isProxyBid;
        }

        public void setIsProxyBid(int isProxyBid) {
            this.isProxyBid = isProxyBid;
        }
        @Column(name="isQuestionAnswer",nullable=false)
        public int getIsQuestionAnswer() {
            return this.isQuestionAnswer;
        }

        public void setIsQuestionAnswer(int isQuestionAnswer) {
            this.isQuestionAnswer = isQuestionAnswer;
        }
        @Column(name="isRebateForm",nullable=false)
        public int getIsRebateForm() {
            return this.isRebateForm;
        }

        public void setIsRebateForm(int isRebateForm) {
            this.isRebateForm = isRebateForm;
        }
        
        @Column(name="isRebateApplicable",nullable=false)
        public int getIsRebateApplicable() {
			return isRebateApplicable;
		}

		public void setIsRebateApplicable(int isRebateApplicable) {
			this.isRebateApplicable = isRebateApplicable;
		}

		@Column(name="isReEvaluationReq",nullable=false)
        public int getIsReEvaluationReq() {
            return this.isReEvaluationReq;
        }

        public void setIsReEvaluationReq(int isReEvaluationReq) {
            this.isReEvaluationReq = isReEvaluationReq;
        }
        @Column(name="isRegistrationCharges",nullable=false)
        public int getIsRegistrationCharges() {
            return this.isRegistrationCharges;
        }

        public void setIsRegistrationCharges(int isRegistrationCharges) {
            this.isRegistrationCharges = isRegistrationCharges;
        }
        @Column(name="isRevisePriceBid",nullable=false)
        public int getIsRevisePriceBid() {
            return this.isRevisePriceBid;
        }

        public void setIsRevisePriceBid(int isRevisePriceBid) {
            this.isRevisePriceBid = isRevisePriceBid;
        }
        @Column(name="isReworkRequired",nullable=false)
        public int getIsReworkRequired() {
            return this.isReworkRequired;
        }

        public void setIsReworkRequired(int isReworkRequired) {
            this.isReworkRequired = isReworkRequired;
        }
        @Column(name="isSecurityfeesApplicable",nullable=false)
        public int getIsSecurityfeesApplicable() {
            return this.isSecurityfeesApplicable;
        }

        public void setIsSecurityfeesApplicable(int isSecurityfeesApplicable) {
            this.isSecurityfeesApplicable = isSecurityfeesApplicable;
        }
        @Column(name="isSORApplicable",nullable=false)
        public int getIsSORApplicable() {
            return this.isSORApplicable;
        }

        public void setIsSORApplicable(int isSORApplicable) {
            this.isSORApplicable = isSORApplicable;
        }
        @Column(name="isSplitPOAllowed",nullable=false)
        public int getIsSplitPOAllowed() {
            return this.isSplitPOAllowed;
        }

        public void setIsSplitPOAllowed(int isSplitPOAllowed) {
            this.isSplitPOAllowed = isSplitPOAllowed;
        }
        @Column(name="isSystemGeneratedTenderDoc",nullable=false)
        public int getIsSystemGeneratedTenderDoc() {
            return this.isSystemGeneratedTenderDoc;
        }

        public void setIsSystemGeneratedTenderDoc(int isSystemGeneratedTenderDoc) {
            this.isSystemGeneratedTenderDoc = isSystemGeneratedTenderDoc;
        }
        @Column(name="isTwoStageEvaluation",nullable=false)
        public int getIsTwoStageEvaluation() {
            return this.isTwoStageEvaluation;
        }

        public void setIsTwoStageEvaluation(int isTwoStageEvaluation) {
            this.isTwoStageEvaluation = isTwoStageEvaluation;
        }
        @Column(name="isTwoStageOpening",nullable=false)
        public int getIsTwoStageOpening() {
            return this.isTwoStageOpening;
        }

        public void setIsTwoStageOpening(int isTwoStageOpening) {
            this.isTwoStageOpening = isTwoStageOpening;
        }
        @Column(name="isWorkflowRequired",nullable=false)
        public int getIsWorkflowRequired() {
            return this.isWorkflowRequired;
        }

        public void setIsWorkflowRequired(int isWorkflowRequired) {
            this.isWorkflowRequired = isWorkflowRequired;
        }
        @Column(name="keywordText",nullable=true, length=2000)
        public String getKeywordText() {
            return this.keywordText;
        }

        public void setKeywordText(String keywordText) {
            this.keywordText = keywordText;
        }
        @Column(name="multiLevelEvaluationReq",nullable=false)
        public int getMultiLevelEvaluationReq() {
            return this.multiLevelEvaluationReq;
        }

        public void setMultiLevelEvaluationReq(int multiLevelEvaluationReq) {
            this.multiLevelEvaluationReq = multiLevelEvaluationReq;
        }
        @Column(name="officerId",nullable=false)
        public int getOfficerId() {
            return this.officerId;
        }

        public void setOfficerId(int officerId) {
            this.officerId = officerId;
        }
        @Column(name="openingDate",nullable=true)
        public Date getOpeningDate() {
            return this.openingDate;
        }

        public void setOpeningDate(Date openingDate) {
            this.openingDate = openingDate;
        }
        @Column(name="otherProcurementNature",nullable=true, length=50)
        public String getOtherProcurementNature() {
            return this.otherProcurementNature;
        }

        public void setOtherProcurementNature(String otherProcurementNature) {
            this.otherProcurementNature = otherProcurementNature;
        }
        @Column(name="preBidAddress",nullable=true, length=2000)
        public String getPreBidAddress() {
            return this.preBidAddress;
        }

        public void setPreBidAddress(String preBidAddress) {
            this.preBidAddress = preBidAddress;
        }
        @Column(name="preBidEndDate",nullable=true)
        public Date getPreBidEndDate() {
            return this.preBidEndDate;
        }

        public void setPreBidEndDate(Date preBidEndDate) {
            this.preBidEndDate = preBidEndDate;
        }
        @Column(name="preBidMode",nullable=false)
        public int getPreBidMode() {
            return this.preBidMode;
        }

        public void setPreBidMode(int preBidMode) {
            this.preBidMode = preBidMode;
        }
        @Column(name="preBidStartDate",nullable=true)
        public Date getPreBidStartDate() {
            return this.preBidStartDate;
        }

        public void setPreBidStartDate(Date preBidStartDate) {
            this.preBidStartDate = preBidStartDate;
        }
        @Column(name="prevEstimatedValue",nullable=false)
        public BigDecimal getPrevEstimatedValue() {
            return this.prevEstimatedValue==null?BigDecimal.ZERO:this.prevEstimatedValue;
        }

        public void setPrevEstimatedValue(BigDecimal prevEstimatedValue) {
            this.prevEstimatedValue = prevEstimatedValue==null?BigDecimal.ZERO:prevEstimatedValue;
        }
        @Column(name="projectDuration",nullable=true)
        public String getProjectDuration() {
            return this.projectDuration;
        }

        public void setProjectDuration(String projectDuration) {
            this.projectDuration = projectDuration;
        }
        @Column(name="publishedBy",nullable=true)
        public int getPublishedBy() {
            return this.publishedBy;
        }

        public void setPublishedBy(int publishedBy) {
            this.publishedBy = publishedBy;
        }
        @Column(name="publishedOn",nullable=true)
        public Date getPublishedOn() {
            return this.publishedOn;
        }

        public void setPublishedOn(Date publishedOn) {
            this.publishedOn = publishedOn;
        }
        @Column(name="questionAnswerEndDate",nullable=true)
        public Date getQuestionAnswerEndDate() {
            return this.questionAnswerEndDate;
        }

        public void setQuestionAnswerEndDate(Date questionAnswerEndDate) {
            this.questionAnswerEndDate = questionAnswerEndDate;
        }
        @Column(name="questionAnswerStartDate",nullable=true)
        public Date getQuestionAnswerStartDate() {
            return this.questionAnswerStartDate;
        }

        public void setQuestionAnswerStartDate(Date questionAnswerStartDate) {
            this.questionAnswerStartDate = questionAnswerStartDate;
        }
        @Column(name="registrationCharges",nullable=true, length= 50)
        public String getRegistrationCharges() {
            return this.registrationCharges;
        }

        public void setRegistrationCharges(String registrationCharges) {
            this.registrationCharges = registrationCharges;
        }
        @Column(name="registrationChargesMode",nullable=false)
        public int getRegistrationChargesMode() {
            return this.registrationChargesMode;
        }

        public void setRegistrationChargesMode(int registrationChargesMode) {
            this.registrationChargesMode = registrationChargesMode;
        }
        @Column(name="remark",nullable=true, length=2000)
        public String getRemark() {
            return this.remark;
        }

        public void setRemark(String remark) {
            this.remark = remark;
        }
        /*@Column(name="resultSharing",nullable=false)
        public int getResultSharing() {
            return this.resultSharing;
        }

        public void setResultSharing(int resultSharing) {
            this.resultSharing = resultSharing;
        }*/
        @Column(name="secFeePaymentAddress",nullable=true, length=2000)
        public String getSecFeePaymentAddress() {
            return this.secFeePaymentAddress;
        }

        public void setSecFeePaymentAddress(String secFeePaymentAddress) {
            this.secFeePaymentAddress = secFeePaymentAddress;
        }
        @Column(name="secFeePaymentMode",nullable=false)
        public int getSecFeePaymentMode() {
            return this.secFeePaymentMode;
        }

        public void setSecFeePaymentMode(int secFeePaymentMode) {
            this.secFeePaymentMode = secFeePaymentMode;
        }
        @Column(name="securityFee",nullable=true, length= 50)
        public String getSecurityFee() {
            return this.securityFee;
        }

        public void setSecurityFee(String securityFee) {
            this.securityFee = securityFee;
        }
        @Column(name="showBidderWiseForm",nullable=false)
        public int getShowBidderWiseForm() {
            return this.showBidderWiseForm;
        }

        public void setShowBidderWiseForm(int showBidderWiseForm) {
            this.showBidderWiseForm = showBidderWiseForm;
        }
        @Column(name="showBidDetail",nullable=false)
        public int getShowBidDetail() {
            return this.showBidDetail;
        }

        public void setShowBidDetail(int showBidDetail) {
            this.showBidDetail = showBidDetail;
        }
        @Column(name="showNoOfBidders",nullable=false)
        public int getShowNoOfBidders() {
            return this.showNoOfBidders;
        }

        public void setShowNoOfBidders(int showNoOfBidders) {
            this.showNoOfBidders = showNoOfBidders;
        }
        @Column(name="showResultOnHomePage",nullable=false)
        public int getShowResultOnHomePage() {
            return this.showResultOnHomePage;
        }

        public void setShowResultOnHomePage(int showResultOnHomePage) {
            this.showResultOnHomePage = showResultOnHomePage;
        }
        @Column(name="sorVariation",nullable=true)
        public BigDecimal getSorVariation() {
            return this.sorVariation;
        }

        public void setSorVariation(BigDecimal sorVariation) {
            this.sorVariation = sorVariation;
        }
        @Column(name="submissionEndDate",nullable=true)
        public Date getSubmissionEndDate() {
            return this.submissionEndDate;
        }

        public void setSubmissionEndDate(Date submissionEndDate) {
            this.submissionEndDate = submissionEndDate;
        }
        @Column(name="submissionMode",nullable=false)
        public int getSubmissionMode() {
            return this.submissionMode;
        }

        public void setSubmissionMode(int submissionMode) {
            this.submissionMode = submissionMode;
        }
        @Column(name="submissionStartDate",nullable=true)
        public Date getSubmissionStartDate() {
            return this.submissionStartDate;
        } 

        public void setSubmissionStartDate(Date submissionStartDate) {
            this.submissionStartDate = submissionStartDate;
        }

        @Column(name="tenderBrief",nullable=true, length=2000)
        public String getTenderBrief() {
            return this.tenderBrief;
        }

        public void setTenderBrief(String tenderBrief) {
            this.tenderBrief = tenderBrief;
        }
        @Column(name="tenderDetail",nullable=true, length=2000)
        public String getTenderDetail() {
            return this.tenderDetail;
        }

        public void setTenderDetail(String tenderDetail) {
            this.tenderDetail = tenderDetail;
        }
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        @Column(name="tenderId",unique=true,nullable=false)
        public Integer getTenderId() {
            return this.tenderId;
        }

        public void setTenderId(Integer tenderId) {
            this.tenderId = tenderId;
        }
        public TblTender(int tenderId){
            this.tenderId = tenderId;
        }
        @Column(name="tenderMode",nullable=false)
        public int getTenderMode() {
            return this.tenderMode;
        }

        public void setTenderMode(int tenderMode) {
            this.tenderMode = tenderMode;
        }
        @Column(name="tenderNo",nullable=true, length=2000)
        public String getTenderNo() {
            return this.tenderNo;
        }

        public void setTenderNo(String tenderNo) {
            this.tenderNo = tenderNo;
        }
        @Column(name="tenderResult",nullable=false)
        public int getTenderResult() {
            return this.tenderResult;
        }

        public void setTenderResult(int tenderResult) {
            this.tenderResult = tenderResult;
        }
        @Column(name="tenderValue",nullable=false)
        public BigDecimal getTenderValue() {
            return this.tenderValue;
        }

        public void setTenderValue(BigDecimal tenderValue) {
            this.tenderValue = tenderValue;
        }
        @Column(name="updatedBy",nullable=false)
        public int getUpdatedBy() {
            return this.updatedBy;
        }

        public void setUpdatedBy(int updatedBy) {
            this.updatedBy = updatedBy;
        }
        @Column(name="updatedOn",nullable=false)
        public Date getUpdatedOn() {
            return this.updatedOn;
        }

        public void setUpdatedOn(Date updatedOn) {
            this.updatedOn = updatedOn;
        }
        @Column(name="validityPeriod",nullable=true)
        public String getValidityPeriod() {
            return this.validityPeriod;
        }

        public void setValidityPeriod(String validityPeriod) {
            this.validityPeriod = validityPeriod;
        }
        @Column(name="winningReportMode",nullable=false)
        public int getWinningReportMode() {
            return this.winningReportMode;
        }

        public void setWinningReportMode(int winningReportMode) {
            this.winningReportMode = winningReportMode;
        }
        @Column(name="workflowTypeId",nullable=false)
        public int getWorkflowTypeId() {
            return this.workflowTypeId;
        }

        public void setWorkflowTypeId(int workflowTypeId) {
            this.workflowTypeId = workflowTypeId;
        }
        @Column(name="formContract",nullable=false)
        public int getFormContract() {
            return this.formContract;
        }

        public void setFormContract(int formContract) {
            this.formContract = formContract;
        }
        @Column(name="productId")
        public int getProductId() {
            return this.productId;
        }

        public void setProductId(int productId) {
            this.productId = productId;
        }
        @Column(name="tenderSector")
        public int getTenderSector() {
            return this.tenderSector;
        }

        public void setTenderSector(int tenderSector) {
            this.tenderSector = tenderSector;
        }

        @Column(name="prequalification")
        public String getPrequalification() {
            return this.prequalification;
        }

        public void setPrequalification(String prequalification) {
            this.prequalification = prequalification;
        }
        
        @Column(name="isWeightageEvaluationRequired",nullable=false)
        public int getIsWeightageEvaluationRequired() {
            return this.isWeightageEvaluationRequired;
        }

        public void setIsWeightageEvaluationRequired(int isWeightageEvaluationRequired) {
            this.isWeightageEvaluationRequired = isWeightageEvaluationRequired;
        }
        
        
        @Column(name="workflowForBidOpening",nullable=false)
        public int getWorkflowForBidOpening() {
			return workflowForBidOpening;
		}

		public void setWorkflowForBidOpening(int workflowForBidOpening) {
			this.workflowForBidOpening = workflowForBidOpening;
		}
		@Column(name="workflowForNegotiation",nullable=false)
		public int getWorkflowForNegotiation() {
			return workflowForNegotiation;
		}

		public void setWorkflowForNegotiation(int workflowForNegotiation) {
			this.workflowForNegotiation = workflowForNegotiation;
		}

		
		@Column(name="decryptorRequired",nullable=false)
		public int getDecryptorRequired() {
			return decryptorRequired;
		}

		public void setDecryptorRequired(int decryptorRequired) {
			this.decryptorRequired = decryptorRequired;
		}

		 public int getIsEMDdoneByTOC() {
                    return isEMDdoneByTOC;
        }

		public void setIsEMDdoneByTOC(int isEMDdoneByTOC) {
			this.isEMDdoneByTOC = isEMDdoneByTOC;
		}
		@Column(name="workflowForTOC",nullable=true)
	    public int getWorkflowForTOC() {
	        return this.workflowForTOC;
	    }

	    public void setWorkflowForTOC(int workflowForTOC) {
	        this.workflowForTOC = workflowForTOC;
	    }
		
		@Column(name="workflowForTEC",nullable=true)
	    public int getWorkflowForTEC() {
	        return this.workflowForTEC;
	    }

	    public void setWorkflowForTEC(int workflowForTEC) {
	        this.workflowForTEC = workflowForTEC;
	    }       
				
		public TblTender(){
        }
}