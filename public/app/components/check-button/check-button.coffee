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
        disabl: '='
    link: (scope, elem, attrs) ->

        # CSS 'disabled' property, or no class (empty string)
        scope.disab = -> if scope.disabl then 'disabled' else ''
            # I used this instead of ng-disabled, because ng-disabled does not add the class
            # "disabled" to the button. And I need that class to re-style the button.

        modifyTick = ->
            # TODO: I want to do this here, not in habit.clickTick. However, modifying "ticked" here modifies it later in the habit...
            scope.ticked = switch
                when scope.ticked == 'unknown' then 'done'
                when scope.ticked == 'done'    then 'failed'
                when scope.ticked == 'failed'  then 'done'
                else 'failed'

        scope.clickedTheTick = -> 
            # modifyTick()
            scope.actionWhenClicked()
