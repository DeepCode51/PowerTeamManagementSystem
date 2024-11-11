package com.powerteam.model.sys;

import lombok.Data;

@Data
public class Role {

    private Integer roleId;

    private String roleName;

    private Boolean isSystemRole;

	public Integer getRoleId() {
		return roleId;
	}

	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public Boolean getIsSystemRole() {
		return isSystemRole;
	}

	public void setIsSystemRole(Boolean isSystemRole) {
		this.isSystemRole = isSystemRole;
	}
    
    
}