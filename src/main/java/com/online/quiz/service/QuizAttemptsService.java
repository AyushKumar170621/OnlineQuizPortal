package com.online.quiz.service;

import com.online.quiz.model.QuizAttempts;
import com.online.quiz.repository.QuizAttemptsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Date;

@Service
public class QuizAttemptsService {

    private final QuizAttemptsRepository quizAttemptsRepository;

    @Autowired
    public QuizAttemptsService(QuizAttemptsRepository quizAttemptsRepository) {
        this.quizAttemptsRepository = quizAttemptsRepository;
    }

    public QuizAttempts submitQuizAttempt(int userId, int quizId, int score) {
        QuizAttempts attempt = new QuizAttempts();
        // Set properties of attempt based on method parameters and other required details
        // Assuming Users is correctly set up and fetched here
        // attempt.setUserID(user);
        attempt.setQuizID(quizId);
        attempt.setScore(score);
        attempt.setAttemptedAt(new Date(System.currentTimeMillis())); // Assuming attemptedAt is java.sql.Date
        // Submitting at is not demonstrated here, assuming typo in the QuizAttempts model (submittedAt as int)

        return quizAttemptsRepository.save(attempt);
    }

    // Other service methods as required
}
