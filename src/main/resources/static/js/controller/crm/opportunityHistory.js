powerteam.controller('opportunityHistory', ['$scope', '$http', function ($scope, $http) {

    $scope.query = {word: null, phaseList: [5], order: 'closeDate desc', pageNum: 1, total: 0, pageSize: 10};

    $scope.list = [];

    $scope.init = function () {
        $scope.$watchGroup(['query.word', 'query.pageNum'], function (newValue, oldValue) {
            $scope.find();
        });
    };

    $scope.find = function () {
        $http.post('opportunity/find', $scope.query).then(function (response) {
            $scope.list = response.data.list;
            $scope.query.pageNum = response.data.pageNum;
            $scope.query.pageSize = response.data.pageSize;
            $scope.query.total = response.data.total;
        });
    };
}]);