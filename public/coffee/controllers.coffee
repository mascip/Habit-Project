'use strict'
        

class SingleResult
    constructor: ({@day, @dateTime, @ticked, @streak}) ->
        #alert('SingleResult: ' + @day + ' - ' + @dateTime+' - ' + @ticked+' - ' + @streak)


class Habit
    # A habit and the user's results to display for this habit
    # @name: the name of the habit (eg:meditation)
    # @streakXdaysAgo: a JSON with {NbDaysInThePast: streak} pairs
    constructor: (@name, @prevResults) ->
        #alert(JSON.stringify(@prevResults))
        #alert(JSON.stringify(@prevResults[0]))
        # Result currently selected by the user (default: today's result)
        @selectedResult = 
            day: moment().startOf('day')
            dateTime: 0
            streak: @prevResults[0].streak
            ticked: 0
        @nextResults = []
        @allTicked = _.pluck(@allResults(), 'ticked')

    prevStreak: -> @prevResults[0].streak

    clicked: =>
        tickedOld = @selectedResult.ticked
        @selectedResult.ticked = (tickedOld + 1) % 3  
        @selectedResult.streak = switch
            when tickedOld == 1 then @increaseStreak()
            when tickedOld == 2 then @decreaseStreak()
            else @prevStreak() 

    increaseStreak: -> if @prevStreak() > 1 then @prevStreak() + 1 else 1
    decreaseStreak: -> if @prevStreak() < 0 then @prevStreak() - 1 else -1

    selectPrevDay: ->
        #alert('prev:' + JSON.stringify(@prevResults) + 'sel:' + JSON.stringify(@selectedResult) + 'next:' + JSON.stringify(@nextResults)   )

        @nextResults.unshift(@selectedResult)
        #alert('next:' + JSON.stringify @nextResults)
        @selectedResult = @prevResults.shift()
        #alert('sel:' + JSON.stringify @selectedResult)

        #alert('prev:' + JSON.stringify(@prevResults) + 'sel:' + JSON.stringify(@selectedResult) + 'next:' + JSON.stringify(@nextResults)   )

    selectNextDay: ->
        @nextResults.unshift(@selectedResult)
        @selectedResult = @prevResults.shift()


    allResults: -> 
        allR = [@selectedResult]
        if @prevResults.length then allR = @prevResults.concat(allR) 
        if @nextResults.length then allR = allR.concat(@nextResults) 
        return allR

        


### Controllers ###

app_name = "myApp"
app = angular.module "#{app_name}.controllers", []

app.controller 'myCtrl2', ['$scope', ($scope) -> 
        $scope.test = 2;
]


app.controller 'CtrlUserBoard', ['$scope', ($scope) ->

    #alert 'controller' 

    now = moment()
    selectedDay = now.startOf('day')
    $scope.displayedDay = selectedDay.valueOf()
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
                    ticked: 2
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

    $scope.selectPrevDay = ->
        selectedDay.subtract('days',1)
        $scope.displayedDay = selectedDay.valueOf()
        habit.selectPrevDay() for habit in $scope.habits

]

