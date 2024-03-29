package com.online.quiz.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.online.quiz.model.QuizTopic;
import com.online.quiz.model.Users;
import com.online.quiz.repository.UserRepository;
import com.online.quiz.service.QuizServices;

import jakarta.servlet.http.HttpSession;


@Controller
public class HomeController {
	
	@Autowired
	private QuizServices qService;
	@Autowired
	private UserRepository userRepo;
	@Autowired 
	private HttpSession httpSession;
	
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
        Users user = userRepo.findByUsername(currentUser.getUsername());
        httpSession.setAttribute("fname", user.getFullName());
        modelAndView.addObject("quizTopics", quizTopics);
        modelAndView.setViewName("home");
        return modelAndView;
	}
}
