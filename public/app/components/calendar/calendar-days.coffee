'use strict'
app_name = "myApp"
app = angular.module "#{app_name}.CalendarDays", []

# Returns 6 weeks, encompassing all days of the given month (January is number 1)
app.factory 'CalendarDays', (TheTime) ->
    class CalendarDays
        constructor: (month, year) ->
            @nbWeeks = 6
            # We always display 6 weeks, so that all days of the month are displayed 
            # (sometimes they are in 6 different weeks), and the size of the calendar 
            # always remains the same
            
            # List all the days
            dayOneOfTheMonth = moment("#{month}-01-#{year}")
            firstDayOfCal = moment(dayOneOfTheMonth).weekday(0)
                # The first day is at the beginning of the week, of the 1st of the month
                # isoWeekDay: 0 is Sunday, 1 is Monday
            @weeks = _.map([1..@nbWeeks], (weekNum) ->
                _.map([7*(weekNum-1)..7*weekNum-1], (num) -> 
                    moment(firstDayOfCal).add(num, 'days')
                )
            )
            
                # For each day of each week, add the right number of days to the firstDay of the calendar
