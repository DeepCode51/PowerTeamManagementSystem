powerteam.controller('orgUnit', ['$scope', '$http', 'ngNotify', '$uibModal', function ($scope, $http, ngNotify, $uibModal) {
    $scope.allOrgUnitList = [];

    $scope.init = function () {
        $scope.findAllOrgUnit();
    };

    $scope.findAllOrgUnit = function () {
        $scope.allOrgUnitList = [];
        $http.post('orgUnit/findAllOrgUnit').then(function (response) {
            $scope.allOrgUnitList = response.data;
        });
    };

    $scope.showAdd = function () {
        $uibModal.open({templateUrl: 'Add.html', controller: 'add'}).result.then(function () {
            $scope.findAllOrgUnit();
        });
    };

    $scope.showEdit = function ($node, $parentNode) {
        $uibModal.open({templateUrl: 'Edit.html', controller: 'edit', resolve: {id: $node.orgUnitId, parent: $parentNode}}).result.then(function () {
            $scope.findAllOrgUnit();
        });
    };
}]);

powerteam.controller('add', ['$scope', '$http', '$uibModalInstance', 'ngNotify', function ($scope, $http, $uibModalInstance, ngNotify) {
    $scope.allOrgUnitList = [];

    $scope.Model = {orgUnitName: null, pid: null, selectedOrgUnit: {orgUnitId: null, orgUnitName: "空", pid: null}};

    $scope.init = function () {
        $scope.findAllOrgUnit();
    };

    $scope.findAllOrgUnit = function () {
        $scope.allOrgUnitList = [];
        $http.post('orgUnit/findAllOrgUnit').then(function (response) {
            $scope.allOrgUnitList = $scope.allOrgUnitList.concat({orgUnitId: null, orgUnitName: "空", pid: null}, response.data);
        });
    };

    $scope.ok = function () {
        $http.post('orgUnit/add', $scope.Model).then(function (response) {
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

powerteam.controller('edit', ['$scope', '$http', '$uibModalInstance', 'ngNotify', 'id', 'parent', '$filter', function ($scope, $http, $uibModalInstance, ngNotify, id, parent, $filter) {
    var where = $filter('where');
    var removeWith = $filter('removeWith');

    $scope.allOrgUnitList = [];

    $scope.Model = null;

    $scope.init = function () {
        $scope.findAllOrgUnit();
    };

    $scope.findAllOrgUnit = function () {
        $scope.allOrgUnitList = [];
        $http.post('orgUnit/findAllOrgUnit').then(function (response) {
            $scope.allOrgUnitList = $scope.allOrgUnitList.concat({orgUnitId: null, orgUnitName: "空", pid: null}, response.data);
            $scope.Model = where($scope.allOrgUnitList, {orgUnitId: id})[0];
            if (parent) {
                $scope.Model.selectedOrgUnit = where($scope.allOrgUnitList, {orgUnitId: parent.orgUnitId})[0];
            } else {
                $scope.Model.selectedOrgUnit = {orgUnitId: null, orgUnitName: "空", pid: null};
            }
            $scope.allOrgUnitList = removeWith($scope.allOrgUnitList, {orgUnitId: id});
        });
    };

    $scope.ok = function () {
        $http.post('orgUnit/update', $scope.Model).then(function (response) {
            if (response.data.success) {
                ngNotify.set('保存成功', 'success');
                $uibModalInstance.close();
            } else {
                ngNotify.set(response.data.message, 'error');
            }
        });
    };

    $scope.remove = function () {
        $http.post('orgUnit/remove', $scope.Model).then(function (response) {
            if (response.data.success) {
                ngNotify.set('删除成功', 'success');
                $uibModalInstance.close();
            } else {
                ngNotify.set(response.data.message, 'error');
            }
        });
    };

    $scope.up = function () {
        $http.post('orgUnit/up', $scope.Model).then(function (response) {
            if (response.data.success) {
                ngNotify.set('上调组织成功!', 'success');
                $uibModalInstance.close();
            } else {
                ngNotify.set('上调组织失败!', 'error');
            }
        });
    };

    $scope.down = function () {
        $http.post('orgUnit/down', $scope.Model).then(function (response) {
            if (response.data.success) {
                ngNotify.set('下调组织成功!', 'success');
                $uibModalInstance.close();
            } else {
                ngNotify.set('下调组织失败!', 'error');
            }
        });
    };

    $scope.cancel = function () {
        $uibModalInstance.dismiss('cancel');
    };
}]);

powerteam.controller('orgUser', ['$scope', '$http', 'ngNotify', '$uibModal', '$filter', function ($scope, $http, ngNotify, $uibModal, $filter) {
    var where = $filter('where');
    var first = $filter('first');

    $scope.allOrgUnitList = [];

    $scope.orgUnit = null;
    $scope.orgUnitHead = null;

    $scope.userInOrgUnitQuery = {orgUnitId: null, pageNum: 1, total: 0, pageSize: 10, order: 'isUnitHead desc,realName desc'};
    $scope.userNotInOrgUnitQuery = {word: null, orgUnitId: null, pageNum: 1, total: 0, pageSize: 10, order: 'realName desc'};
    $scope.userInOrgUnit = [];
    $scope.userNotInOrgUnit = [];

    $scope.init = function () {
        $scope.findAllOrgUnit();
    };

    $scope.findAllOrgUnit = function () {
        $scope.allOrgUnitList = [];
        $http.post('orgUnit/findAllOrgUnit').then(function (response) {
            $scope.allOrgUnitList = response.data;
            var rootUnit = first(where($scope.allOrgUnitList, {pid: null}));
            rootUnit.active = true;
            $scope.orgUnit = rootUnit;
            $scope.userInOrgUnitQuery.orgUnitId = $scope.orgUnit.orgUnitId;
            $scope.userNotInOrgUnitQuery.orgUnitId = $scope.orgUnit.orgUnitId;

            $scope.$watchGroup(['userInOrgUnitQuery.orgUnitId', 'userInOrgUnitQuery.pageNum'], function (newValue, oldValue) {
                $scope.findUserInOrgUnit();
            });
            $scope.$watchGroup(['userNotInOrgUnitQuery.word', 'userNotInOrgUnitQuery.orgUnitId', 'userNotInOrgUnitQuery.pageNum'], function (newValue, oldValue) {
                $scope.findUserNotInOrgUnit();
            });
        });
    };

    $scope.nodeClick = function ($node, $parentNode) {
        $scope.orgUnit = $node;
        $scope.userInOrgUnitQuery.orgUnitId = $scope.orgUnit.orgUnitId;
        $scope.userNotInOrgUnitQuery.orgUnitId = $scope.orgUnit.orgUnitId;
    };

    $scope.findUserInOrgUnit = function () {
        $http.post('orgUnit/orgUser/findUserInOrgUnit', $scope.userInOrgUnitQuery).then(function (response) {
            $scope.userInOrgUnit = response.data.list;
            $scope.userInOrgUnitQuery.pageNum = response.data.pageNum;
            $scope.userInOrgUnitQuery.total = response.data.total;
            $scope.userInOrgUnitQuery.pageSize = response.data.pageSize;

            $scope.orgUnitHead = first(where($scope.userInOrgUnit, {isUnitHead: true}));
            if ($scope.orgUnitHead == null) {
                $scope.orgUnitHead = {realName: '暂无主管', avatar: 'img/avatar/noFace.png'};
            }
        });
    };

    $scope.findUserNotInOrgUnit = function () {
        $scope.userNotInOrgUnit = [];
        $http.post('orgUnit/orgUser/findUserNotInOrgUnit', $scope.userNotInOrgUnitQuery).then(function (response) {
            $scope.userNotInOrgUnit = response.data.list;
            $scope.userNotInOrgUnitQuery.pageNum = response.data.pageNum;
            $scope.userNotInOrgUnitQuery.total = response.data.total;
            $scope.userNotInOrgUnitQuery.pageSize = response.data.pageSize;
        });
    };

    $scope.addOrgUser = function (userId) {
        $http.post('orgUnit/orgUser/add', {orgUnitId: $scope.orgUnit.orgUnitId, userId: userId}).then(function (response) {
            if (response.data.success) {
                ngNotify.set('操作成功!', 'success');
                $scope.findUserInOrgUnit();
                $scope.findUserNotInOrgUnit();
            } else {
                ngNotify.set('操作失败!', 'error');
            }
        });
    };

    $scope.removeOrgUser = function (userId) {
        $http.post('orgUnit/orgUser/remove', {orgUnitId: $scope.orgUnit.orgUnitId, userId: userId}).then(function (response) {
            if (response.data.success) {
                ngNotify.set('操作成功!', 'success');
                $scope.findUserInOrgUnit();
                $scope.findUserNotInOrgUnit();
            } else {
                ngNotify.set('操作失败!', 'error');
            }
        });
    };

    $scope.setUnitHead = function (userId) {
        $http.post('orgUnit/orgUser/setUnitHead', {orgUnitId: $scope.orgUnit.orgUnitId, userId: userId}).then(function (response) {
            if (response.data.success) {
                ngNotify.set('操作成功!', 'success');
                $scope.findUserInOrgUnit();
                $scope.findUserNotInOrgUnit();
            } else {
                ngNotify.set('操作失败!', 'error');
            }
        });
    };

    $scope.removeUnitHead = function (userId) {
        $http.post('orgUnit/orgUser/removeUnitHead', {orgUnitId: $scope.orgUnit.orgUnitId, userId: userId}).then(function (response) {
            if (response.data.success) {
                ngNotify.set('操作成功!', 'success');
                $scope.findUserInOrgUnit();
                $scope.findUserNotInOrgUnit();
            } else {
                ngNotify.set('操作失败!', 'error');
            }
        });
    };
}]);