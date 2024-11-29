package com.online.quiz.model;

import java.util.List;

public class RoleUpdateRequest {
    private int userId;
    private List<Integer> roleIds;
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public List<Integer> getRoleIds() {
		return roleIds;
	}
	public void setRoleIds(List<Integer> roleIds) {
		this.roleIds = roleIds;
	}
	
	

}
