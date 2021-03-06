// Generated by CoffeeScript 1.6.3
(function() {
  'use strict';
  var app, app_name;

  app_name = "myApp";

  app = angular.module("" + app_name + ".TheTime", []);

  app.service('TheTime', function() {
    this.now = function() {
      return moment();
    };
    this.today = function() {
      return this.now().startOf('day');
    };
    this.month = this.today().month() + 1;
    this.monthName = this.today().format('MMMM');
    this.year = this.today().year();
    this.sayDay = function(day) {
      return day.format("dddd, MMMM Do YYYY, h:mm:ss a");
    };
    this.wasAgo = function(day) {
      return this.today().diff(day, 'days');
    };
    return this.isToday = function(day) {
      return day.isSame(this.today());
    };
  });

}).call(this);
