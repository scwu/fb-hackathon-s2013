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

    $routeProvider.when "/:id",
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
    zoom: 12
    center: new google.maps.LatLng 40.7142, 74.0064
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
  $scope.markers = []

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

        marker.loc = location

        if not $scope.bounds?
          $scope.bounds = new google.maps.LatLngBounds results[0].geometry.location, results[0].geometry.location

        $scope.bounds.extend results[0].geometry.location

        $scope.map.fitBounds $scope.bounds
        google.maps.event.trigger($scope.map, 'resize')
        $scope.markers.push marker unless marker in $scope.markers
    );

  $scope.removeLocation = (location) ->
    $scope.locations = (e for e in $scope.locations when e isnt location)
    removed = (e for e in $scope.markers when e.loc is location)
    for e in removed
      e.setMap null
    $scope.markers = (e for e in $scope.markers when e.loc isnt location)

InfoController.$inject = ['$scope', '$http', '$location']

@ContributeController = ($scope, $http, $location, $routeParams) ->

  $scope.eventSources = [[{title: "NOW", start: new Date()}], [], []]
  $scope.timeIncrements = [0..47].map (offset) ->
    a = new Date
    a.setSeconds 0
    a.setHours(30*offset / 60)
    a.setMinutes(30*offset % 60)
    a.toLocaleTimeString()
  $scope.dates = [0..6].map (day) ->
    a = new Date
    a.setDate(a.getDate() - a.getDay() + day)
    a.toLocaleDateString()
  $scope.mode = null
  $scope.days = [0..6]

  $http.get("/api/events/#{$routeParams.id}").success (data, code) ->
    console.log data
    $scope.emails = (p.lastName for p in data.invited)
    $scope.locations = data.locations
    $scope.responses = data.responses
    $scope.resMap = {}
    for res in data.responses
      for rawDate in res.dates
        date = new Date(rawDate)
        time = date.toLocaleTimeString()
        $scope.resMap[time] ||= []
        $scope.resMap[time][date.getDay()] = true
      console.log $scope.resMap

  $scope.moveEmailUp = (email) ->
    index = $scope.emails.indexOf email

    unless index is 0
      [$scope.emails[index - 1], $scope.emails[index]] = [email, $scope.emails[index - 1]]

  $scope.descriptionIn = (title, description) ->
    description = $scope.directionIn
    title = $scope.titleIn
    $scope.directionIn = ""

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

  $scope.moveEmailDown = (email) ->
    index = $scope.emails.indexOf email

    unless index is ($scope.emails.length - 1)
      [$scope.emails[index + 1], $scope.emails[index]] = [email, $scope.emails[index + 1]]

  $scope.moveLocationUp = (location) ->
    index = $scope.locations.indexOf location

    unless index is 0
      [$scope.locations[index - 1], $scope.locations[index]] = [location, $scope.locations[index - 1]]

  $scope.moveLocationDown = (location) ->
    index = $scope.locations.indexOf location

    unless index is ($scope.locations.length - 1)
      [$scope.locations[index + 1], $scope.locations[index]] = [location, $scope.locations[index + 1]]

ContributeController.$inject = ['$scope', '$http', '$location', '$routeParams']
