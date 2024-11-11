<#import "../shared/layout.ftl" as Base>
<#macro header>
<script src="js/controller/crm/customerDashboard.js"></script>
</#macro>
<@Base.Layout header=header>
<section class="content-header">
    <h1>
        客户看板
    </h1>
    <ol class="breadcrumb">
        <li><a><i class="fa fa-user-md"></i> 客户</a></li>
        <li class="active">客户看板</li>
    </ol>
</section>
<section class="content" ng-controller="customerDashboard" ng-init="Model.customerId=${customerId};init();">
    <div class="row">
        <div class="col-lg-3">
            <div class="box box-widget">
                <div class="box-header with-border">
                    <h6 class="profile-username"><i class="fa fa-building-o"></i> {{Model.customerName}} <span class="label bg-fuchsia" ng-show="Model.potential">潜在</span></h6>
                </div>
                <div class="box-body box-profile">
                    <p>等级：
                        <span uib-rating class="text-yellow" ng-model="model.star" max="5" ng-click="updateStar(Model)"></span>
                    </p>
                    <p>电话：{{Model.tel}}</p>
                    <p>网址：<a ng-href="{{Model.website}}" target="_blank" ng-show="Model.website!=null&&Model.website.length>0">{{Model.website}}</a></p>
                    <p>地址：{{Model.address}}</p>
                    <p>地区：<span ng-show="Model.provinceId!=null">{{Model.province.name}}</span> <span ng-show="Model.cityId!=null">{{Model.city.name}}</span></p>
                    <p>行业：<span ng-show="Model.industry!=null">{{Model.industry.industryName}}</span></p>
                    <p>关系：<span ng-show="Model.customerCategory!=null">{{Model.customerCategory.categoryName}}</span></p>
                    <p>来源：<span ng-show="Model.source!=null">{{Model.source.sourceName}}</span></p>
                </div>
            </div>
            <div class="box box-widget">
                <div class="box-header with-border">
                    <h3 class="box-title"><i class="fa fa-location-arrow"></i> 地理位置</h3>
                </div>
                <div class="box-body">
                    <div baidu-map="${PowerTeam.baiduMapAk}" map-ready="mapReady(map)" style="height: 300px"></div>
                </div>
            </div>
        </div>
        <div class="col-lg-9">
            <div class="box box-widget">
                <div class="box-header with-border">
                    <h3 class="box-title">记录工作</h3>
                </div>
                <div class="box-body">
                    <form novalidate name="form" ng-submit="addActivity()">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-xs-12 col-md-3">
                                    <ui-select ng-model="Activity.selectedType" on-select="Activity.activityType=Activity.selectedType.id" required>
                                        <ui-select-match placeholder="请选择工作类型">{{Activity.selectedType.name}}</ui-select-match>
                                        <ui-select-choices repeat="type in activityTypeList">
                                            <span ng-bind="type.name"></span>
                                        </ui-select-choices>
                                    </ui-select>
                                </div>
                                <div class="col-xs-12 col-md-9">
                                    <div class="input-group">
                                        <input type="text" name="content" ng-model="Activity.content" placeholder="记录你的工作..." class="form-control" required maxlength="200">
                                        <span class="input-group-btn">
                                            <button type="submit" class="btn btn-primary btn-flat" ng-disabled="form.$invalid || loading">保存</button>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs">
                    <li class="active"><a href="#activity" data-toggle="tab">动态</a></li>
                    <li><a href="#contacts" data-toggle="tab">联系人</a></li>
                </ul>
                <div class="tab-content">
                    <div class="active tab-pane" id="activity">
                        <ul class="timeline">
                            <li ng-repeat="activity in activityList" ng-switch="activity.activityType">
                                <i class="fa fa-phone bg-green" ng-switch-when="1"></i>
                                <i class="fa fa-coffee bg-blue" ng-switch-when="2"></i>
                                <i class="fa fa-bell-o bg-blue" ng-switch-when="100"></i>
                                <div class="timeline-item box-card">
                                    <span class="time"><i class="fa fa-clock-o"></i> {{activity.createDate | amTimeAgo}}</span>
                                    <h3 class="timeline-header"><a>{{activity.createByUser.realName}}</a> <span ng-switch-when="1">进行了电话拜访</span><span ng-switch-when="2">进行了面谈</span></h3>
                                    <div class="timeline-body">
                                        {{activity.content}}
                                    </div>
                                </div>
                            </li>
                            <li ng-show="activityList.length>0">
                                <i class="fa fa-clock-o bg-blue"></i>
                            </li>
                        </ul>
                        <div class="text-center">
                            <button class="btn btn-primary btn-xs" ng-click="moreData()" ng-show="queryActivity.hasNextPage">加载更多数据</button>
                            <span ng-show="!queryActivity.hasNextPage&&activityList.length>0">没有更多数据了</span>
                        </div>
                        <div ng-show="activityList.length==0" class="text-center">
                            <#include "../shared/noData.ftl">
                        </div>
                    </div>
                    <div class="tab-pane" id="contacts">
                        <div class="row">
                            <div class="col-md-3" ng-repeat="contacts in contactList">
                                <div class="box box-widget box-card">
                                    <div class="box-header with-border">
                                        <div class="user-block">
                                            <img class="img-circle" src="img/avatar/noFace.png">
                                            <span class="username"><a>{{contacts.name}}</a></span>
                                            <span class="description">{{contacts.title}} - {{contacts.phone}}</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div ng-show="contactList.length==0" class="text-center">
                            <#include "../shared/noData.ftl">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
</@Base.Layout>