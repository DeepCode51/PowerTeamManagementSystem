package com.powerteam.model.sys;

import lombok.Data;

@Data
public class Fun {

    private Integer funId;

    private String funName;

    private String funCode;

	public Integer getFunId() {
		return funId;
	}

	public void setFunId(Integer funId) {
		this.funId = funId;
	}

	public String getFunName() {
		return funName;
	}

	public void setFunName(String funName) {
		this.funName = funName;
	}

	public String getFunCode() {
		return funCode;
	}

	public void setFunCode(String funCode) {
		this.funCode = funCode;
	}
    
    
}
