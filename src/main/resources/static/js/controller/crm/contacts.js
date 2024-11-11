powerteam.controller('contactsList', ['$scope', '$http', 'ngNotify', '$uibModal', function ($scope, $http, ngNotify, $uibModal) {
    $scope.query = {word: null, pageNum: 1, total: 0, pageSize: 10, order: 'createDate desc'};
    $scope.list = [];

    $scope.init = function () {
        $scope.$watchGroup(['query.word', 'query.pageNum'], function (newValue, oldValue) {
            $scope.find();
        });
    };

    $scope.find = function () {
        $http.post('contacts/find', $scope.query).then(function (response) {
            $scope.list = response.data.list;
            $scope.query.pageNum = response.data.pageNum;
            $scope.query.pageSize = response.data.pageSize;
            $scope.query.total = response.data.total;
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
}]);

powerteam.controller('add', ['$scope', '$http', '$uibModalInstance', 'ngNotify', function ($scope, $http, $uibModalInstance, ngNotify) {
    $scope.Model = {customerId: null, name: null, phone: null, title: null, sex: true, dept: null, email: null, tel: null, fax: null, qq: null, wx: null};

    $scope.customerList = [];

    $scope.init = function () {

    };

    $scope.findCustomer = function (word) {
        if (word != null && word.length > 0) {
            $http.post('customer/find', {word: word, disablePaging: true, order: 'createDate desc'}).then(function (response) {
                $scope.customerList = response.data.list;
                $scope.customerList.splice(0, 0, {customerId: null, customerName: '请输入客户名称'});
            });
        }
    };

    $scope.ok = function () {
        $http.post('contacts/add', $scope.Model).then(function (response) {
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

    $scope.customerList = [];

    $scope.init = function () {
        $scope.findById();
    };

    $scope.findById = function () {
        $http.post('contacts/findById', {contactsId: id}).then(function (response) {
            $scope.Model = response.data;
            if ($scope.Model.customer != null) {
                $scope.Model.selectedCustomer = $scope.Model.customer;
                $scope.customerList.splice(0, 0, {customerId: null, customerName: '请输入客户名称'});
                $scope.customerList.splice(1, 0, $scope.Model.customer);
            }
        });
    };

    $scope.findCustomer = function (word) {
        if (word != null && word.length > 0) {
            $http.post('customer/find', {word: word, disablePaging: true, order: 'createDate desc'}).then(function (response) {
                $scope.customerList = response.data.list;
                $scope.customerList.splice(0, 0, {customerId: null, customerName: '请输入客户名称'});
            });
        }
    };

    $scope.ok = function () {
        $http.post('contacts/update', $scope.Model).then(function (response) {
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