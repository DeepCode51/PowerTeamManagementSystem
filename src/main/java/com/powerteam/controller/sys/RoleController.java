package com.powerteam.controller.sys;

import com.github.pagehelper.PageInfo;
import com.powerteam.controller.AuthorizedController;
import com.powerteam.model.sys.Role;
import com.powerteam.model.sys.RoleUser;
import com.powerteam.model.sys.User;
import com.powerteam.service.sys.RoleService;
import com.powerteam.vo.Result;
import com.powerteam.vo.sys.QueryRoleUserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/role")
public class RoleController extends AuthorizedController {

    @Autowired
    private RoleService roleService;

    @RequestMapping(value = "", method = RequestMethod.GET)
    public String index() {
        return "sys/role";
    }

    @RequestMapping(value = "/findAll", method = RequestMethod.POST)
    @ResponseBody
    public List<Role> findAll() {
        return roleService.findAll();
    }

    @RequestMapping(value = "/checkRoleName", method = RequestMethod.POST)
    @ResponseBody
    public Result existRoleName(@RequestBody Role role) {
        return roleService.checkRoleName(role);
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    public Result add(@RequestBody Role role) {
        return roleService.insert(role);
    }

    @RequestMapping(value = "/remove", method = RequestMethod.POST)
    @ResponseBody
    public Result delete(@RequestBody List<Integer> ids) {
        return roleService.deleteByIds(ids);
    }

    @RequestMapping(value = "/findById", method = RequestMethod.POST)
    @ResponseBody
    public Role findById(@RequestBody Role role) {
        return roleService.findById(role.getRoleId());
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public Result update(@RequestBody Role role) {
        return roleService.update(role);
    }

    @RequestMapping(value = "/user/{roleId}", method = RequestMethod.GET)
    public ModelAndView roleUser(@PathVariable int roleId) {
        ModelAndView vm = new ModelAndView("sys/roleUser");
        vm.addObject("roleId", roleId);
        return vm;
    }

    @RequestMapping(value = "/user/findUserInRole", method = RequestMethod.POST)
    @ResponseBody
    public PageInfo<User> findUserInRole(@RequestBody QueryRoleUserVo vo) {
        return roleService.findUserInRole(vo);
    }

    @RequestMapping(value = "/user/remove", method = RequestMethod.POST)
    @ResponseBody
    public Result deleteRoleUser(@RequestBody RoleUser roleUser) {
        return roleService.deleteRoleUser(roleUser);
    }

    @RequestMapping(value = "/user/findUserNotInRole", method = RequestMethod.POST)
    @ResponseBody
    public PageInfo<User> findUserNotInRole(@RequestBody QueryRoleUserVo vo) {
        return roleService.findUserNotInRole(vo);
    }

    @RequestMapping(value = "/user/add", method = RequestMethod.POST)
    @ResponseBody
    public Result addRoleUser(@RequestBody RoleUser roleUser) {
        return roleService.insertRoleUser(roleUser);
    }

    @RequestMapping(value = "/menu/{roleId}", method = RequestMethod.GET)
    public ModelAndView roleMenu(@PathVariable Integer roleId) {
        ModelAndView mv = new ModelAndView("sys/roleMenu");
        mv.addObject("roleId", roleId);
        return mv;
    }

    @RequestMapping(value = "/menu/saveMenu", method = RequestMethod.POST)
    @ResponseBody
    public Result saveMenu(@RequestBody Map map) {
        return roleService.saveRoleMenu((Integer) map.get("roleId"), (List<Integer>) map.get("menuIdList"));
    }

    @RequestMapping(value = "/fun/{roleId}", method = RequestMethod.GET)
    public ModelAndView roleFun(@PathVariable int roleId) {
        ModelAndView vm = new ModelAndView("sys/roleFun");
        vm.addObject("roleId", roleId);
        return vm;
    }
}