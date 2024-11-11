<#import "../shared/layout.ftl" as Base>
<#macro header>
<script src="js/controller/crm/opportunityDashboard.js"></script>
</#macro>
<@Base.Layout header=header>
<section class="content-header">
    <h1>
        业务机会看板
    </h1>
    <ol class="breadcrumb">
        <li><i class="fa fa-star"></i> 业务机会</li>
        <li class="active">看板</li>
    </ol>
</section>
<section class="content" ng-controller="opportunityDashboard" ng-init="find()">
    <div class="row">
        <div class="col-lg-12">
            <button class="btn btn-primary" ng-click="showAdd()"><i class="fa fa-plus"></i> 新机会</button>
            <a href="opportunity/history" target="_blank" class="btn bg-orange"><i class="fa fa-history"></i> 已完成</a>
        </div>
    </div>
    <br>
    <div class="row">
        <div class="col-md-3 col-lg-3" ng-repeat="phase in phaseList" >
            <div class="box box-solid">
                <div class="box-header with-border text-center bg-blue">
                    <h3 class="box-title">{{phase.name}}({{ (list | where:{phase:phase.id}).length }}个)</h3>
                </div>
                <div class="box-body no-padding">
                    <ul class="nav nav-pills nav-stacked">
                        <li ng-repeat="opportunity in list | where:{phase:phase.id}">
                            <a ng-href="opportunity/detail/{{opportunity.opportunityId}}">{{opportunity.name}} <span class="label text-fuchsia pull-right">￥ {{opportunity.amount | number:2}}</span></a>
                        </li>
                    </ul>
                    <div ng-show="(list | where:{phase:phase.id}).length==0" class="text-center">
                        <#include "../shared/noData.ftl">
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script type="text/ng-template" id="Add.html">
        <div class="modal-dialog" ng-init="init();">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" ng-click="cancel()"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">新机会</h4>
                </div>
                <div class="modal-body">
                    <form role="form" name="form" novalidate>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <label>标题 <span class="text-red">*</span></label>
                                    <input type="text" class="form-control" name="name" ng-model="Model.name" placeholder="标题" required maxlength="30">
                                    <div ng-show="form.name.$dirty && form.name.$error.required" class="text-red">请输入标题</div>
                                </div>
                                <div class="form-group">
                                    <label>金额 <span class="text-red">*</span></label>
                                    <input type="text" class="form-control" name="amount" ng-number ng-model="Model.amount" placeholder="请输入机会金额" required>
                                </div>
                                <div class="form-group">
                                    <label>机会结束日期 <span class="text-red">*</span></label>
                                    <div class="input-group">
                                        <input type="text" class="form-control" uib-datepicker-popup ng-model="Model.endDate" ng-focus="showDate=true" is-open="showDate" readonly placeholder="结束日期" required>
                                        <div class="input-group-btn">
                                            <button type="button" class="btn btn-default" ng-click="showDate=true"><i class="fa fa-calendar"></i></button>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label>所属客户 <span class="text-red">*</span></label>
                                    <ui-select ng-model="Model.selectedCustomer" on-select="Model.customerId=Model.selectedCustomer.customerId">
                                        <ui-select-match placeholder="请输入客户名称">{{Model.selectedCustomer.customerName}}</ui-select-match>
                                        <ui-select-choices repeat="customer in customerList" refresh="findCustomer($select.search)" refresh-delay="0">
                                            <span ng-bind="customer.customerName"></span>
                                        </ui-select-choices>
                                        <ui-select-no-choice>
                                            <span class="text-muted">请输入客户名称(模糊查询)</span>
                                        </ui-select-no-choice>
                                    </ui-select>
                                </div>
                                <div class="form-group">
                                    <label>描述</label>
                                    <textarea class="form-control" rows="5" name="description" ng-model="Model.description" placeholder="请填写业务机会详细信息" maxlength="500"></textarea>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal" ng-click="cancel()"><i class="fa fa-close"></i> 关闭</button>
                    <button type="button" class="btn btn-primary" ng-disabled="form.$invalid || Model.customerId==null || loading" ng-click="ok()"><i class="fa fa-save"></i> 添加</button>
                </div>
            </div>
        </div>
    </script>

</section>
</@Base.Layout>