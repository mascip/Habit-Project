'use strict'
        

class SingleResult
    constructor: ({@day, @dateTime, @ticked, @streak}) ->
        #alert('SingleResult: ' + @day + ' - ' + @dateTime+' - ' + @ticked+' - ' + @streak)


class Habit
    # A habit and the user's results to display for this habit
    # @name: the name of the habit (eg:meditation)
    # @streakXdaysAgo: a JSON with {NbDaysInThePast: streak} pairs
    constructor: (@name, @prevResults) ->
        # Result currently selected by the user (default: today's result)
        @selectedResult = 
            day: moment().startOf('day')
            dateTime: 0
            streak: _.last(@prevResults).streak
            ticked: 0
        @nextResults = []
        @allTicks = []
        
        # Initialization
        @updateAllTicks()
        

    noPrevResults: -> return @prevResults.length == 0

    prevStreak: -> 
        if @noPrevResults() then 0 else _.last(@prevResults).streak

    clicked: =>
        # Update the tick
        tickedNew = (@selectedResult.ticked + 1) % 3  
        @selectedResult.ticked = tickedNew

        # Update the streak
        @selectedResult.streak = switch
            when tickedNew == 1 then @increaseStreak()
            when tickedNew == 2 then @decreaseStreak()
            else @prevStreak() 

        # Update all the record of all ticks
            #TODO: try to do it with angular-underscore, in the template
        @updateAllTicks()
        
    updateAllTicks: -> @allTicked = _.pluck(@allResults(), 'ticked')

    increaseStreak: -> if @prevStreak() > 0 then @prevStreak() + 1 else 1
    decreaseStreak: -> if @prevStreak() < 0 then @prevStreak() - 1 else -1

    selectPrevDay: ->
        #alert('prev:' + JSON.stringify(@prevResults) + 'sel:' + JSON.stringify(@selectedResult) + 'next:' + JSON.stringify(@nextResults)   )

        @nextResults.unshift(@selectedResult)
        @selectedResult = @prevResults.pop()

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
        new Habit 'exercise', createResults([10,1,1], [9,1,2], [8,1,3], [7,1,4], [6,1,5], [5,1,6], [4,1,7], [3,1,8], [2,2,-1], [1,2,-2]) 
        new Habit 'meditation', createResults([5,1,1], [4,1,2], [3,1,3], [2,1,4], [1,1,5])
    ]

    $scope.selectPrevDay = ->
        selectedDay.subtract('days',1)
        $scope.displayedDay = selectedDay.valueOf()
        habit.selectPrevDay() for habit in $scope.habits

]

