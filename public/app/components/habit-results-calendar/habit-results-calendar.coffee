'use strict'
app_name = "myApp"
app = angular.module "#{app_name}.habitResultsCalendar", []

app.directive 'habitResultsCalendar', (CalendarDays, TheTime) ->
    restrict: 'E'
    templateUrl: 'app/components/habit-results-calendar/habitResultsCalendar.html'
    replace: true
    # scope: true
    # compile: -> alert('COMPILED!')
    link: (scope, element, attrs) ->
        scope.monthName = TheTime.monthName
        scope.year = TheTime.year
        calDays = new CalendarDays(TheTime.month, scope.year)
        scope.nbWeeks = calDays.nbWeeks
        scope.daysInWeek = calDays.weeks
        # alert(JSON.stringify(daysInWeek))
        scope.dayNumsInWeek = _.map(scope.daysInWeek, (week) ->  
            _.map(week, (day) ->
                day.date()  # day number in the month (1-31)
            )
        )

