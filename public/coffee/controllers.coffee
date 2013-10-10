'use strict'
        

class SingleResult
    constructor: ({@day, @dateTime, @ticked, @streak}) ->
        #alert('SingleResult: ' + @day + ' - ' + @dateTime+' - ' + @ticked+' - ' + @streak)


class Habit
    # A habit and the user's results to display for this habit
    # @name: the name of the habit (eg:meditation)
    # @streakXdaysAgo: a JSON with {NbDaysInThePast: streak} pairs
    constructor: (@name, @previousResults) ->
        #alert(JSON.stringify(@previousResults))
        #alert(JSON.stringify(@previousResults[0]))
        # Result currently selected by the user (default: today's result)
        @selectedResult = 
            day: moment().startOf('day')
            dateTime: 0
            streak: @previousResults[0].streak
            ticked: 0
        @nextResults = {}

    previousStreak: -> @previousResults[0].streak

    clicked: =>
        tickedOld = @selectedResult.ticked
        @selectedResult.ticked = (tickedOld + 1) % 3  
        @selectedResult.streak = switch
            when tickedOld == 1 then @increaseStreak()
            when tickedOld == 2 then @failedStreak()
            else @sameStreak()

    increaseStreak: -> if @previousStreak() > 1 then @previousStreak() + 1 else 1
    sameStreak: -> @previousStreak()
    failedStreak: -> if @previousStreak() < 0 then @previousStreak() - 1 else -1

### Controllers ###

app_name = "myApp"
app = angular.module "#{app_name}.controllers", []

app.controller 'myCtrl2', ['$scope', ($scope) -> 
        $scope.test = 2;
]


app.controller 'CtrlUserBoard', ['$scope', ($scope) ->

    alert 'controller' 

    now = moment()
    selectedDate = now.startOf('day')
    $scope.displayedDate = selectedDate.valueOf()
        # AngularJS wants milliseconds, valueOf() gives milliseconds

    $scope.checkboxImages = [
        "images/unchecked_checkbox.png",
        "images/tick-green.png",
        "images/red-cross.png",
    ]

    $scope.habits = [ 
        new Habit 'meditation', [
                new SingleResult
                    day: moment().subtract('days',1).startOf('day')
                    dateTime: moment().subtract('days',1)
                    ticked: 1
                    streak: 5
                    ,
                new SingleResult
                    day: moment().subtract('days',2).startOf('day')
                    dateTime: moment().subtract('days',2)
                    ticked: 1
                    streak: 4
                ,
                new SingleResult
                    day: moment().subtract('days',3).startOf('day')
                    dateTime: moment().subtract('days',3)
                    ticked: 1
                    streak: 3
            ]
        new Habit 'exercise', [
                new SingleResult
                    day: moment().subtract('days',1).startOf('day')
                    dateTime: moment().subtract('days',1)
                    ticked: 0
                    streak: -1
                    ,
                new SingleResult
                    day: moment().subtract('days',2).startOf('day')
                    dateTime: moment().subtract('days',2)
                    ticked: 1
                    streak: 28
                ,
                new SingleResult
                    day: moment().subtract('days',3).startOf('day')
                    dateTime: moment().subtract('days',3)
                    ticked: 1
                    streak: 27
            ]

    ]

    $scope.selectPreviousDate = ->
        selectedDate.subtract('days',1)
        $scope.displayedDate = selectedDate.valueOf()

]

