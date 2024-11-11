package com.powerteam.model.masterData;

import lombok.Data;

@Data
public class OrgUnit {

	private Integer orgUnitId;
	private String orgUnitName;
	private Integer pid;
	private Integer orgIndex;

	public Integer getOrgUnitId() {
		return orgUnitId;
	}

	public void setOrgUnitId(Integer orgUnitId) {
		this.orgUnitId = orgUnitId;
	}

	public String getOrgUnitName() {
		return orgUnitName;
	}

	public void setOrgUnitName(String orgUnitName) {
		this.orgUnitName = orgUnitName;
	}

	public Integer getPid() {
		return pid;
	}

	public void setPid(Integer pid) {
		this.pid = pid;
	}

	public Integer getOrgIndex() {
		return orgIndex;
	}

	public void setOrgIndex(Integer orgIndex) {
		this.orgIndex = orgIndex;
	}

}
