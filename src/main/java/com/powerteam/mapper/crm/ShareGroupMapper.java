package com.powerteam.mapper.crm;

import com.powerteam.model.crm.ShareGroup;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ShareGroupMapper {

    int insertShareGroup(ShareGroup shareGroup);

    int deleteByResource(ShareGroup shareGroup);
}
