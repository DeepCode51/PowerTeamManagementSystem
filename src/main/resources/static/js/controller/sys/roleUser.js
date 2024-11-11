powerteam.controller('roleUser', ['$scope', '$http', 'ngNotify', function ($scope, $http, ngNotify) {
    $scope.roleId = null;
    $scope.list = [];

    $scope.userInRole = [];
    $scope.userInRoleSearch = {word: null, roleId: null, pageNum: 1, total: 0, pageSize: 10};

    $scope.userNotInRole = [];
    $scope.userNotInRoleSearch = {word: null, roleId: null, pageNum: 1, total: 0, pageSize: 10};

    $scope.init = function () {
        $scope.userInRoleSearch.roleId = $scope.roleId;
        $scope.userNotInRoleSearch.roleId = $scope.roleId;
        $scope.find();

        $scope.$watchGroup(['userInRoleSearch.word','userInRoleSearch.roleId','userInRoleSearch.pageNum'], function (newValue, oldValue) {
            $scope.findUserInRole();
        });

        $scope.$watchGroup(['userNotInRoleSearch.word','userNotInRoleSearch.roleId','userNotInRoleSearch.pageNum'], function (newValue, oldValue) {
            $scope.findUserNotInRole();
        });
    };

    $scope.find = function () {
        $http.post('role/findAll').then(function (response) {
            $scope.list = response.data;
        });
    };

    $scope.findUserInRole = function () {
        $http.post('role/user/findUserInRole', $scope.userInRoleSearch).then(function (response) {
            $scope.userInRole = response.data.list;
            $scope.userInRoleSearch.pageNum = response.data.pageNum;
            $scope.userInRoleSearch.total = response.data.total;
            $scope.userInRoleSearch.pageSize = response.data.pageSize;
        });
    };

    $scope.removeRoleUser = function (userId) {
        $http.post('role/user/remove', {roleId: $scope.roleId, userId: userId}).then(function (response) {
            if (response.data.success) {
                ngNotify.set('移除成功', 'success');
                $scope.findUserInRole();
                $scope.findUserNotInRole();
            } else {
                ngNotify.set(response.data.message, 'error');
            }
        });
    };

    $scope.findUserNotInRole = function () {
        $http.post('role/user/findUserNotInRole', $scope.userNotInRoleSearch).then(function (response) {
            $scope.userNotInRole = response.data.list;
            $scope.userNotInRoleSearch.pageNum = response.data.pageNum;
            $scope.userNotInRoleSearch.total = response.data.total;
            $scope.userNotInRoleSearch.pageSize = response.data.pageSize;
        });
    };

    $scope.addRoleUser = function (userId) {
        $http.post('role/user/add', {roleId: $scope.roleId, userId: userId}).then(function (response) {
            if (response.data.success) {
                ngNotify.set('分配成功', 'success');
                $scope.findUserInRole();
                $scope.findUserNotInRole();
            } else {
                ngNotify.set(response.data.message, 'error');
            }
        });
    };
}]);