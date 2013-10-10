'use strict'

#TODO:
# ticked = [unknown, done, failed]
        

class SingleResult
    constructor: ({@day, @dateTime, @ticked, @streak}) ->
        #alert('SingleResult: ' + @day + ' - ' + @dateTime+' - ' + @ticked+' - ' + @streak)


class Habit
    # A habit and the user's results to display for this habit
    # @name: the name of the habit (eg:meditation)
    # @prevResults: a list of previous results. The N-th element was N days ago
    constructor: (@name, prevResults) ->
         
        # Result currently selected by the user (default: today's result)
        @currentResult = 
            day: moment().startOf('day')
            dateTime: 0
            streak: _.first(prevResults).streak
            ticked: 0
        
        # All results
        @results = _.clone prevResults
        @results.unshift(_.clone @currentResult)
        
        # Which day is displayed to the user (nb of days ago. 0 is today)
        @daySelected = 0
        

    ticked: -> @selectedResult().ticked

    streak: -> @selectedResult().streak

    selectedResult: -> @results[@daySelected]

    calcStreak: (tick, prevStreak) -> switch
        when tick == 0 then prevStreak
        when tick == 1 then @increaseStreak(prevStreak)
        when tick == 2 then @decreaseStreak(prevStreak)

    firstResult: -> _.last @results

    updateAllStreaks: ->
        for i in [@results.length-1..1] # starting from the oldest streak...
            @results[i-1].streak =  @calcStreak(@results[i-1].ticked, @results[i].streak)

        # update the first streak in the list
        @firstResult().streak = @calcStreak(@firstResult().ticked, 0)

    clicked: =>
        # Change the current tick
        @selectedResult().ticked = (@ticked() + 1) % 3

        # Update all streak values
        @updateAllStreaks()

    clickPrevDay: -> @daySelected++  # One MORE day in the past 
        
    doesntExist: -> @daySelected >= @results.length

    increaseStreak: (prevStk) -> if prevStk > 0 then prevStk + 1 else 1
    decreaseStreak: (prevStk) -> if prevStk < 0 then prevStk - 1 else -1

    selectPrevDay: ->
        #@nextResults.unshift(@selectedResult())
        #@selectedResult() = @prevResults.pop()


    selectNextDay: ->
        #@nextResults.unshift(@selectedResult())
        #@selectedResult() = @prevResults.shift()


        


### Controllers ###

app_name = "myApp"
app = angular.module "#{app_name}.controllers", []

app.controller 'myCtrl2', ['$scope', ($scope) -> 
        $scope.test = 2;
]


app.controller 'CtrlUserBoard', ['$scope', ($scope) ->


    now = moment()
    selectedDay = now.startOf('day')
    $scope.displayedDay = selectedDay.valueOf()
        # AngularJS wants milliseconds, valueOf() gives milliseconds

    $scope.checkboxImages = [
        "images/unchecked_checkbox.png",
        "images/tick-green.png",
        "images/red-cross.png",
    ]

    createSingleResult = (daysAgo, tck, strk) ->
        new SingleResult
            day: moment().subtract('days',daysAgo).startOf('day')
            dateTime: moment().subtract('days',daysAgo)
            ticked: tck
            streak: strk

    createResults = (resultsArgs...) ->
        results = _.map(resultsArgs, (args) -> 
                #createSingleResult.apply(this,args)
                createSingleResult(args...)
            )

        

    $scope.habits = [ 
        new Habit 'meditation', createResults([1,1,5], [2,1,4], [3,1,3], [4,1,2], [5,1,1])
        new Habit 'exercise', createResults([1,1,10], [2,1,9], [3,1,8], [4,1,7], [5,1,6], [6,1,5], [7,1,4], [8,1,3], [9,2,-1], [10,2,-2]) 
    ]

    $scope.clickPrevDay = ->
        selectedDay.subtract('days',1)
        $scope.displayedDay = selectedDay.valueOf()
        habit.clickPrevDay() for habit in $scope.habits

]

