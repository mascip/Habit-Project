'use strict'
app_name = "myApp"
app = angular.module "#{app_name}.services", []

# Demonstrate how to register services
# In this case it is a simple value service.
app.value 'version', '0.1'

app.factory 'CreateResults', ->
class CreateResults
    constructor: (resultsArgs...) ->
        results = _.map(resultsArgs, (args) -> 
            SingleResultService(args...)
        )



app.factory 'HabitService', ->
    class Habit
        # A habit and the user's results to display for this habit
        # @name: the name of the habit (eg:meditation)
        # @prevResults: a list of previous results. The N-th element was N days ago
        constructor: (@name, prevResults=[]) ->
            
            # Result currently selected by the user (default: today's result)
            emptyHabit = prevResults.length == 0
            currentStreak = if emptyHabit then 0 else _.first(prevResults).streak
            currentResult = 
                day: moment().startOf('day')
                dateTime: 0
                streak: currentStreak 
                ticked: 'unknown'
            
            # Copy previous results and update new one
            @results = _.clone prevResults
            @results.unshift(_.clone currentResult)
            @updateAllStreaks() 

            # Which day is displayed to the user (nb of days ago. 0 is today)
            @dayIdx = 0

            # Has today's result been ticked?
            @notTickedToday = true
            
        streakOnDay: (daysAgo) -> @results[daysAgo].streak
        tickedOnDay: (daysAgo) -> @results[daysAgo].ticked

        ## ClickTick
        # When the user indicates whether they have done the habit or not
        clickTick: (daysAgo) ->
            # Once you have ticked, the state cannot be 'unknown' anymore
            ticked = @tickedOnDay(daysAgo)
            @results[daysAgo].ticked = switch
                when ticked == 'unknown' then 'done'
                when ticked == 'done'    then 'failed'
                when ticked == 'failed'  then 'done'
                else 'failed'
            
            # Was it today's result?
            @notTickedToday = false if @dayIds == 0

            # Update all streak values
            @updateAllStreaks()
        
        ## emptyHabit
        emptyHabit: -> @results.length == 0

        ## updateAllStreaks
        # When a result has been changed, all the following Streak values get changed
        updateAllStreaks: ->
            #return if @emptyHabit() # Nothing to update
            if !@emptyHabit()
                # Update the first streak value in the list
                @firstResult().streak = @calcStreak(@firstResult().ticked, 0)

                # Update all the other streak values
                if @results.length > 1
                    for i in [@results.length-2..0] # starting from the second oldest streak...
                        @results[i].streak =  @calcStreak(@results[i].ticked, @results[i+1].streak)
            
            # Update the total numbers of results, and number of done/failed habits
            @countAllResults()

        countAllResults: ->
            @countResults = _.countBy( @results, (result) -> result.ticked )
            for res in ['unknown', 'done', 'fail']
                @countResults[res] ||= 0
            @countResults.total = @results.length - @countResults['unknown']

        # Update the results every time the streak is changed
        #$scope.$watch(@streak, alert('streak changed'))

        firstResult: -> _.last @results

        ## calcStreak
        # tick: current tick status (unkown / failed / done)
        # prevStreak: value of the previous streak
        calcStreak: (tick, prevStreak) -> switch
            when tick == 'unknown' then prevStreak
            when tick == 'done' then @increaseStreak(prevStreak)
            when tick == 'failed' then @decreaseStreak(prevStreak)
        increaseStreak: (prevStk) -> if prevStk > 0 then prevStk + 1 else 1
        decreaseStreak: (prevStk) -> if prevStk < 0 then prevStk - 1 else -1

        # If a habit doesn't exist yet at the selected date... perhaps don't display it?
        # TODO: a better solution will be to list the habits that are present each day!
        # ... or to use UserDailyResults = { habits: [ { 'meditation' ..., but that might be a pain for calculating future streak results, unless if I use a linked list. Think about it...
        
        doesntExistOnDay: (daysAgo) -> daysAgo >= @results.length # TODO delete when filter created

        wasActive: (daysAgo) -> daysAgo < @results.length 
            # TODO LATER: will need to be more complex when habits will end

