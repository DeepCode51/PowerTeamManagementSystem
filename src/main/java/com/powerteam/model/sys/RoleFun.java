package com.powerteam.model.sys;

import lombok.Data;

@Data
public class RoleFun {

	private Integer roleId;
	private Integer funId;

	public Integer getRoleId() {
		return roleId;
	}

	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}

	public Integer getFunId() {
		return funId;
	}

	public void setFunId(Integer funId) {
		this.funId = funId;
	}

}
