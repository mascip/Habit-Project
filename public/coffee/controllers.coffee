'use strict'
app_name = "myApp"
app = angular.module "#{app_name}.controllers", ['ui.bootstrap']

app.controller 'myCtrl2', ['$scope', ($scope) -> 
    $scope.test = 'some text'
]

class SingleResult
    constructor: ({@day, @dateTime, @ticked, @streak}) ->

app.controller 'CtrlUserBoard',
class CtrlUserBoard
    constructor: ($scope, HabitService) ->

        ## DATA

        # Which day is displayed to the user (nb of days ago. 0 is today)
        $scope.daysAgo = 0 # Default: today

        # Days
        now = moment()
        today = now.startOf('day')
        selectedDay = moment(today)
        $scope.displayedDay = selectedDay.valueOf()
            # AngularJS wants milliseconds, valueOf() gives milliseconds

        # Images for tick-boxes
        $scope.checkboxImages = 
            unknown:    "images/unchecked_checkbox.png"
            done:       "images/tick-green.png"
            failed:     "images/red-cross.png"


        # Habits data
        $scope.habits = [ 
            new HabitService 'meditation', createResults([1,'done']) #, [2,'done']) #, [3,'done',3], [4,'done',2], [5,'done',1])
            new HabitService 'exercise', createResults([1,'failed'], [2,'failed'], [3,'done'], [4,'done'], [5,'done'], [6,'done'], [7,'done'], [8,'done'], [9,'done'], [10,'done']) 
        ]

        # New Habit input field
        $scope.inputHabitName = undefined
        $scope.habitNames = _.pluck($scope.habits, 'name')

        ## Functions called from within the page
        $scope.thisIsToday = -> selectedDay.isSame(today)

        $scope.clickPrevDay = ->
            $scope.daysAgo++
            selectedDay.subtract('days',1)
            $scope.displayedDay = selectedDay.valueOf()
        
        $scope.clickNextDay = ->
            $scope.daysAgo--
            selectedDay.add('days',1)
            $scope.displayedDay = selectedDay.valueOf()

        $scope.addOneHabit = (name) ->
            $scope.habits.push(new HabitService name)
            $scope.nowAddingHabit = false   # Close the form that adds a habit

        $scope.wasActive = (habit)->
            return habit.wasActive($scope.daysAgo)
    
    ## Helper functions to create data, for test
    createSingleResult = (daysAgo, tck) ->
        new SingleResult
            day: moment().subtract('days',daysAgo).startOf('day')
            dateTime: moment().subtract('days',daysAgo)
            ticked: tck
            streak: 0

    createResults = (resultsArgs...) ->
        results = _.map(resultsArgs, (args) -> 
            #createSingleResult.apply(this,args)
            createSingleResult(args...)
        )

 
 # END CtrlUserBoard
