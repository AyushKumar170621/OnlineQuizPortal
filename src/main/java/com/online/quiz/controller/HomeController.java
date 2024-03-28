package com.online.quiz.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.online.quiz.model.QuizTopic;
import com.online.quiz.repository.QuizRepository;
import com.online.quiz.repository.UserRepository;
import com.online.quiz.service.QuizServices;


@Controller
public class HomeController {
	
	@Autowired
	private QuizServices qService;
	
	@GetMapping("/login")
	public String login()
	{
		return "userlogin";
	}
	
	@GetMapping("/home")
	public ModelAndView quizTopic(@AuthenticationPrincipal UserDetails currentUser)
	{
		ModelAndView modelAndView = new ModelAndView();
        List<QuizTopic> quizTopics = qService.getAllQuizTopics();
        for(QuizTopic tp : quizTopics)
        {
        	System.out.println(tp.getTopicName());
        }
        modelAndView.addObject("quizTopics", quizTopics);
        modelAndView.setViewName("home");
        return modelAndView;
	}
}
