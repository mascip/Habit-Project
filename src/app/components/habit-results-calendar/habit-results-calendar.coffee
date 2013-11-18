'use strict'
app_name = "myApp"
app = angular.module "#{app_name}.habitResultsCalendar", []

app.directive 'habitResultsCalendar', (CalendarDays) ->
    restrict: 'E'
    templateUrl: 'app/components/habit-results-calendar/habitResultsCalendar.html'
    replace: true
    # scope: true
    # compile: -> alert('COMPILED!')
    link: (scope, element, attrs) ->
        calDays = new CalendarDays(1) # 1 for January
        scope.nbWeeks = calDays.nbWeeks
        scope.daysInWeek = calDays.weeks

