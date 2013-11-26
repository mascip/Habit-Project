'use strict'
app_name = "myApp"
app = angular.module "#{app_name}.HabitF", []

app.factory 'HabitF', (Habit) ->
    class HabitF
        contructor:

            @findIn = (habitService, name) ->
                _.find(habitService, (habit) -> habit.name == name)

