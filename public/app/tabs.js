// Generated by CoffeeScript 1.6.3
(function() {
  'use strict';
  var CtrlTabs, app, app_name;

  app_name = "myApp";

  app = angular.module("" + app_name + ".ctrl-tabs", ['ui.bootstrap']);

  app.controller('CtrlTabs', CtrlTabs = (function() {
    function CtrlTabs($scope, $location, $state) {
      $scope.isActive = function(viewLocation) {
        var res;
        res = $state.includes(viewLocation);
        return res;
      };
    }

    return CtrlTabs;

  })());

}).call(this);
