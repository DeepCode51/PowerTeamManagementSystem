package com.powerteam.service.crm;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.powerteam.mapper.crm.OpportunityMapper;
import com.powerteam.model.crm.*;
import com.powerteam.util.DateUtil;
import com.powerteam.vo.Result;
import com.powerteam.vo.crm.QueryOpportunityVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.*;

@Service
public class OpportunityService {

    @Autowired
    private OpportunityMapper opportunityMapper;

    @Autowired
    private ShareGroupService shareGroupService;

    @Autowired
    private ActivityService activityService;

    @Transactional
    public Result insert(Opportunity opportunity) {
        Result result = new Result();

        opportunity.setPossibility(0f);
        opportunity.setCreateDate(new Date());
        opportunity.setOwner(opportunity.getCreateBy());
        opportunity.setPhase(OpportunityPhase.初步接触);

        if (opportunityMapper.insert(opportunity) > 0) {
            ShareGroup shareGroup = new ShareGroup();
            shareGroup.setResourceType(ResourceType.业务机会);
            shareGroup.setResourceId(opportunity.getOpportunityId());
            shareGroup.setUserId(opportunity.getCreateBy());

            if (shareGroupService.insert(shareGroup).isSuccess()) {

                Activity activity = new Activity();
                activity.setResourceType(ResourceType.业务机会);
                activity.setResourceId(opportunity.getOpportunityId());
                activity.setActivityType(ActivityType.系统跟踪);
                activity.setContent("创建了业务机会");
                activity.setCreateDate(new Date());
                activity.setCreateBy(opportunity.getCreateBy());

                if (activityService.insert(activity).isSuccess()) {
                    result.setSuccess(true);
                } else {
                    result.setMessage("新增业务机会失败");
                }
            } else {
                result.setMessage("新增业务机会失败");
            }
        } else {
            result.setMessage("新增业务机会失败");
        }

        return result;
    }

    public PageInfo<Opportunity> find(QueryOpportunityVo vo) {
        if (!vo.isDisablePaging()) {
            PageHelper.startPage(vo.getPageNum(), vo.getPageSize());
        }

        if (!StringUtils.isEmpty(vo.getWord())) {
            vo.setWord("%" + vo.getWord() + "%");
        }
        return new PageInfo<>(opportunityMapper.find(vo));
    }

    public Opportunity findById(Integer opportunityId) {
        return opportunityMapper.findById(opportunityId);
    }

    @Transactional
    public Result update(Opportunity opportunity) {
        Result result = new Result();

        if (opportunity.getPhase() == OpportunityPhase.关闭) {
            if (opportunity.getWin().equals(true)) {
                opportunity.setLossReason(null);
            }
            opportunity.setCloseDate(new Date());
        } else {
            opportunity.setWin(null);
            opportunity.setLossReason(null);
            opportunity.setCloseDate(null);
        }
        result.setSuccess(opportunityMapper.update(opportunity) > 0);
        return result;
    }

    @Transactional
    public Result insertContactsRole(ContactsRole contactsRole) {
        Result result = new Result();
        contactsRole.setRole(ContactsRoleType.联络人);
        result.setSuccess(opportunityMapper.insertContactsRole(contactsRole) > 0);
        return result;
    }

    @Transactional
    public Result updateContactsRole(ContactsRole contactsRole) {
        Result result = new Result();
        result.setSuccess(opportunityMapper.updateContactsRole(contactsRole) > 0);
        return result;
    }

    @Transactional
    public Result deleteContactsRole(ContactsRole contactsRole) {
        Result result = new Result();
        result.setSuccess(opportunityMapper.deleteContactsRole(contactsRole) > 0);
        return result;
    }

    @Transactional
    public Result delete(Opportunity opportunity) {
        Result result = new Result();

        ShareGroup shareGroup = new ShareGroup();
        shareGroup.setResourceType(ResourceType.业务机会);
        shareGroup.setResourceId(opportunity.getOpportunityId());

        if (!shareGroupService.deleteByResource(shareGroup).isSuccess()) {
            return result;
        }

        Activity activity = new Activity();
        activity.setResourceType(ResourceType.业务机会);
        activity.setResourceId(opportunity.getOpportunityId());
        if (!activityService.deleteByResource(activity).isSuccess()) {
            return result;
        }

        if (opportunityMapper.delete(opportunity) > 0) {
            result.setSuccess(true);
        }
        return result;
    }

    public List<Map> findMonthlyFunnel(QueryOpportunityVo vo) {

        List<Byte> phaseList = new ArrayList<>();
        phaseList.add(OpportunityPhase.初步接触);
        phaseList.add(OpportunityPhase.需求分析);
        phaseList.add(OpportunityPhase.协商方案);
        phaseList.add(OpportunityPhase.商业谈判);
        phaseList.add(OpportunityPhase.关闭);
        vo.setPhaseList(phaseList);

        vo.setStartCreateDate(DateUtil.firstDayInMonth());
        vo.setEndCreateDate(DateUtil.lastDayInMonth());

        return opportunityMapper.findMonthlyFunnel(vo);
    }

    public List<Map> findMonthlyConversion(QueryOpportunityVo vo) {

        vo.setStartCreateDate(DateUtil.firstDayInMonth());
        vo.setEndCreateDate(DateUtil.lastDayInMonth());

        return opportunityMapper.findMonthlyConversion(vo);
    }

    public List<Opportunity> findRecentlyClosing(QueryOpportunityVo vo) {

        List<Byte> phaseList = new ArrayList<>();
        phaseList.add(OpportunityPhase.初步接触);
        phaseList.add(OpportunityPhase.需求分析);
        phaseList.add(OpportunityPhase.协商方案);
        phaseList.add(OpportunityPhase.商业谈判);
        vo.setPhaseList(phaseList);

        vo.setEndDate(DateUtil.toEndDate(DateUtil.addDays(new Date(), 7)));

        return opportunityMapper.findRecentlyClosing(vo);
    }
}
