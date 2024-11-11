package com.powerteam.controller.crm;

import com.github.pagehelper.PageInfo;
import com.powerteam.controller.AuthorizedController;
import com.powerteam.model.crm.Activity;
import com.powerteam.service.crm.ActivityService;
import com.powerteam.service.masterData.OrgUnitService;
import com.powerteam.vo.Result;
import com.powerteam.vo.crm.QueryActivityVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/activity")
public class ActivityController extends AuthorizedController {

    @Autowired
    private ActivityService activityService;

    @Autowired
    private OrgUnitService orgUnitService;

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    public Result add(@RequestBody Activity activity) {
        activity.setCreateBy(getUser().getUserId());
        return activityService.insert(activity);
    }

    @RequestMapping(value = "/find", method = RequestMethod.POST)
    @ResponseBody
    public PageInfo<Activity> find(@RequestBody QueryActivityVo vo) {
        return activityService.find(vo);
    }

    @RequestMapping(value = "/findMyDailyReport", method = RequestMethod.POST)
    @ResponseBody
    public PageInfo<Activity> findMyDailyReport(@RequestBody QueryActivityVo vo) {
        List<Integer> createBy = new ArrayList<>();
        createBy.add(getUser().getUserId());
        vo.setCreateBy(createBy);
        return activityService.find(vo);
    }

    @RequestMapping(value = "/findTeamDailyReport", method = RequestMethod.POST)
    @ResponseBody
    public PageInfo<Activity> findTeamDailyReport(@RequestBody QueryActivityVo vo) {
        List<Integer> subordinate = orgUnitService.findSubordinate(getUser().getUserId());
        vo.setCreateBy(subordinate);
        return activityService.find(vo);
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public Result delete(@RequestBody Activity activity) {
        return activityService.delete(activity);
    }
}
