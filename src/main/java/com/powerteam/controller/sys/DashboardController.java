package com.powerteam.controller.sys;

import com.powerteam.controller.AuthorizedController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/dashboard")
public class DashboardController extends AuthorizedController {

    @RequestMapping(value = "", method = RequestMethod.GET)
    public String dashboard() {
        return "sys/dashboard";
    }

}