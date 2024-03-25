package com.online.quiz.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.online.quiz.model.Users;

public interface UserRepository extends JpaRepository<Users,String>{
    Users findByUsername(String username);
}
