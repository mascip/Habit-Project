// Generated by CoffeeScript 1.6.3
(function() {
  'use strict';
  var CtrlMyLab, app, app_name;

  app_name = "myApp";

  app = angular.module("" + app_name + ".ctrl-my-lab", ['ui.bootstrap']);

  app.controller('CtrlMyLab', CtrlMyLab = (function() {
    function CtrlMyLab($scope, ActiveHabit, Habit, MyHabits, TheTime) {
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
      $scope.allHabits = _.map(['Meditation', 'Exercise', 'Procrastination', 'Get Organized', 'Stay Organized', 'Organize Emails'], function(name) {
        return new Habit(name);
      });
      $scope.myHabits = MyHabits;
      $scope.inputHabitName = void 0;
      $scope.allHabitNames = _.pluck($scope.allHabits, 'name');
      $scope.myHabitNames = _.pluck($scope.myHabits, 'name');
      $scope.otherHabitNames = _.difference($scope.allHabitNames, $scope.myHabitNames);
      $scope.dateChangeIsSelected = 0;
      $scope.clickPrevWeek = function() {
        return $scope.daysAgo += 7;
      };
      $scope.clickNextWeek = function() {
        return $scope.daysAgo -= 7;
      };
      $scope.pickedDate = today.format('YYYY-MM-DD');
      $scope.addOneHabit = function(name, pickedDate) {
        var nbDaysToInit;
        if (name === void 0 || name === '') {
          return;
        }
        nbDaysToInit = today.diff(pickedDate, 'days');
        $scope.myHabits.push(new ActiveHabit(name, nbDaysToInit));
        console.log('Habit #{name} added');
        $scope.nowAddingHabit = false;
        return $scope.dateChangeIsSelected = 0;
      };
      $scope.wasActive = function(habit) {
        return habit.wasActive($scope.daysAgo);
      };
    }

    return CtrlMyLab;

  })());

}).call(this);
