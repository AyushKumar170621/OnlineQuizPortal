package com.online.quiz.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.online.quiz.model.Role;
import com.online.quiz.model.Users;
import com.online.quiz.model.RoleDTO;
import com.online.quiz.model.UserRole;
import com.online.quiz.repository.RoleRepository;
import com.online.quiz.repository.UserRepository;

@Service
public class RoleService {
	@Autowired
	private RoleRepository roleRepo;
	@Autowired
	private UserRepository userRepo;

	public List<RoleDTO> getRolesWithAssignmentStatus(int userId) {
		List<RoleDTO> res = new ArrayList<RoleDTO>();
		List<Role> roles = roleRepo.findAll();
		Users user = userRepo.findById(userId).get();
		for( Role role:roles)
		{
			RoleDTO temp = new RoleDTO(role.getRoleID(),role.getRoleName());
			for (UserRole usrole : user.getUserRoles())
			{
				if(temp.getRoleId() == usrole.getRole().getRoleID())
				{
					temp.setAssigned(true);
				}
			}
			res.add(temp);
		}
		return res;
	}
	
}
