#= require lib/angular-ui

autoresponseModule = angular.module("autoresponse", ['ui'])

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

  $scope.mode = "times"

InfoController.$inject = ['$scope', '$http', '$location']
