<#import "../shared/layout.ftl" as Base>
<#macro header>
<script src="lib/ECharts/echarts.min.js"></script>
<script src="js/controller/sys/dashboard.js"></script>
</#macro>
<@Base.Layout header=header>
<section class="content-header">
    <h1>
        看板
    </h1>
    <ol class="breadcrumb">
        <li><i class="fa fa-dashboard"></i> 首页</li>
        <li class="active">看板</li>
    </ol>
</section>
<section class="content" ng-controller="dashboard" ng-init="init()">

    <div class="row">
        <div class="col-md-6">
            <div class="box box-widget">
                <div class="box-header with-border">
                    <h3 class="box-title">本月我参与的业务机会</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                        </button>
                        <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div id="monthlyFunnel" style="width: 100%;height: 400px;"></div>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="box box-widget">
                <div class="box-header with-border">
                    <h3 class="box-title">本月我的转化情况</h3>
                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                        </button>
                        <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div id="monthlyConversion" style="width: 100%;height: 400px;"></div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <div class="box box-widget">
                <div class="box-header with-border">
                    <h3 class="box-title">将要结束的业务机会</h3>

                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                        </button>
                        <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                    </div>
                </div>
                <div class="box-body">
                    <div class="table-responsive">
                        <table class="table no-margin">
                            <thead>
                            <tr>
                                <th>标题</th>
                                <th>结束日期</th>
                                <th>金额</th>
                                <th>所处阶段</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr ng-repeat="opportunity in recentlyClosing">
                                <td><a href="opportunity/detail/{{opportunity.opportunityId}}" target="_blank">{{opportunity.name}}</a></td>
                                <td>{{opportunity.endDate | date:'yyyy-MM-dd'}}</td>
                                <td><span class="label bg-fuchsia">{{opportunity.amount | number:2}}</span></td>
                                <td><span class="label label-primary">{{ (phaseList|where:{id:opportunity.phase}|first).name }}中</span></td>
                            </tr>
                            <tr ng-show="recentlyClosing==null || recentlyClosing.length==0">
                                <td class="text-center text-muted" colspan="4">
                                    <#include "../shared/noData.ftl">
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
</@Base.Layout>