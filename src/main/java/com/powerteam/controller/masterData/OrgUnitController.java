package com.powerteam.controller.masterData;

import com.github.pagehelper.PageInfo;
import com.powerteam.controller.AuthorizedController;
import com.powerteam.model.masterData.OrgUnit;
import com.powerteam.model.masterData.OrgUnitUser;
import com.powerteam.model.sys.User;
import com.powerteam.service.masterData.OrgUnitService;
import com.powerteam.vo.Result;
import com.powerteam.vo.masterData.QueryOrgUnitUserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/orgUnit")
public class OrgUnitController extends AuthorizedController {

    @Autowired
    private OrgUnitService orgUnitService;

    @RequestMapping(value = "", method = RequestMethod.GET)
    public String index() {
        return "masterData/orgUnit";
    }

    @RequestMapping(value = "/findAllOrgUnit", method = RequestMethod.POST)
    @ResponseBody
    public List<OrgUnit> findAllOrgUnit() {
        return orgUnitService.findAllOrgUnit();
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    public Result add(@RequestBody OrgUnit orgUnit) {
        return orgUnitService.insert(orgUnit);
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public Result update(@RequestBody OrgUnit orgUnit) {
        return orgUnitService.update(orgUnit);
    }

    @RequestMapping(value = "/remove", method = RequestMethod.POST)
    @ResponseBody
    public Result remove(@RequestBody OrgUnit orgUnit) {
        return orgUnitService.delete(orgUnit.getOrgUnitId());
    }

    @RequestMapping(value = "/up", method = RequestMethod.POST)
    @ResponseBody
    public Result up(@RequestBody OrgUnit orgUnit) {
        return orgUnitService.up(orgUnit.getOrgUnitId());
    }

    @RequestMapping(value = "/down", method = RequestMethod.POST)
    @ResponseBody
    public Result down(@RequestBody OrgUnit orgUnit) {
        return orgUnitService.down(orgUnit.getOrgUnitId());
    }

    @RequestMapping(value = "/orgUser", method = RequestMethod.GET)
    public String orgUser() {
        return "masterData/orgUser";
    }

    @RequestMapping(value = "/orgUser/findUserNotInOrgUnit", method = RequestMethod.POST)
    @ResponseBody
    public PageInfo<User> findUserNotInOrgUnit(@RequestBody QueryOrgUnitUserVo vo) {
        return orgUnitService.findUserNotInOrgUnit(vo);
    }

    @RequestMapping(value = "/orgUser/findUserInOrgUnit", method = RequestMethod.POST)
    @ResponseBody
    public PageInfo<OrgUnitUser> findUserInOrgUnit(@RequestBody QueryOrgUnitUserVo vo) {
        return orgUnitService.findUserInOrgUnit(vo);
    }

    @RequestMapping(value = "/orgUser/add", method = RequestMethod.POST)
    @ResponseBody
    public Result addOrgUser(@RequestBody OrgUnitUser orgUnitUser) {
        return orgUnitService.insertOrgUnitUser(orgUnitUser);
    }

    @RequestMapping(value = "/orgUser/remove", method = RequestMethod.POST)
    @ResponseBody
    public Result removeOrgUser(@RequestBody OrgUnitUser orgUnitUser) {
        return orgUnitService.deleteOrgUnitUser(orgUnitUser);
    }

    @RequestMapping(value = "/orgUser/setUnitHead", method = RequestMethod.POST)
    @ResponseBody
    public Result setUnitHead(@RequestBody OrgUnitUser orgUnitUser) {
        return orgUnitService.setUnitHead(orgUnitUser);
    }

    @RequestMapping(value = "/orgUser/removeUnitHead", method = RequestMethod.POST)
    @ResponseBody
    public Result removeUnitHead(@RequestBody OrgUnitUser orgUnitUser) {
        return orgUnitService.removeUnitHead(orgUnitUser);
    }
}
