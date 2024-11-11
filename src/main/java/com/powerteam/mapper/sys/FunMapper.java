package com.powerteam.mapper.sys;


import com.powerteam.model.sys.Fun;
import com.powerteam.model.sys.RoleFun;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface FunMapper {

    List<Fun> findUserFunList(int userId);

    List<Fun> findAll();

    List<Fun> findFunInRole(Integer roleId);

    int deleteRoleFun(Integer roleId);

    int insertRoleFun(RoleFun roleFun);
}
