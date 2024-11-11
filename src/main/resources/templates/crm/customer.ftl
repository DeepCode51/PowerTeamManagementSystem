<#import "../shared/layout.ftl" as Base>
<#macro header>
<script src="js/controller/crm/customer.js"></script>
</#macro>
<@Base.Layout header=header>
<section class="content-header">
    <h1>
        客户管理
    </h1>
    <ol class="breadcrumb">
        <li><i class="fa fa-user-md"></i> 客户</li>
        <li class="active">客户管理</li>
    </ol>
</section>
<section class="content" ng-controller="customerList" ng-init="init();">
    <div class="row">
        <div class="col-md-12 col-lg-2">
            <div class="box box-widget">
                <div class="box-header">
                    <h3 class="box-title"><b>查询客户</b></h3>
                </div>
                <div class="box-body">
                    <div class="form-group">
                        <input type="text" class="form-control" ng-model="query.word" placeholder="客户名称">
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-12 col-lg-10">
            <div class="box box-widget">
                <div class="box-header">
                    <button type="button" class="btn btn-primary btn-sm" ng-click="showAdd()"><i class="fa fa-plus"></i> 新客户</button>
                </div>
                <div class="box-body table-responsive no-padding">
                    <table class="table table-hover">
                        <tbody>
                        <tr>
                            <th>客户名称</th>
                            <th>等级</th>
                            <th>电话</th>
                            <th>网址</th>
                            <th>行业</th>
                            <th>类型</th>
                            <th>来源</th>
                            <th>地区</th>
                            <th>操作</th>
                        </tr>
                        <tr ng-repeat="model in list">
                            <td><a href="customer/dashboard/{{model.customerId}}" target="_blank">{{model.customerName}}</a> <span class="label bg-fuchsia" ng-show="model.potential">潜在</span></td>
                            <td>
                                <span class="text-yellow" uib-rating ng-model="model.star" max="5" ng-click="updateStar(model)"></span>
                            </td>
                            <td>{{model.tel}}</td>
                            <td><a target="_blank" ng-href="{{model.website}}" ng-show="model.website!=null">{{model.website}}</a></td>
                            <td>{{model.industry.industryName}}</td>
                            <td>{{model.customerCategory.categoryName}}</td>
                            <td>{{model.source.sourceName}}</td>
                            <td>
                                <span ng-show="model.provinceId!=null">{{model.province.name}}</span> <span ng-show="model.cityId!=null">{{model.city.name}}</span>
                            </td>
                            <td>
                                <button type="button" class="btn btn-primary btn-xs" ng-click="showEdit(model.customerId)"><i class="fa fa-pencil"></i> 编辑</button>
                            </td>
                        </tr>
                        <tr ng-show="list==null || list.length==0">
                            <td class="text-center text-muted" colspan="9">
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

    <script type="text/ng-template" id="Add.html">
        <div class="modal-dialog" ng-init="init();">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" ng-click="cancel()"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">添加新客户</h4>
                </div>
                <div class="modal-body">
                    <form role="form" name="form" novalidate>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <label>客户名称 <span class="text-red">*</span></label>
                                    <input type="text" class="form-control" name="customerName" ng-model="Model.customerName" placeholder="客户名称" required maxlength="30" ng-ajax="customer/checkCustomerName">
                                    <div ng-show="form.customerName.$dirty && form.customerName.$error.required" class="text-red">请输入客户名称</div>
                                    <div ng-show="form.customerName.$dirty && form.customerName.$error.ngAjax" class="text-red">客户名称已存在</div>
                                </div>
                                <div class="form-group">
                                    <label>联系电话</label>
                                    <input type="text" class="form-control" name="tel" ng-model="Model.tel" placeholder="联系电话" maxlength="30">
                                </div>
                                <div class="form-group">
                                    <label>详细地址</label>
                                    <input type="text" class="form-control" name="address" ng-model="Model.address" placeholder="详细地址" maxlength="100">
                                </div>
                                <div class="form-group">
                                    <label>网址</label>
                                    <input type="text" class="form-control" name="website" ng-model="Model.website" placeholder="网址" maxlength="255">
                                </div>
                                <div class="form-group">
                                    <label>所在地区</label>
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <ui-select ng-model="Model.selectedProvince" on-select="Model.provinceId=Model.selectedProvince.id" ng-change="provinceChange()">
                                                <ui-select-match placeholder="请选择省份">{{Model.selectedProvince.name}}</ui-select-match>
                                                <ui-select-choices repeat="province in provinceList">
                                                    <span ng-bind="province.name"></span>
                                                </ui-select-choices>
                                            </ui-select>
                                        </div>
                                        <div class="col-lg-6">
                                            <ui-select ng-model="Model.selectedCity" on-select="Model.cityId=Model.selectedCity.id">
                                                <ui-select-match placeholder="请选择城市">{{Model.selectedCity.name}}</ui-select-match>
                                                <ui-select-choices repeat="city in cityList">
                                                    <span ng-bind="city.name"></span>
                                                </ui-select-choices>
                                            </ui-select>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label>所属行业</label>
                                    <ui-select ng-model="Model.selectedIndustry" on-select="Model.industryId=Model.selectedIndustry.industryId">
                                        <ui-select-match placeholder="请选择行业">{{Model.selectedIndustry.industryName}}</ui-select-match>
                                        <ui-select-choices repeat="industry in industryList">
                                            <span ng-bind="industry.industryName"></span>
                                        </ui-select-choices>
                                    </ui-select>
                                </div>
                                <div class="form-group">
                                    <label>客户类型</label>
                                    <ui-select ng-model="Model.selectedCategory" on-select="Model.categoryId=Model.selectedCategory.categoryId">
                                        <ui-select-match placeholder="请选择客户类型">{{Model.selectedCategory.categoryName}}</ui-select-match>
                                        <ui-select-choices repeat="category in customerCategoryList">
                                            <span ng-bind="category.categoryName"></span>
                                        </ui-select-choices>
                                    </ui-select>
                                </div>
                                <div class="form-group">
                                    <label>客户来源</label>
                                    <ui-select ng-model="Model.selectedSource" on-select="Model.sourceId=Model.selectedSource.sourceId">
                                        <ui-select-match placeholder="请选择客户来源">{{Model.selectedSource.sourceName}}</ui-select-match>
                                        <ui-select-choices repeat="source in sourceList">
                                            <span ng-bind="source.sourceName"></span>
                                        </ui-select-choices>
                                    </ui-select>
                                </div>
                                <div class="form-group">
                                    <label>潜在客户</label>
                                    <div class="radio">
                                        <label class="checkbox-inline">
                                            <input type="checkbox" name="potential" ng-model="Model.potential" ng-value="true"> 潜在客户
                                        </label>
                                    </div>
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
        <div class="modal-dialog" ng-init="init()">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" ng-click="cancel()"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">编辑客户</h4>
                </div>
                <div class="modal-body">
                    <form role="form" name="form" novalidate>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <label>客户名称 <span class="text-red">*</span></label>
                                    <input type="text" class="form-control" name="customerName" ng-model="Model.customerName" placeholder="客户名称" required maxlength="30" ng-ajax="customer/checkCustomerName">
                                    <div ng-show="form.customerName.$dirty && form.customerName.$error.required" class="text-red">请输入客户名称</div>
                                    <div ng-show="form.customerName.$dirty && form.customerName.$error.ngAjax" class="text-red">客户名称已存在</div>
                                </div>
                                <div class="form-group">
                                    <label>联系电话</label>
                                    <input type="text" class="form-control" name="tel" ng-model="Model.tel" placeholder="联系电话" maxlength="30">
                                </div>
                                <div class="form-group">
                                    <label>详细地址</label>
                                    <input type="text" class="form-control" name="address" ng-model="Model.address" placeholder="详细地址" maxlength="100">
                                </div>
                                <div class="form-group">
                                    <label>网址</label>
                                    <input type="text" class="form-control" name="website" ng-model="Model.website" placeholder="网址" maxlength="255">
                                </div>
                                <div class="form-group">
                                    <label>所在地区</label>
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <ui-select ng-model="Model.selectedProvince" on-select="Model.provinceId=Model.selectedProvince.id" ng-change="provinceChange()">
                                                <ui-select-match placeholder="请选择省份">{{Model.selectedProvince.name}}</ui-select-match>
                                                <ui-select-choices repeat="province in provinceList">
                                                    <span ng-bind="province.name"></span>
                                                </ui-select-choices>
                                            </ui-select>
                                        </div>
                                        <div class="col-lg-6">
                                            <ui-select ng-model="Model.selectedCity" on-select="Model.cityId=Model.selectedCity.id">
                                                <ui-select-match placeholder="请选择城市">{{Model.selectedCity.name}}</ui-select-match>
                                                <ui-select-choices repeat="city in cityList">
                                                    <span ng-bind="city.name"></span>
                                                </ui-select-choices>
                                            </ui-select>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label>所属行业</label>
                                    <ui-select ng-model="Model.selectedIndustry" on-select="Model.industryId=Model.selectedIndustry.industryId">
                                        <ui-select-match placeholder="请选择行业">{{Model.selectedIndustry.industryName}}</ui-select-match>
                                        <ui-select-choices repeat="industry in industryList">
                                            <span ng-bind="industry.industryName"></span>
                                        </ui-select-choices>
                                    </ui-select>
                                </div>
                                <div class="form-group">
                                    <label>客户类型</label>
                                    <ui-select ng-model="Model.selectedCategory" on-select="Model.categoryId=Model.selectedCategory.categoryId">
                                        <ui-select-match placeholder="请选择客户类型">{{Model.selectedCategory.categoryName}}</ui-select-match>
                                        <ui-select-choices repeat="category in customerCategoryList">
                                            <span ng-bind="category.categoryName"></span>
                                        </ui-select-choices>
                                    </ui-select>
                                </div>
                                <div class="form-group">
                                    <label>客户来源</label>
                                    <ui-select ng-model="Model.selectedSource" on-select="Model.sourceId=Model.selectedSource.sourceId">
                                        <ui-select-match placeholder="请选择客户来源">{{Model.selectedSource.sourceName}}</ui-select-match>
                                        <ui-select-choices repeat="source in sourceList">
                                            <span ng-bind="source.sourceName"></span>
                                        </ui-select-choices>
                                    </ui-select>
                                </div>
                                <div class="form-group">
                                    <label>潜在客户</label>
                                    <div class="radio">
                                        <label class="checkbox-inline">
                                            <input type="checkbox" name="potential" ng-model="Model.potential" ng-value="true"> 潜在客户
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal" ng-click="cancel()"><i class="fa fa-close"></i> 关闭</button>
                    <button type="button" class="btn btn-primary" ng-disabled="form.$invalid || loading" ng-click="ok()"><i class="fa fa-save"></i> 更新</button>
                </div>
            </div>
        </div>
    </script>
</section>
</@Base.Layout>