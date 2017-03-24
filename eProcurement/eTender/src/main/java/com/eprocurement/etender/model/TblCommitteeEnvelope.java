package com.eprocurement.etender.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.springframework.core.style.ToStringCreator;

@Entity
@Table(name="tbl_committeeenvelope")
public class TblCommitteeEnvelope  implements java.io.Serializable {

        private   int committeeEnvelopeId;
        private   int minMemberApproval;
        private   TblCommittee tblCommittee;
        private   TblTenderEnvelope tblTenderEnvelope;


        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        @Column(name="committeeEnvelopeId",unique=true,nullable=false)
        public int getCommitteeEnvelopeId() {
            return this.committeeEnvelopeId;
        }

        public void setCommitteeEnvelopeId(int committeeEnvelopeId) {
            this.committeeEnvelopeId = committeeEnvelopeId;
        }
        public TblCommitteeEnvelope(int committeeEnvelopeId){
            this.committeeEnvelopeId = committeeEnvelopeId;
        }
        @Column(name="minMemberApproval",nullable=false)
        public int getMinMemberApproval() {
            return this.minMemberApproval;
        }

        public void setMinMemberApproval(int minMemberApproval) {
            this.minMemberApproval = minMemberApproval;
        }
        @ManyToOne(fetch=FetchType.LAZY)
        @JoinColumn(name="committeeid")
        public TblCommittee getTblCommittee() {
            return this.tblCommittee;
        }

        public void setTblCommittee(TblCommittee tblCommittee) {
            this.tblCommittee = tblCommittee;
        }
        @ManyToOne(fetch=FetchType.LAZY)
        @JoinColumn(name="envelopeid")
        public TblTenderEnvelope getTblTenderEnvelope() {
            return this.tblTenderEnvelope;
        }

        public void setTblTenderEnvelope(TblTenderEnvelope tblTenderEnvelope) {
            this.tblTenderEnvelope = tblTenderEnvelope;
        }
        public TblCommitteeEnvelope(){
        }
        @Override
        public String toString() {
		return new ToStringCreator(this).append("committeeEnvelopeId", this.getCommitteeEnvelopeId()).append("minMemberApproval", this.getMinMemberApproval()).toString();
	}
}
