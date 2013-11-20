'use strict'
app_name = "myApp"
app = angular.module "#{app_name}.CalendarDays", []

# Returns 6 weeks, encompassing all days of the given month (January is number 1)
app.factory 'CalendarDays', (TheTime) ->
    class CalendarDays
        constructor: (month, year) ->
            @nbWeeks = 6    # We always display 6 weeks
            
            # List of days number in each week
            dayOneOfTheMonth = moment("#{month}-01-#{year}")
            firstDayOfCal = moment(dayOneOfTheMonth).weekday(0)
                # The first day is at the beginning of the week
                # isoWeekDay: 0 is Sunday, 1 is Monday
            # alert(now + ' - ' + month + ' - ' + year + ' - ' + TheTime.sayDay(dayOneOfTheMonth) + ' - ' + TheTime.sayDay(firstDayOfCal) + ' - ' + TheTime.sayDay(moment(firstDayOfCal).add(0, 'days')) + ' - ' +  TheTime.sayDay(moment(firstDayOfCal).add(1, 'days')))

            @weeks = _.map([1..@nbWeeks], (weekNum) ->
                _.map([7*(weekNum-1)..7*weekNum-1], (num) -> 
                    moment(firstDayOfCal).add(num, 'days')
                )
            )
                # For each day of each week, add the right number of days to the firstDay of the calendar
        
            # alert('IN: ' + JSON.stringify(@weeks[0][0]) + ' - ' + TheTime.sayDay(@weeks[0][0]) + ' - ' + JSON.stringify(@weeks[0][1]) + ' - ' + TheTime.sayDay(@weeks[0][1]) + ' - ' + @weeks[0][1].date())


            # alert(JSON.stringify(@days))
