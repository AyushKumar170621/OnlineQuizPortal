package com.online.quiz.model;

import java.sql.Date;
import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.PrePersist;

@Entity
public class QuizAttempts {

	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private int attemptID;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "userID",nullable=false)
	private Users user;
	
	@OneToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "quizID",nullable =false)
	private QuizTopic quizTopic;
	
	
	@Column(nullable=false)
	private int score;
	
	public Users getUser() {
		return user;
	}

	public void setUser(Users user) {
		this.user = user;
	}

	public QuizTopic getQuizTopic() {
		return quizTopic;
	}

	public void setQuizTopic(QuizTopic quizTopic) {
		this.quizTopic = quizTopic;
	}

	@Column(nullable=false)
	private LocalDateTime attemptedAt;
	
	
	public int getAttemptID() {
		return attemptID;
	}

	public void setAttemptID(int attemptID) {
		this.attemptID = attemptID;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	public LocalDateTime getAttemptedAt() {
		return attemptedAt.withNano(0);
	}

	public void setAttemptedAt(LocalDateTime attemptedAt) {
		this.attemptedAt = attemptedAt;
	}

	
}
