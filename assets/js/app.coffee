#= require bower_components/jquery/jquery.js
#= require bower_components/jquery-ui/ui/jquery-ui.js
#= require bower_components/angular/angular.js
#= require bower_components/angular-ui/build/angular-ui.js
#= require bower_components/fullcalendar/fullcalendar.js
#= require bower_components/fullcalendar/gcal.js
#= require bower_components/angular-ui-calendar/src/calendar.js

autoresponseModule = angular.module("autoresponse", ['ui', 'ui.calendar'])

autoresponseModule.config [
  "$routeProvider"
  "$locationProvider"
  ($routeProvider, $locationProvider) ->

    $routeProvider.when "/",
      templateUrl: "partials/index"
      controller: IndexController

    $routeProvider.when "/info",
      templateUrl: "partials/info"
      controller: InfoController

    $routeProvider.otherwise redirectTo: "/"
    $locationProvider.html5Mode true
]

@IndexController = ($scope, $http, $location) ->

  $scope.next = ->
    $scope.handleAuthClick;


IndexController.$inject = ['$scope', '$http', '$location']

@InfoController = ($scope, $http, $location) ->

  $scope.calendarConfig =
    calendar:
      height: 600
      defaultView: 'agendaWeek'
      editable: true
      selectable: true
      header:
        left: 'month agendaWeek'
        center: 'title'
        right: 'today prev,next'

  $scope.eventSources = [[{title: "NOW", start: new Date()}], [], []]
  $scope.mode = "times"
  $scope.emails = []
  $scope.locations = []

  $scope.addEmail = ->
    console.log $scope.eventSources
    email = $scope.emailIn
    $scope.emails.push email unless email in $scope.emails
    $scope.emailIn = ""

  $scope.removeEmail = (email) ->
    $scope.emails = (e for e in $scope.emails when e isnt email)

  $scope.addLocation = ->
    location = $scope.locationIn
    $scope.locations.push location unless location in $scope.locations
    $scope.locationIn = ""

  $scope.removeLocation = (location) ->
    $scope.locations = (e for e in $scope.locations when e isnt location)

InfoController.$inject = ['$scope', '$http', '$location']
