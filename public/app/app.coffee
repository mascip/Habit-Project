'use strict'

### Declare app level module which depends on filters, and services ###

app_name = "myApp"
app = angular.module app_name, ["#{app_name}.filters", "#{app_name}.services", "#{app_name}.directives", "#{app_name}.ctrl-habit-board",  "#{app_name}.ctrl-tabs", "#{app_name}.ctrl-my-lab", "angular-underscore", "ui.router", "#{app_name}.habitResultsCalendar", "#{app_name}.CalendarDays", "#{app_name}.TheTime", "#{app_name}.CheckButton"]

app.config ($stateProvider, $urlRouterProvider) ->

    
    navTabs=
        templateUrl: 'app/tabs/tabs.html'
        controller: 'CtrlTabs'
         
    $stateProvider
        .state( 'myLab', 
            url: '/'
            views:
                "":
                    templateUrl: 'app/my-lab//myLab.html'
                    controller: 'CtrlMyLab'
                "nav-tabs": navTabs
        )
        .state( 'habitBoard', 
            url: '/habit/:name'
            views:
                "":
                    templateUrl: 'app/habit-board/habitBoard.html'
                    controller: 'CtrlHabitBoard'
                "nav-tabs": navTabs
        )


#angular.bootstrap document, [app_name]
