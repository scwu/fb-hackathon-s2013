var map;
var geocoder;
var bounds;

function initialize() {
	// generates map
	geocoder = new google.maps.Geocoder();

	var myOptions = {
		zoom : 2,
		center : new google.maps.LatLng(0, 0),
		disableDefaultUI : true,
		mapTypeId : google.maps.MapTypeId.ROADMAP,
		panControl : true,
		zoomControl : true,
		mapTypeControl : false,
		scaleControl : false,
		streetViewControl : true,
		overviewMapControl : false,
	};

	map = new google.maps.Map(document.getElementById("map"),
			myOptions);

	bounds = new google.maps.LatLngBounds();
}

function addAddress(address) {
	geocoder.geocode({
		'address' : address
	}, function(results, status) {
		if (status == google.maps.GeocoderStatus.OK) {

			var marker = new google.maps.Marker({
				map : map,
				position : results[0].geometry.location
			});

			bounds.extend(results[0].geometry.location);

			map.fitBounds(bounds);
		}
	});
}

google.maps.event.addDomListener(window, 'load', initialize);