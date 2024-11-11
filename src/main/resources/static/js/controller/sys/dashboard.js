powerteam.controller('dashboard', ['$scope', '$http', '$filter', function ($scope, $http, $filter) {

    $scope.init = function () {
        $scope.findMonthlyFunnel();
        $scope.findMonthlyConversion();
        $scope.findRecentlyClosing();
    };

    $scope.monthlyFunnel = [];
    $scope.monthlyConversion = [];
    $scope.recentlyClosing = [];

    $scope.phaseList = [{id: 1, name: '初步接触'}, {id: 2, name: '需求分析'}, {id: 3, name: '协商方案'}, {id: 4, name: '商业谈判'}, {id: 5, name: '关闭'}];
    $scope.statusList = [{id: 1, name: '赢单'}, {id: 2, name: '输单'}, {id: 3, name: '进行中'}];


    var where = $filter('where');
    var sum = $filter('sum');
    var map = $filter('map');
    var flatten = $filter('flatten');

    $scope.findMonthlyFunnel = function () {
        $http.post('opportunity/findMonthlyFunnel', {}).then(function (response) {
            $scope.monthlyFunnel = response.data;
            var data = [];
            for (var i = 0; i < $scope.monthlyFunnel.length; i++) {
                var item = $scope.monthlyFunnel[i];
                data.push({name: (where($scope.phaseList, {id: item.phase}))[0].name, value: item.total});
            }
            var option = {
                tooltip: {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c}个"
                },
                toolbox: {
                    feature: {
                        restore: {},
                        saveAsImage: {}
                    }
                },
                legend: {
                    data: ['初步接触', '需求分析', '协商方案', '商业谈判', '关闭']
                },
                series: [
                    {
                        name: '本月累计',
                        type: 'funnel',
                        min: 0,
                        max: sum(flatten(map($scope.monthlyFunnel, 'total'))),
                        minSize: '1%',
                        maxSize: '100%',
                        sort: 'descending',
                        gap: 2,
                        label: {
                            normal: {
                                position: 'right'
                            },
                            emphasis: {
                                textStyle: {
                                    fontSize: 20
                                }
                            }
                        },
                        labelLine: {
                            normal: {
                                length: 10,
                                lineStyle: {
                                    width: 1,
                                    type: 'solid'
                                }
                            }
                        },
                        itemStyle: {
                            normal: {
                                borderColor: '#fff',
                                borderWidth: 1
                            }
                        },
                        data: data
                    }
                ]
            };
            var myChart = echarts.init(document.getElementById('monthlyFunnel'));
            myChart.setOption(option);
            $(window, ".wrapper").resize(function () {
                myChart.resize();
            });
        });
    };

    $scope.findMonthlyConversion = function () {
        $http.post('opportunity/findMonthlyConversion', {}).then(function (response) {
            $scope.monthlyConversion = response.data;
            var data = [];
            for (var i = 0; i < $scope.monthlyConversion.length; i++) {
                var item = $scope.monthlyConversion[i];
                data.push({name: (where($scope.statusList, {id: item.status}))[0].name, value: item.total});
            }
            var option = {
                tooltip: {
                    trigger: 'item',
                    formatter: "{a} <br/>{b}: {c} ({d}%)"
                },
                toolbox: {
                    feature: {
                        restore: {},
                        saveAsImage: {}
                    }
                },
                legend: {
                    orient: 'vertical',
                    x: 'left',
                    data: ['赢单', '输单', '进行中']
                },
                series: [
                    {
                        name: '转化比率',
                        type: 'pie',
                        radius: ['50%', '70%'],
                        avoidLabelOverlap: false,
                        label: {
                            normal: {
                                show: false,
                                position: 'center'
                            },
                            emphasis: {
                                show: true,
                                textStyle: {
                                    fontSize: '30',
                                    fontWeight: 'bold'
                                }
                            }
                        },
                        labelLine: {
                            normal: {
                                show: false
                            }
                        },
                        data: data
                    }
                ]
            };
            var myChart = echarts.init(document.getElementById('monthlyConversion'));
            myChart.setOption(option);
            $(window, ".wrapper").resize(function () {
                myChart.resize();
            });
        });

    };

    $scope.findRecentlyClosing = function () {
        $http.post('opportunity/findRecentlyClosing', {}).then(function (response) {
            $scope.recentlyClosing = response.data;
        });
    };
}]);