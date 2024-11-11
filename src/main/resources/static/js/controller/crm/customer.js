powerteam.controller('customerList', ['$scope', '$http', 'ngNotify', '$uibModal', function ($scope, $http, ngNotify, $uibModal) {
    $scope.query = {word: null, pageNum: 1, total: 0, pageSize: 10, order: 'createDate desc'};
    $scope.list = [];

    $scope.init = function () {
        $scope.$watchGroup(['query.word', 'query.pageNum'], function (newValue, oldValue) {
            $scope.find();
        });
    };

    $scope.find = function () {
        $http.post('customer/find', $scope.query).then(function (response) {
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

    $scope.updateStar = function (model) {
        $http.post('customer/updateStar', model).then(function (response) {
            if (response.data.success) {
                ngNotify.set('更新等级成功', 'success');
                $scope.find();
            } else {
                ngNotify.set(response.data.message, 'error');
            }
        });
    };
}]);

powerteam.controller('add', ['$scope', '$http', '$uibModalInstance', 'ngNotify', function ($scope, $http, $uibModalInstance, ngNotify) {
    $scope.Model = {customerName: null, tel: null, address: null, website: null, industryId: null, categoryId: null, sourceId: null, provinceId: null, cityId: null, potential: false};

    $scope.industryList = [];
    $scope.customerCategoryList = [];
    $scope.sourceList = [];
    $scope.provinceList = [];
    $scope.cityList = [];

    $scope.init = function () {
        $scope.findAllIndustry();
        $scope.findAllCustomerCategory();
        $scope.findAllSource();
        $scope.findAllProvince();
    };

    $scope.findAllIndustry = function () {
        $http.post('customer/findAllIndustry').then(function (response) {
            $scope.industryList = response.data;
        });
    };

    $scope.findAllCustomerCategory = function () {
        $http.post('customer/findAllCustomerCategory').then(function (response) {
            $scope.customerCategoryList = response.data;
        });
    };

    $scope.findAllSource = function () {
        $http.post('customer/findAllSource').then(function (response) {
            $scope.sourceList = response.data;
        });
    };

    $scope.findAllProvince = function () {
        $scope.provinceList = [];
        $http.post('district/findAllProvince').then(function (response) {
            $scope.provinceList = response.data;
        });
    };

    $scope.findCity = function () {
        $scope.cityList = [];
        $http.post('district/findCity', $scope.Model.selectedProvince.id).then(function (response) {
            $scope.cityList = response.data;
        });
    };

    $scope.provinceChange = function () {
        $scope.Model.cityId = null;
        $scope.Model.selectedCity = null;
        $scope.findCity();
    };

    $scope.ok = function () {
        $http.post('customer/add', $scope.Model).then(function (response) {
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
        $scope.findAllIndustry();
        $scope.findAllCustomerCategory();
        $scope.findAllSource();
        $scope.findAllProvince();
    };

    $scope.findById = function () {
        $http.post('customer/findById', {customerId: id}).then(function (response) {
            $scope.Model = response.data;
            $scope.Model.selectedIndustry = $scope.Model.industry;
            $scope.Model.selectedCategory = $scope.Model.customerCategory;
            $scope.Model.selectedSource = $scope.Model.source;
            $scope.Model.selectedProvince = $scope.Model.province;
            $scope.Model.selectedCity = $scope.Model.city;
            if ($scope.Model.selectedCity != null) {
                $scope.findCity();
            }
        });
    };

    $scope.findAllIndustry = function () {
        $http.post('customer/findAllIndustry').then(function (response) {
            $scope.industryList = response.data;
        });
    };

    $scope.findAllCustomerCategory = function () {
        $http.post('customer/findAllCustomerCategory').then(function (response) {
            $scope.customerCategoryList = response.data;
        });
    };

    $scope.findAllSource = function () {
        $http.post('customer/findAllSource').then(function (response) {
            $scope.sourceList = response.data;
        });
    };

    $scope.findAllProvince = function () {
        $scope.provinceList = [];
        $http.post('district/findAllProvince').then(function (response) {
            $scope.provinceList = response.data;
        });
    };

    $scope.findCity = function () {
        $scope.cityList = [];
        $http.post('district/findCity', $scope.Model.selectedProvince.id).then(function (response) {
            $scope.cityList = response.data;
        });
    };

    $scope.provinceChange = function () {
        $scope.Model.cityId = null;
        $scope.Model.selectedCity = null;
        $scope.findCity();
    };

    $scope.ok = function () {
        $http.post('customer/update', $scope.Model).then(function (response) {
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