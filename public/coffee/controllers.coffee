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
        currentResult = 
            day: moment().startOf('day')
            dateTime: 0
            streak: _.first(prevResults).streak
            ticked: 'unknown'
        
        # All results
        @results = _.clone prevResults
        @results.unshift(_.clone currentResult)
        @updateAllStreaks()

        # Which day is displayed to the user (nb of days ago. 0 is today)
        @dayIdx = 0
        # Has today's result been ticked?
        @notTickedToday = true
        

    # Delegation to attributes
    selectedResult: -> @results[@dayIdx]
    ticked: -> @selectedResult().ticked
    streak: -> @selectedResult().streak
    selectedDay: -> @results[@dayIdx].day


    ## ClickTick
    # When the user indicates whether they have done the habit or not
    clickTick: =>
        # Once you have ticked, the state cannot be 'unknown' anymore
        @selectedResult().ticked = switch
            when @ticked() == 'unknown' then 'done'
            when @ticked() == 'done'    then 'failed'
            when @ticked() == 'failed'  then 'done'
            else 'failed'
        
        # Was it today's result?
        @notTickedToday = false if @dayIds == 0

        # Update all streak values
        @updateAllStreaks()

    ## updateAllStreaks
    # When a result has been changed, all the following Streak values get changed
    updateAllStreaks: ->
        # update the first streak value in the list
        @firstResult().streak = @calcStreak(@firstResult().ticked, 'unknown')

        # Update all the other streak values
        for i in [@results.length-2..0] # starting from the second oldest streak...
            console.log @results[i]
            @results[i].streak =  @calcStreak(@results[i].ticked, @results[i+1].streak)
        
        # Update the total numbers of results, and number of done/failed habits
        @countAllResults()

    countAllResults: ->
        @countResults = _.countBy( @results, (result) -> result.ticked )
        @countResults['unknown'] ||= 0
        @countResults.total = _.size(@results) - @countResults['unknown']

    # Update the results every time the streak is changed
    #$scope.$watch(@streak, alert('streak changed'))

    firstResult: -> _.last @results
    calcStreak: (tick, prevStreak) -> switch
        when tick == 'unknown' then prevStreak
        when tick == 'done' then @increaseStreak(prevStreak)
        when tick == 'failed' then @decreaseStreak(prevStreak)
    increaseStreak: (prevStk) -> if prevStk > 0 then prevStk + 1 else 1
    decreaseStreak: (prevStk) -> if prevStk < 0 then prevStk - 1 else -1

    # Changing which day is displayed
    clickPrevDay: -> @dayIdx++  # One MORE day in the past 
    clickNextDay: -> @dayIdx--  # One LESS day in the past 

    # If a habit doesn't exist yet at the selected date... perhaps don't display it?
    # TODO: a better solution will be to list the habits that are present each day!
    # ... or to use UserDailyResults = { habits: [ { 'meditation' ..., but that might be a pain for calculating future streak results, unless if I use a linked list. Think about it...
    doesntExistYet: -> @dayIdx >= @results.length



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
   

    $scope.habits = [ 
        new Habit 'meditation', createResults([1,'done'], [2,'done']) #, [3,'done',3], [4,'done',2], [5,'done',1])
        new Habit 'exercise', createResults([1,'failed'], [2,'failed'], [3,'done'], [4,'done'], [5,'done'], [6,'done'], [7,'done'], [8,'done'], [9,'done'], [10,'done']) 
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
