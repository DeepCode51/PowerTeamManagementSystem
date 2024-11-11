package com.powerteam.model.crm;

import lombok.Data;

@Data
public class ShareGroup {

    private Integer shareGroupId;
    private Byte resourceType;
    private Integer resourceId;
    private Integer userId;
	public Integer getShareGroupId() {
		return shareGroupId;
	}
	public void setShareGroupId(Integer shareGroupId) {
		this.shareGroupId = shareGroupId;
	}
	public Byte getResourceType() {
		return resourceType;
	}
	public void setResourceType(Byte resourceType) {
		this.resourceType = resourceType;
	}
	public Integer getResourceId() {
		return resourceId;
	}
	public void setResourceId(Integer resourceId) {
		this.resourceId = resourceId;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
    
    

}
