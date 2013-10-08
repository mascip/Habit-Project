'use strict'
        
today = new Date().toJSON()

class Habit
    # A habit and the user's results to display for this habit
    # @name: the name of the habit (eg:meditation)
    # @streakXdaysAgo: a JSON with {NbDaysInThePast: streak} pairs
    constructor: (@name, @streakXdaysAgo) ->
        @streak = @streakXdaysAgo[1]

    ticked: 0



    previousStreak: -> @streakXdaysAgo[1]

    increaseStreak: -> 
        if @previousStreak() > 1 then @previousStreak() + 1 else 1

    sameStreak: -> 
        @previousStreak()

    failedStreak: -> 
        if @previousStreak() < 0 then @previousStreak() - 1 else -1

    clicked: =>
        @ticked = (@ticked + 1) % 3  
        @streak = switch
            when @ticked == 1 then @increaseStreak()
            when @ticked == 2 then @failedStreak()
            else @sameStreak()


### Controllers ###

app_name = "myApp"
app = angular.module "#{app_name}.controllers", []

app.controller 'myCtrl1', ['$scope', ($scope) ->
    $scope.name = "view 1"
    $scope.say = -> window.alert.apply window, arguments
    $scope.test = 4;
  ]

app.controller 'myCtrl2', ['$scope', ($scope) -> 
        $scope.test = 2;
    ]

app.controller 'CtrlUserBoard', ['$scope', ($scope) ->
    $scope.name = "view 3"
    $scope.say = -> window.alert.apply window, arguments
    $scope.test = 4;

    $scope.checkboxImages = [
        "images/unchecked_checkbox.png",
        "images/tick-green.png",
        "images/red-cross.png",
    ]


    $scope.habits = [ 
        new Habit 'meditation', {1: -2, 2: -1}
        new Habit 'exercise', {1: 5, 2: 4}
    ]
]

