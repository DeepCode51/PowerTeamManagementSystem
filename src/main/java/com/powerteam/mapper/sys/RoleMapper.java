package com.powerteam.mapper.sys;

import com.powerteam.model.sys.Role;
import com.powerteam.model.sys.RoleMenu;
import com.powerteam.model.sys.RoleUser;
import com.powerteam.model.sys.User;
import com.powerteam.vo.sys.QueryRoleUserVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface RoleMapper {

    List<Role> findAll();

    Boolean existRoleName(Role role);

    int insert(Role role);

    int deleteByIds(List<Integer> ids);

    Role findById(Integer roleId);

    int update(Role role);

    List<User> findUserInRole(QueryRoleUserVo vo);

    int deleteRoleUser(RoleUser roleUser);

    List<User> findUserNotInRole(QueryRoleUserVo vo);

    int insertRoleUser(RoleUser roleUser);

    int deleteRoleMenu(Integer roleId);

    int insertRoleMenu(RoleMenu roleMenu);
}
