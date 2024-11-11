powerteam.controller('menu', ['$scope', '$http', 'ngNotify', '$uibModal', function ($scope, $http, ngNotify, $uibModal) {
    $scope.menuTree = [];

    $scope.init = function () {
        $scope.findAllMenuTree();
    };

    $scope.findAllMenuTree = function () {
        $http.post('menu/findAllMenuTree').then(function (response) {
            $scope.menuTree = response.data;
        });
    };

    $scope.showAdd = function () {
        $uibModal.open({templateUrl: 'Add.html', controller: 'add'}).result.then(function () {
            $scope.findAllMenuTree();
        });
    };

    $scope.showEdit = function (id) {
        $uibModal.open({templateUrl: 'Edit.html', controller: 'edit', resolve: {id: id}}).result.then(function () {
            $scope.findAllMenuTree();
        });
    };

    $scope.remove = function (menuId) {
        $http.post('menu/remove', {menuId: menuId}).then(function (response) {
            if (response.data.success) {
                ngNotify.set('删除成功', 'success');
                $scope.findAllMenuTree();
            } else {
                ngNotify.set(response.data.message, 'error');
            }
        });
    };

    $scope.up = function (menuId) {
        $http.post('menu/up', {menuId: menuId}).then(function (response) {
            if (response.data.success) {
                ngNotify.set('上调成功', 'success');
                $scope.findAllMenuTree();
            } else {
                ngNotify.set(response.data.message, 'error');
            }
        });
    };

    $scope.down = function (menuId) {
        $http.post('menu/down', {menuId: menuId}).then(function (response) {
            if (response.data.success) {
                ngNotify.set('下调成功', 'success');
                $scope.findAllMenuTree();
            } else {
                ngNotify.set(response.data.message, 'error');
            }
        });
    };
}]);

powerteam.controller('add', ['$scope', '$http', '$uibModalInstance', 'ngNotify', function ($scope, $http, $uibModalInstance, ngNotify) {
    $scope.Model = {pid: 1, menuName: null, menuCode: null, menuLink: null, menuIcon: 'fa fa-circle-o fa-fw', selectedMenu: {menuId: 1, menuName: "根菜单"}};

    $scope.parentMenuList = [];

    $scope.init = function () {
        $scope.findAllMenuTree();
    };

    $scope.findAllMenuTree = function () {
        $http.post('menu/findAllMenuTree').then(function (response) {
            $scope.parentMenuList = [{menuId: 1, menuName: "根菜单"}];
            for (var i = 0; i < response.data.length; i++) {
                var parent = response.data[i];
                $scope.parentMenuList.push(parent.node);
            }
        });
    };

    $scope.ok = function () {
        $http.post('menu/add', $scope.Model).then(function (response) {
            if (response.data.success) {
                ngNotify.set('保存成功', 'success');
                $uibModalInstance.close();
            } else {
                ngNotify.set(response.data.message, 'error');
            }
        });
    };

    $scope.cancel = function () {
        $uibModalInstance.dismiss('cancel');
    };
}]);

powerteam.controller('edit', ['$scope', '$http', '$uibModalInstance', 'ngNotify', 'id', '$q', '$filter', function ($scope, $http, $uibModalInstance, ngNotify, id, $q, $filter) {
    $scope.Model = null;

    $scope.parentMenuList = [];
    var where = $filter('where');

    $scope.init = function () {
        $scope.findAllMenuTree().then(function () {
            $scope.findById();
        });
    };

    $scope.findById = function () {
        $http.post('menu/findById', {menuId: id}).then(function (response) {
            $scope.Model = response.data;
            $scope.Model.selectedMenu = where($scope.parentMenuList, {menuId: $scope.Model.pid})[0];
        });
    };

    $scope.findAllMenuTree = function () {
        var deferred = $q.defer();
        $http.post('menu/findAllMenuTree').then(function (response) {
            $scope.parentMenuList = [{menuId: 1, menuName: "根菜单"}];
            for (var i = 0; i < response.data.length; i++) {
                var parent = response.data[i];
                if (parent.node.menuId == id) {
                    continue;
                }
                $scope.parentMenuList.push(parent.node);
            }
            deferred.resolve();
        });
        return deferred.promise;
    };

    $scope.ok = function () {
        $http.post('menu/update', $scope.Model).then(function (response) {
            if (response.data.success) {
                ngNotify.set('保存成功', 'success');
                $uibModalInstance.close();
            } else {
                ngNotify.set(response.data.message, 'error');
            }
        });
    };

    $scope.cancel = function () {
        $uibModalInstance.dismiss('cancel');
    };
}]);
