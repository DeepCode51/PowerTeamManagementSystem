powerteam.controller('roleList', ['$scope', '$http', 'ngNotify', '$uibModal', function ($scope, $http, ngNotify, $uibModal) {
    $scope.list = [];

    $scope.find = function () {
        $http.post('role/findAll').then(function (response) {
            $scope.list = response.data;
        });
    };

    $scope.showAdd = function () {
        $uibModal.open({templateUrl: 'Add.html', controller: 'add'}).result.then(function () {
            $scope.find();
        });
    };

    $scope.showEdit = function (id) {
        $uibModal.open({templateUrl: 'Edit.html', controller: 'edit', resolve: {id: id}}).result.then(function () {
            $scope.find();
        });
    };

    $scope.remove = function (id) {
        $http.post('role/remove', [id]).then(function (response) {
            if (response.data.success) {
                ngNotify.set('删除成功', 'success');
                $scope.find();
            } else {
                ngNotify.set(response.data.message, 'error');
            }
        });
    };
}]);

powerteam.controller('add', ['$scope', '$http', '$uibModalInstance', 'ngNotify', function ($scope, $http, $uibModalInstance, ngNotify) {
    $scope.Model = {roleName: null};

    $scope.ok = function () {
        $http.post('role/add', $scope.Model).then(function (response) {
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

powerteam.controller('edit', ['$scope', '$http', '$uibModalInstance', 'ngNotify', 'id', function ($scope, $http, $uibModalInstance, ngNotify, id) {
    $scope.Model = null;

    $scope.init = function () {
        $scope.findById();
    };

    $scope.findById = function () {
        $http.post('role/findById', {roleId: id}).then(function (response) {
            $scope.Model = response.data;
        });
    };

    $scope.ok = function () {
        $http.post('role/update', $scope.Model).then(function (response) {
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