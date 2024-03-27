package com.online.quiz.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.online.quiz.model.QuizTopic;
import com.online.quiz.repository.QuizRepository;
import com.online.quiz.repository.UserRepository;

@Controller
public class Home {
	
	@Autowired
	private QuizRepository Qrepo;
	@GetMapping("/home")
	public String home(@AuthenticationPrincipal UserDetails currentUser)
	{
		System.out.println(currentUser.getUsername());
		return "home";
	}
	
	@GetMapping("/login")
	public String login()
	{
		return "userlogin";
	}
	
	@GetMapping("/topic")
	public String quizTopic()
	{
		List<QuizTopic> list= Qrepo.findAll();
		for(QuizTopic tmp : list)
		{
			System.out.print(tmp.getTopicName());
		}
		return "inside topics";
	}
}
