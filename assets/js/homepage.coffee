#= require lib/angular-ui

homepageModule = angular.module("autoresponse", ['ui'])

homepageModule.config [
  "$routeProvider"
  "$locationProvider"
  ($routeProvider, $locationProvider) ->

    $routeProvider.when "/",
      templateUrl: "partials/homePage"
      controller: IndexController

    $routeProvider.otherwise redirectTo: "/"
    $locationProvider.html5Mode true
]

@IndexController = ($scope, $http, $location) ->

  $scope.start = () ->
    window.location = '/auth'


IndexController.$inject = ['$scope', '$http', '$location']
