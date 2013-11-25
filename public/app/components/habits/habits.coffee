'use strict'
app_name = "myApp"
app = angular.module "#{app_name}.habits", []

# Demonstrate how to register services
# In this case it is a simple value service.
app.value 'version', '0.1'


class SingleResult
    constructor: ({@day, @checkinDateTime, @ticked, @streak}) ->
    
## MyHabits
app.factory 'MyHabits', (ActiveHabit) ->
        ## Helper functions to create data, for test
        createSingleResult = (daysAgo, tck) ->
            new SingleResult
                day: moment().subtract('days',daysAgo).startOf('day')
                checkinDateTime: moment().subtract('days',daysAgo)
                ticked: tck
                streak: 0
        createResults = (resultsArgs...) ->
            results = _.map(resultsArgs, (args) ->
                #createSingleResult.apply(this,args)
                createSingleResult(args...)
            )
            # TODO: no need for the day number here
        return [
                new ActiveHabit 'Meditation', 0, createResults([1,'done'], [2,'done'], [3,'done',3], [4,'done',2], [5,'done',1])
                new ActiveHabit 'Exercise', 0, createResults([1,'failed'], [2,'failed'], [3,'done'], [4,'done'], [5,'done'], [6,'done'], [7,'done'], [8,'done'], [9,'done'], [10,'failed'], [11,'done'], [12,'done'], [13,'done'], [14,'done'], [15,'done'], [16,'done'], [17,'done'], [18,'done'], [19,'done'], [20,'done'], [21,'done'], [22,'done'], [23,'done'], [24,'done']) 
        ]

app.factory 'Habit', ->
    class Habit
        constructor: (@name) ->


app.factory 'ActiveHabit', (Habit, TheTime) ->
    class ActiveHabit
        # A habit and the user's results to display for this habit
        # @name: the name of the habit (eg:meditation)
        # prevResults: a list of previous results. The N-th element was N days ago
        constructor: (name, nbDaysToInit=0, prevResults=[]) ->
            @habit = new Habit(name)
            @name = @habit.name
            @results = _.clone prevResults

            @addOneUnknownResult = (day=TheTime.today(), prevStreak=0) ->
                unknownResult =
                    day: day
                    checkinDateTime: 0
                    streak: prevStreak
                    ticked: 'unknown'
                @results.unshift(unknownResult)
                
            @addUnknownResults = (nbDays=0, lastDay=TheTime.today(), prevStreak=0) ->
                for daysAgo in [0..nbDays]
                    theDay = moment(lastDay).subtract(daysAgo, 'days')
                    @addOneUnknownResult(theDay, prevStreak)

            # Result currently selected by the user (default: today's result)
            emptyHabit = prevResults.length == 0
            alert("Defect: to create a Habit, it must either have previous results, or past days to initialize; not both") if nbDaysToInit>0 and !emptyHabit

            currentStreak = if emptyHabit then 0 else _.first(prevResults).streak
            
            # Copy previous results and update new one
            @addUnknownResults(nbDaysToInit)
            # @results.unshift(_.clone currentResult)
            @updateAllStreaks() 
            # $rootScope.$watch(@results, @updateStreaks)

            # Which day is displayed to the user (nb of days ago. 0 is today)
            @dayIdx = 0

            # Has today's result been ticked?
            # @notTickedToday = true
             

        ## Accessing ticks and streaks
        allStreaks: -> _.map(@results, (res) -> res.streak)
        longestStreak: -> _.max(@allStreaks())
        streakAgo: (daysAgo) -> @results[daysAgo].streak
        tickedAgo: (daysAgo) -> 
            return 'unknown' if @doesntExistAgo(daysAgo) or daysAgo < 0
            @results[daysAgo].ticked
        tickedOnDay: (day) -> @tickedAgo(TheTime.wasAgo(day))

        ## Time related methods
        nbDaysSinceStart: () -> @results.length
        nbWeeksStarted: (daysAgo=0) -> Math.ceil((@nbDaysSinceStart()-daysAgo) / 7)
        nbDaysInWeek: (weekNum) -> Math.min(7, @nbDaysSinceStart() - 7 * weekNum)
            # weekNum: 0 is the current week, 1 is the previous week, etc
        nbWeeksToDisplay: (daysAgo=0) -> Math.min(2, @nbWeeksStarted(daysAgo))
        # currentWeekNumber: -> 

        resultsOfWeek: (weekNum) -> 
            weekNum # TODO

        startingDay: () ->
            TheTime.today().subtract(@nbDaysSinceStart()-1, 'days')

        inactiveOnDay: (day) ->
            day.isBefore(@startingDay()) or day.isAfter(TheTime.today())
        activeOnDay: (day) ->
            not @inactiveOnDay(day)
        
            
        ## ClickTick
        # When the user indicates whether they have done the habit or not
        clickTickAgo: (daysAgo) ->
            # Once you have ticked, the state cannot be 'unknown' anymore
            # TODO: I want to do this in the directive, not in here. However, it doesn't work properly (see the directive)
            ticked = @tickedAgo(daysAgo)
            @results[daysAgo].ticked = switch
                when ticked == 'unknown' then 'done'
                when ticked == 'done'    then 'failed'
                when ticked == 'failed'  then 'done'
                else 'failed'
            # Was it today's result?
            # @notTickedToday = false if @dayIds == 0
            # Update all streak values
            @updateAllStreaks() # Try to delete it and put a $watch in the constructor
        
        clickTickOnDay: (day) ->
            @clickTickAgo(TheTime.wasAgo(day))

        ## emptyHabit
        emptyHabit: -> @results.length == 0
        
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

            @percentSuccess = @countResults.done / @countResults.total * 100

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
        
        doesntExistAgo: (daysAgo) -> daysAgo >= @results.length # TODO delete when filter created?
        doesntExistOnDay: (day) -> doesntExistAgo(TheTime.wasAgo(day))

        wasActive: (daysAgo) -> daysAgo < @results.length 
            # TODO LATER: will need to be more complex when habits will end

