package com.powerteam.mapper.sys;

import com.powerteam.model.sys.User;
import com.powerteam.vo.sys.QueryUserVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface UserMapper {

    User signIn(User user);

    Boolean existUserName(User user);

    int insert(User user);

    List<User> find(QueryUserVo vo);

    int deleteByIds(List<Integer> ids);

    User findById(Integer userId);

    User findWithPasswordById(Integer userId);

    int update(User user);

    int resetPassword(User user);
}
