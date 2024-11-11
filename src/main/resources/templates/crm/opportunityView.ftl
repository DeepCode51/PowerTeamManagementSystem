<#import "../shared/layout.ftl" as Base>
<#macro header>
<script src="js/controller/crm/opportunityView.js"></script>
</#macro>
<@Base.Layout header=header>
<div ng-controller="opportunityView" ng-init="Model.opportunityId=${opportunityId};init();">
    <section class="content-header">
        <h1>
            <i class="fa fa-star"></i> {{Model.name}}
        </h1>
        <ol class="breadcrumb">
            <li><i class="fa fa-star"></i> 业务机会</li>
            <li class="active">业务机会详情</li>
        </ol>
    </section>
    <section class="content">
        <div class="container-fluid">
            <div class="row text-center step">
                <div class="col-lg-2 no-padding" ng-repeat="phase in phaseList">
                    <h3 class="step-item" ng-class="{'bg-green':Model.phase>phase.id,'bg-blue':Model.phase==phase.id,'bg-gray':Model.phase<phase.id}">
                        <i class="fa" ng-class="{'fa-check':Model.phase>phase.id}"></i>{{phase.name}}
                    </h3>
                </div>
                <div class="col-lg-2 no-padding">
                    <h3 class="bg-gray step-item"><i class="fa fa-smile-o" ng-show="Model.win"></i><i class="fa fa-meh-o" ng-hide="Model.win"></i> {{Model.win?'赢单':'输单'}}</h3>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6 col-lg-3">
                <div class="box box-widget">
                    <form role="form" name="form" novalidate>
                        <div class="box-body">
                            <div class="form-group">
                                <label>所属客户</label>
                                <div>{{Model.customer.customerName}}</div>
                            </div>
                            <div class="form-group">
                                <label>业务机会所属人</label>
                                <div>{{Model.ownerUser.realName}}</div>
                            </div>
                            <div class="form-group">
                                <label>金额</label>
                                <div>{{Model.amount | number:2}} <span class="label bg-fuchsia">{{ Model.budgetConfirmed?'预算已确认':'预算未确认' }}</span></div>
                            </div>
                            <div class="form-group">
                                <label>机会结束日期</label>
                                <div>{{Model.endDate | date:'yyyy-MM-dd'}}</div>
                            </div>
                            <div class="form-group">
                                <label>结果</label>
                                <div ng-switch="Model.win"><span ng-switch-when="true" class="label label-success">赢单</span><span ng-switch-when="false" class="label label-danger">输单</span></div>
                            </div>
                            <div class="form-group" ng-show="Model.win==false">
                                <label>输单原因</label>
                                <div>
                                    {{ (lossReasonList | where : {id:Model.lossReason} | first).name }}
                                </div>
                            </div>
                            <div class="form-group">
                                <label>描述</label>
                                <div>{{Model.description}}</div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="box box-widget">
                    <div class="box-body">
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
                </div>
            </div>
            <div class="col-md-6 col-lg-3">
                <div class="box box-widget">
                    <div class="box-header with-border">
                        <h3 class="box-title">联系人角色</h3>
                    </div>
                    <div class="box-body">
                        <ul class="products-list product-list-in-box">
                            <li class="item" ng-repeat="contactsRole in Model.contactsRoleList" ng-switch="contactsRole.role">
                                <div class="product-img">
                                    <img src="img/avatar/noFace.png">
                                </div>
                                <div class="product-info">
                                    <a href="javascript:void(0)" class="product-title">{{contactsRole.contacts.name}}
                                        <span class="pull-right label label-primary">{{ (contactsRoleList | where :{id:contactsRole.role} | first).name }}</span>
                                    </a>
                                    <span class="product-description">{{contactsRole.contacts.title}} - {{contactsRole.contacts.phone}}</span>
                                </div>
                            </li>
                        </ul>
                        <div ng-show="Model.contactsRoleList==null||Model.contactsRoleList.length==0" class="text-center">
                            <#include "../shared/noData.ftl">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>
</@Base.Layout>