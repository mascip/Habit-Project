// Generated by CoffeeScript 1.6.3
(function() {
  'use strict';
  var CtrlTabs, app, app_name;

  app_name = "myApp";

  app = angular.module("" + app_name + ".ctrl-tabs", ['ui.bootstrap']);

  app.controller('CtrlTabs', CtrlTabs = (function() {
    function CtrlTabs() {}

    CtrlTabs.prototype.contructor = function($location) {
      return $scope.isActive = function(viewLocation) {
        alert($location.path() + '---' + viewLocation === $location.path());
        return viewLocation === $location.path();
      };
    };

    return CtrlTabs;

  })());

}).call(this);