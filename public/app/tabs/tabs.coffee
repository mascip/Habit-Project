'use strict'
app_name = "myApp"
app = angular.module "#{app_name}.ctrl-tabs", ['ui.bootstrap']

app.controller 'CtrlTabs',
class CtrlTabs
    constructor: ($scope, $location, $state) ->
        $scope.isActive = (viewLocation) ->
            $state.includes(viewLocation)
            # TODO: it is called to very frequently (too often?). I could keep a list of tabs here, 
            # and create an object that lists whether they are active or not.
            # It would be updated only when there is a stateChangeSuccess
