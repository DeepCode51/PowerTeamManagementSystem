package com.powerteam.mapper.sys;

import com.powerteam.model.sys.Menu;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface MenuMapper {

    List<Menu> findUserMenuList(int userId);

    List<Menu> findAllMenu();

    List<Menu> findRoleMenu(Integer roleId);

    Boolean existMenuName(Menu menu);

    Boolean existMenuCode(Menu menu);

    int insert(Menu menu);

    int findMaxMenuIndex();

    int deleteChildren(Integer menuId);

    int delete(Integer menuId);

    Menu findPreviousMenu(Integer menuId);

    Menu findNextMenu(Integer menuId);

    Menu findById(Integer menuId);

    int update(Menu menu);

}
