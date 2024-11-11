powerteam.controller('roleFun', ['$scope', '$http', 'ngNotify', '$q', '$filter', function ($scope, $http, ngNotify, $q, $filter) {
    $scope.roleId = null;
    $scope.allRoleList = [];
    $scope.allFunList = [];
    $scope.funInRoleList = [];

    $scope.checkFlag = null;

    var where = $filter('where');
    var map = $filter('map');

    $scope.init = function () {
        var promise = [];
        promise.push($scope.findAllRole());
        promise.push($scope.findAllFun());
        $q.all(promise).then($scope.findFunInRole);
    };

    $scope.findAllRole = function () {
        var deferred = $q.defer();
        $http.post('role/findAll').then(function (response) {
            $scope.allRoleList = response.data;
            deferred.resolve();
        });
        return deferred.promise;
    };

    $scope.findAllFun = function () {
        var deferred = $q.defer();
        $http.post('fun/findAll').then(function (response) {
            $scope.allFunList = response.data;
            deferred.resolve();
        });
        return deferred.promise;
    };

    $scope.findFunInRole = function () {
        var deferred = $q.defer();
        $http.post('fun/findFunInRole', $scope.roleId).then(function (response) {
            $scope.funInRoleList = response.data;
            angular.forEach($scope.allFunList, function (value, key) {
                if (( where($scope.funInRoleList, {funId: value.funId})).length > 0) {
                    value.checked = true;
                }
            });
            deferred.resolve();
        });
        return deferred.promise;
    };

    $scope.checkAll = function () {
        if ($scope.checkFlag != null) {
            angular.forEach($scope.allFunList, function (value, key) {
                value.checked = $scope.checkFlag;
            });
        }
    };

    $scope.saveRoleFun = function () {
        var funIdList = map(where($scope.allFunList, {checked: true}), 'funId');
        $http.post('fun/saveRoleFun', {roleId: $scope.roleId, funIdList: funIdList}).then(function (response) {
            if (response.data.success) {
                ngNotify.set('分配成功', 'success');
            } else {
                ngNotify.set(response.data.message, 'error');
            }
        });
    };
}]);