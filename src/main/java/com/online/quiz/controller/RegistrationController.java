package com.online.quiz.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.online.quiz.model.UserDTO;
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
	    public String registerUser(UserDTO user,@RequestParam(required=false) List<String> roles,RedirectAttributes redirectAttributes) {
	    	 // Check if user already exists
	        if (userService.existsByUsername(user.getUsername())) {
	            // Add error message and user object to flash attributes
	            redirectAttributes.addFlashAttribute("errorMessage", "User already exists. Please choose a different username.");
	            return "redirect:/register";
	        }
	        // Attempt to register the user
	        Users newUser = new Users();
	        newUser.setFullName(user.getFullName());
	        newUser.setUsername(user.getUsername());
	        newUser.setPassword(user.getPassword());
	        if (roles == null || roles.isEmpty()) {
	            roles = Collections.singletonList("User");
	        }
	        Users registeredUser = userService.registerUser(newUser,roles);
	        if (registeredUser != null) {
	            // Add success message to flash attributes
	            redirectAttributes.addFlashAttribute("successMessage", "Registration successful! You can now login.");
	            // Redirect to login page
	            return "redirect:/login";
	        } else {
	            // Add error message to flash attributes
	            redirectAttributes.addFlashAttribute("errorMessage", "Registration failed. Please try again.");
	            // Redirect to registration page
	            return "redirect:/register";
	        }
	    }
}
