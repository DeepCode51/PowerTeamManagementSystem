package com.powerteam.service.sys;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.powerteam.mapper.sys.RoleMapper;
import com.powerteam.model.sys.Role;
import com.powerteam.model.sys.RoleMenu;
import com.powerteam.model.sys.RoleUser;
import com.powerteam.model.sys.User;
import com.powerteam.vo.Result;
import com.powerteam.vo.sys.QueryRoleUserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.List;

@Service
public class RoleService {

    @Autowired
    private RoleMapper roleMapper;

    /**
     * 查询所有角色
     *
     * @return
     */
    public List<Role> findAll() {
        return roleMapper.findAll();
    }

    /**
     * 检查角色名称是否重复
     *
     * @param role
     * @return
     */
    public Result checkRoleName(Role role) {
        return new Result(!roleMapper.existRoleName(role));
    }

    /**
     * 新增角色
     *
     * @param role
     * @return
     */
    @Transactional
    public Result insert(Role role) {
        role.setIsSystemRole(false);

        Result result = new Result();

        if (!checkRoleName(role).isSuccess()) {
            result.setMessage("角色名称已存在");
            return result;
        }

        result.setSuccess(roleMapper.insert(role) > 0);
        return result;
    }

    /**
     * 批量删除角色
     *
     * @param ids 角色Id列表
     * @return
     */
    @Transactional
    public Result deleteByIds(List<Integer> ids) {
        Result result = new Result();
        result.setSuccess(roleMapper.deleteByIds(ids) > 0);
        return result;
    }

    /**
     * 根据角色Id获取角色信息
     *
     * @param roleId
     * @return
     */
    public Role findById(Integer roleId) {
        return roleMapper.findById(roleId);
    }

    /**
     * 更新角色
     *
     * @param role
     * @return
     */
    @Transactional
    public Result update(Role role) {
        Result result = new Result();
        result.setSuccess(roleMapper.update(role) > 0);
        return result;
    }

    /**
     * 查询在某角色中的用户列表(分页)
     *
     * @param vo
     * @return
     */
    public PageInfo<User> findUserInRole(QueryRoleUserVo vo) {
        if (!StringUtils.isEmpty(vo.getWord())) {
            vo.setWord("%" + vo.getWord() + "%");
        }

        if (!vo.isDisablePaging()) {
            PageHelper.startPage(vo.getPageNum(), vo.getPageSize());
        }
        return new PageInfo<>(roleMapper.findUserInRole(vo));
    }

    /**
     * 把用户从某角色中移除
     *
     * @param roleUser
     * @return
     */
    @Transactional
    public Result deleteRoleUser(RoleUser roleUser) {
        return new Result(roleMapper.deleteRoleUser(roleUser) > 0);
    }

    /**
     * 查询还未加入到某角色中的用户列表(分页)
     *
     * @param vo
     * @return
     */
    public PageInfo<User> findUserNotInRole(QueryRoleUserVo vo) {
        if (!StringUtils.isEmpty(vo.getWord())) {
            vo.setWord("%" + vo.getWord() + "%");
        }

        if (!vo.isDisablePaging()) {
            PageHelper.startPage(vo.getPageNum(), vo.getPageSize());
        }
        return new PageInfo<>(roleMapper.findUserNotInRole(vo));
    }

    /**
     * 分配某用户到某角色中
     *
     * @param roleUser
     * @return
     */
    @Transactional
    public Result insertRoleUser(RoleUser roleUser) {
        return new Result(roleMapper.insertRoleUser(roleUser) > 0);
    }

    /**
     * 把菜单从某角色中移除
     *
     * @param roleId
     * @return
     */
    @Transactional
    public Result deleteRoleMenu(Integer roleId) {
        return new Result(roleMapper.deleteRoleMenu(roleId) > 0);
    }

    /**
     * 分配菜单到某角色中
     *
     * @param roleMenu
     * @return
     */
    @Transactional
    public Result insertRoleMenu(RoleMenu roleMenu) {
        return new Result(roleMapper.insertRoleMenu(roleMenu) > 0);
    }

    /**
     * 批量分配菜单到某角色中
     *
     * @param roleId
     * @param menuIdList
     * @return
     */
    @Transactional
    public Result saveRoleMenu(Integer roleId, List<Integer> menuIdList) {
        Result result = new Result();
        try {
            this.deleteRoleMenu(roleId);
            if (menuIdList != null) {
                for (Integer menuId : menuIdList) {
                    RoleMenu roleMenu = new RoleMenu();
                    roleMenu.setRoleId(roleId);
                    roleMenu.setMenuId(menuId);
                    this.insertRoleMenu(roleMenu);
                }
            }
            result.setSuccess(true);
        } catch (Exception e) {
            result.setSuccess(false);
        }

        return result;
    }
}
