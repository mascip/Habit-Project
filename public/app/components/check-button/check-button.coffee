'use strict'
app_name = "myApp"
app = angular.module "#{app_name}.CheckButton", []

app.directive 'checkButton', () ->
    restrict: 'E'
    templateUrl: 'app/components/check-button/checkButton.html'
    replace: true
    scope:
        ticked: '='
        actionWhenClicked: '&'
    link: (scope, elem, attrs) ->

        # TODO: I want to do this here, not in habit.clickTick. However, modifying "ticked" here modifies it later in the habit...
        modifyTick = ->
            scope.ticked = switch
                when scope.ticked == 'unknown' then 'done'
                when scope.ticked == 'done'    then 'failed'
                when scope.ticked == 'failed'  then 'done'
                else 'failed'

        scope.clickedTheTick = -> 
            # modifyTick()
            scope.actionWhenClicked()
