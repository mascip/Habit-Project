// Generated by CoffeeScript 1.6.3
(function() {
  'use strict';
  var app, app_name;

  app_name = "myApp";

  app = angular.module("" + app_name + ".HabitUtil", []);

  app.service('HabitUtil', function() {
    return this.findIn = function(habitService, name) {
      return _.find(habitService, function(habit) {
        return habit.getName() === name;
      });
    };
  });

}).call(this);
