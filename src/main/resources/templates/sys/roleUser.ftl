<#import "../shared/layout.ftl" as Base>
<#macro header>
<script src="js/controller/sys/roleUser.js"></script>
</#macro>
<@Base.Layout header=header>
<section class="content-header">
    <h1>
        分配用户
    </h1>
    <ol class="breadcrumb">
        <li><i class="fa fa-cogs"></i> 系统管理</li>
        <li>角色管理</li>
        <li class="active">分配用户</li>
    </ol>
</section>
<section class="content" ng-controller="roleUser" ng-init="roleId=${roleId};init();">
    <div class="row">
        <div class="col-md-2">
            <div class="box box-solid">
                <div class="box-header with-border">
                    <h3 class="box-title">角色列表</h3>
                </div>
                <div class="box-body no-padding">
                    <ul class="nav nav-pills nav-stacked">
                        <li ng-repeat="item in list" ng-class="{'active':roleId==item.roleId}">
                            <a href="role/user/{{item.roleId}}">{{item.roleName}}
                                <span class="label label-success pull-right" ng-show="item.roleId==roleId">{{userInRoleSearch.total}}</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="col-md-5">
            <div class="box box-widget">
                <div class="box-header">
                    <h3 class="box-title">该角色中的用户</h3>
                    <div class="box-tools">
                        <div class="input-group input-group-sm" style="width: 150px;">
                            <input type="text" ng-model="userInRoleSearch.word" class="form-control pull-right" placeholder="用户名 / 真实姓名">
                            <div class="input-group-btn">
                                <button type="button" class="btn btn-default"><i class="fa fa-search"></i></button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="box-body table-responsive no-padding">
                    <table class="table table-hover">
                        <tbody>
                        <tr>
                            <th>头像</th>
                            <th>用户名</th>
                            <th>真实姓名</th>
                            <th>操作</th>
                        </tr>
                        <tr ng-repeat="model in userInRole">
                            <td><img ng-src="{{model.avatar}}" class="img-circle img-sm"></td>
                            <td>{{model.userName}}</td>
                            <td>{{model.realName}}</td>
                            <td>
                                <button type="button" class="btn btn-danger btn-xs" ng-click="removeRoleUser(model.userId)"><i class="fa fa-arrow-circle-right"></i> 移除</button>
                            </td>
                        </tr>
                        <tr ng-show="userInRole==null || userInRole.length==0">
                            <td class="text-center text-muted" colspan="4">
                                <#include "../shared/noData.ftl">
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="box-footer">
                    <ul uib-pagination ng-model="userInRoleSearch.pageNum" items-per-page="userInRoleSearch.pageSize" total-items="userInRoleSearch.total" class="pagination-sm no-margin pull-right"></ul>
                </div>
            </div>
        </div>
        <div class="col-md-5">
            <div class="box box-widget">
                <div class="box-header">
                    <h3 class="box-title">可加入到该角色中的用户</h3>
                    <div class="box-tools">
                        <div class="input-group input-group-sm" style="width: 150px;">
                            <input type="text" ng-model="userNotInRoleSearch.word" class="form-control pull-right" placeholder="用户名 / 真实姓名">
                            <div class="input-group-btn">
                                <button type="button" class="btn btn-default"><i class="fa fa-search"></i></button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="box-body table-responsive no-padding">
                    <table class="table table-hover">
                        <tbody>
                        <tr>
                            <th>头像</th>
                            <th>用户名</th>
                            <th>真实姓名</th>
                            <th>操作</th>
                        </tr>
                        <tr ng-repeat="model in userNotInRole">
                            <td><img ng-src="{{model.avatar}}" class="img-circle img-sm"></td>
                            <td>{{model.userName}}</td>
                            <td>{{model.realName}}</td>
                            <td>
                                <button type="button" class="btn btn-success btn-xs" ng-click="addRoleUser(model.userId)"><i class="fa fa-arrow-circle-left"></i> 分配</button>
                            </td>
                        </tr>
                        <tr ng-show="userNotInRole==null || userNotInRole.length==0">
                            <td class="text-center text-muted" colspan="4">
                                <#include "../shared/noData.ftl">
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="box-footer">
                    <ul uib-pagination ng-model="userNotInRoleSearch.pageNum" items-per-page="userNotInRoleSearch.pageSize" total-items="userNotInRoleSearch.total" class="pagination-sm no-margin pull-right"></ul>
                </div>
            </div>
        </div>
    </div>
</section>
</@Base.Layout>