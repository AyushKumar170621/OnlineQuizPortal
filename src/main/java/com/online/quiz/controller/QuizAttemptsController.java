package com.online.quiz.controller;

import com.online.quiz.model.QuizAttemptDTO;
import com.online.quiz.model.QuizAttempts;
import com.online.quiz.service.QuizAttemptsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class QuizAttemptsController {

    private final QuizAttemptsService quizAttemptsService;

    @Autowired
    public QuizAttemptsController(QuizAttemptsService quizAttemptsService) {
        this.quizAttemptsService = quizAttemptsService;
    }

    @PostMapping("/submitQuiz")
    public QuizAttempts submitQuiz(@RequestBody QuizAttemptDTO submission) {
        // QuizSubmissionDTO should contain fields like userId, quizId, answers etc.
        // Calculate score based on the answers provided and predefined correct answers
        int score = calculateScore(submission);
        return quizAttemptsService.submitQuizAttempt(submission.getUserId(), submission.getQuizId(), score);
    }

    private int calculateScore(QuizAttemptDTO submission) {
        // Implement scoring logic here
        return 0; // Placeholder
    }

    // Define DTO classes as needed for request bodies
}
