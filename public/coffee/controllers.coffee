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
    constructor: ($scope, ActiveHabit, Habit) ->

        ## DATA

        # Which day is displayed to the user (nb of days ago. 0 is today)
        $scope.daysAgo = 0 # Default: today

        # Days
        now = moment()
        today = now.startOf('day')
        $scope.selectedDay = moment(today)
        # The date to display, and current week, updating when selectedDay changes
        # AngularJS wants milliseconds, valueOf() gives milliseconds
        $scope.displayedDay = $scope.selectedDay.valueOf()
        $scope.$watch( 'daysAgo', -> 
            $scope.selectedDay = moment(today).add('days',$scope.daysAgo)
            $scope.displayedDay = $scope.selectedDay.valueOf()
        )

        # # Images for tick-boxes
        # $scope.checkboxIcon = 
        #     unknown: "unchecked"
        #     done:    "ok"
        #     failed:  "remove"

        # Habits data
        #$scope.allHabits = ['Meditation', 'Exercise', 'Procrastination', 'Get Organized']
        $scope.allHabits = _.map(['Meditation', 'Exercise', 'Procrastination', 'Get Organized', 'Stay Organized', 'Organize Emails'],
            (name) -> new Habit(name))

        $scope.myHabits = [ 
            new ActiveHabit 'Meditation', createResults([1,'done']) #, [2,'done']) #, [3,'done',3], [4,'done',2], [5,'done',1])
            new ActiveHabit 'Exercise', createResults([1,'failed'], [2,'failed'], [3,'done'], [4,'done'], [5,'done'], [6,'done'], [7,'done'], [8,'done']) 
        ]



        # New Habit input field
        $scope.inputHabitName = undefined
        $scope.allHabitNames = _.pluck($scope.allHabits, 'name')
        $scope.myHabitNames = _.pluck($scope.myHabits, 'name')
        $scope.otherHabitNames = _.difference( $scope.allHabitNames, $scope.myHabitNames)

        # Start date input field
        $scope.dateChangeIsSelected=0

        ## Functions called from within the page
        $scope.thisIsToday = -> $scope.selectedDay.isSame(today)

        $scope.clickPrevWeek = ->
            $scope.daysAgo += 7
        
        $scope.clickNextWeek = ->
            # TODO: move to latest day, if it's less than 7 days ahead?
            $scope.daysAgo -= 7

        # When a user adds a habit
        $scope.addOneHabit = (name) ->
            return if name == undefined || name == ''
            console.log('Habit #{name} added')
            $scope.myHabits.push(new ActiveHabit name)
            $scope.nowAddingHabit = false   # Close the form that adds a habit
            $scope.dateChangeIsSelected=0

        # TODO: make it an angular filter, external to the controller
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
