'use strict'

### Declare app level module which depends on filters, and services ###

app_name = "myApp"
app = angular.module app_name, ["#{app_name}.filters", "#{app_name}.services", "#{app_name}.directives", "#{app_name}.controllers"]

app.config ['$routeProvider', ($routeProvider) ->

  $routeProvider.when '/view1',
    templateUrl: 'partials/partial1.html'
    controller: 'myCtrl1'



  $routeProvider.otherwise
    redirectTo: '/'
    templateUrl: 'partials/UserBoard.html'
    controller: 'CtrlUserBoard'
]

#angular.bootstrap document, [app_name]
