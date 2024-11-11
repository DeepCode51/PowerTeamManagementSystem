package com.powerteam.mapper.crm;

import com.powerteam.model.crm.ContactsRole;
import com.powerteam.model.crm.Opportunity;
import com.powerteam.vo.crm.QueryOpportunityVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface OpportunityMapper {

    int insert(Opportunity opportunity);

    List<Opportunity> find(QueryOpportunityVo vo);

    Opportunity findById(Integer opportunityId);

    int update(Opportunity opportunity);

    int insertContactsRole(ContactsRole contactsRole);

    int updateContactsRole(ContactsRole contactsRole);

    int deleteContactsRole(ContactsRole contactsRole);

    int delete(Opportunity opportunity);

    List<Map> findMonthlyFunnel(QueryOpportunityVo vo);

    List<Map> findMonthlyConversion(QueryOpportunityVo vo);

    List<Opportunity> findRecentlyClosing(QueryOpportunityVo vo);
}
