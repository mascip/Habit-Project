'use strict'

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


    class Habit
        constructor: (@name, @pastResults) ->
            @streak = _.last @pastResults

        ticked: 0

        previousStreak: -> _.last @pastResults

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


    $scope.habits = [ 
        new Habit 'meditation', [-2]
        new Habit 'exercise', [5]
    ]
]

