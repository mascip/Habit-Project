'use strict'

### Declare app level module which depends on filters, and services ###

app_name = "myApp"
app = angular.module app_name, ["#{app_name}.filters", "#{app_name}.services", "#{app_name}.directives", "#{app_name}.controllers", "angular-underscore", "ui.router"]

app.config ($stateProvider, $urlRouterProvider) ->

    $stateProvider
        .state( 'myLab', {
            url: '/',
            templateUrl: 'partials/myLab.html',
            controller: 'CtrlMyLab'
        })
        .state( 'habit', {
            url: '/habit/:name',
            templateUrl: 'partials/SingleHabitPage.html',
            controller: 'CtrlHabitPage'
        })


#angular.bootstrap document, [app_name]
