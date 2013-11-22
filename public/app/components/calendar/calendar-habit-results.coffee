'use strict'
app_name = "myApp"
app = angular.module "#{app_name}.calendarHabitResults", []

# TODO: I should give the habit as a parameter to the directive
app.directive 'calendarHabitResults', (CalendarDays, TheTime) ->
    restrict: 'E'
    # scope:
    #     hab: '=habit'
    templateUrl: 'app/components/calendar/calendar.html'
    replace: true
    link: (scope, element, attrs) ->
        # alert(scope.hab.name)
        scope.today = TheTime.today()
        scope.monthName = TheTime.monthName
        scope.year = TheTime.year
        calDays = new CalendarDays(TheTime.month, scope.year)
        scope.nbWeeks = calDays.nbWeeks
        scope.daysInWeek = calDays.weeks
        scope.dayNumInWeek = _.map(scope.daysInWeek, (week) ->
            _.map(week, (day) ->
                day.date()  # day number in the month (1-31)
            )
        )
        # alert(JSON.stringify(scope.dayNumInWeek))
        

