'use strict'
app_name = "myApp"
app = angular.module "#{app_name}.srvc-habit-templates", []

app.factory 'HabitTemplates', (Habit) ->

        allHabits = _.map(['Meditation', 'Exercise', 'Procrastination', 'Get Organized', 'Stay Organized', 'Organize Emails'],
            (name) -> new Habit(name))

        return allHabits
