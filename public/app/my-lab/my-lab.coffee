'use strict'
app_name = "myApp"
app = angular.module "#{app_name}.ctrl-my-lab", ['ui.bootstrap', 'ui.router']

app.controller 'CtrlMyLab',
class CtrlMyLab
    constructor: ($scope, $state, ActiveHabit, MyHabits, HabitTemplates, TheTime) ->

        ## DATA

        # Which day is displayed to the user (nb of days ago. 0 is today)
        $scope.daysAgo = 0 # Default: today

        # Today
        # theTime = new TheTime
        today = TheTime.today()
        $scope.displayedToday = today.valueOf()
        $scope.$watch( 'today', ->
            $scope.displayedToday = today.valueOf()
        )

        # Selected Day
        $scope.selectedDay = moment(today)
        $scope.displayedDay = $scope.selectedDay.valueOf()
            # The date to display, and current week, updating when selectedDay changes
            # AngularJS wants milliseconds, valueOf() gives milliseconds
        $scope.$watch( 'daysAgo', -> 
            $scope.selectedDay = moment(today).add('days',$scope.daysAgo)
            $scope.displayedDay = $scope.selectedDay.valueOf()
        )

        # Habits data
        $scope.allHabits = HabitTemplates
        # Obtain the pre-prepared list of Habits and results
        $scope.myHabits = MyHabits

        # New Habit input field
        $scope.inputHabitName = undefined
        allHabitNames = _.pluck(HabitTemplates, 'name')
        $scope.myHabitNames = _.pluck(MyHabits, 'name')
        $scope.otherHabitNames = _.difference( allHabitNames, $scope.myHabitNames)

        # Start date input field
        $scope.dateChangeIsSelected=0

        ## Functions called from within the page
        $scope.clickPrevWeek = ->
            $scope.daysAgo += 7
        
        $scope.clickNextWeek = ->
            # TODO: move to latest day, if it's less than 7 days ahead?
            $scope.daysAgo -= 7

        # When a user adds a habit
        $scope.startedDaysAgo = 0
        $scope.pickedDate = today.format('YYYY-MM-DD')
        $scope.addOneHabit = (habName, nbDaysToInit) ->
            alert('Defect: a Habit must have a name') if habName == undefined || habName == ''
            # Add the habit
            MyHabits.push(new ActiveHabit habName, nbDaysToInit)
            console.log("Habit #{habName} added")
            
            # Reinitialize the form to add a habit
            $scope.nowAddingHabit = false
            $scope.dateChangeIsSelected = 0
            $scope.startedDaysAgo = 0

            # If the habit was started several days ago, go to the Habit Board,
            # so the user can update their previous day's results
            if nbDaysToInit > 0
                $state.transitionTo("habitBoard", {name: habName})
           # $state.go('habit({name: name})')
           # alert(JSON.stringify(state))

        # TODO: make it an angular filter, external to the controller
        $scope.wasActive = (habit)->
            return habit.wasActive($scope.daysAgo)
