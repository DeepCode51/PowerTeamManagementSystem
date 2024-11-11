package com.powerteam.controller.crm;

import com.powerteam.controller.AuthorizedController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class DailyReportController extends AuthorizedController {

    @RequestMapping(value = "/dailyReport", method = RequestMethod.GET)
    public String dailyReport() {
        return "crm/dailyReport";
    }

    @RequestMapping(value = "/teamDailyReport", method = RequestMethod.GET)
    public String teamDailyReport() {
        return "crm/teamDailyReport";
    }
}
