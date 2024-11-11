<#import "../shared/layout.ftl" as Base>
<#macro header>
<script src="js/controller/sys/user.js"></script>
</#macro>
<@Base.Layout header=header>
<section class="content-header">
    <h1>
        用户资料
    </h1>
    <ol class="breadcrumb">
        <li><i class="fa fa-dashboard"></i> 用户管理</li>
        <li class="active">用户资料</li>
    </ol>
</section>
<section class="content" ng-controller="userProfile" ng-init="userId=${User.userId};init();">
    <div class="row">
        <div class="col-md-4 col-md-offset-4">
            <div class="box box-widget">
                <div class="box-header with-border">
                    <div class="user-block">
                        <img class="img-circle" src="${User.avatar}">
                        <span class="username"><a>${User.realName}</a></span>
                        <span class="description">${User.userName}</span>
                    </div>
                </div>
                <div class="box-body">
                    <form role="form" name="form" novalidate>
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
                    </form>
                </div>
                <div class="box-footer">
                    <button type="button" class="btn btn-primary" ng-click="save()" ng-disabled="form.$invalid || loading"><i class="fa fa-save"></i> 修改</button>
                </div>
            </div>
            <div class="box box-widget">
                <div class="box-header with-border">
                    <h3 class="box-title">修改密码</h3>
                </div>
                <div class="box-body">
                    <form role="form" name="passwordForm" novalidate>
                        <div class="form-group">
                            <label>原密码 <span class="text-red">*</span></label>
                            <input type="password" class="form-control" name="rawPassword" ng-model="Model.rawPassword" placeholder="原密码" required maxlength="30">
                            <div ng-show="passwordForm.rawPassword.$dirty && passwordForm.rawPassword.$error.required" class="text-red">请输入密码</div>
                        </div>
                        <div class="form-group">
                            <label>密码 <span class="text-red">*</span></label>
                            <input type="password" class="form-control" name="password" ng-model="Model.password" placeholder="密码" required maxlength="30">
                            <div ng-show="passwordForm.password.$dirty && passwordForm.password.$error.required" class="text-red">请输入密码</div>
                        </div>
                        <div class="form-group">
                            <label>确认密码 <span class="text-red">*</span></label>
                            <input type="password" class="form-control" name="passwordConfirm" ng-model="passwordConfirm" placeholder="确认密码" required maxlength="30" ng-match="Model.password">
                            <div ng-show="passwordForm.passwordConfirm.$dirty && passwordForm.passwordConfirm.$error.required" class="text-red">请输入确认密码</div>
                            <div ng-show="passwordForm.passwordConfirm.$dirty && passwordForm.passwordConfirm.$error.ngMatch" class="text-red">两次密码不匹配</div>
                        </div>
                    </form>
                </div>
                <div class="box-footer">
                    <button type="button" class="btn btn-primary" ng-click="updatePassword()" ng-disabled="passwordForm.$invalid || loading"><i class="fa fa-save"></i> 修改</button>
                </div>
            </div>
        </div>
    </div>
</section>
</@Base.Layout>