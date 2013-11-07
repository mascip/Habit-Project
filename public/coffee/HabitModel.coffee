app_name = "myApp"
app = angular.module "#{app_name}.services", []

app.service 'Habit', 
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

