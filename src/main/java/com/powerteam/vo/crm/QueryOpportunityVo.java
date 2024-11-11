package com.powerteam.vo.crm;


import com.powerteam.vo.QueryPageVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.Date;
import java.util.List;

@Data
@EqualsAndHashCode(callSuper = true)
public class QueryOpportunityVo extends QueryPageVo {

    private String word;

    /**
     * 阶段列表
     */
    List<Byte> phaseList;

    /**
     * 干系人列表
     */
    List<Integer> userIdList;

    /**
     * 查询业务机会创建的开始日期
     */
    private Date startCreateDate;

    /**
     * 查询业务机会创建的结束日期
     */
    private Date endCreateDate;

    /**
     * 查询到期日期比该日期早的业务机会
     */
    private Date endDate;

	public String getWord() {
		return word;
	}

	public void setWord(String word) {
		this.word = word;
	}

	public List<Byte> getPhaseList() {
		return phaseList;
	}

	public void setPhaseList(List<Byte> phaseList) {
		this.phaseList = phaseList;
	}

	public List<Integer> getUserIdList() {
		return userIdList;
	}

	public void setUserIdList(List<Integer> userIdList) {
		this.userIdList = userIdList;
	}

	public Date getStartCreateDate() {
		return startCreateDate;
	}

	public void setStartCreateDate(Date startCreateDate) {
		this.startCreateDate = startCreateDate;
	}

	public Date getEndCreateDate() {
		return endCreateDate;
	}

	public void setEndCreateDate(Date endCreateDate) {
		this.endCreateDate = endCreateDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
    
    
}
