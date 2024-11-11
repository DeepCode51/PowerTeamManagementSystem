<#import "../shared/layout.ftl" as Base>
<#macro header>
<script src="js/controller/crm/contacts.js"></script>
</#macro>
<@Base.Layout header=header>
<section class="content-header">
    <h1>
        联系人管理
    </h1>
    <ol class="breadcrumb">
        <li><i class="fa fa-phone"></i> 联系人</li>
        <li class="active">联系人管理</li>
    </ol>
</section>
<section class="content" ng-controller="contactsList" ng-init="init();">
    <div class="row">
        <div class="col-md-12 col-lg-2">
            <div class="box box-widget">
                <div class="box-header">
                    <h3 class="box-title"><b>查询联系人</b></h3>
                </div>
                <div class="box-body">
                    <div class="form-group">
                        <input type="text" class="form-control" ng-model="query.word" placeholder="联系人名称">
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-12 col-lg-10">
            <div class="box box-widget">
                <div class="box-header">
                    <button type="button" class="btn btn-primary btn-sm" ng-click="showAdd()"><i class="fa fa-plus"></i> 新联系人</button>
                </div>
                <div class="box-body table-responsive no-padding">
                    <table class="table table-hover">
                        <tbody>
                        <tr>
                            <th>姓名</th>
                            <th>性别</th>
                            <th>手机</th>
                            <th>职务</th>
                            <th>所属客户</th>
                            <th>部门</th>
                            <th>电子邮件</th>
                            <th>座机</th>
                            <th>传真</th>
                            <th>QQ</th>
                            <th>微信</th>
                            <th>创建者</th>
                            <th>操作</th>
                        </tr>
                        <tr ng-repeat="model in list">
                            <td>{{model.name}}</td>
                            <td>{{model.sex?'男':'女'}}</td>
                            <td>{{model.phone}}</td>
                            <td>{{model.title}}</td>
                            <td>{{model.customer!=null?model.customer.customerName:null}}</td>
                            <td>{{model.dept}}</td>
                            <td>{{model.email}}</td>
                            <td>{{model.tel}}</td>
                            <td>{{model.fax}}</td>
                            <td>{{model.qq}}</td>
                            <td>{{model.wx}}</td>
                            <td>{{model.createByUser.realName}}</td>
                            <td>
                                <button type="button" class="btn btn-primary btn-xs" ng-click="showEdit(model.contactsId)"><i class="fa fa-pencil"></i> 编辑</button>
                            </td>
                        </tr>
                        <tr ng-show="list==null || list.length==0">
                            <td class="text-center text-muted" colspan="11">
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
                    <h4 class="modal-title">添加新联系人</h4>
                </div>
                <div class="modal-body">
                    <form role="form" name="form" novalidate>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>姓名 <span class="text-red">*</span></label>
                                    <input type="text" class="form-control" name="name" ng-model="Model.name" placeholder="姓名" required maxlength="30">
                                    <div ng-show="form.name.$dirty && form.name.$error.required" class="text-red">请输入姓名</div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>手机 <span class="text-red">*</span></label>
                                    <input type="text" class="form-control" name="phone" ng-model="Model.phone" placeholder="手机" maxlength="30" required>
                                    <div ng-show="form.phone.$dirty && form.phone.$error.required" class="text-red">请输入手机</div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>职务 <span class="text-red">*</span></label>
                                    <input type="text" class="form-control" name="title" ng-model="Model.title" placeholder="职务" maxlength="30" required>
                                    <div ng-show="form.title.$dirty && form.title.$error.required" class="text-red">请输入职务</div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>部门</label>
                                    <input type="text" class="form-control" name="dept" ng-model="Model.dept" placeholder="部门" maxlength="30">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>所属客户</label>
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
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>电子邮件</label>
                                    <input type="email" class="form-control" name="email" ng-model="Model.email" placeholder="电子邮件" maxlength="255">
                                    <div ng-show="form.email.$dirty && form.email.$error.email" class="text-red">电子邮件格式不正确</div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>座机</label>
                                    <input type="text" class="form-control" name="tel" ng-model="Model.tel" placeholder="座机" maxlength="30">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>传真</label>
                                    <input type="text" class="form-control" name="fax" ng-model="Model.fax" placeholder="传真" maxlength="30">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>QQ</label>
                                    <input type="text" class="form-control" name="qq" ng-model="Model.qq" placeholder="QQ" maxlength="30">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>微信</label>
                                    <input type="text" class="form-control" name="wx" ng-model="Model.wx" placeholder="微信" maxlength="30">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label>性别 <span class="text-red">*</span></label>
                                    <div class="radio">
                                        <label>
                                            <input type="radio" ng-model="Model.sex" ng-value="true"> 男
                                        </label>
                                        <label>
                                            <input type="radio" ng-model="Model.sex" ng-value="false"> 女
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
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>姓名 <span class="text-red">*</span></label>
                                    <input type="text" class="form-control" name="name" ng-model="Model.name" placeholder="姓名" required maxlength="30">
                                    <div ng-show="form.name.$dirty && form.name.$error.required" class="text-red">请输入姓名</div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>手机 <span class="text-red">*</span></label>
                                    <input type="text" class="form-control" name="phone" ng-model="Model.phone" placeholder="手机" maxlength="30" required>
                                    <div ng-show="form.phone.$dirty && form.phone.$error.required" class="text-red">请输入手机</div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>职务 <span class="text-red">*</span></label>
                                    <input type="text" class="form-control" name="title" ng-model="Model.title" placeholder="职务" maxlength="30" required>
                                    <div ng-show="form.title.$dirty && form.title.$error.required" class="text-red">请输入职务</div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>部门</label>
                                    <input type="text" class="form-control" name="dept" ng-model="Model.dept" placeholder="部门" maxlength="30">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>所属客户</label>
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
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>电子邮件</label>
                                    <input type="email" class="form-control" name="email" ng-model="Model.email" placeholder="电子邮件" maxlength="255">
                                    <div ng-show="form.email.$dirty && form.email.$error.email" class="text-red">电子邮件格式不正确</div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>座机</label>
                                    <input type="text" class="form-control" name="tel" ng-model="Model.tel" placeholder="座机" maxlength="30">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>传真</label>
                                    <input type="text" class="form-control" name="fax" ng-model="Model.fax" placeholder="传真" maxlength="30">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>QQ</label>
                                    <input type="text" class="form-control" name="qq" ng-model="Model.qq" placeholder="QQ" maxlength="30">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>微信</label>
                                    <input type="text" class="form-control" name="wx" ng-model="Model.wx" placeholder="微信" maxlength="30">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label>性别 <span class="text-red">*</span></label>
                                    <div class="radio">
                                        <label>
                                            <input type="radio" ng-model="Model.sex" ng-value="true"> 男
                                        </label>
                                        <label>
                                            <input type="radio" ng-model="Model.sex" ng-value="false"> 女
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