<#import "../shared/layout.ftl" as Base>
<#macro header>
<script src="js/controller/sys/user.js"></script>
</#macro>
<@Base.Layout header=header>
<section class="content-header">
    <h1>
        用户管理
    </h1>
    <ol class="breadcrumb">
        <li><i class="fa fa-cogs"></i> 系统管理</li>
        <li class="active">用户管理</li>
    </ol>
</section>
<section class="content" ng-controller="userList" ng-init="init();">
    <div class="row">
        <div class="col-xs-12 col-sm-3 col-lg-2">
            <div class="box box-widget">
                <div class="box-header">
                    <h3 class="box-title"><b>查询用户</b></h3>
                </div>
                <div class="box-body">
                    <div class="form-group">
                        <input type="text" class="form-control" ng-model="query.word" placeholder="用户名 / 真实姓名">
                    </div>
                    <div class="form-group">
                        <div class="input-group">
                            <input type="text" class="form-control" uib-datepicker-popup ng-model="query.startDate" ng-focus="showStartDate=true" is-open="showStartDate" readonly placeholder="创建开始日期">
                            <div class="input-group-btn">
                                <button type="button" class="btn btn-default" ng-click="showStartDate=true"><i class="fa fa-calendar"></i></button>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="input-group">
                            <input type="text" class="form-control" uib-datepicker-popup ng-model="query.endDate" ng-focus="showEndDate=true" is-open="showEndDate" readonly placeholder="创建结束日期">
                            <div class="input-group-btn">
                                <button type="button" class="btn btn-default" ng-click="showEndDate=true"><i class="fa fa-calendar"></i></button>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <ui-select ng-model="query.selectedStatus" on-select="query.status=query.selectedStatus.value">
                            <ui-select-match placeholder="请选择用户状态">{{query.selectedStatus.text}}</ui-select-match>
                            <ui-select-choices repeat="status in statusList">
                                <span ng-bind="status.text"></span>
                            </ui-select-choices>
                        </ui-select>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xs-12 col-sm-9 col-lg-10">
            <div class="box box-widget">
                <div class="box-header">
                    <button type="button" class="btn btn-primary btn-sm" ng-click="showAdd()"><i class="fa fa-plus"></i> 新用户</button>
                </div>
                <div class="box-body table-responsive no-padding">
                    <table class="table table-hover">
                        <tbody>
                        <tr>
                            <th>#</th>
                            <th>头像</th>
                            <th>用户名</th>
                            <th>真实姓名</th>
                            <th>性别</th>
                            <th>启用状态</th>
                            <th>注册日期</th>
                            <th>操作</th>
                        </tr>
                        <tr ng-repeat="model in list">
                            <td>{{$index+1}}</td>
                            <td><img ng-src="{{model.avatar}}" class="img-circle img-sm"></td>
                            <td>{{model.userName}}</td>
                            <td>{{model.realName}}</td>
                            <td ng-switch="model.gender"><span ng-switch-when="true"><i class="fa fa-mars"></i> 男</span><span ng-switch-when="false"><i class="fa fa-venus"></i> 女</span></td>
                            <td>
                                <switcher class="switcher" ng-model="model.status" true-value="1" false-value="2" ng-change="updateStatus(newValue,oldValue,model)" true-label="" false-label=""></switcher>
                            </td>
                            <td>{{model.createAt | date:'yyyy-MM-dd HH:mm'}}</td>
                            <td>
                                <button type="button" class="btn btn-primary btn-xs" ng-click="showEdit(model.userId)"><i class="fa fa-pencil"></i> 编辑</button>
                                <button type="button" class="btn btn-warning btn-xs" uib-tooltip="新密码为123456" ng-click="resetPassword(model.userId)"><i class="fa fa-key"></i> 重置密码</button>
                                <button type="button" class="btn btn-danger btn-xs" ng-click="remove(model.userId)"><i class="fa fa-trash-o"></i> 删除</button>
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
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" ng-click="cancel()"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">添加新用户</h4>
                </div>
                <div class="modal-body">
                    <form role="form" name="form" novalidate>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <label>用户名 <span class="text-red">*</span></label>
                                    <input type="text" class="form-control" name="userName" ng-model="Model.userName" placeholder="用户名" required maxlength="30" ng-ajax="user/checkUserName">
                                    <div ng-show="form.userName.$dirty && form.userName.$error.required" class="text-red">请输入用户名</div>
                                    <div ng-show="form.userName.$dirty && form.userName.$error.ngAjax" class="text-red">用户名已存在</div>
                                </div>
                                <div class="form-group">
                                    <label>真实姓名 <span class="text-red">*</span></label>
                                    <input type="text" class="form-control" name="realName" ng-model="Model.realName" placeholder="真实姓名" required maxlength="10">
                                    <div ng-show="form.realName.$dirty && form.realName.$error.required" class="text-red">请输入真实姓名</div>
                                </div>
                                <div class="form-group">
                                    <label>密码 <span class="text-red">*</span></label>
                                    <input type="password" class="form-control" name="password" ng-model="Model.password" placeholder="密码" required maxlength="30">
                                    <div ng-show="form.password.$dirty && form.password.$error.required" class="text-red">请输入密码</div>
                                </div>
                                <div class="form-group">
                                    <label>确认密码 <span class="text-red">*</span></label>
                                    <input type="password" class="form-control" name="passwordConfirm" ng-model="passwordConfirm" placeholder="确认密码" required maxlength="30" ng-match="Model.password">
                                    <div ng-show="form.passwordConfirm.$dirty && form.passwordConfirm.$error.required" class="text-red">请输入确认密码</div>
                                    <div ng-show="form.passwordConfirm.$dirty && form.passwordConfirm.$error.ngMatch" class="text-red">两次密码不匹配</div>
                                </div>
                                <div class="form-group">
                                    <label>头像</label>
                                    <br>
                                    <label class="img-picker">
                                        <input type="radio" name="avatar" ng-model="Model.avatar" ng-value="'img/avatar/avatar1.png'"> <img src="img/avatar/avatar1.png" class="img-circle img64">
                                    </label>
                                    <label class="img-picker">
                                        <input type="radio" name="avatar" ng-model="Model.avatar" ng-value="'img/avatar/avatar2.png'"> <img src="img/avatar/avatar2.png" class="img-circle img64">
                                    </label>
                                    <label class="img-picker">
                                        <input type="radio" name="avatar" ng-model="Model.avatar" ng-value="'img/avatar/avatar3.png'"> <img src="img/avatar/avatar3.png" class="img-circle img64">
                                    </label>
                                    <label class="img-picker">
                                        <input type="radio" name="avatar" ng-model="Model.avatar" ng-value="'img/avatar/avatar4.png'"> <img src="img/avatar/avatar4.png" class="img-circle img64">
                                    </label>
                                </div>
                                <div class="form-group">
                                    <label class="radio-inline">
                                        <input type="radio" name="gender" ng-model="Model.gender" ng-value="1"> 男
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="gender" ng-model="Model.gender" ng-value="0"> 女
                                    </label>
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
                    <h4 class="modal-title">编辑用户</h4>
                </div>
                <div class="modal-body">
                    <form role="form" name="form" novalidate>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <label>用户名 <span class="text-red">*</span></label>
                                    <input type="text" class="form-control" name="userName" ng-model="Model.userName" placeholder="用户名" required maxlength="30" disabled="disabled">
                                    <div ng-show="form.userName.$dirty && form.userName.$error.required" class="text-red">请输入用户名</div>
                                    <div ng-show="form.userName.$dirty && form.userName.$error.ngAjax" class="text-red">用户名已存在</div>
                                </div>
                                <div class="form-group">
                                    <label>真实姓名 <span class="text-red">*</span></label>
                                    <input type="text" class="form-control" name="realName" ng-model="Model.realName" placeholder="真实姓名" required maxlength="10">
                                    <div ng-show="form.realName.$dirty && form.realName.$error.required" class="text-red">请输入真实姓名</div>
                                </div>
                                <div class="form-group">
                                    <label>头像</label>
                                    <br>
                                    <label class="img-picker">
                                        <input type="radio" name="avatar" ng-model="Model.avatar" ng-value="'img/avatar/avatar1.png'"> <img src="img/avatar/avatar1.png" class="img-circle img64">
                                    </label>
                                    <label class="img-picker">
                                        <input type="radio" name="avatar" ng-model="Model.avatar" ng-value="'img/avatar/avatar2.png'"> <img src="img/avatar/avatar2.png" class="img-circle img64">
                                    </label>
                                    <label class="img-picker">
                                        <input type="radio" name="avatar" ng-model="Model.avatar" ng-value="'img/avatar/avatar3.png'"> <img src="img/avatar/avatar3.png" class="img-circle img64">
                                    </label>
                                    <label class="img-picker">
                                        <input type="radio" name="avatar" ng-model="Model.avatar" ng-value="'img/avatar/avatar4.png'"> <img src="img/avatar/avatar4.png" class="img-circle img64">
                                    </label>
                                </div>
                                <div class="form-group">
                                    <label class="radio-inline">
                                        <input type="radio" name="gender" ng-model="Model.gender" ng-value="1"> 男
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="gender" ng-model="Model.gender" ng-value="0"> 女
                                    </label>
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