powerteam.controller('userList', ['$scope', '$http', 'ngNotify', '$uibModal', function ($scope, $http, ngNotify, $uibModal) {
    $scope.statusList = [{text: '全部用户', value: null}, {text: '已启用', value: 1}, {text: '已禁用', value: 2}];
    $scope.query = {word: null, startDate: null, endDate: null, order: 'userName,createAt desc', status: $scope.statusList[0].value, selectedStatus: $scope.statusList[0], pageNum: 1, total: 0, pageSize: 10};
    $scope.list = [];

    $scope.init = function () {
        $scope.$watchGroup(['query.word','query.startDate','query.endDate','query.status','query.pageNum'], function (newValue, oldValue) {
            $scope.find();
        });
    };

    $scope.find = function () {
        $http.post('user/find', $scope.query).then(function (response) {
            $scope.list = response.data.list;
            $scope.query.pageNum = response.data.pageNum;
            $scope.query.pageSize = response.data.pageSize;
            $scope.query.total = response.data.total;
        });
    };

    $scope.updateStatus = function (newValue, oldValue, model) {
        model.status = newValue;
        $http.post('user/updateStatus', model).then(function (response) {
            if (response.data.success) {
                $scope.find();
            } else {
                ngNotify.set(response.data.message, 'error');
            }
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
        $http.post('user/remove', [id]).then(function (response) {
            if (response.data.success) {
                ngNotify.set('删除成功', 'success');
                $scope.find();
            } else {
                ngNotify.set(response.data.message, 'error');
            }
        });
    };

    $scope.resetPassword = function (id) {
        $http.post('user/resetPassword', {userId: id}).then(function (response) {
            if (response.data.success) {
                ngNotify.set('密码重置成功', 'success');
                $scope.find();
            } else {
                ngNotify.set(response.data.message, 'error');
            }
        });
    };
}]);

powerteam.controller('add', ['$scope', '$http', '$uibModalInstance', 'ngNotify', function ($scope, $http, $uibModalInstance, ngNotify) {
    $scope.Model = {userName: null, realName: null, gender: 1, password: null, avatar: 'img/avatar/avatar1.png'};

    $scope.ok = function () {
        $http.post('user/add', $scope.Model).then(function (response) {
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
        $http.post('user/findById', {userId: id}).then(function (response) {
            $scope.Model = response.data;
        });
    };

    $scope.ok = function () {
        $http.post('user/update', $scope.Model).then(function (response) {
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

powerteam.controller('userProfile', ['$scope', '$http', 'ngNotify', '$window', '$timeout', function ($scope, $http, ngNotify, $window, $timeout) {
    $scope.userId = null;
    $scope.Model = null;

    $scope.init = function () {
        $scope.findById();
    };

    $scope.findById = function () {
        $http.post('user/findById', {userId: $scope.userId}).then(function (response) {
            $scope.Model = response.data;
        });
    };

    $scope.save = function () {
        $http.post('user/update', $scope.Model).then(function (response) {
            if (response.data.success) {
                ngNotify.set('保存成功', 'success');
                $timeout(function () {
                    $window.location.reload();
                }, 500);
            } else {
                ngNotify.set(response.data.message, 'error');
            }
        });
    };

    $scope.updatePassword = function () {
        $http.post('user/updatePassword', $scope.Model).then(function (response) {
            if (response.data.success) {
                ngNotify.set('修改密码成功', 'success');
            } else {
                ngNotify.set(response.data.message, 'error');
            }
        });
    };
}]);