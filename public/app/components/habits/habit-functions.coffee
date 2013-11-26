'use strict'
app_name = "myApp"
app = angular.module "#{app_name}.HabitF", []

app.service 'HabitF', () ->

        ## Find a habit in a habitService (could be a list of habit templates, or active habits)
        # The habitService must return a list of Habits, each with a name property
        @findIn = (habitService, name) -> _.find(habitService, (habit) -> habit.name == name)

