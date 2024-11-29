package com.online.quiz.service;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.online.quiz.model.Role;
import com.online.quiz.model.UserRole;
import com.online.quiz.model.Users;
import com.online.quiz.repository.RoleRepository;
import com.online.quiz.repository.UserRepository;
import com.online.quiz.repository.UserRoleRepository;

import jakarta.transaction.Transactional;
@Service
public class MyUserDetailsService implements UserDetailsService {

	@Autowired
	private UserRepository repo;
	@Autowired
	private  PasswordEncoder passwordEncoder;
	@Autowired
	private RoleRepository roleRepository;
	@Autowired
	private UserRoleRepository userRoleRepo;
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		Users user = repo.findByUsername(username);
		if(user == null)
		{
			throw new UsernameNotFoundException("no user found");
		}
		return new UserPrincipal(user);
	}
	
	public Users registerUser(Users user, List<String> roles) {
		String encodedPassword = passwordEncoder.encode(user.getPassword());
		user.setPassword(encodedPassword);
		List<UserRole> userRoles = new ArrayList<>();

	    for (String roleName : roles) {
	        Role role = roleRepository.findByRoleName(roleName);
	        
	        // If role does not exist, create and save a new Role
	        if (role == null) {
	            role = new Role();
	            role.setRoleName(roleName);
	            roleRepository.save(role);
	        }

	        // Create and associate UserRole for each role
	        UserRole userRole = new UserRole();
	        userRole.setUser(user);
	        userRole.setRole(role);

	        // Add the UserRole to the list for this user
	        userRoles.add(userRole);
	    }

	    // Set the list of UserRoles in the Users entity
	    user.setUserRoles(userRoles);
		System.out.println(user);
        return repo.save(user);
    }

	public boolean existsByUsername(String username) {
		// TODO Auto-generated method stub
		Users existingUser = repo.findByUsername(username);
        return existingUser != null;
	}
	
	public List<Users> findAllUsers()
	{
		return repo.findAll();
	}

	public List<Users> searchUsers(String role, String name, String email) {
		// TODO Auto-generated method stub
		return repo.searchUsers(role, name, email);
	}

	@Transactional
	public boolean updateUserRoles(int userId, List<Integer> roleIds) {
	    // Fetch the User entity by ID
	    Users user = repo.findById(userId)
	                     .orElseThrow(() -> new RuntimeException("User not found with ID: " + userId));
	    
	    // Delete all existing UserRoles for the User
	    for (UserRole roles : user.getUserRoles()) {
	        System.out.println("Deleting UserRole with ID: " + roles.getUserRoleID());
	        userRoleRepo.deleteById(roles.getUserRoleID());
	    }

	    // Prepare new UserRole associations
	    List<UserRole> userRoles = new ArrayList<>();
	    for (Integer id : roleIds) {
	        // Fetch the Role entity safely
	        Role role = roleRepository.findById(id)
	                                  .orElseThrow(() -> new RuntimeException("Role not found with ID: " + id));
	        
	        // Create a new UserRole and add it to the list
	        UserRole newUserRole = new UserRole(user, role);
	        userRoleRepo.save(newUserRole);
	        userRoles.add(newUserRole);
	    }

	    // Set the new UserRole list to the User and save
	    user.setUserRoles(userRoles);
	    repo.save(user);

	    return true;
	}

	
}
