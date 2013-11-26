'use strict'
app_name = "myApp"
app = angular.module "#{app_name}.ctrl-habit-board", ['ui.bootstrap']

app.controller 'CtrlHabitBoard',
class CtrlHabitBoard
    constructor: ($scope, $stateParams, MyHabits, HabitF) ->
        # Which day is displayed to the user (nb of days ago. 0 is today)
        $scope.daysAgo = 0 # Default: today

        # Today
        # TODO: refactor this with the TheTime service (see my-lab.coffee)
        now = moment()
        today = now.startOf('day')
        $scope.displayedToday = today.valueOf()
        $scope.$watch( 'today', ->
            $scope.displayedToday = today.valueOf()
        )

        # Selected Day
        $scope.selectedDay = moment(today)
        $scope.thisIsToday = $scope.selectedDay.isSame(today)
        $scope.displayedDay = $scope.selectedDay.valueOf()
            # The date to display, and current week, updating when selectedDay changes
            # AngularJS wants milliseconds, valueOf() gives milliseconds
        $scope.$watch( 'daysAgo', -> 
            $scope.selectedDay = moment(today).add('days',$scope.daysAgo)
            $scope.displayedDay = $scope.selectedDay.valueOf()
            $scope.thisIsToday = $scope.selectedDay.isSame(today)
        )

        # Obtain the pre-prepared list of Habits and results
        $scope.habit = HabitF.findIn(MyHabits, $stateParams.name)
        $scope.habitName = $scope.habit.name
        $scope.myHabits = MyHabits

        # Delete the habit
        $scope.stopHabit = -> 
            # alert("Not implemented yet")
            MyHabits.stopHabit($scope.habit)

        # TODO: delete duplication
        # Start date input field
        $scope.dateChangeIsSelected=0

        ## Functions called from within the page
        $scope.wasActive = (habit)->
            return habit.wasActive($scope.daysAgo)

        # TODO: REMOVE DUPLICATION => DIRECTIVE !
        $scope.clickPrevWeek = ->
            $scope.daysAgo += 7
        
        $scope.clickNextWeek = ->
            # TODO: move to latest day, if it's less than 7 days ahead?
            $scope.daysAgo -= 7
