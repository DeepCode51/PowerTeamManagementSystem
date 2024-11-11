package com.powerteam.service.sys;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.powerteam.mapper.sys.UserMapper;
import com.powerteam.model.sys.User;
import com.powerteam.model.sys.UserStatus;
import com.powerteam.util.DateUtil;
import com.powerteam.vo.Result;
import com.powerteam.vo.ResultData;
import com.powerteam.vo.sys.QueryUserVo;
import com.powerteam.vo.sys.UpdatePasswordVo;
import org.mybatis.spring.MyBatisSystemException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.Date;
import java.util.List;

@Service
public class UserService {

    @Autowired
    private UserMapper userMapper;

    /**
     * 用户登陆
     *
     * @param user 用户名和密码
     * @return
     */
    public ResultData<User> signIn(User user) {
        ResultData<User> result = new ResultData<>();

        try {
            user = userMapper.signIn(user);
        } catch (MyBatisSystemException ex) {
            result.setMessage("数据库连接异常，请检查数据库连接配置。");
            return result;
        }

        if (user != null) {
            switch (user.getStatus()) {
                case UserStatus.启用:
                    result.setData(user);
                    result.setSuccess(true);
                    break;
                case UserStatus.禁用:
                    result.setMessage("当前用户已禁用,请联系管理员!");
                    break;
            }
        } else {
            result.setMessage("用户名密码错误!");
        }

        return result;
    }

    /**
     * 检查用户名是否重复
     *
     * @param user
     * @return
     */
    public Result checkUserName(User user) {
        return new Result(!userMapper.existUserName(user));
    }

    /**
     * 新增用户
     *
     * @param user 用户信息
     * @return
     */
    @Transactional
    public Result insert(User user) {
        user.setCreateAt(new Date());
        user.setStatus(UserStatus.启用);

        Result result = new Result();

        if (!checkUserName(user).isSuccess()) {
            result.setMessage("用户名重复");
            return result;
        }

        result.setSuccess(userMapper.insert(user) > 0);

        return result;
    }

    /**
     * 用户查询
     *
     * @param vo 查询条件
     * @return
     */
    public PageInfo<User> find(QueryUserVo vo) {
        if (vo.getStartDate() != null) {
            vo.setStartDate(DateUtil.toStartDate(vo.getStartDate()));
        }

        if (vo.getEndDate() != null) {
            vo.setEndDate(DateUtil.toEndDate(vo.getEndDate()));
        }

        if (!StringUtils.isEmpty(vo.getWord())) {
            vo.setWord("%" + vo.getWord() + "%");
        }

        if (!vo.isDisablePaging()) {
            PageHelper.startPage(vo.getPageNum(), vo.getPageSize());
        }
        return new PageInfo<>(userMapper.find(vo));
    }

    /**
     * 批量删除用户
     *
     * @param ids 用户Id列表
     * @return
     */
    @Transactional
    public Result deleteByIds(List<Integer> ids) {
        Result result = new Result();
        result.setSuccess(userMapper.deleteByIds(ids) > 0);
        return result;
    }

    /**
     * 根据用户Id获取用户信息
     *
     * @param userId 用户Id
     * @return
     */
    public User findById(Integer userId) {
        return userMapper.findById(userId);
    }

    /**
     * 更新用户
     *
     * @param user 用户信息
     * @return
     */
    @Transactional
    public Result update(User user) {
        Result result = new Result();
        result.setSuccess(userMapper.update(user) > 0);
        return result;
    }

    /**
     * 更新用户状态 (启用/禁用)
     *
     * @param user
     * @return
     */
    @Transactional
    public Result updateStatus(User user) {
        User model = this.findById(user.getUserId());
        if (model != null) {
            model.setStatus(user.getStatus());
            return update(model);
        } else {
            return new Result();
        }
    }

    /**
     * 重置密码
     *
     * @param user 用户Id
     * @return
     */
    @Transactional
    public Result resetPassword(User user) {
        user.setPassword("123456");
        Result result = new Result();
        result.setSuccess(userMapper.resetPassword(user) > 0);
        return result;
    }

    /**
     * 修改密码
     *
     * @param user
     * @return
     */
    @Transactional
    public Result updatePassword(UpdatePasswordVo user) {
        Result result = new Result();
        User rawUser = userMapper.findWithPasswordById(user.getUserId());
        if (rawUser.getPassword().equals(user.getRawPassword())) {
            result.setSuccess(userMapper.resetPassword(user) > 0);
        } else {
            result.setMessage("原密码不正确");
        }
        return result;
    }
}