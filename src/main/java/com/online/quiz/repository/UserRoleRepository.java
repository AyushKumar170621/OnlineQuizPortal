package com.online.quiz.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.online.quiz.model.UserRole;
import com.online.quiz.model.Users;

public interface UserRoleRepository extends JpaRepository<UserRole,Integer> {
}
