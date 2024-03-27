package com.online.quiz.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.online.quiz.model.QuizTopic;

public interface QuizRepository extends JpaRepository<QuizTopic,Integer>{
}
