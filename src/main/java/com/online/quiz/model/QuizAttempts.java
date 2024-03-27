package com.online.quiz.model;

import java.sql.Date;
import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.PrePersist;

@Entity
public class QuizAttempts {

	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private int attemptID;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "userID",nullable=false)
	private Users user;
	
	@Column(nullable=false)
	private int quizID;
	
	@Column(nullable=false)
	private int score;
	
	@Column(nullable=false)
	private Date attemptedAt;
	
	@Column(nullable=false)
	private int submittedAt;
	
	public int getAttemptID() {
		return attemptID;
	}

	public void setAttemptID(int attemptID) {
		this.attemptID = attemptID;
	}

	public Users getUserID() {
		return user;
	}

	public void setUserID(Users user) {
		this.user = user;
	}

	public int getQuizID() {
		return quizID;
	}

	public void setQuizID(int quizID) {
		this.quizID = quizID;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	public Date getAttemptedAt() {
		return attemptedAt;
	}

	public void setAttemptedAt(Date attemptedAt) {
		this.attemptedAt = attemptedAt;
	}

	public int getSubmittedAt() {
		return submittedAt;
	}

	public void setSubmittedAt(int submittedAt) {
		this.submittedAt = submittedAt;
	}
	
}
