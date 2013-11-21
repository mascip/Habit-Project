'use strict'
app_name = "myApp"
app = angular.module "#{app_name}.TheTime", []

app.service 'TheTime', ->
    @now = -> moment()
    @today = () -> @now().startOf('day')
    @month = @today().month() + 1
    @monthName = @today().format('MMMM')
    @year = @today().year()

    # For Debug purposes
    @sayDay = (day) -> day.format("dddd, MMMM Do YYYY, h:mm:ss a")
    @wasAgo = (day) ->
        @today().diff(day, 'days')

    @isToday = (day) -> day.isSame(@today())
