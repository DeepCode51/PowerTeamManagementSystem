<#import "../shared/layout.ftl" as Base>
<#macro header>
<script src="js/controller/crm/opportunityHistory.js"></script>
</#macro>
<@Base.Layout header=header>
<section class="content-header">
    <h1>
        业务机会历史
    </h1>
    <ol class="breadcrumb">
        <li><i class="fa fa-star"></i> 业务机会</li>
        <li class="active">历史</li>
    </ol>
</section>
<section class="content" ng-controller="opportunityHistory" ng-init="init();">
    <div class="row">
        <div class="col-lg-2">
            <div class="box box-widget">
                <div class="box-header">
                    <h3 class="box-title"><b>查询业务机会</b></h3>
                </div>
                <div class="box-body">
                    <div class="form-group">
                        <input type="text" class="form-control" ng-model="query.word" placeholder="标题">
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-10">
            <div class="box box-widget">
                <div class="box-body table-responsive no-padding">
                    <table class="table table-hover">
                        <tbody>
                        <tr>
                            <th>#</th>
                            <th>标题</th>
                            <th>金额</th>
                            <th>结果</th>
                            <th>关闭日期</th>
                            <th>创建日期</th>
                        </tr>
                        <tr ng-repeat="model in list">
                            <td>{{$index+1}}</td>
                            <td><a href="opportunity/history/view/{{model.opportunityId}}" target="_blank">{{model.name}}</a></td>
                            <td>{{model.amount | number:2}}</td>
                            <td ng-switch="model.win"><span ng-switch-when="true" class="label label-success">赢单</span><span ng-switch-when="false" class="label label-danger">输单</span></td>
                            <td>{{model.closeDate | date:'yyyy-MM-dd HH:ss'}}</td>
                            <td>{{model.createDate | date:'yyyy-MM-dd HH:ss'}}</td>
                        </tr>
                        <tr ng-show="list==null || list.length==0">
                            <td class="text-center text-muted" colspan="6">
                                <#include "../shared/noData.ftl">
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="box-footer">
                    <ul uib-pagination ng-model="query.pageNum" items-per-page="query.pageSize" total-items="query.total" class="pagination-sm no-margin pull-right"></ul>
                </div>
            </div>
        </div>
    </div>
</section>
</@Base.Layout>