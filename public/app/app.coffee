'use strict'

### Declare app level module which depends on filters, and services ###

app_name = "myApp"
app = angular.module app_name, 
    ["#{app_name}.filters", "#{app_name}.services", "#{app_name}.directives", "#{app_name}.ctrl-habit-board",  "#{app_name}.ctrl-tabs", "#{app_name}.ctrl-my-lab", "#{app_name}.calendarHabitResults", "#{app_name}.CalendarDays", "#{app_name}.TheTime", "#{app_name}.CheckButton",
    "angular-underscore", "ui.router"]

app.config ($stateProvider, $urlRouterProvider) ->
    
    # Navigation tabs, present in all pages, as an independent ui-view
    navTabs=
        templateUrl: 'app/tabs/tabs.html'
        controller: 'CtrlTabs'
         
    $stateProvider
        .state( 'myLab',
            url: '/'
            views:
                "nav-tabs": navTabs
                "":
                    templateUrl: 'app/my-lab//myLab.html'
                    controller: 'CtrlMyLab'
        )
        .state( 'habitBoard',
            url: '/habit/:name'
            views:
                "nav-tabs": navTabs
                "":
                    templateUrl: 'app/habit-board/habitBoard.html'
                    controller: 'CtrlHabitBoard'
        )


#angular.bootstrap document, [app_name]
