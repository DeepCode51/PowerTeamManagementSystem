<#import "../shared/layout.ftl" as Base>
<#macro header>
<script src="js/controller/masterData/orgUnit.js"></script>
</#macro>
<@Base.Layout header=header>
<section class="content-header">
    <h1>
        分配用户
    </h1>
    <ol class="breadcrumb">
        <li><i class="fa fa-database"></i> 主数据管理</li>
        <li>组织架构</li>
        <li class="active">分配用户</li>
    </ol>
</section>
<section class="content" ng-controller="orgUser" ng-init="init();">
    <div class="row">
        <div class="col-md-12 col-lg-2">
            <div class="box box-widget">
                <div class="box-header with-border">
                    <h3 class="box-title">组织架构</h3>
                </div>
                <div class="box-body">
                    <tree-list ng-model="allOrgUnitList" node-id="orgUnitId" label="orgUnitName" expand-To-Depth="10" node-click="nodeClick($node,$parentNode)" order="orgIndex">
                    </tree-list>
                </div>
            </div>
        </div>
        <div class="col-md-6 col-lg-5">
            <div class="box box-widget widget-user">
                <div class="widget-user-header bg-light-blue">
                    <h3 class="widget-user-username">{{orgUnitHead.realName}}</h3>
                    <h5 class="widget-user-desc">{{orgUnit.orgUnitName}}</h5>
                </div>
                <div class="widget-user-image">
                    <img class="img-circle" ng-src="{{orgUnitHead.avatar}}">
                </div>
                <div class="box-footer">
                    <div class="row">
                        <div class="col-sm-4 border-right">
                            <div class="description-block">
                                <h5 class="description-header">{{orgUnit.orgUnitName}}</h5>
                                <span class="description-text">组织</span>
                            </div>
                        </div>
                        <div class="col-sm-4 border-right">
                            <div class="description-block">
                                <h5 class="description-header">主管</h5>
                                <span class="description-text">担任</span>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="description-block">
                                <h5 class="description-header">{{userInOrgUnitQuery.total}}个</h5>
                                <span class="description-text">组员</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="box-body no-padding">
                    <ul class="nav nav-stacked">
                        <li ng-repeat="item in userInOrgUnit">
                            <a>
                                {{item.realName}}({{item.userName}})
                                <div class="pull-right">
                                    <button type="button" ng-show="!item.isUnitHead" class="btn btn-success btn-xs" ng-click="setUnitHead(item.userId)"><i class="fa fa-star"></i> 设为主管</button>
                                    <button type="button" ng-show="item.isUnitHead" class="btn bg-maroon btn-xs" ng-click="removeUnitHead(item.userId)"><i class="fa fa-star-o"></i> 解除主管</button>
                                    <button type="button" class="btn btn-danger btn-xs" ng-click="removeOrgUser(item.userId)"><i class="fa fa-arrow-circle-right"></i> 移除</button>
                                </div>
                            </a>
                        </li>
                    </ul>
                </div>
                <div class="box-footer">
                    <ul uib-pagination ng-model="userInOrgUnitQuery.pageNum" items-per-page="userInOrgUnitQuery.pageSize" total-items="userInOrgUnitQuery.total" class="pagination-sm no-margin pull-right"></ul>
                </div>
            </div>
        </div>
        <div class="col-md-6 col-lg-5">
            <div class="box box-widget">
                <div class="box-header with-border">
                    <h3 class="box-title">可加入该组织的用户</h3>
                    <div class="box-tools">
                        <div class="input-group input-group-sm" style="width: 150px;">
                            <input type="text" class="form-control pull-right" ng-model="userNotInOrgUnitQuery.word" placeholder="用户名 / 真实姓名">
                            <div class="input-group-btn">
                                <button type="button" class="btn btn-default" ng-click="findUserNotInOrgUnit()"><i class="fa fa-search"></i></button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="box-body no-padding">
                    <ul class="nav nav-stacked">
                        <li ng-repeat="item in userNotInOrgUnit">
                            <a>
                                {{item.realName}}({{item.userName}})
                                <button type="button" class="btn btn-success btn-xs pull-right" ng-click="addOrgUser(item.userId)"><i class="fa fa-arrow-circle-left"></i> 加入</button>
                            </a>
                        </li>
                    </ul>
                </div>
                <div class="box-footer">
                    <ul uib-pagination ng-model="userNotInOrgUnitQuery.pageNum" items-per-page="userNotInOrgUnitQuery.pageSize" total-items="userNotInOrgUnitQuery.total" class="pagination-sm no-margin pull-right"></ul>
                </div>
            </div>
        </div>
    </div>
</section>
</@Base.Layout>