powerteam.controller('opportunityDetail', ['$scope', '$http', 'ngNotify', '$uibModal', '$filter', '$window', function ($scope, $http, ngNotify, $uibModal, $filter, $window) {

    var where = $filter('where');

    $scope.Model = {opportunityId: null};
    $scope.Activity = {content: null, resourceType: 2, resourceId: null, activityType: null, selectedType: null};

    $scope.queryActivity = {resourceType: 2, resourceId: null, pageNum: 1, pageSize: 5, order: 'createDate desc', hasNextPage: null};

    $scope.phaseList = [{id: 1, name: '初步接触'}, {id: 2, name: '需求分析'}, {id: 3, name: '协商方案'}, {id: 4, name: '商业谈判'}, {id: 5, name: '关闭'}];
    $scope.lossReasonList = [{id: 1, name: '输给竞争对手'}, {id: 2, name: '客户失去预算'}, {id: 3, name: '自身产品不足'}, {id: 4, name: '其他原因'}];
    $scope.contactsRoleList = [{id: 1, name: '联络人'}, {id: 2, name: '执行者'}, {id: 3, name: '影响者'}, {id: 4, name: '使用者'}, {id: 5, name: '决策者'}];
    $scope.activityTypeList = [{id: 1, name: '电话'}, {id: 2, name: '面谈'}];

    $scope.activityList = [];

    $scope.init = function () {
        $scope.findById();
    };

    $scope.findById = function () {
        $http.post('opportunity/findById', {opportunityId: $scope.Model.opportunityId}).then(function (response) {
            $scope.Model = response.data;
            $scope.Activity.resourceId = $scope.Model.opportunityId;
            $scope.queryActivity.resourceId = $scope.Model.opportunityId;

            $scope.refreshActivity();
            if ($scope.Model.win == false && $scope.Model.lossReason != null) {
                $scope.Model.selectedReason = where($scope.lossReasonList, {id: $scope.Model.lossReason})[0];
            } else {
                $scope.Model.selectedReason = $scope.lossReasonList[0];
            }
        });
    };

    $scope.changePhase = function (phase) {
        $scope.Model.phase = phase.id;
        if (phase.id == 5) {
            if ($scope.Model.win == null) {
                $scope.Model.win = true;
                $scope.Model.selectedReason = $scope.lossReasonList[0];
            }
        }
    };

    $scope.update = function () {
        $http.post('opportunity/update', $scope.Model).then(function (response) {
            if (response.data.success) {
                ngNotify.set('更新成功', 'success');
                $scope.findById();
            } else {
                ngNotify.set(response.data.message, 'error');
            }
        });
    };

    $scope.chooseContact = function () {
        $uibModal.open({templateUrl: 'ChooseContact.html', controller: 'chooseContact', size: 'lg', resolve: {opportunity: $scope.Model}}).result.then(function () {
            $scope.findById();
        });
    };

    $scope.changeContactRole = function (contactsRole, role) {
        contactsRole.role = role.id;
        $http.post('opportunity/updateContactsRole', contactsRole).then(function (response) {
            if (response.data.success) {
                ngNotify.set('设置角色成功', 'success');
                $scope.findById();
            } else {
                ngNotify.set(response.data.message, 'error');
            }
        });
    };

    $scope.removeContactRole = function (contactsRole) {
        $http.post('opportunity/removeContactsRole', contactsRole).then(function (response) {
            if (response.data.success) {
                ngNotify.set('移除联系人成功', 'success');
                $scope.findById();
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

    $scope.moreData = function () {
        $scope.queryActivity.pageNum++;
        $scope.findActivity();
    };

    $scope.remove = function () {
        $scope.$parent.confirm('系统提示', '确定删除吗?').then(function () {
            $http.post('opportunity/remove', $scope.Model).then(function (response) {
                if (response.data.success) {
                    ngNotify.set('删除成功', 'success');
                    go('opportunity');
                } else {
                    ngNotify.set('删除失败', 'error');
                }
            });
        });
    };
}]);

powerteam.controller('chooseContact', ['$scope', '$http', '$uibModalInstance', 'ngNotify', 'opportunity', '$filter', function ($scope, $http, $uibModalInstance, ngNotify, opportunity, $filter) {

    var map = $filter('map');
    var flatten = $filter('flatten');

    $scope.query = {word: null, excludeContactsId: null, pageNum: 1, total: 0, pageSize: 10, order: 'createDate desc'};

    $scope.contactList = [];

    $scope.init = function () {
        $scope.$watchGroup(['query.word', 'query.pageNum'], function (newValue, oldValue) {
            $scope.find();
        });
    };

    $scope.find = function () {
        $scope.query.excludeContactsId = flatten(map(opportunity.contactsRoleList, 'contactsId'));
        $http.post('contacts/find', $scope.query).then(function (response) {
            $scope.contactList = response.data.list;
            $scope.query.pageNum = response.data.pageNum;
            $scope.query.pageSize = response.data.pageSize;
            $scope.query.total = response.data.total;
        });
    };

    $scope.ok = function (contact) {
        $http.post('opportunity/addContactsRole', {opportunityId: opportunity.opportunityId, contactsId: contact.contactsId}).then(function (response) {
            if (response.data.success) {
                ngNotify.set('操作成功', 'success');
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