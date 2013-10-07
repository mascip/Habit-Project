'use strict'

### Controllers ###

app_name = "myApp"
app = angular.module "#{app_name}.controllers", []

app.controller 'myCtrl1', ['$scope', ($scope) ->
    $scope.name = "view 1"
    $scope.say = -> window.alert.apply window, arguments
    $scope.test = 4;
  ]

app.controller 'myCtrl2', ['$scope', ($scope) -> 
        $scope.test = 2;
    ]

app.controller 'myCtrl3', ['$scope', ($scope) ->
    $scope.name = "view 3"
    $scope.say = -> window.alert.apply window, arguments
    $scope.test = 4;
  ]

