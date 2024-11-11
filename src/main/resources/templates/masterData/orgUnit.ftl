<#import "../shared/layout.ftl" as Base>
<#macro header>
<script src="js/controller/masterData/orgUnit.js"></script>
</#macro>
<@Base.Layout header=header>
<section class="content-header">
    <h1>
        组织架构
    </h1>
    <ol class="breadcrumb">
        <li><i class="fa fa-database"></i> 主数据管理</li>
        <li class="active">组织架构</li>
    </ol>
</section>
<section class="content" ng-controller="orgUnit" ng-init="init();">
    <div class="row">
        <div class="col-md-12">
            <div class="box box-widget">
                <div class="box-header with-border">
                    <button type="button" class="btn btn-primary btn-sm" ng-click="showAdd()"><i class="fa fa-plus"></i> 添加新组织</button>
                    <a href="orgUnit/orgUser" class="btn btn-success btn-sm"><i class="fa fa-users"></i> 分配用户</a>
                </div>
                <div class="box-body">
                    <tree-list ng-model="allOrgUnitList" node-id="orgUnitId" label="orgUnitName" expand-To-Depth="10" node-click="showEdit($node,$parentNode)" order="orgIndex">
                    </tree-list>
                </div>
            </div>
        </div>
    </div>

    <script type="text/ng-template" id="Add.html">
        <div class="modal-dialog" ng-init="init();">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" ng-click="cancel()"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">添加新组织</h4>
                </div>
                <div class="modal-body">
                    <form role="form" name="form" novalidate>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <label>上级组织 <span class="text-red">*</span></label>
                                    <ui-select ng-model="Model.selectedOrgUnit" on-select="Model.pid=Model.selectedOrgUnit.orgUnitId;">
                                        <ui-select-match placeholder="请选择上级组织">{{Model.selectedOrgUnit.orgUnitName}}</ui-select-match>
                                        <ui-select-choices repeat="orgUnit in allOrgUnitList">
                                            <span>{{orgUnit.orgUnitName}}</span>
                                        </ui-select-choices>
                                    </ui-select>
                                </div>
                                <div class="form-group">
                                    <label>组织名称 <span class="text-red">*</span></label>
                                    <input type="text" class="form-control" placeholder="组织名称" ng-model="Model.orgUnitName" required maxlength="30">
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal" ng-click="cancel()"><i class="fa fa-close"></i> 关闭</button>
                    <button type="button" class="btn btn-primary" ng-disabled="form.$invalid || loading" ng-click="ok()"><i class="fa fa-save"></i> 添加</button>
                </div>
            </div>
        </div>
    </script>

    <script type="text/ng-template" id="Edit.html">
        <div class="modal-dialog" ng-init="init();">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" ng-click="cancel()"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">编辑组织</h4>
                </div>
                <div class="modal-body">
                    <form role="form" name="form" novalidate>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <label>上级组织 <span class="text-red">*</span></label>
                                    <ui-select ng-model="Model.selectedOrgUnit" on-select="Model.pid=Model.selectedOrgUnit.orgUnitId;">
                                        <ui-select-match placeholder="请选择上级组织">{{Model.selectedOrgUnit.orgUnitName}}</ui-select-match>
                                        <ui-select-choices repeat="orgUnit in allOrgUnitList">
                                            <span>{{orgUnit.orgUnitName}}</span>
                                        </ui-select-choices>
                                    </ui-select>
                                </div>
                                <div class="form-group">
                                    <label>组织名称 <span class="text-red">*</span></label>
                                    <input type="text" class="form-control" placeholder="组织名称" ng-model="Model.orgUnitName" required maxlength="30">
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal" ng-click="cancel()"><i class="fa fa-close"></i> 关闭</button>
                    <button type="button" class="btn btn-success" ng-click="up()"><i class="fa fa-long-arrow-up"></i> 上调</button>
                    <button type="button" class="btn btn-warning" ng-click="down()"><i class="fa fa-long-arrow-down"></i> 上调</button>
                    <button type="button" class="btn btn-danger" ng-click="remove()"><i class="fa fa-trash-o"></i> 删除</button>
                    <button type="button" class="btn btn-primary" ng-disabled="form.$invalid || loading" ng-click="ok()"><i class="fa fa-save"></i> 更新</button>
                </div>
            </div>
        </div>
    </script>

</section>
</@Base.Layout>