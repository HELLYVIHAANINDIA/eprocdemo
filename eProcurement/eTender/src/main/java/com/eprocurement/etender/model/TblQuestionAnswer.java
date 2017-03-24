
package com.eprocurement.etender.model;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import org.springframework.core.style.ToStringCreator;

@Entity
@Table(name="tbl_questionanswer")
public class TblQuestionAnswer  implements java.io.Serializable {

        private   int questionId;
        private   String question;
        private   String answer;
        private   int isActive;
        private   int questionBy;
        private   Date questionDate;
        private   int answerBy;
        private   Date answerDate;
        private   int eventId;


        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        @Column(name="questionId",unique=true,nullable=false)
        public int getQuestionId() {
            return this.questionId;
        }

        public void setQuestionId(int questionId) {
            this.questionId = questionId;
        }
        public TblQuestionAnswer(int questionId){
            this.questionId = questionId;
        }
        
        
        
        
        @Column(name="question",nullable=false)
        public String getQuestion() {
			return question;
		}

		public void setQuestion(String question) {
			this.question = question;
		}

		@Column(name="answer")
		public String getAnswer() {
			return answer;
		}

		public void setAnswer(String answer) {
			this.answer = answer;
		}

		@Column(name="isActive")
		public int getIsActive() {
			return isActive;
		}

		public void setIsActive(int isActive) {
			this.isActive = isActive;
		}

		@Column(name="questionBy")
		public int getQuestionBy() {
			return questionBy;
		}

		public void setQuestionBy(int questionBy) {
			this.questionBy = questionBy;
		}

		@Temporal(TemporalType.TIMESTAMP)
		@Column(name="questionDate")
		public Date getQuestionDate() {
			return questionDate;
		}

		public void setQuestionDate(Date questionDate) {
			this.questionDate = questionDate;
		}

		@Column(name="answerBy")
		public int getAnswerBy() {
			return answerBy;
		}

		public void setAnswerBy(int answerBy) {
			this.answerBy = answerBy;
		}

		@Temporal(TemporalType.TIMESTAMP)
		@Column(name="answerDate")
		public Date getAnswerDate() {
			return answerDate;
		}

		public void setAnswerDate(Date answerDate) {
			this.answerDate = answerDate;
		}

		@Column(name="eventId")
		public int getEventId() {
			return eventId;
		}

		public void setEventId(int eventId) {
			this.eventId = eventId;
		}

		public TblQuestionAnswer(){
        }
}
