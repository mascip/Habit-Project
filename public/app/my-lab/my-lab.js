// Generated by CoffeeScript 1.6.3
(function() {
  'use strict';
  var CtrlMyLab, app, app_name;

  app_name = "myApp";

  app = angular.module("" + app_name + ".ctrl-my-lab", ['ui.bootstrap', 'ui.router']);

  app.controller('CtrlMyLab', CtrlMyLab = (function() {
    function CtrlMyLab($scope, $state, ActiveHabit, MyHabits, HabitTemplates, TheTime) {
      var today;
      $scope.daysAgo = 0;
      today = TheTime.today();
      $scope.displayedToday = today.valueOf();
      $scope.$watch('today', function() {
        return $scope.displayedToday = today.valueOf();
      });
      $scope.selectedDay = moment(today);
      $scope.displayedDay = $scope.selectedDay.valueOf();
      $scope.$watch('daysAgo', function() {
        $scope.selectedDay = moment(today).add('days', $scope.daysAgo);
        return $scope.displayedDay = $scope.selectedDay.valueOf();
      });
      $scope.allHabits = HabitTemplates;
      $scope.myHabits = MyHabits;
      $scope.inputHabitName = void 0;
      $scope.allHabitNames = _.pluck(HabitTemplates, 'name');
      $scope.myHabitNames = _.pluck(MyHabits, 'name');
      $scope.otherHabitNames = _.difference($scope.allHabitNames, $scope.myHabitNames);
      $scope.dateChangeIsSelected = 0;
      $scope.clickPrevWeek = function() {
        return $scope.daysAgo += 7;
      };
      $scope.clickNextWeek = function() {
        return $scope.daysAgo -= 7;
      };
      $scope.startedDaysAgo = 0;
      $scope.pickedDate = today.format('YYYY-MM-DD');
      $scope.addOneHabit = function(habitName, nbDaysToInit) {
        if (habitName === void 0 || habitName === '') {
          alert('Defect: a Habit must have a name');
        }
        MyHabits.push(new ActiveHabit(habitName, nbDaysToInit));
        console.log("Habit " + habitName + " added");
        $scope.nowAddingHabit = false;
        $scope.dateChangeIsSelected = 0;
        $scope.startedDaysAgo = 0;
        if (nbDaysToInit > 0) {
          return $state.transitionTo("habitBoard", {
            name: habitName
          });
        }
      };
      $scope.wasActive = function(habit) {
        return habit.wasActive($scope.daysAgo);
      };
    }

    return CtrlMyLab;

  })());

}).call(this);
