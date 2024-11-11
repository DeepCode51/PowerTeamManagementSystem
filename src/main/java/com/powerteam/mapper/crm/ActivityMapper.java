package com.powerteam.mapper.crm;

import com.powerteam.model.crm.Activity;
import com.powerteam.vo.crm.QueryActivityVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ActivityMapper {

    int insert(Activity activity);

    List<Activity> find(QueryActivityVo vo);

    int deleteByResource(Activity activity);

    int delete(Activity activity);
}
