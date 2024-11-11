package com.powerteam.controller.sys;

import com.powerteam.config.PowerTeamConfig;
import com.powerteam.interceptor.annotation.RequireSession;
import com.powerteam.model.sys.User;
import com.powerteam.service.sys.UserService;
import com.powerteam.vo.ResultData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

@Controller
public class HomeController {

    @Autowired
    private HttpSession session;

    @Autowired
    private UserService userService;

    @Autowired
    private PowerTeamConfig powerTeamConfig;


    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String signIn() {
        return "sys/home";
    }

    @RequestMapping(value = "/signIn", method = RequestMethod.POST)
    @ResponseBody
    public ResultData<User> signIn(@RequestBody User user) {
        ResultData<User> result = userService.signIn(user);
        if (result.isSuccess()) {
            user = result.getData();
            session.setAttribute("User", user);
        }
        return result;
    }

    @RequestMapping(value = "/signOut", method = RequestMethod.GET)
    @RequireSession
    public String signOut() {
        session.invalidate();
        return "redirect:" + powerTeamConfig.getWebRoot();
    }

}
