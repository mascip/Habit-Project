'use strict'
app_name = "myApp"
app = angular.module "#{app_name}.ctrl-tabs", ['ui.bootstrap']

app.controller 'CtrlTabs',
class CtrlTabs
    contructor: ($location) ->
        $scope.isActive = (viewLocation) ->
                alert($location.path() + '---' + viewLocation == $location.path())
                return viewLocation == $location.path()
