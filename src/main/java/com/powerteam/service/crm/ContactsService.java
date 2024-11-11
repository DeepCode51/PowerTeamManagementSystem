package com.powerteam.service.crm;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.powerteam.mapper.crm.ContactsMapper;
import com.powerteam.model.crm.Contacts;
import com.powerteam.vo.Result;
import com.powerteam.vo.crm.QueryContactsVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.Date;

@Service
public class ContactsService {

    @Autowired
    private ContactsMapper contactsMapper;

    @Transactional
    public Result insert(Contacts contacts) {
        Result result = new Result();
        contacts.setCreateDate(new Date());
        result.setSuccess(contactsMapper.insert(contacts) > 0);
        return result;
    }

    public PageInfo<Contacts> find(QueryContactsVo vo) {
        if (!StringUtils.isEmpty(vo.getWord())) {
            vo.setWord("%" + vo.getWord() + "%");
        }

        if (!vo.isDisablePaging()) {
            PageHelper.startPage(vo.getPageNum(), vo.getPageSize());
        }
        return new PageInfo<>(contactsMapper.find(vo));
    }

    public Contacts findById(Integer customerId) {
        return contactsMapper.findById(customerId);
    }

    @Transactional
    public Result update(Contacts contacts) {
        Result result = new Result();
        result.setSuccess(contactsMapper.update(contacts) > 0);
        return result;
    }
}
