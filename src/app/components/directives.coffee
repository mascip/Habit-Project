'use strict'

### Directives ###

app_name = "myApp"
app = angular.module "#{app_name}.directives", []

app.directive 'appVersion', [
  'version', (version) ->
    (scope, element, attrs) ->
      element.text version
]

# app.directive 'habit', () ->
#     restrict: 'E'
#     template: '<div>Hi there</div>'
#     # replace: true
#     # compile: -> alert('COMPILED!')
#     # link: (scope, element, attrs) -> alert('LINKED!')
# #
# # From https://gist.github.com/geelen/2873603
# window.stoppingPropagation = (callback) -> (event) ->
#   event.stopPropagation()
#   callback(event)

app.directive 'ngTap', ->
  (scope, element, attrs) ->
    tapping = false
    element.bind 'touchstart', stoppingPropagation (event) -> tapping = true
    element.bind 'touchmove' , stoppingPropagation (event) -> tapping = false
    element.bind 'touchend'  , stoppingPropagation (event) -> scope.$apply(attrs['ngTap']) if tapping
