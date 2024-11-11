<#macro defaultHeader>
</#macro>
<#macro Layout header=defaultHeader>
<!DOCTYPE html>
<html ng-app="PowerTeam">
<head>
    <base href="${PowerTeam.webRoot}">
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <title>${PowerTeam.title}</title>
    <#include "../shared/cssAndJs.ftl">
    <@header />
</head>
<body class="hold-transition skin-blue-light sidebar-mini" ng-clock>
<#--<div class="loading" ng-show="loading">-->
    <#--<div class="circles-loader">-->
    <#--</div>-->
<#--</div>-->
<div class="wrapper" ng-controller="layout" ng-init="findUserMenuTree()">
    <header class="main-header">
        <a href="${PowerTeam.webRoot}" class="logo">
            <span class="logo-mini"><b>${PowerTeam.title}</b></span>
            <span class="logo-lg"><b>${PowerTeam.title}</b></span>
        </a>
        <nav class="navbar navbar-static-top">
            <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
                <span class="sr-only">Toggle navigation</span>
            </a>
            <div class="navbar-custom-menu">
                <ul class="nav navbar-nav">
                    <li class="dropdown user user-menu">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <img src="${User.avatar}" class="user-image">
                            <span class="hidden-xs">${User.realName}</span>
                        </a>
                        <ul class="dropdown-menu">
                            <li class="user-header">
                                <img src="${User.avatar}" class="img-circle" alt="User Image">
                                <p>
                                ${User.realName}
                                    <small>welcome!</small>
                                </p>
                            </li>
                            <li class="user-footer">
                                <div class="pull-left">
                                    <a href="user/profile" class="btn btn-default btn-flat">设置</a>
                                </div>
                                <div class="pull-right">
                                    <button ng-click="signOut()" class="btn btn-default btn-flat">注销</button>
                                </div>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
        </nav>
    </header>
    <aside class="main-sidebar">
        <section class="sidebar">
            <div class="user-panel">
                <div class="pull-left image">
                    <img src="${User.avatar}" class="img-circle">
                </div>
                <div class="pull-left info">
                    <p>${User.realName}</p>
                    <a><i class="fa fa-circle text-success"></i> Online</a>
                </div>
            </div>
            <form action="#" method="get" class="sidebar-form">
                <div class="input-group">
                    <input type="text" name="q" class="form-control" placeholder="搜索">
                    <span class="input-group-btn">
                        <button type="submit" name="search" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i>
                        </button>
                      </span>
                </div>
            </form>
            <ul class="sidebar-menu">
                <li class="header">MAIN NAVIGATION</li>
                <li class="treeview" ng-class="{'active':activeParentMenu()==parentMenu.node.menuId}" ng-repeat="parentMenu in menuTree">
                    <a href="javascript:void(0)" ng-click="parentMenuClick(parentMenu)">
                        <i ng-class="parentMenu.node.menuIcon"></i><span> {{parentMenu.node.menuName}}</span>
                        <span class="pull-right-container">
                            <i class="fa fa-angle-left pull-right" ng-if="parentMenu.children.length>0"></i>
                        </span>
                    </a>
                    <ul class="treeview-menu" ng-if="parentMenu.children.length>0">
                        <li ng-class="{'active':activeChildMenu()==childMenu.node.menuId}" ng-repeat="childMenu in parentMenu.children">
                            <a href="javascript:void(0)" ng-click="childMenuClick(parentMenu,childMenu)">
                                <i ng-class="childMenu.node.menuIcon" }"></i> {{childMenu.node.menuName}}
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>
        </section>
    </aside>
    <div class="content-wrapper">
        <#nested/>
    </div>
    <footer class="main-footer">
        <div class="pull-right hidden-xs">
            <b>Version</b> 0.0.1
        </div>
        <strong>Copyright &copy; 2016 <a href="${PowerTeam.webRoot}">${PowerTeam.title}</a>.</strong> All rights reserved.
    </footer>
    <script type="text/ng-template" id="confirm.html">
        <div class="modal-header">
            <h3 class="modal-title">{{title}}</h3>
        </div>
        <div class="modal-body">
            {{content}}
        </div>
        <div class="modal-footer">
            <button class="btn btn-danger" type="button" ng-click="ok()">确定</button>
            <button class="btn btn-default" type="button" ng-click="cancel()">取消</button>
        </div>
    </script>
</div>
</body>
</html>
</#macro>