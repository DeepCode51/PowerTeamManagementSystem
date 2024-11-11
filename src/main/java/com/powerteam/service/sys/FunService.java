package com.powerteam.service.sys;

import com.powerteam.mapper.sys.FunMapper;
import com.powerteam.model.sys.Fun;
import com.powerteam.model.sys.RoleFun;
import com.powerteam.vo.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class FunService {

    @Autowired
    private FunMapper funMapper;

    /**
     * 获取某用户所拥有的功能权限
     *
     * @param userId
     * @return
     */
    public List<Fun> findUserFunList(int userId) {
        return funMapper.findUserFunList(userId);
    }

    /**
     * 获取系统中全部的功能权限
     *
     * @return
     */
    public List<Fun> findAll() {
        return funMapper.findAll();
    }

    /**
     * 获取角色中的权限列表
     *
     * @param roleId
     * @return
     */
    public List<Fun> findFunInRole(Integer roleId) {
        return funMapper.findFunInRole(roleId);
    }

    /**
     * 批量分配功能到某角色中
     *
     * @param roleId
     * @param funIdList
     * @return
     */
    @Transactional
    public Result saveRoleFun(Integer roleId, List<Integer> funIdList) {
        Result result = new Result();
        try {
            funMapper.deleteRoleFun(roleId);
            if (funIdList != null) {
                for (Integer funId : funIdList) {
                    RoleFun roleFun = new RoleFun();
                    roleFun.setRoleId(roleId);
                    roleFun.setFunId(funId);
                    funMapper.insertRoleFun(roleFun);
                }
            }
            result.setSuccess(true);
        } catch (Exception e) {
            result.setSuccess(false);
        }

        return result;
    }
}