'use strict'

### Declare app level module which depends on filters, and services ###

app_name = "myApp"
app = angular.module app_name, ["#{app_name}.filters", "#{app_name}.services", "#{app_name}.directives", "#{app_name}.controllers"]

app.config ['$routeProvider', ($routeProvider) ->

  $routeProvider.when '/view1',
    templateUrl: 'partials/partial1.html'
    controller: 'myCtrl1'

  $routeProvider.when '/view2',
    templateUrl: 'partials/partial2.html'
    controller: 'myCtrl2'

  $routeProvider.when '/view3',
    templateUrl: 'partials/partial3.html'
    controller: 'myCtrl3'


  $routeProvider.otherwise
    redirectTo: '/view1'
]

#angular.bootstrap document, [app_name]
