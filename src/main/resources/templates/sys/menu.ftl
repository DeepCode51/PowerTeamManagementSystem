<#import "../shared/layout.ftl" as Base>
<#macro header>
<script src="js/controller/sys/menu.js"></script>
</#macro>
<@Base.Layout header=header>
<section class="content-header">
    <h1>
        菜单管理
    </h1>
    <ol class="breadcrumb">
        <li><i class="fa fa-cogs"></i> 系统管理</li>
        <li class="active">菜单管理</li>
    </ol>
</section>
<section class="content" ng-controller="menu" ng-init="init();">
    <div class="row">
        <div class="col-xs-12">
            <div class="box box-widget">
                <div class="box-header">
                    <button type="button" class="btn btn-primary btn-sm" ng-click="showAdd()"><i class="fa fa-plus"></i> 新菜单</button>
                </div>
                <div class="box-body table-responsive no-padding">
                    <table class="table table-hover">
                        <tbody>
                        <tr>
                            <th>菜单名称</th>
                            <th>菜单代码</th>
                            <th>链接</th>
                            <th>操作</th>
                        </tr>
                        <tr ng-repeat-start="parent in menuTree">
                            <td><i ng-class="parent.node.menuIcon"></i> {{parent.node.menuName}}</td>
                            <td>{{parent.node.menuCode}}</td>
                            <td>{{parent.node.menuLink}}</td>
                            <td>
                                <button type="button" class="btn btn-primary btn-xs" ng-click="showEdit(parent.node.menuId)"><i class="fa fa-edit"></i> 编辑</button>
                                <button type="button" class="btn btn-success btn-xs" ng-click="up(parent.node.menuId)"><i class="fa fa-long-arrow-up"></i> 上调</button>
                                <button type="button" class="btn btn-warning btn-xs" ng-click="down(parent.node.menuId)"><i class="fa fa-long-arrow-down"></i> 下调</button>
                                <button type="button" class="btn btn-danger btn-xs" ng-click="remove(parent.node.menuId)"><i class="fa fa-trash-o"></i> 删除</button>
                            </td>
                        </tr>
                        <tr ng-repeat="child in parent.children" ng-repeat-end>
                            <td><span ng-repeat="n in [] | range:8">&nbsp;</span> <i ng-class="child.node.menuIcon"></i> {{child.node.menuName}}</td>
                            <td><span ng-repeat="n in [] | range:8">&nbsp;</span> {{child.node.menuCode}}</td>
                            <td>{{child.node.menuLink}}</td>
                            <td><span ng-repeat="n in [] | range:8">&nbsp;</span>
                                <button type="button" class="btn btn-primary btn-xs" ng-click="showEdit(child.node.menuId)"><i class="fa fa-edit"></i> 编辑</button>
                                <button type="button" class="btn btn-success btn-xs" ng-click="up(child.node.menuId)"><i class="fa fa-long-arrow-up"></i> 上调</button>
                                <button type="button" class="btn btn-warning btn-xs" ng-click="down(child.node.menuId)"><i class="fa fa-long-arrow-down"></i> 下调</button>
                                <button type="button" class="btn btn-danger btn-xs" ng-click="remove(child.node.menuId)"><i class="fa fa-trash-o"></i> 删除</button>
                            </td>
                        </tr>
                        <tr ng-show="menuTree==null || menuTree.length==0">
                            <td class="text-center text-muted" colspan="4">
                                <#include "../shared/noData.ftl">
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <script type="text/ng-template" id="Add.html">
        <div class="modal-dialog" role="document" ng-init="init();">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" ng-click="cancel()"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">添加新菜单</h4>
                </div>
                <div class="modal-body">
                    <form role="form" name="form" novalidate>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <label>上级菜单 <span class="text-red">*</span></label>
                                    <ui-select ng-model="Model.selectedMenu" on-select="Model.pid=Model.selectedMenu.menuId;Model.menuLink=null;">
                                        <ui-select-match placeholder="请选择上级菜单">{{Model.selectedMenu.menuName}}</ui-select-match>
                                        <ui-select-choices repeat="menu in parentMenuList">
                                            <i ng-class="menu.menuIcon"></i><span> {{menu.menuName}}</span>
                                        </ui-select-choices>
                                    </ui-select>
                                </div>
                                <div class="form-group">
                                    <label>菜单名称 <span class="text-red">*</span></label>
                                    <input type="text" class="form-control" name="menuName" ng-model="Model.menuName" placeholder="菜单名称" required maxlength="30" ng-ajax="menu/checkMenuName">
                                    <div ng-show="form.menuName.$dirty && form.menuName.$error.required" class="text-red">请输入菜单名称</div>
                                    <div ng-show="form.menuName.$dirty && form.menuName.$error.ngAjax" class="text-red">菜单名称已存在</div>
                                </div>
                                <div class="form-group">
                                    <label>菜单代码 <span class="text-red">*</span></label>
                                    <input type="text" class="form-control" name="menuCode" ng-model="Model.menuCode" placeholder="菜单代码" required maxlength="30" ng-ajax="menu/checkMenuCode">
                                    <div ng-show="form.menuCode.$dirty && form.menuCode.$error.required" class="text-red">请输入菜单代码</div>
                                    <div ng-show="form.menuCode.$dirty && form.menuCode.$error.ngAjax" class="text-red">菜单代码已存在</div>
                                </div>
                                <div class="form-group" ng-show="Model.pid!=null">
                                    <label>菜单链接 <span class="text-red">*</span></label>
                                    <input type="text" class="form-control" name="menuLink" ng-model="Model.menuLink" ng-required="Model.pid!=null" placeholder="菜单链接" maxlength="255">
                                </div>
                                <div class="form-group">
                                    <label>图标css <span class="text-red">*</span></label>
                                    <input type="text" class="form-control" name="menuIcon" ng-model="Model.menuIcon" placeholder="图标css" required maxlength="255">
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal" ng-click="cancel()"><i class="fa fa-close"></i> 关闭</button>
                    <button type="button" class="btn btn-primary" ng-disabled="form.$invalid" ng-click="ok()"><i class="fa fa-save"></i> 添加</button>
                </div>
            </div>
        </div>
    </script>

    <script type="text/ng-template" id="Edit.html">
        <div class="modal-dialog" role="document" ng-init="init();">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" ng-click="cancel()"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">编辑菜单</h4>
                </div>
                <div class="modal-body">
                    <form role="form" name="form" novalidate>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <label>上级菜单 <span class="text-red">*</span></label>
                                    <ui-select ng-model="Model.selectedMenu" on-select="Model.pid=Model.selectedMenu.menuId;Model.menuLink=null;">
                                        <ui-select-match placeholder="请选择上级菜单">{{Model.selectedMenu.menuName}}</ui-select-match>
                                        <ui-select-choices repeat="menu in parentMenuList">
                                            <i ng-class="menu.menuIcon"></i><span> {{menu.menuName}}</span>
                                        </ui-select-choices>
                                    </ui-select>
                                </div>
                                <div class="form-group">
                                    <label>菜单名称 <span class="text-red">*</span></label>
                                    <input type="text" class="form-control" name="menuName" ng-model="Model.menuName" placeholder="菜单名称" required maxlength="30" ng-ajax="menu/checkMenuName">
                                    <div ng-show="form.menuName.$dirty && form.menuName.$error.required" class="text-red">请输入菜单名称</div>
                                    <div ng-show="form.menuName.$dirty && form.menuName.$error.ngAjax" class="text-red">菜单名称已存在</div>
                                </div>
                                <div class="form-group">
                                    <label>菜单代码 <span class="text-red">*</span></label>
                                    <input type="text" class="form-control" name="menuCode" ng-model="Model.menuCode" placeholder="菜单代码" required maxlength="30" ng-ajax="menu/checkMenuCode">
                                    <div ng-show="form.menuCode.$dirty && form.menuCode.$error.required" class="text-red">请输入菜单代码</div>
                                    <div ng-show="form.menuCode.$dirty && form.menuCode.$error.ngAjax" class="text-red">菜单代码已存在</div>
                                </div>
                                <div class="form-group" ng-show="Model.pid!=null">
                                    <label>菜单链接 <span class="text-red">*</span></label>
                                    <input type="text" class="form-control" name="menuLink" ng-model="Model.menuLink" ng-required="Model.pid!=null" placeholder="菜单链接" maxlength="255">
                                </div>
                                <div class="form-group">
                                    <label>图标css <span class="text-red">*</span></label>
                                    <input type="text" class="form-control" name="menuIcon" ng-model="Model.menuIcon" placeholder="图标css" required maxlength="255">
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal" ng-click="cancel()"><i class="fa fa-close"></i> 关闭</button>
                    <button type="button" class="btn btn-primary" ng-disabled="form.$invalid" ng-click="ok()"><i class="fa fa-save"></i> 更新</button>
                </div>
            </div>
        </div>
    </script>
</section>
</@Base.Layout>