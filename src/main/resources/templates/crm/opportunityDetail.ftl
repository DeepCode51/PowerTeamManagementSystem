<#import "../shared/layout.ftl" as Base>
<#macro header>
<script src="js/controller/crm/opportunityDetail.js"></script>
</#macro>
<@Base.Layout header=header>
<div ng-controller="opportunityDetail" ng-init="Model.opportunityId=${opportunityId};init();">
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
                <div class="col-lg-2 no-padding" ng-repeat="phase in phaseList" ng-click="changePhase(phase)">
                    <h3 class="step-item" ng-class="{'bg-green':Model.phase>phase.id,'bg-blue':Model.phase==phase.id,'bg-gray':Model.phase<phase.id}">
                        <i class="fa" ng-class="{'fa-check':Model.phase>phase.id}"></i>{{phase.name}}
                    </h3>
                </div>
                <div class="col-lg-2 no-padding">
                    <h3 class="bg-gray step-item" ng-show="Model.phase!=5">选择阶段</h3>
                    <h3 class="bg-gray step-item" ng-show="Model.phase==5"><i class="fa fa-smile-o" ng-show="Model.win"></i><i class="fa fa-meh-o" ng-hide="Model.win"></i> {{Model.win?'赢单':'输单'}}</h3>
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
                                <label for="endDate">机会结束日期 <span class="text-red">*</span></label>
                                <div class="input-group">
                                    <input type="text" class="form-control" uib-datepicker-popup ng-model="Model.endDate" ng-focus="showDate=true" is-open="showDate" readonly placeholder="机会结束日期" required>
                                    <div class="input-group-btn">
                                        <button type="button" class="btn btn-default" ng-click="showDate=true"><i class="fa fa-calendar"></i></button>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="amount">金额 <span class="text-red">*</span></label>
                                <input type="text" class="form-control" ng-number ng-model="Model.amount" placeholder="请输入机会金额" required>
                            </div>
                            <div class="row">
                                <div class="col-lg-6">
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" ng-model="Model.budgetConfirmed"> 预算已确认
                                        </label>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" ng-model="Model.roiConfirmed"> 投资回报率分析完成
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group" ng-show="Model.phase==5">
                                <label for="endDate">选择结果 <span class="text-red">*</span></label>
                                <div class="radio">
                                    <label>
                                        <input type="radio" name="win" ng-model="Model.win" ng-value="true"> 赢单
                                    </label>
                                    <label>
                                        <input type="radio" name="win" ng-model="Model.win" ng-value="false"> 输单
                                    </label>
                                </div>
                            </div>
                            <div class="form-group" ng-show="Model.phase==5 && !Model.win">
                                <label for="endDate">输单原因 <span class="text-red">*</span></label>
                                <ui-select ng-model="Model.selectedReason" on-select="Model.lossReason=Model.selectedReason.id">
                                    <ui-select-match placeholder="请选择输单原因">{{Model.selectedReason.name}}</ui-select-match>
                                    <ui-select-choices repeat="reason in lossReasonList">
                                        <span ng-bind="reason.name"></span>
                                    </ui-select-choices>
                                </ui-select>
                            </div>
                            <div class="form-group">
                                <label>描述</label>
                                <textarea class="form-control" rows="5" name="description" ng-model="Model.description" placeholder="请填写业务机会详细信息" maxlength="500"></textarea>
                            </div>
                        </div>
                        <div class="box-footer">
                            <button type="button" class="btn btn-primary btn-block" ng-disabled="form.$invalid || loading" ng-click="update()">更新</button>
                            <button type="button" class="btn bg-fuchsia btn-block" ng-disabled="loading" ng-click="remove()">删除</button>
                        </div>
                    </form>
                </div>
            </div>
            <div class="col-md-6 col-lg-6">
                <div class="box box-widget">
                    <div class="box-header with-border">
                        <h3 class="box-title">记录工作</h3>
                    </div>
                    <div class="box-body">
                        <form novalidate name="activityForm" ng-submit="addActivity()">
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-12 col-lg-3">
                                        <ui-select ng-model="Activity.selectedType" on-select="Activity.activityType=Activity.selectedType.id" required>
                                            <ui-select-match placeholder="请选择工作类型">{{Activity.selectedType.name}}</ui-select-match>
                                            <ui-select-choices repeat="type in activityTypeList">
                                                <span ng-bind="type.name"></span>
                                            </ui-select-choices>
                                        </ui-select>
                                    </div>
                                    <div class="col-md-12 col-lg-9">
                                        <div class="input-group">
                                            <input type="text" name="content" ng-model="Activity.content" placeholder="记录你的工作..." class="form-control" required maxlength="200">
                                            <span class="input-group-btn">
                                            <button type="submit" class="btn btn-primary btn-flat" ng-disabled="activityForm.$invalid || loading">保存</button>
                                        </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
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
                                        <div class="btn-group pull-right" uib-dropdown>
                                            <button id="role-button" type="button" class="btn btn-xs" uib-dropdown-toggle ng-class="{'bg-blue':contactsRole.role==5,'bg-green':contactsRole.role==4,'bg-yellow':contactsRole.role==3,'bg-teal':contactsRole.role==2,'bg-purple':contactsRole.role==1}">
                                                <span ng-repeat="role in contactsRoleList" ng-show="role.id==contactsRole.role">{{role.name}}</span>
                                                <span class="caret"></span>
                                            </button>
                                            <button type="button" class="btn bg-maroon btn-xs" ng-click="removeContactRole(contactsRole)">
                                                移除
                                            </button>
                                            <ul class="dropdown-menu" uib-dropdown-menu role="menu" aria-labelledby="role-button">
                                                <li role="menuitem" ng-repeat="role in contactsRoleList" ng-click="changeContactRole(contactsRole,role)" ng-hide="contactsRole.role==role.id">
                                                    <a href="javascript:void(0)"><i class="fa fa-male"></i>{{role.name}}</a>
                                                </li>
                                            </ul>
                                        </div>
                                    </a>
                                    <span class="product-description">{{contactsRole.contacts.title}} - {{contactsRole.contacts.phone}}</span>
                                </div>
                            </li>
                        </ul>
                        <div ng-show="Model.contactsRoleList==null||Model.contactsRoleList.length==0" class="text-center">
                            <#include "../shared/noData.ftl">
                        </div>
                        <button class="btn btn-primary btn-block" ng-click="chooseContact()"><b>选择联系人</b></button>
                    </div>
                </div>
            </div>
        </div>

        <script type="text/ng-template" id="ChooseContact.html">
            <div class="modal-dialog modal-lg" role="document" ng-init="init();">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" ng-click="cancel()"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">选择联系人</h4>
                    </div>
                    <div class="modal-body">
                        <input ng-model="query.word" class="form-control" type="text" placeholder="姓名 / 职务 / 手机号">
                        <br>
                        <div class="row">
                            <div class="col-md-4" ng-repeat="contacts in contactList">
                                <div class="box box-widget box-card">
                                    <div class="box-header with-border">
                                        <div class="user-block">
                                            <img class="img-circle" src="img/avatar/noFace.png">
                                            <span class="username"><a>{{contacts.name}}</a> <button class="btn btn-primary btn-xs pull-right" ng-click="ok(contacts)">选择</button></span>
                                            <span class="description">{{contacts.title}} - {{contacts.phone}}</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div ng-show="contactList==null||contactList.length==0" class="text-center">
                                <#include "../shared/noData.ftl">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <ul uib-pagination ng-model="query.pageNum" items-per-page="query.pageSize" total-items="query.total" class="pagination-sm no-margin pull-right"></ul>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal" ng-click="cancel()"><i class="fa fa-close"></i> 关闭</button>
                        <a href="contacts" target="_blank" class="btn btn-success"><i class="fa fa-plus"></i> 创建新联系人</a>
                    </div>
                </div>
            </div>
        </script>
    </section>
</div>
</@Base.Layout>