<#import "../shared/layout.ftl" as Base>
<#macro header>
<script src="js/controller/sys/roleMenu.js"></script>
</#macro>
<@Base.Layout header=header>
<section class="content-header">
    <h1>
        分配菜单
    </h1>
    <ol class="breadcrumb">
        <li><i class="fa fa-cogs"></i> 系统管理</li>
        <li>角色管理</li>
        <li class="active">分配菜单</li>
    </ol>
</section>
<section class="content" ng-controller="roleMenu" ng-init="roleId=${roleId};init();">
    <div class="row">
        <div class="col-md-2">
            <div class="box box-widget">
                <div class="box-header with-border">
                    <h3 class="box-title">角色列表</h3>
                </div>
                <div class="box-body no-padding">
                    <ul class="nav nav-pills nav-stacked">
                        <li ng-repeat="item in roleList" ng-class="{'active':roleId==item.roleId}">
                            <a href="role/menu/{{item.roleId}}">{{item.roleName}}
                                <span class="label label-success pull-right" ng-show="item.roleId==roleId">{{userInRoleSearch.total}}</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="col-md-10">
            <div class="box box-widget">
                <div class="box-header with-border">
                    <h3 class="box-title">菜单</h3>
                </div>
                <div class="box-body">
                    <tree-list ng-model="allMenuList" node-id="menuId" label="menuName" expand-To-Depth="10" can-check="true" node-css="menuIcon">
                    </tree-list>
                </div>
                <div class="box-footer">
                    <button type="button" class="btn btn-primary btn-sm" ng-click="saveRoleMenu()"><i class="fa fa-save"></i> 保存</button>
                </div>
            </div>
        </div>
    </div>
</section>
</@Base.Layout>