package com.online.quiz.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.online.quiz.model.QuizTopic;
import com.online.quiz.repository.QuizRepository;

@Service
public class QuizServices {

	@Autowired
	private QuizRepository quizRepo;
	
	public List<QuizTopic> getAllQuizTopics() {
        return quizRepo.findAll();
    }
	
	public QuizTopic getQuiz(int id) {
		Optional<QuizTopic> qt =  quizRepo.findById(id);
		return qt.orElse(null);
	}
}
