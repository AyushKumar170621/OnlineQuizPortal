package com.online.quiz.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.online.quiz.model.Users;

public interface UserRepository extends JpaRepository<Users,Integer>{
    Users findByUsername(String username);
    @Query("SELECT u FROM Users u " +
            "JOIN u.userRoles ur " +
            "JOIN ur.role r " +
            "WHERE (:role IS NULL OR r.roleName = :role) " +
            "AND (:name IS NULL OR LOWER(u.fullName) LIKE LOWER(CONCAT('%', :name, '%'))) " +
            "AND (:email IS NULL OR LOWER(u.username) LIKE LOWER(CONCAT('%', :email, '%')))")
     List<Users> searchUsers(
             @Param("role") String role,
             @Param("name") String name,
             @Param("email") String email);
}
