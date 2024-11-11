package com.powerteam.model.crm;

import lombok.Data;

@Data
public class Source {

	private Integer sourceId;
	private String sourceName;

	public Integer getSourceId() {
		return sourceId;
	}

	public void setSourceId(Integer sourceId) {
		this.sourceId = sourceId;
	}

	public String getSourceName() {
		return sourceName;
	}

	public void setSourceName(String sourceName) {
		this.sourceName = sourceName;
	}

}
