'use strict'
app_name = "myApp"
app = angular.module "#{app_name}.controllers", ['ui.bootstrap']

app.controller 'myCtrl2', ['$scope', ($scope) -> 
    $scope.test = 'some text'
]


app.controller 'CtrlHabitPage',
class CtrlHabitPage
    constructor: ($scope, $stateParams, MyHabits) ->
        # Which day is displayed to the user (nb of days ago. 0 is today)
        $scope.daysAgo = 0 # Default: today

        # Days
        now = moment()
        today = now.startOf('day')
        $scope.displayedToday = today.valueOf()
        $scope.$watch( 'today', ->
            $scope.displayedToday = today.valueOf()
        )
        $scope.selectedDay = moment(today)
        # The date to display, and current week, updating when selectedDay changes
        # AngularJS wants milliseconds, valueOf() gives milliseconds
        $scope.displayedDay = $scope.selectedDay.valueOf()
        $scope.$watch( 'daysAgo', ->
            $scope.selectedDay = moment(today).add('days',$scope.daysAgo)
            $scope.displayedDay = $scope.selectedDay.valueOf()
        )

        # Obtain the pre-prepared list of Habits and results
        $scope.habitName = $stateParams.name
        myHabitsService = new MyHabits
        myHabitsService.fillList()
        myHabits = myHabitsService.list
        $scope.habit = _.find(myHabits, (habit) ->
           console.log(habit.name + '---' + $scope.habitName)
           return habit.name == $scope.habitName
        )

        # TODO: delete duplication
        # Start date input field
        $scope.dateChangeIsSelected=0
        ## Functions called from within the page
        $scope.thisIsToday = -> $scope.selectedDay.isSame(today)
        $scope.wasActive = (habit)->
            return habit.wasActive($scope.daysAgo)

        # TODO: REMOVE DUPLICATION => DIRECTIVE !
        $scope.clickPrevWeek = ->
            $scope.daysAgo += 7
        
        $scope.clickNextWeek = ->
            # TODO: move to latest day, if it's less than 7 days ahead?
            $scope.daysAgo -= 7

app.controller 'CtrlUserBoard',
class CtrlUserBoard
    constructor: ($scope, ActiveHabit, Habit, MyHabits) ->

        ## DATA

        # Which day is displayed to the user (nb of days ago. 0 is today)
        $scope.daysAgo = 0 # Default: today

        # Days
        now = moment()
        today = now.startOf('day')
        $scope.displayedToday = today.valueOf()
        $scope.$watch( 'today', ->
            $scope.displayedToday = today.valueOf()
        )
        $scope.selectedDay = moment(today)
        # The date to display, and current week, updating when selectedDay changes
        # AngularJS wants milliseconds, valueOf() gives milliseconds
        $scope.displayedDay = $scope.selectedDay.valueOf()
        $scope.$watch( 'daysAgo', -> 
            $scope.selectedDay = moment($scope.today).add('days',$scope.daysAgo)
            $scope.displayedDay = $scope.selectedDay.valueOf()
        )


        # Habits data
        $scope.allHabits = _.map(['Meditation', 'Exercise', 'Procrastination', 'Get Organized', 'Stay Organized', 'Organize Emails'],
            (name) -> new Habit(name))

        # Obtain the pre-prepared list of Habits and results
        myHabitsService = new MyHabits
        myHabitsService.fillList()
        $scope.myHabits = myHabitsService.list

        # New Habit input field
        $scope.inputHabitName = undefined
        $scope.allHabitNames = _.pluck($scope.allHabits, 'name')
        $scope.myHabitNames = _.pluck($scope.myHabits, 'name')
        $scope.otherHabitNames = _.difference( $scope.allHabitNames, $scope.myHabitNames)

        # Start date input field
        $scope.dateChangeIsSelected=0

        ## Functions called from within the page
        $scope.thisIsToday = -> $scope.selectedDay.isSame(today)

        $scope.clickPrevWeek = ->
            $scope.daysAgo += 7
        
        $scope.clickNextWeek = ->
            # TODO: move to latest day, if it's less than 7 days ahead?
            $scope.daysAgo -= 7

        # When a user adds a habit
        $scope.pickedDate = today.format('YYYY-MM-DD')
        $scope.addOneHabit = (name, pickedDate) ->
            return if name == undefined || name == ''
            nbDaysToInit = today.diff(pickedDate, 'days')
                # If an earlier starting date was selected
            $scope.myHabits.push(new ActiveHabit name, nbDaysToInit)
            console.log('Habit #{name} added')
            $scope.nowAddingHabit = false   # Close the form that adds a habit
            $scope.dateChangeIsSelected=0

        # TODO: make it an angular filter, external to the controller
        $scope.wasActive = (habit)->
            return habit.wasActive($scope.daysAgo)

         

 
 # END CtrlUserBoard
