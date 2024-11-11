package com.powerteam.model.crm;

import com.powerteam.model.sys.User;
import lombok.Data;

import java.util.Date;

@Data
public class Activity {

	private Integer activityId;
	private Byte resourceType;
	private Integer resourceId;
	private Byte activityType;
	private String content;
	private Date createDate;
	private Integer createBy;

	private User createByUser;
	private Customer customer;
	private Opportunity opportunity;

	public Integer getActivityId() {
		return activityId;
	}

	public void setActivityId(Integer activityId) {
		this.activityId = activityId;
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

	public Byte getActivityType() {
		return activityType;
	}

	public void setActivityType(Byte activityType) {
		this.activityType = activityType;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Integer getCreateBy() {
		return createBy;
	}

	public void setCreateBy(Integer createBy) {
		this.createBy = createBy;
	}

	public User getCreateByUser() {
		return createByUser;
	}

	public void setCreateByUser(User createByUser) {
		this.createByUser = createByUser;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public Opportunity getOpportunity() {
		return opportunity;
	}

	public void setOpportunity(Opportunity opportunity) {
		this.opportunity = opportunity;
	}

}
