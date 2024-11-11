package com.powerteam.mapper.crm;

import com.powerteam.model.crm.*;
import com.powerteam.vo.crm.QueryCustomerVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CustomerMapper {

    List<Customer> find(QueryCustomerVo vo);

    List<Industry> findAllIndustry();

    List<CustomerCategory> findAllCustomerCategory();

    List<Source> findAllSource();

    int insert(Customer customer);

    Boolean existCustomerName(Customer customer);

    Customer findById(Integer customerId);

    int update(Customer customer);
}