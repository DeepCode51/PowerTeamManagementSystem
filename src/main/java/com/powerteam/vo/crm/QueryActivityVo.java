package com.powerteam.vo.crm;

import com.powerteam.vo.QueryPageVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.Date;
import java.util.List;

@Data
@EqualsAndHashCode(callSuper = true)
public class QueryActivityVo extends QueryPageVo {

    private Byte resourceType;
    private Integer resourceId;
    private List<Byte> activityType;

    private Date workDay;
    private List<Integer> createBy;
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
	public List<Byte> getActivityType() {
		return activityType;
	}
	public void setActivityType(List<Byte> activityType) {
		this.activityType = activityType;
	}
	public Date getWorkDay() {
		return workDay;
	}
	public void setWorkDay(Date workDay) {
		this.workDay = workDay;
	}
	public List<Integer> getCreateBy() {
		return createBy;
	}
	public void setCreateBy(List<Integer> createBy) {
		this.createBy = createBy;
	}
    
    
}
