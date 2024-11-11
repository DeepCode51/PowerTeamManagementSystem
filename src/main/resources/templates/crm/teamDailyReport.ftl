<#import "../shared/layout.ftl" as Base>
<#macro header>
<script src="js/controller/crm/dailyReport.js"></script>
</#macro>
<@Base.Layout header=header>
<section class="content-header">
    <h1>
        团队日报
    </h1>
    <ol class="breadcrumb">
        <li><i class="fa fa-thumb-tack"></i> 日报</li>
        <li class="active">团队日报</li>
    </ol>
</section>
<section class="content" ng-controller="teamDailyReport" ng-init="init()">
    <div class="row">
        <div class="col-lg-2">
            <button class="btn btn-primary btn-flat btn-block margin-bottom" uib-datepicker-popup ng-model="query.workDay" datepicker-options="datepickerOptions" show-button-bar="false" ng-focus="showDate=true" is-open="showDate">切换日期 {{query.workDay|date:'yyyy-MM-dd'}} <span class="caret"></span></button>
            <div class="box box-solid">
                <div class="box-header with-border">
                    <h3 class="box-title">工作日</h3>
                </div>
                <div class="box-body no-padding">
                    <ul class="nav nav-pills nav-stacked">
                        <li ng-class="{'active':query.workDay.getDay()==1}"><a><i class="fa fa-calendar"></i> 周一</a></li>
                        <li ng-class="{'active':query.workDay.getDay()==2}"><a><i class="fa fa-calendar"></i> 周二</a></li>
                        <li ng-class="{'active':query.workDay.getDay()==3}"><a><i class="fa fa-calendar"></i> 周三</a></li>
                        <li ng-class="{'active':query.workDay.getDay()==4}"><a><i class="fa fa-calendar"></i> 周四</a></li>
                        <li ng-class="{'active':query.workDay.getDay()==5}"><a><i class="fa fa-calendar"></i> 周五</a></li>
                        <li ng-class="{'active':query.workDay.getDay()==6}"><a><i class="fa fa-calendar"></i> 周六</a></li>
                        <li ng-class="{'active':query.workDay.getDay()==0}"><a><i class="fa fa-calendar"></i> 周日</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="col-lg-10">
            <div class="box box-widget" ng-repeat="(createBy, list) in activityList| groupBy: 'createBy'">
                <div class="box-header with-border">
                    <div class="user-block">
                        <img class="img-circle" src="{{list[0].createByUser.avatar}}" alt="User Image">
                        <span class="username"><a>{{list[0].createByUser.realName}}</a></span>
                        <span class="description">工作日 {{query.workDay|date:'yyyy-MM-dd'}}</span>
                    </div>
                    <div class="box-tools">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <ul class="timeline">
                        <li ng-repeat="activity in list" ng-switch="activity.activityType">
                            <i class="fa fa-phone bg-green" ng-switch-when="1"></i>
                            <i class="fa fa-coffee bg-blue" ng-switch-when="2"></i>
                            <i class="fa fa-thumb-tack bg-purple" ng-switch-when="99"></i>
                            <i class="fa fa-bell-o bg-blue" ng-switch-when="100"></i>
                            <div class="timeline-item box-card">
                                <span class="time"><i class="fa fa-clock-o"></i> {{activity.createDate | amTimeAgo}}</span>
                                <h3 class="timeline-header"><a>{{activity.createByUser.realName}}</a>
                                    <span ng-switch="activity.resourceType">
                                        <span ng-switch-when="1">对{{activity.customer.customerName}}</span>
                                        <span ng-switch-when="2">对{{activity.opportunity.name}}</span>
                                    </span>
                                    <span ng-switch-when="1">进行了电话拜访</span>
                                    <span ng-switch-when="2">进行了面谈</span>
                                    <span ng-switch-when="99">填写日报</span>
                                </h3>
                                <div class="timeline-body">
                                    {{activity.content}}
                                </div>
                            </div>
                        </li>
                        <li ng-show="list.length>0">
                            <i class="fa fa-clock-o bg-blue"></i>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</section>
</@Base.Layout>