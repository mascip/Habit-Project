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
            ticked: 'unknown'
        
        # All results
        @results = _.clone prevResults
        @results.unshift(_.clone @currentResult)
        
        # Which day is displayed to the user (nb of days ago. 0 is today)
        @dayIdx = 0
        

    ticked: -> @selectedResult().ticked

    streak: -> @selectedResult().streak

    selectedResult: -> @results[@dayIdx]

    calcStreak: (tick, prevStreak) -> switch
        when tick == 'unknown' then prevStreak
        when tick == 'done' then @increaseStreak(prevStreak)
        when tick == 'failed' then @decreaseStreak(prevStreak)

    firstResult: -> _.last @results

    updateAllStreaks: ->
        for i in [@results.length-1..1] # starting from the oldest streak...
            @results[i-1].streak =  @calcStreak(@results[i-1].ticked, @results[i].streak)

        # update the first streak in the list
        @firstResult().streak = @calcStreak(@firstResult().ticked, 'unknown')

    clickTick: =>
        # Once you've ticked it, you HAVE to say whether the habit is done or not
        @selectedResult().ticked = switch
            when @ticked() == 'unknown' then 'done'
            when @ticked() == 'done'    then 'failed'
            when @ticked() == 'failed'  then 'done'
            else 'failed'
        
        # Change the current tick
        #@selectedResult().ticked = (@ticked() + 1) % 3

        # Update all streak values
        @updateAllStreaks()

    selectedDay: -> @results[@dayIdx].day

    clickPrevDay: -> @dayIdx++  # One MORE day in the past 
    clickNextDay: -> @dayIdx--  # One LESS day in the past 
        
    doesntExistYet: -> @dayIdx >= @results.length

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


        # Helper functions to create data, for test
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
        new Habit 'meditation', createResults([1,'done',5], [2,'done',4], [3,'done',3], [4,'done',2], [5,'done',1])
        new Habit 'exercise', createResults([1,'failed',-2], [2,'failed',-1], [3,'done',8], [4,'done',7], [5,'done',6], [6,'done',5], [7,'done',4], [8,'done',3], [9,'done',2], [10,'done',1]) 
    ]

    $scope.thisIsToday = -> selectedDay.isSame(today)

    $scope.clickPrevDay = ->
        selectedDay.subtract('days',1)
        $scope.displayedDay = selectedDay.valueOf()
        habit.clickPrevDay() for habit in $scope.habits
    
    $scope.clickNextDay = ->
        selectedDay.add('days',1)
        $scope.displayedDay = selectedDay.valueOf()
        habit.clickNextDay() for habit in $scope.habits

 
]
