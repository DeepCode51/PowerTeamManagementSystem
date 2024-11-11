package com.powerteam.service.crm;

import com.powerteam.mapper.crm.ShareGroupMapper;
import com.powerteam.model.crm.ShareGroup;
import com.powerteam.vo.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ShareGroupService {

    @Autowired
    private ShareGroupMapper shareGroupMapper;

    @Transactional
    public Result insert(ShareGroup shareGroup) {
        Result result = new Result();
        result.setSuccess(shareGroupMapper.insertShareGroup(shareGroup) > 0);
        return result;
    }

    @Transactional
    public Result deleteByResource(ShareGroup shareGroup) {
        Result result = new Result();

        try {
            shareGroupMapper.deleteByResource(shareGroup);
            result.setSuccess(true);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
}
