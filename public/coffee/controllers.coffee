'use strict'
        
today = moment().startOf('day')

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
        @streak = @previousResults[0].streak
        @ticked = 0

    previousStreak: -> @previousResults[0].streak

    increaseStreak: -> if @previousStreak() > 1 then @previousStreak() + 1 else 1

    sameStreak: -> @previousStreak()

    failedStreak: -> if @previousStreak() < 0 then @previousStreak() - 1 else -1

    clicked: =>
        @ticked = (@ticked + 1) % 3  
        @streak = switch
            when @ticked == 1 then @increaseStreak()
            when @ticked == 2 then @failedStreak()
            else @sameStreak()


### Controllers ###

app_name = "myApp"
app = angular.module "#{app_name}.controllers", []

app.controller 'myCtrl2', ['$scope', ($scope) -> 
        $scope.test = 2;
]

app.controller 'CtrlUserBoard', ['$scope', ($scope) ->

    $scope.checkboxImages = [
        "images/unchecked_checkbox.png",
        "images/tick-green.png",
        "images/red-cross.png",
    ]


    $scope.habits = [ 
        new Habit 'meditation', [
                new SingleResult
                    day: moment().subtract(1).startOf('day')
                    dateTime: moment().subtract(1)
                    ticked: 1
                    streak: 5
                    ,
                new SingleResult
                    day: moment().subtract(2).startOf('day')
                    dateTime: moment().subtract(2)
                    ticked: 1
                    streak: 4
            ]
        new Habit 'exercise', [
                new SingleResult
                    day: moment().subtract(1).startOf('day')
                    dateTime: moment().subtract(1)
                    ticked: 0
                    streak: -1
                    ,
                new SingleResult
                    day: moment().subtract(2).startOf('day')
                    dateTime: moment().subtract(2)
                    ticked: 1
                    streak: 28
            ]

        
    ]

]

