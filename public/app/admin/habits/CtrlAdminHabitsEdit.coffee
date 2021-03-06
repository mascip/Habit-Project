'use strict'
app_name = "myApp"
app = angular.module "#{app_name}.CtrlAdminHabitsEdit", []

app.controller 'CtrlAdminHabitsEdit',
class CtrlAdminHabitsEdit
    constructor: ($scope, $stateParams, HabitTemplates, HabitUtil) ->
        
        # Find the Habit Template
        $scope.habit = HabitUtil.findIn(HabitTemplates, $stateParams.name)
        $scope.habitName = $scope.habit.name

        # Text editor options
        $scope.tinymceOptions =
            menubar: false
            statusbar: false
            toolbar: "undo redo | styleselect | bold italic | spellchecker link image | save"
