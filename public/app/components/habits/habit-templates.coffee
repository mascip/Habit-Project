'use strict'
app_name = "myApp"
app = angular.module "#{app_name}.srvc-habit-templates", []

app.factory 'HabitTemplates', (HabitTemplate) ->

        allHabits = _.map(['Meditation', 'Exercise', 'Procrastination', 'Get Organized', 'Stay Organized', 'Organize Emails'],
            (name) -> new HabitTemplate(name))

        return allHabits

app.factory 'HabitTemplate', () ->
    class HabitTemplate
        constructor: (@name, @desc='') ->
             

