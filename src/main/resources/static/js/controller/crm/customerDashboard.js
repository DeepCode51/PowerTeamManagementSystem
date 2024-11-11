powerteam.controller('customerDashboard', ['$scope', '$http', 'ngNotify', '$uibModal', function ($scope, $http, ngNotify, $uibModal) {

    $scope.Model = {customerId: null};

    $scope.Activity = {content: null, resourceType: 1, resourceId: null, activityType: null, selectedType: null};

    $scope.queryActivity = {resourceType: 1, resourceId: null, pageNum: 1, pageSize: 5, order: 'createDate desc', hasNextPage: null};

    $scope.queryContact = {customerId: null, disablePaging: true, order: 'createDate desc'};

    $scope.activityTypeList = [{id: 1, name: '电话'}, {id: 2, name: '面谈'}];

    $scope.activityList = [];
    $scope.contactList = [];

    $scope.map = null;

    $scope.init = function () {
        $scope.findById();
    };

    $scope.mapReady = function (map) {
        $scope.map = map;
        $scope.map.enableScrollWheelZoom();
        $scope.map.addEventListener("click", $scope.markLocation);
        while ($scope.Model.customerId == null) {
        }
        if ($scope.Model.lng != null && $scope.Model.lat != null) {
            var point = new BMap.Point($scope.Model.lng, $scope.Model.lat);
            $scope.map.centerAndZoom(point, 19);
            var marker = new BMap.Marker(point);
            $scope.map.addOverlay(marker);
        } else {
            var point = new BMap.Point(116.404036, 39.915114);
            $scope.map.centerAndZoom(point, 19);
        }
    };

    $scope.markLocation = function (e) {
        $scope.Model.lng = e.point.lng;
        $scope.Model.lat = e.point.lat;
        $http.post('customer/updateLocation', $scope.Model).then(function (response) {
            if (response.data.success) {
                ngNotify.set('更新地理位置成功', 'success');
                $scope.map.clearOverlays();
                var point = new BMap.Point($scope.Model.lng, $scope.Model.lat);
                $scope.map.centerAndZoom(point, 19);
                var marker = new BMap.Marker(point);
                $scope.map.addOverlay(marker);
            } else {
                ngNotify.set(response.data.message, 'error');
            }
        });
    };

    $scope.findById = function () {
        $http.post('customer/findById', {customerId: $scope.Model.customerId}).then(function (response) {
            $scope.Model = response.data;
            $scope.Activity.resourceId = $scope.Model.customerId;
            $scope.queryActivity.resourceId = $scope.Model.customerId;
            $scope.queryContact.customerId = $scope.Model.customerId;
            $scope.findActivity();
            $scope.findContacts();
        });
    };

    $scope.updateStar = function (model) {
        $http.post('customer/updateStar', model).then(function (response) {
            if (response.data.success) {
                ngNotify.set('更新等级成功', 'success');
            } else {
                ngNotify.set(response.data.message, 'error');
            }
        });
    };

    $scope.addActivity = function () {
        $http.post('activity/add', $scope.Activity).then(function (response) {
            if (response.data.success) {
                ngNotify.set('记录工作成功', 'success');
                $scope.Activity.content = null;
                $scope.Activity.activityType = null;
                $scope.Activity.selectedType = null;
                $scope.refreshActivity();
            } else {
                ngNotify.set(response.data.message, 'error');
            }
        });
    };

    $scope.refreshActivity = function () {
        $scope.queryActivity.pageNum = 1;
        $scope.hasNextPage = null;
        $scope.activityList = [];
        $scope.findActivity();
    };

    $scope.findActivity = function () {
        $http.post('activity/find', $scope.queryActivity).then(function (response) {
            $scope.activityList = $scope.activityList.concat(response.data.list);
            $scope.queryActivity.pageNum = response.data.pageNum;
            $scope.queryActivity.pageSize = response.data.pageSize;
            $scope.queryActivity.hasNextPage = response.data.hasNextPage;
        });
    };

    $scope.findContacts = function () {
        $http.post('contacts/find', $scope.queryContact).then(function (response) {
            $scope.contactList = response.data.list;
        });
    };

    $scope.moreData = function () {
        $scope.queryActivity.pageNum++;
        $scope.findActivity();
    };
}]);
