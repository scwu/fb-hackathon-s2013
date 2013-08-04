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

    $routeProvider.when "/contribute",
      templateUrl: "partials/contribute"
      controller: ContributeController

    $routeProvider.otherwise redirectTo: "/"
    $locationProvider.html5Mode true
]

@IndexController = ($scope, $http, $location) ->

  $scope.next = ->
    handleAuthClick ->
      $location.path '/info'

IndexController.$inject = ['$scope', '$http', '$location']

@InfoController = ($scope, $http, $location) ->

  $scope.mapConfig =
    zoom: 2
    center: new google.maps.LatLng 0, 0
    disableDefaultUI: true
    mapTypeId: google.maps.MapTypeId.ROADMAP
    panControl: true
    zoomControl: true
    mapTypeControl: false
    scaleControl: false
    streetViewControl: true
    overviewMapControl: false

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
  $scope.mode = null
  $scope.emails = []
  $scope.locations = []

  $scope.geocoder = new google.maps.Geocoder()

  $scope.map = new google.maps.Map(document.getElementById("mapHolder"), $scope.mapConfig)

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
    $scope.geocoder.geocode({
      address : location
    }, (results, status) ->
      if status == google.maps.GeocoderStatus.OK

        marker = new google.maps.Marker
          map: $scope.map
          position: results[0].geometry.location

        if not $scope.bounds?
          $scope.bounds = new google.maps.LatLngBounds results[0].geometry.location, results[0].geometry.location

        $scope.bounds.extend results[0].geometry.location

        $scope.map.fitBounds $scope.bounds
    );

  $scope.removeLocation = (location) ->
    $scope.locations = (e for e in $scope.locations when e isnt location)

InfoController.$inject = ['$scope', '$http', '$location']

@ContributeController = ($scope, $http, $location) ->

  $scope.mapConfig =
    zoom: 2
    center: new google.maps.LatLng 0, 0
    disableDefaultUI: true
    mapTypeId: google.maps.MapTypeId.ROADMAP
    panControl: true
    zoomControl: true
    mapTypeControl: false
    scaleControl: false
    streetViewControl: true
    overviewMapControl: false

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
  $scope.mode = null
  $scope.emails = []
  $scope.locations = []

  $scope.geocoder = new google.maps.Geocoder()

  $scope.map = new google.maps.Map(document.getElementById("mapHolder"), $scope.mapConfig)

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
    $scope.geocoder.geocode({
      address : location
    }, (results, status) ->
      if status == google.maps.GeocoderStatus.OK

        marker = new google.maps.Marker
          map: $scope.map
          position: results[0].geometry.location

        if not $scope.bounds?
          $scope.bounds = new google.maps.LatLngBounds results[0].geometry.location, results[0].geometry.location

        $scope.bounds.extend results[0].geometry.location

        $scope.map.fitBounds $scope.bounds
    );

  $scope.removeLocation = (location) ->
    $scope.locations = (e for e in $scope.locations when e isnt location)

ContributeController.$inject = ['$scope', '$http', '$location']
