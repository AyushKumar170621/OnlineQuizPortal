package com.online.quiz.model;

public class RoleDTO {
    private int roleId;
    private String roleName;
    private boolean assigned;
	public int getRoleId() {
		return roleId;
	}
	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}
	public String getRoleName() {
		return roleName;
	}
	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}
	public boolean isAssigned() {
		return assigned;
	}
	public void setAssigned(boolean assigned) {
		this.assigned = assigned;
	}
	public RoleDTO(int roleId, String roleName) {
		super();
		this.roleId = roleId;
		this.roleName = roleName;
		this.assigned =false;
	}

    // Getters and Setters
}

