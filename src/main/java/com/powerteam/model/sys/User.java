package com.powerteam.model.sys;

import lombok.Data;
import org.springframework.util.StringUtils;

import java.util.Date;

@Data
public class User {

    private Integer userId;

    private String userName;

    private String password;

    private String avatar;

    private String userCode;

    private String realName;

    private Boolean gender;

    private Byte status;

    private Date createAt;

    public String getAvatar() {
        if (StringUtils.isEmpty(avatar)) {
            avatar = "img/avatar/avatar1.png";
        }
        return avatar;
    }

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUserCode() {
		return userCode;
	}

	public void setUserCode(String userCode) {
		this.userCode = userCode;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public Boolean getGender() {
		return gender;
	}

	public void setGender(Boolean gender) {
		this.gender = gender;
	}

	public Byte getStatus() {
		return status;
	}

	public void setStatus(Byte status) {
		this.status = status;
	}

	public Date getCreateAt() {
		return createAt;
	}

	public void setCreateAt(Date createAt) {
		this.createAt = createAt;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}
    
}
