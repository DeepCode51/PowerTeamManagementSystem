package com.powerteam.vo;

import lombok.Data;

@Data
public class Result {

    public Result() {
        this.setSuccess(false);
    }

    public Result(boolean success) {
        this.setSuccess(success);
    }

    private boolean success;

    private String message;

    private String code;

	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
    
    
    
}
