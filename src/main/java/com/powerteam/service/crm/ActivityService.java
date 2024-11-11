package com.powerteam.service.crm;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.powerteam.mapper.crm.ActivityMapper;
import com.powerteam.model.crm.Activity;
import com.powerteam.vo.Result;
import com.powerteam.vo.crm.QueryActivityVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;

@Service
public class ActivityService {

    @Autowired
    private ActivityMapper activityMapper;

    @Transactional
    public Result insert(Activity activity) {
        if (activity.getCreateDate() == null) {
            activity.setCreateDate(new Date());
        }
        Result result = new Result();
        result.setSuccess(activityMapper.insert(activity) > 0);
        return result;
    }

    public PageInfo<Activity> find(QueryActivityVo vo) {
        if (!vo.isDisablePaging()) {
            PageHelper.startPage(vo.getPageNum(), vo.getPageSize());
        }
        return new PageInfo<>(activityMapper.find(vo));
    }

    @Transactional
    public Result deleteByResource(Activity activity) {
        Result result = new Result();

        try {
            activityMapper.deleteByResource(activity);
            result.setSuccess(true);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    @Transactional
    public Result delete(Activity activity) {
        return new Result(activityMapper.delete(activity) > 0);
    }

}
