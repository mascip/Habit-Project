'use strict'
app_name = "myApp"
app = angular.module "#{app_name}.habitResultsCalendar", []

app.directive 'habitResultsCalendar', () ->
    restrict: 'E'
    templateUrl: 'app/components/habit-results-calendar/habitResultsCalendar.html'
    replace: true
    # scope: true
    # compile: -> alert('COMPILED!')
    # link: (scope, element, attrs) -> alert('LINKED!')
