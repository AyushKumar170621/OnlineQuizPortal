package com.online.quiz.model;

import java.sql.Date;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;

@Entity
public class Users {
	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private int userID;
	
	@Column(unique=true, nullable = false)
	private String username;
	
	@Column(nullable = false)
	private String password;
	
	@Column(nullable = false)
	private Date createdAt;
	
	@Column(nullable = false)
	private String fullName;
	
	@Enumerated(EnumType.STRING)
	private UserRole role;
	
	private Date lastLogin;
	
	@OneToMany(mappedBy="user",cascade = CascadeType.ALL, fetch  = FetchType.LAZY)
	private List<QuizAttempts> quizAttempts;
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public int getUserID() {
		return userID;
	}
	public void setUserID(int userID) {
		this.userID = userID;
	}
	public Date getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}
	public Date getLastLogin() {
		return lastLogin;
	}
	public void setLastLogin(Date lastLogin) {
		this.lastLogin = lastLogin;
	}
	public List<QuizAttempts> getQuizAttempts() {
		return quizAttempts;
	}
	public void setQuizAttempts(List<QuizAttempts> quizAttempts) {
		this.quizAttempts = quizAttempts;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
}
