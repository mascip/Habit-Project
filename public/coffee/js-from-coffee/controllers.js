// Generated by CoffeeScript 1.6.3
(function() {
  'use strict';
  /* Controllers*/

  var app, app_name;

  app_name = "myApp";

  app = angular.module("" + app_name + ".controllers", []);

  app.controller('myCtrl1', [
    '$scope', function($scope) {
      $scope.name = "view 1";
      $scope.say = function() {
        return window.alert.apply(window, arguments);
      };
      return $scope.test = 4;
    }
  ]);

  app.controller('myCtrl2', [
    '$scope', function($scope) {
      return $scope.test = 2;
    }
  ]);

  app.controller('myCtrl3', [
    '$scope', function($scope) {
      $scope.name = "view 3";
      $scope.say = function() {
        return window.alert.apply(window, arguments);
      };
      return $scope.test = 4;
    }
  ]);

}).call(this);
