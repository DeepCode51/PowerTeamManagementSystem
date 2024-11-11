powerteam.controller('opportunityDashboard', ['$scope', '$http', 'ngNotify', '$uibModal', function ($scope, $http, ngNotify, $uibModal) {

    $scope.query = {disablePaging: true, order: 'createDate desc', phaseList: [1, 2, 3, 4]};

    $scope.list = [];

    $scope.phaseList = [{id: 1, name: '初步接触中'}, {id: 2, name: '需求分析中'}, {id: 3, name: '协商方案中'}, {id: 4, name: '商业谈判中'}];

    $scope.find = function () {
        $http.post('opportunity/find', $scope.query).then(function (response) {
            $scope.list = response.data.list;
        });
    };

    $scope.showAdd = function () {
        $uibModal.open({templateUrl: 'Add.html', controller: 'add'}).result.then(function () {
            $scope.find();
        });
    };

}]);

powerteam.controller('add', ['$scope', '$http', '$uibModalInstance', 'ngNotify', '$rootScope', function ($scope, $http, $uibModalInstance, ngNotify) {
    $scope.Model = {name: null, customerId: null, amount: null, endDate: null, description: null};

    $scope.customerList = [];

    $scope.findCustomer = function (word) {
        if (word != null && word.length > 0) {
            $http.post('customer/find', {word: word, disablePaging: true, order: 'createDate desc'}).then(function (response) {
                $scope.customerList = response.data.list;
                $scope.customerList.splice(0, 0, {customerId: null, customerName: '请输入客户名称'});
            });
        }
    };

    $scope.ok = function () {
        $http.post('opportunity/add', $scope.Model).then(function (response) {
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