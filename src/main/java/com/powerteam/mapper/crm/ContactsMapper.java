package com.powerteam.mapper.crm;

import com.powerteam.model.crm.Contacts;
import com.powerteam.vo.crm.QueryContactsVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ContactsMapper {

    int insert(Contacts contacts);

    List<Contacts> find(QueryContactsVo vo);

    Contacts findById(Integer contactsId);

    int update(Contacts contacts);
}
