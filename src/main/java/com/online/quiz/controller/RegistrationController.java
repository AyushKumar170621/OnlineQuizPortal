package com.online.quiz.controller;

import org.springframework.beans.factory.annotation.Autowired;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.online.quiz.model.Users;
import com.online.quiz.service.MyUserDetailsService;

@Controller
@RequestMapping("/register")
public class RegistrationController {
	 private final MyUserDetailsService userService;

	    @Autowired
	    public RegistrationController(MyUserDetailsService userService) {
	        this.userService = userService;
	    }

	    @GetMapping
	    public String showRegistrationForm() {
	        return "register";
	    }

	    @PostMapping
	    public String registerUser(Users user) {
	        userService.registerUser(user);
	        return "redirect:/login"; 
	    }
}
