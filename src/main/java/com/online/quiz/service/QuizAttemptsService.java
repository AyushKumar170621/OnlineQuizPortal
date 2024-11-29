package com.online.quiz.service;

import com.online.quiz.model.QuizAttempts;
import com.online.quiz.model.Users;
import com.online.quiz.repository.QuizAttemptsRepository;
import com.online.quiz.repository.QuizRepository;
import com.online.quiz.repository.UserRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class QuizAttemptsService {

    private final QuizAttemptsRepository quizAttemptsRepository;
    private final UserRepository userRepo;
    private final QuizRepository quizRepo;
    @Autowired
    public QuizAttemptsService(QuizAttemptsRepository quizAttemptsRepository, UserRepository userRepo, QuizRepository quizRepo) {
        this.quizAttemptsRepository = quizAttemptsRepository;
        this.userRepo = userRepo;
        this.quizRepo= quizRepo;
    }

    public QuizAttempts submitQuizAttempt(String username, int quizId, int score) {
        QuizAttempts attempt = new QuizAttempts();
        // Set properties of attempt based on method parameters and other required details
        // Assuming Users is correctly set up and fetched here
        attempt.setUser(userRepo.findByUsername(username));
        attempt.setQuizTopic(quizRepo.findById(quizId).get());
        attempt.setScore(score);
        attempt.setAttemptedAt(LocalDateTime.now()); // Assuming attemptedAt is java.sql.Date
        // Submitting at is not demonstrated here, assuming typo in the QuizAttempts model (submittedAt as int)

        return quizAttemptsRepository.save(attempt);
    }
    
    public List<QuizAttempts> getUserSubmissions(String username)
    {
    	Users uId = userRepo.findByUsername(username);
    	List<QuizAttempts> res = quizAttemptsRepository.findByUser(uId);
    	
    	return res;
    }

	public List<QuizAttempts> findAllQuizAttempts() {
		// TODO Auto-generated method stub
		return quizAttemptsRepository.findAll();
	}


    // Other service methods as required
}
