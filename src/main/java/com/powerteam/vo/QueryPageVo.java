package com.powerteam.vo;

import lombok.Data;

@Data
public class QueryPageVo {

    private boolean disablePaging;
    private String order;
    private Integer pageNum;
    private Integer pageSize;
	public boolean isDisablePaging() {
		return disablePaging;
	}
	public void setDisablePaging(boolean disablePaging) {
		this.disablePaging = disablePaging;
	}
	public String getOrder() {
		return order;
	}
	public void setOrder(String order) {
		this.order = order;
	}
	public Integer getPageNum() {
		return pageNum;
	}
	public void setPageNum(Integer pageNum) {
		this.pageNum = pageNum;
	}
	public Integer getPageSize() {
		return pageSize;
	}
	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

    
}
