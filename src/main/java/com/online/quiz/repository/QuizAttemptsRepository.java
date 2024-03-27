package com.online.quiz.repository;

import com.online.quiz.model.QuizAttempts;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface QuizAttemptsRepository extends JpaRepository<QuizAttempts, Integer> {
    // Additional query methods can be defined here
}
