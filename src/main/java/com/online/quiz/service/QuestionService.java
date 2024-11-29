package com.online.quiz.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.online.quiz.model.Question;
import com.online.quiz.repository.QuestionRepository;

@Service
public class QuestionService {
	private final QuestionRepository questionRepository;

    @Autowired
    public QuestionService(QuestionRepository questionRepository) {
        this.questionRepository = questionRepository;
    }

    public List<Question> getQuestionsByTopicAndType(Long quizTopicId, boolean isMultichoice) {
        return questionRepository.findByQuizTopicIdAndIsMultichoice(quizTopicId, isMultichoice);
    }
    
    public List<Question> getQuestionsByTopicId(Long quizTopicId)
    {
    	return questionRepository.findByQuizTopicId(quizTopicId);
    }
    public Question getAnswers(Integer questionId)
    {
    	Optional<Question>  quesRes = questionRepository.findById(questionId);
    	return quesRes.orElse(null);
    }

	public void saveQuestion(Question question) {
		// TODO Auto-generated method stub
		questionRepository.save(question);
		
	}

	public Question findQuestionById(int id) {
		return questionRepository.findById(id).get();
	}

	public void deleteQuestionById(int id) {
		questionRepository.deleteById(id);
		
	}
}
