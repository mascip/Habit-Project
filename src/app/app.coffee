'use strict'

### Declare app level module which depends on filters, and services ###

app_name = "myApp"
app = angular.module app_name, ["#{app_name}.filters", "#{app_name}.services", "#{app_name}.directives", "#{app_name}.ctrl-habit-board",  "#{app_name}.ctrl-tabs", "#{app_name}.ctrl-my-lab", "angular-underscore", "ui.router" ,"#{app_name}.habitResultsCalendar"]

app.config ($stateProvider, $urlRouterProvider) ->

    # $urlRouterProvider.otherwise('/')

    myLab =
        templateUrl: 'partials/myLab.html'
        controller: 'CtrlMyLab'

    habitBoard =
        templateUrl: 'partials/habitBoard.html'
        controller: 'CtrlHabitBoard'

    $stateProvider
        .state( 'myLab', 
            url: '/'
            templateUrl: 'partials/myLab.html'
            controller: 'CtrlMyLab'
        )
        .state( 'habit', 
            url: '/habit/:name'
            templateUrl: 'partials/habitBoard.html'
            controller: 'CtrlHabitBoard'
        )


#angular.bootstrap document, [app_name]
