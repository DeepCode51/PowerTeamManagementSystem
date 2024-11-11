powerteam.controller('signIn', ['$scope', '$http', 'ngNotify', function ($scope, $http, ngNotify) {
    $scope.User = {userName: null, password: null};
    $scope.signIn = function () {
        $http.post('signIn', $scope.User).then(function (response) {
            if (response.data.success) {
                go('dashboard');
            } else {
                ngNotify.set(response.data.message, 'error');
            }
        });
    };
}]);