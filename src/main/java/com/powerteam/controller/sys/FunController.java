package com.powerteam.controller.sys;

import com.powerteam.model.sys.Fun;
import com.powerteam.service.sys.FunService;
import com.powerteam.vo.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/fun")
public class FunController {

    @Autowired
    private FunService funService;

    @RequestMapping(value = "/findAll", method = RequestMethod.POST)
    @ResponseBody
    public List<Fun> findAll() {
        return funService.findAll();
    }

    @RequestMapping(value = "/findFunInRole", method = RequestMethod.POST)
    @ResponseBody
    public List<Fun> findFunInRole(@RequestBody Integer roleId) {
        return funService.findFunInRole(roleId);
    }

    @RequestMapping(value = "/saveRoleFun", method = RequestMethod.POST)
    @ResponseBody
    public Result saveMenu(@RequestBody Map map) {
        return funService.saveRoleFun((Integer) map.get("roleId"), (List<Integer>) map.get("funIdList"));
    }
}
