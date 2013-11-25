'use strict'
app_name = "myApp"
app = angular.module "#{app_name}.ctrl-admin-habits", []

app.controller 'CtrlAdminHabitsList',
class AdminHabitsList
    constructor: ($scope, HabitTemplates, Habit) ->

        # Load the templates
        $scope.habitTemplates = HabitTemplates

        nowAddingHabit = false;

        ## Add a habit
        $scope.addOneHabitTemplate = (habitName) -> 

            # Add the habit template
            $scope.habitTemplates.push(new Habit habitName)
            console.log("Habit template #{habitName} added")

            # Reinitialize the form to add a habit
            $scope.nowAddingHabit = false

        ## Remove a habit
        $scope.removeHabit = (idx) -> $scope.habitTemplates.splice(idx, 1)

