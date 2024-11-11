package com.powerteam.vo.crm;

import com.powerteam.vo.QueryPageVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.List;

@Data
@EqualsAndHashCode(callSuper = true)
public class QueryContactsVo extends QueryPageVo {

    private String word;
    private Integer customerId;
    private List<Integer> excludeContactsId;
	public String getWord() {
		return word;
	}
	public void setWord(String word) {
		this.word = word;
	}
	public Integer getCustomerId() {
		return customerId;
	}
	public void setCustomerId(Integer customerId) {
		this.customerId = customerId;
	}
	public List<Integer> getExcludeContactsId() {
		return excludeContactsId;
	}
	public void setExcludeContactsId(List<Integer> excludeContactsId) {
		this.excludeContactsId = excludeContactsId;
	}

    
}
