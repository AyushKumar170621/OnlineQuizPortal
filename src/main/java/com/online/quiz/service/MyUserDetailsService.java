package com.online.quiz.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.online.quiz.model.Users;
import com.online.quiz.repository.UserRepository;
@Service
public class MyUserDetailsService implements UserDetailsService {

	@Autowired
	private UserRepository repo;
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		Users user = repo.findByUsername(username);
		if(user == null)
		{
			throw new UsernameNotFoundException("no user found");
		}
		return new UserPrincipal(user);
	}
	
}
