package com.powerteam.model.crm;

import lombok.Data;

@Data
public class Industry {

	private Integer industryId;
	private String industryName;

	public Integer getIndustryId() {
		return industryId;
	}

	public void setIndustryId(Integer industryId) {
		this.industryId = industryId;
	}

	public String getIndustryName() {
		return industryName;
	}

	public void setIndustryName(String industryName) {
		this.industryName = industryName;
	}

}
