package com.online.quiz.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.online.quiz.model.Role;
import com.online.quiz.model.Users;

public interface RoleRepository extends JpaRepository<Role, Integer> {
	Role findByRoleName(String roleName);
}
