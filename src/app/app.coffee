'use strict'

### Declare app level module which depends on filters, and services ###

app_name = "myApp"
app = angular.module app_name, ["#{app_name}.filters", "#{app_name}.services", "#{app_name}.directives", "#{app_name}.ctrl-habit-board",  "#{app_name}.ctrl-tabs", "#{app_name}.ctrl-my-lab", "angular-underscore", "ui.router", "#{app_name}.habitResultsCalendar", "#{app_name}.calendarDays"]

app.config ($stateProvider, $urlRouterProvider) ->

    # $urlRouterProvider.otherwise('/')
    
    navTabs=
        templateUrl: 'partials/tabs.html'
        controller: 'CtrlTabs'
         
    $stateProvider
        .state( 'myLab', 
            url: '/'
            views:
                "":
                    templateUrl: 'partials/myLab.html'
                    controller: 'CtrlMyLab'
                "nav-tabs": navTabs
        )
        .state( 'habitBoard', 
            url: '/habit/:name'
            views:
                "":
                    templateUrl: 'partials/habitBoard.html'
                    controller: 'CtrlHabitBoard'
                "nav-tabs": navTabs
        )


#angular.bootstrap document, [app_name]
