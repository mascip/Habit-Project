// Generated by CoffeeScript 1.6.3
(function() {
  'use strict';
  var app, app_name;

  app_name = "myApp";

  app = angular.module("" + app_name + ".habitResultsCalendar", []);

  app.directive('habitResultsCalendar', function(CalendarDays, TheTime) {
    return {
      restrict: 'E',
      templateUrl: 'app/components/habit-results-calendar/habitResultsCalendar.html',
      replace: true,
      link: function(scope, element, attrs) {
        var calDays;
        scope.today = TheTime.today;
        scope.monthName = TheTime.monthName;
        scope.year = TheTime.year;
        calDays = new CalendarDays(TheTime.month, scope.year);
        scope.nbWeeks = calDays.nbWeeks;
        scope.daysInWeek = calDays.weeks;
        return scope.dayNumsInWeek = _.map(scope.daysInWeek, function(week) {
          return _.map(week, function(day) {
            return day.date();
          });
        });
      }
    };
  });

}).call(this);
