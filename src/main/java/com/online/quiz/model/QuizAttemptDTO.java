package com.online.quiz.model;

import java.util.List;

public class QuizAttemptDTO {
    private int userId;
    private int quizId;
    private List<QuestionAnswerDTO> questionAnswers;
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getQuizId() {
		return quizId;
	}
	public void setQuizId(int quizId) {
		this.quizId = quizId;
	}
	public List<QuestionAnswerDTO> getQuestionAnswers() {
		return questionAnswers;
	}
	public void setQuestionAnswers(List<QuestionAnswerDTO> questionAnswers) {
		this.questionAnswers = questionAnswers;
	}

}

