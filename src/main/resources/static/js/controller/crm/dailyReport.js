powerteam.controller('dailyReport', ['$scope', '$http', 'ngNotify', function ($scope, $http, ngNotify) {

    $scope.datepickerOptions = {maxDate: new Date()};

    $scope.query = {workDay: new Date(), activityType: [1, 2, 99], disablePaging: true, order: 'createDate desc'};

    $scope.Activity = {content: null, activityType: 99, createDate: null};

    $scope.activityList = [];

    $scope.init = function () {
        $scope.$watchGroup(['query.workDay'], function (newValue, oldValue) {
            $scope.Activity.createDate = $scope.query.workDay;
            $scope.find();
        });
    };

    $scope.add = function () {
        $http.post('activity/add', $scope.Activity).then(function (response) {
            if (response.data.success) {
                ngNotify.set('记录工作成功', 'success');
                $scope.Activity.content = null;
                $scope.find();
            } else {
                ngNotify.set(response.data.message, 'error');
            }
        });
    };

    $scope.find = function () {
        $http.post('activity/findMyDailyReport', $scope.query).then(function (response) {
            $scope.activityList = response.data.list;
        });
    };

    $scope.delete = function (id) {
        $http.post('activity/delete', {activityId: id}).then(function (response) {
            if (response.data.success) {
                ngNotify.set('删除成功', 'success');
                $scope.find();
            } else {
                ngNotify.set(response.data.message, 'error');
            }
        });
    };
}]);

powerteam.controller('teamDailyReport', ['$scope', '$http', 'ngNotify', function ($scope, $http, ngNotify) {

    $scope.datepickerOptions = {maxDate: new Date()};

    $scope.query = {workDay: new Date(), activityType: [1, 2, 99], disablePaging: true, order: 'createDate desc'};

    $scope.activityList = [];

    $scope.init = function () {
        $scope.$watchGroup(['query.workDay'], function (newValue, oldValue) {
            $scope.find();
        });
    };

    $scope.find = function () {
        $http.post('activity/findTeamDailyReport', $scope.query).then(function (response) {
            $scope.activityList = response.data.list;
        });
    };

}]);