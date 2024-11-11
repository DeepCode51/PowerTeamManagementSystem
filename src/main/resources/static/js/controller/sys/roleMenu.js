powerteam.controller('roleMenu', ['$scope', '$http', 'ngNotify', '$filter', function ($scope, $http, ngNotify, $filter) {
    var contains = $filter('contains');
    var map = $filter('map');
    var where = $filter('where');

    $scope.roleId = null;
    $scope.allMenuList = [];
    $scope.roleList = [];
    $scope.roleMenuList = [];

    $scope.init = function () {
        $scope.findAllMenu();
        $scope.findAllRole();
        $scope.findRoleMenu();
    };

    $scope.findAllMenu = function () {
        $http.post('menu/findAllMenu').then(function (response) {
            $scope.allMenuList = response.data;
        });
    };

    $scope.findAllRole = function () {
        $http.post('role/findAll').then(function (response) {
            $scope.roleList = response.data;
        });
    };

    $scope.findRoleMenu = function () {
        $http.post('menu/findRoleMenu', {roleId: $scope.roleId}).then(function (response) {
            $scope.roleMenuList = response.data;
            var roleMenuIdList = map($scope.roleMenuList, 'menuId');
            for (var i = 0; i < $scope.allMenuList.length; i++) {
                var menu = $scope.allMenuList[i];
                if (contains(roleMenuIdList, menu.menuId)) {
                    menu.checked = true;
                } else {
                    menu.checked = false;
                }
            }
        });
    };

    $scope.saveRoleMenu = function () {
        var menuIdList = map(where($scope.allMenuList, {checked: true}), 'menuId');
        $http.post('role/menu/saveMenu', {roleId: $scope.roleId, menuIdList: menuIdList}).then(function (response) {
            if (response.data.success) {
                ngNotify.set('分配成功', 'success');
            } else {
                ngNotify.set(response.data.message, 'error');
            }
        });
    };
}]);