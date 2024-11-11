package com.powerteam.controller.sys;

import com.github.pagehelper.PageInfo;
import com.powerteam.controller.AuthorizedController;
import com.powerteam.model.sys.User;
import com.powerteam.service.sys.UserService;
import com.powerteam.vo.Result;
import com.powerteam.vo.sys.QueryUserVo;
import com.powerteam.vo.sys.UpdatePasswordVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController extends AuthorizedController {

    @Autowired
    private UserService userService;

    @Autowired
    private HttpSession session;

    @RequestMapping(value = "", method = RequestMethod.GET)
    public String index() {
        return "sys/user";
    }

    @RequestMapping(value = "/find", method = RequestMethod.POST)
    @ResponseBody
    public PageInfo<User> find(@RequestBody QueryUserVo vo) {
        return userService.find(vo);
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    public Result add(@RequestBody User user) {
        return userService.insert(user);
    }

    @RequestMapping(value = "/remove", method = RequestMethod.POST)
    @ResponseBody
    public Result delete(@RequestBody List<Integer> ids) {
        return userService.deleteByIds(ids);
    }

    @RequestMapping(value = "/findById", method = RequestMethod.POST)
    @ResponseBody
    public User findById(@RequestBody User user) {
        return userService.findById(user.getUserId());
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public Result update(@RequestBody User user) {
        Result result = userService.update(user);
        if (result.isSuccess() && user.getUserId() == getUser().getUserId()) {
            session.setAttribute("User", userService.findById(getUser().getUserId()));
        }
        return result;
    }

    @RequestMapping(value = "/updateStatus", method = RequestMethod.POST)
    @ResponseBody
    public Result updateStatus(@RequestBody User user) {
        return userService.updateStatus(user);
    }

    @RequestMapping(value = "/checkUserName", method = RequestMethod.POST)
    @ResponseBody
    public Result checkUserName(@RequestBody User user) {
        return userService.checkUserName(user);
    }

    @RequestMapping(value = "/resetPassword", method = RequestMethod.POST)
    @ResponseBody
    public Result resetPassword(@RequestBody User user) {
        return userService.resetPassword(user);
    }

    @RequestMapping(value = "/profile", method = RequestMethod.GET)
    public String profile() {
        return "sys/profile";
    }

    @RequestMapping(value = "/updatePassword", method = RequestMethod.POST)
    @ResponseBody
    public Result updatePassword(@RequestBody UpdatePasswordVo vo) {
        return userService.updatePassword(vo);
    }
}