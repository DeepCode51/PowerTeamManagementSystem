package com.powerteam.service.crm;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.powerteam.mapper.crm.CustomerMapper;
import com.powerteam.model.crm.*;
import com.powerteam.vo.Result;
import com.powerteam.vo.crm.QueryCustomerVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.Date;
import java.util.List;

@Service
public class CustomerService {

    @Autowired
    private CustomerMapper customerMapper;

    @Autowired
    private ShareGroupService shareGroupService;

    @Autowired
    private ActivityService activityService;

    public PageInfo<Customer> find(QueryCustomerVo vo) {
        if (!StringUtils.isEmpty(vo.getWord())) {
            vo.setWord("%" + vo.getWord() + "%");
        }

        if (!vo.isDisablePaging()) {
            PageHelper.startPage(vo.getPageNum(), vo.getPageSize());
        }
        return new PageInfo<>(customerMapper.find(vo));
    }

    public List<CustomerCategory> findAllCustomerCategory() {
        return customerMapper.findAllCustomerCategory();
    }

    public List<Industry> findAllIndustry() {
        return customerMapper.findAllIndustry();
    }

    public List<Source> findAllSource() {
        return customerMapper.findAllSource();
    }

    @Transactional
    public Result insert(Customer customer) {
        customer.setCreateDate(new Date());
        customer.setOwner(customer.getCreateBy());
        Result result = new Result();

        if (!checkCustomerName(customer).isSuccess()) {
            result.setMessage("客户名称重复");
            return result;
        }

        if (customerMapper.insert(customer) > 0) {
            ShareGroup shareGroup = new ShareGroup();
            shareGroup.setResourceType(ResourceType.客户);
            shareGroup.setResourceId(customer.getCustomerId());
            shareGroup.setUserId(customer.getCreateBy());

            if (shareGroupService.insert(shareGroup).isSuccess()) {

                Activity activity = new Activity();
                activity.setResourceType(ResourceType.客户);
                activity.setResourceId(customer.getCustomerId());
                activity.setActivityType(ActivityType.系统跟踪);
                activity.setContent("创建了客户");
                activity.setCreateDate(new Date());
                activity.setCreateBy(customer.getCreateBy());

                if (activityService.insert(activity).isSuccess()) {
                    result.setSuccess(true);
                } else {
                    result.setMessage("新增客户失败");
                }
            } else {
                result.setMessage("新增客户失败");
            }
        } else {
            result.setMessage("新增客户失败");
        }

        return result;
    }

    public Result checkCustomerName(Customer customer) {
        return new Result(!customerMapper.existCustomerName(customer));
    }

    public Customer findById(Integer customerId) {
        return customerMapper.findById(customerId);
    }

    @Transactional
    public Result update(Customer customer) {
        Result result = new Result();
        result.setSuccess(customerMapper.update(customer) > 0);
        return result;
    }

    @Transactional
    public Result updateStar(Customer customer) {
        Result result = new Result();
        Customer model = findById(customer.getCustomerId());
        model.setStar(customer.getStar());
        result.setSuccess(customerMapper.update(model) > 0);
        return result;
    }

    @Transactional
    public Result updateLocation(Customer customer) {
        Result result = new Result();
        Customer model = findById(customer.getCustomerId());
        model.setLng(customer.getLng());
        model.setLat(customer.getLat());
        result.setSuccess(customerMapper.update(model) > 0);
        return result;
    }

}