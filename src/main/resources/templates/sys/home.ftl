<!DOCTYPE html>
<html ng-app="PowerTeam" class="login">
<head>
    <base href="${PowerTeam.webRoot}">
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=11"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>${PowerTeam.title}</title>
    <#include "../shared/cssAndJs.ftl">
    <script src="js/controller/sys/home.js"></script>
</head>
<body>
<div class="login-box" ng-controller="signIn">
    <div class="login-box-body">
        <div class="login-logo">
            <a href="${PowerTeam.webRoot}"><b>${PowerTeam.title}</b></a>
        </div>
        <p class="login-box-msg">疾如风，徐如林!</p>
        <form ng-submit="signIn()">
            <div class="form-group has-feedback">
                <input type="text" class="form-control" ng-model="User.userName" placeholder="用户名">
                <span class="fa fa-user form-control-feedback"></span>
            </div>
            <div class="form-group has-feedback">
                <input type="password" class="form-control" ng-model="User.password" placeholder="密码">
                <span class="fa fa-lock form-control-feedback"></span>
            </div>
            <div class="row">
                <div class="col-xs-offset-8 col-xs-4">
                    <button type="submit" class="btn btn-primary btn-block btn-flat" ng-disabled="loading">登陆</button>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>