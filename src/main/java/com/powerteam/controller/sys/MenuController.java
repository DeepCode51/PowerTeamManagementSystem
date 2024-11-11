package com.powerteam.controller.sys;

import com.powerteam.controller.AuthorizedController;
import com.powerteam.model.sys.Menu;
import com.powerteam.model.sys.Role;
import com.powerteam.service.sys.MenuService;
import com.powerteam.vo.Result;
import com.powerteam.vo.TreeNode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller()
@RequestMapping("/menu")
public class MenuController extends AuthorizedController {

    @Autowired
    private MenuService menuService;

    @RequestMapping(value = "", method = RequestMethod.GET)
    public String index() {
        return "sys/menu";
    }

    @RequestMapping(value = "/findAllMenu", method = RequestMethod.POST)
    @ResponseBody
    public List<Menu> findAllMenu() {
        return menuService.findAllMenu();
    }

    @RequestMapping(value = "/findAllMenuTree", method = RequestMethod.POST)
    @ResponseBody
    public List<TreeNode<Menu>> findAllMenuTree() {
        return menuService.findAllMenuTree();
    }

    @RequestMapping(value = "/findUserMenuTree", method = RequestMethod.POST)
    @ResponseBody
    public List<TreeNode<Menu>> findUserMenuTree() {
        return menuService.findUserMenuTree(getUser().getUserId());
    }

    @RequestMapping(value = "/findRoleMenu", method = RequestMethod.POST)
    @ResponseBody
    public List<Menu> findRoleMenu(@RequestBody Role role) {
        return menuService.findRoleMenu(role.getRoleId());
    }

    @RequestMapping(value = "/checkMenuName", method = RequestMethod.POST)
    @ResponseBody
    public Result checkMenuName(@RequestBody Menu menu) {
        return menuService.checkMenuName(menu);
    }

    @RequestMapping(value = "/checkMenuCode", method = RequestMethod.POST)
    @ResponseBody
    public Result checkMenuCode(@RequestBody Menu menu) {
        return menuService.checkMenuCode(menu);
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    public Result add(@RequestBody Menu menu) {
        return menuService.insert(menu);
    }

    @RequestMapping(value = "/remove", method = RequestMethod.POST)
    @ResponseBody
    public Result remove(@RequestBody Menu menu) {
        return menuService.delete(menu.getMenuId());
    }

    @RequestMapping(value = "/findById", method = RequestMethod.POST)
    @ResponseBody
    public Menu findById(@RequestBody Menu menu) {
        return menuService.findById(menu.getMenuId());
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public Result update(@RequestBody Menu menu) {
        return menuService.update(menu);
    }

    @RequestMapping(value = "/up", method = RequestMethod.POST)
    @ResponseBody
    public Result up(@RequestBody Menu menu) {
        return menuService.up(menu.getMenuId());
    }

    @RequestMapping(value = "/down", method = RequestMethod.POST)
    @ResponseBody
    public Result down(@RequestBody Menu menu) {
        return menuService.down(menu.getMenuId());
    }
}
