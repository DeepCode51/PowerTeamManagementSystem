package com.powerteam.controller.crm;

import com.github.pagehelper.PageInfo;
import com.powerteam.controller.AuthorizedController;
import com.powerteam.model.crm.ContactsRole;
import com.powerteam.model.crm.Opportunity;
import com.powerteam.service.crm.OpportunityService;
import com.powerteam.service.masterData.OrgUnitService;
import com.powerteam.vo.Result;
import com.powerteam.vo.crm.QueryOpportunityVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/opportunity")
public class OpportunityController extends AuthorizedController {

    @Autowired
    private OpportunityService opportunityService;

    @Autowired
    private OrgUnitService orgUnitService;

    @RequestMapping(value = "", method = RequestMethod.GET)
    public String customer() {
        return "crm/opportunity";
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    public Result add(@RequestBody Opportunity opportunity) {
        opportunity.setCreateBy(getUser().getUserId());
        return opportunityService.insert(opportunity);
    }

    @RequestMapping(value = "/find", method = RequestMethod.POST)
    @ResponseBody
    public PageInfo<Opportunity> find(@RequestBody QueryOpportunityVo vo) {
        List<Integer> subordinate = orgUnitService.findSubordinate(getUser().getUserId());
        vo.setUserIdList(subordinate);
        return opportunityService.find(vo);
    }

    @RequestMapping(value = "/detail/{opportunityId}", method = RequestMethod.GET)
    public ModelAndView detail(@PathVariable int opportunityId) {
        ModelAndView vm = new ModelAndView("crm/opportunityDetail");
        vm.addObject("opportunityId", opportunityId);
        return vm;
    }

    @RequestMapping(value = "/findById", method = RequestMethod.POST)
    @ResponseBody
    public Opportunity findById(@RequestBody Opportunity opportunity) {
        return opportunityService.findById(opportunity.getOpportunityId());
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public Result update(@RequestBody Opportunity opportunity) {
        return opportunityService.update(opportunity);
    }

    @RequestMapping(value = "/addContactsRole", method = RequestMethod.POST)
    @ResponseBody
    public Result addContactsRole(@RequestBody ContactsRole contactsRole) {
        return opportunityService.insertContactsRole(contactsRole);
    }

    @RequestMapping(value = "/updateContactsRole", method = RequestMethod.POST)
    @ResponseBody
    public Result updateContactsRole(@RequestBody ContactsRole contactsRole) {
        return opportunityService.updateContactsRole(contactsRole);
    }

    @RequestMapping(value = "/removeContactsRole", method = RequestMethod.POST)
    @ResponseBody
    public Result removeContactsRole(@RequestBody ContactsRole contactsRole) {
        return opportunityService.deleteContactsRole(contactsRole);
    }

    @RequestMapping(value = "/remove", method = RequestMethod.POST)
    @ResponseBody
    public Result remove(@RequestBody Opportunity opportunity) {
        return opportunityService.delete(opportunity);
    }

    @RequestMapping(value = "/history", method = RequestMethod.GET)
    public String history() {
        return "crm/opportunityHistory";
    }

    @RequestMapping(value = "/history/view/{opportunityId}", method = RequestMethod.GET)
    public ModelAndView view(@PathVariable int opportunityId) {
        ModelAndView vm = new ModelAndView("crm/opportunityView");
        vm.addObject("opportunityId", opportunityId);
        return vm;
    }

    @RequestMapping(value = "/findMonthlyFunnel", method = RequestMethod.POST)
    @ResponseBody
    public List<Map> findMonthlyFunnel(@RequestBody QueryOpportunityVo vo) {
        List<Integer> userIdList = new ArrayList<>();
        userIdList.add(getUser().getUserId());
        vo.setUserIdList(userIdList);
        return opportunityService.findMonthlyFunnel(vo);
    }

    @RequestMapping(value = "/findMonthlyConversion", method = RequestMethod.POST)
    @ResponseBody
    public List<Map> findMonthlyConversion(@RequestBody QueryOpportunityVo vo) {
        List<Integer> userIdList = new ArrayList<>();
        userIdList.add(getUser().getUserId());
        vo.setUserIdList(userIdList);
        return opportunityService.findMonthlyConversion(vo);
    }

    @RequestMapping(value = "/findRecentlyClosing", method = RequestMethod.POST)
    @ResponseBody
    public List<Opportunity> findRecentlyClosing(@RequestBody QueryOpportunityVo vo) {
        List<Integer> userIdList = new ArrayList<>();
        userIdList.add(getUser().getUserId());
        vo.setUserIdList(userIdList);
        return opportunityService.findRecentlyClosing(vo);
    }
}
