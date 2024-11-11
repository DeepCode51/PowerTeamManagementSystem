<#import "../shared/layout.ftl" as Base>
<#macro header>
<script src="js/controller/sys/role.js"></script>
</#macro>
<@Base.Layout header=header>
<section class="content-header">
    <h1>
        角色管理
    </h1>
    <ol class="breadcrumb">
        <li><i class="fa fa-cogs"></i> 系统管理</li>
        <li class="active">角色管理</li>
    </ol>
</section>
<section class="content" ng-controller="roleList" ng-init="find();">
    <div class="row">
        <div class="col-md-12">
            <div class="box box-widget">
                <div class="box-header">
                    <button type="button" class="btn btn-primary btn-sm" ng-click="showAdd()"><i class="fa fa-plus"></i> 新角色</button>
                </div>
                <div class="box-body table-responsive no-padding">
                    <table class="table table-hover">
                        <tbody>
                        <tr>
                            <th>#</th>
                            <th>角色名称</th>
                            <th>操作</th>
                        </tr>
                        <tr ng-repeat="model in list">
                            <td>{{$index+1}}</td>
                            <td>{{model.roleName}}</td>
                            <td>
                                <a href="role/user/{{model.roleId}}" class="btn btn-success btn-xs"><i class="fa fa-users"></i> 分配用户</a>
                                <a href="role/menu/{{model.roleId}}" class="btn bg-purple btn-xs"><i class="fa fa-list-ul"></i> 分配菜单</a>
                                <a href="role/fun/{{model.roleId}}" class="btn bg-purple btn-xs"><i class="fa fa-list-ul"></i> 分配功能权限</a>
                                <button type="button" class="btn btn-primary btn-xs" ng-hide="model.isSystemRole" ng-click="showEdit(model.roleId)"><i class="fa fa-pencil"></i> 编辑</button>
                                <button type="button" class="btn btn-danger btn-xs" ng-hide="model.isSystemRole" ng-click="remove(model.roleId)"><i class="fa fa-trash-o"></i> 删除</button>
                            </td>
                        </tr>
                        <tr ng-show="list==null || list.length==0">
                            <td class="text-center text-muted" colspan="3">
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
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" ng-click="cancel()"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">添加新角色</h4>
                </div>
                <div class="modal-body">
                    <form role="form" name="form" novalidate>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <label>角色名称 <span class="text-red">*</span></label>
                                    <input type="text" class="form-control" name="roleName" ng-model="Model.roleName" placeholder="角色名称" required maxlength="30" ng-ajax="role/checkRoleName">
                                    <div ng-show="form.roleName.$dirty && form.roleName.$error.required" class="text-red">请输入角色名称</div>
                                    <div ng-show="form.roleName.$dirty && form.roleName.$error.ngAjax" class="text-red">角色名称已存在</div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal" ng-click="cancel()"><i class="fa fa-close"></i> 关闭</button>
                    <button type="button" class="btn btn-primary" ng-disabled="form.$invalid || loading" ng-click="ok()"><i class="fa fa-save"></i> 添加</button>
                </div>
            </div>
        </div>
    </script>
    <script type="text/ng-template" id="Edit.html">
        <div class="modal-dialog" ng-init="init();">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" ng-click="cancel()"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">编辑角色</h4>
                </div>
                <div class="modal-body">
                    <form role="form" name="form" novalidate>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <label>角色名称 <span class="text-red">*</span></label>
                                    <input type="text" class="form-control" name="roleName" ng-model="Model.roleName" placeholder="角色名称" required maxlength="30" ng-ajax="role/checkRoleName">
                                    <div ng-show="form.roleName.$dirty && form.roleName.$error.required" class="text-red">请输入角色名称</div>
                                    <div ng-show="form.roleName.$dirty && form.roleName.$error.ngAjax" class="text-red">角色名称已存在</div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal" ng-click="cancel()"><i class="fa fa-close"></i> 关闭</button>
                    <button type="button" class="btn btn-primary" ng-disabled="form.$invalid || loading" ng-click="ok()"><i class="fa fa-save"></i> 更新</button>
                </div>
            </div>
        </div>
    </script>
</section>
</@Base.Layout>