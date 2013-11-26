'use strict'
app_name = "myApp"
app = angular.module "#{app_name}.CtrlAdminHabitsEdit", []

app.controller 'CtrlAdminHabitsEdit',
class CtrlAdminHabitsEdit
    constructor: ($scope, $stateParams, HabitTemplates, HabitF) ->
        $scope.test = 'a'
        
        # Find the Habit Template
        $scope.habit = HabitF.findIn(HabitTemplates, $stateParams.name)
        $scope.habitName = $scope.habit.name
