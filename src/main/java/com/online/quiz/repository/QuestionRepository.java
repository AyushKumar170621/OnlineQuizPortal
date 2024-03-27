package com.online.quiz.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.online.quiz.model.Question;

public interface QuestionRepository extends JpaRepository<Question,Integer>{
	List<Question> findByQuizTopicIdAndIsMultichoice(Long quizTopicId, boolean isMultichoice);
}
