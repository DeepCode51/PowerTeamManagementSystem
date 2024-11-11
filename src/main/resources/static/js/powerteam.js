String.prototype.endsWith = function (suffix) {
    return this.indexOf(suffix, this.length - suffix.length) !== -1;
};

var powerteam = angular.module('PowerTeam', ['ngNotify', 'ui.bootstrap', 'ui.select', 'switcher', 'ngFormValidation', 'angular.filter', 'angular-treeList', 'angular-baidu-map', 'angularMoment']);

powerteam.run(['$rootScope', 'ngNotify', function ($rootScope, ngNotify) {
    $rootScope.requestCount = 0;
    $rootScope.loading = false;
    $rootScope.disableLoading = false;

    ngNotify.config({
        theme: 'pure',
        position: 'top',
        duration: 1000,
        type: 'info',
        sticky: false,
        button: true,
        html: false
    });
}]);

powerteam.config(['$httpProvider', function ($httpProvider) {
    $httpProvider.interceptors.push(['$q', '$rootScope', '$timeout', function ($q, $rootScope, $timeout) {
        return {
            'request': function (config) {
                if (!config.disableLoading && !config.url.endsWith('.html')) {
                    $rootScope.requestCount++;
                    $rootScope.loading = $rootScope.requestCount > 0;
                }
                return config;
            },
            'requestError': function (rejection) {
                if (!rejection.config.disableLoading && !rejection.config.url.endsWith('.html')) {
                    $rootScope.requestCount--;
                    $rootScope.loading = $rootScope.requestCount > 0;
                }
                return $q.reject(rejection);
            },
            'response': function (response) {
                if (!response.config.disableLoading && !response.config.url.endsWith('.html')) {
                    $rootScope.requestCount--;
                    $rootScope.loading = $rootScope.requestCount > 0;
                }
                return response;
            },
            'responseError': function (rejection) {
                if (rejection.status == 403) {
                    go("");
                }
                if (!rejection.config.disableLoading && !rejection.config.url.endsWith('.html')) {
                    $rootScope.requestCount--;
                    $rootScope.loading = $rootScope.requestCount > 0;
                }
                return $q.reject(rejection);
            }
        };
    }]);
}]);

powerteam.config(['uibDatepickerPopupConfig', 'uibPaginationConfig', '$uibModalProvider', function (uibDatepickerPopupConfig, uibPaginationConfig, $uibModalProvider) {
    uibDatepickerPopupConfig.closeText = '关闭';
    uibDatepickerPopupConfig.clearText = '清空';
    uibDatepickerPopupConfig.currentText = '今天';

    uibPaginationConfig.previousText = '‹';
    uibPaginationConfig.nextText = '›';
    uibPaginationConfig.firstText = '«';
    uibPaginationConfig.lastText = '»';
    uibPaginationConfig.maxSize = 10;
    uibPaginationConfig.boundaryLinks = true;

    $uibModalProvider.options.animation = true;
}]);

angular.module("uib/template/pagination/pagination.html", []).run(["$templateCache", function ($templateCache) {
    $templateCache.put("uib/template/pagination/pagination.html",
        "<li><a href=\"javascript:void(0);\">共 {{totalItems}} 条</a></li>\n" +
        "<li ng-if=\"::boundaryLinks\" ng-class=\"{disabled: noPrevious()||ngDisabled}\" class=\"pagination-first\"><a href ng-click=\"selectPage(1, $event)\" ng-disabled=\"noPrevious()||ngDisabled\" uib-tabindex-toggle>{{::getText('first')}}</a></li>\n" +
        "<li ng-if=\"::directionLinks\" ng-class=\"{disabled: noPrevious()||ngDisabled}\" class=\"pagination-prev\"><a href ng-click=\"selectPage(page - 1, $event)\" ng-disabled=\"noPrevious()||ngDisabled\" uib-tabindex-toggle>{{::getText('previous')}}</a></li>\n" +
        "<li ng-repeat=\"page in pages track by $index\" ng-class=\"{active: page.active,disabled: ngDisabled&&!page.active}\" class=\"pagination-page\"><a href ng-click=\"selectPage(page.number, $event)\" ng-disabled=\"ngDisabled&&!page.active\" uib-tabindex-toggle>{{page.text}}</a></li>\n" +
        "<li ng-if=\"::directionLinks\" ng-class=\"{disabled: noNext()||ngDisabled}\" class=\"pagination-next\"><a href ng-click=\"selectPage(page + 1, $event)\" ng-disabled=\"noNext()||ngDisabled\" uib-tabindex-toggle>{{::getText('next')}}</a></li>\n" +
        "<li ng-if=\"::boundaryLinks\" ng-class=\"{disabled: noNext()||ngDisabled}\" class=\"pagination-last\"><a href ng-click=\"selectPage(totalPages, $event)\" ng-disabled=\"noNext()||ngDisabled\" uib-tabindex-toggle>{{::getText('last')}}</a></li>\n" +
        "");
}]);

powerteam.controller('layout', ['$scope', '$window', '$http', '$uibModal', function ($scope, $window, $http, $uibModal) {
    $scope.menuTree = null;

    $scope.activeParentMenu = function () {
        return parseInt($window.sessionStorage.getItem('activeParentMenu'));
    };

    $scope.activeChildMenu = function () {
        return parseInt($window.sessionStorage.getItem('activeChildMenu'));
    };

    $scope.parentMenuClick = function (parentMenu) {
        if (parentMenu.children.length > 0) {
            return;
        } else {
            $window.sessionStorage.setItem('activeParentMenu', parentMenu.node.menuId);
            $window.sessionStorage.setItem('activeChildMenu', null);
            go(parentMenu.node.menuLink);
        }
    };

    $scope.childMenuClick = function (parentMenu, childMenu) {
        $window.sessionStorage.setItem('activeParentMenu', parentMenu.node.menuId);
        $window.sessionStorage.setItem('activeChildMenu', childMenu.node.menuId);
        go(childMenu.node.menuLink);
    };

    $scope.findUserMenuTree = function () {
        $http.post('menu/findUserMenuTree').then(function (response) {
            $scope.menuTree = response.data;
        });
    };

    $scope.signOut = function () {
        $window.sessionStorage.clear();
        go('signOut');
    };

    $scope.confirm = function (title, content) {
        return $uibModal.open({
            templateUrl: 'confirm.html', controller: 'confirmCtrl', resolve: {
                title: function () {
                    return title;
                }, content: function () {
                    return content;
                }
            }
        }).result;
    };
}]);

powerteam.controller('confirmCtrl', ['$scope', '$uibModalInstance', 'title', 'content', function ($scope, $uibModalInstance, title, content) {
    $scope.title = title;
    $scope.content = content;

    $scope.ok = function () {
        $uibModalInstance.close();
    };

    $scope.cancel = function () {
        $uibModalInstance.dismiss('cancel');
    };
}]);

function go(url) {
    var baseUrl = document.getElementsByTagName("base")[0].href;
    window.location.href = baseUrl + url;
}