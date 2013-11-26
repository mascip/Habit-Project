'use strict'

### Declare app level module which depends on filters, and services ###

app_name = "myApp"
app = angular.module app_name, 
    ["#{app_name}.filters", "#{app_name}.habits", "#{app_name}.srvc-habit-templates", "#{app_name}.directives", "#{app_name}.ctrl-habit-board",  "#{app_name}.ctrl-tabs", "#{app_name}.ctrl-my-lab", "#{app_name}.calendarHabitResults", "#{app_name}.CalendarDays", "#{app_name}.TheTime", "#{app_name}.CheckButton", "#{app_name}.ctrl-admin-habits", "#{app_name}.CtrlAdminHabitsEdit",
    "angular-underscore", "ui.router"]

app.config ($stateProvider, $urlRouterProvider) ->
    
    # Navigation tabs, present in all pages, as an independent ui-view
    navTabs=
        templateUrl: 'app/tabs/tabs.html'
        controller: 'CtrlTabs'

    # Default route if no route matched
    $urlRouterProvider.otherwise("/")

    # All my routes
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
        .state( 'admin',
            url: '/admin'
            views:
                "nav-tabs": navTabs
                "":
                    templateUrl: ''
                    controller: ''
        )
        .state( 'admin/habits',
            url: '/admin/habits'
            views:
                "nav-tabs": navTabs
                "":
                    templateUrl: 'app/admin/habitsList.html'
                    controller: 'CtrlAdminHabitsList'
        )
        .state( 'admin/habits/edit',
            url: '/admin/habits/:name/edit'
            views:
                "nav-tabs": navTabs
                "":
                    templateUrl: 'app/admin/habits/edit.html'
                    controller: 'CtrlAdminHabitsEdit'
        )




#angular.bootstrap document, [app_name]
