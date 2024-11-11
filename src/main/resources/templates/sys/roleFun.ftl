<#import "../shared/layout.ftl" as Base>
<#macro header>
<script src="js/controller/sys/roleFun.js"></script>
</#macro>
<@Base.Layout header=header>
<section class="content-header">
    <h1>
        分配功能
    </h1>
    <ol class="breadcrumb">
        <li><i class="fa fa-cogs"></i> 系统管理</li>
        <li>角色管理</li>
        <li class="active">分配功能</li>
    </ol>
</section>
<section class="content" ng-controller="roleFun" ng-init="roleId=${roleId};init();">
    <div class="row">
        <div class="col-md-2">
            <div class="box box-solid">
                <div class="box-header with-border">
                    <h3 class="box-title">角色列表</h3>
                </div>
                <div class="box-body no-padding">
                    <ul class="nav nav-pills nav-stacked">
                        <li ng-repeat="item in allRoleList" ng-class="{'active':roleId==item.roleId}">
                            <a href="role/fun/{{item.roleId}}">{{item.roleName}}</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="col-md-10">
            <div class="box box-widget">
                <div class="box-header">
                    <h3 class="box-title">功能列表</h3>
                </div>
                <div class="box-body table-responsive no-padding">
                    <table class="table table-hover">
                        <tbody>
                        <tr>
                            <th><input type="checkbox" ng-model="checkFlag" ng-click="checkAll()"></th>
                            <th>功能名称</th>
                            <th>功能编码</th>
                        </tr>
                        <tr ng-repeat="model in allFunList">
                            <td><input type="checkbox" ng-model="model.checked"></td>
                            <td>{{model.funName}}</td>
                            <td>{{model.funCode}}</td>
                        </tr>
                        <tr ng-show="allFunList==null || allFunList.length==0">
                            <td class="text-center text-muted" colspan="3">
                                <#include "../shared/noData.ftl">
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="box-footer">
                    <button type="button" class="btn btn-primary btn-sm" ng-click="saveRoleFun()"><i class="fa fa-save"></i> 保存</button>
                </div>
            </div>
        </div>
    </div>
</section>
</@Base.Layout>