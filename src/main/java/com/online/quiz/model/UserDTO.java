package com.online.quiz.model;

import java.sql.Date;

import jakarta.persistence.Column;

public class UserDTO {
	@Column(unique=true, nullable = false)
	private String username;
	
	@Column(nullable = false)
	private String password;

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	@Column(nullable = false)
	private String fullName;

}
