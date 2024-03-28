package com.online.quiz.controller;

import com.online.quiz.model.Question;
import com.online.quiz.service.QuestionService;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/question")
public class QuestionController {

    private final QuestionService questionService;

    @Autowired
    public QuestionController(QuestionService questionService) {
        this.questionService = questionService;
    }

    @GetMapping("/{quizTopicId}")
    public ModelAndView showQuestions(@PathVariable Long quizTopicId, @AuthenticationPrincipal UserDetails currentUser) {
        ModelAndView modelAndView = new ModelAndView("questionsPage");
        // Assuming you want both multi-choice and single-choice questions for the topic
        List<Question> mulquestions = questionService.getQuestionsByTopicAndType(quizTopicId, true);
        List<Question> mcqlquestions = questionService.getQuestionsByTopicAndType(quizTopicId, false);
        List<Question> questions = new ArrayList<>();
        Collections.shuffle(mulquestions);
        Collections.shuffle(mcqlquestions);
        questions.addAll(mulquestions.subList(0,4));
        questions.addAll(mcqlquestions.subList(0,6));
        modelAndView.addObject("questions", questions);
        modelAndView.addObject("userId",currentUser.getUsername());
        modelAndView.addObject("quizId",quizTopicId);
        modelAndView.setViewName("quizView");
        return modelAndView;
    }
}
