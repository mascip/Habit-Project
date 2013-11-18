// Generated by CoffeeScript 1.6.3
(function() {
  'use strict';
  var CtrlHabitBoard, app, app_name;

  app_name = "myApp";

  app = angular.module("" + app_name + ".ctrl-habit-board", ['ui.bootstrap']);

  app.controller('CtrlHabitBoard', CtrlHabitBoard = (function() {
    function CtrlHabitBoard($scope, $stateParams, MyHabits) {
      var myHabits, now, today;
      $scope.nbWeekInMonth = function(activeDay) {
        return 5;
      };
      $scope.daysAgo = 0;
      now = moment();
      today = now.startOf('day');
      $scope.displayedToday = today.valueOf();
      $scope.$watch('today', function() {
        return $scope.displayedToday = today.valueOf();
      });
      $scope.selectedDay = moment(today);
      $scope.thisIsToday = $scope.selectedDay.isSame(today);
      $scope.displayedDay = $scope.selectedDay.valueOf();
      $scope.$watch('daysAgo', function() {
        $scope.selectedDay = moment(today).add('days', $scope.daysAgo);
        $scope.displayedDay = $scope.selectedDay.valueOf();
        return $scope.thisIsToday = $scope.selectedDay.isSame(today);
      });
      $scope.habitName = $stateParams.name;
      myHabits = MyHabits;
      $scope.habit = _.find(myHabits, function(habit) {
        return habit.name === $scope.habitName;
      });
      $scope.dateChangeIsSelected = 0;
      $scope.wasActive = function(habit) {
        return habit.wasActive($scope.daysAgo);
      };
      $scope.clickPrevWeek = function() {
        return $scope.daysAgo += 7;
      };
      $scope.clickNextWeek = function() {
        return $scope.daysAgo -= 7;
      };
    }

    return CtrlHabitBoard;

  })());

  app.directive('habite', function() {
    return {
      restict: 'E',
      template: '<div>Hi there</div>'
    };
  });

}).call(this);
