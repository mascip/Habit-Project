'use strict'
app_name = "myApp"
app = angular.module "#{app_name}.srvc-habit-templates", []

app.factory 'HabitTemplates', (HabitTemplate) ->

        allHabits = _.map([
                ['Meditation','<p>Mindfulness is your best ally for taking on new habits. Here is an explanation of <a href="http://zenhabits.net/fundameditate/">how meditation can help</a>.</p><p>And for the <a href="http://seachange.zenhabits.net"/>Sea Change program</a> members, here is a <a href="http://seachange.zenhabits.net/meditation-module-overview"/>plan</a> to get into the meditation habit.</p>'],
                ['Exercise', 'A description of the habit, written by Leo'],
                ['Procrastination', 'Procrastination is...'],
                ['Get Organized', "Some text here, about getting organized"],
                ['Stay Organized',  "Description of the habit"],
                ['Organize Emails', "Oh, emails, they're tricky!"],
                ],
            (array) -> new HabitTemplate(array[0], array[1])
            )

        return allHabits

app.factory 'HabitTemplate', () ->
    class HabitTemplate
        constructor: (@name, @desc='') ->
            @getName = -> @name
            @getDesc = -> @desc

