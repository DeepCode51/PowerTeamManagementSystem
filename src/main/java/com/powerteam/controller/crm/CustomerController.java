package com.powerteam.controller.crm;

import com.github.pagehelper.PageInfo;
import com.powerteam.controller.AuthorizedController;
import com.powerteam.model.crm.Customer;
import com.powerteam.model.crm.CustomerCategory;
import com.powerteam.model.crm.Industry;
import com.powerteam.model.crm.Source;
import com.powerteam.service.crm.CustomerService;
import com.powerteam.vo.Result;
import com.powerteam.vo.crm.QueryCustomerVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequestMapping("/customer")
public class CustomerController extends AuthorizedController {

    @Autowired
    private CustomerService customerService;

    @RequestMapping(value = "", method = RequestMethod.GET)
    public String customer() {
        return "crm/customer";
    }

    @RequestMapping(value = "/find", method = RequestMethod.POST)
    @ResponseBody
    public PageInfo<Customer> find(@RequestBody QueryCustomerVo vo) {
        return customerService.find(vo);
    }

    @RequestMapping(value = "/findAllCustomerCategory", method = RequestMethod.POST)
    @ResponseBody
    public List<CustomerCategory> findAllCustomerCategory() {
        return customerService.findAllCustomerCategory();
    }

    @RequestMapping(value = "/findAllIndustry", method = RequestMethod.POST)
    @ResponseBody
    public List<Industry> findAllIndustry() {
        return customerService.findAllIndustry();
    }

    @RequestMapping(value = "/findAllSource", method = RequestMethod.POST)
    @ResponseBody
    public List<Source> findAllSource() {
        return customerService.findAllSource();
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    public Result add(@RequestBody Customer customer) {
        customer.setCreateBy(getUser().getUserId());
        return customerService.insert(customer);
    }

    @RequestMapping(value = "/checkCustomerName", method = RequestMethod.POST)
    @ResponseBody
    public Result checkCustomerName(@RequestBody Customer customer) {
        return customerService.checkCustomerName(customer);
    }

    @RequestMapping(value = "/findById", method = RequestMethod.POST)
    @ResponseBody
    public Customer findById(@RequestBody Customer customer) {
        return customerService.findById(customer.getCustomerId());
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public Result update(@RequestBody Customer customer) {
        return customerService.update(customer);
    }

    @RequestMapping(value = "/dashboard/{customerId}", method = RequestMethod.GET)
    public ModelAndView dashboard(@PathVariable int customerId) {
        ModelAndView vm = new ModelAndView("crm/customerDashboard");
        vm.addObject("customerId", customerId);
        return vm;
    }

    @RequestMapping(value = "/updateStar", method = RequestMethod.POST)
    @ResponseBody
    public Result updateStar(@RequestBody Customer customer) {
        return customerService.updateStar(customer);
    }

    @RequestMapping(value = "/updateLocation", method = RequestMethod.POST)
    @ResponseBody
    public Result updateLocation(@RequestBody Customer customer) {
        return customerService.updateLocation(customer);
    }
}