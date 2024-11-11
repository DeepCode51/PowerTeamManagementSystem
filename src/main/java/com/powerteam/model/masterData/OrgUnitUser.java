package com.powerteam.model.masterData;

import com.powerteam.model.sys.User;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
public class OrgUnitUser extends User {

	private Integer orgUnitId;
	private Boolean isUnitHead;

	public Integer getOrgUnitId() {
		return orgUnitId;
	}

	public void setOrgUnitId(Integer orgUnitId) {
		this.orgUnitId = orgUnitId;
	}

	public Boolean getIsUnitHead() {
		return isUnitHead;
	}

	public void setIsUnitHead(Boolean isUnitHead) {
		this.isUnitHead = isUnitHead;
	}

}
