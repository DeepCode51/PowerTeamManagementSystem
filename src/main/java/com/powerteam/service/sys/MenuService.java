package com.powerteam.service.sys;


import com.powerteam.mapper.sys.MenuMapper;
import com.powerteam.model.sys.Menu;
import com.powerteam.vo.Result;
import com.powerteam.vo.TreeNode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class MenuService {

    @Autowired
    private MenuMapper menuMapper;

    /**
     * 内部使用 递归菜单树
     *
     * @param pid   父Id
     * @param menus 菜单列表
     * @return
     */
    private List<TreeNode<Menu>> findMenuTree(int pid, List<Menu> menus) {
        List<TreeNode<Menu>> result = new ArrayList<>();

        menus.stream().filter(menu -> menu.getPid() != null && menu.getPid() == pid).sorted((e1, e2) -> e1.getMenuIndex().compareTo(e2.getMenuIndex())).forEach(child -> {
            TreeNode<Menu> node = new TreeNode<>();
            node.setNode(child);
            node.setChildren(findMenuTree(child.getMenuId(), menus));
            result.add(node);
        });

        return result;
    }

    /**
     * 查询某用户拥有的菜单(列表)
     *
     * @param userId
     * @return
     */
    public List<Menu> findUserMenuList(int userId) {
        return menuMapper.findUserMenuList(userId);
    }

    /**
     * 查询某用户拥有的菜单(树形)
     *
     * @param userId
     * @return
     */
    public List<TreeNode<Menu>> findUserMenuTree(Integer userId) {

        List<Menu> menus = menuMapper.findUserMenuList(userId);
        Optional<Menu> root = menus.stream().filter(menu -> menu.getPid() == null).findAny();
        if (root.isPresent()) {
            return findMenuTree(root.get().getMenuId(), menus);
        }

        return new ArrayList<>();
    }

    /**
     * 查询所有菜单(列表)
     *
     * @return
     */
    public List<Menu> findAllMenu() {
        return menuMapper.findAllMenu();
    }

    /**
     * 查询所有菜单(树形)
     *
     * @return
     */
    public List<TreeNode<Menu>> findAllMenuTree() {
        List<Menu> menus = findAllMenu();
        Optional<Menu> root = menus.stream().filter(menu -> menu.getPid() == null).findAny();
        if (root.isPresent()) {
            return findMenuTree(root.get().getMenuId(), menus);
        }
        return new ArrayList<>();
    }

    /**
     * 查询某角色的菜单列表(列表)
     *
     * @param roleId
     * @return
     */
    public List<Menu> findRoleMenu(Integer roleId) {
        return menuMapper.findRoleMenu(roleId);
    }

    /**
     * 检查菜单名称是否重复
     *
     * @param menu
     * @return
     */
    public Result checkMenuName(Menu menu) {
        return new Result(!menuMapper.existMenuName(menu));
    }

    /**
     * 检查菜单编码是否重复
     *
     * @param menu
     * @return
     */
    public Result checkMenuCode(Menu menu) {
        return new Result(!menuMapper.existMenuCode(menu));
    }

    /**
     * 新增菜单
     *
     * @param menu
     * @return
     */
    @Transactional
    public Result insert(Menu menu) {
        menu.setMenuIndex(menuMapper.findMaxMenuIndex() + 1);
        return new Result(menuMapper.insert(menu) > 0);
    }

    /**
     * 删除菜单
     *
     * @param menuId
     * @return
     */
    @Transactional
    public Result delete(Integer menuId) {
        menuMapper.deleteChildren(menuId);
        return new Result(menuMapper.delete(menuId) > 0);
    }

    /**
     * 根据菜单Id获取菜单信息
     *
     * @param menuId
     * @return
     */
    public Menu findById(Integer menuId) {
        return menuMapper.findById(menuId);
    }

    /**
     * 更新菜单
     *
     * @param menu
     * @return
     */
    @Transactional
    public Result update(Menu menu) {
        return new Result(menuMapper.update(menu) > 0);
    }

    /**
     * 找到某菜单的前一个菜单
     *
     * @param menuId
     * @return
     */
    public Menu findPreviousMenu(Integer menuId) {
        return menuMapper.findPreviousMenu(menuId);
    }

    /**
     * 找到某菜单的下一个菜单
     *
     * @param menuId
     * @return
     */
    public Menu findNextMenu(Integer menuId) {
        return menuMapper.findNextMenu(menuId);
    }

    /**
     * 上调菜单
     *
     * @param menuId
     * @return
     */
    @Transactional
    public Result up(Integer menuId) {
        Menu previousMenu = this.findPreviousMenu(menuId);
        if (previousMenu != null) {
            Menu menu = this.findById(menuId);
            int tempMenuIndex = 0;
            tempMenuIndex = menu.getMenuIndex();
            menu.setMenuIndex(previousMenu.getMenuIndex());
            previousMenu.setMenuIndex(tempMenuIndex);

            this.update(menu);
            this.update(previousMenu);
        }
        return new Result(true);
    }

    /**
     * 下调菜单
     *
     * @param menuId
     * @return
     */
    @Transactional
    public Result down(Integer menuId) {
        Menu nextMenu = this.findNextMenu(menuId);
        if (nextMenu != null) {
            Menu menu = this.findById(menuId);
            int tempMenuIndex = 0;
            tempMenuIndex = menu.getMenuIndex();
            menu.setMenuIndex(nextMenu.getMenuIndex());
            nextMenu.setMenuIndex(tempMenuIndex);

            this.update(menu);
            this.update(nextMenu);
        }
        return new Result(true);
    }
}
